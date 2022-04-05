@CLI_Negative @TC106031

Feature: Net Route Functional Negative Tests

  @SID_1
  Scenario: Net Route host Negative Tests
    Given CLI Net Route Set Ip Host Negative Input

  @SID_2
  Scenario: Net Route set Negative Tests
    And CLI Net Route Set Net Negative Input

  @SID_3
  Scenario: Net Route default Negative Tests
    And CLI Net Route Set Default Negative Input

  @SID_4
  Scenario: Net Route set host Negative Tests
    And CLI Net Route Set Host Negative Input

  @SID_5
  Scenario: Net Route delete Negative Tests
    And CLI Net Route Delete Negative Input

  @SID_6
  Scenario: Net Route get Negative Tests
    And CLI Net Route Get Negative Input

  @SID_7
  Scenario: Net Route set Negative Tests
    And CLI Net Route Set Negative Input

  @SID_8
  Scenario: Net Route Negative Tests
    And CLI Net Route Negative Input
