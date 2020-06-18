@TC111874
Feature: DefensePro Network Policy Upload to Server

  @SID_1
  Scenario: Delete Network template from vision if exists
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_exported_file where name='auto_import';"" on "ROOT_SERVER_CLI"
    Then MYSQL DELETE FROM "device_exported_file" Table in "VISION_NG" Schema WHERE "name='auto_import'"
    Then CLI copy "/home/radware/Scripts/Delete_network_Policy.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then CLI copy "/home/radware/Scripts/Download_network_Template.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then CLI Run remote linux Command "rm -f /download" on "ROOT_SERVER_CLI"

  @SID_2
  Scenario: Upload network policy to vision
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "nohup /home/radware/Scripts/upload_policy.sh " |
      | #visionIP                                       |
      | " /home/radware/Scripts/auto_import"            |

  @SID_3
  Scenario: Verify Network policy in vision
#    Then CLI Run linux Command "mysql -prad123 vision_ng -BNe "select dev_type,file_type from device_exported_file where name='auto_import';"" on "ROOT_SERVER_CLI" and validate result EQUALS "DefensePro	1"
    Then MYSQL Validate Single Value by SELECT "dev_type" Column FROM "VISION_NG" Schema and "device_exported_file" Table WHERE "name='auto_import'" EQUALS "DefensePro"
    Then MYSQL Validate Single Value by SELECT "file_type" Column FROM "VISION_NG" Schema and "device_exported_file" Table WHERE "name='auto_import'" EQUALS 1

    Then REST Request "GET" for "Vision DP Policies->Network Policies Table"
      | type                 | value                                            |
      | params               | filter=name:auto_import                          |
      | result               | "name":"auto_import"                             |
      | result               | "deviceName":"local"                             |
      | result               | "deviceType":"DefensePro"                        |
      | result               | "exportedFileType":"NETWORK_PROTECTION_TEMPLATE" |
      | Returned status code | 200                                              |

  @SID_4
  Scenario: Download network policy from vision server
    Then CLI Run remote linux Command "/Download_network_Template.sh device_exported_file auto_import" on "ROOT_SERVER_CLI" with timeOut 30

  @SID_5
  Scenario: Verify content of downloaded file
    Then CLI Run linux Command "cat /download|awk -F"dp policies-config table create " '{printf$2}'|awk '{print$1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "auto_import"

  @SID_6
  Scenario: Delete Network policy from vision
    Then CLI Run linux Command "/Delete_network_Policy.sh device_exported_file auto_import" on "ROOT_SERVER_CLI" and validate result CONTAINS ""status":"ok"" in any line with timeOut 5

  @SID_7
  Scenario: Verify Network policy deleted in vision
#    Then CLI Run linux Command "mysql -prad123 vision_ng -BNe "select count(*) from device_exported_file where name='auto_import';"" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then MYSQL Validate Number of Records FROM "device_exported_file" Table in "VISION_NG" Schema WHERE "name='auto_import'" Condition Applies EQUALS 0
