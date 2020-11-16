Feature: AppWall


@SID_1
Scenario: Navigate to NEW REPORTS page
Then UI Login with user "radware" and password "radware"
Then UI Navigate to "NEW REPORTS" page via homepage
Then UI Click Button "New Report Tab"

@SID_2
Scenario: create new OWASP Top 10 1
Given UI "Create" Report With Name "OWASP Top 10 1 "
| Template              | reportType:AppWall , Widgets:[OWASP Top 10] , devices:All , showTable:true|
| Logo                  | reportLogoPNG.png                                                         |
| Time Definitions.Date | Quick:15m                                                                 |
| Format                | Select: CSV                                                               |

@SID_3
Scenario: create new OWASP Top 10 2
Given UI "Create" Report With Name "OWASP Top 10 2 "
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10] , devices:All , showTable:false    |
| Logo                  | reportLogoPNG.png                                                              |
| Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                            |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
| Format                | Select: PDF                                                                    |

@SID_4
Scenario: create new OWASP Top 10 3
Given UI "Create" Report With Name "OWASP Top 10 3 "
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10] , devices:[{devicesIndex:10}] , showTable:false |
| Time Definitions.Date | Relative:Days                                                                               |
| Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                |
| Format                | Select: HTML                                                                                |

@SID_5
Scenario: create new OWASP Top 10 4
Given UI "Create" Report With Name "OWASP Top 10 4 "
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10] , devices:All , showTable:true     |
| Time Definitions.Date | Relative:Months                                                                |
| Schedule              | Run Every:Daily,On Time:+2m                                                    |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
| Format                | Select: CSV                                                                    |

@SID_6
Scenario: create new Top Attack Category1
Given UI "Create" Report With Name "Top Attack Category1 "
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Attack Category] , devices:All , showTable:true |
| Logo                  | reportLogoPNG.png                                                                 |
| Time Definitions.Date | Quick:1D                                                                          |
| Schedule              | Run Every:Weekly, On Time:+6H, At days:[FRI]                                      |
| Format                | Select: CSV                                                                       |

@SID_7
Scenario: create new Top Attack Category2
Given UI "Create" Report With Name "Top Attack Category2 "
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Attack Category] , devices:All , showTable:false |
| Logo                  | reportLogoPNG.png                                                                  |
| Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                |
| Schedule              | Run Every:once, On Time:+6H                                                        |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body     |
| Format                | Select: PDF                                                                        |

@SID_8
Scenario: create new Top Attack Category3
Given UI "Create" Report With Name "Top Attack Category3 "
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Attack Category] , devices:[{devicesIndex:10}] , showTable:false |
| Time Definitions.Date | Quick:This Week                                                                                    |
| Format                | Select: HTML                                                                                       |

@SID_9
Scenario: create new Top Attack Category4
Given UI "Create" Report With Name "Top Attack Category4 "
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Attack Category] , devices:All , showTable:true |
| Time Definitions.Date | Relative:[Days,3]                                                                 |
| Schedule              | Run Every:Daily,On Time:+2m                                                       |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body    |
| Format                | Select: CSV                                                                       |

@SID_10
Scenario: create new Top Sources1
Given UI "Create" Report With Name "Top Sources1 "
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Sources] , devices:All , showTable:true |
| Logo                  | reportLogoPNG.png                                                         |
| Time Definitions.Date | Quick:This Week                                                           |
| Schedule              | Run Every:Daily,On Time:+2m                                               |
| Format                | Select: CSV                                                               |

@SID_11
Scenario: create new Top Sources2
Given UI "Create" Report With Name "Top Sources2 "
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Sources] , devices:All , showTable:false     |
| Logo                  | reportLogoPNG.png                                                              |
| Time Definitions.Date | Relative:[Weeks,2]                                                             |
| Schedule              | Run Every:Weekly, On Time:+6H, At days:[THU]                                   |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
| Format                | Select: PDF                                                                    |

@SID_12
Scenario: create new Top Sources3
Given UI "Create" Report With Name "Top Sources3 "
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Sources] , devices:[{devicesIndex:10}] , showTable:false |
| Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                        |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                            |
| Format                | Select: HTML                                                                               |

