@TC124883
Feature: DefensePro Behavioral QDoS General Tests

  @SID_1
  Scenario: Run DP simulator - QDos_Ahlam4
    Given CLI simulate 1000 attacks of type "QDos_Ahlam4" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds
    Then Sleep "5"
    * CLI kill all simulator attacks on current vision

  @SID_2
  Scenario: login and Verify default Tab BDoS
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label           | param  | value |
      | Behavioral Tab  |  BDoS  | true  |
      | Behavioral Tab  |  DNS   | false |
      | Behavioral Tab  |  QDoS  | false |
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "Quantile Status"

  @SID_3
  Scenario: Validate Tab Switch
    Then UI Click Button "Behavioral Tab" with value "QDoS"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "Quantile Status"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label           | param  | value |
      | Behavioral Tab  |  BDoS  | false |
      | Behavioral Tab  |  DNS   | false |
      | Behavioral Tab  |  QDoS  | true  |

  @SID_4
  Scenario:Navigate to DefensePro Behavioral Protections Dashboard And Select Scope
    Then UI "Select" Scope Polices
     | devices | type:DefensePro Behavioral Protections,index:11,policies:[p1] |
    Then Sleep "10"

  @SID_5
  Scenario: Validate Scope Selection Stability
    Then UI Click Button "Behavioral Tab" with value "BDoS"
    Then Sleep "2"
    And UI Do Operation "Select" item "Device Selection"
    Then UI Validate the attribute of "Class" are "EQUAL" to
      | label                                      | param          | value   |
      | DefensePro Analytics_RationScopeSelection  |  172.16.22.50  |         |
      | DefensePro Analytics_RationScopeSelection  |  172.16.22.51  | checked |
      | DefensePro Analytics_RationScopeSelection  |  172.16.22.55  |         |
    Then UI Click Button "Device Selection.Cancel"
    Then UI Click Button "Behavioral Tab" with value "QDoS"
    And UI Do Operation "Select" item "Device Selection"
    Then UI Validate the attribute of "Class" are "EQUAL" to
      | label                                      | param          | value   |
      | DefensePro Analytics_RationScopeSelection  |  172.16.22.50  |         |
      | DefensePro Analytics_RationScopeSelection  |  172.16.22.51  | checked |
      | DefensePro Analytics_RationScopeSelection  |  172.16.22.55  |         |
    Then UI Click Button "Device Selection.Cancel"

  @SID_6
  Scenario: Validate QDos chart
     Then UI Validate Virtical StackBar data with widget "qdosChart"
     | label | value | legendName   |
     | 0     | 25852 | Under Attack |
     | 1     | 2430  | Peacetime    |
     | 5     | 2070  | Peacetime    |
     | 10    | 2178  | Peacetime    |
     | 20    | 2001  | Peacetime    |
     | 30    | 2124  | Peacetime    |
     | 39    | 25768 | Under Attack |
     | 40    | 2211  | Peacetime    |
     | 45    | 2417  | Peacetime    |

  @SID_7
  Scenario: Add Quantile Status and validate
    And UI VRM Select Widgets
      | Quantile Status   |
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "Quantile Status-1"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "Quantile Status"

  @SID_8
  Scenario: Remove QDoS Widgets AND Validate existance
    Then UI Click Button "Widget remove" with value "Quantile Status"
    Then UI Click Button "Widget remove" with value "Quantile Status-1"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "Quantile Status"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "Quantile Status-1"
    Then UI Click Button "Behavioral Tab" with value "BDoS"
    Then Sleep "2"
    Then UI Click Button "Behavioral Tab" with value "QDoS"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "Quantile Status"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "Quantile Status-1"

  @SID_9
  Scenario: Validate Default Form of QDoS Tab
    Then UI Navigate to "Application Dashboard" page via homePage
    Then UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Click Button "Behavioral Tab" with value "QDoS"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "Quantile Status"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "Quantile Status-1"

  @SID_10
  Scenario: CLEAR ALL And Validate Default Form
    And UI VRM Select Widgets
      | Quantile Status  |
    And UI VRM Select Widgets
      | Quantile Status  |
    And UI VRM Select Widgets
      | Quantile Status  |
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "Quantile Status-4"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "Quantile Status-3"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "Quantile Status-2"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "Quantile Status"
    When UI VRM Clear All Widgets
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "Quantile Status-4"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "Quantile Status-3"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "Quantile Status-2"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "Quantile Status"
    Then UI Navigate to "Application Dashboard" page via homePage
    Then UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Click Button "Behavioral Tab" with value "QDoS"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "Quantile Status"

  @SID_11
  Scenario: Validate Chart Settings
    And UI Click Button "Chart Settings" with value "Quantile Status"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI validate Checkbox by label "DPPolicycheck" if Selected "false"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,19_Characters_19_Ch"
    Then UI Click Button "Widget Settings Save"
    And UI Click Button "Chart Settings" with value "Quantile Status"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI validate Checkbox by label "DPPolicycheck" if Selected "true"
    Then UI Click Button "Widget Settings Cancel"

  @SID_12
  Scenario: Validate Chart Number Reset
    Then UI logout and close browser
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Click Button "Behavioral Tab" with value "QDoS"
    When UI VRM Clear All Widgets
    And UI VRM Select Widgets
      | Quantile Status  |
    And UI VRM Select Widgets
      | Quantile Status  |
    And UI VRM Select Widgets
      | Quantile Status  |
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "Quantile Status-3"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "Quantile Status-2"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "Quantile Status-1"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "Quantile Status"

  @SID_13
  Scenario: Validate No Widgets Selected Message
    When UI VRM Clear All Widgets
    Then UI Validate Element Existence By Label "Repo button" if Exists "true"
    Then UI Click Button "Repo button"
    Then UI Click Button "Repository Widget" with value "Quantile_Status"
    Then UI Click Button "Widget Selection.Add Selected Widgets"
    Then UI Click Button "Widget Selection"
    Then UI Validate Element Existence By Label "Repo button" if Exists "false"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "Quantile Status-4"

  @SID_14
  Scenario: kill all simulator attacks and logout
    Then UI logout and close browser
    Then CLI kill all simulator attacks on current vision







