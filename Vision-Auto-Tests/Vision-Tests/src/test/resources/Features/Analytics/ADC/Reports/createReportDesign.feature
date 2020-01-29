@ADC_Report @TC105967

Feature: DPM - Design Report Wizard
  @SID_1
  Scenario: Login and navigate to the Reports WizardRamat HaHayal, Tel Aviv-Yafo
    * REST Vision Install License Request "vision-reporting-module-ADC"
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "ADC Reports" page via homePage
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

  @SID_2
  Scenario: Design the Report - delete all widgets and add one widget
    Given UI "Create" DPMReport With Name "DesignADC"
      | reportType | Application Report                      |
      | devices    | virts:[Rejith_32326515:88]              |
      | Design     | Delete:[ALL], Add:[Requests per Second] |
      | Format     | Select: PDF                             |
    #test report exist20
    When UI Click Button "Expand" with value "DesignADC"
    When UI Click Button "Generate Now" with value "DesignADC"
    When Sleep "30"
    When UI Click Button "Log Preview" with value "DesignADC"
#    Then UI Validate Element Existence By Label "Widget found" if Exists "true" with value "Requests_per_Second-1"
    Then UI Validate Element Existence By Label "Log Preview" if Exists "true" with value "DesignADC"

  @SID_3
  Scenario: Design the Report - edit and delete the top widget
    Given UI "Create" DPMReport With Name "TopWidgetsReport"
      | reportType | Application Report                                      |
      | devices    | virts:[Rejith_32326515:88]                              |
      | Design     | Delete:[ALL], Add:[End-to-End Time,Requests per Second] |
      | Format     | Select: CSV                                             |


    Given UI "Validate" DPMReport With Name "TopWidgetsReport"
      | reportType | Application Report                            |
      | devices    | virts:[Rejith_32326515:88]                    |
      | Design     | Widgets:[End-to-End Time,Requests per Second] |
      | Format     | Select: CSV                                   |


#    When UI Click Button "Expand" with value "TopWidgetsReport"
#    When UI Click Button "Generate Now" with value "TopWidgetsReport"
#    When Sleep "60"
    Then UI Generate and Validate Report With Name "TopWidgetsReport" with Timeout of 300 Seconds
    When UI Click Button "Log Preview" with value "TopWidgetsReport"
#    Then UI Validate Element Existence By Label "Widget found" if Exists "true" with value "Table-1"
    Then UI Validate Element Existence By Label "Log Preview" if Exists "true" with value "TopWidgetsReport"

#
#  @SID_4
#  Scenario: Design the Report - Change position for widget
#    Given UI "Create" DPMReport With Name "changePosition"
#      | reportType | Virtual Service Report   |
#      | Design     | Position:Table,X:0,Y:460 |

  Scenario: Design the Report - edit and delete the top widget
    Given UI "Create" DPMReport With Name "NetworkReport"
      | reportType | Network Report                               |
      | devices    | virts:[Alteon_172.17.164.17]                 |
      | Design     | Delete:[ALL], Add:[Ports Traffic Information] |
      | Format     | Select: CSV                                  |


    Given UI "Validate" DPMReport With Name "NetworkReport"
      | reportType | Network Report                      |
      | devices    | virts:[Alteon_172.17.164.17]        |
      | Design     | Widgets:[Ports Traffic Information] |
      | Format     | Select: CSV                         |

    When UI Click Button "Expand" with value "NetworkReport"
    When UI Click Button "Generate Now" with value "NetworkReport"
    When Sleep "15"
    When UI Click Button "Log Preview" with value "NetworkReport"
    Then UI Validate Element Existence By Label "Log Preview" if Exists "true" with value "NetworkReport"

#
  @SID_5
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |

