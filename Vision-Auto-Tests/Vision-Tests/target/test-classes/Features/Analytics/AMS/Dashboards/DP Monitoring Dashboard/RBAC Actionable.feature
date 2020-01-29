@VRM @TC109954
Feature: RBAC for actionable
  
  @SID_1
  Scenario: Clean system data before "Protection Policies" test
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    * CLI Clear vision logs

  
  @SID_2
  Scenario: run attacks
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 20 with loopDelay 15000
    And CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000
    And CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 11 with loopDelay 15000 and wait 50 seconds
    Given CLI simulate 1000 attacks of type "attack_rate" on "DefensePro" 10 with loopDelay 15000 and wait 120 seconds
    Given CLI simulate 1 attacks of type "vrm_bdos" on "DefensePro" 10 and wait 70 seconds


  @SID_3
  Scenario Outline: valid roles to run the Actions from the Monitoring Screens with a user of vision
    Given UI Login with user "<userName>" and password "radware"
    And UI Open Upper Bar Item "AMS" negative
    And UI Open "Dashboards" Tab
    And UI Open "DP Monitoring Dashboard" Sub Tab
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy index 0
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0
    Then UI Validate Element Existence By Label "Edit Bandwidth" if Exists "true"
    Then UI Logout

    Examples:
      | userName                  |
      | sys_admin                 |
      | radware                   |
      | Device_Administrator_user |


  @SID_4
  Scenario Outline: invalid roles to run the Actions from the Monitoring Screens with a user of vision
    Given UI Login with user "<userName>" and password "radware"
    And UI Open Upper Bar Item "AMS" negative
    And UI Open "Dashboards" Tab
    And UI Open "DP Monitoring Dashboard" Sub Tab
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy index 0
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0
    Then UI Validate Element Existence By Label "Edit Bandwidth" if Exists "false"
    Then UI Logout

    Examples:
      | userName           |
      | Device_Viewer_user |
