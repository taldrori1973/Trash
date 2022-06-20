@TC127093
Feature: Top Source IPs Chart

  @SID_1
  Scenario: Clean system data before Top Source IPs Chart Test
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "df-traffic"
    * REST Delete ES index "df-attack"
    * REST Delete ES index "traffic*"
    * REST Delete ES index "attacks*"
    * CLI Clear vision logs
    Then CLI simulate 1 attacks of prefix type "FNM2" on SetId "FNM_Set_0" as dest from src "10.18.2.19" and wait 200 seconds

  @SID_2
  Scenario: Login and navigate to DF Analytics
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "DefenseFlow Analytics" page via homePage


  @SID_3
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Total bps
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label      | param | value     |
      | Top Source | 0     | 10.0.0.33 |
      | Top Source | 1     | 10.0.0.30 |
      | Top Source | 2     | 10.0.0.21 |
      | Top Source | 3     | 10.0.0.32 |
      | Top Source | 4     | 10.0.0.22 |


    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                  | param | value     | offset |
      | Top Source Total Value | 0     | 632.15 Mb | 20     |
      | Top Source Total Value | 1     | 616.76 Mb | 20     |
      | Top Source Total Value | 2     | 605.47 Mb | 20     |
      | Top Source Total Value | 3     | 599.32 Mb | 20     |
      | Top Source Total Value | 4     | 598.74 Mb | 20     |

    Then UI Validate Text field "Top Source Total Percentage" with params "0" EQUALS "73.17%"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                       | param | value   |
      | Top Source Total Percentage | 0     | 10.58 % |
      | Top Source Total Percentage | 1     | 10.32 % |
      | Top Source Total Percentage | 2     | 10.13 % |
      | Top Source Total Percentage | 3     | 10.03 % |
      | Top Source Total Percentage | 4     | 10.02 % |

  @SID_4
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Total pps
    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "pps Units" with value "Top Source IP Addresses"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label      | param | value |
      | Top Source | 0     | TCP   |
      | Top Source | 1     | UDP   |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                  | param | value   |
      | Top Source Total Value | 0     | 8.85 Kp |
      | Top Source Total Value | 1     | 5.29 Kp |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                       | param | value  |
      | Top Source Total Percentage | 0     | 62.57% |
      | Top Source Total Percentage | 1     | 37.42% |

  @SID_5
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Last bps
    Then UI Click Button "Dropdown Sort By" with value "Top Source IP Addresses"
    Then UI Click Button "Sort By Last" with value "Top Source IP Addresses"
    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "bps Units" with value "Top Source IP Addresses"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label      | param | value     |
      | Top Source | 0     | 10.0.0.33 |
      | Top Source | 1     | 10.0.0.30 |
      | Top Source | 2     | 10.0.0.21 |
      | Top Source | 3     | 10.0.0.32 |
      | Top Source | 4     | 10.0.0.22 |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                  | param | value     |
      | Top Source Total Value | 0     | 1.15 Mbps |
      | Top Source Total Value | 1     | 989 Kbps  |
      | Top Source Total Value | 2     | 979 Kbps  |
      | Top Source Total Value | 3     | 945 Kbps  |
      | Top Source Total Value | 4     | 935 Kbps  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                       | param | value   |
      | Top Source Total Percentage | 0     | 12.47 % |
      | Top Source Total Percentage | 1     | 10.77 % |
      | Top Source Total Percentage | 2     | 10.66 % |
      | Top Source Total Percentage | 3     | 10.29 % |
      | Top Source Total Percentage | 4     | 10.18 % |


  @SID_6
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Last pps
    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "pps Units" with value "Top Source IP Addresses"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label      | param | value     |
      | Top Source | 0     | 10.0.0.33 |
      | Top Source | 1     | 10.0.0.30 |
      | Top Source | 2     | 10.0.0.21 |
      | Top Source | 3     | 10.0.0.32 |
      | Top Source | 4     | 10.0.0.22 |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                  | param | value     |
      | Top Source Total Value | 0     | 3.04 Mbps |
      | Top Source Total Value | 1     | 3.02 Mbps |
      | Top Source Total Value | 2     | 3 Mbps    |
      | Top Source Total Value | 3     | 2.96 Mbps |
      | Top Source Total Value | 4     | 2.96 Mbps |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                       | param | value   |
      | Top Source Total Percentage | 0     | 10.34 % |
      | Top Source Total Percentage | 1     | 10.26 % |
      | Top Source Total Percentage | 2     | 10.20 % |
      | Top Source Total Percentage | 3     | 10.08 % |
      | Top Source Total Percentage | 4     | 10.07 % |


  @SID_7
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Average bps
    Then UI Click Button "Dropdown Sort By" with value "Top Source IP Addresses"
    Then UI Click Button "Sort By Average" with value "Top Source IP Addresses"
    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "bps Units" with value "Top Source IP Addresses"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label      | param | value     |
      | Top Source | 0     | 10.0.0.33 |
      | Top Source | 1     | 10.0.0.30 |
      | Top Source | 2     | 10.0.0.21 |
      | Top Source | 3     | 10.0.0.32 |
      | Top Source | 4     | 10.0.0.22 |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                  | param | value     |
      | Top Source Total Value | 0     | 3.04 Mbps |
      | Top Source Total Value | 1     | 3.02 Mbps |
      | Top Source Total Value | 2     | 3 Mbps    |
      | Top Source Total Value | 3     | 2.96 Mbps |
      | Top Source Total Value | 4     | 2.96 Mbps |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                       | param | value   |
      | Top Source Total Percentage | 0     | 10.34 % |
      | Top Source Total Percentage | 1     | 10.26 % |
      | Top Source Total Percentage | 2     | 10.20 % |
      | Top Source Total Percentage | 3     | 10.08 % |
      | Top Source Total Percentage | 4     | 10.07 % |

  @SID_8
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Average pps
    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "pps Units" with value "Top Source IP Addresses"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label      | param | value |
      | Top Source | 0     | TCP   |
      | Top Source | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                  | param | value  |
      | Top Source Total Value | 0     | 20 pps |
      | Top Source Total Value | 1     | 12 pps |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                       | param | value  |
      | Top Source Total Percentage | 0     | 62.62% |
      | Top Source Total Percentage | 1     | 37.37% |


  @SID_9
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Max bps
    Then UI Click Button "Dropdown Sort By" with value "Top Source IP Addresses"
    Then UI Click Button "Sort By Max" with value "Top Source IP Addresses"
    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "bps Units" with value "Top Source IP Addresses"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label      | param | value     |
      | Top Source | 0     | 10.0.0.33 |
      | Top Source | 1     | 10.0.0.30 |
      | Top Source | 2     | 10.0.0.21 |
      | Top Source | 3     | 10.0.0.32 |
      | Top Source | 4     | 10.0.0.22 |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                  | param | value     |
      | Top Source Total Value | 0     | 4.36 Mbps |
      | Top Source Total Value | 1     | 4.19 Mbps |
      | Top Source Total Value | 2     | 4.18 Mbps |
      | Top Source Total Value | 3     | 4.1 Mbps  |
      | Top Source Total Value | 4     | 4.08 Mbps |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                       | param | value   |
      | Top Source Total Percentage | 0     | 10.71 % |
      | Top Source Total Percentage | 1     | 10.29 % |
      | Top Source Total Percentage | 2     | 10.27 % |
      | Top Source Total Percentage | 3     | 10.07 % |
      | Top Source Total Percentage | 4     | 10.02 % |

  @SID_10
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Max pps
    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "pps Units" with value "Top Source IP Addresses"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label      | param | value |
      | Top Source | 0     | TCP   |
      | Top Source | 1     | ICMP  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                  | param | value  |
      | Top Source Total Value | 0     | 31 pps |
      | Top Source Total Value | 1     | 19 pps |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                       | param | value  |
      | Top Source Total Percentage | 0     | 60.74% |
      | Top Source Total Percentage | 1     | 37.22% |

              ################  Line Charts ##################

  @SID_11
  Scenario: Validate Top Source IP Line Charts Values bps
    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "bps Units" with value "Top Source IP Addresses"
    Then Sleep "5"
    Then UI Validate Line Chart data "Top Source" with Label "TCP"
      | value | count |
      | 3607  | 0     |
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
    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "pps Units" with value "Top Source IP Addresses"
    Then Sleep "5"
    Then UI Validate Line Chart data "Top Source" with Label "TCP"
      | value | count |
      | 77    | 1     |
    Then UI Validate Line Chart data "Top Source" with Label "UDP"
      | value | count |
      | 65    | 1     |
    Then UI Validate Line Chart data "Top Source" with Label "TCP"
      | value | count |
      | 104   | 1     |
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


  @SID_16
  Scenario: Logout and Close Browser
    Then UI logout and close browser