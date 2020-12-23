@Analytics_ADC @TC106011 
Feature: AMS Report Schedule Wizard

  
  @SID_1
  Scenario: Login and navigate to the Reports Wizard
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then CLI copy "/home/radware/Scripts/get_scheduled_report_value.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    And UI Navigate to "AMS Reports" page via homePage


  # "Scheduling Month"

  @SID_2
  Scenario: Add new Report Scheduling Month
    Then UI "Create" Report With Name "MonthScheduleReport"
      | Template-1 | reportType:DefensePro Analytics ,devices:[All] |
      | Schedule   | Run Every:Monthly,On Time:+2m  |

    Then UI "Validate" Report With Name "MonthScheduleReport"
      | Template-1 | reportType:DefensePro Analytics ,devices:[All] |
      | Schedule   | Run Every:Monthly,On Time:+2m  |
#    Then CLI Run remote linux Command "/get_scheduled_report_value.sh MonthScheduleReport" on "ROOT_SERVER_CLI"
#    Then CLI Operations - Verify that output contains regex "0 (\d{2}) (\d{2}) (\d{1,2}) (\d{1,2}) \? \*"

  # "Scheduling Day"
  @SID_3
  Scenario: Add new Report Scheduling Day
    Given UI "Create" Report With Name "DayScheduleReport"
      | Template-1 | reportType:DefensePro Analytics ,devices:[All] |
      | Time Definitions.Date | Quick:30m                           |
      | Schedule              | Run Every:Daily,On Time:+4m    |
#    Then CLI Run remote linux Command "/get_scheduled_report_value.sh DayScheduleReport" on "ROOT_SERVER_CLI"
#    Then CLI Operations - Verify that output contains regex "0 (\d{1,2}) (\d{1,2}) \? \* \*"
    Then UI "Validate" Report With Name "DayScheduleReport"
      | Template-1 | reportType:DefensePro Analytics ,devices:[All] |
      | Time Definitions.Date | Quick:30m                           |
      | Schedule              | Run Every:Daily,On Time:+4m    |

  # "Scheduling Week"
  @SID_4
  Scenario: Add new Report Scheduling Week
    Given UI "Create" Report With Name "WeekScheduleReport"
      | Template-1 | reportType:DefensePro Analytics ,devices:[{deviceIndex:10}, {deviceIndex:11,  devicePorts:[1], devicePolicies:[BDOS]}] |
      | Time Definitions.Date | Quick:30m   |
      | Schedule              | Run Every:Weekly,On Time:+3m                 |

    Then UI "Validate" Report With Name "WeekScheduleReport"
      | Template-1 | reportType:DefensePro Analytics ,devices:[{deviceIndex:10}, {deviceIndex:11,  devicePorts:[1], devicePolicies:[BDOS]}] |
      | Time Definitions.Date | Quick:30m      |
      | Schedule              | Run Every:Weekly,On Time:+3m                 |
  # "Scheduling Once"
  
  @SID_5
  Scenario: Add new Report Scheduling Once
    Given UI "Create" Report With Name "OnceScheduleReport"
      | Template-1 | reportType:DefensePro Analytics ,devices:[All] |
      | Time Definitions.Date | Quick:30m                           |
#      | Schedule              | Run Every:Once,On Time: 23:59  |
      | Schedule              | Run Every:Once, On Time:+6H                                                                        |
  @SID_6
  Scenario: validate Scheduling Once
    Then UI "Validate" Report With Name "OnceScheduleReport"
      | Template-1 | reportType:DefensePro Analytics ,devices:[All] |
      | Time Definitions.Date | Quick:30m                                                                                        |
#      | Schedule              | Run Every:Once,On Time: 23:59   |
      | Schedule              | Run Every:Once, On Time:+6H                                                                        |
#    Then CLI Run remote linux Command "/get_scheduled_report_value.sh OnceScheduleReport" on "ROOT_SERVER_CLI"
#    Then CLI Operations - Verify that output contains regex "0 59 23 (\d{1,2}) (\d{1,2}) \? 2020"

  @SID_7
  Scenario: TC102002 - Add new Report Scheduling Hour
    Given UI "Create" Report With Name "day2ScheduleReport"
      | Template-1 | reportType:DefensePro Analytics ,devices:[{deviceIndex:10}, {deviceIndex:11,  devicePorts:[1], devicePolicies:[BDOS]}] |
      | Time Definitions.Date | Quick:30m                                                                                        |
      | Schedule              | Run Every:Daily,On Time:+5m                  |


    Then UI "Validate" Report With Name "day2ScheduleReport"
      | Template-1 | reportType:DefensePro Analytics ,devices:[{deviceIndex:10}, {deviceIndex:11,  devicePorts:[1], devicePolicies:[BDOS]}] |
      | Time Definitions.Date | Quick:30m                                                                                        |
      | Schedule              | Run Every:Daily,On Time:+5m                  |

  @SID_8
  Scenario: validate Scheduling Hour
#    Then CLI Run remote linux Command "/get_scheduled_report_value.sh day2ScheduleReport" on "ROOT_SERVER_CLI"
#    Then CLI Operations - Verify that output contains regex "0 (\d{2}) (\d{2}) \? \* \*"

  @SID_9
  Scenario: Sleep and verify daily report were generated
    When Sleep "430"
    Then UI Click Button "My Report" with value "DayScheduleReport"
    Then UI Validate Element Existence By Label "Generate By Schedule" if Exists "true" with value "DayScheduleReport,on"

  @SID_10
  Scenario: Sleep and verify monthly report were generated
    Then UI Click Button "My Report" with value "MonthScheduleReport"
    Then UI Validate Element Existence By Label "Generate By Schedule" if Exists "true" with value "MonthScheduleReport,on"

  @SID_11
  Scenario: Sleep and verify weekly report were generated
    Then UI Click Button "My Report" with value "WeekScheduleReport"
    Then UI Validate Element Existence By Label "Generate By Schedule" if Exists "true" with value "WeekScheduleReport,on"

  @SID_12
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
