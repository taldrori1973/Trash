@rest100
Feature: Demo

#  Scenario: Validate AVA Attack Capacity License
#    Given That Current Vision is Logged In
#    And New GET Request Specification with Base Path "/mgmt/system/config/item/licenseinfo"
#    And The Request Path Parameters Are
#      | paramName1 | value |
#      | paramName2 | value |
#    And The Request Query Parameters Are
#      | paramName1 | value |
#      | paramName2 | value |
#    And The Request Accept JSON
#    And The Request Content Type Is JSON
#    And The Request Headers Are
#      | header Key | value |
#      | header Key | value |
#    And The Request Cookies Are
#      | cookie key | value |
#      | cookie key | value |
#    And The Request Body Is
#      | key | string |
#      | object.key | string |
#      | object.key.key | string |
#      |key | boolean |
#
#    {key string,
#  {}
#  {}
#  key boolean}
#    When Send Request with the Given Specification
#
#    Then Validate That Response Status Code Is OK

#
#  Scenario: Get Local Users
#    Given That Current Vision is Logged In
#    Given New Request Specification from File "/Vision/mgmt/system/config/itemlist/SystemConfigItemList" with label "Get Local Users"
#    When Send Request with the Given Specification
#    Then Validate That Response Status Code Is OK

  Scenario: Get Local User
    Given That Current Vision is Logged In
    And Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/mgmt/system/config/itemlist/SystemConfigItemList" with label "Get Local Users"
#      | label | jsonPath                      |
      | ormID | $[?(@.name=='radware')].ormID |

    Given New Request Specification from File "/Vision/mgmt/system/config/itemlist/SystemConfigItemList" with label "Get Local User"
    And The Request Path Parameters Are
      | id | ${ormID} |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK



