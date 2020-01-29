@TC108108
Feature: EAAF Hits Timeline, Summary Hits and Global Time Selection
@SID_1
  Scenario: Clean system attacks,database and logs
    * CLI kill all simulator attacks on current vision
    # wait until collector cache clean up
    * Sleep "15"
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs
    * CLI Run remote linux Command "curl -X GET localhost:9200/_cat/indices?v | grep dp-attack-raw >> /opt/radware/storage/maintenance/dp-attack-before-streaming" on "ROOT_SERVER_CLI"
    * CLI Run remote linux Command "curl -X POST localhost:9200/dp-attack-raw-*/_search -d '{"query":{"bool":{"must":[{"match_all":{}}],"must_not":[],"should":[]}},"from":0,"size":1000,"sort":[],"aggs":{}}' >> /opt/radware/storage/maintenance/attack-raw-index-before-stream" on "ROOT_SERVER_CLI"
  @SID_2
  Scenario: Run DP simulator PCAPs for EAAF widgets and arrange the data for automation needs
    # run EAAF attacks PCAP - this PCAP is the ONLY RELEVANT PCAP FOR THIS TEST FILE
    * CLI simulate 1 attacks of type "IP_FEED_Modified" on "DefensePro" 10
    # run NON EAAF attacks PCAP - this made in order to check whether system distinguish between EAAF and NON EAAF attacks
    * CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10 and wait 100 seconds
    # copy script that arrange the attacks times according to time ranges we have to check (15m, 30m, 1H, 1D, etc.)
    Then CLI copy "/home/radware/Scripts/EAAF_attacksTimeSpreadingScript.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    # copy script that keeps the attacks times in relation to system current time
    Then CLI copy "/home/radware/Scripts/EAAF_KeepAttacksTimesUpToDate.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    # run the script of attacks data time modification
    Then CLI Run remote linux Command "/EAAF_attacksTimeSpreadingScript.sh" on "ROOT_SERVER_CLI" with timeOut 1800
    # run the script of attacks data time update according to current system time.Scenario:
    # NOTE: this script can be stopped at the end of this test file but it's not mandatory
    Then CLI Run remote linux Command "/EAAF_KeepAttacksTimesUpToDate.sh &" on "ROOT_SERVER_CLI"
  @SID_3
  Scenario: Login and navigate to EAAF dashboard
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "EAAF Dashboard" page via homePage
  @SID_4
  Scenario: EAAF Hits Timeline - verify data for 15 minutes
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "15m"
    Then UI Click Button "Events" with value "EAAF-Hits-Timeline"
    Then UI Validate number range between minValue 44 and maxValue 48 in label "TotalsInTimeFrame Distinict IP Addresses value"
    Then UI Validate number range between minValue 44 and maxValue 48 in label "TotalsInTimeFrame Events value"
    Then UI Validate number range between minValue 34.67 and maxValue 35.68 in label "TotalsInTimeFrame Packets value"
    Then UI Validate number range between minValue 25.52 and maxValue 26.55 in label "TotalsInTimeFrame Volume value"
  Then UI Validate Text field by id "TotalsInTimeFrame Packets badge" EQUALS "K"
    Then UI Validate Text field by id "TotalsInTimeFrame Volume badge" EQUALS "K"

      Then UI Validate Line Chart data "EAAF Hits Timeline events" with LabelTime
      | value | count |countOffset |
      | 15    | 2     |1           |

  @SID_5
  Scenario: EAAF Hits Timeline - verify data for 30 minutes
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "30m"
    Then UI Click Button "Events" with value "EAAF-Hits-Timeline"
    Then UI Validate number range between minValue 68 and maxValue 72 in label "TotalsInTimeFrame Distinict IP Addresses value"
    Then UI Validate number range between minValue 74 and maxValue 78 in label "TotalsInTimeFrame Events value"
    Then UI Validate number range between minValue 41.39 and maxValue 42.42 in label "TotalsInTimeFrame Packets value"
    Then UI Validate number range between minValue 32.26 and maxValue 33.29 in label "TotalsInTimeFrame Volume value"
    Then UI Validate Text field by id "TotalsInTimeFrame Packets badge" EQUALS "K"
    Then UI Validate Text field by id "TotalsInTimeFrame Volume badge" EQUALS "K"
  @SID_6
  Scenario: EAAF Hits Timeline - verify data for one hour
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1H"
    Then UI Click Button "Events" with value "EAAF-Hits-Timeline"
    Then UI Validate number range between minValue 98 and maxValue 101 in label "TotalsInTimeFrame Distinict IP Addresses value"
    Then UI Validate number range between minValue 104 and maxValue 107 in label "TotalsInTimeFrame Events value"
    Then UI Validate number range between minValue 49.01 and maxValue 49.84 in label "TotalsInTimeFrame Packets value"
    Then UI Validate number range between minValue 39.94 and maxValue 40.71 in label "TotalsInTimeFrame Volume value"
    Then UI Validate Text field by id "TotalsInTimeFrame Packets badge" EQUALS "K"
    Then UI Validate Text field by id "TotalsInTimeFrame Volume badge" EQUALS "K"
  @SID_7
  Scenario: EAAF Hits Timeline - verify data for one day
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1D"
    Then UI Validate number range between minValue 143 and maxValue 147 in label "TotalsInTimeFrame Distinict IP Addresses value"
    Then UI Validate number range between minValue 149 and maxValue 153 in label "TotalsInTimeFrame Events value"
    Then UI Validate number range between minValue 83.98 and maxValue 85.00 in label "TotalsInTimeFrame Packets value"
    Then UI Validate number range between minValue 65.71 and maxValue 66.74 in label "TotalsInTimeFrame Volume value"
    Then UI Validate Text field by id "TotalsInTimeFrame Packets badge" EQUALS "K"
    Then UI Validate Text field by id "TotalsInTimeFrame Volume badge" EQUALS "K"
    Then UI Click Button "Events" with value "EAAF-Hits-Timeline"
    Then UI Validate Line Chart data "EAAF Hits Timeline events" with LabelTime
      | value | count |countOffset |
      | 4    | 11     |2           |
    Then UI Click Button "Packets" with value "EAAF-Hits-Timeline"
    Then UI Validate Line Chart data "EAAF Hits Timeline events" with LabelTime
      | value | count |countOffset |
      | 512    | 10     |2           |
    Then UI Click Button "Volume" with value "EAAF-Hits-Timeline"
    Then UI Validate Line Chart data "EAAF Hits Timeline events" with LabelTime
      | value | count |countOffset |
      | 512    | 10     |2           |
  @SID_8
  Scenario: EAAF Hits Timeline - verify data for one week
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1W"
    Then UI Validate number range between minValue 154 and maxValue 154 in label "TotalsInTimeFrame Distinict IP Addresses value"
    Then UI Validate number range between minValue 162 and maxValue 166 in label "TotalsInTimeFrame Events value"
    Then UI Validate number range between minValue 83.98 and maxValue 88.00 in label "TotalsInTimeFrame Packets value"
    Then UI Validate number range between minValue 65.71 and maxValue 69.74 in label "TotalsInTimeFrame Volume value"
    Then UI Validate Text field by id "TotalsInTimeFrame Packets badge" EQUALS "K"
    Then UI Validate Text field by id "TotalsInTimeFrame Volume badge" EQUALS "K"
    Then UI Click Button "Events" with value "EAAF-Hits-Timeline"
    Then UI Validate Line Chart data "EAAF Hits Timeline events" with LabelTime
      | value | count |countOffset |
      | 2    | 4     |2           |
    Then UI Click Button "Packets" with value "EAAF-Hits-Timeline"
    Then UI Validate Line Chart data "EAAF Hits Timeline events" with LabelTime
      | value | count |countOffset |
      | 256    | 3     |2           |
    Then UI Click Button "Volume" with value "EAAF-Hits-Timeline"
    Then UI Validate Line Chart data "EAAF Hits Timeline events" with LabelTime
      | value | count |countOffset |
      | 256    | 3     |2           |
  @SID_9
  Scenario: EAAF Hits Timeline - verify data for one month
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1M"
    Then UI Validate number range between minValue 154 and maxValue 158 in label "TotalsInTimeFrame Distinict IP Addresses value"
    Then UI Validate number range between minValue 173 and maxValue 177 in label "TotalsInTimeFrame Events value"
    Then UI Validate number range between minValue 89.20 and maxValue 90.23 in label "TotalsInTimeFrame Packets value"
    Then UI Validate number range between minValue 70.94 and maxValue 71.96 in label "TotalsInTimeFrame Volume value"
    Then UI Validate Text field by id "TotalsInTimeFrame Packets badge" EQUALS "K"
    Then UI Validate Text field by id "TotalsInTimeFrame Volume badge" EQUALS "K"
    Then UI Click Button "Events" with value "EAAF-Hits-Timeline"
    Then UI Validate Line Chart data "EAAF Hits Timeline events" with LabelTime
      | value | count |countOffset |
      | 2    | 3     |2           |
    Then UI Click Button "Packets" with value "EAAF-Hits-Timeline"
    Then UI Validate Line Chart data "EAAF Hits Timeline events" with LabelTime
      | value | count |countOffset |
      | 172    | 3     |2           |
    Then UI Click Button "Volume" with value "EAAF-Hits-Timeline"
    Then UI Validate Line Chart data "EAAF Hits Timeline events" with LabelTime
      | value | count |countOffset |
      | 172    | 3     |2           |
  @SID_10
  Scenario: EAAF Hits Timeline - verify data for three months
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3M"
    Then UI Validate number range between minValue 163 and maxValue 167 in label "TotalsInTimeFrame Distinict IP Addresses value"
    Then UI Validate number range between minValue 182 and maxValue 186 in label "TotalsInTimeFrame Events value"
    Then UI Validate number range between minValue 91.50 and maxValue 91.92 in label "TotalsInTimeFrame Packets value"
    Then UI Validate number range between minValue 73.24 and maxValue 73.67 in label "TotalsInTimeFrame Volume value"
    Then UI Validate Text field by id "TotalsInTimeFrame Packets badge" EQUALS "K"
    Then UI Validate Text field by id "TotalsInTimeFrame Volume badge" EQUALS "K"
    Then UI Click Button "Events" with value "EAAF-Hits-Timeline"
    Then UI Validate Line Chart data "EAAF Hits Timeline events" with LabelTime
      | value | count |countOffset |
      | 3    | 3     |2           |
    Then UI Click Button "Packets" with value "EAAF-Hits-Timeline"
    Then UI Validate Line Chart data "EAAF Hits Timeline events" with LabelTime
      | value | count |countOffset |
      | 768    | 3     |2           |
    Then UI Click Button "Volume" with value "EAAF-Hits-Timeline"
    Then UI Validate Line Chart data "EAAF Hits Timeline events" with LabelTime
      | value | count |countOffset |
      | 768    | 3     |2           |
  @SID_11
  Scenario: EAAF Summary Hits - last 24H verification
    Then UI Validate number range between minValue 149 and maxValue 153 in label "Daily Hits value"
  @SID_12
  Scenario: EAAF Summary Hits - last Month verification
    Then UI Validate number range between minValue 159 and maxValue 163 in label "Monthly Hits value"
  @SID_13
  Scenario: EAAF Summary Hits - last Year verification
    Then UI Validate number range between minValue 625 and maxValue 625 in label "Yearly Hits value"
  @SID_14
  Scenario: Cleanup
    Then UI Navigate to "HOME" page via homePage
    Then UI logout and close browser
