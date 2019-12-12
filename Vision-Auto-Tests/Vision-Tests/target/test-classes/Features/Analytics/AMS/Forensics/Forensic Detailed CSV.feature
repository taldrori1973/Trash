@TC110199
Feature: Forensics Detailed CSV

  @SID_1
  Scenario: Clean system data
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    * CLI kill all simulator attacks on current vision
    * CLI Clear vision logs
    * REST Delete ES index "dp-*"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
#    * REST Delete ES index "forensics-definition"
#    * REST Delete ES index "dpforensics-1"

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
    And CLI simulate 1 attacks of type "rest_traffic_filter" on "DefensePro" 10 and wait 85 seconds

  @SID_3
  Scenario: login and go to forensic tab
    Given UI Login with user "sys_admin" and password "radware"
    And UI Open Upper Bar Item "AMS"
    And UI Open "Forensics" Tab

  @SID_4
  Scenario: Create Forensics Report csv_detailed
    When UI "Create" Forensics With Name "csv_detailed"
      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                               |
      | Output | Action,Attack ID,Start Time,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Threat Category,Radware ID,Device IP Address,Attack Name,End Time,Duration,Packets,Mbits,Physical Port,,Risk, Policy Name |
      | Format | Select: CSV                                                                                                                                                                                                                                    |

  @SID_5
  Scenario: Modify any dynamic values in DB
    Then CLI Run remote linux Command "curl -XPOST "localhost:9200/dp-attack-raw-*/_update_by_query/?conflicts=proceed&pretty" -d '{"query": {"bool": {"must": [{"term": {"attackIpsId": "137-1414505529"}}]}},"script": {"source": "ctx._source.status=params.status","params": {"status": "Terminated"}},"size": 1}'" on "ROOT_SERVER_CLI"
    Then Sleep "5"
    Then CLI Run remote linux Command "curl -XPOST "localhost:9200/dp-attack-raw-*/_update_by_query/?conflicts=proceed&refresh" -d '{"query":{"bool": {"must": [{"term":{"attackIpsId":"137-1414505529"}}]}},"script": {"source": "ctx._source.duration ='20000'"},"size":1}'" on "ROOT_SERVER_CLI"
    Then Sleep "5"
    Then CLI Run remote linux Command "curl -XPOST "localhost:9200/dp-attack-raw-*/_update_by_query/?conflicts=proceed&refresh" -d '{"query":{"bool": {"must": [{"term":{"attackIpsId":"137-1414505529"}}]}},"script": {"source": "ctx._source.averageAttackPacketRatePps ='55972'"},"size":1}'" on "ROOT_SERVER_CLI"


  @SID_6
  Scenario: Clear FTP server logs and generate the report
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/csv_detailed*.zip /home/radware/ftp/csv_detailed*.csv" on "GENERIC_LINUX_SERVER"
    Then UI Generate and Validate Forensics With Name "csv_detailed" with Timeout of 300 Seconds
    Then Sleep "5"

  @SID_7
  Scenario: Unzip CSV file
    Then CLI Run remote linux Command "unzip -o /home/radware/ftp/csv_detailed*.zip -d /home/radware/ftp/" on "GENERIC_LINUX_SERVER"
    Then Sleep "3"

  @SID_8
  Scenario: validate detailed csv DNS
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)-1|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "S.No"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+1|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "State,Blocking"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+2|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Mitigation Action,SignatureChallenge"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+3|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TTL,255"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+4|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "L4Checksum,10117"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+5|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "IP ID Number,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+6|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Packet Size,124"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+7|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Destination IP,1.1.1.3"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+8|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Destination Port,53"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+9|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "DNS ID,1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+10|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "DNS Query Count,1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+11|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "DNS An Query Count,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+12|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Flags,256"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+13|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Footprint,"[ OR  checksum=10117,]""
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+14|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Protection,A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+15|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Direction,In"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+16|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "A In,576,3350,720,3378"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+17|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "A Out,0,0,0,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+18|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "AAAA In,114,0,143,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+19|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "AAAA Out,0,0,0,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+20|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "MX Out,0,0,0,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+21|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "MXIn,342,0,427,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+22|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "NAPTR In,15,0,19,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+23|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "NAPTR Out,0,0,0,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+24|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Other In,15,0,19,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+25|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Other Out,0,0,0,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+26|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "PRT In,342,0,427,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+27|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "PRT Out,0,0,0,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+28|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "SOA In,15,0,19,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+29|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "SOA Out,0,0,0,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+30|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "SRV In,15,0,19,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+31|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "SRV Out,0,0,0,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+32|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Text In,60,0,76,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+33|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Text Out,0,0,0,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+34|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Type,NORMAL,ANOMALY,NORMAL,ANOMALY"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+35|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "counter_protection_mode,4,4,4,4"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+36|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "SAMPLE DETAILS:"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+37|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Source IP, Source Port, Destination IP, Destination Port, Physical Port, VLAN Tag, MPLS RD, Protocol"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+38|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.85.1.2,1024,1.1.1.3,53,101,N/A,N/A,UDP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+39|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.85.1.2,1024,1.1.1.3,53,101,N/A,N/A,UDP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DNS flood IPv4 DNS-A" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+40|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "*********************************************************************"

  @SID_9
  Scenario: validate detailed csv BDoS
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+1|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "State,Blocking"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+2|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "L4Checksum,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+3|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TCP Sequence Number,123456"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+4|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "IP ID Number,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+5|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "DNS ID,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+6|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "DNS Query,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+7|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "DNS Query Count,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+8|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Source IP,192.85.1.2"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+9|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Source Port,1024"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+10|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Destination IP,1.1.1.1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+11|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Destination Port,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+12|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Fragmentation Offset,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+13|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Fragmentation Flag,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+14|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Flow Label,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+15|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ToS,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+16|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Packet Size,124"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+17|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ICMP Message Type,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+18|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TTL,255"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+19|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Is Burst Active,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+20|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Current Burst Number,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+21|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Average Burst Duration,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+22|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Average Time between Bursts,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+23|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Average Burst Rate,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+24|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Max Average Burst Rate,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+25|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Footprint,"[ OR  sequence-number=123456,]""
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+26|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Protection,TCP SYN ACK"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+27|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Direction,In"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+28|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Fin+Ack In,96,0,202,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+29|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Fin+Ack Out,96,0,202,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+30|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Frag+Ack In,204,0,24,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+31|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Frag+Ack Out,96,0,24,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+32|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Psh+Ack In,783,0,245,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+33|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Psh+Ack Out,783,0,245,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+34|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Reset Out,193,0,403,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+35|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ResetIn,193,0,403,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+36|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Syn In,96,0,189,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+37|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Syn Out,96,0,189,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+38|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Syn+Ack In,96,3351,195,3379"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+39|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Syn+Ack Out,96,0,195,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+40|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Type,NORMAL,ANOMALY,NORMAL,ANOMALY"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+41|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "counter_protection_mode,4,4,4,4"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+42|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "SAMPLE DETAILS:"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+43|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Source IP, Source Port, Destination IP, Destination Port, Physical Port, VLAN Tag, MPLS RD, Protocol"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+44|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.85.1.2,1024,1.1.1.1,1025,101,N/A,N/A,TCP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+45|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.85.1.2,1024,1.1.1.1,1025,101,N/A,N/A,TCP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "7839-1402580209" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+46|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "*********************************************************************"

  @SID_10
  Scenario: validate detailed csv anti-scan
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+1|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Time Between Events,0.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+2|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Number Of Scanned Events,9957"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+3|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Blocking Duration,10"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+4|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Action,Drop"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+5|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Action Reason,Configuration"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+6|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Event Type,SCANNING_ATTACK_DETAILS_REPORT"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+7|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Footprint,"[ OR  destination-ip=10.10.1.200,] AND [ AND  ttl=255, AND  packet-size=124, AND  sequence-number=123456,]""
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+8|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "SAMPLE DETAILS:"

    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+9|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Destination IP, Destination Port, Flag, ICMP Message Type"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+10|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "10.10.1.200,22261,SYN,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+11|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "10.10.1.200,35915,SYN,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+12|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "10.10.1.200,57620,SYN,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+13|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "10.10.1.200,61578,SYN,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+14|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "10.10.1.200,30789,SYN,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+15|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "10.10.1.200,6931,SYN,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+16|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "10.10.1.200,43704,SYN,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+17|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "10.10.1.200,54620,SYN,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+18|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "10.10.1.200,27310,SYN,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+19|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "10.10.1.200,46423,SYN,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "AntiScanning" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+20|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "*********************************************************************"

  @SID_11
  Scenario: validate detailed csv traffic filters
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "TrafficFilters" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+1|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "SAMPLE DETAILS:"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "TrafficFilters" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+2|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Source IP, Source Port, Destination IP, Destination Port, Physical Port, VLAN Tag, MPLS RD, Protocol"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "TrafficFilters" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+3|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.85.1.2,1024,192.0.0.1,53,28,N/A,N/A,UDP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "TrafficFilters" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+4|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.85.1.2,1024,192.0.0.1,53,28,N/A,N/A,UDP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "TrafficFilters" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+5|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "*********************************************************************"

  @SID_12
  Scenario: validate detailed csv Server Cracking
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "ServerCracking" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+1|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Attacker IP,192.168.43.2"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "ServerCracking" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+2|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Attacker IPs Id,N/A"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "ServerCracking" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+3|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "Start Time"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "ServerCracking" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+4|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Protected Host,1.1.1.1"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "ServerCracking" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+5|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Protected Port,80"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "ServerCracking" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+6|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Attacker URL,"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "ServerCracking" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+7|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Action,drop"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "ServerCracking" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+8|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Number Of Events,34"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "ServerCracking" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+9|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Blocking Duration,17"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "ServerCracking" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+10|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Time Between Events,1.0E-4"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "ServerCracking" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+11|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Protocol,http"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "ServerCracking" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+12|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Message,"GET /index.html HTTP/1.1","GET /index.html HTTP/1.1","GET /index.html HTTP/1.1","GET /index.html HTTP/1.1","GET /index.html HTTP/1.1","GET /index.html HTTP/1.1","GET /index.html HTTP/1.1","GET /index.html HTTP/1.1","GET /index.html HTTP/1.1","GET /index.html HTTP/1.1""
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "ServerCracking" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+13|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "*********************************************************************"

  @SID_13
  Scenario: validate detailed csv SynFlood
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "SynFlood" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+1|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Attacked Host,2000::0001"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "SynFlood" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+2|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Attacked Port,80"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "SynFlood" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+3|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Attack Duration,20000"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "SynFlood" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+4|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Average Attack Packet Rate,55972"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "SynFlood" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+5|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Activation Threshold,2500"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "SynFlood" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+6|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TCP Challenge,TransparentProxy"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "SynFlood" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+7|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "HTTP Challenge,CloudAuthentication"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "SynFlood" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+8|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Attack Volume,208889"
#    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "SynFlood" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+9|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Attack Rate,8355"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "SynFlood" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+9|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "HTTP Auth Utilization,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "SynFlood" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+10|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TCP Auth Utilization,0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "SynFlood" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+11|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Average Attack Rate,10444"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "SynFlood" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+12|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "*********************************************************************"

  @SID_14
  Scenario: validate detailed csv HTTPS
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+1|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Protected Server,test"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+2|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Detection Engine,By Rate of HTTPS Requests"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+3|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Authentication Method,302 Redirect"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+4|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Total Suspect Sources,2559994656"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+5|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Total Challenged,12"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+6|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Total Packets Dropped,11.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+7|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Challenge Rate,14"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+8|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Total Sources Authenticated,1088888"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+9|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Total Attacker Sources,1700000"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+10|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Authentication List Utilization,15"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+11|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Max Request Rate Per Source,21.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+12|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Max Response Bandwidth Per Source,22.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+13|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Min Buckets Number Per Source,23.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+14|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Max Buckets Number Per Source,24.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+15|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Inbound Long Baseline Rate,140.9568"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+16|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Inbound Long Base Line Edge,240.82397"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+17|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Inbound Short Base Line Rate,25.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+18|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Inbound Short Base Line Attack Edge,26.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+19|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Inbound Real Time Full Rate,759.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+20|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Outbound Bandwidth Long Baseline,31.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+21|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Outbound Bandwidth Long Attack Edge,32.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+22|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Outbound Bandwidth Short Baseline,33.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+23|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Outbound Bandwidth Short Attack Edge,34.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+24|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Outbound Response Size Base line,35.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+25|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Outbound Response Size Attack Edge,36.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+26|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Outbound RT Bandwidth,37.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+27|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Outbound RT Response Size,38.0"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+28|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "STATE LOG:"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+29|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "State: ,Characterization"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+30|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "State: ,Mitigation"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+31|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "MITIGATION STATE LOG:"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+32|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "Mitigation State: ,Rate Limit Suspected Attackers"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "33-19" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+33|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "*********************************************************************"

  @SID_15
  Scenario: validate detailed csv DOS Shield
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+1|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "SAMPLE DETAILS:"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+2|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Source IP, Source Port, Destination IP, Destination Port, Physical Port, VLAN Tag, MPLS RD, Protocol"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+3|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.85.1.8,1055,1.1.1.8,1028,101,N/A,N/A,TCP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+4|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.85.1.8,1055,1.1.1.8,1028,101,N/A,N/A,TCP"
    Then CLI Run linux Command "cat /home/radware/ftp/csv_detailed_*.csv|head -$(echo $(grep -n "DOSS-Anomaly-TCP-SYN-RST" /home/radware/ftp/csv_detailed_*.csv |cut -f1 -d:)+5|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "*********************************************************************"

  @SID_16
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
