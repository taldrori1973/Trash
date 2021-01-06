@TC118951
Feature: DefensePro Behavioral CSV report

  @SID_1
  Scenario: keep reports copy on file system
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." with timeOut 240
    Given CLI Reset radware password

  @SID_2
  Scenario: Clear Database and old reports on file-system
    * REST Delete ES index "dp-*"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"
    Given Setup email server

  @SID_3
  Scenario: generate attack
    Given CLI kill all simulator attacks on current vision
    Given CLI Clear vision logs
    Then REST Delete ES index "dp-*"
    Given CLI simulate 200 attacks of type "baselines_pol_1" on "DefensePro" 10 with loopDelay 15000 and wait 140 seconds

  @SID_4
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_5
  Scenario: Create new Report Analytics CSV Delivery
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"deviceIp":"172.16.22.50"}},"script":{"source":"ctx._source.endTime='$(date +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"
    Given UI "Create" Report With Name "DefensePro Behavioral E2E Test"
      | Template              | reportType:DefensePro Behavioral Protections,Widgets:[ALL], devices:[{deviceIndex:10, devicePolicies:[pol_1]}] |
      | Share                 | Email:[Test, Test2],Subject:DefensePro Behavioral E2E Test Subject                                             |
      | Format                | Select: CSV                                                                                                    |
      | Time Definitions.Date | Quick:15m                                                                                                      |

  @SID_6
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Behavioral E2E Test"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Behavioral E2E Test"
    Then Sleep "35"

  @SID_9
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_11
  Scenario: BDoS-Advanced-UDP Rate-Invariant Validation
  #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-Advanced-UDP\ Rate-Invariant-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "NO DATA FOR SELECTED DATA SOURCE"

  @SID_12
  Scenario: BDoS-ICMP Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -1|grep deviceIp,normal,fullExcluded,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fullExcluded"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isTcp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fast"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "92"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "-1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "icmp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "false"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "bps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "45600"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1040"

  @SID_13
  Scenario:BDoS-IGMP Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -1|grep deviceIp,normal,fullExcluded,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fullExcluded"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isTcp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fast"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "92"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "-1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "igmp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "false"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "bps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "44960"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "46800"

  @SID_14
  Scenario:BDoS-TCP FIN ACK Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|grep deviceIp,normal,fullExcluded,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fullExcluded"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isTcp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fast"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "322"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "-1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "tcp-ack-fin"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "bps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "44160"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ FIN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "46000"

  @SID_15
  Scenario:BDoS-TCP Fragmented Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|grep deviceIp,normal,fullExcluded,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fullExcluded"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isTcp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fast"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "161"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "-1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "tcp-frag"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "bps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "43840"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "45760"

  @SID_16
  Scenario:BDoS-TCP RST Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -1|grep deviceIp,normal,fullExcluded,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fullExcluded"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isTcp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fast"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "645"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "-1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "tcp-rst"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "bps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "44640"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ RST-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "46480"

  @SID_17
  Scenario:BDoS-TCP SYN ACK Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|grep deviceIp,normal,fullExcluded,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fullExcluded"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isTcp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fast"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "322"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "-1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "tcp-syn-ack"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "bps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "44000"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN\ ACK-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "66680"

  @SID_18
  Scenario:BDoS-TCP SYN Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -1|grep deviceIp,normal,fullExcluded,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fullExcluded"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isTcp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fast"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "322"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "-1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "tcp-syn"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "bps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "44800"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP\ SYN-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "46640"

  @SID_19
  Scenario:BDoS-UDP Fragmented Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|grep deviceIp,normal,fullExcluded,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fullExcluded"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isTcp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fast"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "768"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "-1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "udp-frag"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "false"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "bps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "45120"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP\ Fragmented-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "46960"

  @SID_20
  Scenario:BDoS-UDP Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -1|grep deviceIp,normal,fullExcluded,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fullExcluded"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isTcp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fast"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2048"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "-1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "udp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "false"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "bps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "45280"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "66480"


  @SID_21
  Scenario: DNS-AAAA Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -1|grep timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1350"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "dns-aaaa"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "qps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "4680"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-AAAA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "4320"

  @SID_22
  Scenario: DNS-A Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -1|grep timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "6750"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "dns-a"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "qps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "4560"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-A-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "4200"

  @SID_23
  Scenario: DNS-MX Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -1|grep timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "3600"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "dns-mx"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "qps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "4600"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-MX-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "4240"


  @SID_24
  Scenario: DNS-NAPTR Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -1|grep timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "260"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "dns-naptr"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "qps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "4800"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-NAPTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "4440"

  @SID_25
  Scenario: DNS-Other Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -1|grep timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "280"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "dns-other"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "qps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "4880"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-Other-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "4520"

  @SID_26
  Scenario: DNS-PTR Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -1|grep timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "3600"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "dns-ptr"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "qps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "4640"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-PTR-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "4280"

  @SID_27
  Scenario: DNS-SOA Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -1|grep timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "250"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "dns-soa"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "qps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "4760"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SOA-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "4400"

  @SID_28
  Scenario: DNS-SRV Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -1|grep timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "270"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "dns-srv"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "qps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "4840"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-SRV-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "4480"

  @SID_29
  Scenario: DNS-TXT Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -1|grep timeStamp,deviceIp,normal,policyName,enrichmentContainer,protection,id,isIpv4,units,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "720"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "dns-text"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "qps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "4720"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DNS-TXT-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "4360"

  @SID_30
  Scenario: Excluded UDP Traffic Validation
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -1|grep deviceIp,normal,fullExcluded,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "normal"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fullExcluded"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "enrichmentContainer"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protection"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isTcp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "isIpv4"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "units"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $10}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $11}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "fast"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $12}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "id"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "partial"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "direction"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "full"

    #  |head -2|
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2048"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "-1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "pol_1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "{}"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "udp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "false"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $8}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "true"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $9}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "bps"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $10}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $13}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "45280"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $14}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Excluded\ UDP\ Traffic-DefensePro\ Behavioral\ Protections.csv|head -2|tail -1|awk -F "," '{printf $15}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "66480"


  @SID_31
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
