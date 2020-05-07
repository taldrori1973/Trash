

Feature: Attack Table - Expand Table Row

  @Test12
  @SID_1
  Scenario: Clean system data before Traffic Bandwidth test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-tr*"
    * REST Delete ES index "dp-atta*"
    * CLI Clear vision logs


  @SID_2
  Scenario: Run DP simulator PCAPs for Traffic Bandwidth
    When REST Login with user "radware" and password "radware"
    Then CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10 and wait 210 seconds
#    Given CLI simulate 1 attacks of type "many_attacks" on "DefensePro" 10
  
  @SID_3
  Scenario:  login
    Given UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "2"
    And UI Navigate to "AMS Attacks" page via homePage

####################  BehavioralDOS attack tables ####################################################

  @SID_4
  Scenario:  validate tables for BehavioralDOS
   Given UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Attack Category" findBy cellValue "BehavioralDOS"
    Then UI Validate Element Existence By Label "Expand Row Table Selected" if Exists "true" with value "info,Characteristics"


  @SID_5
  Scenario Outline:  validate date of Info table - BehavioralDOS
    Then Validate Expand Info Table with label "<label>" Equals to "<value>"

    Examples:
      | label             | value                          |
      |Status             |Terminated                      |
      |Risk               |Low                             |
