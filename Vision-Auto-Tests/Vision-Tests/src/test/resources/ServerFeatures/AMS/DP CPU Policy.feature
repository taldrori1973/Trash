@TC114856
Feature: DP CPU Policy Utilization

  @SID_1
  Scenario: Simulate Attacks
    * CLI Clear vision logs
    * CLI kill all simulator attacks on current vision
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"
    Then CLI simulate 1000 attacks of type "dp_two_policies" on "DefensePro" 10 and wait 120 seconds

  @SID_2
  Scenario: Validate Dp Policy Utilization Including Device and Policy With Data
    Given That Current Vision is Logged In With Username "radware" and Password "radware"
    And Send DpPolicyUtilization Request
      | jsonPath               | value          |
      | $.timeFrame.value      | 15             |
      | $.timeFrame.unit       | "minute"       |
      | $.timeFrame.fromDate   |                |
      | $.timeFrame.toDate     |                |
      | $.timeFrame.dataPoints | 91             |
      | $.selected.deviceIP    | "172.16.22.50" |
      | $.selected.policy.name | "puPolicy1"    |
    Then Validate That Response Status Code Is OK
    Then Validate totalHits for DpPolicyUtilization
    Then Validate policyUtil for DpPolicyUtilization

  @SID_3
  Scenario: Validate Dp Policy Utilization Including Device and Policy With Data 2
    Given That Current Vision is Logged In With Username "radware" and Password "radware"
    Then Send DpPolicyUtilization Request
      | jsonPath               | value          |
      | $.timeFrame.value      | 15             |
      | $.timeFrame.unit       | "minute"       |
      | $.timeFrame.fromDate   |                |
      | $.timeFrame.toDate     |                |
      | $.timeFrame.dataPoints | 91             |
      | $.selected.deviceIP    | "172.16.22.50" |
      | $.selected.policy.name | "puPolicy2"    |
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath                 | value |
      | $.data[0].row.policyUtil | "0"   |
    Then Validate totalHits for DpPolicyUtilization

  @SID_4
  Scenario: Validate Dp Policy Utilization Including Device Without Data - Device Negative
    Given That Current Vision is Logged In With Username "radware" and Password "radware"
    Then Send DpPolicyUtilization Request
      | jsonPath               | value          |
      | $.timeFrame.value      | 15             |
      | $.timeFrame.unit       | "minute"       |
      | $.timeFrame.fromDate   |                |
      | $.timeFrame.toDate     |                |
      | $.timeFrame.dataPoints | 91             |
      | $.selected.deviceIP    | "172.16.22.51" |
      | $.selected.policy.name | "puPolicy1"    |
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath             | value |
      | $.metaData.totalHits | "0"   |
    Then Validate Object "$.data" isEmpty "true"

  @SID_5
  Scenario: Validate Dp Policy Utilization Including Policy Without Data - Policy Negative
    Given That Current Vision is Logged In With Username "radware" and Password "radware"
    Then Send DpPolicyUtilization Request
      | jsonPath               | value          |
      | $.timeFrame.value      | 15             |
      | $.timeFrame.unit       | "minute"       |
      | $.timeFrame.fromDate   |                |
      | $.timeFrame.toDate     |                |
      | $.timeFrame.dataPoints | 91             |
      | $.selected.deviceIP    | "172.16.22.50" |
      | $.selected.policy.name | "BDOS"         |
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath             | value |
      | $.metaData.totalHits | "0"   |
    Then Validate Object "$.data" isEmpty "true"

  @SID_6
  Scenario: Validate Dp CPU Utilization Including Device and Policy With Data
    Given That Current Vision is Logged In With Username "radware" and Password "radware"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.50" |
      | $.selectedDevices[0].networkPolicies[0] | "SSL2"         |
      | $.selectedDevices[0].networkPolicies[1] | "BDOS"         |
      | $.selectedDevices[0].networkPolicies[2] | "bdos1"        |
      | $.selectedDevices[0].networkPolicies[3] | "pol"          |
      | $.selectedDevices[0].networkPolicies[4] | "pol1"         |
      | $.selectedDevices[0].networkPolicies[5] | "policy1"      |
      | $.selectedDevices[0].networkPolicies[6] | "policy20"     |
      | $.selectedDevices[0].networkPolicies[7] | "puPolicy1"    |
      | $.selectedDevices[0].networkPolicies[8] | "puPolicy2"    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    And Validate That Response Body Contains
      | jsonPath                                                  | value          |
      | $.devices[0].policies[?(@.name=='puPolicy2')].utilization | 0              |
      | $.devices[0].deviceIP                                     | "172.16.22.50" |
    Then Validate DeviceUtilization for DpCpuUtilization
    Then Validate Utilization for puPolicy1 DpCpuUtilization

  @SID_7
  Scenario: Validate Dp CPU Utilization Including Device and One Policy With Data
    Given That Current Vision is Logged In With Username "radware" and Password "radware"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.50" |
      | $.selectedDevices[0].networkPolicies[0] | "puPolicy1"    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    And Validate That Response Body Contains
      | jsonPath                      | value          |
      | $.devices[0].deviceIP         | "172.16.22.50" |
      | $.devices[0].policies[0].name | "puPolicy1"    |
    Then Validate DeviceUtilization for DpCpuUtilization
    Then Validate Utilization for puPolicy1 DpCpuUtilization

  @SID_8
  Scenario: Validate Dp CPU Utilization Including Device and One Policy With Data 2
    Given That Current Vision is Logged In With Username "radware" and Password "radware"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.50" |
      | $.selectedDevices[0].networkPolicies[0] | "puPolicy2"    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    And Validate That Response Body Contains
      | jsonPath                             | value          |
      | $.devices[0].deviceIP                | "172.16.22.50" |
      | $.devices[0].deviceUtilization       | 0              |
      | $.devices[0].policies[0].name        | "puPolicy2"    |
      | $.devices[0].policies[0].utilization | 0              |
    And Validate DeviceUtilization for DpCpuUtilization

  @SID_9
  Scenario: Validate Dp CPU Utilization Including Device and One Policy With Data - multiple policies
    Given That Current Vision is Logged In With Username "radware" and Password "radware"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.50" |
      | $.selectedDevices[0].networkPolicies[0] | "SSL2"         |
      | $.selectedDevices[0].networkPolicies[1] | "BDOS"         |
      | $.selectedDevices[0].networkPolicies[2] | "bdos1"        |
      | $.selectedDevices[0].networkPolicies[3] | "pol"          |
      | $.selectedDevices[0].networkPolicies[4] | "pol1"         |
      | $.selectedDevices[0].networkPolicies[5] | "policy1"      |
      | $.selectedDevices[0].networkPolicies[6] | "policy20"     |
      | $.selectedDevices[0].networkPolicies[7] | "puPolicy2"    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    And Validate That Response Body Contains
      | jsonPath                             | value          |
      | $.devices[0].deviceIP                | "172.16.22.50" |
      | $.devices[0].deviceUtilization       | 0              |
      | $.devices[0].policies[0].name        | "puPolicy2"    |
      | $.devices[0].policies[0].utilization | 0              |
    And Validate DeviceUtilization for DpCpuUtilization

  @SID_10
  Scenario: Validate Dp CPU Utilization Including Device Without Data - device negative
    Given That Current Vision is Logged In With Username "radware" and Password "radware"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.51" |
      | $.selectedDevices[0].networkPolicies[0] | "SSL2"         |
      | $.selectedDevices[0].networkPolicies[1] | "BDOS"         |
      | $.selectedDevices[0].networkPolicies[2] | "bdos1"        |
      | $.selectedDevices[0].networkPolicies[3] | "pol"          |
      | $.selectedDevices[0].networkPolicies[4] | "pol1"         |
      | $.selectedDevices[0].networkPolicies[5] | "policy1"      |
      | $.selectedDevices[0].networkPolicies[6] | "policy20"     |
      | $.selectedDevices[0].networkPolicies[7] | "puPolicy1"    |
      | $.selectedDevices[0].networkPolicies[8] | "puPolicy2"    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate Object "$.devices" isEmpty "true"

  @SID_11
  Scenario: Validate Dp CPU Utilization Including Policies Without Data - policy negative
    Given That Current Vision is Logged In With Username "radware" and Password "radware"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.50" |
      | $.selectedDevices[0].networkPolicies[0] | "SSL2"         |
      | $.selectedDevices[0].networkPolicies[1] | "BDOS"         |
      | $.selectedDevices[0].networkPolicies[2] | "bdos1"        |
      | $.selectedDevices[0].networkPolicies[3] | "pol"          |
      | $.selectedDevices[0].networkPolicies[4] | "pol1"         |
      | $.selectedDevices[0].networkPolicies[5] | "policy1"      |
      | $.selectedDevices[0].networkPolicies[6] | "policy20"     |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate Object "$.devices" isEmpty "true"



