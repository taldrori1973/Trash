@TC127106
Feature:DF_analytics_Top Destination IP Addresses

  @SID_1
  Scenario: Clean system data before Top Source IPs Chart Test
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "df-traffic"
    * REST Delete ES index "df-attack"
    * REST Delete ES index "traffic*"
    * REST Delete ES index "attacks*"
    * CLI Clear vision logs
    Then CLI simulate 1 attacks of type "FlowDetector_test" on SetId "FNM_Set_0" as dest from src "10.18.2.19" and wait 200 seconds


  @SID_2
  Scenario: Login and navigate to DF Analytics
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "DefenseFlow Analytics" page via homePage


  @SID_3
  Scenario:validate all PO are selected
    When UI Do Operation "Select" item "ProtectedObjects ScopeSelection"
    Then UI validate CheckBox by ID "select all PO" if Selected "true"
    Then UI Click Button "Cancel Scope Selection"

    ##############validate with BPS side Bar All Protected Object###############################
  @SID_4
  Scenario:validate side bar of top destination ip Total

    Then UI Click Button "Dropdown Sort By" with value "Top Destination IP Addresses"
    Then UI Click Button "Sort By Total" with value "Top Destination IP Addresses"

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label           | param | value     |
      | Top Destination | 0     | 60.0.0.9  |
      | Top Destination | 1     | 60.0.0.10 |
      | Top Destination | 2     | 60.0.0.16 |
      | Top Destination | 3     | 60.0.0.4  |
      | Top Destination | 4     | 60.0.0.5  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                 | param | value    | offset |
      | Top Destination Total | 0     | 39.03 Gb | 20     |
      | Top Destination Total | 1     | 37.57 Gb | 20     |
      | Top Destination Total | 2     | 4.46 Gb  | 20     |
      | Top Destination Total | 3     | 4.38 Gb  | 20     |
      | Top Destination Total | 4     | 4.35 Gb  | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value  |
      | Top Destination TotalPercent | 0     | 31.63 % |
      | Top Destination TotalPercent | 1     | 20.02 % |
      | Top Destination TotalPercent | 2     | 7.13 %  |
      | Top Destination TotalPercent | 3     | 6.81 %  |
      | Top Destination TotalPercent | 4     | 6.70 %  |



  @SID_5
  Scenario:validate line chart data first 5 are checked
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "0" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "1" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "2" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "3" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "4" is "EQUALS" to "true"
#
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "5" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "6" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "7" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "8" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "9" is "EQUALS" to "false"

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.9"
      | value  | count | offset |
      | 254417 | 1     | 5      |


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.10"
      | value  | count | offset |
      | 283302 | 1     | 5      |


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.16"
      | value | count | offset |
      | 26823 | 1     | 5      |

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.4"
      | value | count | offset |
      | 34346 | 1     | 5      |

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.5"
      | value | count | offset |
      | 26555 | 1     | 5      |

  @SID_6
  Scenario:validate side bar of top destination ip Last
    Then UI Click Button "Dropdown Sort By" with value "Top Destination IP Addresses"
    Then UI Click Button "Sort By Last" with value "Top Destination IP Addresses"

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label           | param | value     |
      | Top Destination | 0     | 60.0.0.9  |
      | Top Destination | 1     | 60.0.0.10 |
      | Top Destination | 2     | 60.0.0.16 |
      | Top Destination | 3     | 60.0.0.4  |
      | Top Destination | 4     | 60.0.0.5  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                 | param | value    | offset |
      | Top Destination Total | 0     | 39.03 Gb | 20     |
      | Top Destination Total | 1     | 37.57 Gb | 20     |
      | Top Destination Total | 2     | 4.46 Gb  | 20     |
      | Top Destination Total | 3     | 4.38 Gb  | 20     |
      | Top Destination Total | 4     | 4.35 Gb  | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value  |
      | Top Destination TotalPercent | 0     | 31.63% |
      | Top Destination TotalPercent | 1     | 20.02% |
      | Top Destination TotalPercent | 2     | 7.13%  |
      | Top Destination TotalPercent | 3     | 6.81%  |
      | Top Destination TotalPercent | 4     | 6.70%  |

  @SID_7
  Scenario:validate line chart data first 5 are checked

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.10"
      | value | count | offset |
      | 79651 | 1     | 5      |


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.9"
      | value  | count | offset |
      | 149508 | 1     | 5      |


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.14"
      | value | count | offset |
      | 8503  | 1     | 5      |

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.13"
      | value | count | offset |
      | 8621  | 1     | 5      |

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.15"
      | value | count | offset |
      | 7901  | 1     | 5      |


  @SID_8
  Scenario:validate side bar of top destination ip Average
    Then UI Click Button "Dropdown Sort By" with value "Top Destination IP Addresses"
    Then UI Click Button "Sort By Average" with value "Top Destination IP Addresses"

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label           | param | value     |
      | Top Destination | 0     | 60.0.0.9  |
      | Top Destination | 1     | 60.0.0.10 |
      | Top Destination | 2     | 60.0.0.16 |
      | Top Destination | 3     | 60.0.0.4  |
      | Top Destination | 4     | 60.0.0.5  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                 | param | value    | offset |
      | Top Destination Total | 0     | 39.03 Gb | 20     |
      | Top Destination Total | 1     | 37.57 Gb | 20     |
      | Top Destination Total | 2     | 4.46 Gb  | 20     |
      | Top Destination Total | 3     | 4.38 Gb  | 20     |
      | Top Destination Total | 4     | 4.35 Gb  | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value  |
      | Top Destination TotalPercent | 0     | 31.63% |
      | Top Destination TotalPercent | 1     | 20.02% |
      | Top Destination TotalPercent | 2     | 7.13%  |
      | Top Destination TotalPercent | 3     | 6.81%  |
      | Top Destination TotalPercent | 4     | 6.70%  |

  @SID_9
  Scenario:validate line chart data first 5 are checked

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.9"
      | value | count | offset |
      | 3611  | 2     | 5      |


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.10"
      | value | count | offset |
      | 976   | 2     | 5      |


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.16"
      | value | count | offset |
      | 810   | 1     | 5      |

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.4"
      | value | count | offset |
      | 663   | 2     | 5      |

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.5"
      | value | count | offset |
      | 866   | 2     | 5      |

  @SID_10
  Scenario:validate side bar of top destination ip Max

    Then UI Click Button "Dropdown Sort By" with value "Top Destination IP Addresses"
    Then UI Click Button "Sort By Max" with value "Top Destination IP Addresses"

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label           | param | value     |
      | Top Destination | 0     | 60.0.0.9  |
      | Top Destination | 1     | 60.0.0.10 |
      | Top Destination | 2     | 60.0.0.16 |
      | Top Destination | 3     | 60.0.0.4  |
      | Top Destination | 4     | 60.0.0.5  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                 | param | value    | offset |
      | Top Destination Total | 0     | 39.03 Gb | 20     |
      | Top Destination Total | 1     | 37.57 Gb | 20     |
      | Top Destination Total | 2     | 4.46 Gb  | 20     |
      | Top Destination Total | 3     | 4.38 Gb  | 20     |
      | Top Destination Total | 4     | 4.35 Gb  | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value  |
      | Top Destination TotalPercent | 0     | 31.63% |
      | Top Destination TotalPercent | 1     | 20.02% |
      | Top Destination TotalPercent | 2     | 7.13%  |
      | Top Destination TotalPercent | 3     | 6.81%  |
      | Top Destination TotalPercent | 4     | 6.70%  |
  @SID_11
  Scenario:validate line chart data first 5 are checked
    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.2"
      | value | count | offset |
      | 3611  | 2     | 5      |


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.4"
      | value | count | offset |
      | 976   | 2     | 5      |


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.32"
      | value | count | offset |
      | 810   | 1     | 5      |

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.10"
      | value | count | offset |
      | 663   | 2     | 5      |

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.5"
      | value | count | offset |
      | 866   | 2     | 5      |

       ################ validate with PPS ###################
  @SID_12
  Scenario:validate side bar of top destinations ip

    Then UI Click Button "Dropdown Units" with value "Top Source IP Addresses"
    Then UI Click Button "pps Units" with value "Top Source IP Addresses"
    Then UI Click Button "Dropdown Sort By" with value "Top Destination IP Addresses"
    Then UI Click Button "Sort By Last" with value "Top Destination IP Addresses"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label           | param | value     |
      | Top Destination | 0     | 60.0.0.9  |
      | Top Destination | 1     | 60.0.0.10 |
      | Top Destination | 2     | 60.0.0.16 |
      | Top Destination | 3     | 60.0.0.4  |
      | Top Destination | 4     | 60.0.0.5  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                 | param | value    | offset |
      | Top Destination Total | 0     | 39.03 Gb | 20     |
      | Top Destination Total | 1     | 37.57 Gb | 20     |
      | Top Destination Total | 2     | 4.46 Gb  | 20     |
      | Top Destination Total | 3     | 4.38 Gb  | 20     |
      | Top Destination Total | 4     | 4.35 Gb  | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value  |
      | Top Destination TotalPercent | 0     | 31.63% |
      | Top Destination TotalPercent | 1     | 20.02% |
      | Top Destination TotalPercent | 2     | 7.13%  |
      | Top Destination TotalPercent | 3     | 6.81%  |
      | Top Destination TotalPercent | 4     | 6.70%  |

  @SID_13
  Scenario:validate line chart data first 5 are checked
    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.2"
      | value | count | offset |
      | 3611  | 2     | 5      |


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.4"
      | value | count | offset |
      | 976   | 2     | 5      |


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.32"
      | value | count | offset |
      | 810   | 1     | 5      |

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.10"
      | value | count | offset |
      | 663   | 2     | 5      |

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.5"
      | value | count | offset |
      | 866   | 2     | 5      |

  @SID_14
  Scenario:validate side bar of top destination ip Last
    Then UI Click Button "Dropdown Sort By" with value "Top Destination IP Addresses"
    Then UI Click Button "Sort By Total" with value "Top Destination IP Addresses"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label           | param | value     |
      | Top Destination | 0     | 60.0.0.9  |
      | Top Destination | 1     | 60.0.0.10 |
      | Top Destination | 2     | 60.0.0.16 |
      | Top Destination | 3     | 60.0.0.4  |
      | Top Destination | 4     | 60.0.0.5  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                 | param | value    | offset |
      | Top Destination Total | 0     | 39.03 Gb | 20     |
      | Top Destination Total | 1     | 37.57 Gb | 20     |
      | Top Destination Total | 2     | 4.46 Gb  | 20     |
      | Top Destination Total | 3     | 4.38 Gb  | 20     |
      | Top Destination Total | 4     | 4.35 Gb  | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value  |
      | Top Destination TotalPercent | 0     | 31.63% |
      | Top Destination TotalPercent | 1     | 20.02% |
      | Top Destination TotalPercent | 2     | 7.13%  |
      | Top Destination TotalPercent | 3     | 6.81%  |
      | Top Destination TotalPercent | 4     | 6.70%  |

  @SID_15
  Scenario:validate line chart data first 5 are checked


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.2"
      | value | count | offset |
      | 3611  | 2     | 5      |


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.4"
      | value | count | offset |
      | 976   | 2     | 5      |


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.32"
      | value | count | offset |
      | 810   | 1     | 5      |

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.10"
      | value | count | offset |
      | 663   | 2     | 5      |

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.5"
      | value | count | offset |
      | 866   | 2     | 5      |

  @SID_16
  Scenario:validate side bar of top destination ip Average

    Then UI Click Button "Dropdown Sort By" with value "Top Destination IP Addresses"
    Then UI Click Button "Sort By Average" with value "Top Destination IP Addresses"

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label           | param | value     |
      | Top Destination | 0     | 60.0.0.9  |
      | Top Destination | 1     | 60.0.0.10 |
      | Top Destination | 2     | 60.0.0.16 |
      | Top Destination | 3     | 60.0.0.4  |
      | Top Destination | 4     | 60.0.0.5  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                 | param | value    | offset |
      | Top Destination Total | 0     | 39.03 Gb | 20     |
      | Top Destination Total | 1     | 37.57 Gb | 20     |
      | Top Destination Total | 2     | 4.46 Gb  | 20     |
      | Top Destination Total | 3     | 4.38 Gb  | 20     |
      | Top Destination Total | 4     | 4.35 Gb  | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value  |
      | Top Destination TotalPercent | 0     | 31.63% |
      | Top Destination TotalPercent | 1     | 20.02% |
      | Top Destination TotalPercent | 2     | 7.13%  |
      | Top Destination TotalPercent | 3     | 6.81%  |
      | Top Destination TotalPercent | 4     | 6.70%  |

  @SID_17
  Scenario:validate line chart data first 5 are checked


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.2"
      | value | count | offset |
      | 3611  | 2     | 5      |


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.4"
      | value | count | offset |
      | 976   | 2     | 5      |


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.32"
      | value | count | offset |
      | 810   | 1     | 5      |

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.10"
      | value | count | offset |
      | 663   | 2     | 5      |

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.5"
      | value | count | offset |
      | 866   | 2     | 5      |

  @SID_18
  Scenario:validate side bar of top destination ip Max

    Then UI Click Button "Dropdown Sort By" with value "Top Destination IP Addresses"
    Then UI Click Button "Sort By Max" with value "Top Destination IP Addresses"

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label           | param | value     |
      | Top Destination | 0     | 60.0.0.9  |
      | Top Destination | 1     | 60.0.0.10 |
      | Top Destination | 2     | 60.0.0.16 |
      | Top Destination | 3     | 60.0.0.4  |
      | Top Destination | 4     | 60.0.0.5  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                 | param | value    | offset |
      | Top Destination Total | 0     | 39.03 Gb | 20     |
      | Top Destination Total | 1     | 37.57 Gb | 20     |
      | Top Destination Total | 2     | 4.46 Gb  | 20     |
      | Top Destination Total | 3     | 4.38 Gb  | 20     |
      | Top Destination Total | 4     | 4.35 Gb  | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                        | param | value  |
      | Top Destination TotalPercent | 0     | 31.63% |
      | Top Destination TotalPercent | 1     | 20.02% |
      | Top Destination TotalPercent | 2     | 7.13%  |
      | Top Destination TotalPercent | 3     | 6.81%  |
      | Top Destination TotalPercent | 4     | 6.70%  |


  @SID_19
  Scenario:validate line chart data first 5 are checked


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.2"
      | value | count | offset |
      | 3611  | 2     | 5      |


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.4"
      | value | count | offset |
      | 976   | 2     | 5      |


    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.32"
      | value | count | offset |
      | 810   | 1     | 5      |

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.10"
      | value | count | offset |
      | 663   | 2     | 5      |

    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.5"
      | value | count | offset |
      | 866   | 2     | 5      |


