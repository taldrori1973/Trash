@TC118703
Feature: AppWall CSV Report

  @SID_1
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." with timeOut 240


  @SID_2
  Scenario: old reports on file-system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"
    Given Setup email server

  @SID_3
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "appwall-v2-attack*"
    * REST Delete ES index "vrm-scheduled-report-*"
    * CLI Clear vision logs

  @SID_4
  Scenario:Run AW Attacks
    Given CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/AW_Attacks/sendAW_Attacks.sh "                     |
      | #visionIP                                                         |
      | " 172.17.164.30 5 "/home/radware/AW_Attacks/AppwallAttackTypes/"" |
    And CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "cat /home/radware/AW_Attacks/AppwallAttackTypes/Injection3 \| netcat " |
      | #visionIP                                                               |
      | " 2215"                                                                 |
    And Sleep "40"
    And CLI Operations - Run Root Session command "curl -XPOST -H "Content-type: application/json" -s "localhost:9200/appwall-v2-attack-raw-*/_update_by_query/?conflicts=proceed&refresh" -d '{"query":{"bool":{"must":{"term":{"tunnel":"tun_HTTP"}}}},"script":{"source":"ctx._source.receivedTimeStamp='$(echo $(date +%s%3N)-7200000|bc)L';"}}'"
    And CLI Operations - Run Root Session command "curl -XPOST -H "Content-type: application/json" -s "localhost:9200/appwall-v2-attack-raw-*/_update_by_query/?conflicts=proceed&refresh" -d '{"query":{"bool":{"must":{"term":{"tunnel":"Default Web Application"}}}},"script":{"source":"ctx._source.receivedTimeStamp='$(echo $(date +%s%3N)-7200000|bc)L';"}}'"
    And CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/AW_Attacks/sendAW_Attacks.sh "                     |
      | #visionIP                                                         |
      | " 172.17.164.30 5 "/home/radware/AW_Attacks/AppwallAttackTypes/"" |
    And Sleep "40"

  @SID_5
  Scenario: Login And Copy get_scheduled_report_value.sh File To Server
    Given UI Login with user "radware" and password "radware"
