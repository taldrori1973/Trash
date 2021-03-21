@TC114857
Feature: Policy CPU


  @SID_1
  Scenario: Clean system data before Traffic Bandwidth test
    * CLI kill all simulator attacks on current vision
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator PCAPs for Traffic Bandwidth
    Given CLI simulate 1000 attacks of type "dp_two_policies" on "DefensePro" 10 and wait 120 seconds



  @SID_3
  Scenario:  login
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "2"
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage


#
  @SID_4
  Scenario: validate that the overloaded devices forom
    Then UI Validate Text field "numberOverloadedDevices" EQUALS "1"
    Then UI Click Button "overloadedDevicesButton"
    Then UI Validate Text field "deviceName" with params "0" EQUALS "DefensePro_172.16.22.50"
    Then UI Validate Text field "cpuDeviceNumber" with params "0" MatchRegex "59|60|61|62"
    Then UI Click Button "deviceName" with value "0"
    Then UI Validate Text field "cpuPolicyName" with params "0" EQUALS "puPolicy1"
    Then UI Validate Text field "cpuPolicyValue" with params "0" EQUALS "59"
    Then UI Validate Text field "cpuPolicyName" with params "1" EQUALS "puPolicy2"
    Then UI Validate Text field "cpuPolicyValue" with params "1" EQUALS "0"


  @SID_5
  Scenario: enter to drill-2
    Then UI Click Button "overloadedDevicesButton"
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "puPolicy1"


  @SID_6
  Scenario: validate PolicyCPU Utilization
    Then UI Validate Line Chart data "DP Policy Traffic Utilization underAttack Widget" with Label "CPU"
      | value | min |
      | 59    | 3   |
      | 60    | 3   |
      | 61    | 3   |


  @SID_7
  Scenario: Inbound Traffic Cleanup
    Given UI logout and close browser
    * CLI kill all simulator attacks on current vision
