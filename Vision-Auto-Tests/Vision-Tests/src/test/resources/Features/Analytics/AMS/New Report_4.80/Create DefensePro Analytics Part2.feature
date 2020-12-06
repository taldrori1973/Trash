@TC118343
Feature: DefensePro Analytics Part 2

@SID_40
Scenario: create new Top Attack Destinations1
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Attack Destinations Report1"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[All],showTable:true |
| Logo                  | reportLogoPNG.png                                                                                    |
| Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                     |
| Format                | Select: CSV                                                                                          |
Then UI "Validate" Report With Name "Top Attack Destinations Report1"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[All],showTable:true |
| Logo                  | reportLogoPNG.png                                                                                    |
| Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                     |
| Format                | Select: CSV                                                                                          |
Then UI Delete Report With Name "Top Attack Destinations Report1"

@SID_41
Scenario: create new Top Attack Destinations2
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Attack Destinations Report2"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[All],showTable:false |
| Logo                  | reportLogoPNG.png                                                                                     |
| Time Definitions.Date | Quick:This Month                                                                                      |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUL]                                                       |
| share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                  |
| Format                | Select: PDF                                                                                           |
Then UI "Validate" Report With Name "Top Attack Destinations Report2"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[All],showTable:false |
| Logo                  | reportLogoPNG.png                                                                                     |
| Time Definitions.Date | Quick:This Month                                                                                      |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUL]                                                       |
| share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                  |
| Format                | Select: PDF                                                                                           |
Then UI Delete Report With Name "Top Attack Destinations Report2"

@SID_42
Scenario: create new Top Attack Destinations3
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Attack Destinations Report3"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[{deviceIndex:10}],showTable:false |
| Time Definitions.Date | Relative:[Hours,3]                                                                                                 |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                       |
| Format                | Select: HTML                                                                                                       |
Then UI "Validate" Report With Name "Top Attack Destinations Report3"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[{deviceIndex:10}],showTable:false |
| Time Definitions.Date | Relative:[Hours,3]                                                                                                 |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                       |
| Format                | Select: HTML                                                                                                       |
Then UI Delete Report With Name "Top Attack Destinations Report3"


@SID_43
Scenario: create new Top Attack Destinations4
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Attack Destinations Report4"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[All],showTable:true |
| Time Definitions.Date | Quick:Quarter                                                                                        |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                         |
| share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                 |
| Format                | Select: CSV                                                                                          |
Then UI "Validate" Report With Name "Top Attack Destinations Report4"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[All],showTable:true |
| Time Definitions.Date | Quick:Quarter                                                                                        |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                         |
| share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                 |
| Format                | Select: CSV                                                                                          |
Then UI Delete Report With Name "Top Attack Destinations Report4"


@SID_44
Scenario: Top Attack Sources Report 1
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Attack Sources 1"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Sources], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                   |
| Logo                  | reportLogoPNG.png                                                                             |
| Time Definitions.Date | Quick:30m                                                                                     |
Then UI "Validate" Report With Name "Top Attack Sources 1"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Sources], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                   |
| Logo                  | reportLogoPNG.png                                                                             |
| Time Definitions.Date | Quick:30m                                                                                     |
Then UI Delete Report With Name "Top Attack Sources 1"


@SID_45
Scenario: Top Attack Sources Report 2
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Attack Sources 2"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Sources],devices:[{deviceIndex:10}] |
| Format                | Select: PDF                                                                               |
| Logo                  | reportLogoPNG.png                                                                         |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                          |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body            |
Then UI "Validate" Report With Name "Top Attack Sources 2"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Sources],devices:[{deviceIndex:10}] |
| Format                | Select: PDF                                                                               |
| Logo                  | reportLogoPNG.png                                                                         |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                          |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body            |
Then UI Delete Report With Name "Top Attack Sources 2"

@SID_46
Scenario: Top Attack Sources Report 3
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Attack Sources 3"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Sources],devices:[{deviceIndex:10}] |
| Format                | Select: HTML                                                                              |
| Time Definitions.Date | Relative:[Weeks,2]                                                                        |
Then UI "Validate" Report With Name "Top Attack Sources 3"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Sources],devices:[{deviceIndex:10}] |
| Format                | Select: HTML                                                                              |
| Time Definitions.Date | Relative:[Weeks,2]                                                                        |
Then UI Delete Report With Name "Top Attack Sources 3"

