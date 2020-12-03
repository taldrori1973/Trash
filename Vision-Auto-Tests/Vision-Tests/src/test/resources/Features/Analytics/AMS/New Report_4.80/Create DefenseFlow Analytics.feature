@TC117964
Feature:DefenseFlow Analytics


  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

    # ------------------------------------------------------------------------------------------------------------------------------------------------------------
  @SID_2
  Scenario: Top Attacks by Duration Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Duration 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                   |
      | Logo                  | reportLogoPNG.png                                                                                             |
      | Time Definitions.Date | Quick:15m                                                                                                     |
    Then UI "Validate" Report With Name "Top Attacks by Duration 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                   |
      | Logo                  | reportLogoPNG.png                                                                                             |
      | Time Definitions.Date | Quick:15m                                                                                                     |
    Then UI Delete Report With Name "Top Attacks by Duration 1"


  @SID_3
  Scenario: Top Attacks by Duration Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Duration 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration],Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                               |
      | Logo                  | reportLogoPNG.png                                                                                         |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                            |
    Then UI "Validate" Report With Name "Top Attacks by Duration 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                             |
    Then UI Delete Report With Name "Top Attacks by Duration 2"

  @SID_4
  Scenario: Top Attacks by Duration Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Duration 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                               |
      | Time Definitions.Date | Relative:[Days,2]                                                                                          |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                               |
    Then UI "Validate" Report With Name "Top Attacks by Duration 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                               |
      | Time Definitions.Date | Relative:[Days,2]                                                                                          |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                               |
    Then UI Delete Report With Name "Top Attacks by Duration 3"

  @SID_5
  Scenario: Top Attacks by Duration Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Duration 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                   |
      | Time Definitions.Date | Relative:[Months,2]                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                |
    Then UI "Validate" Report With Name "Top Attacks by Duration 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                   |
      | Time Definitions.Date | Relative:[Months,2]                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                |
    Then UI Delete Report With Name "Top Attacks by Duration 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_6
  Scenario: Top Attacks by Count Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Count Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Count],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                 |
      | Logo                  | reportLogoPNG.png                                                                                           |
      | Time Definitions.Date | Quick:1D                                                                                                    |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[FRI]                                                                |
    Then UI "Validate" Report With Name "Top Attacks by Count Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Count],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                 |
      | Logo                  | reportLogoPNG.png                                                                                           |
      | Time Definitions.Date | Quick:1D                                                                                                    |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[FRI]                                                                |
    Then UI Delete Report With Name "Top Attacks by Count Report 1"

  @SID_7
  Scenario: Top Attacks by Count Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Count Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Count], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                             |
      | Logo                  | reportLogoPNG.png                                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                        |
      | Schedule              | Run Every:Once, On Time:+6H                                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                          |
    Then UI "Validate" Report With Name "Top Attacks by Count Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Count], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                             |
      | Logo                  | reportLogoPNG.png                                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                        |
      | Schedule              | Run Every:Once, On Time:+6H                                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                          |
    Then UI Delete Report With Name "Top Attacks by Count Report 2"

  @SID_8
  Scenario: Top Attacks by Count Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Count Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Count], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                            |
      | Time Definitions.Date | Quick:This Week                                                                                         |
    Then UI "Validate" Report With Name "Top Attacks by Count Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Count], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                            |
      | Time Definitions.Date | Quick:This Week                                                                                         |
    Then UI Delete Report With Name "Top Attacks by Count Report 3"

  @SID_9
  Scenario: Top Attacks by Count Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Count Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Count], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                |
      | Time Definitions.Date | Relative:[Days,3]                                                                                          |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                             |
    Then UI "Validate" Report With Name "Top Attacks by Count Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Count], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                |
      | Time Definitions.Date | Relative:[Days,3]                                                                                          |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                             |
    Then UI Delete Report With Name "Top Attacks by Count Report 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_10
  Scenario: Top Attacks by Rate Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Rate Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Rate],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Quick:This Week                                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                |
    Then UI "Validate" Report With Name "Top Attacks by Rate Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Rate],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Quick:This Week                                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                |
    Then UI Delete Report With Name "Top Attacks by Rate Report 1"

  @SID_11
  Scenario: Top Attacks by Rate Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Rate Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Rate], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                            |
      | Logo                  | reportLogoPNG.png                                                                                      |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                     |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[THU]                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
    Then UI "Validate" Report With Name "Top Attacks by Rate Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Rate], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                            |
      | Logo                  | reportLogoPNG.png                                                                                      |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                     |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[THU]                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
    Then UI Delete Report With Name "Top Attacks by Rate Report 2"

  @SID_12
  Scenario: Top Attacks by Rate Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Rate 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Rate], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                           |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                       |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                        |
    Then UI "Validate" Report With Name "Top Attacks by Rate 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Rate], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                           |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                       |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                        |
    Then UI Delete Report With Name "Top Attacks by Rate 3"

  @SID_13
  Scenario: Top Attacks by Rate Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Rate Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Rate], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                               |
      | Time Definitions.Date | Relative:[Months,4]                                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                            |
    Then UI "Validate" Report With Name "Top Attacks by Rate Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Rate], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                               |
      | Time Definitions.Date | Relative:[Months,4]                                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                            |
    Then UI Delete Report With Name "Top Attacks by Rate Report 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_14
  Scenario: Top Attacks by Protocol Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Protocol Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Protocol],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                    |
      | Logo                  | reportLogoPNG.png                                                                                              |
      | Time Definitions.Date | Quick:30m                                                                                                      |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[TUE]                                                                   |
    Then UI "Validate" Report With Name "Top Attacks by Protocol Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Protocol],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                    |
      | Logo                  | reportLogoPNG.png                                                                                              |
      | Time Definitions.Date | Quick:30m                                                                                                      |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[TUE]                                                                   |
    Then UI Delete Report With Name "Top Attacks by Protocol Report 1"

  @SID_15
  Scenario: Top Attacks by Protocol Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Protocol Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Protocol], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                             |
    Then UI "Validate" Report With Name "Top Attacks by Protocol Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Protocol], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                             |
    Then UI Delete Report With Name "Top Attacks by Protocol Report 2"

  @SID_16
  Scenario: Top Attacks by Protocol Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Protocol Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Protocol], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                               |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                         |
    Then UI "Validate" Report With Name "Top Attacks by Protocol Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Protocol], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                               |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                         |
    Then UI Delete Report With Name "Top Attacks by Protocol Report 3"

  @SID_17
  Scenario: Top Attacks by Protocol Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Protocol Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Protocol], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                   |
      | Time Definitions.Date | Quick:Quarter                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                |
    Then UI "Validate" Report With Name "Top Attacks by Protocol Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Protocol], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                   |
      | Time Definitions.Date | Quick:Quarter                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                |
    Then UI Delete Report With Name "Top Attacks by Protocol Report 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_18
  Scenario: Top Attack Destination Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Destination Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attack Destination],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                   |
      | Logo                  | reportLogoPNG.png                                                                                             |
      | Time Definitions.Date | Quick:Previous Month                                                                                          |
    Then UI "Validate" Report With Name "Top Attack Destination Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attack Destination],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                   |
      | Logo                  | reportLogoPNG.png                                                                                             |
      | Time Definitions.Date | Quick:Previous Month                                                                                          |
    Then UI Delete Report With Name "Top Attack Destination Report 1"

  @SID_19
  Scenario: Top Attack Destination Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Destination  Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attack Destination], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                               |
      | Logo                  | reportLogoPNG.png                                                                                         |
      | Time Definitions.Date | Quick:This Month                                                                                          |
      | Schedule              | Run Every:Once, On Time:+6H                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                            |
    Then UI "Validate" Report With Name "Top Attack Destination  Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attack Destination], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                               |
      | Logo                  | reportLogoPNG.png                                                                                         |
      | Time Definitions.Date | Quick:This Month                                                                                          |
      | Schedule              | Run Every:Once, On Time:+6H                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                            |
    Then UI Delete Report With Name "Top Attack Destination  Report 2"

  @SID_20
  Scenario: Top Attack Destination Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Destination Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attack Destination], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                           |
    Then UI "Validate" Report With Name "Top Attack Destination Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attack Destination], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                           |
    Then UI Delete Report With Name "Top Attack Destination Report 3"

  @SID_21
  Scenario: Top Attack Destination Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Destination Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attack Destination], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                  |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                           |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                               |
    Then UI "Validate" Report With Name "Top Attack Destination Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attack Destination], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                  |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                           |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                               |
    Then UI Delete Report With Name "Top Attack Destination Report 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_22
  Scenario: Top Attack Sources Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Sources Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attack Sources],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                               |
      | Logo                  | reportLogoPNG.png                                                                                         |
      | Time Definitions.Date | Quick:15m                                                                                                 |
    Then UI "Validate" Report With Name "Top Attack Sources Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attack Sources],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                               |
      | Logo                  | reportLogoPNG.png                                                                                         |
      | Time Definitions.Date | Quick:15m                                                                                                 |
    Then UI Delete Report With Name "Top Attack Sources Report 1"

  @SID_23
  Scenario: Top Attack Sources Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Sources Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attack Sources], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                           |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:This Week                                                                                       |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
    Then UI "Validate" Report With Name "Top Attack Sources Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attack Sources], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                           |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:This Week                                                                                       |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
    Then UI Delete Report With Name "Top Attack Sources Report 2"

  @SID_24
  Scenario: Top Attack Sources Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Sources Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attack Sources], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                       |
    Then UI "Validate" Report With Name "Top Attack Sources Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attack Sources], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                       |
    Then UI Delete Report With Name "Top Attack Sources Report 3"

  @SID_25
  Scenario: Top Attack Sources Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Sources Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attack Sources], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                       |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                           |
    Then UI "Validate" Report With Name "Top Attack Sources Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attack Sources], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                       |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                           |
    Then UI Delete Report With Name "Top Attack Sources Report 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_26
  Scenario: Traffic Bandwidth Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Bandwidth Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[30]}],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                       |
      | Logo                  | reportLogoPNG.png                                                                                                                 |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                  |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                                                      |
    Then UI "Validate" Report With Name "Traffic Bandwidth Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[30]}],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                       |
      | Logo                  | reportLogoPNG.png                                                                                                                 |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                  |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                                                      |
    Then UI Delete Report With Name "Traffic Bandwidth Report 1"

  @SID_27
  Scenario: Traffic Bandwidth Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Bandwidth Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[40]}], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                   |
      | Logo                  | reportLogoPNG.png                                                                                                             |
      | Time Definitions.Date | Quick:3M                                                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                |
    Then UI "Validate" Report With Name "Traffic Bandwidth Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[40]}], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                   |
      | Logo                  | reportLogoPNG.png                                                                                                             |
      | Time Definitions.Date | Quick:3M                                                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                |
    Then UI Delete Report With Name "Traffic Bandwidth Report 2"

  @SID_28
  Scenario: Traffic Bandwidth Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Bandwidth Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[All Protected Objects]}], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                    |
      | Time Definitions.Date | Quick:This Month                                                                                                                                |
    Then UI "Validate" Report With Name "Traffic Bandwidth Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[All Protected Objects]}], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                    |
      | Time Definitions.Date | Quick:This Month                                                                                                                                |
    Then UI Delete Report With Name "Traffic Bandwidth Report 3"

  @SID_29
  Scenario: Traffic Bandwidth Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Bandwidth Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[All Protected Objects]}], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                                      |
      | Time Definitions.Date | Quick:1H                                                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                   |
    Then UI "Validate" Report With Name "Traffic Bandwidth Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[All Protected Objects]}], Protected Objects:[All] |
      | Format                | Select: HTML                                                                                                      |
      | Time Definitions.Date | Quick:1H                                                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                   |
    Then UI Delete Report With Name "Traffic Bandwidth Report 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_30
  Scenario: Traffic Rate Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Rate Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Traffic Rate],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                         |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Quick:15m                                                                                           |
    Then UI "Validate" Report With Name "Traffic Rate Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Traffic Rate],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                         |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Quick:15m                                                                                           |
    Then UI Delete Report With Name "Traffic Rate Report 1"

  @SID_31
  Scenario: Traffic Rate Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Rate Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Traffic Rate], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                               |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |
    Then UI "Validate" Report With Name "Traffic Rate Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Traffic Rate], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                               |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |
    Then UI Delete Report With Name "Traffic Rate Report 2"

  @SID_32
  Scenario: Traffic Rate Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Rate Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Traffic Rate], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                     |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                                     |
    Then UI "Validate" Report With Name "Traffic Rate Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Traffic Rate], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                     |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                                     |
    Then UI Delete Report With Name "Traffic Rate Report 3"

  @SID_33
  Scenario: Traffic Rate Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Rate Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Traffic Rate], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                        |
      | Time Definitions.Date | Relative:[Months,4]                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                     |
    Then UI "Validate" Report With Name "Traffic Rate Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Traffic Rate], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                        |
      | Time Definitions.Date | Relative:[Months,4]                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                     |
    Then UI Delete Report With Name "Traffic Rate Report 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_34
  Scenario: DDoS Peak Attack per Period Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DDoS Peak Attack per Period Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[DDoS Peak Attack per Period],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                        |
      | Logo                  | reportLogoPNG.png                                                                                                  |
      | Time Definitions.Date | Quick:1D                                                                                                           |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[FRI]                                                                       |
    Then UI "Validate" Report With Name "DDoS Peak Attack per Period Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[DDoS Peak Attack per Period],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                        |
      | Logo                  | reportLogoPNG.png                                                                                                  |
      | Time Definitions.Date | Quick:1D                                                                                                           |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[FRI]                                                                       |
    Then UI Delete Report With Name "DDoS Peak Attack per Period Report 1"

  @SID_35
  Scenario: DDoS Peak Attack per Period Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DDoS Peak Attack per Period Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[DDoS Peak Attack per Period], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                    |
      | Logo                  | reportLogoPNG.png                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                               |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                 |
    Then UI "Validate" Report With Name "DDoS Peak Attack per Period Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[DDoS Peak Attack per Period], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                    |
      | Logo                  | reportLogoPNG.png                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                               |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                 |
    Then UI Delete Report With Name "DDoS Peak Attack per Period Report 2"

  @SID_36
  Scenario: DDoS Peak Attack per Period Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DDoS Peak Attack per Period Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[DDoS Peak Attack per Period], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                   |
      | Time Definitions.Date | Quick:This Week                                                                                                |
    Then UI "Validate" Report With Name "DDoS Peak Attack per Period Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[DDoS Peak Attack per Period], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                   |
      | Time Definitions.Date | Quick:This Week                                                                                                |
    Then UI Delete Report With Name "DDoS Peak Attack per Period Report 3"

  @SID_37
  Scenario: DDoS Peak Attack per Period Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DDoS Peak Attack per Period Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[DDoS Peak Attack per Period], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                       |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                    |
    Then UI "Validate" Report With Name "DDoS Peak Attack per Period Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[DDoS Peak Attack per Period], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                       |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                    |
    Then UI Delete Report With Name "DDoS Peak Attack per Period Report 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_38
  Scenario: DDoS Attack Activations per Period Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DDoS Attack Activations per Period Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[DDoS Attack Activations per Period],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                               |
      | Logo                  | reportLogoPNG.png                                                                                                         |
      | Time Definitions.Date | Quick:This Week                                                                                                           |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                               |
    Then UI "Validate" Report With Name "DDoS Attack Activations per Period Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[DDoS Attack Activations per Period],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                               |
      | Logo                  | reportLogoPNG.png                                                                                                         |
      | Time Definitions.Date | Quick:This Week                                                                                                           |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                               |
    Then UI Delete Report With Name "DDoS Attack Activations per Period Report 1"

  @SID_39
  Scenario: DDoS Attack Activations per Period Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DDoS Attack Activations per Period Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[DDoS Attack Activations per Period], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                            |
      | Logo                  | reportLogoPNG.png                                                                                                                      |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                     |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[THU]                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                         |
    Then UI "Validate" Report With Name "DDoS Attack Activations per Period Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[DDoS Attack Activations per Period], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                            |
      | Logo                  | reportLogoPNG.png                                                                                                                      |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                     |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[THU]                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                         |
    Then UI Delete Report With Name "DDoS Attack Activations per Period Report 2"

  @SID_40
  Scenario: DDoS Attack Activations per Period Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DDoS Attack Activations per Period Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[DDoS Attack Activations per Period], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                                       |
    Then UI "Validate" Report With Name "DDoS Attack Activations per Period Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[DDoS Attack Activations per Period], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                                       |
    Then UI Delete Report With Name "DDoS Attack Activations per Period Report 3"

  @SID_41
  Scenario: DDoS Attack Activations per Period Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DDoS Attack Activations per Period Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[DDoS Attack Activations per Period], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                              |
      | Time Definitions.Date | Relative:[Months,3]                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                           |
    Then UI "Validate" Report With Name "DDoS Attack Activations per Period Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[DDoS Attack Activations per Period], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                              |
      | Time Definitions.Date | Relative:[Months,3]                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                           |
    Then UI Delete Report With Name "DDoS Attack Activations per Period Report 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_42
  Scenario: Top 10 Activations by Duration Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top 10 Activations by Duration Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Duration],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                           |
      | Logo                  | reportLogoPNG.png                                                                                                     |
      | Time Definitions.Date | Quick:30m                                                                                                             |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[TUE]                                                                          |
    Then UI "Validate" Report With Name "Top 10 Activations by Duration Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Duration],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                           |
      | Logo                  | reportLogoPNG.png                                                                                                     |
      | Time Definitions.Date | Quick:30m                                                                                                             |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[TUE]                                                                          |
    Then UI Delete Report With Name "Top 10 Activations by Duration Report 1"

  @SID_43
  Scenario: Top 10 Activations by Duration Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top 10 Activations by Duration Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Duration], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                        |
      | Logo                  | reportLogoPNG.png                                                                                                                  |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                     |
    Then UI "Validate" Report With Name "Top 10 Activations by Duration Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Duration], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                        |
      | Logo                  | reportLogoPNG.png                                                                                                                  |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                     |
    Then UI Delete Report With Name "Top 10 Activations by Duration Report 2"

  @SID_44
  Scenario: Top 10 Activations by Duration Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top 10 Activations by Duration Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Duration], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                      |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                |
    Then UI "Validate" Report With Name "Top 10 Activations by Duration Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Duration], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                      |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                |
    Then UI Delete Report With Name "Top 10 Activations by Duration Report 3"

  @SID_45
  Scenario: Top 10 Activations by Duration Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top 10 Activations by Duration Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Duration], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                          |
      | Time Definitions.Date | Quick:Quarter                                                                                                        |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                       |
    Then UI "Validate" Report With Name "Top 10 Activations by Duration Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Duration], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                          |
      | Time Definitions.Date | Quick:Quarter                                                                                                        |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                       |
    Then UI Delete Report With Name "Top 10 Activations by Duration Report 4"

    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_46
  Scenario: Top 10 Activations by Attack Rate (Gbps) Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top 10 Activations by Attack Rate (Gbps) Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Attack Rate (Gbps)],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                                                               |
      | Time Definitions.Date | Quick:Previous Month                                                                                                            |
    Then UI "Validate" Report With Name "Top 10 Activations by Attack Rate (Gbps) Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Attack Rate (Gbps)],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                                                               |
      | Time Definitions.Date | Quick:Previous Month                                                                                                            |
    Then UI Delete Report With Name "Top 10 Activations by Attack Rate (Gbps) Report 1"

  @SID_47
  Scenario: Top 10 Activations by Attack Rate (Gbps) Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top 10 Activations by Attack Rate (Gbps) Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Attack Rate (Gbps)], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                                  |
      | Logo                  | reportLogoPNG.png                                                                                                                            |
      | Time Definitions.Date | Quick:This Month                                                                                                                             |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                               |
    Then UI "Validate" Report With Name "Top 10 Activations by Attack Rate (Gbps) Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Attack Rate (Gbps)], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                                  |
      | Logo                  | reportLogoPNG.png                                                                                                                            |
      | Time Definitions.Date | Quick:This Month                                                                                                                             |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                               |
    Then UI Delete Report With Name "Top 10 Activations by Attack Rate (Gbps) Report 2"

  @SID_48
  Scenario: Top 10 Activations by Attack Rate (Gbps) Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top 10 Activations by Attack Rate (Gbps) Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Attack Rate (Gbps)], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                             |
    Then UI "Validate" Report With Name "Top 10 Activations by Attack Rate (Gbps) Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Attack Rate (Gbps)], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                             |
    Then UI Delete Report With Name "Top 10 Activations by Attack Rate (Gbps) Report 3"

  @SID_49
  Scenario: Top 10 Activations by Attack Rate (Gbps) Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top 10 Activations by Attack Rate (Gbps) Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Attack Rate (Gbps)], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                    |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                             |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                 |
    Then UI "Validate" Report With Name "Top 10 Activations by Attack Rate (Gbps) Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Attack Rate (Gbps)], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                    |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                             |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                 |
    Then UI Delete Report With Name "Top 10 Activations by Attack Rate (Gbps) Report 4"
    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_50
  Scenario: Top 10 Activations by Attack Rate (Mpps) Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top 10 Activations by Attack Rate (Mpps) Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                                                               |
      | Time Definitions.Date | Quick:15m                                                                                                                       |
    Then UI "Validate" Report With Name "Top 10 Activations by Attack Rate (Mpps) Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                                                               |
      | Time Definitions.Date | Quick:15m                                                                                                                       |
    Then UI Delete Report With Name "Top 10 Activations by Attack Rate (Mpps) Report 1"

  @SID_51
  Scenario: Top 10 Activations by Attack Rate (Mpps) Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top 10 Activations by Attack Rate (Mpps) Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Attack Rate (Mpps)], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                 |
      | Logo                  | reportLogoPNG.png                                                                                                           |
      | Time Definitions.Date | Quick:This Week                                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                              |
    Then UI "Validate" Report With Name "Top 10 Activations by Attack Rate (Mpps) Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Attack Rate (Mpps)], Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                 |
      | Logo                  | reportLogoPNG.png                                                                                                           |
      | Time Definitions.Date | Quick:This Week                                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                              |
    Then UI Delete Report With Name "Top 10 Activations by Attack Rate (Mpps) Report 2"

  @SID_52
  Scenario: Top 10 Activations by Attack Rate (Mpps) Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top 10 Activations by Attack Rate (Mpps) Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Attack Rate (Mpps)], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                 |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                              |
    Then UI "Validate" Report With Name "Top 10 Activations by Attack Rate (Mpps) Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Attack Rate (Mpps)], Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                 |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                              |
    Then UI Delete Report With Name "Top 10 Activations by Attack Rate (Mpps) Report 3"

  @SID_53
  Scenario: Top 10 Activations by Attack Rate (Mpps) Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top 10 Activations by Attack Rate (Mpps) Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Attack Rate (Mpps)], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                    |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                             |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                 |
    Then UI "Validate" Report With Name "Top 10 Activations by Attack Rate (Mpps) Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top 10 Activations by Attack Rate (Mpps)], Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                    |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                             |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                 |
    Then UI Delete Report With Name "Top 10 Activations by Attack Rate (Mpps) Report 4"

    # ------------------------------------------------------------------------------------------------------------------------------------------------------------
   # {1}-Top Attacks by Duration, {2}-Top Attacks by Count, {3}-Top Attacks by Rate, {4}-Top Attacks by Protocol, {5}-Top Attack Destination, {6}-Top Attack Sources, {7}-Traffic Bandwidth,
   # {8}-Traffic Rate, {9}-DDoS Peak Attack per Period, {10}-DDoS Attack Activations per Period, {11}- Top 10 Activations by Duration, {12}-Top 10 Activations by Attack Rate (Gbps)
   # {13}-Top 10 Activations by Attack Rate (Mpps)
    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_54
  Scenario:Widgets 3_7_8_11_13 Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_7_8_11_13 Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[60]}, Top Attacks by Rate, Traffic Rate, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                               |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                                                                                                                                                                    |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                |
    Then UI "Validate" Report With Name "Widgets 3_7_8_11_13 Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[60]}, Top Attacks by Rate, Traffic Rate, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                               |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                                                                                                                                                                    |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                |
    Then UI Delete Report With Name "Widgets 3_7_8_11_13 Report 1"

  @SID_55
  Scenario:Widgets 3_7_8_11_13 Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_7_8_11_13 Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[70]}, Top Attacks by Rate, Traffic Rate, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[All] |
      | Format                | Select: PDF                                                                                                                                                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                               |
      | Time Definitions.Date | Quick:3M                                                                                                                                                                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                                                                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                  |
    Then UI "Validate" Report With Name "Widgets 3_7_8_11_13 Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[70]}, Top Attacks by Rate, Traffic Rate, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[All] |
      | Format                | Select: PDF                                                                                                                                                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                               |
      | Time Definitions.Date | Quick:3M                                                                                                                                                                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                                                                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                  |
    Then UI Delete Report With Name "Widgets 3_7_8_11_13 Report 2"

  @SID_56
  Scenario: Widgets 3_7_8_11_13 Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_7_8_11_13 Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[30]}, Top Attacks by Rate, Traffic Rate, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                  |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                                              |
    Then UI "Validate" Report With Name "Widgets 3_7_8_11_13 Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[30]}, Top Attacks by Rate, Traffic Rate, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                  |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                                              |
    Then UI Delete Report With Name "Widgets 3_7_8_11_13 Report 3"

  @SID_57
  Scenario: Widgets 3_7_8_11_13 Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_7_8_11_13 Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[90]}, Top Attacks by Rate, Traffic Rate, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space], showTable:true |
      | Format                | Select: HTML                                                                                                                                                                                                                                                 |
      | Time Definitions.Date | Quick:1H                                                                                                                                                                                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                              |
    Then UI "Validate" Report With Name "Widgets 3_7_8_11_13 Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[90]}, Top Attacks by Rate, Traffic Rate, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space], showTable:true |
      | Format                | Select: HTML                                                                                                                                                                                                                                                 |
      | Time Definitions.Date | Quick:1H                                                                                                                                                                                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                              |
    Then UI Delete Report With Name "Widgets 3_7_8_11_13 Report 4"

    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_58
  Scenario: Widgets 1_4_6_8_9_11_12_13 Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Protocol, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                          |
      | Time Definitions.Date | Quick:15m                                                                                                                                                                                                                                                                                                                  |
    Then UI "Validate" Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Protocol, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                          |
      | Time Definitions.Date | Quick:15m                                                                                                                                                                                                                                                                                                                  |
    Then UI Delete Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 1"

  @SID_59
  Scenario: Widgets 1_4_6_8_9_11_12_13 Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Protocol, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                                                                             |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                       |
      | Time Definitions.Date | Quick:This Week                                                                                                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                                                                                                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                          |
    Then UI "Validate" Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Protocol, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                                                                             |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                       |
      | Time Definitions.Date | Quick:This Week                                                                                                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                                                                                                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                          |
    Then UI Delete Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 2"

  @SID_60
  Scenario: Widgets 1_4_6_8_9_11_12_13 Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Protocol, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                                             |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                                                          |
    Then UI "Validate" Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Protocol, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                                             |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                                                          |
    Then UI Delete Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 3"

  @SID_61
  Scenario: Widgets 1_4_6_8_9_11_12_13 Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Protocol, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[all], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                             |
    Then UI "Validate" Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Protocol, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[all], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                             |
    Then UI Delete Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 4"

    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_62
  Scenario: Widgets 1_2_4_5_6_10 Report Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_2_4_5_6_7_10 Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Count, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, DDoS Attack Activations per Period],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                   |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                             |
      | Time Definitions.Date | Quick:15m                                                                                                                                                                                                                                     |
    Then UI "Validate" Report With Name "Widgets 1_2_4_5_6_7_10 Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Count, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, DDoS Attack Activations per Period],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                   |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                             |
      | Time Definitions.Date | Quick:15m                                                                                                                                                                                                                                     |
    Then UI Delete Report With Name "Widgets 1_2_4_5_6_7_10 Report 1"

  @SID_63
  Scenario: Widgets 1_2_4_5_6_10 Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_2_4_5_6_7_10 Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Count, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, DDoS Attack Activations per Period],  Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                                                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                          |
      | Time Definitions.Date | Quick:This Week                                                                                                                                                                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                             |
    Then UI "Validate" Report With Name "Widgets 1_2_4_5_6_7_10 Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Count, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, DDoS Attack Activations per Period],  Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                                                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                          |
      | Time Definitions.Date | Quick:This Week                                                                                                                                                                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                             |
    Then UI Delete Report With Name "Widgets 1_2_4_5_6_7_10 Report 2"

  @SID_64
  Scenario: Widgets 1_2_4_5_6_10 Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_2_4_5_6_7_10 Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Count, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, DDoS Attack Activations per Period],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                             |
    Then UI "Validate" Report With Name "Widgets 1_2_4_5_6_7_10 Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Count, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, DDoS Attack Activations per Period],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                             |
    Then UI Delete Report With Name "Widgets 1_2_4_5_6_7_10 Report 3"

  @SID_65
  Scenario: Widgets 1_2_4_5_6_10 Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_2_4_5_6_7_10 Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Count, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, DDoS Attack Activations per Period],  Protected Objects:[all], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                   |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                |
    Then UI "Validate" Report With Name "Widgets 1_2_4_5_6_7_10 Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Count, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, DDoS Attack Activations per Period],  Protected Objects:[all], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                   |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                |
    Then UI Delete Report With Name "Widgets 1_2_4_5_6_7_10 Report 4"

    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_66
  Scenario: Widgets 3_7_10_11_12_13 Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_7_10_11_12_13 Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[70]},Top Attacks by Rate, DDoS Attack Activations per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                    |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                              |
      | Time Definitions.Date | Quick:Previous Month                                                                                                                                                                                                                                                                                           |
    Then UI "Validate" Report With Name "Widgets 3_7_10_11_12_13 Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[70]},Top Attacks by Rate, DDoS Attack Activations per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                    |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                              |
      | Time Definitions.Date | Quick:Previous Month                                                                                                                                                                                                                                                                                           |
    Then UI Delete Report With Name "Widgets 3_7_10_11_12_13 Report 1"

  @SID_67
  Scenario: Widgets 3_7_10_11_12_13 Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_7_10_11_12_13 Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[35]},Top Attacks by Rate, DDoS Attack Activations per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                                                                 |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                                                                                            |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                                                                                                                                                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                              |
    Then UI "Validate" Report With Name "Widgets 3_7_10_11_12_13 Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[35]},Top Attacks by Rate, DDoS Attack Activations per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                                                                 |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                                                                                            |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                                                                                                                                                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                              |
    Then UI Delete Report With Name "Widgets 3_7_10_11_12_13 Report 2"

  @SID_68
  Scenario: Widgets 3_7_10_11_12_13 Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_7_10_11_12_13 Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[40]},Top Attacks by Rate, DDoS Attack Activations per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                                 |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                                              |
    Then UI "Validate" Report With Name "Widgets 3_7_10_11_12_13 Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[40]},Top Attacks by Rate, DDoS Attack Activations per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                                 |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                                              |
    Then UI Delete Report With Name "Widgets 3_7_10_11_12_13 Report 3"

  @SID_69
  Scenario: Widgets 3_7_10_11_12_13 Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_7_10_11_12_13 Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[60]},Top Attacks by Rate, DDoS Attack Activations per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[all], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                    |
      | Time Definitions.Date | Relative:[Hours,4]                                                                                                                                                                                                                                                                                             |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                                                                                                                                                                                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                 |
    Then UI "Validate" Report With Name "Widgets 3_7_10_11_12_13 Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[60]},Top Attacks by Rate, DDoS Attack Activations per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[all], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                    |
      | Time Definitions.Date | Relative:[Hours,4]                                                                                                                                                                                                                                                                                             |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                                                                                                                                                                                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                 |
    Then UI Delete Report With Name "Widgets 3_7_10_11_12_13 Report 4"


    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_70
  Scenario: Widgets 3_4_5_6_7_8_9_13 Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_4_5_6_7_8_9_13  Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[20]}, Top Attacks by Rate, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                       |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                 |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                                  |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                                                                                                                                                                                                                                      |
    Then UI "Validate" Report With Name "Widgets 3_4_5_6_7_8_9_13  Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[20]}, Top Attacks by Rate, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                       |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                 |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                                  |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                                                                                                                                                                                                                                      |
    Then UI Delete Report With Name "Widgets 3_4_5_6_7_8_9_13  Report 1"

  @SID_71
  Scenario: Widgets 3_4_5_6_7_8_9_13 Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_4_5_6_7_8_9_13 Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[15]}, Top Attacks by Rate, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                                                                    |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                              |
      | Time Definitions.Date | Quick:3M                                                                                                                                                                                                                                                                                                       |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                                                                                                                                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                 |
    Then UI "Validate" Report With Name "Widgets 3_4_5_6_7_8_9_13 Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[15]}, Top Attacks by Rate, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                                                                    |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                              |
      | Time Definitions.Date | Quick:3M                                                                                                                                                                                                                                                                                                       |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                                                                                                                                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                 |
    Then UI Delete Report With Name "Widgets 3_4_5_6_7_8_9_13 Report 2"

  @SID_72
  Scenario: Widgets 3_4_5_6_7_8_9_13 Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_4_5_6_7_8_9_13 Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[25]}, Top Attacks by Rate, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                                    |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                                                                                                                |
    Then UI "Validate" Report With Name "Widgets 3_4_5_6_7_8_9_13 Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[25]}, Top Attacks by Rate, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                                    |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                                                                                                                |
    Then UI Delete Report With Name "Widgets 3_4_5_6_7_8_9_13 Report 3"

  @SID_73
  Scenario: Widgets 3_4_5_6_7_8_9_13 Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_4_5_6_7_8_9_13  Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[30]}, Top Attacks by Rate, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[all], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                       |
      | Time Definitions.Date | Quick:1H                                                                                                                                                                                                                                                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                    |
    Then UI "Validate" Report With Name "Widgets 3_4_5_6_7_8_9_13  Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[30]}, Top Attacks by Rate, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[all], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                       |
      | Time Definitions.Date | Quick:1H                                                                                                                                                                                                                                                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                    |
    Then UI Delete Report With Name "Widgets 3_4_5_6_7_8_9_13  Report 4"


    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_74
  Scenario: Widgets 1_2_6_11_12_13 Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Count, Top Attack Sources, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                  |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                            |
      | Time Definitions.Date | Quick:15m                                                                                                                                                                                                                                                                    |
    Then UI "Validate" Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Count, Top Attack Sources, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                  |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                            |
      | Time Definitions.Date | Quick:15m                                                                                                                                                                                                                                                                    |
    Then UI Delete Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 1"

  @SID_75
  Scenario: Widgets 1_2_6_11_12_13 Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Count, Top Attack Sources, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                               |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                         |
      | Time Definitions.Date | Quick:This Week                                                                                                                                                                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                                                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                            |
    Then UI "Validate" Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Count, Top Attack Sources, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                               |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                         |
      | Time Definitions.Date | Quick:This Week                                                                                                                                                                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                                                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                            |
    Then UI Delete Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 2"

  @SID_76
  Scenario: Widgets 1_2_6_11_12_13 Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Count, Top Attack Sources, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                               |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                            |
    Then UI "Validate" Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Count, Top Attack Sources, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                               |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                            |
    Then UI Delete Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 3"

  @SID_77
  Scenario: Widgets 1_2_6_11_12_13 Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Count, Top Attack Sources, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[all], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                  |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                                                           |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                               |
    Then UI "Validate" Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Count, Top Attack Sources, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[all], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                  |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                                                           |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                               |
    Then UI Delete Report With Name "Widgets 1_4_6_7_8_9_11_12_13 Report 4"

    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_78
  Scenario: Widgets 4_5_6_7_8_9_10_11_12_13 Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 4_5_6_7_8_9_10_11_12_13  Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[20]}, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, DDoS Attack Activations per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                                                                                                          |
      | Time Definitions.Date | Quick:15m                                                                                                                                                                                                                                                                                                                                                                                                  |
    Then UI "Validate" Report With Name "Widgets 4_5_6_7_8_9_10_11_12_13  Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[20]}, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, DDoS Attack Activations per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                                                                                                          |
      | Time Definitions.Date | Quick:15m                                                                                                                                                                                                                                                                                                                                                                                                  |
    Then UI Delete Report With Name "Widgets 4_5_6_7_8_9_10_11_12_13  Report 1"

  @SID_79
  Scenario: Widgets 4_5_6_7_8_9_10_11_12_13 Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 4_5_6_7_8_9_10_11_12_13 Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[15]}, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, DDoS Attack Activations per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                                                                                                                                                             |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                                                                                                       |
      | Time Definitions.Date | Quick:This Week                                                                                                                                                                                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                                                                                                                                                                                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                                                                                                          |
    Then UI "Validate" Report With Name "Widgets 4_5_6_7_8_9_10_11_12_13 Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[15]}, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, DDoS Attack Activations per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                                                                                                                                                             |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                                                                                                                       |
      | Time Definitions.Date | Quick:This Week                                                                                                                                                                                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                                                                                                                                                                                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                                                                                                          |
    Then UI Delete Report With Name "Widgets 4_5_6_7_8_9_10_11_12_13 Report 2"

  @SID_80
  Scenario: Widgets 4_5_6_7_8_9_10_11_12_13 Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 4_5_6_7_8_9_10_11_12_13 Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[25]}, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, DDoS Attack Activations per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                                                                                                                             |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                                                                                                                                          |
    Then UI "Validate" Report With Name "Widgets 4_5_6_7_8_9_10_11_12_13 Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[25]}, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, DDoS Attack Activations per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                                                                                                                             |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                                                                                                                                          |
    Then UI Delete Report With Name "Widgets 4_5_6_7_8_9_10_11_12_13 Report 3"

  @SID_81
  Scenario: Widgets 4_5_6_7_8_9_10_11_12_13 Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 4_5_6_7_8_9_10_11_12_13  Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[30]}, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, DDoS Attack Activations per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[all], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                                                                                                |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                                                                                                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                                                                                                             |
    Then UI "Validate" Report With Name "Widgets 4_5_6_7_8_9_10_11_12_13  Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[30]}, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, Traffic Rate, DDoS Peak Attack per Period, DDoS Attack Activations per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[all], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                                                                                                |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                                                                                                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                                                                                                             |
    Then UI Delete Report With Name "Widgets 4_5_6_7_8_9_10_11_12_13  Report 4"

    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_82
  Scenario: Widgets 1_2_3_4_5_6_7_10 Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_2_3_4_5_6_7_10  Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[20]}, Top Attacks by Duration, Top Attacks by Count, Top Attacks by Rate, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, DDoS Attack Activations per Period],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                               |
      | Time Definitions.Date | Quick:Previous Month                                                                                                                                                                                                                                                                                            |
    Then UI "Validate" Report With Name "Widgets 1_2_3_4_5_6_7_10  Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[20]}, Top Attacks by Duration, Top Attacks by Count, Top Attacks by Rate, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, DDoS Attack Activations per Period],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                               |
      | Time Definitions.Date | Quick:Previous Month                                                                                                                                                                                                                                                                                            |
    Then UI Delete Report With Name "Widgets 1_2_3_4_5_6_7_10  Report 1"

  @SID_83
  Scenario: Widgets 1_2_3_4_5_6_7_10 Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_2_3_4_5_6_7_10 Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[15]}, Top Attacks by Duration, Top Attacks by Count, Top Attacks by Rate, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, DDoS Attack Activations per Period],  Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                                                                  |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                            |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                                                                                             |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                                                                                                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                               |
    Then UI "Validate" Report With Name "Widgets 1_2_3_4_5_6_7_10 Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[15]}, Top Attacks by Duration, Top Attacks by Count, Top Attacks by Rate, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, DDoS Attack Activations per Period],  Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                                                                                                                                                                                                  |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                                                            |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                                                                                             |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                                                                                                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                               |
    Then UI Delete Report With Name "Widgets 1_2_3_4_5_6_7_10 Report 2"

  @SID_84
  Scenario: Widgets 1_2_3_4_5_6_7_10 Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_2_3_4_5_6_7_10 Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[25]}, Top Attacks by Duration, Top Attacks by Count, Top Attacks by Rate, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, DDoS Attack Activations per Period],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                                  |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                                               |
    Then UI "Validate" Report With Name "Widgets 1_2_3_4_5_6_7_10 Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[25]}, Top Attacks by Duration, Top Attacks by Count, Top Attacks by Rate, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, DDoS Attack Activations per Period],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                                  |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                                               |
    Then UI Delete Report With Name "Widgets 1_2_3_4_5_6_7_10 Report 3"

  @SID_85
  Scenario: Widgets 1_2_3_4_5_6_7_10 Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_2_3_4_5_6_7_10  Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[30]}, Top Attacks by Duration, Top Attacks by Count, Top Attacks by Rate, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, DDoS Attack Activations per Period],  Protected Objects:[all], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                     |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                                                                                                                                                                                                              |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                                                                                                                                                                                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                  |
    Then UI "Validate" Report With Name "Widgets 1_2_3_4_5_6_7_10  Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[{Traffic Bandwidth:[30]}, Top Attacks by Duration, Top Attacks by Count, Top Attacks by Rate, Top Attacks by Protocol, Top Attack Destination, Top Attack Sources, DDoS Attack Activations per Period],  Protected Objects:[all], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                     |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                                                                                                                                                                                                              |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                                                                                                                                                                                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                                  |
    Then UI Delete Report With Name "Widgets 1_2_3_4_5_6_7_10  Report 4"

    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_86
  Scenario: Widgets 1_3_10 Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_3_10  Report"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Rate, DDoS Attack Activations per Period],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                             |
      | Logo                  | reportLogoPNG.png                                                                                                                                                       |
      | Time Definitions.Date | Quick:15m                                                                                                                                                               |
    Then UI "Validate" Report With Name "Widgets 1_3_10  Report"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Rate, DDoS Attack Activations per Period],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                             |
      | Logo                  | reportLogoPNG.png                                                                                                                                                       |
      | Time Definitions.Date | Quick:15m                                                                                                                                                               |
    Then UI Delete Report With Name "Widgets 1_3_10  Report"

  @SID_87
  Scenario: Widgets 3_6_9_13 Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 3_6_9_13 Report"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Rate, Top Attack Sources, DDoS Peak Attack per Period, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                                                                                        |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                  |
      | Time Definitions.Date | Quick:This Week                                                                                                                                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                     |
    Then UI "Validate" Report With Name "Widgets 3_6_9_13 Report"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Rate, Top Attack Sources, DDoS Peak Attack per Period, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                                                                                                                                        |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                  |
      | Time Definitions.Date | Quick:This Week                                                                                                                                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                     |
    Then UI Delete Report With Name "Widgets 3_6_9_13 Report"

  @SID_88
  Scenario: Widgets 1_3_5_7_9_11_13 Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 1_3_5_7_9_11_13 Report"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Rate, Top Attack Destination, {Traffic Bandwidth:[20]}, DDoS Peak Attack per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                                       |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                                        |
    Then UI "Validate" Report With Name "Widgets 1_3_5_7_9_11_13 Report"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Duration, Top Attacks by Rate, Top Attack Destination, {Traffic Bandwidth:[20]}, DDoS Peak Attack per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Mpps)],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                                       |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                                        |
    Then UI Delete Report With Name "Widgets 1_3_5_7_9_11_13 Report"

  @SID_89
  Scenario: Widgets 2_4_8_12 Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Widgets 2_4_8_12 Report"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Count, Top Attacks by Protocol, Traffic Rate, Top 10 Activations by Attack Rate (Gbps)],  Protected Objects:[all], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                  |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                                                                                           |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                               |
    Then UI "Validate" Report With Name "Widgets 2_4_8_12 Report"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[Top Attacks by Count, Top Attacks by Protocol, Traffic Rate, Top 10 Activations by Attack Rate (Gbps)],  Protected Objects:[all], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                  |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                                                                                           |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                               |
    Then UI Delete Report With Name "Widgets 2_4_8_12 Report"
    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_90
  Scenario: ALL Widgets Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "ALL Widgets Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[ALL],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                |
      | Logo                  | reportLogoPNG.png                                                                          |
      | Time Definitions.Date | Quick:Previous Month                                                                       |
    Then UI "Validate" Report With Name "ALL Widgets Report 1"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[ALL],  Protected Objects:[All], showTable:true |
      | Format                | Select: CSV                                                                                |
      | Logo                  | reportLogoPNG.png                                                                          |
      | Time Definitions.Date | Quick:Previous Month                                                                       |
    Then UI Delete Report With Name "ALL Widgets Report 1"

  @SID_91
  Scenario: ALL Widgets Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "ALL Widgets Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[ALL],  Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                             |
      | Logo                  | reportLogoPNG.png                                                                       |
      | Time Definitions.Date | Quick:This Month                                                                        |
      | Schedule              | Run Every:Once, On Time:+6H                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body          |
    Then UI "Validate" Report With Name "ALL Widgets Report 2"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[ALL],  Protected Objects:[PO Name Space] |
      | Format                | Select: PDF                                                                             |
      | Logo                  | reportLogoPNG.png                                                                       |
      | Time Definitions.Date | Quick:This Month                                                                        |
      | Schedule              | Run Every:Once, On Time:+6H                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body          |
    Then UI Delete Report With Name "ALL Widgets Report 2"

  @SID_92
  Scenario: ALL Widgets Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "ALL Widgets Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[ALL],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                             |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                          |
    Then UI "Validate" Report With Name "ALL Widgets Report 3"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[ALL],  Protected Objects:[PO Name Space] |
      | Format                | Select: HTML                                                                                             |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                          |
    Then UI Delete Report With Name "ALL Widgets Report 3"

  @SID_93
  Scenario: ALL Widgets Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "ALL Widgets Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[ALL],  Protected Objects:[all], showTable:true |
      | Format                | Select: CSV                                                                                |
      | Time Definitions.Date | Relative:[Hours,2]                                                                         |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body             |
    Then UI "Validate" Report With Name "ALL Widgets Report 4"
      | Template              | reportType:DefenseFlow Analytics , Widgets:[ALL],  Protected Objects:[all], showTable:true |
      | Format                | Select: CSV                                                                                |
      | Time Definitions.Date | Relative:[Hours,2]                                                                         |
      #| Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body             |
    Then UI Delete Report With Name "ALL Widgets Report 4"

    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_94
  Scenario: Logout
    Then UI logout and close browser