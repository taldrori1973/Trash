@TC126163
Feature: BDoS Attack Lifecycle


  @SID_1_Pre-requisites
  Scenario: Clean system data before concurrent connection test
    When CLI Operations - Run Radware Session command "net firewall open-port set 5140 open"
    When CLI Operations - Run Radware Session command "net firewall open-port set 9200 open"
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * REST Delete ES index "adc-*"
    * CLI Clear vision logs


#
  @SID_2_RunTraffic
  Scenario: Run DP simulator PCAPs


#    Given CLI simulate 1000 attacks of type "many_attacks" on SetId "DefensePro_Set_9" and wait 90 seconds
#    Given CLI simulate 1 attacks of type "MR_150pol_10attacks_interval5" on SetId "DefensePro_Set_8" and wait 90 seconds
#    Given CLI simulate 1 attacks of type "MR_200_war" on SetId "DefensePro_Set_8" and wait 90 seconds
    Given CLI simulate 2 attacks of type "vrm_bdos" on SetId "DefensePro_Set_1" and wait 90 seconds

#    Given CLI simulate 100 attacks of type "baselines_pol_1" on SetId "DefensePro_Set_8" and wait 90 seconds

  @SID_3_NavigatetoPage
  Scenario: Navigate to the BDoS page
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Attack Category" findBy cellValue "Behavioral DoS"
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Behavioral DoS"
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack Name" findBy cellValue "network flood IPv4 TCP-SYN-ACK"

#  @SID_6_ValidateTopBand
#  Scenario: Validate Top Band
#    Then UI Validate Text field "topBand.Device" EQUALS "90.110-DP"
#    Then UI Validate Text field "topBand.PolicyName" EQUALS "net202DNSserver"
#    Then UI Validate Text field "topBand.AttackName" EQUALS "network flood IPv4 TCP-SYN-ACK"


  @SID_4_ValidateInfoCard

  Scenario: Validate info card data - BDOS
    Then UI Validate Text field "Info.Protocol" EQUALS "Protocol: TCP"
    Then UI Validate Text field "Info.Total packets" On Regex "Total Packets: (\d+,\d+)" GTE "322982"
    Then UI Validate Text field "Info.Volume" EQUALS "Volume: 41.22 MB"
    Then UI Validate Text field "Info.Physical Port" EQUALS "Physical Port: 1"
    Then UI Validate Text field "Info.Device IP" EQUALS "Device IP Address: 172.16.22.50"
    Then UI Validate Text field "Info.MaxBps" On Regex "Max bps: (\d+,\d+,\d+)" GTE "1152000"
    Then UI Validate Text field "Info.Maxpps" On Regex "Max pps: (\d+,\d+)" GTE "1126"
    Then UI Validate Text field "Info.Description" EQUALS "No Description"
    Then UI Validate Text field "Info.Direction" EQUALS "Direction:In"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Real-Time Signature Blocking"


    Then UI Validate Table record values by columns with elementLabel "Characteristics.Attack Identification Statistics" findBy index 0

      | columnName  | value         |
      | Type        | Normal (Kbps) |
      | SYN In      | 96            |
      | SYN Out     | 96            |
      | RST In      | 193           |
      | RST Out     | 193           |
      | FIN ACK In  | 96            |
      | FIN ACK Out | 96            |
      | SYN ACK In  | 96            |
      | FIN ACK Out | 96            |
      | FRAG In     | 204           |
      | FRAG Out    | 96            |

#    Then UI Validate Table record values by columns with elementLabel "Characteristics.Attack Identification Statistics" findBy index 1
#
#      | columnName  | value          |
#      | Type        | Anomaly (Kbps) |
#      | SYN In      | 0              |
#      | SYN Out     | 0              |
#      | RST In      | 0              |
#      | RST Out     | 0              |
#      | FIN ACK In  | 0              |
#      | FIN ACK Out | 0              |
#      | SYN ACK In  | 3351           |
#      | SYN ACK Out | 0              |
#      | FRAG In     | 0              |
#      | FRAG Out    | 0              |

#    Then UI Validate Table record values by columns with elementLabel "Characteristics.Attack Identification Statistics" findBy index 2
#
#      | columnName  | value                |
#      | Type        | Normal (Packets/Sec) |
#      | SYN In      | 189                  |
#      | SYN Out     | 189                  |
#      | RST In      | 403                  |
#      | RST Out     | 403                  |
#      | FIN ACK In  | 202                  |
#      | FIN ACK Out | 202                  |
#      | SYN ACK In  | 195                  |
#      | SYN ACK Out | 195                  |
#      | FRAG In     | 24                   |
#      | FRAG Out    | 24                   |
#
#    Then UI Validate Table record values by columns with elementLabel "Characteristics.Attack Identification Statistics" findBy index 3
#
#      | columnName  | value                 |
#      | Type        | Anomaly (Packets/Sec) |
#      | SYN In      | 0                     |
#      | SYN Out     | 0                     |
#      | RST In      | 0                     |
#      | RST Out     | 0                     |
#      | FIN ACK In  | 0                     |
#      | FIN ACK Out | 0                     |
#      | SYN ACK In  | 3379                  |
#      | SYN ACK Out | 0                     |
#      | FRAG In     | 0                     |
#      | FRAG Out    | 0                     |


  @SID_8_ValidateBDoSLifecycleChart
  Scenario: BDoS lifecycle
    Then UI Validate Line Chart data "BDoS Attack Life Cycle" with Label "Real-Time Signature (RTS)"
      | value | min |
      | 1125  | 5   |

    Then UI Validate Line Chart data "BDoS Attack Life Cycle" with Label "Real-Time Signature (RTS)"
      | value | min |
      | 866.5   | 1   |

    Then UI Validate Line Chart data "BDoS Attack Life Cycle" with Label "Real-Time Signature (RTS)"
      | value | min |
      | 952.6666666666666   | 1   |

  Scenario: RTS validation
    Then UI Validate Line Chart attribute "rts" with index "0" in data in chart "BDoS Attack Life Cycle"
      | type  | oper | param           | values |
      | INNER | OR   | sequence-number | 123456 |
#      | type  | oper |
#      | OUTER | OR   |

  Scenario: DDoS-TCp SYN ACK chart validation
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Legitimate Traffic"
      | value | min |
      | 3351  | 1   |

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Total Traffic"
      | value | min |
      | 3456  | 1   |

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Normal Edge"
      | value | min |
      | 96    | 1   |

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Suspected Edge"
      | value | min |
      | 105   | 1   |

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Attack Edge"
      | value | min |
      | 115   | 1   |

#  @SID_9_ValidateDroppedPackets
#  Scenario: Validate Dropped Packets table
#    Then UI Validate Table record values by columns with elementLabel "Characteristics.DroppedPackets" findBy index 0
#      | columnName  | value           |
#      | Source      | 192.85.1.2:1024 |
#      | Destination | 1.1.1.1:1025    |
#      | Protocol    | TCP             |
#
#  @SID_10_ValidateTopAttackSources
#  Scenario: Validate Top Attack Sources
#    Then UI Text of "TOP ATTACK SOURCES.IP" with extension "0" equal to "192.85.1.2"
#    Then UI Text of "TOP ATTACK SOURCES.Percentage" with extension "0" equal to "100.00%"
#
#  @SID_11_ValidateAttackLog
#  Scenario: Validate Attack Log card data - BDOS
#    Then UI Text of "Attack Log" with extension "0" contains "Attack Ongoing"

  @SID_12_CleanUp
  Scenario: cleanup
    Then UI close browser
#    Then CLI kill all simulator attacks on current vision