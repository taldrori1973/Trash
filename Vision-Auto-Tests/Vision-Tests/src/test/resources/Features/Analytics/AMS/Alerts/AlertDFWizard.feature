@VRM_Alerts @TC113517 @DFALERTS
Feature: VRM AW Alerts

  
  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    * CLI Clear vision logs

  
  @SID_2
  Scenario: VRM - enabling emailing and go to VRM Alerts Tab
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Vision Install License Request "vision-reporting-module-AMS"
    And UI Go To Vision
    Then UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"
    Then UI Do Operation "select" item "Email Reporting Configuration"
    Then UI Set Checkbox "Enable" To "true"
    Then UI Set Text Field "SMTP User Name" To "qa_test@Radware.com"
    Then UI Set Checkbox "Enable" To "false"
    Then UI Click Button "Submit"
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
    And UI Set Checkbox "Enable" To "true"
    And UI Set Text Field "SMTP Server Address" To "172.17.164.10"
    And UI Set Text Field "SMTP Port" To "251"
    And UI Click Button "Submit"
    And UI Navigate to "AMS Alerts" page via homePage


  @SID_3
  Scenario: Create Alert Delivery
    When UI "Create" Alerts With Name "Alert Delivery"
      | Product | DefenseFlow |
      | Basic Info | Description:Alert Delivery Description,Impact: Our network is down,Remedy: Please protect real quick!,Severity:Critical     |
      | Criteria   | Event Criteria:Action,Operator:Not Equals,Value:[Forward];     |
      | Schedule   | checkBox:Trigger,alertsPerHour:10                                                                                           |
      | Share      | Email:[automation.vision1@alert.local, automation.vision2@alert.local],Subject:Alert Delivery Subj,Body:Alert Delivery Body |
    And Sleep "120"

  @SID_4
  Scenario: Run DP simulator VRM_Alert_Severity
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_alert_PO_101.sh "                     |
      | #visionIP |
      | " Terminated" |
    And Sleep "60"

  @SID_5
  Scenario: Verify Alert Email Delivery Subject
    Then CLI Run remote linux Command "cat /var/spool/mail/alertuser > /tmp/alertdelivery.log" on "GENERIC_LINUX_SERVER"
    Then CLI Run linux Command "cat /var/spool/mail/alertuser|tr -d "="|tr -d "\n"|grep -o "Subject: Alert Delivery Subj" |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2"

  @SID_6
  Scenario: Verify Alert Email Delivery Remedy
    Then CLI Run linux Command "cat /var/spool/mail/alertuser|tr -d "="|tr -d "\n"|grep -o "Remedy</td>    <td>Please protect real quick!" |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2"

  @SID_7
  Scenario: Verify Alert Email Delivery Impact
    Then CLI Run linux Command "cat /var/spool/mail/alertuser|tr -d "="|tr -d "\n"|grep -o "<td>Impact</td>    <td>Our network is down</td>" |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2"

  @SID_8
  Scenario: Verify Alert Email Delivery Sender
    Then CLI Run linux Command "grep "From: APSolute Vision <qa_test@Radware.com>" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2"

  @SID_9
  Scenario: Verify Alert Email Delivery recipient
    Then CLI Run linux Command "grep "X-Original-To: automation.vision1@alert.local" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "X-Original-To: automation.vision2@alert.local" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"

  @SID_10
  Scenario: Verify Alert Email Delivery attack details
    Then CLI Run linux Command "grep -o -e "2000::0001" -e "<td>80</td>" -e "SYN Flood HTTP" -e "policy1" -e "TCP" -e "Unknown" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "16"



    #    ------------------- Ahlam - Add test for Connection PPS  -----------------


    
  @SID_14
  Scenario: Create Alert Category ConnectionPPS
    When UI "Create" Alerts With Name "Alert_Category connection PPS"
      | Product | DefenseFlow |
      | Basic Info | Description:Category Connection PPS Description,Impact: Our network is down,Remedy: Please protect real quick!,Severity:Critical     |
      | Criteria | Event Criteria:Threat Category,Operator:Equals,Value:[Connection PPS]; |
      | Schedule   | checkBox:Trigger,alertsPerHour:10                                                                                           |
      | Share      | Email:[automation.vision1@alert.local, automation.vision2@alert.local],Subject:Alert Delivery Subj,Body:Alert Delivery Body |
    And Sleep "120"

  
  @SID_13
  Scenario: Run DP simulator VRM_Alert_Severity
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_alert_PO_101.sh "                     |
      | #visionIP |
      | " Terminated" |
    And Sleep "60"



  
  @SID_15
  Scenario: Verify alert table sorting in modal popup
    Then UI Navigate to "AMS Alerts" page via homePage
    Then UI "Check" all the Toggle Alerts
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Category connection PPS"
    Then UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy index 0
    Then UI Validate Table record values by columns with elementLabel "Alert details" findBy index 0
      | columnName  | value |
      | Threat Category | ConnectionPPS  |
    Then UI Click Button "Table Details OK" with value "OK"

  
  @SID_16
  Scenario: VRM Validate Alert browser details Alert_Category connection PPS
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Category connection PPS \nSeverity: MINOR \nDescription: Category \nImpact: N/A \nRemedy: N/A \nDevice IP: 172.16.22.50 \n*Attacks Count: 1 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

# -------------------------------------------------------------------------

  @SID_11
  Scenario: VRM - go to vision and disable emailing
    Then UI Open "Configurations" Tab
    And UI Go To Vision
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
    And UI Set Checkbox "Enable" To "false"
    And UI Click Button "Submit"



  @SID_12
  Scenario: Cleanup
    Then UI Logout
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
