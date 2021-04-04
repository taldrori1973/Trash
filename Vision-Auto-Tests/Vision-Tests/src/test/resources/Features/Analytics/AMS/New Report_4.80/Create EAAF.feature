@TC117963
Feature: EAAF

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: create new Top Malicious IP Addresses1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Malicious IP Addresses1"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Volume]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                               |
      | Time Definitions.Date | Quick:1D                                                                        |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                    |
      | Format                | Select: CSV                                                                     |
    Then UI "Validate" Report With Name "Top Malicious IP Addresses1"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Volume]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                               |
      | Time Definitions.Date | Quick:1D                                                                        |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                    |
      | Format                | Select: CSV                                                                     |
    Then UI Delete Report With Name "Top Malicious IP Addresses1"

  @SID_3
  Scenario: create new Top Malicious IP Addresses2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Malicious IP Addresses2"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Packets]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                 |
      | Schedule              | Run Every:once, On Time:+6H                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body   |
      | Format                | Select: PDF                                                                      |
    Then UI "Validate" Report With Name "Top Malicious IP Addresses2"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Packets]}] ,devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                 |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                  |
      | Schedule              | Run Every:once, On Time:+6H                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body    |
      | Format                | Select: PDF                                                                       |
    Then UI Delete Report With Name "Top Malicious IP Addresses2"

  @SID_4
  Scenario: create new Top Malicious IP Addresses3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Malicious IP Addresses3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Events]}],devices:[All] |
      | Time Definitions.Date | Quick:This Week                                                                 |
      | Format                | Select: HTML                                                                    |
    Then UI "Validate" Report With Name "Top Malicious IP Addresses3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Events]}],devices:[All] |
      | Time Definitions.Date | Quick:This Week                                                                 |
      | Format                | Select: HTML                                                                    |
    Then UI Delete Report With Name "Top Malicious IP Addresses3"

  @SID_5
  Scenario: create new Top Malicious IP Addresses4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Malicious IP Addresses4"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Volume]}],devices:[All] |
      | Time Definitions.Date | Relative:[Days,2]                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body  |
      | Format                | Select: CSV                                                                     |
    Then UI "Validate" Report With Name "Top Malicious IP Addresses4"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Volume]}],devices:[All] |
      | Time Definitions.Date | Relative:[Days,2]                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body  |
      | Format                | Select: CSV                                                                     |
    Then UI Delete Report With Name "Top Malicious IP Addresses4"

  @SID_6
  Scenario: create new Top Attacking Geolocations1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacking Geolocations1"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Attacking Geolocations:[Events]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                               |
      | Time Definitions.Date | Quick:This Week                                                                 |
      | Schedule              | Run Every:Daily,On Time:+2m                                                     |
      | Format                | Select: CSV                                                                     |
    Then UI "Validate" Report With Name "Top Attacking Geolocations1"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Attacking Geolocations:[Events]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                               |
      | Time Definitions.Date | Quick:This Week                                                                 |
      | Schedule              | Run Every:Daily,On Time:+2m                                                     |
      | Format                | Select: CSV                                                                     |
    Then UI Delete Report With Name "Top Attacking Geolocations1"

  @SID_7
  Scenario: create new Top Attacking Geolocations2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacking Geolocations2"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Attacking Geolocations:[Events]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                               |
      | Time Definitions.Date | Relative:[Weeks,2]                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body  |
      | Format                | Select: PDF                                                                     |
    Then UI "Validate" Report With Name "Top Attacking Geolocations2"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Attacking Geolocations:[Events]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                               |
      | Time Definitions.Date | Relative:[Weeks,2]                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body  |
      | Format                | Select: PDF                                                                     |
    Then UI Delete Report With Name "Top Attacking Geolocations2"

  @SID_8
  Scenario: create new Top Attacking Geolocations3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacking Geolocations3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Attacking Geolocations:[Volume]}],devices:[All] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                 |
      | Format                | Select: HTML                                                                    |
    Then UI "Validate" Report With Name "Top Attacking Geolocations3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Attacking Geolocations:[Volume]}],devices:[All] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                 |
      | Format                | Select: HTML                                                                    |
    Then UI Delete Report With Name "Top Attacking Geolocations3"

  @SID_9
  Scenario: create new Top Attacking Geolocations4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacking Geolocations4"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Attacking Geolocations:[Events]}],devices:[All] |
      | Time Definitions.Date | Relative:[Months,2]                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body  |
      | Format                | Select: CSV                                                                     |
    Then UI "Validate" Report With Name "Top Attacking Geolocations4"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Attacking Geolocations:[Events]}],devices:[All] |
      | Time Definitions.Date | Relative:[Months,2]                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body  |
      | Format                | Select: CSV                                                                     |
    Then UI Delete Report With Name "Top Attacking Geolocations4"

  @SID_10
  Scenario: create new Breakdown by Malicious Activity1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Breakdown by Malicious Activity1"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Breakdown by Malicious Activity:[Volume]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                    |
      | Time Definitions.Date | Quick:30m                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[TUE]                                         |
      | Format                | Select: CSV                                                                          |
    Then UI "Validate" Report With Name "Breakdown by Malicious Activity1"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Breakdown by Malicious Activity:[Volume]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                    |
      | Time Definitions.Date | Quick:30m                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[TUE]                                         |
      | Format                | Select: CSV                                                                          |
    Then UI Delete Report With Name "Breakdown by Malicious Activity1"

  @SID_11
  Scenario: create new Breakdown by Malicious Activity2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Breakdown by Malicious Activity2"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Breakdown by Malicious Activity:[Packets]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body        |
      | Format                | Select: PDF                                                                           |
    Then UI "Validate" Report With Name "Breakdown by Malicious Activity2"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Breakdown by Malicious Activity:[Packets]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                     |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body        |
      | Format                | Select: PDF                                                                           |
    Then UI Delete Report With Name "Breakdown by Malicious Activity2"

  @SID_12
  Scenario: create new Breakdown by Malicious Activity3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Breakdown by Malicious Activity3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Breakdown by Malicious Activity:[Events]}],devices:[All] |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                   |
      | Format                | Select: HTML                                                                         |
    Then UI "Validate" Report With Name "Breakdown by Malicious Activity3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Breakdown by Malicious Activity:[Events]}],devices:[All] |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                   |
      | Format                | Select: HTML                                                                         |
    Then UI Delete Report With Name "Breakdown by Malicious Activity3"

  @SID_13
  Scenario: create new Breakdown by Malicious Activity4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Breakdown by Malicious Activity4"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Breakdown by Malicious Activity:[Volume]}],devices:[All] |
      | Time Definitions.Date | Quick:Quarter                                                                        |
      | Schedule              | Run Every:once, On Time:+6H                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body       |
      | Format                | Select: CSV                                                                          |
    Then UI "Validate" Report With Name "Breakdown by Malicious Activity4"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Breakdown by Malicious Activity:[Volume]}],devices:[All] |
      | Time Definitions.Date | Quick:Quarter                                                                        |
      | Schedule              | Run Every:once, On Time:+6H                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body       |
      | Format                | Select: CSV                                                                          |
    Then UI Delete Report With Name "Breakdown by Malicious Activity4"

  @SID_14
  Scenario: create new EAAF Hits Timeline1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "EAAF Hits Timeline1"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{EAAF Hits Timeline:[Volume]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                       |
      | Time Definitions.Date | Quick:Previous Month                                                    |
      | Format                | Select: CSV                                                             |
    Then UI "Validate" Report With Name "EAAF Hits Timeline1"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{EAAF Hits Timeline:[Volume]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                       |
      | Time Definitions.Date | Quick:Previous Month                                                    |
      | Format                | Select: CSV                                                             |
    Then UI Delete Report With Name "EAAF Hits Timeline1"

  @SID_15
  Scenario: create new EAAF Hits Timeline2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "EAAF Hits Timeline2"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{EAAF Hits Timeline:[Packets]}] ,devices:[All]      |
      | Logo                  | reportLogoPNG.png                                                              |
      | Time Definitions.Date | Quick:This Month                                                               |
      | Schedule              | Run Every:once, On Time:+6H                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: PDF                                                                    |
    Then UI "Validate" Report With Name "EAAF Hits Timeline2"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{EAAF Hits Timeline:[Packets]}],devices:[All]       |
      | Logo                  | reportLogoPNG.png                                                              |
      | Time Definitions.Date | Quick:This Month                                                               |
      | Schedule              | Run Every:once, On Time:+6H                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: PDF                                                                    |
    Then UI Delete Report With Name "EAAF Hits Timeline2"

  @SID_16
  Scenario: create new EAAF Hits Timeline3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "EAAF Hits Timeline3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{EAAF Hits Timeline:[Events]}],devices:[All] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                         |
      | Format                | Select: HTML                                                            |
    Then UI "Validate" Report With Name "EAAF Hits Timeline3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{EAAF Hits Timeline:[Events]}],devices:[All] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                         |
      | Format                | Select: HTML                                                            |
    Then UI Delete Report With Name "EAAF Hits Timeline3"

  @SID_17
  Scenario: create new EAAF Hits Timeline4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "EAAF Hits Timeline4"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{EAAF Hits Timeline:[Volume]}],devices:[All]        |
      | Time Definitions.Date | Relative:[Hours,3]                                                             |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI "Validate" Report With Name "EAAF Hits Timeline4"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{EAAF Hits Timeline:[Volume]}],devices:[All]        |
      | Time Definitions.Date | Relative:[Hours,3]                                                             |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Report With Name "EAAF Hits Timeline4"


  @SID_18
  Scenario: create new Totals in Selected Time Frame1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Totals in Selected Time Frame1"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[Totals in Selected Time Frame],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                       |
      | Time Definitions.Date | Quick:15m                                                               |
      | Format                | Select: CSV                                                             |
    Then UI "Validate" Report With Name "Totals in Selected Time Frame1"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[Totals in Selected Time Frame],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                       |
      | Time Definitions.Date | Quick:15m                                                               |
      | Format                | Select: CSV                                                             |
    Then UI Delete Report With Name "Totals in Selected Time Frame1"


  @SID_19
  Scenario: create new Totals in Selected Time Frame2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Totals in Selected Time Frame2"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[Totals in Selected Time Frame],devices:[All]        |
      | Logo                  | reportLogoPNG.png                                                              |
      | Time Definitions.Date | Quick:This Week                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: PDF                                                                    |
    Then UI "Validate" Report With Name "Totals in Selected Time Frame2"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[Totals in Selected Time Frame],devices:[All]        |
      | Logo                  | reportLogoPNG.png                                                              |
      | Time Definitions.Date | Quick:This Week                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: PDF                                                                    |
    Then UI Delete Report With Name "Totals in Selected Time Frame2"

  @SID_20
  Scenario: create new Totals in Selected Time Frame3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Totals in Selected Time Frame3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[Totals in Selected Time Frame],devices:[All] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                         |
      | Format                | Select: HTML                                                            |
    Then UI "Validate" Report With Name "Totals in Selected Time Frame3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[Totals in Selected Time Frame],devices:[All] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                         |
      | Format                | Select: HTML                                                            |
    Then UI Delete Report With Name "Totals in Selected Time Frame3"

  @SID_21
  Scenario: create new Totals in Selected Time Frame4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Totals in Selected Time Frame4"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[Totals in Selected Time Frame],devices:[All]        |
      | Time Definitions.Date | Relative:[Weeks,2]                                                             |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI "Validate" Report With Name "Totals in Selected Time Frame4"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[Totals in Selected Time Frame],devices:[All]        |
      | Time Definitions.Date | Relative:[Weeks,2]                                                             |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Report With Name "Totals in Selected Time Frame4"

  @SID_22
  Scenario: create new Top Malicious IP Addresses and Breakdown by Malicious Activity and EAAF Hits Timeline1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Malicious IP Addresses and Breakdown by Malicious Activity and EAAF Hits Timeline1"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Events]},{Breakdown by Malicious Activity:[Events]},{EAAF Hits Timeline:[Events]}] ,devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                                                         |
      | Time Definitions.Date | Quick:15m                                                                                                                                                 |
      | Format                | Select: CSV                                                                                                                                               |
    Then UI "Validate" Report With Name "Top Malicious IP Addresses and Breakdown by Malicious Activity and EAAF Hits Timeline1"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Events]},{Breakdown by Malicious Activity:[Events]},{EAAF Hits Timeline:[Events]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                                                        |
      | Time Definitions.Date | Quick:15m                                                                                                                                                |
      | Format                | Select: CSV                                                                                                                                              |
    Then UI Delete Report With Name "Top Malicious IP Addresses and Breakdown by Malicious Activity and EAAF Hits Timeline1"


  @SID_23
  Scenario: create new Top Malicious IP Addresses and Breakdown by Malicious Activity and EAAF Hits Timeline2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Malicious IP Addresses and Breakdown by Malicious Activity and EAAF Hits Timeline2"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Packets]},{Breakdown by Malicious Activity:[Packets]},{EAAF Hits Timeline:[Volume]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                                                          |
      | Time Definitions.Date | Quick:This Week                                                                                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                             |
      | Format                | Select: PDF                                                                                                                                                |
    Then UI "Validate" Report With Name "Top Malicious IP Addresses and Breakdown by Malicious Activity and EAAF Hits Timeline2"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Packets]},{Breakdown by Malicious Activity:[Packets]},{EAAF Hits Timeline:[Volume]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                                                          |
      | Time Definitions.Date | Quick:This Week                                                                                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                             |
      | Format                | Select: PDF                                                                                                                                                |
    Then UI Delete Report With Name "Top Malicious IP Addresses and Breakdown by Malicious Activity and EAAF Hits Timeline2"


  @SID_24
  Scenario: create new Top Malicious IP Addresses and Breakdown by Malicious Activity and EAAF Hits Timeline3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Malicious IP Addresses and Breakdown by Malicious Activity and EAAF Hits Timeline3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Volume]},{Breakdown by Malicious Activity:[Volume]},{EAAF Hits Timeline:[Volume]}],devices:[All] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                          |
      | Format                | Select: HTML                                                                                                                                             |
    Then UI "Validate" Report With Name "Top Malicious IP Addresses and Breakdown by Malicious Activity and EAAF Hits Timeline3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Volume]},{Breakdown by Malicious Activity:[Volume]},{EAAF Hits Timeline:[Volume]}],devices:[All] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                          |
      | Format                | Select: HTML                                                                                                                                             |
    Then UI Delete Report With Name "Top Malicious IP Addresses and Breakdown by Malicious Activity and EAAF Hits Timeline3"


  @SID_25
  Scenario: create new Top Malicious IP Addresses and Breakdown by Malicious Activity and EAAF Hits Timeline4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Malicious IP Addresses and Breakdown by Malicious Activity and EAAF Hits Timeline4"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Events]},{Breakdown by Malicious Activity:[Packets]},{EAAF Hits Timeline:[Volume]}],devices:[All] |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                        |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                            |
      | Format                | Select: CSV                                                                                                                                               |
    Then UI "Validate" Report With Name "Top Malicious IP Addresses and Breakdown by Malicious Activity and EAAF Hits Timeline4"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Events]},{Breakdown by Malicious Activity:[Packets]},{EAAF Hits Timeline:[Volume]}],devices:[All] |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                        |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                            |
      | Format                | Select: CSV                                                                                                                                               |
    Then UI Delete Report With Name "Top Malicious IP Addresses and Breakdown by Malicious Activity and EAAF Hits Timeline4"

  @SID_26
  Scenario: create new Top Attacking Geolocations and Breakdown by Malicious Activity and EAAF Hits Timeline1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacking Geolocations and Breakdown by Malicious Activity and EAAF Hits Timeline1"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Attacking Geolocations:[Volume]},{Breakdown by Malicious Activity:[Volume]},{EAAF Hits Timeline:[Volume]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                                                        |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                         |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                             |
      | Format                | Select: CSV                                                                                                                                              |
    Then UI "Validate" Report With Name "Top Attacking Geolocations and Breakdown by Malicious Activity and EAAF Hits Timeline1"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Attacking Geolocations:[Volume]},{Breakdown by Malicious Activity:[Volume]},{EAAF Hits Timeline:[Volume]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                                                        |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                         |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                             |
      | Format                | Select: CSV                                                                                                                                              |
    Then UI Delete Report With Name "Top Attacking Geolocations and Breakdown by Malicious Activity and EAAF Hits Timeline1"

  @SID_27
  Scenario: create new Top Attacking Geolocations and Breakdown by Malicious Activity and EAAF Hits Timeline2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacking Geolocations and Breakdown by Malicious Activity and EAAF Hits Timeline2"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Attacking Geolocations:[Events]},{Breakdown by Malicious Activity:[Events]},{EAAF Hits Timeline:[Events]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                                                        |
      | Time Definitions.Date | Quick:3M                                                                                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                           |
      | Format                | Select: PDF                                                                                                                                              |
    Then UI "Validate" Report With Name "Top Attacking Geolocations and Breakdown by Malicious Activity and EAAF Hits Timeline2"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Attacking Geolocations:[Events]},{Breakdown by Malicious Activity:[Events]},{EAAF Hits Timeline:[Events]}] ,devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                                                         |
      | Time Definitions.Date | Quick:3M                                                                                                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                            |
      | Format                | Select: PDF                                                                                                                                               |
    Then UI Delete Report With Name "Top Attacking Geolocations and Breakdown by Malicious Activity and EAAF Hits Timeline2"


  @SID_28
  Scenario: create new Top Attacking Geolocations and Breakdown by Malicious Activity and EAAF Hits Timeline3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacking Geolocations and Breakdown by Malicious Activity and EAAF Hits Timeline3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Attacking Geolocations:[Packets]},{Breakdown by Malicious Activity:[Packets]},{EAAF Hits Timeline:[Packets]}],devices:[All] |
      | Time Definitions.Date | Quick:This Month                                                                                                                                            |
      | Format                | Select: HTML                                                                                                                                                |
    Then UI "Validate" Report With Name "Top Attacking Geolocations and Breakdown by Malicious Activity and EAAF Hits Timeline3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Attacking Geolocations:[Packets]},{Breakdown by Malicious Activity:[Packets]},{EAAF Hits Timeline:[Packets]}],devices:[All] |
      | Time Definitions.Date | Quick:This Month                                                                                                                                            |
      | Format                | Select: HTML                                                                                                                                                |
    Then UI Delete Report With Name "Top Attacking Geolocations and Breakdown by Malicious Activity and EAAF Hits Timeline3"


  @SID_29
  Scenario: create new Top Attacking Geolocations and Breakdown by Malicious Activity and EAAF Hits Timeline4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacking Geolocations and Breakdown by Malicious Activity and EAAF Hits Timeline4"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Attacking Geolocations:[Volume]},{Breakdown by Malicious Activity:[Volume]},{EAAF Hits Timeline:[Volume]}],devices:[All] |
      | Time Definitions.Date | Quick:1H                                                                                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                          |
      | Format                | Select: HTML                                                                                                                                             |
    Then UI "Validate" Report With Name "Top Attacking Geolocations and Breakdown by Malicious Activity and EAAF Hits Timeline4"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Attacking Geolocations:[Volume]},{Breakdown by Malicious Activity:[Volume]},{EAAF Hits Timeline:[Volume]}],devices:[All] |
      | Time Definitions.Date | Quick:1H                                                                                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                          |
      | Format                | Select: HTML                                                                                                                                             |
    Then UI Delete Report With Name "Top Attacking Geolocations and Breakdown by Malicious Activity and EAAF Hits Timeline4"

  @SID_30
  Scenario: create new Breakdown by Malicious Activity and EAAF Hits Timeline1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Breakdown by Malicious Activity and EAAF Hits Timeline1"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Breakdown by Malicious Activity:[Volume]},{EAAF Hits Timeline:[Volume]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                  |
      | Time Definitions.Date | Quick:15m                                                                                                          |
      | Format                | Select: CSV                                                                                                        |
    Then UI "Validate" Report With Name " Breakdown by Malicious Activity and EAAF Hits Timeline1"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Breakdown by Malicious Activity:[Volume]},{EAAF Hits Timeline:[Volume]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                  |
      | Time Definitions.Date | Quick:15m                                                                                                          |
      | Format                | Select: CSV                                                                                                        |
    Then UI Delete Report With Name " Breakdown by Malicious Activity and EAAF Hits Timeline1"

  @SID_31
  Scenario: create new Breakdown by Malicious Activity and EAAF Hits Timeline2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Breakdown by Malicious Activity and EAAF Hits Timeline2"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Breakdown by Malicious Activity:[Packets]},{EAAF Hits Timeline:[Packets]}],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                    |
      | Time Definitions.Date | Quick:This Week                                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                       |
      | Format                | Select: PDF                                                                                                          |
    Then UI "Validate" Report With Name " Breakdown by Malicious Activity and EAAF Hits Timeline2"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Breakdown by Malicious Activity:[Packets]},{EAAF Hits Timeline:[Packets]}] ,devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                     |
      | Time Definitions.Date | Quick:This Week                                                                                                       |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                        |
      | Format                | Select: PDF                                                                                                           |
    Then UI Delete Report With Name " Breakdown by Malicious Activity and EAAF Hits Timeline2"

  @SID_32
  Scenario: create new Breakdown by Malicious Activity and EAAF Hits Timeline3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Breakdown by Malicious Activity and EAAF Hits Timeline3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Breakdown by Malicious Activity:[Events]},{EAAF Hits Timeline:[Events]}],devices:[All] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                    |
      | Format                | Select: HTML                                                                                                       |
    Then UI "Validate" Report With Name " Breakdown by Malicious Activity and EAAF Hits Timeline3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Breakdown by Malicious Activity:[Events]},{EAAF Hits Timeline:[Events]}],devices:[All] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                    |
      | Format                | Select: HTML                                                                                                       |
    Then UI Delete Report With Name " Breakdown by Malicious Activity and EAAF Hits Timeline3"

  @SID_33
  Scenario: create new Breakdown by Malicious Activity and EAAF Hits Timeline4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name " Breakdown by Malicious Activity and EAAF Hits Timeline4"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Breakdown by Malicious Activity:[Volume]},{EAAF Hits Timeline:[Packets]}],devices:[All] |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                  |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                      |
      | Format                | Select: CSV                                                                                                         |
    Then UI "Validate" Report With Name " Breakdown by Malicious Activity and EAAF Hits Timeline4"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Breakdown by Malicious Activity:[Volume]},{EAAF Hits Timeline:[Packets]}],devices:[All] |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                  |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                      |
      | Format                | Select: CSV                                                                                                         |
    Then UI Delete Report With Name " Breakdown by Malicious Activity and EAAF Hits Timeline4"

  @SID_34
  Scenario: create new All Widgets1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "All Widgets1"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Events]},{Top Attacking Geolocations:[Events]},{Breakdown by Malicious Activity:[Events]},{EAAF Hits Timeline:[Volume]},Totals in Selected Time Frame] ,devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                             |
      | Time Definitions.Date | Quick:Previous Month                                                                                                                                                                                                          |
      | Format                | Select: CSV                                                                                                                                                                                                                   |
    Then UI "Validate" Report With Name "All Widgets1"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Events]},{Top Attacking Geolocations:[Events]},{Breakdown by Malicious Activity:[Events]},{EAAF Hits Timeline:[Volume]},Totals in Selected Time Frame],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                            |
      | Time Definitions.Date | Quick:Previous Month                                                                                                                                                                                                         |
      | Format                | Select: CSV                                                                                                                                                                                                                  |
    Then UI Delete Report With Name "All Widgets1"

  @SID_35
  Scenario: create new All Widgets2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "All Widgets2"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Packets]},{Top Attacking Geolocations:[Packets]},{Breakdown by Malicious Activity:[Packets]},{EAAF Hits Timeline:[Volume]},Totals in Selected Time Frame],devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                               |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                                                                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                  |
      | Format                | Select: PDF                                                                                                                                                                                                                     |
    Then UI "Validate" Report With Name "All Widgets2"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Packets]},{Top Attacking Geolocations:[Packets]},{Breakdown by Malicious Activity:[Packets]},{EAAF Hits Timeline:[Volume]},Totals in Selected Time Frame] ,devices:[All] |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                   |
      | Format                | Select: PDF                                                                                                                                                                                                                      |
    Then UI Delete Report With Name "All Widgets2"

  @SID_36
  Scenario: create new All Widgets3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "All Widgets3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Volume]},{Top Attacking Geolocations:[Volume]},{Breakdown by Malicious Activity:[Volume]},{EAAF Hits Timeline:[Volume]},Totals in Selected Time Frame] ,devices:[All] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                               |
      | Format                | Select: HTML                                                                                                                                                                                                                  |
    Then UI "Validate" Report With Name "All Widgets3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Volume]},{Top Attacking Geolocations:[Volume]},{Breakdown by Malicious Activity:[Volume]},{EAAF Hits Timeline:[Volume]},Totals in Selected Time Frame],devices:[All] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                              |
      | Format                | Select: HTML                                                                                                                                                                                                                 |
    Then UI Delete Report With Name "All Widgets3"

  @SID_37
  Scenario: create new All Widgets3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "All Widgets3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Volume]},{Top Attacking Geolocations:[Events]},{Breakdown by Malicious Activity:[Volume]},{EAAF Hits Timeline:[Volume]},Totals in Selected Time Frame],devices:[All] |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                                                                                                                                           |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                                                                                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                               |
      | Format                | Select: CSV                                                                                                                                                                                                                  |
    Then UI "Validate" Report With Name "All Widgets3"
      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Volume]},{Top Attacking Geolocations:[Events]},{Breakdown by Malicious Activity:[Volume]},{EAAF Hits Timeline:[Volume]},Totals in Selected Time Frame] ,devices:[All] |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                                                                                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                |
      | Format                | Select: CSV                                                                                                                                                                                                                   |
    Then UI Delete Report With Name "All Widgets3"

  @SID_38
  Scenario: Logout
    Then UI logout and close browser




























































