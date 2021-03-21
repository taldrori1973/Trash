@CLI_Positive @TC108896
Feature: Config-Sync failure mail

  @SID_4
  Scenario: Mail Failure
    Given CLI Reset radware password
    Then CLI Verify Config Sync Failure Mail

  @SID_5
  Scenario: set config-sync mode to disabled
    Then CLI Set both visions disabled with timeout 3000
