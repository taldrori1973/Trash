@TC108105
Feature: EAAF Widget - Top IP Statistics
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
  Scenario: Run DP simulator PCAPs for EAAF widgets
    * CLI simulate 1 attacks of type "IP_FEED_Modified" on "DefensePro" 10 and wait 150 seconds
  @SID_3
  Scenario: Login and navigate to EAAF dashboard
    * CLI Run remote linux Command "mysql -u root -prad123 vision_ng -e "update user_mgt set password='0R5nzwnMaxkeLEWhI+QahPWxssDjLbGH', password_expiration_date='2030-1-1' where name='radware';"" on "ROOT_SERVER_CLI"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
#    Given UI Login with user "sys_admin" and password "radware"
    Given UI Login with user "sys_admin" and password "radware"
#    When UI Open Upper Bar Item "EAAF Dashboard"
    When UI Navigate to "EAAF Dashboard" page via homePage
#this scenario verifies two things: Default selection of "Events" TAB and data correctness of that TAB
  @SID_4
  Scenario: Validate Top Malicious IP Addresses Widget - Events
#      check IP bar percentage value
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "0" is "EQUALS" to "100.00%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "3" is "EQUALS" to "54.17%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "6" is "EQUALS" to "37.50%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "9" is "EQUALS" to "25.00%"
  @SID_5
  Scenario: Validate Num of attacks per IP
# Validate Num of attacks per IP
    Then UI Click Button "Events" with value "Top-Malicious-IP-Addresses"
    Then UI Validate Text field "TOTAL IP Events value" with params "0" EQUALS "24"
    Then UI Validate Text field "TOTAL IP Events value" with params "2" EQUALS "14"
    Then UI Validate Text field "TOTAL IP Events value" with params "5" EQUALS "10"
    Then UI Validate Text field "TOTAL IP Events value" with params "9" EQUALS "6"
  @SID_6
  Scenario: Validate IP addresses correctness
#    Validate IP addresses correctness
    Then UI Text of "top ip value" with extension "0" equal to "172.217.186.137"
    Then UI Text of "top ip value" with extension "1" equal to "130.206.245.152"
    Then UI Text of "top ip value" with extension "2" equal to "138.121.200.174"
    Then UI Text of "top ip value" with extension "3" equal to "128.201.145.148"
    Then UI Text of "top ip value" with extension "4" equal to "185.185.124.174"
    Then UI Text of "top ip value" with extension "5" equal to "253.245.116.150"
    Then UI Text of "top ip value" with extension "6" equal to "146.112.230.157"
    Then UI Text of "top ip value" with extension "7" equal to "185.133.124.156"
    Then UI Text of "top ip value" with extension "8" equal to "170.247.140.174"
    Then UI Text of "top ip value" with extension "9" equal to "148.223.160.129"
  @SID_7
  Scenario: validate values ordering
# validate values ordering
    Then UI Validate elements "TOTAL IP Events value" with params "" are sorting Descending by "Numerical"
  @SID_8
  Scenario: Validate Top Malicious IP Addresses Widget - Packets
    Then UI Click Button "Packets" with value "Top-Malicious-IP-Addresses"
  @SID_9
  Scenario: check IP bar percentage value
    #      check IP bar percentage value
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "0" is "EQUALS" to "100.00%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "1" is "EQUALS" to "99.99%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "3" is "EQUALS" to "99.97%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "9" is "EQUALS" to "5.82%"
  @SID_10
  Scenario: Validate Num of packets per IP
# Validate Num of packets per IP
    Then UI Validate Text field "TOTAL IP Events value" with params "0" EQUALS "11.82 K"
    Then UI Validate Text field "TOTAL IP Events value" with params "2" EQUALS "11.82 K"
    Then UI Validate Text field "TOTAL IP Events value" with params "5" EQUALS "11.82 K"
    Then UI Validate Text field "TOTAL IP Events value" with params "6" EQUALS "1.33 K"
    Then UI Validate Text field "TOTAL IP Events value" with params "7" EQUALS "1.12 K"
    Then UI Validate Text field "TOTAL IP Events value" with params "8" EQUALS "989"
    Then UI Validate Text field "TOTAL IP Events value" with params "9" EQUALS "688"


