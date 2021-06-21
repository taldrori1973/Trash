@run
Feature: E2E LinkProof Report
  @SID_1
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." Retry 240 seconds

  @SID_2
  Scenario: old reports on file-system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"

  @SID_3
  Scenario: Login and Navigate ADC Report
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "ADC Reports" page via homePage

  @SID_4
  Scenario: stop IPTABLES
    Then CLI Run linux Command "service iptables stop" on "ROOT_SERVER_CLI" and validate result CONTAINS "Unloading modules"

  @SID_5
  Scenario: Create and validate ADC Report
    Given UI "Create" Report With Name "ADC LinkProof Report"
      | Template              | reportType:LinkProof ,Widgets:[Upload Throughput,Download Throughput,CEC] , devices:[Simulator-50.50.101.101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1H                                                                                                                        |
      | Format                | Select:  CSV                                                                                                                    |
    Then UI "Validate" Report With Name "ADC LinkProof Report"
      | Template              | reportType:LinkProof ,Widgets:[Upload Throughput,Download Throughput,CEC] , devices:[Simulator-50.50.101.101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1H                                                                                                                        |
      | Format                | Select: CSV                                                                                                                     |

  @SID_6
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "ADC LinkProof Report"
    Then UI Click Button "Generate Report Manually" with value "ADC LinkProof Report"
    Then Sleep "35"

  @SID_7
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_8
  Scenario: ADC Applications report validate CSV file Requests per Second widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -1|tail -1|grep downThroughputUtil,wanLinkID,,cunnEstConn,upThroughputBitsPs,upThroughputUtil,downThroughputBitsPS,timestamp|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "12"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -3|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "-1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "w1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "w2"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "2"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -3|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "201456"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -3|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "233488"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "2"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -3|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "-1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "3400864"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -3|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "3687984"
    Then CLI Run linux Command "sed -n '1d;p' "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"| awk -F "," '{print $2}' | sort | uniq| wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2"
    Then CLI Run linux Command "sed -n '1d;p' "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"| awk -F "," '{print $3}' | sort | uniq| wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2"
    Then CLI Run linux Command "sed -n '1d;p' "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"| awk -F "," '{print $4}' | sort | uniq| wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2"
    Then CLI Run linux Command "sed -n '1d;p' "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"| awk -F "," '{print $5}' | sort | uniq| wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2"
    Then CLI Run linux Command "sed -n '1d;p' "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"| awk -F "," '{print $6}' | sort | uniq| wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv" |grep -w  '12'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "100"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv" |grep -w  '-1'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "100"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv" |grep -w  'w1'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "100"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv" |grep -w  'w2'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "100"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv" |grep -w  '2'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "100"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv" |grep -w  '1'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "100"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv" |grep -w  '201456'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "100"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv" |grep -w  '233488'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "100"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv" |grep -w  '2'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "100"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv" |grep -w  '-1'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "100"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv" |grep -w  '3400864'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "100"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv" |grep -w  '3687984'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "100"



  @SID_10
  Scenario: start IPTABLES
    Then CLI Run linux Command "service iptables start" on "ROOT_SERVER_CLI" and validate result CONTAINS "Loading additional modules"

  @SID_11
  Scenario: Logout
    Then UI logout and close browser

