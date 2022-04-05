@TC111695
Feature: CLI System database Status

  @SID_1
  Scenario: System database Status menu
    When CLI Operations - Run Radware Session command "system database status ?"
    Then CLI Operations - Verify that output contains regex ".*Shows the status of the database service..*"

  @SID_2
  Scenario: System database Start menu
    When CLI Operations - Run Radware Session command "system database start?"
    Then CLI Operations - Verify that output contains regex ".*Usage: system database start.*"
    Then CLI Operations - Verify that output contains regex ".*Starts the database service.*"
    Then CLI Operations - Verify that output contains regex ".*DB service is up already.*"

  @SID_3
  Scenario: System database Sub Menu
    When CLI System Database Sub Menu Test

  @SID_4
  Scenario: System database Stop
    When CLI System Database Stop

  @SID_5
  Scenario: System database Stop menu
    When CLI Operations - Run Radware Session command "system database stop?"
    Then CLI Operations - Verify that output contains regex ".*Usage: system database stop.*"
    Then CLI Operations - Verify that output contains regex ".*Stops the database service.*"

  @SID_6
  Scenario: System database Start
    When CLI System Database Start

  @SID_7
  Scenario: System database Status - verify running
    When CLI System Database Status

  @SID_8
  Scenario: system database validate system status up and healthy
    When CLI validate service "all" status is "up" and health is "healthy" retry for 600 seconds
