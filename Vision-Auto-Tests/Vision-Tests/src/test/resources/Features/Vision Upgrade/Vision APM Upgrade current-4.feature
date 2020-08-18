@TC116607
Feature: Vision APM Upgrade current -4

  @SID_1
  Scenario: Upgrade APM vision from release-4
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Then Upgrade to non-supported version
