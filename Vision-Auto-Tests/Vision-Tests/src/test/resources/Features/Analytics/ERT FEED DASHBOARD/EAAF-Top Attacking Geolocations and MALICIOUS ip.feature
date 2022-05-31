@TC126827
Feature:EAAF-Top Attacking Geolocations and MALICIOUS ip

  @SID_1
  Scenario: Login and navigate to EAAF dashboard and Clean system attacks
    Then Play File "empty_file.xmf" in device "50.50.100.1" from map "Automation_Machines" and wait 20 seconds
    * REST Delete ES index "eaaf-attack-*"
    * REST Delete ES index "attack-*"
    * CLI Clear vision logs
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"

  @SID_2
  Scenario: PLAY DP_sim_8.28 file and Navigate EAAF DashBoard
    Given Play File "DP_sim_8.28.xmf" in device "50.50.100.1" from map "Automation_Machines" and wait 20 seconds
    Then Sleep "300"
    And UI Navigate to "EAAF Dashboard" page via homePage
    Then Play File "empty_file.xmf" in device "50.50.100.1" from map "Automation_Machines" and wait 20 seconds



  @SID_3

  Scenario: validate top attacking geolocations packets
    Then UI VRM Select device from dashboard and Save Filter
      | setId     | ports | policies |
      | DP_Sim_Set_0 |       |          |
    Then UI Click Button "Geolocations tabs" with value "Packets"
    Then UI Validate Text field "Country Name" with params "India" EQUALS "India"
    Then UI Validate Text field "Total Events Value" with params "0" EQUALS "287"

    Then UI Validate Text field "Country Name" with params "Sweden" EQUALS "Sweden"
    Then UI Validate Text field "Total Events Value" with params "1" EQUALS "287"

    Then UI Validate Text field "Country Name" with params "Vietnam" EQUALS "Vietnam"
    Then UI Validate Text field "Total Events Value" with params "2" EQUALS "287"

    Then UI Validate Text field "Country Name" with params "China" EQUALS "China"
    Then UI Validate Text field "Total Events Value" with params "3" EQUALS "286"

    Then UI Validate Text field "Country Name" with params "United States" EQUALS "United States"
    Then UI Validate Text field "Total Events Value" with params "4" EQUALS "144"

    Then UI Validate Text field "Country Name" with params "Lithuania" EQUALS "Lithuania"
    Then UI Validate Text field "Total Events Value" with params "5" EQUALS "143"

    Then UI Validate Text field "Country Name" with params "Mexico" EQUALS "Mexico"
    Then UI Validate Text field "Total Events Value" with params "6" EQUALS "143"

    Then UI Validate Text field "Country Name" with params "Paraguay" EQUALS "Paraguay"
    Then UI Validate Text field "Total Events Value" with params "7" EQUALS "143"

    Then UI Validate Text field "Country Name" with params "Singapore" EQUALS "Singapore"
    Then UI Validate Text field "Total Events Value" with params "8" EQUALS "143"

  @SID_4
  Scenario: validate top attacking geolocations Attacks

    Then UI Click Button "Geolocations tabs" with value "Attacks"
    Then UI Validate Text field "Country Name" with params "India" EQUALS "India"
    Then UI Validate Text field "Total Events Value" with params "0" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "Sweden" EQUALS "Sweden"
    Then UI Validate Text field "Total Events Value" with params "1" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "Vietnam" EQUALS "Vietnam"
    Then UI Validate Text field "Total Events Value" with params "2" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "China" EQUALS "China"
    Then UI Validate Text field "Total Events Value" with params "3" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "United States" EQUALS "United States"
    Then UI Validate Text field "Total Events Value" with params "4" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "Lithuania" EQUALS "Lithuania"
    Then UI Validate Text field "Total Events Value" with params "5" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "Mexico" EQUALS "Mexico"
    Then UI Validate Text field "Total Events Value" with params "6" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "Paraguay" EQUALS "Paraguay"
    Then UI Validate Text field "Total Events Value" with params "7" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "Singapore" EQUALS "Singapore"
    Then UI Validate Text field "Total Events Value" with params "8" EQUALS "1"

  @SID_5
  Scenario: validate top attacking geolocations volume
    Then UI Click Button "Geolocations tabs" with value "Volume"
    Then UI Validate Text field "Country Name" with params "India" EQUALS "India"
    Then UI Validate Text field "Total Events Value" with params "0" EQUALS "284K"

    Then UI Validate Text field "Country Name" with params "Sweden" EQUALS "Sweden"
    Then UI Validate Text field "Total Events Value" with params "1" EQUALS "284K"

    Then UI Validate Text field "Country Name" with params "Vietnam" EQUALS "Vietnam"
    Then UI Validate Text field "Total Events Value" with params "2" EQUALS "284K"

    Then UI Validate Text field "Country Name" with params "China" EQUALS "China"
    Then UI Validate Text field "Total Events Value" with params "3" EQUALS "283K"

    Then UI Validate Text field "Country Name" with params "United States" EQUALS "United States"
    Then UI Validate Text field "Total Events Value" with params "4" EQUALS "142K"

    Then UI Validate Text field "Country Name" with params "Lithuania" EQUALS "Lithuania"
    Then UI Validate Text field "Total Events Value" with params "5" EQUALS "141K"

    Then UI Validate Text field "Country Name" with params "Mexico" EQUALS "Mexico"
    Then UI Validate Text field "Total Events Value" with params "6" EQUALS "141K"

    Then UI Validate Text field "Country Name" with params "Paraguay" EQUALS "Paraguay"
    Then UI Validate Text field "Total Events Value" with params "7" EQUALS "141K"

    Then UI Validate Text field "Country Name" with params "Singapore" EQUALS "Singapore"
    Then UI Validate Text field "Total Events Value" with params "8" EQUALS "141K"


    #########################################################################################################
  ##################################### TOP MALICIOUS IP ADDRESSES WIDGET #####################################



  @SID_6
  Scenario: validate  TOP MALICIOUS IP ADDRESSES packets
    Then UI Click Button "Malicious tabs" with value "Packets"

    Then UI Validate Text field "Country Code Malicious" with params "113.172.213.32" EQUALS "113.172.213.32"
    Then UI Validate Text field "Total Events Value Malicious" with params "0" EQUALS "287"

    Then UI Validate Text field "Country Code Malicious" with params "120.138.13.189" EQUALS "120.138.13.189"
    Then UI Validate Text field "Total Events Value Malicious" with params "1" EQUALS "287"

    Then UI Validate Text field "Country Code Malicious" with params "178.73.215.171" EQUALS "178.73.215.171"
    Then UI Validate Text field "Total Events Value Malicious" with params "2" EQUALS "287"

    Then UI Validate Text field "Country Code Malicious" with params "125.64.94.138" EQUALS "125.64.94.138"
    Then UI Validate Text field "Total Events Value Malicious" with params "3" EQUALS "286"

    Then UI Validate Text field "Country Code Malicious" with params "128.1.248.26" EQUALS "128.1.248.26"
    Then UI Validate Text field "Total Events Value Malicious" with params "4" EQUALS "144"

    Then UI Validate Text field "Country Code Malicious" with params "104.28.113.201" EQUALS "104.28.113.201"
    Then UI Validate Text field "Total Events Value Malicious" with params "5" EQUALS "143"

    Then UI Validate Text field "Country Code Malicious" with params "141.98.9.21" EQUALS "141.98.9.21"
    Then UI Validate Text field "Total Events Value Malicious" with params "6" EQUALS "143"

    Then UI Validate Text field "Country Code Malicious" with params "167.71.201.112" EQUALS "167.71.201.112"
    Then UI Validate Text field "Total Events Value Malicious" with params "7" EQUALS "143"

    Then UI Validate Text field "Country Code Malicious" with params "178.17.174.10" EQUALS "178.17.174.10"
    Then UI Validate Text field "Total Events Value Malicious" with params "8" EQUALS "143"

    Then UI Validate Text field "Country Code Malicious" with params "189.203.104.55" EQUALS "189.203.104.55"
    Then UI Validate Text field "Total Events Value Malicious" with params "9" EQUALS "143"

  @SID_7
  Scenario: validate TOP MALICIOUS IP ADDRESSES Attacks
    Then UI Click Button "Malicious tabs" with value "Attacks"

    Then UI Validate Text field "Country Code Malicious" with params "113.172.213.32" EQUALS "113.172.213.32"
    Then UI Validate Text field "Total Events Value Malicious" with params "0" EQUALS "1"

    Then UI Validate Text field "Country Code Malicious" with params "120.138.13.189" EQUALS "120.138.13.189"
    Then UI Validate Text field "Total Events Value Malicious" with params "1" EQUALS "1"

    Then UI Validate Text field "Country Code Malicious" with params "178.73.215.171" EQUALS "178.73.215.171"
    Then UI Validate Text field "Total Events Value Malicious" with params "2" EQUALS "1"

    Then UI Validate Text field "Country Code Malicious" with params "125.64.94.138" EQUALS "125.64.94.138"
    Then UI Validate Text field "Total Events Value Malicious" with params "3" EQUALS "1"

    Then UI Validate Text field "Country Code Malicious" with params "128.1.248.26" EQUALS "128.1.248.26"
    Then UI Validate Text field "Total Events Value Malicious" with params "4" EQUALS "1"

    Then UI Validate Text field "Country Code Malicious" with params "104.28.113.201" EQUALS "104.28.113.201"
    Then UI Validate Text field "Total Events Value Malicious" with params "5" EQUALS "1"

    Then UI Validate Text field "Country Code Malicious" with params "141.98.9.21" EQUALS "141.98.9.21"
    Then UI Validate Text field "Total Events Value Malicious" with params "6" EQUALS "1"

    Then UI Validate Text field "Country Code Malicious" with params "167.71.201.112" EQUALS "167.71.201.112"
    Then UI Validate Text field "Total Events Value Malicious" with params "7" EQUALS "1"

    Then UI Validate Text field "Country Code Malicious" with params "178.17.174.10" EQUALS "178.17.174.10"
    Then UI Validate Text field "Total Events Value Malicious" with params "8" EQUALS "1"

    Then UI Validate Text field "Country Code Malicious" with params "189.203.104.55" EQUALS "189.203.104.55"
    Then UI Validate Text field "Total Events Value Malicious" with params "9" EQUALS "1"

  @SID_8
  Scenario: validate TOP MALICIOUS IP ADDRESSES volume
    Then UI Click Button "Malicious tabs" with value "Volume"

    Then UI Validate Text field "Country Code Malicious" with params "113.172.213.32" EQUALS "113.172.213.32"
    Then UI Validate Text field "Total Events Value Malicious" with params "0" EQUALS "284K"

    Then UI Validate Text field "Country Code Malicious" with params "120.138.13.189" EQUALS "120.138.13.189"
    Then UI Validate Text field "Total Events Value Malicious" with params "1" EQUALS "284K"

    Then UI Validate Text field "Country Code Malicious" with params "178.73.215.171" EQUALS "178.73.215.171"
    Then UI Validate Text field "Total Events Value Malicious" with params "2" EQUALS "284K"

    Then UI Validate Text field "Country Code Malicious" with params "125.64.94.138" EQUALS "125.64.94.138"
    Then UI Validate Text field "Total Events Value Malicious" with params "3" EQUALS "283K"

    Then UI Validate Text field "Country Code Malicious" with params "128.1.248.26" EQUALS "128.1.248.26"
    Then UI Validate Text field "Total Events Value Malicious" with params "4" EQUALS "142K"

    Then UI Validate Text field "Country Code Malicious" with params "104.28.113.201" EQUALS "104.28.113.201"
    Then UI Validate Text field "Total Events Value Malicious" with params "5" EQUALS "141K"

    Then UI Validate Text field "Country Code Malicious" with params "141.98.9.21" EQUALS "141.98.9.21"
    Then UI Validate Text field "Total Events Value Malicious" with params "6" EQUALS "141K"

    Then UI Validate Text field "Country Code Malicious" with params "167.71.201.112" EQUALS "167.71.201.112"
    Then UI Validate Text field "Total Events Value Malicious" with params "7" EQUALS "141K"

    Then UI Validate Text field "Country Code Malicious" with params "178.17.174.10" EQUALS "178.17.174.10"
    Then UI Validate Text field "Total Events Value Malicious" with params "8" EQUALS "141K"

    Then UI Validate Text field "Country Code Malicious" with params "189.203.104.55" EQUALS "189.203.104.55"
    Then UI Validate Text field "Total Events Value Malicious" with params "9" EQUALS "141K"

