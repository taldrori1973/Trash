@TC110199
Feature: Forensics CSV without Attack details

  @SID_1
  Scenario: Clean system data
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
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
    And UI Navigate to "AMS Forensics" page via homePage

  @SID_4
  Scenario: Create Forensics Report csv_without_details
    When UI "Create" Forensics With Name "csv_without_details"
      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                               |
      | Output | Action,Attack ID,Start Time,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Threat Category,Radware ID,Device IP Address,Attack Name,End Time,Duration,Packets,Mbits,Physical Port,,Risk, Policy Name |
      | Format | Select: CSV                                                                                                                                                                                                                                    |

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
  Scenario: Clear FTP server logs and generate the report
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/csv_without_details*.zip /home/radware/ftp/csv_without_details*.csv" on "GENERIC_LINUX_SERVER"
    Then UI Generate and Validate Forensics With Name "csv_without_details" with Timeout of 300 Seconds
    Then Sleep "5"

  @SID_7
  Scenario: Unzip CSV file
    Then CLI Run remote linux Command "unzip -o /home/radware/ftp/csv_without_details*.zip -d /home/radware/ftp/" on "GENERIC_LINUX_SERVER"
    Then Sleep "3"

  @SID_8
  Scenario: Validate detailed csv DNS
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "DNS"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "BDOS"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 8" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Forward"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "7447-1402580209"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0.0.0.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 11" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 12" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0.0.0.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 13" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 14" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Unknown"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 15" on "GENERIC_LINUX_SERVER" and validate result EQUALS "UDP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 16" on "GENERIC_LINUX_SERVER" and validate result EQUALS "450"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 18" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0.00"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 21" on "GENERIC_LINUX_SERVER" and validate result EQUALS "High"

  @SID_9
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
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "157.25"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 21" on "GENERIC_LINUX_SERVER" and validate result EQUALS "High"

  @SID_10
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
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "9.33"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "TCP Scan (vertical)" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 21" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Medium"

  @SID_11
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
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "11.17"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "MNG-1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "f1" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 21" on "GENERIC_LINUX_SERVER" and validate result EQUALS "High"

  @SID_12
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
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "82.14"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "4"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "Brute Force Web" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 21" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Medium"

  @SID_13
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
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "102.49"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Multiple"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "SYN Flood HTTP" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 21" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Medium"

  @SID_14
  Scenario: Validate detailed csv HTTPS
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Https"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 6" on "GENERIC_LINUX_SERVER" and validate result EQUALS "HTTPS Flood Protection"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "pol1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 8" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Drop"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0.0.0.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 11" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 12" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0.0.0.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 13" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 14" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Unknown"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 15" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TCP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 16" on "GENERIC_LINUX_SERVER" and validate result EQUALS "700"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 17" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 18" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0.00"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 21" on "GENERIC_LINUX_SERVER" and validate result EQUALS "High"

  @SID_15
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
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 19" on "GENERIC_LINUX_SERVER" and validate result EQUALS "55.31"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 20" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_without_details_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 21" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Low"

  @SID_16
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
