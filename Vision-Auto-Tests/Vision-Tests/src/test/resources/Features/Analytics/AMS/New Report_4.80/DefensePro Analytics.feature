@TCtest11

Feature: DefensePro Analytics
#
#  @SID_1
#  Scenario: Navigate to NEW REPORTS page
#    Then UI Login with user "radware" and password "radware"
#    Then UI Navigate to "NEW REPORTS" page via homepage
#    Then UI Click Button "New Report Tab"
#
#  @SID_2
#  Scenario: create new
#    Given UI "Create" Report With Name "Traffic Report"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Traffic Bandwidth],devices:[All] |
##|Template-1            | reportType:Appwall , Widgets:[Traffic Bandwidth],devices:[All]         |
#      | Format                | Select: PDF                                                                 |
#      | Logo                  | reportLogoPNG.png                                                           |
##| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                                                                                |
#      | Time Definitions.Date | Quick:Today                                                                 |
#
#


 #
#
#Scenario: Create Report of Traffic Global Kbps Inbound
#Given UI "Create" Report With Name "Traffic Report"
#| Template-1            | reportType:DefensePro Analytics , Widgets:[Concurrent Connections],devices:[{devicesIndex:10,devicePorts:[1],devicePolicies:[BDOS,APOL]},{deviceIndex:10}]                             |
#| Template-2            | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[bps/pps,Inbound/Outbound,All/1-100]},ALL/specific widgets],devices:[{devicesIndex:11,devicePorts:[1,2],devicePolicies:[BDOS,APOL]},{deviceIndex:10}] |
#| Format                | Select: CSV                                                                                                                                                                            |
#|Template-3             |reportType:DefensePro Analytics , Widgets:[BDoS-TCP SYN,Concurrent Connections],devices:[{devicesIndex:11,devicePorts:[1,2],devicePolicies:[BDOS,APOL]},{deviceIndex:10}]|
#| Logo                  | reportLogoPNG.png                                                                                                                                                                      |
#| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN,SEP,DEC]                                                                                                                                |
#| Time Definitions.Date | Quick:This Month                                                                                                                                                                       |


  #@SID_2
#Scenario: create new
#  Given UI "Create" Report With Name "Traffic Report"
#  | Template              | reportType:DefensePro Analytics , Widgets:[Traffic Bandwidth],devices:[All]  |
#  |Template-1            | reportType:Appwall , Widgets:[Traffic Bandwidth],devices:[All]         |
#  | Format                | Select: PDF                            |
#  | Logo                  | reportLogoPNG.png                                                                                                                                                                      |
#  | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                                                                                |
#  | Time Definitions.Date | Quick:Today                                                                                                                                        |
#


#
  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "NEW REPORTS" page via homepage
    Then UI Click Button "New Report Tab"


 # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_41
  Scenario: Top Attack Sources Report - Time: Quick Range (30m)
    Given UI "Create" Report With Name "Top Attack Sources_Time_Quick_30m"
      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attack Sources], devices:[All], showTable:true |
      | Format                | Select: CSV                                                                    |
      | Logo                  | reportLogoPNG.png                                                              |
      | Time Definitions.Date | Quick:30m                                                                      |



