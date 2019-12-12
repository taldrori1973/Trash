@CLI_Negative @TC106028

Feature: Net Physical Interface Negative Functional Tests

  @SID_1
  Scenario: Net Physical-Interface Set Negative
    Given CLI Net Physical-Interface Set Negative
  @SID_2
  Scenario: Net Physical-Interface Negative
    When CLI Net Physical-Interface Negative
  @SID_3
  Scenario: Net Physical-Interface Get Negative
    Then CLI Net Physical-Interface Get Negative
