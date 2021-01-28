@TC119270
Feature: Packet Type testing in DefensePro Monitoring Dashboard

  @SID_1
  Scenario: Clean system data before Traffic Bandwidth test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-tr*"
    * REST Delete ES index "dp-atta*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator PCAPs for Traffic Bandwidth
    When REST Login with user "radware" and password "radware"
    Given CLI simulate 4 attacks of type "https" on "DefensePro" 11

  @SID_3
  Scenario:  login
    Given UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "2"
    Then UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @SID_4
  Scenario: validate paketType : Decrypted-HTTPS
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "p2"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Intrusions"
    Then UI Validate "Protection Policies.Events Table" Table rows count EQUALS to 1
    Then UI validate Table row by keyValue with elementLabel "Protection Policies.Events Table" findBy columnName "Packet Type" findBy cellValue "Decrypted HTTPS"
    Then UI Click Button "Protection Policies.GO BACK"

  @SID_5
  Scenario: validate paketType : Decrypted-HTTPS
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "p2"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "SYN Flood"
    Then UI Validate "Protection Policies.Events Table" Table rows count EQUALS to 1
    Then UI validate Table row by keyValue with elementLabel "Protection Policies.Events Table" findBy columnName "Packet Type" findBy cellValue "Regular"
    Then UI Click Button "Protection Policies.GO BACK"

  @SID_6
  Scenario: validate Events Table
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "p2"
    Then UI Click Switch button "Protection Policies.Protections Table.Switch Button" and set the status to "ON"
    Then UI Validate "Protection Policies.Events Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName  | value           |
      | Packet Type | Decrypted HTTPS |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 1
      | columnName  | value   |
      | Packet Type | Regular |

  @SID_7
  Scenario: Traffic Cleanup
    Given UI logout and close browser

