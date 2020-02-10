
@VRM_Report @TC106239
Feature: VRM AMS Report Data Traffic

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
    Then Sleep "10"

    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"

  @SID_3
  Scenario: Generate 4 cycles of traffic
    Given CLI simulate 4 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000 and wait 60 seconds

  @SID_4
  Scenario: Login to VRM AMS reports tab
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "AMS Reports" page via homePage

      #############################  TRAFFIC AND CONNECTIONS   ########################################################################

  @SID_5
  Scenario: Create Report of Traffic Global Kbps Inbound
    Given UI "Create" Report With Name "Traffic Report"
      | reportType            | DefensePro Analytics Dashboard                                                |
      | Design                | Delete:[ALL], Add:[Traffic Bandwidth,Connections Rate,Concurrent Connections] |
      | Format                | Select: CSV                                                                   |
      | Time Definitions.Date | Relative:[Hours,1]                                                            |

  @SID_6
  Scenario: Generate the report "Traffic Report"
    And UI Open "Alerts" Tab
    And UI Open "Reports" Tab
    And UI Generate and Validate Report With Name "Traffic Report" with Timeout of 300 Seconds

  @SID_7
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "cp /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip /opt/radware/storage/maintenance/" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_8
  Scenario: VRM report validate CSV file TRAFFIC Global Kbps Inbound number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "5"

  @SID_9
  Scenario: VRM report validate CSV file TRAFFIC Global Kbps Inbound headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|grep "timeStamp,excluded,discards,trafficValue" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "excluded"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "discards"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "trafficValue"

  @SID_10
  Scenario: VRM report validate CSV file TRAFFIC Global Kbps Inbound content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -2|tail -1|grep -oP "(\d{13}),0,513819,729740" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -2|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "513819"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "729740"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -5|tail -1|grep -oP "(\d{13}),0,513819,729740" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -5|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -5|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -5|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "513819"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -5|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "729740"


  @SID_11
  Scenario: VRM report validate CSV file CONNECTION RATE Global Kbps Inbound number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "5"

  @SID_12
  Scenario: VRM report validate CSV file CONNECTION RATE Global Kbps Inbound headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -1|grep "timeStamp,connectionPerSecond,policyDirection" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "connectionPerSecond"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyDirection"

  @SID_13
  Scenario: VRM report validate CSV file CONNECTION RATE Global Kbps Inbound content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -2|tail -1|grep -oP "(\d{13}),6335,Inbound" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -2|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "6335"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Inbound"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -5|tail -1|grep -oP "(\d{13}),6335,Inbound" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -5|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -5|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "6335"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -5|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Inbound"

  @SID_14
  Scenario: VRM report validate CSV file CONCURRENT CONNECTIONS Global Kbps Inbound number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "5"


  @SID_15
  Scenario: VRM report validate CSV file CONCURRENT CONNECTIONS Global Kbps Inbound headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv|head -1|grep "concurrentConnections,timeStamp" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "concurrentConnections"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"

  @SID_16
  Scenario: VRM report validate CSV file CONCURRENT CONNECTIONS Global Kbps Inbound content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |head -2|tail -1|grep -oP "426037,(\d{13})" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |head -2|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "426037"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |head -5|tail -1|grep -oP "426037,(\d{13})" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |head -5|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |head -5|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "426037"

      #############################  TRAFFIC PER POLICY bps IN   ###########################################################################

  @SID_17
  Scenario: Create Report of Traffic per policy Kbps Inbound
    Given UI "Create" Report With Name "Policy14 bps Report"
      | reportType            | DefensePro Analytics Dashboard                                                |
      | Design                | Delete:[ALL], Add:[Traffic Bandwidth,Connections Rate,Concurrent Connections] |
      | Time Definitions.Date | Relative:[Hours,1]                                                            |
      | devices               | index:10,policies:[Policy14]                                                  |
      | Format                | Select: CSV                                                                   |

  @SID_18
  Scenario: Delete old zip files from file system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_19
  Scenario: Generate the report "Policy14 bps Report"
    And UI Open "Alerts" Tab
    And UI Open "Reports" Tab
    And UI Click Button "Title" with value "Policy14 bps Report"
    And UI Click Button "Generate Now" with value "Policy14 bps Report"
    Then Sleep "60"

  @SID_20
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_21
  Scenario: VRM report validate CSV file TRAFFIC per policy Kbps Inbound number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "5"

  @SID_22
  Scenario: VRM report validate CSV file TRAFFIC per policy Kbps Inbound headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|grep "timeStamp,excluded,discards,trafficValue" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "excluded"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "discards"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "trafficValue"

  @SID_23
  Scenario: VRM report validate CSV file TRAFFIC per policy Kbps Inbound content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -2|tail -1|grep -oP "(\d{13}),0,2322,3089" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -2|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2322"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "3089"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -5|tail -1|grep -oP "(\d{13}),0,2322,3089" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -5|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -5|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -5|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2322"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -5|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "3089"

  @SID_24
  Scenario: VRM report validate CSV file CONNECTION RATE per policy Kbps Inbound number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "5"

  @SID_25
  Scenario: VRM report validate CSV file CONNECTION RATE per policy Kbps Inbound headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -1|grep "timeStamp,connectionPerSecond,policyDirection" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "connectionPerSecond"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyDirection"

  @SID_26
  Scenario: VRM report validate CSV file CONNECTION RATE per policy Kbps Inbound content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -2|tail -1|grep -oP "(\d{13}),422,Inbound" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -2|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "422"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Inbound"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -5|tail -1|grep -oP "(\d{13}),422,Inbound" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -5|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -5|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "422"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -5|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Inbound"

  @SID_27
  Scenario: VRM report validate CSV file CONCURRENT CONNECTIONS per policy Kbps Inbound number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "5"

  @SID_28
  Scenario: VRM report validate CSV file CONCURRENT CONNECTIONS per policy Kbps Inbound headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv|head -1|grep "concurrentConnections,timeStamp" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "concurrentConnections"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"

  @SID_29
  Scenario: VRM report validate CSV file CONCURRENT CONNECTIONS per policy Kbps Inbound content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |head -2|tail -1|grep -oP "1012596,(\d{13})" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1012596"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |head -2|tail -1|awk -F "," '{printf $2}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |head -5|tail -1|grep -oP "1012596,(\d{13})" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |head -5|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1012596"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |head -5|tail -1|awk -F "," '{printf $2}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

      #############################  TRAFFIC PER POLICY pps OUT   #########################################################################

