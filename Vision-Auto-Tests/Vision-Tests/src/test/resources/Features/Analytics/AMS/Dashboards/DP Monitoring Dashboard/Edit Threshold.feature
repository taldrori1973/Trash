@run
@TC110221
Feature: AMS actionable edit Threshold
  @SID_1
  Scenario: Clean system data before "Protection Policies" test
    Given CLI Reset radware password
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    Given REST Login with user "sys_admin" and password "radware"
    Then REST Request "POST" for "Vdirect->Sync Devices"
      | type                 | value |
      | Returned status code | 200   |
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    * CLI Clear vision logs

  @SID_2
   Scenario: validate Edit Threshold script exist in vision
     Then CLI Operations - Run Root Session command "find /opt/radware/ConfigurationTemplatesRepository/actionable/ -name "adjust_profile_v2.vm"" timeout 60
     Then CLI Operations - Verify that output contains regex ".*adjust_profile.*"
    Then CLI Operations - Run Root Session command "find /opt/radware/storage/vdirect/database/templates/ -name "adjust_profile_v2.vm"" timeout 60
    Then CLI Operations - Verify that output contains regex ".*adjust_profile.*"
  @SID_3
  Scenario: run attacks
    Given CLI simulate 1000 attacks of type "baselines_pol_1_dynamic" on "DefensePro" 11 and wait 10 seconds

  @SID_4
  Scenario: login
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given UI Login with user "sys_admin" and password "radware"


  @SID_5
  Scenario:  Navigate to DP dashboard
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @SID_6
  Scenario: Entering to the under attack policy 3nd drill
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Behavioral DoS"
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0

  @SID_7
  Scenario: Edit Bandwidth Fill, BDOS
    When UI Click Button "Edit Bandwidth"
#    Then fill device: "DefensePro_172.16.22.51", Edit Treshold
    Then UI Set Text Field "BDOS Profile Name" To "AAA" enter Key false
    Then UI Set Text Field BY Character "Inbound Trafic" To "1234"
    Then UI Set Text Field BY Character "Outbound Trafic" To "123"

    Then UI Click Button "Run Edit Bandwidth"
    Then UI Click Button "Dismiss"

  @SID_8
  Scenario: Validate BDOS Bandwidth , BDOS
    #must wait until Profile table updated
    Then Sleep "10"
    Then Rest Validate BDOS Table DP: ip "172.16.22.51" Profile:"AAA" ,Inbound:"1234", Outbound:"123"

  @SID_9
  Scenario: Edit Bandwidth Fill
    When UI Click Button "Edit Bandwidth"
#    Then fill device: "DefensePro_172.16.22.51", Edit Treshold
    Then UI Set Text Field "BDOS Profile Name" To "AAA" enter Key false
    Then UI Set Text Field BY Character "Inbound Trafic" To "999"
    Then UI Set Text Field BY Character "Outbound Trafic" To "1000"
    Then UI Click Button "Run Edit Bandwidth"
    Then UI Click Button "Dismiss"

  @SID_10
  Scenario: Validate BDOS Bandwidth
    #must wait until Profile table updated
    Then Sleep "10"
    Then Rest Validate BDOS Table DP: ip "172.16.22.51" Profile:"AAA" ,Inbound:"999", Outbound:"1000"

  @SID_11
  Scenario: Validate Vdirect logs
    * CLI Check if logs contains
      | logType | expression                                         | isExpected |
      | VDIRECT | Updating BDoS profile AAA                          | EXPECTED   |
      | VDIRECT | Configuration template adjust_profile_v2.vm merged | EXPECTED   |

  @SID_12
  Scenario:  Navigate to DP Monitoring dashboard
    Then UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @SID_13
  Scenario: Enter to the under attack policy 3nd drill
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DNS Flood"
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0

  @SID_14
  Scenario: Edit Bandwidth Fill, DNS
    When UI Click Button "Edit Bandwidth"
    Then UI Set Text Field "DNS Profile Name" To "DNFp" enter Key false
    Then UI Set Text Field BY Character "Expected DNS Query Rate" To "1234"
    Then UI Set Text Field BY Character "Max Allowed QPS" To "5678"
    Then UI Click Button "Run Edit Bandwidth"
    Then UI Click Button "Dismiss"

  @SID_15
  Scenario: Validate DNS Bandwidth
    #must wait until Profile table updated
    Then Sleep "5"
    Then Rest Validate DNS Table DP: ip "172.16.22.51" Profile:"DNFp" ,QueryRate:"1234", MaxQPS:"5678"

  @SID_16
  Scenario: Validate Vdirect log
    * CLI Check if logs contains
      | logType | expression                                         | isExpected |
      | VDIRECT | Updating DNS profile DNFp                          | EXPECTED   |
      | VDIRECT | Configuration template adjust_profile_v2.vm merged | EXPECTED   |

  @SID_17
  Scenario: Edit DNS Bandwidth Fill
    When UI Click Button "Edit Bandwidth"
    Then UI Set Text Field "DNS Profile Name" To "DNFp" enter Key false
    Then UI Set Text Field BY Character "Expected DNS Query Rate" To "100000"
    Then UI Set Text Field BY Character "Max Allowed QPS" To "110000"
    Then UI Click Button "Run Edit Bandwidth"
    Then UI Click Button "Dismiss"

  @SID_18
  Scenario: Validate Bandwidth DNS
    #must wait until Profile table updated
    Then Sleep "5"
    Then Rest Validate DNS Table DP: ip "172.16.22.51" Profile:"DNFp" ,QueryRate:"100000", MaxQPS:"110000"

  @SID_19
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
