
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

  @SID_2
  Scenario: Login and Email configuration
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
    When UI Open Upper Bar Item "AMS"
    When UI Open "Dashboards" Tab
    When UI Open "Reports" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

  @SID_5
  Scenario: Create DefenseFlow traffic report
    When UI "Create" Report With Name "DF_Traffic"
      | reportType     | DefenseFlow Analytics Dashboard                                    |
      | projectObjects | PO_100                                                             |
      | Design         | Delete:[ALL],Add:[Traffic Bandwidth,Traffic Rate]                  |
      | Share          | Email:[DF_traffic@report.local],Subject:DefenseFlow Traffic report |
      | Format         | Select: CSV                                                        |

  @SID_6
  Scenario: Clear SMTP server log files
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/reportuser" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command "rm -f /home/radware/attachments/TC112396/*" on "GENERIC_LINUX_SERVER"

  @SID_7
  Scenario: Generate Report
    Then UI Generate and Validate Report With Name "DF_Traffic" with Timeout of 120 Seconds

  @SID_8
  Scenario: Validate Report Email recieved content Traffic_Bandwidth
    Then CLI Run linux Command "cat /var/spool/mail/reportuser|tr -d "="|tr -d "\n"|grep -o "Subject: DefenseFlow Traffic report" |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"

    Then CLI Run remote linux Command "ripmime -i /var/mail/reportuser -d /home/radware/attachments/TC112396" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command "unzip -o -d /home/radware/attachments/TC112396/ /home/radware/attachments/TC112396/VRM_report_*.zip" on "GENERIC_LINUX_SERVER"

    Then CLI Run linux Command "cat /home/radware/attachments/TC112396/Traffic_Bandwidth.csv |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "4"
    Then CLI Run linux Command "cat /home/radware/attachments/TC112396/Traffic_Bandwidth.csv|head -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "timeStamp,diverted,discarded,inbound,dropped,clean"
    Then CLI Run linux Command "cat /home/radware/attachments/TC112396/Traffic_Bandwidth.csv|tail -1|awk -F"," '{print$2}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1620"
    Then CLI Run linux Command "cat /home/radware/attachments/TC112396/Traffic_Bandwidth.csv|tail -1|awk -F"," '{print$3}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2024"
    Then CLI Run linux Command "cat /home/radware/attachments/TC112396/Traffic_Bandwidth.csv|tail -1|awk -F"," '{print$4}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "8083.1999999999998181010596454143524169921875"
    Then CLI Run linux Command "cat /home/radware/attachments/TC112396/Traffic_Bandwidth.csv|tail -1|awk -F"," '{print$5}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "4016"
    Then CLI Run linux Command "cat /home/radware/attachments/TC112396/Traffic_Bandwidth.csv|tail -1|awk -F"," '{print$6}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "815.200000000000045474735088646411895751953125"

  @SID_9
  Scenario: Validate Report Email recieved content Traffic_Rate
    Then CLI Run linux Command "cat /home/radware/attachments/TC112396/Traffic_Bandwidth.csv |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "4"
    Then CLI Run linux Command "cat /home/radware/attachments/TC112396/Traffic_Bandwidth.csv|head -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "timeStamp,diverted,discarded,inbound,dropped,clean"
    Then CLI Run linux Command "cat /home/radware/attachments/TC112396/Traffic_Rate.csv| tail -1|grep -oP "(\d{13}),425000,32000,700933,320000,109300" |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/attachments/TC112396/Traffic_Rate.csv| tail -1|awk -F"," '{print$2}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "425000"
    Then CLI Run linux Command "cat /home/radware/attachments/TC112396/Traffic_Rate.csv| tail -1|awk -F"," '{print$3}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "32000"
    Then CLI Run linux Command "cat /home/radware/attachments/TC112396/Traffic_Rate.csv| tail -1|awk -F"," '{print$4}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "700933"
    Then CLI Run linux Command "cat /home/radware/attachments/TC112396/Traffic_Rate.csv| tail -1|awk -F"," '{print$5}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "320000"
    Then CLI Run linux Command "cat /home/radware/attachments/TC112396/Traffic_Rate.csv| tail -1|awk -F"," '{print$6}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "109300"

  @SID_10
  Scenario: Download and unzip CSV from UI page
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER" and wait 90 seconds
      | "/home/radware/Scripts/download_report_file.sh " |
      | #visionIP                                        |
      | " DF_Traffic"                                    |
    Then CLI Run remote linux Command "unzip -o -d /home/radware/Downloads/TC112396/ /home/radware/Downloads/downloaded.report" on "GENERIC_LINUX_SERVER"

  @SID_11
  Scenario: Verify content of downloaded CSV
    When CLI Run linux Command "ll /home/radware/Downloads/downloaded.report |awk '{print$5}'" on "GENERIC_LINUX_SERVER" and validate result GT "3000"
    Then CLI Run linux Command "cat /home/radware/Downloads/TC112396/Traffic_Rate.csv| tail -1|awk -F"," '{print$2}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "425000"
    Then CLI Run linux Command "cat /home/radware/Downloads/TC112396/Traffic_Rate.csv| tail -1|awk -F"," '{print$3}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "32000"
    Then CLI Run linux Command "cat /home/radware/Downloads/TC112396/Traffic_Rate.csv| tail -1|awk -F"," '{print$4}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "700933"
    Then CLI Run linux Command "cat /home/radware/Downloads/TC112396/Traffic_Rate.csv| tail -1|awk -F"," '{print$5}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "320000"
    Then CLI Run linux Command "cat /home/radware/Downloads/TC112396/Traffic_Rate.csv| tail -1|awk -F"," '{print$6}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "109300"

  ######################   REPORT OF MORE THAN AN HOUR  #############################

  @SID_12
  Scenario: Copy needed script and cleanup
    Then CLI copy "/home/radware/Scripts/put_DF_documents_in_past.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    * REST Delete ES index "df-traffic-*"

  @SID_13
  Scenario: Run DF traffic simulator
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER" and wait 90 seconds
      | "/home/radware/curl_DF_traffic_auto.sh " |
      | #visionIP                                |
      | " PO_100 1"                              |

    Then CLI Run remote linux Command "/put_DF_documents_in_past.sh" on "ROOT_SERVER_CLI" with timeOut 20

  @SID_14
  Scenario: Create DefenseFlow traffic report
    When UI "Create" Report With Name "DF_Traffic_year"
      | reportType            | DefenseFlow Analytics Dashboard                                    |
      | projectObjects        | PO_100                                                             |
      | Design                | Delete:[ALL],Add:[Traffic Bandwidth,Traffic Rate]                  |
      | Time Definitions.Date | Relative:[Months,12]                                               |
      | Share                 | Email:[DF_traffic@report.local],Subject:DefenseFlow Traffic report |
      | Format                | Select: CSV                                                        |

  @SID_15
  Scenario: Clear SMTP server log files
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/reportuser" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command "rm -f /home/radware/attachments/TC112396_16/*" on "GENERIC_LINUX_SERVER"

  @SID_16
  Scenario: Generate Report
    Then UI Generate and Validate Report With Name "DF_Traffic_year" with Timeout of 120 Seconds

  @SID_17
  Scenario: Verify report content
    Then CLI Run remote linux Command "ripmime -i /var/mail/reportuser -d /home/radware/attachments/TC112396_16" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command "unzip -o -d /home/radware/attachments/TC112396/ /home/radware/attachments/TC112396_16/VRM_report_*.zip" on "GENERIC_LINUX_SERVER"

    Then CLI Run linux Command "cat /home/radware/attachments/TC112396_16/Traffic_Bandwidth.csv |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "4"
    Then CLI Run linux Command "cat /home/radware/attachments/TC112396_16/Traffic_Bandwidth.csv|head -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "timeStamp,diverted,discarded,inbound,dropped,clean"
    Then CLI Run linux Command "cat /home/radware/attachments/TC112396_16/Traffic_Bandwidth.csv|tail -1|awk -F"," '{print$2}'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1620"

  @SID_18
  Scenario: Search for bad logs
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
      | ALL     | error      | NOT_EXPECTED |

  @SID_19
  Scenario: Cleanup
    When UI Open "Configurations" Tab
    Then UI logout and close browser
    * CLI kill all simulator attacks on current vision
