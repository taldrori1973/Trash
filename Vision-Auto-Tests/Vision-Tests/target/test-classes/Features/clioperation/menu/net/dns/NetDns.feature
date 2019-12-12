@CLI_Positive @TC106018
Feature: Net Dns Functional Tests

  @SID_1
  Scenario: net dns set sub menu
    Then CLI dns set sub menu

  @SID_2
  Scenario: net dns sub menu
    Then CLI dns sub menu

  @SID_3
  Scenario: net dns primary set
    Then CLI net dns primary Set

  @SID_4
  Scenario: net dns seconderay set
    Then CLI net dns seconderay set

  @SID_5
  Scenario: net dns tertiary set
    Then CLI net dns tertiary set

  @SID_6
  Scenario: net dns delete tertiary
    Then CLI net dns delete tertiary

  @SID_7
  Scenario: net dns delete secondary
    Then CLI net dns delete secondary

  @SID_8
  Scenario: net dns delete primary
    Then CLI net dns delete primary

  @SID_9
  Scenario: net dns get
    Then CLI net dns get
