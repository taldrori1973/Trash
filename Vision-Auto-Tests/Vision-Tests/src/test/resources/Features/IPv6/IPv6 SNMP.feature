@TC108880
Feature: IPv6 SNMP OS agent and trap test

  @SID_1
  Scenario: Configure SNMP service IPv6
        # Add ntp server and verify IP
#    Given REST Login with user "radware" and password "radware"
#    Given UI Login with user "radware" and password "radware"
#
#    Then UI Add "Alteon" with index 40 on "Default" site
    Then CLI Connect Radware
    Then CLI Operations - Run Radware Session command "system snmp service start"
#    Then CLI Operations - Run Radware Session command "system snmp service stop"
#    Then CLI Operations - Run Radware Session command "system snmp service start"
    Then CLI Operations - Run Radware Session command "system snmp community add com1"
    Then CLI Operations - Run Radware Session command "system snmp trap target add 200a::1001:1001:1001:1001 publicv6"
#    Then CLI Operations - Run Radware Session command "system snmp community delete com1"
#    Then CLI Operations - Run Radware Session command "system snmp trap target delete host com1"
#    Then UI Timeout in seconds "30"
#
#    Then UI validate Alerts Filter by KeyValue
#      | devicesList        |                |
#      | selectAllDevices   | true           |
#      | raisedTimeUnit     | Minute/s       |
#      | raisedTimeValue    | 5              |
#      | severityList       | Information    |
#      | modulesList        | Vision General |
#      | devicesTypeList    | Vision         |
#      | groupsList         |                |
#      | ackUnackStatusList | Unacknowledged |
#      | restoreDefaults    | true           |
#
#    Then  UI verify Existing Alert with columnName "Message" by columnValue "M_60050: User radware stopped the SNMP service."
#    Then  UI verify Existing Alert with columnName "Message" by columnValue "M_60049: User radware started the SNMP service."
#    Then  UI verify Existing Alert with columnName "Message" by columnValue "M_60054: User radware deleted an SNMP trap target."
#    Then  UI verify Existing Alert with columnName "Message" by columnValue "M_60051: User radware added an SNMP community."
#    Then  UI verify Existing Alert with columnName "Message" by columnValue "M_60053: User radware added an SNMP trap target."
#    Then  UI verify Existing Alert with columnName "Message" by columnValue "M_60054: User radware deleted an SNMP trap target."

#    Then CLI Operations - Run Radware Session command "system snmp service start"
#    Then CLI Run linux Command "system snmp service status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "is running"

  @SID_2
  Scenario: Snmpwalk CPU Utilization No Response Output Test IPv6
    When CLI run snmpwalk command "cpu.utilization.User"
    Then CLI Operations - Verify that output contains regex ".*Timeout: No Response.*" negative
    And CLI run snmpwalk command "cpu.utilization.System"
    Then CLI Operations - Verify that output contains regex ".*Timeout: No Response.*" negative
    And CLI run snmpwalk command "cpu.utilization.Total"
    Then CLI Operations - Verify that output contains regex ".*Timeout: No Response.*" negative

  @SID_3
  Scenario: Snmpwalk CPU Utilization Test IPv6
    #  1.	User cpu utilization
#    When CLI snmpwalk Validate "cpu.utilization" with "User"
    When CLI snmpwalk Validate "cpu.utilization" with "User"
    #  2.	System cpu utilization
    And CLI snmpwalk Validate "cpu.utilization" with "System"
    #  3.	Total cpu utilization
    Then CLI snmpwalk Validate "cpu.utilization" with "Total"

  @SID_4
  Scenario: Snmpwalk Vision Hostname Test IPv6
    When CLI run snmpwalk command "Vision.Hostname"
    Then CLI Operations - Verify that output contains regex ".*vision.radware.*"

  @SID_5
  Scenario: IPv6 Clear snmpd server log and Generate OS trap
    Then CLI Run remote linux Command "ssh root@172.17.178.20 'echo "cleared" $(date) > /var/log/snmptrap.log'" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Run Radware Session command "system snmp service stop"

  @SID_6
  Scenario: IPv6 Verify OS trap received at snmpd server
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log |grep -a "Community:"|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Community: TRAP2, SNMP v2c, community publicv6"
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log |grep -a "Agent Hostname:"|tail -1'" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "Agent Hostname: UDP/IPv6: [200a::172:17:164:111]"
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log |grep -a "Trap Type:"|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Trap Type: Cold Start"
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log |grep -a "Description:"|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Description: Cold Start"

  @SID_7
  Scenario: Stop SNMP service IPv6
    Then CLI Connect Radware
    Then CLI Operations - Run Radware Session command "system snmp service stop"

#  @SID_5
    # Todo Ask Ameer How to fix it for IPv6
#  Scenario: Mail Failure IPv6
#    Then CLI Verify Config Sync Failure Mail

#  @SID_6
#  Scenario: delete Devices for Alerts
#    Then UI Delete "Alteon" device with index 40 from topology tree
#    Then UI Logout