################################################################################ RBAC ################################################################################
  ########################################################### SEC_MON - LOCAL ###########################################################
  @SID_12
  Scenario: Authentication Mode - Local User
    Given That Current Vision is Logged In With Username "radware" and Password "radware"
    * REST Send simple body request from File "Vision/SystemManagement.json" with label "Set Authentication Mode"
      | jsonPath             | value   |
      | $.authenticationMode | "Local" |

  @SID_13
  Scenario: Create Local User SEC_MON One Device All Policies 1
    Given That Current Vision is Logged In
    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Local Users"
      | ormID | $[?(@.name=='RadwareTest')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Delete an Item from the Server"
    And The Request Path Parameters Are
      | item | user     |
      | id   | ${ormID} |

    When Send Request with the Given Specification
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Create Local User"
    Given The Request Body is the following Object
      | jsonPath                                                       | value                     |
      | $.name                                                         | "RadwareTest"             |
      | $.password                                                     | "Radware123321"           |
      | $.requireDeviceLock                                            | true                      |
      | $.userSettings.userLocale                                      | "en_US"                   |
      | $.parameters.roleGroupPairList[0].groupName                    | "DefensePro_172.16.22.50" |
      | $.parameters.roleGroupPairList[0].roleName                     | "SEC_MON"                 |
      | $.networkPolicies[0].networkProtectionRuleId.deviceId          | "[ALL]"                   |
      | $.networkPolicies[0].networkProtectionRuleId.rsIDSNewRulesName | "[ALL]"                   |
      | $.roleGroupPairList[0].groupName                               | "DefensePro_172.16.22.50" |
      | $.roleGroupPairList[0].roleName                                | "SEC_MON"                 |

    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_14
  Scenario: Validate RBAC Dp CPU Utilization With All Policies And Restricted Device - Forbidden Access
    Given That Current Vision is Logged In With Username "RadwareTest" and Password "Radware123321"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.51" |
      | $.selectedDevices[0].networkPolicies[0] | "SSL2"         |
      | $.selectedDevices[0].networkPolicies[1] | "BDOS"         |
      | $.selectedDevices[0].networkPolicies[2] | "bdos1"        |
      | $.selectedDevices[0].networkPolicies[3] | "pol"          |
      | $.selectedDevices[0].networkPolicies[4] | "pol1"         |
      | $.selectedDevices[0].networkPolicies[5] | "policy1"      |
      | $.selectedDevices[0].networkPolicies[6] | "policy20"     |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is Forbidden
    And Validate That Response Body Contains
      | jsonPath  | value                                        |
      | $.status  | 403                                          |
      | $.error   | "Forbidden"                                  |
      | $.message | "Access Error: Unauthorised. Access Denied." |

  @SID_15
  Scenario: Validate RBAC Dp CPU Utilization With All Policies And Restricted Device
    Given That Current Vision is Logged In With Username "RadwareTest" and Password "Radware123321"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.50" |
      | $.selectedDevices[0].networkPolicies[0] | "SSL2"         |
      | $.selectedDevices[0].networkPolicies[1] | "BDOS"         |
      | $.selectedDevices[0].networkPolicies[2] | "bdos1"        |
      | $.selectedDevices[0].networkPolicies[3] | "pol"          |
      | $.selectedDevices[0].networkPolicies[4] | "pol1"         |
      | $.selectedDevices[0].networkPolicies[5] | "puPolicy1"    |
      | $.selectedDevices[0].networkPolicies[6] | "puPolicy2"    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    And Validate That Response Body Contains
      | jsonPath                                                  | value          |
      | $.devices[0].policies[?(@.name=='puPolicy2')].utilization | 0              |
      | $.devices[0].deviceIP                                     | "172.16.22.50" |
    Then Validate DeviceUtilization for DpCpuUtilization
    Then Validate Utilization for puPolicy1 DpCpuUtilization

  @SID_16
  Scenario: Create Local User SEC_MON One Device All Policies 2
    Given That Current Vision is Logged In
    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Local Users"
      | ormID | $[?(@.name=='RadwareTest1')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Delete an Item from the Server"
    And The Request Path Parameters Are
      | item | user     |
      | id   | ${ormID} |

    When Send Request with the Given Specification
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Create Local User"
    Given The Request Body is the following Object
      | jsonPath                                                       | value                     |
      | $.name                                                         | "RadwareTest1"            |
      | $.password                                                     | "Radware123321"           |
      | $.requireDeviceLock                                            | true                      |
      | $.userSettings.userLocale                                      | "en_US"                   |
      | $.parameters.roleGroupPairList[0].groupName                    | "DefensePro_172.16.22.51" |
      | $.parameters.roleGroupPairList[0].roleName                     | "SEC_MON"                 |
      | $.networkPolicies[0].networkProtectionRuleId.deviceId          | "[ALL]"                   |
      | $.networkPolicies[0].networkProtectionRuleId.rsIDSNewRulesName | "[ALL]"                   |
      | $.roleGroupPairList[0].groupName                               | "DefensePro_172.16.22.51" |
      | $.roleGroupPairList[0].roleName                                | "SEC_MON"                 |

    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_17
  Scenario: Validate RBAC Dp CPU Utilization With All Policies And Restricted Device - Forbidden Access
    Given That Current Vision is Logged In With Username "RadwareTest1" and Password "Radware123321"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.50" |
      | $.selectedDevices[0].networkPolicies[0] | "SSL2"         |
      | $.selectedDevices[0].networkPolicies[1] | "BDOS"         |
      | $.selectedDevices[0].networkPolicies[2] | "bdos1"        |
      | $.selectedDevices[0].networkPolicies[3] | "pol"          |
      | $.selectedDevices[0].networkPolicies[4] | "pol1"         |
      | $.selectedDevices[0].networkPolicies[5] | "puPolicy1"    |
      | $.selectedDevices[0].networkPolicies[6] | "puPolicy2"    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is Forbidden
    And Validate That Response Body Contains
      | jsonPath  | value                                        |
      | $.status  | 403                                          |
      | $.error   | "Forbidden"                                  |
      | $.message | "Access Error: Unauthorised. Access Denied." |

  @SID_18
  Scenario: Validate RBAC Dp CPU Utilization With All Policies And Restricted Device
    Given That Current Vision is Logged In With Username "RadwareTest1" and Password "Radware123321"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.51" |
      | $.selectedDevices[0].networkPolicies[0] | "SSL2"         |
      | $.selectedDevices[0].networkPolicies[1] | "BDOS"         |
      | $.selectedDevices[0].networkPolicies[2] | "bdos1"        |
      | $.selectedDevices[0].networkPolicies[3] | "pol"          |
      | $.selectedDevices[0].networkPolicies[4] | "pol1"         |
      | $.selectedDevices[0].networkPolicies[5] | "policy1"      |
      | $.selectedDevices[0].networkPolicies[6] | "policy20"     |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate Object "$.devices" isEmpty "true"

  @SID_19
  Scenario: Create Local User SEC_MON All Devices And Restricted Policies 3
    Given That Current Vision is Logged In
    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Local Users"
      | ormID | $[?(@.name=='RadwareTest2')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Delete an Item from the Server"
    And The Request Path Parameters Are
      | item | user     |
      | id   | ${ormID} |

    When Send Request with the Given Specification
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Create Local User"
    Given The Request Body is the following Object
      | jsonPath                                                       | value                     |
      | $.name                                                         | "RadwareTest2"            |
      | $.password                                                     | "Radware123321"           |
      | $.requireDeviceLock                                            | true                      |
      | $.userSettings.userLocale                                      | "en_US"                   |
      | $.parameters.roleGroupPairList[0].groupName                    | "[ALL]"                   |
      | $.parameters.roleGroupPairList[0].roleName                     | "SEC_MON"                 |
      | $.networkPolicies[0].networkProtectionRuleId.deviceId          | "DefensePro_172.16.22.50" |
      | $.networkPolicies[0].networkProtectionRuleId.rsIDSNewRulesName | "policy1"                 |
      | $.networkPolicies[1].networkProtectionRuleId.deviceId          | "DefensePro_172.16.22.51" |
      | $.networkPolicies[1].networkProtectionRuleId.rsIDSNewRulesName | "[ALL]"                   |
      | $.roleGroupPairList[0].groupName                               | "[ALL]"                   |
      | $.roleGroupPairList[0].roleName                                | "SEC_MON"                 |

    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_20
  Scenario: Validate RBAC Dp CPU Utilization With All Policies And Restricted Device
    Given That Current Vision is Logged In With Username "RadwareTest2" and Password "Radware123321"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.51" |
      | $.selectedDevices[0].networkPolicies[0] | "SSL2"         |
      | $.selectedDevices[0].networkPolicies[1] | "BDOS"         |
      | $.selectedDevices[0].networkPolicies[2] | "bdos1"        |
      | $.selectedDevices[0].networkPolicies[3] | "pol"          |
      | $.selectedDevices[0].networkPolicies[4] | "pol1"         |
      | $.selectedDevices[0].networkPolicies[5] | "policy1"      |
      | $.selectedDevices[0].networkPolicies[6] | "policy20"     |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate Object "$.devices" isEmpty "true"

  @SID_21
  Scenario: Validate RBAC Dp CPU Utilization With All Policies And Restricted Device - Forbidden Access
    Given That Current Vision is Logged In With Username "RadwareTest2" and Password "Radware123321"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.50" |
      | $.selectedDevices[0].networkPolicies[0] | "puPolicy1"    |
      | $.selectedDevices[0].networkPolicies[0] | "puPolicy2"    |

    When Send Request with the Given Specification
    Then Validate That Response Status Code Is Forbidden
    And Validate That Response Body Contains
      | jsonPath  | value                                        |
      | $.status  | 403                                          |
      | $.error   | "Forbidden"                                  |
      | $.message | "Access Error: Unauthorised. Access Denied." |

  @SID_22
  Scenario: Validate RBAC Dp Policy Utilization - Forbidden Access No Data
    # this test is catch bug and fixed in 4.70 (management decision), in 4.60 it will fail, TODO in 4.70
#    Given That Current Vision is Logged In With Username "RadwareTest2" and Password "Radware123321"
#    Then Send DpPolicyUtilization Request
#      | jsonPath               | value          |
#      | $.timeFrame.value      | 15             |
#      | $.timeFrame.unit       | "minute"       |
#      | $.timeFrame.fromDate   |                |
#      | $.timeFrame.toDate     |                |
#      | $.timeFrame.dataPoints | 91             |
#      | $.selected.deviceIP    | "172.16.22.50" |
#      | $.selected.policy.name | "puPolicy1"    |
#    Then Validate That Response Status Code Is FORBIDDEN
#    Then Validate That Response Body Contains
#      | jsonPath  | value                                        |
#      | $.status  | 403                                          |
#      | $.error   | "Forbidden"                                  |
#      | $.message | "Access Error: Unauthorised. Access Denied." |

    ########################################################### SEC_ADMIN - LOCAL ###########################################################
  @SID_23
  Scenario: Create Local User SEC_ADMIN One Device All Policies 1
    Given That Current Vision is Logged In
    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Local Users"
      | ormID | $[?(@.name=='RadwareTest3')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Delete an Item from the Server"
    And The Request Path Parameters Are
      | item | user     |
      | id   | ${ormID} |

    When Send Request with the Given Specification
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Create Local User"
    Given The Request Body is the following Object
      | jsonPath                                                       | value                     |
      | $.name                                                         | "RadwareTest3"            |
      | $.password                                                     | "Radware123321"           |
      | $.requireDeviceLock                                            | true                      |
      | $.userSettings.userLocale                                      | "en_US"                   |
      | $.parameters.roleGroupPairList[0].groupName                    | "DefensePro_172.16.22.50" |
      | $.parameters.roleGroupPairList[0].roleName                     | "SEC_ADMIN"               |
      | $.networkPolicies[0].networkProtectionRuleId.deviceId          | "[ALL]"                   |
      | $.networkPolicies[0].networkProtectionRuleId.rsIDSNewRulesName | "[ALL]"                   |
      | $.roleGroupPairList[0].groupName                               | "DefensePro_172.16.22.50" |
      | $.roleGroupPairList[0].roleName                                | "SEC_ADMIN"               |

    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_24
  Scenario: Validate RBAC Dp CPU Utilization With All Policies And Restricted Device - Forbidden Access
    Given That Current Vision is Logged In With Username "RadwareTest3" and Password "Radware123321"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.51" |
      | $.selectedDevices[0].networkPolicies[0] | "SSL2"         |
      | $.selectedDevices[0].networkPolicies[1] | "BDOS"         |
      | $.selectedDevices[0].networkPolicies[2] | "bdos1"        |
      | $.selectedDevices[0].networkPolicies[3] | "pol"          |
      | $.selectedDevices[0].networkPolicies[4] | "pol1"         |
      | $.selectedDevices[0].networkPolicies[5] | "policy1"      |
      | $.selectedDevices[0].networkPolicies[6] | "policy20"     |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is Forbidden
    And Validate That Response Body Contains
      | jsonPath  | value                                        |
      | $.status  | 403                                          |
      | $.error   | "Forbidden"                                  |
      | $.message | "Access Error: Unauthorised. Access Denied." |

  @SID_25
  Scenario: Validate RBAC Dp CPU Utilization With All Policies And Restricted Device
    Given That Current Vision is Logged In With Username "RadwareTest3" and Password "Radware123321"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.50" |
      | $.selectedDevices[0].networkPolicies[0] | "SSL2"         |
      | $.selectedDevices[0].networkPolicies[1] | "BDOS"         |
      | $.selectedDevices[0].networkPolicies[2] | "bdos1"        |
      | $.selectedDevices[0].networkPolicies[3] | "pol"          |
      | $.selectedDevices[0].networkPolicies[4] | "pol1"         |
      | $.selectedDevices[0].networkPolicies[5] | "puPolicy1"    |
      | $.selectedDevices[0].networkPolicies[6] | "puPolicy2"    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    And Validate That Response Body Contains
      | jsonPath                                                  | value          |
      | $.devices[0].policies[?(@.name=='puPolicy2')].utilization | 0              |
      | $.devices[0].deviceIP                                     | "172.16.22.50" |
    Then Validate DeviceUtilization for DpCpuUtilization
    Then Validate Utilization for puPolicy1 DpCpuUtilization

  @SID_26
  Scenario: Create Local User SEC_ADMIN One Device All Policies 2
    Given That Current Vision is Logged In
    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Local Users"
      | ormID | $[?(@.name=='RadwareTest4')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Delete an Item from the Server"
    And The Request Path Parameters Are
      | item | user     |
      | id   | ${ormID} |

    When Send Request with the Given Specification
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Create Local User"
    Given The Request Body is the following Object
      | jsonPath                                                       | value                     |
      | $.name                                                         | "RadwareTest4"            |
      | $.password                                                     | "Radware123321"           |
      | $.requireDeviceLock                                            | true                      |
      | $.userSettings.userLocale                                      | "en_US"                   |
      | $.parameters.roleGroupPairList[0].groupName                    | "DefensePro_172.16.22.51" |
      | $.parameters.roleGroupPairList[0].roleName                     | "SEC_ADMIN"               |
      | $.networkPolicies[0].networkProtectionRuleId.deviceId          | "[ALL]"                   |
      | $.networkPolicies[0].networkProtectionRuleId.rsIDSNewRulesName | "[ALL]"                   |
      | $.roleGroupPairList[0].groupName                               | "DefensePro_172.16.22.51" |
      | $.roleGroupPairList[0].roleName                                | "SEC_ADMIN"               |

    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_27
  Scenario: Validate RBAC Dp CPU Utilization With All Policies And Restricted Device - Forbidden Access
    Given That Current Vision is Logged In With Username "RadwareTest4" and Password "Radware123321"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.50" |
      | $.selectedDevices[0].networkPolicies[0] | "SSL2"         |
      | $.selectedDevices[0].networkPolicies[1] | "BDOS"         |
      | $.selectedDevices[0].networkPolicies[2] | "bdos1"        |
      | $.selectedDevices[0].networkPolicies[3] | "pol"          |
      | $.selectedDevices[0].networkPolicies[4] | "pol1"         |
      | $.selectedDevices[0].networkPolicies[5] | "puPolicy1"    |
      | $.selectedDevices[0].networkPolicies[6] | "puPolicy2"    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is Forbidden
    And Validate That Response Body Contains
      | jsonPath  | value                                        |
      | $.status  | 403                                          |
      | $.error   | "Forbidden"                                  |
      | $.message | "Access Error: Unauthorised. Access Denied." |

  @SID_28
  Scenario: Validate RBAC Dp CPU Utilization With All Policies And Restricted Device
    Given That Current Vision is Logged In With Username "RadwareTest4" and Password "Radware123321"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.51" |
      | $.selectedDevices[0].networkPolicies[0] | "SSL2"         |
      | $.selectedDevices[0].networkPolicies[1] | "BDOS"         |
      | $.selectedDevices[0].networkPolicies[2] | "bdos1"        |
      | $.selectedDevices[0].networkPolicies[3] | "pol"          |
      | $.selectedDevices[0].networkPolicies[4] | "pol1"         |
      | $.selectedDevices[0].networkPolicies[5] | "policy1"      |
      | $.selectedDevices[0].networkPolicies[6] | "policy20"     |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate Object "$.devices" isEmpty "true"

  @SID_29
  Scenario: Create Local User SEC_ADMIN All Devices And Restricted Policies 3
    Given That Current Vision is Logged In
    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Local Users"
      | ormID | $[?(@.name=='RadwareTest5')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Delete an Item from the Server"
    And The Request Path Parameters Are
      | item | user     |
      | id   | ${ormID} |

    When Send Request with the Given Specification
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Create Local User"
    Given The Request Body is the following Object
      | jsonPath                                                       | value                     |
      | $.name                                                         | "RadwareTest5"            |
      | $.password                                                     | "Radware123321"           |
      | $.requireDeviceLock                                            | true                      |
      | $.userSettings.userLocale                                      | "en_US"                   |
      | $.parameters.roleGroupPairList[0].groupName                    | "[ALL]"                   |
      | $.parameters.roleGroupPairList[0].roleName                     | "SEC_ADMIN"               |
      | $.networkPolicies[0].networkProtectionRuleId.deviceId          | "DefensePro_172.16.22.50" |
      | $.networkPolicies[0].networkProtectionRuleId.rsIDSNewRulesName | "policy1"                 |
      | $.networkPolicies[1].networkProtectionRuleId.deviceId          | "DefensePro_172.16.22.51" |
      | $.networkPolicies[1].networkProtectionRuleId.rsIDSNewRulesName | "[ALL]"                   |
      | $.roleGroupPairList[0].groupName                               | "[ALL]"                   |
      | $.roleGroupPairList[0].roleName                                | "SEC_ADMIN"               |

    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_30
  Scenario: Validate RBAC Dp CPU Utilization With All Policies And Restricted Device
    Given That Current Vision is Logged In With Username "RadwareTest5" and Password "Radware123321"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.51" |
      | $.selectedDevices[0].networkPolicies[0] | "SSL2"         |
      | $.selectedDevices[0].networkPolicies[1] | "BDOS"         |
      | $.selectedDevices[0].networkPolicies[2] | "bdos1"        |
      | $.selectedDevices[0].networkPolicies[3] | "pol"          |
      | $.selectedDevices[0].networkPolicies[4] | "pol1"         |
      | $.selectedDevices[0].networkPolicies[5] | "policy1"      |
      | $.selectedDevices[0].networkPolicies[6] | "policy20"     |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate Object "$.devices" isEmpty "true"

  @SID_31
  Scenario: Validate RBAC Dp CPU Utilization With All Policies And Restricted Device - Forbidden Access
    Given That Current Vision is Logged In With Username "RadwareTest5" and Password "Radware123321"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.50" |
      | $.selectedDevices[0].networkPolicies[0] | "puPolicy1"    |
      | $.selectedDevices[0].networkPolicies[0] | "puPolicy2"    |

    When Send Request with the Given Specification
    Then Validate That Response Status Code Is Forbidden
    And Validate That Response Body Contains
      | jsonPath  | value                                        |
      | $.status  | 403                                          |
      | $.error   | "Forbidden"                                  |
      | $.message | "Access Error: Unauthorised. Access Denied." |
######################################################################################################################
  @SID_32
  Scenario: Authentication Mode - Local User
    Given That Current Vision is Logged In With Username "radware" and Password "radware"
    * REST Send simple body request from File "Vision/SystemManagement.json" with label "Set Authentication Mode"
      | jsonPath             | value    |
      | $.authenticationMode | "TACACS" |

  @SID_33
  Scenario: Validate RBAC Dp CPU Utilization With All Policies And Restricted Device - TACACS Forbidden Access
    Given That Current Vision is Logged In With Username "sec_mon_all_pol" and Password "radware"
    And New Request Specification from File "Vision/DpCpuUtilization" with label "Dp CPU Utilization"
    And The Request Body is the following Object
      | jsonPath                                | value          |
      | $.selectedDevices[0].deviceId           | "172.16.22.51" |
      | $.selectedDevices[0].networkPolicies[0] | "puPolicy1"    |
      | $.selectedDevices[0].networkPolicies[0] | "puPolicy2"    |

    When Send Request with the Given Specification
    Then Validate That Response Status Code Is Forbidden
    And Validate That Response Body Contains
      | jsonPath  | value                                        |
      | $.status  | 403                                          |
      | $.error   | "Forbidden"                                  |
      | $.message | "Access Error: Unauthorised. Access Denied." |
###########################################################################################################
  @SID_34
  Scenario Outline: Delete Local Users
    Given That Current Vision is Logged In
    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Local Users"
      | ormID | $[?(@.name=='<user>')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Delete an Item from the Server"
    And The Request Path Parameters Are
      | item | user     |
      | id   | ${ormID} |

    When Send Request with the Given Specification
    Examples:
      | user         |
      | RadwareTest  |
      | RadwareTest1 |
      | RadwareTest2 |
      | RadwareTest3 |
      | RadwareTest4 |
      | RadwareTest5 |

  @SID_35
  Scenario: Kill Simulate Attack
    * CLI kill all simulator attacks on current vision
    * Sleep "120"
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"

  @SID_36
  Scenario: Validate Dp Policy Utilization Without Live Attacks
    Given That Current Vision is Logged In With Username "radware" and Password "radware"
    Then Send DpPolicyUtilization Request
      | jsonPath               | value          |
      | $.timeFrame.value      | 15             |
      | $.timeFrame.unit       | "minute"       |
      | $.timeFrame.fromDate   |                |
      | $.timeFrame.toDate     |                |
      | $.timeFrame.dataPoints | 91             |
      | $.selected.deviceIP    | "172.16.22.51" |
      | $.selected.policy.name | "puPolicy2"    |
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath   | value |
      | $.metaData | null  |
      | $.data     | null  |

