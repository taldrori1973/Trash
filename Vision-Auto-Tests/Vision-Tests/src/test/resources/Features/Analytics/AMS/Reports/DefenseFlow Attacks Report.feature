@TC111798
Feature: DefenseFlow Attacks Reports

  #  ==========================================Setup================================================
  @SID_1
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "df-attack*"
    * REST Delete ES index "vrm-scheduled-report-*"
    * REST Delete ES index "vrm-scheduled-report-result-*"
    * CLI Clear vision logs

  @SID_31
  Scenario: Change DF managment IP to IP of Generic Linux
    When CLI Operations - Run Radware Session command "system df management-ip set 172.17.164.10"
    When CLI Operations - Run Radware Session command "system df management-ip get"
    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 172.17.164.10"

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
  Scenario: Change DF management IP to IP of DefenseFlow
    When CLI Run remote linux Command on "RADWARE_SERVER_CLI"
      | "system df management-ip set " |
      | #dfIP                          |

  @SID_4
  Scenario:Login and copy uVision_get_scheduled_report_value.sh file to server
    Given UI Login with user "sys_admin" and password "radware"
    Then CLI copy "/home/radware/Scripts/uVision_get_scheduled_report_value.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"

  @SID_5
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

  @SID_6
  Scenario: Navigate to AMS report
    And UI Navigate to "AMS Reports" page via homePage
    Then UI Validate Element Existence By Label "New Report Tab" if Exists "true"

  # =============================================Overall===========================================================
  @SID_7
  Scenario: Create DefenseFlow report
    When UI "Create" Report With Name "OverallDFReport"
      | Template | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Duration,Top Attack Destination,Top Attacks by Protocol],Protected Objects:[All] |
      | Logo     | reportLogoPNG.png                                                                                                                         |
    Then UI "Validate" Report With Name "OverallDFReport"
      | Template | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Duration,Top Attack Destination,Top Attacks by Protocol],Protected Objects:[All] |
      | Logo     | reportLogoPNG.png                                                                                                                         |
    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "OverallDFReport"

  @SID_8
  Scenario: Edit report
    When UI "Edit" Report With Name "OverallDFReport"
      | Template              | reportType:DefenseFlow Analytics,Protected Objects:[PO_300]      |
      | Logo                  | reportLogoPNG.png                                                |
      | Time Definitions.Date | Quick:15m                                                        |
      | Share                 | Email:[DF_attack@report.local],Subject:DefenseFlow Attack report |
      | Format                | Select: CSV                                                      |


  @SID_9
  Scenario: Clear SMTP server log files
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/reportuser" on "GENERIC_LINUX_SERVER"

  @SID_10
  Scenario: Generate Report
    Then UI "Generate" Report With Name "OverallDFReport"
      | timeOut | 60 |

  @SID_11
  Scenario: Delete report
    When UI Click Button "Delete" with value "OverallDFReport"
    When UI Click Button "Delete.Approve"
    Then UI Validate Element Existence By Label "My Report" if Exists "false" with value "OverallDFReport"

  @SID_12
  Scenario: Validate Report Email received content
    Then CLI Run remote linux Command "cat /var/spool/mail/reportuser > /tmp/reportdelivery.log" on "GENERIC_LINUX_SERVER"
    Then CLI Run linux Command "grep "X-Original-To: DF_attack@report.local" /var/spool/mail/reportuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"


  @SID_13
  Scenario: Create New Report with Default Values
    When UI "Create" Report With Name "deliveryDF"
      | Template | reportType:DefenseFlow Analytics, Protected Objects:[All]                                    |
      | Share    | Email:[automation.vision1@radware.com, also@report.local],Subject:report delivery Subject DF |
    Then UI "Generate" Report With Name "deliveryDF"
      | timeOut | 100 |

  @SID_14
  Scenario: Create New Report with Monthly schedule
    When UI "Create" Report With Name "scheduleMonthlyDF"
      | Template | reportType:DefenseFlow Analytics, Protected Objects:[All] |
      | Schedule | Run Every:Monthly,On Time:+2m                             |

    Then UI "Validate" Report With Name "scheduleMonthlyDF"
      | Template | reportType:DefenseFlow Analytics, Protected Objects:[All] |
      | Schedule | Run Every:Monthly,On Time:+2m                             |

  @SID_15
  Scenario: Create New Report with With daily schedule
    When UI "Create" Report With Name "scheduleDailyDF"
      | Template | reportType:DefenseFlow Analytics, Protected Objects:[All] |
      | Schedule | Run Every:Daily,On Time:+2m                               |

    Then UI "Validate" Report With Name "scheduleDailyDF"
      | Template | reportType:DefenseFlow Analytics, Protected Objects:[All] |
      | Schedule | Run Every:Daily,On Time:+2m                               |

  @SID_16
  Scenario: validation if reports generated after the expected time
    When Sleep "150"
    # validate if scheduleMonthlyDF generated in UI
    When UI Click Button "My Report" with value "scheduleMonthlyDF"
    Then UI Validate Element Existence By Label "Generate Report Manually" if Exists "true" with value "scheduleMonthlyDF"

    # validate if scheduleDailyDF generated in UI
    When UI Click Button "My Report" with value "scheduleDailyDF"
    Then UI Validate Element Existence By Label "Generate Report Manually" if Exists "true" with value "scheduleDailyDF"

    # validate scheduleMonthlyDF schedule regex matchs in CLI
    Then CLI Run remote linux Command "/uVision_get_scheduled_report_value.sh scheduleMonthlyDF" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "0 (\d{2}) (\d{2}) (\d{1,2}) (\d{1,2}) \? \*"

    # validate scheduleDailyDF schedule regex matchs in CLI
    Then CLI Run remote linux Command "/uVision_get_scheduled_report_value.sh scheduleDailyDF" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "0 (\d{2}) (\d{2}) \? \* \*"

  @SID_17
  Scenario: Cleanup
    * REST Delete ES index "df-attack*"
    * REST Delete ES index "vrm-scheduled-report-*"
    * REST Delete ES index "vrm-scheduled-report-result-*"


    # new attacks one occurred before 100 days, and another before 25 hours
  @SID_18
  Scenario: Run DF simulator
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_100_100D_Before.sh " |
      | #visionIP                                                   |
      | " Terminated"                                               |
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_300_25H_Before.sh " |
      | #visionIP                                                  |
      | " Terminated"                                              |

  @SID_19
  Scenario: validate time selection -Quick range- Report
    Given UI "Create" Report With Name "1WeakBeforeReport"
      | Template              | reportType:DefenseFlow Analytics,Protected Objects:[PO_300] |
      | Time Definitions.Date | Quick:1W                                                    |
      | Format                | Select: CSV                                                 |
    Then UI "Validate" Report With Name "1WeakBeforeReport"
      | Template              | reportType:DefenseFlow Analytics,Protected Objects:[PO_300] |
      | Time Definitions.Date | Quick:1W                                                    |
      | Format                | Select: CSV                                                 |
    Then UI "Generate" Report With Name "1WeakBeforeReport"
      | timeOut | 100 |

  @SID_20
  Scenario: Download CSV from UI page
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER" and wait 90 seconds
      | "/home/radware/Scripts/download_report_file.sh " |
      | #visionIP                                        |
      | " 1WeakBeforeReport"                             |

  @SID_22
  Scenario: validate time selection -Absolute- report
    Given UI "Create" Report With Name "100DaysBeforeReport"
      | Template              | reportType:DefenseFlow Analytics,Protected Objects:[PO_200,PO_100],Widgets:[Top Attacks by Duration,Top Attack Destination,Top Attacks by Protocol] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                    |
      | Format                | Select: CSV                                                                                                                                         |
    Then UI "Validate" Report With Name "100DaysBeforeReport"
      | Template              | reportType:DefenseFlow Analytics,Protected Objects:[PO_200,PO_100],Widgets:[Top Attacks by Duration,Top Attack Destination,Top Attacks by Protocol] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                    |
      | Format                | Select: CSV                                                                                                                                         |
    Then UI "Generate" Report With Name "100DaysBeforeReport"
      | timeOut | 100 |

  @SID_23
  Scenario: Download CSV from UI page
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER" and wait 90 seconds
      | "/home/radware/Scripts/download_report_file.sh " |
      | #visionIP                                        |
      | " 1WeakBeforeReport"                             |

  @SID_24
  Scenario: logout
    When UI Navigate to "VISION SETTINGS" page via homePage
    And UI Go To Vision
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
    And UI Set Checkbox "Enable" To "false"
    Then UI Click Button "Submit"
    When UI logout and close browser

  @SID_25
  Scenario Outline: login with sec_mon user
    Given UI Login with user "<username>" and password "<password>"
    Then REST Login with user "<username>" and password "<password>"
    And UI Navigate to "AMS Reports" page via homePage
    Then UI Validate Element Existence By Label "My Report" if Exists "false" with value "2DaysBeforeReport"
    Then UI Validate Element Existence By Label "My Report" if Exists "false" with value "100DaysBeforeReport"
    Examples:
      | username | password |
      | sec_mon  | radware  |

  @SID_26
  Scenario: non-admin user can't select DF in report
    When UI Click Button "Add New"
    And UI Click Button "Template" with value ""
    Then UI Validate Element Existence By Label "Template" if Exists "false" with value "DefenseFlow Analytics"
    And UI Click Button "cancel"

  @SID_27
  Scenario: non-admin user can't navigate to DF dashboard
    Then UI Validate user rbac
      | operations            | accesses |
      | DefenseFlow Analytics | no       |

  @SID_28
  Scenario: can't see the admins report
    Then REST Validate existence reports
      | reportName          | isExist |
      | 2DaysBeforeReport   | false   |
      | 100DaysBeforeReport | false   |

  @SID_29
  Scenario: Get POs by Security_Monitor_user user by rest
    Then REST Request "POST" for "DefenseFlow->getPOs"
      | type                 | value |
      | Returned status code | 403   |

  @SID_30
  Scenario: Search for bad logs
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
      | ALL     | error      | NOT_EXPECTED |

  @SID_31
  Scenario: Cleanup
    When UI Open "Configurations" Tab
    Then UI logout and close browser

  @SID_32
  Scenario: Wait Protected Objects
    Then Wait For PO's appearance timeout 10 minutes