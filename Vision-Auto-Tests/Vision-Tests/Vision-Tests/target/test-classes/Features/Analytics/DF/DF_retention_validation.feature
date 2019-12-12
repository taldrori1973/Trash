@TC110769
Feature: DF Retention Validation

  @SID_1
  Scenario: Copy retention verification script
    Then CLI copy "/home/radware/Scripts/retentionVerification.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"

  @SID_2
  Scenario: Verify DF Attack retention task
    When Verify retention task of index aggregation for index "df-attack-raw"

  @SID_3
  Scenario: Verify DF Traffic retention task
    When Verify retention task of index aggregation for index "df-traffic-raw"
