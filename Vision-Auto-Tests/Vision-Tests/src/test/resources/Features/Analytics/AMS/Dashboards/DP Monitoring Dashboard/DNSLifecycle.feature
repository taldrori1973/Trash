#@Debug1
@TC126164
Feature: DNS Attack lifecycle


  @SID_1_Pre-requisites
  Scenario: Clean system data before concurrent connection test
    When CLI Operations - Run Radware Session command "net firewall open-port set 5140 open"
    When CLI Operations - Run Radware Session command "net firewall open-port set 9200 open"
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * REST Delete ES index "adc-*"
#    * CLI Clear vision logs


  @SID_2_RunTraffic
  Scenario: Run DP simulator PCAPs
#   Given CLI simulate 2 attacks of type "rest_DNS_NEW" on SetId "DefensePro_Set_9" and wait 90 seconds
    Given CLI simulate 2 attacks of type "DNS_99_subdomains" on SetId "DefensePro_Set_1" and wait 180 seconds
    * CLI kill all simulator attacks on current vision

  @SID_3_NavigatetoPage
  Scenario: Navigate to the DNS page
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Attack Category" findBy cellValue "DNS Flood"
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DNS Flood"
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack Name" findBy cellValue "DNS flood IPv4 DNS-A"

#  @SID_6_ValidateTopBand
#  Scenario: Validate Top Band
#    Then UI Validate Text field "topBand.Device" EQUALS "90.110-DP"
#    Then UI Validate Text field "topBand.PolicyName" EQUALS "net202DNSserver"
#    Then UI Validate Text field "topBand.AttackName" EQUALS "DNS flood IPv4 DNS-A"


  @SID_7_ValidateInfoCard

  Scenario: Validate info card data
    Then UI Validate Text field "Info.Protocol" EQUALS "Protocol: UDP"
    Then UI Validate Text field "Info.Total packets" On Regex "Total Packets: (\d+,\d+,\d+)" GTE "46163500"
    Then UI Validate Text field "Info.Volume" EQUALS "Volume: 4.33 GB"
    Then UI Validate Text field "Info.Physical Port" EQUALS "Physical Port: 1"
    Then UI Validate Text field "Info.Device IP" EQUALS "Device IP Address: 172.16.22.50"
    Then UI Validate Text field "Info.MaxBps" On Regex "Max bps: (\d+,\d+,\d+)" GTE "110995456"
    Then UI Validate Text field "Info.Maxpps" On Regex "Max pps: (\d+,\d+)" GTE "163229"
    Then UI Validate Text field "Info.Description" EQUALS "No Description"
    Then UI Validate Text field "Info.Direction" EQUALS "Direction:In"
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Real-Time Signature Rate Limit"

#    Then UI Text of "Characteristics.whitelist_0" equal to "mydomain.com"
#    Then UI Text of "Characteristics.whitelist_1" equal to "mail.mydomain.com"
#    Then UI Text of "Characteristics.whitelist_2" equal to "support.mydomain.com"
#    Then UI Text of "Characteristics.whitelist_3" equal to "sana.mydomain.com"
#    Then UI Text of "Characteristics.whitelist_4" equal to "wwrflqemg6d5.mydomain.com"



  @SID_8_ValidateBDoSLifecycleChart
  Scenario: DNS Attack lifecycle
    Then UI Validate Line Chart data "DNS Attack Life Cycle" with Label "Real-Time Signature (RTS)"
      | value   | min |
      | 73102.0 | 1   |

    Then UI Validate Line Chart data "DNS Attack Life Cycle" with Label "Real-Time Signature (RTS)"
      | value   | min |
      | 72069.5 | 2   |


  Scenario: RTS validation
    Then UI Validate Line Chart attribute "rts" with index "0" in data in chart "DNS Attack Life Cycle"
      | type  | oper | param         | values       |
      | INNER | AND  | dns-subdomain | mydomain.com |
#      | type  | oper |
#      | OUTER | OR   |

  Scenario: DDoS-TCp SYN ACK chart validation
    Then UI Validate Line Chart data "DNS-A" with Label "Legitimate Traffic"
      | value | min |
      | 310  | 1   |

    Then UI Validate Line Chart data "DNS-A" with Label "Total Traffic"
      | value | min |
      | 411351  | 1   |

    Then UI Validate Line Chart data "DNS-A" with Label "Normal Edge"
      | value | min |
      | 760  | 1   |

    Then UI Validate Line Chart data "DNS-A" with Label "Suspected Edge"
      | value | min |
      | null  | 1   |

    Then UI Validate Line Chart data "DNS-A" with Label "Attack Edge"
      | value | min |
      | null  | 1   |
#  @SID_9_ValidateDroppedPackets
#  Scenario: Validate Dropped Packets table
#    Then UI Validate Table record values by columns with elementLabel "Characteristics.DroppedPackets" findBy index 0
#      | columnName  | value               |
#      | Source      | 155.1.100.196:19097 |
#      | Destination | 155.1.202.193:53    |
#      | Protocol    | UDP                 |
#
#    Then UI Validate Table record values by columns with elementLabel "Characteristics.DroppedPackets" findBy index 1
#      | columnName  | value               |
#      | Source      | 155.1.100.196:47134 |
#      | Destination | 155.1.202.193:53    |
#      | Protocol    | UDP                 |
#
#  @SID_10_ValidateTopAttackSources
#  Scenario: Validate Top Attack Sources
#    Then UI Text of "TOP ATTACK SOURCES.IP" with extension "0" equal to "155.1.100.196"
#    Then UI Text of "TOP ATTACK SOURCES.Percentage" with extension "0" equal to "100.00%"
#
#  @SID_11_ValidateAttackLog
#  Scenario: Validate Attack Log card data
#    Then UI Text of "Attack Log" with extension "0" contains "Attack Ongoing"

  @SID_12_CleanUp
  Scenario: cleanup
    Then UI close browser
#    Then CLI kill all simulator attacks on current vision
