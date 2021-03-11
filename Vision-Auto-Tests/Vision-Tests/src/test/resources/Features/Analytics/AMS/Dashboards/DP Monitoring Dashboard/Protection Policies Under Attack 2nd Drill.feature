@VRM @TC105993

Feature: DP Monitoring Dashboard - Protection Policies - Under Attack 2nd Drill

  @SID_1
  Scenario: Clean system data before "Protection Policies" test
    * CLI kill all simulator attacks on current vision
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs


  @SID_2
  Scenario: Run DP simulator PCAPs for "Protection Policies" - 2nd drill - attack rate
    Given CLI simulate 1000 attacks of type "attack_rate" on "DefensePro" 10 with loopDelay 15000 and wait 120 seconds


  @SID_3
  Scenario: Login and navigate to VRM
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage


  @SID_4
  Scenario: Entering to the under attack policy 2nd drill
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0


  @SID_5
  Scenario: Validate Dashboards "Traffic Bandwidth" Widget data
    When UI Do Operation "Select" item "Policy Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Received"
      | value   | min |
      | 1954261 | 2   |
    Then  UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Dropped"
      | value   | min |
      | 1954250 | 2   |
    When UI Do Operation "Select" item "Policy Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Received"
      | value   | count |
      | 1954261 | 0     |
    Then  UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Dropped"
      | value   | count |
      | 1954250 | 0     |
    When UI Do Operation "Select" item "Policy Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Received"
      | value  | count |
      | 174487 | 0     |
    Then  UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Dropped"
      | value  | count |
      | 174487 | 0     |
    When UI Do Operation "Select" item "Policy Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Received"
      | value  | min |
      | 174487 | 2   |
    Then  UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Dropped"
      | value  | min |
      | 174487 | 2   |


  @SID_6
  Scenario: Validate Dashboards "TOTAL TRAFFIC" Widget data
    Then UI Validate Text field "Total Traffic Received text" EQUALS "1.95 G"
    Then UI Validate Text field "Total Traffic Dropped text" EQUALS "1.95 G"


  @SID_7
  Scenario: Validate Dashboards "Last Period Attack Rate" Widget data
    Then UI Validate Text field "LAST PERIOD ATTACK RATE.Bandwidth" EQUALS "1.95 G"
    Then UI Validate Text field "LAST PERIOD ATTACK RATE.Packet Rate" EQUALS "174.49 K"

#  Scenario: Validate Dashboards "Attack Traffic and Active Protections" Widget data

  @SID_8
  Scenario: validate events by Category table rows - sort by Alphabet
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Protections Table" findBy index 0
      | columnName      | value          |
      | Protection Name | Behavioral DoS |
      | Attack Rate     | 643.06 Mbps    |
      | Drop Rate       | 643.06 Mbps    |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Protections Table" findBy index 1
      | columnName      | value |
      | Protection Name | ACL   |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Protections Table" findBy index 2
      | columnName      | value     |
      | Protection Name | Anomalies |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Protections Table" findBy index 3
      | columnName      | value         |
      | Protection Name | Anti-Scanning |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Protections Table" findBy index 4
      | columnName      | value     |
      | Protection Name | DNS Flood |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Protections Table" findBy index 5
      | columnName      | value |
      | Protection Name | DoS   |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Protections Table" findBy index 6
      | columnName      | value        |
      | Protection Name | Geo location |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Protections Table" findBy index 7
      | columnName      | value       |
      | Protection Name | HTTPS Flood |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Protections Table" findBy index 8
      | columnName      | value      |
      | Protection Name | Intrusions |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Protections Table" findBy index 9
      | columnName      | value                |
      | Protection Name | Malicious IP Address |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Protections Table" findBy index 10
      | columnName      | value     |
      | Protection Name | SYN Flood |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Protections Table" findBy index 11
      | columnName      | value           |
      | Protection Name | Traffic Filters |

  @SID_9
  Scenario: validate events by Category table rows - attack details
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy index 0
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName | value         |
      | Attack ID  | 17-1527513960 |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName  | value                          |
      | Attack Name | network flood IPv4 TCP-SYN-ACK |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName  | value       |
      | Policy Name | Protect_5_1 |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName    | value   |
      | Attack Status | Ongoing |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName | value |
      | Risk       | High  |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName | value |
      | Action     | Drop  |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName | value       |
      | Bandwidth  | 643.06 Mbps |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName  | value     |
      | Packet Rate | 58795 PPS |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName     | value    |
      | Source Address | Multiple |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName          | value     |
      | Destination Address | 10.10.0.6 |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName | value          |
      | Category   | Behavioral DoS |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName        | value        |
      | Device IP Address | 172.16.22.50 |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName  | value |
      | Source Port | 1024  |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName       | value |
      | Destination Port | 1024  |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName | value   |
      | Direction  | Unknown |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName | value |
      | Radware ID | 78    |

  @SID_10
  Scenario: validate events by un-categorized table rows
    Then UI Click Switch button "Protection Policies.Protections Table.Switch Button" and set the status to "ON"
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName | value         |
      | Attack ID  | 17-1527513960 |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName  | value                          |
      | Attack Name | network flood IPv4 TCP-SYN-ACK |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName  | value       |
      | Policy Name | Protect_5_1 |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName    | value   |
      | Attack Status | Ongoing |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName | value |
      | Risk       | High  |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName | value |
      | Action     | Drop  |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName | value       |
      | Bandwidth  | 643.06 Mbps |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName  | value     |
      | Packet Rate | 58795 PPS |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName     | value    |
      | Source Address | Multiple |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName          | value     |
      | Destination Address | 10.10.0.6 |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName | value          |
      | Category   | Behavioral DoS |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName        | value        |
      | Device IP Address | 172.16.22.50 |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName  | value |
      | Source Port | 1024  |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName       | value |
      | Destination Port | 1024  |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName | value |
      | Radware ID | 78    |
    Then UI Click Button "Protection Policies.GO BACK"


  @SID_11
  Scenario: Validate Attack Rate and Drop Rate Aggregation
    Given CLI kill all simulator attacks on current vision
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"

    Given CLI simulate 1 attacks of type "rest_black_ip46" on "DefensePro" 10 and wait 45 seconds
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And  UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Protections Table" findBy index 0
      | columnName      | value       |
      | Protection Name | ACL         |
      | Attack Rate     | 867.07 Mbps |
      | Drop Rate       | 867.07 Mbps |

  @SID_12
  Scenario: Validate Attack volume and total packets
    Then UI Click Switch button "Protection Policies.Protections Table.Switch Button" and set the status to "ON"
#    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy index 0
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "77-1526381752"
      | columnName    | value        |
      | Policy Name   | Black_IPV4   |
      | Attack Name   | Black List   |
      | Total Packets | 68,589       |
      | Volume        | 55.94 MBytes |

  @SID_16
  Scenario: Protection Policies Cleanup
    Given UI logout and close browser
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
