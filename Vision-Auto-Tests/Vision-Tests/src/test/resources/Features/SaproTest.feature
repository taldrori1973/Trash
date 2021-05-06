@SAPRO
Feature: Test1

  Scenario: start
    Then From map "Automation_Machines" start devices
      | 50.50.100.1 |
      | 50.50.100.2 |

  Scenario: stop
    Then From map "Automation_Machines" stop devices
      | 50.50.100.1 |
      | 50.50.100.2 |