####################################data not changing with Pcap##################################
  @SID_9
  Scenario: validate that the data not change with pcap
    Then UI Navigate to "AMS Reports" page via homePage
    Given CLI simulate 1000 attacks of type "ERT_FEED" on SetId "DefensePro_Set_13" with loopDelay 15000 and wait 120 seconds

    Given CLI kill all simulator attacks on current vision
    Then UI Navigate to "EAAF Dashboard" page via homePage


  @SID_12
  Scenario: validate top attacking geolocations packets
    Then UI VRM Select device from dashboard and Save Filter
      | setId        | ports | policies |
      | DP_Sim_Set_0 |       |          |
    Then UI Click Button "Geolocations tabs" with value "Packets"

    Then UI Validate Text field "Country Name" with params "India" EQUALS "India"
    Then UI Validate Text field "Total Events Value" with params "0" EQUALS "287"

    Then UI Validate Text field "Country Name" with params "Sweden" EQUALS "Sweden"
    Then UI Validate Text field "Total Events Value" with params "1" EQUALS "287"

    Then UI Validate Text field "Country Name" with params "Vietnam" EQUALS "Vietnam"
    Then UI Validate Text field "Total Events Value" with params "2" EQUALS "287"

    Then UI Validate Text field "Country Name" with params "China" EQUALS "China"
    Then UI Validate Text field "Total Events Value" with params "3" EQUALS "286"

    Then UI Validate Text field "Country Name" with params "United States" EQUALS "United States"
    Then UI Validate Text field "Total Events Value" with params "4" EQUALS "144"

    Then UI Validate Text field "Country Name" with params "Lithuania" EQUALS "Lithuania"
    Then UI Validate Text field "Total Events Value" with params "5" EQUALS "143"

    Then UI Validate Text field "Country Name" with params "Mexico" EQUALS "Mexico"
    Then UI Validate Text field "Total Events Value" with params "6" EQUALS "143"

    Then UI Validate Text field "Country Name" with params "Paraguay" EQUALS "Paraguay"
    Then UI Validate Text field "Total Events Value" with params "7" EQUALS "143"

    Then UI Validate Text field "Country Name" with params "Singapore" EQUALS "Singapore"
    Then UI Validate Text field "Total Events Value" with params "8" EQUALS "143"

  @SID_13
  Scenario: validate top attacking geolocations Attacks

    Then UI Click Button "Geolocations tabs" with value "Attacks"
    Then UI Validate Text field "Country Name" with params "India" EQUALS "India"
    Then UI Validate Text field "Total Events Value" with params "0" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "Sweden" EQUALS "Sweden"
    Then UI Validate Text field "Total Events Value" with params "1" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "Vietnam" EQUALS "Vietnam"
    Then UI Validate Text field "Total Events Value" with params "2" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "China" EQUALS "China"
    Then UI Validate Text field "Total Events Value" with params "3" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "United States" EQUALS "United States"
    Then UI Validate Text field "Total Events Value" with params "4" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "Lithuania" EQUALS "Lithuania"
    Then UI Validate Text field "Total Events Value" with params "5" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "Mexico" EQUALS "Mexico"
    Then UI Validate Text field "Total Events Value" with params "6" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "Paraguay" EQUALS "Paraguay"
    Then UI Validate Text field "Total Events Value" with params "7" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "Singapore" EQUALS "Singapore"
    Then UI Validate Text field "Total Events Value" with params "8" EQUALS "1"

  @SID_14
  Scenario: validate top attacking geolocations volume
    Then UI Click Button "Geolocations tabs" with value "Volume"
    Then UI Validate Text field "Country Name" with params "India" EQUALS "India"
    Then UI Validate Text field "Total Events Value" with params "0" EQUALS "284K"

    Then UI Validate Text field "Country Name" with params "Sweden" EQUALS "Sweden"
    Then UI Validate Text field "Total Events Value" with params "1" EQUALS "284K"

    Then UI Validate Text field "Country Name" with params "Vietnam" EQUALS "Vietnam"
    Then UI Validate Text field "Total Events Value" with params "2" EQUALS "284K"

    Then UI Validate Text field "Country Name" with params "China" EQUALS "China"
    Then UI Validate Text field "Total Events Value" with params "3" EQUALS "283K"

    Then UI Validate Text field "Country Name" with params "United States" EQUALS "United States"
    Then UI Validate Text field "Total Events Value" with params "4" EQUALS "142K"

    Then UI Validate Text field "Country Name" with params "Lithuania" EQUALS "Lithuania"
    Then UI Validate Text field "Total Events Value" with params "5" EQUALS "141K"

    Then UI Validate Text field "Country Name" with params "Mexico" EQUALS "Mexico"
    Then UI Validate Text field "Total Events Value" with params "6" EQUALS "141K"

    Then UI Validate Text field "Country Name" with params "Paraguay" EQUALS "Paraguay"
    Then UI Validate Text field "Total Events Value" with params "7" EQUALS "141K"

    Then UI Validate Text field "Country Name" with params "Singapore" EQUALS "Singapore"
    Then UI Validate Text field "Total Events Value" with params "8" EQUALS "141K"


    #########################################################################################################
  ##################################### TOP MALICIOUS IP ADDRESSES WIDGET #####################################



  @SID_15
  Scenario: validate  TOP MALICIOUS IP ADDRESSES packets
    Then UI Click Button "Malicious tabs" with value "Packets"

    Then UI Validate Text field "Country Code Malicious" with params "113.172.213.32" EQUALS "113.172.213.32"
    Then UI Validate Text field "Total Events Value Malicious" with params "0" EQUALS "287"

    Then UI Validate Text field "Country Code Malicious" with params "120.138.13.189" EQUALS "120.138.13.189"
    Then UI Validate Text field "Total Events Value Malicious" with params "1" EQUALS "287"

    Then UI Validate Text field "Country Code Malicious" with params "178.73.215.171" EQUALS "178.73.215.171"
    Then UI Validate Text field "Total Events Value Malicious" with params "2" EQUALS "287"

    Then UI Validate Text field "Country Code Malicious" with params "125.64.94.138" EQUALS "125.64.94.138"
    Then UI Validate Text field "Total Events Value Malicious" with params "3" EQUALS "286"

    Then UI Validate Text field "Country Code Malicious" with params "128.1.248.26" EQUALS "128.1.248.26"
    Then UI Validate Text field "Total Events Value Malicious" with params "4" EQUALS "144"

    Then UI Validate Text field "Country Code Malicious" with params "104.28.113.201" EQUALS "104.28.113.201"
    Then UI Validate Text field "Total Events Value Malicious" with params "5" EQUALS "143"

    Then UI Validate Text field "Country Code Malicious" with params "141.98.9.21" EQUALS "141.98.9.21"
    Then UI Validate Text field "Total Events Value Malicious" with params "6" EQUALS "143"

    Then UI Validate Text field "Country Code Malicious" with params "167.71.201.112" EQUALS "167.71.201.112"
    Then UI Validate Text field "Total Events Value Malicious" with params "7" EQUALS "143"

    Then UI Validate Text field "Country Code Malicious" with params "178.17.174.10" EQUALS "178.17.174.10"
    Then UI Validate Text field "Total Events Value Malicious" with params "8" EQUALS "143"

    Then UI Validate Text field "Country Code Malicious" with params "189.203.104.55" EQUALS "189.203.104.55"
    Then UI Validate Text field "Total Events Value Malicious" with params "9" EQUALS "143"

  @SID_16
  Scenario: validate TOP MALICIOUS IP ADDRESSES Attacks
    Then UI Click Button "Malicious tabs" with value "Attacks"

    Then UI Validate Text field "Country Code Malicious" with params "113.172.213.32" EQUALS "113.172.213.32"
    Then UI Validate Text field "Total Events Value Malicious" with params "0" EQUALS "1"

    Then UI Validate Text field "Country Code Malicious" with params "120.138.13.189" EQUALS "120.138.13.189"
    Then UI Validate Text field "Total Events Value Malicious" with params "1" EQUALS "1"

    Then UI Validate Text field "Country Code Malicious" with params "178.73.215.171" EQUALS "178.73.215.171"
    Then UI Validate Text field "Total Events Value Malicious" with params "2" EQUALS "1"

    Then UI Validate Text field "Country Code Malicious" with params "125.64.94.138" EQUALS "125.64.94.138"
    Then UI Validate Text field "Total Events Value Malicious" with params "3" EQUALS "1"

    Then UI Validate Text field "Country Code Malicious" with params "128.1.248.26" EQUALS "128.1.248.26"
    Then UI Validate Text field "Total Events Value Malicious" with params "4" EQUALS "1"

    Then UI Validate Text field "Country Code Malicious" with params "104.28.113.201" EQUALS "104.28.113.201"
    Then UI Validate Text field "Total Events Value Malicious" with params "5" EQUALS "1"

    Then UI Validate Text field "Country Code Malicious" with params "141.98.9.21" EQUALS "141.98.9.21"
    Then UI Validate Text field "Total Events Value Malicious" with params "6" EQUALS "1"

    Then UI Validate Text field "Country Code Malicious" with params "167.71.201.112" EQUALS "167.71.201.112"
    Then UI Validate Text field "Total Events Value Malicious" with params "7" EQUALS "1"

    Then UI Validate Text field "Country Code Malicious" with params "178.17.174.10" EQUALS "178.17.174.10"
    Then UI Validate Text field "Total Events Value Malicious" with params "8" EQUALS "1"

    Then UI Validate Text field "Country Code Malicious" with params "189.203.104.55" EQUALS "189.203.104.55"
    Then UI Validate Text field "Total Events Value Malicious" with params "9" EQUALS "1"

  @SID_17
  Scenario: validate TOP MALICIOUS IP ADDRESSES volume
    Then UI Click Button "Malicious tabs" with value "Volume"

    Then UI Validate Text field "Country Code Malicious" with params "113.172.213.32" EQUALS "113.172.213.32"
    Then UI Validate Text field "Total Events Value Malicious" with params "0" EQUALS "284K"

    Then UI Validate Text field "Country Code Malicious" with params "120.138.13.189" EQUALS "120.138.13.189"
    Then UI Validate Text field "Total Events Value Malicious" with params "1" EQUALS "284K"

    Then UI Validate Text field "Country Code Malicious" with params "178.73.215.171" EQUALS "178.73.215.171"
    Then UI Validate Text field "Total Events Value Malicious" with params "2" EQUALS "284K"

    Then UI Validate Text field "Country Code Malicious" with params "125.64.94.138" EQUALS "125.64.94.138"
    Then UI Validate Text field "Total Events Value Malicious" with params "3" EQUALS "283K"

    Then UI Validate Text field "Country Code Malicious" with params "128.1.248.26" EQUALS "128.1.248.26"
    Then UI Validate Text field "Total Events Value Malicious" with params "4" EQUALS "142K"

    Then UI Validate Text field "Country Code Malicious" with params "104.28.113.201" EQUALS "104.28.113.201"
    Then UI Validate Text field "Total Events Value Malicious" with params "5" EQUALS "141K"

    Then UI Validate Text field "Country Code Malicious" with params "141.98.9.21" EQUALS "141.98.9.21"
    Then UI Validate Text field "Total Events Value Malicious" with params "6" EQUALS "141K"

    Then UI Validate Text field "Country Code Malicious" with params "167.71.201.112" EQUALS "167.71.201.112"
    Then UI Validate Text field "Total Events Value Malicious" with params "7" EQUALS "141K"

    Then UI Validate Text field "Country Code Malicious" with params "178.17.174.10" EQUALS "178.17.174.10"
    Then UI Validate Text field "Total Events Value Malicious" with params "8" EQUALS "141K"

    Then UI Validate Text field "Country Code Malicious" with params "189.203.104.55" EQUALS "189.203.104.55"
    Then UI Validate Text field "Total Events Value Malicious" with params "9" EQUALS "141K"

  @SSSW
  @SID_15
  Scenario: verify no data available in dashboard
    And UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | setId             | ports | policies |
      | DefensePro_Set_13 |       |          |

    Then UI Text of "EAAF charts" with extension "top attacking geolocations" equal to " !No data available"
    Then UI Text of "EAAF charts" with extension "breakdown by malicious" equal to " !No data available"
    Then UI Text of "EAAF charts" with extension "top malicious" equal to " !No data available"
    Then UI Text of "EAAF charts" with extension "EAAF timeline" equal to " !No data available"
    Then UI Text of "EAAF charts" with extension "distinct ip" equal to " !No data available"

