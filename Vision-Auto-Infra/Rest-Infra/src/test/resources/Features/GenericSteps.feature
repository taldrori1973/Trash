@run
Feature: Generic Steps

  Scenario: Send Get Request
    Given Login to Vision With username "radware" and password "radware"
    Given New GET Request Specification
    And Request Base Path "mgmt/device/byip/{deviceIp}/config/rsIDSNewRulesTable"
    And Request Path Parameters
      | deviceIp | 172.16.22.51 |
    And Request Query Params
      | count | 5                 |
      | props | rsIDSNewRulesName |
    And Request Accept JSON
    And Request Content Type JSON
    And Request Headers
      | Connection | keep-alive |
    And Request Cookies
      | a | b |
    When Send Request
    Then Validate That Response Status Code Is OK

  Scenario: Send Get Request 2
    Given New GET Request Specification
    Given Request Base Path "mgmt/device/byip/{deviceIp}/config/rsIDSNewRulesTable"