@SID_47
Scenario: Top Attack Sources Report 4
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Attack Sources 4"
| Template | reportType:DefensePro Analytics,Widgets:[Top Attack Sources],devices:[All], showTable:true |
| Format   | Select: CSV                                                                                  |
| Schedule | Run Every:Weekly, On Time:+6H, At Days:[MON]                                                 |
| Share    | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body               |
Then UI "Validate" Report With Name "Top Attack Sources 4"
| Template | reportType:DefensePro Analytics,Widgets:[Top Attack Sources],devices:[All], showTable:true |
| Format   | Select: CSV                                                                                  |
| Schedule | Run Every:Weekly, On Time:+6H, At Days:[MON]                                                 |
| Share    | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body               |
Then UI Delete Report With Name "Top Attack Sources 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

@SID_48
Scenario: Top Scanners Report 1
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Scanners 1"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Scanners], devices:[All], showTable:true |
| Format                | Select: CSV                                                                             |
| Logo                  | reportLogoPNG.png                                                                       |
| Time Definitions.Date | Quick:3M                                                                                |
| Schedule              | Run Every:Daily,On Time:+2m                                                             |
Then UI "Validate" Report With Name "Top Scanners 1"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Scanners], devices:[All], showTable:true |
| Format                | Select: CSV                                                                             |
| Logo                  | reportLogoPNG.png                                                                       |
| Time Definitions.Date | Quick:3M                                                                                |
| Schedule              | Run Every:Daily,On Time:+2m                                                             |
Then UI Delete Report With Name "Top Scanners 1"

@SID_49
Scenario: Top Scanners Report 2
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Scanners 2"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Scanners],devices:[{deviceIndex:10}] |
| Format                | Select: PDF                                                                         |
| Logo                  | reportLogoPNG.png                                                                   |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                    |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                        |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body      |
Then UI "Validate" Report With Name "Top Scanners 2"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Scanners],devices:[{deviceIndex:10}] |
| Format                | Select: PDF                                                                         |
| Logo                  | reportLogoPNG.png                                                                   |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                    |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                        |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body      |
Then UI Delete Report With Name "Top Scanners 2"

@SID_50
Scenario: Top Scanners Report 3
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Scanners 3"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Scanners],devices:[{deviceIndex:10},{deviceIndex:11}] |
| Format                | Select: HTML                                                                                         |
| Time Definitions.Date | Relative:[Months,4]                                                                                  |
Then UI "Validate" Report With Name "Top Scanners 3"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Scanners],devices:[{deviceIndex:10},{deviceIndex:11}] |
| Format                | Select: HTML                                                                                         |
| Time Definitions.Date | Relative:[Months,4]                                                                                  |
Then UI Delete Report With Name "Top Scanners 3"

@SID_51
Scenario: Top Scanners Report 4
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Scanners 4"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Scanners],devices:[All], showTable:true |
| Format                | Select: CSV                                                                            |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                        |
| Time Definitions.Date | Quick:Quarter                                                                          |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body         |
Then UI "Validate" Report With Name "Top Scanners 4"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Scanners],devices:[All], showTable:true |
| Format                | Select: CSV                                                                            |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                        |
| Time Definitions.Date | Quick:Quarter                                                                          |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body         |
Then UI Delete Report With Name "Top Scanners 4"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

@SID_52
Scenario: Top Probed IP Addresses Report 1
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Probed IP Addresses 1"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Probed IP Addresses], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                        |
| Logo                  | reportLogoPNG.png                                                                                  |
| Time Definitions.Date | Quick:This Week                                                                                    |
| Schedule              | Run Every:Daily,On Time:+2m                                                                        |
Then UI "Validate" Report With Name "Top Probed IP Addresses 1"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Probed IP Addresses], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                        |
| Logo                  | reportLogoPNG.png                                                                                  |
| Time Definitions.Date | Quick:This Week                                                                                    |
| Schedule              | Run Every:Daily,On Time:+2m                                                                        |
Then UI Delete Report With Name "Top Probed IP Addresses 1"