#  @SID_42
#  Scenario: Top Attack Sources Report - Time: Absolute
#    Given UI "Create" Report With Name "Top Attack Sources_Time_Absolute"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attack Sources],devices:[{devicesIndex:10}] |
#      | Format                | Select: PDF                                                                                |
#      | Logo                  | reportLogoPNG.png                                                                          |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                        |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body             |
#
#  @SID_43
#  Scenario:  Top Attack Sources Report - Time: Relative (Weeks)
#    Given UI "Create" Report With Name "Top Attack Sources Time_Relative "
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attack Sources],devices:[{devicesIndex:10}] |
#      | Format                | Select: HTML                                                                               |
#      | Time Definitions.Date | Relative:[Weeks,2]                                                                         |
#
#  @SID_44
#  Scenario:  Top Attack Sources Report - Schedule: (Weekly,MON)
#    Given UI "Create" Report With Name "Top Attack Sources  Schedule_Weekly)"
#      | Template | reportType:DefensePro Analytics , Widgets:[Top Attack Sources],devices:[All], showTable:true |
#      | Format   | Select: CSV                                                                                |
#      | Schedule | Run Every:Weekly, On Time:+6H, At Days:[MON]                                               |
#      | Share    | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body             |
#
## ------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#  @SID_45
#  Scenario: Top Scanners Report - Time:Quick Range (3M), Schedule: (Daily)
#    Given UI "Create" Report With Name "Top Scanners Time_Quick_3M  Schedule_Daily"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Scanners], devices:[All], showTable:true |
#      | Format                | Select: CSV                                                                           |
#      | Logo                  | reportLogoPNG.png                                                                     |
#      | Time Definitions.Date | Quick:3M                                                                              |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                           |
#
#  @SID_46
#  Scenario: Top Scanners Report - Time: Absolute, Schedule: (Weekly,Fri)
#    Given UI "Create" Report With Name "Top Scanners Time_Absolute"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Scanners],devices:[{devicesIndex:10}] |
#      | Format                | Select: PDF                                                                          |
#      | Logo                  | reportLogoPNG.png                                                                    |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                  |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                         |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body       |
#
#  @SID_47
#  Scenario:  Top Scanners Report - Time: Relative (Months)
#    Given UI "Create" Report With Name "Top Scanners Time_Relative "
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Scanners],devices:[{devicesIndex:10, devicesIndex:11}] |
#      | Format                | Select: HTML                                                                                          |
#      | Time Definitions.Date | Relative:[Months,4]                                                                                   |
#
#  @SID_48
#  Scenario:  Top Scanners Report - Time:Quick Range (Quarter), Schedule: (Monthly,OCT)
#    Given UI "Create" Report With Name "Top Scanners Time_Quarter  Schedule_Monthly"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Scanners],devices:[All], showTable:true |
#      | Format                | Select: CSV                                                                          |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                      |
#      | Time Definitions.Date | Quick:Quarter                                                                        |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body       |
#
## ------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#  @SID_49
#  Scenario: Top Probed IP Addresses Report - Time:Quick Range (This Week), Schedule:(Daily)
#    Given UI "Create" Report With Name "Top Probed IP Addresses Time_Quick_30m  Schedule_Daily"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Probed IP Addresses], devices:[All], showTable:true |
#      | Format                | Select: CSV                                                                                      |
#      | Logo                  | reportLogoPNG.png                                                                                |
#      | Time Definitions.Date | Quick:This Week                                                                                  |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                      |
#
#  @SID_50
#  Scenario: Top Probed IP Addresses Report - Time: Absolute, Schedule: (Weekly,Sun)
#    Given UI "Create" Report With Name "Top Probed IP Addresses Time_Absolute  Schedule_Weekly"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Probed IP Addresses],devices:[{devicesIndex:10}] |
#      | Format                | Select: PDF                                                                                     |
#      | Logo                  | reportLogoPNG.png                                                                               |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                             |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                    |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |
#
#  @SID_51
#  Scenario:  Top Probed IP Addresses Report - Time: Relative (Hours), Schedule: (once)
#    Given UI "Create" Report With Name "Top Probed IP Addresses Time_Relative_Hours"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Probed IP Addresses],devices:[{devicesIndex:10}] |
#      | Format                | Select: HTML                                                                                    |
#      | Time Definitions.Date | Relative:[Hours,2]                                                                              |
#      | Schedule              | Run Every:once, On Time:+6H                                                                     |
#
#  @SID_52
#  Scenario:  Top Probed IP Addresses Report - Time: Quick Range (1M)
#    Given UI "Create" Report With Name "Top Probed IP Addresses Time_Quick_1M"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Probed IP Addresses],devices:[All], showTable:true |
#      | Format                | Select: CSV                                                                                     |
#      | Time Definitions.Date | Quick:1M                                                                                        |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |
#
# # ------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#  @SID_53
#  Scenario: Attacks by Protection Policy Report - Time: Quick Range (Today), Schedule: (Weekly,MON)
#    Given UI "Create" Report With Name "Attacks by Protection Policy Time_Quick_Today  Schedule_Weekly"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Protection Policy], devices:[All], showTable:true |
#      | Format                | Select: CSV                                                                                           |
#      | Logo                  | reportLogoPNG.png                                                                                     |
#      | Time Definitions.Date | Quick:Today                                                                                           |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                                          |
#
#  @SID_54
#  Scenario: Attacks by Protection Policy Report - Time:Relative (Days), Schedule: (Daily)
#    Given UI "Create" Report With Name "Attacks by Protection Policy Time_Relative_Days  Schedule_Daily"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Protection Policy],devices:[{devicesIndex:10}] |
#      | Format                | Select: PDF                                                                                          |
#      | Logo                  | reportLogoPNG.png                                                                                    |
#      | Time Definitions.Date | Relative:[Days,2]                                                                                    |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                          |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                       |
#
#
#  @SID_55
#  Scenario:  Attacks by Protection Policy Report - Time: Absolute, Schedule: (Monthly,SEP)
#    Given UI "Create" Report With Name "Attacks by Protection Policy Time_Absolute  Schedule_Monthly"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Protection Policy],devices:[{devicesIndex:10, devicesIndex:11}] |
#      | Format                | Select: HTML                                                                                                          |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                                   |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[SEP]                                                                       |
#
#  @SID_56
#  Scenario:  Attacks by Protection Policy Report - Time: Relative (Months)
#    Given UI "Create" Report With Name "Attacks by Protection Policy Time_Relative_Months"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Attacks by Protection Policy],devices:[All], showTable:true |
#      | Format                | Select: CSV                                                                                          |
#      | Time Definitions.Date | Relative:[Months,2]                                                                                  |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                       |
#
#  # ------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#  @SID_57
#  Scenario: Attack Categories by Bandwidth Report - Time: Quick Range (15m)
#    Given UI "Create" Report With Name "Attack Categories by Bandwidth Time_Quick_15m"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Attack Categories by Bandwidth], devices:[All], showTable:true |
#      | Format                | Select: CSV                                                                                             |
#      | Logo                  | reportLogoPNG.png                                                                                       |
#      | Time Definitions.Date | Quick:15m                                                                                               |
#
#  @SID_58
#  Scenario: Attack Categories by Bandwidth Report - Time:Absolute , Schedule: (Monthly,APR)
#    Given UI "Create" Report With Name "Attack Categories by Bandwidth Time_Absolute  Schedule_Monthly"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Attack Categories by Bandwidth],devices:[{devicesIndex:10}] |
#      | Format                | Select: PDF                                                                                            |
#      | Logo                  | reportLogoPNG.png                                                                                      |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                    |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                        |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
#
#
#  @SID_59
#  Scenario:  Attack Categories by Bandwidth Report - Time: Relative: (Weeks), Schedule: (Weekly,SUN)
#    Given UI "Create" Report With Name "Attack Categories by Bandwidth Time_Relative_Weeks  Schedule_Weekly"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Attack Categories by Bandwidth],devices:[{devicesIndex:10, devicesIndex:11}] |
#      | Format                | Select: HTML                                                                                                            |
#      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                      |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                            |
#
#  @SID_60
#  Scenario:  Attack Categories by Bandwidth Report - Time: Relative (Hours), Schedule: (Daily)
#    Given UI "Create" Report With Name "Attack Categories by Bandwidth Time_Relative_Hours)_  Schedule_Daily"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Attack Categories by Bandwidth],devices:[All], showTable:true |
#      | Format                | Select: CSV                                                                                            |
#      | Time Definitions.Date | Relative:[Hours,2]                                                                                     |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                            |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
#
#  # ------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#  @SID_61
#  Scenario: Top Allowed Attackers Report - Time: Quick Range (1H), Schedule: (Daily)
#    Given UI "Create" Report With Name "Top Allowed Attackers Time_Quick_1H  Schedule_Daily"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Allowed Attackers], devices:[All], showTable:true |
#      | Format                | Select: CSV                                                                                    |
#      | Logo                  | reportLogoPNG.png                                                                              |
#      | Time Definitions.Date | Quick:1H                                                                                       |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                    |
#
#  @SID_62
#  Scenario: Top Allowed Attackers Report - Time:Quick Range (This Week) , Schedule: (Weekly,THU)
#    Given UI "Create" Report With Name "Top Allowed Attackers Time_Quick_This Week  Schedule_Weekly"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Allowed Attackers],devices:[{devicesIndex:10}] |
#      | Format                | Select: PDF                                                                                   |
#      | Logo                  | reportLogoPNG.png                                                                             |
#      | Time Definitions.Date | Quick:This Week                                                                               |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                  |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                |
#
#  @SID_63
#  Scenario:  Top Allowed Attackers Report - Time: Absolute, Schedule: (Monthly,MAR)
#    Given UI "Create" Report With Name "Top Allowed Attackers Time_Absolute  Schedule_Monthly"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Allowed Attackers],devices:[{devicesIndex:10, devicesIndex:11}] |
#      | Format                | Select: HTML                                                                                                   |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                            |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                |
#
#  @SID_64
#  Scenario:  Top Allowed Attackers Report - Time: Relative (Weeks), Schedule: (once)
#    Given UI "Create" Report With Name "Top Allowed Attackers Time_Relative_Weeks"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Allowed Attackers],devices:[All], showTable:true |
#      | Format                | Select: CSV                                                                                   |
#      | Time Definitions.Date | Relative:[Weeks,2]                                                                            |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                |
#      | Schedule              | Run Every:once, On Time:+6H                                                                   |
#
#  # ------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#  @SID_65
#  Scenario: Top Attacks by Duration Report - Time: Quick Range (30m), Schedule: (Monthly,JUN)
#    Given UI "Create" Report With Name "Top Attacks by Duration Time_Quick_30m  Schedule_Monthly"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Duration], devices:[All], showTable:true |
#      | Format                | Select: CSV                                                                                      |
#      | Logo                  | reportLogoPNG.png                                                                                |
#      | Time Definitions.Date | Quick:30m                                                                                        |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                  |
#
#  @SID_66
#  Scenario: Top Attacks by Duration Report - Time:Quick Range (3M)
#    Given UI "Create" Report With Name "Top Attacks by Duration Time_Quick_3M"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Duration],devices:[{devicesIndex:10}] |
#      | Format                | Select: PDF                                                                                     |
#      | Logo                  | reportLogoPNG.png                                                                               |
#      | Time Definitions.Date | Quick:3M                                                                                        |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |
#
#  @SID_67
#  Scenario:  Top Attacks by Duration Report - Time: Absolute, Schedule: (Weekly,MUN)
#    Given UI "Create" Report With Name "Top Attacks by Duration Time_Absolute  Schedule_Weekly"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Duration],devices:[{devicesIndex:10, devicesIndex:11}] |
#      | Format                | Select: HTML                                                                                                     |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                              |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MUN]                                                                     |
#
#  @SID_68
#  Scenario:  Top Attacks by Duration Report - Time: Relative (Months), Schedule: (Daily)
#    Given UI "Create" Report With Name "Top Attacks by Duration Time_Relative_Months  Schedule_Daily"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Duration],devices:[All], showTable:true |
#      | Format                | Select: CSV                                                                                     |
#      | Time Definitions.Date | Relative:[Months,2]                                                                             |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                     |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |
#
#  # ------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#  @SID_69
#  Scenario: Top Attacks by Signature Report - Time: Quick Range (1H)
#    Given UI "Create" Report With Name "Top Attacks by Signature Time_Quick_1H"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Signature], devices:[All], showTable:true |
#      | Format                | Select: CSV                                                                                       |
#      | Logo                  | reportLogoPNG.png                                                                                 |
#      | Time Definitions.Date | Quick:1H                                                                                          |
#
#  @SID_70
#  Scenario: Top Attacks by Signature Report - Time:Absolute, Schedule:(Monthly,JAN)
#    Given UI "Create" Report With Name "Top Attacks by Signature Time_Quick_3M"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Signature],devices:[{devicesIndex:10}] |
#      | Format                | Select: PDF                                                                                      |
#      | Logo                  | reportLogoPNG.png                                                                                |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                              |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                  |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                   |
#
#  @SID_71
#  Scenario:  Top Attacks by Signature Report - Time: Relative:(Days), Schedule: (Daily)
#    Given UI "Create" Report With Name "Top Attacks by Signature Time_Relative_Days  Schedule_Daily"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Signature],devices:[{devicesIndex:10, devicesIndex:11}] |
#      | Format                | Select: HTML                                                                                                      |
#      | Time Definitions.Date | Relative:[Days,3]                                                                                                 |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                                       |
#
#  @SID_72
#  Scenario:  Top Attacks by Signature Report - Time: Relative (Weeks), Schedule: (Weekly,WED)
#    Given UI "Create" Report With Name "Top Attacks by Signature Time_Relative_Weeks  Schedule_Weekly"
#      | Template              | reportType:DefensePro Analytics , Widgets:[Top Attacks by Signature],devices:[All], showTable:true |
#      | Format                | Select: CSV                                                                                      |
#      | Time Definitions.Date | Relative:[Weeks,4]                                                                               |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                     |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                   |
#
#  #------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#  @SID_73
#  Scenario: All Widgets Report - bps,Inbound,All - Time: Quick Range (1H)
#    Given UI "Create" Report With Name "All Widgets bps_Inbound_All  Time_Quick_1H"
#      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[bps,Inbound,All]},ALL], devices:[All], showTable:true |
#      | Format                | Select: CSV                                                                                                        |
#      | Logo                  | reportLogoPNG.png                                                                                                  |
#      | Time Definitions.Date | Quick:1H                                                                                                           |
#
#  @SID_74
#  Scenario: All Widgets Report - bps,Outbound,All - Time:Absolute, Schedule:(Monthly,JAN)
#    Given UI "Create" Report With Name "All Widgets bps_Outbound_All  Time_Absolute  Schedule_Monthly"
#      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[bps,Outbound,All]},ALL], devices:[{devicesIndex:10}] |
#      | Format                | Select: PDF                                                                                                         |
#      | Logo                  | reportLogoPNG.png                                                                                                   |
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                                 |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                     |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                      |
#
#  @SID_75
#  Scenario:  All Widgets Report - bps,Inbound,1-100 - Time: Relative:(Days), Schedule: (Daily)
#    Given UI "Create" Report With Name "All Widgets  bps_Inbound_1_100  Time_Relative_Days  Schedule_Daily"
#      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[bps,Inbound,1-100]},ALL], devices:[{devicesIndex:10, devicesIndex:11}] |
#      | Format                | Select: HTML                                                                                                                          |
#      | Time Definitions.Date | Relative:[Days,2]                                                                                                                     |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                           |
#
#  @SID_76
#  Scenario:  All Widgets Report - pps,Outbound,1-100 - Time: Relative (Days), Schedule: (Daily)
#    Given UI "Create" Report With Name "All Widgets  pps_Outbound_1_100  Time_Relative_Days  Schedule_Daily"
#      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[pps,Outbound,1-100]},ALL], devices:[{devicesIndex:11}] |
#      | Format                | Select: HTML                                                                                                          |
#      | Time Definitions.Date | Relative:[Days,2]                                                                                                     |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                                           |
#
#  @SID_77
#  Scenario:  All Widgets Report - pps,Outbound,All - Time: Relative:(Weeks), Schedule: (Weekly,WED)
#    Given UI "Create" Report With Name "All Widgets  pps_Outbound_All  Time_Relative_Weeks  Schedule_Weekly"
#      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[bps,Outbound,All]},ALL], devices:[All], showTable:true |
#      | Format                | Select: CSV                                                                                                         |
#      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                  |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                        |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                      |
#
#  @SID_78
#  Scenario:  All Widgets Report - pps,Inbound,All - Time: Relative (Weeks), Schedule: (Weekly,WED)
#    Given UI "Create" Report With Name "All Widgets_pps_Inbound_All"
#      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[pps,Inbound,All]},ALL], devices:[All], showTable:true |
#      | Format                | Select: CSV                                                                                                        |
#      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                 |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                       |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                     |
#
#
#
# # ------------------------------------------------------------------------------------------------------------------------------------------------------------





