@rest100
Feature: Demo

  Scenario: Validate AVA Attack Capacity License
    Given That Current Vision is Logged In
    And New GET Request Specification with Base Path "/mgmt/system/config/item/licenseinfo"
    And The Request Path Parameters Are
      | paramName1 | value |
      | paramName2 | value |
    And The Request Query Parameters Are
      | paramName1 | value |
      | paramName2 | value |
    And The Request Accept JSON
    And The Request Content Type Is JSON
    And The Request Headers Are
      | header Key | value |
      | header Key | value |
    And The Request Cookies Are
      | cookie key | value |
      | cookie key | value |
    And The Request Body Is
      |  |  |
    When Send Request with the Given Specification

    Then Validate That Response Status Code Is OK


