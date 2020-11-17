@TC_DefenseFlow_Analytics
Feature:DefenseFlow Analytics
|


  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "NEW REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

    # ------------------------------------------------------------------------------------------------------------------------------------------------------------
  @SID_2
  Scenario: Top Attacks by Duration Report - Time: Quick Range (15m)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Duration_Time_Quick_15m"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attacks by Duration], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                         |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Quick:15m                                                                                           |


  @SID_3
  Scenario: Top Attacks by Duration Report - Time: Absolute, Schedule: (Monthly,Oct)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Duration_Time_Absolute  Schedule_Monthly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attacks by Duration],devices:[{devicesIndex:10}] |
      | Format                | Select: PDF                                                                                      |
      | Logo                  | reportLogoPNG.png                                                                                |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                   |


  @SID_4
  Scenario:  Top Attacks by Duration Report - Time: Relative (Days), Schedule:(Weekly,SUN)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Duration Time_Relative_Days  Schedule_Weekly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attacks by Duration],devices:[{devicesIndex:11}] |
      | Format                | Select: HTML                                                                                     |
      | Time Definitions.Date | Relative:[Days,2]                                                                                |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                     |


  @SID_5
  Scenario:  Top Attacks by Duration Report  - Time: Relative: (Months)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Duration  Time_Relative_Months)"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attacks by Duration],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                        |
      | Time Definitions.Date | Relative:[Months,2]                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                     |

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_6
  Scenario: Top Attacks by Count Report - Time: Quick Range (1D), Schedule:(Weekly,FRI)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Count_Time_Quick_1D  Schedule_Weekly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attacks by Count], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                      |
      | Logo                  | reportLogoPNG.png                                                                                |
      | Time Definitions.Date | Quick:1D                                                                                         |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[FRI]                                                     |


  @SID_7
  Scenario: Top Attacks by Count Report - Time: Absolute, Schedule: (Once)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Count_Time_Absolute  Schedule_Once"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attacks by Count],devices:[{devicesIndex:10}] |
      | Format                | Select: PDF                                                                                   |
      | Logo                  | reportLogoPNG.png                                                                             |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                           |
      | Schedule              | Run Every:Once                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                |


  @SID_8
  Scenario:  Top Attacks by Count Report - Time: Quick Range (This Week)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Count  Time_Quick_This Week"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attacks by Count],devices:[{devicesIndex:11}] |
      | Format                | Select: HTML                                                                                  |
      | Time Definitions.Date | Quick:This Week                                                                               |


  @SID_9
  Scenario:  Top Attacks by Count Report  - Time: Relative: (Days), Schedule:(Daily)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Count  Time_Relative_Days  Schedule_Daily)"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attacks by Count],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                     |
      | Time Definitions.Date | Relative:[Days,3]                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_10
  Scenario: Top Attacks by Rate Report - Time: Quick Range (This Week), Schedule:(Daily)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Rate_Time_Quick_This Week  Schedule_Daily"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attacks by Rate], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                               |
      | Time Definitions.Date | Quick:This Week                                                                                 |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                            |


  @SID_11
  Scenario: Top Attacks by Rate Report - Time:  - Time: Relative: (Weeks), Schedule: (Weekly,THU)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Rate Time_Relative_Weeks  Schedule_Weekly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attacks by Rate],devices:[{devicesIndex:10}] |
      | Format                | Select: PDF                                                                                  |
      | Logo                  | reportLogoPNG.png                                                                            |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                           |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[THU]                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body               |


  @SID_12
  Scenario:  Top Attacks by Rate Report - Time: Absolute, Schedule:(Monthly,MAY)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Rate Time_Absolute  Schedule_Monthly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attacks by Rate],devices:[{devicesIndex:11}] |
      | Format                | Select: HTML                                                                                 |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                              |


  @SID_13
  Scenario:  Top Attacks by Rate Report  - Time: Relative: (Months)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Rate  Time_Relative_Months"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attacks by Rate],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                    |
      | Time Definitions.Date | Relative:[Months,4]                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                 |

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_14
  Scenario: Top Attacks by Protocol Report - Time: Quick Range (30m), Schedule:(Weekly,TUE)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Protocol  Time_Quick_30m  Schedule_Weekly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attacks by Protocol], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                         |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Quick:30m                                                                                           |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[TUE]                                                        |


  @SID_15
  Scenario: Top Attacks by Protocol Report - Time: Absolute,  Schedule: (Months,APR)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Protocol  Time_Absolute  Schedule_Months"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attacks by Protocol],devices:[{devicesIndex:10}] |
      | Format                | Select: PDF                                                                                      |
      | Logo                  | reportLogoPNG.png                                                                                |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                   |


  @SID_16
  Scenario:  Top Attacks by Protocol Report - Time: Relative (Weeks)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Protocol  Time_Relative_Weeks"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attacks by Protocol],devices:[{devicesIndex:11}] |
      | Format                | Select: HTML                                                                                     |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                               |


  @SID_17
  Scenario:  Top Attacks by Protocol Report  -Time: Quick Range (Quarter), Schedule:(once)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Protocol  Time_Quick_Quarter  Schedule_once"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attacks by Protocol],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                        |
      | Time Definitions.Date | Quick:Quarter                                                                                      |
      | Schedule              | Run Every:Once                                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                     |
# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_18
  Scenario: Top Attack Destination Report - Time: Quick Range (Previous Month)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Destination  Time_Quick_Previous_Month"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attack Destination], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                        |
      | Logo                  | reportLogoPNG.png                                                                                  |
      | Time Definitions.Date | Quick:Previous Month                                                                               |


  @SID_19
  Scenario: Top Attack Destination Report - Time: Quick Range (This Month), Schedule: (Once)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Destination  Time_Quick_This Month  Schedule_Once"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attack Destination],devices:[{devicesIndex:10}] |
      | Format                | Select: PDF                                                                                     |
      | Logo                  | reportLogoPNG.png                                                                               |
      | Time Definitions.Date | Quick:This Month                                                                                |
      | Schedule              | Run Every:Once                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |


  @SID_20
  Scenario:  Top Attack Destination Report - Time: Absolute, Schedule:(Monthly,MAR)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Destination  Time_Absolute  Schedule_Monthly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attack Destination],devices:[{devicesIndex:11}] |
      | Format                | Select: HTML                                                                                    |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                 |

  @SID_21
  Scenario:  Top Attack Destination Report  -Time: Relative:(Hours), Schedule:(Weekly,WED)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Destination  Time_Relative_Hours  Schedule_Weekly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attack Destination],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                       |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                    |
# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_22
  Scenario: Top Attack Sources Report - Time: Quick Range (15m)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Sources  Time_Quick_15m"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attack Sources], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                    |
      | Logo                  | reportLogoPNG.png                                                                              |
      | Time Definitions.Date | Quick:15m                                                                                      |


  @SID_23
  Scenario: Top Attack Sources Report - Time: Quick Range (This Week), Schedule:(Monthly,AUG)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Sources  Time_Quick_This Week  Schedule_Monthly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attack Sources],devices:[{devicesIndex:10}] |
      | Format                | Select: PDF                                                                                 |
      | Logo                  | reportLogoPNG.png                                                                           |
      | Time Definitions.Date | Quick:This Week                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body              |


  @SID_24
  Scenario:  Top Attack Sources Report - Time: Absolute, Schedule:(Monthly,MAR)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Sources  Time_Absolute  Schedule_Monthly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attack Sources],devices:[{devicesIndex:11}] |
      | Format                | Select: HTML                                                                                |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                             |

  @SID_25
  Scenario:  Top Attack Sources Report  -Time: Relative:(Weeks), Schedule:(Daily)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attack Sources  Time_Relative_Weeks  Schedule_Daily"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Top Attack Sources],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                   |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                |

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_26
  Scenario: Traffic Bandwidth Report - Time: Absolute, Schedule:(Weekly,SUN)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Bandwidth  Time_Absolute  Schedule_Weekly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[{Traffic Bandwidth:[30]},Traffic Bandwidth], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                                            |
      | Logo                  | reportLogoPNG.png                                                                                                      |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                                    |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                                           |


  @SID_27
  Scenario: Traffic Bandwidth Report - Time: Quick Range (3M), Schedule:(Monthly,DEC)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Bandwidth  Time_Quick_3M  Schedule_Monthly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[{Traffic Bandwidth:[40]},Traffic Bandwidth],devices:[{devicesIndex:10}] |
      | Format                | Select: PDF                                                                                                         |
      | Logo                  | reportLogoPNG.png                                                                                                   |
      | Time Definitions.Date | Quick:3M                                                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                      |


  @SID_28
  Scenario:  Traffic Bandwidth Report - Time: -Time: Quick Range (This Month)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Bandwidth  Time_Time_Quick_This Month"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[{Traffic Bandwidth:[All]},Traffic Bandwidth],devices:[{devicesIndex:11},{devicesIndex:10}] |
      | Format                | Select: HTML                                                                                                                           |
      | Time Definitions.Date | Quick:This Month                                                                                                                       |

  @SID_29
  Scenario:  Traffic Bandwidth Report  -Time: Quick Range (1H), Schedule:(Monthly,MAR)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Bandwidth  Time_Quick_1H  Schedule_Monthly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[{Traffic Bandwidth:[All]},Traffic Bandwidth],devices:[All] |
      | Format                | Select: HTML                                                                                           |
      | Time Definitions.Date | Quick:1H                                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                        |

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_30
  Scenario: Traffic Rate Report - Time: Quick Range (15m)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Rate  Time_Quick_15m"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Traffic Rate], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                              |
      | Logo                  | reportLogoPNG.png                                                                        |
      | Time Definitions.Date | Quick:15m                                                                                |


  @SID_31
  Scenario: Traffic Rate Report - Time: Quick Range Absolute, Schedule:(Monthly,OCT)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Rate  Time_Quick_Absolute  Schedule_Monthly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Traffic Rate],devices:[{devicesIndex:11}] |
      | Format                | Select: PDF                                                                           |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body        |


  @SID_32
  Scenario:  Traffic Rate Report - Time: Relative:(Days), Schedule:(Weekly,SUN)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Rate  Time_Relative_Days  Schedule_Weekly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Traffic Rate],devices:[{devicesIndex:11},{devicesIndex:10}] |
      | Format                | Select: HTML                                                                                            |
      | Time Definitions.Date | Relative:[Days,3]                                                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                            |

  @SID_33
  Scenario:  Traffic Rate Report  -Time: Relative:(Months)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Traffic Rate  Time_Relative_Months"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[Traffic Rate],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                             |
      | Time Definitions.Date | Relative:[Months,4]                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body          |


# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_34
  Scenario: DDoS Peak Attack per Period Report - Time: Quick Range (1D), Schedule:(Weekly,FRI)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DDoS Peak Attack per Period  Time_Quick_1D  Schedule_Weekly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[DDoS Peak Attack per Period], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                             |
      | Logo                  | reportLogoPNG.png                                                                                       |
      | Time Definitions.Date | Quick:1D                                                                                                |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[FRI]                                                            |


  @SID_35
  Scenario: DDoS Peak Attack per Period Report - Time: Quick Range Absolute, Schedule:(once)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DDoS Peak Attack per Period  Time_Quick_Absolute  Schedule_once"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[DDoS Peak Attack per Period],devices:[{devicesIndex:11}] |
      | Format                | Select: PDF                                                                                          |
      | Logo                  | reportLogoPNG.png                                                                                    |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                  |
      | Schedule              | Run Every:Once                                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                       |


  @SID_36
  Scenario:  DDoS Peak Attack per Period Report - Time: Quick Range (This Week)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DDoS Peak Attack per Period  Time_Quick_This Week"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[DDoS Peak Attack per Period],devices:[{devicesIndex:10}] |
      | Format                | Select: HTML                                                                                         |
      | Time Definitions.Date | Quick:This Week                                                                                      |


  @SID_37
  Scenario:  DDoS Peak Attack per Period Report  -Time: Relative:(Days)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DDoS Peak Attack per Period  Time_Relative_Days"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[DDoS Peak Attack per Period],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                            |
      | Time Definitions.Date | Relative:[Days,3]                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |


# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_38
  Scenario: DDoS Attack Activations per Period Report - Time: Quick Range (This Week), Schedule:(Daily)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DDoS Attack Activations per Period  Time_Quick_This Week  Schedule_Daily"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[DDoS Attack Activations per Period], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                                    |
      | Logo                  | reportLogoPNG.png                                                                                              |
      | Time Definitions.Date | Quick:This Week                                                                                                |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                           |


  @SID_39
  Scenario: DDoS Attack Activations per Period Report - Time: Relative: (Weeks), Schedule:(Weekly,THU)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DDoS Attack Activations per Period  Time_Relative_Weeks  Schedule_Weekly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[DDoS Attack Activations per Period],devices:[{devicesIndex:10},{devicesIndex:11}] |
      | Format                | Select: PDF                                                                                                                   |
      | Logo                  | reportLogoPNG.png                                                                                                             |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[THU]                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                |


  @SID_40
  Scenario:  DDoS Attack Activations per Period Report - Time: Absolute, Schedule:(Monthly,MAY)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DDoS Attack Activations per Period  Time_Quick_This Week  Schedule_Monthly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[DDoS Attack Activations per Period],devices:[{devicesIndex:10}] |
      | Format                | Select: HTML                                                                                                |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                             |


  @SID_41
  Scenario:  DDoS Attack Activations per Period Report  -Time: Relative:(Months)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DDoS Attack Activations per Period  Time_Relative_Months"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[DDoS Attack Activations per Period],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                                   |
      | Time Definitions.Date | Relative:[Months,3]                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                |


# ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_42
  Scenario:  Top 10 Activations by Duration Report - Time: Quick Range (30m), Schedule:(Weekly,TUE)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Top 10 Activations by Duration  Time_Quick_30m  Schedule_Weekly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[ Top 10 Activations by Duration], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                                 |
      | Logo                  | reportLogoPNG.png                                                                                           |
      | Time Definitions.Date | Quick:30m                                                                                                   |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[TUE]                                                                |


  @SID_43
  Scenario:  Top 10 Activations by Duration Report - Time: Absolute, Schedule:(Monthly,APR)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Top 10 Activations by Duration  Time_Relative_Weeks  Schedule_Monthly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[ Top 10 Activations by Duration],devices:[{devicesIndex:10},{devicesIndex:11}] |
      | Format                | Select: PDF                                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                             |


  @SID_44
  Scenario:   Top 10 Activations by Duration Report  - Time: Relative:(Weeks)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Top 10 Activations by Duration  Time_Relative_Weeks"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[ Top 10 Activations by Duration],devices:[{devicesIndex:10}] |
      | Format                | Select: HTML                                                                                             |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                       |


  @SID_45
  Scenario:   Top 10 Activations by Duration Report  -Time: Quick Range (Quarter), Schedule:(once)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Top 10 Activations by Duration  Time_Quick_Quarter  Schedule_once"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[ Top 10 Activations by Duration],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                                |
      | Time Definitions.Date | Quick:Quarter                                                                                              |
      | Schedule              | Run Every:Once                                                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                             |

    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_46
  Scenario:  Top 10 Activations by Attack Rate (Gbps) Report - Time: Quick Range (Previous Month)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Top 10 Activations by Attack Rate (Gbps)  Time_Quick_Previous Month"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[ Top 10 Activations by Attack Rate (Gbps)], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                                           |
      | Logo                  | reportLogoPNG.png                                                                                                     |
      | Time Definitions.Date | Quick:Previous Month                                                                                                  |


  @SID_47
  Scenario:  Top 10 Activations by Attack Rate (Gbps) Report - Time: Quick Range (This Month), Schedule:(once)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Top 10 Activations by Attack Rate (Gbps)  Time_Quick_This Month  Schedule_once"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[ Top 10 Activations by Attack Rate (Gbps)],devices:[{devicesIndex:10},{devicesIndex:11}] |
      | Format                | Select: PDF                                                                                                                          |
      | Logo                  | reportLogoPNG.png                                                                                                                    |
      | Time Definitions.Date | Quick:This Month                                                                                                                     |
      | Schedule              | Run Every:Once                                                                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                       |


  @SID_48
  Scenario:   Top 10 Activations by Attack Rate (Gbps) Report  - Time: Absolute, Schedule:(Monthly,MAR)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Top 10 Activations by Attack Rate (Gbps)  Time_Relative_Weeks  Schedule_Monthly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[ Top 10 Activations by Attack Rate (Gbps)],devices:[{devicesIndex:10}] |
      | Format                | Select: HTML                                                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                    |


  @SID_49
  Scenario:   Top 10 Activations by Attack Rate (Gbps) Report  -Time: Relative:(Hours), Schedule:(Weekly,WED)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Top 10 Activations by Attack Rate (Gbps)  Time_Relative_Hours  Schedule_Weekly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[ Top 10 Activations by Attack Rate (Gbps)],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                                          |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                   |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[WED]                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                       |


    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_50
  Scenario:  Top 10 Activations by Attack Rate (Mpps) Report - Time: Quick Range (15m)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Top 10 Activations by Attack Rate (Mpps)  Time_Quick_15m"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[ Top 10 Activations by Attack Rate (Mpps)], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                                           |
      | Logo                  | reportLogoPNG.png                                                                                                     |
      | Time Definitions.Date | Quick:15m                                                                                                             |


  @SID_51
  Scenario:  Top 10 Activations by Attack Rate (Mpps) Report - Time: Quick Range (This Week), Schedule:(Monthly,AUG)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Top 10 Activations by Attack Rate (Mpps)  Time_Quick_This Week  Schedule_Monthly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[ Top 10 Activations by Attack Rate (Mpps)],devices:[{devicesIndex:10}] |
      | Format                | Select: PDF                                                                                                        |
      | Logo                  | reportLogoPNG.png                                                                                                  |
      | Time Definitions.Date | Quick:This Week                                                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                     |


  @SID_52
  Scenario:   Top 10 Activations by Attack Rate (Mpps) Report  - Time: Absolute, Schedule:(Monthly,MAR)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Top 10 Activations by Attack Rate (Mpps)  Time_Relative_Weeks  Schedule_Monthly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[ Top 10 Activations by Attack Rate (Mpps)],devices:[{devicesIndex:10},{devicesIndex:11}] |
      | Format                | Select: HTML                                                                                                                         |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                      |


  @SID_53
  Scenario:   Top 10 Activations by Attack Rate (Mpps) Report  -Time: Relative:(Weeks), Schedule:(Daily)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Top 10 Activations by Attack Rate (Mpps)  Time_Relative_Weeks  Schedule_Daily"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[ Top 10 Activations by Attack Rate (Mpps)],devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                                          |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                   |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                       |


    # ------------------------------------------------------------------------------------------------------------------------------------------------------------
   # {1}-Top Attacks by Duration, {2}-Top Attacks by Count, {3}-Top Attacks by Rate, {4}-Top Attacks by Protocol, {5}-Top Attack Destination, {6}-Top Attack Sources, {7}-Traffic Bandwidth,
   # {8}-Traffic Rate, {9}-DDoS Peak Attack per Period, {10}-DDoS Attack Activations per Period, {11}- Top 10 Activations by Duration, {12}-Top 10 Activations by Attack Rate (Gbps)
   # {13}-Top 10 Activations by Attack Rate (Mpps)
    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_54
  Scenario:  Widgets 3_7_8_11_13 Report - Time: Absolute, Schedule:(Weekly,SUN)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Widgets 3_7_8_11_13  Time_Quick_Absolute  Schedule_Weekly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[{Traffic Bandwidth:[60]}, Top Attacks by Rate, Traffic Bandwidth, Traffic Rate, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Mpps)], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                           |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                     |
      | Schedule              | Run Every:Weekly, On Time:+6H, At days:[SUN]                                                                                                                                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                                                                                                                                                   |


  @SID_55
  Scenario:  Widgets 3_7_8_11_13 Report - Time: Quick Range (3M), Schedule:(Monthly,DEC)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Widgets 3_7_8_11_13  Time_Quick_3M  Schedule_Monthly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[{Traffic Bandwidth:[70]}, Top Attacks by Rate, Traffic Bandwidth, Traffic Rate, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Mpps)], devices:[All] |
      | Format                | Select: PDF                                                                                                                                                                                                           |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                     |
      | Time Definitions.Date | Quick:3M                                                                                                                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                                                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                        |


  @SID_56
  Scenario:   Widgets 3_7_8_11_13 Report  - Time:Quick Range (This Month)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Widgets 3_7_8_11_13  Time_Quick_This Month"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[{Traffic Bandwidth:[30]}, Top Attacks by Rate, Traffic Bandwidth, Traffic Rate, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Mpps)], devices:[{devicesIndex:10},{devicesIndex:11}] |
      | Format                | Select: HTML                                                                                                                                                                                                                                          |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                                      |


  @SID_57
  Scenario:   Widgets 3_7_8_11_13 Report  -Time: Quick Range (1H), Schedule:(Monthly,MAR)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Widgets 3_7_8_11_13  Time_Quick_1H  Schedule_Monthly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[{Traffic Bandwidth:[90]}, Top Attacks by Rate, Traffic Bandwidth, Traffic Rate, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Mpps)], devices:[{devicesIndex:10}], showTable:true |
      | Format                | Select: HTML                                                                                                                                                                                                                                        |
      | Time Definitions.Date | Quick:1H                                                                                                                                                                                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                     |


    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_58
  Scenario:  Widgets 1_4_6_7_8_9_11_12_13 Report - Time: Quick Range (15m)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Widgets 1_4_6_7_8_9_11_12_13  Time_Quick_15m"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[{Traffic Bandwidth:[all]}, Top Attacks by Duration, Top Attacks by Protocol, Top Attack Sources, Traffic Bandwidth, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                           |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                     |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                                                                                                                                                   |


  @SID_59
  Scenario:  Widgets 1_4_6_7_8_9_11_12_13 Report - Time: Quick Range (3M), Schedule:(Monthly,AUG)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Widgets 1_4_6_7_8_9_11_12_13  Time_Quick_This Week  Schedule_Monthly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[{Traffic Bandwidth:[all]}, Top Attacks by Duration, Top Attacks by Protocol, Top Attack Sources, Traffic Bandwidth, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)], devices:[{devicesIndex:10}] |
      | Format                | Select: PDF                                                                                                                                                                                                           |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                     |
      | Time Definitions.Date | Quick:This Week                                                                                                                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                        |


  @SID_60
  Scenario:   Widgets 1_4_6_7_8_9_11_12_13 Report  - Time:Absolute, Schedule:(Monthly,MAR)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Widgets 1_4_6_7_8_9_11_12_13  Time_Quick_Absolute  Schedule_Monthly"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[{Traffic Bandwidth:[all]}, Top Attacks by Duration, Top Attacks by Protocol, Top Attack Sources, Traffic Bandwidth, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)], devices:[{devicesIndex:10},{devicesIndex:11}] |
      | Format                | Select: HTML                                                                                                                                                                                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                     |


  @SID_61
  Scenario:   Widgets 1_4_6_7_8_9_11_12_13 Report  -Time:Relative:(Weeks), Schedule:(Daily)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Widgets 1_4_6_7_8_9_11_12_13  Time_Relative_Weeks  Schedule_Daily"
      | Template              | reportType:DefenseFlow_Analytics , Widgets:[{Traffic Bandwidth:[all]}, Top Attacks by Duration, Top Attacks by Protocol, Top Attack Sources, Traffic Bandwidth, Traffic Rate, DDoS Peak Attack per Period, Top 10 Activations by Duration, Top 10 Activations by Attack Rate (Gbps), Top 10 Activations by Attack Rate (Mpps)], devices:[all], showTable:true |
      | Format                | Select: CSV                                                                                                                                                                                                                                        |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                       |
