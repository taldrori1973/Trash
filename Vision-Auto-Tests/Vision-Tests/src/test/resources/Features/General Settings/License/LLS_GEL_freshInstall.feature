@TC111692
Feature: LLS_GEL_freshInstall

  @SID_1
  Scenario: FreshInstallIn parallel
    Then Fresh Install In Parallel

  @SID_2
  Scenario: verify lls service status is Not running
    Given CLI Run remote linux Command "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='16';"" on "ROOT_SERVER_CLI"
    Given CLI Run remote linux Command on Vision 2 "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='16';"" on "ROOT_SERVER_CLI"
    Given CLI Run remote linux Command on Vision 2 "echo 'cleared' $(date)|tee /opt/radware/storage/maintenance/logs/lls/lls_install_display.log" on "ROOT_SERVER_CLI"
    Then REST Login with activation with user "radware" and password "radware"
#    Then CLI Clear vision logs

  @SID_3
  Scenario: start lls service
    Then CLI LLS Service Start,with timeout 1000

  @SID_4
  Scenario: verify lls service status is running
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"
#    Then CLI Operations - Verify that output contains regex ".*BackOfficeURL: https://flex1336.flexnetoperations.com/flexnet/deviceservices*"

  @SID_43
  Scenario: validate main url is configured
    Then CLI LLS stanadlone validate URL in main Machine,timeout 30

  @SID_5
  Scenario: verify lls state is enabled
    When CLI Operations - Run Radware Session command "system lls state get"
    Then CLI Operations - Verify that output contains regex ".*LLS service is enabled.*"

  @SID_6
  Scenario: Validate LLS version
    Then CLI Run linux Command "cat /opt/radware/storage/llsinstall/license-server-*/version.txt" on "ROOT_SERVER_CLI" and validate result EQUALS "2.5.0-1"
    When CLI Operations - Run Radware Session command "system lls version"
    Then CLI Operations - Verify that output contains regex ".*2.5.0-1*"

  @SID_7
  Scenario: verify lls disable
    When CLI Operations - Run Radware Session command "system lls state disable"
    Then CLI Operations - Verify that output contains regex ".*Continue?.*\(y/n\).*"
    When CLI Operations - Run Radware Session command "y" timeout 600
    Then CLI Operations - Verify that output contains regex ".*Stopping Local License Server*"
    When CLI Operations - Run Radware Session command "system lls state get"
    Then CLI Operations - Verify that output contains regex ".*LLS service is disabled.*"

  @SID_8
  Scenario: verify lls enable
    When CLI Operations - Run Radware Session command "system lls state enable"
    Then CLI Operations - Verify that output contains regex ".*Continue?.*\(y/n\).*"
    When CLI Operations - Run Radware Session command "y" timeout 600
    Then CLI Operations - Verify that output contains regex ".*Starting Local License Server*"
    When CLI Operations - Run Radware Session command "system lls state get"
    Then CLI Operations - Verify that output contains regex ".*LLS service is enabled.*"

  @SID_9
  Scenario: verify lls service stop
    When CLI Operations - Run Radware Session command "system lls service stop"
    Then CLI Operations - Verify that output contains regex ".*Continue?.*\(y/n\).*"
    When CLI Operations - Run Radware Session command "y" timeout 600
    Then CLI Operations - Verify that output contains regex ".*Stopping Local License Server*"
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is stopped.*"

  @SID_10
  Scenario: verify lls service start
    Then CLI LLS Service Start,with timeout 780
    When CLI Operations - Run Radware Session command "system lls service status"
    Then CLI Operations - Verify that output contains regex ".*Local License Server is running.*"

  @SID_11
  Scenario: Check logs
    Then CLI Check if logs contains
      | logType | expression          | isExpected   |
      | LLS     | fatal\| error\|fail | NOT_EXPECTED |
      | LLS     | Setup complete!     | EXPECTED     |

#      | LLS     | Installation ended  | EXPECTED     |

  @SID_12
  Scenario: install lls UAT mode
