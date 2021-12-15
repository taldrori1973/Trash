@ADC_Report @TC105968

Feature: DPM - Report Wizard Creation

  @SID_1
  Scenario: Prepare Simulators, Login and navigate to the Reports Wizard
    Given Init Simulators
    * REST Vision Install License Request "vision-reporting-module-ADC"
    Given REST Login with user "radware" and password "radware"
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.4.0.0-DD-1.00-396.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI Upload Device Driver For "Alteon" Version "32.4.0.0"
    When CLI validate service "all" status is "up" and health is "healthy" retry for 600 seconds
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "ADC Reports" page via homePage


  @SID_2
  Scenario Outline: ADC - Add new Report
    Given UI "Create" Report With Name "<ReportName>"
      | Template              | reportType:Application , Widgets:[Requests per Second,End-to-End Time] ,Applications:[<ApplicationName>] |
      | Time Definitions.Date | Quick:30m                                                                                                |
      | Share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                     |
    Given UI "Validate" Report With Name "<ReportName>"
      | Template              | reportType:Application , Widgets:[Requests per Second,End-to-End Time] ,Applications:[<ApplicationName>] |
      | Time Definitions.Date | Quick:30m                                                                                                |
      | Share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                     |
    Then UI Delete Report With Name "<ReportName>"

    Examples:
      | ReportName       | ApplicationName                                      |
      | ADCcreateReport1 | Rejith_#convertIpToHexa(Alteon_Set_Simulators_2);:80 |

#    When UI Click Button "Edit" with value "createReport1"
#    When UI Click Button "Next" with value ""
#    When UI Click Button "Back" with value ""
#    Then UI Validate Element Existence By Label "Selection Widget" if Exists "true" with value ""


  @SID_3
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |

  @SID_4
  Scenario: Stop simulators
    Given Stop Simulators