@SID_13
Scenario: create new Top Sources4
Given UI "Create" Report With Name "Top Sources4 "
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Sources] , devices:All , showTable:true      |
| Time Definitions.Date | Relative:[Months,2]                                                            |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
| Format                | Select: CSV                                                                    |

@SID_14
Scenario: create new Geolocation1
Given UI "Create" Report With Name "Geolocation1 "
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Geolocation] , devices:All , showTable:true |
| Logo                  | reportLogoPNG.png                                                         |
| Time Definitions.Date | Quick:30m                                                                 |
| Schedule              | Run Every:Weekly, On Time:+6H, At days:[TUE]                              |
| Format                | Select: CSV                                                               |

@SID_15
Scenario: create new Geolocation2
Given UI "Create" Report With Name "Geolocation2 "
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Geolocation] , devices:All , showTable:false     |
| Logo                  | reportLogoPNG.png                                                              |
| Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                            |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
| Format                | Select: PDF                                                                    |

@SID_16
Scenario: create new Geolocation3
Given UI "Create" Report With Name "Geolocation3 "
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Geolocation] , devices:[{devicesIndex:10}] , showTable:false |
| Time Definitions.Date | Relative:[Weeks,2]                                                                         |
| Format                | Select: HTML                                                                               |

@SID_17
Scenario: create new Geolocation4
Given UI "Create" Report With Name "Geolocation4 "
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Geolocation] , devices:All , showTable:true      |
| Time Definitions.Date | Quick:Quarter                                                                  |
| Schedule              | Run Every:once, On Time:+6H                                                    |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
| Format                | Select: CSV                                                                    |

@SID_18
Scenario: create new Attacks by Action1
Given UI "Create" Report With Name "Attacks by Action1"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Attacks by Action] , devices:All , showTable:true |
| Logo                  | reportLogoPNG.png                                                               |
| Time Definitions.Date | Quick:Previous Month                                                            |
| Format                | Select: CSV                                                                     |

@SID_19
Scenario: create new Attacks by Action2
Given UI "Create" Report With Name "Attacks by Action2"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Attacks by Action] , devices:All , showTable:false |
| Logo                  | reportLogoPNG.png                                                                |
| Time Definitions.Date | Quick:This Month                                                                 |
| Schedule              | Run Every:once, On Time:+6H                                                      |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body   |
| Format                | Select: PDF                                                                      |

@SID_20
Scenario: create new Attacks by Action3
Given UI "Create" Report With Name "Attacks by Action3"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Attacks by Action] , devices:[{devicesIndex:10}] , showTable:false |
| Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                              |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                  |
| Format                | Select: HTML                                                                                     |

@SID_21
Scenario: create new Attacks by Action4
Given UI "Create" Report With Name "Attacks by Action4"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Attacks by Action] , devices:All , showTable:true |
| Time Definitions.Date | Relative:[Hours,2]                                                              |
| Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                    |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body  |
| Format                | Select: CSV                                                                     |

@SID_22
Scenario: create new Top Attacked Hosts1
Given UI "Create" Report With Name "Top Attacked Hosts1"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Attacked Hosts] , devices:All , showTable:true |
| Logo                  | reportLogoPNG.png                                                                |
| Time Definitions.Date | Quick:15m                                                                        |
| Format                | Select: CSV                                                                      |

@SID_23
Scenario: create new Top Attacked Hosts2
Given UI "Create" Report With Name "Top Attacked Hosts2"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Attacked Hosts] , devices:All , showTable:false |
| Logo                  | reportLogoPNG.png                                                                 |
| Time Definitions.Date | Quick:This Week                                                                   |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                   |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body    |
| Format                | Select: PDF                                                                       |

@SID_24
Scenario: create new Top Attacked Hosts3
Given UI "Create" Report With Name "Top Attacked Hosts3"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Attacked Hosts] , devices:[{devicesIndex:10}] , showTable:false |
| Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                               |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                   |
| Format                | Select: HTML                                                                                      |

@SID_25
Scenario: create new Top Attacked Hosts4
Given UI "Create" Report With Name "Top Attacked Hosts4"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Attacked Hosts] , devices:All , showTable:true |
| Time Definitions.Date | Relative:[Weeks,2]                                                               |
| Schedule              | Run Every:Daily,On Time:+2m                                                      |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body   |
| Format                | Select: CSV                                                                      |

