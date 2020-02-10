
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
    And UI Navigate to "AMS Reports" page via homePage


      #############################  TRAFFIC AND CONNECTIONS   ########################################################################

  @SID_5
  Scenario: Create Report of Traffic Global Kbps Inbound
    Given UI "Create" Report With Name "Traffic Report"
      | reportType | DefensePro Analytics Dashboard                                                |
      | Design     | Delete:[ALL], Add:[Traffic Bandwidth,Connections Rate,Concurrent Connections] |
      | Format     | Select: CSV                                                                   |
    # | Time Definitions.Date | Relative:[Hours,1]             |

  @SID_6
  Scenario: Generate the report "Traffic Report"
    And UI Open "Alerts" Tab
    And UI Open "Reports" Tab
    Then UI Generate and Validate Report With Name "Traffic Report" with Timeout of 300 Seconds

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
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv|head -1|grep "connvcurrentConnections,timeStamp" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "connvcurrentConnections"
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
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv|head -1|grep "conncurrentConnections,timeStamp" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Concurrent_Connections*.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "conncurrentConnections"
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

  @SID_30
  Scenario: Create Report of Traffic per policy pps Outbound
    Given UI "Create" Report With Name "Policy15 PPS Out Report"
      | reportType            | DefensePro Analytics Dashboard |
      | Design                | Delete:[ALL], Add:[Traffic Bandwidth,Connections Rate,Concurrent Connections] |
      | Time Definitions.Date | Relative:[Hours,1]                                                            |
      | devices               | index:10,policies:[Policy15]                                                  |
      | Format                | Select: CSV                                                                   |
    Then UI Click Button "Edit" with value "Policy15 PPS Out Report"
