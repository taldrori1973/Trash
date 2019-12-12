@ADC_Report @TC105968

Feature: DPM - Report Wizard Creation

  @SID_1
  Scenario: Login and navigate to the Reports Wizard
    * REST Vision Install License Request "vision-reporting-module-ADC"
    Given UI Login with user "sys_admin" and password "radware"
    When UI Open Upper Bar Item "ADC"
    When UI Open "Reports" Tab


  @SID_2
  Scenario: ADC - Add new Report
    Given UI "Create" DPMReport With Name "ADCcreateReport1"
      | reportType            | Application Report                                                   |
      | devices               | virts:[Rejith_32326515:88]                                        |
      | Time Definitions.Date | Quick:30m                                                            |
      | Share              | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody |
    Given UI "Validate" DPMReport With Name "ADCcreateReport1"
      | reportType            | Application Report                                                   |
      | devices               | virts:[Rejith_32326515:88]                                        |
      | Time Definitions.Date | Quick:30m                                                            |
      | Share              | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody |
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






