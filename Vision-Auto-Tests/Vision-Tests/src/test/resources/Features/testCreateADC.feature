@run
Feature: test

  @SID_1
  Scenario: Login and Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @SID_8
  Scenario: create new Download Throughput bps1

    Then UI "Select" Scope Polices "BDOS,policy1,Policy14" in Device "DefensePro_172.16.22.50"

    Then UI "Validate" Scope Polices "BDOS,policy1,Policy14" in Device "DefensePro_172.16.22.50"


