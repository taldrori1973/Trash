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
    Then CLI simulate 1 attacks of type "FlowDetector_test" on SetId "FNM_Set_0" as dest from src "10.18.2.19" and wait 200 seconds
    Then Sleep "100"

  @SID_2
  Scenario: Login and navigate to DF Analytics
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "DefenseFlow Analytics" page via homePage


  @SID_3
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Total bps
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label      | param | value     |
      | Top Source | 0     | 10.0.0.27 |
      | Top Source | 1     | 10.0.0.26 |
      | Top Source | 2     | 10.0.0.24 |
      | Top Source | 3     | 10.0.0.20 |
      | Top Source | 4     | 10.0.0.30 |


    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                  | param | value     | offset |
      | Top Source Total Value | 0     | 678.49 Mb | 20     |
      | Top Source Total Value | 1     | 662.97 Mb | 20     |
      | Top Source Total Value | 2     | 661.17 Mb | 20     |
      | Top Source Total Value | 3     | 652.86 Mb | 20     |
      | Top Source Total Value | 4     | 649.11 Mb | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                       | param | value   | offset |
      | Top Source Total Percentage | 0     | 10.47 % | 3      |
      | Top Source Total Percentage | 1     | 10.20 % | 3      |
      | Top Source Total Percentage | 2     | 10.21 % | 3      |
      | Top Source Total Percentage | 3     | 10.08 % | 3      |
      | Top Source Total Percentage | 4     | 10.02 % | 3      |

  @SID_4
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Total pps
    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "pps Units" with value "Top Source IP Addresses"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label      | param | value     |
      | Top Source | 0     | 10.0.0.23 |
      | Top Source | 1     | 10.0.0.32 |
      | Top Source | 2     | 10.0.0.24 |
      | Top Source | 3     | 10.0.0.25 |
      | Top Source | 4     | 10.0.0.22 |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                  | param | value | offset |
      | Top Source Total Value | 0     | 862 p | 20     |
      | Top Source Total Value | 1     | 846 p | 20     |
      | Top Source Total Value | 2     | 843 p | 20     |
      | Top Source Total Value | 3     | 823 p | 20     |
      | Top Source Total Value | 4     | 817 p | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                       | param | value   | offset |
      | Top Source Total Percentage | 0     | 10.53 % | 3      |
      | Top Source Total Percentage | 1     | 10.34 % | 3      |
      | Top Source Total Percentage | 2     | 10.30 % | 3      |
      | Top Source Total Percentage | 3     | 10.06 % | 3      |
      | Top Source Total Percentage | 4     | 9.98 %  | 3      |

  @SID_5
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Last bps
    Then UI Click Button "Dropdown Sort By" with value "Top Source IP Addresses"
    Then UI Click Button "Sort By Last" with value "Top Source IP Addresses"
    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "bps Units" with value "Top Source IP Addresses"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label      | param | value     |
      | Top Source | 0     | 10.0.0.24 |
      | Top Source | 1     | 10.0.0.20 |
      | Top Source | 2     | 10.0.0.31 |
      | Top Source | 3     | 10.0.0.25 |
      | Top Source | 4     | 10.0.0.32 |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                  | param | value     | offset |
      | Top Source Total Value | 0     | 2.21 Mbps | 10     |
      | Top Source Total Value | 1     | 2.21 Mbps | 10     |
      | Top Source Total Value | 2     | 2.17 Mbps | 10     |
      | Top Source Total Value | 3     | 2.09 Mbps | 10     |
      | Top Source Total Value | 4     | 2.06 Mbps | 10     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                       | param | value   | offset |
      | Top Source Total Percentage | 0     | 10.80 % | 3      |
      | Top Source Total Percentage | 1     | 10.79 % | 3      |
      | Top Source Total Percentage | 2     | 10.62 % | 3      |
      | Top Source Total Percentage | 3     | 10.21 % | 3      |
      | Top Source Total Percentage | 4     | 10.04 % | 3      |


  @SID_6
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Last pps
    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "pps Units" with value "Top Source IP Addresses"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label      | param | value     |
      | Top Source | 0     | 10.0.0.24 |
      | Top Source | 1     | 10.0.0.33 |
      | Top Source | 2     | 10.0.0.20 |
      | Top Source | 3     | 10.0.0.30 |
      | Top Source | 4     | 10.0.0.23 |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                  | param | value | offset |
      | Top Source Total Value | 0     | 3 pps | 10     |
      | Top Source Total Value | 1     | 3 pps | 10     |
      | Top Source Total Value | 2     | 3 pps | 10     |
      | Top Source Total Value | 3     | 2 pps | 10     |
      | Top Source Total Value | 4     | 2 pps | 10     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                       | param | value   | offset |
      | Top Source Total Percentage | 0     | 11.23 % | 3      |
      | Top Source Total Percentage | 1     | 10.99 % | 3      |
      | Top Source Total Percentage | 2     | 10.93 % | 3      |
      | Top Source Total Percentage | 3     | 9.90 %  | 3      |
      | Top Source Total Percentage | 4     | 9.78 %  | 3      |


  @SID_7
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Average bps
    Then UI Click Button "Dropdown Sort By" with value "Top Source IP Addresses"
    Then UI Click Button "Sort By Average" with value "Top Source IP Addresses"
    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "bps Units" with value "Top Source IP Addresses"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label      | param | value     |
      | Top Source | 0     | 10.0.0.27 |
      | Top Source | 1     | 10.0.0.24 |
      | Top Source | 2     | 10.0.0.26 |
      | Top Source | 3     | 10.0.0.20 |
      | Top Source | 4     | 10.0.0.30 |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                  | param | value     | offset |
      | Top Source Total Value | 0     | 2.83 Mbps | 10     |
      | Top Source Total Value | 1     | 2.76 Mbps | 10     |
      | Top Source Total Value | 2     | 2.75 Mbps | 10     |
      | Top Source Total Value | 3     | 2.72 Mbps | 10     |
      | Top Source Total Value | 4     | 2.7 Mbps  | 10     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                       | param | value   | offset |
      | Top Source Total Percentage | 0     | 10.34 % | 3      |
      | Top Source Total Percentage | 1     | 10.26 % | 3      |
      | Top Source Total Percentage | 2     | 10.20 % | 3      |
      | Top Source Total Percentage | 3     | 10.08 % | 3      |
      | Top Source Total Percentage | 4     | 10.07 % | 3      |

  @SID_8
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Average pps
    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "pps Units" with value "Top Source IP Addresses"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label      | param | value     |
      | Top Source | 0     | 10.0.0.23 |
      | Top Source | 1     | 10.0.0.32 |
      | Top Source | 2     | 10.0.0.24 |
      | Top Source | 3     | 10.0.0.22 |
      | Top Source | 4     | 10.0.0.31 |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                  | param | value | offset |
      | Top Source Total Value | 0     | 3 pps | 10     |
      | Top Source Total Value | 1     | 3 pps | 10     |
      | Top Source Total Value | 2     | 3 pps | 10     |
      | Top Source Total Value | 3     | 3 pps | 10     |
      | Top Source Total Value | 4     | 3 pps | 10     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                       | param | value   | offset |
      | Top Source Total Percentage | 0     | 10.56 % | 3      |
      | Top Source Total Percentage | 1     | 10.36 % | 3      |
      | Top Source Total Percentage | 2     | 10.33 % | 3      |
      | Top Source Total Percentage | 3     | 10.08 % | 3      |
      | Top Source Total Percentage | 4     | 10.01 % | 3      |


  @SID_9
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Max bps
    Then UI Click Button "Dropdown Sort By" with value "Top Source IP Addresses"
    Then UI Click Button "Sort By Max" with value "Top Source IP Addresses"
    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "bps Units" with value "Top Source IP Addresses"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label      | param | value     |
      | Top Source | 0     | 10.0.0.26 |
      | Top Source | 1     | 10.0.0.27 |
      | Top Source | 2     | 10.0.0.21 |
      | Top Source | 3     | 10.0.0.22 |
      | Top Source | 4     | 10.0.0.20 |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                  | param | value     | offset |
      | Top Source Total Value | 0     | 4.5 Mbps  | 10     |
      | Top Source Total Value | 1     | 4.41 Mbps | 10     |
      | Top Source Total Value | 2     | 4.39 Mbps | 10     |
      | Top Source Total Value | 3     | 4.31 Mbps | 10     |
      | Top Source Total Value | 4     | 4.29 Mbps | 10     |


    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                       | param | value   | offset |
      | Top Source Total Percentage | 0     | 10.49 % | 3      |
      | Top Source Total Percentage | 1     | 10.28 % | 3      |
      | Top Source Total Percentage | 2     | 10.23 % | 3      |
      | Top Source Total Percentage | 3     | 10.06 % | 3      |
      | Top Source Total Percentage | 4     | 9.99 %  | 3      |

  @SID_10
  Scenario: Validate Top Source IP Extended Widgets Values Sorted by Max pps
    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "pps Units" with value "Top Source IP Addresses"
    Then Sleep "3"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label      | param | value     |
      | Top Source | 0     | 10.0.0.31 |
      | Top Source | 1     | 10.0.0.25 |
      | Top Source | 2     | 10.0.0.23 |
      | Top Source | 3     | 10.0.0.32 |
      | Top Source | 4     | 10.0.0.30 |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                  | param | value | offset |
      | Top Source Total Value | 0     | 6 pps | 10     |
      | Top Source Total Value | 1     | 5 pps | 10     |
      | Top Source Total Value | 2     | 5 pps | 10     |
      | Top Source Total Value | 3     | 5 pps | 10     |
      | Top Source Total Value | 4     | 5 pps | 10     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                       | param | value   | offset |
      | Top Source Total Percentage | 0     | 11.11 % | 3      |
      | Top Source Total Percentage | 1     | 9.25 %  | 3      |
      | Top Source Total Percentage | 2     | 9.25 %  | 3      |
      | Top Source Total Percentage | 3     | 9.25 %  | 3      |
      | Top Source Total Percentage | 4     | 9.25 %  | 3      |

              ################  Line Charts ##################

  @SID_11
  Scenario: Validate Top Source IP Line Charts Values bps
    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "bps Units" with value "Top Source IP Addresses"
    Then Sleep "5"
    Then UI Validate Line Chart data "Top Source IP Addresses" with Label "10.0.0.27"
      | value | offset | count |
      | 610   | 20     | 1     |
    Then UI Validate Line Chart data "Top Source IP Addresses" with Label "10.0.0.24"
      | value | offset | count |
      | 554   | 20     | 1     |
    Then UI Validate Line Chart data "Top Source IP Addresses" with Label "10.0.0.26"
      | value | offset | count |
      | 586   | 20     | 1     |
    Then UI Validate Line Chart data "Top Source IP Addresses" with Label "10.0.0.20"
      | value | offset | count |
      | 781   | 20     | 1     |
    Then UI Validate Line Chart data "Top Source IP Addresses" with Label "10.0.0.30"
      | value | offset | count |
      | 688   | 20     | 1     |

  @SID_12
  Scenario: Validate Top Source IP Line Charts Values pps
    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "pps Units" with value "Top Source IP Addresses"
    Then Sleep "5"
    Then UI Validate Line Chart data "Top Source IP Addresses" with Label "10.0.0.23"
      | value | offset | count |
      | 2     | 20     | 1     |
    Then UI Validate Line Chart data "Top Source IP Addresses" with Label "10.0.0.32"
      | value | offset | count |
      | 2     | 20     | 1     |
    Then UI Validate Line Chart data "Top Source IP Addresses" with Label "10.0.0.24"
      | value | offset | count |
      | 2     | 20     | 1     |
    Then UI Validate Line Chart data "Top Source IP Addresses" with Label "10.0.0.22"
      | value | offset | count |
      | 2     | 20     | 1     |
    Then UI Validate Line Chart data "Top Source IP Addresses" with Label "10.0.0.22"
      | value | offset | count |
      | 2     | 20     | 1     |


  @SID_16
  Scenario: Logout and Close Browser
    Then UI logout and close browser