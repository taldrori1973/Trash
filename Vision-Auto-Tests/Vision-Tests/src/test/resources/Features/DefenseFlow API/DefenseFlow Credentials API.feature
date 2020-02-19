@TC106932

Feature: DefenseFlow Credentials API

  @SID_1
  @run
  Scenario: Clear logs
    Given CLI Clear vision logs

  @SID_2
  @run
  Scenario: Change DF credentials
    Then REST Request "POST" for "DefenseFlow->Change HTTPS Credentials"
      | type                 | value               |
      | body                 | httpsUsername=userN |
      | body                 | httpsPassword=passN |
      | Returned status code | 200                 |

  @SID_3
  Scenario: Validate DF credentials
    Then CLI Run linux Command "mysql -prad123 vision_ng -e "select https_username,https_password from device_access where https_port='9101'\G" |head -2 |tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "https_username: userN"
    Then CLI Run linux Command "mysql -prad123 vision_ng -e "select https_username,https_password from device_access where https_port='9101'\G" |head -3 |tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "https_password: passN"

  @SID_4
  @run
  Scenario: Setting config sync to active
    Then CLI Operations - Run Radware Session command "system config-sync interval set 1"
    Then CLI Operations - Run Radware Session command "system config-sync mode set active"

  @SID_5
  Scenario: Verify config-sync is using the new username
    Then Sleep "120"
    Then CLI Operations - Run Root Session command "clear"
    Then CLI Run linux Command "cat /opt/radware/storage/maintenance/logs/config.sync.log |grep "/rest/ha/view/registration-active"|tail -1|awk -F"Authentication failed for " '{print$2}'|awk -F"\"" '{print$1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "username userN" with runCommand delay 60

  @SID_6
  Scenario: Change DF credentials
    Then REST Request "POST" for "DefenseFlow->Change HTTPS Credentials"
      | type                 | value                 |
      | body                 | httpsUsername=radware |
      | body                 | httpsPassword=radware |
      | Returned status code | 200                   |

  @SID_7
  Scenario: Validate DF credentials
    Then CLI Run linux Command "mysql -prad123 vision_ng -e "select https_username,https_password from device_access where https_port='9101'\G" |head -2 |tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "https_username: radware"
    Then CLI Run linux Command "mysql -prad123 vision_ng -e "select https_username,https_password from device_access where https_port='9101'\G" |head -3 |tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "https_password: radware"

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
