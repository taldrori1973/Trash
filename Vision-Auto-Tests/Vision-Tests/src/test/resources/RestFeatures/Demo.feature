@rest100
Feature: Demo

  Scenario: Validate AVA Attack Capacity License
    Given That Current Vision is Logged In
    And New GET Request Specification with Base Path "/mgmt/system/config/item/licenseinfo"
    And Request Content Type JSON

    When Send Request

    Then Validate That Response Status Code Is OK
#    And Validate That Response Body Contains
#      | jsonPathString                           | expectedValue |
#      | $.attackCapacityLicense.licenseViolation | false         |
#      | $.attackCapacityLicense.isInGracePeriod  | false         |

  Scenario: Validate AppWall User Access
    Given That Device AppWall with IP "172.17.164.30" is Logged In With Username "user1" and Password "1qaz!QAZ"
    And New GET Request Specification with Base Path "/v2/config/aw/Users/{Login_Name}"
    And Request Path Parameters
      | Login_Name | user1 |
    When Send Request

    Then Validate That Response Status Code Is OK

