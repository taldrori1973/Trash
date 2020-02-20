@TC113494
Feature: DefenseFlow Activations Reports CSV
  @SID_1
  Scenario: keep reports copy on file system
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720

  @SID_2
  Scenario: Clear data
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    * REST Delete ES index "dp-*"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"
    * CLI Clear vision logs


  @SID_3
  Scenario:Login
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given UI Login with user "sys_admin" and password "radware"


  @SID_4
  Scenario: Navigate to AMS report
    And UI Navigate to "AMS Reports" page via homePage

  @SID_5
  Scenario: Create DefenseFlow report
    When UI "Create" Report With Name "OverallDFReport"
      | reportType     | DefenseFlow Analytics Dashboard                                                                                                                                                          |
      | projectObjects | All                                                                                                                                                                                      |
      | Design         | Add:[Top 10 Attacks by Duration (hh:mm:ss),Top 10 Attacks by Rate (Gbps),Top 10 Attacks by Rate (Mpps),DDoS Peak Attack per Selected Period,DDoS Attack Activations per Selected Period] |
      | Format         | Select: CSV                                                                                                                                                                              |
    Then UI Validate Element Existence By Label "Reports List Item" if Exists "true" with value "OverallDFReport"

  @SID_6
  Scenario: Generate Report
    Then UI Generate and Validate Report With Name "OverallDFReport" with Timeout of 120 Seconds

  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_7
  Scenario: VRM report validate CSV file DDoS_Attack Activations per Selected Period.csv
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DDoS_Attack*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DDoS_Attack*.csv|head -1|tail -1|grep updateTime,distinct_count|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/DDoS_Attack*.csv|head -2|tail -1|grep 14|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_8
  Scenario: VRM report validate CSV file DDoS_Peak Attack per Selected Period
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"DDoS_Peak Attack per Selected Period.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"DDoS_Peak Attack per Selected Period.csv"|head -1|tail -1|grep maxBandwidthBps,updateTime,activationId,protectedObjectName,destinationNetwork|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"DDoS_Peak Attack per Selected Period.csv"|head -2|tail -1|grep 1231371200000,.*,14,PO_115,80.75.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_9
  Scenario: VRM report validate CSV file Top_10 Attacks by Duration
    Then CLI Run linux Command " cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Duration (hh_mm:ss).csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Duration (hh_mm:ss).csv"|head -1|tail -1|grep duration,distinct_count,activationId,protectedObjectName,destinationNetwork|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_10
  Scenario: VRM report validate CSV file Top_10 Attacks by Rate Gbps
    Then CLI Run linux Command " cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Gbps).csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Gbps).csv"|head -1|tail -1|grep maxBandwidthBps,distinct_count,activationId,protectedObjectName,destinationNetwork|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Gbps).csv"|head -2|tail -1|grep 1231371200000,1,14,PO_115,80.75.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Gbps).csv"|head -3|tail -1|grep 1151371200000,1,13,PO_114,80.74.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Gbps).csv"|head -4|tail -1|grep 1071371200000,1,12,PO_113,80.73.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Gbps).csv"|head -5|tail -1|grep 991371200000,1,11,PO_112,80.72.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Gbps).csv"|head -6|tail -1|grep 911371200000,1,10,PO_111,80.71.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Gbps).csv"|head -7|tail -1|grep 751371200000,1,9,PO_109,70.79.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Gbps).csv"|head -8|tail -1|grep 671371200000,1,8,PO_108,70.78.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Gbps).csv"|head -9|tail -1|grep 591371200000,1,7,PO_107,70.77.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Gbps).csv"|head -10|tail -1|grep 511371200000,1,6,PO_106,70.76.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Gbps).csv"|head -11|tail -1|grep 431371200000,1,5,PO_105,70.75.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_11
  Scenario: VRM report validate CSV file Top_10 Attacks by Rate Mpps
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Mpps).csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Mpps).csv"|head -1|tail -1|grep distinct_count,maxPacketRatePps,activationId,protectedObjectName,destinationNetwork|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Mpps).csv"|head -2|tail -1|grep 1,15087000000,14,PO_115,80.75.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Mpps).csv"|head -3|tail -1|grep 1,14087000000,13,PO_114,80.74.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Mpps).csv"|head -4|tail -1|grep 1,13087000000,12,PO_113,80.73.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Mpps).csv"|head -5|tail -1|grep 1,12087000000,11,PO_112,80.72.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Mpps).csv"|head -6|tail -1|grep 1,11087000000,10,PO_111,80.71.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Mpps).csv"|head -7|tail -1|grep 1,9087000000,9,PO_109,70.79.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Mpps).csv"|head -8|tail -1|grep 1,8087000000,8,PO_108,70.78.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Mpps).csv"|head -9|tail -1|grep 1,7087000000,7,PO_107,70.77.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Mpps).csv"|head -10|tail -1|grep 1,6087000000,6,PO_106,70.76.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/"Top_10 Attacks by Rate (Mpps).csv"|head -11|tail -1|grep 1,5087000000,5,PO_105,70.75.0.0/32|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |