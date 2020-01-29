@ADC_Report @TC105969
Feature:  DPM - Report Delivery Wizard

  @SID_1
  Scenario: DPM - Login and enabling emailing
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-reporting-module-ADC"
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
    And UI Set Text Field "SMTP Port" To "25"
    And UI Click Button "Submit"

  @SID_2
  Scenario: Navigate to the Reports Wizard
    When UI Open Upper Bar Item "ADC"
    When UI Open "Reports" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

  @SID_3
  Scenario: ADC - Create new Report Delivery
    Given UI "Create" DPMReport With Name "Delivery_Test_report"
      | reportType | Virtual Service Report                                               |
      | devices    | virts:[Rejith_32326515:88]                                           |
      | Share      | Email:[automation.vision1@adcreporter.local,automation.vision2@adcreporter.local],Subject:mySubject,Body:myBody |

  @SID_4
  Scenario: ADC - Generate Report Delivery
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/mail/adcreporter" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command "rm -f /home/radware/attachments/TC105969/* " on "GENERIC_LINUX_SERVER"
    Then UI Generate and Validate Report With Name "Delivery_Test_report" with Timeout of 180 Seconds

  @SID_5
  Scenario: ADC - Validate Report Delivery To
    Then CLI Run linux Command "cat /var/mail/adcreporter|grep X-Original-To:|grep vision1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "X-Original-To: automation.vision1@adcreporter.local"
    Then CLI Run linux Command "cat /var/mail/adcreporter|grep X-Original-To:|grep vision2" on "GENERIC_LINUX_SERVER" and validate result EQUALS "X-Original-To: automation.vision2@adcreporter.local"
  @SID_6
  Scenario: ADC - Validate Report Delivery attachment name
    Then CLI Run linux Command "grep -oP "filename=VRM_report_(\d{13}).pdf" /var/mail/adcreporter|wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "1"
  @SID_7
  Scenario: ADC - Validate Report Delivery Subject
    Then CLI Run linux Command "cat /var/mail/adcreporter |grep Subject:" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Subject: mySubject"
  @SID_8
  Scenario: ADC - Validate Report Delivery Body
    Then CLI Run linux Command "cat /var/mail/adcreporter |grep myBody |wc -l" on "GENERIC_LINUX_SERVER" and validate result GT "0"
  @SID_9
  Scenario: ADC - Validate Report Delivery PDF size
    Then CLI Run remote linux Command "sudo ripmime --overwrite -i /var/mail/adcreporter -d /home/radware/attachments/TC105969/" on "GENERIC_LINUX_SERVER"
    When CLI Run linux Command "ll /home/radware/attachments/TC105969/VRM_report_*.pdf |awk '{print$5}'" on "GENERIC_LINUX_SERVER" and validate result GT "3000"
  @SID_10
  Scenario: ADC - Validate Report Delivery From
    Then CLI Run linux Command "cat /var/mail/adcreporter|grep From:|awk '{print$2,$3}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "APSolute Vision"
  @SID_11
  Scenario: ADC - Validate Report Delivery Sender
    Then CLI Run linux Command "cat /var/mail/adcreporter|grep From:|awk '{print$4}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "<qa_test@Radware.com>"
  @SID_12
  Scenario: ADC - Edit Report Delivery Format
    Then UI "Edit" DPMReport With Name "Delivery_Test_report"
      | Format | Select: HTML |
  @SID_13
  Scenario: ADC - Generate Report Delivery
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/mail/adcreporter" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command "rm -f /home/radware/attachments/TC105969/* " on "GENERIC_LINUX_SERVER"
    Then UI Generate and Validate Report With Name "Delivery_Test_report" with Timeout of 180 Seconds
  @SID_14
  Scenario: ADC - Generate Report Delivery format
    Then CLI Run linux Command "cat /var/mail/adcreporter|grep "Content-Type:"|head -3" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Content-Type: text/html; charset=us-ascii"

  @SID_15
  Scenario: Cleanup
    When UI Open "Configurations" Tab
    Then UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |



