@TC118580
Feature: Edit AMS Report tests
  @SID_1
  Scenario: Login and Navigate to NEW REPORTS page
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
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


  @SID_3
  Scenario: Add Template Widget to Dp Analytics and DF Analytics and HTTPS Flood Report
    Given UI "Edit" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-3 | reportType:HTTPS Flood,AddWidgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
    Then UI "Validate" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-3 | reportType:HTTPS Flood,Widgets:[Inbound Traffic,Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |

  @SID_4
  Scenario: Delete Template Widget from Dp Analytics and DF Analytics and HTTPS Flood Report
    Given UI "Edit" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-3 | reportType:HTTPS Flood,DeleteWidgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
    Then UI "Validate" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-3 | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |


  @SID_5
  Scenario: Edit Template Devices from Dp Analytics and DF Analytics and HTTPS Flood Report
    Given UI "Edit" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-1 | reportType:DefensePro Analytics,devices:[{deviceIndex:11}] |
    Then UI "Validate" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-1 | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:11}],showTable:true |


  @SID_6
  Scenario:Add Template to Dp Analytics and DF Analytics and HTTPS Flood Report
    Given UI "Edit" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-4 | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}],devices:[{deviceIndex:11}],showTable:true |
    Then UI "Validate" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-1 | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:11}],showTable:true |
      | Template-2            | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO Name Space],showTable:true           |
      | Template-3            | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
      | Template-4 | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}],devices:[{deviceIndex:11}],showTable:true |

  @SID_7
  Scenario: Delete Template from Dp Analytics and DF Analytics and HTTPS Flood Report
    Given UI "Edit" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-4 | DeleteTemplate:true |
    Then UI "Validate" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-1 | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:11}],showTable:true |
      | Template-2            | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO Name Space],showTable:true           |
      | Template-3            | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |

  @SID_8
  Scenario: Create and validate Dp Analytics and DF Analytics and HTTPS Flood Report
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

  @SID_9
  Scenario: Edit Dp Analytics and DF Analytics and HTTPS Flood Report2 report name
    Then UI Click Button "My Reports Tab"
    Then UI Click Button "Edit Report" with value "Dp Analytics and DF Analytics and HTTPS Flood Report2"
    Then UI Set Text Field "Report Name" To "Dp Analytics and DF Analytics and HTTPS Flood Report"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'Dp Analytics and DF Analytics and HTTPS Flood Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Dp Analytics and DF Analytics and HTTPS Flood Report"?"
    Then UI Click Button "Yes"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'Dp Analytics and DF Analytics and HTTPS Flood Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Dp Analytics and DF Analytics and HTTPS Flood Report"?"
    Then UI Click Button "No"

  @SID_10
  Scenario: Delete report
    Then UI Delete Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
    Then UI Delete Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report2"

  @SID_11
  Scenario: Logout
    Then UI logout and close browser
