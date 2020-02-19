@TC109508
Feature: OTB Alteon Enable Disable Real

  @SID_1
  Scenario: Login and cleanup
    Then UI Login with user "sys_admin" and password "radware"
    Then REST Delete ES index "alert"
    Then REST Request "POST" for "Vdirect->Sync Devices"
      | type                 | value |
      | Returned status code | 200   |

  @SID_2
  Scenario: Create operational enabled real server
    Then REST Unlock Action on "Alteon" 14
    Then REST Lock Action on "Alteon" 14
#    Then REST Request "POST" for "Edit Alteon->Real Server->Create"
    Then REST Generic API Request "POST" for "Edit Alteon->Real Server->Create" Expected result "ok"
#      | type                 | value   |
#      | IpAddr               | 2.2.2.2 |
#      | body                 | State3  |
#      | Index                | 10      |
#      | LLBType              | 0       |
#      | SecType              | 1       |
#      | IpVer                | 1       |
#      | MaxConns             | 0       |
#      | Weight               | 1       |
#      | TimeOut              | 10      |
#      | PingInterval         | 0       |
#      | FailRetry            | 0       |
#      | SuccRetry            | 0       |
#      | ExcludeStr           | 2       |
#      | Cookie               | 2       |
#      | Submac               | 2       |
#      | Returned status code | 200     |

  @SID_3
  Scenario: Run ADC Disable Real server operation
    Then UI ToolboxTest - Run With Params by actionName "ADC_TURNOFFON_ALL_REAL_SERVERS" with actionParentGroupName "OPERATIONS"
    Then UI Click Web element with id "gwt-debug-deviceListFgId_Tab"
    Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "Alteon_172.17.164.17" with dualListItems "gwt-debug-#device#alteons"
#    Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "LinkProof NG_172.17.154.200" with dualListItems "gwt-debug-#device#alteons"
    Then UI Click Button by id "gwt-debug-parametersFieldGroup_Tab"
    Then UI Click Button by id "gwt-debug-#adminscript#SearchRealIp_NEW"
    Then UI Set Text field with id "gwt-debug-#adminscript#SearchRealIp_Widget" with "2.2.2.2"
    Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_#adminscript#SearchRealIp_Submit"
    Then UI Select "disable" from Vision dropdown by Id "gwt-debug-#adminscript#action_Widget-input"
    Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Submit"
    Then UI Wait for OTB running script output popup 60 seconds
    Then UI Click Button by id "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Close"

  @SID_4
  Scenario: Apply on Alteon
#    Then REST Login with user "sys_admin" and password "radware"
    Then REST Lock Action on "Alteon" 14
    Then REST Apply Action on "Alteon" 14

  @SID_5
  Scenario: Verify real server state Enabled in Alteon configuration
    Then REST Request "GET" for "Edit Alteon->Monitoring->Servers Resources->Real Server State"
      | type                 | value       |
      | result               | "Status": 2 |
      | Returned status code | 200         |

  @SID_6
  Scenario: Verify alert success message
    When Sleep "10"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"OPERATOR_TOOLBOX"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |awk -F"M_01414: " '{print $2}'|awk -F" on " '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "Operator Toolbox script ADC_TurnOffOn_All_Real_Servers.vm was executed successfully by user sys_admin"

  @SID_7
  Scenario: Cleanup alerts
    Then REST Delete ES index "alert"

  @SID_8
  Scenario: Run ADC Enable Real server operation
    Then UI ToolboxTest - Run With Params by actionName "ADC_TURNOFFON_ALL_REAL_SERVERS" with actionParentGroupName "OPERATIONS"
    Then UI Click Web element with id "gwt-debug-deviceListFgId_Tab"
    Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "Alteon_172.17.164.17" with dualListItems "gwt-debug-#device#alteons"
#    Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "LinkProof NG_172.17.154.200" with dualListItems "gwt-debug-#device#alteons"
    Then UI Click Button by id "gwt-debug-parametersFieldGroup_Tab"
    Then UI Click Button by id "gwt-debug-#adminscript#SearchRealIp_NEW"
    Then UI Set Text field with id "gwt-debug-#adminscript#SearchRealIp_Widget" with "2.2.2.2"
    Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_#adminscript#SearchRealIp_Submit"
    Then UI Select "enable" from Vision dropdown by Id "gwt-debug-#adminscript#action_Widget-input"
    Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Submit"
    Then UI Wait for OTB running script output popup 60 seconds
    Then UI Click Button by id "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Close"
    Then UI Click Button by id "gwt-debug-ToolBox_ADVANCED"
    Then UI Click Button by id "gwt-debug-ToolBox_DASHBOARD"


  @SID_9
  Scenario: Apply on Alteon
#    Then REST Login with user "sys_admin" and password "radware"
    Then REST Lock Action on "Alteon" 14
#    Then REST Apply Action on "Alteon" 14

  @SID_10
  Scenario: Verify real server state Disabled in Alteon configuration
    Then REST Request "GET" for "Edit Alteon->Monitoring->Servers Resources->Real Server State"
      | type                 | value       |
      | result               | "Status": 2 |
      | Returned status code | 200         |

  @SID_11
  Scenario: Verify alert success message
    When Sleep "10"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"OPERATOR_TOOLBOX"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |awk -F"M_01414: " '{print $2}'|awk -F" on " '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "Operator Toolbox script ADC_TurnOffOn_All_Real_Servers.vm was executed successfully by user sys_admin"

  @SID_12
  Scenario: Delete the real server and unlock device
#    Then REST Unlock Action on "Alteon" 14
#    Then REST Lock Action on "Alteon" 14
    Then REST Request "DELETE" for "Edit Alteon->Real Server"
      | type                 | value |
      | Returned status code | 200   |
    Then REST Apply Action on "Alteon" 14
    Then REST Unlock Action on "Alteon" 14

  @SID_13
  Scenario: cleanup
    Then UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |