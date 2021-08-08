@CLI_Positive @TC106020
Feature: Net Firewall Tests

  @SID_1
  Scenario: Net Firewall Submenu
    When CLI Net Firewall Submenu

  @SID_2
  Scenario: Net Firewall open-port Submenu
    And CLI Net Firewall open-port Submenu

  @SID_3
  Scenario: Net Firewall open-port set open
    And CLI Net Firewall open-port set open

  @SID_4
  Scenario: Net Firewall open-port set close
    And CLI Net Firewall open-port set close

