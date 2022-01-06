@TC124357
Feature: Flow Statistics In DF Analytics and Reports

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "df-*"
    * REST Delete ES index "df-traffic*"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    * CLI Clear vision logs
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"

  @SID_2
  Scenario: Change DF management IP to IP of Generic Linux
    When CLI Operations - Run Radware Session command "system df management-ip set 172.17.164.10"
    When CLI Operations - Run Radware Session command "system df management-ip get"
    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 172.17.164.10"

  @SID_3
  Scenario: Generate DefenseFlow traffic events
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER" and wait 120 seconds and wait for prompt "False"
      | "nohup /home/radware/curl_DF_traffic_auto2.sh " |
      | #visionIP                                       |
      | " PO_101 20"                                    |

  @SID_4
  Scenario: VRM - Login to AMS DefenseFlow Analytics Dashboard
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Go To Vision
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->AMS Analytics"
    Then UI Select "24H" from Vision dropdown by Id "gwt-debug-amsShortTermQueryWindow_Widget-input"
    Then UI Click Button "Submit"
    Then UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"
    Then UI Do Operation "select" item "Email Reporting Configuration"
    Then UI Set Checkbox "Enable" To "true"
    Then UI Set Text Field "SMTP User Name" To "qa_test@Radware.com"
    Then UI Set Text Field "Subject Header" To "Alert Notification Message"
    Then UI Set Text Field "From Header" To "Automation system"
    Then UI Set Checkbox "Enable" To "false"
    Then UI Click Button "Submit"
    And UI Navigate to "AMS Reports" page via homePage
    And UI Go To Vision
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
    And UI Set Checkbox "Enable" To "true"
    And UI Set Text Field "SMTP Server Address" To "172.17.164.10"
    And UI Set Text Field "SMTP Port" To "25"
    And UI Click Button "Submit"
    Given Clear email history for user "setup"
    And UI Navigate to "AMS Reports" page via homePage
