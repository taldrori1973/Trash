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
  Scenario: Validate
    Then UI Click Button "Behavioral Tab" with value "QDoS"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "Quantile Status"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label           | param  | value |
      | Behavioral Tab  |  BDoS  | false |
      | Behavioral Tab  |  DNS   | false |
      | Behavioral Tab  |  QDoS  | true  |


  @SID_4
  Scenario:Navigate to DefensePro Behavioral Protections Dashboard and validate QDos chart
    Then UI "Select" Scope Polices
     | devices | type:DefensePro Behavioral Protections,index:11,policies:[p1] |
    Then Sleep "10"
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

  @SID_5
  Scenario: Add Quantile Status and validate
    And UI VRM Select Widgets
      | Quantile Status   |
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "Quantile Status-1"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "Quantile Status"


  @SID_6
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

  @SID_7
  Scenario: Validate Default Form of QDoS Tab
    Then UI Navigate to "Application Dashboard" page via homePage
    Then UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Click Button "Behavioral Tab" with value "QDoS"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "Quantile Status"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "Quantile Status-1"


  @SID_7
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

  @SID_8
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









