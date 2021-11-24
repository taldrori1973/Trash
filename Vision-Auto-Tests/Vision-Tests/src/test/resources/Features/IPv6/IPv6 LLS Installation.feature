@TC111604
Feature: IPv6 LLS-GEL Installation
  @SID_1
  Scenario: verify lls service status is Not running
    Given CLI Reset radware password
#    Given CLI Run remote linux Command "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='16';"" on "ROOT_SERVER_CLI"
    Given MYSQL UPDATE "lls_server" Table in "vision_ng" Schema SET "min_required_ram" Column Value as 16 WHERE ""
    Then REST Login with user "radware" and password "radware"
    Then CLI Set config sync mode to "disabled" with timeout 1000
    Then CLI Clear vision logs

  @SID_2
  Scenario: start lls service
    Then CLI LLS Service Start,with timeout 780

  @SID_4
  Scenario: verify lls state is enabled
    When CLI Operations - Run Radware Session command "system lls state get"
    Then CLI Operations - Verify that output contains regex ".*LLS service is enabled.*"

  @SID_5
  Scenario: Validate LLS version
    When CLI Operations - Run Radware Session command "system lls version"
    Then CLI Operations - Verify that output contains regex ".* 2.6.0*"

  @SID_6
  Scenario: verify lls disable
    Then CLI LLS SET State "disable" with timeout 300

  @SID_7
  Scenario: verify lls enable
    Then CLI LLS SET State "enable" with timeout 300

  @SID_8
  Scenario: verify lls service stop
    When CLI LLS Service Stop with timeout 720

  @SID_9
  Scenario: verify lls service start
    Then CLI LLS Service Start,with timeout 780

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
    Given MYSQL UPDATE "lls_server" Table in "vision_ng" Schema SET "min_required_ram" Column Value as 24 WHERE ""

  @SID_16
  Scenario: Check logs
    Then CLI Check if logs contains
      | logType | expression          | isExpected   |
      | LLS     | fatal\| error\|fail | NOT_EXPECTED |
      | LLS     | Setup complete! | EXPECTED     |
