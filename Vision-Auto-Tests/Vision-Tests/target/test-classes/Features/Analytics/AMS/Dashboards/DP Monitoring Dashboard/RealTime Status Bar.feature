@VRM @TC105996
Feature: VRM Real Time Status Bar Devices status

  @Sanity @SID_1
  Scenario: Devices status basic
    When CLI kill all simulator attacks on current vision
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    When CLI Clear vision logs
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    When UI Open Upper Bar Item "AMS"
    When UI Open "Dashboards" Tab
    When UI Open "DP Monitoring Dashboard" Sub Tab
# Validate correct number of DPs
    Then UI Text of "Device Status Up Summary" equal to "3"

    Then UI Text of "Device Status Maintenance Summary" equal to "0"
    Then UI Text of "Device Status Down Summary" equal to "0"
    Then UI Open "Configurations" Tab

  @SID_2
  Scenario: Devices status filter by device
  # Filter by device does not affect this widget
    When UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab
    Then UI Text of "Device Selection" equal to "DEVICES 3/3"
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then Sleep "2"
#   Validate correct number of DPs
    Then UI Text of "Device Selection" equal to "DEVICES 1/3"
    Then UI Text of "Device Status Up Summary" equal to "1"
    Then UI Text of "Device Status Maintenance Summary" equal to "0"
    Then UI Text of "Device Status Down Summary" equal to "0"
    Then UI Logout

  @SID_3
  Scenario: Devices status filter policy
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | BDOS     |
    Then Sleep "4"
    Then UI Text of "Device Selection" equal to "DEVICES 1/3"
    Then UI Text of "Device Status Up Summary" equal to "1"
    Then UI Text of "Device Status Maintenance Summary" equal to "0"
    Then UI Text of "Device Status Down Summary" equal to "0"
    Then UI Open "Configurations" Tab

#  Scenario: TC100762 Devices status disconnected DP by add device
#    Then UI Add "DefensePro" with index 31 on "FakeDPs_Old_Version_site" site nowait
#    # force this DP as ver 8
#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update software set version='8.17.0.0' where version='';"" on "ROOT_SERVER_CLI"
#    Then Sleep "110"
#    Then UI Open Upper Bar Item "AMS"
#    Then UI Open "Dashboards" Tab
#    Then UI Open "DP Monitoring Dashboard" Sub Tab
#    Then UI Text of "Device Selection" equal to "DefensePro (4 Devices)"
#    Then UI Text of "Device Status Up Summary" equal to "3 Devices"
#    Then UI Text of "Device Status Maintenance Summary" equal to "0 Devices"
#    Then UI Text of "Device Status Down Summary" equal to "1 Devices"
#
#  Scenario: Delete disconnected DP
#    Then UI Open "Configurations" Tab
#    Then UI Delete "DefensePro" device with index 31 from topology tree
#    Then Sleep "45"

  @SID_4
  Scenario: Devices status disconnected DP by route
    Then CLI Run remote linux Command "net route set host 172.16.22.55 172.17.3.3" on "Radware_SERVER_CLI"
    Then Sleep "120"
    Then UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab
    Then Sleep "3"
    Then UI Text of "Device Selection" equal to "DEVICES 3/3"
    Then UI Text of "Device Status Up Summary" equal to "2"
    Then UI Text of "Device Status Maintenance Summary" equal to "0"
    Then UI Text of "Device Status Down Summary" equal to "1"
    Then UI Open "Configurations" Tab

  @SID_5
  Scenario: Devices status connected DP by route
    Then CLI Run remote linux Command "net route delete 172.16.22.55 255.255.255.255 172.17.3.3" on "Radware_SERVER_CLI"
    Then Sleep "35"
    Then UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab
    Then UI Text of "Device Selection" equal to "DEVICES 3/3"
    Then UI Text of "Device Status Up Summary" equal to "3"
    Then UI Text of "Device Status Maintenance Summary" equal to "0"
    Then UI Text of "Device Status Down Summary" equal to "0"
    Then UI Open "Configurations" Tab

  @SID_6
  Scenario: Devices status disconnected Alteon
    When UI Add "Alteon" with index 30 on "Default" site nowait
    Then UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab
    Then Sleep "90"
# Validate correct number of DPs
    When UI Text of "Device Selection" equal to "DEVICES 3/3"
    When UI Text of "Device Status Maintenance Summary" equal to "0"
    When UI Text of "Device Status Down Summary" equal to "0"
    When UI Open "Configurations" Tab

  @SID_7
  Scenario: Delete disconnected Alteon
    Then UI Delete "Alteon" device with index 30 from topology tree
    Then Sleep "90"
    Then UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab
    Then UI Text of "Device Selection" equal to "DEVICES 3/3"
    Then UI Text of "Device Status Up Summary" equal to "3"
    Then UI Text of "Device Status Maintenance Summary" equal to "0"
    Then UI Text of "Device Status Down Summary" equal to "0"
    Then UI Logout

  @SID_8
  Scenario: Devices status RBAC
    When UI Login with user "sec_admin_all_pol" and password "radware"
  # user has permission only to one up DP
    Then UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab
    Then UI Text of "Device Selection" equal to "DEVICES 1/1"
    Then UI Text of "Device Status Up Summary" equal to "1"
    Then UI Text of "Device Status Maintenance Summary" equal to "0"
    Then UI Text of "Device Status Down Summary" equal to "0"
#    Then UI logout and close browser

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
