@VRM @TC105994
Feature: DP Monitoring Dashboard - Protection Policies - Under Attack 3rd Drill

  @SID_1
  Scenario: Clean system data before "Protection Policies" test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    * CLI Clear vision logs

  @SID_2
  Scenario: Login as sys_admin and update Attack Description File
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    When UI Update Attack Description File

#########################################################   BDOS   ################################################################

  @SID_3
  Scenario: Run DP simulator PCAPs for "Protection Policies" - 3rd drill - BDOS
    Given CLI simulate 1 attacks of type "vrm_bdos" on "DefensePro" 10 and wait 70 seconds

  @SID_4
  Scenario: Navigate to DP dashboard
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @SID_5
  Scenario: Entering to the under attack policy 3nd drill
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0

  ##Bdos - Info Card
  @SID_6
  Scenario: Validate info card data - BDOS
    Then UI Validate Text field "Info.Protocol" EQUALS "Protocol: TCP"
    Then UI Validate Text field "Info.Total packets" EQUALS "Total Packets: 161,491"
    Then UI Validate Text field "Info.Volume" EQUALS "Volume: 20.61 MBytes"
    Then UI Validate Text field "Info.Physical Port" EQUALS "Physical Port: 1"
    Then UI Validate Text field "Info.Device IP" EQUALS "Device IP Address: 172.16.22.50"
    Then UI Click Button "Info.Description" with value "Description"
    Then UI Validate Text field "Info.Description" CONTAINS "Description"
    Then UI Validate Text field "Info.Description" CONTAINS "TCP"
    Then UI Click Button "Info.Description" with value "Description"

  ##Bdos - Dropped packets
  @SID_7
  Scenario: Validate Dropped packets card data - BDOS
    Then UI Validate Table record values by columns with elementLabel "Dropped Packets" findBy index 0
      | columnName  | value           |
      | Source      | 192.85.1.2:1024 |
      | Destination | 1.1.1.1:1025    |
      | Protocol    | TCP             |
    Then UI Validate Table record values by columns with elementLabel "Dropped Packets" findBy index 1
      | columnName  | value           |
      | Source      | 192.85.1.2:1024 |
      | Destination | 1.1.1.1:1025    |
      | Protocol    | TCP             |

  ##Bdos - Top Attack Sources
  @SID_8
  Scenario: Validate Top Attack Sources card data - BDOS
    Then UI Text of "TOP ATTACK SOURCES.IP" with extension "0" equal to "192.85.1.2"
    Then UI Text of "TOP ATTACK SOURCES.Percentage" with extension "0" equal to "100%"

  ##Bdos -  Attack Log
  @SID_9
  Scenario: Validate Attack Log card data - BDOS
    Then UI Text of "Attack Log" with extension "0" contains "Attack Ongoing"

    ##Bdos - Per attack card
  @SID_10
  Scenario: Validate per attack card data - BDOS
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Real-Time Signature Blocking"
    Then UI Text of "Characteristics.Real-Time Signature.Operator" with extension "1" equal to "OR"
    Then UI Text of "Characteristics.Real-Time Signature.Parameter" with extension "1" equal to "sequence-number"
    Then UI Text of "Characteristics.Real-Time Signature.Value/s" with extension "1" equal to "123456"
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
      | SYN ACK Out | 96            |
      | FRAG In     | 204           |
      | FRAG Out    | 96            |
    Then UI Validate Table record values by columns with elementLabel "Characteristics.Attack Identification Statistics" findBy index 1
      | columnName  | value          |
      | Type        | Anomaly (Kbps) |
      | SYN In      | 0              |
      | SYN Out     | 0              |
      | RST In      | 0              |
      | RST Out     | 0              |
      | FIN ACK In  | 0              |
      | FIN ACK Out | 0              |
      | SYN ACK In  | 3351           |
      | SYN ACK Out | 0              |
      | FRAG In     | 0              |
      | FRAG Out    | 0              |
    Then UI Validate Table record values by columns with elementLabel "Characteristics.Attack Identification Statistics" findBy index 2
      | columnName  | value               |
      | Type        | Normal (Packet/Sec) |
      | SYN In      | 189                 |
      | SYN Out     | 189                 |
      | RST In      | 403                 |
      | RST Out     | 403                 |
      | FIN ACK In  | 202                 |
      | FIN ACK Out | 202                 |
      | SYN ACK In  | 195                 |
      | SYN ACK Out | 195                 |
      | FRAG In     | 24                  |
      | FRAG Out    | 24                  |
    Then UI Validate Table record values by columns with elementLabel "Characteristics.Attack Identification Statistics" findBy index 3
      | columnName  | value                |
      | Type        | Anomaly (Packet/Sec) |
      | SYN In      | 0                    |
      | SYN Out     | 0                    |
      | RST In      | 0                    |
      | RST Out     | 0                    |
      | FIN ACK In  | 0                    |
      | FIN ACK Out | 0                    |
      | SYN ACK In  | 3379                 |
      | SYN ACK Out | 0                    |
      | FRAG In     | 0                    |
      | FRAG Out    | 0                    |

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 96    | 13    | 4      |
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Suspected Edge"
      | value | count | offset |
      | 105   | 63    | 6      |
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 3350  | 3     | 1      |
      | 3455  | 3     | 1      |
      | 3456  | 3     | 1      |
      | 3457  | 3     | 1      |
    And UI Validate Line Chart attributes "BDoS-TCP SYN ACK" with Label "Total Traffic"
      | attribute             | value                    |
      | pointRadius           | 0                        |
      | fill                  | true                     |
      | lineTension           | 0.35                     |
      | borderCapStyle        | butt                     |
      | borderDashOffset      | 0                        |
      | borderJoinStyle       | miter                    |
      | borderWidth           | 1                        |
      | pointHoverRadius      | 4                        |
      | pointHoverBorderWidth | 1                        |
      | backgroundColor       | rgba(141, 190, 214, 0.1) |
      | borderColor           | rgba(141, 190, 214, 5)   |
    And UI Validate Line Chart attributes "BDoS-TCP SYN ACK" with Label "Suspected Edge"
      | attribute             | value   |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ffa20d |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |


  @SID_11
  Scenario: Logout
    Then UI Logout

  @SID_12
  Scenario: Login and open VRM
    Given UI Login with user "sys_admin" and password "radware"

  #########################################################   SYN Flood   ###########################################################

  @SID_13
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"

  @SID_14
  Scenario: Run DP simulator PCAPs for "Protection Policies" - 3rd drill - SYN Flood
    Given CLI simulate 1 attacks of type "rest_synflood" on "DefensePro" 10 and wait 50 seconds

  @SID_15
  Scenario: Entering to the under attack policy 3nd drill
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0

  ##SYN Flood - Info Card

  @SID_16
  Scenario: Validate info card data - SYN Flood
    Then UI Validate Text field "Info.Protocol" EQUALS "Protocol: TCP"
    Then UI Validate Text field "Info.Total packets" EQUALS "Total Packets: 223,890"
    Then UI Validate Text field "Info.Volume" EQUALS "Volume: 13.43 MBytes"
    Then UI Validate Text field "Info.Physical Port" EQUALS "Physical Port: Multiple"
    Then UI Validate Text field "Info.Device IP" EQUALS "Device IP Address: 172.16.22.50"

  ##SYN Flood -  Attack Log

  @SID_17
  Scenario: Validate Attack Log card data - SYN Flood
    Then UI Text of "Attack Log" with extension "0" contains "Attack Started"

  ##SYN Flood - Per attack card

  @SID_18
  Scenario: Validate per attack card data - SYN Flood
    Then UI Validate Element Existence By Label "Characteristics.Attack Duration" if Exists "true"
    Then UI Validate Text field "Characteristics.Activation Threshold" EQUALS "Activation Threshold:2500"
    Then UI Validate Element Existence By Label "Characteristics.Attack Duration" if Exists "true"
    Then UI Validate Text field "Characteristics.Challenge Method" EQUALS "Challenge Method:TCP Reset"
    Then UI Validate Text field "Characteristics.Challenge Type" EQUALS "Challenge Type:TCP Challenge"
    Then UI Validate Text field "Characteristics.TCP Challenge" EQUALS "TCP Challenge:TransparentProxy"
    Then UI Validate Text field "Characteristics.HTTP Challenge" EQUALS "HTTP Challenge:CloudAuthentication"

  ############################################   Traffic Filters   ##################################################################

  @SID_19
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"

  @SID_20
  Scenario: Run DP simulator PCAPs for "Protection Policies" - 3rd drill - Traffic Filters
    Given CLI simulate 1 attacks of type "rest_traffic_filter" on "DefensePro" 10 and wait 40 seconds

  @SID_21
  Scenario: Entering to the under attack policy 3nd drill
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    # And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Traffic Filters"
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0

     ##Traffic Filters - Info Card
  @SID_22
  Scenario: Validate info card data - Traffic Filters
    Then UI Validate Text field "Info.Protocol" EQUALS "Protocol: UDP"
    Then UI Validate Text field "Info.Total packets" EQUALS "Total Packets: 18,770"
    Then UI Validate Text field "Info.Volume" EQUALS "Volume: 1.46 MBytes"
    Then UI Validate Text field "Info.Physical Port" EQUALS "Physical Port: MNG-1"
    Then UI Validate Text field "Info.Device IP" EQUALS "Device IP Address: 172.16.22.50"

      ##Traffic Filters - Per attack card

  @SID_23
  Scenario: Validate per attack card data - Traffic Filters
    Then UI Validate Text field "Characteristics.Filter Name" EQUALS "Filter Name:f1"
    Then UI Validate Text field "Characteristics.Filter ID" EQUALS "Filter ID:700000"
    Then UI Validate Text field "Characteristics.Attack Rate" EQUALS "Attack Rate:285"
    Then UI Validate Text field "Characteristics.Attack Bandwidth" EQUALS "Attack Bandwidth:173 Kbps"

  ##Traffic Filters - Dropped packets
  @SID_24
  Scenario: Validate Dropped packets card data - Traffic Filters
    Then UI Validate Table record values by columns with elementLabel "Dropped Packets" findBy index 0
      | columnName  | value           |
      | Source      | 192.85.1.2:1024 |
      | Destination | 192.0.0.1:53    |
      | Protocol    | UDP             |
    Then UI Validate Table record values by columns with elementLabel "Dropped Packets" findBy index 1
      | columnName  | value           |
      | Source      | 192.85.1.2:1024 |
      | Destination | 192.0.0.1:53    |
      | Protocol    | UDP             |

  ##Traffic Filters - Top Attack Sources
  @SID_25
  Scenario: Validate Top Attack Sources card data - Traffic Filters
    Then UI Text of "TOP ATTACK SOURCES.IP" with extension "0" equal to "192.85.1.2"
    Then UI Text of "TOP ATTACK SOURCES.Percentage" with extension "0" equal to "100%"

  ##Traffic Filters -  Attack Log
  @SID_26
  Scenario: Validate Attack Log card data - Traffic Filters
    Then UI Click Button "Protection Policies.GO BACK" with value ""
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Traffic Filters"
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0
    Then UI Text of "Attack Log" with extension "0" contains "Attack Terminated"


  ###################################################   DNS Flood   ################################################################
  @SID_27
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"

  @SID_28
  Scenario: Run DP simulator PCAPs for "Protection Policies" - 3rd drill - DNS Flood
    Given CLI simulate 1 attacks of type "rest_DNS_NEW" on "DefensePro" 10 and wait 130 seconds

  @SID_29
  Scenario: Entering to the under attack policy 3nd drill
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0

  ##DNS Flood - Info Card
  @SID_30
  Scenario: Validate info card data - DNS Flood
    Then UI Validate Text field "Info.Protocol" EQUALS "Protocol: UDP"
    Then UI Validate Text field "Info.Total packets" EQUALS "Total Packets: 2,417"
    Then UI Validate Text field "Info.Volume" EQUALS "Volume: 175.87 KBytes"
    Then UI Validate Text field "Info.Physical Port" EQUALS "Physical Port: 0"
    Then UI Validate Text field "Info.Device IP" EQUALS "Device IP Address: 172.16.22.50"
    Then UI Click Button "Info.Description" with value "Description"
    Then UI Validate Text field "Info.Description" CONTAINS "Description"
    Then UI Validate Text field "Info.Description" CONTAINS "DNS"
    Then UI Click Button "Info.Description" with value "Description"

  @SID_31
  Scenario: Validate per attack card data - DNS Flood
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Real-Time Signature Rate-Limit"
    Then UI Text of "Characteristics.Real-Time Signature.Outer Value" with extension "0" equal to "["
    Then UI Text of "Characteristics.Real-Time Signature.Operator" with extension "1" equal to "OR"
    Then UI Text of "Characteristics.Real-Time Signature.Parameter" with extension "1" equal to "dns-subdomain"
    Then UI Text of "Characteristics.Real-Time Signature.Outer Value" with extension "2" equal to "]"
    Then UI Text of "Characteristics.Real-Time Signature.Outer Value" with extension "3" equal to "OR"
    Then UI Text of "Characteristics.Real-Time Signature.Outer Value" with extension "4" equal to "["
    Then UI Text of "Characteristics.Real-Time Signature.Operator" with extension "5" equal to "AND"
    Then UI Text of "Characteristics.Real-Time Signature.Parameter" with extension "5" equal to "dns-flags"
    Then UI Text of "Characteristics.Real-Time Signature.Value/s" with extension "5" equal to "256"
    Then UI Text of "Characteristics.Real-Time Signature.Operator" with extension "6" equal to "AND"
    Then UI Text of "Characteristics.Real-Time Signature.Parameter" with extension "6" equal to "source-ip"
    Then UI Text of "Characteristics.Real-Time Signature.Value/s" with extension "6" equal to "197.1.1.1"
    Then UI Text of "Characteristics.Real-Time Signature.Operator" with extension "7" equal to "AND"
    Then UI Text of "Characteristics.Real-Time Signature.Parameter" with extension "7" equal to "packet-size"
    Then UI Text of "Characteristics.Real-Time Signature.Value/s" with extension "7" equal to "73"
    Then UI Text of "Characteristics.Real-Time Signature.Operator" with extension "8" equal to "AND"
    Then UI Text of "Characteristics.Real-Time Signature.Parameter" with extension "8" equal to "destination-ip"
    Then UI Text of "Characteristics.Real-Time Signature.Value/s" with extension "8" equal to "30.1.1.10"
    Then UI Text of "Characteristics.Real-Time Signature.Operator" with extension "9" equal to "AND"
    Then UI Text of "Characteristics.Real-Time Signature.Parameter" with extension "9" equal to "ttl"
    Then UI Text of "Characteristics.Real-Time Signature.Value/s" with extension "9" equal to "64"
    Then UI Text of "Characteristics.Real-Time Signature.Outer Value" with extension "10" equal to "]"

    Then UI Validate Line Chart data "DNS-A" with Label "Normal Edge"
      | value | count | offset |
      | 0     | 0     | 0      |

    Then UI Validate Text field "Characteristics.whitelist_0" EQUALS "mail.gooooooooooooooooooooo.uk"
    Then UI Validate Text field "Characteristics.whitelist_1" EQUALS "gmail.google.com"
    Then UI Validate Text field "Characteristics.whitelist_2" EQUALS "www.google.com"
    Then UI Validate Text field "Characteristics.whitelist_3" EQUALS "maps.google.com"
    Then UI Validate Text field "Characteristics.whitelist_4" EQUALS "yohail.google.com"
  ##DNS Flood - Dropped packets

  @SID_32
  Scenario: Validate Dropped packets card data - DNS Flood
    Then UI Validate Table record values by columns with elementLabel "Dropped Packets" findBy index 0
      | columnName  | value           |
      | Source      | 197.1.1.1:54081 |
      | Destination | 30.1.1.10:53    |
      | Protocol    | UDP             |
    Then UI Validate Table record values by columns with elementLabel "Dropped Packets" findBy index 1
      | columnName  | value           |
      | Source      | 197.1.1.1:54081 |
      | Destination | 30.1.1.10:53    |
      | Protocol    | UDP             |

  ##DNS Flood - Top Attack Sources
  @SID_33
  Scenario: Validate Top Attack Sources card data - DNS Flood
    Then UI Text of "TOP ATTACK SOURCES.IP" with extension "0" equal to "197.1.1.1"
    Then UI Text of "TOP ATTACK SOURCES.Percentage" with extension "0" equal to "100%"

  ##DNS Flood -  Attack Log
  @SID_34
  Scenario: Validate Attack Log card data - DNS Flood
    Then UI Text of "Attack Log" with extension "0" contains "Attack Ongoing"

  ##DNS Flood - Per attack card

  @SID_35
  Scenario: Logout
    Then UI Logout

  @SID_36
  Scenario: Kill and generate DNS attack IPv6
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    Given CLI simulate 3 attacks of type "baselines_pol_1" on "DefensePro" 10 with loopDelay 15000 and wait 55 seconds

  @SID_37
  Scenario: Login and open VRM DNS attack details
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "pol_1"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DNS Flood"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0

  @SID_38
  Scenario: Validate DNS Flood attack card data - non-default baselines
    Then UI Validate Line Chart attributes "DNS-AAAA" with Label "Total Traffic"
      | attribute             | value                    |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                        |
      | fill                  | true                     |
      | lineTension           | 0.35                     |
      | borderCapStyle        | butt                     |
      | borderDashOffset      | 0                        |
      | borderJoinStyle       | miter                    |
      | borderWidth           | 1                        |
      | pointHoverRadius      | 4                        |
      | pointHoverBorderWidth | 1                        |
      | backgroundColor       | rgba(141, 190, 214, 0.1) |
      | borderColor           | rgba(141, 190, 214, 5)   |
    Then UI Validate Line Chart data "DNS-AAAA" with Label "Total Traffic"
      | value  | count | offset |
      | 844403 | 4     | 1      |

  @SID_39
  Scenario: Logout
    Then UI Logout

  @SID_40
  Scenario: Login and open VRM
    Given UI Login with user "sys_admin" and password "radware"

  ###############################################   Anti-Scanning   ###############################################################

  @SID_41
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"

  @SID_42
  Scenario: Run DP simulator PCAPs for "Protection Policies" - 3rd drill - Anti-Scanning
    Given CLI simulate 1 attacks of type "ascan" on "DefensePro" 10 and wait 75 seconds

  @SID_43
  Scenario: Entering to the under attack policy 3nd drill
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0

    ##Anti-Scanning - Info Card

  @SID_44
  Scenario: Validate info card data - Anti-Scanning
    Then UI Validate Text field "Info.Protocol" EQUALS "Protocol: TCP"
    Then UI Validate Text field "Info.Total packets" EQUALS "Total Packets: 40,350"
    Then UI Validate Text field "Info.Volume" EQUALS "Volume: 5 MBytes"
    Then UI Validate Text field "Info.Physical Port" EQUALS "Physical Port: 1"
    Then UI Validate Text field "Info.Device IP" EQUALS "Device IP Address: 172.16.22.50"
    Then UI Click Button "Info.Description" with value "Description"
    Then UI Validate Text field "Info.Description" CONTAINS "Description"
    Then UI Validate Text field "Info.Description" CONTAINS "Scanning"
    Then UI Click Button "Info.Description" with value "Description"

  ##Anti-Scanning -  Attack Log

  @SID_45
  Scenario: Validate Attack Log card data - Anti-Scanning
    Then UI Text of "Attack Log" with extension "0" contains "Attack Ongoing"

  ##Anti-Scanning - Per attack card

  @SID_46
  Scenario: Validate per attack card data - Anti-Scanning
    Then UI Validate Text field "Characteristics.Action" EQUALS "Action:Drop"
    Then UI Validate Text field "Characteristics.Action Reason" EQUALS "Action Reason:Configuration"
    Then UI Validate Element Existence By Label "Characteristics.Number of Probes" if Exists "true"
    Then UI Validate Text field "Characteristics.Average Time Between Probes" EQUALS "Average Time Between Probes: < 0"
    Then UI Validate Text field "Characteristics.Blocking Duration" EQUALS "Blocking Duration:23 sec"
    Then UI Validate Element Existence By Label "Characteristics.Estimated Release Time (Local)" if Exists "true"
    Then UI Text of "Characteristics.Real-Time Signature.Operator" with extension "1" equal to "OR"
    Then UI Text of "Characteristics.Real-Time Signature.Parameter" with extension "1" equal to "destination-ip"
    Then UI Text of "Characteristics.Real-Time Signature.Value/s" with extension "1" equal to "1.1.1.7"
    Then UI Text of "Characteristics.Real-Time Signature.Outer Value" with extension "3" equal to "AND"
    Then UI Text of "Characteristics.Real-Time Signature.Operator" with extension "5" equal to "AND"
    Then UI Text of "Characteristics.Real-Time Signature.Parameter" with extension "5" equal to "ttl"
    Then UI Text of "Characteristics.Real-Time Signature.Value/s" with extension "5" equal to "255"
    Then UI Text of "Characteristics.Real-Time Signature.Operator" with extension "6" equal to "AND"
    Then UI Text of "Characteristics.Real-Time Signature.Parameter" with extension "6" equal to "packet-size"
    Then UI Text of "Characteristics.Real-Time Signature.Value/s" with extension "6" equal to "124"
    Then UI Text of "Characteristics.Real-Time Signature.Operator" with extension "7" equal to "AND"
    Then UI Text of "Characteristics.Real-Time Signature.Parameter" with extension "7" equal to "sequence-number"
    Then UI Text of "Characteristics.Real-Time Signature.Value/s" with extension "7" equal to "123456"

  ##Anti-Scanning - Per attack card - Scan Details table

  @SID_47
  Scenario: Validate per attack card data - Anti-Scanning - Scan Details table
    Then UI Validate Table record values by columns with elementLabel "Characteristics.Scan Details" findBy index 0
      | columnName          | value   |
      | Destination IP      | 1.1.1.7 |
      | Destination L4 Port | 1       |
      | TCP Flag / Protocol | SYN     |
    Then UI Validate Table record values by columns with elementLabel "Characteristics.Scan Details" findBy index 6
      | columnName          | value   |
      | Destination IP      | 1.1.1.7 |
      | Destination L4 Port | 7       |
      | TCP Flag / Protocol | SYN     |
    Then UI Validate Table record values by columns with elementLabel "Characteristics.Scan Details" findBy index 14
      | columnName          | value   |
      | Destination IP      | 1.1.1.7 |
      | Destination L4 Port | 15      |
      | TCP Flag / Protocol | SYN     |

  ########################################################   DoS   #################################################################
  @SID_48
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"

  @SID_49
  Scenario: Run DP simulator PCAPs for "Protection Policies" - 3rd drill - DoS
    Given CLI simulate 1 attacks of type "rest_dos" on "DefensePro" 10 and wait 46 seconds

  @SID_50
  Scenario: Entering to the under attack policy 3nd drill
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0

      ##DoS - Info Card
  @SID_51
  Scenario: Validate info card data - DoS
    Then UI Validate Text field "Info.Protocol" EQUALS "Protocol: TCP"
    Then UI Validate Text field "Info.Total packets" EQUALS "Total Packets: 58,469"
    Then UI Validate Text field "Info.Volume" EQUALS "Volume: 7.25 MBytes"
    Then UI Validate Text field "Info.Physical Port" EQUALS "Physical Port: 1"
    Then UI Validate Text field "Info.Device IP" EQUALS "Device IP Address: 172.16.22.50"

  ##DoS - Dropped packets
  @SID_52
  Scenario: Validate Dropped packets card data - DoS
    Then UI Validate Table record values by columns with elementLabel "Dropped Packets" findBy index 0
      | columnName  | value           |
      | Source      | 192.85.1.8:1055 |
      | Destination | 1.1.1.8:1028    |
      | Protocol    | TCP             |
    Then UI Validate Table record values by columns with elementLabel "Dropped Packets" findBy index 1
      | columnName  | value           |
      | Source      | 192.85.1.8:1055 |
      | Destination | 1.1.1.8:1028    |
      | Protocol    | TCP             |

  ##DoS - Top Attack Sources
  @SID_53
  Scenario: Validate Top Attack Sources card data - DoS
    Then UI Text of "TOP ATTACK SOURCES.IP" with extension "0" equal to "192.85.1.8"
    Then UI Text of "TOP ATTACK SOURCES.Percentage" with extension "0" equal to "100%"

  ##DoS -  Attack Log
  @SID_54
  Scenario: Validate Attack Log card data - DoS
    Then UI Text of "Attack Log" with extension "0" contains "Attack"

  ##DoS - Per attack card
  @SID_55
  Scenario: Validate per attack card data - DoS
    Then UI Validate Text field "Characteristics.Action" EQUALS "Action:Drop"
    Then UI Validate Text field "Characteristics.Attacker IP" EQUALS "Attacker IP:192.85.1.8"
    Then UI Validate Text field "Characteristics.Protected Host" EQUALS "Protected Host:1.1.1.8"
    Then UI Validate Text field "Characteristics.Protected Port" EQUALS "Protected Port:1028"
    Then UI Validate Element Existence By Label "Characteristics.Average Duration" if Exists "true"

  ########################################################   DoS PPS   ##############################################################

  @SID_56
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"

  @SID_57
  Scenario: Run DP simulator PCAPs for "Protection Policies" - 3rd drill - DoS pps
    Given CLI simulate 1 attacks of type "rest_dos_pps" on "DefensePro" 10 and wait 40 seconds

  @SID_58
  Scenario: Entering to the under attack policy 3nd drill
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DoS"
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0

      ##DoS - Info Card

  @SID_59
  Scenario: Validate info card data - DoS pps
    Then UI Validate Text field "Info.Protocol" EQUALS "Protocol: TCP"
    Then UI Validate Text field "Info.Total packets" EQUALS "Total Packets: 1,296"
    Then UI Validate Text field "Info.Volume" EQUALS "Volume: 0 Bytes"
    Then UI Validate Text field "Info.Physical Port" EQUALS "Physical Port: 3"
    Then UI Validate Text field "Info.Device IP" EQUALS "Device IP Address: 172.16.22.50"

  ##DoS -  Attack Log

  @SID_60
  Scenario: Validate Attack Log card data - DoS pps
    Then UI Click Button "Protection Policies.GO BACK" with value ""
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DoS"
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0
    Then UI Text of "Attack Log" with extension "0" contains "Attack Terminated"

  ##DoS - Per attack card

  @SID_61
  Scenario: Validate per attack card data - DoS pps
    Then UI Validate Text field "Characteristics.Action" EQUALS "Action:forward"
    Then UI Validate Text field "Characteristics.Attacker IP" EQUALS "Attacker IP:198.18.0.1"
    Then UI Validate Text field "Characteristics.Protected Host" EQUALS "Protected Host:198.18.252.1"
    Then UI Validate Text field "Characteristics.Protected Port" EQUALS "Protected Port:80"
    Then UI Validate Text field "Characteristics.Current Attack Rate" EQUALS "Current Attack Rate:"
    Then UI Validate Text field "Characteristics.Average Attack Rate" EQUALS "Average Attack Rate:"
    Then UI Validate Element Existence By Label "Characteristics.Average Duration" if Exists "true"

  ########################################################   Intrusions   ##########################################################
  @SID_62
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"

  @SID_63
  Scenario: Run DP simulator PCAPs for "Protection Policies" - 3rd drill - Intrusions
    Given CLI simulate 1 attacks of type "rest_intrusion" on "DefensePro" 10 and wait 45 seconds

  @SID_64
  Scenario: Entering to the under attack policy 3nd drill
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0

  ##Intrusions - Info Card
  @SID_65
  Scenario: Validate info card data - Intrusions
    Then UI Validate Text field "Info.Protocol" EQUALS "Protocol: TCP"
    Then UI Validate Text field "Info.Total packets" EQUALS "Total Packets: 1"
    Then UI Validate Text field "Info.Volume" EQUALS "Volume: 0 Bytes"
    Then UI Validate Text field "Info.Physical Port" EQUALS "Physical Port: 1"
    Then UI Validate Text field "Info.Device IP" EQUALS "Device IP Address: 172.16.22.50"

  ##########################################################   ACL   ###############################################################
  @SID_66
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"

  @SID_67
  Scenario: Run DP simulator PCAPs for "Protection Policies" - 3rd drill - ACL
    Given CLI simulate 1 attacks of type "rest_black_ip46" on "DefensePro" 10 and wait 46 seconds

  @SID_68
  Scenario: Entering to the under attack policy 3nd drill
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0

      ##ACL - Info Card
  @SID_69
  Scenario: Validate info card data - ACL
    Then UI Validate Text field "Info.Protocol" EQUALS "Protocol: IP"
    Then UI Validate Text field "Info.Total packets" EQUALS "Total Packets: 68,589"
    Then UI Validate Text field "Info.Volume" EQUALS "Volume: 55.94 MBytes"
    Then UI Validate Text field "Info.Physical Port" EQUALS "Physical Port: T-1"
    Then UI Validate Text field "Info.Device IP" EQUALS "Device IP Address: 172.16.22.50"
    Then UI Click Button "Info.Description" with value "Description"
    Then UI Validate Text field "Info.Description" CONTAINS "Description"
    Then UI Validate Text field "Info.Description" CONTAINS "black list"
    Then UI Click Button "Info.Description" with value "Description"

  ##ACL - Dropped packets
  @SID_70
  Scenario: Validate Dropped packets card data - ACL
    Then UI Validate Table record values by columns with elementLabel "Dropped Packets" findBy index 0
      | columnName  | value        |
      | Source      | 1.1.1.1:1024 |
      | Destination | 2.2.2.1:1024 |
      | Protocol    | TCP          |

  ##ACL - Top Attack Sources
  @SID_71
  Scenario: Validate Top Attack Sources card data - ACL
    Then UI Text of "TOP ATTACK SOURCES.IP" with extension "0" equal to "1.1.1.1"
    Then UI Text of "TOP ATTACK SOURCES.Percentage" with extension "0" equal to "100%"

  ##ACL -  Attack Log
  @SID_72
  Scenario: Validate Attack Log card data - ACL
    Then UI Text of "Attack Log" with extension "0" contains "Attack Occurred"

  ########################################################   Anomalies   ###########################################################
  @SID_73
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"

  @SID_74
  Scenario: Run DP simulator PCAPs for "Protection Policies" - 3rd drill - Anomalies
    Given CLI simulate 1 attacks of type "rest_anomalies" on "DefensePro" 10 and wait 46 seconds

  @SID_75
  Scenario: Entering to the under attack policy 3nd drill
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0


    ##Anomalies - Info Card
  @SID_76
  Scenario: Validate info card data - Anomalies
    Then UI Validate Text field "Info.Protocol" EQUALS "Protocol: IP"
    Then UI Validate Text field "Info.Total packets" EQUALS "Total Packets: 1"
    Then UI Validate Text field "Info.Volume" EQUALS "Volume: 0 Bytes"
    Then UI Validate Text field "Info.Physical Port" EQUALS "Physical Port: 0"
    Then UI Validate Text field "Info.Device IP" EQUALS "Device IP Address: 172.16.22.50"
    Then UI Click Button "Info.Description" with value "Description"
    Then UI Validate Text field "Info.Description" CONTAINS "Description"
    Then UI Validate Text field "Info.Description" CONTAINS "checksum"
    Then UI Click Button "Info.Description" with value "Description"

  ##Anomalies -  Attack Log
  @SID_77
  Scenario: Validate Attack Log card data - Anomalies
    Then UI Text of "Attack Log" with extension "0" contains "Attack Occurred"

  @SID_78
  Scenario: Logout
    Then UI Logout

      ########################################################   Https Flood Inbound   ###########################################################

  @SID_79
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    * REST Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "dp-*"
    * REST Update Policies for All DPs


  @SID_80
  Scenario: Run DP simulator PCAPs for "Protection Policies" - 3rd drill - Https Flood
    Given CLI simulate 2 attacks of type "HTTPS" on "DefensePro" 11 with loopDelay 5000 and wait 60 seconds

  @SID_81
  Scenario: Login and open AMS dashboard
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @SID_82
  Scenario: Entering to the under attack policy 3nd drill https flood
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Attack Categories" findBy cellValue "HTTPS Flood"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "HTTPS Flood"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0

      ##Https Flood - Info Card

  @SID_83
  Scenario: Validate info card data - https flood
    Then UI Validate Text field "Info.Protocol" EQUALS "Protocol: TCP"
    Then UI Validate Text field "Info.Total packets" EQUALS "Total Packets: 0"
    Then UI Validate Text field "Info.Volume" EQUALS "Volume: 0 Bytes"
    Then UI Validate Text field "Info.Physical Port" EQUALS "Physical Port: 0"
    Then UI Validate Text field "Info.Device IP" EQUALS "Device IP Address: 172.16.22.51"
    Then UI Click Button "Info.Description" with value "Description"
    Then UI Validate Text field "Info.Description" CONTAINS "Description"
    Then UI Click Button "Info.Description" with value "Description"
    Then UI Validate Text field "Info.HTTPS Protected Server" EQUALS "Protected SSL Object: test"


        ##https flkood - Per attack card

  @SID_84
  Scenario: Validate per attack card data - https flood
    Then UI Validate Text field "Characteristics.HTTPS Attack Duration" CONTAINS "Attack Duration:"
    Then UI Validate Text field "Characteristics.Attack State" EQUALS "Attack State:Mitigation"
    Then UI Validate Text field "Characteristics.Attack Detection" EQUALS "Attack Detection Method:By Rate of HTTPS Requests"
    Then UI Validate Text field "Characteristics.Attack Mitigation Method" EQUALS "Attack Mitigation Method:Rate Limit Suspected Attackers"
    Then UI Validate Text field "Characteristics.HTTPS Authentication Method" EQUALS "Authentication Method:302 Redirect"
    Then UI Validate Text field "Characteristics.HTTPS Suspect-Source" EQUALS "Total Suspect Sources:2,559,994,656"
    Then UI Validate Text field "Characteristics.HTTPS Challenge-Rate per Second" EQUALS "Total Requests Challenged:14"
    Then UI Validate Text field "Characteristics.HTTPS Drop-Rate" EQUALS "Total Packets Dropped:11"
    Then UI Validate Text field "Characteristics.Total Unique Sources Challenged" EQUALS "Total Sources Challenged:12"
    Then UI Validate Text field "Characteristics.Total Unique Sources Authenticated" EQUALS "Total Sources Authenticated:1,088,888"
    Then UI Validate Text field "Characteristics.Total Attacker Sources" EQUALS "Total Attacker Sources:1,700,000"
    Then UI Validate Text field "Characteristics.Authentication List Utilization" EQUALS "Authentication List Utilization:15 %"
    Then UI Validate Text field "Characteristics.Request Per Seconds" EQUALS "Requests per Second:759"
    Then UI Validate Text field "Characteristics.Transitory Baseline" EQUALS "Transitory Baseline Value:25 RPS"
    Then UI Validate Text field "Characteristics.Transitory Attack Edge" EQUALS "Transitory Attack-Edge Value:26 RPS"
    Then UI Validate Text field "Characteristics.Long Trend Baseline" EQUALS "Long-Term Trend Baseline Value:141 RPS"
    Then UI Validate Text field "Characteristics.Long-Trend_Baseline Edge" EQUALS "Long-Term Trend Attack-Edge Value:241 RPS"
    Then UI Validate Text field "Characteristics.Exceed Requests Rate" EQUALS "10-Sec RPS-Over-Baseline :21"

  ##https flood -  Attack Log

  @SID_85
  Scenario: Validate Attack Log card data - https flood
    Then UI Text of "Attack Log" with extension "0" contains "State:  Rate Limit Suspected Attackers"
    Then UI Text of "Attack Log" with extension "1" contains "State:  Characterization"
    Then UI Text of "Attack Log" with extension "2" contains "State:  Mitigation"
    Then UI Text of "Attack Log" with extension "3" contains "State:  Rate Limit Suspected Attackers"

  ##https flood -  request size distribution

  @SID_86
  Scenario: Validate Https Flood distributed size graph data - Baseline
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Baseline"
      | value       | count | index | offset |
      | 0           | 47    | 0     | 0      |
      | 0.97232455  | 1     | 1     | 0      |
      | 0.77        | 1     | 2     | 0      |
      | 0.027675444 | 1     | 4     | 0      |


  @SID_87
  Scenario: Validate Https Flood distributed size graph style - Baseline
    Then UI Validate Line Chart attributes "Request-Size Distribution" with Label "Baseline"
      | attribute                 | value   |
      | pointRadius               | 0       |
      | fill                      | true    |
      | lineTension               | 0.35    |
      | borderCapStyle            | butt    |
      | borderDashOffset          | 0       |
      | borderJoinStyle           | miter   |
      | borderWidth               | 1       |
      | pointHoverRadius          | 4       |
      | pointHoverBorderWidth     | 1       |
      | backgroundColor           | #6296BA |
      | pointHoverBackgroundColor | #6296BA |
      | color                     | #6296BA |

  @SID_88
  Scenario: Validate Https Flood distributed size graph data - Real Time Traffic
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Real-Time Traffic"
      | value      | count | index | offset |
      | 0          | 46    | 0     | 0      |
      | 0.23451911 | 1     | 1     | 0      |
      | 0.214519   | 1     | 2     | 0      |
      | 0.81       | 1     | 4     | 0      |
      | 0.5        | 1     | 49    | 0      |

  @SID_89
  Scenario: Validate Https Flood distributed size graph style - Real Time Traffic
    Then UI Validate Line Chart attributes "Request-Size Distribution" with Label "Real-Time Traffic"
      | attribute                 | value   |
      | pointRadius               | 0       |
      | fill                      | false   |
      | lineTension               | 0.35    |
      | borderCapStyle            | butt    |
      | borderDashOffset          | 0       |
      | borderJoinStyle           | miter   |
      | borderWidth               | 3       |
      | pointHoverRadius          | 0       |
      | pointHoverBorderWidth     | 0       |
      | backgroundColor           | #3C4144 |
      | pointHoverBackgroundColor | #3C4144 |
      | color                     | #3C4144 |
      | type                      | line    |
      | borderColor               | #3C4144 |
      | pointHitRadius            | 0       |


  @SID_90
  Scenario: Validate Https Flood distributed size graph data - Attack Edge
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Attack Edge"
      | value      | count | index | offset |
      | 0          | 48    | 0     | 0      |
      | 1          | 1     | 1     | 0      |
      | 0.47802296 | 1     | 4     | 0      |

  @SID_91
  Scenario: Validate Https Flood distributed size graph style - Attack Edge
    Then UI Validate Line Chart attributes "Request-Size Distribution" with Label "Attack Edge"
      | attribute                 | value   |
      | pointRadius               | 0       |
      | fill                      | true    |
      | lineTension               | 0.35    |
      | borderCapStyle            | butt    |
      | borderDashOffset          | 0       |
      | borderJoinStyle           | miter   |
      | borderWidth               | 1       |
      | pointHoverRadius          | 4       |
      | pointHoverBorderWidth     | 1       |
      | backgroundColor           | #F39C12 |
      | pointHoverBackgroundColor | #F39C12 |
      | color                     | #F39C12 |
      | pointHitRadius            | 0       |
      | borderDash                | []      |

  @SID_92
  Scenario: Validate Https Flood distributed size graph data - Under Attack
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Under Attack"
      | value      | count | index | offset |
      | 0          | 46    | 0     | 0      |
      | 0.23451911 | 1     | 1     | 0      |
      | 0.214519   | 1     | 2     | 0      |
      | 0.81       | 1     | 4     | 0      |
      | 0.5        | 1     | 49    | 0      |

  @SID_93
  Scenario: Validate Https Flood distributed size graph style - Under Attack
    Then UI Validate Line Chart attributes "Request-Size Distribution" with Label "Under Attack"
      | attribute                 | value   |
      | pointRadius               | 0       |
      | fill                      | true    |
      | lineTension               | 0.35    |
      | borderCapStyle            | butt    |
      | borderDashOffset          | 0       |
      | borderJoinStyle           | miter   |
      | borderWidth               | 1       |
      | pointHoverRadius          | 4       |
      | pointHoverBorderWidth     | 1       |
      | backgroundColor           | #E74C3C |
      | pointHoverBackgroundColor | #E74C3C |
      | color                     | #E74C3C |
      | pointHitRadius            | 0       |
      | borderDash                | []      |

  ####################################################
  ##https Https set toggle to Attack Start Time     ##
  ##Navigate back inorder to refresh the start-time ##
  ####################################################
  @SID_94
  Scenario: Https set toggle to Attack Start Time
    * UI Click Button "Characteristics.HTTPS Go-Back"
    * UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "HTTPS Flood"
    * UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0
    * UI Click Button "toggle Attack Start Time"

  @SID_95
  Scenario: Validate Https Flood distributed size graph data - Baseline - Attack Start Time
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Baseline"
      | value       | count | index | offset |
      | 0           | 48    | 0     | 0      |
      | 0.97232455  | 1     | 1     | 0      |
      | 0.027675444 | 1     | 4     | 0      |

  @SID_96
  Scenario: Validate Https Flood distributed size graph style - Baseline - Attack Start Time
    Then UI Validate Line Chart attributes "Request-Size Distribution" with Label "Baseline"
      | attribute                 | value   |
      | pointRadius               | 0       |
      | fill                      | true    |
      | lineTension               | 0.35    |
      | borderCapStyle            | butt    |
      | borderDashOffset          | 0       |
      | borderJoinStyle           | miter   |
      | borderWidth               | 1       |
      | pointHoverRadius          | 4       |
      | pointHoverBorderWidth     | 1       |
      | backgroundColor           | #6296BA |
      | pointHoverBackgroundColor | #6296BA |
      | color                     | #6296BA |

  @SID_97
  Scenario: Validate Https Flood distributed size graph data - Real Time Traffic - Attack Start Time
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Real-Time Traffic"
      | value      | count | index | offset |
      | 0          | 48    | 0     | 0      |
      | 0.23451911 | 1     | 1     | 0      |
      | 0.7654809  | 1     | 4     | 0      |

  @SID_98
  Scenario: Validate Https Flood distributed size graph style - Real Time Traffic - Attack Start Time
    Then UI Validate Line Chart attributes "Request-Size Distribution" with Label "Real-Time Traffic"
      | attribute                 | value   |
      | pointRadius               | 0       |
      | fill                      | false   |
      | lineTension               | 0.35    |
      | borderCapStyle            | butt    |
      | borderDashOffset          | 0       |
      | borderJoinStyle           | miter   |
      | borderWidth               | 3       |
      | pointHoverRadius          | 0       |
      | pointHoverBorderWidth     | 0       |
      | backgroundColor           | #3C4144 |
      | pointHoverBackgroundColor | #3C4144 |
      | color                     | #3C4144 |
      | type                      | line    |
      | borderColor               | #3C4144 |
      | pointHitRadius            | 0       |

  @SID_99
  Scenario: Validate Https Flood distributed size graph data - Attack Edge - Attack Start Time
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Attack Edge"
      | value      | count | index | offset |
      | 0          | 48    | 0     | 0      |
      | 1          | 1     | 1     | 0      |
      | 0.47802296 | 1     | 4     | 0      |

  @SID_100
  Scenario: Validate Https Flood distributed size graph style - Attack Edge - Attack Start Time
    Then UI Validate Line Chart attributes "Request-Size Distribution" with Label "Attack Edge"
      | attribute                 | value   |
      | pointRadius               | 0       |
      | fill                      | true    |
      | lineTension               | 0.35    |
      | borderCapStyle            | butt    |
      | borderDashOffset          | 0       |
      | borderJoinStyle           | miter   |
      | borderWidth               | 1       |
      | pointHoverRadius          | 4       |
      | pointHoverBorderWidth     | 1       |
      | backgroundColor           | #F39C12 |
      | pointHoverBackgroundColor | #F39C12 |
      | color                     | #F39C12 |
      | pointHitRadius            | 0       |
      | borderDash                | []      |

  @SID_101
  Scenario: Validate Https Flood distributed size graph data - Under Attack - Attack Start Time
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Under Attack"
      | value      | count | index | offset |
      | 0          | 48    | 0     | 0      |
      | 0.23451911 | 1     | 1     | 0      |
      | 0.7654809  | 1     | 4     | 0      |

  @SID_102
  Scenario: Validate Https Flood distributed size graph style - Under Attack - Attack Start Time
    Then UI Validate Line Chart attributes "Request-Size Distribution" with Label "Under Attack"
      | attribute                 | value   |
      | pointRadius               | 0       |
      | fill                      | true    |
      | lineTension               | 0.35    |
      | borderCapStyle            | butt    |
      | borderDashOffset          | 0       |
      | borderJoinStyle           | miter   |
      | borderWidth               | 1       |
      | pointHoverRadius          | 4       |
      | pointHoverBorderWidth     | 1       |
      | backgroundColor           | #E74C3C |
      | pointHoverBackgroundColor | #E74C3C |
      | color                     | #E74C3C |
      | pointHitRadius            | 0       |
      | borderDash                | []      |

  ##https flood -  HTTPS baselines

  @SID_103
  Scenario: Validate Https Flood baseline graph Transitory Baseline data
    Then UI Validate Line Chart data "Requests per Second" with Label "Transitory Baseline"
      | value | count | offset |
      | 17200 | 60    | 5      |

  @SID_104
  Scenario: Validate Https Flood baseline graph Transitory Attack Edge data
    Then UI Validate Line Chart data "Requests per Second" with Label "Transitory Attack Edge"
      | value | count | offset |
      | 21641 | 60    | 5      |

  @SID_105
  Scenario: Validate Https Flood baseline graph Total Traffic data
    Then UI Validate Line Chart data "Requests per Second" with Label "Total Traffic"
      | value   | count | offset |
      | 25060.0 | 2     | 1      |

  @SID_106
  Scenario: Validate Https Flood baseline graph Long Trend Baseline data
    Then UI Validate Line Chart data "Requests per Second" with Label "Long-Term Trend Baseline"
      | value | count | offset |
      | 5075  | 59    | 2      |

  @SID_107
  Scenario: Validate Https Flood baseline graph Long Trend Attack Edge data
    Then UI Validate Line Chart data "Requests per Second" with Label "Long-Term Trend Attack Edge"
      | value | count | offset |
      | 7002  | 60    | 2      |

  @SID_108
  Scenario: Validate Https Flood baseline graph Legitimate Traffic data
    Then UI Validate Line Chart data "Requests per Second" with Label "Legitimate Traffic"
      | value   | count | offset |
      | 17500.0 | 2     | 1      |

  @SID_109
  Scenario: Validate Https Flood baseline graph 24H
    When UI Click Button "Time Picker"
    When UI Click Button "Time Range 24H" with value "24H"
    Then UI Validate Line Chart data "Requests per Second" with Label "Legitimate Traffic"
      | value | count | offset |
      | null  | 24    | 1      |

  @SID_110
  Scenario: Validate Https Flood baseline graph 1H
    When UI Click Button "Time Range 1H" with value "1H"
    Then UI Validate Line Chart data "Requests per Second" with Label "Legitimate Traffic"
      | value | count | offset |
      | null  | 238   | 1      |

  @SID_111
  Scenario: Validate Https Flood baseline graph 30m
    When UI Click Button "Time Range 30m" with value "30m"
    Then UI Validate Line Chart data "Requests per Second" with Label "Legitimate Traffic"
      | value | count | offset |
      | null  | 118   | 1      |

  @SID_112
  Scenario: Validate Https Flood baseline graph 15m
    When UI Click Button "Time Range 15m" with value "15m"
    When UI Click Button "Time Picker"
    Then UI Validate Line Chart data "Requests per Second" with Label "Legitimate Traffic"
      | value | count | offset |
      | null  | 58    | 1      |

  @SID_113
  Scenario: Validate Https Flood baseline graph Transitory Baseline styling
    Then UI Validate Line Chart attributes "Requests per Second" with Label "Transitory Baseline"
      | attribute             | value   |
      | backgroundColor       | #8CBA46 |
      | steppedLine           | true    |
      | pointHoverBorderWidth | 1       |
      | borderColor           | #8CBA46 |
      | pointHitRadius        | 10      |
      | pointRadius           | 0       |
      | pointHoverRadius      | 4       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | borderDashOffset      | 0       |
      | borderCapStyle        | butt    |
      | lineTension           | 0.35    |
      | fill                  | false   |

  @SID_114
  Scenario: Validate Https Flood baseline graph Transitory Attack Edge styling
    Then UI Validate Line Chart attributes "Requests per Second" with Label "Transitory Attack Edge"
      | attribute             | value          |
      | backgroundColor       | rgb(154, 1, 1) |
      | steppedLine           | true           |
      | pointHoverBorderWidth | 1              |
      | borderColor           | rgb(154, 1, 1) |
      | pointHitRadius        | 10             |
      | pointRadius           | 0              |
      | pointHoverRadius      | 4              |
      | borderJoinStyle       | miter          |
      | borderDashOffset      | 0              |
      | borderWidth           | 2.5            |
      | borderCapStyle        | butt           |
      | lineTension           | 0.35           |
      | fill                  | false          |

  @SID_115
  Scenario: Validate Https Flood baseline graph Total Traffic styling
    Then UI Validate Line Chart attributes "Requests per Second" with Label "Total Traffic"
      | attribute             | value                    |
      | backgroundColor       | rgba(169, 207, 233, 0.8) |
      | pointHoverBorderWidth | 1                        |
      | borderColor           | rgb(169, 207, 233)       |
      | pointHitRadius        | 10                       |
      | pointRadius           | 0                        |
      | pointHoverRadius      | 4                        |
      | borderJoinStyle       | miter                    |
      | borderDashOffset      | 0                        |
      | borderWidth           | 1                        |
      | borderCapStyle        | butt                     |
      | lineTension           | 0.35                     |
      | fill                  | true                     |
      | borderColor           | rgb(169, 207, 233)       |
      | color                 | rgba(169, 207, 233, 0.8) |

  @SID_116
  Scenario: Validate Https Flood baseline graph Long Trend Baseline styling
    Then UI Validate Line Chart attributes "Requests per Second" with Label "Long-Term Trend Baseline"
      | attribute             | value   |
      | backgroundColor       | #67853B |
      | steppedLine           | true    |
      | pointHoverBorderWidth | 1       |
      | borderColor           | #67853B |
      | pointHitRadius        | 10      |
      | pointRadius           | 0       |
      | pointHoverRadius      | 4       |
      | borderJoinStyle       | miter   |
      | borderDashOffset      | 0       |
      | borderWidth           | 2.5     |
      | borderCapStyle        | butt    |
      | lineTension           | 0.35    |
      | fill                  | false   |

  @SID_117
  Scenario: Validate Https Flood baseline graph Long Trend Attack Edge styling
    Then UI Validate Line Chart attributes "Requests per Second" with Label "Long-Term Trend Attack Edge"
      | attribute             | value   |
      | backgroundColor       | #EC3434 |
      | steppedLine           | true    |
      | pointHoverBorderWidth | 1       |
      | borderColor           | #EC3434 |
      | pointHitRadius        | 10      |
      | pointRadius           | 0       |
      | pointHoverRadius      | 4       |
      | borderJoinStyle       | miter   |
      | borderDashOffset      | 0       |
      | borderWidth           | 2.5     |
      | borderCapStyle        | butt    |
      | lineTension           | 0.35    |
      | fill                  | false   |

  @SID_118
  Scenario: Validate Https Flood baseline graph Legitimate Traffic styling
    Then UI Validate Line Chart attributes "Requests per Second" with Label "Legitimate Traffic"
      | attribute             | value                 |
      | backgroundColor       | rgba(66, 75, 83, 0.5) |
      | pointHoverBorderWidth | 1                     |
      | borderColor           | rgba(66, 75, 83, 0.5) |
      | pointHitRadius        | 10                    |
      | pointRadius           | 0                     |
      | pointHoverRadius      | 4                     |
      | borderJoinStyle       | miter                 |
      | borderDashOffset      | 0                     |
      | borderWidth           | 1                     |
      | borderCapStyle        | butt                  |
      | lineTension           | 0.35                  |
      | fill                  | true                  |
      | color                 | rgba(66, 75, 83, 0.5) |

  ###############################################################
  ##https Https set toggle to Current - Verify changes occured ##
  ###############################################################