@SID_53
Scenario: Top Probed IP Addresses 2
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Probed IP Addresses 2"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Probed IP Addresses],devices:[{deviceIndex:10}] |
| Format                | Select: PDF                                                                                    |
| Logo                  | reportLogoPNG.png                                                                              |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                               |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                   |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                 |
Then UI "Validate" Report With Name "Top Probed IP Addresses 2"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Probed IP Addresses],devices:[{deviceIndex:10}] |
| Format                | Select: PDF                                                                                    |
| Logo                  | reportLogoPNG.png                                                                              |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                               |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                   |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                 |
Then UI Delete Report With Name "Top Probed IP Addresses 2"

@SID_54
Scenario: Top Probed IP Addresses Report 3
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Probed IP Addresses 3"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Probed IP Addresses],devices:[{deviceIndex:10}] |
| Format                | Select: HTML                                                                                   |
| Time Definitions.Date | Relative:[Hours,2]                                                                             |
| Schedule              | Run Every:once, On Time:+6H                                                                    |
Then UI "Validate" Report With Name "Top Probed IP Addresses 3"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Probed IP Addresses],devices:[{deviceIndex:10}] |
| Format                | Select: HTML                                                                                   |
| Time Definitions.Date | Relative:[Hours,2]                                                                             |
| Schedule              | Run Every:once, On Time:+6H                                                                    |
Then UI Delete Report With Name "Top Probed IP Addresses 3"

@SID_55
Scenario: Top Probed IP Addresses Report 4
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Probed IP Addresses 4"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Probed IP Addresses],devices:[All], showTable:true |
| Format                | Select: CSV                                                                                       |
| Time Definitions.Date | Quick:1M                                                                                          |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                    |
Then UI "Validate" Report With Name "Top Probed IP Addresses 4"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Probed IP Addresses],devices:[All], showTable:true |
| Format                | Select: CSV                                                                                       |
| Time Definitions.Date | Quick:1M                                                                                          |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                    |
Then UI Delete Report With Name "Top Probed IP Addresses 4"

 # ------------------------------------------------------------------------------------------------------------------------------------------------------------

@SID_56
Scenario: Attacks by Protection Policy Report 1
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Attacks by Protection Policy 1"
| Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Protection Policy], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                             |
| Logo                  | reportLogoPNG.png                                                                                       |
| Time Definitions.Date | Quick:Today                                                                                             |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                                            |
Then UI "Validate" Report With Name "Attacks by Protection Policy 1"
| Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Protection Policy], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                             |
| Logo                  | reportLogoPNG.png                                                                                       |
| Time Definitions.Date | Quick:Today                                                                                             |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                                            |
Then UI Delete Report With Name "Attacks by Protection Policy 1"

@SID_57
Scenario: Attacks by Protection Policy Report 2
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Attacks by Protection Policy 2"
| Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Protection Policy],devices:[{deviceIndex:10}] |
| Format                | Select: PDF                                                                                         |
| Logo                  | reportLogoPNG.png                                                                                   |
| Time Definitions.Date | Relative:[Days,2]                                                                                   |
| Schedule              | Run Every:Daily,On Time:+2m                                                                         |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                      |
Then UI "Validate" Report With Name "Attacks by Protection Policy 2"
| Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Protection Policy],devices:[{deviceIndex:10}] |
| Format                | Select: PDF                                                                                         |
| Logo                  | reportLogoPNG.png                                                                                   |
| Time Definitions.Date | Relative:[Days,2]                                                                                   |
| Schedule              | Run Every:Daily,On Time:+2m                                                                         |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                      |
Then UI Delete Report With Name "Attacks by Protection Policy 2"

@SID_58
Scenario: Attacks by Protection Policy 3
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Attacks by Protection Policy 3"
| Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Protection Policy],devices:[{deviceIndex:10},{deviceIndex:11}] |
| Format                | Select: HTML                                                                                                         |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                     |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[SEP]                                                                      |
Then UI "Validate" Report With Name "Attacks by Protection Policy 3"
| Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Protection Policy],devices:[{deviceIndex:10},{deviceIndex:11}] |
| Format                | Select: HTML                                                                                                         |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                     |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[SEP]                                                                      |
Then UI Delete Report With Name "Attacks by Protection Policy 3"

@SID_59
Scenario: Attacks by Protection Policy 4
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Attacks by Protection Policy 4"
| Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Protection Policy],devices:[All], showTable:true |
| Format                | Select: CSV                                                                                            |
| Time Definitions.Date | Relative:[Months,2]                                                                                    |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |

