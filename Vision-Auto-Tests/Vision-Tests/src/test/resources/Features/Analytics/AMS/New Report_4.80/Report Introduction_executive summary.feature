@AMEEN1
Feature: Report introduction and executive summary

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: create new Report intro_executive summary
    Given UI "Create" Report With Name "Report intro_executive summary"
      | Template-1            | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format                | Select: PDF                                                                                                                                           |
      | ExecutiveSummary      | SummaryBody: Automation test, Title: false, Bold:false, Underline: false, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Validate" Report With Name "Report intro_executive summary"
      | Template-1            | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format                | Select: PDF                                                                                                                                           |
      | ExecutiveSummary      | SummaryBody: Automation test, Title: false, Bold:false, Underline: false, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |

    Then UI Click Button "My Report" with value "Report intro_executive summary"
    Then UI Click Button "Generate Report Manually" with value "Report intro_executive summary"
    Then Sleep "60"
    Then UI Click Button "Log Preview" with value "Report intro_executive summary_0"
    Then Sleep "10"
    Then UI Text of Executive Summary equal to "Automation test" and Link Equal to "Click Here To Open Google,www.google.com"
    Then UI Delete Report With Name "Report intro_executive summary"


  @SID_3
  Scenario: create new Report intro_executive summary1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Report intro_executive summary1"
      | Template-1            | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format                | Select: PDF                                                                                                                                           |
      | ExecutiveSummary      | SummaryBody: Automation test, Title: false, Bold:false, Underline: true, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Validate" Report With Name "Report intro_executive summary1"
      | Template-1            | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format                | Select: PDF                                                                                                                                           |
      | ExecutiveSummary      | SummaryBody: Automation test, Title: false, Bold:false, Underline: true, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI Click Button "My Report" with value "Report intro_executive summary1"
    Then UI Click Button "Generate Report Manually" with value "Report intro_executive summary1"
    Then Sleep "60"
    Then UI Click Button "Log Preview" with value "Report intro_executive summary1_0"
    Then Sleep "10"
    Then UI Text of Executive Summary equal to "Automation test" and Link Equal to "Click Here To Open Google,www.google.com"
    Then UI Delete Report With Name "Report intro_executive summary1"


  @SID_4
  Scenario: create new Report intro_executive summary2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Report intro_executive summary2"
      | Template-1            | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format                | Select: PDF                                                                                                                                           |
      | ExecutiveSummary      | SummaryBody: Automation test, Title: false, Bold:true, Underline: true, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Validate" Report With Name "Report intro_executive summary2"
      | Template-1            | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format                | Select: PDF                                                                                                                                           |
      | ExecutiveSummary      | SummaryBody: Automation test, Title: false, Bold:true, Underline: true, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI Click Button "My Report" with value "Report intro_executive summary2"
    Then UI Click Button "Generate Report Manually" with value "Report intro_executive summary2"
    Then Sleep "60"
    Then UI Click Button "Log Preview" with value "Report intro_executive summary2_0"
    Then Sleep "10"
    Then UI Text of Executive Summary equal to "Automation test" and Link Equal to "Click Here To Open Google,www.google.com"
    Then UI Delete Report With Name "Report intro_executive summary2"

  @SID_5
  Scenario: create new Report intro_executive summary3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Report intro_executive summary3"
      | Template-1            | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format                | Select: PDF                                                                                                                                           |
      | ExecutiveSummary      | SummaryBody: Automation test, Title: true, Bold:false, Underline: true, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Validate" Report With Name "Report intro_executive summary3"
      | Template-1            | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format                | Select: PDF                                                                                                                                           |
      | ExecutiveSummary      | SummaryBody: Automation test, Title: true, Bold:false, Underline: true, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI Click Button "My Report" with value "Report intro_executive summary3"
    Then UI Click Button "Generate Report Manually" with value "Report intro_executive summary3"
    Then Sleep "60"
    Then UI Click Button "Log Preview" with value "Report intro_executive summary3_0"
    Then Sleep "10"
    Then UI Text of Executive Summary equal to "Automation test" and Link Equal to "Click Here To Open Google,www.google.com"
    Then UI Delete Report With Name "Report intro_executive summary3"


  @SID_6
  Scenario: create new Report intro_executive summary4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Report intro_executive summary4"
      | Template-1            | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format                | Select: PDF                                                                                                                                           |
      | ExecutiveSummary      | SummaryBody: Automation test, Title: true, Bold:false, Underline: false, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Validate" Report With Name "Report intro_executive summary4"
      | Template-1            | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format                | Select: PDF                                                                                                                                           |
      | ExecutiveSummary      | SummaryBody: Automation test, Title: true, Bold:false, Underline: false, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI Click Button "My Report" with value "Report intro_executive summary4"
    Then UI Click Button "Generate Report Manually" with value "Report intro_executive summary4"
    Then Sleep "60"
    Then UI Click Button "Log Preview" with value "Report intro_executive summary4_0"
    Then Sleep "10"
    Then UI Text of Executive Summary equal to "Automation test" and Link Equal to "Click Here To Open Google,www.google.com"
    Then UI Delete Report With Name "Report intro_executive summary4"


  @SID_7
  Scenario: create new Report intro_executive summary5
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Report intro_executive summary5"
      | Template-1            | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format                | Select: PDF                                                                                                                                           |
      | ExecutiveSummary      | SummaryBody: Automation test, Title: true, Bold:true, Underline: false, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Validate" Report With Name "Report intro_executive summary5"
      | Template-1            | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format                | Select: PDF                                                                                                                                           |
      | ExecutiveSummary      | SummaryBody: Automation test, Title: true, Bold:true, Underline: false, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI Click Button "My Report" with value "Report intro_executive summary5"
    Then UI Click Button "Generate Report Manually" with value "Report intro_executive summary5"
    Then Sleep "60"
    Then UI Click Button "Log Preview" with value "Report intro_executive summary5_0"
    Then Sleep "10"
    Then UI Text of Executive Summary equal to "Automation test" and Link Equal to "Click Here To Open Google,www.google.com"
    Then UI Delete Report With Name "Report intro_executive summary5"

  @SID_8
  Scenario: create new Report intro_executive summary6
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Report intro_executive summary6"
      | Template-1            | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format                | Select: PDF                                                                                                                                           |
      | ExecutiveSummary      | SummaryBody: Automation test, Title: false, Bold:true, Underline: false, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Validate" Report With Name "Report intro_executive summary6"
      | Template-1            | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format                | Select: PDF                                                                                                                                           |
      | ExecutiveSummary      | SummaryBody: Automation test, Title: false, Bold:true, Underline: false, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI Click Button "My Report" with value "Report intro_executive summary6"
    Then UI Click Button "Generate Report Manually" with value "Report intro_executive summary6"
    Then Sleep "60"
    Then UI Click Button "Log Preview" with value "Report intro_executive summary6_0"
    Then Sleep "10"
    Then UI Text of Executive Summary equal to "Automation test" and Link Equal to "Click Here To Open Google,www.google.com"
    Then UI Delete Report With Name "Report intro_executive summary6"

  @SID_9
  Scenario: create new Report intro_executive summary7
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Report intro_executive summary7"
      | Template-1            | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format                | Select: PDF                                                                                                                                           |
      | ExecutiveSummary      | SummaryBody: Automation test, Title: true, Bold:true, Underline: true, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI "Validate" Report With Name "Report intro_executive summary7"
      | Template-1            | reportType:DefensePro Analytics , Widgets:[All]  ,devices:[All]                                                                                       |
      | Format                | Select: PDF                                                                                                                                           |
      | ExecutiveSummary      | SummaryBody: Automation test, Title: true, Bold:true, Underline: true, Location: left, URL:[www.google.com,Click Here To Open Google] ,Enable :true |
    Then UI Click Button "My Report" with value "Report intro_executive summary7"
    Then UI Click Button "Generate Report Manually" with value "Report intro_executive summary7"
    Then Sleep "60"
    Then UI Click Button "Log Preview" with value "Report intro_executive summary7_0"
    Then Sleep "10"
    Then UI Text of Executive Summary equal to "Automation test" and Link Equal to "Click Here To Open Google,www.google.com"
    Then UI Delete Report With Name "Report intro_executive summary7"


  @SID_10
  Scenario: Logout
    Then UI logout and close browser