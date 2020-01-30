@TC112565
Feature: CLI System AVR help

  @SID_1
  Scenario: System AVR help
    When CLI Operations - Run Radware Session command "system avr?"
    Then CLI Operations - Verify that output contains regex "disable( |\t)+Stops and disables the APSolute Vision Reporter service.*"
    Then CLI Operations - Verify that output contains regex "enable( |\t)+Enables and starts the APSolute Vision Reporter service.*"
    Then CLI Operations - Verify that output contains regex "status( |\t)+Shows the status of the APSolute Vision Reporter service..*"

  @SID_2
  Scenario: System AVR status
    When CLI Operations - Run Radware Session command "system avr status?"
    Then CLI Operations - Verify that output contains regex "Usage: system avr status.*"
    Then CLI Operations - Verify that output contains regex "Shows the status of the APSolute Vision Reporter service..*"

  @SID_3
  Scenario: System AVR disable
    When CLI Operations - Run Radware Session command "system avr disable?"
    Then CLI Operations - Verify that output contains regex "Usage: system avr disable.*"
    Then CLI Operations - Verify that output contains regex "Stops and disables the APSolute Vision Reporter service.*"

  @SID_4
  Scenario: System AVR enable
    When CLI Operations - Run Radware Session command "system avr enable?"
    Then CLI Operations - Verify that output contains regex "Usage: system avr enable.*"
    Then CLI Operations - Verify that output contains regex "Enables and starts the APSolute Vision Reporter service..*"
