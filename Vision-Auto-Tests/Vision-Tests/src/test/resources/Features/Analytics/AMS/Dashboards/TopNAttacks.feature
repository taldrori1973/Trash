Feature: topNAttacks


  @runSetup
  @SID_1
  Scenario: Clean system data before "Protection Policies" test
    * CLI kill all simulator attacks on current vision
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"

  @runSetup
  @SID_3
  Scenario: Run DP simulator PCAPs for "Protection Policies" - 3rd drill - BDOS
#    Given CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10
    Given CLI simulate 1 attacks of type "many_attacks" on "DefensePro" 10 and wait 130 seconds
#    Given CLI simulate 1 attacks of type "vrm_bdos" on "DefensePro" 10 and wait 70 seconds


  Scenario: Login as sys_admin and update Attack Description File
    Given UI Login with user "radware" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage


  Scenario: validate Top attacks sources in 2drill down
    Then Sleep "3"
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    Then UI Validate Text field "topAttackSource" with params "0" EQUALS "149.85.1.2"
    Then UI Validate Text field "topAttackSource" with params "1" MatchRegex "\d+.\d+.\d+.\d+"
#    Then UI Validate Text field "topAttackSource" with params "2" EQUALS "192.85.1.7"
#    Then UI Validate Text field "topAttackSource" with params "3" EQUALS "190.85.1.2"
#    Then UI Validate Text field "topAttackSource" with params "4" EQUALS "1.1.1.1"
#    Then UI Validate Text field "topAttackSource" with params "5" EQUALS "1.3.5.8"

    Then UI Validate Text field "topAttackDestination" with params "0" EQUALS "2.2.2.1"
    Then UI Validate Text field "topAttackDestination" with params "1" MatchRegex "\d+.\d+.\d+.\d+"
#    Then UI Validate Text field "topAttackDestination" with params "2" EQUALS "4.4.4.1"
#    Then UI Validate Text field "topAttackDestination" with params "3" EQUALS "5.6.7.38"
#    Then UI Validate Text field "topAttackDestination" with params "4" EQUALS "5.6.7.39"



  Scenario: validate 3 drill down
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DNS Flood"
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0
    Then UI Validate Text field "TOP ATTACK SOURCES.IP" with params "0" EQUALS "192.85.1.9"

  Scenario: validate global policy
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "Global Policy"
