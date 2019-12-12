@CLI_Negative @TC106019
Feature: Net Dns Negative Tests

  @SID_1
  Scenario: Net Dns Primary Set Negative
    When CLI Net Dns Primary Set Negative
  @SID_2
  Scenario: Net Dns Seconderay Set Negative
    When CLI Net Dns Seconderay Set Negative
  @SID_3
  Scenario: Net Dns Tertiary Set Negative
    When CLI Net Dns Tertiary Set Negative
  @SID_4
  Scenario: Net Dns Delete Tertiary Negative
    And CLI Net Dns Delete Tertiary Negative
  @SID_5
  Scenario: Net Dns Delete Seconderay Negative
    And CLI Net Dns Delete Seconderay Negative
  @SID_6
  Scenario: Net Dns Delete Primary Negative
    And CLI Net Dns Delete Primary Negative
  @SID_7
  Scenario: Net Dns Negative
    Then CLI Net Dns Negative
