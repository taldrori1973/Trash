#@rest100
@TC113068
Feature: Demo

#    Then MariaDb Test

  @run_kVision
  Scenario: MariaDb
#    Then MYSQL Validate Single Value by SELECT "name" Column FROM "VISION_NG" Schema and "vision_license" Table WHERE "description='Vision Reporting Module - ADC'" EQUALS null
#    Then MYSQL Validate Single Value by SELECT "license_str" Column FROM "VISION_NG" Schema and "vision_license" Table WHERE "description='Vision Reporting Module - ADC'" EQUALS "vision-reporting-module-ADC-3sp77Gn7"
#    Then MYSQL Validate Single Value by SELECT "is_expired" Column FROM "VISION_NG" Schema and "vision_license" Table WHERE "description='Vision Reporting Module - ADC'" EQUALS false
#    Then MYSQL Validate Single Value by SELECT "ormversion" Column FROM "VISION_NG" Schema and "vision_license" Table WHERE "description='Vision Reporting Module - ADC'" EQUALS 1
#    Then MYSQL Validate Single Value by SELECT "name" Column FROM "VISION_NG" Schema and "vision_license" Table WHERE "description='Vision Reporting Module - ADC'" EQUALS "null"
#    Then MYSQL Validate Single Value by SELECT "license_str" Column FROM "VISION_NG" Schema and "vision_license" Table WHERE "description='Vision Reporting Module - ADC'" EQUALS null
#    Then MYSQL Validate Single Value by SELECT "is_expired" Column FROM "VISION_NG" Schema and "vision_license" Table WHERE "description='Vision Reporting Module - ADC'" EQUALS "false"
#    Then MYSQL Validate Single Value by SELECT "ormversion" Column FROM "VISION_NG" Schema and "vision_license" Table WHERE "description='Vision Reporting Module - ADC'" EQUALS "1"
#    Then MYSQL Validate Single Value by SELECT "license_str" Column FROM "VISION_NG" Schema and "vision_license" Table WHERE "description='APSolute Vision Device Performance Monitor'" EQUALS "vision-perfreporter-16May2020-22May2020-JSDuGFSe"
#    Then MYSQL Validate Single Value by SELECT "license_str" Column FROM "VISION_NG" Schema and "vision_license" Table WHERE "description='APSolute Vision Device Performance Monitor'" MatchRegex ".*-perfreporter-16May2020-21May2020-JSDuGFSe"
#    Then MYSQL Validate Single Value by SELECT "license_str" Column FROM "VISION_NG" Schema and "vision_license" Table WHERE "description='APSolute Vision Device Performance Monitor'" MatchRegex "-perfreporter-.*"
#    Then MYSQL Validate Single Value by SELECT "is_expired" Column FROM "VISION_NG" Schema and "vision_license" Table WHERE "description='APSolute Vision Device Performance Monitor'" EQUALS "false"


#    Then MYSQL UPDATE "vision_license" Table in "VISION_NG" Schema SET "is_expired" Column Value as true WHERE "description='Vision Reporting Module - ADC'"
#    Then MYSQL UPDATE "vision_license" Table in "VISION_NG" Schema SET "is_expired" Column Value as false WHERE "description='Vision Reporting Module - ADC'" And VALIDATE 1 Records Was Updated
#    Then MYSQL UPDATE "vision_license" Table in "VISION_NG" Schema SET "name" Column Value as null WHERE "description='Vision Reporting Module - ADC'"
#    Then MYSQL UPDATE "vision_license" Table in "VISION_NG" Schema SET "ormversion" Column Value as 0 WHERE "description='Vision Reporting Module - ADC'"
#    Then MYSQL UPDATE "vision_license" Table in "VISION_NG" Schema SET "product_name" Column Value as "kvision" WHERE "description='Vision Reporting Module - ADC'"


#    Then MYSQL UPDATE "vision_license" Table in "VISION_NG" Schema SET The Following Columns Values WHERE "description='Vision Reporting Module - ADC'" And VALIDATE 1 Records Was Updated
#      | ormversion   | 1        |
#      | name         | null     |
#      | product_name | "vision" |
#      | is_expired   | false    |

    Then MYSQL Validate Number of Records FROM "vision_license" Table in "VISION_NG" Schema WHERE "" Condition Applies EQUALS 1
    Then MYSQL Validate Number of Records FROM "vision_license" Table in "VISION_NG" Schema WHERE "" Condition Applies EQUALS 0
    Then MYSQL Validate Number of Records FROM "vision_license" Table in "VISION_NG" Schema WHERE "" Condition Applies GT 0
  #    Then MYSQL DELETE FROM "vision_license" Table in "VISION_NG" Schema WHERE "description='APSolute Vision Device Performance Monitor'" And VALIDATE 1 Records Was Deleted

  Scenario: Licenses
#    Then REST Vision Install License Request "vision-reporting-module-ADC"
#
#    Then REST Vision Install License Request "vision-perfreporter" from date "-2d" to date "+3d"
#
    Then REST Vision DELETE License Request "vision-activation"
    Then REST Vision Install License Request vision-activation with expired date
#
#    Then REST Vision DELETE License Request "vision-activation"
#    Then REST Vision Install License Request "vision-activation"
#    Then REST Vision Install License Request "vision-reporting-module-AMS"
#    Then REST Vision DELETE License Request "vision-reporting-module-AMS"

  Scenario: Test
    Given SUT Test

  @SID_5
  Scenario: Create Local User

    Given That Current Vision is Logged In

    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Local Users"
      | ormID | $[?(@.name=='cucumber')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Delete an Item from the Server"

    And The Request Path Parameters Are
      | item | user     |
      | id   | ${ormID} |

    When Send Request with the Given Specification




    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Create Local User"

    Given The Request Body is the following Object
      | jsonPath                                                       | value                     |
      | $.name                                                         | "cucumber"                |
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


  Scenario: DefenseFlow

    Given That Defense Flow With Ip "172.17.160.152" And Port 9101 is Connected without Authentication
    Given New Request Specification from File "/DefenseFlow/VisionRequests.json" with label "Register DefenseFlow in Vision"
    And The Request Body is the following Object
      | jsonPath   | value            |
      | $.ip       | "172.17.192.100" |
      | $.user     | "defenseflow"    |
      | $.password | "defenseflow"    |

    When Send Request with the Given Specification

    Then Validate That Response Status Code Is OK

