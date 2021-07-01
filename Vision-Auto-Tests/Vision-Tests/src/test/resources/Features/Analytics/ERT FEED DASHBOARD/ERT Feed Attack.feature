@TC110170
Feature: ERTFeed Attack validation

  @SID_1
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
  @SID_2
  Scenario: Run DP simulator PCAPs for EAAF widgets and arrange the data for automation needs
    When CLI simulate 1 attacks of type "ErtFeed_GeoFeed" on "DefensePro" 11 and wait 20 seconds
    Then CLI copy "/home/radware/Scripts/EAAF_attacksTimeSpreadingScript.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    # copy script that keeps the attacks times in relation to system current time
    Then CLI copy "/home/radware/Scripts/EAAF_KeepAttacksTimesUpToDate.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    # run the script of attacks data time modification
    Then CLI Run remote linux Command "/EAAF_attacksTimeSpreadingScript.sh" on "ROOT_SERVER_CLI" with timeOut 1800
    # run the script of attacks data time update according to current system time.Scenario:
    # NOTE: this script can be stopped at the end of this test file but it's not mandatory
    Then CLI Run remote linux Command "nohup /EAAF_KeepAttacksTimesUpToDate.sh" on "ROOT_SERVER_CLI"

  @SID_3
  Scenario: Login and navigate to EAAF dashboard
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    When UI Navigate to "EAAF Dashboard" page via homePage

  @SID_4
  Scenario: Validate Top Attacking Geolocations Widget - Packets
    Then UI Click Button "Packets" with value "Top-Attacking-Geolocations"
    Then UI Validate Text field "TOTAL Country Events value" with params "0" EQUALS "74 K" with offset 2

  @SID_5
  Scenario: Validate Top Attacking Geolocations Widget - Events
    Then UI Click Button "Events" with value "Top-Attacking-Geolocations"
    Then UI Validate Text field "TOTAL Country Events value" with params "0" EQUALS "1"

  @SID_6
  Scenario: Validate Top Attacking Geolocations Widget - Volume
    Then UI Click Button "Volume" with value "Top-Attacking-Geolocations"
    Then UI Validate Text field "TOTAL Country Events value" with params "0" EQUALS "35 M" with offset 2

  @SID_7
  Scenario: Validate Top Malicious IP Addresses Widget - Packets
    Then UI Click Button "Packets" with value "Top-Malicious-IP-Addresses"
    Then UI Validate Text field "TOTAL IP Events value" with params "0" EQUALS "74 K" with offset 2

  @SID_8
  Scenario: Validate Top Malicious IP Addresses Widget - Events
    Then UI Click Button "Events" with value "Top-Malicious-IP-Addresses"
    Then UI Validate Text field "TOTAL IP Events value" with params "0" EQUALS "1"

  @SID_9
  Scenario: Validate Top Malicious IP Addresses Widget - Volume
    Then UI Click Button "Volume" with value "Top-Malicious-IP-Addresses"
    Then UI Validate Text field "TOTAL IP Events value" with params "0" EQUALS "35 M" with offset 2

  @SID_10
  Scenario: Logout
    Then UI logout and close browser







