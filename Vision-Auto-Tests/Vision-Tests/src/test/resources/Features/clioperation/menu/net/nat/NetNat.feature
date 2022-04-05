@CLI_Positive @TC106023

Feature: Net Nat CLI Tests

  @SID_1
  Scenario: net Sub Menu
    Given CLI net Sub Menu

  @SID_2
  Scenario: Net Nat Set IP
    When CLI Net Nat Set IP

  @SID_3
  Scenario: Net Nat Sub Menu
    And CLI Net Nat Sub Menu

  @SID_4
  Scenario: Net Nat Set Sub Menu
    And CLI Net Nat Set Sub Menu

  @SID_5
  Scenario: Net Nat Set HostName
    Then CLI Net Nat Set Host Name

  @SID_6
  Scenario: Net Nat Set none
    When Net Nat Set none

  @SID_7
  Scenario: Verify services are running
    When CLI validate service "all" status is "up" and health is "healthy" retry for 600 seconds

