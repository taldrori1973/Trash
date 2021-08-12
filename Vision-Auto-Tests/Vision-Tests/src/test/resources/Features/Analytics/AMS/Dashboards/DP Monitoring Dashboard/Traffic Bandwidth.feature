@VRM @TC105997

Feature: AMS main dashboard Traffic Bandwidth

  @Dev_Sanity @SID_1
  Scenario: Clean system data before Traffic Bandwidth test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-tr*"
    * CLI Clear vision logs

  @Shay_DP @SID_2
  @Dev_Sanity
  Scenario: Run DP simulator PCAPs for Traffic Bandwidth
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 11 with loopDelay 15000
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 20 with loopDelay 15000
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 21 with loopDelay 15000 and wait 120 seconds

  @Dev_Sanity @SID_3
  Scenario: Login and navigate to VRM
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "2"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @Dev_Sanity @SID_4
  Scenario: VRM - Validate Dashboards "Traffic Bandwidth" Widget data for only DP version 8 machines
    When Sleep "1"
    Given UI Do Operation "Select" item "Global Time Filter"
    Then Sleep "1"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value   | count | offset |
      | 1459480 | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value   | count | offset |
      | 1027638 | 8     | 2      |
#    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value   | count | offset |
      | 1459480 | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value   | count | offset |
      | 1027638 | 8     | 2      |
    #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset |
      | 40000 | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset |
      | 0     | 8     | 2      |
    #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset |
      | 20000 | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset |
      | 0     | 8     | 2      |
    #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value    | count | offset |
      | 11157622 | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value   | count | offset |
      | 1035926 | 8     | 2      |
    #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |

  @SID_5
  Scenario: VRM - Validate Dashboards "Traffic Bandwidth" Chart data for one selected DP machine
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value   | count | offset |
      | 5578811 | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value  | count | offset |
      | 517963 | 8     | 2      |
    #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset |
      | 10000 | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset |
      | 0     | 8     | 2      |
    #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value  | count | offset |
      | 729740 | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value  | count | offset |
      | 513819 | 8     | 2      |
    #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset |
      | 20000 | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset |
      | 0     | 8     | 2      |
    #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |

  @SID_6
  Scenario: VRM - Validate Dashboards "Traffic Bandwidth" Chart data for one selected DP machine filtered by ports
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 3,4   |          |
    Then UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset |
      | 0     | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset |
      | 0     | 8     | 2      |
    #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    Then UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset |
      | 0     | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset |
      | 0     | 8     | 2      |
    #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset |
      | 20000 | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset |
      | 0     | 8     | 2      |
        #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset |
      | 10000 | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset |
      | 0     | 8     | 2      |
    #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |

  @SID_7
  Scenario: VRM - Validate Dashboards "Traffic Bandwidth" Chart data for one selected DP machine filtered by policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | Policy15 |
    Then UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Click Button "Accessibility Open Menu"
    Then UI Click Button "Accessibility Close"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset |
      | null  | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset |
      | null  | 8     | 2      |
        #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value  | count | offset |
      | 229813 | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value  | count | offset |
      | 115568 | 8     | 2      |
        #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Click Button "Accessibility Open Menu"
    Then UI Click Button "Accessibility Close"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset |
      | null  | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset |
      | null  | 8     | 2      |
        #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset |
      | 7473  | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset |
      | 4190  | 8     | 2      |
        #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |

  @SID_8
  Scenario: VRM - NEGATIVE - Validate Dashboards "Traffic Bandwidth" Chart data doesn't exist for policy without traffic
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | Policy17 |
    Then UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value   | count | offset | exist |
      | 5578811 | 8     | 2      | false |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value  | count | offset | exist |
      | 517963 | 8     | 2      | false |
        #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset | exist |
      | 10000 | 8     | 2      | false |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset | exist |
      | 0     | 8     | 2      | false |
        #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value  | count | offset | exist |
      | 729740 | 8     | 2      | false |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value  | count | offset | exist |
      | 513819 | 8     | 2      | false |
        #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset | exist |
      | 20000 | 8     | 2      | false |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset | exist |
      | 0     | 8     | 2      | false |
        #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |

  @SID_9
  Scenario: VRM - Validate Dashboards "Traffic Bandwidth" Chart data for one selected DP machine filtered by ports and policies
    When UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 6     | Policy14 |
    # for traffic this combination is illegal and will return null
    Then UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset |
      | null  | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset |
      | null  | 8     | 2      |
        #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset |
      | null  | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset |
      | null  | 8     | 2      |
        #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset |
      | null  | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset |
      | null  | 8     | 2      |
        #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset |
      | null  | 8     | 2      |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset |
      | null  | 8     | 2      |
        #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |

  @SID_10
  Scenario: VRM - NEGATIVE - Validate Dashboards "Traffic Bandwidth" Chart data doesn't exist for policy with traffic on wrong port
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1     | Policy15 |
    Then UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset | exist |
      | 0     | 8     | 2      | false |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset | exist |
      | 0     | 8     | 2      | false |
        #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset | exist |
      | 0     | 8     | 2      | false |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset | exist |
      | 0     | 8     | 2      | false |
        #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset | exist |
      | 0     | 8     | 2      | false |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset | exist |
      | 0     | 8     | 2      | false |
        #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value | count | offset | exist |
      | 0     | 8     | 2      | false |
    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count | offset | exist |
      | 0     | 8     | 2      | false |
        #    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
