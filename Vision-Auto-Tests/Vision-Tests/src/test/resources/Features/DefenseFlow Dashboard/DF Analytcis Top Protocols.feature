@TC127263
Feature: DF Analytics Top Protocols

  @SID_1
  Scenario:  Clean system First Then Send Attacks
    * CLI kill all simulator attacks on current vision
#    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "df-a*"
    * REST Delete ES index "df-t*"
    * REST Delete ES index "traffic*"
    * REST Delete ES index "attack*"
    * CLI Clear vision logs
    Then CLI simulate 1 attacks of type "FlowDetector_test" on SetId "FNM_Set_0" as dest from src "10.18.2.19" and wait 200 seconds
    * CLI kill all simulator attacks on current vision
    Then Sleep "50"

  @SID_2
  Scenario: Login With Radware and Navigate to DF Analytics
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "DefenseFlow Analytics" page via homePage


                  #################  Extended Charts ##################


  @SID_3
  Scenario: Validate Top Protocols Extended Widgets Values Sorted by Total bps
    Then UI Click Button "Dropdown Sort By" with value "Top Protocols"
    Then Sleep "2"
    Then UI Click Button "Sort By Total" with value "Top Protocols"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label         | param | value |
      | Top Protocols | 0     | TCP   |
      | Top Protocols | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                     | param | value   | offset |
      | Top Protocols Total Value | 0     | 5.77 Gb | 20     |
      | Top Protocols Total Value | 1     | 2.54 Gb | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                          | param | value   | offset |
      | Top Protocols Total Percentage | 0     | 69.44 % | 4      |
      | Top Protocols Total Percentage | 1     | 30.55 % | 4      |

  @SID_4
  Scenario: Validate Top Protocols Extended Widgets Values Sorted by Total pps
    Then UI Click Button "Dropdown Units" with value "Top Protocols"
    Then UI Click Button "pps Units" with value "Top Protocols"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label         | param | value |
      | Top Protocols | 0     | TCP   |
      | Top Protocols | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                     | param | value   | offset |
      | Top Protocols Total Value | 0     | 7.22 Kp | 20     |
      | Top Protocols Total Value | 1     | 3.23 Kp | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                          | param | value   | offset |
      | Top Protocols Total Percentage | 0     | 69.07 % | 4      |
      | Top Protocols Total Percentage | 1     | 30.92 % | 4      |

  @SID_5
  Scenario: Validate Top Protocols Extended Widgets Values Sorted by Last bps
    Then UI Click Button "Dropdown Sort By" with value "Top Protocols"
    Then UI Click Button "Sort By Last" with value "Top Protocols"
    Then UI Click Button "Dropdown Units" with value "Top Protocols"
    Then UI Click Button "bps Units" with value "Top Protocols"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label         | param | value |
      | Top Protocols | 0     | TCP   |
      | Top Protocols | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                     | param | value     | offset |
      | Top Protocols Total Value | 0     | 18.1 Mbps | 20     |
      | Top Protocols Total Value | 1     | 7.75 Mbps | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                          | param | value   | offset |
      | Top Protocols Total Percentage | 0     | 70.02 % | 4      |
      | Top Protocols Total Percentage | 1     | 29.97 % | 4      |


  @SID_6
  Scenario: Validate Top Protocols Extended Widgets Values Sorted by Last pps
    Then UI Click Button "Dropdown Units" with value "Top Protocols"
    Then UI Click Button "pps Units" with value "Top Protocols"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label         | param | value |
      | Top Protocols | 0     | TCP   |
      | Top Protocols | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                     | param | value  | offset |
      | Top Protocols Total Value | 0     | 24 pps | 20     |
      | Top Protocols Total Value | 1     | 10 pps | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                          | param | value   | offset |
      | Top Protocols Total Percentage | 0     | 69.57 % | 4      |
      | Top Protocols Total Percentage | 1     | 30.42 % | 4      |


  @SID_7
  Scenario: Validate Top Protocols Extended Widgets Values Sorted by Average bps
    Then UI Click Button "Dropdown Sort By" with value "Top Protocols"
    Then UI Click Button "Sort By Average" with value "Top Protocols"
    Then UI Click Button "Dropdown Units" with value "Top Protocols"
    Then UI Click Button "bps Units" with value "Top Protocols"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label         | param | value |
      | Top Protocols | 0     | TCP   |
      | Top Protocols | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                     | param | value      | offset |
      | Top Protocols Total Value | 0     | 24.03 Mbps | 20     |
      | Top Protocols Total Value | 1     | 10.57 Mbps | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                          | param | value   | offset |
      | Top Protocols Total Percentage | 0     | 69.44 % | 2      |
      | Top Protocols Total Percentage | 1     | 30.55 % | 2      |

  @SID_8
  Scenario: Validate Top Protocols Extended Widgets Values Sorted by Average pps
    Then UI Click Button "Dropdown Units" with value "Top Protocols"
    Then UI Click Button "pps Units" with value "Top Protocols"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label         | param | value |
      | Top Protocols | 0     | TCP   |
      | Top Protocols | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                     | param | value  | offset |
      | Top Protocols Total Value | 0     | 30 pps | 20     |
      | Top Protocols Total Value | 1     | 13 pps | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                          | param | value   | offset |
      | Top Protocols Total Percentage | 0     | 69.14 % | 4      |
      | Top Protocols Total Percentage | 1     | 30.95 % | 4      |


  @SID_9
  Scenario: Validate Top Protocols Extended Widgets Values Sorted by Max bps
    Then UI Click Button "Dropdown Sort By" with value "Top Protocols"
    Then UI Click Button "Sort By Max" with value "Top Protocols"
    Then UI Click Button "Dropdown Units" with value "Top Protocols"
    Then UI Click Button "bps Units" with value "Top Protocols"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label         | param | value |
      | Top Protocols | 0     | TCP   |
      | Top Protocols | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                     | param | value      | offset |
      | Top Protocols Total Value | 0     | 37.14 Mbps | 20     |
      | Top Protocols Total Value | 1     | 16.46 Mbps | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                          | param | value   | offset |
      | Top Protocols Total Percentage | 0     | 69.28 % | 4      |
      | Top Protocols Total Percentage | 1     | 30.71 % | 4      |

  @SID_10
  Scenario: Validate Top Protocols Extended Widgets Values Sorted by Max pps
    Then UI Click Button "Dropdown Units" with value "Top Protocols"
    Then UI Click Button "pps Units" with value "Top Protocols"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label         | param | value |
      | Top Protocols | 0     | TCP   |
      | Top Protocols | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                     | param | value  | offset |
      | Top Protocols Total Value | 0     | 45 pps | 20     |
      | Top Protocols Total Value | 1     | 21 pps | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                          | param | value   | offset |
      | Top Protocols Total Percentage | 0     | 67.16 % | 4      |
      | Top Protocols Total Percentage | 1     | 31.34 % | 4      |

              ################  Line Charts ##################

  @SID_11
  Scenario: Validate Top Protocols Line Charts Values bps
    Then UI Click Button "Dropdown Units" with value "Top Protocols"
    Then UI Click Button "bps Units" with value "Top Protocols"
    Then Sleep "5"
    Then UI Validate Line Chart data "Top Protocols" with Label "TCP"
      | value | offset | count |
      | 37135 | 1000   | 1     |
    Then UI Validate Line Chart data "Top Protocols" with Label "ICMP"
      | value | offset | count |
      | 16460 | 1000   | 1     |
    Then Sleep "3"
    Then UI Validate Line Chart data "Top Protocols" with Label "TCP"
      | value | offset | count |
      | 18103 | 1000   | 1     |
    Then UI Validate Line Chart data "Top Protocols" with Label "ICMP"
      | value | offset | count |
      | 7747  | 1000   | 1     |

  @SID_12
  Scenario: Validate Top Protocols Line Charts Values pps
    Then UI Click Button "Dropdown Units" with value "Top Protocols"
    Then UI Click Button "pps Units" with value "Top Protocols"
    Then Sleep "5"
    Then UI Validate Line Chart data "Top Protocols" with Label "TCP"
      | value | count | offset |
      | 45    | 1     | 5      |
    Then UI Validate Line Chart data "Top Protocols" with Label "ICMP"
      | value | count | offset |
      | 18    | 1     | 5      |
    Then UI Validate Line Chart data "Top Protocols" with Label "TCP"
      | value | count | offset |
      | 24    | 1     | 5      |
    Then UI Validate Line Chart data "Top Protocols" with Label "ICMP"
      | value | count | offset |
      | 10    | 1     | 5      |

  @SID_13
  Scenario: Validate Top Protocols Chart Legends Line Chart Selection
    Then UI Click Button "Dropdown Units" with value "Top Protocols"
    Then UI Click Button "bps Units" with value "Top Protocols"
    Then UI Click Button "Legend Row" with value "0-Top Protocols"
    Then UI Validate Line Chart data "Top Protocols" with Label "TCP" Not Exist "true"
      | value | count | offset |
    Then UI Click Button "Legend Row" with value "1-Top Protocols"
    Then UI Validate Line Chart data "Top Protocols" with Label "ICMP" Not Exist "true"
      | value | count | offset |
    Then UI Click Button "Legend Row" with value "0-Top Protocols"
    Then UI Click Button "Legend Row" with value "1-Top Protocols"
    Then UI Validate Line Chart data "Top Protocols" with Label "TCP"
      | value | offset | count |
      | 18103 | 1000   | 1     |
    Then UI Validate Line Chart data "Top Protocols" with Label "ICMP"
      | value | offset | count |
      | 7747  | 1000   | 1     |


                  #################  Last Week Trends Charts ##################


#  @SID_14
#  Scenario: Validate Last Week Trends Top Protocols Bar Chart
#    Then UI Validate Line Chart data "trends-topProtocol-bar" with Label "TCP$TCP"
#      | value      | offset | count |
#      | 1347521866 | 10000  | 1     |
#    Then UI Validate Line Chart data "trends-topProtocol-bar" with Label "ICMP$ICMP"
#      | value    | offset | count |
#      | 81967391 | 10000  | 1     |
#
#  @SID_15
#  Scenario: Validate Last Week Trends Top Protocols Doughnut Chart
#    Then UI Click Button "Switch doughnut Chart" with value "topProtocol"
#    Then Sleep "5"
#    Then UI Validate Line Chart data "trends-topProtocol-doughnut" with Label "TCP"
#      | value             | offset | count |
#      | 94.02986636115514 | 5      | 1     |
#    Then UI Validate Line Chart data "trends-topProtocol-doughnut" with Label "ICMP"
#      | value             | offset | count |
#      | 5.970133576630788 | 5      | 1     |

  @SID_14
  Scenario: Logout and Close Browser
    Then UI logout and close browser