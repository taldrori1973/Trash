@TC110735
Feature: Vision Upgrade current -4

  @SID_1
  Scenario: Upgrade vision from release-4
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Then Upgrade to non-supported version
