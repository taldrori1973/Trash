@TC122170 
Feature: Attack Statistics Totals Table

  @SID_1
  Scenario: Clean system data
    Given CLI Reset radware password
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    * CLI kill all simulator attacks on current vision
    * CLI Clear vision logs
    * REST Delete ES index "dp-*"
    * REST Delete ES index "forensics-*"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"


  @SID_2
  Scenario: Run DP simulator BDOS attack
    Given CLI simulate 1 attacks of type "many_attacks" on "DefensePro" 10 and wait 250 seconds
    * CLI kill all simulator attacks on current vision


  @SID_3
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage

#--------------------------------------------- HTML Format ------------------------------------------

  
  @SID_4
  Scenario: create new DefensePro Analytics Report
    Given UI "Create" Report With Name "DefensePro Analytics Report"
      | Template              | reportType:DefensePro Analytics,Widgets:[ALL] ,devices:[All],showTable:true |
      | Format                | Select: HTML                                                                |
      | Time Definitions.Date | Quick:This Week                                                             |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Template              | reportType:DefensePro Analytics,Widgets:[ALL] ,devices:[All],showTable:true |
      | Format                | Select: HTML                                                                |
      | Time Definitions.Date | Quick:This Week                                                             |


  @SID_5
  Scenario: Generate report DefensePro Analytics Report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "100"

  @SID_6
  Scenario: Show DefensePro Analytics Report
    Then UI Click Button "Log Preview" with value "DefensePro Analytics Report_0"
    Then UI ScrollIntoView with label "Attack Statistics Totals Label" and params "Total number of dropped packets"
    Then UI Text of "Attack Statistics Totals Label" with extension "Total dropped bandwidth" equal to "Total dropped bandwidth"
    Then UI Text of "Attack Statistics Totals Value" with extension "Total dropped bandwidth" equal to "140,128.995 Mbit"
    Then UI Text of "Attack Statistics Totals Label" with extension "Total number of events" equal to "Total number of events"
    Then UI Text of "Attack Statistics Totals Value" with extension "Total number of events" equal to "33"
    Then UI Text of "Attack Statistics Totals Label" with extension "Total number of dropped packets" equal to "Total number of dropped packets"
    Then UI Text of "Attack Statistics Totals Value" with extension "Total number of dropped packets" equal to "151,049,505"

  @SID_7
  Scenario: Edit logo DefensePro Analytics Report
    Given UI "Edit" Report With Name "DefensePro Analytics Report"
      | Logo | reportLogoPNG.png |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Logo | reportLogoPNG.png |

  @SID_8
  Scenario: Generate report DefensePro Analytics Report after edit logo
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "100"

  @SID_9
  Scenario: Show report DefensePro Analytics Report after edit logo
    Then UI Click Button "Log Preview" with value "DefensePro Analytics Report_0"
    Then UI ScrollIntoView with label "Attack Statistics Totals Label" and params "Total number of dropped packets"
    Then UI Text of "Attack Statistics Totals Label" with extension "Total dropped bandwidth" equal to "Total dropped bandwidth"
    Then UI Text of "Attack Statistics Totals Value" with extension "Total dropped bandwidth" equal to "140,128.995 Mbit"
    Then UI Text of "Attack Statistics Totals Label" with extension "Total number of events" equal to "Total number of events"
    Then UI Text of "Attack Statistics Totals Value" with extension "Total number of events" equal to "33"
    Then UI Text of "Attack Statistics Totals Label" with extension "Total number of dropped packets" equal to "Total number of dropped packets"
    Then UI Text of "Attack Statistics Totals Value" with extension "Total number of dropped packets" equal to "151,049,505"

  @SID_10
  Scenario: Edit share email and devices DefensePro Analytics Report
    Given UI "Edit" Report With Name "DefensePro Analytics Report"
      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |

  @SID_11
  Scenario: Generate report DefensePro Analytics Report after edit email
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "100"

  @SID_12
  Scenario: Show report DefensePro Analytics Report after edit email
    Then UI Click Button "Log Preview" with value "DefensePro Analytics Report_0"
    Then UI ScrollIntoView with label "Attack Statistics Totals Label" and params "Total number of dropped packets"
    Then UI Text of "Attack Statistics Totals Label" with extension "Total dropped bandwidth" equal to "Total dropped bandwidth"
    Then UI Text of "Attack Statistics Totals Value" with extension "Total dropped bandwidth" equal to "140,128.995 Mbit"
    Then UI Text of "Attack Statistics Totals Label" with extension "Total number of events" equal to "Total number of events"
    Then UI Text of "Attack Statistics Totals Value" with extension "Total number of events" equal to "33"
    Then UI Text of "Attack Statistics Totals Label" with extension "Total number of dropped packets" equal to "Total number of dropped packets"
    Then UI Text of "Attack Statistics Totals Value" with extension "Total number of dropped packets" equal to "151,049,505"

    #--------------------------------------------- PDF Format ------------------------------------------

  @SID_13
  Scenario: edit format PDF  DefensePro Analytics Report
    Given UI "Edit" Report With Name "DefensePro Analytics Report"
      | Format | Select: PDF |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Format | Select: PDF |

  @SID_14
  Scenario: Generate DefensePro Analytics Report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "100"

  @SID_15
  Scenario: Show report DefensePro Analytics Report
    Then UI Click Button "Log Preview" with value "DefensePro Analytics Report_0"
    Then UI ScrollIntoView with label "Attack Statistics Totals Label" and params "Total number of dropped packets"
    Then UI Text of "Attack Statistics Totals Label" with extension "Total dropped bandwidth" equal to "Total dropped bandwidth"
    Then UI Text of "Attack Statistics Totals Value" with extension "Total dropped bandwidth" equal to "140,128.995 Mbit"
    Then UI Text of "Attack Statistics Totals Label" with extension "Total number of events" equal to "Total number of events"
    Then UI Text of "Attack Statistics Totals Value" with extension "Total number of events" equal to "33"
    Then UI Text of "Attack Statistics Totals Label" with extension "Total number of dropped packets" equal to "Total number of dropped packets"
    Then UI Text of "Attack Statistics Totals Value" with extension "Total number of dropped packets" equal to "151,049,505"

  @SID_16
  Scenario: Edit share and devices DefensePro Analytics Report
    Given UI "Edit" Report With Name "DefensePro Analytics Report"
      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |

  @SID_17
  Scenario: Generate report DefensePro Analytics Report after the edit share email
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "100"

  @SID_18
  Scenario: Show report DefensePro Analytics Report after the edit share email
    Then UI Click Button "Log Preview" with value "DefensePro Analytics Report_0"
    Then UI ScrollIntoView with label "Attack Statistics Totals Label" and params "Total number of dropped packets"
    Then UI Text of "Attack Statistics Totals Label" with extension "Total dropped bandwidth" equal to "Total dropped bandwidth"
    Then UI Text of "Attack Statistics Totals Value" with extension "Total dropped bandwidth" equal to "140,128.995 Mbit"
    Then UI Text of "Attack Statistics Totals Label" with extension "Total number of events" equal to "Total number of events"
    Then UI Text of "Attack Statistics Totals Value" with extension "Total number of events" equal to "33"
    Then UI Text of "Attack Statistics Totals Label" with extension "Total number of dropped packets" equal to "Total number of dropped packets"
    Then UI Text of "Attack Statistics Totals Value" with extension "Total number of dropped packets" equal to "151,049,505"

  @SID_19
  Scenario: Edit logo and devices DefensePro Analytics Report in PDF Format
    Given UI "Edit" Report With Name "DefensePro Analytics Report"
      | Logo | reportLogoPNG.png |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Logo | reportLogoPNG.png |

  @SID_20
  Scenario: Generate report DefensePro Analytics Report after the edit logo in PDF Format
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "100"

  @SID_21
  Scenario: Show report DefensePro Analytics Report after the edit logo in PDF Format
    Then UI Click Button "Log Preview" with value "DefensePro Analytics Report_0"
    Then UI ScrollIntoView with label "Attack Statistics Totals Label" and params "Total number of dropped packets"
    Then UI Text of "Attack Statistics Totals Label" with extension "Total dropped bandwidth" equal to "Total dropped bandwidth"
    Then UI Text of "Attack Statistics Totals Value" with extension "Total dropped bandwidth" equal to "140,128.995 Mbit"
    Then UI Text of "Attack Statistics Totals Label" with extension "Total number of events" equal to "Total number of events"
    Then UI Text of "Attack Statistics Totals Value" with extension "Total number of events" equal to "33"
    Then UI Text of "Attack Statistics Totals Label" with extension "Total number of dropped packets" equal to "Total number of dropped packets"
    Then UI Text of "Attack Statistics Totals Value" with extension "Total number of dropped packets" equal to "151,049,505"

  @SID_22
  Scenario: Delete report
    Then UI Delete Report With Name "DefensePro Analytics Report"

  @SID_23
  Scenario: Logout
    Then UI logout and close browser