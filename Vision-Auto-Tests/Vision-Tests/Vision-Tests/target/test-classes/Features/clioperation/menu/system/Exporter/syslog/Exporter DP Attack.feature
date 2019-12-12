@TC109491
Feature: Exporter Syslog DP Attack

  @SID_1
  Scenario: Cleanup DP attacks and syslog messages
    * REST Delete ES index "dp-*"
    Then CLI Run remote linux Command "ssh root@172.17.178.20 'rm -f /var/log/syslog*.gz'" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command "ssh root@172.17.178.20 'echo "cleared" $(date) > /var/log/syslog'" on "GENERIC_LINUX_SERVER"
    Then CLI Clear vision logs
    Then Sleep "10"

  @SID_2
  Scenario: Configure CLI exporter parameters
    Then CLI Operations - Run Radware Session command "system exporter syslog-host set 172.17.178.20"
    Then CLI Operations - Run Radware Session command "system exporter syslog-port set 514"
    Then CLI Operations - Run Radware Session command "system exporter event-type disable All"
    Then CLI Operations - Run Radware Session command "system exporter event-type enable DPSecurityAttack"
    Then CLI Operations - Run Radware Session command "system exporter state enable"

  @SID_3
  Scenario: generate one DP attack
    * CLI simulate 1 attacks of type "rest_intrusion" on "DefensePro" 10 and wait 20 seconds

  @SID_4
  Scenario: Validate syslog server message details message type
    Then CLI Run remote linux Command "ssh root@172.17.178.20 'pwd'" on "GENERIC_LINUX_SERVER"
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f4|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "DPSecurityAttack"
  @SID_5
  Scenario: Validate syslog server message details message category
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f5|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "[IntrusionsAttackEntity"
  @SID_6
  Scenario: Validate syslog server message details message device ip
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f6|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "deviceIp="172.16.22.50""
  @SID_7
  Scenario: Validate syslog server message details message mpls
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f7|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "mplsRd="N/A""
  @SID_8
  Scenario: Validate syslog server message details message src port
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f8|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "sourcePort="1055""
  @SID_9
  Scenario: Validate syslog server message details message attack id
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f9|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "attackIpsId="7716-1402580209""
  @SID_10
  Scenario: Validate syslog server message details message vlan
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f10|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "vlanTag="N/A""
  @SID_11
  Scenario: Validate syslog server message details message src address
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f11|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "sourceAddress="192.85.1.77""
  @SID_12
  Scenario: Validate syslog server message details message packet count
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f12|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "packetCount="1""
  @SID_13
  Scenario: Validate syslog server message details message src MSISDN
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f13|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "srcMsisdn="N/A""
  @SID_14
  Scenario: Validate syslog server message details message dst MSISDN
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f14|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "destMsisdn="N/A""
  @SID_15
  Scenario: Validate syslog server message details message phisical port
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f15|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "physicalPort="1""
  @SID_16
  Scenario: Validate syslog server message details message action
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f16|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "actionType="Drop""
  @SID_17
  Scenario: Validate syslog server message details message protocol
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f17|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "protocol="TCP""
  @SID_18
  Scenario: Validate syslog server message details message dst port
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f18|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "destPort="80""
  @SID_19
  Scenario: Validate syslog server message details message BW
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f19|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "packetBandwidth="0""
  @SID_20
  Scenario: Validate syslog server message details message dst address
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f20|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "destAddress="1.1.1.9""
  @SID_21
  Scenario: Validate syslog server message details message name
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f21|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "name="tim""
  @SID_22
  Scenario: Validate syslog server message details message policy
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f22|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ruleName="BDOS""
  @SID_23
  Scenario: Validate syslog server message details message radware id
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f23|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "radwareId="300000""
  @SID_24
  Scenario: Validate syslog server message details message risk
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f24|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "risk="Low""
  @SID_25
  Scenario: Validate syslog server message details message start time
    Then CLI Run linux Command "ssh root@172.17.178.20 'grep -oP "startTime=\"(\d{13})\"" /var/log/syslog|wc -l'" on "GENERIC_LINUX_SERVER" and validate result GTE "1"
  @SID_26
  Scenario: Validate syslog server message details message end time
    Then CLI Run linux Command "ssh root@172.17.178.20 'grep -oP "endTime=\"(\d{13})\"" /var/log/syslog|wc -l'" on "GENERIC_LINUX_SERVER" and validate result GTE "1"
  @SID_27
  Scenario: Validate syslog server message details message category
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f27|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "category="Intrusions""
  @SID_28
  Scenario: Validate syslog server message details message direction
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f28|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "direction="In""
  @SID_29
  Scenario: Validate syslog server message details message status
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f29|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "status="Occurred"]"

  @SID_30
  Scenario: generate same DP attack again
    * CLI simulate 1 attacks of type "rest_intrusion" on "DefensePro" 10 and wait 15 seconds

  @SID_31
  Scenario: Validate syslog server message details
    Then CLI Run remote linux Command "ssh root@172.17.178.20 'pwd'" on "GENERIC_LINUX_SERVER"
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog|grep -E "DPSecurityAttack.*category=\"Intrusions\""|wc -l'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2"
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f12|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "packetCount="2""
    Then CLI Run remote linux Command "ssh root@172.17.178.20 'cat /var/log/syslog > /tmp/last.syslog'" on "GENERIC_LINUX_SERVER"

  @SID_32
  Scenario: CLI disable exporter
    Then CLI Operations - Run Radware Session command "system exporter state disable"
