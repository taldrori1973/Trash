@TC109704
Feature: DefensePro find Update Policy pending

  @SID_1
  Scenario: Cleanup
    Then REST Delete ES index "alert"

  @SID_2
  Scenario: Sync devices with vdirect
    Then REST Request "POST" for "Vdirect->Sync Devices"
      | type                 | value |
      | Returned status code | 200   |

  @SID_3
  Scenario: Run DP find update policy pending
    Then UI Login with user "sys_admin" and password "radware"
    Then UI ToolboxTest - Run With Params by actionName "DEFENSEPRO_FIND_UPDATE_POLICY_PENDING" with actionParentGroupName "OPERATIONS"
    Then UI Click Web element with id "gwt-debug-deviceListFgId_Tab"
    Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "DefensePro_172.16.22.51" with dualListItems "gwt-debug-#device#defensePros"
    Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Submit"
    Then UI Wait for OTB running script output popup 60 seconds
    Then UI logout and close browser

  @SID_4
  Scenario: Verify alert success message
    When Sleep "10"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"OPERATOR_TOOLBOX"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |awk -F"M_01414: " '{print $2}'|awk -F" on " '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "Operator Toolbox script DefensePro_Find_Update_Policy_Pending.vm was executed successfully by user sys_admin"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"OPERATOR_TOOLBOX"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |awk -F"devices" '{print $2}'|awk -F"  " '{print $1}'" on "ROOT_SERVER_CLI" and validate result CONTAINS "pending update policies"
