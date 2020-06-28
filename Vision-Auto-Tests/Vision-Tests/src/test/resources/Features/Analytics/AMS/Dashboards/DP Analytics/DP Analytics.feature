@DP_Analytics @TC105989

Feature: DP ANALYTICS

  @SID_1
  Scenario: Clean system attacks,database and logs
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    * CLI kill all simulator attacks on current vision
    # wait until collector cache clean up
    * Sleep "15"
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs
    * CLI Run remote linux Command "curl -X GET localhost:9200/_cat/indices?v | grep dp-attack-raw >> /opt/radware/storage/maintenance/dp-attack-before-streaming" on "ROOT_SERVER_CLI"
    * CLI Run remote linux Command "curl -X POST localhost:9200/dp-attack-raw-*/_search -d '{"query":{"bool":{"must":[{"match_all":{}}]}},"from":0,"size":1000}' > /opt/radware/storage/maintenance/attack-raw-index-before-stream" on "ROOT_SERVER_CLI"

  @SID_2
  Scenario: Run DP simulator PCAPs for Attacks by Protection Policy  widget
    * CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10
    * CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 11 with attack ID
    * CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 12 with attack ID
    * CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 20 with attack ID
    * CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 21 and wait 240 seconds with attack ID
    * CLI Run remote linux Command "curl -X GET localhost:9200/_cat/indices?v | grep dp-attack-raw >> /opt/radware/storage/maintenance/dp-attack-after-streaming" on "ROOT_SERVER_CLI"
    # Wait to avoid ES issue when running curl one after another
    And Sleep "5"
    * CLI Run remote linux Command "curl -X POST localhost:9200/dp-attack-raw-*/_search -d '{"query":{"bool":{"must":[{"match_all":{}}],"must_not":[],"should":[]}},"from":0,"size":1000}' > /opt/radware/storage/maintenance/attack-raw-index-after-stream" on "ROOT_SERVER_CLI"

  @SID_3
  Scenario: Login and add widgets
    When UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
    And UI VRM Select Widgets
      | Attacks by Source And Destination |
      | Top Attacks by Duration           |
      | Top Probed IP Addresses           |

    # ================= ATTACKS BY MITIGATION ACTION ================= #

  @SID_4
  Scenario: VRM - Validate Dashboards "Attacks by Mitigation Action" Chart data for all DP machines
    * Sleep "2"
    Then UI Validate StackBar data with widget "Attacks by Mitigation Action"
      | label              | value | legendName         |
      | shlomi             | 15    | Drop               |
      | BDOS               | 12    | Drop               |
      | Packet Anomalies   | 9     | Drop               |
      | shlomchik          | 9     | Drop               |
      | Black_IPV6         | 6     | Drop               |
      | POL_IPV6           | 6     | Drop               |
      | policy1            | 6     | Drop               |
   #  | bbt-sc1            | 3     | Drop               |
      | Black_IPV4         | 3     | Drop               |
      | Paaaaaaaaaaaaaaa   | 3     | Drop               |
    # | pol_1              | 3     | Drop               |
      | 1                  | 3     | Drop               |
      | policy1            | 6     | Challenge          |
      | HPPPf              | 3     | Challenge          |
      | 1                  | 3     | Forward            |
      | BDOS               | 3     | Forward            |
      | bdos1              | 3     | Forward            |
      | DOSS               | 3     | Forward            |
      | pph_9Pkt_lmt_252.1 | 3     | Forward            |
      | Seets_policy       | 3     | Http200OkResetDest |

  @SID_5
  Scenario: VRM - Validate Dashboards "Attacks by Mitigation Action" Chart widget styling attributes
    Then UI Validate Line Chart attributes "Attacks by Mitigation Action" with Label "shlomi"
      | attribute       | value                  |
      | backgroundColor | #00BDEE |
    Then  UI Validate Line Chart attributes "Attacks by Mitigation Action" with Label "BDOS"
      | attribute       | value                    |
      | backgroundColor | #6CB9FF |
    Then UI Validate Line Chart attributes "Attacks by Mitigation Action" with Label "Packet Anomalies"
      | attribute       | value                    |
      | backgroundColor | #04C2A0 |
    Then UI Validate Line Chart attributes "Attacks by Mitigation Action" with Label "shlomchik"
      | attribute       | value                   |
      | backgroundColor | #108282 |
    Then UI Validate Line Chart attributes "Attacks by Mitigation Action" with Label "Black_IPV6"
      | attribute       | value                    |
      | backgroundColor | #4388C8 |

  @SID_6
  Scenario: VRM - Validate Dashboards "Attacks by Mitigation Action" Chart data for one selected DP machine
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    * Sleep "2"
    Then UI Validate StackBar data with widget "Attacks by Mitigation Action"
      | label              | value | legendName         |
      | shlomi             | 5     | Drop               |
      | BDOS               | 4     | Drop               |
      | Packet Anomalies   | 3     | Drop               |
      | shlomchik          | 3     | Drop               |
      | Black_IPV6         | 2     | Drop               |
      | POL_IPV6           | 2     | Drop               |
      | policy1            | 2     | Drop               |
     #| bbt-sc1            | 1     | Drop               |
      | Black_IPV4         | 1     | Drop               |
      | Paaaaaaaaaaaaaaa   | 1     | Drop               |
      | 1                  | 1     | Drop               |
      | policy1            | 2     | Challenge          |
      | HPPPf              | 1     | Challenge          |
      | 1                  | 1     | Forward            |
      | BDOS               | 1     | Forward            |
      | bdos1              | 1     | Forward            |
      | DOSS               | 1     | Forward            |
      | pph_9Pkt_lmt_252.1 | 1     | Forward            |
      | Seets_policy       | 1     | Http200OkResetDest |

  @SID_7
  Scenario: VRM - Validate Dashboards "Attacks by Mitigation Action" Chart data for one selected port
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1     |          |
    Then UI Validate StackBar data with widget "Attacks by Mitigation Action"
      | label  | value | legendName |
      | shlomi | 5     | Drop       |
      | BDOS   | 4     | Drop       |

  @SID_8
  Scenario: VRM - Validate Dashboards "Attacks by Mitigation Action" Chart data for selected policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies          |
      | 10    |       | BDOS,pol_1,shlomi |
    * Sleep "2"
    Then UI Validate StackBar data with widget "Attacks by Mitigation Action"
      | label  | value | legendName |
      | BDOS   | 4     | Drop       |
      | pol_1  | 1     | Drop       |
      | shlomi | 5     | Drop       |
      | BDOS   | 1     | Forward    |

  @SID_9
  Scenario: VRM - Validate Dashboards "Attacks by Mitigation Action" Chart data for selected port and policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies    |
      | 10    | 1     | BDOS,shlomi |
    Then UI Validate StackBar data with widget "Attacks by Mitigation Action"
      | label  | value | legendName |
      | shlomi | 5     | Drop       |
      | BDOS   | 4     | Drop       |

  @SID_10
  Scenario: VRM - NEGATIVE: Validate Dashboards "Attacks by Mitigation Action" Chart data doesn't exist for policy without relevant data
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | BDOS     |
    Then UI Validate StackBar data with widget "Attacks by Mitigation Action"
      | label     | value | legendName | exist |
      | shlomchik | 3     | Drop       | false |

  @SID_11
  Scenario: VRM - NEGATIVE: Validate Dashboards "Attacks by Mitigation Action" data doesn't exist for policy with traffic and port with no traffic
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 4     | BDOS     |
    Then UI Validate StackBar data with widget "Attacks by Mitigation Action"
      | label   | value | legendName | exist |
      | shlomi  | 5     | Drop       | false |
      | BDOS    | 4     | Drop       | false |
      | bbt-sc1 | 1     | Drop       | false |

  @SID_12
  Scenario: Attacks by Mitigation Action Cleanup
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
    * UI Logout

