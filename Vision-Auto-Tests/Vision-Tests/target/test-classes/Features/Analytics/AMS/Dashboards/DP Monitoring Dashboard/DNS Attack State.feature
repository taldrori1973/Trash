
@TC108794
Feature: AMS DNS Attack State

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * CLI Clear vision logs

  @SID_2
  Scenario: generate DNS attacks with all possible states
    Given CLI simulate 20 attacks of type "DNS_States" on "DefensePro" 10 with loopDelay 15000 and wait 40 seconds
  @SID_3
  Scenario: Login and enter attacks table
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "pol_1"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DNS Flood"

  @SID_4
  Scenario: validate DNS State attack 41-1528993409 Real-Time Signature Analysis
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "41-1528993409"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Real-Time Signature Analysis"
    Then UI Click Button "Protection Policies.GO BACK" with value "<< GO BACK"
  @SID_5
  Scenario: validate DNS State attack 42-1528993409 Real-Time Signature Challenge
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DNS Flood"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "42-1528993409"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Real-Time Signature Challenge"
    Then UI Click Button "Protection Policies.GO BACK" with value "<< GO BACK"
  @SID_6
  Scenario: validate DNS State attack 43-1528993409 Real-Time Signature Rate-Limit
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DNS Flood"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "43-1528993409"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Real-Time Signature Rate-Limit"
    Then UI Click Button "Protection Policies.GO BACK" with value "<< GO BACK"
  @SID_7
  Scenario: validate DNS State attack 44-1528993409 Collective Challenge
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DNS Flood"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "44-1528993409"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Collective Challenge"
    Then UI Click Button "Protection Policies.GO BACK" with value "<< GO BACK"
  @SID_8
  Scenario: validate DNS State attack 45-1528993409 Collective Rate-Limit
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DNS Flood"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "45-1528993409"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Collective Rate-Limit"
    Then UI Click Button "Protection Policies.GO BACK" with value "<< GO BACK"
  @SID_9
  Scenario: validate DNS State attack 46-1528993409 Collective Challenge
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DNS Flood"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "46-1528993409"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Collective Challenge"
    Then UI Click Button "Protection Policies.GO BACK" with value "<< GO BACK"

  @SID_10
  Scenario: validate DNS State attack 47-1528993409 Collective Rate-Limit
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DNS Flood"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "47-1528993409"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Collective Rate-Limit"
    Then UI Click Button "Protection Policies.GO BACK" with value "<< GO BACK"
  @SID_11
  Scenario: validate DNS State attack 48-1528993409 Anomaly
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DNS Flood"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "48-1528993409"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Anomaly"
    Then UI Click Button "Protection Policies.GO BACK" with value "<< GO BACK"
  @SID_12
  Scenario: validate DNS State attack 49-1528993409 Real-Time Signature Challenge
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DNS Flood"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "49-1528993409"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Real-Time Signature Challenge"
    Then UI Click Button "Protection Policies.GO BACK" with value "<< GO BACK"
  @SID_13
  Scenario: validate DNS State attack 50-1528993409 Collective Challenge
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DNS Flood"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "50-1528993409"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Collective Challenge"
    Then UI Click Button "Protection Policies.GO BACK" with value "<< GO BACK"
  @SID_14
  Scenario: validate DNS State attack 51-1528993409 Collective Rate-Limit
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DNS Flood"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "51-1528993409"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Collective Rate-Limit"
    Then UI Click Button "Protection Policies.GO BACK" with value "<< GO BACK"

  @SID_15
  Scenario: validate DNS State attack 40-1528993409 Normal
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DNS Flood"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "40-1528993409"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Normal"
    Then UI Click Button "Protection Policies.GO BACK" with value "<< GO BACK"

  @SID_16
  Scenario: Stop generating attacks and Logout
    Then CLI kill all simulator attacks on current vision
    Then UI logout and close browser