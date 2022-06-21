@TC127410
Feature: DF Analytics Top Applications

  @SID_1
  Scenario:  Clean system First Then Send Attacks
    * CLI kill all simulator attacks on current vision
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "df-a*"
    * REST Delete ES index "df-t*"
    * REST Delete ES index "traffic*"
    * REST Delete ES index "attacks*"
    * CLI Clear vision logs
    ###### Pcap should be Added ######

  @SID_2
  Scenario: Login With Radware and Navigate to DF Analytics
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "DefenseFlow Analytics" page via homePage

                  #################  Extended Charts ##################


  @SID_3
  Scenario: Validate Top Applications Extended Widgets Values Sorted by Total bps
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label            | param | value |
      | Top Applications | 0     | TCP   |
      | Top Applications | 1     | UDP   |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value     | offset |
      | Top Applications Total Value | 0     | 2.47 Mbps | 20     |
      | Top Applications Total Value | 1     | 995 Kbps  | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                             | param | value  | offset |
      | Top Applications Total Percentage | 0     | 57.71% | 2      |
      | Top Applications Total Percentage | 1     | 42.28% | 2      |

  @SID_4
  Scenario: Validate Top Applications Extended Widgets Values Sorted by Total pps
    Then UI Click Button "Dropdown Units" with value "Top Applications"
    Then UI Click Button "pps Units" with value "Top Applications"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label            | param | value |
      | Top Applications | 0     | TCP   |
      | Top Applications | 1     | UDP   |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value   | offset |
      | Top Applications Total Value | 0     | 8.85 Kp | 20     |
      | Top Applications Total Value | 1     | 5.29 Kp | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                             | param | value  | offset |
      | Top Applications Total Percentage | 0     | 62.57% | 2      |
      | Top Applications Total Percentage | 1     | 37.42% | 2      |

  @SID_5
  Scenario: Validate Top Applications Extended Widgets Values Sorted by Last bps
    Then UI Click Button "Dropdown Sort By" with value "Top Applications"
    Then UI Click Button "Sort By Last" with value "Top Applications"
    Then UI Click Button "Dropdown Units" with value "Top Applications"
    Then UI Click Button "bps Units" with value "Top Applications"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label            | param | value |
      | Top Applications | 0     | TCP   |
      | Top Applications | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value      | offset |
      | Top Applications Total Value | 0     | 13.86 Mbps | 20     |
      | Top Applications Total Value | 1     | 10.35 Mbps | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                             | param | value  | offset |
      | Top Applications Total Percentage | 0     | 57.71% | 2      |
      | Top Applications Total Percentage | 1     | 42.28% | 2      |

  @SID_6
  Scenario: Validate Top Applications Extended Widgets Values Sorted by Last pps
    Then UI Click Button "Dropdown Units" with value "Top Applications"
    Then UI Click Button "pps Units" with value "Top Applications"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label            | param | value |
      | Top Applications | 0     | TCP   |
      | Top Applications | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value  | offset |
      | Top Applications Total Value | 0     | 24 pps | 20     |
      | Top Applications Total Value | 1     | 14 pps | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                             | param | value  | offset |
      | Top Applications Total Percentage | 0     | 63.66% | 2      |
      | Top Applications Total Percentage | 1     | 36.33% | 2      |


  @SID_7
  Scenario: Validate Top Applications Extended Widgets Values Sorted by Average bps
    Then UI Click Button "Dropdown Sort By" with value "Top Applications"
    Then UI Click Button "Sort By Average" with value "Top Applications"
    Then UI Click Button "Dropdown Units" with value "Top Applications"
    Then UI Click Button "bps Units" with value "Top Applications"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label            | param | value |
      | Top Applications | 0     | TCP   |
      | Top Applications | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value      | offset |
      | Top Applications Total Value | 0     | 22.55 Mbps | 20     |
      | Top Applications Total Value | 1     | 17.05 Mbps | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                             | param | value  | offset |
      | Top Applications Total Percentage | 0     | 56.94% | 2      |
      | Top Applications Total Percentage | 1     | 43.05% | 2      |

  @SID_8
  Scenario: Validate Top Applications Extended Widgets Values Sorted by Average pps
    Then UI Click Button "Dropdown Units" with value "Top Applications"
    Then UI Click Button "pps Units" with value "Top Applications"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label            | param | value |
      | Top Applications | 0     | TCP   |
      | Top Applications | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value  | offset |
      | Top Applications Total Value | 0     | 20 pps | 20     |
      | Top Applications Total Value | 1     | 12 pps | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                             | param | value  | offset |
      | Top Applications Total Percentage | 0     | 62.62% | 2      |
      | Top Applications Total Percentage | 1     | 37.37% | 2      |


  @SID_9
  Scenario: Validate Top Applications Extended Widgets Values Sorted by Max bps
    Then UI Click Button "Dropdown Sort By" with value "Top Applications"
    Then UI Click Button "Sort By Max" with value "Top Applications"
    Then UI Click Button "Dropdown Units" with value "Top Applications"
    Then UI Click Button "bps Units" with value "Top Applications"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label            | param | value |
      | Top Applications | 0     | TCP   |
      | Top Applications | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value      | offset |
      | Top Applications Total Value | 0     | 35.51 Mbps | 20     |
      | Top Applications Total Value | 1     | 26.79 Mbps | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                             | param | value  | offset |
      | Top Applications Total Percentage | 0     | 57.00% | 2      |
      | Top Applications Total Percentage | 1     | 42.99% | 2      |

  @SID_10
  Scenario: Validate Top Applications Extended Widgets Values Sorted by Max pps
    Then UI Click Button "Dropdown Units" with value "Top Applications"
    Then UI Click Button "pps Units" with value "Top Applications"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label            | param | value |
      | Top Applications | 0     | TCP   |
      | Top Applications | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value  | offset |
      | Top Applications Total Value | 0     | 31 pps | 20     |
      | Top Applications Total Value | 1     | 19 pps | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                             | param | value  | offset |
      | Top Applications Total Percentage | 0     | 60.74% | 2      |
      | Top Applications Total Percentage | 1     | 37.22% | 2      |

              ################  Line Charts ##################

  @SID_11
  Scenario: Validate Top Applications Line Charts Values bps
    Then UI Click Button "Dropdown Units" with value "Top Applications"
    Then UI Click Button "bps Units" with value "Top Applications"
    Then Sleep "5"
    Then UI Validate Line Chart data "Top Applications" with Label "HTTP (80)"
      | value | count |
      | 1188  | 1     |
    Then UI Validate Line Chart data "Top Applications" with Label "HTTP over SSL (443)"
      | value | count |
      | 700   | 1     |
    Then Sleep "3"
    Then UI Validate Line Chart data "Top Applications" with Label "SNMT (25)"
      | value | count |
      | 899   | 1     |
    Then UI Validate Line Chart data "Top Applications" with Label "SSH/SCP (22)"
      | value | count |
      | 775   | 1     |
    Then UI Validate Line Chart data "Top Applications" with Label "DNS (53)"
      | value | count |
      | 775   | 1     |

  @SID_12
  Scenario: Validate Top Applications Line Charts Values pps
    Then UI Click Button "Dropdown Units" with value "Top Applications"
    Then UI Click Button "pps Units" with value "Top Applications"
    Then Sleep "5"
    Then UI Validate Line Chart data "Top Applications" with Label "HTTP (80)"
      | value | count |
      | 1188  | 1     |
    Then UI Validate Line Chart data "Top Applications" with Label "HTTP over SSL (443)"
      | value | count |
      | 700   | 1     |
    Then Sleep "3"
    Then UI Validate Line Chart data "Top Applications" with Label "SNMT (25)"
      | value | count |
      | 899   | 1     |
    Then UI Validate Line Chart data "Top Applications" with Label "SSH/SCP (22)"
      | value | count |
      | 775   | 1     |
    Then UI Validate Line Chart data "Top Applications" with Label "DNS (53)"
      | value | count |
      | 775   | 1     |


  @SID_13
  Scenario: Validate Top Applications Chart Legends Line Chart Selection
    Then UI Click Button "Legend Row" with value "0-Top Applications"
    Then UI Validate Line Chart data "Top Applications" with Label "HTTP (80)" Not Exist "true"
      | value | count | offset |
    Then UI Click Button "Legend Row" with value "1-Top Applications"
    Then UI Validate Line Chart data "Top Applications" with Label "HTTP over SSL (443)" Not Exist "true"
      | value | count | offset |
    Then UI Click Button "Legend Row" with value "0-Top Applications"
    Then UI Click Button "Legend Row" with value "1-Top Applications"
    Then UI Validate Line Chart data "Top Applications" with Label "HTTP (80)"
      | value | count |
      | 899   | 1     |
    Then UI Validate Line Chart data "Top Applications" with Label "HTTP over SSL (443)"
      | value | count |
      | 775   | 1     |

                  #################  Last Week Trends Charts ##################


  @SID_14
  Scenario: Validate Last Week Trends Top Applications Bar Chart
    Then UI Validate Line Chart data "trends-topApplication-bar" with Label "SNMT$25"
      | value    | count |
      | 98180964 | 1     |
    Then UI Validate Line Chart data "trends-topApplication-bar" with Label "WINS Replication$42"
      | value    | count |
      | 48166687 | 1     |
    Then UI Validate Line Chart data "trends-topApplication-bar" with Label "DNS$53"
      | value    | count |
      | 47884316 | 1     |
    Then UI Validate Line Chart data "trends-topApplication-bar" with Label "HTTP$80"
      | value     | count |
      | 513738506 | 1     |
    Then UI Validate Line Chart data "trends-topApplication-bar" with Label "HTTP over SSL$443"
      | value     | count |
      | 444607589 | 1     |


  @SID_15
  Scenario: Validate Last Week Trends Top Applications Doughnut Chart
    Then UI Click Button "Switch doughnut Chart" with value "topApplication"
    Then Sleep "5"
    Then UI Validate Line Chart data "trends-topApplication-doughnut" with Label "HTTP"
      | value            | count |
      | 44.3057311897803 | 1     |
    Then UI Validate Line Chart data "trends-topApplication-doughnut" with Label "HTTP over SSL"
      | value             | count |
      | 38.82248587132261 | 1     |
    Then UI Validate Line Chart data "trends-topApplication-doughnut" with Label "SNMT"
      | value             | count |
      | 8.534295382013589 | 1     |
    Then UI Validate Line Chart data "trends-topApplication-doughnut" with Label "WINS Replication"
      | value             | count |
      | 4.231309450764006 | 1     |
    Then UI Validate Line Chart data "trends-topApplication-doughnut" with Label "SSH/SCP"
      | value             | count |
      | 4.106177797064031 | 1     |


  @SID_16
  Scenario: Logout and Close Browser
    Then UI logout and close browser