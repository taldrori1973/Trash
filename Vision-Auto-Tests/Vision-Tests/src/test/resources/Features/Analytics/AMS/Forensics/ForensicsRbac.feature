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
    Given CLI Reset radware password
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    When REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given CLI simulate 1 attacks of type "Ascan_Policy14" on SetId "DefensePro_Set_1"
    Given CLI simulate 1 attacks of type "rest_dos" on SetId "DefensePro_Set_2"
    When CLI simulate 1 attacks of type "rest_anomalies" on SetId "DefensePro_Set_1" and wait 22 seconds

  @SID_3
  Scenario: Forensics RBAC restricted user DEVICE can not view definition of admin other
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage
    When UI "Create" Forensics With Name "AllDevAllPol"
      |  |  |
    When UI "Create" Forensics With Name "Device10_Policy15"
      | devices               | setId:DefensePro_Set_1,policies:[Policy15];|
    * UI logout and close browser

  @SID_4
  Scenario: Forensics RBAC restricted user ALL can not view definition of other device
    Given UI Login with user "sec_mon_all_pol" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage
    When UI "Create" Forensics With Name "sec_mon_all_pol_radware"
      |  |  |
    Then UI Validate Element Existence By Label "INFO Forensics" if Exists "false" with value "AllDevAllPol"
    Then UI Validate Element Existence By Label "Delete Forensics" if Exists "false" with value "AllDevAllPol"
    Then UI Validate Element Existence By Label "Edit Forensics" if Exists "false" with value "AllDevAllPol"
    * UI logout and close browser

  @SID_5
  Scenario: Forensics RBAC restricted user ALL can view definition of admin same device
    Given UI Login with user "sec_mon_all_pol" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage
    Then UI Validate Element Existence By Label "INFO Forensics" if Exists "true" with value "Device10_Policy15"
    Then UI Validate Element Existence By Label "Delete Forensics" if Exists "true" with value "Device10_Policy15"
    Then UI Validate Element Existence By Label "Edit Forensics" if Exists "true" with value "Device10_Policy15"
    And UI Logout

  @SID_6
  Scenario: Forensics RBAC sec_mon_all_pol gets all results only on device
    Given UI Login with user "sec_mon_all_pol" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage
    When UI "Create" Forensics With Name "Only Device 10"
    | | |
    Then UI Click Button "My Forensics" with value "Only Device 10"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Only Device 10"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Only Device 10,0"
    And Sleep "3"

    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName | value   |
      | Direction  | Unknown |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 1
      | columnName | value   |
      | Direction  | Unknown |
    And UI Logout

  @SID_7
  Scenario: Forensics RBAC admin can view definition of restricted user
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage
    Then UI Validate Element Existence By Label "INFO Forensics" if Exists "true" with value "sec_mon_all_pol_radware"
    Then UI Validate Element Existence By Label "Delete Forensics" if Exists "true" with value "sec_mon_all_pol_radware"
    Then UI Validate Element Existence By Label "Edit Forensics" if Exists "true" with value "sec_mon_all_pol_radware"
    * UI logout and close browser

  @SID_8
  Scenario: Forensics RBAC restricted user POLICY can view only same policy definition
    Given UI Login with user "sec_mon" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage
    Then UI Validate Element Existence By Label "INFO Forensics" if Exists "true" with value "AllDevAllPol"
    Then UI Validate Element Existence By Label "Delete Forensics" if Exists "true" with value "AllDevAllPol"
    Then UI Validate Element Existence By Label "Edit Forensics" if Exists "true" with value "AllDevAllPol"
    Then UI Validate Element Existence By Label "INFO Forensics" if Exists "true" with value "Device10_Policy15"
    Then UI Validate Element Existence By Label "Delete Forensics" if Exists "true" with value "Device10_Policy15"
    Then UI Validate Element Existence By Label "Edit Forensics" if Exists "true" with value "Device10_Policy15"
    And UI Logout

  @SID_9
  Scenario: Forensics RBAC restricted POLICY user gets results only for relevant policy
    Given UI Login with user "sec_mon_Policy14" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage
    When UI "Create" Forensics With Name "Only Policy14"
      | | |
    Then UI Click Button "My Forensics" with value "Only Policy14"
    Then UI Validate Element Existence By Label "Generate Snapshot Forensics Manually" if Exists "true" with value "Only Policy14"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Only Policy14"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Only Policy14,0"
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName  | value    |
      | Policy Name | Policy14 |

  @SID_10
  Scenario: Validate DF not appears for sec_mon_all_pol
    Given UI Login with user "sec_mon_all_pol" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage
    Then UI Click Button "New Forensics Tab"
    Then UI Validate the attribute of "data-debug-enabled" are "EQUAL" to
      | label     | param       | value |
      | Product   | DefenseFlow | false |
    And UI Logout

  @SID_11
  Scenario: Validate DF not appears for sec_mon
    Given UI Login with user "sec_mon" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage
    Then UI Click Button "New Forensics Tab"
    Then UI Validate the attribute of "data-debug-enabled" are "EQUAL" to
      | label     | param       | value |
      | Product   | DefenseFlow | false |



  @SID_13
  Scenario: Login And Go to Vision
    Given UI Login with user "radware" and password "radware"
    Given UI Go To Vision
    Given UI Navigate to page "System->User Management->Local Users"


  @SID_14
  Scenario Outline: Create users and verify
    When UI Create New User With User Name "<User Name>" ,Role "<Role>" ,Scope "<Scope>" ,Password "<Password>"
    Then  UI User With User Name "<User Name>" ,Role "<Role>" ,Scope "<Scope>" Exists
    Examples:
      | User Name             | Role                          | Scope | Password        |
      | adc_admin_certificate | ADC+Certificate Administrator | [ALL] | Radware1234!@#$ |
      | adc_admin             | ADC Administrator             | [ALL] | Radware1234!@#$ |
      | adc_operator          | ADC Operator                  | [ALL] | Radware1234!@#$ |
      | certificate_admin     | Certificate Administrator     | [ALL] | Radware1234!@#$ |
      | device_admin          | Device Administrator          | [ALL] | Radware1234!@#$ |
      | device_configurator   | Device Configurator           | [ALL] | Radware1234!@#$ |
      | device_operator       | Device Operator               | [ALL] | Radware1234!@#$ |
      | device_viewer         | Device Viewer                 | [ALL] | Radware1234!@#$ |
      | real_server_operator  | Real Server Operator          | [ALL] | Radware1234!@#$ |
      | security_admin        | Security Administrator        | [ALL] | Radware1234!@#$ |
      | security_monitor      | Security Monitor              | [ALL] | Radware1234!@#$ |
      | user_admin            | User Administrator            | [ALL] | Radware1234!@#$ |
      | vision_admin          | Vision Administrator          | [ALL] | Radware1234!@#$ |
      | vision_reporter       | Vision Reporter               | [ALL] | Radware1234!@#$ |
      | system_user           | System User                   | [ALL] | Radware1234!@#$ |


  @SID_15
  Scenario Outline: Scope "All" is required for User Definition
    When Scope Is "<enabled or disabled>" For Role "<Role>"
    Examples:
      | enabled or disabled | Role                          |
      | enabled             | ADC+Certificate Administrator |
      | enabled             | ADC Administrator             |
      | enabled             | ADC Operator                  |
      | enabled             | Certificate Administrator     |
      | enabled             | Device Administrator          |
      | enabled             | Device Configurator           |
      | enabled             | Device Operator               |
      | enabled             | Device Viewer                 |
      | enabled             | Real Server Operator          |
      | enabled             | Security Administrator        |
      | enabled             | Security Monitor              |
      | disabled            | User Administrator            |
      | disabled            | Vision Administrator          |
      | disabled            | Vision Reporter               |
      | disabled            | System User                   |


  @SID_16
  Scenario: Edit User Management Settings
    Then UI Navigate to page "System->User Management->Authentication Mode"
    Then UI Select "Local" from Vision dropdown "Authentication Mode"
    Then UI Click Button "Submit"
    Then UI Logout


  @SID_17
  Scenario: Validate DF not appears for adc_admin_certificate
    Given UI Login with user "adc_admin_certificate" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AMS Forensics                               | no       |
    * UI Logout

  @SID_18
  Scenario: Validate DF not appears for adc_admin
    Given UI Login with user "adc_admin" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AMS Forensics                               | no       |
    * UI Logout

  @SID_19
  Scenario: Validate DF not appears for adc_operator
    Given UI Login with user "adc_operator" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AMS Forensics                               | no       |
    * UI Logout


  @SID_20
  Scenario: Validate DF not appears for certificate_admin
    Given UI Login with user "certificate_admin" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AMS Forensics                               | no       |
    * UI Logout



  @SID_21
  Scenario: Validate DF not appears for device_admin
    Given UI Login with user "device_admin" and password "Radware1234!@#$"
    Then UI Navigate to "AMS Forensics" page via homepage
    Then UI Click Button "New Forensics Tab"
    Then UI Validate the attribute of "data-debug-enabled" are "EQUAL" to
      | label     | param       | value |
      | Product   | DefenseFlow | false |
      | Product   | DefensePro  | true  |
      | Product   | AppWall     | true  |
    * UI Logout

  @SID_22
  Scenario: Validate DF not appears for device_configurator
    Given UI Login with user "device_configurator" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AMS Forensics                               | no       |
    * UI Logout

  @SID_23
  Scenario: Validate DF not appears for device_operator
    Given UI Login with user "device_operator" and password "Radware1234!@#$"
    Then UI Navigate to "AMS Forensics" page via homepage
    Then UI Click Button "New Forensics Tab"
    Then UI Validate the attribute of "data-debug-enabled" are "EQUAL" to
      | label     | param       | value |
      | Product   | DefenseFlow | false |
      | Product   | DefensePro  | true  |
      | Product   | AppWall     | true  |
    * UI Logout

  @SID_24
  Scenario: Validate DF not appears for device_viewer
    Given UI Login with user "device_viewer" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AMS Forensics                               | no       |
    * UI Logout


  @SID_25
  Scenario: Validate DF not appears for real_server_operator
    Given UI Login with user "real_server_operator" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AMS Forensics                               | no       |
    * UI Logout

  @SID_26
  Scenario: Validate DF not appears for security_admin
    Given UI Login with user "security_admin" and password "Radware1234!@#$"
    Then UI Navigate to "AMS Forensics" page via homepage
    Then UI Click Button "New Forensics Tab"
    Then UI Validate the attribute of "data-debug-enabled" are "EQUAL" to
      | label     | param       | value |
      | Product   | DefenseFlow | true |
      | Product   | DefensePro  | true  |
      | Product   | AppWall     | true  |
    * UI Logout

  @SID_27
  Scenario: Validate DF not appears for security_monitor
    Given UI Login with user "security_monitor" and password "Radware1234!@#$"
    Then UI Navigate to "AMS Forensics" page via homepage
    Then UI Click Button "New Forensics Tab"
    Then UI Validate the attribute of "data-debug-enabled" are "EQUAL" to
      | label     | param       | value |
      | Product   | DefenseFlow | false |
      | Product   | DefensePro  | true  |
      | Product   | AppWall     | true  |
    * UI Logout

  @SID_28
  Scenario: Validate DF not appears for user_admin
    Given UI Login with user "user_admin" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AMS Forensics                               | no       |
    * UI Logout

  @SID_29
  Scenario: Validate DF not appears for vision_admin
    Given UI Login with user "vision_admin" and password "Radware1234!@#$"
    Then UI Navigate to "AMS Forensics" page via homepage
    Then UI Click Button "New Forensics Tab"
    Then UI Validate the attribute of "data-debug-enabled" are "EQUAL" to
      | label     | param       | value |
      | Product   | DefenseFlow | true |
      | Product   | DefensePro  | true  |
      | Product   | AppWall     | true  |
    * UI Logout

  @SID_30
  Scenario: Validate DF not appears for vision_reporter
    Given UI Login with user "vision_reporter" and password "Radware1234!@#$"
    Then UI Navigate to "AMS Forensics" page via homepage
    Then UI Click Button "New Forensics Tab"
    Then UI Validate the attribute of "data-debug-enabled" are "EQUAL" to
      | label     | param       | value |
      | Product   | DefenseFlow | true |
      | Product   | DefensePro  | true  |
      | Product   | AppWall     | true  |
    * UI Logout



  @SID_31
  Scenario: Login And Go to Vision
    Given UI Login with user "radware" and password "radware"
    Given UI Go To Vision
    Then UI Navigate to page "System->User Management->Authentication Mode"
    Then UI Select "TACACS+" from Vision dropdown "Authentication Mode"
    Then UI Click Button "Submit"


  @SID_12
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression                                    | isExpected   |
      | ALL     | fatal                                         | NOT_EXPECTED |
      | JBOSS   | Not authorized operation launched by the user | IGNORE       |



