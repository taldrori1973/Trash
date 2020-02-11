@TC113290
Feature: AMS Dashboards Title

  @SID_1
  Scenario: VRM - Login to VRM "Wizard" Test
    * REST Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-AppWall"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given UI Login with user "radware" and password "radware"


  @SID_2
  Scenario: Validate Title Of DefensePro Behavioral Protections Dashboard
    Given UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Validate Text field "Title" EQUALS "DefensePro Behavioral Protections"

  @SID_3
  Scenario: Validate Title Of HTTPS Flood Dashboard
    Given UI Navigate to "HTTPS Flood Dashboard" page via homePage
    Then UI Validate Text field "Title" EQUALS "HTTPS Flood"

  @SID_4
  Scenario: Validate Title Of DefensePro Analytics Dashboard
    Given UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics"

  @SID_5
  Scenario: Validate Title Of DefensePro Monitoring Dashboard
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Validate Text field "Title" EQUALS "DefensePro Monitoring"

  @SID_6
  Scenario: Validate Title Of DefenseFlow Analytics Dashboard
    Given UI Navigate to "DefenseFlow Analytics Dashboard" page via homePage
    Then UI Validate Text field "Title" EQUALS "DefenseFlow Analytics"

  @SID_7
  Scenario: Validate Title Of AppWall Dashboard
    And UI Navigate to "AppWall Dashboard" page via homePage
    Then UI Validate Text field "Title" EQUALS "AppWall"

  @SID_8
  Scenario: Cleanup
    Then UI logout and close browser