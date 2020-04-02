@CLI_Positive @TC108896
Feature: Config-Sync failure mail

  @SID_4
  Scenario: Mail Failure
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Then CLI Verify Config Sync Failure Mail