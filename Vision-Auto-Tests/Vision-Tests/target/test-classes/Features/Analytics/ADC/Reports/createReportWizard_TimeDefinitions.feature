@ADC_Report @TC105972

Feature: DPM - Report Wizard_Time_Definitions

#  @VRM_Time_1
  @SID_1
  Scenario: Clean system data before test
#    * CLI kill all simulator attacks on current vision
#    * REST Delete ES index "dp-*"
    * CLI Clear vision logs


  @SID_2
  Scenario: Run DP simulator PCAPs for TOP FORWARDED ATTACK SOURCES
#    Given CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10 and wait 180 seconds with attack ID


  @SID_3
  Scenario: Login and navigate to the Reports Wizard
    * REST Vision Install License Request "vision-reporting-module-ADC"
    Given UI Login with user "sys_admin" and password "radware"
#    When UI "Create" "DefensePro" with index 10 on "Default" site
    When UI Navigate to "ADC Reports" page via homePage
    Then UI Validate Element Existence By Label "Add New" if Exists "true"


  @SID_4
  Scenario: ADC - Add new Report 15 mim from type Virtual Service Report
    # "TimeFrame 15 mim"
    Given UI "Create" DPMReport With Name "ADCtestReport_15m"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:15m                  |

    Then UI "Validate" DPMReport With Name "ADCtestReport_15m"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:15m                  |


  @SID_5
  Scenario: TC103851- ADC - Add new Report 30 mim from type Virtual Service Report
    # "TimeFrame 30 mim"
    Given UI "Create" DPMReport With Name "ADCtestReport_30m"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:30m                  |

    Then UI "Validate" DPMReport With Name "ADCtestReport_30m"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:30m                  |


  @SID_6
  Scenario: ADC - Add new Report 1 Hour from type Virtual Service Report
    # "TimeFrame 1 Hour"
    Given UI "Create" DPMReport With Name "ADCtestReport_1H"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:1H                   |

    Then UI "Validate" DPMReport With Name "ADCtestReport_1H"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:1H                   |


  @SID_7
  Scenario: ADC - Add new Report 1 Day from type Virtual Service Report
    # "TimeFrame 1 Day"
    Given UI "Create" DPMReport With Name "ADCtestReport_1D"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:1D                   |
    Then UI "Validate" DPMReport With Name "ADCtestReport_1D"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:1D                   |

  @SID_8
  Scenario:  ADC - Add new Report 1 Week from type Virtual Service Report
    # "TimeFrame 1 Week"
    Given UI "Create" DPMReport With Name "ADCtestReport_1W"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:1W                   |

    Then UI "Validate" DPMReport With Name "ADCtestReport_1W"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:1W                   |


  @SID_9
  Scenario: ADC - Add new Report 1 Month from type Virtual Service Report
    # "TimeFrame 1 Month"
    Given UI "Create" DPMReport With Name "ADCtestReport_1M"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:1M                   |

    Then UI "Validate" DPMReport With Name "ADCtestReport_1M"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:1M                   |

  @SID_10
  Scenario: DE43518 - ADC - Add new Report 3 Month from type DefensePro Baseline BDOS Dashboard
    # "TimeFrame 3 Month"
    Given UI "Create" DPMReport With Name "ADCtestReport_3M"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:3M                   |
    Then UI "Validate" DPMReport With Name "ADCtestReport_3M"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:3M                   |
