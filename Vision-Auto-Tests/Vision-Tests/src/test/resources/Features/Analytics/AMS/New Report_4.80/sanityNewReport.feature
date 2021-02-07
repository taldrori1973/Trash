@TC117968
Feature: Basic tests for report parameters
  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: Validate Report Parameters Name
    Then UI Text of "Name Tab" equal to "Report Name*"
    Then UI Text of "Logo Tab" equal to "Logo"
    Then UI Text of "Time Tab" equal to "Time*"
    Then UI Text of "Schedule Tab" equal to "Schedule*"
    Then UI Text of "Share Tab" equal to "Share"
    Then UI Text of "Format Tab" equal to "Format"

  @SID_3
  Scenario: Report Name is selected
    Then UI Click Button "Name Tab"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label        | param | value |
      | Name Tab     |       | true  |
      | Logo Tab     |       | false |
      | Time Tab     |       | false |
      | Schedule Tab |       | false |
      | Share Tab    |       | false |
      | Format Tab   |       | false |

  @SID_4
  Scenario: Report Logo is selected
    Then UI Click Button "Logo Tab"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label        | param | value |
      | Name Tab     |       | false |
      | Logo Tab     |       | true  |
      | Time Tab     |       | false |
      | Schedule Tab |       | false |
      | Share Tab    |       | false |
      | Format Tab   |       | false |

  @SID_5
  Scenario: Report Time is selected
    Then UI Click Button "Time Tab"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label        | param | value |
      | Name Tab     |       | false |
      | Logo Tab     |       | false |
      | Time Tab     |       | true  |
      | Schedule Tab |       | false |
      | Share Tab    |       | false |
      | Format Tab   |       | false |

  @SID_6
  Scenario: Report Schedule is selected
    Then UI Click Button "Schedule Tab"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label        | param | value |
      | Name Tab     |       | false |
      | Logo Tab     |       | false |
      | Time Tab     |       | false |
      | Schedule Tab |       | true  |
      | Share Tab    |       | false |
      | Format Tab   |       | false |

  @SID_7
  Scenario: Report Share is selected
    Then UI Click Button "Share Tab"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label        | param | value |
      | Name Tab     |       | false |
      | Logo Tab     |       | false |
      | Time Tab     |       | false |
      | Schedule Tab |       | false |
      | Share Tab    |       | true  |
      | Format Tab   |       | false |

  @SID_8
  Scenario: Report Format is selected
    Then UI Click Button "Format Tab"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label        | param | value |
      | Name Tab     |       | false |
      | Logo Tab     |       | false |
      | Time Tab     |       | false |
      | Schedule Tab |       | false |
      | Share Tab    |       | false |
      | Format Tab   |       | true  |

  @SID_9
  Scenario: Validate report name
    Then UI Validate the attribute "placeholder" Of Label "Report Name" is "EQUALS" to "Type here"
    Then UI Set Text Field "Report Name" To " "
    Then Sleep "1"
    Then validate webUI CSS value "border-bottom-color" of label "Report Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Report Name" To "&"
    Then validate webUI CSS value "border-bottom-color" of label "Report Name" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Report Name" To "Test"
    Then validate webUI CSS value "border-bottom-color" of label "Report Name" equals "rgb(212, 212, 212)"

  @SID_10
  Scenario: Validate Logo
    Then UI Text of "Add Logo" equal to "Add Logo (PNG, 100×100)"
    Then UI Click Button "Add Logo"
    Then Upload file "reportLogoPNG.png"
    Then Upload file "invalidSizePngReportLogo.png"
    Then UI Validate Text field "Logo Size Message" CONTAINS "The graphic file that you selected is invalid. Select a 100×100-pixel .png file and try again"
    Then Upload file "invalidFormatReportLogo.jpg"
    Then UI Validate Text field "Logo Size Message" CONTAINS "The graphic file that you selected is invalid. Select a 100×100-pixel .png file and try again"

  @SID_11
  Scenario: Report Time - Quick Range is selected
    Then UI Click Button "Time Type" with value "quickrange"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label     | param      | value |
      | Time Type | quickrange | true  |
      | Time Type | absolute   | false |
      | Time Type | relative   | false |

  @SID_12
  Scenario: Report Time - Absolute is selected
    Then UI Click Button "Time Type" with value "absolute"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label     | param      | value |
      | Time Type | quickrange | false |
      | Time Type | absolute   | true  |
      | Time Type | relative   | false |

  @SID_13
  Scenario: Report Time - Relative is selected
    Then UI Click Button "Time Type" with value "relative"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label     | param      | value |
      | Time Type | quickrange | false |
      | Time Type | absolute   | false |
      | Time Type | relative   | true  |

  @SID_14
  Scenario: Validate Quick Range Time
    Then UI Click Button "Time Type" with value "quickrange"
    Then UI Click Button "Quick Range" with value "15m"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label       | param          | value |
      | Quick Range | 15m            | true  |
      | Quick Range | 30m            | false |
      | Quick Range | 1H             | false |
      | Quick Range | 1D             | false |
      | Quick Range | 1W             | false |
      | Quick Range | 1M             | false |
      | Quick Range | 3M             | false |
      | Quick Range | Today          | false |
      | Quick Range | Yesterday      | false |
      | Quick Range | This Week      | false |
      | Quick Range | This Month     | false |
      | Quick Range | Previous Month | false |
      | Quick Range | Quarter        | false |

  @SID_15
  Scenario: Time - Relative Hour button is selected
    Then UI Click Button "Time Type" with value "relative"
    Then UI Click Button "Relative Time Unit" with value "Hours"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label              | param  | value |
      | Relative Time Unit | Hours  | true  |
      | Relative Time Unit | Days   | false |
      | Relative Time Unit | Weeks  | false |
      | Relative Time Unit | Months | false |

  @SID_16
  Scenario: Time - Relative Days button is selected
    Then UI Click Button "Relative Time Unit" with value "Days"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label              | param  | value |
      | Relative Time Unit | Hours  | false |
      | Relative Time Unit | Days   | true  |
      | Relative Time Unit | Weeks  | false |
      | Relative Time Unit | Months | false |

  @SID_17
  Scenario: Time - Relative Weeks button is selected
    Then UI Click Button "Relative Time Unit" with value "Weeks"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label              | param  | value |
      | Relative Time Unit | Hours  | false |
      | Relative Time Unit | Days   | false |
      | Relative Time Unit | Weeks  | true  |
      | Relative Time Unit | Months | false |

  @SID_18
  Scenario: Time - Relative Months button is selected
    Then UI Click Button "Relative Time Unit" with value "Months"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label              | param  | value |
      | Relative Time Unit | Hours  | false |
      | Relative Time Unit | Days   | false |
      | Relative Time Unit | Weeks  | false |
      | Relative Time Unit | Months | true  |

  @SID_19
  Scenario: Validate Relative Time - Hours
    Then UI Click Button "Relative Time Unit" with value "Hours"
    Then UI Set Text Field "Relative Time Unit Value" and params "Hours" To "0"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Hours" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Relative Time Unit Value" and params "Hours" To "-1"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Hours" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Relative Time Unit Value" and params "Hours" To "8761"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Hours" equals "rgb(244, 20, 20)"

  @SID_20
  Scenario: Validate Relative Time - Days
    Then UI Click Button "Relative Time Unit" with value "Days"
    Then UI Set Text Field "Relative Time Unit Value" and params "Days" To "0"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Days" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Relative Time Unit Value" and params "Days" To "-1"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Days" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Relative Time Unit Value" and params "Days" To "366"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Days" equals "rgb(244, 20, 20)"

  @SID_21
  Scenario: Validate Relative Time - Weeks
    Then UI Click Button "Relative Time Unit" with value "Weeks"
    Then UI Set Text Field "Relative Time Unit Value" and params "Weeks" To "0"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Weeks" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Relative Time Unit Value" and params "Weeks" To "-1"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Weeks" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Relative Time Unit Value" and params "Weeks" To "53"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Weeks" equals "rgb(244, 20, 20)"

  @SID_22
  Scenario: Validate Relative Time - Months
    Then UI Click Button "Relative Time Unit" with value "Months"
    Then UI Set Text Field "Relative Time Unit Value" and params "Months" To "0"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Months" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Relative Time Unit Value" and params "Months" To "-1"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Months" equals "rgb(244, 20, 20)"
    Then UI Set Text Field "Relative Time Unit Value" and params "Months" To "13"
    Then validate webUI CSS value "border-bottom-color" of label "Relative Time Unit Value" with params "Months" equals "rgb(244, 20, 20)"

  @SID_23
  Scenario: Report Schedule Daily is selected
    Then UI Click Button "Switch button Scheduled Report"
    Then UI Click Button "Schedule Report" with value "daily"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label           | param   | value |
      | Schedule Report | daily   | true  |
      | Schedule Report | weekly  | false |
      | Schedule Report | monthly | false |
      | Schedule Report | once    | false |

  @SID_24
  Scenario: Report Schedule Weekly is selected
    Then UI Click Button "Schedule Report" with value "weekly"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label           | param   | value |
      | Schedule Report | daily   | false |
      | Schedule Report | weekly  | true  |
      | Schedule Report | monthly | false |
      | Schedule Report | once    | false |

  @SID_25
  Scenario: Report Schedule Monthly is selected
    Then UI Click Button "Schedule Report" with value "monthly"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label           | param   | value |
      | Schedule Report | daily   | false |
      | Schedule Report | weekly  | false |
      | Schedule Report | monthly | true  |
      | Schedule Report | once    | false |

  @SID_26
  Scenario: Report Schedule Once is selected
    Then UI Click Button "Schedule Report" with value "once"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label           | param   | value |
      | Schedule Report | daily   | false |
      | Schedule Report | weekly  | false |
      | Schedule Report | monthly | false |
      | Schedule Report | once    | true  |
