@ADC_Report@TC108089

Feature: ADC- Create Report share

  @SID_1
  Scenario: keep reports copy on file system
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720

  @SID_2
  Scenario: Clear Database and old reports on file-system
    * REST Delete ES index "dp-traffic-*"
    * REST Delete ES index "dp-https-stats-*"
    * REST Delete ES index "dp-https-rt-*"
    * REST Delete ES index "dp-five-*"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"

  @SID_3
  Scenario: DPM - enabling emailing and go to DPM Reports Tab
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
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
    And UI Open Upper Bar Item "ADC"
    And UI Open "Reports" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

  @SID_4
  Scenario: Clear SMTP server log files
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/radware" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/reportuser" on "GENERIC_LINUX_SERVER"

  @SID_5
  Scenario: Create and genearte Report
    Given UI "Create" DPMReport With Name "ADCShare"
      | reportType            | Application Report                                                                            |
      | devices               | virts:[Rejith_32326515:88]                                                                    |
      | Format                | Select: CSV                                                                                   |
      | Share                 | Email:[automation.vision1@radware.com, also@report.local],Subject:report delivery Subject ADC |
      | Time Definitions.Date | Quick:15m                                                                                     |

    When UI Click Button "Expand" with value "ADCShare"
    When UI Click Button "Generate Now" with value "ADCShare"
    When Sleep "30"
    When UI Click Button "Log Preview" with value "ADCShare"
    Then UI Validate Element Existence By Label "Log Preview" if Exists "true" with value "ADCShare"


  @SID_6
  Scenario: Validate Report
    Given UI "Validate" DPMReport With Name "ADCShare"
      | reportType            | Application Report                                                                            |
      | devices               | virts:[Rejith_32326515:88]                                                                    |
      | Format                | Select: CSV                                                                                   |
      | Share                 | Email:[automation.vision1@radware.com, also@report.local],Subject:report delivery Subject ADC |
      | Time Definitions.Date | Quick:15m                                                                                     |


  @SID_7
  Scenario: Validate Report Email received content
    Then CLI Run remote linux Command "cat /var/spool/mail/reportuser > /tmp/reportdelivery.log" on "GENERIC_LINUX_SERVER"
    Then CLI Run linux Command "cat /var/spool/mail/reportuser|tr -d "="|tr -d "\n"|grep -o "Subject: report delivery Subject ADC" |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /var/spool/mail/radware|tr -d "="|tr -d "\n"|grep -o "Subject: report delivery Subject ADC" |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"

    Then CLI Run linux Command "grep "From: APSolute Vision <qa_test@Radware.com>" /var/spool/mail/reportuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "From: APSolute Vision <qa_test@Radware.com>" /var/spool/mail/radware |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"

    Then CLI Run linux Command "grep "X-Original-To: also@report.local" /var/spool/mail/reportuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "X-Original-To: automation.vision1@radware.com" /var/spool/mail/radware |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"

    Then CLI Run linux Command "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).zip" /var/spool/mail/reportuser | wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).zip" /var/spool/mail/radware | wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"


  @SID_8
  Scenario: ADC report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

   Scenario: CSV File Validate number of lines
#     Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Rejith_32326515_88.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "145"
     Then CLI Run linux Command "awk 'END { print NR }' /opt/radware/mgt-server/third-party/tomcat/bin/Rejith_32326515_88.csv" on "ROOT_SERVER_CLI" and validate result EQUALS "141"

   Scenario: Validate CSV File contain: Throughput and Connections per second
     Then CLI Run remote linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Rejith_32326515_88.csv" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex ".*\"Throughput \(bps\)\",.*"
#    Then CLI Operations - Verify that output contains regex ".*\"throughput\",\"applicationId\",\"timestamp\",.*"

  Scenario: Copy script
    Then CLI copy file by user "root" "/root/validateCSVReport.sh" from "genericLinuxServer" to "rootServerCli" "/root/"

Scenario: run Script to validate Connections per Second
  Then CLI Operations - Run Root Session command "./validateCSVReport.sh "Connections per Second" "/opt/radware/mgt-server/third-party/tomcat/bin/Rejith_32326515_88.csv" 20 13 Rejith_32326515:88"
  Then CLI Operations - Verify that output contains regex ".*validation succeeded.*"

  Scenario: run Script to validate Throughput
    Then CLI Operations - Run Root Session command "./validateCSVReport.sh "Throughput" "/opt/radware/mgt-server/third-party/tomcat/bin/Rejith_32326515_88.csv" 20 11 Rejith_32326515:88"
    Then CLI Operations - Verify that output contains regex ".*validation succeeded.*"

  @SID_9
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |