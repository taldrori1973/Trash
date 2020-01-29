@TC111695 @Test1
Feature: CLI System database Status

  @SID_1
  Scenario: System database Status menu
    When CLI Operations - Run Radware Session command "system database status?"
    Then CLI Operations - Verify that output contains regex ".*Shows the status of the database service..*"

  @SID_2
  Scenario: System database Start menu
    When CLI Operations - Run Radware Session command "system database start?"
    Then CLI Operations - Verify that output contains regex ".*Usage: system database start.*"
    Then CLI Operations - Verify that output contains regex ".*Starts the database service.*"
    Then CLI Operations - Verify that output contains regex ".*DB service is up already.*"

  @SID_3
  Scenario: System database Status - verify running
    When CLI Operations - Run Radware Session command "system database status"
    Then CLI Operations - Verify that output contains regex ".*MariaDB running.*"

  @SID_4
  Scenario: System database Stop
    When CLI Operations - Run Radware Session command "system database stop"
    Then CLI Operations - Verify that output contains regex ".*Shutting down MariaDB.*.*\[  OK  \]"
    Then CLI Operations - Verify that output contains regex ".*Database was stopped.*"
    Then CLI Operations - Verify that output contains regex ".*Stopping elasticsearch:.*\[  OK  \].*"

  @SID_5
  Scenario: System database Status - verify stopped
    When CLI Operations - Run Radware Session command "system database status"
    Then CLI Operations - Verify that output contains regex ".*MariaDB is not running.*\[FAILED\].*"

  @SID_6
  Scenario: System database Stop
    When CLI Operations - Run Radware Session command "system database stop"
    Then CLI Operations - Verify that output contains regex ".*DB service is down already.*"

  @SID_7
  Scenario: System database Stop menu
    When CLI Operations - Run Radware Session command "system database stop?"
    Then CLI Operations - Verify that output contains regex ".*Usage: system database stop.*"
    Then CLI Operations - Verify that output contains regex ".*Stops the database service.*"

  @SID_8
  Scenario: Verify databases are stopped
    Then CLI Run linux Command "service elasticsearch status" on "ROOT_SERVER_CLI" and validate result EQUALS "elasticsearch is stopped"
    Then CLI Run linux Command "service mysql status" on "ROOT_SERVER_CLI" and validate result CONTAINS "MariaDB is not running"

  @SID_9
  Scenario: System database Start
    When CLI Operations - Run Radware Session command "system database start"
    Then CLI Operations - Verify that output contains regex ".*Starting MariaDB.*"
    Then CLI Operations - Verify that output contains regex ".*Starting elasticsearch.*"

  @SID_10
  Scenario: System database Status - verify running
    When CLI Operations - Run Radware Session command "system database status"
    Then CLI Operations - Verify that output contains regex ".*MariaDB running.*"

  @SID_11
  Scenario: Verify databases are started
    Then CLI Run linux Command "service elasticsearch status |awk '{print$1, $4, $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "elasticsearch is running..."
    Then CLI Run linux Command "service mysql status" on "ROOT_SERVER_CLI" and validate result CONTAINS "MariaDB running"
