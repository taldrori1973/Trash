@TC108221
Feature: VRM AMS Report Data DNS baselines

  @SID_1
  Scenario: keep reports copy on file system
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Given CLI Reset radware password
    Then Sleep "90"

  @SID_2
  Scenario: Clear Database latest traffic index and old reports on file-system
    Then CLI kill all simulator attacks on current vision
    Then CLI Clear vision logs
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * Rest Add Policy "pol_1" To DP "172.16.22.50" if Not Exist
    Then Sleep "5"

  @SID_3
  Scenario: Generate 4 cycles of traffic and clean old zip files
    Given CLI kill all simulator attacks on current vision
    Given CLI simulate 4 attacks of type "baselines_pol_1" on "DefensePro" 10 with loopDelay 15000 and wait 60 seconds
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario: Login to VRM AMS reports tab
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "AMS Reports" page via homePage

    ######################    DNS Baselines IPv4    #################################################

  @SID_5
  Scenario: Create Report of DNS baselines IPv4
    Given UI "Create" Report With Name "DNS Baselines Report IPv4"
      | reportType | DefensePro Behavioral Protections Dashboard |
      | Design     | {"Add":[{"DNS-A":["IPv4"]},{"DNS-AAAA":["IPv4"]},{"DNS-MX":["IPv4"]},{"DNS-SRV":["IPv4"]},{"DNS-TXT":["IPv4"]},{"DNS-SOA":["IPv4"]},{"DNS-PTR":["IPv4"]},{"DNS-NAPTR":["IPv4"]},{"DNS-Other":["IPv4"]}]} |
      | devices    | index:10,policies:[pol_1]                   |
      | Format     | Select: CSV                                 |
      | Time Definitions.Date | Relative:[Hours,1]               |

  @SID_6
  Scenario: Generate the report "DNS Baselines Report IPv4"
    Then UI Generate and Validate Report With Name "DNS Baselines Report IPv4" with Timeout of 300 Seconds
    Then Sleep "10"

  @SID_7
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_8
  Scenario: VRM report validate CSV file DNS-NAPTR IPv4 number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_9
  Scenario: VRM report validate CSV file DNS-NAPTR IPv4 headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -1|grep "timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -7|tail -1|grep "suspectedEdgeNoise,deviceIp,attackEdgeNoise,policyName,enrichmentContainer,protection,isIpv4,units,timeStamp,suspectedAttack,id,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_10
  Scenario: VRM report validate CSV file DNS-NAPTR IPv4 content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,260,pol_1,{},dns-naptr,,true,qps,4800,In,4440" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "260"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "dns-naptr"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $9}'" on "ROOT_SERVER_CLI" and validate result EQUALS "qps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $10}'" on "ROOT_SERVER_CLI" and validate result EQUALS "4800"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $11}'" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "4440"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|grep -oP "0.0,172.16.22.50,0.0,pol_1,{},dns-naptr,true,qps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),189.73666,,In,184.80421" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "0.0"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "0.0"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "dns-naptr"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $7}'" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "qps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $10}'" on "ROOT_SERVER_CLI" and validate result EQUALS "189.73666"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $13}'" on "ROOT_SERVER_CLI" and validate result EQUALS "184.80421"

  @SID_11
  Scenario: VRM report validate CSV file DNS-TXT IPv4 number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_12
  Scenario: VRM report validate CSV file DNS-TXT IPv4 headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|grep "timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $7}'" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $9}'" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $10}'" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $11}'" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|grep "suspectedEdgeNoise,deviceIp,attackEdgeNoise,policyName,enrichmentContainer,protection,isIpv4,units,timeStamp,suspectedAttack,id,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "suspectedEdgeNoise"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "attackEdgeNoise"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $7}'" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $9}'" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $10}'" on "ROOT_SERVER_CLI" and validate result EQUALS "suspectedAttack"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $11}'" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $13}'" on "ROOT_SERVER_CLI" and validate result EQUALS "suspectedEdge"

  @SID_13
  Scenario: VRM report validate CSV file DNS-TXT IPv4 content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,720,pol_1,{},dns-text,,true,qps,4720,In,4360" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "720"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "dns-text"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $9}'" on "ROOT_SERVER_CLI" and validate result EQUALS "qps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $10}'" on "ROOT_SERVER_CLI" and validate result EQUALS "4720"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $11}'" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "4360"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|grep -oP "0.0,172.16.22.50,0.0,pol_1,{},dns-text,true,qps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),758.94666,,In,739.21686" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "0.0"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "0.0"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "dns-text"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $7}'" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "qps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $9}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $10}'" on "ROOT_SERVER_CLI" and validate result EQUALS "758.94666"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $13}'" on "ROOT_SERVER_CLI" and validate result EQUALS "739.21686"

  @SID_14
  Scenario: VRM report validate CSV file DNS-SRV IPv4 number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_15
  Scenario: VRM report validate CSV file DNS-SRV IPv4 headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV*.csv |head -1|grep "timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV*.csv |head -7|tail -1|grep "suspectedEdgeNoise,deviceIp,attackEdgeNoise,policyName,enrichmentContainer,protection,isIpv4,units,timeStamp,suspectedAttack,id,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_16
  Scenario: VRM report validate CSV file DNS-SRV IPv4 content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV*.csv |head -2|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,270,pol_1,{},dns-srv,,true,qps,4840,In,4480" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV*.csv |head -2|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV*.csv |head -8|tail -1|grep -oP "0.0,172.16.22.50,0.0,pol_1,{},dns-srv,true,qps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),189.73666,,In,184.80421" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_17
  Scenario: VRM report validate CSV file DNS-SOA IPv4 number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_18
  Scenario: VRM report validate CSV file DNS-SOA IPv4 headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA.csv |head -1|grep "timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA.csv |head -7| tail -1|grep "suspectedEdgeNoise,deviceIp,attackEdgeNoise,policyName,enrichmentContainer,protection,isIpv4,units,timeStamp,suspectedAttack,id,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_19
  Scenario: VRM report validate CSV file DNS-SOA IPv4 content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA.csv |head -2|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,250,pol_1,{},dns-soa,,true,qps,4760,In,4400" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA.csv |head -2|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA.csv |head -8|tail -1|grep -oP "0.0,172.16.22.50,0.0,pol_1,{},dns-soa,true,qps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),189.73666,,In,184.80421" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_20
  Scenario: VRM report validate CSV file DNS-PTR IPv4 number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_21
  Scenario: VRM report validate CSV file DNS-PTR IPv4 headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR*.csv |head -1|grep "timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR*.csv |head -7|tail -1|grep "suspectedEdgeNoise,deviceIp,attackEdgeNoise,policyName,enrichmentContainer,protection,isIpv4,units,timeStamp,suspectedAttack,id,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_22
  Scenario: VRM report validate CSV file DNS-PTR IPv4 content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR*.csv |head -2|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,3600,pol_1,{},dns-ptr,,true,qps,4640,In,4280" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR*.csv |head -2|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR*.csv |head -8|tail -1|grep -oP "0.0,172.16.22.50,0.0,pol_1,{},dns-ptr,true,qps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),4024.9224,,In,3806.5366" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_23
  Scenario: VRM report validate CSV file DNS-Other IPv4 number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_24
  Scenario: VRM report validate CSV file DNS-Other IPv4 headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other*.csv |head -1|grep "timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other*.csv |head -7|tail -1|grep "suspectedEdgeNoise,deviceIp,attackEdgeNoise,policyName,enrichmentContainer,protection,isIpv4,units,timeStamp,suspectedAttack,id,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_25
  Scenario: VRM report validate CSV file DNS-Other IPv4 content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other*.csv |head -2|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,280,pol_1,{},dns-other,,true,qps,4880,In,4520" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other*.csv |head -2|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other*.csv |head -8|tail -1|grep -oP "0.0,172.16.22.50,0.0,pol_1,{},dns-other,true,qps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),189.73666,,In,184.80421" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_26
  Scenario: VRM report validate CSV file DNS-MX IPv4 number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_27
  Scenario: VRM report validate CSV file DNS-MX IPv4 headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX*.csv |head -1|grep "timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX*.csv |head -7|tail -1|grep "suspectedEdgeNoise,deviceIp,attackEdgeNoise,policyName,enrichmentContainer,protection,isIpv4,units,timeStamp,suspectedAttack,id,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_28
  Scenario: VRM report validate CSV file DNS-MX IPv4 content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX*.csv |head -2|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,3600,pol_1,{},dns-mx,,true,qps,4600,In,4240" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX*.csv |head -2|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX*.csv |head -8|tail -1|grep -oP "0.0,172.16.22.50,0.0,pol_1,{},dns-mx,true,qps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),4024.9224,,In,3806.5366" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_29
  Scenario: VRM report validate CSV file DNS-A IPv4 number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_30
  Scenario: VRM report validate CSV file DNS-A IPv4 headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A.csv |head -1|grep "timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A.csv |head -7|tail -1|grep "suspectedEdgeNoise,deviceIp,attackEdgeNoise,policyName,enrichmentContainer,protection,isIpv4,units,timeStamp,suspectedAttack,id,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_31
  Scenario: VRM report validate CSV file DNS-A IPv4 content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A.csv |head -2|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,6750,pol_1,{},dns-a,,true,qps,4560,In,4200" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A.csv |head -2|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A.csv |head -8|tail -1|grep -oP "0.0,172.16.22.50,0.0,pol_1,{},dns-a,true,qps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),7794.2285,,In,7253.347" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_32
  Scenario: VRM report validate CSV file DNS-AAAA IPv4 number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_33
  Scenario: VRM report validate CSV file DNS-AAAA IPv4 headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA*.csv |head -1|grep "timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA*.csv |head -7|tail -1|grep "suspectedEdgeNoise,deviceIp,attackEdgeNoise,policyName,enrichmentContainer,protection,isIpv4,units,timeStamp,suspectedAttack,id,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_34
  Scenario: VRM report validate CSV file DNS-AAAA IPv4 content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA*.csv |head -2|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,1350,pol_1,{},dns-aaaa,,true,qps,4680,In,4320" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA*.csv |head -2|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA*.csv |head -8|tail -1|grep -oP "0.0,172.16.22.50,0.0,pol_1,{},dns-aaaa,true,qps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),1423.0249,,In,1386.0316" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


       ######################    DNS Baselines IPv6    #################################################

  @SID_35
  Scenario: Create Report of DNS baselines IPv6
    Given UI "Create" Report With Name "DNS Baselines Report IPv6"
      | reportType | DefensePro Behavioral Protections Dashboard |
      | Design     | {"Add":[{"DNS-A":["IPv6"]},{"DNS-AAAA":["IPv6"]},{"DNS-MX":["IPv6"]},{"DNS-SRV":["IPv6"]},{"DNS-TXT":["IPv6"]},{"DNS-SOA":["IPv6"]},{"DNS-PTR":["IPv6"]},{"DNS-NAPTR":["IPv6"]},{"DNS-Other":["IPv6"]}]} |
      | devices    | index:10,policies:[pol_1]                   |
      | Format     | Select: CSV                                 |
      | Time Definitions.Date | Relative:[Hours,1]               |

  @SID_36
  Scenario: clear files from file system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_37
  Scenario: Generate the report "DNS Baselines Report IPv6"
    Then UI Navigate to "AMS Alerts" page via homePage
    Then UI Navigate to "AMS Reports" page via homePage
    Then UI Generate and Validate Report With Name "DNS Baselines Report IPv6" with Timeout of 300 Seconds

  @SID_38
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_39
  Scenario: VRM report validate CSV file DNS-NAPTR IPv6 number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_40
  Scenario: VRM report validate CSV file DNS-NAPTR IPv6 headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -1|grep "timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -7|tail -1|grep "suspectedEdgeNoise,deviceIp,attackEdgeNoise,policyName,enrichmentContainer,protection,isIpv4,units,timeStamp,suspectedAttack,id,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_41
  Scenario: VRM report validate CSV file DNS-NAPTR IPv6 content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,260,pol_1,{},dns-naptr,,false,qps,4800,In,4440" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "260"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "dns-naptr"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "false"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $9}'" on "ROOT_SERVER_CLI" and validate result EQUALS "qps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $10}'" on "ROOT_SERVER_CLI" and validate result EQUALS "4800"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $11}'" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -2|tail -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "4440"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|grep -oP "0.0,172.16.22.50,0.0,pol_1,{},dns-naptr,false,qps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),189.73666,,In,184.80421" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "0.0"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "0.0"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "dns-naptr"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $7}'" on "ROOT_SERVER_CLI" and validate result EQUALS "false"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "qps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $10}'" on "ROOT_SERVER_CLI" and validate result EQUALS "189.73666"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR*.csv |head -8|tail -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "184.80421"

  @SID_42
  Scenario: VRM report validate CSV file DNS-TXT IPv6 number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_43
  Scenario: VRM report validate CSV file DNS-TXT IPv6 headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|grep "timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $7}'" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $9}'" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $10}'" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $11}'" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|grep "suspectedEdgeNoise,deviceIp,attackEdgeNoise,policyName,enrichmentContainer,protection,isIpv4,units,timeStamp,suspectedAttack,id,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "suspectedEdgeNoise"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "attackEdgeNoise"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $7}'" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $9}'" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $10}'" on "ROOT_SERVER_CLI" and validate result EQUALS "suspectedAttack"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $11}'" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -7|tail -1|awk -F"," '{print $13}'" on "ROOT_SERVER_CLI" and validate result EQUALS "suspectedEdge"

  @SID_44
  Scenario: VRM report validate CSV file DNS-TXT IPv6 content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,720,pol_1,{},dns-text,,true,qps,4720,In,4360" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "720"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "dns-text"
    Then CLI Run remote linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $7}'" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "^$"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "false"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $9}'" on "ROOT_SERVER_CLI" and validate result EQUALS "qps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $10}'" on "ROOT_SERVER_CLI" and validate result EQUALS "4720"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $11}'" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -2|tail -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "4360"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|grep -oP "0.0,172.16.22.50,0.0,pol_1,{},dns-text,true,qps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),758.94666,,In,739.21686" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "0.0"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "0.0"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $4}'" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $6}'" on "ROOT_SERVER_CLI" and validate result EQUALS "dns-text"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $7}'" on "ROOT_SERVER_CLI" and validate result EQUALS "false"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "qps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $9}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $10}'" on "ROOT_SERVER_CLI" and validate result EQUALS "758.94666"
    Then CLI Run remote linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $11}'" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "^$"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $12}'" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT.csv |head -8|tail -1|awk -F"," '{print $13}'" on "ROOT_SERVER_CLI" and validate result EQUALS "739.21686"

  @SID_45
  Scenario: VRM report validate CSV file DNS-SRV IPv6 number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_46
  Scenario: VRM report validate CSV file DNS-SRV IPv6 headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV*.csv |head -1|grep "timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV*.csv |head -7|tail -1|grep "suspectedEdgeNoise,deviceIp,attackEdgeNoise,policyName,enrichmentContainer,protection,isIpv4,units,timeStamp,suspectedAttack,id,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_47
  Scenario: VRM report validate CSV file DNS-SRV IPv6 content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV*.csv |head -2|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,270,pol_1,{},dns-srv,,false,qps,4840,In,4480" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV*.csv |head -2|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV*.csv |head -8|tail -1|grep -oP "0.0,172.16.22.50,0.0,pol_1,{},dns-srv,false,qps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),189.73666,,In,184.80421" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_48
  Scenario: VRM report validate CSV file DNS-SOA IPv6 number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_49
  Scenario: VRM report validate CSV file DNS-SOA IPv6 headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA.csv |head -1|grep "timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA.csv |head -7| tail -1|grep "suspectedEdgeNoise,deviceIp,attackEdgeNoise,policyName,enrichmentContainer,protection,isIpv4,units,timeStamp,suspectedAttack,id,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_50
  Scenario: VRM report validate CSV file DNS-SOA IPv6 content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA.csv |head -2|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,250,pol_1,{},dns-soa,,false,qps,4760,In,4400" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA.csv |head -2|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA.csv |head -8|tail -1|grep -oP "0.0,172.16.22.50,0.0,pol_1,{},dns-soa,false,qps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),189.73666,,In,184.80421" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_51
  Scenario: VRM report validate CSV file DNS-PTR IPv6 number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_52
  Scenario: VRM report validate CSV file DNS-PTR IPv6 headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR*.csv |head -1|grep "timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR*.csv |head -7|tail -1|grep "suspectedEdgeNoise,deviceIp,attackEdgeNoise,policyName,enrichmentContainer,protection,isIpv4,units,timeStamp,suspectedAttack,id,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_53
  Scenario: VRM report validate CSV file DNS-PTR IPv6 content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR*.csv |head -2|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,3600,pol_1,{},dns-ptr,,true,qps,4640,In,4280" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR*.csv |head -2|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR*.csv |head -8|tail -1|grep -oP "0.0,172.16.22.50,0.0,pol_1,{},dns-ptr,false,qps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),4024.9224,,In,3806.5366" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_54
  Scenario: VRM report validate CSV file DNS-Other IPv6 number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_55
  Scenario: VRM report validate CSV file DNS-Other IPv6 headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other*.csv |head -1|grep "timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other*.csv |head -7|tail -1|grep "suspectedEdgeNoise,deviceIp,attackEdgeNoise,policyName,enrichmentContainer,protection,isIpv4,units,timeStamp,suspectedAttack,id,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_56
  Scenario: VRM report validate CSV file DNS-Other IPv6 content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other*.csv |head -2|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,280,pol_1,{},dns-other,,false,qps,4880,In,4520" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other*.csv |head -2|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other*.csv |head -8|tail -1|grep -oP "0.0,172.16.22.50,0.0,pol_1,{},dns-other,false,qps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),189.73666,,In,184.80421" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_57
  Scenario: VRM report validate CSV file DNS-MX IPv6 number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_58
  Scenario: VRM report validate CSV file DNS-MX IPv6 headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX*.csv |head -1|grep "timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX*.csv |head -7|tail -1|grep "suspectedEdgeNoise,deviceIp,attackEdgeNoise,policyName,enrichmentContainer,protection,isIpv4,units,timeStamp,suspectedAttack,id,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_59
  Scenario: VRM report validate CSV file DNS-MX IPv6 content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX*.csv |head -2|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,3600,pol_1,{},dns-mx,,false,qps,4600,In,4240" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX*.csv |head -2|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX*.csv |head -8|tail -1|grep -oP "0.0,172.16.22.50,0.0,pol_1,{},dns-mx,false,qps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),4024.9224,,In,3806.5366" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_60
  Scenario: VRM report validate CSV file DNS-A IPv6 number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_61
  Scenario: VRM report validate CSV file DNS-A IPv6 headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A.csv |head -1|grep "timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A.csv |head -7|tail -1|grep "suspectedEdgeNoise,deviceIp,attackEdgeNoise,policyName,enrichmentContainer,protection,isIpv4,units,timeStamp,suspectedAttack,id,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_62
  Scenario: VRM report validate CSV file DNS-A IPv6 content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A.csv |head -2|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,6750,pol_1,{},dns-a,,false,qps,4560,In,4200" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A.csv |head -2|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A.csv |head -8|tail -1|grep -oP "0.0,172.16.22.50,0.0,pol_1,{},dns-a,false,qps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),7794.2285,,In,7253.347" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_63
  Scenario: VRM report validate CSV file DNS-AAAA IPv6 number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_64
  Scenario: VRM report validate CSV file DNS-AAAA IPv6 headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA*.csv |head -1|grep "timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA*.csv |head -7|tail -1|grep "suspectedEdgeNoise,deviceIp,attackEdgeNoise,policyName,enrichmentContainer,protection,isIpv4,units,timeStamp,suspectedAttack,id,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_65
  Scenario: VRM report validate CSV file DNS-AAAA IPv6 content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA*.csv |head -2|tail -1|grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),172.16.22.50,1350,pol_1,{},dns-aaaa,,false,qps,4680,In,4320" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA*.csv |head -2|tail -1|awk -F"," '{print $1}' |grep -oP "$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]")"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA*.csv |head -8|tail -1|grep -oP "0.0,172.16.22.50,0.0,pol_1,{},dns-aaaa,false,qps,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),1423.0249,,In,1386.0316" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_66
  Scenario: cleanup and check logs
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal        | NOT_EXPECTED |
    * UI logout and close browser
    * CLI kill all simulator attacks on current vision