Then UI "Validate" Report With Name "Attacks by Protection Policy 4"
| Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Protection Policy],devices:[All], showTable:true |
| Format                | Select: CSV                                                                                            |
| Time Definitions.Date | Relative:[Months,2]                                                                                    |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
Then UI Delete Report With Name "Attacks by Protection Policy 4"

  # ------------------------------------------------------------------------------------------------------------------------------------------------------------

@SID_60
Scenario: Attack Categories by Bandwidth Report 1
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Attack Categories by Bandwidth 1"
| Template              | reportType:DefensePro Analytics,Widgets:[Attack Categories by Bandwidth], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                               |
| Logo                  | reportLogoPNG.png                                                                                         |
| Time Definitions.Date | Quick:15m                                                                                                 |
Then UI "Validate" Report With Name "Attack Categories by Bandwidth 1"
| Template              | reportType:DefensePro Analytics,Widgets:[Attack Categories by Bandwidth], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                               |
| Logo                  | reportLogoPNG.png                                                                                         |
| Time Definitions.Date | Quick:15m                                                                                                 |
Then UI Delete Report With Name "Attack Categories by Bandwidth 1"

@SID_61
Scenario: Attack Categories by Bandwidth Report 2
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Attack Categories by Bandwidth 2"
| Template              | reportType:DefensePro Analytics,Widgets:[Attack Categories by Bandwidth],devices:[{deviceIndex:10}] |
| Format                | Select: PDF                                                                                           |
| Logo                  | reportLogoPNG.png                                                                                     |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                      |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                       |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
Then UI "Validate" Report With Name "Attack Categories by Bandwidth 2"
| Template              | reportType:DefensePro Analytics,Widgets:[Attack Categories by Bandwidth],devices:[{deviceIndex:10}] |
| Format                | Select: PDF                                                                                           |
| Logo                  | reportLogoPNG.png                                                                                     |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                      |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                       |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
Then UI Delete Report With Name "Attack Categories by Bandwidth 2"

@SID_62
Scenario: Attack Categories by Bandwidth Report 3
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Attack Categories by Bandwidth 3"
| Template              | reportType:DefensePro Analytics,Widgets:[Attack Categories by Bandwidth],devices:[{deviceIndex:10},{deviceIndex:11}] |
| Format                | Select: HTML                                                                                                           |
| Time Definitions.Date | Relative:[Weeks,2]                                                                                                     |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                           |
Then UI "Validate" Report With Name "Attack Categories by Bandwidth 3"
| Template              | reportType:DefensePro Analytics,Widgets:[Attack Categories by Bandwidth],devices:[{deviceIndex:10},{deviceIndex:11}] |
| Format                | Select: HTML                                                                                                           |
| Time Definitions.Date | Relative:[Weeks,2]                                                                                                     |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                           |
Then UI Delete Report With Name "Attack Categories by Bandwidth 3"

@SID_63
Scenario: Attack Categories by Bandwidth Report 4
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Attack Categories by Bandwidth 4"
| Template              | reportType:DefensePro Analytics,Widgets:[Attack Categories by Bandwidth],devices:[All], showTable:true |
| Format                | Select: CSV                                                                                              |
| Time Definitions.Date | Relative:[Hours,2]                                                                                       |
| Schedule              | Run Every:Daily,On Time:+2m                                                                              |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                           |
Then UI "Validate" Report With Name "Attack Categories by Bandwidth 4"
| Template              | reportType:DefensePro Analytics,Widgets:[Attack Categories by Bandwidth],devices:[All], showTable:true |
| Format                | Select: CSV                                                                                              |
| Time Definitions.Date | Relative:[Hours,2]                                                                                       |
| Schedule              | Run Every:Daily,On Time:+2m                                                                              |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                           |
Then UI Delete Report With Name "Attack Categories by Bandwidth 4"

  # ------------------------------------------------------------------------------------------------------------------------------------------------------------

@SID_64
Scenario: Top Allowed Attackers Report 1
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Allowed Attackers 1"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Allowed Attackers], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                      |
| Logo                  | reportLogoPNG.png                                                                                |
| Time Definitions.Date | Quick:1H                                                                                         |
| Schedule              | Run Every:Daily,On Time:+2m                                                                      |
Then UI "Validate" Report With Name "Top Allowed Attackers 1"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Allowed Attackers], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                      |
| Logo                  | reportLogoPNG.png                                                                                |
| Time Definitions.Date | Quick:1H                                                                                         |
| Schedule              | Run Every:Daily,On Time:+2m                                                                      |
Then UI Delete Report With Name "Top Allowed Attackers 1"

