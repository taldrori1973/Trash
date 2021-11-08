@TC108795  @Test12
Feature: AMS BDoS Attack State

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs

  @SID_2
  Scenario: generate BDoS attacks with all possible states
    Given CLI simulate 20 attacks of type "Burst_States" on SetId "DefensePro_Set_2" with loopDelay 15000 and wait 40 seconds

  @SID_3
  Scenario: Login and enter attacks table
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then Sleep "60"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "pol_1"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Behavioral DoS"

  @SID_4
  Scenario: validate BDoS State attack 60-1514816419
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "60-1514816419"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Burst Attack Signature Blocking"
    Then UI Click Button "Protection Policies.GO BACK" with value "<< GO BACK"
  @SID_5
  Scenario: validate BDoS State attack 61-1514816419
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Behavioral DoS"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "61-1514816419"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Strictness Anomaly"
    Then UI Click Button "Protection Policies.GO BACK" with value "<< GO BACK"
  @SID_6
  Scenario: validate BDoS State attack 62-1514816419
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Behavioral DoS"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "62-1514816419"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Anomaly"
    Then UI Click Button "Protection Policies.GO BACK" with value "<< GO BACK"
  @SID_7
  Scenario: validate BDoS State attack 63-1514816419
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Behavioral DoS"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "63-1514816419"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Real-Time Signature Blocking"
    Then UI Click Button "Protection Policies.GO BACK" with value "<< GO BACK"
  @SID_8
  Scenario: validate BDoS State attack 64-1514816419
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Behavioral DoS"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "64-1514816419"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Real-Time Signature Analysis"
    Then UI Click Button "Protection Policies.GO BACK" with value "<< GO BACK"
  @SID_9
  Scenario: validate BDoS State attack 65-1514816419
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Behavioral DoS"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "65-1514816419"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Normal"
    Then UI Click Button "Protection Policies.GO BACK" with value "<< GO BACK"

  @SID_10
  Scenario: Stop generating attacks and Logout
    Then CLI kill all simulator attacks on current vision
    Then UI logout and close browser