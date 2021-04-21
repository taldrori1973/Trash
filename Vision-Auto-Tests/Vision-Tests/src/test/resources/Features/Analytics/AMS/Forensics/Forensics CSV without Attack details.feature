@TC110199

Feature: Forensics CSV without Attack details

  @SID_1
  Scenario: Clean system data
    Given CLI Reset radware password
    * CLI kill all simulator attacks on current vision
    * CLI Clear vision logs
    * REST Delete ES index "dp-*"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"

  @SID_2
  Scenario: Run DP simulator for BDOS, DNS, ASCAN, Syn, HTTPs, burst
    And CLI simulate 1 attacks of type "rest_synflood" on "DefensePro" 10
    And CLI simulate 1 attacks of type "rest_dns" on "DefensePro" 10
    And CLI simulate 1 attacks of type "rest_ascan" on "DefensePro" 10
    And CLI simulate 1 attacks of type "rest_bdos" on "DefensePro" 10
    And CLI simulate 1 attacks of type "rest_server_crack" on "DefensePro" 10
    And CLI simulate 1 attacks of type "HTTPS" on "DefensePro" 10
    And CLI simulate 1 attacks of type "rest_burst" on "DefensePro" 10
    And CLI simulate 1 attacks of type "rest_dos" on "DefensePro" 10
    And CLI simulate 1 attacks of type "rest_traffic_filter" on "DefensePro" 10 and wait 30 seconds

  @SID_3
  Scenario: login and go to forensic tab
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "VISION SETTINGS" page via homePage
    And UI Go To Vision
    And UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"
    And UI Do Operation "select" item "Email Reporting Configuration"
    And UI Set Checkbox "Enable" To "true"
    And UI Set Text Field "SMTP User Name" To "qa_test@radware.com"
    And UI Set Text Field "From Header" To "Automation system"
    And UI Set Checkbox "Enable" To "false"
    And UI Click Button "Submit"
    And UI Go To Vision
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
    And UI Set Checkbox "Enable" To "true"
    And UI Set Text Field "SMTP Server Address" To "172.17.164.10"
    And UI Set Text Field "SMTP Port" To "25"
    And UI Click Button "Submit"
    Then UI Navigate to "AMS Forensics" page via homepage
    Given Clear email history for user "setup"


  @SID_4
  Scenario: Create Forensics forensics csv_without_details
    When UI "Create" Forensics With Name "csv_without_details"
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                              |
      | Output                | Start Time,End Time,Threat Category,Attack Name,Policy Name,Source IP Address,Destination IP Address,Destination Port,Direction,Protocol,Device IP Address,Action,Attack ID,Source Port,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag,Packet Type |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                   |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                              |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Http 403 Forbidden                                                                                                                                                                                                                                            |
      | Time Definitions.Date | Quick:Today                                                                                                                                                                                                                                                                                                   |

  @SID_5
  Scenario: Modify any dynamic values in DB
    #All units in mSec but in CSV/UI will be shown in seconds
    #Less than 1000 mSec are rounded to 0
    Then CLI Run remote linux Command "curl -XPOST "localhost:9200/dp-attack-raw-*/_update_by_query/?conflicts=proceed&pretty" -d '{"query": {"bool": {"must": [{"term": {"attackIpsId": "7839-1402580209"}}]}},"script": {"source": "ctx._source.duration ='20000'"},"size": 1}'" on "ROOT_SERVER_CLI"
    Then Sleep "5"
    Then CLI Run remote linux Command "curl -XPOST "localhost:9200/dp-attack-raw-*/_update_by_query/?conflicts=proceed&pretty" -d '{"query": {"bool": {"must": [{"term": {"attackIpsId": "7840-1402580209"}}]}},"script": {"source": "ctx._source.duration ='1000'"},"size": 1}'" on "ROOT_SERVER_CLI"
    Then Sleep "5"
    Then CLI Run remote linux Command "curl -XPOST "localhost:9200/dp-attack-raw-*/_update_by_query/?conflicts=proceed&pretty" -d '{"query": {"bool": {"must": [{"term": {"attackIpsId": "33-19"}}]}},"script": {"source": "ctx._source.duration ='1'"},"size": 1}'" on "ROOT_SERVER_CLI"
    Then Sleep "5"

  @SID_6
  Scenario: Clear FTP server logs and generate the forensics
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/csv_without_details*.zip /home/radware/ftp/csv_without_details*.csv" on "GENERIC_LINUX_SERVER"
    Then UI Click Button "My Forensics" with value "csv_without_details"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "csv_without_details"
    Then Sleep "35"

  @SID_7
  Scenario: Validate Forensics.Table
    And UI Click Button "Views.Forensic" with value "csv_without_details,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 8

  @SID_8
  Scenario: Unzip CSV file
    Then CLI Run remote linux Command "unzip -o /home/radware/ftp/csv_without_details*.zip -d /home/radware/ftp/" on "GENERIC_LINUX_SERVER"
    Then Sleep "3"

  @SID_9
  Scenario: Validate detailed csv DNS
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv |wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "9"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "DNS"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "BDOS"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "7447-1402580209"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0.0.0.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 11" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 12" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0.0.0.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 13" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 14" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Unknown"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 15" on "GENERIC_LINUX_SERVER" and validate result EQUALS "UDP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 16" on "GENERIC_LINUX_SERVER" and validate result EQUALS "450"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 18" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Regular"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0.00"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 23" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 24" on "GENERIC_LINUX_SERVER" and validate result EQUALS "High"

  @SID_10
  Scenario: Validate detailed csv BDoS
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "BehavioralDOS"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 6" on "GENERIC_LINUX_SERVER" and validate result EQUALS "network flood IPv4 TCP-SYN-ACK"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "BDOS"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 8" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Drop"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.85.1.2"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 11" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1024"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 12" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1.1.1.1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 13" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1025"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 14" on "GENERIC_LINUX_SERVER" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 15" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TCP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 16" on "GENERIC_LINUX_SERVER" and validate result EQUALS "78"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 17" on "GENERIC_LINUX_SERVER" and validate result EQUALS "20"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 18" on "GENERIC_LINUX_SERVER" and validate result EQUALS "161491"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Regular"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "157.25"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 23" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 24" on "GENERIC_LINUX_SERVER" and validate result EQUALS "High"

  @SID_11
  Scenario: Validate detailed csv anti-scan
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "AntiScanning"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 8" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Drop"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "136-1414505529"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.85.1.2"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 11" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 12" on "GENERIC_LINUX_SERVER" and validate result EQUALS "10.10.1.200"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 13" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Multiple"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 14" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Unknown"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 15" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TCP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 16" on "GENERIC_LINUX_SERVER" and validate result EQUALS "350"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 18" on "GENERIC_LINUX_SERVER" and validate result EQUALS "9867"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Regular"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "9.33"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 23" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 24" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Medium"

  @SID_12
  Scenario: Validate detailed csv traffic filters
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TrafficFilters"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "aaa4"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 8" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Drop"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "34-2206430105"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.85.1.2"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 11" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1024"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 12" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.0.0.1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 13" on "GENERIC_LINUX_SERVER" and validate result EQUALS "53"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 14" on "GENERIC_LINUX_SERVER" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 15" on "GENERIC_LINUX_SERVER" and validate result EQUALS "UDP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 16" on "GENERIC_LINUX_SERVER" and validate result EQUALS "700000"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 18" on "GENERIC_LINUX_SERVER" and validate result EQUALS "18770"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Regular"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "11.17"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 23" on "GENERIC_LINUX_SERVER" and validate result EQUALS "MNG-1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 24" on "GENERIC_LINUX_SERVER" and validate result EQUALS "High"

  @SID_13
  Scenario: Validate detailed csv Server Cracking
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ServerCracking"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "bbt-sc1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 8" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Drop"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "7840-1402580209"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.168.43.2"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 11" on "GENERIC_LINUX_SERVER" and validate result EQUALS "4445"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 12" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1.1.1.1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 13" on "GENERIC_LINUX_SERVER" and validate result EQUALS "80"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 14" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Out"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 15" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TCP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 16" on "GENERIC_LINUX_SERVER" and validate result EQUALS "400"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 17" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 18" on "GENERIC_LINUX_SERVER" and validate result EQUALS "179244"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Regular"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "82.14"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 23" on "GENERIC_LINUX_SERVER" and validate result EQUALS "4"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 24" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Medium"

  @SID_14
  Scenario: Validate detailed csv SynFlood
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "SynFlood"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 8" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Challenge"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "137-1414505529"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Multiple"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 11" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Multiple"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 12" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2000::0001"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 13" on "GENERIC_LINUX_SERVER" and validate result EQUALS "80"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 14" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Unknown"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 15" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TCP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 16" on "GENERIC_LINUX_SERVER" and validate result EQUALS "200000"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 18" on "GENERIC_LINUX_SERVER" and validate result EQUALS "223890"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Regular"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "102.49"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 23" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Multiple"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 24" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Medium"

  @SID_15
  Scenario: Validate detailed csv BehavioralDOS - 2
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "BehavioralDOS"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 6" on "GENERIC_LINUX_SERVER" and validate result EQUALS "network flood IPv4 TCP-SYN-ACK"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 8" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Drop"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0.0.0.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 11" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 12" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0.0.0.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 13" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 14" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Unknown"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 15" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TCP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 16" on "GENERIC_LINUX_SERVER" and validate result EQUALS "78"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 18" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Regular"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0.00"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 23" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 24" on "GENERIC_LINUX_SERVER" and validate result EQUALS "High"

  @SID_16
  Scenario: Validate detailed csv DOS Shield
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "DOSShield"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "BDOS"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 8" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Drop"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "7706-1402580209"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.85.1.8"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 11" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1055"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 12" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1.1.1.8"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 13" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1028"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 14" on "GENERIC_LINUX_SERVER" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 15" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TCP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 16" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1239"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 18" on "GENERIC_LINUX_SERVER" and validate result EQUALS "58469"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Regular"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "55.31"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 23" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 24" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Low"

  @SID_17
  Scenario: Delete Forensics
    Then UI Delete Forensics With Name "csv_without_details"

  @SID_18
  Scenario: Create Forensics forensics csv_without_details
    When UI "Create" Forensics With Name "csv_without_details"
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                              |
      | Output                | Start Time,End Time,Threat Category,Attack Name,Policy Name,Source IP Address,Destination IP Address,Destination Port,Direction,Protocol,Device IP Address,Action,Attack ID,Source Port,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag,Packet Type |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                   |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                              |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Http 403 Forbidden                                                                                                                                                                                                                                            |
      | Time Definitions.Date | Quick:Today                                                                                                                                                                                                                                                                                                   |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                                                                   |

  @SID_19
  Scenario: Modify any dynamic values in DB
    Then Sleep "100"
    And UI Navigate to "AMS Reports" page via homePage
    Then UI Navigate to "AMS Forensics" page via homepage
    #All units in mSec but in CSV/UI will be shown in seconds
    #Less than 1000 mSec are rounded to 0
    Then CLI Run remote linux Command "curl -XPOST "localhost:9200/dp-attack-raw-*/_update_by_query/?conflicts=proceed&pretty" -d '{"query": {"bool": {"must": [{"term": {"attackIpsId": "7839-1402580209"}}]}},"script": {"source": "ctx._source.duration ='20000'"},"size": 1}'" on "ROOT_SERVER_CLI"
    Then Sleep "5"
    Then CLI Run remote linux Command "curl -XPOST "localhost:9200/dp-attack-raw-*/_update_by_query/?conflicts=proceed&pretty" -d '{"query": {"bool": {"must": [{"term": {"attackIpsId": "7840-1402580209"}}]}},"script": {"source": "ctx._source.duration ='1000'"},"size": 1}'" on "ROOT_SERVER_CLI"
    Then Sleep "5"
    Then CLI Run remote linux Command "curl -XPOST "localhost:9200/dp-attack-raw-*/_update_by_query/?conflicts=proceed&pretty" -d '{"query": {"bool": {"must": [{"term": {"attackIpsId": "33-19"}}]}},"script": {"source": "ctx._source.duration ='1'"},"size": 1}'" on "ROOT_SERVER_CLI"
    Then Sleep "5"

  @SID_20
  Scenario: Validate Forensics.Table
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "My Forensics" with value "csv_without_details"
#    Then UI Click Button "Generate Snapshot Forensics Manually" with value "csv_without_details"
#    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "csv_without_details,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 8

  @SID_21
  Scenario: Unzip CSV file
    Then CLI Run remote linux Command "unzip -o /home/radware/ftp/csv_without_details*.zip -d /home/radware/ftp/" on "GENERIC_LINUX_SERVER"
    Then Sleep "3"

  @SID_22
  Scenario: Validate detailed csv DNS
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv |wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "9"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "DNS"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "BDOS"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "7447-1402580209"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0.0.0.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 11" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 12" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0.0.0.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 13" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 14" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Unknown"
#    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radwFare/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 15" on "GENERIC_LINUX_SERVER" and validate result EQUALS "UDP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 16" on "GENERIC_LINUX_SERVER" and validate result EQUALS "450"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 18" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Regular"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0.00"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 23" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 24" on "GENERIC_LINUX_SERVER" and validate result EQUALS "High"

  @SID_23
  Scenario: Validate detailed csv BDoS
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "BehavioralDOS"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 6" on "GENERIC_LINUX_SERVER" and validate result EQUALS "network flood IPv4 TCP-SYN-ACK"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "BDOS"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 8" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Drop"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.85.1.2"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 11" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1024"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 12" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1.1.1.1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 13" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1025"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 14" on "GENERIC_LINUX_SERVER" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 15" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TCP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 16" on "GENERIC_LINUX_SERVER" and validate result EQUALS "78"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 17" on "GENERIC_LINUX_SERVER" and validate result EQUALS "20"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 18" on "GENERIC_LINUX_SERVER" and validate result EQUALS "161491"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Regular"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "157.25"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 23" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 24" on "GENERIC_LINUX_SERVER" and validate result EQUALS "High"

  @SID_24
  Scenario: Validate detailed csv anti-scan
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "AntiScanning"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 8" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Drop"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "136-1414505529"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.85.1.2"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 11" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 12" on "GENERIC_LINUX_SERVER" and validate result EQUALS "10.10.1.200"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 13" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Multiple"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 14" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Unknown"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 15" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TCP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 16" on "GENERIC_LINUX_SERVER" and validate result EQUALS "350"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 18" on "GENERIC_LINUX_SERVER" and validate result EQUALS "9867"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Regular"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "9.33"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 23" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 24" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Medium"

  @SID_25
  Scenario: Validate detailed csv traffic filters
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TrafficFilters"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "aaa4"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 8" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Drop"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "34-2206430105"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.85.1.2"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 11" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1024"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 12" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.0.0.1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 13" on "GENERIC_LINUX_SERVER" and validate result EQUALS "53"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 14" on "GENERIC_LINUX_SERVER" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 15" on "GENERIC_LINUX_SERVER" and validate result EQUALS "UDP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 16" on "GENERIC_LINUX_SERVER" and validate result EQUALS "700000"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 18" on "GENERIC_LINUX_SERVER" and validate result EQUALS "18770"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Regular"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "11.17"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 23" on "GENERIC_LINUX_SERVER" and validate result EQUALS "MNG-1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 24" on "GENERIC_LINUX_SERVER" and validate result EQUALS "High"

  @SID_26
  Scenario: Validate detailed csv Server Cracking
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ServerCracking"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "bbt-sc1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 8" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Drop"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "7840-1402580209"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.168.43.2"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 11" on "GENERIC_LINUX_SERVER" and validate result EQUALS "4445"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 12" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1.1.1.1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 13" on "GENERIC_LINUX_SERVER" and validate result EQUALS "80"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 14" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Out"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 15" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TCP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 16" on "GENERIC_LINUX_SERVER" and validate result EQUALS "400"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 17" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 18" on "GENERIC_LINUX_SERVER" and validate result EQUALS "179244"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Regular"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "82.14"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 23" on "GENERIC_LINUX_SERVER" and validate result EQUALS "4"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 24" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Medium"

  @SID_27
  Scenario: Validate detailed csv SynFlood
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "SynFlood"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 8" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Challenge"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "137-1414505529"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Multiple"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 11" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Multiple"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 12" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2000::0001"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 13" on "GENERIC_LINUX_SERVER" and validate result EQUALS "80"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 14" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Unknown"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 15" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TCP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 16" on "GENERIC_LINUX_SERVER" and validate result EQUALS "200000"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 18" on "GENERIC_LINUX_SERVER" and validate result EQUALS "223890"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Regular"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "102.49"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 23" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Multiple"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 24" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Medium"

  @SID_28
  Scenario: Validate detailed csv BehavioralDOS - 2
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "BehavioralDOS"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 6" on "GENERIC_LINUX_SERVER" and validate result EQUALS "network flood IPv4 TCP-SYN-ACK"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 8" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Drop"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0.0.0.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 11" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 12" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0.0.0.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 13" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 14" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Unknown"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 15" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TCP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 16" on "GENERIC_LINUX_SERVER" and validate result EQUALS "78"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 18" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Regular"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0.00"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 23" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "42-1514816419" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 24" on "GENERIC_LINUX_SERVER" and validate result EQUALS "High"

  @SID_29
  Scenario: Validate detailed csv DOS Shield
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "DOSShield"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "BDOS"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 8" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Drop"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "7706-1402580209"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.85.1.8"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 11" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1055"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 12" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1.1.1.8"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 13" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1028"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 14" on "GENERIC_LINUX_SERVER" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 15" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TCP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 16" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1239"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 18" on "GENERIC_LINUX_SERVER" and validate result EQUALS "58469"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Regular"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "55.31"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 23" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 24" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Low"

  @SID_30
  Scenario: Delete Forensics
    Then UI Delete Forensics With Name "csv_without_details"

  @SID_31
  Scenario: Create Forensics forensics csv_without_details
    Given Clear email history for user "setup"
    Then Sleep "5"
    When UI "Create" Forensics With Name "csv_without_details"
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                              |
      | Output                | Start Time,End Time,Threat Category,Attack Name,Policy Name,Source IP Address,Destination IP Address,Destination Port,Direction,Protocol,Device IP Address,Action,Attack ID,Source Port,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag,Packet Type |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                   |
      | Share                 | Email:[maha],Subject:Validate Email,Body:Email Body                                                                                                                                                                                                                                                           |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Http 403 Forbidden                                                                                                                                                                                                                                            |
      | Time Definitions.Date | Quick:Today                                                                                                                                                                                                                                                                                                   |

  @SID_32
  Scenario: Clear FTP server logs and generate the forensics
    Then UI Click Button "My Forensics" with value "csv_without_details"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "csv_without_details"
    Then Sleep "35"

  @SID_33
  Scenario: Validate Forensics.Table
    And UI Click Button "Views.Forensic" with value "csv_without_details,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 8

  @SID_34
  Scenario: Validate Report Forensics received content
    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: maha@.*.local"" EQUALS "1"

  @SID_35
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_36
  Scenario: Delete Forensics
    Then UI Delete Forensics With Name "csv_without_details"

  @SID_37
  Scenario: Cleanup
    Then UI logout and close browser