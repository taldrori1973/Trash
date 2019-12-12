@TC109057
Feature: Toolbox tests Alteon create user

  @SID_1
  Scenario: Import driver script and jar file
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.2.1.0-DD-1.00-110.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.4.0.0-DD-1.00-396.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"

  @SID_2
  Scenario: Upload Driver to vision
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.2.1.0-DD-1.00-110.jar" on "ROOT_SERVER_CLI" with timeOut 240
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.4.0.0-DD-1.00-396.jar" on "ROOT_SERVER_CLI" with timeOut 240
    Then Sleep "90"
@SID_3
Scenario: Login and sync devices to vdirect
Then UI Login with user "sys_admin" and password "radware"
  Then REST Request "POST" for "Vdirect->Sync Devices"
    | type                 | value |
    | Returned status code | 200   |

  @SID_4
  Scenario: Run ADC Create Users
Then UI ToolboxTest - Run With Params by actionName "ADC_CREATE_USERS" with actionParentGroupName "CONFIGURATION"
Then UI Click Web element with id "gwt-debug-deviceListFgId_Tab"
Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "Alteon_172.17.164.17" with dualListItems "gwt-debug-#device#alteons"
Then UI Click Web element with id "gwt-debug-parametersFieldGroup_Tab"
Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.UID_Widget" with "11"
Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.name_Widget" with "test"
Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.pswd_Widget" with "123"
Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.pswd_DuplicatePasswordField" with "123"
Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.adminPswd_Widget" with "admin"
Then UI Set Text field with id "gwt-debug-#adminscript#UserParamObj#CustomType#.adminPswd_DuplicatePasswordField" with "admin"
Then UI Set Checkbox by ID "gwt-debug-#adminscript#ApplySaveObj#CustomType#.apply_Widget-input" To "true"
Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Submit"
Then UI Wait for OTB running script output popup 60 seconds
  Then UI Click Button by id "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Close"
  Then UI Click Button by id "gwt-debug-ToolBox_ADVANCED"
  Then UI Click Button by id "gwt-debug-ToolBox_DASHBOARD"

@SID_5
  Scenario: Verify user existence in Alteon configuration
  Then REST Request "GET" for "Edit Alteon->Configuration->System->Users->Local Users"
    | type   | value          |
    | result | "UId": 11      |
    | result | "Name": "test" |

@SID_6
Scenario: Run ADC Delete Users
Then UI ToolboxTest - Run With Params by actionName "ADC_DELETE_USERS" with actionParentGroupName "CONFIGURATION"
Then UI Click Web element with id "gwt-debug-deviceListFgId_Tab"
Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "Alteon_172.17.164.17" with dualListItems "gwt-debug-#device#alteons"
Then UI Click Web element with id "gwt-debug-parametersFieldGroup_Tab"
Then UI Click Web element with id "gwt-debug-#adminscript#UIDs_NEW"
Then UI Set Text field with id "gwt-debug-#adminscript#UIDs_Widget" with "11"
Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_#adminscript#UIDs_Submit"
Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Submit"
Then UI Wait for OTB running script output popup 60 seconds negative
  Then UI Go To Vision
Then UI Verify User Existence with userId 11 "Alteon" device with index 14 negative
Then UI Logout