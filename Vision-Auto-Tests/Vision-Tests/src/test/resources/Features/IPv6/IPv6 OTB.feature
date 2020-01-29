@TC110885
Feature: IPv6 OTB Alteon

  @SID_1
  Scenario: Import driver script and jar file
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_file where fk_dev_site_tree_el=(select row_id from site_tree_elem_abs where name='Alteon_200a::172:17:164:19');"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from dpm_virtual_services where fk_device=(select row_id from site_tree_elem_abs where name='Alteon_200a::172:17:164:19');"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='Alteon_200a::172:17:164:19';"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_setup where fk_dev_access_device_acces=(select row_id from device_access where mgt_ip="200a:0:0:0:172:17:164:19");"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_access where mgt_ip="200a:0:0:0:172:17:164:19";"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='Alteons-IPv6';"" on "ROOT_SERVER_CLI"

    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.2.1.0-DD-1.00-110.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.4.0.0-DD-1.00-396.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"

  @SID_2
  Scenario: Upload Driver to vision
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.2.1.0-DD-1.00-110.jar" on "ROOT_SERVER_CLI" with timeOut 240
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.4.0.0-DD-1.00-396.jar" on "ROOT_SERVER_CLI" with timeOut 240
    Then Sleep "90"

  @SID_3
  Scenario: Add new Site to tree
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Add new Site "Alteons-IPv6" under Parent "Default"

  @SID_4
  Scenario: Add new Alteon to site
    Then UI Add "Alteon" with index 40 on "Alteons-IPv6" site

  @SID_5
  Scenario: Lock device and do some change
    When REST Login with user "sys_admin" and password "radware"
    When REST Lock Action on "Alteon" 40
    Then REST Request "PUT" for "Edit Alteon->Setup->System->SNMPIpv6"
      | type | value                   |
      | body | sysContact=someone_else |
    Then REST Unlock Action on "Alteon" 40
    Then CLI Run remote linux Command "service ip6tables stop" on "ROOT_SERVER_CLI" with timeOut 240
    Then REST Delete ES index "alert*"
    Then CLI Run remote linux Command "service ip6tables start" on "ROOT_SERVER_CLI" with timeOut 240
    Then REST Request "POST" for "Vdirect->Sync Devices"
      | type                 | value |
      | Returned status code | 200   |

  @SID_6
  Scenario: Check Vdirect logs
    Then CLI Check if logs contains
      | logType | expression                     | isExpected   |
      | VDIRECT | fatal                          | NOT_EXPECTED |
      | VDIRECT | error                          | NOT_EXPECTED |
      | VDIRECT | Could not update server report | IGNORE       |

  @SID_7
  Scenario: Run ADC Save pending OTB
    Then UI Login with user "sys_admin" and password "radware"
    Then UI ToolboxTest - Run With Params by actionName "ALTEON_FIND_SAVE_PENDING" with actionParentGroupName "OPERATIONS"
    Then UI Click Web element with id "gwt-debug-deviceListFgId_Tab"
    Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "Alteon_200a::172:17:164:19" with dualListItems "gwt-debug-#device#alteons"
    Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Submit"
    Then UI Wait for OTB running script output popup 60 seconds
    Then UI Logout

  @SID_8
  Scenario: Verify alert success message
    When Sleep "10"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"OPERATOR_TOOLBOX"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |awk -F"M_01414: " '{print $2}'|awk -F" on " '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "Operator Toolbox script Alteon_Find_Save_Pending.vm was executed successfully by user sys_admin"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"OPERATOR_TOOLBOX"}}]}},"from":0,"size":10}' localhost:9200/alert/_search|awk -F"output" '{print $2}'|awk -F"require_device_lock" '{print $1}'" on "ROOT_SERVER_CLI" and validate result CONTAINS "The following devices are pending save:<br><br/>200a:0:0:0:172:17:164:19"

  @SID_17
  Scenario: Login and sync devices to vdirect
    Then UI Login with user "radware" and password "radware"
    Then REST Request "POST" for "Vdirect->Sync Devices"
      | type                 | value |
      | Returned status code | 200   |

  @SID_9
  Scenario: Run ADC Create Users
    Then UI ToolboxTest - Run With Params by actionName "ADC_CREATE_USERS" with actionParentGroupName "CONFIGURATION"
    Then UI Click Web element with id "gwt-debug-deviceListFgId_Tab"
    Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "Alteon_200a::172:17:164:19" with dualListItems "gwt-debug-#device#alteons"
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

  @SID_10
  Scenario: Verify user existence in Alteon configuration
    Then REST Request "GET" for "Edit Alteon->Configuration->System->Users->Local UsersIpv6"
      | type   | value          |
      | result | "UId": 11      |
      | result | "Name": "test" |

  @SID_11
  Scenario: Check Vdirect logs
    Then CLI Check if logs contains
      | logType | expression                     | isExpected   |
      | VDIRECT | fatal                          | NOT_EXPECTED |
      | VDIRECT | error                          | NOT_EXPECTED |
      | VDIRECT | Could not update server report | IGNORE       |


  @SID_12
  Scenario: Run ADC Delete Users
    Then UI ToolboxTest - Run With Params by actionName "ADC_DELETE_USERS" with actionParentGroupName "CONFIGURATION"
    Then UI Click Web element with id "gwt-debug-deviceListFgId_Tab"
    Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "Alteon_200a::172:17:164:19" with dualListItems "gwt-debug-#device#alteons"
    Then UI Click Web element with id "gwt-debug-parametersFieldGroup_Tab"
    Then UI Click Web element with id "gwt-debug-#adminscript#UIDs_NEW"
    Then UI Set Text field with id "gwt-debug-#adminscript#UIDs_Widget" with "11"
    Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_#adminscript#UIDs_Submit"
    Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Submit"
    Then UI Wait for OTB running script output popup 60 seconds negative
    Then UI Go To Vision
    Then UI Verify User Existence with userId 11 "Alteon" device with index 40 negative
#    Then UI Logout

  @SID_13
  Scenario: Delete Alteon devices from tree
    Then UI open Topology Tree view "SitesAndClusters" site
    Then UI Delete "Alteon" device with index 40 from topology tree

  @SID_14
  Scenario: Delete Alteon site
    Then UI Delete TopologyTree Element "Alteons-IPv6" by topologyTree Tab "SitesAndClusters"

  @SID_15
  Scenario: Cleanup
    Then UI logout and close browser

  @SID_16
  Scenario: Check Vdirect logs
    Then CLI Check if logs contains
      | logType | expression                     | isExpected   |
      | VDIRECT | error                          | NOT_EXPECTED |
      | VDIRECT | fatal                          | NOT_EXPECTED |
      | VDIRECT | Could not update server report | IGNORE       |
