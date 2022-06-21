@TC127410
Feature: DF Analytics Top Applications

  @SID_1
  Scenario:  Clean system First Then Send Attacks
    * CLI kill all simulator attacks on current vision
#    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "df-a*"
    * REST Delete ES index "df-t*"
    * REST Delete ES index "traffic*"
    * REST Delete ES index "attacks*"
    Then CLI simulate 1 attacks of type "FNM_test_New" on SetId "FNM_Set_0" as dest from src "192.168.31.3" and wait 200 seconds
    * CLI kill all simulator attacks on current vision
    Then Sleep "50"

  @SID_2
  Scenario: Login With Radware and Navigate to DF Analytics
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "DefenseFlow Analytics" page via homePage

                  #################  Extended Charts ##################


  @SID_3
  Scenario: Validate Top Applications Extended Widgets Values Sorted by Total bps
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label            | param | value        |
      | Top Applications | 0     | DNS (53)     |
      | Top Applications | 1     | SSH/SCP (22) |
      | Top Applications | 2     | SNMT (25)    |
      | Top Applications | 3     | N_A (153)    |
      | Top Applications | 4     | HTTP (80)    |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value     | offset |
      | Top Applications Total Value | 0     | 678.49 Mb | 20     |
      | Top Applications Total Value | 1     | 662.97 Mb | 20     |
      | Top Applications Total Value | 2     | 652.86 Mb | 20     |
      | Top Applications Total Value | 3     | 649.11 Mb | 20     |
      | Top Applications Total Value | 4     | 641.11 Mb | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                             | param | value   | offset |
      | Top Applications Total Percentage | 0     | 11.76 % | 2      |
      | Top Applications Total Percentage | 1     | 11.49 % | 2      |
      | Top Applications Total Percentage | 2     | 11.31 % | 2      |
      | Top Applications Total Percentage | 3     | 11.25 % | 2      |
      | Top Applications Total Percentage | 4     | 11.11 % | 2      |

  @SID_4
  Scenario: Validate Top Applications Extended Widgets Values Sorted by Total pps
    Then UI Click Button "Dropdown Units" with value "Top Applications"
    Then UI Click Button "pps Units" with value "Top Applications"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label            | param | value        |
      | Top Applications | 0     | XDMCP (177)  |
      | Top Applications | 1     | SSH/SCP (22) |
      | Top Applications | 2     | FTP (20)     |
      | Top Applications | 3     | HTTP (80)    |
      | Top Applications | 4     | N_A (153)    |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value | offset |
      | Top Applications Total Value | 0     | 846 p | 20     |
      | Top Applications Total Value | 1     | 843 p | 20     |
      | Top Applications Total Value | 2     | 823 p | 20     |
      | Top Applications Total Value | 3     | 816 p | 20     |
      | Top Applications Total Value | 4     | 802 p | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                             | param | value   | offset |
      | Top Applications Total Percentage | 0     | 11.71 % | 2      |
      | Top Applications Total Percentage | 1     | 11.67 % | 2      |
      | Top Applications Total Percentage | 2     | 11.40 % | 2      |
      | Top Applications Total Percentage | 3     | 11.30 % | 2      |
      | Top Applications Total Percentage | 4     | 11.10 % | 2      |

  @SID_5
  Scenario: Validate Top Applications Extended Widgets Values Sorted by Last bps
    Then UI Click Button "Dropdown Sort By" with value "Top Applications"
    Then UI Click Button "Sort By Last" with value "Top Applications"
    Then UI Click Button "Dropdown Units" with value "Top Applications"
    Then UI Click Button "bps Units" with value "Top Applications"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label            | param | value        |
      | Top Applications | 0     | SSH/SCP (22) |
      | Top Applications | 1     | SNMT (25)    |
      | Top Applications | 2     | HTTP (80)    |
      | Top Applications | 3     | XDMCP (177)  |
      | Top Applications | 4     | FTP (20)     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value     | offset |
      | Top Applications Total Value | 0     | 2.21 Mbps | 2      |
      | Top Applications Total Value | 1     | 2.21 Mbps | 2      |
      | Top Applications Total Value | 2     | 2.09 Mbps | 2      |
      | Top Applications Total Value | 3     | 2.06 Mbps | 2      |
      | Top Applications Total Value | 4     | 2.04 Mbps | 2      |


    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                             | param | value   | offset |
      | Top Applications Total Percentage | 0     | 12.20 % | 2      |
      | Top Applications Total Percentage | 1     | 12.20 % | 2      |
      | Top Applications Total Percentage | 2     | 11.54 % | 2      |
      | Top Applications Total Percentage | 3     | 11.35 % | 2      |
      | Top Applications Total Percentage | 4     | 11.26 % | 2      |


  @SID_6
  Scenario: Validate Top Applications Extended Widgets Values Sorted by Last pps
    Then UI Click Button "Dropdown Units" with value "Top Applications"
    Then UI Click Button "pps Units" with value "Top Applications"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label            | param | value               |
      | Top Applications | 0     | SSH/SCP (22)        |
      | Top Applications | 1     | HTTP over SSL (443) |
      | Top Applications | 2     | SNMT (25)           |
      | Top Applications | 3     | N_A (153)           |
      | Top Applications | 4     | FTP (20)            |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value | offset |
      | Top Applications Total Value | 0     | 3 pps | 2      |
      | Top Applications Total Value | 1     | 3 pps | 2      |
      | Top Applications Total Value | 2     | 3 pps | 2      |
      | Top Applications Total Value | 3     | 2 pps | 2      |
      | Top Applications Total Value | 4     | 2 pps | 2      |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                             | param | value   | offset |
      | Top Applications Total Percentage | 0     | 12.82 % | 2      |
      | Top Applications Total Percentage | 1     | 12.54 % | 2      |
      | Top Applications Total Percentage | 2     | 11.47 % | 2      |
      | Top Applications Total Percentage | 3     | 11.29 % | 2      |
      | Top Applications Total Percentage | 4     | 10.81 % | 2      |


  @SID_7
  Scenario: Validate Top Applications Extended Widgets Values Sorted by Average bps
    Then UI Click Button "Dropdown Sort By" with value "Top Applications"
    Then UI Click Button "Sort By Average" with value "Top Applications"
    Then UI Click Button "Dropdown Units" with value "Top Applications"
    Then UI Click Button "bps Units" with value "Top Applications"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label            | param | value        |
      | Top Applications | 0     | DNS (53)     |
      | Top Applications | 1     | SSH/SCP (22) |
      | Top Applications | 2     | SNMT (25)    |
      | Top Applications | 3     | N_A (153)    |
      | Top Applications | 4     | HTTP (80)    |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value     | offset |
      | Top Applications Total Value | 0     | 2.26 Mbps | 2      |
      | Top Applications Total Value | 1     | 2.21 Mbps | 2      |
      | Top Applications Total Value | 2     | 2.18 Mbps | 2      |
      | Top Applications Total Value | 3     | 2.16 Mbps | 2      |
      | Top Applications Total Value | 4     | 2.14 Mbps | 2      |


    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                             | param | value   | offset |
      | Top Applications Total Percentage | 0     | 11.76 % | 2      |
      | Top Applications Total Percentage | 1     | 11.49 % | 2      |
      | Top Applications Total Percentage | 2     | 11.32 % | 2      |
      | Top Applications Total Percentage | 3     | 11.25 % | 2      |
      | Top Applications Total Percentage | 4     | 11.11 % | 2      |

  @SID_8
  Scenario: Validate Top Applications Extended Widgets Values Sorted by Average pps
    Then UI Click Button "Dropdown Units" with value "Top Applications"
    Then UI Click Button "pps Units" with value "Top Applications"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label            | param | value        |
      | Top Applications | 0     | XDMCP (177)  |
      | Top Applications | 1     | SSH/SCP (22) |
      | Top Applications | 2     | FTP (20)     |
      | Top Applications | 3     | HTTP (80)    |
      | Top Applications | 4     | N_A (153)    |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value | offset |
      | Top Applications Total Value | 0     | 2 pps | 2      |
      | Top Applications Total Value | 1     | 2 pps | 2      |
      | Top Applications Total Value | 2     | 2 pps | 2      |
      | Top Applications Total Value | 3     | 2 pps | 2      |
      | Top Applications Total Value | 4     | 2 pps | 2      |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                             | param | value   | offset |
      | Top Applications Total Percentage | 0     | 11.75 % | 2      |
      | Top Applications Total Percentage | 1     | 11.70 % | 2      |
      | Top Applications Total Percentage | 2     | 11.43 % | 2      |
      | Top Applications Total Percentage | 3     | 11.33 % | 2      |
      | Top Applications Total Percentage | 4     | 11.13 % | 2      |


  @SID_9
  Scenario: Validate Top Applications Extended Widgets Values Sorted by Max bps
    Then UI Click Button "Dropdown Sort By" with value "Top Applications"
    Then UI Click Button "Sort By Max" with value "Top Applications"
    Then UI Click Button "Dropdown Units" with value "Top Applications"
    Then UI Click Button "bps Units" with value "Top Applications"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label            | param | value        |
      | Top Applications | 0     | DNS (53)     |
      | Top Applications | 1     | SSH/SCP (22) |
      | Top Applications | 2     | SNMT (25)    |
      | Top Applications | 3     | N_A (153)    |
      | Top Applications | 4     | HTTP (80)    |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value     | offset |
      | Top Applications Total Value | 0     | 2.26 Mbps | 2      |
      | Top Applications Total Value | 1     | 2.21 Mbps | 2      |
      | Top Applications Total Value | 2     | 2.18 Mbps | 2      |
      | Top Applications Total Value | 3     | 2.16 Mbps | 2      |
      | Top Applications Total Value | 4     | 2.14 Mbps | 2      |


    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                             | param | value   | offset |
      | Top Applications Total Percentage | 0     | 11.76 % | 2      |
      | Top Applications Total Percentage | 1     | 11.49 % | 2      |
      | Top Applications Total Percentage | 2     | 11.31 % | 2      |
      | Top Applications Total Percentage | 3     | 11.25 % | 2      |
      | Top Applications Total Percentage | 4     | 11.11 % | 2      |

  @SID_10
  Scenario: Validate Top Applications Extended Widgets Values Sorted by Max pps
    Then UI Click Button "Dropdown Units" with value "Top Applications"
    Then UI Click Button "pps Units" with value "Top Applications"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label            | param | value        |
      | Top Applications | 0     | XDMCP (177)  |
      | Top Applications | 1     | SSH/SCP (22) |
      | Top Applications | 2     | FTP (20)     |
      | Top Applications | 3     | HTTP (80)    |
      | Top Applications | 4     | N_A (153)    |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value | offset |
      | Top Applications Total Value | 0     | 2 pps | 2      |
      | Top Applications Total Value | 1     | 2 pps | 2      |
      | Top Applications Total Value | 2     | 2 pps | 2      |
      | Top Applications Total Value | 3     | 2 pps | 2      |
      | Top Applications Total Value | 4     | 2 pps | 2      |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                             | param | value   | offset |
      | Top Applications Total Percentage | 0     | 11.75 % | 2      |
      | Top Applications Total Percentage | 1     | 11.70 % | 2      |
      | Top Applications Total Percentage | 2     | 11.43 % | 2      |
      | Top Applications Total Percentage | 3     | 11.33 % | 2      |
      | Top Applications Total Percentage | 4     | 11.13 % | 2      |

              ################  Line Charts ##################

  @SID_11
  Scenario: Validate Top Applications Line Charts Values bps
    Then UI Click Button "Dropdown Units" with value "Top Applications"
    Then UI Click Button "bps Units" with value "Top Applications"
    Then Sleep "5"
    Then UI Validate Line Chart data "Top Applications" with Label "HTTP (80)"
      | value | offset | count |
      | 3751  | 1000   | 1     |
    Then UI Validate Line Chart data "Top Applications" with Label "N_A (153)"
      | value | offset | count |
      | 1872  | 1000   | 1     |
    Then Sleep "3"
    Then UI Validate Line Chart data "Top Applications" with Label "SNMT (25)"
      | value | offset | count |
      | 4285  | 1000   | 1     |
    Then UI Validate Line Chart data "Top Applications" with Label "SSH/SCP (22)"
      | value | offset | count |
      | 4124  | 1000   | 1     |
    Then UI Validate Line Chart data "Top Applications" with Label "DNS (53)"
      | value | offset | count |
      | 4341  | 1000   | 1     |

  @SID_12
  Scenario: Validate Top Applications Line Charts Values pps
    Then UI Click Button "Dropdown Units" with value "Top Applications"
    Then UI Click Button "pps Units" with value "Top Applications"
    Then Sleep "5"
    Then UI Validate Line Chart data "Top Applications" with Label "FTP (20)"
      | value | offset | count |
      | 5     | 2      | 1     |
    Then UI Validate Line Chart data "Top Applications" with Label "HTTP (80)"
      | value | offset | count |
      | 2     | 2      | 1     |
    Then Sleep "3"
    Then UI Validate Line Chart data "Top Applications" with Label "XDMCP (177)"
      | value | offset | count |
      | 5     | 2      | 1     |
    Then UI Validate Line Chart data "Top Applications" with Label "SSH/SCP (22)"
      | value | offset | count |
      | 4     | 4      | 1     |
    Then UI Validate Line Chart data "Top Applications" with Label "N_A (153)"
      | value | offset | count |
      | 4     | 2      | 1     |


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
      | value | offset | count |
      | 2     | 2      | 1     |
    Then UI Validate Line Chart data "Top Applications" with Label "SSH/SCP (22)"
      | value | offset | count |
      | 4     | 2      | 1     |

                  #################  Last Week Trends Charts ##################

