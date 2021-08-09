@TC122170
Feature: Attack Statistics Totals Table

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage

#--------------------------------------------- HTML Format ------------------------------------------
  @SID_2
  Scenario: create new DefensePro Analytics Report
    Given UI "Create" Report With Name "DefensePro Analytics Report"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[{deviceIndex:10, devicePolicies:[BDOS,SSL]}],showTable:true |
      | Format   | Select: HTML                                                                                                                           |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[{deviceIndex:10, devicePolicies:[BDOS,SSL]}],showTable:true |
      | Format   | Select: HTML                                                                                                                           |

  @SID_3
  Scenario: Generate report DefensePro Analytics Report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"

  @SID_4
  Scenario: Show report DefensePro Analytics Report
    Then UI Click Button "Log Preview" with value "DefensePro Analytics Report_0"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of event"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,539,553"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of dropped packets"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "5,671,952,000"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total dropped bandwidth"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,843,206 Mbit"

  @SID_5
  Scenario: Edit and Generate report DefensePro Analytics Report
    Given UI "Edit" Report With Name "DefensePro Analytics Report"
      | Format                | Select: PDF                                                                    |
      | Time Definitions.Date | Quick:This Week                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Format                | Select: PDF                                                                    |
      | Time Definitions.Date | Quick:This Week                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |

    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"

  @SID_6
  Scenario: Show report DefensePro Analytics Report
    Then UI Click Button "Log Preview" with value "DefensePro Analytics Report_0"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of event"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,539,553"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of dropped packets"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "5,671,952,000"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total dropped bandwidth"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,843,206 Mbit"


  @SID_7
  Scenario: create new DefensePro Analytics Report
    Given UI "Create" Report With Name "DefensePro Analytics Report"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[{deviceIndex:10, devicePolicies:[BDOS,SSL]}],showTable:true |
      | Format   | Select: PDF                                                                                                                            |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[{deviceIndex:10, devicePolicies:[BDOS,SSL]}],showTable:true |
      | Format   | Select: PDF                                                                                                                            |

  @SID_8
  Scenario: Generate report DefensePro Analytics Report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"

  @SID_9
  Scenario: Show report DefensePro Analytics Report
    Then UI Click Button "Log Preview" with value "DefensePro Analytics Report_0"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of event"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,539,553"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of dropped packets"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "5,671,952,000"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total dropped bandwidth"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,843,206 Mbit"
    Then UI Delete Report With Name "DefensePro Analytics Report"



