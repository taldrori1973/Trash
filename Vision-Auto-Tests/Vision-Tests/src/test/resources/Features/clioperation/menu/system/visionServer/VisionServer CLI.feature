@CLI_Positive @TC106040

Feature: Vision Server Services CLI Tests

  @SID_1
  Scenario: system vision-server help
    Given CLI Reset radware password
    When CLI Vision Server SubMenu Test

  @SID_2
  Scenario: system vision-server start help
    When CLI Operations - Run Radware Session help command "system vision-server start ?"
    Then CLI Operations - Verify that output contains regex "Usage: system vision-server start.*"
    Then CLI Operations - Verify that output contains regex "Starts the APSolute Vision server..*"

  @SID_3
  Scenario: system vision-server status help
    When CLI Operations - Run Radware Session help command "system vision-server status ?"
    Then CLI Operations - Verify that output contains regex "Usage: system vision-server status.*"
    Then CLI Operations - Verify that output contains regex "Shows the status of the APSolute Vision server..*"

  @SID_4
  Scenario: system vision-server stop help
    When CLI Operations - Run Radware Session help command "system vision-server stop ?"
    Then CLI Operations - Verify that output contains regex "Usage: system vision-server stop.*"
    Then CLI Operations - Verify that output contains regex "Stops the APSolute Vision server..*"

  @SID_5
  Scenario: system vision-server stop
    When CLI Server Stop

  @SID_6
  Scenario: system vision-server start
    When CLI Server Start

  @SID_7
  Scenario: system vision-server validate status up and healthy
    When CLI validate service "all" status is "up" and health is "healthy" retry for 600 seconds