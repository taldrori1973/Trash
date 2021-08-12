@TC108104
Feature: EAAF Widget - Top Country Statistics

  @SID_1
  Scenario: Clean system attacks,database and logs
    * CLI kill all simulator attacks on current vision
    # wait until collector cache clean up
    * Sleep "15"
#  * REST Delete ES index "dp-traffic-*"
#  * REST Delete ES index "dp-https-stats-*"
#  * REST Delete ES index "dp-https-rt-*"
#  * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs
    * CLI Run remote linux Command "curl -X GET localhost:9200/_cat/indices?v | grep dp-attack-raw >> /opt/radware/storage/maintenance/dp-attack-before-streaming" on "ROOT_SERVER_CLI"
    * CLI Run remote linux Command "curl -X POST localhost:9200/dp-attack-raw-*/_search -d '{"query":{"bool":{"must":[{"match_all":{}}],"must_not":[],"should":[]}},"from":0,"size":1000,"sort":[],"aggs":{}}' >> /opt/radware/storage/maintenance/attack-raw-index-before-stream" on "ROOT_SERVER_CLI"

  @SID_2
  Scenario: Run DP simulator PCAPs for EAAF widgets
    * CLI simulate 1 attacks of type "IP_FEED_Modified" on SetId "DefensePro_Set_1" and wait 150 seconds

  @SID_3
  Scenario: Login and navigate to EAAF dashboard
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
#    Given UI Login with user "sys_admin" and password "radware"
#    When UI Open Upper Bar Item "EAAF Dashboard"
    When UI Navigate to "EAAF Dashboard" page via homePage
#this scenario verifies two things: Default selection of "Events" TAB and data correctness of that TAB

  @SID_4
  Scenario: Validate Top Attacking Countries Widget - Events
#      check IP bar percentage value
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "0" is "EQUALS" to "100.00%"
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "2" is "EQUALS" to "51%" with offset 2
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "3" is "EQUALS" to "49%" with offset 2
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "5" is "EQUALS" to "4%" with offset 2

  @SID_5
  Scenario: Validate Num of attacks per IP
# Validate Num of attacks per IP
    Then UI Click Button "Events" with value "Top-Attacking-Geolocations"
    Then UI Validate Text field "TOTAL Country Events value" with params "0" EQUALS "192"
    Then UI Validate Text field "TOTAL Country Events value" with params "1" EQUALS "103"
    Then UI Validate Text field "TOTAL Country Events value" with params "3" EQUALS "96"
    Then UI Validate Text field "TOTAL Country Events value" with params "5" EQUALS "22"

  @SID_6
  Scenario: alidate Num of attacks per IP
#    Validate IP addresses correctness
    Then UI Text of "Country bar" with extension "0" equal to "Costa Rica"
    Then UI Text of "Country bar" with extension "1" equal to "Colombia"
    Then UI Text of "Country bar" with extension "2" equal to "Cuba"
    Then UI Text of "Country bar" with extension "3" equal to "Argentina"
    Then UI Text of "Country bar" with extension "4" equal to "United States"
    Then UI Text of "Country bar" with extension "5" equal to "Spain"

# validate values ordering
    Then UI Validate elements "TOTAL Country Events value" with params "" are sorting Descending by "Numerical"

  @SID_7
  Scenario: Validate Top Attacking Countries Widget - Packets
    Then UI Click Button "Packets" with value "Top-Attacking-Geolocations"
    #      check IP bar percentage value
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "0" is "EQUALS" to "100.00%"
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "1" is "EQUALS" to "51%" with offset 2
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "3" is "EQUALS" to "49%" with offset 2
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "4" is "EQUALS" to "28%" with offset 2
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "5" is "EQUALS" to "4%" with offset 2

  @SID_8
  Scenario: Validate Num of packets per IP
# Validate Num of packets per IP
    Then UI Validate Text field "TOTAL Country Events value" with params "0" EQUALS "47 K" with offset 2
    Then UI Validate Text field "TOTAL Country Events value" with params "2" EQUALS "23 K" with offset 2
    Then UI Validate Text field "TOTAL Country Events value" with params "4" EQUALS "13 K" with offset 2
    Then UI Validate Text field "TOTAL Country Events value" with params "5" EQUALS "2 K" with offset 2

  @SID_9
  Scenario: Validate IP addresses correctness
