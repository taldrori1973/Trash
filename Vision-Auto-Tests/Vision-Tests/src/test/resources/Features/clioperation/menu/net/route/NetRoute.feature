@CLI_Positive @TC106030
Feature: Net Route Functional Tests

  @SID_1
  Scenario: net route get
    Then CLI Net Route Get

  @SID_2
  Scenario: net route set net
    Then CLI Net Route Set Net

  @SID_3
  Scenario: net route set host
    Then CLI Net Route Set Host

  @SID_4
  Scenario: net route sub menu set
    Then CLI Route Set Sub Menu Test

  @SID_5
  Scenario: net route main sub menu
    Then CLI Route Sub Menu Test

  @SID_6
  Scenario: net route delete
    Then CLI Net Route Delete