@SID_65
Scenario: Top Allowed Attackers Report 2
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Allowed Attackers 2"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Allowed Attackers],devices:[{deviceIndex:10}] |
| Format                | Select: PDF                                                                                  |
| Logo                  | reportLogoPNG.png                                                                            |
| Time Definitions.Date | Quick:This Week                                                                              |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                 |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body               |
Then UI "Validate" Report With Name "Top Allowed Attackers 2"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Allowed Attackers],devices:[{deviceIndex:10}] |
| Format                | Select: PDF                                                                                  |
| Logo                  | reportLogoPNG.png                                                                            |
| Time Definitions.Date | Quick:This Week                                                                              |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                 |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body               |
Then UI Delete Report With Name "Top Allowed Attackers 2"

@SID_66
Scenario: Top Allowed Attackers Report 3
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Allowed Attackers 3"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Allowed Attackers],devices:[{deviceIndex:10},{deviceIndex:11}] |
| Format                | Select: HTML                                                                                                  |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                              |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                               |
Then UI "Validate" Report With Name "Top Allowed Attackers 3"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Allowed Attackers],devices:[{deviceIndex:10},{deviceIndex:11}] |
| Format                | Select: HTML                                                                                                  |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                              |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                               |
Then UI Delete Report With Name "Top Allowed Attackers 3"

@SID_67
Scenario: Top Allowed Attackers Report 4
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Allowed Attackers 4"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Allowed Attackers],devices:[All], showTable:true |
| Format                | Select: CSV                                                                                     |
| Time Definitions.Date | Relative:[Weeks,2]                                                                              |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |
| Schedule              | Run Every:once, On Time:+6H                                                                     |
Then UI "Validate" Report With Name "Top Allowed Attackers 4"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Allowed Attackers],devices:[All], showTable:true |
| Format                | Select: CSV                                                                                     |
| Time Definitions.Date | Relative:[Weeks,2]                                                                              |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |
| Schedule              | Run Every:once, On Time:+6H                                                                     |
Then UI Delete Report With Name "Top Allowed Attackers 4"

  # ------------------------------------------------------------------------------------------------------------------------------------------------------------

@SID_68
Scenario: Top Attacks by Duration Report 1
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Attacks by Duration 1"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Duration], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                        |
| Logo                  | reportLogoPNG.png                                                                                  |
| Time Definitions.Date | Quick:30m                                                                                          |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                    |
Then UI "Validate" Report With Name "Top Attacks by Duration 1"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Duration], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                        |
| Logo                  | reportLogoPNG.png                                                                                  |
| Time Definitions.Date | Quick:30m                                                                                          |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                    |
Then UI Delete Report With Name "Top Attacks by Duration 1"

@SID_69
Scenario: Top Attacks by Duration 2
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Attacks by Duration 2"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Duration],devices:[{deviceIndex:10}] |
| Format                | Select: PDF                                                                                    |
| Logo                  | reportLogoPNG.png                                                                              |
| Time Definitions.Date | Quick:3M                                                                                       |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                 |
Then UI "Validate" Report With Name "Top Attacks by Duration 2"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Duration],devices:[{deviceIndex:10}] |
| Format                | Select: PDF                                                                                    |
| Logo                  | reportLogoPNG.png                                                                              |
| Time Definitions.Date | Quick:3M                                                                                       |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                 |
Then UI Delete Report With Name "Top Attacks by Duration 2"

@SID_70
Scenario: Top Attacks by Duration Report 3
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Attacks by Duration 3"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Duration],devices:[{deviceIndex:10},{deviceIndex:11}] |
| Format                | Select: HTML                                                                                                    |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                                                    |
Then UI "Validate" Report With Name "Top Attacks by Duration 3"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Duration],devices:[{deviceIndex:10},{deviceIndex:11}] |
| Format                | Select: HTML                                                                                                    |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                                                    |
Then UI Delete Report With Name "Top Attacks by Duration 3"

