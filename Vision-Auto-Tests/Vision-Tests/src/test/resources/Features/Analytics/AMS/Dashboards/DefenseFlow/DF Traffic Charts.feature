@TC124351
Feature: Traffic Bandwidth \Traffic Rate Charts

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
    Given Clear email history for user "setup"
    And UI Navigate to "AMS Reports" page via homePage

############################### tests for Reports ###############################

  @SID_5
  Scenario: create new Report intro_executive summary
    Given UI "Create" Report With Name "Traffic widgets Report"
      | Template-1       | reportType:DefenseFlow Analytics , Widgets:[Traffic Bandwidth (DefensePro Only),Traffic Rate (DefensePro Only),Traffic Bandwidth,Traffic Rate]  ,Protected Objects:[All]                                                                                        |
      | Format           | Select: PDF                                                                                                                                            |
      | Share            | Email:[maha],Subject:Validate Email,Body:Email Body                                                                                                    |
    Then UI "Validate" Report With Name "Traffic widgets Report"
      | Template-1       | reportType:DefenseFlow Analytics , Widgets:[Traffic Bandwidth (DefensePro Only),Traffic Rate (DefensePro Only),Traffic Bandwidth,Traffic Rate]  ,Protected Objects:[All]                                                                                        |
      | Format           | Select: PDF                                                                                                                                            |
      | Share            | Email:[maha],Subject:Validate Email,Body:Email Body                                                                                                    |
    Then UI "Generate" Report With Name "Traffic widgets Report"
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
    Then UI "Edit" Report With Name "Traffic widgets Report"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "Traffic widgets Report"
      | Format | Select: HTML |
    Then UI "Generate" Report With Name "Traffic widgets Report"
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
    Then UI "Edit" Report With Name "Traffic widgets Report"
      | Format | Select: CSV |
    Then UI "Validate" Report With Name "Traffic widgets Report"
      | Format | Select: CSV |
    Then UI "Generate" Report With Name "Traffic widgets Report"
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
    Then UI Delete Report With Name "Traffic widgets Report"

