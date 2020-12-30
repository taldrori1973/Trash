
@TC112396
Feature: DefenseFlow Traffic Reports

  @SID_1
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "df-traffic*"
    * REST Delete ES index "vrm-scheduled-report-*"
    * REST Delete ES index "vrm-scheduled-report-result-*"
    * CLI Clear vision logs

  @SID_13
  Scenario: Change DF managment IP to IP of Generic Linux
    When CLI Operations - Run Radware Session command "system df management-ip set 172.17.164.10"
    When CLI Operations - Run Radware Session command "system df management-ip get"
    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 172.17.164.10"

  @SID_2
  Scenario: Email configuration
    Given UI Login with user "sys_admin" and password "radware"
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

  @SID_3
  Scenario: Run DF traffic simulator
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER" and wait 90 seconds
      | "/home/radware/curl_DF_traffic_auto.sh " |
      | #visionIP                                |
      | " PO_100 3"                              |

  @SID_4
  Scenario: Navigate to AMS report
    And UI Navigate to "AMS Reports" page via homePage


  # =============================================Overall===========================================================
  @SID_5
  Scenario: Create DefenseFlow traffic report
    Given UI "Create" Report With Name "DF_Traffic"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[ALL],Protected Objects:[PO_100] |
      | Format                | Select: CSV                                                                                                           |
      | Share          | Email:[DF_traffic@report.local],Subject:DefenseFlow Traffic report |

  @SID_6
  Scenario: Clear SMTP server log files
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/reportuser" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command "rm -f /home/radware/attachments/TC112396/*" on "GENERIC_LINUX_SERVER"

  @SID_7
  Scenario: Generate Report
    Then UI Click Button "My Report" with value "DF_Traffic"
    Then UI Click Button "Generate Report Manually" with value "DF_Traffic"
    Then Sleep "35"

  @SID_8
  Scenario: Validate Report Email received content
    Then CLI Run linux Command "cat /var/spool/mail/reportuser|tr -d "="|tr -d "\n"|grep -o "Subject: DefenseFlow Traffic report" |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"

    Then CLI Run remote linux Command "ripmime -i /var/mail/reportuser -d /home/radware/attachments/TC112396" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command "unzip -o /home/radware/attachments/TC112396/VRM_report_*.zip" on "GENERIC_LINUX_SERVER"


  @SID_9
  Scenario: Download CSV from UI page
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER" and wait 90 seconds
      | "/home/radware/Scripts/download_report_file.sh " |
      | #visionIP                                        |
      | " DF_Traffic"                                    |
    Then CLI Run remote linux Command "unzip -o /home/radware/Downloads/downloaded.report" on "GENERIC_LINUX_SERVER"

  @SID_10
  Scenario: Verify content of downloaded CSV
    When CLI Run linux Command "ll /home/radware/Downloads/downloaded.report |awk '{print$5}'" on "GENERIC_LINUX_SERVER" and validate result GTE "2500"

  @SID_11
  Scenario: Search for bad logs
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
      | ALL     | error      | NOT_EXPECTED |

  @SID_12
  Scenario: Cleanup
    When UI Open "Configurations" Tab
    Then UI logout and close browser
    * CLI kill all simulator attacks on current vision
