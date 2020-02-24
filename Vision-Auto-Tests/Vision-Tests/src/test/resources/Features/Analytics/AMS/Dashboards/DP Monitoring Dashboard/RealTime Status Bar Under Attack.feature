@TC112257
Feature: VRM Real Time Status Bar Under Attack

  @SID_1
  Scenario: Under attack Clean system data before test
  # Written by YL
    Then CLI Clear vision logs
    Given CLI kill all simulator attacks on current vision
    Given REST Delete ES index "dp-attack*"
    Given REST Delete ES index "dp-sampl*"
    Given REST Delete ES index "dp-packet*"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given CLI simulate 1 attacks of type "rest_anomalies" on "DefensePro" 10 and wait 50 seconds

  @SID_2
  Scenario: Under attack basic occurred
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Validate Element Existence By Label "Under Attack" if Exists "true"
    And Sleep "300"
    Then UI Validate Element Existence By Label "Peace Time" if Exists "true"
    Then UI Validate Text field "Peacetime text" EQUALS "PEACETIME"
    And UI Logout

  @SID_3
  Scenario: Under attack basic ongoing
    Given CLI kill all simulator attacks on current vision
    Given REST Delete ES index "dp-attack*"
    Given REST Delete ES index "dp-sampl*"
    Given REST Delete ES index "dp-packet*"
    Given CLI simulate 20 attacks of type "vrm_bdos" on "DefensePro" 10
  # Attack on BDOS policy physical port 1 for 8 minutes
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And Sleep "60"
    Then UI Validate Element Existence By Label "Under Attack" if Exists "true"
    Then UI Validate Text field "Under Attack text" EQUALS "UNDER ATTACK"
    And UI Logout

  @SID_4
  Scenario: Under_attack_filter_device
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 11    |       |          |
    And Sleep "2"
    Then UI Validate Element Existence By Label "Under Attack" if Exists "false"
    Then UI Validate Element Existence By Label "Peace Time" if Exists "true"
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    And Sleep "2"
    Then UI Validate Element Existence By Label "Under Attack" if Exists "true"
    Then UI Validate Element Existence By Label "Peace Time" if Exists "false"
    And UI Logout

  @SID_5
  Scenario: Under_attack_filter_port
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 2     |          |
    Then UI Validate Element Existence By Label "Under Attack" if Exists "false"
    Then UI Validate Element Existence By Label "Peace Time" if Exists "true"
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1     |          |
    Then UI Validate Element Existence By Label "Under Attack" if Exists "true"
    Then UI Validate Element Existence By Label "Peace Time" if Exists "false"
    And UI Logout

  @SID_6
  Scenario: Under_attack_filter_policy
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | Policy14 |
    Then UI Validate Element Existence By Label "Under Attack" if Exists "false"
    Then UI Validate Element Existence By Label "Peace Time" if Exists "true"
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | BDOS     |
    Then UI Validate Element Existence By Label "Under Attack" if Exists "true"
    Then UI Validate Element Existence By Label "Peace Time" if Exists "false"
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies       |
      | 10    |       | BDOS, Policy14 |
    Then UI Validate Element Existence By Label "Under Attack" if Exists "true"
    Then UI Validate Element Existence By Label "Peace Time" if Exists "false"
    And UI Logout

  @SID_7
  Scenario: Under_attack_RBAC_device
    Given UI Login with user "sec_admin_all_pol" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Validate Element Existence By Label "Under Attack" if Exists "true"
    Then UI Validate Element Existence By Label "Peace Time" if Exists "false"
    And UI Logout
    Given UI Login with user "sec_admin_all_pol_51" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Validate Element Existence By Label "Under Attack" if Exists "false"
    Then UI Validate Element Existence By Label "Peace Time" if Exists "true"
    And UI Logout

  @SID_8
  Scenario: Under_attack_RBAC_policy sec_admin
    Then UI Login with user "sec_admin" and password "radware"
    # user has permission for Policy15 only
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Validate Element Existence By Label "Under Attack" if Exists "false"
    Then UI Logout
  @SID_9
  Scenario: Under_attack_RBAC_policy sec_mon_BDOS
    Then UI Login with user "sec_mon_BDOS" and password "radware"
    # user has permission for BDOS only
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Validate Element Existence By Label "Under Attack" if Exists "true"
    Then UI Logout

  @SID_10
  Scenario: Under_attack_clear
    Given CLI kill all simulator attacks on current vision
    Given CLI simulate 1 attacks of type "rest_bdos_term_only" on "DefensePro" 10 and wait 300 seconds
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Validate Element Existence By Label "Under Attack" if Exists "false"
    Then UI Validate Element Existence By Label "Peace Time" if Exists "true"
    And UI Logout

  @SID_11
  Scenario: Under attack DP 7
    Given CLI simulate 4 attacks of type "rest_anomalies" on "DefensePro" 20 with loopDelay 15000 and wait 40 seconds with attack ID
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Validate Element Existence By Label "Under Attack" if Exists "false"
    Then UI Validate Element Existence By Label "Peace Time" if Exists "true"

  @SID_12
  Scenario: Under attack check logs
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal        | NOT_EXPECTED |

@SID_13
  Scenario: cleanup
    * UI logout and close browser
    * CLI kill all simulator attacks on current vision
#      END RT UNDER ATTACK