############################### tests for AMS DF Analytics Dashboard ###############################

  @SID_11
  Scenario:Navigate to DF Analytics and Show only Flow Statistics Chart in DF Analytics
    And UI Navigate to "DefenseFlow Analytics Dashboard" page via homePage
    Then UI Click Button "Widget Selection"
    Then UI Click Button "Widget Selection.Clear Dashboard"
    Then UI Click Button "Widget Selection.Remove All Confirm"
    Then UI Click Button "New Widget" with value "Traffic_Rate"
    Then UI Click Button "Widget Selection.Add Selected Widgets"
    Then UI Click Button "Widget Selection"

  @SID_12
  Scenario: Validate traffic rate all pps
    Then UI Validate Sum Of Line Chart data "df-traffic-rate-chart" with Label "Inbound" Equals to "14018660"
    Then UI Validate Sum Of Line Chart data "df-traffic-rate-chart" with Label "Discarded Inbound" Equals to "640000.0"
    Then UI Validate Sum Of Line Chart data "df-traffic-rate-chart" with Label "Clean" Equals to "2186000.0"
    Then UI Validate Sum Of Line Chart data "df-traffic-rate-chart" with Label "Diverted" Equals to "8500000.0"


  @SID_13
  Scenario: Check disable checkbox with no data in chart
    Then UI Click Button "Attribute CheckBox" with value "0Inbound"
    Then UI Click Button "Attribute CheckBox" with value "1Discarded Inbound"
    Then UI Click Button "Attribute CheckBox" with value "2Clean"
    Then UI Click Button "Attribute CheckBox" with value "3Diverted"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "0Inbound" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "1Discarded Inbound" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "2Clean" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "3Diverted" is "EQUALS" to "false"


  @SID_14
  Scenario: Check disable checkbox with no data in chart
    Then UI Click Button "Attribute CheckBox" with value "0Inbound"
    Then UI Click Button "Attribute CheckBox" with value "1Discarded Inbound"
    Then UI Click Button "Attribute CheckBox" with value "2Clean"
    Then UI Click Button "Attribute CheckBox" with value "3Diverted"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "0Inbound" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "1Discarded Inbound" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "2Clean" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "3Diverted" is "EQUALS" to "true"


  @SID_15
  Scenario: Show only Flow Statistics Chart in DF Analytics
    Then UI Click Button "Widget Selection"
    Then UI Click Button "Widget Selection.Clear Dashboard"
    Then UI Click Button "Widget Selection.Remove All Confirm"
    Then UI Click Button "New Widget" with value "Traffic_Bandwidth"
    Then UI Click Button "Widget Selection.Add Selected Widgets"
    Then UI Click Button "Widget Selection"


  @SID_16
  Scenario: Validate traffic bandwidth all bps
    Then UI Validate Sum Of Line Chart data "df-traffic-bandwidth-chart" with Label "Inbound" Equals to "161664.0"
    Then UI Validate Sum Of Line Chart data "df-traffic-bandwidth-chart" with Label "Discarded Inbound" Equals to "40480.0"
    Then UI Validate Sum Of Line Chart data "df-traffic-bandwidth-chart" with Label "Clean" Equals to "16304.0"
    Then UI Validate Sum Of Line Chart data "df-traffic-bandwidth-chart" with Label "Diverted" Equals to "32400.0"

  @SID_17
  Scenario: Check disable checkbox with no data in chart
    Then UI Click Button "Attribute CheckBox" with value "0Inbound"
    Then UI Click Button "Attribute CheckBox" with value "1Discarded Inbound"
    Then UI Click Button "Attribute CheckBox" with value "2Clean"
    Then UI Click Button "Attribute CheckBox" with value "3Diverted"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "0Inbound" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "1Discarded Inbound" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "2Clean" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "3Diverted" is "EQUALS" to "false"


  @SID_18
  Scenario: Check disable checkbox with no data in chart
    Then UI Click Button "Attribute CheckBox" with value "0Inbound"
    Then UI Click Button "Attribute CheckBox" with value "1Discarded Inbound"
    Then UI Click Button "Attribute CheckBox" with value "2Clean"
    Then UI Click Button "Attribute CheckBox" with value "3Diverted"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "0Inbound" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "1Discarded Inbound" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "2Clean" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "3Diverted" is "EQUALS" to "true"



  @SID_19
  Scenario: Show only Flow Statistics Chart in DF Analytics
    Then UI Click Button "Widget Selection"
    Then UI Click Button "Widget Selection.Clear Dashboard"
    Then UI Click Button "Widget Selection.Remove All Confirm"
    Then UI Click Button "New Widget" with value "Traffic_Bandwidth_(Defense_Pro_Only)"
    Then UI Click Button "Widget Selection.Add Selected Widgets"
    Then UI Click Button "Widget Selection"



  @SID_20
  Scenario: Validate traffic bandwidth all DP Only
    Then UI Validate Sum Of Line Chart data "df-traffic-bandwidth-dponly-chart" with Label "Inbound" Equals to "2560.0"
    Then UI Validate Sum Of Line Chart data "df-traffic-bandwidth-dponly-chart" with Label "Discarded Inbound" Equals to "640"
    Then UI Validate Sum Of Line Chart data "df-traffic-bandwidth-dponly-chart" with Label "Clean" Equals to "256"
    Then UI Validate Sum Of Line Chart data "df-traffic-bandwidth-dponly-chart" with Label "Diverted" Equals to "512"


  @SID_21
  Scenario: Check disable checkbox with no data in chart
    Then UI Click Button "Attribute CheckBox" with value "0Inbound"
    Then UI Click Button "Attribute CheckBox" with value "1Discarded Inbound"
    Then UI Click Button "Attribute CheckBox" with value "2Clean"
    Then UI Click Button "Attribute CheckBox" with value "3Diverted"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "0Inbound" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "1Discarded Inbound" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "2Clean" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "3Diverted" is "EQUALS" to "false"



  @SID_22
  Scenario: Check disable checkbox with no data in chart
    Then UI Click Button "Attribute CheckBox" with value "0Inbound"
    Then UI Click Button "Attribute CheckBox" with value "1Discarded Inbound"
    Then UI Click Button "Attribute CheckBox" with value "2Clean"
    Then UI Click Button "Attribute CheckBox" with value "3Diverted"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "0Inbound" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "1Discarded Inbound" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "2Clean" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "3Diverted" is "EQUALS" to "true"


  @SID_23
  Scenario: Show only Flow Statistics Chart in DF Analytics
    Then UI Click Button "Widget Selection"
    Then UI Click Button "Widget Selection.Clear Dashboard"
    Then UI Click Button "Widget Selection.Remove All Confirm"
    Then UI Click Button "New Widget" with value "Traffic_Rate_(Defense_Pro_Only)"
    Then UI Click Button "Widget Selection.Add Selected Widgets"
    Then UI Click Button "Widget Selection"

  @SID_24
  Scenario: Validate traffic bandwidth all DP Only
    Then UI Validate Sum Of Line Chart data "df-traffic-rate-dponly-chart" with Label "Inbound" Equals to "160000"
    Then UI Validate Sum Of Line Chart data "df-traffic-rate-dponly-chart" with Label "Discarded Inbound" Equals to "40000"
    Then UI Validate Sum Of Line Chart data "df-traffic-rate-dponly-chart" with Label "Clean" Equals to "16000"
    Then UI Validate Sum Of Line Chart data "df-traffic-rate-dponly-chart" with Label "Diverted" Equals to "32000"

  @SID_25
  Scenario: Check disable checkbox with no data in chart
    Then UI Click Button "Attribute CheckBox" with value "0Inbound"
    Then UI Click Button "Attribute CheckBox" with value "1Discarded Inbound"
    Then UI Click Button "Attribute CheckBox" with value "2Clean"
    Then UI Click Button "Attribute CheckBox" with value "3Diverted"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "0Inbound" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "1Discarded Inbound" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "2Clean" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "3Diverted" is "EQUALS" to "false"

  @SID_30
  Scenario: Check disable checkbox with no data in chart
    Then UI Click Button "Attribute CheckBox" with value "0Inbound"
    Then UI Click Button "Attribute CheckBox" with value "1Discarded Inbound"
    Then UI Click Button "Attribute CheckBox" with value "2Clean"
    Then UI Click Button "Attribute CheckBox" with value "3Diverted"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "0Inbound" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "1Discarded Inbound" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "2Clean" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Attribute CheckBox" With Params "3Diverted" is "EQUALS" to "true"

  @SID_31
  Scenario: Change DF management IP to IP of Vision DF
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "system df management-ip set " |
      | @defenseFlowDevice.getDeviceIp |

  @SID_32
  Scenario: Cleanup
    Then UI logout and close browser






