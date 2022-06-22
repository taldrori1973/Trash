@TC111619 @DebugTest
Feature: AW Scope Selection

  @SID_1
  Scenario: VRM - Login to VRM "Wizard" Test
    Given UI Login with user "radware" and password "radware"
#    Given REST Vision Install License Request "vision-AVA-AppWall"
#    * REST Delete ES index "aw-web-application"
#    Then REST Add device with SetId "AppWall_Set_1" into site "AW_site"
#    Then REST Delete Device By IP "172.17.164.30"
#    And Browser Refresh Page
#    And Sleep "60"
#    Then REST Add device with SetId "AppWall_Set_1" into site "AW_site"
#    And Sleep "60"
#    Given add 200 applications with prefix name "app" to appWall ip:"172.17.164.30" with timeout 300
#    Given add 200 applications with prefix name "my_app" to appWall ip:"172.17.164.30" with timeout 300
#    Given add 200 applications with prefix name "radware_app" to appWall ip:"172.17.164.30" with timeout 300
#    Given add 150 applications with prefix name "radware_application" to appWall ip:"172.17.164.30" with timeout 300
#    Given add 50 applications with prefix name "application" to appWall ip:"172.17.164.30" with timeout 300
#    And Sleep "90"
#    And Browser Refresh Page
    And UI Navigate to "AppWall Dashboard" page via homePage
    And Sleep "5"
    And UI Do Operation "Select" item "Applications"

  @SID_2
  Scenario: Select All Validation
    Given UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "true"
    Then UI validate Checkbox by label "Device Selection.All Devices Selection" with extension "" if Selected "true"
    Then UI Validate Text field "Applications" CONTAINS "1000/1000"
    And UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "false"
    Then UI validate Checkbox by label "Device Selection.All Devices Selection" with extension "" if Selected "false"

  @SID_3
  Scenario: Filter Validation
    Then UI Validate Search The Text "radware" in Search Label "Filter" if this elements exist with prefix label "Device Selection.Available Device CheckBox"
      | param    |
      | radware  |
      | radware1 |
      | radware2 |
      | radware3 |
      | radware4 |
    And UI Click Button "Scope Selection Cancel"
    And UI Do Operation "Select" item "Applications"
    Then UI Validate Search The Text "my_app-10" in Search Label "Filter" if this elements exist with prefix label "Device Selection.Available Device CheckBox"
      | param      |
      | my_app-10  |
      | my_app-101 |
      | my_app-102 |
      | my_app-100 |
      | my_app-104 |
    And UI Click Button "Scope Selection Cancel"
    And UI Do Operation "Select" item "Applications"
    Then UI Validate Count of Applications scope selection starts with "my_app-10" in AppWall dashboard equal to "11"

    And UI Click Button "Scope Selection Cancel"
    And UI Click Button "Scope Selection ConfirmCancel"

  @SID_4
  Scenario: Validate Selected Checkbox
    Given UI Click Button "Applications"
    Given UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "false"
    And UI Set Text Field BY Character "Filter" and params "" To "Vision1"
    And Sleep "5"
    And UI Set Checkbox "Device Selection.Available Device CheckBox" with extension "Vision1" To "true"
    And UI Set Text Field BY Character "Filter" and params "" To "test2"
    And Sleep "5"
    And UI Set Checkbox "Device Selection.Available Device CheckBox" with extension "test2" To "true"
    And UI Set Text Field BY Character "Filter" and params "" To "Vision1"
    And Sleep "5"
    Then UI Validate the attribute "Class" Of Label "Device Selection.Available Device CheckBox" With Params "Vision1" is "CONTAINS" to "checked"
    And UI Set Text Field BY Character "Filter" and params "" To "test2"
    And Sleep "5"
    Then UI Validate the attribute "Class" Of Label "Device Selection.Available Device CheckBox" With Params "test2" is "CONTAINS" to "checked"
    And UI Click Button "Scope Selection Cancel"
    And UI Click Button "Scope Selection ConfirmCancel"

  @SID_5
  Scenario: Select Default
    Given UI Click Button "Applications"
    And UI Select scope from dashboard and Save Filter device type "AppWall"
      | Default Web Application |

  @SID_6
  Scenario: Cleanup
    Then UI logout and close browser