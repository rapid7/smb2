require 'zlib'
require 'ruby_smb/server/share/provider/processor'

module RubySMB
  class Server
    module Share
      module Provider
        class Disk < Base
          TYPE = TYPE_DISK
          class Processor < Processor::Base
            Handle = Struct.new(:remote_path, :local_path, :durable?)
            def initialize(provider, server_client)
              super
              @handles = {}
              @query_directory_context = {}
            end

            def maximal_access(path=nil)
              RubySMB::SMB2::BitField::FileAccessMask.new(
                read_attr: 1,
                read_data: 1
              )
            end

            def do_close_smb2(request)
              local_path = get_local_path(request.file_id)
              @handles.delete(request.file_id.to_binary_s)
              response = RubySMB::SMB2::Packet::CloseResponse.new
              set_common_info(response, local_path)
              response.flags = 1
              response.structure_size = 0x3c
              response
            end

            def do_create_smb2(request)
              unless request.create_disposition == 1
                logger.warn("Can not handle CREATE request for disposition: #{request.create_disposition}")
                raise NotImplementedError
              end

              path = request.name.snapshot.dup
              path = path.encode.gsub('\\', File::SEPARATOR)
              local_path = get_local_path(path)
              unless local_path.file? || local_path.directory?
                logger.warn("Requested path does not exist: #{local_path}")
                response = RubySMB::SMB2::Packet::ErrorPacket.new
                response.smb2_header.nt_status = WindowsError::NTStatus::STATUS_OBJECT_NAME_NOT_FOUND
                return response
              end

              durable = false
              response = RubySMB::SMB2::Packet::CreateResponse.new
              response.create_action = 1
              set_common_info(response, local_path)
              response.file_id.persistent = Zlib::crc32(path)
              response.file_id.volatile = rand(0xffffffff)

              request.contexts.each do |req_ctx|
                case req_ctx.name
                when SMB2::CreateContext::CREATE_DURABLE_HANDLE
                  # see: https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-smb2/9adbc354-5fad-40e7-9a62-4a4b6c1ff8a0
                  next if request.contexts.any? { |ctx| ctx.name == SMB2::CreateContext::CREATE_DURABLE_HANDLE_RECONNECT }

                  if request.contexts.any? { |ctx| [ SMB2::CreateContext::CREATE_DURABLE_HANDLE_V2, SMB2::CreateContext::CREATE_DURABLE_HANDLE_RECONNECT_v2 ].include?(ctx.name) }
                    response = RubySMB::SMB2::Packet::ErrorPacket.new
                    response.smb2_header.nt_status = WindowsError::NTStatus::STATUS_INVALID_PARAMETER
                    return response
                  end

                  durable = true
                  res_ctx = SMB2::CreateContext::CreateDurableHandleResponse.new
                when SMB2::CreateContext::CREATE_DURABLE_HANDLE_V2
                  # see: https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-smb2/33e6800a-adf5-4221-af27-7e089b9e81d1
                  if request.contexts.any? { |ctx| [ SMB2::CreateContext::CREATE_DURABLE_HANDLE, SMB2::CreateContext::CREATE_DURABLE_HANDLE_RECONNECT, SMB2::CreateContext::CREATE_DURABLE_HANDLE_RECONNECT_v2 ].include?(ctx.name) }
                    response = RubySMB::SMB2::Packet::ErrorPacket.new
                    response.smb2_header.nt_status = WindowsError::NTStatus::STATUS_INVALID_PARAMETER
                    return response
                  end

                  durable = true
                  res_ctx = SMB2::CreateContext::CreateDurableHandleV2Response.new(
                    timeout: 1000,
                    flags: req_ctx.data.flags
                  )
                when SMB2::CreateContext::CREATE_QUERY_MAXIMAL_ACCESS
                  res_ctx = SMB2::CreateContext::CreateQueryMaximalAccessResponse.new(
                    maximal_access: maximal_access(path)
                  )
                when SMB2::CreateContext::CREATE_QUERY_ON_DISK_ID
                  res_ctx = SMB2::CreateContext::CreateQueryOnDiskIdResponse.new(
                    disk_file_id: local_path.stat.ino,
                    volume_id: local_path.stat.dev
                  )
                else
                  logger.warn("Can not handle CREATE context: #{req_ctx.name}")
                  next
                end

                response.contexts << SMB2::CreateContext::CreateContextResponse.new(name: res_ctx.class::NAME, data: res_ctx)
              end

              if response.contexts.length > 0
                # fixup the offsets
                response.contexts[0...-1].each do |ctx|
                  ctx.next_offset = ctx.num_bytes
                end
                response.contexts[-1].next_offset = 0
                response.contexts_offset = response.buffer.abs_offset
                response.contexts_length = response.buffer.num_bytes
              else
                response.contexts_offset = 0
                response.contexts_length = 0
              end

              @handles[response.file_id.to_binary_s] = Handle.new(path, local_path, durable)
              response
            end

            def do_query_directory_smb2(request)
              # see: https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-smb2/29dfcc9b-3aec-406b-abb5-0b4fe96712e2
              info_class = request.file_information_class.snapshot
              begin
                # probe #build_info to see if it supports the requested info class
                build_info(Pathname.new(__FILE__), info_class)
              rescue NotImplementedError
                logger.warn("Can not handle QUERY_DIRECTORY request for class: #{info_class}")
                raise
              end

              local_path = get_local_path(request.file_id)
              unless local_path.directory?
                response = SMB2::Packet::ErrorPacket.new
                response.smb2_header.nt_status = WindowsError::NTStatus::STATUS_INVALID_PARAMETER
                return response
              end

              search_pattern = request.name.snapshot.dup.encode
              begin
                search_regex = wildcard_to_regex(search_pattern)
              rescue NotImplementedError
                logger.warn("Can not handle QUERY_DIRECTORY wildcard pattern: #{search_pattern}")
                raise
              end

              return_single = request.flags.return_single == 1

              infos = []
              total_size = 0

              if @query_directory_context[request.file_id.to_binary_s].nil? || request.flags.reopen == 1 || request.flags.restart_scans == 1
                dirents = local_path.children.sort.to_a
                dirents.unshift(local_path.parent) unless local_path.parent == local_path
                dirents.unshift(local_path)
                @query_directory_context[request.file_id.to_binary_s] = dirents
              else
                dirents = @query_directory_context[request.file_id.to_binary_s]
              end

              while dirents.length > 0
                dirent = dirents.shift
                next unless dirent.file? || dirent.directory? # filter out everything but files and directories

                case dirent
                when local_path
                  dirent_name = '.'
                when local_path.parent
                  dirent_name = '..'
                else
                  dirent_name = dirent.basename.to_s
                end
                next unless search_regex.match?(dirent_name)

                info = build_info(dirent, info_class, rename: dirent_name)
                info_size = info.num_bytes + (7 - (info.num_bytes + 7) % 8)
                if total_size + info_size > request.output_length
                  dirents.unshift(dirent) # no space left for this one so put it back
                  break
                end

                infos << info
                total_size += info_size
                break if return_single
              end

              if infos.length == 0
                response = SMB2::Packet::QueryDirectoryResponse.new
                response.smb2_header.nt_status = WindowsError::NTStatus::STATUS_NO_MORE_FILES
                return response
              end

              response = SMB2::Packet::QueryDirectoryResponse.new
              infos.last.next_offset = 0 if infos.last
              buffer = ""
              infos.each do |info|
                info = info.to_binary_s
                buffer << info + ("\x00".b * (7 - (info.length + 7) % 8))
              end
              response.buffer = buffer
              response
            end

            def do_query_info_smb2(request)
              unless request.info_type == 1
                logger.warn("Can not handle QUERY_INFO request for type: #{request.info_type}, class: #{request.file_information_class}")
                raise NotImplementedError
              end

              local_path = get_local_path(request.file_id)
              case request.file_information_class
              when Fscc::FileInformation::FILE_EA_INFORMATION
                info = Fscc::FileInformation::FileEaInformation.new
              when Fscc::FileInformation::FILE_NETWORK_OPEN_INFORMATION
                info = Fscc::FileInformation::FileNetworkOpenInformation.new
                set_common_info(info, local_path)
              when Fscc::FileInformation::FILE_NORMALIZED_NAME_INFORMATION
                info = Fscc::FileInformation::FileNameInformation.new(file_name: @handles[request.file_id.to_binary_s].remote_path)
              else
                logger.warn("Can not handle QUERY_INFO request for type: #{request.info_type}, class: #{request.file_information_class}")
                raise NotImplementedError
              end
              response = SMB2::Packet::QueryInfoResponse.new
              response.buffer = info.to_binary_s
              response
            end

            def do_read_smb2(request)
              raise NotImplementedError unless request.channel == SMB2::SMB2_CHANNEL_NONE

              local_path = get_local_path(request.file_id)
              buffer = nil
              local_path.open do |file|
                file.seek(request.offset.snapshot)
                buffer = file.read(request.read_length)
              end

              # see: https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-smb2/21e8b343-34e9-4fca-8d93-03dd2d3e961e
              if buffer.nil? || buffer.length == 0 || buffer.length < request.min_bytes
                response = SMB2::Packet::ErrorPacket.new
                response.smb2_header.nt_status = WindowsError::NTStatus::STATUS_END_OF_FILE
                return response
              end

              response = SMB2::Packet::ReadResponse.new
              response.data_length = buffer.length
              response.buffer = buffer
              response
            end

            private

            def build_file_attributes(path)
              file_attributes = Fscc::FileAttributes.new
              if path.file?
                file_attributes.normal = 1
              elsif path.directory?
                file_attributes.directory = 1
              end
              file_attributes
            end

            def build_info(path, info_class, rename: nil)
              case info_class
              when Fscc::FileInformation::FILE_ID_BOTH_DIRECTORY_INFORMATION
                info = Fscc::FileInformation::FileIdBothDirectoryInformation.new
                set_common_info(info, path)
                info.file_name = rename || path.basename.to_s
              when Fscc::FileInformation::FILE_FULL_DIRECTORY_INFORMATION
                info = Fscc::FileInformation::FileFullDirectoryInformation.new
                set_common_info(info, path)
                info.file_name = rename || path.basename.to_s
              else
                raise NotImplementedError, "unsupported info class: #{info_class}"
              end

              info.next_offset = (info.num_bytes + (7 - (info.num_bytes + 7) % 8))
              info
            end

            def get_local_path(path)
              case path
              when Field::Smb2Fileid
                local_path = @handles[path.to_binary_s]&.local_path
              when ::String
                local_path = Pathname.new(provider.path + '/' + path.encode).cleanpath
                # TODO: report / handle directory traversal issues more robustly
                raise RuntimeError unless local_path.to_s == provider.path || local_path.to_s.start_with?(provider.path + '/')
              else
                raise NotImplementedError, "Can not get the local path for: #{path.inspect}"
              end

              local_path
            end

            # A bunch of structures have these common fields with the same meaning, so set them all here
            def set_common_info(info, path)
              begin
                info.create_time = path.birthtime
              rescue NotImplementedError
                logger.warn("The file system does not support #birthtime for #{path}")
              end

              info.last_access = path.atime
              info.last_write = path.mtime
              info.last_change = path.ctime
              if path.file?
                info.end_of_file = path.size
                info.allocation_size = (path.size + (4095 - (path.size + 4095) % 4096))
              end
              info.file_attributes = build_file_attributes(path)
            end

            def wildcard_to_regex(wildcard)
              return Regexp.new('.*') if ['*.*', ''].include?(wildcard)

              if wildcard.each_char.any? { |c| c == '<' || c == '>' }
                # the < > wildcard operators are not supported
                raise NotImplementedError
              end

              wildcard = Regexp.escape(wildcard)
              wildcard = wildcard.gsub(/(\\\?)+$/) { |match| ".{0,#{match.length / 2}}"}
              wildcard = wildcard.gsub('\?', '.')
              wildcard = wildcard.gsub('\*', '.*')
              wildcard = wildcard.gsub('"', '\.')
              Regexp.new('^' + wildcard + '$')
            end
          end

          def initialize(name, path)
            @path = File.expand_path(path)
            super(name)
          end

          attr_accessor :path
        end
      end
    end
  end
end
