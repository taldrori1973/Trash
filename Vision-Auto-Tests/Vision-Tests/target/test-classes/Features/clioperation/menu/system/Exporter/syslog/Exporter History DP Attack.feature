@TC109492
Feature: Exporter Syslog 30 days History DP Attack

  @SID_1
  Scenario: Cleanup DP attacks and syslog messages
    * REST Delete ES index "dp-*"
    Then CLI Run remote linux Command "ssh root@172.17.178.20 'rm -f /var/log/syslog*.gz'" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command "ssh root@172.17.178.20 'echo "cleared" $(date) > /var/log/syslog'" on "GENERIC_LINUX_SERVER"
    Then CLI Clear vision logs
    Then CLI Operations - Run Radware Session command "system exporter state disable"
    Then Sleep "10"

  @SID_2
  Scenario: generate two DP attacks
    * CLI simulate 1 attacks of type "rest_anomalies" on "DefensePro" 10
    * CLI simulate 1 attacks of type "rest_dos" on "DefensePro" 10 and wait 25 seconds

  @SID_3
  Scenario: Move one attack 28 days backwards and the other 32 days backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"match":{"attackIpsId":"7706-1402580209"}},"script":{"source":"ctx._source.startTime='ctx._source.startTime-2419200000L'"}}'" on "ROOT_SERVER_CLI"
    Then Sleep "1"
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"match":{"attackIpsId":"4-1402580209"}},"script":{"source":"ctx._source.startTime='ctx._source.startTime-2764800000L'"}}'" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario: Configure CLI exporter parameters
    Then CLI Operations - Run Radware Session command "system exporter syslog-host set 172.17.178.20"
    Then CLI Operations - Run Radware Session command "system exporter syslog-port set 514"
    Then CLI Operations - Run Radware Session command "system exporter event-type disable All"
    Then CLI Operations - Run Radware Session command "system exporter event-type enable DPSecurityAttack"
    Then CLI Operations - Run Radware Session command "system exporter state enable"
    Then CLI Operations - Run Radware Session command "system exporter history last"
    Then CLI Operations - Run Radware Session command "system exporter state disable"

  @SID_5
  Scenario: Validate syslog server message details
#    Once we have syslog server in SUT we can go with cat /var/log/syslog |grep -v "cleared"|awk '{print $4}'
    Then CLI Run remote linux Command "ssh root@172.17.178.20 'pwd'" on "GENERIC_LINUX_SERVER"
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog|grep -E "DPSecurityAttack.*category=\"DOSShield\""|wc -l'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog|grep -E "DPSecurityAttack.*category=\"Anomalies\""|wc -l'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
  @SID_6
  Scenario: Validate syslog server details message type
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f4|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "DPSecurityAttack"
  @SID_7
  Scenario: Validate syslog server details category type
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f5|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "[DosShieldAttackEntity"
  @SID_8
  Scenario: Validate syslog server details message device ip
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f6|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "deviceIp="172.16.22.50""
  @SID_9
  Scenario: Validate syslog server details message mpls
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f7|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "mplsRd="N/A""
  @SID_10
  Scenario: Validate syslog server details message src port
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f8|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "sourcePort="1055""
  @SID_11
  Scenario: Validate syslog server details message vlan
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f9|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "vlanTag="N/A""
  @SID_12
  Scenario: Validate syslog server details message attack id
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f10|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "attackIpsId="7706-1402580209""
  @SID_13
  Scenario: Validate syslog server details message src address
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f11|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "sourceAddress="192.85.1.8""
  @SID_14
  Scenario: Validate syslog server details message packet count
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f12|tail -1'" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "packetCount="58469""
  @SID_15
  Scenario: Validate syslog server details message dst MSISDN
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f13|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "destMsisdn="N/A""
  @SID_16
  Scenario: Validate syslog server details message src MSISDN
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f14|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "srcMsisdn="N/A""
  @SID_17
  Scenario: Validate syslog server details message physical port
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f15|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "physicalPort="1""
  @SID_18
  Scenario: Validate syslog server details message action
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f16|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "actionType="Drop""
  @SID_19
  Scenario: Validate syslog server details message protocol
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f17|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "protocol="TCP""
  @SID_20
  Scenario: Validate syslog server details message dst port
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f18|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "destPort="1028""
  @SID_21
  Scenario: Validate syslog server details message BW
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f19|tail -1'" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "packetBandwidth="56641""
  @SID_22
  Scenario: Validate syslog server details message dst address
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f20|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "destAddress="1.1.1.8""
  @SID_23
  Scenario: Validate syslog server details message name
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f21|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "name="DOSS-Anomaly-TCP-SYN-RST""
  @SID_24
  Scenario: Validate syslog server details message poilicy
   Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f22|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ruleName="BDOS""
  @SID_25
  Scenario: Validate syslog server details message radware id
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f23|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "radwareId="1239""
  @SID_26
  Scenario: Validate syslog server details message start time
    Then CLI Run linux Command "ssh root@172.17.178.20 'grep -oP "startTime=\"(\d{13})\"" /var/log/syslog|wc -l'" on "GENERIC_LINUX_SERVER" and validate result GTE "1"
  @SID_27
  Scenario: Validate syslog server details message risk
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f25|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "risk="Low""
  @SID_28
  Scenario: Validate syslog server details message end time
    Then CLI Run linux Command "ssh root@172.17.178.20 'grep -oP "endTime=\"(\d{13})\" category=\"DOSShield\"" /var/log/syslog|wc -l'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
  @SID_29
  Scenario: Validate syslog server details message category
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f27|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "category="DOSShield""
  @SID_30
  Scenario: Validate syslog server details message direction
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f28|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "direction="In""
  @SID_31
  Scenario: Validate syslog server details message status
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog |grep -v "cleared"|tr -s " "| cut --delimiter=" "  -f29|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "status="Started"]"

  @SID_32
  Scenario: CLI disable exporter
    Then CLI Operations - Run Radware Session command "system exporter state disable"
