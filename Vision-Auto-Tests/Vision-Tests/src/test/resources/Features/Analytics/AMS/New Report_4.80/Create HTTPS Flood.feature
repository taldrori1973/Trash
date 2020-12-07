@TC117962
Feature: HTTPS Flood

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: Inbound Traffic Report 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Inbound Traffic 1"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic], Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
      | Format                | Select: CSV                                                                                                                  |
      | Logo                  | reportLogoPNG.png                                                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                  |
      | Time Definitions.Date | Quick:Today                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                               |
    Then UI "Validate" Report With Name "Inbound Traffic 1"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic], Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
      | Format                | Select: CSV                                                                                                                  |
      | Logo                  | reportLogoPNG.png                                                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                  |
      | Time Definitions.Date | Quick:Today                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                               |
    Then UI Delete Report With Name "Inbound Traffic 1"


  @SID_3
  Scenario: Inbound Traffic Report 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Inbound Traffic 2"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic], Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
      | Format                | Select: CSV                                                                                                                  |
      | Time Definitions.Date | Quick:Quarter                                                                                                                |
    #  | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                          |
    Then UI "Validate" Report With Name "Inbound Traffic 2"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic], Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
      | Format                | Select: CSV                                                                                                                  |
      | Time Definitions.Date | Quick:Quarter                                                                                                                |
     # | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                          |
    Then UI Delete Report With Name "Inbound Traffic 2"


  @SID_4
  Scenario:  Inbound Traffic Report 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Inbound Traffic 3"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic], Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
      | Format                | Select: PDF                                                                                                                  |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                               |
    Then UI "Validate" Report With Name "Inbound Traffic 3"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic], Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
      | Format                | Select: PDF                                                                                                                  |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                               |
    Then UI Delete Report With Name "Inbound Traffic 3"


  @SID_5
  Scenario:  Inbound Traffic Report 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Inbound Traffic 4"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
      | Logo                  | reportLogoPNG.png                                                                                                           |
      | Format                | Select: HTML                                                                                                                |
      | Schedule              | Run Every:once, On Time:+6H                                                                                                 |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                         |
    Then UI "Validate" Report With Name "Inbound Traffic 4"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
      | Logo                  | reportLogoPNG.png                                                                                                           |
      | Format                | Select: HTML                                                                                                                |
      | Schedule              | Run Every:once, On Time:+6H                                                                                                 |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                         |
    Then UI Delete Report With Name "Inbound Traffic 4"

  @SID_6
  Scenario:  Inbound Traffic Report 5
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Inbound Traffic 5"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
      | Logo                  | reportLogoPNG.png                                                                                                           |
      | Format                | Select: CSV                                                                                                                 |
      | Time Definitions.Date | Quick:1M                                                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                              |
    Then UI "Validate" Report With Name "Inbound Traffic 5"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
      | Logo                  | reportLogoPNG.png                                                                                                           |
      | Format                | Select: CSV                                                                                                                 |
      | Time Definitions.Date | Quick:1M                                                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                              |
    Then UI Delete Report With Name "Inbound Traffic 5"

  @SID_7
  Scenario: Logout
    Then UI logout and close browser