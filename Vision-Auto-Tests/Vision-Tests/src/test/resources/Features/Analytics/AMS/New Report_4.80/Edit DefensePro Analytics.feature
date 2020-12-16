@TC118578
Feature: Edit DefensePro Analytics tests

  @SID_1
  Scenario: Clean data before the test
    * REST Delete ES index "dp-*"

  @SID_2
  Scenario: Login
    Then UI Login with user "sys_admin" and password "radware"

  @SID_3
  Scenario: Run DP simulator PCAPs for "DP attacks"
    Given CLI simulate 1 attacks of type "many_attacks" on "DefensePro" 11 with loopDelay 15000 and wait 60 seconds

  @SID_4
  Scenario: Navigate to NEW REPORTS page
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_5
  Scenario: Create and validate DefensePro Analytics Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DefensePro Analytics Report"
      | Template-1            | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true                      |
      | Template-2            | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}],devices:[{deviceIndex:11}],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                         |
      | Time Definitions.Date | Quick:1D                                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                      |
      | Format                | Select: PDF                                                                                                               |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Template-1            | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true                      |
      | Template-2            | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}],devices:[{deviceIndex:11}],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                         |
      | Time Definitions.Date | Quick:1D                                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                      |
      | Format                | Select: PDF                                                                                                               |

  @SID_6
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"
    #todo validate data Ramez

  @SID_7
  Scenario: Add Template Widget to DefensePro Analytics
    Given UI "Edit" Report With Name "DefensePro Analytics Report"
      | Template-1 | reportType:DefensePro Analytics,AddWidgets:[Top Attacks],devices:[{deviceIndex:10}],showTable:true |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Template-1 | reportType:DefensePro Analytics,Widgets:[Top Attacks,Connections Rate],devices:[{deviceIndex:10}],showTable:true |

  @SID_9
  Scenario: Delete Template from DefensePro Analytics
    Given UI "Edit" Report With Name "DefensePro Analytics Report"
      | Template-2 | DeleteTemplate:true |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Template-1 | reportType:DefensePro Analytics,Widgets:[Top Attacks,Connections Rate],devices:[{deviceIndex:10}],showTable:true |

  @SID_11
  Scenario: Delete Template Widget from DefensePro Analytics
    Given UI "Edit" Report With Name "DefensePro Analytics Report"
      | Template-1 | reportType:DefensePro Analytics,DeleteWidgets:[Top Attacks],devices:[{deviceIndex:10}],showTable:true |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Template-1 | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true |

  @SID_13
  Scenario:Add Template to DefensePro Analytics Report
    Given UI "Edit" Report With Name "DefensePro Analytics Report"
      | Template | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}],devices:[{deviceIndex:11}],showTable:true |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Template-1 | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true                      |
      | Template-2 | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}],devices:[{deviceIndex:11}],showTable:true |

  @SID_15
  Scenario: Create and validate DefensePro Analytics Report2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DefensePro Analytics Report2"
      | Template-1            | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true                      |
      | Template-2            | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}],devices:[{deviceIndex:11}],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                         |
      | Time Definitions.Date | Quick:1D                                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                      |
      | Format                | Select: PDF                                                                                                               |
    Then UI "Validate" Report With Name "DefensePro Analytics Report2"
      | Template-1            | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true                      |
      | Template-2            | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}],devices:[{deviceIndex:11}],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                                         |
      | Time Definitions.Date | Quick:1D                                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                      |
      | Format                | Select: PDF                                                                                                               |

  @SID_16
  Scenario: Edit DefensePro Analytics Report2 report name
    Then UI Click Button "My Report Tab"
    Then UI Click Button "Edit Report" with value "DefensePro Analytics Report2"
    Then UI Set Text Field "Report Name" To "DefensePro Analytics Report"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable To Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'DefensePro Analytics Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "DefensePro Analytics Report"?"
    Then UI Click Button "Yes"
    Then UI Text of "Error message title" equal to "Unable To Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'DefensePro Analytics Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "DefensePro Analytics Report"?"
    Then UI Click Button "No"

  @SID_17
  Scenario: Delete report
    Then UI Delete Report With Name "DefensePro Analytics Report"
    Then UI Delete Report With Name "DefensePro Analytics Report2"

  @SID_18
  Scenario: Logout
    Then UI logout and close browser
