@TC111125
Feature: DF Scope Selection

  @SID_1
  Scenario: VRM - Login to VRM "Wizard" Test
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "DefenseFlow Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Protected Objects"

  @SID_2
  Scenario: Select All Validation
    Given UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "true"
    Then UI validate Checkbox by label "Device Selection.All Devices Selection" with extension "" if Selected "true"
    Then UI Validate Text field "Checked Number" CONTAINS "203/203"
    And UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "false"

  @SID_3
  Scenario: Filter Validation
    Then UI Validate Search The Text "PO_10" in Search Label "Filter" if this elements exist
      | label   | param  |
      | PO Name | PO_10  |
      | PO Name | PO_100 |
      | PO Name | PO_101 |
      | PO Name | PO_102 |
      | PO Name | PO_103 |
      | PO Name | PO_104 |
      | PO Name | PO_105 |
      | PO Name | PO_106 |
      | PO Name | PO_107 |
      | PO Name | PO_108 |
      | PO Name | PO_109 |
    Then UI Validate Search Numbering With text: "PO_10" And Element Label: "Prefix PO" In Search Label "Filter" If this equal to 22
    And UI Click Button "Cancel Scope Selection"

  @SID_4
  Scenario: Validate Selected Checkbox
    Given UI Click Button "Protected Objects"
    And UI Set Text Field BY Character "Filter" and params "" To "PO_1"
    And Sleep "5"
    And UI Set Checkbox "PO Name" with extension "PO_1" To "true"
    And UI Set Text Field BY Character "Filter" and params "" To "PO_2"
    And Sleep "5"
    And UI Set Checkbox "PO Name" with extension "PO_2" To "true"
    And UI Set Text Field BY Character "Filter" and params "" To "PO_1"
    And Sleep "5"
    Then UI Validate the attribute "Class" Of Label "PO Name" With Params "PO_1" is "CONTAINS" to "checked"
    And UI Set Text Field BY Character "Filter" and params "" To "PO_2"
    And Sleep "5"
    Then UI Validate the attribute "Class" Of Label "PO Name" With Params "PO_2" is "CONTAINS" to "checked"
    And UI Click Button "Cancel Scope Selection"

  @SID_5
  Scenario: Select Default POs
    Given UI Click Button "Protected Objects"
    And UI Select scope from dashboard and Save Filter device type "defenseflow"
      | PO_100 |
      | PO_200 |
      | PO_300 |

  @SID_6
  Scenario: Cleanup
    Then UI logout and close browser