#    Then UI Validate Text field "top ip value" with params "0" MatchRegex "128.201.145.148|130.206.245.152|138.121.200.174"
  @SID_11
  Scenario: Validate IP addresses correctness
#    Validate IP addresses correctness
    Then UI Text of "top ip value" with extension "0" equal to "128.201.145.123"
    Then UI Text of "top ip value" with extension "1" equal to "148.223.160.123"
    Then UI Text of "top ip value" with extension "2" equal to "138.121.200.123"
    Then UI Text of "top ip value" with extension "3" equal to "128.201.144.123"
    Then UI Text of "top ip value" with extension "4" equal to "170.247.140.123"
    Then UI Text of "top ip value" with extension "5" equal to "185.185.124.123"
    Then UI Text of "top ip value" with extension "6" equal to "138.121.200.174"
    Then UI Text of "top ip value" with extension "7" equal to "172.217.186.137"
    Then UI Text of "top ip value" with extension "8" equal to "130.206.245.152"
    Then UI Text of "top ip value" with extension "9" equal to "128.201.145.148"
  @SID_12
  Scenario: validate values ordering
# validate values ordering
    Then UI Validate elements "TOTAL IP Events value" with params "" are sorting Descending by "BIT_BYTE_UNITS"
  @SID_13
  Scenario: Validate Top Malicious IP Addresses Widget - Volume

    Then UI Click Button "Volume" with value "Top-Malicious-IP-Addresses"
    #      check IP bar percentage value
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "0" is "EQUALS" to "100.00%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "1" is "EQUALS" to "99.99%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "3" is "EQUALS" to "99.97%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "4" is "EQUALS" to "99.96%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "7" is "EQUALS" to "15.41%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "9" is "EQUALS" to "9.48%"
  @SID_14
  Scenario: Validate Volume amount per IP
# Validate Volume amount per IP
    Then UI Validate Text field "TOTAL IP Events value" with params "0" EQUALS "7.26 M"
    Then UI Validate Text field "TOTAL IP Events value" with params "2" EQUALS "7.26 M"
    Then UI Validate Text field "TOTAL IP Events value" with params "5" EQUALS "7.25 M"
    Then UI Validate Text field "TOTAL IP Events value" with params "6" EQUALS "1.33 M"
    Then UI Validate Text field "TOTAL IP Events value" with params "7" EQUALS "1.12 M"
    Then UI Validate Text field "TOTAL IP Events value" with params "8" EQUALS "989 K"
    Then UI Validate Text field "TOTAL IP Events value" with params "9" EQUALS "688 K"
  @SID_15
  Scenario: Validate IP addresses correctness
#    Validate IP addresses correctness
    Then UI Text of "top ip value" with extension "0" equal to "128.201.145.123"
    Then UI Text of "top ip value" with extension "1" equal to "148.223.160.123"
    Then UI Text of "top ip value" with extension "6" equal to "138.121.200.174"
    Then UI Text of "top ip value" with extension "7" equal to "172.217.186.137"
    Then UI Text of "top ip value" with extension "8" equal to "130.206.245.152"
    Then UI Text of "top ip value" with extension "9" equal to "128.201.145.148"

