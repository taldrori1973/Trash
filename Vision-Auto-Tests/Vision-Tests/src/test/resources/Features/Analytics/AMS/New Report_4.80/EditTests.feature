@TC118580
Feature: Edit AMS Report tests

  @SID_1
  Scenario: Clean data before the test
    * REST Delete ES index "dp-*"
    * REST Delete ES index "df-traffic*"
    * REST Delete ES index "appwall-v2-attack*"

  @SID_2
  Scenario: Login
    Then UI Login with user "sys_admin" and password "radware"

  @SID_3
  Scenario: Run DP simulator PCAPs for "DP attacks", "DF attacks" ,"HTTPS Flood attacks"
    Given CLI simulate 1 attacks of type "many_attacks" on "DefensePro" 11 with loopDelay 15000 and wait 60 seconds
    Given CLI simulate 1 attacks of type "HTTPS" on "DefensePro" 11 with loopDelay 15000 and wait 60 seconds
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_100.sh " |
      | #visionIP                                       |
      | " Terminated"                                   |
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_200.sh " |
      | #visionIP                                       |
      | " Terminated"                                   |
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER" and wait 30 seconds
      | "/home/radware/curl_DF_attacks-auto_PO_300.sh " |
      | #visionIP                                       |
      | " Terminated"                                   |

  @SID_4
  Scenario: Navigate to NEW REPORTS page
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_5
  Scenario: Create and validate Dp Analytics and DF Analytics and HTTPS Flood Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-1            | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true                      |
      | Template-2            | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO Name Space],showTable:true           |
      | Template-3            | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
      | Logo                  | reportLogoPNG.png                                                                                                         |
      | Time Definitions.Date | Quick:1D                                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                      |
      | Format                | Select: PDF                                                                                                               |
    Then UI "Validate" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-1            | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true                      |
      | Template-2            | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO Name Space],showTable:true           |
      | Template-3            | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
      | Logo                  | reportLogoPNG.png                                                                                                         |
      | Time Definitions.Date | Quick:1D                                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                      |
      | Format                | Select: PDF                                                                                                               |

  @SID_6
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "Dp Analytics and DF Analytics and HTTPS Flood Report"
    Then UI Click Button "Generate Report Manually" with value "Dp Analytics and DF Analytics and HTTPS Flood Report"
    Then Sleep "35"
    #todo validate data Ramez

  @SID_7
  Scenario: Add Template Widget to Dp Analytics and DF Analytics and HTTPS Flood Report
    Given UI "Edit" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-1 | reportType:DefensePro Analytics,AddWidgets:[Top Attacks],devices:[{deviceIndex:10}],showTable:true |
    Then UI "Validate" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-1 | reportType:DefensePro Analytics,Widgets:[Top Attacks,Connections Rate],devices:[{deviceIndex:10}],showTable:true |

  @SID_9
  Scenario: Delete Template from Dp Analytics and DF Analytics and HTTPS Flood Report
    Given UI "Edit" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-2 | DeleteTemplate:true |
    Then UI "Validate" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-1 | reportType:DefensePro Analytics,Widgets:[Top Attacks,Connections Rate],devices:[{deviceIndex:10}],showTable:true          |
      | Template-2 | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |

  @SID_11
  Scenario: Delete Template Widget from Dp Analytics and DF Analytics and HTTPS Flood Report
    Given UI "Edit" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-1 | reportType:DefensePro Analytics,DeleteWidgets:[Top Attacks],devices:[{deviceIndex:10}],showTable:true |
    Then UI "Validate" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-1 | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true |

  @SID_13
  Scenario: Create and validateDp Analytics and DF Analytics and HTTPS Flood Report2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report2"
      | Template-1            | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true                      |
      | Template-2            | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO Name Space],showTable:true           |
      | Template-3            | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
      | Logo                  | reportLogoPNG.png                                                                                                         |
      | Time Definitions.Date | Quick:1D                                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                      |
      | Format                | Select: PDF                                                                                                               |
    Then UI "Validate" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report2"
      | Template-1            | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true                      |
      | Template-2            | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO Name Space],showTable:true           |
      | Template-3            | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
      | Logo                  | reportLogoPNG.png                                                                                                         |
      | Time Definitions.Date | Quick:1D                                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                      |
      | Format                | Select: PDF                                                                                                               |

  @SID_14
  Scenario: Edit Dp Analytics and DF Analytics and HTTPS Flood Report2 report name
    Then UI Click Button "My Report Tab"
    Then UI Click Button "Edit Report" with value "Dp Analytics and DF Analytics and HTTPS Flood Report2"
    Then UI Set Text Field "Report Name" To "Dp Analytics and DF Analytics and HTTPS Flood Report"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable To Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'Dp Analytics and DF Analytics and HTTPS Flood Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Dp Analytics and DF Analytics and HTTPS Flood Report"?"
    Then UI Click Button "Yes"
    Then UI Text of "Error message title" equal to "Unable To Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'Dp Analytics and DF Analytics and HTTPS Flood Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Dp Analytics and DF Analytics and HTTPS Flood Report"?"
    Then UI Click Button "No"

  @SID_15
  Scenario: Delete report
    Then UI Delete Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
    Then UI Delete Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report2"

  @SID_16
  Scenario: Logout
    Then UI logout and close browser
