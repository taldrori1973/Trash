@TC108880 @Debug
Feature: IPv6 SNMP OS agent and trap test

  @SID_1
  Scenario: Configure SNMP service IPv6
    Then CLI Connect Radware
    Then CLI Operations - Run Radware Session command "system snmp service start"
    Then CLI Operations - Run Radware Session command "system snmp community add com1"
    Then CLI Operations - Run Radware Session command "system snmp trap target add 200a::1001:1001:1001:1001 publicv6"

  @SID_2
  Scenario: IPv6 Clear snmpd server log and Generate OS Stop trap
    Then CLI Run remote linux Command "ssh root@172.17.178.20 'echo "cleared" $(date) > /var/log/snmptrap.log'" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Run Radware Session command "system snmp service stop"

  @SID_3
  Scenario: IPv6 Verify OS Stop trap received at snmpd server
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log |grep -a "Community:"|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Community: TRAP2, SNMP v2c, community publicv6"
#TODO kvision find a proper way to read the ip address than hardcode it
  #    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log |grep -a "Agent Hostname:"|tail -1'" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "Agent Hostname: UDP/IPv6: [200a::172:17:164:113]"
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log |grep -a "Trap Type:"|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Trap Type: Cold Start"
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log |grep -a "Description:"|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Description: Cold Start"

  @SID_4
  Scenario: IPv6 Clear snmpd server log and Generate OS Start trap
    Then CLI Run remote linux Command "ssh root@172.17.178.20 'echo "cleared" $(date) > /var/log/snmptrap.log'" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Run Radware Session command "system snmp service start"

  @SID_5
  Scenario: IPv6 Verify OS Start trap received at snmpd server
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log |grep -a "Community:"|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Community: TRAP2, SNMP v2c, community publicv6"
    #TODO kvision find a proper way to read the ip address than hardcode it
#    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log |grep -a "Agent Hostname:"|tail -1'" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "Agent Hostname: UDP/IPv6: [200a::172:17:164:113]"
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log |grep -a "Trap Type:"|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Trap Type: Cold Start"
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log |grep -a "Description:"|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Description: Cold Start"


  @SID_6
  Scenario: Stop SNMP service and delete target IPv6
    Then CLI Connect Radware
    Then CLI Operations - Run Radware Session command "system snmp service stop"
    Then CLI Operations - Run Radware Session command "system snmp trap target delete 200a::1001:1001:1001:1001 publicv6"
    Then CLI Operations - Run Radware Session command "system snmp community delete com1"


