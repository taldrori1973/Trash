@VRM_Report2 @TC106013

Feature: VRM AMS Reports RBAC

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "vrm-scheduled-report-*"
    * CLI Clear vision logs
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
  @SID_2
  Scenario: Login as admin and create six types of reports
    Given UI Login with user "sys_admin" and password "radware"
    When UI Open Upper Bar Item "AMS"
    When UI Open "Reports" Tab
    Given UI "Create" Report With Name "Analytics_AllDevAllPol"
      | reportType | DefensePro Analytics Dashboard |
    Given UI "Create" Report With Name "Baseline_AllDevAllPol"
      | reportType | DefensePro Behavioral Protections Dashboard |

    Given UI "Create" Report With Name "Analytics_Dev10Policy14"
      | reportType | DefensePro Analytics Dashboard |
      | devices    | index:10,policies:[Policy14]   |
    Given UI "Create" Report With Name "Baseline_Dev10Policy14"
      | reportType | DefensePro Behavioral Protections Dashboard |
      | devices    | index:10,policies:[Policy14]                   |

    Given UI "Create" Report With Name "Analytics_Dev10AllPol"
      | reportType | DefensePro Analytics Dashboard |
      | devices    | index:10                       |
    Given UI "Create" Report With Name "Baseline_Dev10AllPol"
      | reportType | DefensePro Behavioral Protections Dashboard |
      | devices    | index:10                                    |
    Given UI "Create" Report With Name "Analytics_Dev10Policy14Dev11Policy14"
      | reportType | DefensePro Analytics Dashboard |
      | devices    | index:10,policies:[Policy14]; index:11,policies:[Policy14];  |
    Given UI "Create" Report With Name "Baseline_Dev10Policy14Dev11pol_1"
      | reportType | DefensePro Behavioral Protections Dashboard |
      | devices    | index:10,policies:[Policy14]; index:11,policies:[pol1];  |
    And UI logout and close browser



  @SID_3
  Scenario: Verify permissions for user with ALL:ALL permission
    Given UI Login with user "sys_admin" and password "radware"
    When UI Open Upper Bar Item "AMS"
    When UI Open "Reports" Tab
    Then UI Validate VRM Report Existence by Name "Analytics_AllDevAllPol" if Exists "true"
    Then UI Validate VRM Report Existence by Name "Analytics_Dev10Policy14" if Exists "true"
    Then UI Validate VRM Report Existence by Name "Analytics_Dev10AllPol" if Exists "true"
    Then UI Validate VRM Report Existence by Name "Baseline_AllDevAllPol" if Exists "true"
    Then UI Validate VRM Report Existence by Name "Baseline_Dev10Policy14" if Exists "true"
    Then UI Validate VRM Report Existence by Name "Baseline_Dev10AllPol" if Exists "true"
    Then UI Validate VRM Report Existence by Name "Analytics_Dev10Policy14Dev11Policy14" if Exists "true"
    Then UI Validate VRM Report Existence by Name "Baseline_Dev10Policy14Dev11pol_1" if Exists "true"
    And UI logout and close browser

  @SID_4
  Scenario: verify permissions for user with DEVICE:ALL permission
    Given UI Login with user "sec_mon_all_pol" and password "radware"
    When UI Open Upper Bar Item "AMS"
    When UI Open "Reports" Tab
    Then UI Validate VRM Report Existence by Name "Analytics_AllDevAllPol" if Exists "false"
    Then UI Validate VRM Report Existence by Name "Analytics_Dev10Policy14" if Exists "true"
    Then UI Validate VRM Report Existence by Name "Analytics_Dev10AllPol" if Exists "true"
    Then UI Validate VRM Report Existence by Name "Baseline_AllDevAllPol" if Exists "false"
    Then UI Validate VRM Report Existence by Name "Baseline_Dev10Policy14" if Exists "true"
    Then UI Validate VRM Report Existence by Name "Baseline_Dev10AllPol" if Exists "true"
    Then UI Validate VRM Report Existence by Name "Analytics_Dev10Policy14Dev11Policy14" if Exists "false"
    Then UI Validate VRM Report Existence by Name "Baseline_Dev10Policy14Dev11pol_1" if Exists "false"
    And UI logout and close browser

  @SID_5
  Scenario: Verify permissions for user with DEVICE:POLICY permission
    Given UI Login with user "sec_mon_Policy14" and password "radware"
    When UI Open Upper Bar Item "AMS"
    When UI Open "Reports" Tab
    Then UI Validate VRM Report Existence by Name "Analytics_AllDevAllPol" if Exists "false"
    Then UI Validate VRM Report Existence by Name "Analytics_Dev10Policy14" if Exists "true"
    Then UI Validate VRM Report Existence by Name "Analytics_Dev10AllPol" if Exists "false"
    Then UI Validate VRM Report Existence by Name "Baseline_AllDevAllPol" if Exists "false"
    Then UI Validate VRM Report Existence by Name "Baseline_Dev10Policy14" if Exists "true"
    Then UI Validate VRM Report Existence by Name "Baseline_Dev10AllPol" if Exists "false"
    Then UI Validate VRM Report Existence by Name "Analytics_Dev10Policy14Dev11Policy14" if Exists "false"
    Then UI Validate VRM Report Existence by Name "Baseline_Dev10Policy14Dev11pol_1" if Exists "false"
    And UI logout and close browser

  @SID_6
  Scenario: Verify permissions for user with ALL:POLICY permission
    Given UI Login with user "sec_admin_allDPs_pol_1_policy" and password "radware"
    When UI Open Upper Bar Item "AMS"
    When UI Open "Reports" Tab
    Then UI Validate VRM Report Existence by Name "Analytics_AllDevAllPol" if Exists "false"
    Then UI Validate VRM Report Existence by Name "Analytics_Dev10Policy14" if Exists "false"
    Then UI Validate VRM Report Existence by Name "Analytics_Dev10AllPol" if Exists "false"
    Then UI Validate VRM Report Existence by Name "Baseline_AllDevAllPol" if Exists "false"
    Then UI Validate VRM Report Existence by Name "Baseline_Dev10Policy14" if Exists "false"
    Then UI Validate VRM Report Existence by Name "Baseline_Dev10AllPol" if Exists "false"
    Then UI Validate VRM Report Existence by Name "Analytics_Dev10Policy14Dev11Policy14" if Exists "false"
    Then UI Validate VRM Report Existence by Name "Baseline_Dev10Policy14Dev11pol_1" if Exists "false"
    And UI logout and close browser


#  Scenario: verify permissions for user with DEVICE:2POLICIES permission
#    Given UI Login with user "sys_admin" and password "radware"
#    When UI Open Upper Bar Item "AMS"
#    When UI Open "Reports" Tab

  @SID_7
  Scenario: Reports RBAC check logs
    And CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal        | NOT_EXPECTED |
