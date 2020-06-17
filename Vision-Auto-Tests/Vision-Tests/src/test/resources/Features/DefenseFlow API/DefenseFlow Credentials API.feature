@TC106932
Feature: DefenseFlow Credentials API

  @SID_1
  Scenario: Clear logs
    Given CLI Clear vision logs

  @SID_2
  Scenario: Change DF credentials
    Then REST Request "POST" for "DefenseFlow->Change HTTPS Credentials"
      | type                 | value               |
      | body                 | httpsUsername=userN |
      | body                 | httpsPassword=passN |
      | Returned status code | 200                 |

  @SID_3
  Scenario: Validate DF credentials
#    Then CLI Run linux Command "mysql -prad123 vision_ng -e "select https_username,https_password from device_access where https_port='9101'\G" |head -2 |tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "https_username: userN"
    Then MYSQL Validate Single Value by SELECT "https_username" Column FROM "VISION_NG" Schema and "device_access" Table WHERE "https_port='9101'" EQUALS "userN"
#    Then CLI Run linux Command "mysql -prad123 vision_ng -e "select https_username,https_password from device_access where https_port='9101'\G" |head -3 |tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "https_password: passN"
    Then MYSQL Validate Single Value by SELECT "https_password" Column FROM "VISION_NG" Schema and "device_access" Table WHERE "https_port='9101'" EQUALS "passN"


  @SID_4
  Scenario: Setting config sync to active
    Then CLI Operations - Run Radware Session command "system config-sync interval set 1"
    Then CLI Operations - Run Radware Session command "system config-sync mode set active"

  @SID_5
  Scenario: Verify config-sync is using the new username
    Then Sleep "120"
    Then CLI Operations - Run Root Session command "clear"
    Then CLI Run linux Command "cat /opt/radware/storage/maintenance/logs/config.sync.log | grep "username"|tail -1|awk -F"password" '{print$1}'|awk -F"username " '{print$2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "userN" with runCommand delay 60

  @SID_6
  Scenario: Change DF credentials
    Then REST Request "POST" for "DefenseFlow->Change HTTPS Credentials"
      | type                 | value                 |
      | body                 | httpsUsername=radware |
      | body                 | httpsPassword=radware |
      | Returned status code | 200                   |

  @SID_7
  Scenario: Validate DF credentials
#    Then CLI Run linux Command "mysql -prad123 vision_ng -e "select https_username,https_password from device_access where https_port='9101'\G" |head -2 |tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "https_username: radware"
    Then MYSQL Validate Single Value by SELECT "https_username" Column FROM "VISION_NG" Schema and "device_access" Table WHERE "https_port='9101'" EQUALS "radware"

#    Then CLI Run linux Command "mysql -prad123 vision_ng -e "select https_username,https_password from device_access where https_port='9101'\G" |head -3 |tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "https_password: radware"
    Then MYSQL Validate Single Value by SELECT "https_password" Column FROM "VISION_NG" Schema and "device_access" Table WHERE "https_port='9101'" EQUALS "radware"

  @SID_8
  Scenario: Verify config-sync is using the new username
    Then Sleep "90"
    Then CLI Run linux Command "cat /opt/radware/storage/maintenance/logs/config.sync.log |grep "/rest/ha/view/registration-active"|tail -1|awk -F"timeout 10 " '{print$2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "username radware password ****"

  @SID_9
  Scenario: Cleanup
    Then CLI Operations - Run Radware Session command "system config-sync mode set disabled"
    Then CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
