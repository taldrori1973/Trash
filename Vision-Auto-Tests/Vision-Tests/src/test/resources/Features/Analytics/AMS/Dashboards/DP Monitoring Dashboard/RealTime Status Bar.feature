@VRM @TC105996
Feature: VRM Real Time Status Bar Devices status

  @Sanity @SID_1
  Scenario: Devices status basic
    When CLI kill all simulator attacks on current vision
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    When CLI Clear vision logs
    Given CLI Reset radware password
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
# Validate correct number of DPs
    Then UI Text of "Device Status Up Summary" equal to "3"

    Then UI Text of "Device Status Maintenance Summary" equal to "0"
    Then UI Text of "Device Status Down Summary" equal to "0"
    Then UI Navigate to "VISION SETTINGS" page via homePage

#    DE57930
  @SID_2
  Scenario: Devices status filter by device
  # Filter by device does not affect this widget
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Text of "Device Selection" equal to "DEVICES3/3"
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | setId | ports | policies |
      | DefensePro_Set_1    |       |          |
    Then Sleep "2"
#   Validate correct number of DPs
    Then UI Text of "Device Selection" equal to "DEVICES1/3"
    Then UI Text of "Device Status Up Summary" equal to "3"
    Then UI Text of "Device Status Maintenance Summary" equal to "0"
    Then UI Text of "Device Status Down Summary" equal to "0"
    Then UI Logout

#  DE57930
  @SID_3
  Scenario: Devices status filter policy
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | setId | ports | policies |
      | DefensePro_Set_1    |       | BDOS     |
    Then Sleep "4"
    Then UI Text of "Device Selection" equal to "DEVICES1/3"
    Then UI Text of "Device Status Up Summary" equal to "3"
    Then UI Text of "Device Status Maintenance Summary" equal to "0"
    Then UI Text of "Device Status Down Summary" equal to "0"
    Then UI Navigate to "VISION SETTINGS" page via homePage

#  DE57014
  @SID_4
  Scenario: Devices status disconnected DP by route
    Then CLI Run remote linux Command "net route set host 172.16.22.25 172.17.3.3" on "Radware_SERVER_CLI"
    Then Sleep "120"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then Sleep "3"
    Then UI Text of "Device Selection" equal to "DEVICES1/3"
    Then UI Text of "Device Status Up Summary" equal to "2"
    Then UI Text of "Device Status Maintenance Summary" equal to "0"
    Then UI Text of "Device Status Down Summary" equal to "1"
    Then UI Navigate to "VISION SETTINGS" page via homePage
    Then CLI Run remote linux Command "net route delete 172.16.22.25 255.255.255.255 172.17.3.3" on "Radware_SERVER_CLI"
    Then Sleep "35"

#    DE57014
  @SID_5
  Scenario: Devices status connected DP by route
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Text of "Device Selection" equal to "DEVICES1/3"
    Then UI Text of "Device Status Up Summary" equal to "3"
    Then UI Text of "Device Status Maintenance Summary" equal to "0"
    Then UI Text of "Device Status Down Summary" equal to "0"
    Then UI Navigate to "VISION SETTINGS" page via homePage

  @SID_6
  Scenario: Devices status disconnected Alteon
#   When UI Add "Alteon" with index 30 on "Default" site nowait
    Then UI Add "Alteon_Set_1" under "Default" site
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then Sleep "90"
# Validate correct number of DPs
    Then UI Text of "Device Selection" equal to "DEVICES3/3"
    Then UI Text of "Device Status Up Summary" equal to "3"
    Then UI Text of "Device Status Maintenance Summary" equal to "0"
    Then UI Text of "Device Status Down Summary" equal to "0"
    Then UI Navigate to "VISION SETTINGS" page via homePage

  @SID_7
  Scenario: Delete disconnected Alteon
#   Then UI Delete "Alteon" device with index 30 from topology tree
    Then UI Delete "Alteon_Set_1" from topology tree
    Then Sleep "90"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Text of "Device Selection" equal to "DEVICES3/3"
    Then UI Text of "Device Status Up Summary" equal to "3"
    Then UI Text of "Device Status Maintenance Summary" equal to "0"
    Then UI Text of "Device Status Down Summary" equal to "0"
    Then UI Logout

#  DE57898
  @SID_8
  Scenario: Devices status RBAC
    When UI Login with user "sec_admin_all_pol" and password "radware"
  # user has permission only to one up DP
    Then UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Text of "Device Selection" equal to "DEVICES1/1"
    Then UI Text of "Device Status Up Summary" equal to "1"
    Then UI Text of "Device Status Maintenance Summary" equal to "0"
    Then UI Text of "Device Status Down Summary" equal to "0"
#    Then UI logout and close browser

#    DE57898
  @SID_9
  Scenario: Devices status check logs
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal        | NOT_EXPECTED |

  @Sanity @SID_10
  Scenario: cleanup
    * UI logout and close browser
    * CLI kill all simulator attacks on current vision

#      END DEVICES STATUS
