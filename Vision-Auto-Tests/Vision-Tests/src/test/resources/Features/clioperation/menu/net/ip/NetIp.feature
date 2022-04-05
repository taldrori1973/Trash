@CLI_Positive @TC106021
Feature: Net Ip Functional Tests

  @SID_1
  Scenario: net ip tests
    Then CLI net ip test
  @SID_2
  Scenario: Verify services are running
    When CLI validate service "all" status is "up" and health is "healthy" retry for 600 seconds

  @SID_3
  Scenario: net ip set
    Then CLI net ip set

  @SID_4
  Scenario: net ip sub menu
    Then CLI Ip Sub Menu Test

  @SID_5
  Scenario: net ip management menu
    Then CLI Ip Management SubMenu Test

  @SID_6
  Scenario: net ip get
    Then CLI Net Ip Get

  @SID_7
  Scenario: net ip delete
    Then CLI Net Ip Delete

  @SID_8
  Scenario: Verify services are running
    When CLI validate service "all" status is "up" and health is "healthy" retry for 600 seconds


