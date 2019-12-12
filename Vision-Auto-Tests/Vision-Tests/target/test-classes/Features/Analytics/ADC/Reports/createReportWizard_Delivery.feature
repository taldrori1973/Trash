@ADC_Report @TC105969
Feature:  DPM - Report Delivery Wizard

  @SID_1
  Scenario: Login and navigate to the Reports Wizard
    * REST Vision Install License Request "vision-reporting-module-ADC"
    Given UI Login with user "sys_admin" and password "radware"
    When UI Open Upper Bar Item "ADC"
    When UI Open "Reports" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

  @SID_2
  Scenario: ADC - new Report Delivery

    Given UI "Create" DPMReport With Name "Delivery_Test_report"
      | reportType | Virtual Service Report                                               |
      | devices    | virts:[Rejith:88]                                                    |
      | Delivery   | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody |
    And UI Click Button "Title" with value "Delivery_Test_report"
    And UI Click Button "Generate Now" with value "Delivery_Test_report"
    And UI Click Button "Log Preview" with value "Delivery_Test_report"
    Then UI "Validate" DPMReport With Name "Delivery_Test_report"
      | reportType | Virtual Service Report                                               |
      | Delivery   | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody |
    Then Verify Last Unread Email
      | email                          | password | sender                              | subject   | body   | fileExtension | waitForUnreadEmail |
      | automation.vision1@radware.com | Qwerty1! | Vision.Reporting.Module@radware.com | mySubject | myBody | html          | 180                |

  @SID_3
  Scenario: TC103830- ADC - more than one email
    Given UI "Create" DPMReport With Name "Delivery_Test_report"
      | reportType | Virtual Service Report                                                                                                      |
      | devices    | virts:[Rejith:88]                                                                                                           |
      | Delivery   | Email:[automation.vision1@radware.com,automation.vision2@radware.com],Subject:Subject Delivery Test,Body:Body Delivery Test |
    And UI Click Button "Title" with value "Delivery_Test_report"
    And UI Click Button "Generate Now" with value "Delivery_Test_report"
    And UI Click Button "Log Preview" with value "Delivery_Test_report"
    Then UI "Validate" DPMReport With Name "Delivery_Test_report"
      | reportType | Virtual Service Report                                                                                                      |
      | Delivery   | Email:[automation.vision1@radware.com,automation.vision2@radware.com],Subject:Subject Delivery Test,Body:Body Delivery Test |

    Then Verify Last Unread Email
      | email                          | password | sender                              | subject               | body               | fileExtension | waitForUnreadEmail |
      | automation.vision1@radware.com | Qwerty1! | Vision.Reporting.Module@radware.com | Subject Delivery Test | Body Delivery Test | html          | 180                |
      | automation.vision1@radware.com | Qwerty1! | Vision.Reporting.Module@radware.com | Subject Delivery Test | Body Delivery Test | html          | 180                |


  @SID_4
  Scenario: ADC - just english characters
    Given UI "Create" DPMReport With Name "Delivery_Test_report"
      | reportType | Virtual Service Report                                                                                 |
      | devices    | virts:[Rejith:88]                                                                                      |
      | Delivery   | Email:[automation.vision1@radware.com],Subject:english characters subject,Body:english characters body |
    And UI Click Button "Title" with value "Delivery_Test_report"
    And UI Click Button "Generate Now" with value "Delivery_Test_report"
    And UI Click Button "Log Preview" with value "Delivery_Test_report"
    Then UI "Validate" DPMReport With Name "Delivery_Test_report"
      | reportType | Virtual Service Report                                                                                 |
      | Delivery   | Email:[automation.vision1@radware.com],Subject:english characters subject,Body:english characters body |
    Then Verify Last Unread Email
      | email                          | password | sender                              | subject                    | body                    | fileExtension | waitForUnreadEmail |
      | automation.vision1@radware.com | Qwerty1! | Vision.Reporting.Module@radware.com | english characters subject | english characters body | html          | 180                |

  @SID_5
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |



