@TC118912
Feature: EAAF Generate PDF and HTML Report

  @SID_1
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
#    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/storage/dc_config/kvision-reporter/config/reporter.properties" on "ROOT_SERVER_CLI"
#    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Service "config_kvision-collector_1" do action RESTART
#    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." Retry 240 seconds
    Then CLI Validate service "CONFIG_KVISION_COLLECTOR" is up with timeout "45" minutes


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
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"

    * CLI Clear vision logs
    * CLI Run remote linux Command "curl -X GET localhost:9200/_cat/indices?v | grep dp-attack-raw >> /opt/radware/storage/maintenance/dp-attack-before-streaming" on "ROOT_SERVER_CLI"
    * CLI Run remote linux Command "curl -X POST localhost:9200/dp-attack-raw-*/_search -d '{"query":{"bool":{"must":[{"match_all":{}}],"must_not":[],"should":[]}},"from":0,"size":1000,"sort":[],"aggs":{}}' >> /opt/radware/storage/maintenance/attack-raw-index-before-stream" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario: Run DP simulator PCAPs for EAAF widgets and arrange the data for automation needs
    # run EAAF attacks PCAP - this PCAP is the ONLY RELEVANT PCAP FOR THIS TEST FILE
    * CLI simulate 1 attacks of type "IP_FEED_Modified" on SetId "DefensePro_Set_1" and wait 100 seconds
    # run NON EAAF attacks PCAP - this made in order to check whether system distinguish between EAAF and NON EAAF attacks
    * CLI simulate 1 attacks of type "VRM_attacks" on SetId "DefensePro_Set_1" and wait 100 seconds

  @SID_5
  Scenario: VRM - enabling emailing and go to VRM Reports Tab
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"

  @SID_6
  Scenario: Navigate to AMS Reports
    And UI Navigate to "AMS Reports" page via homePage

  @SID_7
  Scenario: stop IPTABLES
    # ToDo - check service iptables
    #Then CLI Run linux Command "service iptables stop" on "ROOT_SERVER_CLI" and validate result CONTAINS "Unloading modules"

  @SID_8
  Scenario: validate Ports EAAF Hits Timeline-EAAF
    Then UI Validate Line Chart data "EAAF Hits Timeline-EAAF" with LabelTime in report "EAAF Report"
      | value  | count |
      | 280972 | 0     |

  @SID_9
  Scenario: start IPTABLES
    # ToDo - check service iptables
    #Then CLI Run linux Command "service iptables start" on "ROOT_SERVER_CLI" and validate result CONTAINS "Loading additional modules"

  @SID_10
  Scenario: Logout
    Then UI logout and close browser




