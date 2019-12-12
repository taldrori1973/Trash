@CLI_Positive @TC106035
Feature: System SNMP tests

  @SID_1
  Scenario: System SNMP initial Status Tests
    Given CLI Operations - Run Radware Session command "net dns set primary 176.200.120.150"
    Then CLI System Snmp Initial Status
  @SID_2
  Scenario: System SNMP Status start Tests
#    Then CLI System Snmp "Start"
#    Then CLI Service iptables restart
    Given CLI Operations - Run Radware Session command "system snmp service stop"
    Given CLI Operations - Run Radware Session command "system snmp service start"
    Then CLI System Snmp Status - "Started"
    Then CLI System Snmp Status - "Stopped"
  @SID_3
  Scenario: System SNMP Community add Tests
#    Then CLI System Snmp Community Add
    Then CLI Operations - Run Radware Session command "system snmp community delete public"
    Then CLI Operations - Run Radware Session command "system snmp community delete public1"
    Then CLI Operations - Run Radware Session command "system snmp community delete public2"
    Then CLI Operations - Run Radware Session command "system snmp community add public"
    Then CLI Operations - Run Radware Session command "system snmp community add public1"
    Then CLI Operations - Run Radware Session command "system snmp community add public2"
    Then CLI Run linux Command "cat /etc/snmp/snmpd.conf |grep -E "com2sec .*public "" on "ROOT_SERVER_CLI" and validate result EQUALS "com2sec  public   default     public"
    Then CLI Run linux Command "cat /etc/snmp/snmpd.conf |grep -E "com2sec .*public "" on "ROOT_SERVER_CLI" and validate result EQUALS "com2sec  public   default     public"

    Then CLI Run linux Command "cat /etc/snmp/snmpd.conf |grep -E "com2sec .*public1"" on "ROOT_SERVER_CLI" and validate result EQUALS "com2sec  public1   default     public1"
    Then CLI Run linux Command "cat /etc/snmp/snmpd.conf |grep -E "com2sec .*public2"" on "ROOT_SERVER_CLI" and validate result EQUALS "com2sec  public2   default     public2"
    Then CLI Run linux Command "cat /etc/snmp/snmpd.conf |grep -E "com2sec6 .*public1"" on "ROOT_SERVER_CLI" and validate result EQUALS "com2sec6  public1   default     public1"
    Then CLI Run linux Command "cat /etc/snmp/snmpd.conf |grep -E "com2sec6 .*public2"" on "ROOT_SERVER_CLI" and validate result EQUALS "com2sec6  public2   default     public2"

  @SID_4
  Scenario: System SNMP Community list Tests
    Then CLI System Snmp Community List
  @SID_5
  Scenario: System SNMP Community delete Tests
#    Then CLI System Snmp Community Delete
    Then CLI Operations - Run Radware Session command "system snmp community delete public"
    Then CLI Operations - Run Radware Session command "system snmp community delete public1"
    Then CLI Operations - Run Radware Session command "system snmp community delete public2"
    Then CLI Operations - Run Radware Session command "system snmp community list"
    Then CLI Run linux Command "cat /etc/snmp/snmpd.conf |grep "com2sec" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then CLI Run remote linux Command "cat /etc/snmp/snmpd.conf" on "ROOT_SERVER_CLI"

  @SID_6
  Scenario: System SNMP help Tests
    Then CLI System Snmp Help
  @SID_7
  Scenario: System SNMP help Tests
    Then CLI Help - System Snmp Community Add
  @SID_8
  Scenario: System SNMP help delete Tests
    Then CLI Help - System Snmp Community Delete
  @SID_9
  Scenario: System SNMP help list Tests
    Then CLI Help - System Snmp Community List
  @SID_10
  Scenario: System SNMP help trap Tests
    Then CLI Help - System Snmp Trap
  @SID_11
  Scenario: System SNMP help trap target Tests
    Then CLI Help - System Snmp Trap Target
  @SID_12
  Scenario: System SNMP help Tests
    Then CLI Help - System Snmp Trap Target Add
  @SID_13
  Scenario: System SNMP trap Tests
    Then CLI System Snmp Trap Target add & list - Default port
  @SID_14
  Scenario: System SNMP trap custom port Tests
    Then CLI System Snmp Trap Target add & list - Custom port
  @SID_15
  Scenario: System SNMP trap target list Tests
    Then CLI Help - System Snmp Trap Target List
  @SID_16
  Scenario: System SNMP trap target delete Tests
    Then CLI Help - System Snmp Trap Target Delete
  @SID_17
  Scenario: System SNMP trap delete Tests
    Then CLI System Snmp Trap Target delete
  @SID_18
  Scenario: System SNMP stop
    Given CLI Operations - Run Radware Session command "system snmp service stop"
    Then CLI Operations - Run Radware Session command "system snmp service status"
    Then CLI Operations - Verify that output contains regex "snmpd is stopped.*"

#    Then CLI System Snmp "Stop"

#  @SID_19
#  Scenario: System SNMP start
#    Then CLI System Snmp "Start"