# validate values ordering
    Then UI Validate elements "TOTAL IP Events value" with params "" are sorting Descending by "BIT_BYTE_UNITS"
  @SID_16
  Scenario: validate max amount of 10 IP's exists in Top Malicious IP Addresses Widget
    Then UI Click Button "Events" with value "Top-Malicious-IP-Addresses"
    Then UI Validate Element Existence By Label "TOTAL IP Events value" if Exists "false" with value "10"
    Then UI Validate Element Existence By Label "Top IP Address bar" if Exists "false" with value "10"
    Then UI Validate Element Existence By Label "top ip value" if Exists "false" with value "10"
    Then UI Click Button "Packets" with value "Top-Malicious-IP-Addresses"
    Then UI Validate Element Existence By Label "TOTAL IP Events value" if Exists "false" with value "10"
    Then UI Validate Element Existence By Label "Top IP Address bar" if Exists "false" with value "10"
    Then UI Validate Element Existence By Label "top ip value" if Exists "false" with value "10"
    Then UI Click Button "Volume" with value "Top-Malicious-IP-Addresses"
    Then UI Validate Element Existence By Label "TOTAL IP Events value" if Exists "false" with value "10"
    Then UI Validate Element Existence By Label "Top IP Address bar" if Exists "false" with value "10"
    Then UI Validate Element Existence By Label "top ip value" if Exists "false" with value "10"

  @SID_17
  Scenario: Validate IP filtering data correctness on Top Malicious IP Addresses Widget
    Then UI Set Text Field "ipFilter" To "148.223.160.129" enter Key true
    #      check IP bar percentage value
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "0" is "EQUALS" to "100.00%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "1" is "EQUALS" to "99.99%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "2" is "EQUALS" to "99.97%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "3" is "EQUALS" to "99.97%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "4" is "EQUALS" to "99.96%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "5" is "EQUALS" to "99.96%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "6" is "EQUALS" to "18.33%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "7" is "EQUALS" to "15.41%"
    Then UI Validate Element Existence By Label "Top IP Address bar" if Exists "false" with value "8"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "9" is "EQUALS" to "5.33%"
  @SID_18
  Scenario: Validate IP filtering data correctness check values
# check values
    Then UI Validate Text field "TOTAL IP Events value" with params "0" EQUALS "7.26 M"
    Then UI Validate Text field "TOTAL IP Events value" with params "2" EQUALS "7.26 M"
    Then UI Validate Text field "TOTAL IP Events value" with params "5" EQUALS "7.25 M"
    Then UI Validate Text field "TOTAL IP Events value" with params "6" EQUALS "1.33 M"
    Then UI Validate Text field "TOTAL IP Events value" with params "7" EQUALS "1.12 M"
    Then UI Validate Element Existence By Label "TOTAL IP Events value" if Exists "false" with value "8"
    Then UI Validate Text field "TOTAL IP Events value" with params "9" EQUALS "387"
  @SID_19
  Scenario: Validate IP addresses correctness
#    Validate IP addresses correctness
    Then UI Text of "top ip value" with extension "0" equal to "128.201.145.123"
    Then UI Text of "top ip value" with extension "1" equal to "148.223.160.123"
    Then UI Text of "top ip value" with extension "6" equal to "138.121.200.174"
    Then UI Text of "top ip value" with extension "7" equal to "172.217.186.137"
    Then UI Text of "top ip value" with extension "9" equal to "148.223.160.129"
    Then UI Validate Element Existence By Label "top ip value" if Exists "false" with value "10"
    Then UI Validate elements "TOTAL IP Events value" with params "" are sorting Descending by "BIT_BYTE_UNITS"
  @SID_20
  Scenario: check IP bar percentage value
#check Packets TAB
    Then UI Click Button "Packets" with value "Top-Malicious-IP-Addresses"
    #      check IP bar percentage value
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "0" is "EQUALS" to "100.00%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "1" is "EQUALS" to "99.99%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "2" is "EQUALS" to "99.97%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "3" is "EQUALS" to "99.97%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "4" is "EQUALS" to "99.96%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "5" is "EQUALS" to "99.96%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "6" is "EQUALS" to "18.33%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "7" is "EQUALS" to "15.41%"
    Then UI Validate Element Existence By Label "Top IP Address bar" if Exists "false" with value "8"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "9" is "EQUALS" to "5.33%"
  @SID_21
  Scenario: Check values