################################ breakdown malicious #########################################
Scenario: validate breakdown packets

    Then UI Click Button "Eaaf tabs" with value "Packets,Breakdown-by-Malicious-Activity"

  Then UI Validate Text field "breakdown total events" with params "0" EQUALS "2K"

#  Then UI Validate Text field "breakdown title" with params "App Attacker Bot" EQUALS "App Attacker Bot"
#    Then UI Validate Text field "breakdown total events" with params "1" EQUALS "432"
#
#    Then UI Validate Text field "breakdown title" with params "Scanner" EQUALS "Scanner"
#    Then UI Validate Text field "breakdown total events" with params "2" EQUALS "432"
#
#    Then UI Validate Text field "breakdown title" with params "Scanner (TLS/SSL)" EQUALS "Scanner (TLS/SSL)"
#    Then UI Validate Text field "breakdown total events" with params "3" EQUALS "432"



  Then UI Click Button "Eaaf tabs" with value "Attacks,Breakdown-by-Malicious-Activity"

  Then UI Validate Text field "breakdown total events" with params "0" EQUALS "3"

#  Then UI Validate Text field "breakdown title" with params "App Attacker Bot" EQUALS "App Attacker Bot"
#  Then UI Validate Text field "breakdown total events" with params "1" EQUALS "1"
#
#  Then UI Validate Text field "breakdown title" with params "Scanner" EQUALS "Scanner"
#  Then UI Validate Text field "breakdown total events" with params "2" EQUALS "1"
#
#  Then UI Validate Text field "breakdown title" with params "Scanner (TLS/SSL)" EQUALS "Scanner (TLS/SSL)"
#  Then UI Validate Text field "breakdown total events" with params "3" EQUALS "1"



  Then UI Click Button "Eaaf tabs" with value "Volume,Breakdown-by-Malicious-Activity"

  Then UI Validate Text field "breakdown total events" with params "0" EQUALS "2M"

#  Then UI Validate Text field "breakdown title" with params "App Attacker Bot" EQUALS "App Attacker Bot"
#  Then UI Validate Text field "breakdown total events" with params "1" EQUALS "428K"
#
#  Then UI Validate Text field "breakdown title" with params "Scanner" EQUALS "Scanner"
#  Then UI Validate Text field "breakdown total events" with params "2" EQUALS "428K"
#
#  Then UI Validate Text field "breakdown title" with params "Scanner (TLS/SSL)" EQUALS "Scanner (TLS/SSL)"
#  Then UI Validate Text field "breakdown total events" with params "3" EQUALS "428K"