#  @SID_30
#  Scenario: Create Report of Traffic per policy pps Outbound
#    Given UI "Create" Report With Name "Policy15 PPS Out Report"
#      | reportType            | DefensePro Analytics Dashboard |
#      | Design                | Delete:[ALL], Add:[Traffic Bandwidth,Connections Rate,Concurrent Connections] |
#      | Time Definitions.Date | Relative:[Hours,1]                                                            |
#      | devices               | index:10,policies:[Policy15]                                                  |
#      | Format                | Select: CSV                                                                   |
#    Then UI Click Button "Edit" with value "Policy15 PPS Out Report"
##    Then UI Click Button "Delivery Step" with value "initial"
##    Then UI Click Button "Report Format CSV" with value "CSV"
##    Then UI Click Button "Design Step" with value "initial"
##    Then UI Click Button "Widget Selection"
##    Then UI Click Button "Widget Selection.Clear Dashboard"
##    Then UI Click Button "Widget Selection.Remove All Confirm"
##    Then UI Click Button "Widget Selection"
##    Then UI Click Button "Design.trigger-Traffic Bandwidth"
##    Then UI Click Button "Design.trigger-Connections Rate"
##    Then UI Click Button "Design.trigger-Concurrent Connections"
##    Then UI Click Button "Widget Selection.Add Selected Widgets"
#    Then UI Click Button "Design.Traffic Bandwidth PPS" with value "1"
#    Then UI Click Button "Design.Traffic Bandwidth Outbound" with value "1"
#    Then UI Click Button "Submit" with value "Submit"

  @SID_31
  Scenario: Delete old zip files from file system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_32
  Scenario: Generate the report "Policy15 PPS Out Report"
    And UI Open "Alerts" Tab
    And UI Open "Reports" Tab
    And UI Click Button "Title" with value "Policy15 PPS Out Report"
    And UI Click Button "Generate Now" with value "Policy15 PPS Out Report"
    Then Sleep "60"

  @SID_33
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

#  @SID_34
#  Scenario: VRM report validate CSV file TRAFFIC per policy pps Outbound number of lines
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "5"
#
#  @SID_35
#  Scenario: VRM report validate CSV file TRAFFIC per policy pps Outbound headers
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|grep "timeStamp,excluded,discards,trafficValue" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "excluded"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "discards"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "trafficValue"
#
#  @SID_36
#  Scenario: VRM report validate CSV file TRAFFIC per policy pps Outbound content
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -2|tail -1|grep -oP "(\d{13}),0,513819,729740" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -2|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "513819"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "729740"
#
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -5|tail -1|grep -oP "(\d{13}),0,513819,729740" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -5|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -5|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -5|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "513819"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |head -5|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "729740"
#
#  @SID_37
#  Scenario: VRM report validate CSV file CONNECTION RATE per policy pps Outbound number of lines
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "5"
#
#  @SID_38
#  Scenario: VRM report validate CSV file CONNECTION RATE per policy pps Outbound headers
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -1|grep "timeStamp,connectionPerSecond,policyDirection" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "connectionPerSecond"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyDirection"
#
#  @SID_39
#  Scenario: VRM report validate CSV file CONNECTION RATE per policy pps Outbound content
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -2|tail -1|grep -oP "(\d{13}),6335,Inbound" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -2|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "6335"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Inbound"
#
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -5|tail -1|grep -oP "(\d{13}),6335,Inbound" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -5|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -5|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "6335"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -5|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Inbound"

  @SID_40
  Scenario: VRM report validate CSV file CONCURRENT CONNECTIONS per policy pps Outbound number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "5"

  @SID_41
  Scenario: VRM report validate CSV file CONCURRENT CONNECTIONS per policy pps Outbound headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv|head -1|grep "timeStamp,concurrent" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "concurrent"

  @SID_42
  Scenario: VRM report validate CSV file CONCURRENT CONNECTIONS per policy pps Outbound content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |head -2|tail -1|grep -oP "(\d{13}),426037" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |head -2|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "426037"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |head -5|tail -1|grep -oP "(\d{13}),426037" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |head -5|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv |head -5|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "426037"

  @SID_43
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