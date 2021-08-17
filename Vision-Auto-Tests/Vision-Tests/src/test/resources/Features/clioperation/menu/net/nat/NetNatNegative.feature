@CLI_Negative @TC106024

Feature: Net Nat Negative Functional Tests

  @SID_1
  Scenario: net nat negative functional tests
    Given CLI Net Nat Set HostName Negative
  @SID_2
  Scenario: Net Nat Set IP Negative
    And CLI Net Nat Set IP Negative
  @SID_3
  Scenario: Net Nat Get Negative
    And CLI Net Nat Get Negative
  @SID_4
  Scenario: et Nat Set Negative
    And CLI Net Nat Set Negative
  @SID_5
  Scenario: Net Nat Negative
    Then CLI Net Nat Negative

  @SID_6
  Scenario: Verify services are running
    When CLI validate service "all" status is "up" and health is "healthy" retry for 600 seconds