#    Validate IP addresses correctness
    Then UI Text of "Country bar" with extension "0" equal to "Costa Rica"
    Then UI Text of "Country bar" with extension "1" equal to "Colombia"
    Then UI Text of "Country bar" with extension "2" equal to "Cuba"
    Then UI Text of "Country bar" with extension "3" equal to "Argentina"
    Then UI Text of "Country bar" with extension "4" equal to "Mexico"
    Then UI Text of "Country bar" with extension "5" equal to "United States"

  # validate values ordering
    Then UI Validate elements "TOTAL Country Events value" with params "" are sorting Descending by "BIT_BYTE_UNITS"

  @SID_10
  Scenario: Validate Top Attacking Countries Widget - Volume

    Then UI Click Button "Volume" with value "Top-Attacking-Geolocations"
    #      check IP bar percentage value
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "0" is "EQUALS" to "100.00%"
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "1" is "EQUALS" to "52%" with offset 2
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "2" is "EQUALS" to "50%" with offset 2
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "3" is "EQUALS" to "49%" with offset 2
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "4" is "EQUALS" to "22%" with offset 2
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "5" is "EQUALS" to "5%" with offset 2

  @SID_11
  Scenario: Validate Volume amount per IP
# Validate Volume amount per IP
    Then UI Validate Text field "TOTAL Country Events value" with params "0" EQUALS "38 M" with offset 2
    Then UI Validate Text field "TOTAL Country Events value" with params "1" EQUALS "19 M" with offset 2
    Then UI Validate Text field "TOTAL Country Events value" with params "2" EQUALS "19 M" with offset 2
    Then UI Validate Text field "TOTAL Country Events value" with params "3" EQUALS "19 M" with offset 2
    Then UI Validate Text field "TOTAL Country Events value" with params "4" EQUALS "8 M" with offset 2
    Then UI Validate Text field "TOTAL Country Events value" with params "5" EQUALS "2 M" with offset 2

  @SID_12
  Scenario: Validate IP addresses correctness
#    Validate IP addresses correctness
    Then UI Text of "Country bar" with extension "0" equal to "Costa Rica"
    Then UI Text of "Country bar" with extension "1" equal to "Colombia"
    Then UI Text of "Country bar" with extension "2" equal to "Cuba"
    Then UI Text of "Country bar" with extension "3" equal to "Argentina"
    Then UI Text of "Country bar" with extension "4" equal to "Mexico"
    Then UI Text of "Country bar" with extension "5" equal to "United States"

  # validate values ordering
    Then UI Validate elements "TOTAL Country Events value" with params "" are sorting Descending by "BIT_BYTE_UNITS"

  @SID_13
  Scenario: Validate max amount of 6 Countries exists in Top Attacking Countries Widget
    Then UI Click Button "Events" with value "Top-Attacking-Geolocations"
    Then UI Validate Element Existence By Label "TOTAL Country Events value" if Exists "false" with value "6"
    Then UI Validate Element Existence By Label "Country bar" if Exists "false" with value "6"
    Then UI Click Button "Packets" with value "Top-Attacking-Geolocations"
    Then UI Validate Element Existence By Label "TOTAL Country Events value" if Exists "false" with value "6"
    Then UI Validate Element Existence By Label "Country bar" if Exists "false" with value "6"
    Then UI Click Button "Volume" with value "Top-Attacking-Geolocations"
    Then UI Validate Element Existence By Label "TOTAL Country Events value" if Exists "false" with value "6"
    Then UI Validate Element Existence By Label "Country bar" if Exists "false" with value "6"

  @SID_14
  Scenario: Validate IP filtering data correctness on Top Attacking Countries Widget
    Then UI Set Text Field "ipFilter" To "148.223.160.129" enter Key true
    #      check IP bar percentage value
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "0" is "EQUALS" to "100.00%"
    Then UI Validate Element Existence By Label "Country bar" if Exists "false" with value "1"

  @SID_15
  Scenario: Top Attacking Countries check values
# check values
    Then UI Validate Text field "TOTAL Country Events value" with params "0" EQUALS "387 K"
    Then UI Validate Element Existence By Label "TOTAL Country Events value" if Exists "false" with value "1"

  @SID_16
  Scenario: Top Attacking Countries Validate IP addresses correctness
#    Validate IP addresses correctness
    Then UI Text of "Country bar" with extension "0" equal to "Mexico"
    Then UI Validate Element Existence By Label "Country bar" if Exists "false" with value "1"

  @SID_17
  Scenario: Top Attacking Countries check Packets TAB
#check Packets TAB
    Then UI Click Button "Packets" with value "Top-Attacking-Geolocations"
    #      check IP bar percentage value
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "0" is "EQUALS" to "100.00%"
    Then UI Validate Element Existence By Label "Country bar" if Exists "false" with value "1"

  @SID_18
  Scenario: Top Attacking Countries check values
