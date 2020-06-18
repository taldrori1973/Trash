@TC111664
Feature: LLS-GEL HA Installation
  @SID_1
  Scenario: Vision Upgrade
#    Then Revert Vision number 2 to "4.30.00-GA" snapshot
#    Then Prerequisite for Setup
    Then Revert Vision number 2 to snapshot
    Then Revert Vision number 1 to snapshot
    Then Upgrade in Parallel,backup&Restore setup

  @SID_2
  Scenario: Pre LLS Install
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
#    Given CLI Run remote linux Command "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='16';"" on "ROOT_SERVER_CLI"
    Given MYSQL UPDATE "lls_server" Table in "VISION_NG" Schema SET "min_required_ram" Column Value as 16 WHERE ""

#   kvision TODO HA
#    Given CLI Run remote linux Command on Vision 2 "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='16';"" on "ROOT_SERVER_CLI"
#    Given MYSQL UPDATE "lls_server" Table in "VISION_NG" Schema SET "min_required_ram" Column Value as 16 WHERE ""

    Given CLI Run remote linux Command on Vision 2 "echo 'cleared' $(date)|tee /opt/radware/storage/maintenance/logs/lls/lls_install_display.log" on "ROOT_SERVER_CLI"
    Then REST Login with user "radware" and password "radware"
    Then CLI Clear vision logs

  @SID_3
  Scenario: ConfigSync set peer to main host
    Then REST Login with user "radware" and password "radware"
    Given CLI Run remote linux Command on Vision 2 "echo 'cleared' $(date)|tee /opt/radware/storage/maintenance/logs/lls/lls_install_display.log" on "ROOT_SERVER_CLI"
    Then CLI Clear vision logs
    Then CLI Set config sync peer
    Then CLI Set config sync mode to "active" with timeout 1000

  @SID_4
  Scenario: ConfigSync set peer to backup host
    And CLI set target vision Host_2 "standby"
    And CLI Set host2 config sync peer

  @SID_5
  Scenario: LLS HA install UAT mode in backup machine
    Then CLI LLS HA backup install, "UAT" mode, timeout 1300

  @SID_6
  Scenario: LLS HA install UAT mode in main machine
    Then CLI LLS HA main install, "UAT" mode, timeout 1300

  @SID_7
  Scenario: verify lls service status is running after  HA UAT install
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"
    Then CLI Operations - Verify that output contains regex ".*BackOfficeURL: https://flex1336-uat.flexnetoperations.com/flexnet/deviceservices*"

  @SID_15
  Scenario: validate main, backup URL's configured
    Then CLI LLS HA validate URL in "backup" machine,timeout 50
    Then CLI LLS HA validate URL in "main" machine,timeout 50

  @SID_8
  Scenario: LLS HA install FNO mode in backup machine
    Given CLI Run remote linux Command on Vision 2 "echo 'cleared' $(date)|tee /opt/radware/storage/maintenance/logs/lls/lls_install_display.log" on "ROOT_SERVER_CLI"
    Then CLI Clear vision logs
    Then CLI LLS HA backup install, "FNO" mode, timeout 1300

  @SID_9
  Scenario: LLS HA install FNO mode in main machine
    Then CLI LLS HA main install, "FNO" mode, timeout 1300

  @SID_10
  Scenario: verify lls service status is running after  HA FNO install
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"
    Then CLI Operations - Verify that output contains regex ".*BackOfficeURL: https://flex1336.flexnetoperations.com/flexnet/deviceservices*"

  @SID_16
  Scenario: validate main, backup URL's configured
    Then CLI LLS HA validate URL in "backup" machine,timeout 50
    Then CLI LLS HA validate URL in "main" machine,timeout 50

  @SID_11
  Scenario: LLS HA install offline mode in backup machine
    Given CLI Run remote linux Command on Vision 2 "echo 'cleared' $(date)|tee /opt/radware/storage/maintenance/logs/lls/lls_install_display.log" on "ROOT_SERVER_CLI"
    Then CLI Clear vision logs
    Then CLI LLS HA backup install, "offline" mode, timeout 1300

  @SID_12
  Scenario: LLS HA install offline mode in main machine
    Then CLI LLS HA main install, "offline" mode, timeout 1300

  @SID_13
  Scenario: verify lls service status is running after  HA offline install
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"
    Then CLI Operations - Verify that output contains regex ".*BackOfficeURL: None*"


  @SID_14
  Scenario: revert back standby machine to be disabled
    Then CLI set target vision Host_2 "disabled"
#  @SID_22
#  Scenario: revert back requiered memmory
#    Given CLI Run remote linux Command "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='24';"" on "ROOT_SERVER_CLI"
#


