@ToolBox @TC106067

Feature: Toolbox tests Look and Feel

  @SID_1
  Scenario: Login and setup
    Given UI Login with user "radware" and password "radware"
#    Then UI Go To Vision
#    Then UI Add "DefensePro" with index 11 on "Default" site
#    Then UI Add "DefensePro" with index 10 on "Default" site
#    Then UI Add "Alteon" with index 3 on "Default" site

  @SID_2
  Scenario: Resizing Panels
    Then UI ToolboxTest - Resize Group And Verify by groupName "FAVORITES" by xOffset "370" by yOffset "370"
    Then UI ToolboxTest - Restore Dashboard Default View And Verify

  @SID_3
  Scenario: Recently used category management
    Then UI ToolboxTest - Run Action from Group by ActionName "VALIDATE_ALL_APM_SERVICES" by groupName "MONITORING"
#    Then UI ToolboxTest - Run Action from Group by ActionName "VALIDATE_ALL_APM_SERVICES" by groupName "MONITORING"
#    Then UI ToolboxTest - Run Action from Group by ActionName "VALIDATE_ALL_APM_SERVICES" by groupName "MONITORING"
#    Then UI ToolboxTest - Run Action from Group by ActionName "VALIDATE_ALL_APM_SERVICES" by groupName "MONITORING"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "VALIDATE_ALL_APM_SERVICES" by groupName "MONITORING"
#    Then UI ToolboxTest - Run Action from Group by ActionName "DEFENSEPRO_RESET_BDOS_POLICY_BASELINES" by groupName "OPERATIONS"
#    Then UI ToolboxTest - Run Action from Group by ActionName "DEFENSEPRO_RESET_BDOS_POLICY_BASELINES" by groupName "OPERATIONS"
#    Then UI ToolboxTest - Run Action from Group by ActionName "DEFENSEPRO_RESET_BDOS_POLICY_BASELINES" by groupName "OPERATIONS"
#    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "DEFENSEPRO_RESET_BDOS_POLICY_BASELINES" by groupName "OPERATIONS"
#    Then UI ToolboxTest - Run Action from Group by ActionName "DEFENSEPRO_RESET_DNS_POLICY_BASELINES" by groupName "OPERATIONS"
#    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "DEFENSEPRO_RESET_DNS_POLICY_BASELINES" by groupName "RECENTLY_USED"
#    Then UI ToolboxTest - Run Action from Group by ActionName "DEFENSEPRO_FIND_UPDATE_POLICY_PENDING" by groupName "OPERATIONS"
#    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "DEFENSEPRO_FIND_UPDATE_POLICY_PENDING" by groupName "RECENTLY_USED"
#    Then UI ToolboxTest - Run Action from Group by ActionName "DEFENSEPRO_UPDATE_USERS" by groupName "CONFIGURATION"
#    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "DEFENSEPRO_UPDATE_USERS" by groupName "RECENTLY_USED"
#    Then UI ToolboxTest - Run Action from Group by ActionName "DEFENSEPRO_CREATE_USERS" by groupName "CONFIGURATION"
#    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "DEFENSEPRO_CREATE_USERS" by groupName "RECENTLY_USED"
#    Then UI ToolboxTest - Run Action from Group by ActionName "DEFENSEPRO_TUNE_BDOS_PROFILE" by groupName "CONFIGURATION"
#    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "DEFENSEPRO_TUNE_BDOS_PROFILE" by groupName "RECENTLY_USED"
#    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "DEFENSEPRO_RESET_DNS_POLICY_BASELINES" by groupName "RECENTLY_USED" negative
#    Then UI ToolboxTest - Run Action from Group by ActionName "DEFENSEPRO_6_X_SETUP_DEVICE" by groupName "CONFIGURATION"
#    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "DEFENSEPRO_6_X_SETUP_DEVICE" by groupName "RECENTLY_USED"
#    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "DEFENSEPRO_RESET_DNS_POLICY_BASELINES" by groupName "RECENTLY_USED" negative
#    Then UI ToolboxTest - Run Action from Group by ActionName "DEFENSEPRO_UPDATE_USERS" by groupName "CONFIGURATION"
#    Then UI ToolboxTest - Run Action from Group by ActionName "DEFENSEPRO_UPDATE_USERS" by groupName "CONFIGURATION"
#    Then UI ToolboxTest - Run Action from Group by ActionName "DEFENSEPRO_ADD_NETWORK_CLASSES_BY_MASK" by groupName "CONFIGURATION"
#    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "DEFENSEPRO_ADD_NETWORK_CLASSES_BY_MASK" by groupName "RECENTLY_USED"
#    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "DEFENSEPRO_CREATE_USERS" by groupName "RECENTLY_USED" negative
#    Then UI ToolboxTest - Delete All Action In Group by groupName "RECENTLY_USED"

  @SID_4
  Scenario: Drag and Drop Groups
    Then UI ToolboxTest - Drag And Drop Group And Verify by groupName "FAVORITES" by xOffset "-370" by yOffset "0"

  @SID_5
  Scenario: Resizing Panels
    Then UI ToolboxTest - Resize Group And Verify by groupName "FAVORITES" by xOffset "370" by yOffset "370"
    Then UI ToolboxTest - Restore Dashboard Default View And Verify

  @SID_6
  Scenario: Dashboard to Include Panels for Groups of Scripts
    Then UI ToolboxTest - Check that all groups are exist and displayed
    Then UI ToolboxTest - Check that all groups icons are exist and displayed

    Then UI ToolboxTest - Add Action To Group by actionName "ADC_CREATE_USERS" with groupName "CONFIGURATION"
    Then UI ToolboxTest - Delete Action from Group by actionName "ADC_CREATE_USERS" with actionParentGroupName "CONFIGURATION"
    Then UI ToolboxTest - Add Action To Group by actionName "ADC_CREATE_USERS" with groupName "MONITORING"
    Then UI ToolboxTest - Delete Action from Group by actionName "ADC_CREATE_USERS" with actionParentGroupName "MONITORING"
    Then UI ToolboxTest - Add Action To Group by actionName "ADC_CREATE_USERS" with groupName "OPERATIONS"
    Then UI ToolboxTest - Delete Action from Group by actionName "ADC_CREATE_USERS" with actionParentGroupName "OPERATIONS"
    Then UI ToolboxTest - Add Action To Group by actionName "ADC_CREATE_USERS" with groupName "HIGH_AVAILABILITY"
    Then UI ToolboxTest - Delete Action from Group by actionName "ADC_CREATE_USERS" with actionParentGroupName "HIGH_AVAILABILITY"
    Then UI ToolboxTest - Add Action To Group by actionName "ADC_CREATE_USERS" with groupName "DATA_EXPORT"
    Then UI ToolboxTest - Delete Action from Group by actionName "ADC_CREATE_USERS" with actionParentGroupName "DATA_EXPORT"
    Then UI ToolboxTest - Add Action To Group by actionName "ADC_CREATE_USERS" with groupName "EMERGENCY"
    Then UI ToolboxTest - Delete Action from Group by actionName "ADC_CREATE_USERS" with actionParentGroupName "EMERGENCY"
    Then UI ToolboxTest - Add Action To Group by actionName "ADC_CREATE_USERS" with groupName "CONFIGURATION"
    Then UI ToolboxTest - Add Action To Group by actionName "ADC_CREATE_USERS" with groupName "FAVORITES"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ADC_CREATE_USERS" by groupName "CONFIGURATION"
    Then UI ToolboxTest - Delete Action from Group by actionName "ADC_CREATE_USERS" with actionParentGroupName "FAVORITES"

    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ADC_CREATE_USERS" with groupName "MONITORING" with actionParentGroupName "CONFIGURATION"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ADC_CREATE_USERS" with groupName "OPERATIONS" with actionParentGroupName "MONITORING"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ADC_CREATE_USERS" with groupName "HIGH_AVAILABILITY" with actionParentGroupName "OPERATIONS"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ADC_CREATE_USERS" with groupName "DATA_EXPORT" with actionParentGroupName "HIGH_AVAILABILITY"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ADC_CREATE_USERS" with groupName "EMERGENCY" with actionParentGroupName "DATA_EXPORT"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ADC_CREATE_USERS" with groupName "CONFIGURATION" with actionParentGroupName "EMERGENCY"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ADC_CREATE_USERS" with groupName "FAVORITES" with actionParentGroupName "CONFIGURATION"
    Then UI ToolboxTest - Drag And Drop Action From Favorites To Group by actionName "ADC_CREATE_USERS" with groupName "HIGH_AVAILABILITY"

    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ADC_UPDATE_USERS" with groupName "DATA_EXPORT" with actionParentGroupName "CONFIGURATION"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ALTEON_FIND_UNUSED_ENTITIES" with groupName "EMERGENCY" with actionParentGroupName "OPERATIONS"
    Then UI ToolboxTest - Run Action from Group by ActionName "ALTEON_SETUP_DEVICE" by groupName "CONFIGURATION"
    Then UI ToolboxTest - Run Action from Group by ActionName "ALTEON_CHECK_CERTIFICATE_VALIDITY" by groupName "MONITORING"
    Then UI ToolboxTest - Run Action from Group by ActionName "ALTEON_FIND_APPLY_PENDING" by groupName "OPERATIONS"
    Then UI ToolboxTest - Run Action from Group by ActionName "ALTEON_HA_CONFIGURATION" by groupName "HIGH_AVAILABILITY"
    Then UI ToolboxTest - Run Action from Group by ActionName "ADC_UPDATE_USERS" by groupName "DATA_EXPORT"
    Then UI ToolboxTest - Run Action from Group by ActionName "ALTEON_FIND_UNUSED_ENTITIES" by groupName "EMERGENCY"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ADC_UPDATE_USERS" with groupName "CONFIGURATION" with actionParentGroupName "DATA_EXPORT"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ALTEON_FIND_UNUSED_ENTITIES" with groupName "OPERATIONS" with actionParentGroupName "EMERGENCY"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ALTEON_SETUP_DEVICE" by groupName "RECENTLY_USED"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ALTEON_CHECK_CERTIFICATE_VALIDITY" by groupName "RECENTLY_USED"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ALTEON_FIND_APPLY_PENDING" by groupName "RECENTLY_USED"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ALTEON_HA_CONFIGURATION" by groupName "RECENTLY_USED"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ADC_UPDATE_USERS" by groupName "RECENTLY_USED"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ALTEON_FIND_UNUSED_ENTITIES" by groupName "RECENTLY_USED"
    Then UI ToolboxTest - Drag And Drop Action From Group To Recently Used by actionName "ALTEON_EXECUTE_CMD_ON_ALL_OBJECTS" with actionParentGroupName "CONFIGURATION"

  @SID_7
  Scenario: Scrolling support
    Then UI ToolboxTest - Delete All Action In Group by groupName "FAVORITES"
    Then UI ToolboxTest - Verify That Group Is Scrollable by groupName "FAVORITES" negative
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ALTEON_CHECK_CERTIFICATE_VALIDITY" with groupName "FAVORITES" with actionParentGroupName "MONITORING"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ALTEON_CHECK_POLICY_COMPLIANCE" with groupName "FAVORITES" with actionParentGroupName "MONITORING"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ADC_UPDATE_USERS" with groupName "FAVORITES" with actionParentGroupName "CONFIGURATION"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ADC_CREATE_USERS" with groupName "FAVORITES" with actionParentGroupName "CONFIGURATION"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ALTEON_FIND_APPLY_PENDING" with groupName "FAVORITES" with actionParentGroupName "OPERATIONS"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ALTEON_FIND_SAVE_PENDING" with groupName "FAVORITES" with actionParentGroupName "OPERATIONS"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ALTEON_SETUP_DEVICE" with groupName "FAVORITES" with actionParentGroupName "CONFIGURATION"
    Then UI ToolboxTest - Verify That Group Is Scrollable by groupName "FAVORITES"

  @SID_8
  Scenario: Adding and Hiding an Existing Panel
    Then UI ToolboxTest - Show Or Hide Group by groupName "CONFIGURATION" show "false"
    Then UI ToolboxTest - Show Or Hide Group by groupName "CONFIGURATION" show "true"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "DEFENSEPRO_CREATE_USERS" by groupName "CONFIGURATION"

  @SID_9
  Scenario: Schedule Script
    Then UI ToolboxTest - Schedule Action from Group by actionName "ADC_CREATE_USERS" with actionParentGroupName "CONFIGURATION"
    Then UI Click Web element with id "gwt-debug-scheduledTasks.Schedule_Tab"
    Then UI Set Text field with id "gwt-debug-description_Widget" with "OTBTest"
    Then UI Set Text field with id "gwt-debug-name_Widget" with "OTBTest"
    Then UI Select "Daily" from Vision dropdown by Id "gwt-debug-time.frequency_Widget-input"
    Then UI set Current Time Plus Seconds "25"
    Then UI Set Text field with id "gwt-debug-scheduledTasks.Schedule.Daily.Time_Widget" with "currentTimePlus"
    Then UI Click Web element with id "gwt-debug-parametersFieldGroup_Tab"
    Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.UID_Widget" with "11"
    Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.name_Widget" with "test"
    Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.pswd_Widget" with "123"
    Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.pswd_DuplicatePasswordField" with "123"
    Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.adminPswd_Widget" with "123"
    Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.adminPswd_DuplicatePasswordField" with "123"
    Then UI Click Web element with id "gwt-debug-deviceListFgId_Tab"
    Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "Alteon_172.17.178.2" with dualListItems "gwt-debug-#device#alteons"
    Then UI Click Web element with id "gwt-debug-ConfigTab_EDIT_scheduledTasks_Submit"
    Then UI Go To Vision
    Then UI Verify Task Existence with taskName "OTBTest"
    Then UI Timeout in seconds "60"
    Then UI Lock Device "Alteon_Set_3" under "Sites And Devices"
    Then UI Verify User Existence with userId 11 "Alteon" device with index 3
    Then UI Delete task with name "OTBTest"

  @SID_10
  Scenario: Copy Script's Output to Clipboard
    Then UI ToolboxTest - Run With Params by actionName "ADC_CREATE_USERS" with actionParentGroupName "CONFIGURATION"
    Then UI Click Web element with id "gwt-debug-deviceListFgId_Tab"
    Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "Alteon_172.17.178.2" with dualListItems "gwt-debug-#device#alteons"
    Then UI Click Web element with id "gwt-debug-parametersFieldGroup_Tab"
    Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.UID_Widget" with "5"
    Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.name_Widget" with "test1"
    Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.pswd_Widget" with "123"
    Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.pswd_DuplicatePasswordField" with "123"
    Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.adminPswd_Widget" with "123"
    Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.adminPswd_DuplicatePasswordField" with "123"
    Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Submit"
    Then UI ToolboxTest - Copy Script Output And Check Validity with timeOut 60
    Then UI revert Device "REVERT" with deviceType "Alteon" with index 3

  @SID_11
  Scenario: RBAC Support
    Then UI ToolboxTest - Select Category From Advanced by groupName "CONFIGURATION"
    Then UI click Table Record with ColumnValue "ADC Create Users" by columnKey "Action Title" by elementLabelId "adminScriptTable" by deviceDriverType "VISION" findBy Type "BY_ID"
    Then UI Execute Vision table with Action ID "_EDIT" by label "Script" isTriggerPopupSearch event "true"
    Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "Device Configurator" with dualListItems "gwt-debug-adminScriptRoles"
    Then UI Click Button "Submit"
    Then UI ToolboxTest - Select Category From Advanced by groupName "operations"
    Then UI click Table Record with ColumnValue "ADC Find Apply Pending" by columnKey "Action Title" by elementLabelId "adminScriptTable" by deviceDriverType "VISION" findBy Type "BY_ID"
    Then UI Execute Vision table with Action ID "_EDIT" by label "Script" isTriggerPopupSearch event "true"
    Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "Device Operator" with dualListItems "gwt-debug-adminScriptRoles"
    Then UI Click Button "Submit"
    Then UI Add Local user with userName "user1"
      | fullName           | user user                 |
      | organisation       | org                       |
      | address            | radware                   |
      | phoneNumber        | 111111111                 |
      | permissions        | Device Configurator,[ALL] |
      | newNetworkPolicies |                           |
      | password           | 12345678                  |

    Then UI Add Local user with userName "user2"
      | fullName           | user user             |
      | organisation       | org                   |
      | address            | radware               |
      | phoneNumber        | 111111111             |
      | permissions        | Device Operator,[ALL] |
      | newNetworkPolicies |                       |
      | password           | 12345678              |

    Then UI Logout
    Then UI Login with user "user1" and password "12345678"
    Then UI Go To Vision
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ADC_CREATE_USERS" by groupName "CONFIGURATION"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ADC_CREATE_USERS" with groupName "FAVORITES" with actionParentGroupName "CONFIGURATION"
    Then UI ToolboxTest - Run Action from Group by ActionName "ADC_CREATE_USERS" by groupName "CONFIGURATION"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ADC_CREATE_USERS" by groupName "RECENTLY_USED"
    Then UI Logout
    Then UI Login with user "user2" and password "12345678"
    Then UI Go To Vision
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ALTEON_FIND_APPLY_PENDING" by groupName "OPERATIONS"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ALTEON_FIND_APPLY_PENDING" with groupName "FAVORITES" with actionParentGroupName "OPERATIONS"
    Then UI ToolboxTest - Run Action from Group by ActionName "ALTEON_FIND_APPLY_PENDING" by groupName "OPERATIONS"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ALTEON_FIND_APPLY_PENDING" by groupName "RECENTLY_USED"
    Then UI Logout
    Then UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Delete Local user with userName "user1"
    Then UI Delete Local user with userName "user2"

  @SID_12
  Scenario: Saving Category Constellation between different users
    Then UI Add Local user with userName "user1"
      | fullName           | user user           |
      | organisation       | org                 |
      | address            | radware             |
      | phoneNumber        | 111111111           |
      | permissions        | Administrator,[ALL] |
      | newNetworkPolicies |                     |
      | password           | 12345678            |

    Then UI Add Local user with userName "user2"
      | fullName           | user user           |
      | organisation       | org                 |
      | address            | radware             |
      | phoneNumber        | 111111111           |
      | permissions        | Administrator,[ALL] |
      | newNetworkPolicies |                     |
      | password           | 12345678            |

    Then UI Logout
    Then UI Login with user "user1" and password "12345678"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ADC_CREATE_USERS" with groupName "FAVORITES" with actionParentGroupName "CONFIGURATION"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ALTEON_FIND_APPLY_PENDING" with groupName "FAVORITES" with actionParentGroupName "OPERATIONS"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ALTEON_SETUP_DEVICE" with groupName "HIGH_AVAILABILITY" with actionParentGroupName "CONFIGURATION"
    Then UI ToolboxTest - Run Action from Group by ActionName "ADC_TURNOFFON_ALL_REAL_SERVERS" by groupName "OPERATIONS"
    Then UI ToolboxTest - Run Action from Group by ActionName "ALTEON_TURNOFFON_ALL_VIRTUAL_SERVERS" by groupName "OPERATIONS"
    Then UI ToolboxTest - Show Or Hide Group by groupName "CONFIGURATION" show "false"
    Then UI Logout
    Then UI Login with user "user2" and password "12345678"
    Then UI Go To Vision
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ADC_UPDATE_USERS" with groupName "FAVORITES" with actionParentGroupName "CONFIGURATION"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ALTEON_FIND_SAVE_PENDING" with groupName "FAVORITES" with actionParentGroupName "OPERATIONS"
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "DEFENSEPRO_ADD_NETWORK_CLASSES_BY_MASK" with groupName "HIGH_AVAILABILITY" with actionParentGroupName "CONFIGURATION"
    Then UI ToolboxTest - Run Action from Group by ActionName "ALTEON_CHECK_CERTIFICATE_VALIDITY" by groupName "MONITORING"
    Then UI ToolboxTest - Run Action from Group by ActionName "ALTEON_CHECK_POLICY_COMPLIANCE" by groupName "MONITORING"
    Then UI ToolboxTest - Show Or Hide Group by groupName "DATA_EXPORT" show "false"
    Then UI Logout
    Then UI Login with user "user1" and password "12345678"
    Then UI Go To Vision
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ADC_CREATE_USERS" by groupName "FAVORITES"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ALTEON_FIND_APPLY_PENDING" by groupName "FAVORITES"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ALTEON_SETUP_DEVICE" by groupName "HIGH_AVAILABILITY"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ADC_TURNOFFON_ALL_REAL_SERVERS" by groupName "RECENTLY_USED"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ALTEON_TURNOFFON_ALL_VIRTUAL_SERVERS" by groupName "RECENTLY_USED"
    Then UI ToolboxTest - Check If Group Exists "CONFIGURATION" negative
    Then UI Logout
    Then UI Login with user "user2" and password "12345678"
    Then UI Go To Vision
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ADC_UPDATE_USERS" by groupName "FAVORITES"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ALTEON_FIND_SAVE_PENDING" by groupName "FAVORITES"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "DEFENSEPRO_ADD_NETWORK_CLASSES_BY_MASK" by groupName "HIGH_AVAILABILITY"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ALTEON_CHECK_CERTIFICATE_VALIDITY" by groupName "RECENTLY_USED"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ALTEON_CHECK_POLICY_COMPLIANCE" by groupName "RECENTLY_USED"
    Then UI ToolboxTest - Check If Group Exists "DATA_EXPORT" negative
    Then UI Logout
    Then UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Delete Local user with userName "user1"
    Then UI Delete Local user with userName "user2"

  @SID_13
  Scenario: Executing the Signature Locator Script via DefensePro's Signature Screen
    Then UI Signature Find Usage with index 11 by rowNum 0 seconds
    Then UI Wait for OTB running script output popup 60 seconds

  @SID_14
  Scenario: Show previous run results
    Then UI ToolboxTest - Run With Params by actionName "ADC_CREATE_USERS" with actionParentGroupName "CONFIGURATION"
    Then UI Click Web element with id "gwt-debug-deviceListFgId_Tab"
    Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "Alteon_172.17.178.2" with dualListItems "gwt-debug-#device#alteons"
    Then UI Click Web element with id "gwt-debug-parametersFieldGroup_Tab"
    Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.UID_Widget" with "10"
    Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.name_Widget" with "test"
    Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.pswd_Widget" with "123"
    Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.pswd_DuplicatePasswordField" with "123"
    Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.adminPswd_Widget" with "admin"
    Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.adminPswd_DuplicatePasswordField" with "admin"
    Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Submit"
    Then UI ToolboxTest - Copy And Save Script Output "result1" with timeout 60
    Then UI ToolboxTest - Run With Params by actionName "ADC_TURNOFFON_ALL_REAL_SERVERS" with actionParentGroupName "OPERATIONS"
    Then UI Click Web element with id "gwt-debug-deviceListFgId_Tab"
    Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "Alteon_172.17.178.2" with dualListItems "gwt-debug-#device#alteons"
    Then UI Click Web element with id "gwt-debug-parametersFieldGroup_Tab"
    Then UI Click Web element with id "gwt-debug-#adminscript#SearchRealIp_NEW"
    Then UI Set Text field with id "gwt-debug-#adminscript#SearchRealIp_Widget" with "1.1.1.1"
    Then UI Click Button "Submit"
    Then UI Select "enable" from Vision dropdown by Id "gwt-debug-#adminscript#action_Widget-input"
    Then UI Click Button "Submit"
    Then UI ToolboxTest - Copy And Save Script Output "result2" with timeout 60
    Then UI ToolboxTest - Show Previous Result And Compare by actionName "ADC_CREATE_USERS" with groupName "CONFIGURATION" with property "result1"
    Then UI ToolboxTest - Show Previous Result And Compare by actionName "ADC_TURNOFFON_ALL_REAL_SERVERS" with groupName "OPERATIONS" with property "result2"
    Then UI revert Device "REVERT" with deviceType "Alteon" with index 3

  @SID_15
  Scenario: Drag&Drop Script between categories
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ADC_CREATE_USERS" with groupName "HIGH_AVAILABILITY" with actionParentGroupName "CONFIGURATION"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ADC_CREATE_USERS" by groupName "HIGH_AVAILABILITY"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ADC_CREATE_USERS" by groupName "CONFIGURATION" negative
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ADC_CREATE_USERS" with groupName "CONFIGURATION" with actionParentGroupName "HIGH_AVAILABILITY"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ADC_CREATE_USERS" by groupName "CONFIGURATION"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ADC_CREATE_USERS" by groupName "HIGH_AVAILABILITY" negative
    Then UI ToolboxTest - dragAndDropActionToGroup by actionName "ADC_CREATE_USERS" with groupName "FAVORITES" with actionParentGroupName "CONFIGURATION"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ADC_CREATE_USERS" by groupName "CONFIGURATION"
    Then UI ToolboxTest - Check If Action Exist Under Group by actionName "ADC_CREATE_USERS" by groupName "FAVORITES"
    Then UI Logout

  @SID_16
  Scenario: Restore Dashboard Default View
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI ToolboxTest - Show Or Hide Group by groupName "DATA_EXPORT" show "false"
    Then UI ToolboxTest - Show Or Hide Group by groupName "EMERGENCY" show "false"
    Then UI ToolboxTest - Drag And Drop Group And Verify by groupName "FAVORITES" by xOffset "450" by yOffset "0"
    Then UI ToolboxTest - Restore Dashboard Default View And Verify

  @SID_17
  Scenario: Logout and delete devices
#    Then UI Delete "Alteon" device with index 3 from topology tree
#    Then UI Delete "DefensePro" device with index 10 from topology tree
#    Then UI Delete "DefensePro" device with index 11 from topology tree
    Then UI Logout
