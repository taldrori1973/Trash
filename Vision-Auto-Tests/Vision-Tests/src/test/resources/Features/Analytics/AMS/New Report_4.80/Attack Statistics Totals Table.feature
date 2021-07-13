Feature: Attack Statistics Totals Table

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage

  @SID_2
  Scenario: create new DefensePro DefensePro Analytics Report
    Given UI "Create" Report With Name "DefensePro Analytics Report"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[{deviceIndex:10, devicePolicies:[BDOS,SSL]}],showTable:true |
      | Format   | Select: HTML                                                                                                                           |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[{deviceIndex:10, devicePolicies:[BDOS,SSL]}],showTable:true |
      | Format   | Select: HTML                                                                                                                           |

  @SID_3
  Scenario: Generate report DefensePro DefensePro Analytics Report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"

  @SID_4
  Scenario: Show report DefensePro DefensePro Analytics Report
    Then UI Click Button "Log Preview" with value "DefensePro Analytics Report_0"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of event"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,539,553"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of dropped packets"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "5,671,952,000"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total dropped bandwidth"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,843,206 Mbit"








  @SID_12
  Scenario: Logout
    Then UI logout and close browser