#    And CLI copy "/home/radware/Scripts/get_scheduled_report_value.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"

  @SID_6
  Scenario: Navigate AMS Report
    Given REST Add "AppWall" Device To topology Tree with Name "Appwall_SA_172.17.164.30" and Management IP "172.17.164.30" into site "AW_site"
      | attribute     | value    |
      | httpPassword  | 1qaz!QAZ |
      | httpsPassword | 1qaz!QAZ |
      | httpsUsername | user1    |
      | httpUsername  | user1    |
      | visionMgtPort | G1       |
    * REST Vision Install License Request "vision-AVA-AppWall"
    And Browser Refresh Page
    And UI Navigate to "AMS Reports" page via homePage

  @SID_7
  Scenario: create new OWASP Top 10 1
    Given UI "Create" Report With Name "Automation AppWall CSV Report"
      | Template              | reportType:AppWall , Widgets:[ALL],Applications:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                    |
      | Time Definitions.Date | Quick:15m                                                            |
      | Format                | Select: CSV                                                          |
    Then UI "Validate" Report With Name "Automation AppWall CSV Report"
      | Template              | reportType:AppWall , Widgets:[ALL],Applications:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                    |
      | Time Definitions.Date | Quick:15m                                                            |
      | Format                | Select: CSV                                                          |

  @SID_8
  Scenario: generate report
    Then UI "Generate" Report With Name "Automation AppWall CSV Report"
      | timeOut | 60 |

  @SID_7
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI" and wait 185 seconds
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then Sleep "10"

  @SID_8
  Scenario: AppWall report validate CSV file Attack Severity widget number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack Severity-AppWall.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "6"

  @SID_9
  Scenario: AppWall report validate CSV file Attack Severity widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack Severity-AppWall.csv"|head -1|tail -1|grep severity,Count|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_10
  Scenario: AppWall report validate CSV file Attack Severity widget content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack Severity-AppWall.csv"|head -2|tail -1|grep High,130|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack Severity-AppWall.csv"|head -3|tail -1|grep Critical,5|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack Severity-AppWall.csv"|head -4|tail -1|grep Info,5|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack Severity-AppWall.csv"|head -5|tail -1|grep Low,5|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack Severity-AppWall.csv"|head -6|tail -1|grep Warning,5|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_11
  Scenario: AppWall report validate CSV file Attacks by Action widget number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Action-AppWall.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "4"

  @SID_12
  Scenario: AppWall report validate CSV file Attacks by Action widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Action-AppWall.csv"|head -1|tail -1|grep action,Count|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_13
  Scenario: AppWall report validate CSV file Attacks by Action widget content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Action-AppWall.csv"|head -2|tail -1|grep Blocked,140|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Action-AppWall.csv"|head -3|tail -1|grep Modified,5|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Action-AppWall.csv"|head -4|tail -1|grep Reported,5|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_14
  Scenario: AppWall report validate CSV file Geolocation widget number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Geolocation-AppWall.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "6"

  @SID_15
  Scenario: AppWall report validate CSV file Geolocation widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Geolocation-AppWall.csv"|head -1|tail -1|grep countryCode,Count|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_16
  Scenario: AppWall report validate CSV file Geolocation widget content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Geolocation-AppWall.csv"|head -2|tail -1|grep IQ,30|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Geolocation-AppWall.csv"|head -3|tail -1|grep RW,30|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Geolocation-AppWall.csv"|head -4|tail -1|grep SA,30|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Geolocation-AppWall.csv"|head -5|tail -1|grep SO,30|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Geolocation-AppWall.csv"|head -6|tail -1|grep YE,30|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_17
  Scenario: AppWall report validate CSV file OWASP Top 10 widget number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/OWASP Top 10-AppWall.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "5"

  @SID_18
  Scenario: AppWall report validate CSV file OWASP Top 10 widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/OWASP Top 10-AppWall.csv"|head -1|tail -1|grep OWASPCategory,Count|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_19
  Scenario: AppWall report validate CSV file OWASP Top 10 widget content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/OWASP Top 10-AppWall.csv"|head -2|tail -1|grep A1,65|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/OWASP Top 10-AppWall.csv"|head -3|tail -1|grep A5,50|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/OWASP Top 10-AppWall.csv"|head -4|tail -1|grep A7,30|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/OWASP Top 10-AppWall.csv"|head -5|tail -1|grep A6,5|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_20
  Scenario: AppWall report validate CSV file Top Attack Category widget number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Category-AppWall.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "6"

  @SID_21
  Scenario: AppWall report validate CSV file Top Attack Category widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Category-AppWall.csv"|head -1|tail -1|grep violationCategory,Count|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_22
  Scenario: AppWall report validate CSV file Top Attack Category widget content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Category-AppWall.csv"|head -2|tail -1|grep Injections,60|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Category-AppWall.csv"|head -3|tail -1|grep Access Control,50|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Category-AppWall.csv"|head -4|tail -1|grep Cross Site Scripting,30|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Category-AppWall.csv"|head -5|tail -1|grep HTTP RFC Violations,5|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Category-AppWall.csv"|head -6|tail -1|grep Misconfiguration,5|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_23
  Scenario: AppWall report validate CSV file Top Attacked Hosts widget number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacked Hosts-AppWall.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_24
  Scenario: AppWall report validate CSV file Top Attacked Hosts widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacked Hosts-AppWall.csv"|head -1|tail -1|grep host,Count|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_25
  Scenario: AppWall report validate CSV file Top Attacked Hosts widget content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacked Hosts-AppWall.csv"|head -2|tail -1|grep 172.17.154.195,150|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_26
  Scenario: AppWall report validate CSV file Top Sources widget number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Sources-AppWall.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "6"

  @SID_27
  Scenario: AppWall report validate CSV file Top Sources widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Sources-AppWall.csv"|head -1|tail -1|grep sourceIp,Count|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_28
  Scenario: AppWall report validate CSV file Top Sources widget content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Sources-AppWall.csv"|head -2|tail -1|grep 2.56.36.1,30|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Sources-AppWall.csv"|head -3|tail -1|grep 2.88.0.1,30|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Sources-AppWall.csv"|head -4|tail -1|grep 5.62.61.109,30|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Sources-AppWall.csv"|head -5|tail -1|grep 5.62.61.149,30|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Sources-AppWall.csv"|head -6|tail -1|grep 5.62.61.217,30|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"


  @SID_29
  Scenario: Search For Bad Logs
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
      | ALL     | error      | NOT_EXPECTED |

  @SID_30
  Scenario: Cleanup
    Then UI Delete Report With Name "Automation AppWall CSV Report"
    And UI logout and close browser

