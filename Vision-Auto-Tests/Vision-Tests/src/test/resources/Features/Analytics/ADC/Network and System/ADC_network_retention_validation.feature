@TC107067
Feature: ADC Network Retention Validation

  @SID_1
  Scenario: Copy retention verification script
    Then CLI copy "/home/radware/Scripts/retentionVerification.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"

  @SID_2
  Scenario: Verify ADC Network index hourly retention task
    When Verify retention task of index aggregation for index "adc-network-hourly"

  @SID_3
  Scenario: Verify ADC Network index raw retention task
    When Verify retention task of index aggregation for index "adc-network-raw"
