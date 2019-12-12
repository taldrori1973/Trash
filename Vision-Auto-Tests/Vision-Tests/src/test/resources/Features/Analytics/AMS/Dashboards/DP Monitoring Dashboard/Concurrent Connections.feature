@VRM @TC105990
Feature: AMS dashboard CONCURRENT CONNECTIONS


  @SID_1
  Scenario: Clean system data before concurrent connection test
    * CLI kill all simulator attacks on current vision
    Then CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    * REST Delete ES index "dp-concurre*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator PCAPs
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000 and wait 0 seconds
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 11 with loopDelay 15000 and wait 0 seconds
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 20 with loopDelay 15000 and wait 0 seconds
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 21 with loopDelay 15000 and wait 90 seconds

  @SID_3
  Scenario: VRM - Validate Dashboards "Concurrent Connections" Chart data for only DP version 8 machines
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Open Upper Bar Item "AMS"
    When UI Open "Dashboards" Tab
    And UI Open "DP Monitoring Dashboard" Sub Tab
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1m"
    Then UI Validate Line Chart data "Concurrent Connections" with Label "Concurrent Connections"
      | value  | count | offset |
      | 852074 | 4     | 2      |
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    Then UI Validate Line Chart data "Concurrent Connections" with Label "Concurrent Connections"
      | value  | count | offset |
      | 852074 | 8     | 4      |

  @SID_4
  Scenario: VRM - Validate Dashboards "Concurrent Connections" Chart data for one selected DP machine
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 11    |       |          |
    Then UI Validate Line Chart data "Concurrent Connections" with Label "Concurrent Connections"
      | value  | count | offset |
      | 426037 | 8     | 3      |

  @SID_5
  Scenario: VRM - Validate Dashboards "Concurrent Connections" Chart widget styling attributes
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "15m"
    And Sleep "2"
    Then UI Validate Line Chart attributes "Concurrent Connections" with Label "Concurrent Connections"
      | attribute             | value                   |
      | fill                  | true                    |
    # | lineTension           | 0.35                    |
      | borderCapStyle        | butt                    |
    # | borderDash            | []                      |
      | borderDashOffset      | 0                       |
      | borderJoinStyle       | miter                   |
      | borderWidth           | 2                       |
      | pointHoverRadius      | 4                       |
      | pointHoverBorderWidth | 1                       |
      | pointRadius           | 0                       |
      | pointHitRadius        | 0                       |
      | backgroundColor       | rgba(194, 218, 235, 0.5) |
      | hoverBackgroundColor  | rgba(194, 218, 235, 0.4) |
      | hoverBorderColor      | rgba(194, 218, 235, 5)   |
      | borderColor           | rgba(194, 218, 235, 5)   |

  @SID_6
  Scenario: VRM - Validate Dashboards "Concurrent Connections" filtered by policy

  @SID_7
  Scenario: Concurrent Connections Cleanup
    Given UI logout and close browser
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
