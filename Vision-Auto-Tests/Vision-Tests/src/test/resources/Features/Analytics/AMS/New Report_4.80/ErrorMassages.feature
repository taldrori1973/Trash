Feature: Error Massages

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: Create New Report without Report Name
    Given UI "Create" Report With Name ""
#    no data-debug-id
    Then UI Text of "Error message title" contains "Unable To Save Report"
    #    no data-debug-id
    Then UI Text of "Error message description" contains "Invalid configuration. Specify a name for the Report."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"


  @SID_3
  Scenario: Create New Report without Templates
    Given UI "Create" Report With Name "Report without templates"
      | Time Definitions.Date | Quick: 1H                                    |
      | Schedule              | Run Every:Monthly, On Time:+2m               |
      | Share                 | Email:[Test, Test2],Subject:TC108070 Subject |
      | Format                | Select: CSV
    Then UI Text of "Error message title" contains "Unable To Save Report"
    Then UI Text of "Error message description" contains "Invalid configuration. Specify a template for the Report."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report without templates"?"
    Then UI Click Button "Yes"
    Then UI Text of "Error message title" contains "Unable To Save Report"
    Then UI Text of "Error message description" contains "Invalid configuration. Specify a template for the Report."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report without templates"?"
    Then UI Click Button "No"

  @SID_4
  Scenario: Create New Report with Report Name invalid
    Given UI "Create" Report With Name ","
      | Template-1 | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}]  ,devices:[{deviceIndex:11,devicePorts:[1],devicePolicies:[BDOS,1_https]},{deviceIndex:10} ] |
    Then UI Text of "Error message title" contains "Unable To Save Report"
    Then UI Text of "Error message description" contains "Report name contains special characters."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save ","?"
    Then UI Click Button "No"

  @SID_5
  Scenario: Create New Report with Report with more than 50 Widgets
    Given UI "Create" Report With Name "Report with more than 50 Widgets"
      | Template-1 | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[server3-DefensePro_172.16.22.51-https_policy7] |
      | Template-2 | reportType:DefensePro Behavioral Protections , Widgets:[All] , devices:[All]                             |
      | Template-3 | reportType:DefensePro Behavioral Protections , Widgets:[All] , devices:[All]                             |
      | Template-4 | reportType:DefensePro Behavioral Protections , Widgets:[All] , devices:[All]                             |
    Then UI Text of "Error message title" contains "Unable To Save Report"
    Then UI Text of "Error message description" contains "The Report configuration contains too many widgets. A Report can contain no more than 50 widgets. The current configuration contains 51 widgets. Remove at least 1 widgets from the Report configuration and try again."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report with more than 50 Widgets"?"
    Then UI Click Button "No"

  @SID_6
  Scenario: Create New Report with an Error share Email To
    Given UI "Create" Report With Name "Report with an Error share Email To"
      | Time Definitions.Date | Quick: 1H                                                                                         |
      | Share                 | Email:[Test],Subject:TC108070 Subject                                                             |
      | Format                | Select: CSV                                                                                       |
      | Template-1            | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}]  ,devices:[All] |
    Then UI Text of "Error message title" contains "Unable To Save Report"
    Then UI Text of "Error message description" contains "The Share configuration of the Report is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report with an Error share Email To"?"
    Then UI Click Button "No"

#    delete all widgets - ramez
  #todo!!!!!!!!!!!!!!!!
  @SID_7
  Scenario: Create New Report Report without Widgets
    Given UI "Create" Report With Name "Report without Widgets"
      | Time Definitions.Date | Quick: 1H                                                                    |
      | Share                 | Email:[Test],Subject:TC108070 Subject                                        |
      | Format                | Select: CSV                                                                  |
      | Template-2            | reportType:DefensePro Behavioral Protections , Widgets:[All] , devices:[All] |
#    delete all the widgets
    Then UI Text of "Error message title" contains "Unable To Save Report"
    Then UI Text of "Error message description" contains "Invalid configuration. Specify a widget for the Report Template."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report with an Error share Email To"?"
    Then UI Click Button "No"