############################### tests for Reports ###############################

  @SID_5
  Scenario: create new Report intro_executive summary
    Given UI "Create" Report With Name "Flow statistics Report"
      | Template-1 | reportType:DefenseFlow Analytics , Widgets:[Flow Statistics]  ,Protected Objects:[All] |
      | Format     | Select: PDF                                                                            |
      | Share      | Email:[maha],Subject:Validate Email,Body:Email Body                                    |
    Then UI "Validate" Report With Name "Flow statistics Report"
      | Template-1 | reportType:DefenseFlow Analytics , Widgets:[Flow Statistics]  ,Protected Objects:[All] |
      | Format     | Select: PDF                                                                            |
      | Share      | Email:[maha],Subject:Validate Email,Body:Email Body                                    |
    Then UI "Generate" Report With Name "Flow statistics Report"
      | timeOut | 60 |

  @SID_6
  Scenario: Validate share Email PDF format
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
    Given Clear email history for user "setup"

  @SID_7
  Scenario: Edit report to HTML format
    Then UI "Edit" Report With Name "Flow statistics Report"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "Flow statistics Report"
      | Format | Select: HTML |
    Then UI "Generate" Report With Name "Flow statistics Report"
      | timeOut | 60 |

  @SID_8
  Scenario: Validate share Email HTML format
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
    Given Clear email history for user "setup"

  @SID_9
  Scenario: Edit report to CSV format
    Then UI "Edit" Report With Name "Flow statistics Report"
      | Format | Select: CSV |
    Then UI "Validate" Report With Name "Flow statistics Report"
      | Format | Select: CSV |
    Then UI "Generate" Report With Name "Flow statistics Report"
      | timeOut | 60 |

  @SID_10
  Scenario: Validate share Email CSV format
    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@Radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: maha@.*.local"" EQUALS "1"
    #Attachment
    Then Validate "setup" user eMail expression "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).zip"" EQUALS "1"
    Given Clear email history for user "setup"
    Then UI Delete Report With Name "Flow statistics Report"


  @SID_5
  Scenario: Show only Flow Statistics Chart in DF Analytics
    And UI Navigate to "DefenseFlow Analytics Dashboard" page via homePage
    Then UI Click Button "Widget Selection"
    Then UI Click Button "Widget Selection.Clear Dashboard"
    Then UI Click Button "Widget Selection.Remove All Confirm"
    Then UI Click Button "New Widget" with value "Flow_Statistics"
    Then UI Click Button "Widget Selection.Add Selected Widgets"
    Then UI Click Button "Widget Selection"


  @SID_6
  Scenario: Check disable checkbox with no data in chart
    Then UI Click Button "Attribute CheckBox" with value "0Inbound"
    Then UI Click Button "Attribute CheckBox" with value "1Inbound Dropped"
    Then UI Click Button "Attribute CheckBox" with value "2Outbound"
    Then UI Click Button "Attribute CheckBox" with value "3Outbound Dropped"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "0Inbound" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "1Inbound Dropped" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "2Outbound" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "3Outbound Dropped" is "EQUALS" to "false"


  @SID_7
  Scenario: Check enable checkbox with no data in chart
    Then UI Click Button "Attribute CheckBox" with value "0Inbound"
    Then UI Click Button "Attribute CheckBox" with value "1Inbound Dropped"
    Then UI Click Button "Attribute CheckBox" with value "2Outbound"
    Then UI Click Button "Attribute CheckBox" with value "3Outbound Dropped"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "0Inbound" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "1Inbound Dropped" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "2Outbound" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "3Outbound Dropped" is "EQUALS" to "true"


  @SID_20
  Scenario: Validate traffic bandwidth all DP Only
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Inbound" Equals to "3840.0"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Inbound Dropped" Equals to "1920"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Outbound" Equals to "768"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Outbound Dropped" Equals to "384"


  @SID_9
  Scenario: Validate Flow Statistics Chart data in 15 min time range with Pps tab
    Then UI Click Button "Switch Tab" with value "pps"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Inbound" Equals to "160000"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Inbound Dropped" Equals to "80000"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Outbound" Equals to "32000"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Outbound Dropped" Equals to "16000"
    Then UI Click Button "Switch Tab" with value "bps"


  @SID_10
  Scenario: Validate Flow Statistics Chart data in 30 min time range with BBS tab
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "30m"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Inbound" Equals to "3840.0"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Inbound Dropped" Equals to "1920"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Outbound" Equals to "768"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Outbound Dropped" Equals to "384"



  @SID_11
  Scenario: Validate Flow Statistics Chart data in 30 min time range with PPS tab
    Then UI Click Button "Switch Tab" with value "pps"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Inbound" Equals to "160000"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Inbound Dropped" Equals to "80000"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Outbound" Equals to "32000"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Outbound Dropped" Equals to "16000"
    Then UI Click Button "Switch Tab" with value "bps"


  @SID_12
  Scenario: Validate Flow Statistics Chart data in 6 hours time range with BBS tab
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "6H"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Inbound" Equals to "3840.0"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Inbound Dropped" Equals to "1920"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Outbound" Equals to "768"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Outbound Dropped" Equals to "384"


  @SID_11
  Scenario: Validate Flow Statistics Chart data in 6 hours time range with PPS tab
    Then UI Click Button "Switch Tab" with value "pps"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Inbound" Equals to "160000"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Inbound Dropped" Equals to "80000"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Outbound" Equals to "32000"
    Then UI Validate Sum Of Line Chart data "netFlow-chart" with Label "Outbound Dropped" Equals to "16000"


  @SID_12
  Scenario: Change DF management IP to IP of DefenseFlow
    When CLI Run remote linux Command on "RADWARE_SERVER_CLI"
      | "system df management-ip set " |
      | #dfIP                          |

  @SID_13
  Scenario: Cleanup
    Then UI logout and close browser