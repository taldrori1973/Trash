@ADC_Report @TC105973

Feature: DPM - ADC Reports RBAC

  @SID_1
  Scenario: Clean system data
#    * CLI kill all simulator attacks on current vision
#    * REST Delete ES index "vrm-scheduled-report-*"
    * CLI Clear vision logs

  @SID_2
  Scenario: ADC - Login as admin and create two types of reports
    * REST Vision Install License Request "vision-reporting-module-ADC"
    Given UI Login with user "radware" and password "radware"
    When UI Navigate to "ADC Reports" page via homePage
    Given UI "Create" Report With Name "App Report"
      | Template | reportType:Application , Widgets:[Requests per Second] ,Applications:[6:80] |
    Then UI "Validate" Report With Name "App Report"
      | Template | reportType:Application , Widgets:[Requests per Second] ,Applications:[6:80] |


#    Then UI "Create" DPMReport With Name "All_apps"
#      | reportType | DefensePro Behavioral Protections Dashboard |
#      | devices    | virts:[Rejith:88, Rejith:443]               |

    Given UI "Create" Report With Name "Alteon_172.17.164.17 Report"
      | Template | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.17] |
    Then UI "Validate" Report With Name "Alteon_172.17.164.17 Report"
      | Template | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.17] |


#    Then UI "Create" DPMReport With Name "All_devices"
#      | reportType | Network Report         |
#      | devices    | virts:[Rejith:88, Rejith:443] |


    Then UI Click Button "My Report Tab"
    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "App Report"
    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "Alteon_172.17.164.17 Report"

    Then UI Delete Report With Name "App Report"
    Then UI Delete Report With Name "Alteon_172.17.164.17 Report"


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
