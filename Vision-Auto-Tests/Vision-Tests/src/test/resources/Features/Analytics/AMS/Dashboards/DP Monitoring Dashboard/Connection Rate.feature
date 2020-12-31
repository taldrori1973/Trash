@VRM @TC105991
Feature: CONNECTION RATE

  @SID_1
  Scenario: Clean system data before connection rate test
    * CLI kill all simulator attacks on current vision
    Then CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    * REST Delete ES index "dp-traffic-*"
    * REST Delete ES index "dp-https-stats-*"
    * REST Delete ES index "dp-https-rt-*"
    * REST Delete ES index "dp-five-*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator PCAPs
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000 and wait 0 seconds
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 11 with loopDelay 15000 and wait 0 seconds
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 20 with loopDelay 15000 and wait 0 seconds
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 21 with loopDelay 15000 and wait 60 seconds

  @SID_3
  Scenario: VRM - Validate Dashboards "Connections Rate" Widget data for only DP version 8 machines
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1m"
    Then UI Validate Line Chart data "Connections Rate" with Label "Connections per Second"
      | value | min |
      | 12670 | 1   |

  @SID_4
  Scenario: VRM - Validate Dashboards "Connections Rate" Chart data for one selected DP machine
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Validate Line Chart data "Connections Rate" with Label "Connections per Second"
      | value | min |
      | 6335  | 1   |

  @SID_5
  Scenario: VRM - Validate Dashboards "Connections Rate" Chart widget styling attributes
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "15m"
    And Sleep "2"
    Then UI Validate Line Chart attributes "Connections Rate" with Label "Connections per Second"
      | attribute             | value                    |
      | fill                  | true                     |
  #   | lineTension           | 0.35                    |
      | borderCapStyle        | butt                     |
  #   | borderDash            | []                      |
      | borderDashOffset      | 0                        |
      | borderJoinStyle       | miter                    |
      | borderWidth           | 2                        |
      | pointHoverRadius      | 4                        |
      | pointHoverBorderWidth | 1                        |
      | pointRadius           | 0                        |
      | pointHitRadius        | 0                        |
      | backgroundColor       | rgba(194, 218, 235, 0.5) |
      | hoverBackgroundColor  | rgba(194, 218, 235, 0.4) |
      | hoverBorderColor      | rgba(194, 218, 235, 5)   |
      | borderColor           | rgba(194, 218, 235, 5)   |

  @SID_6
  Scenario: Connections rate Cleanup
    Given UI logout and close browser
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
