@ADC_Report @TC105973
Feature: DPM - ADC Reports RBAC

  @SID_1
  Scenario: Clean system data and Prepare simulators
#    * CLI kill all simulator attacks on current vision
#    * REST Delete ES index "vrm-scheduled-report-*"
    * CLI Clear vision logs
    Given Init Simulators
    * REST Vision Install License Request "vision-reporting-module-ADC"
    Given REST Login with user "radware" and password "radware"
    Then CLI Upload Device Driver For "Alteon" Version "32.4.0.0"
    Then REST Add Simulators
    When CLI validate service "all" status is "up" and health is "healthy" retry for 600 seconds

  @SID_2
  Scenario: ADC - Login as admin and create two types of reports
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "ADC Reports" page via homePage
    Given UI "Create" Report With Name "App Report"
      | Application | Alteon_Sim_Set_1:80                                    |
      | Template    | reportType:Application , Widgets:[Requests per Second] |
    Then UI "Validate" Report With Name "App Report"
      | Application | Alteon_Sim_Set_1:80                                    |
      | Template    | reportType:Application , Widgets:[Requests per Second] |


#    Then UI "Create" DPMReport With Name "All_apps"
#      | reportType | DefensePro Behavioral Protections Dashboard |
#      | devices    | virts:[Rejith:88, Rejith:443]               |

    Given UI "Create" Report With Name "Alteon_Sim_Set_2 Report"
      | Application | Alteon_Sim_Set_2                                                    |
      | Template    | reportType:System and Network , Widgets:[Ports Traffic Information] |
    Then UI "Validate" Report With Name "Alteon_Sim_Set_2 Report"
      | Application | Alteon_Sim_Set_2                                                    |
      | Template    | reportType:System and Network , Widgets:[Ports Traffic Information] |


#    Then UI "Create" DPMReport With Name "All_devices"
#      | reportType | Network Report         |
#      | devices    | virts:[Rejith:88, Rejith:443] |


    Then UI Click Button "My Report Tab"
    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "App Report"
    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "Alteon_Sim_Set_2 Report"

    Then UI Delete Report With Name "App Report"
    Then UI Delete Report With Name "Alteon_Sim_Set_2 Report"


  @SID_3
  Scenario: Reports RBAC check logs
    Then UI logout and close browser
    And CLI Check if logs contains
      | logType     | expression                   | isExpected   |
      | ES          | fatal\|error                 | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error                 | NOT_EXPECTED |
      | MAINTENANCE | *.traffic-events-dashboard*. | IGNORE       |
      | JBOSS       | fatal                        | NOT_EXPECTED |
      | TOMCAT      | fatal                        | NOT_EXPECTED |
      | TOMCAT2     | fatal                        | NOT_EXPECTED |

  @SID_4
  Scenario: Stop and delete simulators
    Given Stop Simulators
    Then REST Delete Simulators