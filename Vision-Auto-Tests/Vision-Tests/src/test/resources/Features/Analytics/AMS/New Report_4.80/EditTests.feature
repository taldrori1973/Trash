@TC118580
Feature: Edit AMS Report tests

  @SID_1
  Scenario: Login and Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: Create and validate Dp Analytics and DF Analytics and HTTPS Flood Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-1            | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true                                                                                                                                                                 |
      | Template-2            | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, bps, inbound]}, {BDoS-UDP:[IPv4, bps, inbound]}, {BDoS-UDP Fragmented:[IPv4, bps, inbound]}, {DNS-TXT:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Template-3            | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO Name Space],showTable:true                                                                                                                                                      |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                    |
      | Time Definitions.Date | Quick:1D                                                                                                                                                                                                                                                             |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                                                                                                                                                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                                                                                                                                                 |
      | Format                | Select: PDF                                                                                                                                                                                                                                                          |
    Then UI "Validate" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-1            | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true                                                                                                                                                                 |
      | Template-2            | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, bps, inbound]}, {BDoS-UDP:[IPv4, bps, inbound]}, {BDoS-UDP Fragmented:[IPv4, bps, inbound]}, {DNS-TXT:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Template-3            | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO Name Space],showTable:true                                                                                                                                                      |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                                                                                                    |
      | Time Definitions.Date | Quick:1D                                                                                                                                                                                                                                                             |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                                                                                                                                                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                                                                                                                                                 |
      | Format                | Select: PDF                                                                                                                                                                                                                                                          |


  @SID_3
  Scenario: Add Template Widget to Dp Analytics and DF Analytics and HTTPS Flood Report
    Given UI "Edit" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-3 | reportType:DefenseFlow Analytics,AddWidgets:[Top Attack Destination],Protected Objects:[PO Name Space],showTable:true |
    Then UI "Validate" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-3 | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate,Top Attack Destination],Protected Objects:[PO Name Space],showTable:true |

  @SID_4
  Scenario: Delete Template Widget from Dp Analytics and DF Analytics and HTTPS Flood Report
    Given UI "Edit" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-3 | reportType:DefenseFlow Analytics,DeleteWidgets:[Top Attack Destination],Protected Objects:[PO Name Space],showTable:true |
    Then UI "Validate" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-3 | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO Name Space],showTable:true |


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
      | Template-1 | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:11}],showTable:true                                                                                                                                                                 |
      | Template-2 | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, bps, inbound]}, {BDoS-UDP:[IPv4, bps, inbound]}, {BDoS-UDP Fragmented:[IPv4, bps, inbound]}, {DNS-TXT:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Template-3 | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO Name Space],showTable:true                                                                                                                                                      |
      | Template-4 | reportType:DefensePro Analytics,Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}],devices:[{deviceIndex:11}],showTable:true                                                                                                                                            |

  @SID_7
  Scenario: Delete Template from Dp Analytics and DF Analytics and HTTPS Flood Report
    Given UI "Edit" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-4 | DeleteTemplate:true |
    Then UI "Validate" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report"
      | Template-1 | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:11}],showTable:true                                                                                                                                                                 |
      | Template-2 | reportType:DefensePro Behavioral Protections, Widgets:[{BDoS-TCP FIN ACK:[IPv4, bps, inbound]}, {BDoS-UDP:[IPv4, bps, inbound]}, {BDoS-UDP Fragmented:[IPv4, bps, inbound]}, {DNS-TXT:[IPv4]}, {DNS-AAAA:[IPv4]}], devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Template-3 | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO Name Space],showTable:true                                                                                                                                                      |

  @SID_8
  Scenario: Create and validate Dp Analytics and DF Analytics and HTTPS Flood Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report2"
      | Template-1            | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true            |
      | Template-2            | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO Name Space],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                               |
      | Time Definitions.Date | Quick:1D                                                                                                        |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                    |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                            |
      | Format                | Select: PDF                                                                                                     |
    Then UI "Validate" Report With Name "Dp Analytics and DF Analytics and HTTPS Flood Report2"
      | Template-1            | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true            |
      | Template-2            | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO Name Space],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                               |
      | Time Definitions.Date | Quick:1D                                                                                                        |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                    |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                            |
      | Format                | Select: PDF                                                                                                     |

  @SID_9
  Scenario: Edit Dp Analytics and DF Analytics and HTTPS Flood Report2 report name
    Then UI Click Button "My Report Tab"
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
