@VRM @TC105990
Feature: AMS dashboard CONCURRENT CONNECTIONS

  @SID_1
  Scenario: Clean system data before concurrent connection test
    * CLI kill all simulator attacks on current vision
    Then CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator PCAPs
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000 and wait 0 seconds
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 11 with loopDelay 15000 and wait 90 seconds


  @SID_3
  Scenario:Login and Navigate to DP Monitoring Dashboard
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage


  @SID_4
  Scenario: Validate Dashboards "Concurrent Connections" Chart data for 1m and 2m time range
    Then UI Validate Line Chart data "Concurrent Connections" with Label "Concurrent Connections"
      | value  | min |
      | 852074 | 1   |


  @SID_5
  Scenario: Validate Max values for each attack
    Then UI Validate Text field "Max Button" with params "label-concurrent-connections" EQUALS "Max"
    Then UI Validate Text field "Max Button" with params "value-concurrent-connections" EQUALS "426 K"
    Then UI Click Button "Max Button" with value "value-concurrent-connections"
    Then UI Validate Table record values by columns with elementLabel "Top5 Table" findBy index 0
      | columnName  | value                   |
      | Device Name | DefensePro_172.16.22.50 |
      | Policy      | All                     |
      | Max         | 425957                  |
    Then UI Validate Table record values by columns with elementLabel "Top5 Table" findBy index 1
      | columnName  | value                   |
      | Device Name | DefensePro_172.16.22.51 |
      | Policy      | All                     |
      | Max         | 425957                  |
    Then UI Click Button "Min Button Dialog"


  @SID_6
  Scenario: Validate Min values for each attack
    Then UI Validate Text field "Min Button" with params "label-concurrent-connections" EQUALS "Min"
    Then UI Validate Text field "Min Button" with params "value-concurrent-connections" EQUALS "80"
    Then UI Validate Table record values by columns with elementLabel "Top5 Table" findBy index 0
      | columnName  | value                   |
      | Device Name | DefensePro_172.16.22.50 |
      | Policy      | All                     |
      | Min         | 80                      |
    Then UI Validate Table record values by columns with elementLabel "Top5 Table" findBy index 1
      | columnName  | value                   |
      | Device Name | DefensePro_172.16.22.51 |
      | Policy      | All                     |
      | Min         | 80                      |
    Then UI Click Button "Close Button" with value "concurrent-connections"


  @SID_7
  Scenario: Validate Dashboards "Concurrent Connections" Chart data for 172.16.22.51
    Given UI Click Button "Device Selection"
    When UI Select device from dashboard device type "DefensePro"
      | index |
      | 11    |
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Validate Line Chart data "Concurrent Connections" with Label "Concurrent Connections"
      | value  | min |
      | 426037 | 1   |


  @SID_8
  Scenario: VRM - Validate Dashboards "Concurrent Connections" Chart data for 172.16.22.50
    Given UI Click Button "Device Selection"
    When UI Select device from dashboard device type "DefensePro"
      | index |
      | 10    |
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Validate Line Chart data "Concurrent Connections" with Label "Concurrent Connections"
      | value  | min |
      | 426037 | 1   |


  @SID_9
  Scenario: Validate Dashboards "Concurrent Connections" Chart widget styling attributes
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "15m"
    And Sleep "2"
    Then UI Validate Line Chart attributes "Concurrent Connections" with Label "Concurrent Connections"
      | attribute       | value   |
      | fill            | true    |
      | backgroundColor | #e9fbff |
      | borderColor     | #088eb1 |
      | borderWidth     | 1       |
      | pointHitRadius  | 3       |
      | pointRadius     | 0       |


  @SID_10
  Scenario: Validate Connection Rate chart in Reports
    And UI Navigate to "AMS Reports" page via homePage
    Then Validate Line Chart data "Concurrent Connections-DefensePro Analytics" with Label "Concurrent Connections" in report "Concurrent Connection Report"
      | value  | min |
      | 852074 | 1   |


  @SID_11
  Scenario: Concurrent Connections Cleanup
    Given UI logout and close browser
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
