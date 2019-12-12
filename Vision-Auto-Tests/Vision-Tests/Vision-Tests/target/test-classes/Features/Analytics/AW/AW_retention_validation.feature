@TC111219
Feature: AppWall Retention Validation

    @SID_1
  Scenario: Copy retention verification script
    * REST Delete ES index "appwall-v2-attack-raw-*"
    Then CLI copy "/home/radware/Scripts/retentionVerification_AppWall.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"

  @SID_2
  Scenario: Verify AppWall Network index raw retention task
#    Then CLI Run linux Command "/retentionVerification_AppWall.sh appwall v2 attack raw" on "ROOT_SERVER_CLI" and validate result EQUALS "Success"
    When Verify AW retention task of index aggregation for index "appwall-v2-attack-raw"

