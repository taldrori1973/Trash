@TC117967
Feature: Negative test to validate Error Messages
  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: Create New Report Empty
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Invalid configuration. Specify a name for the Report."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"

  @SID_3
  Scenario: Create New Report without Templates
    Then UI Click Button "New Report Tab"
    Then UI Set Text Field "Report Name" To "Report without templates"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Invalid configuration. Specify a template for the Report."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report without templates"?"
    Then UI Click Button "Yes"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Invalid configuration. Specify a template for the Report."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report without templates"?"
    Then UI Click Button "No"

  @SID_4
  Scenario: Create New Report with Report Name invalid
    Then UI Click Button "New Report Tab"
    Then UI Set Text Field "Report Name" To ","
    Then UI Click Button "Add Template" with value "HTTPS Flood"
    Then UI Click Button "Open Scope Selection" with value "HTTPS Flood"
    Then UI Click Button "httpsScopeRadio" with value "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https"
    Then UI Click Button "SaveHTTPSScopeSelection"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "The Report name contains special characters. Remove the special characters."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save ","?"
    Then UI Click Button "No"

  @SID_5
  Scenario: Create New Report with Report with more than 50 Widgets without policy and port
    Then UI Click Button "New Report Tab"
    Then UI Set Text Field "Report Name" To "Report with more than 50 Widgets without device and policy and port"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "The Report Template requires the selection of a single device and policy."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report with more than 50 Widgets without device and policy and port"?"
    Then UI Click Button "No"

  @SID_6
  Scenario: Create New Report with Report with more than 50 Widgets without policy and port
    Then UI Click Button "New Report Tab"
    Then UI Set Text Field "Report Name" To "Report with more than 50 Widgets without policy and port"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "The Report Template requires the selection of a single device and policy."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report with more than 50 Widgets without policy and port"?"
    Then UI Click Button "No"

  @SID_7
  Scenario: Create New Report with Report with more than 50 Widgets without port
    Then UI Click Button "New Report Tab"
    Then UI Set Text Field "Report Name" To "Report with more than 50 Widgets without port"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "The Report Template requires the selection of a single device and policy."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report with more than 50 Widgets without port"?"
    Then UI Click Button "No"

  @SID_8
  Scenario: Create New Report with Report with more than 50 Widgets
    Then UI Click Button "New Report Tab"
    Then UI Set Text Field "Report Name" To "Report with more than 50 Widgets"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "Scope Selection"
    Then UI Click Button "AllScopeSelection"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,BDOS"
    Then UI Click Button "SaveDPScopeSelection"
    Then UI Click Button "Add Template" with value "HTTPS Flood"
    Then UI Click Button "Open Scope Selection" with value "HTTPS Flood"
    Then UI Click Button "httpsScopeRadio" with value "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https"
    Then UI Click Button "SaveHTTPSScopeSelection"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "The Report configuration contains too many widgets. A Report can contain no more than 200 widgets. The current configuration contains 201 widgets. Remove at least 1 widgets from the Report configuration and try again."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report with more than 50 Widgets"?"
    Then UI Click Button "No"

  @SID_9
  Scenario: Create New Report with invalid Email
    Then UI Click Button "New Report Tab"
    Then UI Set Text Field "Report Name" To "Report with invalid Email"
    Then UI Set Text Field "Email" To "invalidEmail"
    Then UI Click Button "Add Template" with value "DefensePro Behavioral Protections"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "The Share configuration of the Report is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "Report with invalid Email"?"
    Then UI Click Button "No"

  @SID_10
  Scenario: Create two reports with same name
    Given UI "Create" Report With Name "Duplicate Report"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                              |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                               |
      | Format                | Select: CSV                                                                                    |

    Given UI "Validate" Report With Name "Duplicate Report"
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                              |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                               |
      | Format                | Select: CSV                                                                                    |

    Given UI "Create" Report With Name "Duplicate Report" negative
      | Template              | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                              |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                               |
      | Format                | Select: CSV                                                                                    |

    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'Duplicate Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"

    Then UI Text of "Save Change Message" contains "Do you want to save "Duplicate Report"?"
    Then UI Click Button "No"

    Then UI Click Button "My Reports Tab"
    Then UI Delete Report With Name "Duplicate Report"

  @SID_11
  Scenario: Logout
    Then UI logout and close browser
