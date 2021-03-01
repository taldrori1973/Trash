@TC119118
Feature: EAAF ScopeSelections Reports
  @SID_1
  Scenario: Login
    Then UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Vision Install License Request "vision-reporting-module-AMS"

  @SID_2
  Scenario: Navigate to NEW REPORTS page
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_3
  Scenario: Create and validate EAAF Report All Devices
    Given UI "Create" Report With Name "EAAF Report All Devices"
      | Template | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Volume]}] ,devices:[All] |
    Then UI "Validate" Report With Name "EAAF Report All Devices"
      | Template | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Volume]}] ,devices:[All] |
    Then UI Delete Report With Name "EAAF Report All Devices"

  @SID_4
  Scenario: Create and validate EAAF Report with device index 11
    Given UI "Create" Report With Name "EAAF Report with device index 10"
      | Template | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Volume]}] ,devices:[{deviceIndex:10}] |
    Then UI "Validate" Report With Name "EAAF Report with device index 10"
      | Template | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Volume]}] ,devices:[{deviceIndex:10}] |
    Then UI Delete Report With Name "EAAF Report with device index 10"

  @SID_5
  Scenario: Create and validate EAAF Report with device index 11 and Policy 1_https
    Given UI "Create" Report With Name "EAAF Report with device index 11 and Policy 1_https"
      | Template | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Volume]}] ,devices:[{deviceIndex:11 , devicePolicies:[1_https]}]|
    Then UI "Validate" Report With Name "EAAF Report with device index 11 and Policy 1_https"
      | Template | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Volume]}] ,devices:[{deviceIndex:11 , devicePolicies:[1_https]}]|
    Then UI Delete Report With Name "EAAF Report with device index 11 and Policy 1_https"

  @SID_6
  Scenario: Create and validate EAAF Report with device index 11 and Policies BDOS and 1_https
    Given UI "Create" Report With Name "EAAF Report with device index 11 and Policies BDOS and 1_https"
      | Template | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Volume]}] ,devices:[{deviceIndex:11 , devicePolicies:[BDOS,1_https]}]|
    Then UI "Validate" Report With Name "EAAF Report with device index 11 and Policies BDOS and 1_https"
      | Template | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Volume]}] ,devices:[{deviceIndex:11 , devicePolicies:[BDOS,1_https]}]|
    Then UI Delete Report With Name "EAAF Report with device index 11 and Policies BDOS and 1_https"

  @SID_7
  Scenario: Validate Enable and Disable to change policy
    Then UI Click Button "New Report Tab"
    Then UI Set Text Field "Report Name" To "EAAF Report Disable to change policy"
    Then UI Click Button "Add Template" with value "ERT Active Attackers Feed"
    Then UI Click Button "Open Scope Selection" with value "ERT Active Attackers Feed"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Click Button "Open Scope Selection" with value "ERT Active Attackers Feed"
    Then UI Validate Element Existence By Label "EAAFScopeSelectionChange" if Exists "true" with value "172.16.22.50_disabled"
    Then UI Validate Element Existence By Label "EAAFScopeSelectionChange" if Exists "false" with value "172.16.22.50"
    Then UI Click Button "SaveEAAFScopeSelection"
    Then UI Click Button "save"

  @SID_8
  Scenario: Validate Enable and Enable to change policy
    Then UI Click Button "New Report Tab"
    Then UI Set Text Field "Report Name" To "EAAF Report Enable to change policy"
    Then UI Click Button "Add Template" with value "ERT Active Attackers Feed"
    Then UI Click Button "Open Scope Selection" with value "ERT Active Attackers Feed"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 11    |       | 1_https  |
    Then UI Click Button "Open Scope Selection" with value "ERT Active Attackers Feed"
    Then UI Validate Element Existence By Label "EAAFScopeSelectionChange" if Exists "false" with value "172.16.22.51_disabled"
    Then UI Validate Element Existence By Label "EAAFScopeSelectionChange" if Exists "true" with value "172.16.22.51"
    Then UI Click Button "EAAFScopeSelectionChange" with value "172.16.22.51"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.51,1_https"
    Then UI Click Button "SaveEAAFScopeSelection"
    Then UI Click Button "save"

  @SID_9
  Scenario: Delete reports
    Then UI Delete Report With Name "EAAF Report Disable to change policy"
    Then UI Delete Report With Name "EAAF Report Enable to change policy"

  @SID_10
  Scenario: Logout
    Then UI logout and close browser



