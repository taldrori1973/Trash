@Functional @TC105657

Feature: SNMP Alerts

  @SID_1
  Scenario:  SNMP Alerts Functionality
    Given UI Login with user "radware" and password "radware"
    Then CLI Connect Radware
    Then CLI Operations - Run Radware Session command "system snmp service start"
    Then UI Go To Vision
    Then UI Add "DefensePro" with index 2 on "Default" site nowait
    Then CLI Operations - Run Radware Session command "system snmp service stop"
    Then CLI Operations - Run Radware Session command "system snmp service start"
    Then CLI Operations - Run Radware Session command "system snmp community add com1"
    Then CLI Operations - Run Radware Session command "system snmp trap target add host com1 222"
    Then CLI Operations - Run Radware Session command "system snmp community delete com1"
    Then CLI Operations - Run Radware Session command "system snmp trap target delete host com1"
    Then UI Timeout in seconds "30"

    Then UI validate Alerts Filter by KeyValue
      | devicesList        |                |
      | selectAllDevices   | true           |
      | raisedTimeUnit     | Minute/s       |
      | raisedTimeValue    | 5              |
      | severityList       | Information    |
      | modulesList        | Vision General |
      | devicesTypeList    | Vision         |
      | groupsList         |                |
      | ackUnackStatusList | Unacknowledged |
      | restoreDefaults    | true           |

    Then  UI verify Existing Alert with columnName "Message" by columnValue "M_60050: User radware stopped the SNMP service."
    Then  UI verify Existing Alert with columnName "Message" by columnValue "M_60049: User radware started the SNMP service."
    Then  UI verify Existing Alert with columnName "Message" by columnValue "M_60054: User radware deleted an SNMP trap target."
    Then  UI verify Existing Alert with columnName "Message" by columnValue "M_60051: User radware added an SNMP community."
    Then  UI verify Existing Alert with columnName "Message" by columnValue "M_60053: User radware added an SNMP trap target."
    Then  UI verify Existing Alert with columnName "Message" by columnValue "M_60054: User radware deleted an SNMP trap target."

  @SID_2
  Scenario: delete Devices for Alerts
#    When UI Login with user "radware" and password "radware"
#    Then UI Delete "DefensePro" device with index 2 from topology tree
    Then UI Logout

