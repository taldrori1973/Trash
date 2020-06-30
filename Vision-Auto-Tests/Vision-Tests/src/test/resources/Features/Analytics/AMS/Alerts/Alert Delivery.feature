@VRM_Alerts @TC105980
Feature: VRM Alerts Delivery

  
  @SID_1
  Scenario: Clean system data
    Given CLI kill all simulator attacks on current vision
    And REST Delete ES index "rt-alert-def-vrm"
    And REST Delete ES index "alert"
    And REST Delete ES index "dp-*"
    And CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "LINUX_FILE_SERVER"
    * REST Send simple body request from File "Vision/SystemManagement.json" with label "Set Authentication Mode"
      | jsonPath             | value    |
      | $.authenticationMode | "TACACS" |

    And CLI Clear vision logs


  @SID_2
  Scenario: VRM - enabling emailing and go to VRM Alerts Tab
    Given UI Login with user "sys_admin" and password "radware"
    And REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Go To Vision
    When UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"
    And UI Do Operation "select" item "Email Reporting Configuration"
    And UI Set Checkbox "Enable" To "true"
    And UI Set Text Field "SMTP User Name" To "qa_test@Radware.com"
    And UI Set Checkbox "Enable" To "false"
    And UI Click Button "Submit"
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
    And UI Set Checkbox "Enable" To "true"
    And UI Set Text Field "SMTP Server Address" To "172.17.164.10"
    And UI Set Text Field "SMTP Port" To "251"
    And UI Click Button "Submit"
    And UI Navigate to "AMS Alerts" page via homePage


  @SID_3
  Scenario: Create Alert Delivery
    When UI "Create" Alerts With Name "Alert Delivery"
      | Basic Info | Description:Alert Delivery Description,Impact: Our network is down,Remedy: Please protect real quick!,Severity:Critical     |
      | Criteria   | Event Criteria:Attack Name,Operator:Equals,Value:SYN Flood HTTP;                                                            |
      | Schedule   | checkBox:Trigger,alertsPerHour:1                                                                                            |
      | Share      | Email:[automation.vision1@alert.local, automation.vision2@alert.local],Subject:Alert Delivery Subj,Body:Alert Delivery Body |

  
  @SID_4
  Scenario: Run DP simulator VRM_Alert_Severity
    When CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "LINUX_FILE_SERVER"
    And CLI simulate 1 attacks of type "VRM_Alert_Severity" on SetId "DefensePro_Set_1" and wait 95 seconds

  
  @SID_5
  Scenario: Verify Alert Email Delivery Subject
    Then CLI Run remote linux Command "cat /var/spool/mail/alertuser > /tmp/alertdelivery.log" on "LINUX_FILE_SERVER"
    Then CLI Run linux Command "cat /var/spool/mail/alertuser|tr -d "="|tr -d "\n"|grep -o "Subject: Alert Delivery Subj" |wc -l" on "LINUX_FILE_SERVER" and validate result EQUALS "2"
  
  @SID_6
  Scenario: Verify Alert Email Delivery Body
    Then CLI Run linux Command "cat /var/spool/mail/alertuser|tr -d "="|tr -d "\n"|grep -o "Alert Delivery Body" |wc -l" on "LINUX_FILE_SERVER" and validate result EQUALS "2"
  
  @SID_7
  Scenario: Verify Alert Email Delivery Remedy
    Then CLI Run linux Command "cat /var/spool/mail/alertuser|tr -d "="|tr -d "\n"|grep -o "Remedy</td>    <td>Please protect real quick!" |wc -l" on "LINUX_FILE_SERVER" and validate result EQUALS "2"
  
  @SID_8
  Scenario: Verify Alert Email Delivery Impact
    Then CLI Run linux Command "cat /var/spool/mail/alertuser|tr -d "="|tr -d "\n"|grep -o "<td>Impact</td>    <td>Our network is down</td>" |wc -l" on "LINUX_FILE_SERVER" and validate result EQUALS "2"

  
  @SID_9
  Scenario: Verify Alert Email Delivery Sender
    Then CLI Run linux Command "grep "From: APSolute Vision <qa_test@Radware.com>" /var/spool/mail/alertuser |wc -l" on "LINUX_FILE_SERVER" and validate result EQUALS "2"
  
  @SID_10
  Scenario: Verify Alert Email Delivery recipient
    Then CLI Run linux Command "grep "X-Original-To: automation.vision1@alert.local" /var/spool/mail/alertuser |wc -l" on "LINUX_FILE_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "X-Original-To: automation.vision2@alert.local" /var/spool/mail/alertuser |wc -l" on "LINUX_FILE_SERVER" and validate result EQUALS "1"
  
  @SID_11
  Scenario: Verify Alert Email Delivery attack details
    Then CLI Run linux Command "grep -o -e "2000::0001" -e "<td>80</td>" -e "SYN Flood HTTP" -e "policy1" -e "TCP" -e "Unknown" /var/spool/mail/alertuser |wc -l" on "LINUX_FILE_SERVER" and validate result EQUALS "22"
    Then CLI Run linux Command "cat /var/spool/mail/alertuser| tr -d '\n'|grep -oP "Mu(=*)l(=*)tiple" |wc -l" on "LINUX_FILE_SERVER" and validate result EQUALS "8"

  @SID_12
  Scenario: VRM - go to vision and disable emailing
    And UI Go To Vision
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
    And UI Set Checkbox "Enable" To "false"
    And UI Click Button "Submit"

  @SID_13
  Scenario: Cleanup
    Then UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
