@TC111447
Feature: LLS-GEL Installation

  @SID_1
  Scenario: verify lls service status is Not running
#    When CLI Operations - Run Radware Session command "system lls service status"
#    Then CLI Operations - Verify that output contains regex ".*LLS service is disabled.*"
#    Then Revert Vision number 1 to "4.40.00-GA" snapshot
#    Then Revert Vision number 2 to "4.40.00-GA" snapshot
    Given CLI Run remote linux Command "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='16';"" on "ROOT_SERVER_CLI"
    Given CLI Run remote linux Command on Vision 2 "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='16';"" on "ROOT_SERVER_CLI"
    Given CLI Run remote linux Command on Vision 2 "echo 'cleared' $(date)|tee /opt/radware/storage/maintenance/logs/lls/lls_install_display.log" on "ROOT_SERVER_CLI"
    Then REST Login with user "radware" and password "radware"
    Then CLI Clear vision logs

  @SID_2
  Scenario: start lls service
    Then CLI LLS Service Start,with timeout 1300

  @SID_3
  Scenario: verify lls service status is running
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"
#    Then CLI Operations - Verify that output contains regex ".*BackOfficeURL: https://flex1336.flexnetoperations.com/flexnet/deviceservices*"

  @SID_4
  Scenario: verify lls state is enabled
    When CLI Operations - Run Radware Session command "system lls state get"
    Then CLI Operations - Verify that output contains regex ".*LLS service is enabled.*"

  @SID_5
  Scenario: Validate LLS version
    Then CLI Run linux Command "cat /opt/radware/storage/llsinstall/license-server-*/version.txt" on "ROOT_SERVER_CLI" and validate result EQUALS "2.4.0-2"
    When CLI Operations - Run Radware Session command "system lls version"
    Then CLI Operations - Verify that output contains regex ".*2.4.0-2*"

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
    Then CLI LLS Service Start,with timeout 1300
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"

  @SID_10
  Scenario: Check logs
    Then CLI Check if logs contains
      | logType | expression          | isExpected   |
      | LLS     | fatal\| error\|fail | NOT_EXPECTED |
      | LLS     | Setup complete!     | EXPECTED     |

#      | LLS     | Installation ended  | EXPECTED     |

  @SID_29
  Scenario: validate main url is configured
    Then CLI LLS stanadlone validate URL in main Machine,timeout 30

  @SID_33
  Scenario:
    Then CLI Set config sync mode to "disabled" with timeout 1000

  @SID_11
  Scenario: install lls UAT mode
#    Then CLI Set config sync mode to "DISABLED" with timeout 1000
    Then CLI Operations - Run Radware Session command "system config-sync mode set disabled" timeout 1000
    Then CLI LLS standalone install, "UAT" mode, timeout 1500

#  @SID_12
#  Scenario: start lls service UAT
#    Then CLI LLS Service Start,with timeout 780
#    When CLI Operations - Run Radware Session command "system lls service status"
#    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"

  @SID_13
  Scenario: verify lls service status is running after UAT install
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"
    Then CLI Operations - Verify that output contains regex ".*BackOfficeURL: https://flex1336-uat.flexnetoperations.com/flexnet/deviceservices*"

  @SID_30
  Scenario: validate main url is configured after UAT stnadalone installation
    Then CLI LLS stanadlone validate URL in main Machine,timeout 30

  @SID_14
  Scenario: install lls offline mode
    Then CLI LLS standalone install, "offline" mode, timeout 1000

#  @SID_15
#  Scenario: start lls service offline
    Then CLI LLS Service Start,with timeout 780
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"


  @SID_16
  Scenario: verify lls service status is running after offline install
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"
    Then CLI Operations - Verify that output contains regex ".*BackOfficeURL: None*"

  @SID_17
  Scenario: ConfigSync set peer to main host
    Then REST Login with user "radware" and password "radware"
    Given CLI Run remote linux Command on Vision 2 "echo 'cleared' $(date)|tee /opt/radware/storage/maintenance/logs/lls/lls_install_display.log" on "ROOT_SERVER_CLI"
    Then CLI Clear vision logs
    Then CLI Set config sync peer
    Then CLI Set config sync mode to "active" with timeout 1000

  @SID_18
  Scenario: ConfigSync set peer to backup host
    And CLI set target vision Host_2 "standby"
    And CLI Set host2 config sync peer

  @SID_19
  Scenario: LLS HA install UAT mode in backup machine
    Then CLI LLS HA backup install, "UAT" mode, timeout 1300

  @SID_20
  Scenario: LLS HA install UAT mode in main machine
    Then CLI LLS HA main install, "UAT" mode, timeout 1300

  @SID_21
  Scenario: verify lls service status is running after  HA UAT install
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"
    Then CLI Operations - Verify that output contains regex ".*BackOfficeURL: https://flex1336-uat.flexnetoperations.com/flexnet/deviceservices*"

  @SID_31
  Scenario: validate main, backup URL's configured
    Then CLI LLS HA validate URL in "backup" machine,timeout 50
    Then CLI LLS HA validate URL in "main" machine,timeout 50

  @SID_22
  Scenario: LLS HA install FNO mode in backup machine
    Given CLI Run remote linux Command on Vision 2 "echo 'cleared' $(date)|tee /opt/radware/storage/maintenance/logs/lls/lls_install_display.log" on "ROOT_SERVER_CLI"
    Then CLI Clear vision logs
    Then CLI LLS HA backup install, "FNO" mode, timeout 1300

  @SID_23
  Scenario: LLS HA install FNO mode in main machine
    Then CLI LLS HA main install, "FNO" mode, timeout 1300

  @SID_24
  Scenario: verify lls service status is running after  HA FNO install
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"
    Then CLI Operations - Verify that output contains regex ".*BackOfficeURL: https://flex1336.flexnetoperations.com/flexnet/deviceservices*"

  @SID_32
  Scenario: validate main, backup URL's configured
    Then CLI LLS HA validate URL in "backup" machine,timeout 50
    Then CLI LLS HA validate URL in "main" machine,timeout 50

  @SID_25
  Scenario: LLS HA install offline mode in backup machine
    Given CLI Run remote linux Command on Vision 2 "echo 'cleared' $(date)|tee /opt/radware/storage/maintenance/logs/lls/lls_install_display.log" on "ROOT_SERVER_CLI"
    Then CLI Clear vision logs
    Then CLI LLS HA backup install, "offline" mode, timeout 1300

  @SID_26
  Scenario: LLS HA install offline mode in main machine
    Then CLI LLS HA main install, "offline" mode, timeout 1300

  @SID_27
  Scenario: verify lls service status is running after  HA offline install
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"
    Then CLI Operations - Verify that output contains regex ".*BackOfficeURL: None*"


  @SID_28
  Scenario: revert back standby machine to be disabled
    Then CLI set target vision Host_2 "disabled"
#  @SID_22
#  Scenario: revert back requiered memmory
#    Given CLI Run remote linux Command "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='24';"" on "ROOT_SERVER_CLI"
#


