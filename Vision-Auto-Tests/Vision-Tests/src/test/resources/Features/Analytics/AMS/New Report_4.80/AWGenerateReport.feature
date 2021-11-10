@TC118727
Feature: AWGenerateReport

  @SID_1
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/storage/dc_config/kvision-reporter/config/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Service "config_kvision-collector_1" do action RESTART
    Then CLI Validate service "CONFIG_KVISION_COLLECTOR" is up with timeout "45" minutes

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
    Given REST Add device with SetId "AppWall_Set_1" into site "AW_site"
    * REST Vision Install License Request "vision-AVA-AppWall"
    And Browser Refresh Page
    And UI Navigate to "AMS Reports" page via homePage

  @SID_7
  Scenario: validate attacks by action
#    Then CLI Run remote linux Command "service iptables stop" on "ROOT_SERVER_CLI"
    Then UI Validate Pie Chart data "Attacks by Action-AppWall" in Report "AwReportGeneration"
      | label    | data |
      | Blocked  | 281  |
      | Modified | 10   |
      | Reported | 10   |

  @SID_8
  Scenario: validate attacks severity
    Then UI Validate Pie Chart data "Attack Severity-AppWall" in Report "AwReportGeneration"
      | label    | data |
      | High     | 261  |
      | Critical | 10   |
      | Info     | 10   |
      | Low      | 10   |
      | Warning  | 10   |

  @SID_9
  Scenario: validate Top 10 attacks
    Then UI Validate Pie Chart data "OWASP Top 10-AppWall" in Report "AwReportGeneration"
      | label | data |
      | A1    | 131  |
      | A5    | 100  |
      | A7    | 60   |
      | A6    | 10   |

#  @SID_10
#  Scenario: start IPTABLES
#    Then CLI Run remote linux Command "service iptables start" on "ROOT_SERVER_CLI"

  @SID_11
  Scenario: validate that generate report exist in UI
  Scenario: create new OWASP Top 10 1
    Given UI "Create" Report With Name "Automation AppWall Report"
      | Template              | reportType:AppWall , Widgets:[ALL],Applications:[All],showTable:true |
      | Logo                  | reportLogoPNG.png                                                    |
      | Time Definitions.Date | Quick:15m                                                            |
    Then UI "Generate" Report With Name "Automation AppWall Report"
      | timeOut | 60 |

    Then UI Click Button "Log Preview" with value "Automation AppWall Report_0"
    Then UI Validate generate report with name "Automation AppWall Report" is exist
