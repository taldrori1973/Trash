@TC112730

Feature: Forensics CSV with Attack details

  @SID_1
  Scenario: Clean system data
    Given CLI Reset radware password
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    * CLI kill all simulator attacks on current vision
    * CLI Clear vision logs
    * REST Delete ES index "dp-*"
    * REST Delete ES index "forensics-*"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"

  @SID_2
  Scenario: Run DP simulator BDOS attack
  Given CLI simulate 1 attacks of type "many_attacks" on "DefensePro" 10 and wait 250 seconds

  @SID_3
  Scenario: login and go to forensic tab
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage

  @SID_4
  Scenario: Create Forensics Report csv_detailed
    When UI "Create" Forensics With Name "TC112730"
      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                               |
      | Output | Action,Attack ID,Start Time,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Threat Category,Radware ID,Device IP Address,Attack Name,End Time,Duration,Packet Type,Physical Port,Risk,Policy Name |
      | Format | Select: CSVWithDetails                                                                                                                                                                                                                               |

  @SID_5
  Scenario: Clear FTP server logs and generate the report
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/TC112730*.zip /home/radware/ftp/TC112730*.csv" on "GENERIC_LINUX_SERVER"
    Then UI Click Button "My Forensics" with value "TC112730"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "TC112730"
    Then Sleep "35"

  @SID_6
  Scenario: Unzip CSV file
    Then CLI Run remote linux Command "unzip -o /home/radware/ftp/TC112730*.zip -d /home/radware/ftp/" on "GENERIC_LINUX_SERVER"
    Then Sleep "3"

  @SID_7
  Scenario: Validate Forensics.Table
    And UI Click Button "Views.Forensic" with value "TC112730,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 30

  @SID_8
  Scenario: Validate The number of rows attacks , numberOfRecords
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'S.No,Start Time,End Time,Device IP Address,Threat Category,Attack Name,Policy Name,Action,Attack ID,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Packet Type,Physical Port,Risk' |wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "30"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,DNS-Protection,DNS flood IPv4 DNS-OTHER,P_11111111111111111111111111111111111111111111111111111111111111,Drop,47-1531216812,192.85.1.7,1024,2.2.2.1,53,In,UDP,458,365,Regular,1,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Anti-Scanning,Ping Sweep,P_11111111111111111111111111111111111111111111111111111111111111,Drop,34-1531216812,2.2.2.1,0,Multiple,0,In,ICMP,352,361,Regular,1,Medium' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Anti-Scanning,TCP Port Scan,P_11111111111111111111111111111111111111111111111111111111111111,Drop,55-1531216812,1.3.5.8,1024,2.2.2.1,Multiple,Out,TCP,350,361,Regular,2,Medium' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Behavioral-DoS,network flood IPv4 TCP-SYN-ACK,P_11111111111111111111111111111111111111111111111111111111111111,Drop,42-1531216812,1.1.1.1,1024,2.2.2.1,Multiple,In,TCP,78,356,Regular,1,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Behavioral-DoS,network flood IPv4 UDP-FRAG,P_11111111111111111111111111111111111111111111111111111111111111,Drop,40-1531216812,15.15.15.15,1024,2.2.2.1,Multiple,In,UDP,90,356,Regular,1,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Intrusions,HTTP-Triple-Headers-Flood-3,P_11111111111111111111111111111111111111111111111111111111111111,Drop,240-1531216812,Multiple,Multiple,Multiple,Multiple,Unknown,IP,15336,15,Regular,0,Medium' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,DoS,Conn_Limit,P_11111111111111111111111111111111111111111111111111111111111111,Drop,54-1531216812,190.85.1.2,1025,2.2.2.1,Multiple,Out,UDP,450000,359,Regular,2,Medium' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Behavioral-DoS,network flood IPv4 TCP-SYN-ACK,P_11111111111111111111111111111111111111111111111111111111111111,Drop,62-1531216812,2.2.2.1,1024,3.3.3.1,Multiple,Out,TCP,78,349,Regular,2,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,DNS-Protection,DNS flood IPv4 DNS-SOA,P_11111111111111111111111111111111111111111111111111111111111111,Drop,44-1531216812,192.85.1.3,1024,2.2.2.1,53,In,UDP,455,363,Regular,1,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,DNS-Protection,DNS flood IPv4 DNS-AAAA,P_11111111111111111111111111111111111111111111111111111111111111,Challenge,49-1531216812,192.85.1.8,1024,2.2.2.1,53,In,UDP,453,363,Regular,1,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,DNS-Protection,DNS flood IPv4 DNS-NAPTR,P_11111111111111111111111111111111111111111111111111111111111111,Drop,45-1531216812,192.85.1.6,1024,2.2.2.1,53,In,UDP,456,363,Regular,1,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,DNS-Protection,DNS flood IPv4 DNS-TEXT,P_11111111111111111111111111111111111111111111111111111111111111,Drop,43-1531216812,192.85.1.7,1024,2.2.2.1,53,In,UDP,454,363,Regular,1,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Behavioral-DoS,network flood IPv4 TCP-FRAG,P_11111111111111111111111111111111111111111111111111111111111111,Drop,63-1531216812,12.12.12.12,1024,2.2.2.1,Multiple,Out,TCP,79,348,Regular,2,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Behavioral-DoS,network flood IPv4 TCP-FIN-ACK,P_11111111111111111111111111111111111111111111111111111111111111,Drop,61-1531216812,2.2.2.1,100,4.4.4.1,Multiple,Out,TCP,77,349,Regular,2,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Traffic-Filters,F_111111111111111111111111111,P_11111111111111111111111111111111111111111111111111111111111111,Drop,234-1531216812,149.85.1.2,0,2.2.2.1,0,In,IP,700000,154,Regular,1,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Behavioral-DoS,network flood IPv4 TCP-FIN-ACK,P_11111111111111111111111111111111111111111111111111111111111111,Drop,41-1531216812,Multiple,1000,2.2.2.1,Multiple,In,TCP,77,348,Regular,1,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,DNS-Protection,DNS flood IPv4 DNS-SRV,P_11111111111111111111111111111111111111111111111111111111111111,Drop,46-1531216812,192.85.1.9,1024,2.2.2.1,53,In,UDP,457,363,Regular,1,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Intrusions,HTTP-Triple-Headers-Flood-3,P_11111111111111111111111111111111111111111111111111111111111111,Drop,235-1531216812,Multiple,Multiple,Multiple,Multiple,Unknown,IP,15336,15,Regular,0,Medium' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Intrusions,HTTP-Triple-Headers-Flood-3,P_11111111111111111111111111111111111111111111111111111111111111,Drop,238-1531216812,Multiple,Multiple,Multiple,Multiple,Unknown,IP,15336,15,Regular,0,Medium' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,DNS-Protection,DNS RFC-compliance violation,P_11111111111111111111111111111111111111111111111111111111111111,Drop,77-1531216812,0.0.0.0,0,0.0.0.0,0,Unknown,IP,470,91,Regular,0,Low' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Intrusions,HTTP-Triple-Headers-Flood-3,P_11111111111111111111111111111111111111111111111111111111111111,Drop,237-1531216812,Multiple,Multiple,Multiple,Multiple,Unknown,IP,15336,15,Regular,0,Medium' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,DoS,DOSS-Tsunami-SYN-Flood,P_11111111111111111111111111111111111111111111111111111111111111,Drop,236-1531216812,100.1.1.1,1000,2.2.2.1,80,In,TCP,1359,30,Regular,1,Low' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Intrusions,HTTP-Triple-Headers-Flood-3,P_11111111111111111111111111111111111111111111111111111111111111,Drop,239-1531216812,Multiple,Multiple,Multiple,Multiple,Unknown,IP,15336,15,Regular,0,Medium' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Intrusions,HTTP-Triple-Headers-Flood-3,P_11111111111111111111111111111111111111111111111111111111111111,Drop,228-1531216812,Multiple,Multiple,Multiple,Multiple,Unknown,IP,15336,15,Regular,0,Medium' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Intrusions,HTTP-Triple-Headers-Flood-3,P_11111111111111111111111111111111111111111111111111111111111111,Drop,229-1531216812,Multiple,Multiple,Multiple,Multiple,Unknown,IP,15336,15,Regular,0,Medium' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Intrusions,HTTP-Triple-Headers-Flood-3,P_11111111111111111111111111111111111111111111111111111111111111,Drop,231-1531216812,Multiple,Multiple,Multiple,Multiple,Unknown,IP,15336,15,Regular,0,Medium' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Intrusions,HTTP-Triple-Headers-Flood-3,P_11111111111111111111111111111111111111111111111111111111111111,Drop,233-1531216812,Multiple,Multiple,Multiple,Multiple,Unknown,IP,15336,15,Regular,0,Medium' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Intrusions,HTTP-Triple-Headers-Flood-3,P_11111111111111111111111111111111111111111111111111111111111111,Drop,222-1531216812,Multiple,Multiple,Multiple,Multiple,Unknown,IP,15336,15,Regular,0,Medium' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Intrusions,HTTP-Triple-Headers-Flood-3,P_11111111111111111111111111111111111111111111111111111111111111,Drop,226-1531216812,Multiple,Multiple,Multiple,Multiple,Unknown,IP,15336,15,Regular,0,Medium' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Intrusions,HTTP-Triple-Headers-Flood-3,P_11111111111111111111111111111111111111111111111111111111111111,Drop,225-1531216812,Multiple,Multiple,Multiple,Multiple,Unknown,IP,15336,15,Regular,0,Medium' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Traffic-Filters,F_111111111111111111111111111,P_11111111111111111111111111111111111111111111111111111111111111,Drop,230-1531216812,149.85.1.2,0,2.2.2.1,0,In,IP,700000,15,Regular,1,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Traffic-Filters,F_111111111111111111111111111,P_11111111111111111111111111111111111111111111111111111111111111,Drop,219-1531216812,149.85.1.2,0,2.2.2.1,0,In,IP,700000,15,Regular,1,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Traffic-Filters,F_111111111111111111111111111,P_11111111111111111111111111111111111111111111111111111111111111,Drop,221-1531216812,149.85.1.2,0,2.2.2.1,0,In,IP,700000,32,Regular,1,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Traffic-Filters,F_111111111111111111111111111,P_11111111111111111111111111111111111111111111111111111111111111,Drop,223-1531216812,149.85.1.2,0,2.2.2.1,0,In,IP,700000,46,Regular,1,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Traffic-Filters,F_111111111111111111111111111,P_11111111111111111111111111111111111111111111111111111111111111,Drop,224-1531216812,149.85.1.2,0,2.2.2.1,0,In,IP,700000,124,Regular,1,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Traffic-Filters,F_111111111111111111111111111,P_11111111111111111111111111111111111111111111111111111111111111,Drop,232-1531216812,149.85.1.2,0,2.2.2.1,0,In,IP,700000,62,Regular,1,High' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,DoS,DOSS-Tsunami-SYN-Flood,P_11111111111111111111111111111111111111111111111111111111111111,Drop,227-1531216812,100.1.1.1,1000,2.2.2.1,80,In,TCP,1359,29,Regular,1,Low' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '172.16.22.50,Anomalies,L4 Source or Dest Port Zero,Packet Anomalies,Drop,26-1531216812,Multiple,0,Multiple,0,Unknown,IP,125,0,Regular,0,Low' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"

  @SID_9
  Scenario: Validate The attack details
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'State,Blocking' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "12"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Mitigation Action,SignatureRateLimit' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "5"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Mitigation Action,SignatureChallenge' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'TTL,N/A' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "12"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'L4Checksum,N/A' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "12"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'IP ID Number,N/A' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "12"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Packet Size,N/A' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "12"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Destination IP,N/A' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "12"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Destination Port,N/A' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "12"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'DNS ID,N/A' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "12"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'DNS Query Count,N/A' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "12"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'DNS An Query Count,N/A' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "6"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Flags,N/A' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "6"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Footprint' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "15"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Time Between Events,0' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Number Of Scanned Events,2936342' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Number Of Scanned Events,3273973' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Duration,600' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Action,Drop' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Event Type,SCANNING_ATTACK_DETAILS_REPORT' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Event Type,SCANNING_BLOCKING_DURATION_REPORT' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'TCP Sequence Number,N/A' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "6"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Fragmentation Offset,N/A' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "6"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Fragmentation Flag,N/A' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "6"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Flow Label,N/A' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "6"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'ToS,N/A' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "6"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'ICMP Message Type,N/A' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "6"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Is Burst Active,0' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "6"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Current Burst Number,0' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "6"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Average Burst Duration,0' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "6"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Average Time between Bursts,0' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "6"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Average Burst Rate,0' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "12"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Max Average Burst Rate,0' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "6"

  #    --------------------------------------------------------- SAMPLE DETAILS: -------------------------------------------
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'SAMPLE DETAILS:' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "22"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep 'Source IP, Source Port, Destination IP, Destination Port, Physical Port, VLAN Tag, MPLS RD, Protocol' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "22"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '192.85.1.7,1024,2.2.2.1,53,101,N/A,N/A,UDP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "4"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '1.1.1.1,1024,2.2.2.1,1066,101,N/A,N/A,TCP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '1.1.1.1,1024,2.2.2.1,1073,101,N/A,N/A,TCP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '15.15.15.15,1024,2.2.2.1,1025,101,N/A,N/A,UDP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '15.15.15.15,1024,2.2.2.1,1026,101,N/A,N/A,UDP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '190.85.1.2,1025,2.2.2.1,22210,102,N/A,N/A,UDP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '190.85.1.2,1025,2.2.2.1,11105,102,N/A,N/A,UDP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '2.2.2.1,1024,3.3.3.1,1728,102,N/A,N/A,TCP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '2.2.2.1,1024,3.3.3.1,1729,102,N/A,N/A,TCP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '192.85.1.3,1024,2.2.2.1,53,101,N/A,N/A,UDP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '192.85.1.8,1024,2.2.2.1,53,101,N/A,N/A,UDP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '192.85.1.6,1024,2.2.2.1,53,101,N/A,N/A,UDP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '12.12.12.12,1024,2.2.2.1,1054,102,N/A,N/A,TCP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '12.12.12.12,1024,2.2.2.1,1055,102,N/A,N/A,TCP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '2.2.2.1,100,4.4.4.1,103,102,N/A,N/A,TCP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '2.2.2.1,100,4.4.4.1,104,102,N/A,N/A,TCP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '149.85.1.2,0,2.2.2.1,0,101,N/A,N/A,IP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "24"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '3.3.1.2,1000,2.2.2.1,70,101,N/A,N/A,TCP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '3.3.1.4,1000,2.2.2.1,73,101,N/A,N/A,TCP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '192.85.1.9,1024,2.2.2.1,53,101,N/A,N/A,UDP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '190.85.1.2,1025,2.2.2.1,53,102,N/A,N/A,UDP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "2"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv |grep '100.1.1.1,1000,2.2.2.1,80,101,N/A,N/A,TCP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "6"

  @SID_10
  Scenario: Cleanup
    Then UI Delete Forensics With Name "TC112730"
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
