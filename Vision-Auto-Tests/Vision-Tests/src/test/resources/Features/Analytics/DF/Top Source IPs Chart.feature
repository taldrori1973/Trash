@TC127093
Feature: Top Source IPs Chart
  @SID_1
  Scenario: Clean system data before Top Source IPs Chart Test
    * CLI kill all simulator attacks on current vision
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "df-traffic"
    * REST Delete ES index "df-attack"
    * REST Delete ES index "traffic*"
    * REST Delete ES index "attacks*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Login and navigate to DF Analytics
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "DefenseFlow Analytics" page via homePage

  @SID_3
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Total bps
    Then UI Validate Text field "Top Source" with params "0" EQUALS "TCP"
    Then UI Validate Text field "Top Source" with params "1" EQUALS "UDP"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label         | param | value |
      | Top Source | 0     | TCP   |
      | Top Source | 1     | UDP   |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                     | param | value     |
      | Top Source Total Value | 0     | 2.47 Mbps |
      | Top Source Total Value | 1     | 995 Kbps  |

    Then UI Validate Text field "Top Source Total Percentage" with params "0" EQUALS "73.17%"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                          | param | value  |
      | Top Source Total Percentage | 0     | 57.71% |
      | Top Source Total Percentage | 1     | 42.28% |

  @SID_4
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Total pps
    Then UI Click Button "Dropdown Units" with value "Top Source"
    Then UI Click Button "pps Units" with value "Top Source"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label         | param | value |
      | Top Source | 0     | TCP   |
      | Top Source | 1     | UDP   |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                     | param | value   |
      | Top Source Total Value | 0     | 8.85 Kp |
      | Top Source Total Value | 1     | 5.29 Kp |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                          | param | value  |
      | Top Source Total Percentage | 0     | 62.57% |
      | Top Source Total Percentage | 1     | 37.42% |

  @SID_5
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Last bps
    Then UI Click Button "Dropdown Sort By" with value "Top Source"
    Then UI Click Button "Sort By Last" with value "Top Source"
    Then UI Click Button "Dropdown Units" with value "Top Source"
    Then UI Click Button "bps Units" with value "Top Source"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label         | param | value |
      | Top Source | 0     | TCP   |
      | Top Source | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                     | param | value      |
      | Top Source Total Value | 0     | 13.86 Mbps |
      | Top Source Total Value | 1     | 10.35 Mbps |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                          | param | value  |
      | Top Source Total Percentage | 0     | 57.71% |
      | Top Source Total Percentage | 1     | 42.28% |


  @SID_6
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Last pps
    Then UI Click Button "Dropdown Units" with value "Top Source"
    Then UI Click Button "pps Units" with value "Top Source"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label         | param | value |
      | Top Source | 0     | TCP   |
      | Top Source | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                     | param | value  |
      | Top Source Total Value | 0     | 24 pps |
      | Top Source Total Value | 1     | 14 pps |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                          | param | value  |
      | Top Source Total Percentage | 0     | 63.66% |
      | Top Source Total Percentage | 1     | 36.33% |


  @SID_7
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Average bps
    Then UI Click Button "Dropdown Sort By" with value "Top Source"
    Then UI Click Button "Sort By Average" with value "Top Source"
    Then UI Click Button "Dropdown Units" with value "Top Source"
    Then UI Click Button "bps Units" with value "Top Source"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label         | param | value |
      | Top Source | 0     | TCP   |
      | Top Source | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                     | param | value      |
      | Top Source Total Value | 0     | 22.55 Mbps |
      | Top Source Total Value | 1     | 17.05 Mbps |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                          | param | value  |
      | Top Source Total Percentage | 0     | 56.94% |
      | Top Source Total Percentage | 1     | 43.05% |

  @SID_8
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Average pps
    Then UI Click Button "Dropdown Units" with value "Top Source"
    Then UI Click Button "pps Units" with value "Top Source"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label         | param | value |
      | Top Source | 0     | TCP   |
      | Top Source | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                     | param | value  |
      | Top Source Total Value | 0     | 20 pps |
      | Top Source Total Value | 1     | 12 pps |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                          | param | value  |
      | Top Source Total Percentage | 0     | 62.62% |
      | Top Source Total Percentage | 1     | 37.37% |


  @SID_9
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Max bps
    Then UI Click Button "Dropdown Sort By" with value "Top Source"
    Then UI Click Button "Sort By Max" with value "Top Source"
    Then UI Click Button "Dropdown Units" with value "Top Source"
    Then UI Click Button "bps Units" with value "Top Source"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label         | param | value |
      | Top Source | 0     | TCP   |
      | Top Source | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                     | param | value      |
      | Top Source Total Value | 0     | 35.51 Mbps |
      | Top Source Total Value | 1     | 26.79 Mbps |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                          | param | value  |
      | Top Source Total Percentage | 0     | 57.00% |
      | Top Source Total Percentage | 1     | 42.99% |

  @SID_10
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Max pps
    Then UI Click Button "Dropdown Units" with value "Top Source"
    Then UI Click Button "pps Units" with value "Top Source"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label         | param | value |
      | Top Source | 0     | TCP   |
      | Top Source | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                     | param | value  |
      | Top Source Total Value | 0     | 31 pps |
      | Top Source Total Value | 1     | 19 pps |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                          | param | value  |
      | Top Source Total Percentage | 0     | 60.74% |
      | Top Source Total Percentage | 1     | 37.22% |

              ################  Line Charts ##################

  @SID_11
  Scenario: Validate Top Source IP Line Charts Values bps
    Then UI Click Button "Dropdown Units" with value "Top Source"
    Then UI Click Button "bps Units" with value "Top Source"
    Then Sleep "5"
    Then UI Validate Line Chart data "Top Source" with Label "TCP"
      | value | count |
      | 1188  | 1     |
    Then UI Validate Line Chart data "Top Source" with Label "UDP"
      | value | count |
      | 700   | 1     |
    Then Sleep "3"
    Then UI Validate Line Chart data "Top Source" with Label "TCP"
      | value | count |
      | 899   | 1     |
    Then UI Validate Line Chart data "Top Source" with Label "UDP"
      | value | count |
      | 775   | 1     |

  @SID_12
  Scenario: Validate Top Source IP Line Charts Values pps
    Then UI Click Button "Dropdown Units" with value "Top Source"
    Then UI Click Button "pps Units" with value "Top Source"
    Then Sleep "5"
    Then UI Validate Line Chart data "Top Source" with Label "TCP"
      | value | count |
      | 77    | 1     |
    Then UI Validate Line Chart data "Top Source" with Label "UDP"
      | value | count |
      | 65    | 1     |
    Then UI Validate Line Chart data "Top Source" with Label "TCP"
      | value | count |
      | 104    | 1     |
    Then UI Validate Line Chart data "Top Source" with Label "UDP"
      | value | count |
      | 67    | 1     |

  @SID_13
  Scenario: Validate Top Source IP Chart Legends Line Chart Selection
    Then UI Click Button "Legend Row" with value "0-Top Source"
    Then UI Validate Line Chart data "Top Source" with Label "TCP" Not Exist "true"
      | value | count | offset |
    Then UI Click Button "Legend Row" with value "1-Top Source"
    Then UI Validate Line Chart data "Top Source" with Label "ICMP" Not Exist "true"
      | value | count | offset |
    Then UI Click Button "Legend Row" with value "0-Top Source"
    Then UI Click Button "Legend Row" with value "1-Top Source"
    Then UI Validate Line Chart data "Top Source" with Label "TCP"
      | value | count |
      | 899   | 1     |
    Then UI Validate Line Chart data "Top Source" with Label "UDP"
      | value | count |
      | 775   | 1     |

                  #################  Last Week Trends Charts ##################


  @SID_14
  Scenario: Validate Last Week Trends Top Source IP Bar Chart
    Then UI Validate Line Chart data "trends-topProtocol-bar" with Label "TCP$TCP"
      | value    | count |
      | 88242113 | 1     |
    Then UI Validate Line Chart data "trends-topProtocol-bar" with Label "ICMP$ICMP"
      | value    | count |
      | 64225410 | 1     |

  @SID_15
  Scenario: Validate Last Week Trends Top Source IP Doughnut Chart
    Then UI Click Button "Switch doughnut Chart" with value "topProtocol"
    Then Sleep "5"
    Then UI Validate Line Chart data "trends-topProtocol-doughnut" with Label "TCP"
      | value              | count |
      | 57.876005652924654 | 1     |
    Then UI Validate Line Chart data "Trends-Top-Protocols" with Label "ICMP"
      | value             | count |
      | 42.12399347487751 | 1     |

  @SID_16
  Scenario: Logout and Close Browser
    Then UI logout and close browser