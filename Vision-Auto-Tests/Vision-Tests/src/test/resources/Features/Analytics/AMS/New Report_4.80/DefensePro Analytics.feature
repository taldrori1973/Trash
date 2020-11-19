@TCtest11
Feature: DefensePro Analytics


#Scenario: Create Report of Traffic Global Kbps Inbound
#Given UI "Create" Report With Name "Traffic Report"
#| Template-1            | reportType:DefensePro Analytics , Widgets:[Concurrent Connections],devices:[{devicesIndex:10,devicePorts:[1],devicePolicies:[BDOS,APOL]},{deviceIndex:10}]                             |
#| Template-2            | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[bps/pps,Inbound/Outbound,All/1-100]},ALL/specific widgets],devices:[{devicesIndex:11,devicePorts:[1,2],devicePolicies:[BDOS,APOL]},{deviceIndex:10}] |
#| Format                | Select: CSV                                                                                                                                                                            |
#|Template-3             |reportType:DefensePro Analytics , Widgets:[BDoS-TCP SYN,Concurrent Connections],devices:[{devicesIndex:11,devicePorts:[1,2],devicePolicies:[BDOS,APOL]},{deviceIndex:10}]|
#| Logo                  | reportLogoPNG.png                                                                                                                                                                      |
#| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN,SEP,DEC]                                                                                                                                |
#| Time Definitions.Date | Quick:This Month                                                                                                                                                                       |



  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "NEW REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: create new Traffic Bandwidth1
    Given UI "Create" Report With Name "Traffic Bandwidth Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[bps,Inbound,All]}] , devices:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                  |
      | Format                | Select: PDF                                                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                    |
      | Time Definitions.Date | Quick:Today                                                                                                        |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                               |

  @SID_3
  Scenario: create new Traffic Bandwidth2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Bandwidth Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[pps,Outbound,All]}] , devices:[{deviceIndex:10}] , showTable:false |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                                                                      |
      | Time Definitions.Date | Quick:Yesterday                                                                                                                   |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                              |

  @SID_4
  Scenario: create new Traffic Bandwidth3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Bandwidth Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[bps,Outbound,All]}] , devices:[All] , showTable:true |
      | Time Definitions.Date | Quick:Quarter                                                                                                       |
      | Format                | Select: PDF                                                                                                         |

  @SID_5
  Scenario: create new Traffic Bandwidth4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Bandwidth Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[pps,Inbound,All]}] , devices:[All] , showTable:true |
      | Time Definitions.Date | Quick:Quarter                                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                        |
      | Format                | Select: HTML                                                                                                       |

  @SID_6
  Scenario: create new Traffic Bandwidth5
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Bandwidth Report5"
      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[bps,Inbound,50]}] , devices:[All] , showTable:true |
      | Time Definitions.Date | Quick:Quarter                                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                       |
      | Format                | Select: HTML                                                                                                      |

  @SID_7
  Scenario: create new Traffic Bandwidth6
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Bandwidth Report6"
      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}] , devices:[All] , showTable:true |
      | Time Definitions.Date | Quick:Quarter                                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                        |
      | Format                | Select: CSV                                                                                                        |

  @SID_8
  Scenario: create new Connections Rate1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Connections Rate Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[Connections Rate] , devices:[{deviceIndex:10}] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Quick:1D                                                                                                   |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                           |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: CSV                                                                                                |

  @SID_9
  Scenario: create new Connections Rate2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Connections Rate Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[Connections Rate] , devices:[{deviceIndex:10}] , showTable:true |
      | Time Definitions.Date | Quick:1H                                                                                                   |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                             |
      | Format                | Select: PDF                                                                                                |

  @SID_10
  Scenario: create new Connections Rate3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Connections Rate Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[Connections Rate] , devices:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                              |
      | Time Definitions.Date | Relative:[Hours,3]                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                           |
      | Format                | Select: HTML                                                                                   |

  @SID_11
  Scenario: create new Connections Rate4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Connections Rate Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[Connections Rate] , devices:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                             |
      | Time Definitions.Date | Quick:This Week                                                                               |
      | Format                | Select: CSV                                                                                   |

  @SID_12
  Scenario: create new Concurrent Connections1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Concurrent Connections Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[Concurrent Connections] , devices:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                |
      | Format                | Select: PDF                                                                                         |

  @SID_13
  Scenario: create new Concurrent Connections2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Concurrent Connections Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[Concurrent Connections] , devices:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                    |
      | Time Definitions.Date | Quick:Quarter                                                                                        |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                         |
      | Format                | Select: HTML                                                                                         |

  @SID_14
  Scenario: create new Concurrent Connections3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Concurrent Connections Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[Concurrent Connections] , devices:[{deviceIndex:10}] , showTable:false |
      | Time Definitions.Date | Quick:This Month                                                                                                  |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                   |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                              |
      | Format                | Select: [PDF,CSV]                                                                                                 |

  @SID_15
  Scenario: create new Concurrent Connections4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Concurrent Connections Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[Concurrent Connections] , devices:[All] , showTable:true |
      | Time Definitions.Date | Quick:Yesterday                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB]                                                     |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                |

  @SID_16
  Scenario: create new Top Attacks1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks] , devices:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                        |
      | Time Definitions.Date | Quick:1D                                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                             |
      | Format                | Select: CSV                                                                              |

  @SID_17
  Scenario: create new Top Attacks2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks] , devices:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                         |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                       |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                           |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                      |
      | Format                | Select: PDF                                                                               |

  @SID_18
  Scenario: create new Top Attacks3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks] , devices:[{deviceIndex:10}] , showTable:false |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                     |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                         |
      | Format                | Select: HTML                                                                                           |

  @SID_19
  Scenario: create new Top Attacks4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks] , devices:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Months,2]                                                                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                     |
      | Format                | Select: CSV                                                                              |

  @SID_20
  Scenario: create new Top Attacks by Bandwidth1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Bandwidth Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Bandwidth] , devices:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:Previous Month                                                                                  |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                        |
      | Format                | Select: CSV                                                                                           |

  @SID_21
  Scenario: create new Top Attacks by Bandwidth2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Bandwidth Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Bandwidth] , devices:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                      |
      | Time Definitions.Date | Quick:Today                                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUL]                                                        |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                   |
      | Format                | Select: PDF                                                                                            |

  @SID_22
  Scenario: create new Top Attacks by Bandwidth3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Bandwidth Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Bandwidth] , devices:[{deviceIndex:10}] , showTable:false |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[THU]                                                                        |
      | Format                | Select: HTML                                                                                                        |

  @SID_23
  Scenario: create new Top Attacks by Bandwidth4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Bandwidth Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Bandwidth] , devices:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Months,2]                                                                                   |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                       |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                  |
      | Format                | Select: CSV                                                                                           |

  @SID_24
  Scenario: create new Top Attacks by Protocol1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Protocol Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Protocol] , devices:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                    |
      | Time Definitions.Date | Quick:This Week                                                                                      |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[MON]                                                         |
      | Format                | Select: CSV                                                                                          |

  @SID_25
  Scenario: create new Top Attacks by Protocol2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Protocol Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Protocol] , devices:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:1W                                                                                              |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                        |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                  |
      | Format                | Select: PDF                                                                                           |

  @SID_26
  Scenario: create new Top Attacks by Protocol3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Protocol Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Protocol] , devices:[{deviceIndex:10}] , showTable:false |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                |
      | Format                | Select: HTML                                                                                                       |

  @SID_27
  Scenario: create new Top Attacks by Protocol4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Protocol Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Protocol] , devices:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                 |
      | Format                | Select: CSV                                                                                          |

  @SID_28
  Scenario: create new Critical Attacks by Mitigation Action1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Critical Attacks by Mitigation Action Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[Critical Attacks by Mitigation Action] , devices:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                  |
      | Time Definitions.Date | Quick:Today                                                                                                        |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                                       |
      | Format                | Select: CSV                                                                                                        |

  @SID_29
  Scenario: create new Critical Attacks by Mitigation Action2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Critical Attacks by Mitigation Action Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[Critical Attacks by Mitigation Action] , devices:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                                   |
      | Time Definitions.Date | Quick:30m                                                                                                           |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                     |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                |
      | Format                | Select: PDF                                                                                                         |

  @SID_30
  Scenario: create new Critical Attacks by Mitigation Action3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Critical Attacks by Mitigation Action Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[Critical Attacks by Mitigation Action] , devices:[{deviceIndex:10}] , showTable:false |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[MON]                                                                                     |
      | Format                | Select: HTML                                                                                                                     |

  @SID_31
  Scenario: create new Critical Attacks by Mitigation Action4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Critical Attacks by Mitigation Action Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[Critical Attacks by Mitigation Action] , devices:[All] , showTable:true |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                    |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                               |
      | Format                | Select: CSV                                                                                                        |

  @SID_32
  Scenario: create new Attacks by Threat Category1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Threat Category Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Threat Category] , devices:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                       |
      | Time Definitions.Date | Quick:This Month                                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                         |
      | Format                | Select: CSV                                                                                             |

  @SID_33
  Scenario: create new Attacks by Threat Category2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Threat Category Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Threat Category] , devices:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                          |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                     |
      | Format                | Select: PDF                                                                                              |

  @SID_34
  Scenario: create new Attacks by Threat Category3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Threat Category Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Threat Category] , devices:[{deviceIndex:10}] , showTable:false |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                   |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                                                          |
      | Format                | Select: HTML                                                                                                          |

  @SID_35
  Scenario: create new Attacks by Threat Category4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Threat Category Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Threat Category] , devices:[All] , showTable:true |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                         |
      | Time Definitions.Date | Quick:Today                                                                                             |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                    |
      | Format                | Select: CSV                                                                                             |

  @SID_36
  Scenario: create new Attacks by Mitigation Action1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Mitigation Action Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Mitigation Action] , devices:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                         |
      | Time Definitions.Date | Quick:Quarter                                                                                             |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[MON]                                                              |
      | Format                | Select: CSV                                                                                               |

  @SID_37
  Scenario: create new Attacks by Mitigation Action2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Mitigation Action Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Mitigation Action] , devices:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                            |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: PDF                                                                                                |

  @SID_38
  Scenario: create new Attacks by Mitigation Action3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Mitigation Action Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Mitigation Action] , devices:[{deviceIndex:10}] , showTable:false |
      | Time Definitions.Date | Quick:Today                                                                                                             |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                         |
      | Format                | Select: HTML                                                                                                            |

  @SID_39
  Scenario: create new Attacks by Mitigation Action4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Mitigation Action Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Mitigation Action] , devices:[All] , showTable:true |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                       |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                            |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                      |
      | Format                | Select: CSV                                                                                               |

  @SID_40
  Scenario: create new Top Attack Destinations1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Destinations Report1"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attack Destinations] , devices:[All] , showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                 |
      | Format                | Select: CSV                                                                                         |

  @SID_41
  Scenario: create new Top Attack Destinations2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Destinations Report2"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attack Destinations] , devices:[All] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                                    |
      | Time Definitions.Date | Quick:This Month                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUL]                                                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                 |
      | Format                | Select: PDF                                                                                          |

  @SID_42
  Scenario: create new Top Attack Destinations3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Destinations Report3"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attack Destinations] , devices:[{deviceIndex:10}] , showTable:false |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                                |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                                      |
      | Format                | Select: HTML                                                                                                      |

  @SID_43
  Scenario: create new Top Attack Destinations4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Destinations Report4"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attack Destinations] , devices:[All] , showTable:true |
      | Time Definitions.Date | Quick:Quarter                                                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[THU]                                                  |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                |
      | Format                | Select: CSV                                                                                         |

    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_44
  Scenario: Top Attack Sources Report - Time: Quick Range (30m)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Sources_Time_Quick_30m"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attack Sources], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                   |
      | Logo                  | reportLogoPNG.png                                                                             |
      | Time Definitions.Date | Quick:30m                                                                                     |


  @SID_45
  Scenario: Top Attack Sources Report - Time: Absolute
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Sources_Time_Absolute"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attack Sources],devices:[{deviceIndex:10}] |
      | Format                | Select: PDF                                                                                |
      | Logo                  | reportLogoPNG.png                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body             |

  @SID_46
  Scenario:  Top Attack Sources Report - Time: Relative (Weeks)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Sources Time_Relative_Weeks"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attack Sources],devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                               |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                         |

  @SID_47
  Scenario:  Top Attack Sources Report - Schedule: (Weekly,MON)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Sources  Schedule_Weekly)"
      | Template | reportType:DefensePro Analytics , Widgets:[Top Attack Sources],devices:[All], showTable:true |
      | Format   | Select: CSV                                                                                  |
      | Schedule | Run Every:Weekly, On Time:+6H, At Days:[MON]                                                 |
      | Share    | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body               |

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_48
  Scenario: Top Scanners Report - Time:Quick Range (3M), Schedule: (Daily)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Scanners Time_Quick_3M  Schedule_Daily"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Scanners], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                             |
      | Logo                  | reportLogoPNG.png                                                                       |
      | Time Definitions.Date | Quick:3M                                                                                |
      | Schedule              | Run Every:Daily,On Time:+2m                                                             |

  @SID_49
  Scenario: Top Scanners Report - Time: Absolute, Schedule: (Weekly,Fri)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Scanners Time_Absolute  Schedule_Weekly"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Scanners],devices:[{deviceIndex:10}] |
      | Format                | Select: PDF                                                                          |
      | Logo                  | reportLogoPNG.png                                                                    |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                  |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body       |

  @SID_50
  Scenario:  Top Scanners Report - Time: Relative (Months)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Scanners Time_Relative "
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Scanners],devices:[{deviceIndex:10, deviceIndex:11}] |
      | Format                | Select: HTML                                                                                          |
      | Time Definitions.Date | Relative:[Months,4]                                                                                   |

  @SID_51
  Scenario:  Top Scanners Report - Time:Quick Range (Quarter), Schedule: (Monthly,OCT)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Scanners Time_Quarter  Schedule_Monthly"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Scanners],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                        |
      | Time Definitions.Date | Quick:Quarter                                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body         |

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_52
  Scenario: Top Probed IP Addresses Report - Time:Quick Range (This Week), Schedule:(Daily)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Probed IP Addresses Time_Quick_This Week  Schedule_Daily"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Probed IP Addresses], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                        |
      | Logo                  | reportLogoPNG.png                                                                                  |
      | Time Definitions.Date | Quick:This Week                                                                                    |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                        |

  @SID_53
  Scenario: Top Probed IP Addresses Report - Time: Absolute, Schedule: (Weekly,Sun)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Probed IP Addresses Time_Absolute  Schedule_Weekly"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Probed IP Addresses],devices:[{deviceIndex:10}] |
      | Format                | Select: PDF                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                               |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                             |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |

  @SID_54
  Scenario:  Top Probed IP Addresses Report - Time: Relative (Hours), Schedule: (once)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Probed IP Addresses Time_Relative_Hours  Schedule_once"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Probed IP Addresses],devices:[{deviceIndex:10}] |
      | Format                | Select: HTML                                                                                    |
      | Time Definitions.Date | Relative:[Hours,2]                                                                              |
      | Schedule              | Run Every:once, On Time:+6H                                                                     |

  @SID_55
  Scenario:  Top Probed IP Addresses Report - Time: Quick Range (1M)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Probed IP Addresses Time_Quick_1M"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Probed IP Addresses],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                       |
      | Time Definitions.Date | Quick:1M                                                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                    |

 # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_56
  Scenario: Attacks by Protection Policy Report - Time: Quick Range (Today), Schedule: (Weekly,MON)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Protection Policy Time_Quick_Today  Schedule_Weekly"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Protection Policy], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                             |
      | Logo                  | reportLogoPNG.png                                                                                       |
      | Time Definitions.Date | Quick:Today                                                                                             |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                                            |

  @SID_57
  Scenario: Attacks by Protection Policy Report - Time:Relative (Days), Schedule: (Daily)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Protection Policy Time_Relative_Days  Schedule_Daily"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Protection Policy],devices:[{deviceIndex:10}] |
      | Format                | Select: PDF                                                                                          |
      | Logo                  | reportLogoPNG.png                                                                                    |
      | Time Definitions.Date | Relative:[Days,2]                                                                                    |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                       |


  @SID_58
  Scenario:  Attacks by Protection Policy Report - Time: Absolute, Schedule: (Monthly,SEP)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Protection Policy Time_Absolute  Schedule_Monthly"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Protection Policy],devices:[{deviceIndex:10, deviceIndex:11}] |
      | Format                | Select: HTML                                                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[SEP]                                                                       |

  @SID_59
  Scenario:  Attacks by Protection Policy Report - Time: Relative (Months)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Protection Policy Time_Relative_Months"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Protection Policy],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                            |
      | Time Definitions.Date | Relative:[Months,2]                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |

  # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_60
  Scenario: Attack Categories by Bandwidth Report - Time: Quick Range (15m)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attack Categories by Bandwidth Time_Quick_15m"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attack Categories by Bandwidth], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                               |
      | Logo                  | reportLogoPNG.png                                                                                         |
      | Time Definitions.Date | Quick:15m                                                                                                 |

  @SID_61
  Scenario: Attack Categories by Bandwidth Report - Time:Absolute , Schedule: (Monthly,APR)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attack Categories by Bandwidth Time_Absolute  Schedule_Monthly"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attack Categories by Bandwidth],devices:[{deviceIndex:10}] |
      | Format                | Select: PDF                                                                                            |
      | Logo                  | reportLogoPNG.png                                                                                      |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |


  @SID_62
  Scenario:  Attack Categories by Bandwidth Report - Time: Relative: (Weeks), Schedule: (Weekly,SUN)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attack Categories by Bandwidth Time_Relative_Weeks  Schedule_Weekly"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attack Categories by Bandwidth],devices:[{deviceIndex:10, deviceIndex:11}] |
      | Format                | Select: HTML                                                                                                            |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                      |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                            |

  @SID_63
  Scenario:  Attack Categories by Bandwidth Report - Time: Relative (Hours), Schedule: (Daily)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attack Categories by Bandwidth Time_Relative_Hours)_  Schedule_Daily"
      | Template              | reportType:DefensePro Analytics , Widgets:[Attack Categories by Bandwidth],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                              |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                       |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                           |

  # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_64
  Scenario: Top Allowed Attackers Report - Time: Quick Range (1H), Schedule: (Daily)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Allowed Attackers Time_Quick_1H  Schedule_Daily"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Allowed Attackers], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                      |
      | Logo                  | reportLogoPNG.png                                                                                |
      | Time Definitions.Date | Quick:1H                                                                                         |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                      |

  @SID_65
  Scenario: Top Allowed Attackers Report - Time:Quick Range (This Week) , Schedule: (Weekly,THU)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Allowed Attackers Time_Quick_This Week  Schedule_Weekly"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Allowed Attackers],devices:[{deviceIndex:10}] |
      | Format                | Select: PDF                                                                                   |
      | Logo                  | reportLogoPNG.png                                                                             |
      | Time Definitions.Date | Quick:This Week                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                |

  @SID_66
  Scenario:  Top Allowed Attackers Report - Time: Absolute, Schedule: (Monthly,MAR)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Allowed Attackers Time_Absolute  Schedule_Monthly"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Allowed Attackers],devices:[{deviceIndex:10, deviceIndex:11}] |
      | Format                | Select: HTML                                                                                                   |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                |

  @SID_67
  Scenario:  Top Allowed Attackers Report - Time: Relative (Weeks), Schedule: (once)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Allowed Attackers Time_Relative_Weeks"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Allowed Attackers],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                     |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |
      | Schedule              | Run Every:once, On Time:+6H                                                                     |

  # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_68
  Scenario: Top Attacks by Duration Report - Time: Quick Range (30m), Schedule: (Monthly,JUN)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Duration Time_Quick_30m  Schedule_Monthly"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Duration], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                        |
      | Logo                  | reportLogoPNG.png                                                                                  |
      | Time Definitions.Date | Quick:30m                                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                    |

  @SID_69
  Scenario: Top Attacks by Duration Report - Time:Quick Range (3M)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Duration Time_Quick_3M"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Duration],devices:[{deviceIndex:10}] |
      | Format                | Select: PDF                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                               |
      | Time Definitions.Date | Quick:3M                                                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |

  @SID_70
  Scenario:  Top Attacks by Duration Report - Time: Absolute, Schedule: (Weekly,MUN)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Duration Time_Absolute  Schedule_Weekly"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Duration],devices:[{deviceIndex:10, deviceIndex:11}] |
      | Format                | Select: HTML                                                                                                     |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MUN]                                                                     |

  @SID_71
  Scenario:  Top Attacks by Duration Report - Time: Relative (Months), Schedule: (Daily)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Duration Time_Relative_Months  Schedule_Daily"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Duration],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                       |
      | Time Definitions.Date | Relative:[Months,2]                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                    |

  # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_72
  Scenario: Top Attacks by Signature Report - Time: Quick Range (1H)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Signature Time_Quick_1H"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Signature], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                         |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Quick:1H                                                                                            |

  @SID_73
  Scenario: Top Attacks by Signature Report - Time:Absolute, Schedule:(Monthly,JAN)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Signature Time_Absolute   Schedule_Monthly"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Signature],devices:[{deviceIndex:10}] |
      | Format                | Select: PDF                                                                                      |
      | Logo                  | reportLogoPNG.png                                                                                |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                   |

  @SID_74
  Scenario:  Top Attacks by Signature Report - Time: Relative:(Days), Schedule: (Daily)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Signature Time_Relative_Days  Schedule_Daily"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Signature],devices:[{deviceIndex:10, deviceIndex:11}] |
      | Format                | Select: HTML                                                                                                      |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                 |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                       |

  @SID_75
  Scenario:  Top Attacks by Signature Report - Time: Relative (Weeks), Schedule: (Weekly,WED)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Signature Time_Relative_Weeks  Schedule_Weekly"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Signature],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                        |
      | Time Definitions.Date | Relative:[Weeks,4]                                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                     |

  #------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_76
  Scenario: All Widgets Report - bps,Inbound,All - Time: Quick Range (1H)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "All Widgets bps_Inbound_All  Time_Quick_1H"
      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[bps,Inbound,All]},ALL], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                                          |
      | Logo                  | reportLogoPNG.png                                                                                                    |
      | Time Definitions.Date | Quick:1H                                                                                                             |

  @SID_77
  Scenario: All Widgets Report - bps,Outbound,All - Time:Absolute, Schedule:(Monthly,JAN)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "All Widgets bps_Outbound_All  Time_Absolute  Schedule_Monthly"
      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[bps,Outbound,All]},ALL], devices:[{deviceIndex:10}] |
      | Format                | Select: PDF                                                                                                         |
      | Logo                  | reportLogoPNG.png                                                                                                   |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                      |

  @SID_78
  Scenario:  All Widgets Report - bps,Inbound,1-100 - Time: Relative:(Days), Schedule: (Daily)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "All Widgets  bps_Inbound_1_100  Time_Relative_Days  Schedule_Daily"
      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[bps,Inbound,1-100]},ALL], devices:[{deviceIndex:10, deviceIndex:11}] |
      | Format                | Select: HTML                                                                                                                          |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                                     |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                           |

  @SID_79
  Scenario:  All Widgets Report - pps,Outbound,1-100 - Time: Relative (Days), Schedule: (Daily)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "All Widgets  pps_Outbound_1_100  Time_Relative_Days  Schedule_Daily"
      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[pps,Outbound,1-100]},ALL], devices:[{deviceIndex:11}] |
      | Format                | Select: HTML                                                                                                          |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                     |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                           |

  @SID_80
  Scenario:  All Widgets Report - pps,Outbound,All - Time: Relative:(Weeks), Schedule: (Weekly,WED)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "All Widgets  pps_Outbound_All  Time_Relative_Weeks  Schedule_Weekly"
      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[bps,Outbound,All]},ALL], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                                           |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                    |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                        |

  @SID_81
  Scenario:  All Widgets Report - pps,Inbound,All - Time: Relative (Weeks), Schedule: (Weekly,WED)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "All Widgets_pps_Inbound_All  Time_Relative_Weeks  Schedule_Weekly"
      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[pps,Inbound,All]},ALL], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                                          |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                   |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                       |


 # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_82
  Scenario: Logout
    Then UI logout and close browser