#
#    @SID_27
#    Scenario: Validate Report Schedule Once
#      Then UI Select Time of label "Schedule Once Time" with value "2019-02-12 12:12" and pattern "yyyy-MM-dd HH:mm"
#      Then validate webUI CSS value "border-bottom-color" of label "Schedule Once Time" equals "rgb(255, 0, 0)"
#      Then UI Click Button "Schedule Report" with value "daily"
#      Then UI Click Button "Schedule Report" with value "once"
#      Then UI Select Time of label "Schedule Once Time" with value "2022-02-12 12:12" and pattern "yyyy-MM-dd HH:mm"
#      Then validate webUI CSS value "border-bottom-color" of label "Schedule Once Time" equals "rgb(8, 142, 177)"

  @SID_28
  Scenario: Validate Share send email To
    Then UI Validate the attribute "placeholder" Of Label "Email" is "EQUALS" to "E-mail To"
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

  @SID_29
  Scenario: Validate send email Subject
    Then UI Validate the attribute "placeholder" Of Label "Subject" is "EQUALS" to "Subject"

  @SID_30
  Scenario: Validate send email Type your message
    Then UI Validate the attribute "placeholder" Of Label "Email message" is "EQUALS" to "Type your message"

  @SID_31
  Scenario: Report Format PDF Button is clicked
    Then UI Click Button "Format Type" with value "PDF"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label       | param | value |
      | Format Type | PDF   | true  |
      | Format Type | HTML  | false |
      | Format Type | CSV   | false |

  @SID_32
  Scenario: Report Format HTML Button is clicked
    Then UI Click Button "Format Type" with value "HTML"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label       | param | value |
      | Format Type | PDF   | false |
      | Format Type | HTML  | true  |
      | Format Type | CSV   | false |

  @SID_33
  Scenario: Report Format CSV Button is clicked
    Then UI Click Button "Format Type" with value "CSV"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label       | param | value |
      | Format Type | PDF   | false |
      | Format Type | HTML  | false |
      | Format Type | CSV   | true  |

  @SID_34
  Scenario: Logout
    Then UI logout and close browser