@SID_26
Scenario: create new Top Attack Severity1
Given UI "Create" Report With Name "Attack Severity1"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Attack Severity] , devices:All , showTable:true |
| Logo                  | reportLogoPNG.png                                                             |
| Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                           |
| Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                  |
| Format                | Select: CSV                                                                   |

@SID_27
Scenario: create new Top Attack Severity2
Given UI "Create" Report With Name "Attack Severity2"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Attack Severity] , devices:All , showTable:false |
| Logo                  | reportLogoPNG.png                                                              |
| Time Definitions.Date | Quick:3M                                                                       |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
| Format                | Select: PDF                                                                    |

@SID_28
Scenario: create new Top Attack Severity3
Given UI "Create" Report With Name "Attack Severity3"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Attack Severity] , devices:[{devicesIndex:10}] , showTable:false |
| Time Definitions.Date | Quick:This Month                                                                               |
| Format                | Select: HTML                                                                                   |

@SID_29
Scenario: create new Top Attack Severity4
Given UI "Create" Report With Name "Attack Severity4"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Attack Severity] , devices:[{devicesIndex:10}] , showTable:false |
| Time Definitions.Date | Quick:1H                                                                                       |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                |
| Format                | Select: HTML                                                                                   |

@SID_30
Scenario: create new Attack Severity and Top Sources1
Given UI "Create" Report With Name "Attack Severity and Top Sources1"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , devices:All , showTable:true |
| Logo                  | reportLogoPNG.png                                                                         |
| Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                       |
| Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                              |
| Format                | Select: CSV                                                                               |

@SID_31
Scenario: create new Attack Severity and Top Sources2
Given UI "Create" Report With Name "Attack Severity and Top Sources2"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , devices:All , showTable:false |
| Logo                  | reportLogoPNG.png                                                                          |
| Time Definitions.Date | Quick:3M                                                                                   |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                            |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body             |
| Format                | Select: PDF                                                                                |

@SID_32
Scenario: create new Attack Severity and Top Sources3
Given UI "Create" Report With Name "Attack Severity and Top Sources3"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , devices:[{devicesIndex:10}] , showTable:false |
| Time Definitions.Date | Quick:This Month                                                                                           |
| Format                | Select: HTML                                                                                               |

@SID_33
Scenario: create new Attack Severity and Top Sources4
Given UI "Create" Report With Name "Attack Severity and Top Sources4"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , devices:[{devicesIndex:10}] , showTable:false |
| Time Definitions.Date | Quick:1H                                                                                                   |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                            |
| Format                | Select: HTML                                                                                               |

@SID_34
Scenario: create new OWASP Top 10 and Geolocation and Top Attacked Hosts1
Given UI "Create" Report With Name "OWASP Top 10 and Geolocation and Top Attacked Hosts1"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10,Geolocation,Top Attacked Hosts] , devices:All , showTable:true |
| Logo                  | reportLogoPNG.png                                                                                         |
| Time Definitions.Date | Quick:15m                                                                                                 |
| Format                | Select: CSV                                                                                               |

@SID_35
Scenario: create new OWASP Top 10 and Geolocation and Top Attacked Hosts2
Given UI "Create" Report With Name "OWASP Top 10 and Geolocation and Geolocation Top Attacked Hosts2"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10,Geolocation,Top Attacked Hosts] , devices:All , showTable:false |
| Logo                  | reportLogoPNG.png                                                                                          |
| Time Definitions.Date | Quick:This Week                                                                                            |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                            |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                             |
| Format                | Select: PDF                                                                                                |

@SID_36
Scenario: create new OWASP Top 10 and Geolocation and Top Attacked Hosts3
Given UI "Create" Report With Name "OWASP Top 10 and Geolocation and Geolocation Top Attacked Hosts3"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10,Geolocation,Top Attacked Hosts] , devices:[{devicesIndex:10}] , showTable:false |
| Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                                        |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                            |
| Format                | Select: HTML                                                                                                               |

@SID_37
Scenario: create new OWASP Top 10 and Geolocation and Top Attacked Hosts4
Given UI "Create" Report With Name "OWASP Top 10 and Geolocation and Geolocation Top Attacked Hosts4"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10,Geolocation,Top Attacked Hosts] , devices:All , showTable:true |
| Time Definitions.Date | Relative:[Weeks,2]                                                                                        |
| Schedule              | Run Every:Daily,On Time:+2m                                                                               |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                            |
| Format                | Select: CSV                                                                                               |

