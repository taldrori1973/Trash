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
    * CLI simulate 1 attacks of type "IP_FEED_Modified" on "DefensePro" 10 and wait 100 seconds
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
    Then CLI Run remote linux Command "/EAAF_KeepAttacksTimesUpToDate.sh" on "ROOT_SERVER_CLI"

  @EAAFDebug
  @SID_3
  Scenario: Login and navigate to EAAF dashboard
#    Given UI Login with user "sys_admin" and password "radware"
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "EAAF Dashboard" page via homePage

  @EAAFDebug
  @SID_4
  Scenario: EAAF Hits Timeline - verify data for 15 minutes
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "15m"
    Then UI Click Button "Events" with value "EAAF-Hits-Timeline"
    Then UI Validate number range between minValue 44 and maxValue 48 in label "TotalsInTimeFrame Distinict IP Addresses value"
    Then UI Validate number range between minValue 42 and maxValue 48 in label "TotalsInTimeFrame Events value"
    Then UI Validate number range between minValue 17.07 and maxValue 17.83 in label "TotalsInTimeFrame Packets value"
    Then UI Validate number range between minValue 12.50 and maxValue 13.27 in label "TotalsInTimeFrame Volume value"
  Then UI Validate Text field by id "TotalsInTimeFrame Packets badge" EQUALS "K"
    Then UI Validate Text field by id "TotalsInTimeFrame Volume badge" EQUALS "Kbit"

      Then UI Validate Line Chart data "EAAF Hits Timeline events" with LabelTime
      | value | count |countOffset |
      | 15    | 2     |1           |

  @EAAFDebug
  @SID_5
  Scenario: EAAF Hits Timeline - verify data for 30 minutes
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "30m"
    Then UI Click Button "Events" with value "EAAF-Hits-Timeline"
    Then UI Validate number range between minValue 66 and maxValue 72 in label "TotalsInTimeFrame Distinict IP Addresses value"
    Then UI Validate number range between minValue 72 and maxValue 78 in label "TotalsInTimeFrame Events value"
    Then UI Validate number range between minValue 20.44 and maxValue 21.20 in label "TotalsInTimeFrame Packets value"
    Then UI Validate number range between minValue 15.87 and maxValue 16.64 in label "TotalsInTimeFrame Volume value"
    Then UI Validate Text field by id "TotalsInTimeFrame Packets badge" EQUALS "K"
    Then UI Validate Text field by id "TotalsInTimeFrame Volume badge" EQUALS "Kbit"

  @EAAFDebug
  @SID_6
  Scenario: EAAF Hits Timeline - verify data for one hour
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1H"
    Then UI Click Button "Events" with value "EAAF-Hits-Timeline"
    Then UI Validate number range between minValue 96 and maxValue 102 in label "TotalsInTimeFrame Distinict IP Addresses value"
    Then UI Validate number range between minValue 102 and maxValue 108 in label "TotalsInTimeFrame Events value"
    Then UI Validate number range between minValue 24.28 and maxValue 25.04 in label "TotalsInTimeFrame Packets value"
    Then UI Validate number range between minValue 19.71 and maxValue 20.48 in label "TotalsInTimeFrame Volume value"
    Then UI Validate Text field by id "TotalsInTimeFrame Packets badge" EQUALS "K"
    Then UI Validate Text field by id "TotalsInTimeFrame Volume badge" EQUALS "Kbit"

  @EAAFDebug
  @SID_7
  Scenario: EAAF Hits Timeline - verify data for one day
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1D"
    Then UI Validate number range between minValue 142 and maxValue 148 in label "TotalsInTimeFrame Distinict IP Addresses value"
    Then UI Validate number range between minValue 148 and maxValue 154 in label "TotalsInTimeFrame Events value"
    Then UI Validate number range between minValue 41.86 and maxValue 42.62 in label "TotalsInTimeFrame Packets value"
    Then UI Validate number range between minValue 32.72 and maxValue 33.49 in label "TotalsInTimeFrame Volume value"
    Then UI Validate Text field by id "TotalsInTimeFrame Packets badge" EQUALS "K"
    Then UI Validate Text field by id "TotalsInTimeFrame Volume badge" EQUALS "Kbit"
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
      | 512 K   | 10     |2           |

  @EAAFDebug
  @SID_8
  Scenario: EAAF Hits Timeline - verify data for one week
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1W"
    Then UI Validate number range between minValue 152 and maxValue 154 in label "TotalsInTimeFrame Distinict IP Addresses value"
    Then UI Validate number range between minValue 158 and maxValue 166 in label "TotalsInTimeFrame Events value"
    Then UI Validate number range between minValue 43.14 and maxValue 44.00 in label "TotalsInTimeFrame Packets value"
    Then UI Validate number range between minValue 34.01 and maxValue 34.86 in label "TotalsInTimeFrame Volume value"
    Then UI Validate Text field by id "TotalsInTimeFrame Packets badge" EQUALS "K"
    Then UI Validate Text field by id "TotalsInTimeFrame Volume badge" EQUALS "Kbit"
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
      | 256 K   | 3     |2           |

  @EAAFDebug
  @SID_9
  Scenario: EAAF Hits Timeline - verify data for one month
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1M"
    Then UI Validate number range between minValue 154 and maxValue 159 in label "TotalsInTimeFrame Distinict IP Addresses value"
    Then UI Validate number range between minValue 170 and maxValue 178 in label "TotalsInTimeFrame Events value"
    Then UI Validate number range between minValue 44.34 and maxValue 45.24 in label "TotalsInTimeFrame Packets value"
    Then UI Validate number range between minValue 35.21 and maxValue 36.11 in label "TotalsInTimeFrame Volume value"
    Then UI Validate Text field by id "TotalsInTimeFrame Packets badge" EQUALS "K"
    Then UI Validate Text field by id "TotalsInTimeFrame Volume badge" EQUALS "Kbit"
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
      | 172 K   | 3     |2           |

  @EAAFDebug
  @SID_10
  Scenario: EAAF Hits Timeline - verify data for three months
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3M"
    Then UI Validate number range between minValue 157 and maxValue 169 in label "TotalsInTimeFrame Distinict IP Addresses value"
    Then UI Validate number range between minValue 176 and maxValue 188 in label "TotalsInTimeFrame Events value"
    Then UI Validate number range between minValue 44.98 and maxValue 46.52 in label "TotalsInTimeFrame Packets value"
    Then UI Validate number range between minValue 35.85 and maxValue 37.39 in label "TotalsInTimeFrame Volume value"
    Then UI Validate Text field by id "TotalsInTimeFrame Packets badge" EQUALS "K"
    Then UI Validate Text field by id "TotalsInTimeFrame Volume badge" EQUALS "Kbit"
    Then UI Click Button "Events" with value "EAAF-Hits-Timeline"
    Then UI Validate Line Chart data "EAAF Hits Timeline events" with LabelTime
      | value | count |countOffset |
      | 3    | 3     |2           |
    Then UI Click Button "Packets" with value "EAAF-Hits-Timeline"
    Then UI Validate Line Chart data "EAAF Hits Timeline events" with LabelTime
      | value | count |countOffset |
      | 384    | 3     |2           |
    Then UI Click Button "Volume" with value "EAAF-Hits-Timeline"
    Then UI Validate Line Chart data "EAAF Hits Timeline events" with LabelTime
      | value | count |countOffset |
      | 384 K    | 3     |2           |

  @EAAFDebug
  @SID_11
  Scenario: EAAF Summary Hits - last 24H verification
    Then UI Validate number range between minValue 149 and maxValue 153 in label "Daily Hits value"

  @EAAFDebug
  @SID_12
  Scenario: EAAF Summary Hits - last Month verification
    Then UI Validate number range between minValue 166 and maxValue 180 in label "Monthly Hits value"

  @EAAFDebug
  @SID_13
  Scenario: EAAF Summary Hits - last Year verification
    Then UI Validate number range between minValue 625 and maxValue 625 in label "Yearly Hits value"

  @EAAFDebug
  @SID_14
  Scenario: Cleanup
    Then UI Navigate to "VISION SETTINGS" page via homePage
    Then UI logout and close browser