#      # ================= ATTACKS BY SOURCE DESTINATION ================= #
#
#  @SID_13
#  Scenario: Login
#    When UI Login with user "sys_admin" and password "radware"
#    And UI Open Upper Bar Item "AMS"
#    And UI Open "Dashboards" Tab
#    And UI Open "DP Analytics" Sub Tab
#    And UI Do Operation "Select" item "Global Time Filter"
#    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
#
#  @SID_14
#  Scenario: VRM - Validate Dashboards "Attacks by Source And Destination" chart data on All devices
#    When UI Do Operation "Select" item "Device Selection"
#    And UI VRM Select device from dashboard and Save Filter
#      | index | ports | policies |
#      | 10    |       |          |
#      | 11    |       |          |
#      | 12    |       |          |
#    And UI VRM Select Widgets
#      | Attacks by Source And Destination |
#    Then  UI Validate StackBar data with widget "Attacks by Source And Destination-1"
#      | legendName                              | value | label    | exist |
#      | 192.85.1.2                              | 6     | 0        | true  |
#      | 192.85.1.2                              | 18    | 1024     | true  |
#      | 0.0.0.0                                 | 18    | 0        | true  |
#      | Multiple                                | 12    | 0        | true  |
#      | Multiple                                | 6     | Multiple | true  |
#      | 1234:1234:1234:1234:1234:1234:1234:1234 | 6     | 0        | true  |
#      | 1234:1234:1234:1234:1234:1234:1234:1234 | 6     | 1024     | true  |
#      | 192.85.1.8                              | 6     | 1055     | true  |
#      | ::                                      | 6     | 0        | true  |
#      | 197.1.1.1                               | 6     | 54081    | true  |
#    Then UI Total "Attacks by Source And Destination-1" legends equal to 10
#
#  @SID_15
#  Scenario: VRM - Validate Dashboards "Attacks by Source And Destination" Chart data for one DP machines
#    When UI Do Operation "Select" item "Device Selection"
#    And UI VRM Select device from dashboard and Save Filter
#      | index | ports | policies |
#      | 11    |       |          |
#    Then  UI Validate StackBar data with widget "Attacks by Source And Destination-1"
#      | legendName                              | value | label    | exist |
#      | 192.85.1.2                              | 2     | 0        | true  |
#      | 192.85.1.2                              | 6     | 1024     | true  |
#      | 0.0.0.0                                 | 6     | 0        | true  |
#      | Multiple                                | 4     | 0        | true  |
#      | Multiple                                | 2     | Multiple | true  |
#      | 1234:1234:1234:1234:1234:1234:1234:1234 | 2     | 0        | true  |
#      | 1234:1234:1234:1234:1234:1234:1234:1234 | 2     | 1024     | true  |
#      | 192.85.1.8                              | 2     | 1055     | true  |
#      | ::                                      | 2     | 0        | true  |
#    Then UI Total "Attacks by Source And Destination-1" legends equal to 10
#
#  @SID_16
#  Scenario:  VRM - Validate Chart data for one selected DP machine filtered by policies
#    When UI Do Operation "Select" item "Device Selection"
#    And UI VRM Select device from dashboard and Save Filter
#      | index | ports | policies |
#      | 10    |       | BDOS     |
#    Then  UI Validate StackBar data with widget "Attacks by Source And Destination-1"
#      | legendName  | value | label | exist |
#      | 192.85.1.8  | 2     | 1055  | true  |
#      | 192.85.1.77 | 1     | 1055  | true  |
#      | 0.0.0.0     | 1     | 0     | true  |
#      | 192.85.1.2  | 1     | 1024  | true  |
#    Then UI Total "Attacks by Source And Destination-1" legends equal to 4
#
#  @SID_17
#  Scenario: VRM - Validate Chart data for two selected DP machine filtered by ports
#    When UI Do Operation "Select" item "Device Selection"
#    And UI VRM Select device from dashboard and Save Filter
#      | index | ports | policies |
#      | 10    | 1,3   |          |
#      | 11    | 1,3   |          |
#    Then  UI Validate StackBar data with widget "Attacks by Source And Destination-1"
#      | legendName  | value | label | exist |
#      | 192.85.1.2  | 2     | 0     | true  |
#      | 192.85.1.2  | 12    | 1024  | true  |
#      | 192.85.1.8  | 4     | 1055  | true  |
#      | 198.18.0.1  | 2     | 49743 | true  |
#      | 192.85.1.77 | 2     | 1055  | true  |
#    Then UI Total "Attacks by Source And Destination-1" legends equal to 4
#
#  @SID_18
#  Scenario: VRM - Validate Chart data for two selected DP machine filtered by ports and policies
#    When UI Do Operation "Select" item "Device Selection"
#    And UI VRM Select device from dashboard and Save Filter
#      | index | ports | policies |
#      | 10    | 1,3   | BDOS     |
#    Then  UI Validate StackBar data with widget "Attacks by Source And Destination-1"
#      | legendName  | value | label | exist |
#      | 192.85.1.8  | 2     | 1055  | true  |
#      | 192.85.1.2  | 1     | 1024  | true  |
#      | 192.85.1.77 | 1     | 1055  | true  |
#    Then UI Total "Attacks by Source And Destination-1" legends equal to 3
#
#  @SID_19
#  Scenario: NEGATIVE - Validate Chart data doesn't exist for policy without relevant data
#    When UI Do Operation "Select" item "Device Selection"
#    And UI VRM Select device from dashboard and Save Filter
#      | index | ports | policies |
#      | 10    |       | Policy15 |
#    Then  UI Validate StackBar data with widget "Attacks by Source And Destination-1"
#      | legendName  | value | label | exist |
#      | 192.85.1.2  | 2     | 0     | false |
#      | 192.85.1.2  | 12    | 1024  | false |
#      | 192.85.1.8  | 4     | 1055  | false |
#      | 198.18.0.1  | 2     | 49743 | false |
#      | 192.85.1.77 | 2     | 1055  | false |
#
#  @SID_20
#  Scenario: NEGATIVE - Validate Chart data doesn't exist for policy with traffic and port with no traffic
#    When UI Do Operation "Select" item "Device Selection"
#    And UI VRM Select device from dashboard and Save Filter
#      | index | ports | policies |
#      | 10    | 1     | Policy15 |
#    Then  UI Validate StackBar data with widget "Attacks by Source And Destination-1"
#      | legendName  | value | label | exist |
#      | 192.85.1.2  | 2     | 0     | false |
#      | 192.85.1.2  | 12    | 1024  | false |
#      | 192.85.1.8  | 4     | 1055  | false |
#      | 198.18.0.1  | 2     | 49743 | false |
#      | 192.85.1.77 | 2     | 1055  | false |
#      | ::          | 2     | 0     | false |
#
#  @SID_21
#  Scenario: ATTACKS BY SOURCE DESTINATION Cleanup
#    * CLI Check if logs contains
#      | logType | expression | isExpected |
#      | ALL     | fatal      | NOT_EXPECTED      |
#    * UI Logout
#
      # ================= ATTACKS BY PROTECTION POLICY ================= #

  @SID_22
  Scenario: Login
    When UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"

  @SID_23
  Scenario: VRM - Validate Dashboards "Attacks by Protection Policy" Chart data for all DP machines
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
      | 11    |       |          |
      | 12    |       |          |
    Then UI Validate StackBar data with widget "Attacks by Protection Policy"
      | label                          | value | legendName       |
      | DNS flood IPv4 DNS-A           | 6     | 1                |
      | DNS flood IPv4 DNS-A           | 3     | BDOS             |
      | DOSS-Anomaly-TCP-SYN-RST       | 6     | BDOS             |
      | network flood IPv4 TCP-SYN-ACK | 3     | BDOS             |
      | tim                            | 3     | BDOS             |
      | Black List                     | 6     | Black_IPV6       |
      | Incorrect IPv4 checksum        | 9     | Packet Anomalies |
      | TCP Scan (vertical)            | 6     | policy1          |
      | SYN Flood HTTP                 | 6     | policy1          |
      | BWM Limit Alert                | 9     | shlomchik        |
      | TCP Mid Flow packet            | 15    | shlomi           |
      | network flood IPv6 TCP-SYN-ACK | 3     | POL_IPV6         |
      | network flood IPv6 UDP         | 3     | POL_IPV6         |
    Then UI Total "Attacks by Protection Policy" legends equal to 10

  @SID_24
  Scenario: VRM - Validate Dashboards "Attacks by Protection Policy" Chart data for one selected DP machine
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Validate StackBar data with widget "Attacks by Protection Policy"
      | label                          | value | legendName       |
      | DNS flood IPv4 DNS-A           | 2     | 1                |
      | DNS flood IPv4 DNS-A           | 1     | BDOS             |
      | DOSS-Anomaly-TCP-SYN-RST       | 2     | BDOS             |
      | network flood IPv4 TCP-SYN-ACK | 1     | BDOS             |
      | tim                            | 1     | BDOS             |
      | Black List                     | 2     | Black_IPV6       |
      | Incorrect IPv4 checksum        | 3     | Packet Anomalies |
      | TCP Scan (vertical)            | 2     | policy1          |
      | SYN Flood HTTP                 | 2     | policy1          |
      | BWM Limit Alert                | 3     | shlomchik        |
      | TCP Mid Flow packet            | 5     | shlomi           |
      | network flood IPv6 TCP-SYN-ACK | 1     | POL_IPV6         |
      | network flood IPv6 UDP         | 1     | POL_IPV6         |
    Then UI Total "Attacks by Protection Policy" legends equal to 10

  @SID_25
  Scenario:  VRM - Validate Dashboards "Attacks by Protection Policy" Chart data for selected port
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1     |          |
      | 11    | 1     |          |
    * Sleep "2"
    Then UI Validate StackBar data with widget "Attacks by Protection Policy"
      | label                          | value | legendName |
      | TCP Mid Flow packet            | 10    | shlomi     |
      | DOSS-Anomaly-TCP-SYN-RST       | 4     | BDOS       |
      | tim                            | 2     | BDOS       |
      | network flood IPv4 TCP-SYN-ACK | 2     | BDOS       |
    Then UI Total "Attacks by Protection Policy" legends equal to 2

  @SID_26
  Scenario: VRM - Validate Dashboards "Attacks by Protection Policy" Chart data for selected policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies      |
      | 10    |       | BDOS,POL_IPV6 |
      | 11    |       | BDOS,POL_IPV6 |
    Then UI Validate StackBar data with widget "Attacks by Protection Policy"
      | label                          | value | legendName |
      | DOSS-Anomaly-TCP-SYN-RST       | 4     | BDOS       |
      | network flood IPv6 UDP         | 2     | POL_IPV6   |
      | network flood IPv6 TCP-SYN-ACK | 2     | POL_IPV6   |
      | tim                            | 2     | BDOS       |
      | DNS flood IPv4 DNS-A           | 2     | BDOS       |
      | network flood IPv4 TCP-SYN-ACK | 2     | BDOS       |
    Then UI Total "Attacks by Protection Policy" legends equal to 2

  @SID_27
  Scenario: VRM - Validate Dashboards "Attacks by Protection Policy" Chart data for selected port and policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies      |
      | 10    | 1     | BDOS,POL_IPV6 |
      | 11    | 1     | BDOS,POL_IPV6 |
    Then UI Validate StackBar data with widget "Attacks by Protection Policy"
      | label                          | value | legendName |
      | DOSS-Anomaly-TCP-SYN-RST       | 4     | BDOS       |
      | tim                            | 2     | BDOS       |
      | network flood IPv4 TCP-SYN-ACK | 2     | BDOS       |
    Then UI Total "Attacks by Protection Policy" legends equal to 1

  @SID_28
  Scenario: VRM - NEGATIVE: Validate Dashboards "Attacks by Protection Policy" Chart data doesn't exist for policy without relevant data
    Then UI Validate StackBar data with widget "Attacks by Protection Policy"
      | label                          | value | legendName         | exist |
      | network flood IPv6 UDP         | 2     | POL_IPV6           | false |
      | HTTP Page Flood Attack         | 2     | HPPPf              | false |
      | pkt_rate_lmt_9                 | 2     | pph_9Pkt_lmt_252.1 | false |
      | Brute Force Web                | 2     | bbt-sc1            | false |
      | sign_seets3                    | 2     | Seets_policy       | false |
      | network flood IPv6 TCP-SYN-ACK | 2     | POL_IPV6           | false |
    Then UI Total "Attacks by Protection Policy" legends equal to 1

  @SID_29
  Scenario: VRM - NEGATIVE: Validate Dashboards "Attacks by Protection Policy" data doesn't exist for policy with traffic and port with no traffic
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1     | pol_1    |
      | 11    | 1     | pol_1    |
    Then UI Validate StackBar data with widget "Attacks by Protection Policy"
      | label                   | value | legendName       | exist |
      | Incorrect IPv4 checksum | 1     | Paaaaaaaaaaaaaaa | false |
      | Incorrect IPv4 checksum | 3     | Packet Anomalies | false |
      | DNS flood IPv4 DNS-A    | 2     | 1                | false |
      | DNS flood IPv4 DNS-A    | 1     | BDOS             | false |
    Then UI Total "Attacks by Protection Policy" legends equal to 0

  @SID_30
  Scenario: Attacks by Protection Policy Cleanup
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
    * UI Logout

      # ================= Attacks by Threat Category ================= #

  @SID_31
  Scenario: Login
    When UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"

  @SID_32
  Scenario: VRM - Validate Dashboards "Attacks by Threat Category" Chart data for all DP machines
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
      | 11    |       |          |
      | 12    |       |          |
    Then UI Validate Pie Chart data "Attacks by Threat Category"
      | label          | data | exist |
      | BehavioralDOS  | 18   | true  |
      | StatefulACL    | 15   | true  |
      | Anomalies      | 12   | true  |
      | ACL            | 9    | true  |
      | DOSShield      | 9    | true  |
      | BWM            | 9    | true  |
      | DNS            | 9    | true  |
      | SynFlood       | 6    | true  |
      | Anti-Scanning  | 6    | true  |
      | Intrusions     | 6    | true  |
      | httpFlood      | 3    | false |
      | ServerCracking | 3    | false |

  @SID_33
  Scenario: VRM - Validate Dashboards "Attacks by Threat Category" Chart data for one selected DP machine
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Validate Pie Chart data "Attacks by Threat Category"
      | label          | data | exist |
      | BehavioralDOS  | 6    | true  |
      | StatefulACL    | 5    | true  |
      | Anomalies      | 4    | true  |
      | ACL            | 3    | true  |
      | DOSShield      | 3    | true  |
      | BWM            | 3    | true  |
      | DNS            | 3    | true  |
      | SynFlood       | 2    | true  |
      | Anti-Scanning  | 2    | true  |
      | Intrusions     | 2    | true  |
      | httpFlood      | 1    | false |
      | ServerCracking | 1    | false |

  @SID_34
  Scenario: VRM - Validate Dashboards "Attacks by Threat Category" Chart data for one selected port
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 3     |          |
    * Sleep "2"
    Then UI Validate Pie Chart data "Attacks by Threat Category"
      | label         | data |
      | DOSShield     | 1    |
      | Anti-Scanning | 1    |

  @SID_35
  Scenario: VRM - Validate Dashboards "Attacks by Threat Category" Chart data for one selected policy
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | BDOS     |
    * Sleep "2"
    Then UI Validate Pie Chart data "Attacks by Threat Category"
      | label         | data |
      | DOSShield     | 2    |
      | Intrusions    | 1    |
      | BehavioralDOS | 1    |
      | DNS           | 1    |

  @SID_36
  Scenario: VRM - Validate Dashboards "Attacks by Threat Category" Chart data for one selected port and policy
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1     | shlomi   |
    Then UI Validate Pie Chart data "Attacks by Threat Category"
      | label       | data |
      | StatefulACL | 5    |

  @SID_37
  Scenario: VRM - NEGATIVE: Validate Dashboards "Attacks by Threat Category" Chart data doesn't exist for policy without relevant data
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | SSL      |
    Then UI Validate Pie Chart data "Attacks by Threat Category"
      | label     | data | exist |
      | DOSShield | 1    | false |

  @SID_38
  Scenario: VRM - NEGATIVE: Validate Dashboards "Attacks by Threat Category" data doesn't exist for policy with traffic and port with no traffic
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 8     | shlomi   |
    Then UI Validate Pie Chart data "Attacks by Threat Category"
      | label       | data | exist |
      | StatefulACL | 5    | false |

  @SID_39
  Scenario: Attacks by Threat Category Cleanup
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
    * UI Logout

      # ================= ATTACK CATEGORIES BY BANDWIDTH ================= #

  @SID_40
  Scenario: Login
    When UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"

  @SID_41
  Scenario: VRM - Validate Dashboards "Attack Categories by Bandwidth" Chart data for all DP machines
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
      | 11    |       |          |
      | 12    |       |          |
    Then UI Validate StackBar data with widget "Attack Categories by Bandwidth"
      | label        | value     | legendName     |
      | Black_IPV6   | 154503126 | ACL            |
      | Black_IPV4   | 1311063   | ACL            |
      | BDOS         | 483084    | BehavioralDOS  |
      | POL_IPV6     | 77960358  | BehavioralDOS  |
      | policy1      | 418728    | SynFlood       |
      | BDOS         | 339831    | DOSShield      |
      | policy1      | 28674     | Anti-Scanning  |
      | bbt-sc1      | 252324    | ServerCracking |
      | shlomchik    | 61683     | BWM            |
      | 1            | 2856      | DNS            |
      | Seets_policy | 3         | Intrusions     |
    Then UI Total "Attack Categories by Bandwidth" legends equal to 9

  @SID_42
  Scenario: VRM - Validate Dashboards "Attack Categories by Bandwidth" Chart data for one selected DP machine
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Validate StackBar data with widget "Attack Categories by Bandwidth"
      | label        | value    | legendName     |
      | Black_IPV6   | 51501042 | ACL            |
      | Black_IPV4   | 437021   | ACL            |
      | BDOS         | 161028   | BehavioralDOS  |
      | POL_IPV6     | 25986786 | BehavioralDOS  |
      | policy1      | 139576   | SynFlood       |
      | BDOS         | 113277   | DOSShield      |
      | policy1      | 9558     | Anti-Scanning  |
      | bbt-sc1      | 84108    | ServerCracking |
      | shlomchik    | 20561    | BWM            |
      | 1            | 952      | DNS            |
      | Seets_policy | 1        | Intrusions     |
    Then UI Total "Attack Categories by Bandwidth" legends equal to 9

  @SID_43
  Scenario: VRM - Validate Dashboards "Attack Categories by Bandwidth" Chart data with only one selected port
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1     |          |
      | 11    | 1     |          |
    Then UI Validate StackBar data with widget "Attack Categories by Bandwidth"
      | label | value  | legendName    |
      | BDOS  | 322056 | BehavioralDOS |
      | BDOS  | 226554 | DOSShield     |
    Then UI Total "Attack Categories by Bandwidth" legends equal to 2

  @SID_44
  Scenario: VRM - Validate Dashboards "Attack Categories by Bandwidth" Chart data with selected policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies   |
      | 10    |       | Black_IPV4 |
      | 11    |       | Black_IPV4 |
    Then UI Validate StackBar data with widget "Attack Categories by Bandwidth"
      | label      | value  | legendName |
      | Black_IPV4 | 874042 | ACL        |
    Then UI Total "Attack Categories by Bandwidth" legends equal to 1

  @SID_45
  Scenario: VRM - Validate Dashboards "Attack Categories by Bandwidth" Chart data with one selected port and policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1     | BDOS     |
      | 11    | 1     | BDOS     |
    * Sleep "2"
    Then UI Validate StackBar data with widget "Attack Categories by Bandwidth"
      | label | value  | legendName    |
      | BDOS  | 322056 | BehavioralDOS |
      | BDOS  | 226554 | DOSShield     |
    Then UI Total "Attack Categories by Bandwidth" legends equal to 2

  @SID_46
  Scenario: VRM - NEGATIVE: Validate Dashboards "Attack Categories by Bandwidth" Chart data doesn't exist for policy without relevant data
    Then UI Validate StackBar data with widget "Attack Categories by Bandwidth"
      | label        | value     | legendName     | exist |
      | Black_IPV6   | 103002084 | ACL            | false |
      | Black_IPV4   | 874042    | ACL            | false |
      | BDOS         | 322056    | BehavioralDOS  | true  |
      | POL_IPV6     | 51973572  | BehavioralDOS  | false |
      | policy1      | 279152    | SynFlood       | false |
      | BDOS         | 226554    | DOSShield      | true  |
      | policy1      | 19116     | Anti-Scanning  | false |
      | bbt-sc1      | 168216    | ServerCracking | false |
      | shlomchik    | 41122     | BWM            | false |
      | 1            | 1904      | DNS            | false |
      | Seets_policy | 2         | Intrusions     | false |
    Then UI Total "Attack Categories by Bandwidth" legends equal to 2

  @SID_47
  Scenario: VRM - NEGATIVE: Validate Dashboards "Attack Categories by Bandwidth" data doesn't exist for policy with traffic and port with no traffic
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1,3,4 |          |
      | 11    | 1,3,4 |          |
    Then UI Validate StackBar data with widget "Attack Categories by Bandwidth"
      | label      | value     | legendName    | exist |
      | Black_IPV6 | 103002084 | ACL           | false |
      | Black_IPV4 | 874042    | ACL           | false |
      | BDOS       | 322056    | BehavioralDOS | true  |
      | POL_IPV6   | 51973572  | BehavioralDOS | false |
    Then UI Total "Attack Categories by Bandwidth" legends equal to 3

  @SID_48
  Scenario: Attack Categories by Bandwidth Cleanup
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
    * UI Logout

      # ================= TOP ATTACKS DESTINATION ================= #

  @SID_49
  Scenario: Login
    When UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"

  @SID_50
  Scenario: VRM - Validate Dashboards "Top Attack Destination" chart data on All devices
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
      | 11    |       |          |
      | 12    |       |          |
    Then UI Validate Pie Chart data "Top Attack Destination"
      | label                                   | data |
      | 0.0.0.0                                 | 15   |
      | 1.1.1.10                                | 15   |
      | Multiple                                | 12   |
      | 1234:1234:1234:1234:1234:1234:1234:1235 | 12   |
      | 1.1.1.8                                 | 6    |
      | ::                                      | 6    |
      | 2000::0001                              | 6    |
      | 10.10.1.200                             | 6    |
      | 1.1.1.1                                 | 6    |
      | 30.1.1.10                               | 6    |

  @SID_51
  Scenario: VRM - Validate Dashboards "Top Attack Destination" chart data on one device
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Validate Pie Chart data "Top Attack Destination"
      | label                                   | data |
      | 0.0.0.0                                 | 5    |
      | 1.1.1.10                                | 5    |
      | Multiple                                | 4    |
      | 1234:1234:1234:1234:1234:1234:1234:1235 | 4    |
      | 1.1.1.8                                 | 2    |
      | ::                                      | 2    |
      | 2000::0001                              | 2    |
      | 10.10.1.200                             | 2    |
      | 1.1.1.1                                 | 2    |
      | 30.1.1.10                               | 2    |

  @SID_52
  Scenario: VRM - Validate Chart data for two selected DP machine filtered by ports
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1,3   |          |
      | 11    | 1,3   |          |
    Then UI Validate Pie Chart data "Top Attack Destination"
      | label        | data |
      | 1.1.1.1      | 2    |
      | 1.1.1.10     | 10   |
      | 1.1.1.8      | 4    |
      | 1.1.1.9      | 2    |
      | 10.10.1.200  | 2    |
      | 198.18.252.1 | 2    |

  @SID_53
  Scenario: VRM - Validate Chart data for one selected DP machine filtered by ports and policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1     | BDOS     |
    Then UI Validate Pie Chart data "Top Attack Destination"
      | label   | data |
      | 1.1.1.1 | 1    |
      | 1.1.1.8 | 2    |
      | 1.1.1.9 | 1    |

  @SID_54
  Scenario:  VRM - Validate Chart data for one selected DP machine filtered by policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | BDOS     |
    Then UI Validate Pie Chart data "Top Attack Destination"
      | label   | data |
      | 1.1.1.1 | 1    |
      | 0.0.0.0 | 1    |
      | 1.1.1.8 | 2    |
      | 1.1.1.9 | 1    |

  @SID_55
  Scenario: NEGATIVE - Validate Chart data doesn't exist for policy without relevant data
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | Policy15 |
    Then UI Validate Pie Chart data "Top Attack Destination"
      | label                                   | data | exist |
      | 0.0.0.0                                 | 5    | false |
      | 1.1.1.10                                | 5    | false |
      | Multiple                                | 4    | false |
      | 1234:1234:1234:1234:1234:1234:1234:1235 | 4    | false |
      | 1.1.1.8                                 | 2    | false |
      | ::                                      | 2    | false |
      | 2000::0001                              | 2    | false |
      | 10.10.1.200                             | 2    | false |
      | 1.1.1.1                                 | 2    | false |

  @SID_56
  Scenario: NEGATIVE - Validate Chart data doesn't exist for policy with traffic and port with no traffic
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1     | Policy15 |
    Then UI Validate Pie Chart data "Top Attack Destination"
      | label                                   | data | exist |
      | 0.0.0.0                                 | 5    | false |
      | 1.1.1.10                                | 5    | false |
      | Multiple                                | 4    | false |
      | 1234:1234:1234:1234:1234:1234:1234:1235 | 4    | false |
      | 1.1.1.8                                 | 2    | false |
      | ::                                      | 2    | false |
      | 2000::0001                              | 2    | false |
      | 10.10.1.200                             | 2    | false |
      | 1.1.1.1                                 | 2    | false |

  @SID_57
  Scenario: TOP ATTACKS DESTINATION Cleanup
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
    * UI Logout

      # ================= TOP ATTACKS ================= #

  @SID_58
  Scenario: Login
    When UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"

  @SID_59
  Scenario: VRM - Validate Dashboards "Top Attacks" Chart data for all DP machines
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
      | 11    |       |          |
      | 12    |       |          |
    Then UI Validate StackBar data with widget "Top Attacks"
      | label            | value | legendName                     |
      | shlomi           | 15    | TCP Mid Flow packet            |
      | Packet Anomalies | 9     | Incorrect IPv4 checksum        |
      | Paaaaaaaaaaaaaaa | 3     | Incorrect IPv4 checksum        |
      | 1                | 6     | DNS flood IPv4 DNS-A           |
      | BDOS             | 3     | DNS flood IPv4 DNS-A           |
      | shlomchik        | 9     | BWM Limit Alert                |
      | Black_IPV4       | 3     | Black List                     |
      | Black_IPV6       | 6     | Black List                     |
      | policy1          | 6     | TCP Scan (vertical)            |
      | BDOS             | 6     | DOSS-Anomaly-TCP-SYN-RST       |
      | policy1          | 6     | SYN Flood HTTP                 |
      | BDOS             | 3     | network flood IPv4 TCP-SYN-ACK |
      | pol_1            | 3     | network flood IPv4 TCP-SYN-ACK |
      | bdos1            | 3     | network flood IPv6 UDP-FRAG    |
      | DOSS             | 3     | network flood IPv6 UDP-FRAG    |
    Then UI Total "Top Attacks" legends equal to 10

  @SID_60
  Scenario: VRM - Validate Dashboards "Top Attacks" Chart data for one selected DP machine
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    * Sleep "2"
    Then UI Validate StackBar data with widget "Top Attacks"
      | label            | value | legendName                     |
      | shlomi           | 5     | TCP Mid Flow packet            |
      | Packet Anomalies | 3     | Incorrect IPv4 checksum        |
      | Paaaaaaaaaaaaaaa | 1     | Incorrect IPv4 checksum        |
      | 1                | 2     | DNS flood IPv4 DNS-A           |
      | BDOS             | 1     | DNS flood IPv4 DNS-A           |
      | shlomchik        | 3     | BWM Limit Alert                |
      | Black_IPV4       | 1     | Black List                     |
      | Black_IPV6       | 2     | Black List                     |
      | policy1          | 2     | TCP Scan (vertical)            |
      | BDOS             | 2     | DOSS-Anomaly-TCP-SYN-RST       |
      | policy1          | 2     | SYN Flood HTTP                 |
      | BDOS             | 1     | network flood IPv4 TCP-SYN-ACK |
      | pol_1            | 1     | network flood IPv4 TCP-SYN-ACK |
      | bdos1            | 1     | network flood IPv6 UDP-FRAG    |
      | DOSS             | 1     | network flood IPv6 UDP-FRAG    |

  @SID_61
  Scenario: VRM - Validate Dashboards "Top Attacks" Chart data for one selected port
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1     |          |
      | 11    | 1     |          |
    Then UI Validate StackBar data with widget "Top Attacks"
      | label  | value | legendName                     |
      | shlomi | 10    | TCP Mid Flow packet            |
      | BDOS   | 4     | DOSS-Anomaly-TCP-SYN-RST       |
      | BDOS   | 2     | tim                            |
      | BDOS   | 2     | network flood IPv4 TCP-SYN-ACK |

  @SID_62
  Scenario: VRM - Validate Dashboards "Top Attacks" Chart data for selected policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies                   |
      | 10    |       | BDOS,Black_IPV4,Black_IPV6 |
      | 11    |       | BDOS,Black_IPV4,Black_IPV6 |
    Then UI Validate StackBar data with widget "Top Attacks"
      | label      | value | legendName                     |
      | Black_IPV6 | 4     | Black List                     |
      | Black_IPV4 | 2     | Black List                     |
      | BDOS       | 4     | DOSS-Anomaly-TCP-SYN-RST       |
      | BDOS       | 2     | DNS flood IPv4 DNS-A           |
      | BDOS       | 2     | tim                            |
      | BDOS       | 2     | network flood IPv4 TCP-SYN-ACK |

  @SID_63
  Scenario: VRM - Validate Dashboards "Top Attacks" Chart data for selected port and policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies      |
      | 10    | 1     | BDOS,POL_IPV6 |
      | 11    | 1     | BDOS,POL_IPV6 |
    Then UI Validate StackBar data with widget "Top Attacks"
      | label | value | legendName                     |
      | BDOS  | 4     | DOSS-Anomaly-TCP-SYN-RST       |
      | BDOS  | 2     | tim                            |
      | BDOS  | 2     | network flood IPv4 TCP-SYN-ACK |

  @SID_64
  Scenario: VRM - NEGATIVE: Validate Dashboards "Top Attacks" Chart data doesn't exist for policy without relevant data
    Then UI Validate StackBar data with widget "Top Attacks"
      | label    | value | legendName                     | exist |
      | POL_IPV6 | 2     | network flood IPv6 UDP         | false |
      | POL_IPV6 | 2     | network flood IPv6 TCP-SYN-ACK | false |

  @SID_65
  Scenario: VRM - NEGATIVE: Validate Dashboards "Top Attacks" data doesn't exist for policy with traffic and port with no traffic
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 2     |          |
      | 11    | 2     |          |
    Then UI Validate StackBar data with widget "Top Attacks"
      | label  | value | legendName          | exist |
      | shlomi | 10    | TCP Mid Flow packet | false |

  @SID_66
  Scenario: Top Attacks Cleanup
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
    * UI Logout

      # ================= Top Attacks by Bandwidth ================= #

  @SID_67
  Scenario: Login
    When UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"

  @SID_68
  Scenario: VRM - Validate Dashboards "Top Attacks by Bandwidth" Chart data for all DP machines
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
      | 11    |       |          |
      | 12    |       |          |
    Then UI Validate StackBar data with widget "Top Attacks by Bandwidth"
      | label      | value     | legendName                     |
      | BDOS       | 483084    | network flood IPv4 TCP-SYN-ACK |
      | BDOS       | 339831    | DOSS-Anomaly-TCP-SYN-RST       |
      | policy1    | 418728    | SYN Flood HTTP                 |
      | policy1    | 28674     | TCP Scan (vertical)            |
      | bbt-sc1    | 252324    | Brute Force Web                |
      | POL_IPV6   | 38889231  | network flood IPv6 TCP-SYN-ACK |
      | POL_IPV6   | 39071127  | network flood IPv6 UDP         |
      | Black_IPV6 | 154503126 | Black List                     |
      | Black_IPV4 | 1311063   | Black List                     |
      | shlomchik  | 61683     | BWM Limit Alert                |
    Then UI Total "Top Attacks by Bandwidth" legends equal to 10

  @SID_69
  Scenario: VRM - Validate Dashboards "Top Attacks by Bandwidth" Chart data for one selected DP machine
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Validate StackBar data with widget "Top Attacks by Bandwidth"
      | label      | value    | legendName                     |
      | BDOS       | 161028   | network flood IPv4 TCP-SYN-ACK |
      | BDOS       | 113277   | DOSS-Anomaly-TCP-SYN-RST       |
      | policy1    | 139576   | SYN Flood HTTP                 |
      | policy1    | 9558     | TCP Scan (vertical)            |
      | bbt-sc1    | 84108    | Brute Force Web                |
      | POL_IPV6   | 12963077 | network flood IPv6 TCP-SYN-ACK |
      | POL_IPV6   | 13023709 | network flood IPv6 UDP         |
      | Black_IPV6 | 51501042 | Black List                     |
      | Black_IPV4 | 437021   | Black List                     |
      | shlomchik  | 20561    | BWM Limit Alert                |
    Then UI Total "Top Attacks by Bandwidth" legends equal to 10

  @SID_70
  Scenario: VRM - Validate Dashboards "Top Attacks by Bandwidth" Chart data for one selected port
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 4     |          |
      | 11    | 4     |          |
    Then UI Validate StackBar data with widget "Top Attacks by Bandwidth"
      | label   | value  | legendName      |
      | bbt-sc1 | 168216 | Brute Force Web |
    Then UI Total "Top Attacks by Bandwidth" legends equal to 1

  @SID_71
  Scenario: VRM - Validate Dashboards "Top Attacks by Bandwidth" Chart data for one selected policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | BDOS     |
      | 11    |       | BDOS     |
    Then UI Validate StackBar data with widget "Top Attacks by Bandwidth"
      | label | value  | legendName                     |
      | BDOS  | 322056 | network flood IPv4 TCP-SYN-ACK |
      | BDOS  | 226554 | DOSS-Anomaly-TCP-SYN-RST       |
    Then UI Total "Top Attacks by Bandwidth" legends equal to 2

  @SID_72
  Scenario: VRM - Validate Dashboards "Top Attacks by Bandwidth" Chart data for selected port and policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1,4   | BDOS     |
      | 11    | 1,4   | BDOS     |
    * Sleep "2"
    Then UI Validate StackBar data with widget "Top Attacks by Bandwidth"
      | label | value  | legendName                     |
      | BDOS  | 226554 | DOSS-Anomaly-TCP-SYN-RST       |
      | BDOS  | 322056 | network flood IPv4 TCP-SYN-ACK |
    Then UI Total "Top Attacks by Bandwidth" legends equal to 2

  @SID_73
  Scenario: VRM - NEGATIVE: Validate Dashboards "Top Attacks by Bandwidth" Chart data doesn't exist for policy without relevant data
    Then UI Validate StackBar data with widget "Top Attacks by Bandwidth"
      | label   | value  | legendName      | exist |
      | bbt-sc1 | 168216 | Brute Force Web | false |

  @SID_74
  Scenario: VRM - NEGATIVE: Validate Dashboards "Top Attacks by Bandwidth" data doesn't exist for policy with traffic and port with no traffic
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1     |          |
      | 11    | 1     |          |
    Then UI Validate StackBar data with widget "Top Attacks by Bandwidth"
      | label      | value     | legendName                     | exist |
      | policy1    | 279152    | SYN Flood HTTP                 | false |
      | policy1    | 19116     | TCP Scan (vertical)            | false |
      | bbt-sc1    | 168216    | Brute Force Web                | false |
      | POL_IPV6   | 26047418  | network flood IPv6 TCP-SYN-ACK | false |
      | POL_IPV6   | 25926154  | network flood IPv6 UDP         | false |
      | Black_IPV6 | 103002084 | Black List                     | false |
      | Black_IPV4 | 874042    | Black List                     | false |
      | shlomchik  | 41122     | BWM Limit Alert                | false |
      | 1          | 1904      | DNS flood IPv4 DNS-A           | false |

  @SID_75
  Scenario: Top Attacks by Bandwidth Cleanup
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
    * UI Logout

      # ================= TOP ATTACKS BY DURATION ================= #

  @SID_76
  Scenario: Login
    When UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
    And UI VRM Select Widgets
      | Top Attacks by Duration |


  @SID_77
  Scenario: VRM - Validate Dashboards "Top Attacks by Duration" Chart data for all DP machines
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
      | 11    |       |          |
      | 12    |       |          |
    Then UI Validate StackBar data with widget "Top Attacks by Duration-1"
      | label                          | value | legendName      |
      | Black List                     | 9     | Less than 1 min |
      | Incorrect IPv4 checksum        | 12    | Less than 1 min |
 #    | pkt_rate_lmt_9                 | 3     | Less than 1 min |
 #    | sign_seets3                    | 3     | Less than 1 min |
      | TCP Mid Flow packet            | 15    | Less than 1 min |
 #    | TCP Scan (vertical)            | 3     | Less than 1 min |
 #    | tim                            | 3     | Less than 1 min |
      | BWM Limit Alert                | 9     | Less than 1 min |
      | DNS flood IPv4 DNS-A           | 9     | Less than 1 min |
      | DOSS-Anomaly-TCP-SYN-RST       | 6     | Less than 1 min |
      | network flood IPv4 TCP-SYN-ACK | 6     | Less than 1 min |
 #    | network flood IPv6 TCP-SYN-ACK | 3     | Less than 1 min |
 #    | network flood IPv6 UDP         | 3     | Less than 1 min |
      | Brute Force Web                | 3     | Less than 1 min |
      | HTTP Page Flood Attack         | 3     | Less than 1 min |
      | network flood IPv6 UDP-FRAG    | 6     | Less than 1 min |
      | SYN Flood HTTP                 | 3     | 1-5 min         |
      | TCP Scan (vertical)            | 3     | 1-5 min         |
    Then UI Total "Top Attacks by Duration-1" legends equal to 2

  @SID_78
  Scenario: VRM - Validate Dashboards "Top Attacks by Duration" Chart data for one selected DP machine
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Validate StackBar data with widget "Top Attacks by Duration-1"
      | label                          | value | legendName      |
      | Black List                     | 3     | Less than 1 min |
      | Incorrect IPv4 checksum        | 4     | Less than 1 min |
   #  | pkt_rate_lmt_9                 | 1     | Less than 1 min |
   #  | sign_seets3                    | 1     | Less than 1 min |
      | TCP Mid Flow packet            | 5     | Less than 1 min |
   #  | TCP Scan (vertical)            | 1     | Less than 1 min |
   #  | tim                            | 1     | Less than 1 min |
      | BWM Limit Alert                | 3     | Less than 1 min |
      | DNS flood IPv4 DNS-A           | 3     | Less than 1 min |
      | DOSS-Anomaly-TCP-SYN-RST       | 2     | Less than 1 min |
      | network flood IPv4 TCP-SYN-ACK | 2     | Less than 1 min |
   #  | network flood IPv6 TCP-SYN-ACK | 1     | Less than 1 min |
   #  | network flood IPv6 UDP         | 1     | Less than 1 min |
      | Brute Force Web                | 1     | Less than 1 min |
      | HTTP Page Flood Attack         | 1     | Less than 1 min |
      | network flood IPv6 UDP-FRAG    | 2     | Less than 1 min |
      | SYN Flood HTTP                 | 1     | 1-5 min         |
      | TCP Scan (vertical)            | 1     | 1-5 min         |
    Then UI Total "Top Attacks by Duration-1" legends equal to 2

  @SID_79
  Scenario: VRM - Validate Dashboards "Top Attacks by Duration" Chart data for one selected port
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1,3   |          |
    Then UI Validate StackBar data with widget "Top Attacks by Duration-1"
      | label                          | value | legendName      |
      | DOSS-Anomaly-TCP-SYN-RST       | 2     | Less than 1 min |
      | network flood IPv4 TCP-SYN-ACK | 1     | Less than 1 min |
      | pkt_rate_lmt_9                 | 1     | Less than 1 min |
      | TCP Mid Flow packet            | 5     | Less than 1 min |
      | tim                            | 1     | Less than 1 min |
      | TCP Scan (vertical)            | 1     | 1-5 min         |
    Then UI Total "Top Attacks by Duration-1" legends equal to 2

  @SID_80
  Scenario: VRM - Validate Dashboards "Top Attacks by Duration" Chart data for one selected policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | BDOS     |
    Then UI Validate StackBar data with widget "Top Attacks by Duration-1"
      | label                          | value | legendName      |
      | tim                            | 1     | Less than 1 min |
      | DOSS-Anomaly-TCP-SYN-RST       | 2     | Less than 1 min |
      | network flood IPv4 TCP-SYN-ACK | 1     | Less than 1 min |
      | DNS flood IPv4 DNS-A           | 1     | Less than 1 min |
    Then UI Total "Top Attacks by Duration-1" legends equal to 1

  @SID_81
  Scenario: VRM - Validate Dashboards "Top Attacks by Duration" Chart data for selected port and policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1     | BDOS     |
    Then UI Validate StackBar data with widget "Top Attacks by Duration-1"
      | label                          | value | legendName      |
      | tim                            | 1     | Less than 1 min |
      | DOSS-Anomaly-TCP-SYN-RST       | 2     | Less than 1 min |
      | network flood IPv4 TCP-SYN-ACK | 1     | Less than 1 min |
    Then UI Total "Top Attacks by Duration-1" legends equal to 1

  @SID_82
  Scenario: VRM - NEGATIVE: Validate Dashboards "Top Attacks by Duration" Chart data doesn't exist for policy without relevant data
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | Maxim31  |
    Then UI Validate StackBar data with widget "Top Attacks by Duration-1"
      | label                          | value | legendName      | exist |
      | Black List                     | 1     | Less than 1 min | false |
      | Brute Force Web                | 1     | Less than 1 min | false |
      | BWM Limit Alert                | 3     | Less than 1 min | false |
      | DNS flood IPv4 DNS-A           | 2     | Less than 1 min | false |
      | DOSS-Anomaly-TCP-SYN-RST       | 2     | Less than 1 min | false |
      | HTTP Page Flood Attack         | 1     | Less than 1 min | false |
      | network flood IPv6 TCP-SYN-ACK | 1     | Less than 1 min | false |
      | network flood IPv6 UDP         | 1     | Less than 1 min | false |
      | network flood IPv6 UDP-FRAG    | 1     | Less than 1 min | false |
      | sign_seets3                    | 1     | Less than 1 min | false |
      | SYN Flood HTTP                 | 2     | Less than 1 min | false |
      | TCP Scan (vertical)            | 2     | Less than 1 min | false |
      | Black List                     | 2     | 1-5 min         | false |
      | TCP Mid Flow packet            | 5     | 1-5 min         | false |
      | DNS flood IPv4 DNS-A           | 1     | 5-10 min        | false |
      | Incorrect IPv4 checksum        | 1     | 5-10 min        | false |
      | Incorrect IPv4 checksum        | 3     | 10-30 min       | false |
      | network flood IPv4 TCP-SYN-ACK | 1     | 10-30 min       | false |
      | pkt_rate_lmt_9                 | 1     | 10-30 min       | false |
      | tim                            | 1     | 10-30 min       | false |
      | network flood IPv4 TCP-SYN-ACK | 1     | 30-60 min       | false |
      | network flood IPv6 UDP-FRAG    | 1     | 30-60 min       | false |

  @SID_83
  Scenario: VRM - NEGATIVE: Validate Dashboards "Top Attacks by Duration" data doesn't exist for policy with traffic and port with no traffic
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 3     | BDOS     |
    Then UI Validate StackBar data with widget "Top Attacks by Duration-1"
      | label                          | value | legendName      | exist |
      | DOSS-Anomaly-TCP-SYN-RST       | 2     | Less than 1 min | false |
      | DNS flood IPv4 DNS-A           | 1     | 5-10 min        | false |
      | network flood IPv4 TCP-SYN-ACK | 1     | 10-30 min       | false |

  @SID_84
  Scenario: Top Attacks by Duration Cleanup
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
    * UI Logout

      # ================= Top Attacks by Protocol ================= #

  @SID_85
  Scenario: Login
    When UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"

  @SID_86
  Scenario: VRM - Validate Dashboards "Top Attacks by Protocol" Chart data for all DP machines
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
      | 11    |       |          |
      | 12    |       |          |
    Then UI Validate StackBar data with widget "Top Attacks by Protocol"
      | legendName | value | label                          | exist |
      | TCP        | 3     | tim                            | true  |
      | TCP        | 6     | network flood IPv4 TCP-SYN-ACK | true  |
      | TCP        | 6     | SYN Flood HTTP                 | true  |
      | TCP        | 15    | TCP Mid Flow packet            | true  |
      | TCP        | 6     | TCP Scan (vertical)            | true  |
      | TCP        | 3     | Brute Force Web                | true  |
      | TCP        | 6     | DOSS-Anomaly-TCP-SYN-RST       | true  |
      | TCP        | 3     | HTTP Page Flood Attack         | true  |
      | TCP        | 3     | network flood IPv6 TCP-SYN-ACK | true  |
     #| TCP        | 3     | pkt_rate_lmt_9                 | true  |
      | TCP        | 3     | sign_seets3                    | true  |
      | IP         | 12    | Incorrect IPv4 checksum        | true  |
      | IP         | 9     | BWM Limit Alert                | true  |
      | IP         | 9     | Black List                     | true  |
      | UDP        | 9     | DNS flood IPv4 DNS-A           | true  |
      | UDP        | 6     | network flood IPv6 UDP-FRAG    | true  |
      | UDP        | 3     | network flood IPv6 UDP         | true  |
    Then UI Total "Top Attacks by Protocol" legends equal to 3

  @SID_87
  Scenario: VRM - Validate Dashboards "Top Attacks by Protocol" Chart data for one DP machines
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 11    |       |          |
    Then UI Validate StackBar data with widget "Top Attacks by Protocol"
      | legendName | value | label                          | exist |
      | TCP        | 1     | Brute Force Web                | true  |
      | TCP        | 2     | DOSS-Anomaly-TCP-SYN-RST       | true  |
      | TCP        | 1     | HTTP Page Flood Attack         | true  |
      | TCP        | 2     | network flood IPv4 TCP-SYN-ACK | true  |
      | TCP        | 1     | network flood IPv6 TCP-SYN-ACK | true  |
    # | TCP        | 1     | pkt_rate_lmt_9                 | true  |
      | TCP        | 1     | sign_seets3                    | true  |
      | TCP        | 2     | SYN Flood HTTP                 | true  |
      | TCP        | 5     | TCP Mid Flow packet            | true  |
      | TCP        | 2     | TCP Scan (vertical)            | true  |
      | TCP        | 1     | tim                            | true  |
      | IP         | 4     | Incorrect IPv4 checksum        | true  |
      | IP         | 3     | BWM Limit Alert                | true  |
      | IP         | 3     | Black List                     | true  |
      | UDP        | 3     | DNS flood IPv4 DNS-A           | true  |
      | UDP        | 2     | network flood IPv6 UDP-FRAG    | true  |
      | UDP        | 1     | network flood IPv6 UDP         | true  |
    Then UI Total "Top Attacks by Protocol" legends equal to 3

  @SID_88
  Scenario:  VRM - Validate Chart data for one selected DP machine filtered by policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | BDOS     |
    Then UI Validate StackBar data with widget "Top Attacks by Protocol"
      | legendName | value | label                          | exist |
      | TCP        | 2     | DOSS-Anomaly-TCP-SYN-RST       | true  |
      | TCP        | 1     | network flood IPv4 TCP-SYN-ACK | true  |
      | TCP        | 1     | tim                            | true  |
      | UDP        | 1     | DNS flood IPv4 DNS-A           | true  |

  @SID_89
  Scenario: VRM - Validate Chart data for two selected DP machine filtered by ports
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1,3   |          |
      | 11    | 1,3   |          |
    * Sleep "2"
    Then UI Validate StackBar data with widget "Top Attacks by Protocol"
      | legendName | value | label                          | exist |
      | TCP        | 10    | TCP Mid Flow packet            | true  |
      | TCP        | 4     | DOSS-Anomaly-TCP-SYN-RST       | true  |
      | TCP        | 2     | network flood IPv4 TCP-SYN-ACK | true  |
      | TCP        | 2     | pkt_rate_lmt_9                 | true  |
      | TCP        | 2     | TCP Scan (vertical)            | true  |
      | TCP        | 2     | tim                            | true  |

  @SID_90
  Scenario: VRM - Validate Chart data for two selected DP machine filtered by ports and policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1,3   | BDOS     |
    * Sleep "2"
    Then UI Validate StackBar data with widget "Top Attacks by Protocol"
      | legendName | value | label                          | exist |
      | TCP        | 2     | DOSS-Anomaly-TCP-SYN-RST       | true  |
      | TCP        | 1     | network flood IPv4 TCP-SYN-ACK | true  |
      | TCP        | 1     | tim                            | true  |

  @SID_91
  Scenario: NEGATIVE - Validate Chart data doesn't exist for policy without relevant data
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | 1234     |
    Then  UI Validate StackBar data with widget "Top Attacks by Protocol"
      | legendName | value | label                          | exist |
      | TCP        | 2     | DOSS-Anomaly-TCP-SYN-RST       | false |
      | TCP        | 2     | network flood IPv4 TCP-SYN-ACK | false |
      | TCP        | 2     | SYN Flood HTTP                 | false |
      | TCP        | 5     | TCP Mid Flow packet            | false |
      | TCP        | 2     | TCP Scan (vertical)            | false |
      | IP         | 4     | Incorrect IPv4 checksum        | false |
      | IP         | 3     | BWM Limit Alert                | false |
      | IP         | 3     | Black List                     | false |
      | UDP        | 3     | DNS flood IPv4 DNS-A           | false |
      | UDP        | 2     | network flood IPv6 UDP-FRAG    | false |
      | UDP        | 1     | network flood IPv6 UDP         | false |

  @SID_92
  Scenario: NEGATIVE - Validate Chart data doesn't exist for policy with traffic and port with no traffic
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1     | 1234     |
    Then  UI Validate StackBar data with widget "Top Attacks by Protocol"
      | legendName | value | label                          | exist |
      | TCP        | 2     | DOSS-Anomaly-TCP-SYN-RST       | false |
      | TCP        | 2     | network flood IPv4 TCP-SYN-ACK | false |
      | TCP        | 2     | SYN Flood HTTP                 | false |
      | TCP        | 5     | TCP Mid Flow packet            | false |
      | TCP        | 2     | TCP Scan (vertical)            | false |
      | IP         | 4     | Incorrect IPv4 checksum        | false |
      | IP         | 3     | BWM Limit Alert                | false |
      | IP         | 3     | Black List                     | false |
      | UDP        | 3     | DNS flood IPv4 DNS-A           | false |
      | UDP        | 2     | network flood IPv6 UDP-FRAG    | false |
      | UDP        | 1     | network flood IPv6 UDP         | false |

  @SID_93
  Scenario: Top Attacks by Protocol Cleanup
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
    * UI Logout

      # ================= TOP ATTACKS SOURCES ================= #

  @SID_94
  Scenario: Login
    When UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"

  @SID_95
  Scenario: VRM - Validate Dashboards "Top Attack Sources" Chart data for all DP machines
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
      | 11    |       |          |
      | 12    |       |          |
    Then UI Validate Pie Chart data "Top Attack Sources"
      | label                                   | data |
      | 192.85.1.2                              | 24   |
      | 0.0.0.0                                 | 18   |
      | Multiple                                | 18   |
      | 1234:1234:1234:1234:1234:1234:1234:1234 | 12   |
      | 192.85.1.8                              | 6    |
      | ::                                      | 6    |
      | 197.1.1.1                               | 6    |

  @SID_96
  Scenario:  VRM - Validate Dashboards "Top Attack Sources" Chart data for one selected DP machine
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Validate Pie Chart data "Top Attack Sources"
      | label                                   | data |
      | 192.85.1.2                              | 8    |
      | 0.0.0.0                                 | 6    |
      | Multiple                                | 6    |
      | 1234:1234:1234:1234:1234:1234:1234:1234 | 4    |
      | 192.85.1.8                              | 2    |
      | ::                                      | 2    |
      | 197.1.1.1                               | 2    |

  @SID_97
  Scenario: VRM - Validate Dashboards "Top Attack Sources" Chart data for selected port
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 3     |          |
      | 11    | 3     |          |
    Then UI Validate Pie Chart data "Top Attack Sources"
      | label      | data |
      | 198.18.0.1 | 2    |
      | 192.85.1.2 | 2    |

  @SID_98
  Scenario:VRM - Validate Dashboards "Top Attack Sources" Chart data for selected policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies               |
      | 10    |       | Black_IPV4, Black_IPV6 |
      | 11    |       | Black_IPV4, Black_IPV6 |
    Then UI Validate Pie Chart data "Top Attack Sources"
      | label                                   | data |
      | 1234:1234:1234:1234:1234:1234:1234:1234 | 4    |
      | 1.1.1.1                                 | 2    |

  @SID_99
  Scenario: VRM - Validate Dashboards "Top Attack Sources" Chart data for selected port and policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1     | BDOS     |
      | 11    | 1     | BDOS     |
    Then UI Validate Pie Chart data "Top Attack Sources"
      | label       | data |
      | 192.85.1.8  | 4    |
      | 192.85.1.2  | 2    |
      | 192.85.1.77 | 2    |

  @SID_100
  Scenario: VRM - NEGATIVE: Validate Dashboards "Top Attack Sources" Chart data doesn't exist for policy without relevant data
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1     | bdos1    |
      | 11    | 1     | bdos1    |
    Then UI Validate Pie Chart data "Top Attack Sources"
      | label       | data | exist |
      | 192.85.1.8  | 4    | false |
      | 192.85.1.2  | 2    | false |
      | 192.85.1.77 | 2    | false |

  @SID_101
  Scenario: VRM - NEGATIVE: Validate Dashboards "Top Attack Sources" data doesn't exist for policy with traffic and port with no traffic
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 3     | BDOS     |
      | 11    | 3     | BDOS     |
    Then UI Validate Pie Chart data "Top Attack Sources"
      | label       | data | exist |
      | 192.85.1.8  | 4    | false |
      | 192.85.1.2  | 2    | false |
      | 192.85.1.77 | 2    | false |

  @SID_102
  Scenario: Top Attack Sources Cleanup
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
    * UI Logout

      # ================= TOP FORWARDED ATTACK SOURCES ================= #

  @SID_103
  Scenario: Login
    When UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"

  @SID_104
  Scenario: VRM - Validate Dashboards "Top Forwarded Attack Sources" Chart data for all DP machines
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
      | 11    |       |          |
      | 12    |       |          |
    Then UI Validate Pie Chart data "Top Forwarded Attack Sources"
      | label      | data |
      | ::         | 6    |
      | 0.0.0.0    | 3    |
      | 197.1.1.1  | 3    |
      | 198.18.0.1 | 3    |

  @SID_105
  Scenario: VRM - Validate Dashboards "Top Forwarded Attack Sources" Chart data for one selected DP machine
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Validate Pie Chart data "Top Forwarded Attack Sources"
      | label      | data |
      | ::         | 2    |
      | 0.0.0.0    | 1    |
      | 197.1.1.1  | 1    |
      | 198.18.0.1 | 1    |

  @SID_106
  Scenario: VRM - Validate Dashboards "Top Forwarded Attack Sources" Chart data for one selected port
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 3     |          |
    Then UI Validate Pie Chart data "Top Forwarded Attack Sources"
      | label      | data |
      | 198.18.0.1 | 1    |

  @SID_107
  Scenario: VRM - Validate Dashboards "Top Forwarded Attack Sources" Chart data for one selected policy
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | BDOS     |
    Then UI Validate Pie Chart data "Top Forwarded Attack Sources"
      | label   | data |
      | 0.0.0.0 | 1    |

  @SID_108
  Scenario: VRM - Validate Dashboards "Top Forwarded Attack Sources" Chart data for one selected port and policy
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies           |
      | 10    | 3     | pph_9Pkt_lmt_252.1 |
    Then UI Validate Pie Chart data "Top Forwarded Attack Sources"
      | label      | data |
      | 198.18.0.1 | 1    |

  @SID_109
  Scenario: VRM - NEGATIVE: Validate Dashboards "Top Forwarded Attack Sources" Chart data doesn't exist for policy without relevant data
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | BDOS     |
    Then UI Validate Pie Chart data "Top Forwarded Attack Sources"
      | label      | data | exist |
      | ::         | 2    | false |
      | 197.1.1.1  | 2    | false |
      | 198.18.0.1 | 1    | false |

  @SID_110
  Scenario: VRM - NEGATIVE: Validate Dashboards "Top Forwarded Attack Sources" data doesn't exist for policy with traffic and port with no traffic
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 6     | BDOS     |
    Then UI Validate Pie Chart data "Top Forwarded Attack Sources"
      | label      | data | exist |
      | 2.0.0.2    | 1    | false |
      | 192.85.1.3 | 1    | false |
      | 195.18.0.1 | 1    | false |

  @SID_111
  Scenario: Top Forwarded Attack Sources Cleanup
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
    * UI Logout

      # ================= TOP PROBED IP ADDRESSES ================= #

  @SID_112
  Scenario: Login
    When UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
    And UI VRM Select Widgets
      | Top Probed IP Addresses |


  @SID_113
  Scenario: VRM - Validate Dashboards "Top Probed IP Addresses" Chart data for all DP machines
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
      | 11    |       |          |
      | 12    |       |          |
    Then UI Validate Pie Chart data "Top Probed IP Addresses-1"
      | label       | data |
      | 10.10.1.200 | 6    |

  @SID_114
  Scenario: VRM - Validate Dashboards "Top Probed IP Addresses" Chart data for one selected DP machine
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Validate Pie Chart data "Top Probed IP Addresses-1"
      | label       | data |
      | 10.10.1.200 | 2    |

  @SID_115
  Scenario: VRM - Validate Dashboards "Top Probed IP Addresses" Chart data for selected port
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 3     |          |
      | 11    | 3     |          |
    Then UI Validate Pie Chart data "Top Probed IP Addresses-1"
      | label       | data |
      | 10.10.1.200 | 2    |

  @SID_116
  Scenario: VRM - Validate Dashboards "Top Probed IP Addresses" Chart data for selected port and policies
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 3     | policy1  |
      | 11    | 3     | policy1  |
    Then UI Validate Pie Chart data "Top Probed IP Addresses-1"
      | label       | data |
      | 10.10.1.200 | 2    |

  @SID_117
  Scenario: VRM - NEGATIVE: Validate Dashboards "Top Probed IP Addresses" data doesn't exist for policy with traffic and port with no traffic
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 1     |          |
      | 11    | 1     |          |
    Then UI Validate Pie Chart data "Top Probed IP Addresses-1"
      | label       | data | exist |
      | 10.10.1.200 | 2    | false |

  @SID_118
  Scenario: Top Probed IP Addresses Cleanup
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
    * UI Logout

      # ================= TOP SCANNERS ================= #

  @SID_119
  Scenario: Login
    When UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"

  @SID_120
  Scenario: VRM - Validate Dashboards "Top Scanners" Chart data for all DP machines
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
      | 11    |       |          |
      | 12    |       |          |
    Then UI Validate Pie Chart data "Top Scanners"
      | label      | data |
      | 192.85.1.2 | 6    |

  @SID_121
  Scenario: VRM - Validate Dashboards "Top Scanners" Chart data for one selected DP machine
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Validate Pie Chart data "Top Scanners"
      | label      | data |
      | 192.85.1.2 | 2    |

  @SID_122
  Scenario: VRM - Validate Dashboards "Top Scanners" Chart data for one selected port
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 3     |          |
      | 11    | 3     |          |
    Then UI Validate Pie Chart data "Top Scanners"
      | label      | data |
      | 192.85.1.2 | 2    |

  @SID_123
  Scenario: VRM - Validate Dashboards "Top Scanners" Chart data for one selected policy
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | policy1  |
      | 11    |       | policy1  |
    Then UI Validate Pie Chart data "Top Scanners"
      | label      | data |
      | 192.85.1.2 | 4    |

  @SID_124
  Scenario: VRM - Validate Dashboards "Top Scanners" Chart data for one selected port and policy
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 3     | policy1  |
      | 11    | 3     | policy1  |
    Then UI Validate Pie Chart data "Top Scanners"
      | label      | data |
      | 192.85.1.2 | 2    |

  @SID_125
  Scenario: VRM - NEGATIVE: Validate Dashboards "Top Scanners" Chart data doesn't exist for policy without relevant data
    Then UI Validate Pie Chart data "Top Scanners"
      | label     | data | exist |
      | 197.1.1.1 | 2    | false |

  @SID_126
  Scenario: VRM - NEGATIVE: Validate Dashboards "Top Scanners" data doesn't exist for policy with traffic and port with no traffic
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 8     |          |
      | 11    | 8     |          |
    Then UI Validate Pie Chart data "Top Scanners"
      | label      | data | exist |
      | 192.85.1.2 | 2    | false |

  @SID_127
  Scenario: Top Attacks Scanners Cleanup
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
    * UI Logout

  @Sanity @SID_128
  Scenario: Sanity
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI simulate 1 attacks of type "rest_anomalies" on "DefensePro" 10
    * CLI simulate 1 attacks of type "rest_intrusion" on "DefensePro" 10 and wait 30 seconds
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    Then Sleep "5"
    Then UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Validate StackBar data with widget "Top Attacks"
      | label            | value | legendName              |
      | Packet Anomalies | 1     | Incorrect IPv4 checksum |
      | BDOS             | 1     | tim                     |
    Then UI Total "Top Attacks" legends equal to 2

  @Sanity @SID_129
  Scenario: Stop attack and search for bad logs
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |

  @Sanity @SID_130
  Scenario: Cleanup
    Given UI logout and close browser
