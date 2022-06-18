@TC119138
Feature: EAAF Scope selection

  @SID_1
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/storage/dc_config/kvision-reporter/config/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Service "config_kvision-reporter_1" do action RESTART
    Then CLI Validate service "CONFIG_KVISION_REPORTER" is up with timeout "45" minutes

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
    #* CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10
#    * CLI simulate 2 attacks of type "IP_FEED_Modified" on "DefensePro" 11
    Given CLI simulate 1 attacks of type "IP_FEED_Modified" on SetId "DefensePro_Set_2" and wait 100 seconds


  @SID_5
  Scenario: Login
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "EAAF Dashboard" page via homePage


  @SID_6
  Scenario: validate data with scope selection
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_2 |       |          |

    Then UI Click Button "Packets" with value "Top-Malicious-IP-Addresses"
    Then UI Validate Text field "TOTAL IP Events value" with params "0" MatchRegex "(\d+.\d+|\d+) K"

    Then UI Click Button "Packets" with value "Top-Attacking-Geolocations"
    Then UI Validate Text field "country attacks total value" with params "0" MatchRegex "(\d+.\d+|\d+) K"

  @SID_7
  Scenario: run eaaf attacks
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs
    Given CLI simulate 2 attacks of type "IP_FEED_Modified" on SetId "DefensePro_Set_2" and wait 100 seconds

  @SID_8
  Scenario: Re-navigate
    When UI Navigate to "AMS Reports" page via homePage
    Then UI Navigate to "EAAF Dashboard" page via homePage

  @SID_9
  Scenario: validate data with device 11
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_13 |       |         |



  @SID_10
  Scenario: validate not available data
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_2 |       | bdos1    |
    Then UI Text of "noDataAvailable" with extension "" equal to " !No data available"


  @SID_11
  Scenario: validate sanity scope selection
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_13|        |                   |
      | DefensePro_Set_2 |       | 1_https,Policy150    |
    Then UI Do Operation "Select" item "Device Selection"
    Then UI Text of "Device Selection" with extension "" equal to "Devices2/6"
    Then UI Validate Element Existence By Label "DPScopeSelectionChange" if Exists "true" with value "172.16.22.50_disabled"
    Then UI Do Operation "Select" item "Device Selection"