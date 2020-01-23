@rest100
Feature: Demo


  Scenario: Create Local User
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/mgmt/system/config/itemlist/SystemConfigItemList" with label "Create Local User"
    Given The Request Body is the following Object
      | jsonPath                                                       | value                     |
      | $.name                                                         | "cucumber10"              |
      | $.password                                                     | ""                        |
      | $.requireDeviceLock                                            | true                      |
      | $.userSettings.userLocale                                      | "en_US"                   |
      | $.parameters.roleGroupPairList[0].groupName                    | "VA_DPs_Version_8_site"   |
      | $.parameters.roleGroupPairList[0].roleName                     | "CONFIG"                  |
      | $.networkPolicies[0].networkProtectionRuleId.deviceId          | "DefensePro_172.16.22.55" |
      | $.networkPolicies[0].networkProtectionRuleId.rsIDSNewRulesName | "BDOS"                    |
      | $.networkPolicies[1].networkProtectionRuleId.deviceId          | "DefensePro_172.16.22.55" |
      | $.networkPolicies[1].networkProtectionRuleId.rsIDSNewRulesName | "Maxim30"                 |
      | $.roleGroupPairList[0].groupName                               | "VA_DPs_Version_8_site"   |
      | $.roleGroupPairList[0].roleName                                | "CONFIG"                  |

    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |



