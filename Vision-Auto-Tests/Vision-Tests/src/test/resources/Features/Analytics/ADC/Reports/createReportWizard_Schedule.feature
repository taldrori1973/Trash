@ADC_Report @TC105971

Feature: DPM - Report Schedule Wizard


  @SID_1
  Scenario: Login and navigate to the Reports Wizard
    * REST Vision Install License Request "vision-reporting-module-ADC"
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "ADC Reports" page via homePage
    Then UI Validate Element Existence By Label "Add New" if Exists "true"



  # "Scheduling Month"

  @SID_2

  Scenario: ADC - Add new Report Scheduling Month
    Given UI "Create" DPMReport With Name "MonthScheduleReportADC"
      | reportType | Application Report            |
      | Schedule   | Run Every:Monthly,On Time:+5m |

    Given UI "Validate" DPMReport With Name "MonthScheduleReportADC"
      | reportType | Virtual Service Report        |
      | Schedule   | Run Every:Monthly,On Time:+5m |



  # "Scheduling Day"
  @SID_3
  Scenario: ADC - Add new Report Scheduling Day
    Given UI "Create" DPMReport With Name "SchedulingDayADC"
      | reportType            | Application Report            |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:30m                     |
      | Schedule              | Run Every:Daily,On Time:+2m   |

    When Sleep "15"
    And UI Click Button "Reports List Item" with value "SchedulingDayADC"
    Then UI Click Button "Generate Now" with value "SchedulingDayADC"
    When Sleep "300"
    Then UI Validate Element Existence By Label "Log Preview" if Exists "true" with value "SchedulingDayADC"

    Given UI "Validate" DPMReport With Name "SchedulingDayADC"
      | reportType            | Application Report            |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:30m                     |
      | Schedule              | Run Every:Daily,On Time:+2m   |




  # "Scheduling Week"
  @SID_4
  Scenario: ADC - Add new Report Scheduling Week
    Given UI "Create" DPMReport With Name "WeekScheduleReportADC"
      | reportType            | Application Report            |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:30m                     |
      | Schedule              | Run Every:Weekly On Time:+5m  |


    Then UI "Validate" DPMReport With Name "WeekScheduleReportADC"
      | reportType            | Application Report            |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:30m                     |
      | Schedule              | Run Every:Weekly On Time:+5m  |




  # "Scheduling Once"
  @SID_5
  Scenario: ADC - Add new Report Scheduling Once
    Given UI "Create" DPMReport With Name "OnceScheduleReportADC"
      | reportType            | Application Report            |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:30m                     |
      | Schedule              | Run Every:Once,On Time:10:00  |


    Given UI "Validate" DPMReport With Name "OnceScheduleReportADC"
      | reportType            | Application Report            |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:30m                     |
      | Schedule              | Run Every:Once,On Time:10:00  |



#  # "Scheduling Hour"
#    #to do : on time + 2
#  Scenario: TC103849 - ADC - Add new Report Scheduling Hour
#    Given UI "Create" DPMReport With Name "HourScheduleReport"
#      | reportType            | Virtual Service Report                                          |
#      | devices               | virts:[Rejith:88, Rejith:443]                     |
#      | Time Definitions.Date | Quick:30m                                                       |
#      | Schedule              | Run Every:Hour,On Time:+6m                                      |
#
#
#    Then UI "Validate" DPMReport With Name "HourScheduleReport"
#      | reportType            | Virtual Service Report                                          |
#      | devices               | virts:[Rejith:88, Rejith:443]                     |
#      | Time Definitions.Date | Quick:30m                                                       |
#      | Schedule              | Run Every:Hour,On Time:+6m                                      |



  @SID_6
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
