@TC121809
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
  Scenario: Create and validate ADC LinkProof Report1 with w1 and w2 wanlinks
    Given UI "Create" Report With Name "ADC LinkProof Report1"
      | Template              | reportType:LinkProof ,Widgets:[Upload Throughput,Download Throughput,CEC] , devices:[Simulator-50.50.101.101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1H                                                                                                                        |
      | Format                | Select:  CSV                                                                                                                    |
    Then UI "Validate" Report With Name "ADC LinkProof Report1"
      | Template              | reportType:LinkProof ,Widgets:[Upload Throughput,Download Throughput,CEC] , devices:[Simulator-50.50.101.101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1H                                                                                                                        |
      | Format                | Select: CSV                                                                                                                     |

  @SID_6
  Scenario: Validate delivery card and generate report: ADC LinkProof Report1
    Then UI Click Button "My Report" with value "ADC LinkProof Report1"
    Then UI Click Button "Generate Report Manually" with value "ADC LinkProof Report1"
    Then Sleep "35"

  @SID_7
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_8
  Scenario: ADC LinkProof Report1 validate CSV file LinkProof Statistics-LinkProof.csv
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -1|tail -1|grep downThroughputUtil,wanLinkID,cunnEstConn,upThroughputBitsPs,upThroughputUtil,downThroughputBitsPS,timestamp|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
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

  @SID_9
  Scenario: old reports on file-system after the first generate
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"


  @SID_10
  Scenario: Create and validate ADC LinkProof Report2 with Prometheus_is_no_team_to_be_in wanlinks
    Given UI "Create" Report With Name "ADC LinkProof Report2"
      | Template              | reportType:LinkProof ,Widgets:[Upload Throughput,Download Throughput,CEC] , devices:[Simulator-50.50.101.101] ,WANLinks:[Prometheus_is_no_team_to_be_in] |
      | Time Definitions.Date | Quick:1H                                                                                                                                                 |
      | Format                | Select:  CSV                                                                                                                                             |
    Then UI "Validate" Report With Name "ADC LinkProof Report2"
      | Template              | reportType:LinkProof ,Widgets:[Upload Throughput,Download Throughput,CEC] , devices:[Simulator-50.50.101.101] ,WANLinks:[Prometheus_is_no_team_to_be_in] |
      | Time Definitions.Date | Quick:1H                                                                                                                                                 |
      | Format                | Select: CSV                                                                                                                                              |

  @SID_11
  Scenario: Validate delivery card and generate report: ADC LinkProof Report2
    Then UI Click Button "My Report" with value "ADC LinkProof Report2"
    Then UI Click Button "Generate Report Manually" with value "ADC LinkProof Report2"
    Then Sleep "35"

  @SID_12
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_13
  Scenario: ADC LinkProof Report1 validate CSV file LinkProof Statistics-LinkProof.csv
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -1|tail -1|grep downThroughputUtil,wanLinkID,cunnEstConn,upThroughputBitsPs,upThroughputUtil,downThroughputBitsPS,timestamp|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "-1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "Prometheus_is_no_team_to_be_in"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "0"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "0"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "-1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/LinkProof Statistics-LinkProof.csv"|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "0"


  @SID_14
  Scenario: Delete reports
    Then UI Delete Report With Name "ADC LinkProof Report1"
    Then UI Delete Report With Name "ADC LinkProof Report2"

  @SID_10
  Scenario: start IPTABLES
    Then CLI Run linux Command "service iptables start" on "ROOT_SERVER_CLI" and validate result CONTAINS "Loading additional modules"

  @SID_11
  Scenario: Logout
    Then UI logout and close browser

