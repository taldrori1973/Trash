@TC119241
Feature: Basic tests for Forensics parameters

  
  @SID_1
  Scenario: Navigate to NEW ForensicsS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "New Forensics" page via homepage
    Then UI Click Button "New Forensics Tab"

  @SID_2
  Scenario: Validate Forensics Parameters Name
    Then UI Text of "Name Tab" equal to "Name*"
    Then UI Text of "Time Tab" equal to "Time*"
    Then UI Text of "Schedule Tab" equal to "Schedule"
    Then UI Text of "Share Tab" equal to "Share"
    Then UI Text of "Format Tab" equal to "Format*"

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

             ########################## Time Tests #########################################################
  @SID_20
  Scenario: Forensics Time - Quick Range is selected
    Then UI Click Button "Time Type" with value "quickrange"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label     | param      | value |
      | Time Type | quickrange | true  |
      | Time Type | absolute   | false |
      | Time Type | relative   | false |

  @SID_21
  Scenario: Forensics Time - Absolute is selected
    Then UI Click Button "Time Type" with value "absolute"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label     | param      | value |
      | Time Type | quickrange | false |
      | Time Type | absolute   | true  |
      | Time Type | relative   | false |

  @SID_22
  Scenario: Forensics Time - Relative is selected
    Then UI Click Button "Time Type" with value "relative"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label     | param      | value |
      | Time Type | quickrange | false |
      | Time Type | absolute   | false |
      | Time Type | relative   | true  |

  @SID_23
  Scenario: Validate Quick Range Time
    Then UI Click Button "Time Type" with value "quickrange"
    Then UI Click Button "Quick Range" with value "1D"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label       | param      | value |
      | Quick Range | 1D         | true  |
      | Quick Range | 1W         | false |
      | Quick Range | 1M         | false |
      | Quick Range | 3M         | false |
      | Quick Range | 1Y         | false |
      | Quick Range | Today      | false |
      | Quick Range | Yesterday  | false |
      | Quick Range | This Month | false |

  @SID_24
  Scenario: Time - Relative Hour button is selected
    Then UI Click Button "Time Type" with value "relative"
    Then UI Click Button "Relative Time Unit" with value "Hours"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label              | param  | value |
      | Relative Time Unit | Hours  | true  |
      | Relative Time Unit | Days   | false |
      | Relative Time Unit | Weeks  | false |
      | Relative Time Unit | Months | false |

  @SID_25
  Scenario: Time - Relative Days button is selected
    Then UI Click Button "Relative Time Unit" with value "Days"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label              | param  | value |
      | Relative Time Unit | Hours  | false |
      | Relative Time Unit | Days   | true  |
      | Relative Time Unit | Weeks  | false |
      | Relative Time Unit | Months | false |

  @SID_26
  Scenario: Time - Relative Weeks button is selected
    Then UI Click Button "Relative Time Unit" with value "Weeks"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label              | param  | value |
      | Relative Time Unit | Hours  | false |
      | Relative Time Unit | Days   | false |
      | Relative Time Unit | Weeks  | true  |
      | Relative Time Unit | Months | false |

  @SID_27
  Scenario: Time - Relative Months button is selected
    Then UI Click Button "Relative Time Unit" with value "Months"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label              | param  | value |
      | Relative Time Unit | Hours  | false |
      | Relative Time Unit | Days   | false |
      | Relative Time Unit | Weeks  | false |
      | Relative Time Unit | Months | true  |

  @SID_28
  Scenario: Validate Relative Time - Hours
    Then UI Click Button "Relative Time Unit" with value "Hours"
    Then UI Set Text Field "Relative Time Unit Value" and params "Hours" To "0"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Hours" equals "rgb(244, 20, 20)"
    Then UI Validate Text field "Relative Time Error Message" CONTAINS "Select a value between 1 and 8760 Hours."
    Then UI Set Text Field "Relative Time Unit Value" and params "Hours" To "-1"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Hours" equals "rgb(244, 20, 20)"
    Then UI Validate Text field "Relative Time Error Message" CONTAINS "Select a value between 1 and 8760 Hours."
    Then UI Set Text Field "Relative Time Unit Value" and params "Hours" To "8761"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Hours" equals "rgb(244, 20, 20)"
    Then UI Validate Text field "Relative Time Error Message" CONTAINS "Select a value between 1 and 8760 Hours."

  @SID_29
  Scenario: Validate Relative Time - Days
    Then UI Click Button "Relative Time Unit" with value "Days"
    Then UI Set Text Field "Relative Time Unit Value" and params "Days" To "0"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Days" equals "rgb(244, 20, 20)"
    Then UI Validate Text field "Relative Time Error Message" CONTAINS "Select a value between 1 and 365 Days."
    Then UI Set Text Field "Relative Time Unit Value" and params "Days" To "-1"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Days" equals "rgb(244, 20, 20)"
    Then UI Validate Text field "Relative Time Error Message" CONTAINS "Select a value between 1 and 365 Days."
    Then UI Set Text Field "Relative Time Unit Value" and params "Days" To "366"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Days" equals "rgb(244, 20, 20)"
    Then UI Validate Text field "Relative Time Error Message" CONTAINS "Select a value between 1 and 365 Days."

  @SID_30
  Scenario: Validate Relative Time - Weeks
    Then UI Click Button "Relative Time Unit" with value "Weeks"
    Then UI Set Text Field "Relative Time Unit Value" and params "Weeks" To "0"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Weeks" equals "rgb(244, 20, 20)"
    Then UI Validate Text field "Relative Time Error Message" CONTAINS "Select a value between 1 and 52 Weeks."
    Then UI Set Text Field "Relative Time Unit Value" and params "Weeks" To "-1"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Weeks" equals "rgb(244, 20, 20)"
    Then UI Validate Text field "Relative Time Error Message" CONTAINS "Select a value between 1 and 52 Weeks."
    Then UI Set Text Field "Relative Time Unit Value" and params "Weeks" To "53"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Weeks" equals "rgb(244, 20, 20)"
    Then UI Validate Text field "Relative Time Error Message" CONTAINS "Select a value between 1 and 52 Weeks."

  @SID_31
  Scenario: Validate Relative Time - Months
    Then UI Click Button "Relative Time Unit" with value "Months"
    Then UI Set Text Field "Relative Time Unit Value" and params "Months" To "0"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Months" equals "rgb(244, 20, 20)"
    Then UI Validate Text field "Relative Time Error Message" CONTAINS "Select a value between 1 and 12 Months."
    Then UI Set Text Field "Relative Time Unit Value" and params "Months" To "-1"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Months" equals "rgb(244, 20, 20)"
    Then UI Validate Text field "Relative Time Error Message" CONTAINS "Select a value between 1 and 12 Months."
    Then UI Set Text Field "Relative Time Unit Value" and params "Months" To "13"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Months" equals "rgb(244, 20, 20)"
    Then UI Validate Text field "Relative Time Error Message" CONTAINS "Select a value between 1 and 12 Months."

        ########################## Email Tests #########################################################

  @SID_32
  Scenario: Forensics Share Tab Label with value "email" is selected
    Then UI Click Button "Share Tab"
    Then UI Click Button "Share Tab Label" with value "email"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label           | param | value |
      | Share Tab Label | email | true  |
      | Share Tab Label | ftp   | false |

  @SID_33
  Scenario: Forensics Share Tab Label with value "email" is selected
    Then UI Click Button "Share Tab"
    Then UI Click Button "Share Tab Label" with value "ftp"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label           | param | value |
      | Share Tab Label | email | false |
      | Share Tab Label | ftp   | true  |

  @SID_34
  Scenario: Validate Share send email To
    Then UI Click Button "Share Tab Label" with value "email"
    Then UI Text of "Email Tab" equal to "E-mail To"
    Then UI Set Text Field "Email" To "example@example.com" enter Key true
    Then UI Validate Element Existence By Label "Email input" if Exists "true" with value "example@example.com,valid"
    Then UI Set Text Field "Email" To "example" enter Key true
    Then UI Validate Element Existence By Label "Email input" if Exists "true" with value "example,invalid"
    Then UI Set Text Field "Email" To "example." enter Key true
    Then UI Validate Element Existence By Label "Email input" if Exists "true" with value "example.,invalid"
    Then UI Set Text Field "Email" To "example@" enter Key true
    Then UI Validate Element Existence By Label "Email input" if Exists "true" with value "example@,invalid"
    Then UI Set Text Field "Email" To "example@example." enter Key true
    Then UI Validate Element Existence By Label "Email input" if Exists "true" with value "example@example.,invalid"
    Then UI Set Text Field "Email" To "example@example" enter Key true
    Then UI Validate Element Existence By Label "Email input" if Exists "true" with value "example@example,invalid"
    Then UI Set Text Field "Email" To "example.@example.com" enter Key true
    Then UI Validate Element Existence By Label "Email input" if Exists "true" with value "example.@example.com,invalid"
    Then UI Set Text Field "Email" To "example@example. example" enter Key true
    Then UI Validate Element Existence By Label "Email input" if Exists "true" with value "example@example. example,invalid"

  @SID_35
  Scenario: Validate send email Subject
#    no data febug id
#    Then UI Text of "Subject" equal to "Subject *"

  @SID_36
  Scenario: Validate send email Type your message
    Then UI Validate the attribute "placeholder" Of Label "Email message" is "EQUALS" to "Type your message"

  @SID_37
  Scenario: Validate FTP

############################ Output Test ##########################################################################################

  @SID_38
  Scenario: Forensics Output - select all output option of DefensePro
    Then UI Validate Text field "Output Tab" CONTAINS "*"

           ######################################## DefensePro ##########################################################
  @SID_39
  Scenario: Forensics Output - validate default values of DefensePro
    Then UI Click Button "Product Tab" with value "DefensePro"
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

  @SID_40
  Scenario: Forensics Output - delete all selected output of DefensePro
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

  @SID_41
  Scenario: Forensics Output - select all output option of DefensePro
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


    #############################################  DefenseFlow ###############################################

  @SID_41
  Scenario: Forensics Output - validate default values of DefenseFlow
    Then UI Click Button "Product Tab" with value "DefenseFlow"
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

  @SID_43
  Scenario: Forensics Output - delete all selected output of DefenseFlow
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

  @SID_44
  Scenario: Forensics Output - select all output option of DefenseFlow
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


#############################################  AppWall ###############################################

  @SID_45
  Scenario: Forensics Output - validate default values of AppWall
    Then UI Click Button "Product Tab" with value "AppWall"
    Then UI Click Button "outputExpandOrCollapse"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Date and Time" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Device IP" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Source IP" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Destination IP Address" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Source Port" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Cluster Manager IP" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Web Application Name" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Event Description" is "EQUALS" to "true"

  @SID_46
  Scenario: Forensics Output - delete all selected output of AppWall
    Then select forensics Output with details ""
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Date and Time" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Device IP" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Source IP" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Destination IP Address" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Source Port" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Cluster Manager IP" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Web Application Name" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Event Description" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Action" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Attack Name" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Device Host Name" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Directory" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Module" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Severity" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Threat Category" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Transaction ID" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Tunnel" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "User Name" is "EQUALS" to "false"
    Then UI Click Button "outputExpandOrCollapse"
    ## add validate error message

  @SID_47
  Scenario: Forensics Output - select all output option of AppWall
    Then select forensics Output with details "User Name,Tunnel,Transaction ID,Threat Category,Severity,Module,Directory,Device Host Name,Attack Name,Action,Event Description,Source IP,Device IP,Date and Time,Destination IP Address,Web Application Name,Source Port,Cluster Manager IP,"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Date and Time" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Device IP" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Source IP" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Destination IP Address" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Source Port" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Cluster Manager IP" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Web Application Name" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Event Description" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Action" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Attack Name" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Device Host Name" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Directory" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Module" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Severity" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Threat Category" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Transaction ID" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Tunnel" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "User Name" is "EQUALS" to "true"
    Then UI Click Button "outputExpandOrCollapse"




  @SID_48
  Scenario: Logout
    Then UI logout and close browser
