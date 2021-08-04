@CLI_Positive @TC106036

Feature: Snmp divided Tests


  @SID_1
  Scenario: Snmp initial status & start
    When CLI Operations - Run Radware Session command "system snmp service start"
    When CLI Operations - Run Root Session command "systemctl status snmpd | grep Active:"
    Then CLI Operations - Verify that output contains regex ".*active.*(running).*"
#    Then CLI Operations - Verify last output contains
#      | is running |
    When CLI Operations - Run Root Session command "iptables --list | grep snmp"
    Then CLI Operations - Verify that output contains regex "ACCEPT.*(snmp).*"
    Then CLI Operations - Verify that the output Lines number as expected 2

  @SID_2
  Scenario: System Snmp Stop
    When CLI Operations - Run Radware Session command "system snmp service stop"
    When CLI Operations - Run Root Session command "systemctl status snmpd | grep Active:"
    Then CLI Operations - Verify that output contains regex ".*inactive.*(dead).*"
#    Then CLI Operations - Verify last output contains
#      | snmpd is stopped |
    When CLI Operations - Run Root Session command "iptables --list | grep snmp"
    Then CLI Operations - Verify that output contains regex "ACCEPT.*(snmp).*"
    Then CLI Operations - Verify that the output Lines number as expected 2

  @SID_3
  Scenario: System Snmp Status - Started
    When CLI Operations - Run Radware Session command "system snmp service start"
    When CLI Operations - Run Radware Session command "system snmp service status"
    Then CLI Operations - Verify that output contains regex "snmpd is active"

  @SID_4
  Scenario: System Snmp Status - Stopped
    When CLI Operations - Run Radware Session command "system snmp service stop"
    When CLI Operations - Run Radware Session command "system snmp service status"
    Then CLI Operations - Verify that output contains regex "snmpd is inactive"

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
    Then CLI System Snmp Help

  @SID_9
  Scenario: CLI Help - System Snmp Communaity Add
    Then CLI Help - System Snmp Community Add

  @SID_10
  Scenario: CLI Help - System Snmp Community Delete
    Then CLI Help - System Snmp Community Delete

  @SID_11
  Scenario: CLI Help - System Snmp Community List
    Then CLI Help - System Snmp Community List

  @SID_12
  Scenario: CLI Help - System Snmp Trap
    Then CLI Help - System Snmp Trap

  @SID_13
  Scenario: CLI Help - System Snmp Trap Target
    Then CLI Help - System Snmp Trap Target

  @SID_14
  Scenario: CLI Help - System Snmp Trap Target Add
    Then CLI Help - System Snmp Trap Target Add

  @SID_15
  Scenario: CLI Help - System Snmp Trap Target List
    Then CLI Help - System Snmp Trap Target List

  @SID_16
  Scenario: CLI Help - System Snmp Trap Target Delete
    Then CLI Help - System Snmp Trap Target Delete

  @SID_17
  Scenario: CLI System Snmp Trap Target add & list - Default port
    When CLI System Snmp Trap Target add & list - Default port

  @SID_18
  Scenario: CLI System Snmp Trap Target add & list - Custom port
    When CLI System Snmp Trap Target add & list - Custom port

  @SID_19
  Scenario: CLI System Snmp Trap Target delete
    When CLI System Snmp Trap Target delete

  @SID_20
  Scenario: CLI Add Dns Server After Validations
    Then CLI Operations - Run Radware Session command "net dns set primary 10.221.1.47"