#      | value   | count | offset |
#      | 1027638 | 8     | 2      |

  @SID_11
  Scenario: VRM - Validate Dashboards "Traffic Bandwidth" Chart widget styling attributes
    Then UI Validate Line Chart attributes "Traffic Bandwidth" with Label "Dropped"
      | attribute             | value                    |
      | fill                  | true                     |
  #   | lineTension           | 0.35                     |
      | borderCapStyle        | butt                     |
  #   | borderDash            | []                       |
      | borderDashOffset      | 0                        |
      | borderJoinStyle       | miter                    |
      | borderWidth           | 1                        |
      | pointHoverRadius      | 4                        |
      | pointHoverBorderWidth | 1                        |
      | pointRadius           | 0                        |
      | pointHitRadius        | 0                        |
      | backgroundColor       | rgba(190, 30, 45, 0.2) |
      | hoverBackgroundColor  | rgba(190, 30, 45, 0.4) |
      | hoverBorderColor      | rgba(190, 30, 45, 1)   |
      | borderColor           | rgba(190, 30, 45, 1)   |
    And UI Validate Line Chart attributes "Traffic Bandwidth" with Label "Received"
      | attribute             | value                    |
      | fill                  | true                     |
  #   | lineTension           | 0.35                     |
      | borderCapStyle        | butt                     |
  #   | borderDash            | []                       |
      | borderDashOffset      | 0                        |
      | borderJoinStyle       | miter                    |
      | borderWidth           | 2                        |
      | pointHoverRadius      | 4                        |
      | pointHoverBorderWidth | 1                        |
      | pointRadius           | 0                        |
      | pointHitRadius        | 0                        |
      | backgroundColor       | rgba(194, 218, 235, 0.1) |
      | hoverBackgroundColor  | rgba(194, 218, 235, 0.4) |
      | hoverBorderColor      | rgba(194, 218, 235, 5)   |
      | borderColor           | rgba(194, 218, 235, 5)   |
#    And UI Validate Line Chart attributes "Traffic Bandwidth" with Label "Excluded"
#      | attribute             | value                    |
#      | fill                  | true                     |
#  #   | lineTension           | 0.35                     |
#      | borderCapStyle        | butt                     |
#  #   | borderDash            | []                       |
#      | borderDashOffset      | 0                        |
#      | borderJoinStyle       | miter                    |
#      | borderWidth           | 2                        |
#      | pointHoverRadius      | 4                        |
#      | pointHoverBorderWidth | 1                        |
#      | pointRadius           | 0                        |
#      | pointHitRadius        | 0                        |
#      | backgroundColor       | rgba(194, 218, 235, 0.1) |
#      | hoverBackgroundColor  | rgba(194, 218, 235, 0.4) |
#      | hoverBorderColor      | rgba(194, 218, 235, 5)   |
#      | borderColor           | rgba(194, 218, 235, 5)   |

  @SID_12
  Scenario: Inbound Traffic 2 minutes Gaps
    Given UI Logout
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-traffic-raw-*"
    * REST Delete ES index "dp-connection-statistics-*"
    * REST Delete ES index "dp-concurrent-connections-*"
    # YL: play a known amount of traffic with a known gap in between
    And CLI simulate 5 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000 and wait 200 seconds
    And CLI simulate 5 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000 and wait 85 seconds
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Click Button "Accessibility Open Menu"
    Then UI Click Button "Accessibility Close"
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Received"
      | value  | count | offset |
      | 729740 | 10    | 1      |
      | null   | 49    | 2      |

    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value  | count | offset |
      | 513819 | 10    | 1      |
      | null   | 49    | 2      |

    And  UI Validate Line Chart data "Traffic Bandwidth" with Label "Excluded"
      | value  | count | offset |
      | 513819 | 10    | 1      |
      | null   | 49    | 2      |

  @SID_13
  Scenario: Concurrent Connections 2 minutes Gaps
    Then UI Validate Line Chart data "Concurrent Connections" with Label "Concurrent Connections"
      | value  | count | offset |
      | 426037 | 10    | 1      |
      | null   | 49    | 2      |

  @SID_14
  Scenario: Connections rate 2 minutes Gaps
    Then UI Validate Line Chart data "Connections Rate" with Label "Connections per Second"
      | value | count | offset |
      | 6335  | 10    | 1      |
      | null  | 49    | 2      |

  @Dev_Sanity @SID_15
  Scenario: Inbound Traffic Cleanup
    Given UI logout and close browser
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal        | NOT_EXPECTED |