# check values
    Then UI Validate Text field "TOTAL IP Events value" with params "0" EQUALS "11.82 K"
    Then UI Validate Text field "TOTAL IP Events value" with params "2" EQUALS "11.82 K"
    Then UI Validate Text field "TOTAL IP Events value" with params "5" EQUALS "11.82 K"
    Then UI Validate Text field "TOTAL IP Events value" with params "6" EQUALS "1.33 K"
    Then UI Validate Text field "TOTAL IP Events value" with params "7" EQUALS "1.12 K"
    Then UI Validate Element Existence By Label "TOTAL IP Events value" if Exists "false" with value "8"
    Then UI Validate Text field "TOTAL IP Events value" with params "9" EQUALS "387"
  @SID_22
  Scenario: Validate IP addresses correctness
#    Validate IP addresses correctness
    Then UI Text of "top ip value" with extension "0" equal to "128.201.145.123"
    Then UI Text of "top ip value" with extension "1" equal to "148.223.160.123"
    Then UI Text of "top ip value" with extension "6" equal to "138.121.200.174"
    Then UI Text of "top ip value" with extension "7" equal to "172.217.186.137"
    Then UI Text of "top ip value" with extension "9" equal to "148.223.160.129"

    Then UI Validate elements "TOTAL IP Events value" with params "" are sorting Descending by "BIT_BYTE_UNITS"
  @SID_23
  Scenario: check IP bar percentage value
#check Events TAB
    Then UI Click Button "Events" with value "Top-Malicious-IP-Addresses"
    #      check IP bar percentage value
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "0" is "EQUALS" to "100.00%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "1" is "EQUALS" to "87.50%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "2" is "EQUALS" to "58.33%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "3" is "EQUALS" to "54.17%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "4" is "EQUALS" to "50.00%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "5" is "EQUALS" to "41.67%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "6" is "EQUALS" to "37.50%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "7" is "EQUALS" to "33.33%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "9" is "EQUALS" to "25.00%"
  @SID_24
  Scenario: check values
# check values
    Then UI Validate Text field "TOTAL IP Events value" with params "0" EQUALS "24"
    Then UI Validate Text field "TOTAL IP Events value" with params "2" EQUALS "14"
    Then UI Validate Text field "TOTAL IP Events value" with params "5" EQUALS "10"
    Then UI Validate Text field "TOTAL IP Events value" with params "6" EQUALS "9"
    Then UI Validate Text field "TOTAL IP Events value" with params "7" EQUALS "8"
    Then UI Validate Text field "TOTAL IP Events value" with params "8" EQUALS "7"
    Then UI Validate Text field "TOTAL IP Events value" with params "9" EQUALS "6"
  @SID_25
  Scenario: Validate IP addresses correctness
#    Validate IP addresses correctness
    Then UI Text of "top ip value" with extension "0" equal to "172.217.186.137"
    Then UI Text of "top ip value" with extension "1" equal to "130.206.245.152"
    Then UI Text of "top ip value" with extension "6" equal to "146.112.230.157"
    Then UI Text of "top ip value" with extension "7" equal to "185.133.124.156"
    Then UI Text of "top ip value" with extension "9" equal to "148.223.160.129"
    Then UI Validate Element Existence By Label "top ip value" if Exists "false" with value "10"
    Then UI Validate elements "TOTAL IP Events value" with params "" are sorting Descending by "Numerical"
  @SID_26
  Scenario: Validate user selection lasts after page refresh on Top Malicious IP Addresses Widget
    Then UI Click Button "Volume" with value "Top-Malicious-IP-Addresses"
    * Sleep "125"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "0" is "EQUALS" to "100.00%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "1" is "EQUALS" to "99.99%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "2" is "EQUALS" to "99.97%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "3" is "EQUALS" to "99.97%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "4" is "EQUALS" to "99.96%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "5" is "EQUALS" to "99.96%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "6" is "EQUALS" to "18.33%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "7" is "EQUALS" to "15.41%"
    Then UI Validate Element Existence By Label "Top IP Address bar" if Exists "false" with value "8"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "9" is "EQUALS" to "5.33%"
  @SID_27
  Scenario: check values
