@rest100
Feature: Demo


  Scenario: Delete User Before Creating it
    Given That Current Vision is Logged In

    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/mgmt/system/config/itemlist/SystemConfigItemList" with label "Get Local Users"
      | ormID | $[?(@.name=='cucumber')].ormID |



  Scenario: Create Local User
    Given That Current Vision is Logged In

    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/mgmt/system/config/itemlist/SystemConfigItemList" with label "Get Local Users"
      | ormID | $[?(@.name=='cucumber')].ormID |

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



