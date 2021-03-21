@TC118822
Feature: HTTPSGenerateReport

  #  ==========================================Setup================================================
  @SID_1
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    Given CLI Run remote linux Command "service vision restart" on "ROOT_SERVER_CLI" and halt 185 seconds

  @SID_2
  Scenario: Update Policies
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given REST Login with user "radware" and password "radware"
    Then REST Update Policies for All DPs


  @SID_3
  Scenario: Copy and run add https server script
    Then CLI copy "/home/radware/Scripts/add_https_server.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then CLI Run remote linux Command "/add_https_server.sh 172.16.22.51 pol1 test 1.1.1.2" on "ROOT_SERVER_CLI"


  @SID_4
  Scenario:Login and Navigate to HTTPS Flood Dashboard
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage

  @SID_5
  Scenario: Run DP simulator PCAPs for "HTTPS attacks"
    Given CLI simulate 1 attacks of type "HTTPS" on "DefensePro" 11 with loopDelay 15000 and wait 60 seconds

  @SID_6
  Scenario: Inbound Traffic - Real-Time Traffic
    Then CLI Run linux Command "service iptables stop" on "ROOT_SERVER_CLI" and validate result CONTAINS "Unloading modules"
    Then Validate Line Chart data "Inbound Traffic-HTTPS Flood" with Label "Transitory Baseline" in report "HTTPSGenerateReport"
      | value | min |
      | 17200 | 50  |
#    Then Validate Line Chart data "Inbound Traffic-HTTPS Flood" with Label "Total Traffic" in report "HTTPSGenerateReport"
#      | value   | min |
#      | null    | 50  |
#      | 25060.0 | 1   |
#    Then Validate Line Chart data "Inbound Traffic-HTTPS Flood" with Label "Legitimate Traffic" in report "HTTPSGenerateReport"
#      | value   | min |
#      | null    | 50  |
#      | 17500.0 | 1   |
#    Then Validate Line Chart data "Inbound Traffic-HTTPS Flood" with Label "Long-Term Trend Attack Edge" in report "HTTPSGenerateReport"
#      | value   | min |
#      | 7002    | 50  |
#    Then Validate Line Chart data "Inbound Traffic-HTTPS Flood" with Label "Long-Term Trend Baseline" in report "HTTPSGenerateReport"
#      | value   | min |
#      | 5075    | 50  |


#    Then UI Validate StackBar data with widget "Inbound Traffic-HTTPS Flood" in report "HTTPSGenerateReport"
#      | label             | value      | legendName |
#      | Real-Time Traffic | 0          | 100        |
#      | Real-Time Traffic | 0.23451911 | 200        |
#      | Real-Time Traffic | 0.214519   | 300        |
#      | Real-Time Traffic | 0          | 400        |
#      | Real-Time Traffic | 0.81       | 500        |
#
#  @SID_7
#  Scenario: Inbound Traffic - Baseline
#    Then UI Validate StackBar data with widget "Inbound Traffic-HTTPS Flood" in report "HTTPSGenerateReport"
#      | label    | value       | legendName |
#      | Baseline | 0           | 100        |
#      | Baseline | 0.9723455   | 200        |
#      | Baseline | 0.77        | 300        |
#      | Baseline | 0           | 400        |
#      | Baseline | 0.027675444 | 500        |
#
#  @SID_8
#  Scenario: Inbound Traffic - Attack Edge
#    Then UI Validate StackBar data with widget "Inbound Traffic-HTTPS Flood" in report "HTTPSGenerateReport"
#      | label       | value      | legendName |
#      | Attack Edge | 0          | 100        |
#      | Attack Edge | 1          | 200        |
#      | Attack Edge | 0          | 300        |
#      | Attack Edge | 0          | 400        |
#      | Attack Edge | 0.47802296 | 500        |
#
#  @SID_9
#  Scenario: Inbound Traffic - Under Attack
#    Then UI Validate StackBar data with widget "Inbound Traffic-HTTPS Flood" in report "HTTPSGenerateReport"
#      | label        | value      | legendName |
#      | Under Attack | 0          | 100        |
#      | Under Attack | 0.23451911 | 200        |
#      | Under Attack | 0.214519   | 300        |
#      | Under Attack | 0          | 400        |
#      | Under Attack | 0.81       | 500        |

  @SID_7
  Scenario: start IPTABLES
    Then CLI Run linux Command "service iptables start" on "ROOT_SERVER_CLI" and validate result CONTAINS "Loading additional modules"