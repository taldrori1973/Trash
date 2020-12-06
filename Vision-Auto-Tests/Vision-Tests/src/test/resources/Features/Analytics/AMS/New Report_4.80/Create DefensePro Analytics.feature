@TC117961
Feature: DefensePro Analytics


#Scenario: Create Report of Traffic Global Kbps Inbound
#Given UI "Create" Report With Name "Traffic Report"
#| Template-1            | reportType:DefensePro Analytics,Widgets:[Concurrent Connections],devices:[{devicesIndex:10,devicePorts:[1],devicePolicies:[BDOS,APOL]},{deviceIndex:10}]                             |
#| Template-2            | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[bps/pps,Inbound/Outbound,All/1-100]},ALL/specific widgets],devices:[{devicesIndex:11,devicePorts:[1,2],devicePolicies:[BDOS,APOL]},{deviceIndex:10}] |
#| Format                | Select: CSV                                                                                                                                                                            |
#|Template-3             |reportType:DefensePro Analytics,Widgets:[BDoS-TCP SYN,Concurrent Connections],devices:[{devicesIndex:11,devicePorts:[1,2],devicePolicies:[BDOS,APOL]},{deviceIndex:10}]|
#| Logo                  | reportLogoPNG.png                                                                                                                                                                      |
#| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN,SEP,DEC]                                                                                                                                |
#| Time Definitions.Date | Quick:This Month                                                                                                                                                                       |



  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"


  @SID_2
  Scenario: create new Traffic Bandwidth1
    Given UI "Create" Report With Name "Traffic Bandwidth Report1"
      | Template              | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[bps,Inbound,All Policies]}],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                           |
      | Format                | Select: PDF                                                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                             |
      | Time Definitions.Date | Quick:Today                                                                                                                 |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                        |
    Then UI "Validate" Report With Name "Traffic Bandwidth Report1"
      | Template              | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[bps,Inbound,All Policies]}],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                           |
      | Format                | Select: PDF                                                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                             |
      | Time Definitions.Date | Quick:Today                                                                                                                 |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                        |
    Then UI Delete Report With Name "Traffic Bandwidth Report1"

  @SID_3
  Scenario: create new Traffic Bandwidth2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Bandwidth Report2"
      | Template              | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[pps,Outbound,All Policies]}],devices:[{deviceIndex:10}],showTable:false |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                                      |
      | Time Definitions.Date | Quick:Yesterday                                                                                                                            |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                       |
      | Format                | Select: PDF                                                                                                                                |
    Then UI "Validate" Report With Name "Traffic Bandwidth Report2"
      | Template              | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[pps,Outbound,All Policies]}],devices:[{deviceIndex:10}],showTable:false |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                                      |
      | Time Definitions.Date | Quick:Yesterday                                                                                                                            |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                       |
      | Format                | Select: PDF                                                                                                                                |
    Then UI Delete Report With Name "Traffic Bandwidth Report2"

  @SID_4
  Scenario: create new Traffic Bandwidth3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Bandwidth Report3"
      | Template              | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[bps,Outbound,All Policies]}],devices:[All],showTable:true |
      | Time Definitions.Date | Quick:Quarter                                                                                                                |
      | Format                | Select: PDF                                                                                                                  |
    Then UI "Validate" Report With Name "Traffic Bandwidth Report3"
      | Template              | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[bps,Outbound,All Policies]}],devices:[All],showTable:true |
      | Time Definitions.Date | Quick:Quarter                                                                                                                |
      | Format                | Select: PDF                                                                                                                  |
    Then UI Delete Report With Name "Traffic Bandwidth Report3"

  @SID_5
  Scenario: create new Traffic Bandwidth4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Bandwidth Report4"
      | Template              | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[pps,Inbound,All Policies]}],devices:[All],showTable:true |
      | Time Definitions.Date | Quick:Quarter                                                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                                 |
      | Format                | Select: HTML                                                                                                                |
    Then UI "Validate" Report With Name "Traffic Bandwidth Report4"
      | Template              | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[pps,Inbound,All Policies]}],devices:[All],showTable:true |
      | Time Definitions.Date | Quick:Quarter                                                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                                 |
      | Format                | Select: HTML                                                                                                                |
    Then UI Delete Report With Name "Traffic Bandwidth Report4"

  @SID_6
  Scenario: create new Traffic Bandwidth5
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Bandwidth Report5"
      | Template              | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[bps,Inbound,50]}],devices:[All],showTable:true |
      | Time Definitions.Date | Quick:Quarter                                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                       |
      | Format                | Select: HTML                                                                                                      |
    Then UI "Validate" Report With Name "Traffic Bandwidth Report5"
      | Template              | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[bps,Inbound,50]}],devices:[All],showTable:true |
      | Time Definitions.Date | Quick:Quarter                                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                       |
      | Format                | Select: HTML                                                                                                      |
    Then UI Delete Report With Name "Traffic Bandwidth Report5"


  @SID_7
  Scenario: create new Traffic Bandwidth6
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Bandwidth Report6"
      | Template              | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}],devices:[All],showTable:true |
      | Time Definitions.Date | Quick:Quarter                                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                        |
      | Format                | Select: CSV                                                                                                        |
    Then UI "Validate" Report With Name "Traffic Bandwidth Report6"
      | Template              | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}],devices:[All],showTable:true |
      | Time Definitions.Date | Quick:Quarter                                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                        |
      | Format                | Select: CSV                                                                                                        |
    Then UI Delete Report With Name "Traffic Bandwidth Report6"

  @SID_8
  Scenario: create new Connections Rate1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Connections Rate Report1"
      | Template              | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Quick:1D                                                                                                   |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                               |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: CSV                                                                                                |
    Then UI "Validate" Report With Name "Connections Rate Report1"
      | Template              | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Quick:1D                                                                                                   |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                               |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: CSV                                                                                                |
    Then UI Delete Report With Name "Connections Rate Report1"

  @SID_9
  Scenario: create new Connections Rate2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Connections Rate Report2"
      | Template              | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true |
      | Time Definitions.Date | Quick:1H                                                                                                   |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                |
      | Format                | Select: PDF                                                                                                |
    Then UI "Validate" Report With Name "Connections Rate Report2"
      | Template              | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true |
      | Time Definitions.Date | Quick:1H                                                                                                   |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                |
      | Format                | Select: PDF                                                                                                |
    Then UI Delete Report With Name "Connections Rate Report2"


  @SID_10
  Scenario: create new Connections Rate3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Connections Rate Report3"
      | Template              | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[All],showTable:false |
      | Logo                  | reportLogoPNG.png                                                                              |
      | Time Definitions.Date | Relative:[Hours,3]                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                           |
      | Format                | Select: HTML                                                                                   |
    Then UI "Validate" Report With Name "Connections Rate Report3"
      | Template              | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[All],showTable:false |
      | Logo                  | reportLogoPNG.png                                                                              |
      | Time Definitions.Date | Relative:[Hours,3]                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                           |
      | Format                | Select: HTML                                                                                   |
    Then UI Delete Report With Name "Connections Rate Report3"

  @SID_11
  Scenario: create new Connections Rate4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Connections Rate Report4"
      | Template              | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                             |
      | Time Definitions.Date | Quick:This Week                                                                               |
      | Format                | Select: CSV                                                                                   |
    Then UI "Validate" Report With Name "Connections Rate Report4"
      | Template              | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                             |
      | Time Definitions.Date | Quick:This Week                                                                               |
      | Format                | Select: CSV                                                                                   |
    Then UI Delete Report With Name "Connections Rate Report4"

  @SID_12
  Scenario: create new Concurrent Connections1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Concurrent Connections Report1"
      | Template              | reportType:DefensePro Analytics,Widgets:[Concurrent Connections],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                    |
      | Schedule              | Run Every:Once, On Time:+6H                                                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                |
      | Format                | Select: PDF                                                                                         |
    Then UI "Validate" Report With Name "Concurrent Connections Report1"
      | Template              | reportType:DefensePro Analytics,Widgets:[Concurrent Connections],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                    |
      | Schedule              | Run Every:Once, On Time:+6H                                                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                |
      | Format                | Select: PDF                                                                                         |
    Then UI Delete Report With Name "Concurrent Connections Report1"

  @SID_13
  Scenario: create new Concurrent Connections2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Concurrent Connections Report2"
      | Template              | reportType:DefensePro Analytics,Widgets:[Concurrent Connections],devices:[All],showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                    |
      | Time Definitions.Date | Quick:Quarter                                                                                        |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                         |
      | Format                | Select: HTML                                                                                         |
    Then UI "Validate" Report With Name "Concurrent Connections Report2"
      | Template              | reportType:DefensePro Analytics,Widgets:[Concurrent Connections],devices:[All],showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                    |
      | Time Definitions.Date | Quick:Quarter                                                                                        |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                         |
      | Format                | Select: HTML                                                                                         |
    Then UI Delete Report With Name "Concurrent Connections Report2"

  @SID_14
  Scenario: create new Concurrent Connections3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Concurrent Connections Report3"
      | Template              | reportType:DefensePro Analytics,Widgets:[Concurrent Connections],devices:[{deviceIndex:10}],showTable:false |
      | Time Definitions.Date | Quick:This Month                                                                                                  |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                       |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                              |
      | Format                | Select: PDF                                                                                                       |
    Then UI "Validate" Report With Name "Concurrent Connections Report3"
      | Template              | reportType:DefensePro Analytics,Widgets:[Concurrent Connections],devices:[{deviceIndex:10}],showTable:false |
      | Time Definitions.Date | Quick:This Month                                                                                                  |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                       |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                              |
      | Format                | Select: PDF                                                                                                       |
    Then UI Delete Report With Name "Concurrent Connections Report3"

  @SID_15
  Scenario: create new Concurrent Connections4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Concurrent Connections Report4"
      | Template              | reportType:DefensePro Analytics,Widgets:[Concurrent Connections],devices:[All],showTable:true |
      | Time Definitions.Date | Quick:Yesterday                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB]                                                     |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                |
    Then UI "Validate" Report With Name "Concurrent Connections Report4"
      | Template              | reportType:DefensePro Analytics,Widgets:[Concurrent Connections],devices:[All],showTable:true |
      | Time Definitions.Date | Quick:Yesterday                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB]                                                     |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                |
    Then UI Delete Report With Name "Concurrent Connections Report4"


  @SID_16
  Scenario: create new Top Attacks1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks Report1"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                        |
      | Time Definitions.Date | Quick:1D                                                                                 |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                             |
      | Format                | Select: CSV                                                                              |
    Then UI "Validate" Report With Name "Top Attacks Report1"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                        |
      | Time Definitions.Date | Quick:1D                                                                                 |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                             |
      | Format                | Select: CSV                                                                              |
    Then UI Delete Report With Name "Top Attacks Report1"

  @SID_17
  Scenario: create new Top Attacks2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks Report2"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks],devices:[All],showTable:false |
      | Logo                  | reportLogoPNG.png                                                                         |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                           |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                      |
      | Format                | Select: PDF                                                                               |
    Then UI "Validate" Report With Name "Top Attacks Report2"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks],devices:[All],showTable:false |
      | Logo                  | reportLogoPNG.png                                                                         |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                           |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                      |
      | Format                | Select: PDF                                                                               |
    Then UI Delete Report With Name "Top Attacks Report2"

  @SID_18
  Scenario: create new Top Attacks3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks Report3"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks],devices:[{deviceIndex:10}],showTable:false |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                     |
      | Schedule              | Run Every:Once, On Time:+6H                                                                            |
      | Format                | Select: HTML                                                                                           |
    Then UI "Validate" Report With Name "Top Attacks Report3"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks],devices:[{deviceIndex:10}],showTable:false |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                     |
      | Schedule              | Run Every:Once, On Time:+6H                                                                            |
      | Format                | Select: HTML                                                                                           |
    Then UI Delete Report With Name "Top Attacks Report3"

  @SID_19
  Scenario: create new Top Attacks4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks Report4"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks],devices:[All],showTable:true |
      | Time Definitions.Date | Relative:[Months,2]                                                                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                     |
      | Format                | Select: CSV                                                                              |
    Then UI "Validate" Report With Name "Top Attacks Report4"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks],devices:[All],showTable:true |
      | Time Definitions.Date | Relative:[Months,2]                                                                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                     |
      | Format                | Select: CSV                                                                              |
    Then UI Delete Report With Name "Top Attacks Report4"

  @SID_20
  Scenario: create new Top Attacks by Volume1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Volume1"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Volume],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                  |
      | Time Definitions.Date | Quick:Previous Month                                                                               |
      | Schedule              | Run Every:Once, On Time:+6H                                                                        |
      | Format                | Select: CSV                                                                                        |
    Then UI "Validate" Report With Name "Top Attacks by Volume1"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Volume],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                  |
      | Time Definitions.Date | Quick:Previous Month                                                                               |
      | Schedule              | Run Every:Once, On Time:+6H                                                                        |
      | Format                | Select: CSV                                                                                        |
    Then UI Delete Report With Name "Top Attacks by Volume1"

  @SID_21
  Scenario: create new Top Attacks by Volume2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Volume2"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Volume],devices:[All],showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Quick:Today                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUL]                                                     |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                |
      | Format                | Select: PDF                                                                                         |
    Then UI "Validate" Report With Name "Top Attacks by Volume2"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Volume],devices:[All],showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Quick:Today                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUL]                                                     |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                |
      | Format                | Select: PDF                                                                                         |
    Then UI Delete Report With Name "Top Attacks by Volume2"

  @SID_22
  Scenario: create new Top Attacks by Volume3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Volume3"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Volume],devices:[{deviceIndex:10}],showTable:false |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                 |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                        |
      | Format                | Select: HTML                                                                                                     |
    Then UI "Validate" Report With Name "Top Attacks by Volume3"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Volume],devices:[{deviceIndex:10}],showTable:false |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                 |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                        |
      | Format                | Select: HTML                                                                                                     |
    Then UI Delete Report With Name "Top Attacks by Volume3"


  @SID_23
  Scenario: create new Top Attacks by Volume4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Volume4"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Volume],devices:[All],showTable:true |
      | Time Definitions.Date | Relative:[Months,2]                                                                                 |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                |
      | Format                | Select: CSV                                                                                         |
    Then UI "Validate" Report With Name "Top Attacks by Volume4"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Volume],devices:[All],showTable:true |
      | Time Definitions.Date | Relative:[Months,2]                                                                                 |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                |
      | Format                | Select: CSV                                                                                         |
    Then UI Delete Report With Name "Top Attacks by Volume4"


  @SID_24
  Scenario: create new Top Attacks by Protocol1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Protocol Report1"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Protocol],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                    |
      | Time Definitions.Date | Quick:This Week                                                                                      |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                                         |
      | Format                | Select: CSV                                                                                          |
    Then UI "Validate" Report With Name "Top Attacks by Protocol Report1"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Protocol],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                    |
      | Time Definitions.Date | Quick:This Week                                                                                      |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                                         |
      | Format                | Select: CSV                                                                                          |
    Then UI Delete Report With Name "Top Attacks by Protocol Report1"


  @SID_25
  Scenario: create new Top Attacks by Protocol2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Protocol Report2"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Protocol],devices:[All],showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:1W                                                                                              |
      | Schedule              | Run Every:Once, On Time:+6H                                                                           |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                  |
      | Format                | Select: PDF                                                                                           |
    Then UI "Validate" Report With Name "Top Attacks by Protocol Report2"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Protocol],devices:[All],showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:1W                                                                                              |
      | Schedule              | Run Every:Once, On Time:+6H                                                                           |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                  |
      | Format                | Select: PDF                                                                                           |
    Then UI Delete Report With Name "Top Attacks by Protocol Report2"


  @SID_26
  Scenario: create new Top Attacks by Protocol3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Protocol Report3"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Protocol],devices:[{deviceIndex:10}],showTable:false |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                   |
      | Format                | Select: HTML                                                                                                       |
    Then UI "Validate" Report With Name "Top Attacks by Protocol Report3"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Protocol],devices:[{deviceIndex:10}],showTable:false |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                   |
      | Format                | Select: HTML                                                                                                       |
    Then UI Delete Report With Name "Top Attacks by Protocol Report3"

  @SID_27
  Scenario: create new Top Attacks by Protocol4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Protocol Report4"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Protocol],devices:[All],showTable:true |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                 |
      | Format                | Select: CSV                                                                                          |
    Then UI "Validate" Report With Name "Top Attacks by Protocol Report4"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Protocol],devices:[All],showTable:true |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                 |
      | Format                | Select: CSV                                                                                          |
    Then UI Delete Report With Name "Top Attacks by Protocol Report4"

  @SID_28
  Scenario: create new Critical Attacks by Mitigation Action1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Critical Attacks by Mitigation Action Report1"
      | Template              | reportType:DefensePro Analytics,Widgets:[Critical Attacks by Mitigation Action],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                  |
      | Time Definitions.Date | Quick:Today                                                                                                        |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                       |
      | Format                | Select: CSV                                                                                                        |
    Then UI "Validate" Report With Name "Critical Attacks by Mitigation Action Report1"
      | Template              | reportType:DefensePro Analytics,Widgets:[Critical Attacks by Mitigation Action],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                  |
      | Time Definitions.Date | Quick:Today                                                                                                        |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                       |
      | Format                | Select: CSV                                                                                                        |
    Then UI Delete Report With Name "Critical Attacks by Mitigation Action Report1"

  @SID_29
  Scenario: create new Critical Attacks by Mitigation Action2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Critical Attacks by Mitigation Action Report2"
      | Template              | reportType:DefensePro Analytics,Widgets:[Critical Attacks by Mitigation Action],devices:[All],showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                                   |
      | Time Definitions.Date | Quick:30m                                                                                                           |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                |
      | Format                | Select: PDF                                                                                                         |
    Then UI "Validate" Report With Name "Critical Attacks by Mitigation Action Report2"
      | Template              | reportType:DefensePro Analytics,Widgets:[Critical Attacks by Mitigation Action],devices:[All],showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                                   |
      | Time Definitions.Date | Quick:30m                                                                                                           |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                |
      | Format                | Select: PDF                                                                                                         |
    Then UI Delete Report With Name "Critical Attacks by Mitigation Action Report2"

  @SID_30
  Scenario: create new Critical Attacks by Mitigation Action3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Critical Attacks by Mitigation Action Report3"
      | Template              | reportType:DefensePro Analytics,Widgets:[Critical Attacks by Mitigation Action],devices:[{deviceIndex:10}],showTable:false |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                                 |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                                                                     |
      | Format                | Select: HTML                                                                                                                     |
    Then UI "Validate" Report With Name "Critical Attacks by Mitigation Action Report3"
      | Template              | reportType:DefensePro Analytics,Widgets:[Critical Attacks by Mitigation Action],devices:[{deviceIndex:10}],showTable:false |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                                 |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                                                                     |
      | Format                | Select: HTML                                                                                                                     |
    Then UI Delete Report With Name "Critical Attacks by Mitigation Action Report3"

  @SID_31
  Scenario: create new Critical Attacks by Mitigation Action4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Critical Attacks by Mitigation Action Report4"
      | Template              | reportType:DefensePro Analytics,Widgets:[Critical Attacks by Mitigation Action],devices:[All],showTable:true |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                    |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                               |
      | Format                | Select: CSV                                                                                                        |
    Then UI "Validate" Report With Name "Critical Attacks by Mitigation Action Report4"
      | Template              | reportType:DefensePro Analytics,Widgets:[Critical Attacks by Mitigation Action],devices:[All],showTable:true |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                    |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                               |
      | Format                | Select: CSV                                                                                                        |
    Then UI Delete Report With Name "Critical Attacks by Mitigation Action Report4"

  @SID_32
  Scenario: create new Attacks by Threat Category1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Threat Category Report1"
      | Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Threat Category],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                       |
      | Time Definitions.Date | Quick:This Month                                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                         |
      | Format                | Select: CSV                                                                                             |
    Then UI "Validate" Report With Name "Attacks by Threat Category Report1"
      | Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Threat Category],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                       |
      | Time Definitions.Date | Quick:This Month                                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                         |
      | Format                | Select: CSV                                                                                             |
    Then UI Delete Report With Name "Attacks by Threat Category Report1"

  @SID_33
  Scenario: create new Attacks by Threat Category2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Threat Category Report2"
      | Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Threat Category],devices:[All],showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                          |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                     |
      | Format                | Select: PDF                                                                                              |
    Then UI "Validate" Report With Name "Attacks by Threat Category Report2"
      | Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Threat Category],devices:[All],showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                          |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                     |
      | Format                | Select: PDF                                                                                              |
    Then UI Delete Report With Name "Attacks by Threat Category Report2"

  @SID_34
  Scenario: create new Attacks by Threat Category3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Threat Category Report3"
      | Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Threat Category],devices:[{deviceIndex:10}],showTable:false |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                   |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                          |
      | Format                | Select: HTML                                                                                                          |
    Then UI "Validate" Report With Name "Attacks by Threat Category Report3"
      | Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Threat Category],devices:[{deviceIndex:10}],showTable:false |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                   |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                          |
      | Format                | Select: HTML                                                                                                          |
    Then UI Delete Report With Name "Attacks by Threat Category Report3"

  @SID_35
  Scenario: create new Attacks by Threat Category4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Threat Category Report4"
      | Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Threat Category],devices:[All],showTable:true |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                             |
      | Time Definitions.Date | Quick:Today                                                                                             |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                    |
      | Format                | Select: CSV                                                                                             |
    Then UI "Validate" Report With Name "Attacks by Threat Category Report4"
      | Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Threat Category],devices:[All],showTable:true |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                             |
      | Time Definitions.Date | Quick:Today                                                                                             |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                    |
      | Format                | Select: CSV                                                                                             |
    Then UI Delete Report With Name "Attacks by Threat Category Report4"

  @SID_36
  Scenario: create new Attacks by Mitigation Action1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Mitigation Action Report1"
      | Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Mitigation Action],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                         |
      | Time Definitions.Date | Quick:Quarter                                                                                             |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                                              |
      | Format                | Select: CSV                                                                                               |
    Then UI "Validate" Report With Name "Attacks by Mitigation Action Report1"
      | Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Mitigation Action],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                         |
      | Time Definitions.Date | Quick:Quarter                                                                                             |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                                              |
      | Format                | Select: CSV                                                                                               |
    Then UI Delete Report With Name "Attacks by Mitigation Action Report1"

  @SID_37
  Scenario: create new Attacks by Mitigation Action2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Mitigation Action Report2"
      | Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Mitigation Action],devices:[All],showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                            |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: PDF                                                                                                |
    Then UI "Validate" Report With Name "Attacks by Mitigation Action Report2"
      | Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Mitigation Action],devices:[All],showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                            |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: PDF                                                                                                |
    Then UI Delete Report With Name "Attacks by Mitigation Action Report2"

  @SID_38
  Scenario: create new Attacks by Mitigation Action3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Mitigation Action Report3"
      | Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Mitigation Action],devices:[{deviceIndex:10}],showTable:false |
      | Time Definitions.Date | Quick:Today                                                                                                             |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                             |
      | Format                | Select: HTML                                                                                                            |
    Then UI "Validate" Report With Name "Attacks by Mitigation Action Report3"
      | Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Mitigation Action],devices:[{deviceIndex:10}],showTable:false |
      | Time Definitions.Date | Quick:Today                                                                                                             |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                             |
      | Format                | Select: HTML                                                                                                            |
    Then UI Delete Report With Name "Attacks by Mitigation Action Report3"


  @SID_39
  Scenario: create new Attacks by Mitigation Action4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Mitigation Action Report4"
      | Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Mitigation Action],devices:[All],showTable:true |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                          |
      | Schedule              | Run Every:Once, On Time:+6H                                                                               |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                      |
      | Format                | Select: CSV                                                                                               |
    Then UI "Validate" Report With Name "Attacks by Mitigation Action Report4"
      | Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Mitigation Action],devices:[All],showTable:true |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                          |
      | Schedule              | Run Every:Once, On Time:+6H                                                                               |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                      |
      | Format                | Select: CSV                                                                                               |
    Then UI Delete Report With Name "Attacks by Mitigation Action Report4"

  @SID_40
  Scenario: Logout
    Then UI logout and close browser