#
# The Folllowing Scenarios not relevant for ADC , a defect was closed as "Not a defect" for Quick Time options not avaiable
#  @SID_11
#  Scenario: DE43518 - ADC - Add new Report Today from type Application Report
#    ## "TimeFrame Today"
#    Given UI "Create" DPMReport With Name "ADCtestReport_Today"
#      | reportType            | Application Report         |
#      | devices               | virts:[Rejith_32326515:88] |
#      | Time Definitions.Date | Quick:Today                |
#    Then UI "Validate" DPMReport With Name "ADCtestReport_Today"
#      | reportType            | Application Report         |
#      | devices               | virts:[Rejith_32326515:88] |
#      | Time Definitions.Date | Quick:Today                |
#
#
#  @SID_12
#  Scenario: DE43518 - ADC - Add new Report This Week from type Application Report
#    # "TimeFrame This Week"
#    Given UI "Create" DPMReport With Name "ADCtestReport_This_Week"
#      | reportType            | Application Report         |
#      | devices               | virts:[Rejith_32326515:88] |
#      | Time Definitions.Date | Quick:This Week            |
#    Then UI "Validate" DPMReport With Name "ADCtestReport_This_Week"
#      | reportType            | Application Report         |
#      | devices               | virts:[Rejith_32326515:88] |
#      | Time Definitions.Date | Quick:This Week            |
#
#
#  @SID_13
#  Scenario: DE43518 - ADC - Add new Report test This month from type Application Report
#    Given UI "Create" DPMReport With Name "ADCtestReport_This_Month"
#      | reportType            | Application Report         |
#      | devices               | virts:[Rejith_32326515:88] |
#      | Time Definitions.Date | Quick:This Month           |
#    Then UI "Validate" DPMReport With Name "ADCtestReport_This_Month"
#      | reportType            | Application Report         |
#      | devices               | virts:[Rejith_32326515:88] |
#      | Time Definitions.Date | Quick:This Month           |
#
#
#  @SID_14
#  Scenario: DE43518 - ADC - Add new Report Quarter from type Application Report
#    # "TimeFrame Quarter"
#    Given UI "Create" DPMReport With Name "ADCtestReport_This_Quarter"
#      | reportType            | Application Report         |
#      | devices               | virts:[Rejith_32326515:88] |
#      | Time Definitions.Date | Quick:Quarter              |
#
#    Then UI "Create" DPMReport With Name "ADCtestReport_This_Quarter"
#      | reportType            | Application Report         |
#      | devices               | virts:[Rejith_32326515:88] |
#      | Time Definitions.Date | Quick:Quarter              |

#@stam
#  @SID_15
#  Scenario: DE43518 - ADC - Add new Report Absolute from type DefensePro Baseline DNS Dashboard
#    # "TimeFrame Absolute"
#    Given UI "Create" DPMReport With Name "ADCtestReport_Absolute"
#      | reportType            | Application Report                 |
#      | devices               | virts:[Rejith_32326515:88]         |
#      | Time Definitions.Date | Absolute:[Feb 27, 1971 01:00, +1d] |
#    Then UI "Validate" DPMReport With Name "ADCtestReport_Absolute"
#      | reportType            | Application Report                 |
#      | devices               | virts:[Rejith_32326515:88]         |
#      | Time Definitions.Date | Absolute:[Feb 27, 1971 01:00, +1d] |


  @SID_16
  Scenario: DE43518 - ADC - Add new Report Relative 1 hour from type Application Report
    # "TimeFrame Relative 1 Hours"
    Given UI "Create" DPMReport With Name "ADCRelative_1_Hour"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Relative:[Hours,1]         |
    Then UI "Validate" DPMReport With Name "ADCRelative_1_Hour"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Relative:[Hours,1]         |


  @SID_17
  Scenario: DE43518 - ADC - Add new Report Relative 2 Days from type Application Report
    # "TimeFrame Relative 2 Days"
    Given UI "Create" DPMReport With Name "ADCRelative_2_Days"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Relative:[Days,2]          |
    Then UI "Validate" DPMReport With Name "ADCRelative_2_Days"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Relative:[Days,2]          |


  @SID_18
  Scenario: DE43518 - ADC - Add new Report Relative 3 Weeks from type Application Report
    # "TimeFrame Relative 3 Weeks"
    Given UI "Create" DPMReport With Name "ADCRelative_3_Weeks"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Relative:[Weeks,3]         |
    Then UI "Validate" DPMReport With Name "ADCRelative_3_Weeks"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Relative:[Weeks,3]         |


  @SID_19
  Scenario: DE43518 - ADC - Add new Report Relative 4 Month from type Application Report
    # "TimeFrame Relative 4 Month"
    Given UI "Create" DPMReport With Name "ADCRelative_4_Months"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Relative:[Months,4]        |
    Then UI "Validate" DPMReport With Name "ADCRelative_4_Months"
      | reportType            | Application Report         |
      | devices               | virts:[Rejith_32326515:88] |
      | Time Definitions.Date | Relative:[Months,4]        |


#  @SID_20
#  Scenario: DE43518 - ADC - Add new Report Previous Month from type Application Report
#    # "TimeFrame Quick Previous Month"
#    Given UI "Create" DPMReport With Name "ADCPrevious Month"
#      | reportType            | Application Report         |
#      | devices               | virts:[Rejith_32326515:88] |
#      | Time Definitions.Date | Quick:Previous Month       |
#    Then UI "Validate" DPMReport With Name "ADCPrevious Month"
#      | reportType            | Application Report         |
#      | devices               | virts:[Rejith_32326515:88] |
#      | Time Definitions.Date | Quick:Previous Month       |

  @SID_21
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
