@TC127196
Feature: Analytics dashboard - Source IPs and Geo location

  @SID_1
  Scenario: kill simulator, clean all data logs and simulate bdos attack
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp*"
    Given CLI simulate 1 attacks of type "vrm_bdos" on SetId "DefensePro_Set_13" with loopDelay 1500
    Then Play File "empty_file.xmf" in device "DP_Sim_Set_0" from map "Automation_Machines" and wait 20 seconds
    * REST Delete ES index "eaaf-attack-*"
    Given Play File "DP_sim_8.28.xmf" in device "DP_Sim_Set_0" from map "Automation_Machines" and wait 20 seconds
    Then Sleep "360"
    Then Play File "empty_file.xmf" in device "DP_Sim_Set_0" from map "Automation_Machines" and wait 20 seconds
    * CLI kill all simulator attacks on current vision


  @SID_2
  Scenario: Login and navigate to AMS analytics dashboard
    Given UI Login with user "radware" and password "radware"
    Given UI Navigate to "DefensePro Analytics Dashboard" page via homePage

  @SID_3
  Scenario: Show Top attack GeoLocation and Top attack Sources Charts in DP Analytics dashboard
    Then UI Click Button "Widget Selection"
    Then UI Click Button "Widget Selection.Clear Dashboard"
    Then UI Click Button "Widget Selection.Remove All Confirm"
    Then UI Click Button "Geolocation widget"
    Then UI Click Button "Top Attack Sources widget"
    Then UI Click Button "Widget Selection.Add Selected Widgets"
    Then UI Click Button "Widget Selection"


  @SID_4
  Scenario: Validate bdos attack and simulator data in Geolocation chart

    Then Sleep "10"
    Then UI Validate Text field "Country Name" with params "United States" EQUALS "United States"
    Then UI Validate Text field "Country Value" with params "US" EQUALS "18%"
    Then UI Validate Text field "Total Events Value" with params "US" EQUALS "2"

    Then UI Validate Text field "Country Name" with params "China" EQUALS "China"
    Then UI Validate Text field "Country Value" with params "CN" EQUALS "9%"
    Then UI Validate Text field "Total Events Value" with params "CN" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "Lithuania" EQUALS "Lithuania"
    Then UI Validate Text field "Country Value" with params "LT" EQUALS "9%"
    Then UI Validate Text field "Total Events Value" with params "LT" EQUALS "1"

  @SID_5
  Scenario: Validate bdos attack and simulator data in top attack sources chart
    Then UI Validate Pie Chart data "Top Attack Sources"
      | label          | data |
      | Multiple       | 1    |
      | 192.85.1.2     | 1    |
      | 113.172.213.32 | 1    |
      | 120.138.13.189 | 1    |
      | 125.64.94.138  | 1    |
      | 178.73.215.171 | 1    |
      | 104.28.113.201 | 1    |
      | 128.1.248.26   | 1    |
      | 141.98.9.21    | 1    |
      | 167.71.201.112 | 1    |


  @SID_6
  Scenario: select DP 172.17.50.50 from scope selection

    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | setId             | ports | policies |
      | DefensePro_Set_13 |       |          |

  @SID_7
  Scenario: Validate bdos attack in Geolocation chart
    Then Sleep "10"
    Then UI Validate Text field "Country Name" with params "United States" EQUALS "United States"
    Then UI Validate Text field "Country Value" with params "US" EQUALS "50%"
    Then UI Validate Text field "Total Events Value" with params "US" EQUALS "1"


    Then UI Validate Text field "Country Name" with params "Multiple" EQUALS "Multiple"
    Then UI Validate Text field "Country Value" with params "Multiple" EQUALS "50%"
    Then UI Validate Text field "Total Events Value" with params "Multiple" EQUALS "1"


  @SID_8
  Scenario: Validate bdos attack in top attack sources chart
    Then UI Validate Pie Chart data "Top Attack Sources"
      | label      | data |
      | Multiple   | 1    |
      | 192.85.1.2 | 1    |


  @SID_9
  Scenario: select simulator from scope selection
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | setId        | ports | policies |
      | DP_Sim_Set_0 |       |          |

  @SID_10
  Scenario: Validate simulator data in Geolocation chart
    Then Sleep "10"
    Then UI Validate Text field "Country Name" with params "United States" EQUALS "United States"
    Then UI Validate Text field "Country Value" with params "US" EQUALS "10%"
    Then UI Validate Text field "Total Events Value" with params "US" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "China" EQUALS "China"
    Then UI Validate Text field "Country Value" with params "CN" EQUALS "10%"
    Then UI Validate Text field "Total Events Value" with params "CN" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "Lithuania" EQUALS "Lithuania"
    Then UI Validate Text field "Country Value" with params "LT" EQUALS "10%"
    Then UI Validate Text field "Total Events Value" with params "LT" EQUALS "1"


  @SID_11
  Scenario: Validate simulator data in top attack sources chart
    Then UI Validate Pie Chart data "Top Attack Sources"
      | label          | data |
      | 113.172.213.32 | 1    |
      | 120.138.13.189 | 1    |
      | 125.64.94.138  | 1    |
      | 178.73.215.171 | 1    |
      | 104.28.113.201 | 1    |
      | 128.1.248.26   | 1    |
      | 141.98.9.21    | 1    |
      | 167.71.201.112 | 1    |

