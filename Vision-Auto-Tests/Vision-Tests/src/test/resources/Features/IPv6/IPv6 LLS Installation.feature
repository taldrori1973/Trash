@TC111604
Feature: IPv6 LLS-GEL Installation
  @SID_1
  Scenario: verify lls service status is Not running
    Given CLI Reset radware password
    Given CLI Run remote linux Command "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='16';"" on "ROOT_SERVER_CLI"
    Then REST Login with user "radware" and password "radware"
    Then CLI Set config sync mode to "disabled" with timeout 1000
    Then CLI Clear vision logs

  @SID_2
  Scenario: start lls service
    Then CLI LLS Service Start,with timeout 780

  @SID_3
  Scenario: verify lls service status is running
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"

  @SID_4
  Scenario: verify lls state is enabled
    When CLI Operations - Run Radware Session command "system lls state get"
    Then CLI Operations - Verify that output contains regex ".*LLS service is enabled.*"

  @SID_5
  Scenario: Validate LLS version
    Then CLI Run linux Command "cat /opt/radware/storage/llsinstall/license-server-*/version.txt" on "ROOT_SERVER_CLI" and validate result EQUALS "2.5.0-1"
    When CLI Operations - Run Radware Session command "system lls version"
    Then CLI Operations - Verify that output contains regex ".*2.5.0-1*"

  @SID_6
  Scenario: verify lls disable
    When CLI Operations - Run Radware Session command "system lls state disable"
    Then CLI Operations - Verify that output contains regex ".*Continue?.*\(y/n\).*"
    When CLI Operations - Run Radware Session command "y" timeout 600
    Then CLI Operations - Verify that output contains regex ".*Stopping Local License Server*"
    When CLI Operations - Run Radware Session command "system lls state get"
    Then CLI Operations - Verify that output contains regex ".*LLS service is disabled.*"

  @SID_7
  Scenario: verify lls enable
    When CLI Operations - Run Radware Session command "system lls state enable"
    Then CLI Operations - Verify that output contains regex ".*Continue?.*\(y/n\).*"
    When CLI Operations - Run Radware Session command "y" timeout 600
    Then CLI Operations - Verify that output contains regex ".*Starting Local License Server*"
    When CLI Operations - Run Radware Session command "system lls state get"
    Then CLI Operations - Verify that output contains regex ".*LLS service is enabled.*"

  @SID_8
  Scenario: verify lls service stop
    When CLI Operations - Run Radware Session command "system lls service stop"
    Then CLI Operations - Verify that output contains regex ".*Continue?.*\(y/n\).*"
    When CLI Operations - Run Radware Session command "y" timeout 600
    Then CLI Operations - Verify that output contains regex ".*Stopping Local License Server*"
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is stopped.*"

  @SID_9
  Scenario: verify lls service start
    Then CLI LLS Service Start,with timeout 780
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"

  @SID_10
  Scenario: install lls UAT mode
    Then CLI Operations - Run Radware Session command "system config-sync mode set disabled" timeout 1000
    Then CLI LLS standalone install, "UAT" mode, timeout 1500

  @SID_11
  Scenario: verify lls service status is running after UAT install
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"
    Then CLI Operations - Verify that output contains regex ".*BackOfficeURL: https://radware-uat.flexnetoperations.com/flexnet/deviceservices*"

  @SID_12
  Scenario: install lls offline mode
    Then CLI LLS standalone install, "offline" mode, timeout 1000

#  @SID_13
    Then CLI LLS Service Start,with timeout 780
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"


  @SID_14
  Scenario: verify lls service status is running after offline install
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"
    Then CLI Operations - Verify that output contains regex ".*BackOfficeURL: None*"

  @SID_15
  Scenario: revert back to requiered RAM
    Given CLI Run remote linux Command "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='24';"" on "ROOT_SERVER_CLI"

  @SID_16
  Scenario: Check logs
    Then CLI Check if logs contains
      | logType | expression          | isExpected   |
      | LLS     | fatal\| error\|fail | NOT_EXPECTED |
      | LLS     | Setup complete!     | EXPECTED     |
