@TC118847
Feature: Validate Email

  @SID_1
  Scenario: VRM - enabling emailing and go to VRM Reports Tab
    Given Setup email server
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Go To Vision
    Then UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"
    Then UI Do Operation "select" item "Email Reporting Configuration"
    Then UI Set Checkbox "Enable" To "true"
    Then UI Set Text Field "SMTP User Name" To "qa_test@Radware.com"
    Then UI Set Text Field "Subject Header" To "Alert Notification Message"
    Then UI Set Text Field "From Header" To "Automation system"
    Then UI Set Checkbox "Enable" To "false"
    Then UI Click Button "Submit"
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
    And UI Set Checkbox "Enable" To "true"
    And UI Set Text Field "SMTP Server Address" To "172.17.164.10"
    And UI Set Text Field "SMTP Port" To "25"
    And UI Click Button "Submit"
    And UI Navigate to "AMS Reports" page via homePage

  @SID_2
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_3
  Scenario: Create and Validate HTTPS Flood Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DefensePro Analytics Report"
      | Template | reportType:DefensePro Analytics , Widgets:[Connections Rate]  ,devices:[All] |
      | Share    | Email:[maha],Subject:Validate Email,Body:Email Body                          |
      | Format   | Select: PDF                                                                  |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Template | reportType:DefensePro Analytics , Widgets:[Connections Rate]  ,devices:[All] |
      | Share    | Email:[maha],Subject:Validate Email,Body:Email Body                          |
      | Format   | Select: PDF                                                                  |

  @SID_4
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"

  @SID_5
  Scenario: Validate Report Email received content
    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Body: Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@Radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: maha@.*.local"" EQUALS "1"
    #Attachment
    Then Validate "setup" user eMail expression "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).zip"" EQUALS "2"

  @SID_6
  Scenario: Delete report
    Then UI Delete Report With Name "DefensePro Analytics Report"

  @SID_7
  Scenario: Logout
    Then UI logout and close browser
