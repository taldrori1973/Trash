@TC109512
Feature: OTB Alteon Check Certificate validity

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
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Delete ES index "alert"
    Then REST Request "POST" for "Vdirect->Sync Devices"
      | type                 | value |
      | Returned status code | 200   |

  @SID_4
  Scenario: Run cert validity check script
    Then UI ToolboxTest - Run With Params by actionName "ALTEON_CHECK_CERTIFICATE_VALIDITY" with actionParentGroupName "MONITORING"
    Then UI Click Web element with id "gwt-debug-deviceListFgId_Tab"
    Then UI ToolboxTest - Move Toolbox DualList Items to Side "LEFT" with dualListItems "Alteon_172.17.164.18" with dualListItems "gwt-debug-#device#alteons"
    Then UI Click Button by id "gwt-debug-parametersFieldGroup_Tab"
    Then UI Set Text field with id "gwt-debug-#adminscript#timeWindow_Widget" with "90"
    Then UI Click Web element with id "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Submit"
    Then UI Wait for OTB running script output popup 60 seconds

  @SID_5
  Scenario: Verify alert success message
    Then Sleep "15"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"OPERATOR_TOOLBOX"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |awk -F"M_01414: " '{print $2}'|awk -F" on " '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "Operator Toolbox script Alteon_Check_Certificate_Validity.vm was executed successfully by user sys_admin"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"OPERATOR_TOOLBOX"}}]}},"from":0,"size":10}' localhost:9200/alert/_search|awk -F"output" '{print $2}'|awk -F"require_device_lock" '{print $1}'" on "ROOT_SERVER_CLI" and validate result CONTAINS "The following certificates expire within 90 days"

