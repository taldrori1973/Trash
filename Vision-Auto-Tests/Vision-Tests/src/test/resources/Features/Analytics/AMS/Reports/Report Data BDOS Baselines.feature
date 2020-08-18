@TC108220
Feature: VRM AMS Report Data BDoS baselines

  @SID_1
  Scenario: keep reports copy on file system
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then Sleep "120"

  @SID_2
  Scenario: Clear Database latest traffic index and old reports on file-system
    Then CLI kill all simulator attacks on current vision
    Then CLI Clear vision logs
    Then REST Delete ES index "dp-*"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "5"

  @SID_3
  Scenario: Generate 4 cycles of traffic and clean old zip files
    Given CLI kill all simulator attacks on current vision
    Given CLI simulate 4 attacks of type "baselines_pol_1" on "DefensePro" 10 with loopDelay 15000 and wait 60 seconds
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  
  @SID_4
  Scenario: Login to VRM AMS reports tab
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "AMS Reports" page via homePage

  @SID_5
  Scenario: Create Report of BDOS baselines IPv4 bps Inbound
    Given UI "Create" Report With Name "BDOS baselines IPv4 bps Inbound"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10,policies:[pol_1]                   |
      | Time Definitions.Date | Relative:[Hours,1]                          |
      | Format                | Select: CSV                                 |

  @SID_6
  Scenario: Generate the report "BDOS baselines IPv4 bps Inbound"
    And UI Navigate to "AMS Alerts" page via homePage
    And UI Navigate to "AMS Reports" page via homePage
    Then UI Generate and Validate Report With Name "BDOS baselines IPv4 bps Inbound" with Timeout of 300 Seconds
    Then Sleep "10"

  @SID_7
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_8
  Scenario: VRM report validate CSV file BDoS-ICMP IPv4/bps/In number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_9
  Scenario: VRM report validate CSV file BDoS-ICMP IPv4/bps/In headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -1|grep "deviceIp,normal,fullExcluded,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -1|awk -F"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "fullExcluded"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -1|awk -F"," '{print $7}'" on "ROOT_SERVER_CLI" and validate result EQUALS "isTcp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -1|awk -F"," '{print $8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -1|awk -F"," '{print $9}'" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -1|awk -F"," '{print $10}'" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -1|awk -F"," '{print $11}'" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -1|awk -F"," '{print $13}'" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -7| tail -1|awk -F"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -7| tail -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -7| tail -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "suspectedAttack"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -7| tail -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -7| tail -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -7| tail -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -7| tail -1|awk -F"," '{print $7}'" on "ROOT_SERVER_CLI" and validate result EQUALS "isTcp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -7| tail -1|awk -F"," '{print $8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -7| tail -1|awk -F"," '{print $9}'" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -7| tail -1|awk -F"," '{print $10}'" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -7| tail -1|awk -F"," '{print $11}'" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -7| tail -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "suspectedEdge"

  @SID_10
  Scenario: VRM report validate CSV file BDoS-ICMP IPv4/bps/In content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -2|tail -1|grep -oP "172.16.22.50,92,pol_1,{},icmp,false,true,bps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),,,45600,In,1040" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -2|tail -1|awk -F"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -2|tail -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "92"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -2|tail -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -2|tail -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -2|tail -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "icmp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -2|tail -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "false"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -2|tail -1|awk -F"," '{print $7}'" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -2|tail -1|awk -F"," '{print $8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "bps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -2|tail -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "45600"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -2|tail -1|awk -F"," '{print $13}'" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -2|tail -1|awk -F"," '{print $14}'" on "ROOT_SERVER_CLI" and validate result EQUALS "1040"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -8|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,323.81723,pol_1,{},icmp,false,,true,bps,In,182.09581" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -8|tail -1|awk -F "," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_11
  Scenario: VRM report validate CSV file BDoS-UDP_Fragmented IPv4/bps/In number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP_Fragmented.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_12
  Scenario: VRM report validate CSV file BDoS-UDP_Fragmented IPv4/bps/In headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP_Fragmented.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP_Fragmented.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_13
  Scenario: VRM report validate CSV file BDoS-UDP_Fragmented IPv4/bps/In content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP_Fragmented.csv |head -2|tail -1|grep -oP "172.16.22.50,768,pol_1,{},udp-frag,false,true,bps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),,,45120,In,46960" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP_Fragmented.csv |head -8|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,1402.1698,pol_1,{},udp-frag,false,,true,bps,In,1037.7218" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP_Fragmented.csv |head -8|tail -1|awk -F "," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_14
  Scenario: VRM report validate CSV file BDoS-UDP IPv4/bps/In number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_15
  Scenario: VRM report validate CSV file BDoS-UDP IPv4/bps/In headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_16
  Scenario: VRM report validate CSV file BDoS-UDP IPv4/bps/In content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP.csv |head -2|tail -1|grep -oP "172.16.22.50,2048,pol_1,{},udp,false,true,bps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),,,45280,In,66480" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP.csv |head -8|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,3238.1724,pol_1,{},udp,false,,true,bps,In,2575.2234" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP.csv |head -8|tail -1|awk -F "," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_17
  Scenario: VRM report validate CSV file BDoS-TCP_SYN IPv4/bps/In number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_18
  Scenario: VRM report validate CSV file BDoS-TCP_SYN IPv4/bps/In headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_19
  Scenario: VRM report validate CSV file BDoS-TCP_SYN IPv4/bps/In content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN.csv |head -2|tail -1|grep -oP "172.16.22.50,322,pol_1,{},tcp-syn,true,true,bps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),,,44800,In,46640" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN.csv |head -8|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,628.17206,pol_1,{},tcp-syn,true,,true,bps,In,464.89935" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN.csv |head -8|tail -1|awk -F "," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_20
  Scenario: VRM report validate CSV file BDoS-TCP_SYN ACK IPv4/bps/In number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_21
  Scenario: VRM report validate CSV file BDoS-TCP_SYN ACK IPv4/bps/In headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_22
  Scenario: VRM report validate CSV file BDoS-TCP_SYN ACK IPv4/bps/In content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -2|tail -1|grep -oP "172.16.22.50,322,pol_1,{},tcp-syn-ack,true,true,bps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),,,44000,In,66680" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -8|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,628.17206,pol_1,{},tcp-syn-ack,true,,true,bps,In,464.89935" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -8|tail -1|awk -F "," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_23
  Scenario: VRM report validate CSV file BDoS-TCP_RST IPv4/bps/In number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_RST.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_24
  Scenario: VRM report validate CSV file BDoS-TCP_RST IPv4/bps/In headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_RST.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_RST.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_25
  Scenario: VRM report validate CSV file BDoS-TCP_RST IPv4/bps/In content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_RST.csv |head -2|tail -1|grep -oP "172.16.22.50,645,pol_1,{},tcp-rst,true,true,bps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),,,44640,In,46480" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_RST.csv |head -8|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,1256.3441,pol_1,{},tcp-rst,true,,true,bps,In,929.7987" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_RST.csv |head -8|tail -1|awk -F "," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_26
  Scenario: VRM report validate CSV file BDoS-TCP_Fragmented IPv4/bps/In number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_Fragmented.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_27
  Scenario: VRM report validate CSV file BDoS-TCP_Fragmented IPv4/bps/In headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_Fragmented.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_Fragmented.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_28
  Scenario: VRM report validate CSV file BDoS-TCP_Fragmented IPv4/bps/In content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_Fragmented.csv |head -2|tail -1|grep -oP "172.16.22.50,161,pol_1,{},tcp-frag,true,true,bps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),,,43840,In,45760" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_Fragmented.csv |head -8|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,314.08603,pol_1,{},tcp-frag,true,,true,bps,In,232.44968" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_Fragmented.csv |head -8|tail -1|awk -F "," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_29
  Scenario: VRM report validate CSV file BDoS-TCP_FIN ACK IPv4/bps/In number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_FIN\ ACK.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_30
  Scenario: VRM report validate CSV file BDoS-TCP_FIN ACK IPv4/bps/In headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_FIN\ ACK.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_FIN\ ACK.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_31
  Scenario: VRM report validate CSV file BDoS-TCP_FIN ACK IPv4/bps/In content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_FIN\ ACK.csv |head -2|tail -1|grep -oP "172.16.22.50,322,pol_1,{},tcp-ack-fin,true,true,bps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),,,44160,In,46000" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_FIN\ ACK.csv |head -8|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,628.17206,pol_1,{},tcp-ack-fin,true,,true,bps,In,464.89935" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_FIN\ ACK.csv |head -8|tail -1|awk -F "," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_32
  Scenario: VRM report validate CSV file BDoS-IGMP IPv4/bps/In number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_33
  Scenario: VRM report validate CSV file BDoS-IGMP IPv4/bps/In headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_34
  Scenario: VRM report validate CSV file BDoS-IGMP IPv4/bps/In content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP.csv |head -2|tail -1|grep -oP "172.16.22.50,92,pol_1,{},igmp,false,true,bps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),,,44960,In,46800" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP.csv |head -8|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,323.81723,pol_1,{},igmp,false,,true,bps,In,182.09581" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP.csv |head -8|tail -1|awk -F "," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_35
  Scenario: Create Report of BDOS baselines IPv6 PPS Outbound
    Given UI "Create" Report With Name "BDOS baselines IPv6 PPS Outbound"
      | reportType            | DefensePro Behavioral Protections Dashboard                                                                                                                                                                                                                                                                                                                                                                              |
      | Design                | {"Add":[{"BDoS-TCP SYN":["pps","IPv6","Outbound"]},{"BDoS-TCP SYN ACK":["pps","IPv6","Outbound"]},{"BDoS-UDP":["pps","IPv6","Outbound"]},{"BDoS-ICMP":["pps","IPv6","Outbound"]},{"BDoS-TCP RST":["pps","IPv6","Outbound"]},{"BDoS-TCP FIN ACK":["pps","IPv6","Outbound"]},{"BDoS-IGMP":["pps","IPv6","Outbound"]},{"BDoS-TCP Fragmented":["pps","IPv6","Outbound"]},{"BDoS-UDP Fragmented":["pps","IPv6","Outbound"]}]} |
      | devices               | index:10,policies:[pol_1]                                                                                                                                                                                                                                                                                                                                                                                                |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                                                                                                              |
      | Time Definitions.Date | Relative:[Hours,1]                                                                                                                                                                                                                                                                                                                                                                                                       |


    
  @SID_36
  Scenario: Delete old zip files on file system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  
  @SID_37
  Scenario: Generate the report "BDOS baselines IPv6 PPS Outbound"
    And UI Navigate to "AMS Alerts" page via homePage
    And UI Navigate to "AMS Reports" page via homePage
    Then UI Generate and Validate Report With Name "BDOS baselines IPv6 PPS Outbound" with Timeout of 300 Seconds

  
  @SID_38
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  
  @SID_39
  Scenario: VRM report validate CSV file BDoS-TCP_SYN ACK IPv6/PPS/Out number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  
  @SID_40
  Scenario: VRM report validate CSV file BDoS-TCP_SYN ACK IPv6/PPS/Out headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -1|awk -F"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "isTcp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -1|awk -F"," '{print $7}'" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -1|awk -F"," '{print $8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -1|awk -F"," '{print $9}'" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -1|awk -F"," '{print $10}'" on "ROOT_SERVER_CLI" and validate result EQUALS "fast"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -1|awk -F"," '{print $11}'" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -1|awk -F"," '{print $13}'" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -1|awk -F"," '{print $14}'" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -7|tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -7|tail -1|awk -F"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -7|tail -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -7|tail -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "suspectedAttack"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -7|tail -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -7|tail -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -7|tail -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -7|tail -1|awk -F"," '{print $7}'" on "ROOT_SERVER_CLI" and validate result EQUALS "isTcp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -7|tail -1|awk -F"," '{print $8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -7|tail -1|awk -F"," '{print $9}'" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -7|tail -1|awk -F"," '{print $10}'" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -7|tail -1|awk -F"," '{print $11}'" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -7|tail -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "suspectedEdge"


  
  @SID_41
  Scenario: VRM report validate CSV file BDoS-TCP_SYN ACK IPv6/bPS/Out content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -2|tail -1|grep -oP "172.16.22.50,322,pol_1,{},tcp-syn-ack,true,true,bps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),,,44000,In,66680"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -2|tail -1|awk -F"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -2|tail -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "322"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -2|tail -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -2|tail -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -2|tail -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "tcp-syn-ack"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -2|tail -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -2|tail -1|awk -F"," '{print $7}'" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -2|tail -1|awk -F"," '{print $8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "bps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -2|tail -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "44000"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -2|tail -1|awk -F"," '{print $13}'" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -2|tail -1|awk -F"," '{print $14}'" on "ROOT_SERVER_CLI" and validate result EQUALS "66680"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -8|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,628.17206,pol_1,{},tcp-syn-ack,true,,true,bps,In,464.89935" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -8|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -8|tail -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -8|tail -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "628"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -8|tail -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -8|tail -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -8|tail -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "tcp-syn-ack"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -8|tail -1|awk -F"," '{print $7}'" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -8|tail -1|awk -F"," '{print $9}'" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -8|tail -1|awk -F"," '{print $10}'" on "ROOT_SERVER_CLI" and validate result EQUALS "bps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -8|tail -1|awk -F"," '{print $11}'" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -8|tail -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "464"

  @SID_42
  Scenario: cleanup and check logs
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal        | NOT_EXPECTED |
    Then UI Navigate to "VISION SETTINGS" page via homePage
    * UI logout and close browser
    * CLI kill all simulator attacks on current vision