# verify 1. refrest occured 2. only current is updating 3. toggle starttime is not changing
  @SID_119
  Scenario: Run DP simulator PCAPs for Https Flood - Make Change
    * CLI kill all simulator attacks on current vision
    Given CLI simulate 2 attacks of type "HTTPS-Twist" on "DefensePro" 11 with loopDelay 5000 and wait 90 seconds

  @SID_120
  Scenario: Https set toggle to Current - After Change
    * UI Click Button "toggle Current"

  @SID_121
  Scenario: Validate Https Flood distributed size graph data - Baseline - After Change
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Baseline"
      | value       | count | index | offset      |
      | 0.6         | 1     | 0     | 0.1         |
      | 0.97232455  | 1     | 1     | 0.00000001  |
      | 0.77        | 1     | 2     | 0.01        |
      | 0.027675444 | 1     | 4     | 0.000000001 |
      | 0           | 46    | 5     | 0.1         |

  @SID_122
  Scenario: Validate Https Flood distributed size graph data - Real Time Traffic - After Change
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Real-Time Traffic"
      | value      | count | index | offset |
      | 0          | 46    | 0     | 0      |
      | 0.23451911 | 1     | 1     | 0      |
      | 0.214519   | 1     | 2     | 0      |
      | 0.81       | 1     | 4     | 0      |
      | 0.5        | 1     | 49    | 0      |

  @SID_123
  Scenario: Validate Https Flood distributed size graph data - Attack Edge - After Change
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Attack Edge"
      | value      | count | index | offset |
      | 0          | 48    | 0     | 0      |
      | 1          | 1     | 1     | 0      |
      | 0.47802296 | 1     | 4     | 0      |

  @SID_124
  Scenario: Validate Https Flood distributed size graph data - Under Attack - After Change
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Under Attack"
      | value      | count | index | offset |
      | 0          | 46    | 0     | 0      |
      | 0.23451911 | 1     | 1     | 0      |
      | 0.214519   | 1     | 2     | 0      |
      | 0.81       | 1     | 4     | 0      |
      | 0.5        | 1     | 49    | 0      |

  ################################################################################
  ##https Https set toggle to Attack Start Time - Verify NO !!! changes occured ##
  ################################################################################

  # Navigate Back in order to refresh https start time
  @SID_125
  Scenario: Https set toggle to Attack Start Time - After Change
    * UI Click Button "Characteristics.HTTPS Go-Back"
    * UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "HTTPS Flood"
    * UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0
    * UI Click Button "toggle Attack Start Time"

  @SID_126
  Scenario: Validate Https Flood distributed size graph data - Baseline - Attack Start Time - After Change
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Baseline"
      | value       | count | index | offset |
      | 0           | 48    | 0     | 0      |
      | 0.97232455  | 1     | 1     | 0      |
      | 0.027675444 | 1     | 4     | 0      |

  @SID_127
  Scenario: Validate Https Flood distributed size graph data - Real Time Traffic - Attack Start Time - After Change
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Real-Time Traffic"
      | value      | count | index | offset |
      | 0          | 48    | 0     | 0      |
      | 0.23451911 | 1     | 1     | 0      |
      | 0.7654809  | 1     | 4     | 0      |

  @SID_128
  Scenario: Validate Https Flood distributed size graph data - Attack Edge - Attack Start Time - After Change
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Attack Edge"
      | value      | count | index | offset |
      | 0          | 48    | 0     | 0      |
      | 1          | 1     | 1     | 0      |
      | 0.47802296 | 1     | 4     | 0      |

  @SID_129
  Scenario: Validate Https Flood distributed size graph data - Under Attack - Attack Start Time - After Change
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Under Attack"
      | value      | count | index | offset |
      | 0          | 48    | 0     | 0      |
      | 0.23451911 | 1     | 1     | 0      |
      | 0.7654809  | 1     | 4     | 0      |

  @SID_130
  Scenario: Logout
    Then UI Logout

      ##################################################   Https Flood Outbound   ######################################################

  @SID_131
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-attack-*"
    * REST Delete ES index "dp-https-rt-*"
    * REST Delete ES index "dp-daily-https-rt-*"
    * REST Delete ES index "dp-hourly-https-rt-*"
    * REST Delete ES index "dp-https-stats*"

  @SID_132
  Scenario: Run DP simulator PCAPs for "Protection Policies" - 3rd drill - Https Flood
    Given CLI simulate 2 attacks of type "HTTPS" on "DefensePro" 11 with loopDelay 5000 and wait 60 seconds

  @SID_133
  Scenario: Login and open VRM DNS attack details
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @SID_134
  Scenario: Entering to the under attack policy 3nd drill https flood
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Attack Categories" findBy cellValue "HTTPS Flood"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "HTTPS Flood"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 1

      ##Https Flood - Info Card

  @SID_135
  Scenario: Validate info card data - https flood
    Then UI Validate Text field "Info.Protocol" EQUALS "Protocol: TCP"
    Then UI Validate Text field "Info.Total packets" EQUALS "Total Packets: 0"
    Then UI Validate Text field "Info.Volume" EQUALS "Volume: 0 Bytes"
    Then UI Validate Text field "Info.Physical Port" EQUALS "Physical Port: 0"
    Then UI Validate Text field "Info.Device IP" EQUALS "Device IP Address: 172.16.22.51"
    Then UI Click Button "Info.Description" with value "Description"
    Then UI Validate Text field "Info.Description" CONTAINS "Description"
    Then UI Click Button "Info.Description" with value "Description"
    Then UI Validate Text field "Info.HTTPS Protected Server" EQUALS "Protected SSL Object: test"


        ##https flood - Per attack card

  @SID_136
  Scenario: Validate per attack card data - https flood
    Then UI Validate Text field "Characteristics.HTTPS Attack Duration" CONTAINS "Attack Duration:"
    Then UI Validate Text field "Characteristics.Attack State" EQUALS "Attack State:Mitigation"
    Then UI Validate Text field "Characteristics.Attack Detection" EQUALS "Attack Detection Method:By Volume of HTTPS Responses"
    Then UI Validate Text field "Characteristics.Attack Mitigation Method" EQUALS "Attack Mitigation Method:Rate Limit Suspected Attackers"
    Then UI Validate Text field "Characteristics.HTTPS Authentication Method" EQUALS "Authentication Method:302 Redirect"
    Then UI Validate Text field "Characteristics.HTTPS Suspect-Source" EQUALS "Total Suspect Sources:16"
    Then UI Validate Text field "Characteristics.HTTPS Challenge-Rate per Second" EQUALS "Total Requests Challenged:14"
    Then UI Validate Text field "Characteristics.HTTPS Drop-Rate" EQUALS "Total Packets Dropped:11"
    Then UI Validate Text field "Characteristics.Total Unique Sources Challenged" EQUALS "Total Sources Challenged:1,200,009"
    Then UI Validate Text field "Characteristics.Total Unique Sources Authenticated" EQUALS "Total Sources Authenticated:13"
    Then UI Validate Text field "Characteristics.Total Attacker Sources" EQUALS "Total Attacker Sources:17"
    Then UI Validate Text field "Characteristics.Authentication List Utilization" EQUALS "Authentication List Utilization:15 %"
    #Outbound characteristics
    Then UI Validate Text field "Characteristics.Responses_Volume" EQUALS "Responses Volume:37"
    Then UI Validate Text field "Characteristics.Volume_Transitory_Baseline_Value" EQUALS "Responses Volume Transitory Baseline Value:33 RPS"
    Then UI Validate Text field "Characteristics.Volume_Transitory_Attack-Edge_Value" EQUALS "Responses Volume Transitory Attack-Edge Value:34 RPS"
    Then UI Validate Text field "Characteristics.Volume_Long-Trend_Baseline_Value" EQUALS "Responses Volume Long-Term Trend Baseline Value:31 RPS"
    Then UI Validate Text field "Characteristics.Volume_Long-Trend_Attack-Edge_Value" EQUALS "Responses Volume Long-Term Trend Attack-Edge Value:32 RPS"
    Then UI Validate Text field "Characteristics.Response_Size" EQUALS "Average Response Size:38 Bytes"
    Then UI Validate Text field "Characteristics.Response_Size_Baseline_Value" EQUALS "Average Response-Size Baseline Value:35 Bytes"
    Then UI Validate Text field "Characteristics.Response_Size_Attack_Edge_Value" EQUALS "Average Response-Size Attack-Edge Value:36 Bytes"
    Then UI Validate Text field "Characteristics.Exceed_Requests_Rate" EQUALS "Exceed Average Response Size:22"

  ##https flood -  Attack Log

  @SID_137
  Scenario: Validate Attack Log card data - https flood
    Then UI Text of "Attack Log" with extension "0" contains "State:  Mitigation."
    Then UI Text of "Attack Log" with extension "1" contains "State:  Rate Limit Suspected Attackers."
    Then UI Text of "Attack Log" with extension "2" contains "State:  Characterization."

  @SID_138
  Scenario: Validate Https Response Bandwidth graph Transitory Baseline
    Then UI Validate Line Chart data "Response Bandwidth" with Label "Transitory Baseline"
      | value      | count | offset |
      | null       | 57    | 2      |
      | 10070.6284 | 2     | 1      |

  @SID_139
  Scenario: Validate Https Response Bandwidth graph Transitory Attack Edge
    Then UI Validate Line Chart data "Response Bandwidth" with Label "Transitory Attack Edge"
      | value              | count | offset |
      | null               | 57    | 2      |
      | 15120.576985000002 | 2     | 1      |

  @SID_140
  Scenario: Validate Https Response Bandwidth graph Real-Time Traffic
    Then UI Validate Line Chart data "Response Bandwidth" with Label "Real-Time Traffic"
      | value  | count | offset |
      | null   | 57    | 2      |
      | 6379.5 | 2     | 1      |

  @SID_141
  Scenario: Validate Https Response Bandwidth graph Long Trend Baseline data
    Then UI Validate Line Chart data "Response Bandwidth" with Label "Long-Term Trend Baseline"
      | value    | count | offset |
      | null     | 57    | 2      |
      | 140.9568 | 2     | 1      |

  @SID_142
  Scenario: Validate Https Response Bandwidth graph Long-Term Trend Attack Edge
    Then UI Validate Line Chart data "Response Bandwidth" with Label "Long-Term Trend Attack Edge"
      | value     | count | offset |
      | null      | 57    | 2      |
      | 240.82397 | 2     | 1      |

  @SID_143
  Scenario: Validate Https Average Response Size graph Long-Term Trend Baseline
    Then UI Validate Line Chart data "Average Response Size" with Label "Long-Term Trend Baseline"
      | value              | count | offset |
      | null               | 57    | 2      |
      | 370.47839999999997 | 2     | 1      |

  @SID_144
  Scenario: Validate Https Average Response Size graph Long-Term Trend Attack Edge
    Then UI Validate Line Chart data "Average Response Size" with Label "Long-Term Trend Attack Edge"
      | value       | count | offset |
      | null        | 57    | 2      |
      | 5620.761985 | 2     | 1      |

  @SID_145
  Scenario: Validate Https Average Response Size graph Real-Time Traffic
    Then UI Validate Line Chart data "Average Response Size" with Label "Real-Time Traffic"
      | value  | count | offset |
      | null   | 57    | 2      |
      | 6129.5 | 2     | 1      |

  @SID_146
  Scenario: Validate Https Flood baseline graph 24H
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "24H"
    Then UI Validate Line Chart data "Average Response Size" with Label "Real-Time Traffic"
      | value | count | offset |
      | null  | 24    | 1      |
    Then UI Validate Line Chart data "Response Bandwidth" with Label "Long-Term Trend Attack Edge"
      | value | count | offset |
      | null  | 24    | 1      |

  @SID_147
  Scenario: Validate Https Flood baseline graph 1H
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1H"
    Then UI Validate Line Chart data "Average Response Size" with Label "Real-Time Traffic"
      | value | count | offset |
      | null  | 238   | 1      |
    Then UI Validate Line Chart data "Response Bandwidth" with Label "Long-Term Trend Attack Edge"
      | value | count | offset |
      | null  | 238   | 1      |

  @SID_148
  Scenario: Validate Https Flood baseline graph 30m
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "30m"
    Then UI Validate Line Chart data "Average Response Size" with Label "Real-Time Traffic"
      | value | count | offset |
      | null  | 118   | 1      |
    Then UI Validate Line Chart data "Response Bandwidth" with Label "Long-Term Trend Attack Edge"
      | value | count | offset |
      | null  | 118   | 1      |

  @SID_149
  Scenario: Validate Https Flood baseline graph 15m
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "15m"
    Then UI Validate Line Chart data "Average Response Size" with Label "Real-Time Traffic"
      | value | count | offset |
      | null  | 58    | 2      |
    Then UI Validate Line Chart data "Response Bandwidth" with Label "Long-Term Trend Attack Edge"
      | value | count | offset |
      | null  | 58    | 2      |

  @SID_150
  Scenario: Validate Https Response Bandwidth graph Transitory Baseline styling
    Then UI Validate Line Chart attributes "Response Bandwidth" with Label "Transitory Baseline"
      | attribute             | value   |
      | backgroundColor       | #8CBA46 |
      | steppedLine           | true    |
      | pointHoverBorderWidth | 1       |
      | borderColor           | #8CBA46 |
      | pointHitRadius        | 10      |
      | pointRadius           | 0       |
      | pointHoverRadius      | 4       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | borderDashOffset      | 0       |
      | borderCapStyle        | butt    |
      | lineTension           | 0.35    |
      | fill                  | false   |

  @SID_151
  Scenario: Validate Https Response Bandwidth graph Transitory Attack Edge styling
    Then UI Validate Line Chart attributes "Response Bandwidth" with Label "Transitory Attack Edge"
      | attribute             | value          |
      | backgroundColor       | rgb(154, 1, 1) |
      | steppedLine           | true           |
      | pointHoverBorderWidth | 1              |
      | borderColor           | rgb(154, 1, 1) |
      | pointHitRadius        | 10             |
      | pointRadius           | 0              |
      | pointHoverRadius      | 4              |
      | borderJoinStyle       | miter          |
      | borderDashOffset      | 0              |
      | borderWidth           | 2.5            |
      | borderCapStyle        | butt           |
      | lineTension           | 0.35           |
      | fill                  | false          |

  @SID_152
  Scenario: Validate Https Flood baseline graph Real-Time Traffic styling
    Then UI Validate Line Chart attributes "Response Bandwidth" with Label "Real-Time Traffic"
      | attribute             | value                    |
      | backgroundColor       | rgba(169, 207, 233, 0.8) |
      | pointHoverBorderWidth | 1                        |
      | borderColor           | rgba(169, 207, 233, 0.8) |
      | pointHitRadius        | 10                       |
      | pointRadius           | 0                        |
      | pointHoverRadius      | 4                        |
      | borderJoinStyle       | miter                    |
      | borderDashOffset      | 0                        |
      | borderWidth           | 1                        |
      | borderCapStyle        | butt                     |
      | lineTension           | 0.35                     |
      | fill                  | true                     |
      | color                 | rgba(169, 207, 233, 0.8) |

  @SID_153
  Scenario: Validate Https Response Bandwidth graph Long Trend Baseline styling
    Then UI Validate Line Chart attributes "Response Bandwidth" with Label "Long-Term Trend Baseline"
      | attribute             | value   |
      | backgroundColor       | #67853B |
      | steppedLine           | true    |
      | pointHoverBorderWidth | 1       |
      | borderColor           | #67853B |
      | pointHitRadius        | 10      |
      | pointRadius           | 0       |
      | pointHoverRadius      | 4       |
      | borderJoinStyle       | miter   |
      | borderDashOffset      | 0       |
      | borderWidth           | 2.5     |
      | borderCapStyle        | butt    |
      | lineTension           | 0.35    |
      | fill                  | false   |

  @SID_154
  Scenario: Validate Https Flood baseline graph Long Trend Attack Edge styling
    Then UI Validate Line Chart attributes "Response Bandwidth" with Label "Long-Term Trend Attack Edge"
      | attribute             | value   |
      | backgroundColor       | #EC3434 |
      | steppedLine           | true    |
      | pointHoverBorderWidth | 1       |
      | borderColor           | #EC3434 |
      | pointHitRadius        | 10      |
      | pointRadius           | 0       |
      | pointHoverRadius      | 4       |
      | borderJoinStyle       | miter   |
      | borderDashOffset      | 0       |
      | borderWidth           | 2.5     |
      | borderCapStyle        | butt    |
      | lineTension           | 0.35    |
      | color                 | #EC3434 |
      | fill                  | false   |

  @SID_155
  Scenario: Validate Https Average Response Size graph Long-Term Trend Baseline
    Then UI Validate Line Chart attributes "Average Response Size" with Label "Long-Term Trend Baseline"
      | attribute             | value   |
      | backgroundColor       | #67853B |
      | pointHoverBorderWidth | 1       |
      | borderColor           | #67853B |
      | pointHitRadius        | 10      |
      | pointRadius           | 0       |
      | pointHoverRadius      | 4       |
      | borderJoinStyle       | miter   |
      | borderDashOffset      | 0       |
      | borderWidth           | 2.5     |
      | borderCapStyle        | butt    |
      | lineTension           | 0.35    |
      | fill                  | false   |
      | color                 | #67853B |

  @SID_156
  Scenario: Validate Https Average Response Size graph Long-Term Trend Attack Edge
    Then UI Validate Line Chart attributes "Average Response Size" with Label "Long-Term Trend Attack Edge"
      | attribute             | value   |
      | backgroundColor       | #EC3434 |
      | steppedLine           | true    |
      | pointHoverBorderWidth | 1       |
      | borderColor           | #EC3434 |
      | pointHitRadius        | 10      |
      | pointRadius           | 0       |
      | pointHoverRadius      | 4       |
      | borderJoinStyle       | miter   |
      | borderDashOffset      | 0       |
      | borderWidth           | 2.5     |
      | borderCapStyle        | butt    |
      | lineTension           | 0.35    |
      | fill                  | false   |
      | color                 | #EC3434 |

  @SID_157
  Scenario: Validate Https Average Response Size graph Long-Term Trend Attack Edge
    Then UI Validate Line Chart attributes "Average Response Size" with Label "Long-Term Trend Attack Edge"
      | attribute             | value   |
      | backgroundColor       | #EC3434 |
      | pointHoverBorderWidth | 1       |
      | borderColor           | #EC3434 |
      | pointHitRadius        | 10      |
      | pointRadius           | 0       |
      | pointHoverRadius      | 4       |
      | borderJoinStyle       | miter   |
      | borderDashOffset      | 0       |
      | borderWidth           | 2.5     |
      | borderCapStyle        | butt    |
      | lineTension           | 0.35    |
      | fill                  | false   |
      | borderColor           | #EC3434 |
      | color                 | #EC3434 |

      ###############################################   Burst   ###############################################################

  @SID_158
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"

  @SID_159
  Scenario: run burst attack
    Given CLI simulate 4 attacks of type "my_burst" on "DefensePro" 10 and wait 35 seconds

  @SID_160
  Scenario:  Entering to the under attack policy 3nd drill BDoS burst
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "BDOS"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Behavioral DoS"
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy columnName "Attack Categories" findBy cellValue "Behavioral DoS"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0

  @SID_161
  Scenario: Validate info card data - burst
    Then UI Validate Text field "Info.Protocol" EQUALS "Protocol: TCP"
    Then UI Validate Text field "Info.Total packets" EQUALS "Total Packets: 36"
    Then UI Validate Text field "Info.Volume" EQUALS "Volume: 50.69 KBytes"
    Then UI Validate Text field "Info.Physical Port" EQUALS "Physical Port: 0"
    Then UI Validate Text field "Info.Device IP" EQUALS "Device IP Address: 172.16.22.50"
    Then UI Click Button "Info.Description" with value "Description"
    Then UI Validate Text field "Info.Description" CONTAINS "Description"
    Then UI Validate Text field "Info.Description" CONTAINS "RFC 675"
    Then UI Click Button "Info.Description" with value "Description"

  @SID_162
  Scenario: Validate per attack card data - Burst
    Then UI Validate Text field "Characteristics.State" EQUALS "State:Burst-Attack Signature Blocking"
    Then UI Validate Text field "Characteristics.Current Burst Number" EQUALS "Current Burst Number:10"
    Then UI Validate Text field "Characteristics.Avg Burst Duration" EQUALS "Average Burst Duration:0:00:28 (hh.mm.ss)"
    Then UI Validate Text field "Characteristics.Avg Time Between Bursts" EQUALS "Average Time Between Bursts:0:01:04 (hh.mm.ss)"
    Then UI Validate Text field "Characteristics.Avg Burst Rate" EQUALS "Average Burst Rate:726581 Kbps"
    Then UI Validate Text field "Characteristics.Max Burst Rate" EQUALS "Max Burst Rate:800002 Kbps"

  @SID_163
  Scenario: Validate baseline Normal Edge data - burst
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 96    | 7     | 1      |
      | null  | 53    | 4      |

  @SID_164
  Scenario: Validate baseline Suspected Edge data - burst
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Suspected Edge"
      | value | count | offset |
      | 2081  | 63    | 6      |

  @SID_165
  Scenario: Validate baseline Total Traffic data - burst
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 5182  | 7     | 2      |
      | 1727  | 7     | 2      |

  @SID_166
  Scenario: Validate baseline Total Traffic styling - burst
    And UI Validate Line Chart attributes "BDoS-TCP SYN ACK" with Label "Total Traffic"
      | attribute             | value                    |
      | pointRadius           | 0                        |
      | fill                  | true                     |
      | lineTension           | 0.35                     |
      | borderCapStyle        | butt                     |
      | borderDashOffset      | 0                        |
      | borderJoinStyle       | miter                    |
      | borderWidth           | 1                        |
      | pointHoverRadius      | 4                        |
      | pointHoverBorderWidth | 1                        |
      | backgroundColor       | rgba(141, 190, 214, 0.1) |
      | borderColor           | rgba(141, 190, 214, 5)   |

  @SID_167
  Scenario: Validate baseline Suspected Edge styling - burst
    And UI Validate Line Chart attributes "BDoS-TCP SYN ACK" with Label "Suspected Edge"
      | attribute             | value   |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ffa20d |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

  @SID_168
  Scenario: Protection Policies 3rd drill Cleanup
    Given UI logout and close browser
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