# check values
    Then UI Validate Text field "TOTAL IP Events value" with params "0" EQUALS "7.26 M"
    Then UI Validate Text field "TOTAL IP Events value" with params "2" EQUALS "7.26 M"
    Then UI Validate Text field "TOTAL IP Events value" with params "5" EQUALS "7.25 M"
    Then UI Validate Text field "TOTAL IP Events value" with params "6" EQUALS "1.33 M"
    Then UI Validate Text field "TOTAL IP Events value" with params "7" EQUALS "1.12 M"
    Then UI Validate Element Existence By Label "TOTAL IP Events value" if Exists "false" with value "8"
    Then UI Validate Text field "TOTAL IP Events value" with params "9" EQUALS "387"
  @SID_28
  Scenario: Validate IP addresses correctness
#    Validate IP addresses correctness
    Then UI Text of "top ip value" with extension "0" equal to "128.201.145.123"
    Then UI Text of "top ip value" with extension "1" equal to "148.223.160.123"
    Then UI Text of "top ip value" with extension "6" equal to "138.121.200.174"
    Then UI Text of "top ip value" with extension "7" equal to "172.217.186.137"
    Then UI Text of "top ip value" with extension "9" equal to "148.223.160.129"
    Then UI Validate Element Existence By Label "top ip value" if Exists "false" with value "10"
    Then UI Validate elements "TOTAL IP Events value" with params "" are sorting Descending by "BIT_BYTE_UNITS"
  @SID_29
  Scenario: Validate data correctness after clearing IP selection on Top Malicious IP Addresses Widget
    Then UI Click Button "ipFilter clear"
    #      check IP bar percentage value
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "0" is "EQUALS" to "100.00%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "1" is "EQUALS" to "99.99%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "3" is "EQUALS" to "99.97%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "4" is "EQUALS" to "99.96%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "7" is "EQUALS" to "15.41%"
    Then UI Validate the attribute "fill" Of Label "Top IP Address bar" With Params "9" is "EQUALS" to "9.48%"
  @SID_30
  Scenario: Validate Volume amount per IP
# Validate Volume amount per IP
    Then UI Validate Text field "TOTAL IP Events value" with params "0" EQUALS "7.26 M"
    Then UI Validate Text field "TOTAL IP Events value" with params "2" EQUALS "7.26 M"
    Then UI Validate Text field "TOTAL IP Events value" with params "5" EQUALS "7.25 M"
    Then UI Validate Text field "TOTAL IP Events value" with params "6" EQUALS "1.33 M"
    Then UI Validate Text field "TOTAL IP Events value" with params "7" EQUALS "1.12 M"
    Then UI Validate Text field "TOTAL IP Events value" with params "8" EQUALS "989 K"
    Then UI Validate Text field "TOTAL IP Events value" with params "9" EQUALS "688 K"
  @SID_31
  Scenario: Validate IP addresses correctness
#    Validate IP addresses correctness
    Then UI Text of "top ip value" with extension "0" equal to "128.201.145.123"
    Then UI Text of "top ip value" with extension "1" equal to "148.223.160.123"
    Then UI Text of "top ip value" with extension "6" equal to "138.121.200.174"
    Then UI Text of "top ip value" with extension "7" equal to "172.217.186.137"
    Then UI Text of "top ip value" with extension "8" equal to "130.206.245.152"
    Then UI Text of "top ip value" with extension "9" equal to "128.201.145.148"

# validate values ordering
    Then UI Validate elements "TOTAL IP Events value" with params "" are sorting Descending by "BIT_BYTE_UNITS"
  @SID_32
  Scenario: Cleanup
#    Then UI Open "Configurations" Tab
    When UI Navigate to "VISION SETTINGS" page via homePage
    Then UI logout and close browser