#    Then UI Click Button "Delivery Step" with value "initial"
#    Then UI Click Button "Report Format CSV" with value "CSV"
#    Then UI Click Button "Design Step" with value "initial"
#    Then UI Click Button "Widget Selection"
#    Then UI Click Button "Widget Selection.Clear Dashboard"
#    Then UI Click Button "Widget Selection.Remove All Confirm"
#    Then UI Click Button "Widget Selection"
#    Then UI Click Button "Design.trigger-Traffic Bandwidth"
#    Then UI Click Button "Design.trigger-Connections Rate"
#    Then UI Click Button "Design.trigger-Concurrent Connections"
#    Then UI Click Button "Widget Selection.Add Selected Widgets"
    Then UI Click Button "Design.Traffic Bandwidth PPS" with value "1"
    Then UI Click Button "Design.Traffic Bandwidth Outbound" with value "1"
    Then UI Click Button "Submit" with value "Submit"

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

  @SID_34
  Scenario: VRM report validate CSV file TRAFFIC per policy pps Outbound number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "5"

  @SID_35
  Scenario: VRM report validate CSV file TRAFFIC per policy pps Outbound headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|grep "timeStamp,excluded,discards,trafficValue" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "excluded"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "discards"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic_Bandwidth*.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "trafficValue"

  @SID_36
  Scenario: VRM report validate CSV file TRAFFIC per policy pps Outbound content
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

  @SID_37
  Scenario: VRM report validate CSV file CONNECTION RATE per policy pps Outbound number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "5"

  @SID_38
  Scenario: VRM report validate CSV file CONNECTION RATE per policy pps Outbound headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -1|grep "timeStamp,connectionPerSecond,policyDirection" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "connectionPerSecond"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyDirection"

  @SID_39
  Scenario: VRM report validate CSV file CONNECTION RATE per policy pps Outbound content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -2|tail -1|grep -oP "(\d{13}),6335,Inbound" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -2|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "6335"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Inbound"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -5|tail -1|grep -oP "(\d{13}),6335,Inbound" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -5|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -5|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "6335"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Connections_Rate*.csv |head -5|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Inbound"

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

      #############################  BASELINES   #########################################################################################

  @SID_43
  Scenario: Generate 4 cycles of traffic and clean old zip files
    Given CLI kill all simulator attacks on current vision
    Given CLI simulate 4 attacks of type "baselines_pol_1" on "DefensePro" 10 with loopDelay 15000 and wait 60 seconds
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_44
    Scenario: Create Report of BDOS baselines IPv4
    Given UI "Create" Report With Name "Baselines Report"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10,policies:[pol_1]                   |
      | Time Definitions.Date | Relative:[Hours,1]                          |
      | Format                | Select: CSV                                 |

  @SID_45
  Scenario: Generate the report "Baselines Report"
    And UI Open "Alerts" Tab
    And UI Open "Reports" Tab
    And UI Click Button "Title" with value "Baselines Report"
    And UI Click Button "Generate Now" with value "Baselines Report"
    Then Sleep "60"

  @SID_46
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_74
  Scenario: VRM report validate CSV file BDoS-ICMP IPv4/bps/In number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_75
  Scenario: VRM report validate CSV file BDoS-ICMP IPv4/bps/In headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_76
  Scenario: VRM report validate CSV file BDoS-ICMP IPv4/bps/In content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -2|tail -1|grep -oP "172.16.22.50,92,pol_1,{},icmp,false,true,bps,(\d{13}),,,45600,In,1040" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -8|tail -1|grep -oP "(\d{13}),172.16.22.50,323.81723,pol_1,{},icmp,false,,true,bps,In,182.09581" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-ICMP.csv |head -8|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"



  @SID_77
  Scenario: VRM report validate CSV file BDoS-UDP_Fragmented IPv4/bps/In number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP_Fragmented.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_78
  Scenario: VRM report validate CSV file BDoS-UDP_Fragmented IPv4/bps/In headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP_Fragmented.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP_Fragmented.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_79
  Scenario:V VRM report validate CSV file BDoS-UDP_Fragmented IPv4/bps/In content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP_Fragmented.csv |head -2|tail -1|grep -oP "172.16.22.50,768,pol_1,{},udp-frag,false,true,bps,(\d{13}),,,45120,In,46960" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP_Fragmented.csv |head -8|tail -1|grep -oP "(\d{13}),172.16.22.50,1402.1698,pol_1,{},udp-frag,false,,true,bps,In,1037.7218" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP_Fragmented.csv |head -8|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"



  @SID_80
  Scenario: VRM report validate CSV file BDoS-UDP IPv4/bps/In number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_81
  Scenario: VRM report validate CSV file BDoS-UDP IPv4/bps/In headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_82
  Scenario: VRM report validate CSV file BDoS-UDP IPv4/bps/In content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP.csv |head -2|tail -1|grep -oP "172.16.22.50,2048,pol_1,{},udp,false,true,bps,(\d{13}),,,45280,In,66480" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP.csv |head -8|tail -1|grep -oP "(\d{13}),172.16.22.50,3238.1724,pol_1,{},udp,false,,true,bps,In,2575.2234" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-UDP.csv |head -8|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"



  @SID_83
  Scenario: VRM report validate CSV file BDoS-TCP_SYN IPv4/bps/In number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_84
  Scenario: VRM report validate CSV file BDoS-TCP_SYN IPv4/bps/In headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_85
  Scenario: VRM report validate CSV file BDoS-TCP_SYN IPv4/bps/In content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN.csv |head -2|tail -1|grep -oP "172.16.22.50,322,pol_1,{},tcp-syn,true,true,bps,(\d{13}),,,44800,In,46640" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN.csv |head -8|tail -1|grep -oP "(\d{13}),172.16.22.50,628.17206,pol_1,{},tcp-syn,true,,true,bps,In,464.89935" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN.csv |head -8|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"



  @SID_86
  Scenario: VRM report validate CSV file BDoS-TCP_SYN ACK IPv4/bps/In number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_87
  Scenario: VRM report validate CSV file BDoS-TCP_SYN ACK IPv4/bps/In headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_88
  Scenario: VRM report validate CSV file BDoS-TCP_SYN ACK IPv4/bps/In content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -2|tail -1|grep -oP "172.16.22.50,322,pol_1,{},tcp-syn-ack,true,true,bps,(\d{13}),,,44000,In,66680" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -8|tail -1|grep -oP "(\d{13}),172.16.22.50,628.17206,pol_1,{},tcp-syn-ack,true,,true,bps,In,464.89935" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -8|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"



  @SID_89
  Scenario: VRM report validate CSV file BDoS-TCP_RST IPv4/bps/In number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_RST.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_90
  Scenario: VRM report validate CSV file BDoS-TCP_RST IPv4/bps/In headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_RST.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_RST.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_91
  Scenario: VRM report validate CSV file BDoS-TCP_RST IPv4/bps/In content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_RST.csv |head -2|tail -1|grep -oP "172.16.22.50,645,pol_1,{},tcp-rst,true,true,bps,(\d{13}),,,44640,In,46480" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_RST.csv |head -8|tail -1|grep -oP "(\d{13}),172.16.22.50,1256.3441,pol_1,{},tcp-rst,true,,true,bps,In,929.7987" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_RST.csv |head -8|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"



  @SID_92
  Scenario: VRM report validate CSV file BDoS-TCP_Fragmented IPv4/bps/In number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_Fragmented.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_93
  Scenario: VRM report validate CSV file BDoS-TCP_Fragmented IPv4/bps/In headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_Fragmented.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_Fragmented.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_94
  Scenario: VRM report validate CSV file BDoS-TCP_Fragmented IPv4/bps/In content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_Fragmented.csv |head -2|tail -1|grep -oP "172.16.22.50,161,pol_1,{},tcp-frag,true,true,bps,(\d{13}),,,43840,In,45760" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_Fragmented.csv |head -8|tail -1|grep -oP "(\d{13}),172.16.22.50,314.08603,pol_1,{},tcp-frag,true,,true,bps,In,232.44968" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_Fragmented.csv |head -8|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"



  @SID_95
  Scenario: VRM report validate CSV file BDoS-TCP_FIN ACK IPv4/bps/In number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_FIN\ ACK.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_96
  Scenario: VRM report validate CSV file BDoS-TCP_FIN ACK IPv4/bps/In headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_FIN\ ACK.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_FIN\ ACK.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_97
  Scenario: VRM report validate CSV file BDoS-TCP_FIN ACK IPv4/bps/In content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_FIN\ ACK.csv |head -2|tail -1|grep -oP "172.16.22.50,322,pol_1,{},tcp-ack-fin,true,true,bps,(\d{13}),,,44160,In,46000" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_FIN\ ACK.csv |head -8|tail -1|grep -oP "(\d{13}),172.16.22.50,628.17206,pol_1,{},tcp-ack-fin,true,,true,bps,In,464.89935" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_FIN\ ACK.csv |head -8|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"



  @SID_98
  Scenario: VRM report validate CSV file BDoS-IGMP IPv4/bps/In number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_99
  Scenario: VRM report validate CSV file BDoS-IGMP IPv4/bps/In headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_100
  Scenario: VRM report validate CSV file BDoS-IGMP IPv4/bps/In content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP.csv |head -2|tail -1|grep -oP "172.16.22.50,92,pol_1,{},igmp,false,true,bps,(\d{13}),,,44960,In,46800" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP.csv |head -8|tail -1|grep -oP "(\d{13}),172.16.22.50,323.81723,pol_1,{},igmp,false,,true,bps,In,182.09581" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-IGMP.csv |head -8|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


  @SID_101
  Scenario: Create Report of BDOS baselines IPv6 PPS Outbound
    Given UI "Create" Report With Name "Baselines Report IPv6"
      | reportType | DefensePro Behavioral Protections Dashboard |
      | Design     | {"Add":[{"BDoS-TCP SYN":["pps","IPv6","Outbound"]},{"BDoS-TCP SYN ACK":["pps","IPv6","Outbound"]},{"BDoS-UDP":["pps","IPv6","Outbound"]},{"BDoS-ICMP":["pps","IPv6","Outbound"]},{"BDoS-TCP RST":["pps","IPv6","Outbound"]},{"BDoS-TCP FIN ACK":["pps","IPv6","Outbound"]},{"BDoS-IGMP":["pps","IPv6","Outbound"]},{"BDoS-TCP Fragmented":["pps","IPv6","Outbound"]},{"BDoS-UDP Fragmented":["pps","IPv6","Outbound"]}]} |
      | devices    | index:10,policies:[pol_1]                   |
      | Format     | Select: CSV                                 |
      | Time Definitions.Date | Relative:[Hours,1]               |


  @SID_102
  Scenario: Delete old zip files on file system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_103
  Scenario: Generate the report "Baselines Report IPv6"
    And UI Open "Alerts" Tab
    And UI Open "Reports" Tab
    And UI Click Button "Title" with value "Baselines Report IPv6"
    And UI Click Button "Generate Now" with value "Baselines Report IPv6"
    Then Sleep "60"

  @SID_104
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_105
  Scenario: VRM report validate CSV file BDoS-TCP_SYN ACK IPv6/PPS/Out number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "11"

  @SID_106
  Scenario: VRM report validate CSV file BDoS-TCP_SYN ACK IPv6/PPS/Out headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -1|grep "deviceIp,normal,policyName,enrichmentContainer,protection,isTcp,isIpv4,units,timeStamp,fast,id,partial,direction,full" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -7| tail -1|grep "timeStamp,deviceIp,suspectedAttack,policyName,enrichmentContainer,protection,isTcp,id,isIpv4,units,direction,suspectedEdge" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_107
  Scenario: VRM report validate CSV file BDoS-TCP_SYN ACK IPv6/PPS/Out content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -2|tail -1|grep -oP "172.16.22.50,650,pol_1,{},tcp-syn-ack,true,false,pps,(\d{13}),,,3750,Out,4950" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -8|tail -1|grep -oP "(\d{13}),172.16.22.50,275000.0,pol_1,{},tcp-syn-ack,true,,false,pps,Out,270000.0" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/BDoS-TCP_SYN\ ACK.csv |head -8|tail -1|awk -F "," '{printf $1}' |grep -oP "(\d{13})"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


     #############################  CLEANUP   #########################################################################################


  @SID_111
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