#    ################## validate filtering protected object #########################
#
#  @SID_20
#  Scenario: choose OP from the scope selection
#    When UI Do Operation "Select" item "Protected Objects"
#    Then UI Select scope from dashboard and Save Filter device type "defenseflow"
#      | PO_100 |
#      | PO_200 |
#
#  @SID_21
#  Scenario:validate side bar of top destination ip
#
#    Then UI Select "bps" from Vision dropdown "Units"
#    Then UI Select "Total" from Vision dropdown "Sort By"
#    Then UI Validate Text field "Top Destination" with params "0" EQUALS "60.0.0.2"
#    Then UI Validate Text field "Top Destination Total" with params "0" EQUALS "26.03 Gb"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "0" EQUALS "36.71%"
#
#
#    Then UI Validate Text field "Top Destination" with params "1" EQUALS "60.0.0.7"
#    Then UI Validate Text field "Top Destination Total" with params "1" EQUALS "5.26 Gb"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "1" EQUALS "7.42%"
#
#    Then UI Validate Text field "Top Destination" with params "2" EQUALS "60.0.0.3"
#    Then UI Validate Text field "Top Destination Total" with params "2" EQUALS "5.23 Gb"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "2" EQUALS "7.38%"
#
#
#    Then UI Validate Text field "Top Destination" with params "3" EQUALS "60.0.0.10"
#    Then UI Validate Text field "Top Destination Total" with params "3" EQUALS "5.11 Gb"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "3" EQUALS "7.20%"
#
#    Then UI Validate Text field "Top Destination" with params "4" EQUALS "60.0.0.8"
#    Then UI Validate Text field "Top Destination Total" EQUALS "4.97 Gb"
#    Then UI Validate Text field "Top Destination TotalPercent" EQUALS "7.01%"
#
#  @SID_12
#  Scenario:validate line chart data first 5 are checked
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "0" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "1" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "2" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "3" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "4" is "EQUALS" to "true"
#
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "5" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "6" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "7" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "8" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "9" is "EQUALS" to "false"
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.2"
#      | value | count | offset |
#      | 3611  | 3     | 5      |
#
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.7"
#      | value | count | offset |
#      | 976   | 3     | 5      |
#
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.3"
#      | value | count | offset |
#      | 810   | 1     | 5      |
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.10"
#      | value | count | offset |
#      | 663   | 2     | 5      |
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.8"
#      | value | count | offset |
#      | 866   | 2     | 5      |
#
#  @SID_5
#  Scenario:validate side bar of top destination ip Last
#    Then UI Select "Last" from Vision dropdown "Sort By"
#
#    Then UI Validate Text field "Top Destination" with params "0" EQUALS "60.0.0.2"
#    Then UI Validate Text field "Top Destination Total" with params "0" EQUALS "3.69 Mbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "0" EQUALS "32.89%"
#
#
#    Then UI Validate Text field "Top Destination" with params "1" EQUALS "60.0.0.4"
#    Then UI Validate Text field "Top Destination Total" with params "1" EQUALS "976 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "1" EQUALS "8.71%"
#
#    Then UI Validate Text field "Top Destination" with params "2" EQUALS "60.0.0.3"
#    Then UI Validate Text field "Top Destination Total" with params "2" EQUALS "921 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "2" EQUALS "8.22%"
#
#
#    Then UI Validate Text field "Top Destination" with params "3" EQUALS "60.0.0.10"
#    Then UI Validate Text field "Top Destination Total" with params "3" EQUALS "902 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "3" EQUALS "8.05%"
#
#    Then UI Validate Text field "Top Destination" with params "4" EQUALS "60.0.0.5"
#    Then UI Validate Text field "Top Destination Total" EQUALS "884 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" EQUALS "7.89%"
#
#  @SID_12
#  Scenario:validate line chart data first 5 are checked
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "0" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "1" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "2" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "3" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "4" is "EQUALS" to "true"
#
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "5" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "6" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "7" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "8" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "9" is "EQUALS" to "false"
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.2"
#      | value | count | offset |
#      | 3611  | 2     | 5      |
#
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.4"
#      | value | count | offset |
#      | 976   | 2     | 5      |
#
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.32"
#      | value | count | offset |
#      | 810   | 1     | 5      |
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.10"
#      | value | count | offset |
#      | 663   | 2     | 5      |
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.5"
#      | value | count | offset |
#      | 866   | 2     | 5      |
#
#
#
#  @SID_6
#  Scenario:validate side bar of top destination ip Average
#    Then UI Select "Average" from Vision dropdown "Sort By"
#    Then UI Validate Text field "Top Destination" with params "0" EQUALS "60.0.0.2"
#    Then UI Validate Text field "Top Destination Total" with params "0" EQUALS "3.69 Mbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "0" EQUALS "32.89%"
#
#
#    Then UI Validate Text field "Top Destination" with params "1" EQUALS "60.0.0.4"
#    Then UI Validate Text field "Top Destination Total" with params "1" EQUALS "976 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "1" EQUALS "8.71%"
#
#    Then UI Validate Text field "Top Destination" with params "2" EQUALS "60.0.0.3"
#    Then UI Validate Text field "Top Destination Total" with params "2" EQUALS "921 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "2" EQUALS "8.22%"
#
#
#    Then UI Validate Text field "Top Destination" with params "3" EQUALS "60.0.0.10"
#    Then UI Validate Text field "Top Destination Total" with params "3" EQUALS "902 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "3" EQUALS "8.05%"
#
#    Then UI Validate Text field "Top Destination" with params "4" EQUALS "60.0.0.5"
#    Then UI Validate Text field "Top Destination Total" EQUALS "884 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" EQUALS "7.89%"
#
#  @SID_12
#  Scenario:validate line chart data first 5 are checked
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "0" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "1" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "2" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "3" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "4" is "EQUALS" to "true"
#
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "5" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "6" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "7" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "8" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "9" is "EQUALS" to "false"
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.2"
#      | value | count | offset |
#      | 3611  | 2     | 5      |
#
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.4"
#      | value | count | offset |
#      | 976   | 2     | 5      |
#
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.32"
#      | value | count | offset |
#      | 810   | 1     | 5      |
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.10"
#      | value | count | offset |
#      | 663   | 2     | 5      |
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.5"
#      | value | count | offset |
#      | 866   | 2     | 5      |
#
#  @SID_7
#  Scenario:validate side bar of top destination ip Max
#
#    Then UI Select "Max" from Vision dropdown "Sort By"
#    Then UI Validate Text field "Top Destination" with params "0" EQUALS "60.0.0.2"
#    Then UI Validate Text field "Top Destination Total" with params "0" EQUALS "3.69 Mbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "0" EQUALS "32.89%"
#
#
#    Then UI Validate Text field "Top Destination" with params "1" EQUALS "60.0.0.4"
#    Then UI Validate Text field "Top Destination Total" with params "1" EQUALS "976 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "1" EQUALS "8.71%"
#
#    Then UI Validate Text field "Top Destination" with params "2" EQUALS "60.0.0.3"
#    Then UI Validate Text field "Top Destination Total" with params "2" EQUALS "921 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "2" EQUALS "8.22%"
#
#
#    Then UI Validate Text field "Top Destination" with params "3" EQUALS "60.0.0.10"
#    Then UI Validate Text field "Top Destination Total" with params "3" EQUALS "902 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "3" EQUALS "8.05%"
#
#    Then UI Validate Text field "Top Destination" with params "4" EQUALS "60.0.0.5"
#    Then UI Validate Text field "Top Destination Total" EQUALS "884 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" EQUALS "7.89%"
#
#  @SID_12
#  Scenario:validate line chart data first 5 are checked
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "0" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "1" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "2" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "3" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "4" is "EQUALS" to "true"
#
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "5" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "6" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "7" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "8" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "9" is "EQUALS" to "false"
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.2"
#      | value | count | offset |
#      | 3611  | 2     | 5      |
#
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.4"
#      | value | count | offset |
#      | 976   | 2     | 5      |
#
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.32"
#      | value | count | offset |
#      | 810   | 1     | 5      |
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.10"
#      | value | count | offset |
#      | 663   | 2     | 5      |
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.5"
#      | value | count | offset |
#      | 866   | 2     | 5      |
#
#       ################ validate with PPS ###################
#  @SID_8
#  Scenario:validate side bar of top destinations ip
#
#    Then UI Select "pps" from Vision dropdown "Units"
#    Then UI Select "Total" from Vision dropdown "Sort By"
#    Then UI Validate Text field "Top Destination" with params "0" EQUALS "60.0.0.2"
#    Then UI Validate Text field "Top Destination Total" with params "0" EQUALS "3.69 Mbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "0" EQUALS "32.89%"
#
#
#    Then UI Validate Text field "Top Destination" with params "1" EQUALS "60.0.0.4"
#    Then UI Validate Text field "Top Destination Total" with params "1" EQUALS "976 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "1" EQUALS "8.71%"
#
#    Then UI Validate Text field "Top Destination" with params "2" EQUALS "60.0.0.3"
#    Then UI Validate Text field "Top Destination Total" with params "2" EQUALS "921 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "2" EQUALS "8.22%"
#
#
#    Then UI Validate Text field "Top Destination" with params "3" EQUALS "60.0.0.10"
#    Then UI Validate Text field "Top Destination Total" with params "3" EQUALS "902 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "3" EQUALS "8.05%"
#
#    Then UI Validate Text field "Top Destination" with params "4" EQUALS "60.0.0.5"
#    Then UI Validate Text field "Top Destination Total" EQUALS "884 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" EQUALS "7.89%"
#
#  @SID_12
#  Scenario:validate line chart data first 5 are checked
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "0" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "1" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "2" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "3" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "4" is "EQUALS" to "true"
#
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "5" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "6" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "7" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "8" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "9" is "EQUALS" to "false"
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.2"
#      | value | count | offset |
#      | 3611  | 2     | 5      |
#
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.4"
#      | value | count | offset |
#      | 976   | 2     | 5      |
#
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.32"
#      | value | count | offset |
#      | 810   | 1     | 5      |
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.10"
#      | value | count | offset |
#      | 663   | 2     | 5      |
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.5"
#      | value | count | offset |
#      | 866   | 2     | 5      |
#
#  @SID_9
#  Scenario:validate side bar of top destination ip Last
#    Then UI Select "Last" from Vision dropdown "Sort By"
#    Then UI Validate Text field "Top Destination" with params "0" EQUALS "60.0.0.2"
#    Then UI Validate Text field "Top Destination Total" with params "0" EQUALS "3.69 Mbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "0" EQUALS "32.89%"
#
#
#    Then UI Validate Text field "Top Destination" with params "1" EQUALS "60.0.0.4"
#    Then UI Validate Text field "Top Destination Total" with params "1" EQUALS "976 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "1" EQUALS "8.71%"
#
#    Then UI Validate Text field "Top Destination" with params "2" EQUALS "60.0.0.3"
#    Then UI Validate Text field "Top Destination Total" with params "2" EQUALS "921 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "2" EQUALS "8.22%"
#
#
#    Then UI Validate Text field "Top Destination" with params "3" EQUALS "60.0.0.10"
#    Then UI Validate Text field "Top Destination Total" with params "3" EQUALS "902 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "3" EQUALS "8.05%"
#
#    Then UI Validate Text field "Top Destination" with params "4" EQUALS "60.0.0.5"
#    Then UI Validate Text field "Top Destination Total" EQUALS "884 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" EQUALS "7.89%"
#
#  @SID_12
#  Scenario:validate line chart data first 5 are checked
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "0" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "1" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "2" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "3" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "4" is "EQUALS" to "true"
#
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "5" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "6" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "7" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "8" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "9" is "EQUALS" to "false"
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.2"
#      | value | count | offset |
#      | 3611  | 2     | 5      |
#
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.4"
#      | value | count | offset |
#      | 976   | 2     | 5      |
#
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.32"
#      | value | count | offset |
#      | 810   | 1     | 5      |
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.10"
#      | value | count | offset |
#      | 663   | 2     | 5      |
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.5"
#      | value | count | offset |
#      | 866   | 2     | 5      |
#
#  @SID_10
#  Scenario:validate side bar of top destination ip Average
#
#    Then UI Select "Average" from Vision dropdown "Sort By"
#    Then UI Validate Text field "Top Destination" with params "0" EQUALS "60.0.0.2"
#    Then UI Validate Text field "Top Destination Total" with params "0" EQUALS "3.69 Mbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "0" EQUALS "32.89%"
#
#
#    Then UI Validate Text field "Top Destination" with params "1" EQUALS "60.0.0.4"
#    Then UI Validate Text field "Top Destination Total" with params "1" EQUALS "976 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "1" EQUALS "8.71%"
#
#    Then UI Validate Text field "Top Destination" with params "2" EQUALS "60.0.0.3"
#    Then UI Validate Text field "Top Destination Total" with params "2" EQUALS "921 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "2" EQUALS "8.22%"
#
#
#    Then UI Validate Text field "Top Destination" with params "3" EQUALS "60.0.0.10"
#    Then UI Validate Text field "Top Destination Total" with params "3" EQUALS "902 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "3" EQUALS "8.05%"
#
#    Then UI Validate Text field "Top Destination" with params "4" EQUALS "60.0.0.5"
#    Then UI Validate Text field "Top Destination Total" EQUALS "884 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" EQUALS "7.89%"
#
#  @SID_12
#  Scenario:validate line chart data first 5 are checked
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "0" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "1" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "2" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "3" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "4" is "EQUALS" to "true"
#
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "5" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "6" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "7" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "8" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "9" is "EQUALS" to "false"
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.2"
#      | value | count | offset |
#      | 3611  | 2     | 5      |
#
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.4"
#      | value | count | offset |
#      | 976   | 2     | 5      |
#
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.32"
#      | value | count | offset |
#      | 810   | 1     | 5      |
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.10"
#      | value | count | offset |
#      | 663   | 2     | 5      |
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.5"
#      | value | count | offset |
#      | 866   | 2     | 5      |
#
#  @SID_11
#  Scenario:validate side bar of top destination ip Max
#
#    Then UI Select "Max" from Vision dropdown "Sort By"
#    Then UI Validate Text field "Top Destination" with params "0" EQUALS "60.0.0.2"
#    Then UI Validate Text field "Top Destination Total" with params "0" EQUALS "3.69 Mbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "0" EQUALS "32.89%"
#
#
#    Then UI Validate Text field "Top Destination" with params "1" EQUALS "60.0.0.4"
#    Then UI Validate Text field "Top Destination Total" with params "1" EQUALS "976 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "1" EQUALS "8.71%"
#
#    Then UI Validate Text field "Top Destination" with params "2" EQUALS "60.0.0.3"
#    Then UI Validate Text field "Top Destination Total" with params "2" EQUALS "921 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "2" EQUALS "8.22%"
#
#
#    Then UI Validate Text field "Top Destination" with params "3" EQUALS "60.0.0.10"
#    Then UI Validate Text field "Top Destination Total" with params "3" EQUALS "902 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" with params "3" EQUALS "8.05%"
#
#    Then UI Validate Text field "Top Destination" with params "4" EQUALS "60.0.0.5"
#    Then UI Validate Text field "Top Destination Total" EQUALS "884 Kbps"
#    Then UI Validate Text field "Top Destination TotalPercent" EQUALS "7.89%"
#
#  @SID_12
#  Scenario:validate line chart data first 5 are checked
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "0" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "1" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "2" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "3" is "EQUALS" to "true"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "4" is "EQUALS" to "true"
#
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "5" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "6" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "7" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "8" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Top Destination Legends" With Params "9" is "EQUALS" to "false"
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.2"
#      | value | count | offset |
#      | 3611  | 2     | 5      |
#
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.4"
#      | value | count | offset |
#      | 976   | 2     | 5      |
#
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.32"
#      | value | count | offset |
#      | 810   | 1     | 5      |
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.10"
#      | value | count | offset |
#      | 663   | 2     | 5      |
#
#    Then UI Validate Line Chart data "Top Destination IP Addresses" with Label "60.0.0.5"
#      | value | count | offset |
#      | 866   | 2     | 5      |


