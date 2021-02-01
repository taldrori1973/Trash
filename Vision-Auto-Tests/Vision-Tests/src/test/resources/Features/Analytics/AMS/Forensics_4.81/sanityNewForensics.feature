@TC119241
Feature: Basic tests for Forensics parameters

  @Test12
  @SID_1
  Scenario: Navigate to NEW ForensicsS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "New Forensics" page via homepage
    Then UI Click Button "New Forensics Tab"

  @SID_2
  Scenario: Validate Forensics Parameters Name
    Then UI Text of "Name Tab" equal to "Name"
    Then UI Text of "Time Tab" equal to "Time"
    Then UI Text of "Schedule Tab" equal to "Schedule"
    Then UI Text of "Share Tab" equal to "Share"
    Then UI Text of "Format Tab" equal to "Format"

  @SID_3
  Scenario: Forensics Name is selected
    Then UI Click Button "Name Tab"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label        | param | value |
      | Name Tab     |       | true  |
      | Time Tab     |       | false |
      | Schedule Tab |       | false |
      | Share Tab    |       | false |
      | Format Tab   |       | false |

  @SID_4
  Scenario: Forensics Time is selected
    Then UI Click Button "Time Tab"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label        | param | value |
      | Name Tab     |       | false |
      | Time Tab     |       | true  |
      | Schedule Tab |       | false |
      | Share Tab    |       | false |
      | Format Tab   |       | false |

  @SID_5
  Scenario: Forensics Schedule is selected
    Then UI Click Button "Schedule Tab"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label        | param | value |
      | Name Tab     |       | false |
      | Time Tab     |       | false |
      | Schedule Tab |       | true  |
      | Share Tab    |       | false |
      | Format Tab   |       | false |

  @SID_6
  Scenario: Forensics Share is selected
    Then UI Click Button "Share Tab"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label        | param | value |
      | Name Tab     |       | false |
      | Time Tab     |       | false |
      | Schedule Tab |       | false |
      | Share Tab    |       | true  |
      | Format Tab   |       | false |

  @SID_7
  Scenario: Forensics Format is selected
    Then UI Click Button "Format Tab"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label        | param | value |
      | Name Tab     |       | false |
      | Time Tab     |       | false |
      | Schedule Tab |       | false |
      | Share Tab    |       | false |
      | Format Tab   |       | true  |

  @SID_8
  Scenario: Forensics Product DefensePro is selected
    Then UI Click Button "Product Tab" with value "DefensePro"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label       | param       | value |
      | Product Tab | DefensePro  | true  |
      | Product Tab | DefenseFlow | false |
      | Product Tab | AppWall     | false |
#    Then UI Text of "Forensics Product Type" equal to "DefensePro"

  @SID_9
  Scenario: Forensics Product DefenseFlow is selected
    Then UI Click Button "Product Tab" with value "DefenseFlow"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label       | param       | value |
      | Product Tab | DefensePro  | false |
      | Product Tab | DefenseFlow | true  |
      | Product Tab | AppWall     | false |
#    Then UI Text of "Forensics Product Type" equal to "DefenseFlow"

  @SID_10
  Scenario: Forensics Product AppWall is selected
    Then UI Click Button "Product Tab" with value "AppWall"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label       | param       | value |
      | Product Tab | DefensePro  | false |
      | Product Tab | DefenseFlow | false |
      | Product Tab | AppWall     | true  |
#    Then UI Text of "Forensics Product Type" equal to "AppWall"

  @SID_11
  Scenario: Forensics Format HTML Button is clicked
    Then UI Click Button "Format HTML Type"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label                               | param | value |
      | Format HTML Type                    |       | true  |
      | Format CSV Type                     |       | false |
      | Format CSV With Attack Details Type |       | false |
    Then UI Text of "Forensics Format Type" with extension "html" equal to "HTML"

  @SID_12
  Scenario: Forensics Format CSV Button is clicked
    Then UI Click Button "Format CSV Type"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label                               | param | value |
      | Format HTML Type                    |       | false |
      | Format CSV Type                     |       | true  |
      | Format CSV With Attack Details Type |       | false |
    Then UI Text of "Forensics Format Type" with extension "csv" equal to "CSV"

  @SID_13
  Scenario: Forensics Format CSV With Attack Details Button is clicked
    Then UI Click Button "Format CSV With Attack Details Type"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label                               | param | value |
      | Format HTML Type                    |       | false |
      | Format CSV Type                     |       | false |
      | Format CSV With Attack Details Type |       | true  |
