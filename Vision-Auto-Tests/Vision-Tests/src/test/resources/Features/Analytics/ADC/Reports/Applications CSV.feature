@TC118900
Feature: ADC Applications Generate CSV Report
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
  Scenario: Create and validate ADC Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "ADC Applications Report"
      | Template              | reportType:Application ,Widgets:[ALL] , Applications:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:1H                                                                  |
      | Format                | Select:  CSV                                                              |
    Then UI "Validate" Report With Name "ADC Applications Report"
      | Template              | reportType:Application ,Widgets:[ALL] , Applications:[Rejith_32326515:88] |
      | Time Definitions.Date | Quick:1H                                                                  |
      | Format                | Select: CSV                                                               |

  @SID_5
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "ADC Applications Report"
    Then UI Click Button "Generate Report Manually" with value "ADC Applications Report"
    Then Sleep "35"

  @SID_6
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_7
  Scenario: ADC Applications report validate CSV file Requests per Second widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Requests per Second-Application.csv"|head -1|tail -1|grep rate,http_version,applicationId,timestamp|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Requests per Second-Application.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "HTTP 2"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Requests per Second-Application.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Rejith_32326515:88"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Requests per Second-Application.csv"|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "HTTP 1.0"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Requests per Second-Application.csv"|head -3|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Rejith_32326515:88"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Requests per Second-Application.csv"|head -4|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "HTTP 1.1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Requests per Second-Application.csv"|head -4|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Rejith_32326515:88"

  @SID_8
  Scenario: ADC Applications report validate CSV file Throughput (bps) widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Throughput (bps)-Application.csv"|head -1|tail -1|grep throughput,applicationId,timestamp|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Throughput (bps)-Application.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Rejith_32326515:88"

  @SID_9
  Scenario: ADC Applications report validate CSV file Concurrent Connections widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Concurrent Connections-Application.csv"|head -1|tail -1|grep applicationId,timestamp,concurrentConnections|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Concurrent Connections-Application.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Rejith_32326515:88"

  @SID_10
  Scenario: ADC Applications report validate CSV file Connections per Second widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Connections per Second-Application.csv"|head -1|tail -1|grep cps,applicationId,timestamp|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Connections per Second-Application.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Rejith_32326515:88"

  @SID_11
  Scenario: ADC Applications report validate CSV file End-to-End Time widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/End-to-End Time-Application.csv"|head -1|tail -1|grep responseTransferUsecs,appResponseUsecs,clientRttUsecs,applicationId,serverRttUsecs|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/End-to-End Time-Application.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "74008629"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/End-to-End Time-Application.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2038114218"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/End-to-End Time-Application.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Rejith_32326515:88"

  @SID_12
  Scenario: ADC Applications report validate CSV file End-to-End_1 Time widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/End-to-End Time-Application_1.csv"|head -1|tail -1|grep endToEndUsecs,responseTransferUsecs,appResponseUsecs,clientRttUsecs,applicationId,serverRttUsecs,timestamp|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/End-to-End Time-Application_1.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "469995990"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/End-to-End Time-Application_1.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "74008629"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/End-to-End Time-Application_1.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2038114218"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/End-to-End Time-Application_1.csv"|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Rejith_32326515:88"

  @SID_13
  Scenario: ADC Applications report validate CSV file Groups and Content Rules widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -1|tail -1|grep totalDownTime,hcFailureReason,groupID,ip,lastFailureTime,id,status|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "Connection Timeout."
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "201.41.1.8"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "10"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -2|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOWN"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "Connection Timeout."
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -3|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "201.41.1.99"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -3|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "99"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -3|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOWN"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -4|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "Connection Timeout."
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -4|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "201.41.1.100"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -4|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "100"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -4|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOWN"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -5|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "Connection Timeout."
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -5|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "201.41.1.101"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -5|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "101"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -5|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOWN"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -6|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "Connection Timeout."
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -6|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "201.41.1.6"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -6|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "123abc"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -6|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOWN"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -7|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "Connection Timeout."
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -7|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "201.41.1.11"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -7|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "123456789abcdefghijklmno...vwxyz"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -7|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOWN"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -8|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "Connection Timeout."
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -8|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "201.41.1.5"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -8|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "abcdabcdabcdabcdabcdabcdabcdabcdabcdabcd"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -8|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOWN"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -9|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "Connection Timeout."
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -9|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "201.41.1.1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -9|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Real1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -9|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOWN"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -10|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "Connection Timeout."
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -10|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "201.41.1.2"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -10|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Real2"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -10|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOWN"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -11|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "Connection Timeout."
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -11|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "201.41.1.3"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -11|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Real3"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -11|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOWN"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -12|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "Connection Timeout."
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -12|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "201.41.1.4"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -12|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Real4"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -12|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOWN"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -13|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "none"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -13|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "201.41.1.10"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -13|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application.csv"|head -13|tail -1|awk -F "," '{printf $7}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Up"

  @SID_14
  Scenario: ADC Applications report validate CSV file Groups and Content Rules widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application_1.csv"|head -1|tail -1|grep groupID,cps,throughput,id,timestamp,concurrentConnections|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application_1.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application_1.csv"|head -3|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "10"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application_1.csv"|head -4|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "99"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application_1.csv"|head -5|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "100"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application_1.csv"|head -6|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "101"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application_1.csv"|head -7|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "123abc"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application_1.csv"|head -8|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "123456789abcdefghijklmno...vwxyz"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application_1.csv"|head -9|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "abcdabcdabcdabcdabcdabcdabcdabcdabcdabcd"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application_1.csv"|head -10|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Real1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application_1.csv"|head -11|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Real2"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application_1.csv"|head -12|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Real3"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Groups and Content Rules-Application_1.csv"|head -13|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Real4"

  @SID_15
  Scenario: Delete report
    Then UI Delete Report With Name "ADC Applications Report"

  @SID_16
  Scenario: Logout
    Then UI logout and close browser


