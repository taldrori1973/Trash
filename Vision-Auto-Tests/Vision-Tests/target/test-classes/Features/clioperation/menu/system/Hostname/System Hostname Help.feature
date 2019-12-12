
@TC111674
Feature: CLI System Hostname Help

  @SID_1
  Scenario: System hostname help
    When CLI Operations - Run Radware Session command "system hostname ?"
    Then CLI Operations - Verify that output contains regex "get.*Displays the hostname.*"
    Then CLI Operations - Verify that output contains regex "set.*Sets a new hostname."

  @SID_2
  Scenario: system hostname get help
    When CLI Operations - Run Radware Session command "system hostname get ?"
    Then CLI Operations - Verify that output contains regex "Usage: system hostname get"
    Then CLI Operations - Verify that output contains regex "Displays the hostname."

  @SID_3
  Scenario: system hostname set help
    When CLI Operations - Run Radware Session command "system hostname set ?"
    Then CLI Operations - Verify that output contains regex "Usage: system hostname set"
    Then CLI Operations - Verify that output contains regex "Sets a new hostname."