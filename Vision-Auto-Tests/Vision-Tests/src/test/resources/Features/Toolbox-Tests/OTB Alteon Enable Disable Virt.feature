@TC109511
Feature: OTB Alteon Enable Disable Virtual Service

  @SID_1
  Scenario: Login and cleanup
    Then UI Login with user "sys_admin" and password "radware"
    Then REST Delete ES index "alert"
    Then REST Request "POST" for "Vdirect->Sync Devices"
      | type                 | value |
      | Returned status code | 200   |
    Then REST Lock Action on "Alteon" 14
    Then REST RevertApply Action on "Alteon" 14

  @SID_2
  Scenario: Create disabled Virtual server
    Then REST Unlock Action on "Alteon" 14
    Then REST Lock Action on "Alteon" 14
    Then REST Request "POST" for "Edit Alteon->Virtual Server->Create"
      | type                 | value       |
      | Returned status code | 200         |
      | VirtServerIpAddress  | 22.22.22.22 |
      | VirtServerState      | 3           |

  @SID_3
  Scenario: Move Alteon_TurnOffOn_All_Virtual_Servers to EMERGENCY category
#    When CLI Run remote linux Command "mysql -prad123 vision_ng -e "update admin_script set category='6' where name='Alteon_TurnOffOn_All_Virtual_Servers.vm';"" on "ROOT_SERVER_CLI"
    When MYSQL UPDATE "admin_script" Table in "VISION_NG" Schema SET "category" Column Value as 6 WHERE "name='Alteon_TurnOffOn_All_Virtual_Servers.vm'"

  @SID_4
  Scenario: Run ADC Enable virtual server
    Then UI ToolboxTest - Run With Params by actionName "ALTEON_TURNOFFON_ALL_VIRTUAL_SERVERS" with actionParentGroupName "EMERGENCY"
    Then UI Click Web element with id "gwt-debug-deviceListFgId_Tab"
    Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "Alteon_172.17.164.17" with dualListItems "gwt-debug-#device#alteons"
    Then UI Click Button by id "gwt-debug-parametersFieldGroup_Tab"
    Then UI Select "Enable" from Vision dropdown by Id "gwt-debug-#adminscript#state_Widget-input"
    Then UI Click Button by id "gwt-debug-#adminscript#skip_ips_NEW"
    Then UI Set Text field with id "gwt-debug-#adminscript#skip_ips_Widget" with "22.22.22.23"
    Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_#adminscript#skip_ips_Submit"
    Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Submit"
    Then UI Wait for OTB running script output popup 60 seconds
    Then UI Click Button by id "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Close"
    Then UI Click Button by id "gwt-debug-ToolBox_ADVANCED"
    Then UI Click Button by id "gwt-debug-ToolBox_DASHBOARD"

  @SID_5
  Scenario: Apply on Alteon
    Then REST Lock Action on "Alteon" 14
    Then REST Apply Action on "Alteon" 14

  @SID_6
  Scenario: Verify virt state Enabled in Alteon configuration
    Then REST Request "GET" for "Edit Alteon->Monitoring->Servers Resources->Virtual Server State"
      | result | VirtServerState: 2 |

  @SID_7
  Scenario: Verify alert success message
    When Sleep "10"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"OPERATOR_TOOLBOX"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |awk -F"M_01414: " '{print $2}'|awk -F" on " '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "Operator Toolbox script Alteon_TurnOffOn_All_Virtual_Servers.vm was executed successfully by user sys_admin"

  @SID_8
  Scenario: Cleanup alerts
    Then REST Delete ES index "alert"

  @SID_9
  Scenario: Run ADC Disable virtual server
    Then UI ToolboxTest - Run With Params by actionName "ALTEON_TURNOFFON_ALL_VIRTUAL_SERVERS" with actionParentGroupName "EMERGENCY"
    Then UI Click Web element with id "gwt-debug-deviceListFgId_Tab"
    Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "Alteon_172.17.164.17" with dualListItems "gwt-debug-#device#alteons"
    Then UI Click Button by id "gwt-debug-parametersFieldGroup_Tab"
    Then UI Select "Disable" from Vision dropdown by Id "gwt-debug-#adminscript#state_Widget-input"
    Then UI Click Button by id "gwt-debug-#adminscript#skip_ips_NEW"
    Then UI Set Text field with id "gwt-debug-#adminscript#skip_ips_Widget" with "22.22.22.33"
    Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_#adminscript#skip_ips_Submit"
    Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Submit"
    Then UI Wait for OTB running script output popup 60 seconds

  @SID_10
  Scenario: Apply on Alteon
#    Then REST Login with user "sys_admin" and password "radware"
    Then REST Lock Action on "Alteon" 14
    Then REST Apply Action on "Alteon" 14

  @SID_11
  Scenario: Verify virt state Disabled in Alteon configuration
    Then REST Request "GET" for "Edit Alteon->Monitoring->Servers Resources->Virtual Server State"
      | result | VirtServerState: 3 |

  @SID_12
  Scenario: Verify alert success message
    When Sleep "10"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"OPERATOR_TOOLBOX"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |awk -F"M_01414: " '{print $2}'|awk -F" on " '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "Operator Toolbox script Alteon_TurnOffOn_All_Virtual_Servers.vm was executed successfully by user sys_admin"

  @SID_13
  Scenario: Delete the Virtual server and unlock device
#    Then REST Unlock Action on "Alteon" 14
#    Then REST Lock Action on "Alteon" 14
    Then REST Request "DELETE" for "Edit Alteon->Virtual Server"
      | type | value |
    Then REST Apply Action on "Alteon" 14
    Then REST Unlock Action on "Alteon" 14

  @SID_14
  Scenario: cleanup
    Then UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |