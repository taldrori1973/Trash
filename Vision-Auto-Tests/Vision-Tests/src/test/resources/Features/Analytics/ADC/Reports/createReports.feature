Feature: Test Reports Definition

  @SID_1
  Scenario: Navigate to ADC REPORTS page
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "ADC REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: create System And Network Report1
    Given UI "Create" Report With Name "System And Network Report1"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Quick:15m                                                                             |
      | Schedule              | Run Every:Daily,On Time:+2m                                                           |
      | Format                | Select: PDF                                                                           |
    Then UI "Validate" Report With Name "System And Network Report1"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Quick:15m                                                                             |
      | Schedule              | Run Every:Daily,On Time:+2m                                                           |
      | Format                | Select: PDF                                                                           |
    Then UI Delete Report With Name "System And Network Report1"

  @SID_3
  Scenario: create System And Network Report2
    Given UI "Create" Report With Name "System And Network Report2"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Time Definitions.Date | Quick:30m                                                                             |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                          |
      | Format                | Select: HTML                                                                          |
    Then UI "Validate" Report With Name "System And Network Report2"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Time Definitions.Date | Quick:30m                                                                             |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                          |
      | Format                | Select: HTML                                                                          |
    Then UI Delete Report With Name "System And Network Report2"

  @SID_4
  Scenario: create System And Network Report3
    Given UI "Create" Report With Name "System And Network Report3"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[1] |
      | Logo                  | reportLogoPNG.png                                                                   |
      | Time Definitions.Date | Quick:1H                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[TUE,WED]                                    |
      | Format                | Select: CSV                                                                         |
    Then UI "Validate" Report With Name "System And Network Report3"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[1] |
      | Logo                  | reportLogoPNG.png                                                                   |
      | Time Definitions.Date | Quick:1H                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[TUE,WED]                                    |
      | Format                | Select: CSV                                                                         |
    Then UI Delete Report With Name "System And Network Report3"

  @SID_5
  Scenario: create System And Network Report4
    Given UI "Create" Report With Name "System And Network Report4"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[1] |
      | Time Definitions.Date | Quick:3M                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                        |
      | Format                | Select: CSV                                                                         |
    Then UI "Validate" Report With Name "System And Network Report4"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[1] |
      | Time Definitions.Date | Quick:3M                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                        |
      | Format                | Select: CSV                                                                         |
    Then UI Delete Report With Name "System And Network Report4"

  @SID_6
  Scenario: create System And Network Report5
    Given UI "Create" Report With Name "System And Network Report5"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Time Definitions.Date | Quick:1D                                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI,SAT,SUN]                                  |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                  |
      | Format                | Select: HTML                                                                          |
    Then UI "Validate" Report With Name "System And Network Report5"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Time Definitions.Date | Quick:1D                                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI,SAT,SUN]                                  |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                  |
      | Format                | Select: HTML                                                                          |
    Then UI Delete Report With Name "System And Network Report5"

  @SID_7
  Scenario: create System And Network Report6
    Given UI "Create" Report With Name "System And Network Report6"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Quick:1W                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                       |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                  |
      | Format                | Select: PDF                                                                           |
    Then UI "Validate" Report With Name "System And Network Report6"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Quick:1W                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                       |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                  |
      | Format                | Select: PDF                                                                           |
    Then UI Delete Report With Name "System And Network Report6"

  @SID_8
  Scenario: create System And Network Report7
    Given UI "Create" Report With Name "System And Network Report7"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Quick:1M                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,APR]                               |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                  |
      | Format                | Select: PDF                                                                           |
    Then UI "Validate" Report With Name "System And Network Report7"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Quick:1M                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,APR]                               |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                  |
      | Format                | Select: PDF                                                                           |
    Then UI Delete Report With Name "System And Network Report7"

  @SID_9
  Scenario: create System And Network Report8
    Given UI "Create" Report With Name "System And Network Report8"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Absolute:[-1d, +0d]                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                       |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                  |
      | Format                | Select: HTML                                                                          |
    Then UI "Validate" Report With Name "System And Network Report8"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Absolute:[-1d, +0d]                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                       |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                  |
      | Format                | Select: HTML                                                                          |
    Then UI Delete Report With Name "System And Network Report8"

  @SID_10
  Scenario: create System And Network Report9
    Given UI "Create" Report With Name "System And Network Report9"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Relative:[Hours,2]                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN,JUL,AUG,SEP]                           |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                  |
      | Format                | Select: CSV                                                                           |
    Then UI "Validate" Report With Name "System And Network Report9"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Relative:[Hours,2]                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN,JUL,AUG,SEP]                           |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                  |
      | Format                | Select: CSV                                                                           |
    Then UI Delete Report With Name "System And Network Report9"

  @SID_11
  Scenario: create System And Network Report10
    Given UI "Create" Report With Name "System And Network Report10"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[1]         |
      | Time Definitions.Date | Relative:[Days,3]                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC] |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                        |
      | Format                | Select: CSV                                                                                 |
    Then UI "Validate" Report With Name "System And Network Report10"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[1]         |
      | Time Definitions.Date | Relative:[Days,3]                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC] |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                        |
      | Format                | Select: CSV                                                                                 |
    Then UI Delete Report With Name "System And Network Report10"

  @SID_12
  Scenario: create Application Report1
    Given UI "Create" Report With Name "Application Report1"
      | Template-1            | reportType:Application , Widgets:[{Requests per Second},{End-to-End Time}] , devices:[1] |
      | Time Definitions.Date | Relative:[Weeks,4]                                                                       |
      | Schedule              | Run Every:Once, On Time:+6H                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                     |
      | Format                | Select: HTML                                                                             |
    Then UI "Validate" Report With Name "Application Report1"
      | Template-1            | reportType:Application , Widgets:[{Requests per Second},{End-to-End Time}] , devices:[1] |
      | Time Definitions.Date | Relative:[Weeks,4]                                                                       |
      | Schedule              | Run Every:Once, On Time:+6H                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                     |
      | Format                | Select: HTML                                                                             |
    Then UI Delete Report With Name "Application Report1"

  @SID_13
  Scenario: create Application Report2
    Given UI "Create" Report With Name "Application Report2"
      | Template-1            | reportType:Application ,Widgets:[{Throughput:[bps]} ,{Concurrent Connections}] , devices:[1] |
      | Time Definitions.Date | Relative:[Months,5]                                                                          |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                         |
      | Format                | Select: PDF                                                                                  |
    Then UI "Validate" Report With Name "Application Report2"
      | Template-1            | reportType:Application ,Widgets:[{Throughput:[bps]} ,{Concurrent Connections}] , devices:[1] |
      | Time Definitions.Date | Relative:[Months,5]                                                                          |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                         |
      | Format                | Select: PDF                                                                                  |
    Then UI Delete Report With Name "Application Report2"

  @SID_14
  Scenario: create Application Report3
    Given UI "Create" Report With Name "Application Report3"
      | Template-1            | reportType:Application ,Widgets:[{Requests per Second}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                       |
      | Time Definitions.Date | Quick:15m                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                             |
      | Format                | Select: PDF                                                             |
    Then UI "Validate" Report With Name "Application Report3"
      | Template-1            | reportType:Application ,Widgets:[{Requests per Second}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                       |
      | Time Definitions.Date | Quick:15m                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                             |
      | Format                | Select: PDF                                                             |
    Then UI Delete Report With Name "Application Report3"

  @SID_15
  Scenario: create Application Report4
    Given UI "Create" Report With Name "Application Report4"
      | Template-1            | reportType:Application ,Widgets:[{Throughput:[bps]}] , devices:[All] |
      | Time Definitions.Date | Quick:30m                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                         |
      | Format                | Select: HTML                                                         |
    Then UI "Validate" Report With Name "Application Report4"
      | Template-1            | reportType:Application ,Widgets:[{Throughput:[bps]}] , devices:[All] |
      | Time Definitions.Date | Quick:30m                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                         |
      | Format                | Select: HTML                                                         |
    Then UI Delete Report With Name "Application Report4"

  @SID_16
  Scenario: create Application Report5
    Given UI "Create" Report With Name "Application Report5"
      | Template-1            | reportType:Application ,Widgets:[{Concurrent Connections}] , devices:[1] |
      | Logo                  | reportLogoPNG.png                                                        |
      | Time Definitions.Date | Quick:1H                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[TUE,WED]                         |
      | Format                | Select: CSV                                                              |
    Then UI "Validate" Report With Name "Application Report5"
      | Template-1            | reportType:Application ,Widgets:[{Concurrent Connections}] , devices:[1] |
      | Logo                  | reportLogoPNG.png                                                        |
      | Time Definitions.Date | Quick:1H                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[TUE,WED]                         |
      | Format                | Select: CSV                                                              |
    Then UI Delete Report With Name "Application Report5"

  @SID_17
  Scenario: create Application Report6
    Given UI "Create" Report With Name "Application Report6"
      | Template-1            | reportType:Application ,Widgets:[{Connections per Second}] , devices:[1] |
      | Time Definitions.Date | Quick:3M                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                             |
      | Format                | Select: CSV                                                              |
    Then UI "Validate" Report With Name "Application Report6"
      | Template-1            | reportType:Application ,Widgets:[{Connections per Second}] , devices:[1] |
      | Time Definitions.Date | Quick:3M                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                             |
      | Format                | Select: CSV                                                              |
    Then UI Delete Report With Name "Application Report6"

  @SID_18
  Scenario: create Application Report7
    Given UI "Create" Report With Name "Application Report7"
      | Template-1            | reportType:Application ,Widgets:[{Groups and Content Rules}] , devices:[All] |
      | Time Definitions.Date | Quick:1D                                                                     |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI,SAT,SUN]                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody         |
      | Format                | Select: HTML                                                                 |
    Then UI "Validate" Report With Name "Application Report7"
      | Template-1            | reportType:Application ,Widgets:[{Groups and Content Rules}] , devices:[All] |
      | Time Definitions.Date | Quick:1D                                                                     |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI,SAT,SUN]                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody         |
      | Format                | Select: HTML                                                                 |
    Then UI Delete Report With Name "Application Report7"

  @SID_19
  Scenario: create Application Report8
    Given UI "Create" Report With Name "Application Report8"
      | Template-1            | reportType:Application ,Widgets:[{End-to-End Time}] , devices:[All]  |
      | Logo                  | reportLogoPNG.png                                                    |
      | Time Definitions.Date | Quick:1W                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody |
      | Format                | Select: PDF                                                          |
    Then UI "Validate" Report With Name "Application Report8"
      | Template-1            | reportType:Application ,Widgets:[{End-to-End Time}] , devices:[All]  |
      | Logo                  | reportLogoPNG.png                                                    |
      | Time Definitions.Date | Quick:1W                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody |
      | Format                | Select: PDF                                                          |
    Then UI Delete Report With Name "Application Report8"

  @SID_20
  Scenario: create Application Report9
    Given UI "Create" Report With Name "Application Report9"
      | Template-1            | reportType:Application ,Widgets:[{Connections per Second},{Groups and Content Rules},{End-to-End Time}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                       |
      | Time Definitions.Date | Quick:1M                                                                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,APR]                                                                 |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                    |
      | Format                | Select: PDF                                                                                                             |
    Then UI "Validate" Report With Name "Application Report9"
      | Template-1            | reportType:Application ,Widgets:[{Connections per Second},{Groups and Content Rules},{End-to-End Time}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                       |
      | Time Definitions.Date | Quick:1M                                                                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,APR]                                                                 |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                    |
      | Format                | Select: PDF                                                                                                             |
    Then UI Delete Report With Name "Application Report9"

  @SID_21
  Scenario: create Application Report10
    Given UI "Create" Report With Name "Application Report10"
      | Template-1            | reportType:Application ,Widgets:[{Requests per Second},{Throughput:[bps]},{Concurrent Connections}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                   |
      | Time Definitions.Date | Absolute:[-1d, +0d]                                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                                     |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                |
      | Format                | Select: HTML                                                                                                        |
    Then UI "Validate" Report With Name "Application Report10"
      | Template-1            | reportType:Application ,Widgets:[{Requests per Second},{Throughput:[bps]},{Concurrent Connections}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                   |
      | Time Definitions.Date | Absolute:[-1d, +0d]                                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                                     |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                |
      | Format                | Select: HTML                                                                                                        |
    Then UI Delete Report With Name "Application Report10"

  @SID_22
  Scenario: create Application Report11
    Given UI "Create" Report With Name "Application Report11"
      | Template-1            | reportType:Application ,Widgets:[{Concurrent Connections},{Connections per Second}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN,JUL,AUG,SEP]                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                |
      | Format                | Select: CSV                                                                                         |
    Then UI "Validate" Report With Name "Application Report11"
      | Template-1            | reportType:Application ,Widgets:[{Concurrent Connections},{Connections per Second}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN,JUL,AUG,SEP]                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                |
      | Format                | Select: CSV                                                                                         |
    Then UI Delete Report With Name "Application Report11"

  @SID_23
  Scenario: create Application Report12
    Given UI "Create" Report With Name "Application Report12"
      | Template-1            | reportType:Application ,Widgets:[{Concurrent Connections},{Connections per Second},{Groups and Content Rules}] , devices:[1] |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC]                                  |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                         |
      | Format                | Select: CSV                                                                                                                  |
    Then UI "Validate" Report With Name "Application Report12"
      | Template-1            | reportType:Application ,Widgets:[{Concurrent Connections},{Connections per Second},{Groups and Content Rules}] , devices:[1] |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC]                                  |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                         |
      | Format                | Select: CSV                                                                                                                  |
    Then UI Delete Report With Name "Application Report12"

  @SID_24
  Scenario: create Application Report13
    Given UI "Create" Report With Name "Application Report13"
      | Template-1            | reportType:Application ,Widgets:[{Requests per Second},{Throughput:[bps]},{Groups and Content Rules},{End-to-End Time}] , devices:[1] |
      | Time Definitions.Date | Relative:[Weeks,4]                                                                                                                    |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                           |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                  |
      | Format                | Select: HTML                                                                                                                          |
    Then UI "Validate" Report With Name "Application Report13"
      | Template-1            | reportType:Application ,Widgets:[{Requests per Second},{Throughput:[bps]},{Groups and Content Rules},{End-to-End Time}] , devices:[1] |
      | Time Definitions.Date | Relative:[Weeks,4]                                                                                                                    |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                           |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                  |
      | Format                | Select: HTML                                                                                                                          |
    Then UI Delete Report With Name "Application Report13"

  @SID_25
  Scenario: create Application Report14
    Given UI "Create" Report With Name "Application Report14"
      | Template-1            | reportType:Application ,Widgets:[All] , devices:[1]                  |
      | Time Definitions.Date | Relative:[Weeks,4]                                                   |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody |
      | Format                | Select: PDF                                                          |
    Then UI "Validate" Report With Name "Application Report14"
      | Template-1            | reportType:Application ,Widgets:[All] , devices:[1]                  |
      | Time Definitions.Date | Relative:[Weeks,4]                                                   |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody |
      | Format                | Select: PDF                                                          |
    Then UI Delete Report With Name "Application Report14"

  @SID_26
  Scenario: create System And Network And Application Report1
    Given UI "Create" Report With Name "System And Network And Application Report1"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[1] |
      | Template-2            | reportType:Application ,Widgets:[All] , devices:[1]                                 |
      | Time Definitions.Date | Relative:[Months,5]                                                                 |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                |
      | Format                | Select: PDF                                                                         |
    Then UI "Validate" Report With Name "System And Network And Application Report1"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[1] |
      | Template-2            | reportType:Application ,Widgets:[All] , devices:[1]                                 |
      | Time Definitions.Date | Relative:[Months,5]                                                                 |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                |
      | Format                | Select: PDF                                                                         |
    Then UI Delete Report With Name "System And Network And Application Report1"

  @SID_27
  Scenario: create System And Network And Application Report2
    Given UI "Create" Report With Name "System And Network And Application Report2"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Template-2            | reportType:Application ,Widgets:[{Requests per Second}] , devices:[All]               |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Quick:15m                                                                             |
      | Schedule              | Run Every:Daily,On Time:+2m                                                           |
      | Format                | Select: PDF                                                                           |
    Then UI "Validate" Report With Name "System And Network And Application Report2"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Template-2            | reportType:Application ,Widgets:[{Requests per Second}] , devices:[All]               |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Quick:15m                                                                             |
      | Schedule              | Run Every:Daily,On Time:+2m                                                           |
      | Format                | Select: PDF                                                                           |
    Then UI Delete Report With Name "System And Network And Application Report2"

  @SID_28
  Scenario: create System And Network And Application Report3
    Given UI "Create" Report With Name "System And Network And Application Report3"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Template-2            | reportType:Application ,Widgets:[{Throughput:[bps]}] , devices:[All]                  |
      | Time Definitions.Date | Quick:30m                                                                             |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                          |
      | Format                | Select: HTML                                                                          |
    Then UI "Validate" Report With Name "System And Network And Application Report3"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Template-2            | reportType:Application ,Widgets:[{Throughput:[bps]}] , devices:[All]                  |
      | Time Definitions.Date | Quick:30m                                                                             |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                          |
      | Format                | Select: HTML                                                                          |
    Then UI Delete Report With Name "System And Network And Application Report3"

  @SID_29
  Scenario: create System And Network And Application Report4
    Given UI "Create" Report With Name "System And Network And Application Report4"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[1] |
      | Template-2            | reportType:Application ,Widgets:[{Concurrent Connections}] , devices:[1]            |
      | Logo                  | reportLogoPNG.png                                                                   |
      | Time Definitions.Date | Quick:1H                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[TUE,WED]                                    |
      | Format                | Select: CSV                                                                         |
    Then UI "Validate" Report With Name "System And Network And Application Report4"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[1] |
      | Template-2            | reportType:Application ,Widgets:[{Concurrent Connections}] , devices:[1]            |
      | Logo                  | reportLogoPNG.png                                                                   |
      | Time Definitions.Date | Quick:1H                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[TUE,WED]                                    |
      | Format                | Select: CSV                                                                         |
    Then UI Delete Report With Name "System And Network And Application Report4"

  @SID_30
  Scenario: create System And Network And Application Report5
    Given UI "Create" Report With Name "System And Network And Application Report5"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[1] |
      | Template-2            | reportType:Application ,Widgets:[{Connections per Second}] , devices:[1]            |
      | Time Definitions.Date | Quick:3M                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                        |
      | Format                | Select: CSV                                                                         |
    Then UI "Validate" Report With Name "System And Network And Application Report5"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[1] |
      | Template-2            | reportType:Application ,Widgets:[{Connections per Second}] , devices:[1]            |
      | Time Definitions.Date | Quick:3M                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                        |
      | Format                | Select: CSV                                                                         |
    Then UI Delete Report With Name "System And Network And Application Report5"

  @SID_31
  Scenario: create System And Network And Application Report6
    Given UI "Create" Report With Name "System And Network And Application Report6"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Template-2            | reportType:Application ,Widgets:[{Groups and Content Rules}] , devices:[All]          |
      | Time Definitions.Date | Quick:1D                                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI,SAT,SUN]                                  |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                  |
      | Format                | Select: HTML                                                                          |
    Then UI "Validate" Report With Name "System And Network And Application Report6"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Template-2            | reportType:Application ,Widgets:[{Groups and Content Rules}] , devices:[All]          |
      | Time Definitions.Date | Quick:1D                                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI,SAT,SUN]                                  |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                  |
      | Format                | Select: HTML                                                                          |
    Then UI Delete Report With Name "System And Network And Application Report6"

  @SID_32
  Scenario: create System And Network And Application Report7
    Given UI "Create" Report With Name "System And Network And Application Report7"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Template-2            | reportType:Application ,Widgets:[{End-to-End Time}] , devices:[All]                   |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Quick:1W                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                       |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                  |
      | Format                | Select: PDF                                                                           |
    Then UI "Validate" Report With Name "System And Network And Application Report7"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All] |
      | Template-2            | reportType:Application ,Widgets:[{End-to-End Time}] , devices:[All]                   |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Quick:1W                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                       |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                  |
      | Format                | Select: PDF                                                                           |
    Then UI Delete Report With Name "System And Network And Application Report7"


  @SID_33
  Scenario: create System And Network And Application Report8
    Given UI "Create" Report With Name "System And Network And Application Report8"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All]                                   |
      | Template-2            | reportType:Application ,Widgets:[{Connections per Second},{Groups and Content Rules},{End-to-End Time}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                       |
      | Time Definitions.Date | Quick:1M                                                                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,APR]                                                                 |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                    |
      | Format                | Select: PDF                                                                                                             |
    Then UI "Validate" Report With Name "System And Network And Application Report8"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All]                                   |
      | Template-2            | reportType:Application ,Widgets:[{Connections per Second},{Groups and Content Rules},{End-to-End Time}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                       |
      | Time Definitions.Date | Quick:1M                                                                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,APR]                                                                 |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                    |
      | Format                | Select: PDF                                                                                                             |
    Then UI Delete Report With Name "System And Network And Application Report8"

  @SID_34
  Scenario: create System And Network And Application Report9
    Given UI "Create" Report With Name "System And Network And Application Report9"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All]                               |
      | Template-2            | reportType:Application ,Widgets:[{Requests per Second},{Throughput:[bps]},{Concurrent Connections}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                   |
      | Time Definitions.Date | Absolute:[-1d, +0d]                                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                                     |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                |
      | Format                | Select: HTML                                                                                                        |
    Then UI "Validate" Report With Name "System And Network And Application Report9"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All]                               |
      | Template-2            | reportType:Application ,Widgets:[{Requests per Second},{Throughput:[bps]},{Concurrent Connections}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                   |
      | Time Definitions.Date | Absolute:[-1d, +0d]                                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                                     |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                |
      | Format                | Select: HTML                                                                                                        |
    Then UI Delete Report With Name "System And Network And Application Report9"

  @SID_35
  Scenario: create System And Network And Application Report10
    Given UI "Create" Report With Name "System And Network And Application Report10"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All]               |
      | Template-2            | reportType:Application ,Widgets:[{Concurrent Connections},{Connections per Second}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN,JUL,AUG,SEP]                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                |
      | Format                | Select: CSV                                                                                         |
    Then UI "Validate" Report With Name "System And Network And Application Report10"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All]               |
      | Template-2            | reportType:Application ,Widgets:[{Concurrent Connections},{Connections per Second}] , devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN,JUL,AUG,SEP]                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                |
      | Format                | Select: CSV                                                                                         |
    Then UI Delete Report With Name "System And Network And Application Report10"

  @SID_36
  Scenario: create System And Network And Application Report11
    Given UI "Create" Report With Name "System And Network And Application Report11"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All]                                     |
      | Template-2            | reportType:Application,Widgets:[{Concurrent Connections},{Connections per Second},{Groups and Content Rules}],devices:[1] |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC]                               |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                      |
      | Format                | Select: CSV                                                                                                               |
    Then UI "Validate" Report With Name "System And Network And Application Report11"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All]                                     |
      | Template-2            | reportType:Application,Widgets:[{Concurrent Connections},{Connections per Second},{Groups and Content Rules}],devices:[1] |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC]                               |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                      |
      | Format                | Select: CSV                                                                                                               |
    Then UI Delete Report With Name "System And Network And Application Report11"

  @SID_37
  Scenario: create System And Network And Application Report12
    Given UI "Create" Report With Name "System And Network And Application Report12"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All]                                              |
      | Template-2            | reportType:Application,Widgets:[{Requests per Second},{Throughput:[bps]},{Groups and Content Rules},{End-to-End Time}],devices:[1] |
      | Time Definitions.Date | Relative:[Weeks,4]                                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                        |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                               |
      | Format                | Select: HTML                                                                                                                       |
    Then UI "Validate" Report With Name "System And Network And Application Report12"
      | Template-1            | reportType:System And Network , Widgets:[{Ports Traffic Information}] , devices:[All]                                              |
      | Template-2            | reportType:Application,Widgets:[{Requests per Second},{Throughput:[bps]},{Groups and Content Rules},{End-to-End Time}],devices:[1] |
      | Time Definitions.Date | Relative:[Weeks,4]                                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                        |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                               |
      | Format                | Select: HTML                                                                                                                       |
    Then UI Delete Report With Name "System And Network And Application Report12"