@SID_71
Scenario: Top Attacks by Duration Report 4
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Attacks by Duration 4"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Duration],devices:[All], showTable:true |
| Format                | Select: CSV                                                                                       |
| Time Definitions.Date | Relative:[Months,2]                                                                               |
| Schedule              | Run Every:Daily,On Time:+2m                                                                       |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                    |
Then UI "Validate" Report With Name "Top Attacks by Duration 4"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Duration],devices:[All], showTable:true |
| Format                | Select: CSV                                                                                       |
| Time Definitions.Date | Relative:[Months,2]                                                                               |
| Schedule              | Run Every:Daily,On Time:+2m                                                                       |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                    |
Then UI Delete Report With Name "Top Attacks by Duration 4"

  # ------------------------------------------------------------------------------------------------------------------------------------------------------------

@SID_72
Scenario: Top Attacks by Signature Report 1
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Attacks by Signature 1"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Signature], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                         |
| Logo                  | reportLogoPNG.png                                                                                   |
| Time Definitions.Date | Quick:1H                                                                                            |
Then UI "Validate" Report With Name "Top Attacks by Signature 1"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Signature], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                         |
| Logo                  | reportLogoPNG.png                                                                                   |
| Time Definitions.Date | Quick:1H                                                                                            |
Then UI Delete Report With Name "Top Attacks by Signature 1"

@SID_73
Scenario: Top Attacks by Signature 2
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Attacks by Signature 2"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Signature],devices:[{deviceIndex:10}] |
| Format                | Select: PDF                                                                                     |
| Logo                  | reportLogoPNG.png                                                                               |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                 |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |
Then UI "Validate" Report With Name "Top Attacks by Signature 2"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Signature],devices:[{deviceIndex:10}] |
| Format                | Select: PDF                                                                                     |
| Logo                  | reportLogoPNG.png                                                                               |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                 |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |
Then UI Delete Report With Name "Top Attacks by Signature 2"

@SID_74
Scenario: Top Attacks by Signature Report 3
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Attacks by Signature 3"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Signature],devices:[{deviceIndex:10},{deviceIndex:11}] |
| Format                | Select: HTML                                                                                                     |
| Time Definitions.Date | Relative:[Days,3]                                                                                                |
| Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
Then UI "Validate" Report With Name "Top Attacks by Signature 3"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Signature],devices:[{deviceIndex:10},{deviceIndex:11}] |
| Format                | Select: HTML                                                                                                     |
| Time Definitions.Date | Relative:[Days,3]                                                                                                |
| Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
Then UI Delete Report With Name "Top Attacks by Signature 3"

@SID_75
Scenario: Top Attacks by Signature Report 4
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "Top Attacks by Signature 4"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Signature],devices:[All], showTable:true |
| Format                | Select: CSV                                                                                        |
| Time Definitions.Date | Relative:[Weeks,4]                                                                                 |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                       |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                     |
Then UI "Validate" Report With Name "Top Attacks by Signature 4"
| Template              | reportType:DefensePro Analytics,Widgets:[Top Attacks by Signature],devices:[All], showTable:true |
| Format                | Select: CSV                                                                                        |
| Time Definitions.Date | Relative:[Weeks,4]                                                                                 |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                       |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                     |
Then UI Delete Report With Name "Top Attacks by Signature 4"

  #------------------------------------------------------------------------------------------------------------------------------------------------------------

@SID_76
Scenario: All Widgets Report 1
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "All Widgets 1"
| Template              | reportType:DefensePro Analytics,Widgets:[{ALL:[{Traffic Bandwidth:[pps,Inbound,All Policies]}]}], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                                                       |
| Logo                  | reportLogoPNG.png                                                                                                                 |
| Time Definitions.Date | Quick:1H                                                                                                                          |
Then UI "Validate" Report With Name "All Widgets 1"
| Template              | reportType:DefensePro Analytics,Widgets:[{ALL:[{Traffic Bandwidth:[pps,Inbound,All Policies]}]}], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                                                       |
| Logo                  | reportLogoPNG.png                                                                                                                 |
| Time Definitions.Date | Quick:1H                                                                                                                          |
Then UI Delete Report With Name "All Widgets 1"

@SID_77
Scenario: All Widgets Report 2
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "All Widgets 2"
| Template              | reportType:DefensePro Analytics,Widgets:[{ALL:[{Traffic Bandwidth:[bps,Outbound,All Policies]}]}], devices:[{deviceIndex:10}] |
| Format                | Select: PDF                                                                                                                     |
| Logo                  | reportLogoPNG.png                                                                                                               |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                                 |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                  |
Then UI "Validate" Report With Name "All Widgets 2"
| Template              | reportType:DefensePro Analytics,Widgets:[{ALL:[{Traffic Bandwidth:[bps,Outbound,All Policies]}]}], devices:[{deviceIndex:10}] |
| Format                | Select: PDF                                                                                                                     |
| Logo                  | reportLogoPNG.png                                                                                                               |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                |
| Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                                 |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                  |
Then UI Delete Report With Name "All Widgets 2"

@SID_78
Scenario: All Widgets Report 3
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "All Widgets 3"
| Template              | reportType:DefensePro Analytics,Widgets:[{ALL:[{Traffic Bandwidth:[bps,Inbound,50]}]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
| Format                | Select: HTML                                                                                                                          |
| Time Definitions.Date | Relative:[Days,2]                                                                                                                     |
| Schedule              | Run Every:Daily,On Time:+2m                                                                                                           |
Then UI "Validate" Report With Name "All Widgets 3"
| Template              | reportType:DefensePro Analytics,Widgets:[{ALL:[{Traffic Bandwidth:[bps,Inbound,50]}]}], devices:[{deviceIndex:10},{deviceIndex:11}] |
| Format                | Select: HTML                                                                                                                          |
| Time Definitions.Date | Relative:[Days,2]                                                                                                                     |
| Schedule              | Run Every:Daily,On Time:+2m                                                                                                           |
Then UI Delete Report With Name "All Widgets 3"

@SID_79
Scenario: All Widgets Report 4
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "All Widgets 4"
| Template              | reportType:DefensePro Analytics,Widgets:[{ALL:[{Traffic Bandwidth:[pps,Outbound,60]}]}], devices:[{deviceIndex:11}] |
| Format                | Select: HTML                                                                                                          |
| Time Definitions.Date | Relative:[Days,2]                                                                                                     |
| Schedule              | Run Every:Daily,On Time:+2m                                                                                           |
Then UI "Validate" Report With Name "All Widgets 4"
| Template              | reportType:DefensePro Analytics,Widgets:[{ALL:[{Traffic Bandwidth:[pps,Outbound,60]}]}], devices:[{deviceIndex:11}] |
| Format                | Select: HTML                                                                                                          |
| Time Definitions.Date | Relative:[Days,2]                                                                                                     |
| Schedule              | Run Every:Daily,On Time:+2m                                                                                           |
Then UI Delete Report With Name "All Widgets 4"

@SID_80
Scenario: All Widgets Report 5
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "All Widgets 5"
| Template              | reportType:DefensePro Analytics ,Widgets:[{ALL:[{Traffic Bandwidth:[bps,Outbound,All Policies]}]}], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                                                         |
| Time Definitions.Date | Relative:[Weeks,2]                                                                                                                  |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                               |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                      |
Then UI "Validate" Report With Name "All Widgets 5"
| Template              | reportType:DefensePro Analytics ,Widgets:[{ALL:[{Traffic Bandwidth:[bps,Outbound,All Policies]}]}], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                                                         |
| Time Definitions.Date | Relative:[Weeks,2]                                                                                                                  |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                               |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                      |
Then UI Delete Report With Name "All Widgets 5"

@SID_81
Scenario: All Widgets Report 6
Then UI Click Button "New Report Tab"
Given UI "Create" Report With Name "All Widgets 6"
| Template              | reportType:DefensePro Analytics,Widgets:[{ALL:[{Traffic Bandwidth:[pps,Inbound,All Policies]}]}], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                                                       |
| Time Definitions.Date | Relative:[Weeks,2]                                                                                                                |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                             |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                    |
Then UI "Validate" Report With Name "All Widgets 6"
| Template              | reportType:DefensePro Analytics,Widgets:[{ALL:[{Traffic Bandwidth:[pps,Inbound,All Policies]}]}], devices:[All], showTable:true |
| Format                | Select: CSV                                                                                                                       |
| Time Definitions.Date | Relative:[Weeks,2]                                                                                                                |
  #    | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                             |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                    |
Then UI Delete Report With Name "All Widgets 6"


 # ------------------------------------------------------------------------------------------------------------------------------------------------------------

@SID_82
Scenario: Logout
Then UI logout and close browser