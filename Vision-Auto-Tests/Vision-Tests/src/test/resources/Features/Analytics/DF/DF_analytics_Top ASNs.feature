@TC127421
Feature: DF_analytics_Top ASNs

  @SID_1
  Scenario:  Clean system attacks
    * CLI kill all simulator attacks on current vision
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "df-attack*"
    * CLI Clear vision logs


  @SID_2
  Scenario:Login and Navigate df analytics  DashBoard
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "DefenseFlow Analytics" page via homePage


  @SID_3
  Scenario:validate all PO are selected
    When UI Do Operation "Select" item "ProtectedObjects ScopeSelection"
    Then UI validate CheckBox by ID "select all PO" if Selected "true"
    Then UI Click Button "" with value "Cancel Scope Selection"

    ##############validate with BPS side Bar All Protected Object###############################
  @SID_4
  Scenario:validate side bar of Top ASNs Total

    Then UI Click Button "Dropdown Sort By" with value "Top ASNs"
    Then UI Click Button "Sort By Total" with value "Top ASNs"

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label    | param | value     |
      | Top ASNs | 0     | ISI-AS, US (4)|
      | Top ASNs | 1     | UDEL-DCN, US (2)|
      | Top ASNs | 2     | RAND, US (21)|
      | Top ASNs | 3     | DNIC-AS-00013, US (13)|
      | Top ASNs | 4     | DSTL, EU (7)|

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label          | param | value    | offset |
      | Top ASNs Total | 0     | 2.74 Mbps| 20     |
      | Top ASNs Total | 1     | 2.72 Mbps| 20     |
      | Top ASNs Total | 2     | 2.69 Mbps| 20     |
      | Top ASNs Total | 3     | 2.67 Mbps| 20     |
      | Top ASNs Total | 4     | 2.64 Mbps| 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                 | param | value  |
      | Top ASNs TotalPercent | 0     | 31.63% |
      | Top ASNs TotalPercent | 1     | 20.02% |
      | Top ASNs TotalPercent | 2     | 7.13%  |
      | Top ASNs TotalPercent | 3     | 6.81%  |
      | Top ASNs TotalPercent | 4     | 6.70%  |

  @SID_12
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

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.2"
      | value | count | offset |
      | 3611  | 3     | 5      |


    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.7"
      | value | count | offset |
      | 976   | 3     | 5      |


    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.3"
      | value | count | offset |
      | 810   | 1     | 5      |

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.10"
      | value | count | offset |
      | 663   | 2     | 5      |

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.8"
      | value | count | offset |
      | 866   | 2     | 5      |

  @SID_5
  Scenario:validate side bar of Top ASNs  Last
    Then UI Click Button "Dropdown Sort By" with value "Top ASNs"
    Then UI Click Button "Sort By Last" with value "Top ASNs"

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label    | param | value     |
      | Top ASNs | 0     | 60.0.0.9  |
      | Top ASNs | 1     | 60.0.0.10 |
      | Top ASNs | 2     | 60.0.0.16 |
      | Top ASNs | 3     | 60.0.0.4  |
      | Top ASNs | 4     | 60.0.0.5  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label          | param | value    | offset |
      | Top ASNs Total | 0     | 39.03 Gb | 20     |
      | Top ASNs Total | 1     | 37.57 Gb | 20     |
      | Top ASNs Total | 2     | 4.46 Gb  | 20     |
      | Top ASNs Total | 3     | 4.38 Gb  | 20     |
      | Top ASNs Total | 4     | 4.35 Gb  | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                 | param | value  |
      | Top ASNs TotalPercent | 0     | 31.63% |
      | Top ASNs TotalPercent | 1     | 20.02% |
      | Top ASNs TotalPercent | 2     | 7.13%  |
      | Top ASNs TotalPercent | 3     | 6.81%  |
      | Top ASNs TotalPercent | 4     | 6.70%  |

  @SID_12
  Scenario:validate line chart data first 5 are checked
    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.2"
      | value | count | offset |
      | 3611  | 2     | 5      |


    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.4"
      | value | count | offset |
      | 976   | 2     | 5      |


    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.32"
      | value | count | offset |
      | 810   | 1     | 5      |

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.10"
      | value | count | offset |
      | 663   | 2     | 5      |

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.5"
      | value | count | offset |
      | 866   | 2     | 5      |


  @SID_6
  Scenario:validate side bar of Top ASNs Average
    Then UI Click Button "Dropdown Sort By" with value "Top ASNs"
    Then UI Click Button "Sort By Average" with value "Top ASNs"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label    | param | value     |
      | Top ASNs | 0     | 60.0.0.9  |
      | Top ASNs | 1     | 60.0.0.10 |
      | Top ASNs | 2     | 60.0.0.16 |
      | Top ASNs | 3     | 60.0.0.4  |
      | Top ASNs | 4     | 60.0.0.5  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label          | param | value    | offset |
      | Top ASNs Total | 0     | 39.03 Gb | 20     |
      | Top ASNs Total | 1     | 37.57 Gb | 20     |
      | Top ASNs Total | 2     | 4.46 Gb  | 20     |
      | Top ASNs Total | 3     | 4.38 Gb  | 20     |
      | Top ASNs Total | 4     | 4.35 Gb  | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                 | param | value  |
      | Top ASNs TotalPercent | 0     | 31.63% |
      | Top ASNs TotalPercent | 1     | 20.02% |
      | Top ASNs TotalPercent | 2     | 7.13%  |
      | Top ASNs TotalPercent | 3     | 6.81%  |
      | Top ASNs TotalPercent | 4     | 6.70%  |

  @SID_12
  Scenario:validate line chart data first 5 are checked

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.2"
      | value | count | offset |
      | 3611  | 2     | 5      |


    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.4"
      | value | count | offset |
      | 976   | 2     | 5      |


    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.32"
      | value | count | offset |
      | 810   | 1     | 5      |

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.10"
      | value | count | offset |
      | 663   | 2     | 5      |

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.5"
      | value | count | offset |
      | 866   | 2     | 5      |

  @SID_7
  Scenario:validate side bar of Top ASNs Max

    Then UI Click Button "Dropdown Sort By" with value "Top ASNs"
    Then UI Click Button "Sort By Max" with value "Top ASNs"
    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label    | param | value     |
      | Top ASNs | 0     | 60.0.0.9  |
      | Top ASNs | 1     | 60.0.0.10 |
      | Top ASNs | 2     | 60.0.0.16 |
      | Top ASNs | 3     | 60.0.0.4  |
      | Top ASNs | 4     | 60.0.0.5  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label          | param | value    | offset |
      | Top ASNs Total | 0     | 39.03 Gb | 20     |
      | Top ASNs Total | 1     | 37.57 Gb | 20     |
      | Top ASNs Total | 2     | 4.46 Gb  | 20     |
      | Top ASNs Total | 3     | 4.38 Gb  | 20     |
      | Top ASNs Total | 4     | 4.35 Gb  | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                 | param | value  |
      | Top ASNs TotalPercent | 0     | 31.63% |
      | Top ASNs TotalPercent | 1     | 20.02% |
      | Top ASNs TotalPercent | 2     | 7.13%  |
      | Top ASNs TotalPercent | 3     | 6.81%  |
      | Top ASNs TotalPercent | 4     | 6.70%  |


  @SID_12
  Scenario:validate line chart data first 5 are checked
    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.2"
      | value | count | offset |
      | 3611  | 2     | 5      |


    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.4"
      | value | count | offset |
      | 976   | 2     | 5      |


    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.32"
      | value | count | offset |
      | 810   | 1     | 5      |

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.10"
      | value | count | offset |
      | 663   | 2     | 5      |

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.5"
      | value | count | offset |
      | 866   | 2     | 5      |

      ###################################### validate with PPS ###############################################
  @SID_8
  Scenario:validate side bar of Top ASNs

    Then UI Click Button "Dropdown Units" with value "Top ASNs"
    Then UI Click Button "pps Units" with value "Top ASNs"
    Then UI Click Button "Dropdown Sort By" with value "Top ASNs"
    Then UI Click Button "Sort By Last" with value "Top ASNs"


    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label    | param | value     |
      | Top ASNs | 0     | 60.0.0.9  |
      | Top ASNs | 1     | 60.0.0.10 |
      | Top ASNs | 2     | 60.0.0.16 |
      | Top ASNs | 3     | 60.0.0.4  |
      | Top ASNs | 4     | 60.0.0.5  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label          | param | value    | offset |
      | Top ASNs Total | 0     | 39.03 Gb | 20     |
      | Top ASNs Total | 1     | 37.57 Gb | 20     |
      | Top ASNs Total | 2     | 4.46 Gb  | 20     |
      | Top ASNs Total | 3     | 4.38 Gb  | 20     |
      | Top ASNs Total | 4     | 4.35 Gb  | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                 | param | value  |
      | Top ASNs TotalPercent | 0     | 31.63% |
      | Top ASNs TotalPercent | 1     | 20.02% |
      | Top ASNs TotalPercent | 2     | 7.13%  |
      | Top ASNs TotalPercent | 3     | 6.81%  |
      | Top ASNs TotalPercent | 4     | 6.70%  |

  @SID_12
  Scenario:validate line chart data first 5 are checked

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.2"
      | value | count | offset |
      | 3611  | 2     | 5      |


    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.4"
      | value | count | offset |
      | 976   | 2     | 5      |


    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.32"
      | value | count | offset |
      | 810   | 1     | 5      |

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.10"
      | value | count | offset |
      | 663   | 2     | 5      |

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.5"
      | value | count | offset |
      | 866   | 2     | 5      |

  @SID_9
  Scenario:validate side bar of Top ASNs Total
    Then UI Click Button "Dropdown Sort By" with value "Top ASNs"
    Then UI Click Button "Sort By Total" with value "Top ASNs"


    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label    | param | value     |
      | Top ASNs | 0     | 60.0.0.9  |
      | Top ASNs | 1     | 60.0.0.10 |
      | Top ASNs | 2     | 60.0.0.16 |
      | Top ASNs | 3     | 60.0.0.4  |
      | Top ASNs | 4     | 60.0.0.5  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label          | param | value    | offset |
      | Top ASNs Total | 0     | 39.03 Gb | 20     |
      | Top ASNs Total | 1     | 37.57 Gb | 20     |
      | Top ASNs Total | 2     | 4.46 Gb  | 20     |
      | Top ASNs Total | 3     | 4.38 Gb  | 20     |
      | Top ASNs Total | 4     | 4.35 Gb  | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                 | param | value  |
      | Top ASNs TotalPercent | 0     | 31.63% |
      | Top ASNs TotalPercent | 1     | 20.02% |
      | Top ASNs TotalPercent | 2     | 7.13%  |
      | Top ASNs TotalPercent | 3     | 6.81%  |
      | Top ASNs TotalPercent | 4     | 6.70%  |

  @SID_12
  Scenario:validate line chart data first 5 are checked
    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.2"
      | value | count | offset |
      | 3611  | 2     | 5      |


    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.4"
      | value | count | offset |
      | 976   | 2     | 5      |


    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.32"
      | value | count | offset |
      | 810   | 1     | 5      |

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.10"
      | value | count | offset |
      | 663   | 2     | 5      |

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.5"
      | value | count | offset |
      | 866   | 2     | 5      |

  @SID_10
  Scenario:validate side bar of Top ASNs Average

    Then UI Click Button "Dropdown Sort By" with value "Top ASNs"
    Then UI Click Button "Sort By Average" with value "Top ASNs"


    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label    | param | value     |
      | Top ASNs | 0     | 60.0.0.9  |
      | Top ASNs | 1     | 60.0.0.10 |
      | Top ASNs | 2     | 60.0.0.16 |
      | Top ASNs | 3     | 60.0.0.4  |
      | Top ASNs | 4     | 60.0.0.5  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label          | param | value    | offset |
      | Top ASNs Total | 0     | 39.03 Gb | 20     |
      | Top ASNs Total | 1     | 37.57 Gb | 20     |
      | Top ASNs Total | 2     | 4.46 Gb  | 20     |
      | Top ASNs Total | 3     | 4.38 Gb  | 20     |
      | Top ASNs Total | 4     | 4.35 Gb  | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                 | param | value  |
      | Top ASNs TotalPercent | 0     | 31.63% |
      | Top ASNs TotalPercent | 1     | 20.02% |
      | Top ASNs TotalPercent | 2     | 7.13%  |
      | Top ASNs TotalPercent | 3     | 6.81%  |
      | Top ASNs TotalPercent | 4     | 6.70%  |

  @SID_12
  Scenario:validate line chart data first 5 are checked

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.2"
      | value | count | offset |
      | 3611  | 2     | 5      |


    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.4"
      | value | count | offset |
      | 976   | 2     | 5      |


    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.32"
      | value | count | offset |
      | 810   | 1     | 5      |

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.10"
      | value | count | offset |
      | 663   | 2     | 5      |

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.5"
      | value | count | offset |
      | 866   | 2     | 5      |

  @SID_11
  Scenario:validate side bar of Top ASNs Max

    Then UI Click Button "Dropdown Sort By" with value "Top ASNs"
    Then UI Click Button "Sort By Max" with value "Top ASNs"


    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label    | param | value     |
      | Top ASNs | 0     | 60.0.0.9  |
      | Top ASNs | 1     | 60.0.0.10 |
      | Top ASNs | 2     | 60.0.0.16 |
      | Top ASNs | 3     | 60.0.0.4  |
      | Top ASNs | 4     | 60.0.0.5  |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label          | param | value    | offset |
      | Top ASNs Total | 0     | 39.03 Gb | 20     |
      | Top ASNs Total | 1     | 37.57 Gb | 20     |
      | Top ASNs Total | 2     | 4.46 Gb  | 20     |
      | Top ASNs Total | 3     | 4.38 Gb  | 20     |
      | Top ASNs Total | 4     | 4.35 Gb  | 20     |

    Then UI Validate the attribute of "data-debug-value" are "EQUAL" to
      | label                 | param | value  |
      | Top ASNs TotalPercent | 0     | 31.63% |
      | Top ASNs TotalPercent | 1     | 20.02% |
      | Top ASNs TotalPercent | 2     | 7.13%  |
      | Top ASNs TotalPercent | 3     | 6.81%  |
      | Top ASNs TotalPercent | 4     | 6.70%  |

  @SID_12
  Scenario:validate line chart data first 5 are checked

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.2"
      | value | count | offset |
      | 3611  | 2     | 5      |


    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.4"
      | value | count | offset |
      | 976   | 2     | 5      |


    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.32"
      | value | count | offset |
      | 810   | 1     | 5      |

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.10"
      | value | count | offset |
      | 663   | 2     | 5      |

    Then UI Validate Line Chart data "Top ASNs" with Label "60.0.0.5"
      | value | count | offset |
      | 866   | 2     | 5      |


########################################## Last Week Trends Top ASNs ################################################

  @SID_14
  Scenario: Validate Last Week Trends Top ASNs Bar Chart
    Then UI Validate Line Chart data "trends-Top ASNs-bar" with Label "MIT-GATEWAYS, US"
      | value    | count |
      | 88242113 | 1     |


  @SID_15
  Scenario: Validate Last Week Trends Top ASNs Doughnut Chart
    Then UI Click Button "Switch doughnut Chart" with value "Top ASNs"
    Then Sleep "5"
    Then UI Validate Line Chart data "trends-Top ASNs-doughnut" with Label "MIT-GATEWAYS, US"
      | value              | count |
      | 57.876005652924654 | 1     |