#  data-debug-id
#    Then UI Text of "Forensics Format Type" with extension "csv" equal to "CSV W/Details"

  ##################### Name Section tests ###############################

  @SID_14
  Scenario: Validate Forensics Name and Description
    Then UI Validate the attribute "placeholder" Of Label "Forensics Name" is "EQUALS" to "Type here"
    Then UI Set Text Field "Forensics Name" To " "
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "&"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "Test"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(212, 212, 212)"
    Then UI Set Text Field "Forensics Name" To "test~a"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test`"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test!!"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test#"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test$"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test%"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test^"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test&"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test*"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test+"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test="
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test\"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test-"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test?"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test["
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test]"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test'"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test;"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test,"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test/"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test{"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test}"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test:"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test<"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "test>"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Forensics Name" To "@"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(212, 212, 212)"
    Then UI Set Text Field "Forensics Name" To "("
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(212, 212, 212)"
    Then UI Set Text Field "Forensics Name" To ")"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Name" equals "rgb(212, 212, 212)"

    Then UI Set Text Field "Forensics Description" To "Description for Forensics"
    Then validate webUI CSS value "border-bottom-color" of label "Forensics Description" equals "rgb(212, 212, 212)"


    ########################## Schedule Tests #########################################################
  
  @SID_15
  Scenario: Forensics Schedule Daily is selected
    Then UI Click Button "Switch button Scheduled Forensics"
    Then UI Click Button "Schedule Forensics" with value "daily"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label           | param   | value |
      | Schedule Forensics | daily   | true  |
      | Schedule Forensics | weekly  | false |
      | Schedule Forensics | monthly | false |
      | Schedule Forensics | once    | false |


  @SID_16
  Scenario: Forensics Schedule Weekly is selected
    Then UI Click Button "Schedule Forensics" with value "weekly"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label           | param   | value |
      | Schedule Forensics | daily   | false |
      | Schedule Forensics | weekly  | true  |
      | Schedule Forensics | monthly | false |
      | Schedule Forensics | once    | false |


  @SID_17
  Scenario: Forensics Schedule Monthly is selected
    Then UI Click Button "Schedule Forensics" with value "monthly"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label           | param   | value |
      | Schedule Forensics | daily   | false |
      | Schedule Forensics | weekly  | false |
      | Schedule Forensics | monthly | true  |
      | Schedule Forensics | once    | false |


  @SID_18
  Scenario: Forensics Schedule Once is selected
    Then UI Click Button "Schedule Forensics" with value "once"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label           | param   | value |
      | Schedule Forensics | daily   | false |
      | Schedule Forensics | weekly  | false |
      | Schedule Forensics | monthly | false |
      | Schedule Forensics | once    | true  |

  
  @SID_19
  Scenario: Forensics Schedule Monthly - day of month
    Then UI Click Button "Schedule Forensics" with value "monthly"
    Then UI Set Text Field "Scheduling Day of Month input" To "-1"
    Then validate webUI CSS value "border-bottom-color" of label "Scheduling Day of Month" equals "rgb(244, 20, 20)"
    Then UI Validate Text field "Scheduling Month Error Message" CONTAINS "Select the day of the month."
    Then validate webUI CSS value "border-bottom-color" of label "Scheduling Month Error Message" equals "rgb(244, 20, 20)"


  @SID_20
  Scenario: Forensics Output - validate default values
    Then UI Click Button "outputExpandOrCollapse"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Start Time" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "End Time" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Threat Category" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Attack Name" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Policy Name" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Source IP Address" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Destination IP Address" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Destination Port" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Direction" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Protocol" is "EQUALS" to "true"



  @SID_21
  Scenario: Forensics Output - delete all selected output
    Then select forensics Output with details ""
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Start Time" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "End Time" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Threat Category" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Attack Name" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Policy Name" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Source IP Address" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Destination IP Address" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Destination Port" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Direction" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Protocol" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Device IP Address" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Action" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Attack ID" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Source Port" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Radware ID" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Duration" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Total Packets Dropped" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Max pps" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Total Mbits Dropped" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Max bps" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Physical Port" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Risk" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "VLAN Tag" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Packet Type" is "EQUALS" to "false"
    Then UI Click Button "outputExpandOrCollapse"
    ## add validate error message



  @SID_22
  Scenario: Forensics Output - select all output option
    Then select forensics Output with details "Start Time,End Time,Threat Category,Attack Name,Policy Name,Source IP Address,Destination IP Address,Destination Port,Direction,Protocol,Device IP Address,Action,Attack ID,Source Port,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag,Packet Type"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Start Time" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "End Time" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Threat Category" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Attack Name" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Policy Name" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Source IP Address" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Destination IP Address" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Destination Port" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Direction" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Protocol" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Device IP Address" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Action" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Attack ID" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Source Port" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Radware ID" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Duration" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Total Packets Dropped" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Max pps" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Total Mbits Dropped" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Max bps" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Physical Port" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Risk" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "VLAN Tag" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Packet Type" is "EQUALS" to "true"
    Then UI Click Button "outputExpandOrCollapse"




  @SID_22
  Scenario: Forensics Output - select all output option
    Then UI Validate Text field "Output Tab" CONTAINS "*"