#    Then CLI Set config sync mode to "DISABLED" with timeout 1000
    Then CLI Operations - Run Radware Session command "system config-sync mode set disabled" timeout 1300
    Then CLI LLS standalone install, "UAT" mode, timeout 1000

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

  @SID_44
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

  @SID_47
  Scenario: Add alteons to vision
    Then REST Login with activation with user "radware" and password "radware"
    Then REST Add "Alteon" Device To topology Tree with Name "172.17.141.17" and Management IP "172.17.141.17" into site "Default"
      | attribute | value |
    Then REST Add "Alteon" Device To topology Tree with Name "172.17.164.18" and Management IP "172.17.164.18" into site "Default"
      | attribute | value |

  @SID_17
  Scenario: ConfigSync set peer to main host
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

  @SID_45
  Scenario: validate main, backup URL's configured
    Then CLI LLS HA validate URL in "backup" machine,timeout 50
    Then CLI LLS HA validate URL in "main" machine,timeout 50
    ####### GEL Dashboard validation
  @SID_30
  Scenario: Login and navigate to GEL Dashboard
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "GEL Dashboard" page via homePage

  @SID_31
  Scenario: Activate License
    When UI Click Button "Activate License"
    Then UI Set Text Field "Activation ID" To "653b-fc33-8c2b-4b36-8190-0cd8-e4a1-8a16"
    Then UI Click Button "Activate button"
    Then Sleep "10"
    Then UI Validate Element Existence By Label "Entitlement Card" if Exists "true"

  @SID_32
  Scenario: Allocate License to Alteon
    Then UI Click Button "Entitlement Card"
    Then UI Click Button "Allocate"
    Then UI Click Button "Instance Select"
    Then UI Click Button "Instance" with value "172.17.164.18_/_172.17.164.18"
    Then UI Click Button "Select Throughput"
    Then UI Click Button "Throughput" with value "25_Mbps"
    Then UI Click Button "addon"
    Then UI Click Button "Activate button"

  @SID_33
  Scenario: Allocate License to Alteon
    Then UI Click Button "Entitlement Card"
    Then UI Click Button "Allocate"
    Then UI Click Button "Instance Select"
    Then UI Click Button "Instance" with value "172.17.141.17_/_172.17.141.17"
    Then UI Click Button "Select Throughput"
    Then UI Click Button "Throughput" with value "25_Mbps"
    Then UI Click Button "addon"
    Then UI Click Button "Activate button"


  @SID_34
  Scenario: validate instance added to table
#    Then UI Click Button "Entitlement Card"
    Then UI validate Table row by keyValue with elementLabel "instances table" findBy columnName "Instance Name" findBy cellValue "172.17.164.18"
    Then UI validate Table row by keyValue with elementLabel "instances table" findBy columnName "Instance Name" findBy cellValue "172.17.141.17"
    Then UI Validate "instances table" Table rows count EQUALS to 2

  @SID_35
  Scenario: validate entitlement license card updated
    Then UI Validate Text field "Instances" EQUALS "2/500"
    Then UI Validate Text field "throughput" EQUALS "0.05 Gbps"
    Then UI Validate Text field "addons" EQUALS "2/5"


  @SID_36
  Scenario: Deallocate instance, and validate instances table is updated
    Then UI Click Button "Entitlement Card"
    Then UI click Table row by keyValue or Index with elementLabel "instances table" findBy columnName "Instance Name" findBy cellValue "172.17.164.18"
    Then UI Click Button "deallocate"
    Then UI Click Button "Activate button"
    Then UI Validate "instances table" Table rows count EQUALS to 1
    Then UI validate Table row by keyValue with elementLabel "instances table" findBy columnName "Instance Name" findBy cellValue "172.17.141.17"

  @SID_37
  Scenario: Allocate License to Alteon after Deallocation
    Then UI Click Button "Entitlement Card"
    Then UI Click Button "Allocate"
    Then UI Click Button "Instance Select"
    Then UI Click Button "Instance" with value "172.17.164.18_/_172.17.164.18"
    Then UI Click Button "Select Throughput"
    Then UI Click Button "Throughput" with value "25_Mbps"
    Then UI Click Button "addon"
    Then UI Click Button "Activate button"

  @SID_38
  Scenario: validate instance added to table
#    Then UI Click Button "Entitlement Card"
    Then UI validate Table row by keyValue with elementLabel "instances table" findBy columnName "Instance Name" findBy cellValue "172.17.164.18"
    Then UI Validate "instances table" Table rows count EQUALS to 2

  @SID_39
  Scenario: Deallocate instance, and validate instances table is updated
    Then UI Click Button "Entitlement Card"
    Then UI click Table row by keyValue or Index with elementLabel "instances table" findBy columnName "Instance Name" findBy cellValue "172.17.164.18"
    Then UI Click Button "deallocate"
    Then UI Click Button "Activate button"
    Then UI Validate "instances table" Table rows count EQUALS to 1

  @SID_40
  Scenario: Deallocate instance, and validate instances table is updated
    Then UI Click Button "Entitlement Card"
    Then UI click Table row by keyValue or Index with elementLabel "instances table" findBy columnName "Instance Name" findBy cellValue "172.17.141.17"
    Then UI Click Button "deallocate"
    Then UI Click Button "Activate button"
    Then UI Validate "instances table" Table rows count EQUALS to 0

  @SID_41
  Scenario: validate license activated in the Peer machine.
    Then CLI LLS HA validate License Activation: "QA-Secure20Gbps", on the standby machine,timeout 1000

  @SID_42
  Scenario: DeActivate License
    Then UI Click Button "more button"
    Then UI Click Button "Remove Entitlement"
    Then UI Set Text Field "Activation ID" To "653b-fc33-8c2b-4b36-8190-0cd8-e4a1-8a16"
    Then UI Click Button "Activate button"
    Then Sleep "20"
    Then UI Validate Element Existence By Label "Entitlement Card" if Exists "false"


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

  @SID_46
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

  @SID_29
  Scenario: powerOff machines
    When CLI Run remote linux Command on "ROOT_SERVER_CLI" and wait for prompt "False"
      | "poweroff" |
    Given CLI Run remote linux Command on Vision 2 "poweroff" on "ROOT_SERVER_CLI"