@SID_38
Scenario: create new OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts1
Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts1"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Geolocation,Attacks by Action,Top Attacked Hosts] , devices:All , showTable:true |
| Logo                  | reportLogoPNG.png                                                                                                                               |
| Time Definitions.Date | Quick:15m                                                                                                                                       |
| Format                | Select: CSV                                                                                                                                     |

@SID_39
Scenario: create new OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts2
Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts2"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Geolocation,Attacks by Action,Top Attacked Hosts] , devices:All , showTable:false |
| Logo                  | reportLogoPNG.png                                                                                                                                |
| Time Definitions.Date | Quick:This Week                                                                                                                                  |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                  |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                   |
| Format                | Select: PDF                                                                                                                                      |

@SID_40
Scenario: create new OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts3
Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts3"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Geolocation,Attacks by Action,Top Attacked Hosts] , devices:[{devicesIndex:10}] , showTable:false |
| Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                                                                              |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                  |
| Format                | Select: HTML                                                                                                                                                     |

@SID_41
Scenario: create new OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts4
Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Geolocation and Attacks by Action and Top Attacked Hosts4"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Geolocation,Attacks by Action,Top Attacked Hosts] , devices:All , showTable:true |
| Time Definitions.Date | Relative:[Weeks,2]                                                                                                                              |
| Schedule              | Run Every:Daily,On Time:+2m                                                                                                                     |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                  |
| Format                | Select: CSV                                                                                                                                     |

@SID_42
Scenario: create new Top Sources and Attack Severity1
Given UI "Create" Report With Name "Top Sources and Attack Severity1"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , devices:All , showTable:true |
| Logo                  | reportLogoPNG.png                                                                         |
| Time Definitions.Date | Quick:Previous Month                                                                      |
| Format                | Select: CSV                                                                               |

@SID_43
Scenario: create new Top Sources and Attack Severity2
Given UI "Create" Report With Name "Top Sources and Attack Severity2"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , devices:All , showTable:false |
| Logo                  | reportLogoPNG.png                                                                          |
| Time Definitions.Date | Quick:This Month                                                                           |
| Schedule              | Run Every:once, On Time:+6H                                                                |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body             |
| Format                | Select: PDF                                                                                |

@SID_44
Scenario: create new Top Sources and Attack Severity3
Given UI "Create" Report With Name "Top Sources and Attack Severity3"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , devices:[{devicesIndex:10}] , showTable:false |
| Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                        |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                            |
| Format                | Select: HTML                                                                                               |

@SID_45
Scenario: create new Top Sources and Attack Severity4
Given UI "Create" Report With Name "Top Sources and Attack Severity4"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Sources,Attack Severity] , devices:All , showTable:true |
| Time Definitions.Date | Relative:[Hours,2]                                                                        |
| Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                              |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body            |
| Format                | Select: CSV                                                                               |

@SID_46
Scenario: create new Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity1
Given UI "Create" Report With Name "Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity1"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , devices:All , showTable:true |
| Logo                  | reportLogoPNG.png                                                                                                                          |
| Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                                                        |
| Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                                                               |
| Format                | Select: CSV                                                                                                                                |

@SID_47
Scenario: create new Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity2
Given UI "Create" Report With Name "Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity2"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , devices:All , showTable:false |
| Logo                  | reportLogoPNG.png                                                                                                                           |
| Time Definitions.Date | Quick:3M                                                                                                                                    |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                             |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                              |
| Format                | Select: PDF                                                                                                                                 |

@SID_48
Scenario: create new Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity3
Given UI "Create" Report With Name "Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity3"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , devices:[{devicesIndex:10}] , showTable:false |
| Time Definitions.Date | Quick:This Month                                                                                                                                            |
| Format                | Select: HTML                                                                                                                                                |

@SID_49
Scenario: create new Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity4
Given UI "Create" Report With Name "Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity4"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , devices:[{devicesIndex:10}] , showTable:false |
| Time Definitions.Date | Quick:1H                                                                                                                                                    |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                             |
| Format                | Select: HTML                                                                                                                                                |

