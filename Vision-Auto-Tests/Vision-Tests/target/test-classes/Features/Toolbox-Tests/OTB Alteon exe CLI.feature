
@TC109594
Feature: OTB Alteon execute CLI

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
  Scenario: Login and cleanup
    When UI Login with user "sys_admin" and password "radware"
    Then REST Delete ES index "alert"
    Then REST Request "POST" for "Vdirect->Sync Devices"
      | type                 | value |
      | Returned status code | 200   |

  @SID_4
  Scenario: Run ADC Apply pending OTB
    Then UI Login with user "sys_admin" and password "radware"
    Then UI ToolboxTest - Run With Params by actionName "ALTEON_EXECUTE_CMD_ON_ALL_OBJECTS" with actionParentGroupName "CONFIGURATION"
    Then UI Select "Alteon_172.17.164.17" from Vision dropdown by Id "gwt-debug-#device#adc_Widget-input"

    Then UI Click Button by id "gwt-debug-parametersFieldGroup_Tab"
    Then UI Set Text field with Class "gwt-TextArea" with "/c/slb/real 1/cur"

    Then UI Select "/c/slb/real/" from Vision dropdown by Id "gwt-debug-#adminscript#cfg_Widget-input"
    Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Submit"
    Then UI Wait for OTB running script output popup 60 seconds
    Then UI Logout


  @SID_5
  Scenario: Verify alert success message
    When Sleep "10"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"OPERATOR_TOOLBOX"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |awk -F"M_01414: " '{print $2}'|awk -F" on " '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "Operator Toolbox script Alteon_Execute_Cmd_On_All_Objects.vm was executed successfully by user sys_admin"


