@Ramez8889520
Feature: GEL Dashboard
  @SID_1
  Scenario: Login and navigate to EAAF dashboard
    Given UI Login with user "radware" and password "radware"
    Then REST Add "Alteon" Device To topology Tree with Name "172.17.141.17" and Management IP "172.17.141.17" into site "Default"
      | attribute | value |
    Then REST Add "Alteon" Device To topology Tree with Name "172.17.141.17" and Management IP "172.17.141.18" into site "Default"
      | attribute | value |
    When UI Open Upper Bar Item "GEL Dashboard"


  @SID_2
  Scenario: Activate License
    When UI Click Button "Activate License"
    Then UI Set Text Field "Activation ID" To "653b-fc33-8c2b-4b36-8190-0cd8-e4a1-8a16"
    Then UI Click Button "Activate button"
    Then UI Validate Element Existence By Label "Entitlement Card" if Exists "true"

  @SID_3
  Scenario: Allocate License to Alteon
    Then UI Click Button "Entitlement Card"
    Then UI Click Button "Allocate"
    Then UI Click Button "Instance Select"
    Then UI Click Button "Instance" with value "172.17.141.18_/_172.17.141.18"
    Then UI Click Button "Select Throughput"
    Then UI Click Button "Throughput" with value "25_Mbps"
    Then UI Click Button "addon"
    Then UI Click Button "Activate button"

  @SID_4
  Scenario: Allocate License to Alteon
    Then UI Click Button "Entitlement Card"
    Then UI Click Button "Allocate"
    Then UI Click Button "Instance Select"
    Then UI Click Button "Instance" with value "172.17.141.17_/_172.17.141.17"
    Then UI Click Button "Select Throughput"
    Then UI Click Button "Throughput" with value "25_Mbps"
    Then UI Click Button "addon"
    Then UI Click Button "Activate button"



  @SID_5
  Scenario: validate instance added to table
#    Then UI Click Button "Entitlement Card"
    Then UI validate Table row by keyValue with elementLabel "instances table" findBy columnName "Instance Name" findBy cellValue "172.17.141.18"
    Then UI validate Table row by keyValue with elementLabel "instances table" findBy columnName "Instance Name" findBy cellValue "172.17.141.17"
    Then UI Validate "instances table" Table rows count EQUALS to 2

  @SID_6
  Scenario: validate entitlement license card updated
    Then UI Validate Text field "Instances" EQUALS "2/500"
    Then UI Validate Text field "throughput" EQUALS "0.05 Gbps"
    Then UI Validate Text field "addons" EQUALS "2/5"


  @SID_7
  Scenario: Deallocate instance, and validate instances table is updated
    Then UI Click Button "Entitlement Card"
    Then UI click Table row by keyValue or Index with elementLabel "instances table" findBy columnName "Instance Name" findBy cellValue "172.17.141.18"
    Then UI Click Button "deallocate"
    Then UI Click Button "Activate button"
    Then UI Validate "instances table" Table rows count EQUALS to 1

  @SID_8
  Scenario: Allocate License to Alteon after Deallocation
    Then UI Click Button "Entitlement Card"
    Then UI Click Button "Allocate"
    Then UI Click Button "Instance Select"
    Then UI Click Button "Instance" with value "172.17.141.18_/_172.17.141.18"
    Then UI Click Button "Select Throughput"
    Then UI Click Button "Throughput" with value "25_Mbps"
    Then UI Click Button "addon"
    Then UI Click Button "Activate button"

  @SID_9
  Scenario: validate instance added to table
#    Then UI Click Button "Entitlement Card"
    Then UI validate Table row by keyValue with elementLabel "instances table" findBy columnName "Instance Name" findBy cellValue "172.17.141.18"
    Then UI Validate "instances table" Table rows count EQUALS to 2

  @SID_10
  Scenario: Deallocate instance, and validate instances table is updated
    Then UI Click Button "Entitlement Card"
    Then UI click Table row by keyValue or Index with elementLabel "instances table" findBy columnName "Instance Name" findBy cellValue "172.17.141.18"
    Then UI Click Button "deallocate"
    Then UI Click Button "Activate button"
    Then UI Validate "instances table" Table rows count EQUALS to 1

  @SID_11
  Scenario: Deallocate instance, and validate instances table is updated
    Then UI Click Button "Entitlement Card"
    Then UI click Table row by keyValue or Index with elementLabel "instances table" findBy columnName "Instance Name" findBy cellValue "172.17.141.17"
    Then UI Click Button "deallocate"
    Then UI Click Button "Activate button"
    Then UI Validate "instances table" Table rows count EQUALS to 0

  @SID_12
  Scenario: validate license activated in the Peer machine.
    Then CLI LLS HA validate License Activation: "QA-Secure20Gbps", on the standby machine,timeout 1000

  @SID_13
  Scenario: DeActivate License
    Then UI Click Button "more button"
    Then UI Click Button "Remove Entitlement"
    Then UI Set Text Field "Activation ID" To "653b-fc33-8c2b-4b36-8190-0cd8-e4a1-8a16"
    Then UI Click Button "Activate button"
    Then Sleep "5"
    Then UI Validate Element Existence By Label "Entitlement Card" if Exists "false"




