@TC119138
Feature: EAAF Scope selection

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
    * Sleep "15"
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs
    * CLI Run remote linux Command "curl -X GET localhost:9200/_cat/indices?v | grep dp-attack-raw >> /opt/radware/storage/maintenance/dp-attack-before-streaming" on "ROOT_SERVER_CLI"
    * CLI Run remote linux Command "curl -X POST localhost:9200/dp-attack-raw-*/_search -d '{"query":{"bool":{"must":[{"match_all":{}}],"must_not":[],"should":[]}},"from":0,"size":1000,"sort":[],"aggs":{}}' >> /opt/radware/storage/maintenance/attack-raw-index-before-stream" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario: Run DP simulator PCAPs for EAAF widgets and arrange the data for automation needs
    # run EAAF attacks PCAP - this PCAP is the ONLY RELEVANT PCAP FOR THIS TEST FILE
    # run NON EAAF attacks PCAP - this made in order to check whether system distinguish between EAAF and NON EAAF attacks
    * CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10
    * CLI simulate 2 attacks of type "IP_FEED_Modified" on "DefensePro" 11
    * CLI simulate 1 attacks of type "IP_FEED_Modified" on "DefensePro" 10 and wait 100 seconds


  @SID_5
  Scenario: Login
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "EAAF Dashboard" page via homePage


  @SID_6
  Scenario: validate data with scope selection
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Click Button "Packets" with value "Top-Attacking-Geolocations"
    Then UI Validate Text field "TOTAL Country Events value" with params "0" MatchRegex "\d+ K"

    Then UI Click Button "Packets" with value "Top-Malicious-IP-Addresses"
    Then UI Validate Text field "TOTAL IP Events value" with params "0" MatchRegex "\d+ K"

  @SID_7
  Scenario: validate data with device 11
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 11    |       |          |
    Then UI Validate Text field "TOTAL Country Events value" with params "0" MatchRegex "\d+ K"


  @SID_8
  Scenario: validate not available data
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 11    |       | bdos1    |
    Then UI Text of "noDataAvailable" with extension "" equal to "!No Data Available"


  @SID_9
  Scenario: validate sanity scope selection
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies          |
      | 10    |       |                   |
      | 11    |       | 1_https,Policy150 |

    Then UI Text of "Device Selection.Available Devices header" with extension "" equal to "Devices2/3"
    Then UI Validate Element Existence By Label "DPScopeSelectionChange" if Exists "true" with value "172.16.22.50_disabled"
    Then UI Do Operation "Select" item "Device Selection"