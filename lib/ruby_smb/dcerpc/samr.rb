module RubySMB
  module Dcerpc
    module Samr

      UUID = '12345778-1234-abcd-ef00-0123456789ac'
      VER_MAJOR = 1
      VER_MINOR = 0

      #################################
      #           Constants           #
      #################################

      # Operation numbers
      SAMR_CONNECT                         = 0x0000
      SAMR_CLOSE_HANDLE                    = 0x0001
      SAMR_LOOKUP_DOMAIN_IN_SAM_SERVER     = 0x0005
      SAMR_ENUMERATE_DOMAINS_IN_SAM_SERVER = 0x0006
      SAMR_OPEN_DOMAIN                     = 0x0007
      SAMR_QUERY_INFORMATION_DOMAIN        = 0x0008
      SAMR_ENUMERATE_USERS_IN_DOMAIN       = 0x000D
      SAMR_GET_ALIAS_MEMBERSHIP            = 0x0010
      SAMR_LOOKUP_NAMES_IN_DOMAIN          = 0x0011
      SAMR_OPEN_GROUP                      = 0x0013
      SAMR_GET_MEMBERS_IN_GROUP            = 0x0019
      SAMR_OPEN_USER                       = 0x0022
      SAMR_DELETE_USER                     = 0x0023
      SAMR_CHANGE_PASSWORD_USER            = 0x0026
      SAMR_GET_GROUPS_FOR_USER             = 0x0027
      SAMR_CREATE_USER2_IN_DOMAIN          = 0x0032
      SAMR_UNICODE_CHANGE_PASSWORD_USER2   = 0x0037
      SAMR_SET_INFORMATION_USER2           = 0x003a
      SAMR_CONNECT5                        = 0x0040
      SAMR_RID_TO_SID                      = 0x0041

      ################
      # ACCESS_MASK Values

      # [2.2.1.1 Common ACCESS_MASK Values](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/15b9ebf7-161d-4c83-a672-dceb2ac8c448)
      DELETE                 = 0x00010000
      READ_CONTROL           = 0x00020000
      WRITE_DAC              = 0x00040000
      WRITE_OWNER            = 0x00080000
      ACCESS_SYSTEM_SECURITY = 0x01000000
      MAXIMUM_ALLOWED        = 0x02000000


      # [2.2.1.3 Server ACCESS_MASK Values](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/e8afb15e-c053-4984-b84b-66877236e141)
      SAM_SERVER_CONNECT           = 0x00000001
      SAM_SERVER_SHUTDOWN          = 0x00000002
      SAM_SERVER_INITIALIZE        = 0x00000004
      SAM_SERVER_CREATE_DOMAIN     = 0x00000008
      SAM_SERVER_ENUMERATE_DOMAINS = 0x00000010
      SAM_SERVER_LOOKUP_DOMAIN     = 0x00000020
      SAM_SERVER_ALL_ACCESS        = 0x000F003F
      SAM_SERVER_READ              = 0x00020010
      SAM_SERVER_WRITE             = 0x0002000E
      SAM_SERVER_EXECUTE           = 0x00020021

      # [2.2.1.4 Domain ACCESS_MASK Values](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/aef23495-f6aa-48e9-aebc-22e022a2b4eb)
      DOMAIN_READ_PASSWORD_PARAMETERS = 0x00000001
      DOMAIN_WRITE_PASSWORD_PARAMS    = 0x00000002
      DOMAIN_READ_OTHER_PARAMETERS    = 0x00000004
      DOMAIN_WRITE_OTHER_PARAMETERS   = 0x00000008
      DOMAIN_CREATE_USER              = 0x00000010
      DOMAIN_CREATE_GROUP             = 0x00000020
      DOMAIN_CREATE_ALIAS             = 0x00000040
      DOMAIN_GET_ALIAS_MEMBERSHIP     = 0x00000080
      DOMAIN_LIST_ACCOUNTS            = 0x00000100
      DOMAIN_LOOKUP                   = 0x00000200
      DOMAIN_ADMINISTER_SERVER        = 0x00000400
      DOMAIN_ALL_ACCESS               = 0x000F07FF
      DOMAIN_READ                     = 0x00020084
      DOMAIN_WRITE                    = 0x0002047A
      DOMAIN_EXECUTE                  = 0x00020301

      # [2.2.1.5 Group ACCESS_MASK Values](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/f24f9fa8-798d-4e7d-a110-a5eda6900f41)
      GROUP_READ_INFORMATION  = 0x00000001
      GROUP_WRITE_ACCOUNT     = 0x00000002
      GROUP_ADD_MEMBER        = 0x00000004
      GROUP_REMOVE_MEMBER     = 0x00000008
      GROUP_LIST_MEMBERS      = 0x00000010
      GROUP_ALL_ACCESS        = 0x000F001F
      GROUP_READ              = 0x00020010
      GROUP_WRITE             = 0x0002000E
      GROUP_EXECUTE           = 0x00020001

      # [2.2.1.6 Alias ACCESS_MASK Values](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/2da21c6c-5b15-46c8-bd4e-6a8443216e1a)
      ALIAS_ADD_MEMBER        = 0x00000001
      ALIAS_REMOVE_MEMBER     = 0x00000002
      ALIAS_LIST_MEMBERS      = 0x00000004
      ALIAS_READ_INFORMATION  = 0x00000008
      ALIAS_WRITE_ACCOUNT     = 0x00000010
      ALIAS_ALL_ACCESS        = 0x000F001F
      ALIAS_READ              = 0x00020004
      ALIAS_WRITE             = 0x00020013
      ALIAS_EXECUTE           = 0x00020008

      # [2.2.1.7 User ACCESS_MASK Values](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/c0be3f43-bcf9-43ee-b027-3d02ab372c53)
      USER_READ_GENERAL            = 0x00000001
      USER_READ_PREFERENCES        = 0x00000002
      USER_WRITE_PREFERENCES       = 0x00000004
      USER_READ_LOGON              = 0x00000008
      USER_READ_ACCOUNT            = 0x00000010
      USER_WRITE_ACCOUNT           = 0x00000020
      USER_CHANGE_PASSWORD         = 0x00000040
      USER_FORCE_PASSWORD_CHANGE   = 0x00000080
      USER_LIST_GROUPS             = 0x00000100
      USER_READ_GROUP_INFORMATION  = 0x00000200
      USER_WRITE_GROUP_INFORMATION = 0x00000400
      USER_ALL_ACCESS              = 0x000F07FF
      USER_READ                    = 0x0002031A
      USER_WRITE                   = 0x00020044
      USER_EXECUTE                 = 0x00020041

      # [2.2.1.8 USER_ALL Values](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/2675c176-72e0-4ac9-ae6d-cdd87b8ba520)
      USER_ALL_USERNAME            = 0x00000001
      USER_ALL_FULLNAME            = 0x00000002
      USER_ALL_USERID              = 0x00000004
      USER_ALL_PRIMARYGROUPID      = 0x00000008
      USER_ALL_ADMINCOMMENT        = 0x00000010
      USER_ALL_USERCOMMENT         = 0x00000020
      USER_ALL_HOMEDIRECTORY       = 0x00000040
      USER_ALL_HOMEDIRECTORYDRIVE  = 0x00000080
      USER_ALL_SCRIPTPATH          = 0x00000100
      USER_ALL_PROFILEPATH         = 0x00000200
      USER_ALL_WORKSTATIONS        = 0x00000400
      USER_ALL_LASTLOGON           = 0x00000800
      USER_ALL_LASTLOGOFF          = 0x00001000
      USER_ALL_LOGONHOURS          = 0x00002000
      USER_ALL_BADPASSWORDCOUNT    = 0x00004000
      USER_ALL_LOGONCOUNT          = 0x00008000
      USER_ALL_PASSWORDCANCHANGE   = 0x00010000
      USER_ALL_PASSWORDMUSTCHANGE  = 0x00020000
      USER_ALL_PASSWORDLASTSET     = 0x00040000
      USER_ALL_ACCOUNTEXPIRES      = 0x00080000
      USER_ALL_USERACCOUNTCONTROL  = 0x00100000
      USER_ALL_PARAMETERS          = 0x00200000
      USER_ALL_COUNTRYCODE         = 0x00400000
      USER_ALL_CODEPAGE            = 0x00800000
      USER_ALL_NTPASSWORDPRESENT   = 0x01000000
      USER_ALL_LMPASSWORDPRESENT   = 0x02000000
      USER_ALL_PRIVATEDATA         = 0x04000000
      USER_ALL_PASSWORDEXPIRED     = 0x08000000
      USER_ALL_SECURITYDESCRIPTOR  = 0x10000000
      USER_ALL_UNDEFINED_MASK      = 0xC0000000

      # [2.2.3.16 DOMAIN_INFORMATION_CLASS Values](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/6b0dff90-5ac0-429a-93aa-150334adabf6)
      DOMAIN_PASSWORD_INFORMATION    = 1
      DOMAIN_GENERAL_INFORMATION     = 2
      DOMAIN_LOGOFF_INFORMATION      = 3
      DOMAIN_OEM_INFORMATION         = 4
      DOMAIN_NAME_INFORMATION        = 5
      DOMAIN_REPLICATION_INFORMATION = 6
      DOMAIN_SERVER_ROLE_INFORMATION = 7
      DOMAIN_MODIFIED_INFORMATION    = 8
      DOMAIN_STATE_INFORMATION       = 9
      DOMAIN_GENERAL_INFORMATION2    = 11
      DOMAIN_LOCKOUT_INFORMATION     = 12
      DOMAIN_MODIFIED_INFORMATION2   = 13

      # [2.2.6.28 USER_INFORMATION_CLASS Values](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/6b0dff90-5ac0-429a-93aa-150334adabf6)
      USER_GENERAL_INFORMATION       = 1
      USER_PREFERENCES_INFORMATION   = 2
      USER_LOGON_INFORMATION         = 3
      USER_LOGON_HOURS_INFORMATION   = 4
      USER_ACCOUNT_INFORMATION       = 5
      USER_NAME_INFORMATION          = 6
      USER_ACCOUNT_NAME_INFORMATION  = 7
      USER_FULL_NAME_INFORMATION     = 8
      USER_PRIMARY_GROUP_INFORMATION = 9
      USER_HOME_INFORMATION          = 10
      USER_SCRIPT_INFORMATION        = 11
      USER_PROFILE_INFORMATION       = 12
      USER_ADMIN_COMMENT_INFORMATION = 13
      USER_WORK_STATIONS_INFORMATION = 14
      USER_CONTROL_INFORMATION       = 16
      USER_EXPIRES_INFORMATION       = 17
      USER_INTERNAL1_INFORMATION     = 18
      USER_PARAMETERS_INFORMATION    = 20
      USER_ALL_INFORMATION           = 21
      USER_INTERNAL4_INFORMATION     = 23
      USER_INTERNAL5_INFORMATION     = 24
      USER_INTERNAL4_INFORMATION_NEW = 25
      USER_INTERNAL5_INFORMATION_NEW = 26
      USER_INTERNAL7_INFORMATION     = 31
      USER_INTERNAL8_INFORMATION     = 32

      # [2.2.1.9 ACCOUNT_TYPE Values](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/e742be45-665d-4576-b872-0bc99d1e1fbe)
      SAM_DOMAIN_OBJECT             = 0x00000000
      SAM_GROUP_OBJECT              = 0x10000000
      SAM_NON_SECURITY_GROUP_OBJECT = 0x10000001
      SAM_ALIAS_OBJECT              = 0x20000000
      SAM_NON_SECURITY_ALIAS_OBJECT = 0x20000001
      SAM_USER_OBJECT               = 0x30000000
      SAM_MACHINE_ACCOUNT           = 0x30000001
      SAM_TRUST_ACCOUNT             = 0x30000002
      SAM_APP_BASIC_GROUP           = 0x40000000
      SAM_APP_QUERY_GROUP           = 0x40000001

      # [2.2.1.10 SE_GROUP Attributes](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/9e093bd2-e451-4dd5-9700-97b977d7ebb2)
      SE_GROUP_MANDATORY            = 0x00000001
      SE_GROUP_ENABLED_BY_DEFAULT   = 0x00000002
      SE_GROUP_ENABLED              = 0x00000004

      # [2.2.1.11 GROUP_TYPE Codes](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/1f8d7ea1-fcc1-4833-839a-f94d67c08fcd)
      GROUP_TYPE_ACCOUNT_GROUP      = 0x00000002
      GROUP_TYPE_RESOURCE_GROUP     = 0x00000004
      GROUP_TYPE_UNIVERSAL_GROUP    = 0x00000008
      GROUP_TYPE_SECURITY_ENABLED   = 0x80000000
      GROUP_TYPE_SECURITY_ACCOUNT   = 0x80000002
      GROUP_TYPE_SECURITY_RESOURCE  = 0x80000004
      GROUP_TYPE_SECURITY_UNIVERSAL = 0x80000008

      # [2.2.1.12 USER_ACCOUNT Codes](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/b10cfda1-f24f-441b-8f43-80cb93e786ec)
      USER_ACCOUNT_DISABLED                       = 0x00000001
      USER_HOME_DIRECTORY_REQUIRED                = 0x00000002
      USER_PASSWORD_NOT_REQUIRED                  = 0x00000004
      USER_TEMP_DUPLICATE_ACCOUNT                 = 0x00000008
      USER_NORMAL_ACCOUNT                         = 0x00000010
      USER_MNS_LOGON_ACCOUNT                      = 0x00000020
      USER_INTERDOMAIN_TRUST_ACCOUNT              = 0x00000040
      USER_WORKSTATION_TRUST_ACCOUNT              = 0x00000080
      USER_SERVER_TRUST_ACCOUNT                   = 0x00000100
      USER_DONT_EXPIRE_PASSWORD                   = 0x00000200
      USER_ACCOUNT_AUTO_LOCKED                    = 0x00000400
      USER_ENCRYPTED_TEXT_PASSWORD_ALLOWED        = 0x00000800
      USER_SMARTCARD_REQUIRED                     = 0x00001000
      USER_TRUSTED_FOR_DELEGATION                 = 0x00002000
      USER_NOT_DELEGATED                          = 0x00004000
      USER_USE_DES_KEY_ONLY                       = 0x00008000
      USER_DONT_REQUIRE_PREAUTH                   = 0x00010000
      USER_PASSWORD_EXPIRED                       = 0x00020000
      USER_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION = 0x00040000
      USER_NO_AUTH_DATA_REQUIRED                  = 0x00080000
      USER_PARTIAL_SECRETS_ACCOUNT                = 0x00100000
      USER_USE_AES_KEYS                           = 0x00200000

      # [2.2.1.13 UF_FLAG Codes](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/10bf6c8e-34af-4cf9-8dff-6b6330922863)
      UF_SCRIPT                                 = 0x00000001
      UF_ACCOUNTDISABLE                         = 0x00000002
      UF_HOMEDIR_REQUIRED                       = 0x00000008
      UF_LOCKOUT                                = 0x00000010
      UF_PASSWD_NOTREQD                         = 0x00000020
      UF_PASSWD_CANT_CHANGE                     = 0x00000040
      UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED        = 0x00000080
      UF_TEMP_DUPLICATE_ACCOUNT                 = 0x00000100
      UF_NORMAL_ACCOUNT                         = 0x00000200
      UF_INTERDOMAIN_TRUST_ACCOUNT              = 0x00000800
      UF_WORKSTATION_TRUST_ACCOUNT              = 0x00001000
      UF_SERVER_TRUST_ACCOUNT                   = 0x00002000
      UF_DONT_EXPIRE_PASSWD                     = 0x00010000
      UF_MNS_LOGON_ACCOUNT                      = 0x00020000
      UF_SMARTCARD_REQUIRED                     = 0x00040000
      UF_TRUSTED_FOR_DELEGATION                 = 0x00080000
      UF_NOT_DELEGATED                          = 0x00100000
      UF_USE_DES_KEY_ONLY                       = 0x00200000
      UF_DONT_REQUIRE_PREAUTH                   = 0x00400000
      UF_PASSWORD_EXPIRED                       = 0x00800000
      UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION = 0x01000000
      UF_NO_AUTH_DATA_REQUIRED                  = 0x02000000
      UF_PARTIAL_SECRETS_ACCOUNT                = 0x04000000
      UF_USE_AES_KEYS                           = 0x08000000

      # [2.2.1.14 Predefined RIDs](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/565a6584-3061-4ede-a531-f5c53826504b)
      DOMAIN_USER_RID_ADMIN                 = 0x000001F4
      DOMAIN_USER_RID_GUEST                 = 0x000001F5
      DOMAIN_USER_RID_KRBTGT                = 0x000001F6
      DOMAIN_GROUP_RID_ADMINS               = 0x00000200
      DOMAIN_GROUP_RID_USERS                = 0x00000201
      DOMAIN_GROUP_RID_COMPUTERS            = 0x00000203
      DOMAIN_GROUP_RID_CONTROLLERS          = 0x00000204
      DOMAIN_ALIAS_RID_ADMINS               = 0x00000220
      DOMAIN_GROUP_RID_READONLY_CONTROLLERS = 0x00000209

      # [2.2.10.8 Kerberos Encryption Algorithm Identifiers](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/1355fa6b-d097-4ecc-8d5e-75b3a6533e04)
      KERBEROS_TYPE = {
        1          => 'dec-cbc-crc',
        3          => 'des-cbc-md5',
        17         => 'aes128-cts-hmac-sha1-96',
        18         => 'aes256-cts-hmac-sha1-96',
        # Windows Server 2008 and later DC includes a KeyType of -140. Not present when the domain functional level is raised to DS_BEHAVIOR_WIN2008 or greater
        # [Appendix_A_24](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/fa61e5fc-f8fb-4d5b-9695-c724af0c3829#Appendix_A_24)
        0xffffff74 => 'rc4_hmac'
      }

      # [2.2.3.9 SAMPR_RID_ENUMERATION](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/5c94a35a-e7f2-4675-af34-741f5a8ee1a2)
      class SamprRidEnumeration < Ndr::NdrStruct
        default_parameters byte_align: 4
        endian :little

        ndr_uint32         :relative_id
        rpc_unicode_string :name
      end

      class SamprRidEnumerationArray < Ndr::NdrConfArray
        default_parameter type: :sampr_rid_enumeration
      end

      class PsamprRidEnumerationArray < SamprRidEnumerationArray
        extend Ndr::PointerClassPlugin
      end

      # [2.2.3.10 SAMPR_ENUMERATION_BUFFER](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/c53161a4-38e8-4a28-a33e-0d378fce03dd)
      class SamprEnumerationBuffer < Ndr::NdrStruct
        default_parameters byte_align: 4
        endian :little

        ndr_uint32                   :entries_read
        psampr_rid_enumeration_array :buffer
      end

      class PsamprEnumerationBuffer < SamprEnumerationBuffer
        extend Ndr::PointerClassPlugin
      end

      class SamprHandle < Ndr::NdrContextHandle; end

      class PulongArray < Ndr::NdrConfArray
        default_parameter type: :ndr_uint32
        extend Ndr::PointerClassPlugin
      end

      # [2.2.7.3 ENCRYPTED_NT_OWF_PASSWORD](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/ce061fef-6d4f-4802-bd5d-26b11f14f4a6)
      class EncryptedNtOwfPassword < Ndr::NdrStruct
        default_parameter byte_align: 4
        ndr_fixed_byte_array :buffer, initial_length: 16

        # [2.2.11.1.2 Encrypting a 64-bit block with a 7-byte key](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/ebdb15df-8d0d-4347-9d62-082e6eccac40)
        def self.to_output_key(input_key)
          output_key = []
          input_key = input_key.unpack('C'*7)
          output_key.append(input_key[0] >> 0x01)
          output_key.append(((input_key[0]&0x01)<<6) | (input_key[1]>>2))
          output_key.append(((input_key[1]&0x03)<<5) | (input_key[2]>>3))
          output_key.append(((input_key[2]&0x07)<<4) | (input_key[3]>>4))
          output_key.append(((input_key[3]&0x0F)<<3) | (input_key[4]>>5))
          output_key.append(((input_key[4]&0x1F)<<2) | (input_key[5]>>6))
          output_key.append(((input_key[5]&0x3F)<<1) | (input_key[6]>>7))
          output_key.append(input_key[6] & 0x7F)

          output_key = output_key.map {|x| (x << 1) & 0xFE}

          output_key.pack('C'*8)
        end

        # [2.2.11.1 DES-ECB-LM](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/3f5ec79d-b449-4ab2-9423-c4dccbe0b184)
        def self.encrypt_hash(hash:, key:)
          block1 = hash[0..7]
          block2 = hash[8..]
          key1 = to_output_key(key[0..6])
          key2 = to_output_key(key[7..13]) # The last two bytes are ignored

          cipher1 = OpenSSL::Cipher.new('des-ecb').tap do |cipher|
            cipher.encrypt
            cipher.key = key1
          end

          cipher2 = OpenSSL::Cipher.new('des-ecb').tap do |cipher|
            cipher.encrypt
            cipher.key = key2
          end

          cipher1.update(block1) + cipher2.update(block2)
        end
      end

      EncryptedLmOwfPassword = EncryptedNtOwfPassword

      class PencryptedNtOwfPassword < EncryptedNtOwfPassword
        extend Ndr::PointerClassPlugin
      end

      PencryptedLmOwfPassword = PencryptedNtOwfPassword

      # [2.2.7.4 SAMPR_ULONG_ARRAY](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/2feb3806-4db2-45b7-90d2-86c8336a31ba)
      class SamprUlongArray < Ndr::NdrStruct
        default_parameter byte_align: 4

        ndr_uint32   :element_count, initial_value: -> { elements.size }
        pulong_array :elements
      end

      # [2.2.2.4 RPC_SHORT_BLOB](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/77dbfdbb-6627-4871-ab12-5333929347dc)
      class RpcShortBlob < BinData::Record
        ndr_uint16           :buffer_length, initial_value: -> { buffer.length }
        ndr_uint16           :max_length, initial_value: -> { buffer.length }
        ndr_uint16_array_ptr :buffer
      end

      # [2.2.6.21 SAMPR_ENCRYPTED_USER_PASSWORD](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/23f9ef4c-cf3e-4330-9287-ea4799b03201)
      class SamprEncryptedUserPassword < Ndr::NdrStruct
        default_parameter byte_align: 4
        ndr_fixed_byte_array :buffer, initial_length: 516

        def self.encrypt_password(password, old_password_nt)
          # see: https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/5fe3c4c4-e71b-440d-b2fd-8448bfaf6e04
          password = password.encode('UTF-16LE').force_encoding('ASCII-8BIT')
          buffer = password.rjust(512, "\x00") + [ password.length ].pack('V')
          cipher = OpenSSL::Cipher.new('RC4').tap do |cipher|
            cipher.encrypt
            cipher.key = old_password_nt
          end
          cipher.update(buffer)
        end
      end

      class PsamprEncryptedUserPassword < SamprEncryptedUserPassword
        extend Ndr::PointerClassPlugin
      end


      # [2.2.6.22 SAMPR_ENCRYPTED_USER_PASSWORD_NEW](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/112ecc94-1cbe-41cd-b669-377402c20786)
      class SamprEncryptedUserPasswordNew < BinData::Record
        ndr_fixed_byte_array :buffer, initial_length: 532

        def self.encrypt_password(password, key)
          # see: https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/5fe3c4c4-e71b-440d-b2fd-8448bfaf6e04
          password = password.encode('UTF-16LE').force_encoding('ASCII-8BIT')
          buffer = password.rjust(512, "\x00") + [ password.length ].pack('V')
          salt = SecureRandom.random_bytes(16)
          key = OpenSSL::Digest::MD5.new(salt + key).digest
          cipher = OpenSSL::Cipher.new('RC4').tap do |cipher|
            cipher.encrypt
            cipher.key = key
          end
          cipher.update(buffer) + salt
        end
      end

      # [2.2.6.5 SAMPR_LOGON_HOURS](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/d83c356b-7dda-4096-8270-5c581f84a4d9)
      class SamprLogonHours < BinData::Record
        ndr_uint16         :units_per_week
        ndr_byte_array_ptr :logon_hours
      end

      # [2.2.7.11 SAMPR_SR_SECURITY_DESCRIPTOR](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/675e37d9-bb97-4f14-bba2-be081c87cd5d)
      class SamprSrSecurityDescriptor < BinData::Record
        ndr_uint32         :buffer_length, initial_value: -> { buffer.length }
        ndr_byte_array_ptr :buffer
      end

      # [2.2.6.6 SAMPR_USER_ALL_INFORMATION](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/dc966b81-da27-4dae-a28c-ec16534f1cb9)
      class SamprUserAllInformation < BinData::Record
        ndr_uint64                   :last_logon
        ndr_uint64                   :last_logoff
        ndr_uint64                   :password_last_set
        ndr_uint64                   :account_expires
        ndr_uint64                   :password_can_change
        ndr_uint64                   :password_must_change
        rpc_unicode_string           :user_name
        rpc_unicode_string           :full_name
        rpc_unicode_string           :home_directory
        rpc_unicode_string           :home_directory_drive
        rpc_unicode_string           :script_path
        rpc_unicode_string           :profile_path
        rpc_unicode_string           :admin_comment
        rpc_unicode_string           :work_stations
        rpc_unicode_string           :user_comment
        rpc_unicode_string           :parameters
        rpc_short_blob               :lm_owf_password
        rpc_short_blob               :nt_owf_password
        rpc_unicode_string           :private_data
        sampr_sr_security_descriptor :security_descriptor
        ndr_uint32                   :user_id
        ndr_uint32                   :primary_group_id
        ndr_uint32                   :user_account_control
        ndr_uint32                   :which_fields
        sampr_logon_hours            :logon_hours
        ndr_uint16                   :bad_password_count
        ndr_uint16                   :logon_count
        ndr_uint16                   :country_code
        ndr_uint16                   :code_page
        ndr_uint8                    :lm_password_present
        ndr_uint8                    :nt_password_present
        ndr_uint8                    :password_expired
        ndr_uint8                    :private_data_sensitive
      end

      # [2.2.6.25 SAMPR_USER_INTERNAL4_INFORMATION_NEW](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/b2f614b9-0312-421a-abed-10ee002ef780)
      class SamprUserInternal4InformationNew < BinData::Record
        sampr_user_all_information        :i1
        sampr_encrypted_user_password_new :user_password
      end

      # [2.2.6.3 USER_CONTROL_INFORMATION](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/eb5f1508-ede1-4ff1-be82-55f3e2ef1633)
      class UserControlInformation < BinData::Record
        endian     :little

        ndr_uint32 :user_account_control
      end

      # [2.2.6.25 SAMPR_USER_INTERNAL1_INFORMATION](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/50d17755-c6b8-40bd-8cac-bd6cfa31adf2)
      class SamprUserInternal1Information < BinData::Record
        encrypted_nt_owf_password         :encrypted_nt_owf_password
        encrypted_nt_owf_password         :encrypted_lm_owf_password
        ndr_uint8                         :nt_password_present
        ndr_uint8                         :lm_password_present
        ndr_uint8                         :password_expired
      end

      # [2.2.6.29 SAMPR_USER_INFO_BUFFER](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/9496c26e-490b-4e76-827f-2695fc216f35)
      class SamprUserInfoBuffer < BinData::Record
        ndr_uint16 :tag
        choice     :member, selection: :tag do
          user_control_information             USER_CONTROL_INFORMATION
          sampr_user_internal4_information_new USER_INTERNAL4_INFORMATION_NEW
          sampr_user_internal1_information     USER_INTERNAL1_INFORMATION
        end
      end

      # [2.2.10.2 USER_PROPERTY](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/7c0f2eca-1783-450b-b5a0-754cf11f22c9)
      class UserProperty < BinData::Record
        endian   :little

        uint16   :name_length, initial_value: -> { property_name.num_bytes }
        uint16   :value_length, initial_value: -> { property_value.num_bytes }
        uint16   :reserved
        string16 :property_name, read_length: :name_length
        string   :property_value, read_length: :value_length
      end

      # [2.2.10.1 USER_PROPERTIES](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/8263e7ab-aba9-43d2-8a36-3a9cb2dd3dad)
      class UserProperties < BinData::Record
        endian :little
        hide   :bytes_remaining

        uint32 :reserved1
        # Length, in bytes, of the entire structure, starting from the :reserved4 field (offset 12):
        uint32 :struct_length, value: -> { num_bytes - 12}
        uint16 :reserved2
        uint16 :reserved3
        string :reserved4, length: 96
        uint16 :property_signature, initial_value: 0x50
        count_bytes_remaining :bytes_remaining
        # When there are zero `user_property` elements in the `:user_properties` field, this field MUST be omitted;
        # the resultant `UserProperties` structure has a constant size of 0x6F bytes.
        uint16 :property_count, value: -> { user_properties.size }, onlyif: :display_user_properties?
        array  :user_properties, type: :user_property, read_until: -> { array.size == property_count }, onlyif: :display_user_properties?
        uint8  :reserved5

        def display_user_properties?
          bytes_remaining > 1 || user_properties.size > 0
        end

        def do_read(io)
          super
          bytes_remaining.clear
        end
      end

      # [2.2.10.7 KERB_KEY_DATA_NEW](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/447520a5-e1cc-48cc-8fdc-b90db57f7eac)
      class KerbKeyDataNew < BinData::Record
        endian :little

        uint16 :reserved1
        uint16 :reserved2
        uint32 :reserved3
        uint32 :iteration_count
        uint32 :key_type
        uint32 :key_length
        uint32 :key_offset
      end

      # [2.2.10.6 Primary:Kerberos-Newer-Keys - KERB_STORED_CREDENTIAL_NEW](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-samr/08cb3ca7-954b-45e3-902e-77512fe3ba8e)
      class KerbStoredCredentialNew < BinData::Record
        endian :little

        uint16 :revision
        uint16 :flags
        uint16 :credential_count
        uint16 :service_credential_count
        uint16 :old_credential_count
        uint16 :older_credential_count
        uint16 :default_salt_length
        uint16 :default_salt_maximum_length
        uint32 :default_salt_offset
        uint32 :default_iteration_count
        array  :credentials, type: :kerb_key_data_new, initial_length: :credential_count
        array  :service_credentials, type: :kerb_key_data_new, initial_length: :service_credential_count
        array  :old_credentials, type: :kerb_key_data_new, initial_length: :old_credential_count
        array  :older_credentials, type: :kerb_key_data_new, initial_length: :older_credential_count
        string :default_salt, read_length: -> { credentials.map { |e| e.key_offset }.min - @obj.abs_offset }
        string :key_values, read_length: -> { credentials.map { |e| e.key_length }.sum(&:to_i) }

        def get_key_values
          credentials.map do |credential|
            offset = credential.key_offset - key_values.abs_offset
            key_values[offset, credential.key_length]
          end
        end
      end

      require 'ruby_smb/dcerpc/samr/rpc_sid'
      require 'ruby_smb/dcerpc/samr/sampr_domain_info_buffer'

      require 'ruby_smb/dcerpc/samr/samr_connect_request'
      require 'ruby_smb/dcerpc/samr/samr_connect_response'
      require 'ruby_smb/dcerpc/samr/samr_create_user2_in_domain_request'
      require 'ruby_smb/dcerpc/samr/samr_create_user2_in_domain_response'
      require 'ruby_smb/dcerpc/samr/samr_lookup_domain_in_sam_server_request'
      require 'ruby_smb/dcerpc/samr/samr_lookup_domain_in_sam_server_response'
      require 'ruby_smb/dcerpc/samr/samr_lookup_names_in_domain_request'
      require 'ruby_smb/dcerpc/samr/samr_lookup_names_in_domain_response'
      require 'ruby_smb/dcerpc/samr/samr_open_domain_request'
      require 'ruby_smb/dcerpc/samr/samr_open_domain_response'
      require 'ruby_smb/dcerpc/samr/samr_enumerate_domains_in_sam_server_request'
      require 'ruby_smb/dcerpc/samr/samr_enumerate_domains_in_sam_server_response'
      require 'ruby_smb/dcerpc/samr/samr_enumerate_users_in_domain_request'
      require 'ruby_smb/dcerpc/samr/samr_enumerate_users_in_domain_response'
      require 'ruby_smb/dcerpc/samr/samr_rid_to_sid_request'
      require 'ruby_smb/dcerpc/samr/samr_rid_to_sid_response'
      require 'ruby_smb/dcerpc/samr/samr_close_handle_request'
      require 'ruby_smb/dcerpc/samr/samr_close_handle_response'
      require 'ruby_smb/dcerpc/samr/samr_get_members_in_group_request'
      require 'ruby_smb/dcerpc/samr/samr_get_members_in_group_response'
      require 'ruby_smb/dcerpc/samr/samr_get_alias_membership_request'
      require 'ruby_smb/dcerpc/samr/samr_get_alias_membership_response'
      require 'ruby_smb/dcerpc/samr/samr_open_group_request'
      require 'ruby_smb/dcerpc/samr/samr_open_group_response'
      require 'ruby_smb/dcerpc/samr/samr_open_user_request'
      require 'ruby_smb/dcerpc/samr/samr_open_user_response'
      require 'ruby_smb/dcerpc/samr/samr_get_groups_for_user_request'
      require 'ruby_smb/dcerpc/samr/samr_get_groups_for_user_response'
      require 'ruby_smb/dcerpc/samr/samr_set_information_user2_request'
      require 'ruby_smb/dcerpc/samr/samr_set_information_user2_response'
      require 'ruby_smb/dcerpc/samr/samr_change_password_user_request'
      require 'ruby_smb/dcerpc/samr/samr_change_password_user_response'
      require 'ruby_smb/dcerpc/samr/samr_unicode_change_password_user2_request'
      require 'ruby_smb/dcerpc/samr/samr_unicode_change_password_user2_response'
      require 'ruby_smb/dcerpc/samr/samr_delete_user_request'
      require 'ruby_smb/dcerpc/samr/samr_delete_user_response'
      require 'ruby_smb/dcerpc/samr/samr_query_information_domain_request'
      require 'ruby_smb/dcerpc/samr/samr_query_information_domain_response'

      # Returns a handle to a server object.
      #
      # @param server_name [Char] the first character of the NETBIOS name of
      #   the server (optional)
      # @param access [Numeric] access requested for ServerHandle upon output:
      #   bitwise OR of common and server ACCESS_MASK values (defined in
      #   lib/ruby_smb/dcerpc/samr.rb).
      # @return [RubySMB::Dcerpc::Samr::SamprHandle] handle to the server object.
      # @raise [RubySMB::Dcerpc::Error::InvalidPacket] if the response is not a
      #   SamrConnectResponse packet
      # @raise [RubySMB::Dcerpc::Error::SamrError] if the response error status
      #   is not STATUS_SUCCESS
      def samr_connect(server_name: '', access: MAXIMUM_ALLOWED)
        samr_connect_request = SamrConnectRequest.new(
          server_name: server_name,
          desired_access: access
        )
        response = dcerpc_request(samr_connect_request)
        begin
          samr_connect_response = SamrConnectResponse.read(response)
        rescue IOError
          raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrConnectResponse'
        end
        unless samr_connect_response.error_status == WindowsError::NTStatus::STATUS_SUCCESS
          raise RubySMB::Dcerpc::Error::SamrError,
            "Error returned with samr_connect: "\
            "#{WindowsError::NTStatus.find_by_retval(samr_connect_response.error_status.value).join(',')}"
        end
        samr_connect_response.server_handle
      end

      # Create a new user.
      #
      # @param domain_handle [RubySMB::Dcerpc::Samr::SamprHandle] RPC context
      #   handle representing the domain object
      # @param name [String] The name of the account to add
      # @param account_type [Integer] The type of account to add, one of either
      #   USER_NORMAL_ACCOUNT, USER_WORKSTATION_TRUST_ACCOUNT, or
      #   USER_SERVER_TRUST_ACCOUNT
      # @param desired_access [Integer] The access requested on the returned
      #   object
      # @return [RubySMB::Dcerpc::Samr::SamprHandle] handle to the server object.
      # @raise [RubySMB::Dcerpc::Error::InvalidPacket] if the response is not a
      #   SamrConnectResponse packet
      # @raise [RubySMB::Dcerpc::Error::SamrError] if the response error status
      #   is not STATUS_SUCCESS
      def samr_create_user2_in_domain(domain_handle:, name:, account_type: USER_NORMAL_ACCOUNT, desired_access: GROUP_ALL_ACCESS)
        samr_create_request = SamrCreateUser2InDomainRequest.new(
          domain_handle: domain_handle,
          name: name,
          account_type: account_type,
          desired_access: desired_access
        )
        response = dcerpc_request(samr_create_request)
        begin
          samr_create_response = SamrCreateUser2InDomainResponse.read(response)
        rescue IOError
          raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrCreateUser2InDomainResponse'
        end
        unless samr_create_response.error_status == WindowsError::NTStatus::STATUS_SUCCESS
          raise RubySMB::Dcerpc::Error::SamrError,
            "Error returned with samr_create_user2_in_domain: "\
            "#{WindowsError::NTStatus.find_by_retval(samr_create_response.error_status.value).join(',')}"
        end

        {
          user_handle: samr_create_response.user_handle,
          granted_access: samr_create_response.granted_access.to_i,
          relative_id: samr_create_response.relative_id.to_i
        }
      end

      # Delete an existing user.
      #
      # @param user_handle [RubySMB::Dcerpc::Samr::SamprHandle] RPC context
      #   handle representing the user object to delete
      # @raise [RubySMB::Dcerpc::Error::InvalidPacket] if the response is not a
      #   SamrDeleteUserResponse packet
      # @raise [RubySMB::Dcerpc::Error::SamrError] if the response error status
      #   is not STATUS_SUCCESS
      def samr_delete_user(user_handle:)
        samr_delete_user_request = SamrDeleteUserRequest.new(
          user_handle: user_handle
        )

        response = dcerpc_request(samr_delete_user_request)
        begin
          samr_delete_user_response = SamrDeleteUserResponse.read(response)
        rescue IOError
          raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrDeleteUserResponse'
        end
        unless samr_delete_user_response.error_status == WindowsError::NTStatus::STATUS_SUCCESS
          raise RubySMB::Dcerpc::Error::SamrError,
            "Error returned while deleting user in SAM server: "\
            "#{WindowsError::NTStatus.find_by_retval(samr_delete_user_response.error_status.value).join(',')}"
        end

        nil
      end

      # Obtains the SID of a domain object
      #
      # @param server_handle [RubySMB::Dcerpc::Samr::SamprHandle] RPC context
      #   handle representing the server object
      # @param name [String] The domain name
      # @return [RubySMB::Dcerpc::RpcSid] SID value of a domain that
      #   corresponds to the Name passed in
      # @raise [RubySMB::Dcerpc::Error::InvalidPacket] if the response is not a
      #   SamrLookupDomainInSamServerResponse packet
      # @raise [RubySMB::Dcerpc::Error::SamrError] if the response error status
      #   is not STATUS_SUCCESS
      def samr_lookup_domain(server_handle:, name:)
        samr_lookup_domain_in_sam_server_request = SamrLookupDomainInSamServerRequest.new(
          server_handle: server_handle,
          name: name
        )
        response = dcerpc_request(samr_lookup_domain_in_sam_server_request)
        begin
          samr_lookup_domain_in_sam_server_response = SamrLookupDomainInSamServerResponse.read(response)
        rescue IOError
          raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrLookupDomainInSamServerResponse'
        end
        unless samr_lookup_domain_in_sam_server_response.error_status == WindowsError::NTStatus::STATUS_SUCCESS
          raise RubySMB::Dcerpc::Error::SamrError,
            "Error returned during domain lookup in SAM server: "\
            "#{WindowsError::NTStatus.find_by_retval(samr_lookup_domain_in_sam_server_response.error_status.value).join(',')}"
        end
        samr_lookup_domain_in_sam_server_response.domain_id
      end

      # Obtains the SID of a domain object
      #
      # @param domain_handle [RubySMB::Dcerpc::Samr::SamprHandle] RPC context
      #   handle representing the domain object
      # @param name [Array<String>] An array of string account names to
      #   translate to RIDs.
      # @return [Hash<String, Hash<Symbol, Integer>>, Nil] Returns a hash mapping
      #   the requested names to their information. Nil is returned if one or
      #   more names could not be found.
      # @raise [RubySMB::Dcerpc::Error::SamrError] if the response error status
      #   is not STATUS_SUCCESS, STATUS_NONE_MAPPED, or STATUS_SOME_NOT_MAPPED
      def samr_lookup_names_in_domain(domain_handle:, names:)
        raise ArgumentError.new('names may not be longer than 1000') if names.length > 1000

        samr_lookup_request = SamrLookupNamesInDomainRequest.new(
          domain_handle: domain_handle,
          names_count: names.length,
          names: names
        )
        samr_lookup_request.names.set_max_count(1000)
        response = dcerpc_request(samr_lookup_request)
        begin
          samr_lookup_response = SamrLookupNamesInDomainResponse.read(response)
        rescue IOError
          raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrLookupNamesInDomainResponse'
        end
        return nil if samr_lookup_response.error_status == WindowsError::NTStatus::STATUS_NONE_MAPPED
        return nil if samr_lookup_response.error_status == WindowsError::NTStatus::STATUS_SOME_NOT_MAPPED
        unless samr_lookup_response.error_status == WindowsError::NTStatus::STATUS_SUCCESS
          raise RubySMB::Dcerpc::Error::SamrError,
            "Error returned during names lookup in SAM server: "\
            "#{WindowsError::NTStatus.find_by_retval(samr_lookup_response.error_status.value).join(',')}"
        end

        result = {}
        names.each_with_index do |name, index|
          result[name] = {
            rid: samr_lookup_response.relative_ids.elements[index].to_i,
            use: samr_lookup_response.use.elements[index].to_i
          }
        end
        result
      end

      # Returns a handle to a domain object.
      #
      # @param server_handle [RubySMB::Dcerpc::Samr::SamprHandle] RPC context
      #   handle representing the server object
      # @param access [Numeric] access requested for ServerHandle upon output:
      #   bitwise OR of common and server ACCESS_MASK values (defined in
      #   lib/ruby_smb/dcerpc/samr.rb).
      # @param domain_id [RubySMB::Dcerpc::RpcSid] SID value of a domain
      # @return [RubySMB::Dcerpc::Samr::SamprHandle] handle to the domain object.
      # @raise [RubySMB::Dcerpc::Error::InvalidPacket] if the response is not a
      #   SamrOpenDomainResponse packet
      # @raise [RubySMB::Dcerpc::Error::SamrError] if the response error status
      #   is not STATUS_SUCCESS
      def samr_open_domain(server_handle:, access: MAXIMUM_ALLOWED, domain_id:)
        samr_open_domain_request = SamrOpenDomainRequest.new(
          server_handle: server_handle,
          desired_access: access,
          domain_id: domain_id
        )
        response = dcerpc_request(samr_open_domain_request)
        begin
          samr_open_domain_response = SamrOpenDomainResponse.read(response)
        rescue IOError
          raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrLookupDomainInSamServerResponse'
        end
        unless samr_open_domain_response.error_status == WindowsError::NTStatus::STATUS_SUCCESS
          raise RubySMB::Dcerpc::Error::SamrError,
            "Error returned during domain lookup in SAM server: "\
            "#{WindowsError::NTStatus.find_by_retval(samr_open_domain_response.error_status.value).join(',')}"
        end
        samr_open_domain_response.domain_handle
      end

      # Enumerates all domains on the remote server.
      #
      # @param server_handle [RubySMB::Dcerpc::Samr::SamprHandle] RPC context
      #   handle representing the server object
      # @param enumeration_context [Integer] a cookie used by the server to
      #   resume an enumeration
      # @return [Array<String>] an array containing the domain names
      # @raise [RubySMB::Dcerpc::Error::InvalidPacket] if the response is not a
      #   SamrEnumerateDomainsInSamServerResponse packet
      # @raise [RubySMB::Dcerpc::Error::SamrError] if the response error status
      #   is not STATUS_SUCCESS
      def samr_enumerate_domains_in_sam_server(server_handle:, enumeration_context: 0)
        samr_enum_domains_request = SamrEnumerateDomainsInSamServerRequest.new(
          server_handle: server_handle,
          enumeration_context: enumeration_context,
          prefered_maximum_length: 0xFFFFFFFF
        )
        res = []
        loop do
          samr_enum_domains_request.enumeration_context = enumeration_context
          response = dcerpc_request(samr_enum_domains_request)
          begin
            samr_enum_domains_reponse = SamrEnumerateDomainsInSamServerResponse.read(response)
          rescue IOError
            raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrEnumerateDomainsInSamServerResponse'
          end
          unless samr_enum_domains_reponse.error_status == WindowsError::NTStatus::STATUS_SUCCESS ||
                 samr_enum_domains_reponse.error_status == WindowsError::NTStatus::STATUS_MORE_ENTRIES
            raise RubySMB::Dcerpc::Error::SamrError,
              "Error returned during domains enumeration in SAM server: "\
              "#{WindowsError::NTStatus.find_by_retval(samr_enum_domains_reponse.error_status.value).join(',')}"
          end
          samr_enum_domains_reponse.buffer.buffer.each_with_object(res) do |entry, array|
            array << entry.name.buffer
          end
          break unless samr_enum_domains_reponse.error_status == WindowsError::NTStatus::STATUS_MORE_ENTRIES

          enumeration_context = samr_enum_domains_reponse.enumeration_context
        end

        res
      end

      # Enumerates all users in the specified domain.
      #
      # @param domain_handle [RubySMB::Dcerpc::Samr::SamprHandle] RPC context
      #   handle representing the domain object
      # @param enumeration_context [Integer] a cookie used by the server to
      #   resume an enumeration
      # @param user_account_control [Integer] a value to use for filtering on
      #   the userAccountControl attribute
      # @return [Hash<Integer, String>] hash mapping RID and username
      # @raise [RubySMB::Dcerpc::Error::InvalidPacket] if the response is not a
      #   SamrEnumerateUsersInDomainResponse packet
      # @raise [RubySMB::Dcerpc::Error::SamrError] if the response error status
      #   is not STATUS_SUCCESS
      def samr_enumerate_users_in_domain(domain_handle:,
                                         enumeration_context: 0,
                                         user_account_control: USER_NORMAL_ACCOUNT |
                                                               USER_WORKSTATION_TRUST_ACCOUNT |
                                                               USER_SERVER_TRUST_ACCOUNT |
                                                               USER_INTERDOMAIN_TRUST_ACCOUNT)
        samr_enum_users_request = SamrEnumerateUsersInDomainRequest.new(
          domain_handle: domain_handle,
          user_account_control: user_account_control,
          prefered_maximum_length: 0xFFFFFFFF
        )
        res = {}
        loop do
          samr_enum_users_request.enumeration_context = enumeration_context
          response = dcerpc_request(samr_enum_users_request)
          begin
            samr_enum_users_reponse= SamrEnumerateUsersInDomainResponse.read(response)
          rescue IOError
            raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrEnumerateUsersInDomainResponse'
          end
          unless samr_enum_users_reponse.error_status == WindowsError::NTStatus::STATUS_SUCCESS ||
                 samr_enum_users_reponse.error_status == WindowsError::NTStatus::STATUS_MORE_ENTRIES
            raise RubySMB::Dcerpc::Error::SamrError,
              "Error returned during users enumeration in SAM server: "\
              "#{WindowsError::NTStatus.find_by_retval(samr_enum_users_reponse.error_status.value).join(',')}"
          end
          samr_enum_users_reponse.buffer.buffer.each_with_object(res) do |entry, hash|
            hash[entry.relative_id] = entry.name.buffer
          end
          break unless samr_enum_users_reponse.error_status == WindowsError::NTStatus::STATUS_MORE_ENTRIES
          enumeration_context = samr_enum_users_reponse.enumeration_context
        end
        res
      end

      # Returns the SID of an account, given a RID.
      #
      # @param rid [Numeric] the RID
      # @return [String] The SID of the account referenced by RID
      # @raise [RubySMB::Dcerpc::Error::InvalidPacket] if the response is not a
      #   SamrRidToSidResponse packet
      # @raise [RubySMB::Dcerpc::Error::SamrError] if the response error status
      #   is not STATUS_SUCCESS
      def samr_rid_to_sid(object_handle:, rid:)
        samr_rid_to_sid_request = SamrRidToSidRequest.new(
          object_handle: object_handle,
          rid: rid
        )
        response = dcerpc_request(samr_rid_to_sid_request)
        begin
          samr_rid_to_sid_response = SamrRidToSidResponse.read(response)
        rescue IOError
          raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrRidToSidResponse'
        end
        unless samr_rid_to_sid_response.error_status == WindowsError::NTStatus::STATUS_SUCCESS
          raise RubySMB::Dcerpc::Error::SamrError,
            "Error returned during SID lookup in SAM server: "\
            "#{WindowsError::NTStatus.find_by_retval(samr_rid_to_sid_response.error_status.value).join(',')}"
        end
        samr_rid_to_sid_response.sid
      end

      # Update attributes on a user object.
      #
      # @param user_handle [RubySMB::Dcerpc::Samr::SamprHandle] An RPC context
      #   representing a user object.
      # @param user_info: [RubySMB::Dcerpc::Samr::SamprUserInfoBuffer] the user
      #   information to set.
      # @return nothing is returned on success
      # @raise [RubySMB::Dcerpc::Error::SamrError] if the response error status
      #   is not STATUS_SUCCESS
      def samr_set_information_user2(user_handle:, user_info:)
        samr_set_information_user2_request = SamrSetInformationUser2Request.new(
          user_handle: user_handle,
          buffer: user_info
        )
        response = dcerpc_request(samr_set_information_user2_request)
        begin
          samr_set_information_user2_response = SamrSetInformationUser2Response.read(response)
        rescue IOError
          raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrSetInformationUser2Response'
        end
        unless samr_set_information_user2_response.error_status == WindowsError::NTStatus::STATUS_SUCCESS
          raise RubySMB::Dcerpc::Error::SamrError,
            "Error returned while setting user information: "\
            "#{WindowsError::NTStatus.find_by_retval(samr_set_information_user2_response.error_status.value).join(',')}"
        end

        nil
      end

      # Change the password on a user object.
      #
      # @param user_handle [SamprHandle] Handle representing the user to change the password for
      # @param old_password [String] The previous password (either this or old_nt_hash must be specified)
      # @param new_password [String] The password to set on the account
      # @param new_nt_hash [String] The new password's NT hash
      # @param new_lm_hash [String] The new password's LM hash
      # @param old_nt_hash [String] The previous password's NT hash (either this or old_password must be specified)
      # @param old_lm_hash [String] The previous password's LM hash (currently ignored)
      # @return nothing is returned on success
      # @raise [RubySMB::Dcerpc::Error::SamrError] if the response error status
      #   is not STATUS_SUCCESS
      def samr_change_password_user(user_handle:, old_password:nil, new_password:nil, new_nt_hash:nil, new_lm_hash:nil, old_nt_hash:nil, old_lm_hash:nil)
        if new_password.nil? == new_nt_hash.nil?
          raise ArgumentError.new('Provide either new password or new password hashes, but not both')
        end

        if old_password.nil? == old_nt_hash.nil?
          raise ArgumentError.new('Provide either old password or old password hashes, but not both')
        end

        if old_password
          old_lm_hash = Net::NTLM.lm_hash(old_password[0..13])
          old_nt_hash = Net::NTLM.ntlm_hash(old_password)
        end

        if new_nt_hash.nil?
          new_nt_hash = Net::NTLM::ntlm_hash(new_password)
          new_lm_hash = Net::NTLM.lm_hash(new_password[0..13])
        elsif new_lm_hash.nil?
          new_lm_hash = Net::NTLM.lm_hash('')
        end
        
        samr_change_password_user_request = SamrChangePasswordUserRequest.new(
          user_handle: user_handle,
          lm_present: 0,
          old_lm_encrypted_with_new_lm: nil,
          new_lm_encrypted_with_old_lm: nil,
          nt_present: 1,
          old_nt_encrypted_with_new_nt: PencryptedNtOwfPassword.new(buffer: EncryptedNtOwfPassword.encrypt_hash(hash: old_nt_hash, key: new_nt_hash)),
          new_nt_encrypted_with_old_nt: PencryptedNtOwfPassword.new(buffer: EncryptedNtOwfPassword.encrypt_hash(hash: new_nt_hash, key: old_nt_hash)),
          nt_cross_encryption_present: 0,
          new_nt_encrypted_with_new_lm: nil,
          lm_cross_encryption_present: 1,
          new_lm_encrypted_with_new_nt: PencryptedNtOwfPassword.new(buffer: EncryptedNtOwfPassword.encrypt_hash(hash: new_lm_hash, key: new_nt_hash)),
        )
        response = dcerpc_request(samr_change_password_user_request)
        begin
          samr_unicode_change_password_user2_response = SamrChangePasswordUserResponse.read(response)
        rescue IOError
          raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrUnicodeChangePasswordUser2Response'
        end
        unless samr_unicode_change_password_user2_response.error_status == WindowsError::NTStatus::STATUS_SUCCESS
          raise RubySMB::Dcerpc::Error::SamrError,
            "Error returned while changing user password: "\
            "#{WindowsError::NTStatus.find_by_retval(samr_unicode_change_password_user2_response.error_status.value).join(',')}"
        end

        nil
      end


      # Change the password on a user.
      #
      # @param server_name [String] The server name; can be ignored by the server
      # @param target_username [String] The user for which we're changing the password
      # @param old_password [String] The previous password (either this or old_nt_hash must be specified)
      # @param new_password [String] The password to set on the account
      # @param old_nt_hash [String] The previous password's NT hash (either this or old_password must be specified)
      # @param old_lm_hash [String] The previous password's LM hash (currently ignored)
      # @return nothing is returned on success
      # @raise [RubySMB::Dcerpc::Error::SamrError] if the response error status
      #   is not STATUS_SUCCESS
      def samr_unicode_change_password_user2(server_name: "", target_username:, old_password:nil, new_password:, old_nt_hash:nil, old_lm_hash:nil)
        #if old_lm_hash.nil? != old_nt_hash.nil?
        #  raise ArgumentError.new('If providing the previous NT/LM hash, must provide both')
        #end
        if old_password.nil? == old_nt_hash.nil?
          raise ArgumentError.new('Provide either old password or old password hashes, but not both')
        end

        if old_password
          old_lm_hash = Net::NTLM.lm_hash(old_password[0..13])
          old_nt_hash = Net::NTLM.ntlm_hash(old_password)
        end

        new_nt_hash = Net::NTLM::ntlm_hash(new_password)

        samr_unicode_change_password_user2_request = SamrUnicodeChangePasswordUser2Request.new(
          server_name: server_name,
          user_name: target_username,
          new_password_encrypted_with_old_nt: SamprEncryptedUserPassword.new(buffer: SamprEncryptedUserPassword.encrypt_password(new_password, old_nt_hash)),
          old_nt_owf_password_encrypted_with_new_nt: PencryptedNtOwfPassword.new(buffer: EncryptedNtOwfPassword.encrypt_hash(hash: old_nt_hash, key: new_nt_hash)),
          lm_present: 0
        )
        samr_unicode_change_password_user2_request
        response = dcerpc_request(samr_unicode_change_password_user2_request)
        begin
          samr_unicode_change_password_user2_response = SamrUnicodeChangePasswordUser2Response.read(response)
        rescue IOError
          raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrUnicodeChangePasswordUser2Response'
        end
        unless samr_unicode_change_password_user2_response.error_status == WindowsError::NTStatus::STATUS_SUCCESS
          raise RubySMB::Dcerpc::Error::SamrError,
            "Error returned while changing user password: "\
            "#{WindowsError::NTStatus.find_by_retval(samr_unicode_change_password_user2_response.error_status.value).join(',')}"
        end

        nil
      end

      # Closes (that is, releases server-side resources used by) any context
      # handle obtained from this RPC interface
      #
      # @param sam_handle [RubySMB::Dcerpc::Samr::SamprHandle] An RPC context
      #   handle to close
      # @return [RubySMB::Dcerpc::Samr::SamprHandle] A zero handle on success
      # @raise [RubySMB::Dcerpc::Error::InvalidPacket] if the response is not a
      #   SamrCloseHandle packet
      # @raise [RubySMB::Dcerpc::Error::SamrError] if the response error status
      #   is not STATUS_SUCCESS
      def close_handle(sam_handle)
        samr_close_handle_request = SamrCloseHandleRequest.new(sam_handle: sam_handle)
        response = dcerpc_request(samr_close_handle_request)
        begin
          samr_close_handle_response = SamrCloseHandleResponse.read(response)
        rescue IOError
          raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrCloseHandleResponse'
        end
        unless samr_close_handle_response.error_status == WindowsError::NTStatus::STATUS_SUCCESS
          raise RubySMB::Dcerpc::Error::SamrError,
            "Error returned with samr_connect: "\
            "#{WindowsError::NTStatus.find_by_retval(samr_close_handle_response.error_status.value).join(',')}"
        end
        samr_close_handle_response.sam_handle
      end

      # Returns the union of all aliases that a given set of SIDs is a member of.
      #
      # @param domain_handle [RubySMB::Dcerpc::Samr::SamprHandle] An RPC context
      #   representing a domain object.
      # @param sids [Array<RubySMB::Dcerpc::Samr::RpcSid>, RubySMB::Dcerpc::Samr::RpcSid] List of SID's
      # @return [Array<RubySMB::Dcerpc::Ndr::NdrUint32>] The union of all aliases represented by RID's
      # @raise [RubySMB::Dcerpc::Error::InvalidPacket] if the response is not a
      #   SamrGetAliasMembership packet
      # @raise [RubySMB::Dcerpc::Error::SamrError] if the response error status
      #   is not STATUS_SUCCESS
      def samr_get_alias_membership(domain_handle:, sids:)
        sids = [sids] unless sids.is_a?(::Array)
        samr_get_alias_membership_request = SamrGetAliasMembershipRequest.new(
          domain_handle: domain_handle
        )
        sids.each do |sid|
          samr_get_alias_membership_request.sid_array.sids << {sid_pointer: sid}
        end
        response = dcerpc_request(samr_get_alias_membership_request)
        begin
          samr_get_alias_membership_reponse= SamrGetAliasMembershipResponse.read(response)
        rescue IOError
          raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrGetAliasMembershipResponse'
        end
        unless samr_get_alias_membership_reponse.error_status == WindowsError::NTStatus::STATUS_SUCCESS
          raise RubySMB::Dcerpc::Error::SamrError,
            "Error returned while getting alias membership: "\
            "#{WindowsError::NTStatus.find_by_retval(samr_get_alias_membership_reponse.error_status.value).join(',')}"
        end
        return [] if samr_get_alias_membership_reponse.membership.element_count == 0
        samr_get_alias_membership_reponse.membership.elements.to_ary
      end

      # Returns a handle to a group, given a RID
      #
      # @param domain_handle [RubySMB::Dcerpc::Samr::SamprHandle] An RPC context
      #   representing a domain object
      # @param access [Integer] An access control that indicates the requested
      #   access for the returned handle. It is a bitwise OR of common
      #   ACCESS_MASK and user ACCESS_MASK values (see
      #   lib/ruby_smb/dcerpc/samr.rb)
      # @param group_id [Integer] RID of a group
      # @return [RubySMB::Dcerpc::Samr::SamprHandle] The group handle
      # @raise [RubySMB::Dcerpc::Error::InvalidPacket] if the response is not a
      #   SamrOpenGroup packet
      # @raise [RubySMB::Dcerpc::Error::SamrError] if the response error status
      #   is not STATUS_SUCCESS
      def samr_open_group(domain_handle:, access: MAXIMUM_ALLOWED, group_id:)
        samr_open_group_request = SamrOpenGroupRequest.new(
          domain_handle: domain_handle,
          desired_access: access,
          group_id: group_id
        )
        response = dcerpc_request(samr_open_group_request)
        begin
          samr_open_group_response = SamrOpenGroupResponse.read(response)
        rescue IOError
          raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrOpenGroupResponse'
        end
        unless samr_open_group_response.error_status == WindowsError::NTStatus::STATUS_SUCCESS
          raise RubySMB::Dcerpc::Error::SamrError,
            "Error returned when getting a handle to group #{group_id}: "\
            "#{WindowsError::NTStatus.find_by_retval(samr_open_grou_response.error_status.value).join(',')}"
        end
        samr_open_group_response.group_handle
      end

      # Returns a handle to a user, given a RID
      #
      # @param domain_handle [RubySMB::Dcerpc::Samr::SamprHandle] An RPC context
      #   representing a domain object
      # @param access [Integer] An access control that indicates the requested
      #   access for the returned handle. It is a bitwise OR of common
      #   ACCESS_MASK and user ACCESS_MASK values (see
      #   lib/ruby_smb/dcerpc/samr.rb)
      # @param user_id [Integer] RID of a user account
      # @return [RubySMB::Dcerpc::Samr::SamprHandle] The user handle
      # @raise [RubySMB::Dcerpc::Error::InvalidPacket] if the response is not a
      #   SamrOpenUser packet
      # @raise [RubySMB::Dcerpc::Error::SamrError] if the response error status
      #   is not STATUS_SUCCESS
      def samr_open_user(domain_handle:, access: MAXIMUM_ALLOWED, user_id:)
        samr_open_user_request = SamrOpenUserRequest.new(
          domain_handle: domain_handle,
          desired_access: access,
          user_id: user_id
        )
        response = dcerpc_request(samr_open_user_request)
        begin
          samr_open_user_response = SamrOpenUserResponse.read(response)
        rescue IOError
          raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrOpenUserResponse'
        end
        unless samr_open_user_response.error_status == WindowsError::NTStatus::STATUS_SUCCESS
          raise RubySMB::Dcerpc::Error::SamrError,
            "Error returned when getting a handle to user #{user_id}: "\
            "#{WindowsError::NTStatus.find_by_retval(samr_open_user_response.error_status.value).join(',')}"
        end
        samr_open_user_response.user_handle
      end

      # Returns a listing of members of the given group
      #
      # @param group_handle [RubySMB::Dcerpc::Samr::SamprHandle] An RPC context
      #   representing a group object.
      # @return [Array<Array<String,String>>] Array of RID and Attributes
      # @raise [RubySMB::Dcerpc::Error::InvalidPacket] if the response is not a
      #   SamrGetMembersInGroup packet
      # @raise [RubySMB::Dcerpc::Error::SamrError] if the response error status
      #   is not STATUS_SUCCESS
      def samr_get_members_in_group(group_handle:)
        samr_get_members_in_group_request = SamrGetMembersInGroupRequest.new(
          group_handle: group_handle
        )
        response = dcerpc_request(samr_get_members_in_group_request)
        begin
          samr_get_members_in_group_response = SamrGetMembersInGroupResponse.read(response)
        rescue IOError
          raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrGetMembersInGroupResponse'
        end
        unless samr_get_members_in_group_response.error_status == WindowsError::NTStatus::STATUS_SUCCESS
          raise RubySMB::Dcerpc::Error::SamrError,
            "Error returned while getting group membership: "\
            "#{WindowsError::NTStatus.find_by_retval(samr_get_members_in_group_response.error_status.value).join(',')}"
        end
        members = samr_get_members_in_group_response.members.members.to_ary
        attributes = samr_get_members_in_group_response.members.attributes.to_ary

        members.zip(attributes)
      end

      # Returns a listing of groups that a user is a member of
      #
      # @param user_handle [RubySMB::Dcerpc::Samr::SamprHandle] An RPC context
      #   representing a user object.
      # @return [Array<RubySMB::Dcerpc::Samr::GroupMembership>] Array of
      #   GroupMembership containing RID and Attributes
      # @raise [RubySMB::Dcerpc::Error::InvalidPacket] if the response is not a
      #   SamrGetGroupsForUser packet
      # @raise [RubySMB::Dcerpc::Error::SamrError] if the response error status
      #   is not STATUS_SUCCESS
      def samr_get_group_for_user(user_handle:)
        samr_get_groups_for_user_request = SamrGetGroupsForUserRequest.new(
          user_handle: user_handle
        )
        response = dcerpc_request(samr_get_groups_for_user_request)
        begin
          samr_get_groups_for_user_reponse= SamrGetGroupsForUserResponse.read(response)
        rescue IOError
          raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrGetGroupsForUserResponse'
        end
        unless samr_get_groups_for_user_reponse.error_status == WindowsError::NTStatus::STATUS_SUCCESS
          raise RubySMB::Dcerpc::Error::SamrError,
            "Error returned while getting user groups: "\
            "#{WindowsError::NTStatus.find_by_retval(samr_get_groups_for_user_reponse.error_status.value).join(',')}"
        end
        samr_get_groups_for_user_reponse.groups.groups.to_ary
      end

      # Returns domain information.
      #
      # @param domain_handle [RubySMB::Dcerpc::Samr::SamprHandle] An RPC context
      #   representing a domain object
      # @param info_class [Integer] The class of information to retrieve
      # @return [BinData::Choice] The requested information.
      def samr_query_information_domain(domain_handle:, info_class:)
        samr_request = SamrQueryInformationDomainRequest.new(
          domain_handle: domain_handle,
          domain_information_class: info_class
        )
        response = dcerpc_request(samr_request)
        begin
          samr_response = SamrQueryInformationDomainResponse.read(response)
        rescue IOError
          raise RubySMB::Dcerpc::Error::InvalidPacket, 'Error reading SamrQueryInformationDomainResponse'
        end
        unless samr_response.error_status == WindowsError::NTStatus::STATUS_SUCCESS
          raise RubySMB::Dcerpc::Error::SamrError,
            "Error returned while querying domain information: "\
            "#{WindowsError::NTStatus.find_by_retval(samr_response.error_status.value).join(',')}"
        end
        samr_response.buffer.buffer
      end
    end
  end
end
