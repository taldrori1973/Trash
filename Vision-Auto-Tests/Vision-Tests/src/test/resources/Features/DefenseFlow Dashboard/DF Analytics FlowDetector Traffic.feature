@TC127419
Feature: DF Analytics FlowDetector Traffic
  @SID_1
  Scenario:  Clean system First Then Send Attacks
    * CLI kill all simulator attacks on current vision
    #* REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "df-a*"
    * REST Delete ES index "df-t*"
    * REST Delete ES index "traffic*"
    * REST Delete ES index "attacks*"
    * CLI Clear vision logs
    Then CLI simulate 1 attacks of prefix type "FNM2" on SetId "FNM_Set_0" as dest from src "10.18.2.19" and wait 50 seconds
    * CLI kill all simulator attacks on current vision
    Then Sleep "150"


  @SID_2
  Scenario: Login With Radware and Navigate to DF Analytics
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "DefenseFlow Analytics" page via homePage

  @SID_3
  Scenario: Check disable checkbox with no data in chart
    Then UI Click Button "Attribute CheckBox" with value "inbound"
    Then UI Click Button "Attribute CheckBox" with value "inboundDropped"
    Then UI Click Button "Attribute CheckBox" with value "outbound"
    Then UI Click Button "Attribute CheckBox" with value "outboundDropped"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "inbound" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "inboundDropped" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "outbound" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "outboundDropped" is "EQUALS" to "false"


  @SID_4
  Scenario: Check enable checkbox with no data in chart
    Then UI Click Button "Attribute CheckBox" with value "inbound"
    Then UI Click Button "Attribute CheckBox" with value "inboundDropped"
    Then UI Click Button "Attribute CheckBox" with value "outbound"
    Then UI Click Button "Attribute CheckBox" with value "outboundDropped"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "inbound" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "inboundDropped" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "outbound" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "outboundDropped" is "EQUALS" to "true"


  @SID_5
  Scenario: Validate labels AVG and Max value

    Then UI Validate Text field "AVG Value" with params "ceInbound" EQUALS "959.8"
    Then UI Validate Text field "Max Value" with params "ceInbound" EQUALS "2.7"
    Then UI Validate Text field "FlowDetector Traffic Label Value" with params "ceInbound" EQUALS "1.7G"
    Then UI Validate Text field "AVG Value" with params "ceDropped" EQUALS "0"
    Then UI Validate Text field "Max Value" with params "ceDropped" EQUALS "0"
    Then UI Validate Text field "FlowDetector Traffic Label Value" with params "ceDropped" EQUALS "0"
    Then UI Validate Text field "AVG Value" with params "ceOutbound" EQUALS "0"
    Then UI Validate Text field "Max Value" with params "ceOutbound" EQUALS "0"
    Then UI Validate Text field "FlowDetector Traffic Label Value" with params "ceOutbound" EQUALS "0"
    Then UI Validate Text field "AVG Value" with params "ceDroppedOut" EQUALS "0"
    Then UI Validate Text field "Max Value" with params "ceDroppedOut" EQUALS "0"
    Then UI Validate Text field "FlowDetector Traffic Label Value" with params "ceDroppedOut" EQUALS "0"

########################### Need to add data to validate ####################################
  @SID_6
  Scenario: Validate Chart data for each label
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Inbound"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Inbound Dropped"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Outbound"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Outbound Dropped"
      | value | min |
      | 0     | 1   |

  @SID_7
  Scenario: Validate Inbound and Dropped Inbound in 30m time range
    Then UI Click Button "Dropdown Direction" with value "FlowDetector Traffic"
    Then UI Click Button "FlowDetector Traffic Direction" with value "Inbound"
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "30m"
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Inbound"
      | value | min |
      | 0     | 1   |

    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Inbound Dropped"
      | value | min |
      | 0     | 1   |


  @SID_8
  Scenario: Validate Outbound and Dropped Outbound in 30m time range
    Then UI Click Button "Dropdown Direction" with value "FlowDetector Traffic"
    Then UI Click Button "FlowDetector Traffic Direction" with value "Outbound"
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "30m"
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Outbound"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Outbound Dropped"
      | value | min |
      | 0     | 1   |

  @SID_9
  Scenario: Validate data in TCP filter in 1H time range

    Then UI Click Button "Dropdown Direction" with value "FlowDetector Traffic"
    Then UI Click Button "FlowDetector Traffic Direction" with value "Both"
    Then UI Click Button "Dropdown Filter" with value "FlowDetector Traffic"
    Then UI Click Button "FlowDetector Traffic Filter" with value "TCP"
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1H"
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Inbound"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Inbound Dropped"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Outbound"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Outbound Dropped"
      | value | min |
      | 0     | 1   |


  @SID_10
  Scenario: Validate data in UDP filter in 1H time range
    Then UI Click Button "Dropdown Filter" with value "FlowDetector Traffic"
    Then UI Click Button "FlowDetector Traffic Filter" with value "UDP"
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Inbound"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Inbound Dropped"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Outbound"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Outbound Dropped"
      | value | min |
      | 0     | 1   |


  @SID_11
  Scenario: Validate data in ICMP filter in 1H time range
    Then UI Click Button "Dropdown Filter" with value "FlowDetector Traffic"
    Then UI Click Button "FlowDetector Traffic Filter" with value "ICMP"
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Inbound"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Inbound Dropped"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Outbound"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Outbound Dropped"
      | value | min |
      | 0     | 1   |

  @SID_12
  Scenario: Validate data in Other filter in 1H time range
    Then UI Click Button "Dropdown Filter" with value "FlowDetector Traffic"
    Then UI Click Button "FlowDetector Traffic Filter" with value "Other"
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "6H"
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Inbound"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Inbound Dropped"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Outbound"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Outbound Dropped"
      | value | min |
      | 0     | 1   |

  @SID_13
  Scenario: Validate data in Fragmented filter in 1H time range
    Then UI Click Button "Dropdown Filter" with value "FlowDetector Traffic"
    Then UI Click Button "FlowDetector Traffic Filter" with value "Fragmented"
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "15m"
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Inbound"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Outbound"
      | value | min |
      | 0     | 1   |


  @SID_14
  Scenario: Validate data in PPS Units in 1H time range
    Then UI Click Button "Dropdown Filter" with value "FlowDetector Traffic"
    Then UI Click Button "FlowDetector Traffic Filter" with value "All"
    Then UI Click Button "Dropdown Units" with value "FlowDetector Traffic"
    Then UI Click Button "pps Units" with value "FlowDetector Traffic"
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Inbound"
      | value | min |
      | 0     | 1   |

    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Inbound Dropped"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Outbound"
      | value | min |
      | 0     | 1   |
    Then UI Validate Line Chart data "flowDetector-traffic-chart" with Label "Outbound Dropped"
      | value | min |
      | 0     | 1   |
