@TC118899
Feature: EAAF CSV Report

  @SID_1
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." with timeOut 240


  @SID_2
  Scenario: Clear old reports on file-system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"
    Given Setup email server

  @SID_3
  Scenario: Clean system attacks,database and logs
    * CLI kill all simulator attacks on current vision
    # wait until collector cache clean up
    * Sleep "15"
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs
    * CLI Run remote linux Command "curl -X GET localhost:9200/_cat/indices?v | grep dp-attack-raw >> /opt/radware/storage/maintenance/dp-attack-before-streaming" on "ROOT_SERVER_CLI"
    * CLI Run remote linux Command "curl -X POST localhost:9200/dp-attack-raw-*/_search -d '{"query":{"bool":{"must":[{"match_all":{}}],"must_not":[],"should":[]}},"from":0,"size":1000,"sort":[],"aggs":{}}' >> /opt/radware/storage/maintenance/attack-raw-index-before-stream" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario: Run DP simulator PCAPs for EAAF widgets and arrange the data for automation needs
    # run EAAF attacks PCAP - this PCAP is the ONLY RELEVANT PCAP FOR THIS TEST FILE
    * CLI simulate 1 attacks of type "IP_FEED_Modified" on "DefensePro" 10 and wait 100 seconds
    # run NON EAAF attacks PCAP - this made in order to check whether system distinguish between EAAF and NON EAAF attacks
    * CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10 and wait 100 seconds

  @SID_5
  Scenario: VRM - enabling emailing and go to VRM Reports Tab
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"

  @SID_6
  Scenario: Navigate to AMS Reports
    And UI Navigate to "AMS Reports" page via homePage

  @SID_7
  Scenario: create new Total Hits Summary1
    Given UI "Create" Report With Name "EAAF CSV"
      | Template              | reportType:EAAF , Widgets:[ALL] |
      | Time Definitions.Date | Quick:15m                       |
      | Format                | Select: CSV                     |
    Then UI "Validate" Report With Name "EAAF CSV"
      | Template              | reportType:EAAF , Widgets:[ALL] |
      | Time Definitions.Date | Quick:15m                       |
      | Format                | Select: CSV                     |

  @SID_8
  Scenario: generate report
    Then UI Click Button "My Report" with value "EAAF CSV"
    Then UI Click Button "Generate Report Manually" with value "EAAF CSV"
    Then Sleep "35"

  @SID_9
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_10
  Scenario: EAAF report validate CSV file Totals in Selected Time Frame number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Totals in Selected Time Frame-EAAF.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_11
  Scenario: EAAF report validate CSV file Totals in Selected Time Frame header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Totals in Selected Time Frame-EAAF.csv"|head -1|tail -1|grep volume,categoryAgg,distinct_count,packets|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_12
  Scenario: EAAF report validate CSV file Totals in Selected Time Frame content
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Totals in Selected Time Frame-EAAF.csv"|head -2|tail -1|grep 112923,ACL,507,140317|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Totals in Selected Time Frame-EAAF.csv"|head -2|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "112"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Totals in Selected Time Frame-EAAF.csv"|head -2|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACL"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Totals in Selected Time Frame-EAAF.csv"|head -2|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "140"

  @SID_13
  Scenario: EAAF report validate CSV file Top Malicious IP Addresses number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Malicious IP Addresses-EAAF.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "508"

  @SID_14
  Scenario: EAAF report validate CSV file Top Malicious IP Addresses header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Malicious IP Addresses-EAAF.csv"|head -1|tail -1|grep volume,sourceAddress,Count,packets|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"


  @SID_15
  Scenario: EAAF report validate CSV file Top Malicious IP Addresses content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Malicious IP Addresses-EAAF.csv"|head -2|tail -1|grep 1118,172.217.186.137,24,1118|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Malicious IP Addresses-EAAF.csv"|head -3|tail -1|grep 989,130.206.245.152,21,989|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Malicious IP Addresses-EAAF.csv"|head -4|tail -1|grep 1330,128.201.145.123,14,1330|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Malicious IP Addresses-EAAF.csv"|head -5|tail -1|grep 688,128.201.145.148,13,688|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Malicious IP Addresses-EAAF.csv"|head -6|tail -1|grep 643,185.185.124.174,12,643|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Malicious IP Addresses-EAAF.csv"|head -7|tail -1|grep 559,253.245.116.150,10,559|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Malicious IP Addresses-EAAF.csv"|head -8|tail -1|grep 473,146.112.230.157,9,473|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Malicious IP Addresses-EAAF.csv"|head -9|tail -1|grep 430,185.133.124.156,8,430|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Malicious IP Addresses-EAAF.csv"|head -10|tail -1|grep 428,170.247.140.174,7,428|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Malicious IP Addresses-EAAF.csv"|head -11|tail -1|grep 387,148.223.160.129,6,387|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_16
  Scenario: EAAF report validate CSV file Top Attacking Geolocations  number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations-EAAF.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "16"

  @SID_17
  Scenario: EAAF report validate CSV file Top Attacking Geolocations header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations-EAAF.csv"|head -1|tail -1|grep volume,countryCode,Count,packets|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_18
  Scenario: EAAF report validate CSV file Top Attacking Geolocations content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations-EAAF.csv"|head -2|tail -1|grep 38032,CR,192,47163|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations-EAAF.csv"|head -3|tail -1|grep CO,103|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations-EAAF.csv"|head -4|tail -1|grep 19163,CU,101,23728|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations-EAAF.csv"|head -5|tail -1|grep 18948,AR,96,23513|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations-EAAF.csv"|head -6|tail -1|grep 2279,US,33,2279|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations-EAAF.csv"|head -7|tail -1|grep 1075,ES,22,1075|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_19
  Scenario: EAAF report validate CSV file EAAF Hits Timeline of number lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/EAAF Hits Timeline-EAAF.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_20
  Scenario: EAAF report validate CSV file Hits Timeline header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/EAAF Hits Timeline-EAAF.csv"|head -1|tail -1|grep volume,Count,packets,timestamp|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_21
  Scenario: EAAF report validate CSV file Hits Timeline content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/EAAF Hits Timeline-EAAF.csv"|head -2|tail -1|grep 5504,115,5504|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/EAAF Hits Timeline-EAAF.csv"|head -3|tail -1|grep 510|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_22
  Scenario: Search For Bad Logs
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
      | ALL     | error      | NOT_EXPECTED |

  @SID_23
  Scenario: Cleanup
    Then UI Delete Report With Name "EAAF CSV"
    And UI logout and close browser