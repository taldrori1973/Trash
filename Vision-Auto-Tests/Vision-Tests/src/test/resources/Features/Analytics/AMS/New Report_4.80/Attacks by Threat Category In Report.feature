@TC122310
Feature: Attacks by Threat Category In Report

  @SID_1
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    Given CLI Reset radware password
    * REST Delete ES index "dp-*"
    Given CLI Run remote linux Command "service vision restart" on "ROOT_SERVER_CLI" and halt 185 seconds

  @SID_2
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." Retry 240 seconds

  @SID_3
  Scenario: Clear Database and old reports on file-system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario: Run DP simulator PCAPs for "many_attacks"
    Given CLI simulate 1 attacks of type "many_attacks" on "DefensePro" 10 and wait 250 seconds

  @SID_5
  Scenario: VRM - enabling emailing and go to VRM Reports Tab
    Given UI Login with user "radware" and password "radware"
    Given Setup email server
#    Then UI Login with user "radware" and password "radware"
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

  @SID_6
  Scenario: Clear SMTP server log files in first step
    Given Clear email history for user "setup"

  @SID_7
  Scenario: Navigate
    Then UI Navigate to "AMS REPORTS" page via homepage

  @SID_8
  Scenario: create new Attacks by Threat Category Report with Summary Table
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Threat Category Report with Summary Table"
      | Template | reportType:DefensePro Analytics,Widgets:[Attacks by Threat Category],devices:[All],showTable:true |
      | Format   | Select: PDF                                                                                       |
    Then UI "Validate" Report With Name "Attacks by Threat Category Report with Summary Table"
      | Template | reportType:DefensePro Analytics,Widgets:[Attacks by Threat Category],devices:[All],showTable:true |
      | Format   | Select: PDF                                                                                       |

  @SID_9
  Scenario: Validate delivery card and generate report: Attacks by Threat Category Report with Summary Table
    Then UI Click Button "My Report" with value "Attacks by Threat Category Report with Summary Table"
    Then UI Click Button "Generate Report Manually" with value "Attacks by Threat Category Report with Summary Table"
    Then Sleep "35"

  @SID_10
  Scenario: Show Attacks by Threat Category Report with Summary Table after the create
    Then UI Click Button "Log Preview" with value "Attacks by Threat Category Report with Summary Table_0"
    Then UI Text of "Total Summary Table" equal to "Total (for all categories): 23"

  @SID_11
  Scenario: Edit share email in  Attacks by Threat Category Report with Summary Table
    Then UI Click Button "New Report Tab"
    Given UI "Edit" Report With Name "Attacks by Threat Category Report with Summary Table"
      | Share | Email:[maha],Subject:Validate Email,Body:Email Body |
    Then UI "Validate" Report With Name "Attacks by Threat Category Report with Summary Table"
      | Share | Email:[maha],Subject:Validate Email,Body:Email Body |

  @SID_12
  Scenario: Validate delivery card and generate report after edit share email
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"

  @SID_13
  Scenario: Show Attacks by Threat Category Report with Summary Table after edit share email
    Then UI Click Button "Log Preview" with value "Attacks by Threat Category Report with Summary Table_0"
    Then UI Text of "Total Summary Table" equal to "Total (for all categories): 23"

  @SID_14
  Scenario: Validate Report Email received content after edit share email
    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@Radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: maha@.*.local"" EQUALS "1"
    #Attachment
    Then Validate "setup" user eMail expression "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).pdf"" EQUALS "1"

  @SID_15
  Scenario: Clear SMTP server log files after edit share email
    Given Clear email history for user "setup"

  @SID_16
  Scenario: Edit format Attacks by Threat Category  Report with Summary Table
    Then UI Click Button "New Report Tab"
    Given UI "Edit" Report With Name "Attacks by Threat Category Report with Summary Table"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "Attacks by Threat Category Report with Summary Table"
      | Format | Select: HTML |

  @SID_17
  Scenario: Validate delivery card and generate report: Attacks by Threat Category Report with Summary Table after edit format
    Then UI Click Button "My Report" with value "Attacks by Threat Category Report with Summary Table"
    Then UI Click Button "Generate Report Manually" with value "Attacks by Threat Category Report with Summary Table"
    Then Sleep "35"

  @SID_18
  Scenario: Show Attacks by Threat Category Report with Summary Table after edit format
    Then UI Click Button "Log Preview" with value "Attacks by Threat Category Report with Summary Table_0"
    Then UI Text of "Total Summary Table" equal to "Total (for all categories): 23"

  @SID_19
  Scenario: Edit share email to html format Attacks by Threat Category
    Then UI Click Button "New Report Tab"
    Given UI "Edit" Report With Name "Attacks by Threat Category Report with Summary Table"
      | Share | Email:[maha],Subject:Validate Email,Body:Email Body |
    Then UI "Validate" Report With Name "Attacks by Threat Category Report with Summary Table"
      | Share | Email:[maha],Subject:Validate Email,Body:Email Body |

  @SID_20
  Scenario: Validate delivery card and generate report  after edit format and share
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"

  @SID_21
  Scenario: Show Attacks by Threat Category Report with Summary Table  after edit format and share
    Then UI Click Button "Log Preview" with value "Attacks by Threat Category Report with Summary Table_0"
    Then UI Text of "Total Summary Table" equal to "Total (for all categories): 23"

  @SID_22
  Scenario: Validate Report Email received content  after edit format and share
    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@Radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: maha@.*.local"" EQUALS "1"
    #Attachment
    Then Validate "setup" user eMail expression "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).html"" EQUALS "1"

  @SID_23
  Scenario: Clear SMTP server log files  after edit format and share
    Given Clear email history for user "setup"

  @SID_24
  Scenario: Delete report Attacks by Threat Category Report with Summary Table
    Then UI Delete Report With Name "Attacks by Threat Category Report with Summary Table"

  @SID_25
  Scenario: create new Attacks by Threat Category without summary table
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Attacks by Threat Category Report without Summary Table"
      | Template | reportType:DefensePro Analytics,Widgets:[Attacks by Threat Category],devices:[All],showTable:false|
      | Format   | Select: PDF                                                                                       |
    Then UI "Validate" Report With Name "Attacks by Threat Category Report without Summary Table"
      | Template | reportType:DefensePro Analytics,Widgets:[Attacks by Threat Category],devices:[All],showTable:false|
      | Format   | Select: PDF                                                                                       |

  @SID_26
  Scenario: Validate delivery card and generate report: Attacks by Threat Category Report without Summary Table
    Then UI Click Button "My Report" with value "Attacks by Threat Category Report without Summary Table"
    Then UI Click Button "Generate Report Manually" with value "Attacks by Threat Category Report without Summary Table"
    Then Sleep "35"

  @SID_27
  Scenario: Show Attacks by Threat Category Report without Summary Table
    Then UI Click Button "Log Preview" with value "Attacks by Threat Category Report without Summary Table_0"
    Then UI Validate Element Existence By Label "Total Summary Table" if Exists "false"

  @SID_28
  Scenario: Edit format to html in Attacks by Threat Category without summary table
    Then UI Click Button "New Report Tab"
    Given UI "Edit" Report With Name "Attacks by Threat Category Report without Summary Table"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "Attacks by Threat Category Report without Summary Table"
      | Format | Select: HTML |

  @SID_29
  Scenario: Validate delivery card and generate report: Attacks by Threat Category Report without Summary Table after edit html format
    Then UI Click Button "My Report" with value "Attacks by Threat Category Report without Summary Table"
    Then UI Click Button "Generate Report Manually" with value "Attacks by Threat Category Report without Summary Table"
    Then Sleep "35"

  @SID_30
  Scenario: Show Attacks by Threat Category Report without Summary Table after edit html format
    Then UI Click Button "Log Preview" with value "Attacks by Threat Category Report without Summary Table_0"
    Then UI Validate Element Existence By Label "Total Summary Table" if Exists "false"

  @SID_31
  Scenario: Delete report Attacks by Threat Category Report without Summary Table
    Then UI Delete Report With Name "Attacks by Threat Category Report with Summary Table"

  @SID_32
  Scenario: Logout and close browser
    Given UI logout and close browser