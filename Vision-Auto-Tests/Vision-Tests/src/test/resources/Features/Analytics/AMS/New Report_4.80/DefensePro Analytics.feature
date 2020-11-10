

Feature: Israel and Noam

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "NEW REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: create new Traffic Bandwidth1
    Given UI "Create" Report With Name "Traffic Bandwidth Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[bps,Inbound,All]}] , devices:All , showTable:true|
      | Logo                  | reportLogoPNG.png                                                                                               |
      | Format                | Select: PDF                                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                 |
      | Time Definitions.Date | Quick:Today                                                                                                     |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                            |

  @SID_3
  Scenario: create new Traffic Bandwidth2
    Given UI "Create" Report With Name "Traffic Bandwidth Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[pps,Outbound,All]}] , devices:[{deviceIndex:10}] , showTable:false|
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                                                                     |
      | Time Definitions.Date | Quick:Yesterday                                                                                                                  |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                             |

  @SID_4
  Scenario: create new Traffic Bandwidth3
    Given UI "Create" Report With Name "Traffic Bandwidth Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[bps,Outbound,All]}] , devices:All , showTable:true|
      | Time Definitions.Date | Quick:Quarter                                                                                                    |
      | Format                | Select: PDF                                                                                                      |

  @SID_5
  Scenario: create new Traffic Bandwidth4
    Given UI "Create" Report With Name "Traffic Bandwidth Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[pps,Inbound,All]}] , devices:All , showTable:true|
      | Time Definitions.Date | Quick:Quarter                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                     |
      | Format                | Select: HTML                                                                                                    |

  @SID_6
  Scenario: create new Traffic Bandwidth5
    Given UI "Create" Report With Name "Traffic Bandwidth Report5"
      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[bps,Inbound,50]}] , devices:All , showTable:true|
      | Time Definitions.Date | Quick:Quarter                                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                 |
      | Format                | Select: HTML                                                                                                |

  @SID_7
  Scenario: create new Traffic Bandwidth6
    Given UI "Create" Report With Name "Traffic Bandwidth Report6"
      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}] , devices:All , showTable:true|
      | Time Definitions.Date | Quick:Quarter                                                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                  |
      | Format                | Select: CSV                                                                                                  |

  @SID_8
  Scenario: create new Connections Rate1
    Given UI "Create" Report With Name "Connections Rate Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[Connections Rate] , devices:[{deviceIndex:10}] , showTable:true|
      | Logo                  | reportLogoPNG.png                                                                                         |
      | Time Definitions.Date | Quick:1D                                                                                                  |
      | Schedule              | Run Every:Daily                                                                                           |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                      |
      | Format                | Select: CSV                                                                                               |

  @SID_9
  Scenario: create new Connections Rate2
    Given UI "Create" Report With Name "Connections Rate Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[Connections Rate] , devices:[{deviceIndex:10}] , showTable:true|
      | Time Definitions.Date | Quick:1H                                                                                                  |
      | Schedule              | Run Every:Once                                                                                            |
      | Format                | Select: PDF                                                                                               |

  @SID_10
  Scenario: create new Connections Rate3
    Given UI "Create" Report With Name "Connections Rate Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[Connections Rate] , devices:All , showTable:false|
      | Logo                  | reportLogoPNG.png                                                                           |
      | Time Definitions.Date | Relative:Weeks                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                             |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                        |
      | Format                | Select: HTML                                                                                |

  @SID_11
  Scenario: create new Connections Rate4
    Given UI "Create" Report With Name "Connections Rate Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[Connections Rate] , devices:All , showTable:true|
      | Logo                  | reportLogoPNG.png                                                                          |
      | Time Definitions.Date | Quick:This Week                                                                            |
      | Format                | Select: CVS                                                                                |

  @SID_12
  Scenario: create new Concurrent Connections1
    Given UI "Create" Report With Name "Concurrent Connections Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[Concurrent Connections] , devices:All , showTable:true|
      | Logo                  | reportLogoPNG.png                                                                                |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47:16, +0d]                                                              |
      | Schedule              | Run Every:Once                                                                                   |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                             |
      | Format                | Select: PDF                                                                                      |

  @SID_13
  Scenario: create new Concurrent Connections2
    Given UI "Create" Report With Name "Concurrent Connections Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[Concurrent Connections] , devices:All , showTable:false|
      | Logo                  | reportLogoPNG.png                                                                                 |
      | Time Definitions.Date | Quick:Quarter                                                                                     |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                      |
      | Format                | Select: HTML                                                                                      |

  @SID_14
  Scenario: create new Concurrent Connections3
    Given UI "Create" Report With Name "Concurrent Connections Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[Concurrent Connections] , devices:[{deviceIndex:10}] , showTable:false|
      | Time Definitions.Date | Quick:This Month                                                                                                 |
      | Schedule              | Run Every:Daily                                                                                                  |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                             |
      | Format                | Select: [PDF,CSV]                                                                                                |

  @SID_15
  Scenario: create new Concurrent Connections4
    Given UI "Create" Report With Name "Concurrent Connections Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[Concurrent Connections] , devices:All , showTable:true|
      | Time Definitions.Date | Quick:Yesterday                                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB]                                                  |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                             |

  @SID_16
  Scenario: create new Top Attacks1
    Given UI "Create" Report With Name "Top Attacks Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks] , devices:All , showTable:true|
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Quick:1D                                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                          |
      | Format                | Select: CSV                                                                           |

  @SID_17
  Scenario: create new Top Attacks2
    Given UI "Create" Report With Name "Top Attacks Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks] , devices:All , showTable:false|
      | Logo                  | reportLogoPNG.png                                                                      |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47:16, +0d]                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                        |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                   |
      | Format                | Select: PDF                                                                            |

  @SID_18
  Scenario: create new Top Attacks3
    Given UI "Create" Report With Name "Top Attacks Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks] , devices:[{deviceIndex:10}] , showTable:false|
      | Time Definitions.Date | Relative:Hours                                                                                        |
      | Schedule              | Run Every:Once                                                                                        |
      | Format                | Select: HTML                                                                                          |

  @SID_19
  Scenario: create new Top Attacks4
    Given UI "Create" Report With Name "Top Attacks Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks] , devices:All , showTable:true|
      | Time Definitions.Date | Relative:Months                                                                       |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                  |
      | Format                | Select: CSV                                                                           |

  @SID_20
  Scenario: create new Top Attacks by Bandwidth1
    Given UI "Create" Report With Name "Top Attacks by Bandwidth Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Bandwidth] , devices:All , showTable:true|
      | Logo                  | reportLogoPNG.png                                                                                  |
      | Time Definitions.Date | Quick:Previous Month                                                                               |
      | Schedule              | Run Every:Once                                                                                     |
      | Format                | Select: CSV                                                                                        |

  @SID_21
  Scenario: create new Top Attacks by Bandwidth2
    Given UI "Create" Report With Name "Top Attacks by Bandwidth Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Bandwidth] , devices:All , showTable:false|
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Quick:Today                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUL]                                                     |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                |
      | Format                | Select: PDF                                                                                         |

  @SID_22
  Scenario: create new Top Attacks by Bandwidth3
    Given UI "Create" Report With Name "Top Attacks by Bandwidth Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Bandwidth] , devices:[{deviceIndex:10}] , showTable:false|
      | Time Definitions.Date | Absolute:[02.11.2020 13:47:16, +0d]                                                                                |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[THU]                                                                       |
      | Format                | Select: HTML                                                                                                       |

  @SID_23
  Scenario: create new Top Attacks by Bandwidth4
    Given UI "Create" Report With Name "Top Attacks by Bandwidth Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Bandwidth] , devices:All , showTable:true|
      | Time Definitions.Date | Relative:Months                                                                                    |
      | Schedule              | Run Every:Daily                                                                                    |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                               |
      | Format                | Select: CSV                                                                                        |

  @SID_24
  Scenario: create new Top Attacks by Protocol1
    Given UI "Create" Report With Name "Top Attacks by Protocol Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Protocol] , devices:All , showTable:true|
      | Logo                  | reportLogoPNG.png                                                                                 |
      | Time Definitions.Date | Quick:This Week                                                                                   |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[MON]                                                      |
      | Format                | Select: CSV                                                                                       |

  @SID_25
  Scenario: create new Top Attacks by Protocol2
    Given UI "Create" Report With Name "Top Attacks by Protocol Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Protocol] , devices:All , showTable:false|
      | Logo                  | reportLogoPNG.png                                                                                  |
      | Time Definitions.Date | Quick:1W                                                                                           |
      | Schedule              | Run Every:Once                                                                                     |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                               |
      | Format                | Select: PDF                                                                                        |

  @SID_26
  Scenario: create new Top Attacks by Protocol3
    Given UI "Create" Report With Name "Top Attacks by Protocol Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Protocol] , devices:[{deviceIndex:10}] , showTable:false|
      | Time Definitions.Date | Absolute:[02.11.2020 13:47:16, +0d]                                                                               |
      | Format                | Select: HTML                                                                                                      |

  @SID_27
  Scenario: create new Top Attacks by Protocol4
    Given UI "Create" Report With Name "Top Attacks by Protocol Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Protocol] , devices:All , showTable:true|
      | Time Definitions.Date | Relative:Weeks                                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                   |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                              |
      | Format                | Select: CSV                                                                                       |

  @SID_28
  Scenario: create new Critical Attacks by Mitigation Action1
    Given UI "Create" Report With Name "Critical Attacks by Mitigation Action Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[Critical Attacks by Mitigation Action] , devices:All , showTable:true|
      | Logo                  | reportLogoPNG.png                                                                                               |
      | Time Definitions.Date | Quick:Today                                                                                                     |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                                    |
      | Format                | Select: CSV                                                                                                     |

  @SID_29
  Scenario: create new Critical Attacks by Mitigation Action2
    Given UI "Create" Report With Name "Critical Attacks by Mitigation Action Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[Critical Attacks by Mitigation Action] , devices:All , showTable:false|
      | Logo                  | reportLogoPNG.png                                                                                  |
      | Time Definitions.Date | Quick:30m                                                                                          |
      | Schedule              | Run Every:Daily                                                                                    |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                               |
      | Format                | Select: PDF                                                                                        |

  @SID_30
  Scenario: create new Critical Attacks by Mitigation Action3
    Given UI "Create" Report With Name "Critical Attacks by Mitigation Action Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[Critical Attacks by Mitigation Action] , devices:[{deviceIndex:10}] , showTable:false|
      | Time Definitions.Date | Absolute:[02.11.2020 13:47:16, +0d]                                                                                             |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[MON]                                                                                    |
      | Format                | Select: HTML                                                                                                                    |

  @SID_31
  Scenario: create new Critical Attacks by Mitigation Action4
    Given UI "Create" Report With Name "Critical Attacks by Mitigation Action Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[Critical Attacks by Mitigation Action] , devices:All , showTable:true|
      | Time Definitions.Date | Relative:Days                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                 |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                            |
      | Format                | Select: CSV                                                                                                     |

  @SID_32
  Scenario: create new Attacks by Threat Category1
    Given UI "Create" Report With Name "Attacks by Threat Category Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Threat Category] , devices:All , showTable:true|
      | Logo                  | reportLogoPNG.png                                                                                    |
      | Time Definitions.Date | Quick:This Month                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                      |
      | Format                | Select: CSV                                                                                          |

  @SID_33
  Scenario: create new Attacks by Threat Category2
    Given UI "Create" Report With Name "Attacks by Threat Category Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Threat Category] , devices:All , showTable:false|
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47:16, +0d]                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                       |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                  |
      | Format                | Select: PDF                                                                                           |

  @SID_34
  Scenario: create new Attacks by Threat Category3
    Given UI "Create" Report With Name "Attacks by Threat Category Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Threat Category] , devices:[{deviceIndex:10}] , showTable:false|
      | Time Definitions.Date | Relative:Months                                                                                                      |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                                                         |
      | Format                | Select: HTML                                                                                                         |

  @SID_35
  Scenario: create new Attacks by Threat Category4
    Given UI "Create" Report With Name "Attacks by Threat Category Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Threat Category] , devices:All , showTable:true|
      | Schedule              | Run Every:Daily                                                                                      |
      | Time Definitions.Date | Quick:Today                                                                                          |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                 |
      | Format                | Select: CSV                                                                                          |

  @SID_36
  Scenario: create new Attacks by Mitigation Action1
    Given UI "Create" Report With Name "Attacks by Mitigation Action Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Mitigation Action] , devices:All , showTable:true|
      | Logo                  | reportLogoPNG.png                                                                                      |
      | Time Definitions.Date | Quick:Quarter                                                                                          |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[MON]                                                           |
      | Format                | Select: CSV                                                                                            |

  @SID_37
  Scenario: create new Attacks by Mitigation Action2
    Given UI "Create" Report With Name "Attacks by Mitigation Action Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Mitigation Action] , devices:All , showTable:false|
      | Logo                  | reportLogoPNG.png                                                                                       |
      | Time Definitions.Date | Relative:Hours                                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                    |
      | Format                | Select: PDF                                                                                             |

  @SID_38
  Scenario: create new Attacks by Mitigation Action3
    Given UI "Create" Report With Name "Attacks by Mitigation Action Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Mitigation Action] , devices:[{deviceIndex:10}] , showTable:false|
      | Time Definitions.Date | Quick:Today                                                                                                            |
      | Schedule              | Run Every:Daily                                                                                                        |
      | Format                | Select: HTML                                                                                                           |

  @SID_39
  Scenario: create new Attacks by Mitigation Action4
    Given UI "Create" Report With Name "Attacks by Mitigation Action Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Mitigation Action] , devices:All , showTable:true|
      | Time Definitions.Date | Absolute:[02.11.2020 13:47:16, +0d]                                                                    |
      | Schedule              | Run Every:Once                                                                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                   |
      | Format                | Select: CSV                                                                                            |

  @SID_40
  Scenario: create new Top Attack Destination1
    Given UI "Create" Report With Name "Top Attack Destination Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attack Destination] , devices:All , showTable:true|
      | Logo                  | reportLogoPNG.png                                                                                |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47:16, +0d]                                                              |
      | Format                | Select: CSV                                                                                      |

  @SID_41
  Scenario: create new Top Attack Destination2
    Given UI "Create" Report With Name "Top Attack Destination Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attack Destination] , devices:All , showTable:false|
      | Logo                  | reportLogoPNG.png                                                                                 |
      | Time Definitions.Date | Quick:This Month                                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUL]                                                   |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                              |
      | Format                | Select: PDF                                                                                       |

  @SID_42
  Scenario: create new Top Attack Destination3
    Given UI "Create" Report With Name "Top Attack Destination Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attack Destination] , devices:[{deviceIndex:10}] , showTable:false|
      | Time Definitions.Date | Relative:Hours                                                                                                   |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                                     |
      | Format                | Select: HTML                                                                                                     |

  @SID_43
  Scenario: create new Top Attack Destination4
    Given UI "Create" Report With Name "Top Attack Destination Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attack Destination] , devices:All , showTable:true|
      | Time Definitions.Date | Quick:Quarter                                                                                    |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[THU] , Once                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                             |
      | Format                | Select: CSV                                                                                      |
      |