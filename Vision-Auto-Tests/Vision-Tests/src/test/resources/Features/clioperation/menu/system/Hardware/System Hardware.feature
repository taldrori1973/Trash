@TC111797
Feature: CLI System Hardware

  @SID_1
  Scenario: System hardware menu
    When CLI Operations - Run Radware Session command "system hardware?"
    Then CLI Operations - Verify that output contains regex "Displays the system hardware.*"
    Then CLI Operations - Verify that output contains regex ".*status( |\t)+Displays the fan/temperature status of the system hardware.*"

  @SID_2
  Scenario: system hardware status menu
    When CLI Operations - Run Radware Session command "system hardware status?"
    Then CLI Operations - Verify that output contains regex "Displays the fan/temperature status of the system hardware.*"
    Then CLI Operations - Verify that output contains regex ".*get( |\t)+Displays the fan/temperature status of the system hardware.*"

  @SID_3
  Scenario: System hardware status get VM
    When CLI Operations - Run Radware Session command "system hardware status get"
    Then CLI Operations - Verify that output contains regex "The command is not supported on this platform.*"
