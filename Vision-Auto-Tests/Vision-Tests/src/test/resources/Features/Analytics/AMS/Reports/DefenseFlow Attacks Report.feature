@TC111798
Feature: DefenseFlow Attacks Reports

  #  ==========================================Setup================================================
  @SID_1
  Scenario: Clear data
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Then CLI kill all simulator attacks on current vision
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then REST Delete ES index "df-attack*"
    Then REST Delete ES index "vrm-scheduled-report-*"
    Then REST Delete ES index "vrm-scheduled-report-result-*"
    Then CLI Clear vision logs

  @SID_2
  Scenario: Run DF simulator
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_100.sh " |
      | #visionIP                                       |
      | " Terminated"                                   |
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_200.sh " |
      | #visionIP                                       |
      | " Terminated"                                   |
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER" and wait 30 seconds
      | "/home/radware/curl_DF_attacks-auto_PO_300.sh " |
      | #visionIP                                       |
      | " Terminated"                                   |

  @SID_3
  Scenario:Login and copy get_scheduled_report_value.sh file to server
    Given UI Login with user "sys_admin" and password "radware"
    Then CLI copy "/home/radware/Scripts/get_scheduled_report_value.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"

  @SID_4
  Scenario: Email configuration
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

  @SID_5
  Scenario: Navigate to AMS report
    When UI Open Upper Bar Item "AMS"
    When UI Open "Dashboards" Tab
    When UI Open "Reports" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

  # =============================================Overall===========================================================
  @SID_6
  Scenario: Create DefenseFlow report
    When UI "Create" Report With Name "OverallDFReport"
      | reportType         | DefenseFlow Analytics Dashboard                                              |
      | projectObjects     | All                                                                          |
      | Design             | Add:[Top Attacks by Duration,Top Attack Destination,Top Attacks by Protocol] |
      | Customized Options | addLogo: reportLogoPNG.png                                                   |
    Then UI "Validate" Report With Name "OverallDFReport"
      | reportType         | DefenseFlow Analytics Dashboard                                                  |
      | projectObjects     | PO_100,PO_200,PO_300                                                             |
      | Design             | Widgets:[Top Attacks by Duration,Top Attack Destination,Top Attacks by Protocol] |
      | Customized Options | addLogo: reportLogoPNG.png                                                       |
    Then UI Validate Element Existence By Label "Reports List Item" if Exists "true" with value "OverallDFReport"

  @SID_7
  Scenario: Edit report
    When UI "Edit" Report With Name "OverallDFReport"
      | reportType            | DefenseFlow Analytics Dashboard                                    |
      | projectObjects        | PO_300                                                             |
      | Customized Options    | addLogo:unselected                                                 |
      | Time Definitions.Date | Quick:15m                                                          |
      | Share                 | Email:[DF_attack@report.local],Subject:DefenseFlow Attack report   |
      | Format                | Select: CSV                                                        |


  @SID_8
  Scenario: Clear SMTP server log files
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/reportuser" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command "sudo rm -f /home/radware/attachments/TC111798/*" on "GENERIC_LINUX_SERVER"

  @SID_9
  Scenario: Generate Report
    Then UI Generate and Validate Report With Name "OverallDFReport" with Timeout of 120 Seconds

  @SID_10
  Scenario: Delete report
    When UI Click Button "Delete" with value "OverallDFReport"
    When UI Click Button "Delete.Approve"
    Then UI Validate Element Existence By Label "Reports List Item" if Exists "false" with value "OverallDFReport"

  @SID_11
  Scenario: Extract Report Email attachment
    Then CLI Run remote linux Command "cat /var/spool/mail/reportuser > /tmp/reportdelivery.log" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command "sudo ripmime --overwrite -i /var/mail/reportuser -d /home/radware/attachments/TC111798/" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command "sudo unzip -o /home/radware/attachments/TC111798/VRM_report_*.zip -d /home/radware/attachments/TC111798/" on "GENERIC_LINUX_SERVER"

  @SID_12
  Scenario: Validate content of CSV Top_Attack Destination
    Then CLI Run linux Command "cat "/home/radware/attachments/TC111798/Top_Attack Destination.csv" |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "13"
    Then CLI Run linux Command "cat "/home/radware/attachments/TC111798/Top_Attack Destination.csv" |head -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "destAddress,Count"
    Then CLI Run linux Command "cat "/home/radware/attachments/TC111798/Top_Attack Destination.csv" |head -2|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "94.125.59.119,40"
    Then CLI Run linux Command "cat "/home/radware/attachments/TC111798/Top_Attack Destination.csv" |head -3|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "94.125.59.52,7"
    Then CLI Run linux Command "cat "/home/radware/attachments/TC111798/Top_Attack Destination.csv" |head -4|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "94.125.61.203,3"
    Then CLI Run linux Command "cat "/home/radware/attachments/TC111798/Top_Attack Destination.csv" |head -5|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "5.62.87.26,2"
    Then CLI Run linux Command "cat "/home/radware/attachments/TC111798/Top_Attack Destination.csv" |head -6|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "103.81.128.6,1"
    Then CLI Run linux Command "cat "/home/radware/attachments/TC111798/Top_Attack Destination.csv" |head -7|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "185.242.68.179,1"
    Then CLI Run linux Command "cat "/home/radware/attachments/TC111798/Top_Attack Destination.csv" |head -8|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "185.31.222.138,1"
    Then CLI Run linux Command "cat "/home/radware/attachments/TC111798/Top_Attack Destination.csv" |head -9|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "94.125.59.1,1"
    Then CLI Run linux Command "cat "/home/radware/attachments/TC111798/Top_Attack Destination.csv" |head -10|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "94.125.61.210,1"


  @SID_13
  Scenario: Validate content of CSV Top_Attacks by Duration
    Then CLI Run linux Command "cat "/home/radware/attachments/TC111798/Top_Attacks by Duration.csv" |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "10"
    Then CLI Run linux Command "cat "/home/radware/attachments/TC111798/Top_Attacks by Duration.csv" |head -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "duration,name,Count,protectedObjectName"
    Then CLI Run linux Command "cat "/home/radware/attachments/TC111798/Top_Attacks by Duration.csv" |head -2|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS ""5-10 min","HTTP (recv.pps)",32,PO_300"



  @SID_14
  Scenario: Validate content of CSV file Top Attacks by Protocol


  @SID_15
  Scenario: Create New Report with Default Values
    When UI "Create" Report With Name "deliveryDF"
      | reportType     | DefenseFlow Analytics Dashboard                                                              |
      | projectObjects | All                                                                                          |
      | Share          | Email:[automation.vision1@radware.com, also@report.local],Subject:report delivery Subject DF |
    Then UI Generate and Validate Report With Name "deliveryDF" with Timeout of 100 Seconds

  @SID_16
  Scenario: Create New Report with Monthly schedule
    When UI "Create" Report With Name "scheduleMonthlyDF"
      | reportType | DefenseFlow Analytics Dashboard |
      | Schedule   | Run Every:Monthly,On Time:+2m   |

    Then UI "Validate" Report With Name "scheduleMonthlyDF"
      | reportType | DefenseFlow Analytics Dashboard |
      | Schedule   | Run Every:Monthly,On Time:+2m   |

  @SID_17
  Scenario: Create New Report with With daily schedule
    When UI "Create" Report With Name "scheduleDailyDF"
      | reportType | DefenseFlow Analytics Dashboard |
      | Schedule   | Run Every:Daily,On Time:+2m     |

    Then UI "Validate" Report With Name "scheduleDailyDF"
      | reportType | DefenseFlow Analytics Dashboard |
      | Schedule   | Run Every:Daily,On Time:+2m     |

  @SID_18
  Scenario: validation if reports generated after the expected time
    When Sleep "150"
    # validate if scheduleMonthlyDF generated in UI
    When UI Click Button "Reports List Item" with value "scheduleMonthlyDF"
    Then UI Validate Element Existence By Label "Logs List Items" if Exists "true" with value "scheduleMonthlyDF"

    # validate if scheduleDailyDF generated in UI
    When UI Click Button "Reports List Item" with value "scheduleDailyDF"
    Then UI Validate Element Existence By Label "Logs List Items" if Exists "true" with value "scheduleDailyDF"

    # validate scheduleMonthlyDF schedule regex matchs in CLI
    Then CLI Run remote linux Command "/get_scheduled_report_value.sh scheduleMonthlyDF" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "0 (\d{2}) (\d{2}) (\d{1,2}) (\d{1,2}) \? \*"

    # validate scheduleDailyDF schedule regex matchs in CLI
    Then CLI Run remote linux Command "/get_scheduled_report_value.sh scheduleDailyDF" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "0 (\d{2}) (\d{2}) \? \* \*"

  @SID_19
  Scenario: Cleanup
    * REST Delete ES index "df-attack*"
    * REST Delete ES index "vrm-scheduled-report-*"
    * REST Delete ES index "vrm-scheduled-report-result-*"


    # new attacks one occurred before 100 days, and another before 25 hours
  @SID_20
  Scenario: Run DF simulator
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_100_100D_Before.sh " |
      | #visionIP                                                   |
      | " Terminated"                                               |
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_300_25H_Before.sh " |
      | #visionIP                                                  |
      | " Terminated"                                              |

  @SID_21
  Scenario: validate time selection -Quick range- Report
    Given UI "Create" Report With Name "1WeekBeforeReport"
      | reportType            | DefenseFlow Analytics Dashboard |
      | projectObjects        | PO_300                          |
      | Time Definitions.Date | Quick:1W                        |
      | Format                | Select: CSV                     |
    Then UI "Validate" Report With Name "1WeekBeforeReport"
      | reportType            | DefenseFlow Analytics Dashboard |
      | projectObjects        | PO_300                          |
      | Time Definitions.Date | Quick:1W                        |
      | Format                | Select: CSV                     |
    Then UI Generate and Validate Report With Name "1WeekBeforeReport" with Timeout of 120 Seconds

  @SID_22
  Scenario: Download CSV from UI page
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER" and wait 90 seconds
      | "/home/radware/Scripts/download_report_file.sh " |
      | #visionIP                                        |
      | " 1WeekBeforeReport"                             |

  @SID_23
  Scenario: Validate content of CSV file
    Then CLI Run remote linux Command "sudo unzip -o /home/radware/Downloads/downloaded.report -d /home/radware/Downloads/" on "GENERIC_LINUX_SERVER"
    Then CLI Run linux Command "cat "/home/radware/Downloads/Top_Attack Destination.csv" |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "28"


  @SID_24
  Scenario: Validate content of CSV file
  @SID_25
  Scenario: Validate content of CSV file
  @SID_26
  Scenario: Validate content of CSV file
  @SID_27
  Scenario: Validate content of CSV file
  @SID_28
  Scenario: Validate content of CSV file
  @SID_29
  Scenario: Validate content of CSV file

  @SID_30
  Scenario: validate time selection -Absolute- report
    Given UI "Create" Report With Name "100DaysBeforeReport"
      | reportType            | DefenseFlow Analytics Dashboard                                              |
      | projectObjects        | PO_200,PO_100                                                                |
      | Design                | Add:[Top Attacks by Duration,Top Attack Destination,Top Attacks by Protocol] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, -101d]                                        |
      | Format                | Select: CSV                                                                  |
    Then UI "Validate" Report With Name "100DaysBeforeReport"
      | reportType            | DefenseFlow Analytics Dashboard                                                  |
      | projectObjects        | PO_200,PO_100                                                                    |
      | Design                | Widgets:[Top Attacks by Duration,Top Attack Destination,Top Attacks by Protocol] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, -101d]                                            |
      | Format                | Select: CSV                                                                      |
    Then UI Generate and Validate Report With Name "100DaysBeforeReport" with Timeout of 100 Seconds

  @SID_31
  Scenario: Download CSV from UI page
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER" and wait 90 seconds
      | "/home/radware/Scripts/download_report_file.sh " |
      | #visionIP                                        |
      | " 1WeekBeforeReport"                             |

  @SID_32
  Scenario: Validate content of CSV file
    Then CLI Run remote linux Command "sudo unzip -o /home/radware/Downloads/downloaded.report -d /home/radware/Downloads/" on "GENERIC_LINUX_SERVER"
    Then CLI Run linux Command "cat "/home/radware/Downloads/Top_Attack Destination.csv" |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "28"


#  @SID_19
#  Scenario: validate time selection -Relative- report
#    Given UI "Create" Report With Name "2DaysBeforeReport"
#      | reportType            | DefenseFlow Analytics Dashboard       |
#      | Design                | Add:[Traffic Bandwidth, Traffic Rate] |
#      | Time Definitions.Date | Relative:[Days,2]                     |
#      | Format                | Select: CSV                           |
#    Then UI "Validate" Report With Name "2DaysBeforeReport"
#      | reportType            | DefenseFlow Analytics Dashboard           |
#      | Design                | Widgets:[Traffic Bandwidth, Traffic Rate] |
#      | Time Definitions.Date | Relative:[Days,2]                         |
#      | Format                | Select: CSV                               |
#    Then UI Generate and Validate Report With Name "2DaysBeforeReport" with Timeout of 100 Seconds

  @SID_33
  Scenario: logout
    When UI Open "Configurations" Tab
    And UI Go To Vision
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
    And UI Set Checkbox "Enable" To "false"
    Then UI Click Button "Submit"
    When UI logout and close browser

  @SID_34
  Scenario: login with sec_mon user
    Given UI Login with user "sec_mon" and password "radware"
    When UI Open Upper Bar Item "AMS"
    When UI Open "Dashboards" Tab
    When UI Open "Reports" Tab
    Then UI Validate Element Existence By Label "Title" if Exists "false" with value "2DaysBeforeReport"
    Then UI Validate Element Existence By Label "Title" if Exists "false" with value "100DaysBeforeReport"

  @SID_35
  Scenario: non-admin user can't select DF in report
    When UI Click Button "Add New"
    And UI Click Button "Template" with value ""
    Then UI Validate Element Existence By Label "Template" if Exists "false" with value "DefenseFlow Analytics Dashboard"
    And UI Click Button "Cancel"

  @SID_36
  Scenario: non-admin user can't navigate to DF dashboard
    When UI Open "Dashboards" Tab
    Then UI Validate Element Existence By Label "DefenseFlow Analytics Dashboard" if Exists "false"

  @SID_37
  Scenario: can't see the admins report
    Then REST Validate existence reports
      | reportName          | isExist |
      | 2DaysBeforeReport   | false   |
      | 100DaysBeforeReport | false   |

  @SID_38
  Scenario: Get POs by Security_Monitor_user user by rest
    Then REST Request "POST" for "DefenseFlow->getPOs"
      | type                 | value |
      | Returned status code | 404   |

  @SID_39
  Scenario: Search for bad logs
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
      | ALL     | error      | NOT_EXPECTED |

  @SID_40
  Scenario: Cleanup
    When UI Open "Configurations" Tab
    Then UI logout and close browser