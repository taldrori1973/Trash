@TC126510
Feature: EAAF Distinct IP Addresses

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
  Scenario: EAAF Distinct IP Value and Total packets - verify data for 15 min
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "15m"
    Then UI Validate Text field "Total packets value" with params "" EQUALS "10.32 K"
    Then UI Validate number range between minValue 10 and maxValue 11 in label "Total Distinct Ip"

  @SID_4
  Scenario: EAAF Distinct IP Value and Total packets- verify data for 30 min
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "30m"
    Then UI Validate Text field "Total packets value" with params "" EQUALS "10.32 K"
    Then UI Validate number range between minValue 10 and maxValue 11 in label "Total Distinct Ip"


  @SID_5
  Scenario: EAAF Distinct IP Value and Total Packets chart
    Then UI Validate Line Chart data "eaaf-distinct-ip-chart" with Label "packets"
      | value | count | offset |
      | 10030 | 1     | 100    |
    Then UI Validate Line Chart data "eaaf-distinct-ip-chart" with Label "addresses"
      | value | count | offset |
      | 11    | 1     | 1      |

  @SID_6
  Scenario: Validate Chart Legend EAAF Total Packets
    Then UI Click Button "Total Packets"
    Then UI Validate Line Chart data "eaaf-distinct-ip-chart" with Label "packets" Not Exist "true"
      | value | count | offset |
    Then UI Validate Line Chart data "eaaf-distinct-ip-chart" with Label "addresses"
      | value | count | offset |
      | 11    | 1     | 1      |

  @SID_7
  Scenario: Validate Chart Legend EAAF Distinct IP Addresses
    Then UI Click Button "Distinct Ip Addresses"
    Then UI Validate Line Chart data "eaaf-distinct-ip-chart" with Label "packets" Not Exist "true"
      | value | count | offset |
    Then UI Validate Line Chart data "eaaf-distinct-ip-chart" with Label "addresses" Not Exist "true"
      | value | count | offset |

  @SID_8
  Scenario: Validate Chart Data After two Selected Legends
    Then UI Click Button "Distinct Ip Addresses"
    Then UI Click Button "Total Packets"
    Then UI Validate Line Chart data "eaaf-distinct-ip-chart" with Label "packets"
      | value | count | offset |
      | 10030 | 1     | 100    |
    Then UI Validate Line Chart data "eaaf-distinct-ip-chart" with Label "addresses"
      | value | count | offset |
      | 11    | 1     | 1      |

  @SID_9
  Scenario: Logout and Close Browser
    Then UI logout and close browser