#--------------------------------------------------------------- PDF Format -------------------------------------------------------------------
  @SID_10
  Scenario: create new DefensePro Analytics Report Format PDF Report
    Given UI "Create" Report With Name "DefensePro Analytics Report Format PDF Report"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[{deviceIndex:10, devicePolicies:[BDOS,SSL]}],showTable:true |
      | Format   | Select: PDF                                                                                                                            |
    Then UI "Validate" Report With Name "DefensePro Analytics Report Format PDF Report"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[{deviceIndex:10, devicePolicies:[BDOS,SSL]}],showTable:true |
      | Format   | Select: PDF                                                                                                                            |

  @SID_11
  Scenario: Generate report DefensePro Analytics Report Format PDF Report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report Format PDF Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report Format PDF Report"
    Then Sleep "35"

  @SID_12
  Scenario: Show report DefensePro Analytics Report Format PDF Report
    Then UI Click Button "Log Preview" with value "DefensePro Analytics Report Format PDF Report_0"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of event"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,539,553"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of dropped packets"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "5,671,952,000"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total dropped bandwidth"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,843,206 Mbit"

  @SID_12
  Scenario: Edit Template widgets and devices DefensePro Analytics Report Format PDF Report
    Given UI "Edit" Report With Name "DefensePro Analytics Report Format PDF Report"
      | Template | reportType:DefensePro Analytics,Widgets:[ALL],devices:[All] |
    Then UI "Validate" Report With Name "DefensePro Analytics Report Format PDF Report"
      | Template | reportType:DefensePro Analytics,Widgets:[ALL],devices:[All] |

  @SID_13
  Scenario: Generate report DefensePro Analytics Report Format PDF Report after the edit Template widgets
    Then UI Click Button "My Report" with value "DefensePro Analytics Report Format PDF Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report Format PDF Report"
    Then Sleep "35"

  @SID_14
  Scenario: Show report DefensePro Analytics Report Format PDF Report after the edit Template widgets
    Then UI Click Button "Log Preview" with value "DefensePro Analytics Report Format PDF Report_0"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of event"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,539,553"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of dropped packets"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "5,671,952,000"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total dropped bandwidth"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,843,206 Mbit"

  @SID_15
  Scenario: Edit share email and devices DefensePro Analytics Report Format PDF Report
    Given UI "Edit" Report With Name "DefensePro Analytics Report Format PDF Report"
      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
    Then UI "Validate" Report With Name "DefensePro Analytics Report Format PDF Report"
      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |

  @SID_16
  Scenario: Generate report DefensePro Analytics Report Format PDF Report after the edit share email
    Then UI Click Button "My Report" with value "DefensePro Analytics Report Format PDF Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report Format PDF Report"
    Then Sleep "35"

  @SID_17
  Scenario: Show report DefensePro Analytics Report Format PDF Report after the edit share email
    Then UI Click Button "Log Preview" with value "DefensePro Analytics Report Format PDF Report_0"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of event"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,539,553"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of dropped packets"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "5,671,952,000"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total dropped bandwidth"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,843,206 Mbit"

  @SID_18
  Scenario: Edit time and devices DefensePro Analytics Report Format PDF Report
    Given UI "Edit" Report With Name "DefensePro Analytics Report Format PDF Report"
      | Time Definitions.Date | Quick:15m |
    Then UI "Validate" Report With Name "DefensePro Analytics Report Format PDF Report"
      | Time Definitions.Date | Quick:15m |

  @SID_19
  Scenario: Generate report DefensePro Analytics Report Format PDF Report after the edit time
    Then UI Click Button "My Report" with value "DefensePro Analytics Report Format PDF Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report Format PDF Report"
    Then Sleep "35"

  @SID_20
  Scenario: Show report DefensePro Analytics Report Format PDF Report after the edit time
    Then UI Click Button "Log Preview" with value "DefensePro Analytics Report Format PDF Report_0"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of event"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,539,553"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of dropped packets"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "5,671,952,000"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total dropped bandwidth"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,843,206 Mbit"

  @SID_21
  Scenario: Edit logo and devices DefensePro Analytics Report Format PDF Report
    Given UI "Edit" Report With Name "DefensePro Analytics Report Format PDF Report"
      | Logo | reportLogoPNG.png |
    Then UI "Validate" Report With Name "DefensePro Analytics Report Format PDF Report"
      | Logo | reportLogoPNG.png |

  @SID_22
  Scenario: Generate report DefensePro Analytics Report Format PDF Report after the edit logo
    Then UI Click Button "My Report" with value "DefensePro Analytics Report Format PDF Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report Format PDF Report"
    Then Sleep "35"

  @SID_23
  Scenario: Show report DefensePro Analytics Report Format PDF Report after the edit logo
    Then UI Click Button "Log Preview" with value "DefensePro Analytics Report Format PDF Report_0"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of event"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,539,553"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of dropped packets"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "5,671,952,000"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total dropped bandwidth"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,843,206 Mbit"

  @SID_24
  Scenario: Edit Schedule and devices DefensePro Analytics Report Format PDF Report
    Given UI "Edit" Report With Name "DefensePro Analytics Report Format PDF Report"
      | Schedule | Run Every:Daily,On Time:+2m |
    Then UI "Validate" Report With Name "DefensePro Analytics Report Format PDF Report"
      | Schedule | Run Every:Daily,On Time:+2m |
    Then Sleep "60"

  @SID_25
  Scenario: Show report DefensePro Analytics Report Format PDF Report after the edit Schedule
    Then UI Click Button "Log Preview" with value "DefensePro Analytics Report Format PDF Report_0"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of event"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,539,553"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of dropped packets"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "5,671,952,000"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total dropped bandwidth"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,843,206 Mbit"
    Then UI Delete Report With Name "DefensePro Analytics Report Format PDF Report"

  @SID_26
  Scenario: Edit time and devices DefensePro Analytics Report Format PDF Report
    Given UI "Edit" Report With Name "DefensePro Analytics Report Format PDF Report"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "DefensePro Analytics Report Format PDF Report"
      | Format | Select: HTML |

  @SID_27
  Scenario: Generate report DefensePro Analytics Report Format PDF Report after the edit format
    Then UI Click Button "My Report" with value "DefensePro Analytics Report Format PDF Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report Format PDF Report"
    Then Sleep "35"

  @SID_28
  Scenario: Show report DefensePro Analytics Report Format PDF Report after the edit format
    Then UI Click Button "Log Preview" with value "DefensePro Analytics Report Format PDF Report_0"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of event"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,539,553"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total number of dropped packets"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "5,671,952,000"
    Then UI Text of " Attack Statistics Totals Label" with extension "Total number of event" equal to "Total dropped bandwidth"
    Then UI Text of " Attack Statistics Totals Value" with extension "Total number of event" equal to "3,843,206 Mbit"
    Then UI Delete Report With Name "DefensePro Analytics Report Format PDF Report"

  @SID_29
  Scenario: Logout
    Then UI logout and close browser