@TC117965
Feature: AppWall

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: create new OWASP Top 10 1
    Given UI "Create" Report With Name "OWASP Top 10 1 "
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10] , Applications:[All] , showTable:true|
      | Logo                  | reportLogoPNG.png                                                                |
      | Time Definitions.Date | Quick:15m                                                                        |
      | Format                | Select: CSV                                                                      |
    Given UI "Validate" Report With Name "OWASP Top 10 1 "
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10] , Applications:[All] , showTable:true|
      | Logo                  | reportLogoPNG.png                                                                |
      | Time Definitions.Date | Quick:15m                                                                        |
      | Format                | Select: CSV                                                                      |
    Then UI Delete Report With Name "OWASP Top 10 1 "

  @SID_3
  Scenario: create new OWASP Top 10 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 2 "
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10] , Applications:[All] , showTable:false  |
      | Logo                  | reportLogoPNG.png                                                                   |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body      |
      | Format                | Select: PDF                                                                         |
    Given UI "Validate" Report With Name "OWASP Top 10 2 "
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10] , Applications:[All] , showTable:false  |
      | Logo                  | reportLogoPNG.png                                                                   |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body      |
      | Format                | Select: PDF                                                                         |
    Then UI Delete Report With Name "OWASP Top 10 2 "

  @SID_4
  Scenario: create new OWASP Top 10 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 3 "
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Relative:[Days,2]                                                                     |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                          |
      | Format                | Select: HTML                                                                          |
    Given UI "Validate" Report With Name "OWASP Top 10 3 "
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Relative:[Days,2]                                                                     |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                          |
      | Format                | Select: HTML                                                                          |
    Then UI Delete Report With Name "OWASP Top 10 3 "

  @SID_5
  Scenario: create new OWASP Top 10 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 4 "
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Months,2]                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body    |
      | Format                | Select: CSV                                                                       |
    Given UI "Validate" Report With Name "OWASP Top 10 4 "
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Months,2]                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body    |
      | Format                | Select: CSV                                                                       |
    Then UI Delete Report With Name "OWASP Top 10 4 "

  @SID_6
  Scenario: create new Top Attack Category1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Category1 "
      | Template              | reportType:AppWall , Widgets:[Top Attack Category] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                        |
      | Time Definitions.Date | Quick:1D                                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                             |
      | Format                | Select: CSV                                                                              |
    Given UI "Validate" Report With Name "Top Attack Category1 "
      | Template              | reportType:AppWall , Widgets:[Top Attack Category] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                        |
      | Time Definitions.Date | Quick:1D                                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                             |
      | Format                | Select: CSV                                                                              |
    Then UI Delete Report With Name "Top Attack Category1 "

  @SID_7
  Scenario: create new Top Attack Category2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Category2 "
      | Template              | reportType:AppWall , Widgets:[Top Attack Category] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                         |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                          |
      | Schedule              | Run Every:once, On Time:+6H                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body            |
      | Format                | Select: PDF                                                                               |
    Given UI "Validate" Report With Name "Top Attack Category2 "
      | Template              | reportType:AppWall , Widgets:[Top Attack Category] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                         |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                          |
      | Schedule              | Run Every:once, On Time:+6H                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body            |
      | Format                | Select: PDF                                                                               |
    Then UI Delete Report With Name "Top Attack Category2 "

  @SID_8
  Scenario: create new Top Attack Category3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Category3 "
      | Template              | reportType:AppWall , Widgets:[Top Attack Category] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Quick:This Week                                                                              |
      | Format                | Select: HTML                                                                                 |
    Given UI "Validate" Report With Name "Top Attack Category3 "
      | Template              | reportType:AppWall , Widgets:[Top Attack Category] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Quick:This Week                                                                              |
      | Format                | Select: HTML                                                                                 |
    Then UI Delete Report With Name "Top Attack Category3 "

  @SID_9
  Scenario: create new Top Attack Category4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Category4 "
      | Template              | reportType:AppWall , Widgets:[Top Attack Category] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Days,3]                                                                        |
      | Schedule              | Run Every:Daily,On Time:+2m                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body           |
      | Format                | Select: CSV                                                                              |
    Given UI "Validate" Report With Name "Top Attack Category4 "
      | Template              | reportType:AppWall , Widgets:[Top Attack Category] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Days,3]                                                                        |
      | Schedule              | Run Every:Daily,On Time:+2m                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body           |
      | Format                | Select: CSV                                                                              |
    Then UI Delete Report With Name "Top Attack Category4 "

  @SID_10
  Scenario: create new Top Sources1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Sources1 "
      | Template              | reportType:AppWall , Widgets:[Top Sources] ,Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                               |
      | Time Definitions.Date | Quick:This Week                                                                 |
      | Schedule              | Run Every:Daily,On Time:+2m                                                     |
      | Format                | Select: CSV                                                                     |
    Given UI "Validate" Report With Name "Top Sources1 "
      | Template              | reportType:AppWall , Widgets:[Top Sources] ,Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                               |
      | Time Definitions.Date | Quick:This Week                                                                 |
      | Schedule              | Run Every:Daily,On Time:+2m                                                     |
      | Format                | Select: CSV                                                                     |
    Then UI Delete Report With Name "Top Sources1 "

  @SID_11
  Scenario: create new Top Sources2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Sources2 "
      | Template              | reportType:AppWall , Widgets:[Top Sources] ,Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                |
      | Time Definitions.Date | Relative:[Weeks,2]                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body   |
      | Format                | Select: PDF                                                                      |
    Given UI "Validate" Report With Name "Top Sources2 "
      | Template              | reportType:AppWall , Widgets:[Top Sources] ,Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                |
      | Time Definitions.Date | Relative:[Weeks,2]                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body   |
      | Format                | Select: PDF                                                                      |
    Then UI Delete Report With Name "Top Sources2 "

  @SID_12
  Scenario: create new Top Sources3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Sources3 "
      | Template              | reportType:AppWall , Widgets:[Top Sources] ,Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                     |
      | Format                | Select: HTML                                                                        |
    Given UI "Validate" Report With Name "Top Sources3 "
      | Template              | reportType:AppWall , Widgets:[Top Sources] ,Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                     |
      | Format                | Select: HTML                                                                        |
    Then UI Delete Report With Name "Top Sources3 "

  @SID_13
  Scenario: create new Top Sources4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Sources4 "
      | Template              | reportType:AppWall , Widgets:[Top Sources] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Months,2]                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body   |
      | Format                | Select: CSV                                                                      |
    Given UI "Validate" Report With Name "Top Sources4 "
      | Template              | reportType:AppWall , Widgets:[Top Sources] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Months,2]                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body   |
      | Format                | Select: CSV                                                                      |
    Then UI Delete Report With Name "Top Sources4 "

  @SID_14
  Scenario: create new Geolocation1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Geolocation1 "
      | Template              | reportType:AppWall , Widgets:[Geolocation] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                |
      | Time Definitions.Date | Quick:30m                                                                        |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[TUE]                                     |
      | Format                | Select: CSV                                                                      |
    Given UI "Validate" Report With Name "Geolocation1 "
      | Template              | reportType:AppWall , Widgets:[Geolocation] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                |
      | Time Definitions.Date | Quick:30m                                                                        |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[TUE]                                     |
      | Format                | Select: CSV                                                                      |
    Then UI Delete Report With Name "Geolocation1 "

  @SID_15
  Scenario: create new Geolocation2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Geolocation2 "
      | Template              | reportType:AppWall , Widgets:[Geolocation] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                 |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body    |
      | Format                | Select: PDF                                                                       |
    Given UI "Validate" Report With Name "Geolocation2 "
      | Template              | reportType:AppWall , Widgets:[Geolocation] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                 |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body    |
      | Format                | Select: PDF                                                                       |
    Then UI Delete Report With Name "Geolocation2 "

  @SID_16
  Scenario: create new Geolocation3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Geolocation3 "
      | Template              | reportType:AppWall , Widgets:[Geolocation] ,Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                  |
      | Format                | Select: HTML                                                                        |
    Given UI "Validate" Report With Name "Geolocation3 "
      | Template              | reportType:AppWall , Widgets:[Geolocation] ,Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                  |
      | Format                | Select: HTML                                                                        |
    Then UI Delete Report With Name "Geolocation3 "

  @SID_17
  Scenario: create new Geolocation4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Geolocation4 "
      | Template              | reportType:AppWall , Widgets:[Geolocation] ,Applications:[All] , showTable:true |
      | Time Definitions.Date | Quick:Quarter                                                                   |
      | Schedule              | Run Every:once, On Time:+6H                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body  |
      | Format                | Select: CSV                                                                     |
    Given UI "Validate" Report With Name "Geolocation4 "
      | Template              | reportType:AppWall , Widgets:[Geolocation] ,Applications:[All] , showTable:true |
      | Time Definitions.Date | Quick:Quarter                                                                   |
      | Schedule              | Run Every:once, On Time:+6H                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body  |
      | Format                | Select: CSV                                                                     |
    Then UI Delete Report With Name "Geolocation4 "

  @SID_18
  Scenario: create new Attacks by Action1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Action1"
      | Template              | reportType:AppWall , Widgets:[Attacks by Action] ,Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Quick:Previous Month                                                                  |
      | Format                | Select: CSV                                                                           |
    Given UI "Validate" Report With Name "Attacks by Action1"
      | Template              | reportType:AppWall , Widgets:[Attacks by Action] ,Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Quick:Previous Month                                                                  |
      | Format                | Select: CSV                                                                           |
    Then UI Delete Report With Name "Attacks by Action1"

  @SID_19
  Scenario: create new Attacks by Action2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Action2"
      | Template              | reportType:AppWall , Widgets:[Attacks by Action] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                       |
      | Time Definitions.Date | Quick:This Month                                                                        |
      | Schedule              | Run Every:once, On Time:+6H                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body          |
      | Format                | Select: PDF                                                                             |
    Given UI "Validate" Report With Name "Attacks by Action2"
      | Template              | reportType:AppWall , Widgets:[Attacks by Action] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                       |
      | Time Definitions.Date | Quick:This Month                                                                        |
      | Schedule              | Run Every:once, On Time:+6H                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body          |
      | Format                | Select: PDF                                                                             |
    Then UI Delete Report With Name "Attacks by Action2"

  @SID_20
  Scenario: create new Attacks by Action3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Action3"
      | Template              | reportType:AppWall , Widgets:[Attacks by Action] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                            |
      | Format                | Select: HTML                                                                               |
    Given UI "Validate" Report With Name "Attacks by Action3"
      | Template              | reportType:AppWall , Widgets:[Attacks by Action] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                            |
      | Format                | Select: HTML                                                                               |
    Then UI Delete Report With Name "Attacks by Action3"

  @SID_21
  Scenario: create new Attacks by Action4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Action4"
      | Template              | reportType:AppWall , Widgets:[Attacks by Action] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Hours,2]                                                                     |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body         |
      | Format                | Select: CSV                                                                            |
    Given UI "Validate" Report With Name "Attacks by Action4"
      | Template              | reportType:AppWall , Widgets:[Attacks by Action] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Hours,2]                                                                     |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body         |
      | Format                | Select: CSV                                                                            |
    Then UI Delete Report With Name "Attacks by Action4"

  @SID_22
  Scenario: create new Top Attacked Hosts1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacked Hosts1"
      | Template              | reportType:AppWall , Widgets:[Top Attacked Hosts] ,Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                      |
      | Time Definitions.Date | Quick:15m                                                                              |
      | Format                | Select: CSV                                                                            |
    Given UI "Validate" Report With Name "Top Attacked Hosts1"
      | Template              | reportType:AppWall , Widgets:[Top Attacked Hosts] ,Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                      |
      | Time Definitions.Date | Quick:15m                                                                              |
      | Format                | Select: CSV                                                                            |
    Then UI Delete Report With Name "Top Attacked Hosts1"

  @SID_23
  Scenario: create new Top Attacked Hosts2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacked Hosts2"
      | Template              | reportType:AppWall , Widgets:[Top Attacked Hosts] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                        |
      | Time Definitions.Date | Quick:This Week                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body           |
      | Format                | Select: PDF                                                                              |
    Given UI "Validate" Report With Name "Top Attacked Hosts2"
      | Template              | reportType:AppWall , Widgets:[Top Attacked Hosts] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                        |
      | Time Definitions.Date | Quick:This Week                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body           |
      | Format                | Select: PDF                                                                              |
    Then UI Delete Report With Name "Top Attacked Hosts2"


  @SID_24
  Scenario: create new Top Attacked Hosts3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacked Hosts3"
      | Template              | reportType:AppWall , Widgets:[Top Attacked Hosts] ,Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                            |
      | Format                | Select: HTML                                                                               |
    Given UI "Validate" Report With Name "Top Attacked Hosts3"
      | Template              | reportType:AppWall , Widgets:[Top Attacked Hosts] ,Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                            |
      | Format                | Select: HTML                                                                               |
    Then UI Delete Report With Name "Top Attacked Hosts3"

  @SID_25
  Scenario: create new Top Attacked Hosts4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacked Hosts4"
      | Template              | reportType:AppWall , Widgets:[Top Attacked Hosts] ,Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                     |
      | Schedule              | Run Every:Daily,On Time:+2m                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body         |
      | Format                | Select: CSV                                                                            |
    Given UI "Validate" Report With Name "Top Attacked Hosts4"
      | Template              | reportType:AppWall , Widgets:[Top Attacked Hosts] ,Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                     |
      | Schedule              | Run Every:Daily,On Time:+2m                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body         |
      | Format                | Select: CSV                                                                            |
    Then UI Delete Report With Name "Top Attacked Hosts4"

  @SID_26
  Scenario: create new Top Attack Severity1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attack Severity1"
      | Template              | reportType:AppWall , Widgets:[Attack Severity] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                    |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                     |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                         |
      | Format                | Select: CSV                                                                          |
    Given UI "Validate" Report With Name "Attack Severity1"
      | Template              | reportType:AppWall , Widgets:[Attack Severity] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                    |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                     |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                         |
      | Format                | Select: CSV                                                                          |
    Then UI Delete Report With Name "Attack Severity1"

  @SID_27
  Scenario: create new Top Attack Severity2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attack Severity2"
      | Template              | reportType:AppWall , Widgets:[Attack Severity] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Quick:3M                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body        |
      | Format                | Select: PDF                                                                           |
    Given UI "Validate" Report With Name "Attack Severity2"
      | Template              | reportType:AppWall , Widgets:[Attack Severity] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Quick:3M                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body        |
      | Format                | Select: PDF                                                                           |
    Then UI Delete Report With Name "Attack Severity2"

  @SID_28
  Scenario: create new Top Attack Severity3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attack Severity3"
      | Template              | reportType:AppWall , Widgets:[Attack Severity] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Quick:This Month                                                                         |
      | Format                | Select: HTML                                                                             |
    Given UI "Validate" Report With Name "Attack Severity3"
      | Template              | reportType:AppWall , Widgets:[Attack Severity] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Quick:This Month                                                                         |
      | Format                | Select: HTML                                                                             |
    Then UI Delete Report With Name "Attack Severity3"


  @SID_29
  Scenario: create new Top Attack Severity4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attack Severity4"
      | Template              | reportType:AppWall , Widgets:[Attack Severity] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Quick:1H                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                          |
      | Format                | Select: HTML                                                                             |
    Given UI "Validate" Report With Name "Attack Severity4"
      | Template              | reportType:AppWall , Widgets:[Attack Severity] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Quick:1H                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                          |
      | Format                | Select: HTML                                                                             |
    Then UI Delete Report With Name "Attack Severity4"

  @SID_30
  Scenario: create new Attack Severity and Top Sources1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attack Severity and Top Sources1"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                     |
      | Format                | Select: CSV                                                                                      |
    Given UI "Validate" Report With Name "Attack Severity and Top Sources1"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                     |
      | Format                | Select: CSV                                                                                      |
    Then UI Delete Report With Name "Attack Severity and Top Sources1"

  @SID_31
  Scenario: create new Attack Severity and Top Sources2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attack Severity and Top Sources2"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                 |
      | Time Definitions.Date | Quick:3M                                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                    |
      | Format                | Select: PDF                                                                                       |
    Given UI "Validate" Report With Name "Attack Severity and Top Sources2"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                 |
      | Time Definitions.Date | Quick:3M                                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                    |
      | Format                | Select: PDF                                                                                       |
    Then UI Delete Report With Name "Attack Severity and Top Sources2"

  @SID_32
  Scenario: create new Attack Severity and Top Sources3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attack Severity and Top Sources3"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Quick:This Month                                                                                     |
      | Format                | Select: HTML                                                                                         |
    Given UI "Validate" Report With Name "Attack Severity and Top Sources3"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Quick:This Month                                                                                     |
      | Format                | Select: HTML                                                                                         |
    Then UI Delete Report With Name "Attack Severity and Top Sources3"

  @SID_33
  Scenario: create new Attack Severity and Top Sources4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attack Severity and Top Sources4"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Quick:1H                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                      |
      | Format                | Select: HTML                                                                                         |
    Given UI "Validate" Report With Name "Attack Severity and Top Sources4"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Quick:1H                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                      |
      | Format                | Select: HTML                                                                                         |
    Then UI Delete Report With Name "Attack Severity and Top Sources4"

  @SID_34
  Scenario: create new OWASP Top 10 and Geolocation and Top Attacked Hosts1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 and Geolocation and Top Attacked Hosts1"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Geolocation,Top Attacked Hosts] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                |
      | Time Definitions.Date | Quick:15m                                                                                                        |
      | Format                | Select: CSV                                                                                                      |
    Given UI "Validate" Report With Name "OWASP Top 10 and Geolocation and Top Attacked Hosts1"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Geolocation,Top Attacked Hosts] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                |
      | Time Definitions.Date | Quick:15m                                                                                                        |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Report With Name "OWASP Top 10 and Geolocation and Top Attacked Hosts1"

  @SID_35
  Scenario: create new OWASP Top 10 and Geolocation and Top Attacked Hosts2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 and Geolocation and Geolocation Top Attacked Hosts2"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Geolocation,Top Attacked Hosts] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                                 |
      | Time Definitions.Date | Quick:This Week                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                    |
      | Format                | Select: PDF                                                                                                       |
    Given UI "Validate" Report With Name "OWASP Top 10 and Geolocation and Geolocation Top Attacked Hosts2"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Geolocation,Top Attacked Hosts] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                                 |
      | Time Definitions.Date | Quick:This Week                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                    |
      | Format                | Select: PDF                                                                                                       |
    Then UI Delete Report With Name "OWASP Top 10 and Geolocation and Top Attacked Hosts2"

  @SID_36
  Scenario: create new OWASP Top 10 and Geolocation and Top Attacked Hosts3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 and Geolocation and Geolocation Top Attacked Hosts3"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Geolocation,Top Attacked Hosts] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                      |
      | Format                | Select: HTML                                                                                                         |
    Given UI "Validate" Report With Name "OWASP Top 10 and Geolocation and Geolocation Top Attacked Hosts3"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Geolocation,Top Attacked Hosts] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                      |
      | Format                | Select: HTML                                                                                                         |
    Then UI Delete Report With Name "OWASP Top 10 and Geolocation and Top Attacked Hosts3"

  @SID_37
  Scenario: create new OWASP Top 10 and Geolocation and Top Attacked Hosts4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 and Geolocation and Geolocation Top Attacked Hosts4"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Geolocation,Top Attacked Hosts] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                   |
      | Format                | Select: CSV                                                                                                      |
    Given UI "Validate" Report With Name "OWASP Top 10 and Geolocation and Geolocation Top Attacked Hosts4"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Geolocation,Top Attacked Hosts] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                   |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Report With Name "OWASP Top 10 and Geolocation and Top Attacked Hosts4"

  @SID_38
  Scenario: create new OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts1"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Geolocation,Attacks by Action,Top Attacked Hosts] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                                                      |
      | Time Definitions.Date | Quick:15m                                                                                                                                              |
      | Format                | Select: CSV                                                                                                                                            |
    Given UI "Validate" Report With Name "OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts1"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Geolocation,Attacks by Action,Top Attacked Hosts] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                                                      |
      | Time Definitions.Date | Quick:15m                                                                                                                                              |
      | Format                | Select: CSV                                                                                                                                            |
    Then UI Delete Report With Name "OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts1"

  @SID_39
  Scenario: create new OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts2"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Geolocation,Attacks by Action,Top Attacked Hosts] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                                                                       |
      | Time Definitions.Date | Quick:This Week                                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                          |
      | Format                | Select: PDF                                                                                                                                             |
    Given UI "Validate" Report With Name "OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts2"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Geolocation,Attacks by Action,Top Attacked Hosts] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                                                                       |
      | Time Definitions.Date | Quick:This Week                                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                          |
      | Format                | Select: PDF                                                                                                                                             |
    Then UI Delete Report With Name "OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts2"

  @SID_40
  Scenario: create new OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts3"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Geolocation,Attacks by Action,Top Attacked Hosts] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                            |
      | Format                | Select: HTML                                                                                                                                               |
    Given UI "Validate" Report With Name "OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts3"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Geolocation,Attacks by Action,Top Attacked Hosts] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                            |
      | Format                | Select: HTML                                                                                                                                               |
    Then UI Delete Report With Name "OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts3"

  @SID_41
  Scenario: create new OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts4"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Geolocation,Attacks by Action,Top Attacked Hosts] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                     |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                         |
      | Format                | Select: CSV                                                                                                                                            |
    Given UI "Validate" Report With Name "OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts4"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Geolocation,Attacks by Action,Top Attacked Hosts] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                     |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                         |
      | Format                | Select: CSV                                                                                                                                            |
    Then UI Delete Report With Name "OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts4"

  @SID_42
  Scenario: create new Top Sources and Attack Severity1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Sources and Attack Severity1"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                |
      | Time Definitions.Date | Quick:Previous Month                                                                             |
      | Format                | Select: CSV                                                                                      |
    Given UI "Validate" Report With Name "Top Sources and Attack Severity1"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                |
      | Time Definitions.Date | Quick:Previous Month                                                                             |
      | Format                | Select: CSV                                                                                      |
    Then UI Delete Report With Name "Top Sources and Attack Severity1"

  @SID_43
  Scenario: create new Top Sources and Attack Severity2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Sources and Attack Severity2"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                 |
      | Time Definitions.Date | Quick:This Month                                                                                  |
      | Schedule              | Run Every:once, On Time:+6H                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                    |
      | Format                | Select: PDF                                                                                       |
    Given UI "Validate" Report With Name "Top Sources and Attack Severity2"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                 |
      | Time Definitions.Date | Quick:This Month                                                                                  |
      | Schedule              | Run Every:once, On Time:+6H                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                    |
      | Format                | Select: PDF                                                                                       |
    Then UI Delete Report With Name "Top Sources and Attack Severity2"

  @SID_44
  Scenario: create new Top Sources and Attack Severity3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Sources and Attack Severity3"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                      |
      | Format                | Select: HTML                                                                                         |
    Given UI "Validate" Report With Name "Top Sources and Attack Severity3"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                      |
      | Format                | Select: HTML                                                                                         |
    Then UI Delete Report With Name "Top Sources and Attack Severity3"

  @SID_45
  Scenario: create new Top Sources and Attack Severity4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Sources and Attack Severity4"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Hours,2]                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                   |
      | Format                | Select: CSV                                                                                      |
    Given UI "Validate" Report With Name "Top Sources and Attack Severity4"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Hours,2]                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                   |
      | Format                | Select: CSV                                                                                      |
    Then UI Delete Report With Name "Top Sources and Attack Severity4"

  @SID_46
  Scenario: create new Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity1"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                                                 |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                  |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                      |
      | Format                | Select: CSV                                                                                                                                       |
    Given UI "Validate" Report With Name "Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity1"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                                                 |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                  |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                      |
      | Format                | Select: CSV                                                                                                                                       |
    Then UI Delete Report With Name "Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity1"

  @SID_47
  Scenario: create new Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity2"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                                                                  |
      | Time Definitions.Date | Quick:3M                                                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                     |
      | Format                | Select: PDF                                                                                                                                        |
    Given UI "Validate" Report With Name "Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity2"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                                                                  |
      | Time Definitions.Date | Quick:3M                                                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                     |
      | Format                | Select: PDF                                                                                                                                        |
    Then UI Delete Report With Name "Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity2"

  @SID_48
  Scenario: create new Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity3"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] ,Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Quick:This Month                                                                                                                                     |
      | Format                | Select: HTML                                                                                                                                         |
    Given UI "Validate" Report With Name "Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity3"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] ,Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Quick:This Month                                                                                                                                     |
      | Format                | Select: HTML                                                                                                                                         |
    Then UI Delete Report With Name "Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity3"

  @SID_49
  Scenario: create new Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity4"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Quick:1H                                                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                       |
      | Format                | Select: HTML                                                                                                                                          |
    Given UI "Validate" Report With Name "Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity4"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Quick:1H                                                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                       |
      | Format                | Select: HTML                                                                                                                                          |
    Then UI Delete Report With Name "Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity4"

  @SID_50
  Scenario: create new OWASP Top 10 and Top Attack Category and Top Attacked Hosts1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Top Attacked Hosts1"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Attacked Hosts] ,Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                       |
      | Time Definitions.Date | Quick:15m                                                                                                               |
      | Format                | Select: CSV                                                                                                             |
    Given UI "Validate" Report With Name "OWASP Top 10 and Top Attack Category and Top Attacked Hosts1"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Attacked Hosts] ,Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                       |
      | Time Definitions.Date | Quick:15m                                                                                                               |
      | Format                | Select: CSV                                                                                                             |
    Then UI Delete Report With Name "OWASP Top 10 and Top Attack Category and Top Attacked Hosts1"

  @SID_51
  Scenario: create new OWASP Top 10 and Top Attack Category and Top Attacked Hosts2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Top Attacked Hosts2"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Attacked Hosts] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                                         |
      | Time Definitions.Date | Quick:This Week                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                            |
      | Format                | Select: PDF                                                                                                               |
    Given UI "Validate" Report With Name "OWASP Top 10 and Top Attack Category and Top Attacked Hosts2"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Attacked Hosts] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                                         |
      | Time Definitions.Date | Quick:This Week                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                            |
      | Format                | Select: PDF                                                                                                               |
    Then UI Delete Report With Name "OWASP Top 10 and Top Attack Category and Top Attacked Hosts2"

  @SID_52
  Scenario: create new OWASP Top 10 and Top Attack Category and Top Attacked Hosts3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Top Attacked Hosts3"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Attacked Hosts] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                              |
      | Format                | Select: HTML                                                                                                                 |
    Given UI "Validate" Report With Name "OWASP Top 10 and Top Attack Category and Top Attacked Hosts3"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Attacked Hosts] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                              |
      | Format                | Select: HTML                                                                                                                 |
    Then UI Delete Report With Name "OWASP Top 10 and Top Attack Category and Top Attacked Hosts3"

  @SID_53
  Scenario: create new OWASP Top 10 and Top Attack Category and Top Attacked Hosts4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Top Attacked Hosts4"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Attacked Hosts] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                       |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                           |
      | Format                | Select: CSV                                                                                                              |
    Given UI "Validate" Report With Name "OWASP Top 10 and Top Attack Category and Top Attacked Hosts4"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Attacked Hosts] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                       |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                           |
      | Format                | Select: CSV                                                                                                              |
    Then UI Delete Report With Name "OWASP Top 10 and Top Attack Category and Top Attacked Hosts4"

  @SID_54
  Scenario: create new Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity1"
      | Template              | reportType:AppWall , Widgets:[Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                                     |
      | Time Definitions.Date | Quick:15m                                                                                                                             |
      | Format                | Select: CSV                                                                                                                           |
    Given UI "Validate" Report With Name "Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity1"
      | Template              | reportType:AppWall , Widgets:[Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                                     |
      | Time Definitions.Date | Quick:15m                                                                                                                             |
      | Format                | Select: CSV                                                                                                                           |
    Then UI Delete Report With Name "Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity1"


  @SID_55
  Scenario: create new Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity2"
      | Template              | reportType:AppWall , Widgets:[Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                                                      |
      | Time Definitions.Date | Quick:This Week                                                                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                         |
      | Format                | Select: PDF                                                                                                                            |
    Given UI "Validate" Report With Name "Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity2"
      | Template              | reportType:AppWall , Widgets:[Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                                                      |
      | Time Definitions.Date | Quick:This Week                                                                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                         |
      | Format                | Select: PDF                                                                                                                            |
    Then UI Delete Report With Name "Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity2"

  @SID_56
  Scenario: create new Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity3"
      | Template              | reportType:AppWall , Widgets:[Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                           |
      | Format                | Select: HTML                                                                                                                              |
    Given UI "Validate" Report With Name "Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity3"
      | Template              | reportType:AppWall , Widgets:[Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[Vision] , showTable:false |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                           |
      | Format                | Select: HTML                                                                                                                              |
    Then UI Delete Report With Name "Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity3"

  @SID_57
  Scenario: create new Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity4"
      | Template              | reportType:AppWall , Widgets:[Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                    |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                        |
      | Format                | Select: CSV                                                                                                                           |
    Given UI "Validate" Report With Name "Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity4"
      | Template              | reportType:AppWall , Widgets:[Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                    |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                        |
      | Format                | Select: CSV                                                                                                                           |
    Then UI Delete Report With Name "Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity4"

  @SID_58
  Scenario: create new OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity1"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                  |
      | Time Definitions.Date | Quick:Previous Month                                                                                                                                                               |
      | Format                | Select: CSV                                                                                                                                                                        |
    Given UI "Validate" Report With Name "OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity1"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                  |
      | Time Definitions.Date | Quick:Previous Month                                                                                                                                                               |
      | Format                | Select: CSV                                                                                                                                                                        |
    Then UI Delete Report With Name "OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity1"

  @SID_59
  Scenario: create new OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity2"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                   |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                    |
      | Schedule              | Run Every:once, On Time:+6H                                                                                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                      |
      | Format                | Select: PDF                                                                                                                                                                         |
    Given UI "Validate" Report With Name "OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity2"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                   |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                    |
      | Schedule              | Run Every:once, On Time:+6H                                                                                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                      |
      | Format                | Select: PDF                                                                                                                                                                         |
    Then UI Delete Report With Name "OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity2"

  @SID_60
  Scenario: create new OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity3"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[Vision]  , showTable:false |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                         |
      | Format                | Select: HTML                                                                                                                                                                            |
    Given UI "Validate" Report With Name "OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity3"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[Vision]  , showTable:false |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                         |
      | Format                | Select: HTML                                                                                                                                                                            |
    Then UI Delete Report With Name "OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity3"

  @SID_61
  Scenario: create new OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity4"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                     |
      | Format                | Select: CSV                                                                                                                                                                        |
    Given UI "Validate" Report With Name "OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity4"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , Applications:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                     |
      | Format                | Select: CSV                                                                                                                                                                        |
    Then UI Delete Report With Name "OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity4"
