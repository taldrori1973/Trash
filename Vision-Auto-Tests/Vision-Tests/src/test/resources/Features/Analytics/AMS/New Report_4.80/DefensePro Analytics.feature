

@SID_1
Scenario: Navigate to NEW REPORTS page
  Then UI Login with user "radware" and password "radware"
  Then UI Navigate to "NEW REPORTS" page via homepage

@SID_2
Scenario: create new
  Given UI "Create" Report With Name "Traffic Report"
  | Template              | reportType:DefensePro Analytics , Widgets:[Traffic Bandwidth],devices:[All]  |
  |Template-1            | reportType:Appwall , Widgets:[Traffic Bandwidth],devices:[All]         |
  | Format                | Select: PDF                            |
  | Logo                  | reportLogoPNG.png                                                                                                                                                                      |
  | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                                                                                |
  | Time Definitions.Date | Quick:Today                                                                                                                                                                       |