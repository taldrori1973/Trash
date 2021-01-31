@TC119268
Feature: Packet Type testing in DefensePro Attacks Dashboard

  @SID_1
  Scenario: Clean system data before Traffic Bandwidth test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-tr*"
    * REST Delete ES index "dp-atta*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator PCAPs for Traffic Bandwidth
    When REST Login with user "radware" and password "radware"
    Given CLI simulate 1 attacks of type "https" on "DefensePro" 11

  @SID_3
  Scenario:  login
    Given UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "2"
    And UI Navigate to "DefensePro Attacks" page via homePage
    When UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1H"
    When UI set "Auto Refresh" switch button to "off"
    Given UI Click Button "Accessibility Menu"
    Then UI Select Element with label "Accessibility Auto Refresh" and params "Stop Auto-Refresh"
    Then UI Click Button "Accessibility Menu"

  @SID_4
  Scenario: validate the number of Attacks Table
    Then UI Validate "Attacks Table" Table rows count EQUALS to 2

        ####################  Intrusions attack tables ####################################################

  @SID_5
  Scenario:  validate tables for Intrusions
    Then UI search row table in searchLabel "tableSearch" with text "Intrusions"
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Attack Category" findBy cellValue "Intrusions"
    Then UI Validate Element Existence By Label "Expand Tables View" if Exists "true" with value "info"

  @SID_6
  Scenario Outline:  validate date of Info table - Intrusions
    Then Validate Expand "Info" Table with label "<label>" Equals to "<value>"

    Examples:
      | label       | value           |
      | Packet Type | Decrypted HTTPS |


        ####################  SYN Flood attack tables ####################################################

  @SID_7
  Scenario:  validate tables for Intrusions
    Then UI search row table in searchLabel "tableSearch" with text "SYN Flood"
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Attack Category" findBy cellValue "SYN Flood"
    Then UI Validate Element Existence By Label "Expand Tables View" if Exists "true" with value "info"

  @SID_8
  Scenario Outline:  validate date of Info table - SYN Flood
    Then Validate Expand "Info" Table with label "<label>" Equals to "<value>"

    Examples:
      | label       | value   |
      | Packet Type | Regular |

  @SID_9
  Scenario: Traffic Cleanup
    Given UI logout and close browser