@SID_50
Scenario: create new OWASP Top 10 and Top Attack Category and Top Attacked Hosts1
Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Top Attacked Hosts1"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Attacked Hosts] , devices:All , showTable:true |
| Logo                  | reportLogoPNG.png                                                                                                 |
| Time Definitions.Date | Quick:15m                                                                                                         |
| Format                | Select: CSV                                                                                                       |

@SID_51
Scenario: create new OWASP Top 10 and Top Attack Category and Top Attacked Hosts2
Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Top Attacked Hosts2"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Attacked Hosts] , devices:All , showTable:false |
| Logo                  | reportLogoPNG.png                                                                                                  |
| Time Definitions.Date | Quick:This Week                                                                                                    |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                    |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                     |
| Format                | Select: PDF                                                                                                        |

@SID_52
Scenario: create new OWASP Top 10 and Top Attack Category and Top Attacked Hosts3
Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Top Attacked Hosts3"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Attacked Hosts] , devices:[{devicesIndex:10}] , showTable:false |
| Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                                                |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                    |
| Format                | Select: HTML                                                                                                                       |

@SID_53
Scenario: create new OWASP Top 10 and Top Attack Category and Top Attacked Hosts4
Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Top Attacked Hosts4"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Attacked Hosts] , devices:All , showTable:true |
| Time Definitions.Date | Relative:[Weeks,2]                                                                                                |
| Schedule              | Run Every:Daily,On Time:+2m                                                                                       |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                    |
| Format                | Select: CSV                                                                                                       |

@SID_54
Scenario: create new Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity1
Given UI "Create" Report With Name "Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity1"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , devices:All , showTable:true |
| Logo                  | reportLogoPNG.png                                                                                                              |
| Time Definitions.Date | Quick:15m                                                                                                                      |
| Format                | Select: CSV                                                                                                                    |

@SID_55
Scenario: create new Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity2
Given UI "Create" Report With Name "Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity2"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , devices:All , showTable:false |
| Logo                  | reportLogoPNG.png                                                                                                               |
| Time Definitions.Date | Quick:This Week                                                                                                                 |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                 |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                  |
| Format                | Select: PDF                                                                                                                     |

@SID_56
Scenario: create new Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity3
Given UI "Create" Report With Name "Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity3"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , devices:[{devicesIndex:10}] , showTable:false |
| Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                                                             |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                 |
| Format                | Select: HTML                                                                                                                                    |

@SID_57
Scenario: create new Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity4
Given UI "Create" Report With Name "Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity4"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , devices:All , showTable:true |
| Time Definitions.Date | Relative:[Weeks,2]                                                                                                             |
| Schedule              | Run Every:Daily,On Time:+2m                                                                                                    |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                 |
| Format                | Select: CSV                                                                                                                    |

@SID_58
Scenario: create new OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity1
Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity1"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , devices:All , showTable:true |
| Logo                  | reportLogoPNG.png                                                                                                                                                           |
| Time Definitions.Date | Quick:Previous Month                                                                                                                                                        |
| Format                | Select: CSV                                                                                                                                                                 |

@SID_59
Scenario: create new OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity2
Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity2"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , devices:All , showTable:false |
| Logo                  | reportLogoPNG.png                                                                                                                                                            |
| Time Definitions.Date | Quick:This Month                                                                                                                                                             |
| Schedule              | Run Every:once, On Time:+6H                                                                                                                                                  |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                               |
| Format                | Select: PDF                                                                                                                                                                  |

@SID_60
Scenario: create new OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity3
Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity3"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , devices:[{devicesIndex:10}]  , showTable:false |
| Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                                                                                                           |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                               |
| Format                | Select: HTML                                                                                                                                                                                  |

@SID_61
Scenario: create new OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity4
Given UI "Create" Report With Name "OWASP Top 10 and Top Attack Category and Top Sources and Geolocation and Attacks by Action and Top Attacked Hosts and Attack Severity4"
Then UI Click Button "New Report Tab"
| Template              | reportType:AppWall , Widgets:[OWASP Top 10,Top Attack Category,Top Sources,Geolocation,Attacks by Action,Top Attacked Hosts,Attack Severity] , devices:All , showTable:true |
| Time Definitions.Date | Relative:[Hours,2]                                                                                                                                                          |
| Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                                                                                                                |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                              |
| Format                | Select: CSV                                                                                                                                                                 |




























































































