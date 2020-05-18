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
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "ADC Reports" page via homePage
    Then UI "Create" DPMReport With Name "App_Rejith_32326515:80"
      | reportType | Application Dashboard      |
      | devices    | virts:[Rejith_32326515:80] |

#    Then UI "Create" DPMReport With Name "All_apps"
#      | reportType | DefensePro Behavioral Protections Dashboard |
#      | devices    | virts:[Rejith:88, Rejith:443]               |

    Then UI "Create" DPMReport With Name "Device_50.50.101.11"
      | reportType | Network Report         |
      | devices    | virts:[Alteon_50.50.101.11] |

#    Then UI "Create" DPMReport With Name "All_devices"
#      | reportType | Network Report         |
#      | devices    | virts:[Rejith:88, Rejith:443] |

    Then UI logout and close browser

  @SID_3
  Scenario: ADC - Verify permissions for user with ALL:ALL permission
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "ADC Reports" page via homePage
    Then UI Validate VRM Report Existence by Name "App_Rejith_32326515:80" if Exists "true"
    Then UI Validate VRM Report Existence by Name "Device_50.50.101.11" if Exists "true"
    And UI logout and close browser

  @SID_4
  Scenario: ADC - verify App access for user with no DEVICE permission
    Given UI Login with user "Device_Admin_50.50.101.21" and password "radware"
    When UI Navigate to "ADC Reports" page via homePage
    Then UI Validate VRM Report Existence by Name "App_Rejith_32326515:80" if Exists "false"
    #50.50.101.21 has "Rejith_32326515:80" so user should see the report

  @SID_5
  Scenario: ADC - verify Device access for user with no DEVICE permission
    Then UI Validate VRM Report Existence by Name "Device_50.50.101.11" if Exists "false"

  @SID_6
  Scenario: Reports RBAC check logs
    Then UI logout and close browser
    And CLI Check if logs contains
      | logType     | expression                   | isExpected   |
      | ES          | fatal\|error                 | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error                 | NOT_EXPECTED |
      | MAINTENANCE | *.traffic-events-dashboard*. | IGMORE       |
      | JBOSS       | fatal                        | NOT_EXPECTED |
      | TOMCAT      | fatal                        | NOT_EXPECTED |
      | TOMCAT2     | fatal                        | NOT_EXPECTED |
