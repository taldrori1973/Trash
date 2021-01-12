@CLI_Positive @TC106036

Feature: Snmp divided Tests


  @SID_1
  Scenario: Snmp initial status & start
    When CLI Operations - Run Radware Session command "system snmp service start"
    When CLI Operations - Run Root Session command "service snmpd status"
    Then CLI Operations - Verify that output contains regex ".*snmpd.*is running.*"
#    Then CLI Operations - Verify last output contains
#      | is running |
    When CLI Operations - Run Root Session command "iptables --list | grep snmp"
    Then CLI Operations - Verify that output contains regex "ACCEPT.*(snmp).*"
    Then CLI Operations - Verify that the output Lines number as expected 2

  @SID_2
  Scenario: System Snmp Stop
    When CLI Operations - Run Radware Session command "system snmp service stop"
    When CLI Operations - Run Root Session command "service snmpd status"
    Then CLI Operations - Verify that output contains regex ".*snmpd is stopped.*"
#    Then CLI Operations - Verify last output contains
#      | snmpd is stopped |
    When CLI Operations - Run Root Session command "iptables --list | grep snmp"
    Then CLI Operations - Verify that output contains regex "ACCEPT.*(snmp).*"
    Then CLI Operations - Verify that the output Lines number as expected 1

  @SID_3
  Scenario: System Snmp Status - Started
    When CLI Operations - Run Radware Session command "system snmp service start"
    When CLI Operations - Run Radware Session command "system snmp service status"
    Then CLI Operations - Verify that output contains regex "snmpd.*is running..."

  @SID_4
  Scenario: System Snmp Status - Stopped
    When CLI Operations - Run Radware Session command "system snmp service stop"
    When CLI Operations - Run Radware Session command "system snmp service status"
    Then CLI Operations - Verify that output contains regex "snmpd is stopped"

  @SID_5
  Scenario: System Snmp Community Add
    When CLI Operations - Run Radware Session command "system snmp community delete Cy1"
    When CLI Operations - Run Radware Session command "system snmp community add Cy1"
    Then CLI Operations - Verify that output contains regex "Community.*was added."
    When CLI Operations - Run Radware Session command "system snmp community list"
    Then CLI Operations - Verify that output contains regex ".*Cy1.*"

  @SID_6
  Scenario: System Snmp Community delete
    When CLI Operations - Run Radware Session command "system snmp community add Cy2"
    When CLI Operations - Run Radware Session command "system snmp community delete Cy2"
    Then CLI Operations - Verify that output contains regex "Community.*was deleted."
    When CLI Operations - Run Radware Session command "system snmp community list"
    Then CLI Operations - Verify that output contains regex ".*Cy2.*" negative

  @SID_7
  Scenario: System Snmp Community List
    When CLI Operations - Run Radware Session command "system snmp community add CL1"
    When CLI Operations - Run Radware Session command "system snmp community add CL2"
    When CLI Operations - Run Radware Session command "system snmp community add CL3"
    When CLI Operations - Run Radware Session command "system snmp community list"
    Then CLI Operations - Verify that output contains regex ".*CL1.*"
    Then CLI Operations - Verify that output contains regex ".*CL2.*"
    Then CLI Operations - Verify that output contains regex ".*CL3.*"

  @SID_8
  Scenario: System Snmp Help
    When CLI Operations - Run Radware Session command "system snmp ?"
    Then CLI Operations - Verify that output contains regex ".*community.*SNMP community settings."
    Then CLI Operations - Verify that output contains regex ".*service.*Configures the SNMP service."
    Then CLI Operations - Verify that output contains regex ".*trap.*SNMP trap settings."

  @SID_9
  Scenario: CLI Help - System Snmp Communaity Add
    When CLI Operations - Run Radware Session command "system snmp community add ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: system snmp community add <community>\r\n\r\nAdd an SNMP community."


  @SID_10
  Scenario: CLI Help - System Snmp Community Delete
    When CLI Operations - Run Radware Session command "system snmp community delete ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: system snmp community delete <community>\r\n\r\nDelete an SNMP community."

  @SID_11
  Scenario: CLI Help - System Snmp Community List
    When CLI Operations - Run Radware Session command "system snmp community list ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: system snmp community list.*"
    Then CLI Operations - Verify that output contains regex ".*Display the list of SNMP communities."

  @SID_12
  Scenario: CLI Help - System Snmp Trap
    When CLI Operations - Run Radware Session command "system snmp trap ?"
    Then CLI Operations - Verify that output contains regex ".*target.*SNMP trap target settings."

  @SID_13
  Scenario: CLI Help - System Snmp Trap Target
    When CLI Operations - Run Radware Session command "system snmp trap target ?"
    Then CLI Operations - Verify that output contains regex ".*add.*Add an SNMP trap target."
    Then CLI Operations - Verify that output contains regex ".*delete.*Delete an SNMP trap target."
    Then CLI Operations - Verify that output contains regex ".*list.*Display the list of SNMP trap target."

  @SID_14
  Scenario: CLI Help - System Snmp Trap Target Add
    When CLI Operations - Run Radware Session command "system snmp trap target add ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: system snmp trap target add <host> <community> \[port\].*"
    Then CLI Operations - Verify that output contains regex ".*Add an SNMP trap target.*"
    Then CLI Operations - Verify that output contains regex ".*Host: The destination host.*"
    Then CLI Operations - Verify that output contains regex ".*Community: The trap community.*"
    Then CLI Operations - Verify that output contains regex ".*Port \(optional\): The destination port.*"

  @SID_15
  Scenario: CLI Help - System Snmp Trap Target List
    When CLI Operations - Run Radware Session command "system snmp trap target list ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: system snmp trap target list.*"
    Then CLI Operations - Verify that output contains regex ".*Display the list of SNMP trap target..*"

  @SID_16
  Scenario: CLI Help - System Snmp Trap Target Delete
    When CLI Operations - Run Radware Session command "system snmp trap target delete ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: system snmp trap target delete <host> <community>.*"
    Then CLI Operations - Verify that output contains regex ".*Delete an SNMP trap target..*"

  @SID_17
  Scenario: CLI System Snmp Trap Target add & list - Default port
    When CLI Operations - Run Radware Session command "system snmp trap target delete host1 community1"
    When CLI Operations - Run Radware Session command "system snmp trap target add host1 community1"
    When CLI Operations - Run Radware Session command "system snmp trap target list"
    Then CLI Operations - Verify that output contains regex ".*host1:162.*community1.*"

  @SID_18
  Scenario: CLI System Snmp Trap Target add & list - Custom port
    When CLI Operations - Run Radware Session command "system snmp trap target delete host2 community2 120"
    When CLI Operations - Run Radware Session command "system snmp trap target add host2 community2 120"
    When CLI Operations - Run Radware Session command "system snmp trap target list"
    Then CLI Operations - Verify that output contains regex ".*host2:120.*community2.*"

  @SID_19
  Scenario: CLI System Snmp Trap Target delete
    When CLI Operations - Run Radware Session command "system snmp trap target add host3 community3"
    When CLI Operations - Run Radware Session command "system snmp trap target delete host3 community3"
    When CLI Operations - Run Radware Session command "system snmp trap target list"
    Then CLI Operations - Verify that output contains regex ".*host3:162.*community3.*" negative

  @SID_20
  Scenario: CLI Add Dns Server After Validations
    Then CLI Operations - Run Radware Session command "net dns set primary 10.221.1.47"


