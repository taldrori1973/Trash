@TC110239
Feature: Actionable Black And White List

  @SID_1
  Scenario: Clean system data before "Protection Policies" test
    * CLI kill all simulator attacks on current vision
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"

    * REST Delete ES index "dp-*"

    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then REST Request "POST" for "Vdirect->Sync Devices"
      | type                 | value |
      | Returned status code | 200   |
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    * CLI Clear vision logs

  @SID_2
  Scenario: validate Black White List script exist in vision
    Then CLI Operations - Run Root Session command "find /opt/radware/storage/vdirect/database/templates/ -name "Add_Remove_Black_White_List_Entry8.vm"" timeout 60
    Then CLI Operations - Verify that output contains regex ".*Add_Remove_Black_White_List_Entry.*"

  @SID_3
  Scenario: run attacks
    Given CLI simulate 1000 attacks of type "baselines_pol_1_dynamic" on "DefensePro" 10 and wait 20 seconds

  @SID_4
  Scenario: Delete black white list if exist
    Then Rest Delete "black" List if exist with defensePro ip "172.16.22.51" and name of list "black_172.17.173.3"

  @SID_5
  Scenario: login and go to attack dashboard
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @SID_6
  Scenario: open attack actionable menu
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    And UI Click Button "blackWhiteListButton"

  @SID_7
  Scenario: fill black list actionable workflow
    When fill black white list
      | devices             | DefensePro_172.16.22.51 |
      | Run Under Attack    | true                    |
      | Entry prefix        | black                   |
      | Source IP           | 172.17.173.3            |
      | Source Port         | 22                      |
      | Destination IP      | 172.17.173.2            |
      | Destination Port    | 2012                    |
      | Black or White List | BLACK List              |

  @SID_8
  Scenario: Validate black list configuration in DP
    Then Rest Validate "black" List if exist with defensePro ip "172.16.22.51" and name of list "black_172.17.173.3"

  @SID_9
  Scenario: Delete black white list if exist
    Then Rest Delete "white" List if exist with defensePro ip "172.16.22.51" and name of list "white_172.17.173.3"
    Then Rest Delete "white" List if exist with defensePro ip "172.16.22.50" and name of list "white_172.17.173.3"

  @SID_10
  Scenario: Entering to the under attack policy
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy index 0
    And UI Click Button "blackWhiteListButtonUnder"

  @SID_11
  Scenario: fill white list actionable workflow
    When fill black white list
      | devices             | DefensePro_172.16.22.51 |
      | Run Under Attack    | false                   |
      | Entry prefix        | white                   |
      | Source IP           | 172.17.173.3            |
      | Source Port         | 22                      |
      | Destination IP      | 172.17.173.2            |
      | Destination Port    | 2012                    |
      | Black or White List | white List              |

  @SID_12
  Scenario: Validate white list configuration in DP
    Then Rest Validate "white" List if exist with defensePro ip "172.16.22.51" and name of list "white_172.17.173.3"
    Then Rest Validate "white" List if exist with defensePro ip "172.16.22.50" and name of list "white_172.17.173.3"

  @SID_13
  Scenario: Cleanup
    Then Rest Delete "black" List if exist with defensePro ip "172.16.22.51" and name of list "black_172.17.173.3"
    Then Rest Delete "white" List if exist with defensePro ip "172.16.22.51" and name of list "white_172.17.173.3"

    Given UI logout and close browser
    Then UI logout and close browser
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
