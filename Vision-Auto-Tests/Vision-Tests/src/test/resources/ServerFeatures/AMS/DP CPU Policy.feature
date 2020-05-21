@TC114856
Feature: DP CPU Policy Utilization

  @SID_1
  Scenario: Simulate Attacks
    * CLI Clear vision logs
    * CLI kill all simulator attacks on current vision
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

  @SID_12
  Scenario: Kill Simulate Attack
    * CLI kill all simulator attacks on current vision


