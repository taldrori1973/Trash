@TC111875
Feature: DefensePro Network Policy Export from Device

  @SID_1
  Scenario: Delete Network template if exists
    Given CLI Reset radware password
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_exported_file where name='auto_import';"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /download" on "ROOT_SERVER_CLI"
    Given REST Login with user "sys_admin" and password "radware"
    Given REST delete Policy "auto_import" from DP with Set "DefensePro_Set_2"

  @SID_2
  Scenario: Upload network policy to vision
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "nohup /home/radware/Scripts/upload_policy.sh " |
      | #visionIP                                         |
      | " /home/radware/Scripts/auto_import"              |

  @SID_3
  Scenario: Send network policy to DP index 11
    Then REST Request "POST" for "Vision DP Policies->Import Network Policy To DP"
      | type                 | value               |
#      | params               | OverrideExisting=on |
#      | params               | importToInstance=0  |
#      | params               | UpdatePolices=off   |
      | Returned status code | 200                 |
    Then Sleep "10"

  @SID_4
  Scenario: Delete network template from Vision server
#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_exported_file where name='auto_import';"" on "ROOT_SERVER_CLI"
    Then MYSQL DELETE FROM "device_exported_file" Table in "VISION_NG" Schema WHERE "name='auto_import'"

  @SID_5
  Scenario: Export Network Policy from DP to server
    Then REST Request "GET" for "Vision DP Policies->Export Network Policy From DP"
      | type                 | value                        |
#      | params               | PolicyName=auto_import       |
#      | params               | ExportConfiguration=on       |
#      | params               | ExportBaselineDNS=off        |
#      | params               | ExportBaselineBDoS=off       |
#      | params               | ExportBaselineHttpsFlood=off |
#      | params               | ExportSigUsrProf=off         |
#      | params               | ExportTrafficFiltersProf=off |
#      | params               | ExportAntiScanWhitelists=off |
#      | params               | saveToDb=true                |
#      | params               | fileName=auto_import         |
      | Returned status code | 200                          |

  @SID_6
  Scenario: Verify exported network policy exists in DB
#    Then CLI Run linux Command "mysql -prad123 vision_ng -BNe "select dev_type,file_type from device_exported_file where name='auto_import';"" on "ROOT_SERVER_CLI" and validate result EQUALS "DefensePro	1"
  Then MYSQL Validate FROM "device_exported_file" Table in "VISION_NG" Schema WHERE "name='auto_import'" Condition and values equal to "DefensePro	1"

  @SID_7
  Scenario: Export Network Policy from DP to Client
    When CLI Run remote linux Command "rm -f /home/radware/Scripts/policy_download" on "GENERIC_LINUX_SERVER"
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "nohup /home/radware/Scripts/download_policy.sh " |
      | #visionIP                                         |
      | " 172.16.22.51 auto_import"                       |

  @SID_8
  Scenario: Verify exported network policy content in client
    Then CLI Run linux Command "cat /home/radware/Scripts/policy_download|awk -F"dp policies-config table create " '{printf$2}'|awk '{print$1}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "auto_import"