# check values
    Then UI Validate Text field "TOTAL Country Events value" with params "0" EQUALS "387"
    Then UI Validate Element Existence By Label "TOTAL Country Events value" if Exists "false" with value "1"

  @SID_19
  Scenario: Top Attacking Countries check values
#    Validate IP addresses correctness
    Then UI Text of "Country bar" with extension "0" equal to "Mexico"
    Then UI Validate Element Existence By Label "Country bar" if Exists "false" with value "1"

  @SID_20
  Scenario: Top Attacking Countries check Events TAB
#check Events TAB
    Then UI Click Button "Events" with value "Top-Attacking-Geolocations"
    #      check IP bar percentage value
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "0" is "EQUALS" to "100.00%"
    Then UI Validate Element Existence By Label "Country bar" if Exists "false" with value "8"

  @SID_21
  Scenario: Top Attacking Countries check values
# check values
    Then UI Validate Text field "TOTAL Country Events value" with params "0" EQUALS "6"
    Then UI Validate Element Existence By Label "TOTAL Country Events value" if Exists "false" with value "1"

  @SID_22
  Scenario: Top Attacking Countries Validate IP addresses correctness
#    Validate IP addresses correctness
    Then UI Text of "Country bar" with extension "0" equal to "Mexico"
    Then UI Validate Element Existence By Label "Country bar" if Exists "false" with value "1"

  @SID_23
  Scenario: Validate user selection lasts after page refresh on Top Attacking Countries Widget
    Then UI Click Button "Volume" with value "Top-Attacking-Geolocations"
    * Sleep "125"
    #      check IP bar percentage value
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "0" is "EQUALS" to "100.00%"
    Then UI Validate Element Existence By Label "Country bar" if Exists "false" with value "1"

  @SID_24
  Scenario: Validate user selection lasts after page refresh on Top Attacking Countries Widget -check values
# check values
    Then UI Validate Text field "TOTAL Country Events value" with params "0" EQUALS "387 K"
    Then UI Validate Element Existence By Label "TOTAL Country Events value" if Exists "false" with value "1"

#    Validate IP addresses correctness
    Then UI Text of "Country bar" with extension "0" equal to "Mexico"
    Then UI Validate Element Existence By Label "Country bar" if Exists "false" with value "1"

  @SID_25
  Scenario: Validate data correctness after clearing IP selection on Top Attacking Countries Widget
    Then UI clear 15 characters in "ipFilter"
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "0" is "EQUALS" to "100.00%"
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "1" is "EQUALS" to "52%" with offset 2
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "2" is "EQUALS" to "50%" with offset 2
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "3" is "EQUALS" to "49%" with offset 2
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "4" is "EQUALS" to "22%" with offset 2
    Then UI Validate the attribute "fill" Of Label "Country bar" With Params "5" is "EQUALS" to "5%" with offset 2

  @SID_26
  Scenario: Validate Volume amount per IP on Top Attacking Countries Widget
# Validate Volume amount per IP
    Then UI Validate Text field "TOTAL Country Events value" with params "0" EQUALS "38 M" with offset 2
    Then UI Validate Text field "TOTAL Country Events value" with params "1" EQUALS "19 M" with offset 2
    Then UI Validate Text field "TOTAL Country Events value" with params "2" EQUALS "19 M" with offset 2
    Then UI Validate Text field "TOTAL Country Events value" with params "3" EQUALS "19 M" with offset 2
    Then UI Validate Text field "TOTAL Country Events value" with params "4" EQUALS "8 M" with offset 2
    Then UI Validate Text field "TOTAL Country Events value" with params "5" EQUALS "2 M" with offset 2

  @SID_27
  Scenario: Validate Volume amount per IP on Top Attacking Countries Widget -Validate IP addresses correctness
#    Validate IP addresses correctness
    Then UI Text of "Country bar" with extension "0" equal to "Costa Rica"
    Then UI Text of "Country bar" with extension "1" equal to "Colombia"
    Then UI Text of "Country bar" with extension "2" equal to "Cuba"
    Then UI Text of "Country bar" with extension "3" equal to "Argentina"
    Then UI Text of "Country bar" with extension "4" equal to "Mexico"
    Then UI Text of "Country bar" with extension "5" equal to "United States"

  # validate values ordering
    Then UI Validate elements "TOTAL Country Events value" with params "" are sorting Descending by "BIT_BYTE_UNITS"

  @SID_28
  Scenario: Cleanup
#    Then UI Open "Configurations" Tab
    When UI Navigate to "VISION SETTINGS" page via homePage
    Then UI logout and close browser


