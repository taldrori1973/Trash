@TC110735
Feature: Vision Upgrade current -4

  @SID_1
  Scenario: Upgrade vision from release-4
    Given CLI Reset radware password
    Then Upgrade to non-supported version