#
#  @SID_14
#  Scenario: Validate Last Week Trends Top Applications Bar Chart
#    Then UI Validate Line Chart data "trends-topApplication-bar" with Label "SNMT$25"
#      | value    | count |
#      | 98180964 | 1     |
#    Then UI Validate Line Chart data "trends-topApplication-bar" with Label "WINS Replication$42"
#      | value    | count |
#      | 48166687 | 1     |
#    Then UI Validate Line Chart data "trends-topApplication-bar" with Label "DNS$53"
#      | value    | count |
#      | 47884316 | 1     |
#    Then UI Validate Line Chart data "trends-topApplication-bar" with Label "HTTP$80"
#      | value     | count |
#      | 513738506 | 1     |
#    Then UI Validate Line Chart data "trends-topApplication-bar" with Label "HTTP over SSL$443"
#      | value     | count |
#      | 444607589 | 1     |
#
#
#  @SID_15
#  Scenario: Validate Last Week Trends Top Applications Doughnut Chart
#    Then UI Click Button "Switch doughnut Chart" with value "topApplication"
#    Then Sleep "5"
#    Then UI Validate Line Chart data "trends-topApplication-doughnut" with Label "HTTP"
#      | value            | count |
#      | 44.3057311897803 | 1     |
#    Then UI Validate Line Chart data "trends-topApplication-doughnut" with Label "HTTP over SSL"
#      | value             | count |
#      | 38.82248587132261 | 1     |
#    Then UI Validate Line Chart data "trends-topApplication-doughnut" with Label "SNMT"
#      | value             | count |
#      | 8.534295382013589 | 1     |
#    Then UI Validate Line Chart data "trends-topApplication-doughnut" with Label "WINS Replication"
#      | value             | count |
#      | 4.231309450764006 | 1     |
#    Then UI Validate Line Chart data "trends-topApplication-doughnut" with Label "SSH/SCP"
#      | value             | count |
#      | 4.106177797064031 | 1     |


  @SID_16
  Scenario: Logout and Close Browser
    Then UI logout and close browser