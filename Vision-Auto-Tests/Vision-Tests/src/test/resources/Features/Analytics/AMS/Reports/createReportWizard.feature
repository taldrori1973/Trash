@VRM_Report2 @TC106008

Feature: AMS Report Wizard Creation

  @SID_1
  Scenario: VRM Reports Cleanup
    * REST Delete ES index "vrm-scheduled-report-*"
  @SID_2
  Scenario: Login and navigate to the AMS Reports Wizard
    Then UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    When UI Open Upper Bar Item "AMS"
    When UI Open "Reports" Tab


  @SID_3
  Scenario: Add new AMS Report
    Given UI "Create" Report With Name "createReport1"
      | reportType            | DefensePro Analytics Dashboard |

    Given UI "Validate" Report With Name "createReport1"
      | reportType            | DefensePro Analytics Dashboard |

#    When UI Click Button "Edit" with value "createReport1"
#    When UI Click Button "Next" with value ""
#    When UI Click Button "Back" with value ""
#    Then UI Validate Element Existence By Label "Selection Widget" if Exists "true" with value ""



#  Scenario: TC105712 Create Maximum 50 allowed Reports templates
#    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
#    * UI Validate max generate Report Template is 50

  @SID_4
  Scenario: VRM AMS Report validate max 10 generations in view
    Then UI Validate max generate Report is 10

  @SID_5
  Scenario: Cleanup
    Then UI Open "Configurations" Tab
    Then UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |






