@Analytics_ADC @TC106011
Feature: AMS Report Schedule Wizard

  @SID_1
  Scenario: Login and navigate to the Reports Wizard
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then CLI copy "/home/radware/Scripts/get_scheduled_report_value.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    And UI Navigate to "AMS Reports" page via homePage
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

  # "Scheduling Month"
  @SID_2
  Scenario: Add new Report Scheduling Month
    Given UI "Create" Report With Name "MonthScheduleReport"
      | reportType | DefensePro Analytics Dashboard |
      | Schedule   | Run Every:Monthly,On Time:+2m  |

    Then UI "Validate" Report With Name "MonthScheduleReport"
      | reportType | DefensePro Analytics Dashboard |
      | Schedule   | Run Every:Monthly,On Time:+2m  |
#    Then CLI Run remote linux Command "/get_scheduled_report_value.sh MonthScheduleReport" on "ROOT_SERVER_CLI"
#    Then CLI Operations - Verify that output contains regex "0 (\d{2}) (\d{2}) (\d{1,2}) (\d{1,2}) \? \*"

  # "Scheduling Day"
  @SID_3
  Scenario: Add new Report Scheduling Day
    Given UI "Create" Report With Name "DayScheduleReport"
      | reportType            | DefensePro Analytics Dashboard |
      | Time Definitions.Date | Quick:30m                      |
      | Schedule              | Run Every:Daily,On Time:+4m    |
    Then CLI Run remote linux Command "/get_scheduled_report_value.sh DayScheduleReport" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "0 (\d{1,2}) (\d{1,2}) \? \* \*"
    Then UI "Validate" Report With Name "DayScheduleReport"
      | reportType            | DefensePro Analytics Dashboard |
      | Time Definitions.Date | Quick:30m                      |


  # "Scheduling Week"
  @SID_4
  Scenario: Add new Report Scheduling Week
    Given UI "Create" Report With Name "WeekScheduleReport"
      | reportType            | DefensePro Analytics Dashboard               |
      | devices               | index:10;index:11,ports:[1], policies:[BDOS] |
      | Time Definitions.Date | Quick:30m                                    |
      | Schedule              | Run Every:Weekly,On Time:+3m                 |

    Then UI "Validate" Report With Name "WeekScheduleReport"
      | reportType            | DefensePro Analytics Dashboard               |
      | devices               | index:10;index:11,ports:[1], policies:[BDOS] |
      | Time Definitions.Date | Quick:30m                                    |
      | Schedule              | Run Every:Weekly,On Time:+3m                 |

  # "Scheduling Once"
  @SID_5
  Scenario: Add new Report Scheduling Once
    Given UI "Create" Report With Name "OnceScheduleReport"
      | reportType            | DefensePro Analytics Dashboard  |
      | Time Definitions.Date | Quick:30m                       |
      | Schedule              | Run Every:Once,On Time:11:59 PM |

  @SID_6
  Scenario: validate Scheduling Once
    Then UI "Validate" Report With Name "OnceScheduleReport"
      | reportType            | DefensePro Analytics Dashboard  |
      | Time Definitions.Date | Quick:30m                       |
      | Schedule              | Run Every:Once,On Time:11:59 PM |
#    Then CLI Run remote linux Command "/get_scheduled_report_value.sh OnceScheduleReport" on "ROOT_SERVER_CLI"
#    Then CLI Operations - Verify that output contains regex "0 59 23 (\d{1,2}) (\d{1,2}) \? 2020"

  @SID_7
  Scenario: TC102002 - Add new Report Scheduling Hour
    Given UI "Create" Report With Name "day2ScheduleReport"
      | reportType            | DefensePro Analytics Dashboard               |
      | devices               | index:10;index:11,ports:[1], policies:[BDOS] |
      | Time Definitions.Date | Quick:30m                                    |
      | Schedule              | Run Every:Daily,On Time:+5m                  |

    Then UI "Validate" Report With Name "day2ScheduleReport"
      | reportType            | DefensePro Analytics Dashboard               |
      | devices               | index:10;index:11,ports:[1], policies:[BDOS] |
      | Time Definitions.Date | Quick:30m                                    |
      | Schedule              | Run Every:Daily,On Time:+5m                  |

  @SID_8
  Scenario: validate Scheduling Hour
#    Then CLI Run remote linux Command "/get_scheduled_report_value.sh day2ScheduleReport" on "ROOT_SERVER_CLI"
#    Then CLI Operations - Verify that output contains regex "0 (\d{2}) (\d{2}) \? \* \*"

  @SID_9
  Scenario: Sleep and verify daily report were generated
    When Sleep "430"
    Then UI Navigate to "AMS Alerts" page via homePage
    Then UI Navigate to "AMS Reports" page via homePage
    Then UI Click Button "Reports List Item" with value "DayScheduleReport"
    Then UI Validate Element Existence By Label "Log Preview" if Exists "true" with value "DayScheduleReport"

  @SID_10
  Scenario: Sleep and verify monthly report were generated
    Then UI Navigate to "AMS Alerts" page via homePage
    Then UI Navigate to "AMS Reports" page via homePage
    Then UI Click Button "Reports List Item" with value "MonthScheduleReport"
    Then UI Validate Element Existence By Label "Log Preview" if Exists "true" with value "MonthScheduleReport"

  @SID_11
  Scenario: Sleep and verify weekly report were generated
    Then UI Navigate to "AMS Alerts" page via homePage
    Then UI Navigate to "AMS Reports" page via homePage
    Then UI Click Button "Reports List Item" with value "WeekScheduleReport"
    Then UI Validate Element Existence By Label "Log Preview" if Exists "true" with value "WeekScheduleReport"

  @SID_12
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
