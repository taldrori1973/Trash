@TC_HTTPS_Flood

Feature: HTTPS Flood


  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "NEW REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: Inbound Traffic Report - Time:Quick Range (Today), Schedule: (Daily)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Inbound Traffic Time_Quick_Today  Schedule_Daily"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic], devices:[{deviceIndex:10, deviceIndex:11}] |
      | Format                | Select: CSV                                                                                      |
      | Logo                  | reportLogoPNG.png                                                                                |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                      |
      | Time Definitions.Date | Quick:Today                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                   |


  @SID_3
  Scenario: Inbound Traffic Report - Time: Quick Range (Quarter), Schedule: (Weekly,Thu)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Inbound Traffic Time_Quick_Quarter  Schedule_Weekly"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic],devices:[{deviceIndex:10}] |
      | Format                | Select: CSV                                                                    |
      | Time Definitions.Date | Quick:Quarter                                                                  |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                   |


  @SID_4
  Scenario:  Inbound Traffic Report - Time: Absolute, Schedule: (Monthly,Jun)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Inbound Traffic Time_Absolute  Schedule_Monthly"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic],devices:[{deviceIndex:10, deviceIndex:11}] |
      | Format                | Select: PDF                                                                                     |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |


  @SID_5
  Scenario:  Inbound Traffic Report - Time:Relative:(Months), Schedule: (once)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Inbound Traffic Time_Relative_Months  Schedule_once"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic],devices:[{deviceIndex:11}] |
      | Logo                  | reportLogoPNG.png                                                              |
      | Format                | Select: HTML                                                                   |
      | Schedule              | Run Every:once, On Time:+6H                                                    |
      | Time Definitions.Date | Relative:[Months,2]                                                            |

  @SID_6
  Scenario:  Inbound Traffic Report - Time:Quick Range (1M)
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Inbound Traffic Time_Quick_1M"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic],devices:[{deviceIndex:10}] |
      | Logo                  | reportLogoPNG.png                                                              |
      | Format                | Select: CSV                                                                    |
      | Time Definitions.Date | Quick:1M                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |

  @SID_7
  Scenario: Logout
    Then UI logout and close browser