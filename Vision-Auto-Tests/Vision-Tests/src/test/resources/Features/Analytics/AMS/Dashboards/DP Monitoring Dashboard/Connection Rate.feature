@VRM @TC105991
Feature: CONNECTION RATE
  @SID_1
  Scenario: Clean system data before connection rate test
    * CLI kill all simulator attacks on current vision
    Then CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator PCAPs
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000 and wait 0 seconds
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 11 with loopDelay 15000 and wait 90 seconds

  @TC105991
  @SID_3
  Scenario:Login and Navigate to DP Monitoring Dashboard
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @SID_4
  Scenario: Validate Dashboards "Connections Rate" Widget data
    Then UI Validate Line Chart data "Connections Rate" with Label "Connections per Second"
      | value   | min |
      | 12670.0 | 1   |

  @TC105991
  @SID_5
  Scenario: Validate Max values for each attack
    Then UI Validate Text field "Max Button" with params "label-connections-rate" EQUALS "Max"
    Then UI Validate Text field "Max Button" with params "value-connections-rate" EQUALS "849"
    Then UI Click Button "Max Button" with value "value-connections-rate"
    Then UI Validate Table record values by columns with elementLabel "Top5 Table" findBy index 0
      | columnName  | value                   |
      | Device Name | DefensePro_172.16.22.50 |
      | Policy      | Policy150               |
      | Max         | 849                     |
    Then UI Validate Table record values by columns with elementLabel "Top5 Table" findBy index 1
      | columnName  | value                   |
      | Device Name | DefensePro_172.16.22.51 |
      | Policy      | Policy150               |
      | Max         | 849                     |
    Then UI Validate Table record values by columns with elementLabel "Top5 Table" findBy index 2
      | columnName  | value                   |
      | Device Name | DefensePro_172.16.22.50 |
      | Policy      | Policy14                |
      | Max         | 422                     |
    Then UI Validate Table record values by columns with elementLabel "Top5 Table" findBy index 3
      | columnName  | value                   |
      | Device Name | DefensePro_172.16.22.50 |
      | Policy      | Policy140               |
      | Max         | 422                     |
    Then UI Validate Table record values by columns with elementLabel "Top5 Table" findBy index 4
      | columnName  | value                   |
      | Device Name | DefensePro_172.16.22.50 |
      | Policy      | Policy16                |
      | Max         | 422                     |
    Then UI Click Button "Min Button Dialog"


  @SID_6
  Scenario: Validate Min values for each attack
    Then UI Validate Text field "Min Button" with params "label-connections-rate" EQUALS "Min"
    Then UI Validate Text field "Min Button" with params "value-connections-rate" EQUALS "0"
    Then UI Validate Table record values by columns with elementLabel "Top5 Table" findBy index 0
      | columnName  | value                   |
      | Device Name | DefensePro_172.16.22.50 |
      | Policy      | Policy14               |
      | Min         | 0                     |
    Then UI Validate Table record values by columns with elementLabel "Top5 Table" findBy index 1
      | columnName  | value                   |
      | Device Name | DefensePro_172.16.22.50 |
      | Policy      | Policy140               |
      | Min         | 0                     |
    Then UI Validate Table record values by columns with elementLabel "Top5 Table" findBy index 2
      | columnName  | value                   |
      | Device Name | DefensePro_172.16.22.50 |
      | Policy      | Policy16                |
      | Min         | 0                     |
    Then UI Validate Table record values by columns with elementLabel "Top5 Table" findBy index 3
      | columnName  | value                   |
      | Device Name | DefensePro_172.16.22.50 |
      | Policy      | Policy160               |
      | Min         | 0                     |
    Then UI Validate Table record values by columns with elementLabel "Top5 Table" findBy index 4
      | columnName  | value                   |
      | Device Name | DefensePro_172.16.22.50 |
      | Policy      | Policy17                |
      | Min         | 0                     |
    Then UI Click Button "Close Button" with value "connection-statistics"

  @SID_7
  Scenario: VRM - Validate Dashboards "Connections Rate" Chart data for 172.16.22.51
    Given UI Click Button "Device Selection"
    When UI Select device from dashboard device type "DefensePro"
      | index |
      | 11    |
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Validate Line Chart data "Connections Rate" with Label "Connections per Second"
      | value | min |
      | 6335  | 1   |

  @SID_8
  Scenario: VRM - Validate Dashboards "Concurrent Connections" Chart data for 172.16.22.50
    Given UI Click Button "Device Selection"
    When UI Select device from dashboard device type "DefensePro"
      | index |
      | 10    |
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Validate Line Chart data "Connections Rate" with Label "Connections per Second"
      | value | min |
      | 6335  | 1   |

  @SID_9
  Scenario: VRM - Validate Dashboards "Connections Rate" Chart widget styling attributes
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "15m"
    And Sleep "2"
    Then UI Validate Line Chart attributes "Connections Rate" with Label "Connections per Second"
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
    Then Validate Line Chart data "Connections Rate-DefensePro Analytics" with Label "Connections per Second" in report "Connection Rate Report"
      | value   | min |
      | 12670.0 | 1   |

  @SID_11
  Scenario: Connections rate Cleanup
    Given UI logout and close browser
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
