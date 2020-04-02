@VRM_Report2 @TC106003
Feature: Forensics RBAC

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-attack*"
    * REST Delete ES index "dp-sampl*"
    * REST Delete ES index "dp-packet*"
    * REST Delete ES index "forensics-*"
    * REST Delete ES index "dpforensics-*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Forensics RBAC generate attacks
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
#    * REST Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    When CLI simulate 1 attacks of type "Ascan_Policy14" on "DefensePro" 10
    When CLI simulate 1 attacks of type "rest_dos" on "DefensePro" 11
    When CLI simulate 1 attacks of type "rest_anomalies" on "DefensePro" 10 and wait 22 seconds

  @SID_3
  Scenario: Forensics RBAC restricted user DEVICE can not view definition of admin other
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage
    When UI "Create" Forensics With Name "AllDevAllPol"
      |  |  |
    When UI "Create" Forensics With Name "Device10_Policy15"
      | devices               | index:10,policies:[Policy15];|
    * UI logout and close browser

  @SID_4
  Scenario: Forensics RBAC restricted user ALL can not view definition of other device
    Given UI Login with user "sec_mon_all_pol" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage
    When UI "Create" Forensics With Name "sec_mon_all_pol_radware"
      |  |  |
    Then UI Validate Element Existence By Label "Views" if Exists "false" with value "AllDevAllPol"
    Then UI Validate Element Existence By Label "Delete" if Exists "false" with value "AllDevAllPol"
    Then UI Validate Element Existence By Label "Edit" if Exists "false" with value "AllDevAllPol"
    Then UI Validate Element Existence By Label "Views.Expand" if Exists "false" with value "AllDevAllPol"
    * UI logout and close browser

  @SID_5
  Scenario: Forensics RBAC restricted user ALL can view definition of admin same device
    Given UI Login with user "sec_mon_all_pol" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage
    Then UI Validate Element Existence By Label "Views" if Exists "true" with value "Device10_Policy15"
    Then UI Validate Element Existence By Label "Delete" if Exists "true" with value "Device10_Policy15"
    Then UI Validate Element Existence By Label "Edit" if Exists "true" with value "Device10_Policy15"
    Then UI Validate Element Existence By Label "Views.Expand" if Exists "true" with value "Device10_Policy15"
    And UI Logout

  @SID_6
  Scenario: Forensics RBAC sec_mon_all_pol gets all results only on device
    Given UI Login with user "sec_mon_all_pol" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage
    When UI "Create" Forensics With Name "Only Device 10"
    | | |
    When UI Click Button "Views" with value "Only Device 10"
    And UI Click Button "Views.Generate Now" with value "Only Device 10"
    And Sleep "5"
    And UI Click Button "Views.report" with value "Only Device 10"
    And Sleep "3"
    Then UI Validate "Report.Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName | value   |
      | Direction  | Unknown |
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 1
      | columnName | value   |
      | Direction  | Unknown |
    And UI Logout

  @SID_7
  Scenario: Forensics RBAC admin can view definition of restricted user
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage
    Then UI Validate Element Existence By Label "Views" if Exists "true" with value "sec_mon_all_pol_radware"
    Then UI Validate Element Existence By Label "Delete" if Exists "true" with value "sec_mon_all_pol_radware"
    Then UI Validate Element Existence By Label "Edit" if Exists "true" with value "sec_mon_all_pol_radware"
    Then UI Validate Element Existence By Label "Views.Expand" if Exists "true" with value "sec_mon_all_pol_radware"
    * UI logout and close browser

  @SID_8
  Scenario: Forensics RBAC restricted user POLICY can view only same policy definition
    Given UI Login with user "sec_mon" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage
    Then UI Validate Element Existence By Label "Views" if Exists "false" with value "AllDevAllPol"
    Then UI Validate Element Existence By Label "Delete" if Exists "false" with value "AllDevAllPol"
    Then UI Validate Element Existence By Label "Edit" if Exists "false" with value "AllDevAllPol"
    Then UI Validate Element Existence By Label "Views.Expand" if Exists "false" with value "AllDevAllPol"
    Then UI Validate Element Existence By Label "Views" if Exists "true" with value "Device10_Policy15"
    Then UI Validate Element Existence By Label "Delete" if Exists "true" with value "Device10_Policy15"
    Then UI Validate Element Existence By Label "Edit" if Exists "true" with value "Device10_Policy15"
    Then UI Validate Element Existence By Label "Views.Expand" if Exists "true" with value "Device10_Policy15"
    And UI Logout

  @SID_9
  Scenario: Forensics RBAC restricted POLICY user gets results only for relevant policy
    Given UI Login with user "sec_mon_Policy14" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage
    When UI "Create" Forensics With Name "Only Policy14"
      | | |
    When UI Click Button "Views" with value "Only Policy14"
    And UI Click Button "Views.Generate Now" with value "Only Policy14"
    And UI Click Button "Views.report" with value "Only Policy14"
    Then UI Validate "Report.Table" Table rows count EQUALS to 1
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName  | value    |
      | Policy Name | Policy14 |

  @SID_10
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression                                    | isExpected   |
      | ALL     | fatal                                         | NOT_EXPECTED |
      | JBOSS   | Not authorized operation launched by the user | IGNORE       |
