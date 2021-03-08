@Analytics_ADC @TC105998
Feature: Forensic Attack details Tests

  
  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    Given CLI Reset radware password
    # Sleeping in order to let collector cache clean
    Then Sleep "20"
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"

    * REST Delete ES index "forensics-*"
    * REST Delete ES index "dpforensics-*"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    * CLI Clear vision logs

  
  @SID_2
  Scenario: Run DP simulator
    Given CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10 and wait 250 seconds

  
  @SID_3
  Scenario: VRM - Login to VRM Forensics
    Given UI Login with user "sys_admin" and password "radware"
   * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "AMS Forensics" page via homepage
    Then UI Click Button "New Forensics Tab"

  
  @SID_4
  Scenario: VRM - Add New Forensics Report Attack details1
    When UI "Create" Forensics With Name "Attack Details1"
      | Output | Action,Attack ID,Threat Category,Duration |
    Then UI Click Button "My Forensics" with value "Attack Details1"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Attack Details1"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Attack Details1,0"

 ######################################################### Refine ########################################################################

  @SID_5
  Scenario: Validate attack details refine by Action
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | Action |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 26
    * UI Click Button "Forensics.Clear Refine"

  @SID_6
  Scenario: Validate attack details refine by Attack ID
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | Attack ID |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 1
    * UI Click Button "Forensics.Clear Refine"

  @SID_7
  Scenario: Validate attack details refine by Start Time
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | Start Time |
    #  move to manual because refine by time is not absolute
      # Then UI Validate "Forensics.Table" Table rows count EQUALS to 1
    * UI Click Button "Forensics.Clear Refine"

  @SID_8
  Scenario: Validate attack details refine by Source IP Address
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | Source IP Address |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 4

    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "803-1525623158"
      | columnName | value |
      | Action     | Drop  |

    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
      | columnName | value |
      | Action     | Drop  |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "78-1536381752"
      | columnName | value |
      | Action     | Drop  |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "78-1526381752"
      | columnName | value |
      | Action     | Drop  |
    * UI Click Button "Forensics.Clear Refine"

  @SID_9
  Scenario: Validate attack details refine by Source Port
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | Source Port |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 8
    * UI Click Button "Forensics.Clear Refine"

  @SID_10
  Scenario: Validate attack details refine by Destination IP Address
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | Destination IP Address |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 4
    * UI Click Button "Forensics.Clear Refine"

  @SID_11
  Scenario: Validate attack details refine by Destination Port
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | Destination Port |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2
    * UI Click Button "Forensics.Clear Refine"

  @SID_12
  Scenario: Validate attack details refine by Direction
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | Direction |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 3
    * UI Click Button "Forensics.Clear Refine"

  @SID_13
  Scenario: Validate attack details refine by Protocol
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | Protocol |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 19
    * UI Click Button "Forensics.Clear Refine"

  @SID_14
  Scenario: Validate attack details refine by Threat Category
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | Threat Category |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 6
    * UI Click Button "Forensics.Clear Refine"

  @SID_15
  Scenario: Validate attack details refine by Radware ID
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | Radware ID |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 1
    * UI Click Button "Forensics.Clear Refine"

  @SID_16
  Scenario: Validate attack details refine by Attack Name
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | Attack Name |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 1
    * UI Click Button "Forensics.Clear Refine"

  @SID_17
  Scenario: Validate attack details refine by Device IP Address
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | Device IP Address |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 35
    * UI Click Button "Forensics.Clear Refine"

  @SID_18
  Scenario: Validate attack details refine by End Time
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | End Time |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 1
    * UI Click Button "Forensics.Clear Refine"

  @SID_19
  Scenario: Validate attack details refine by Duration
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | Duration |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 3 with offset 2
    * UI Click Button "Forensics.Clear Refine"

#  @SID_20
#  Scenario: Validate attack details refine by pps
#    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
#    And UI Click Button "Refine View"
#    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
#      | pps |
#    Then UI Validate "Forensics.Table" Table rows count EQUALS to 1
#    * UI Click Button "Forensics.Clear Refine"

#  @SID_21
#  Scenario: Validate attack details refine by Mbps
#    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
#    And UI Click Button "Refine View"
#    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
#      | Mbps |
#    Then UI Validate "Forensics.Table" Table rows count EQUALS to 1
#    * UI Click Button "Forensics.Clear Refine"

  @SID_22
  Scenario: Validate attack details refine by Physical Port
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | Physical Port |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2
    * UI Click Button "Forensics.Clear Refine"

  @SID_23
  Scenario: Validate attack details refine by Policy Name
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | Policy Name |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2
    * UI Click Button "Forensics.Clear Refine"

  @SID_24
  Scenario: Validate attack details refine by Risk
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | Risk |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 10
    * UI Click Button "Forensics.Clear Refine"

  @SID_25
  Scenario: Validate attack details refine by VLAN Tag
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | VLAN Tag |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 33
    * UI Click Button "Forensics.Clear Refine"

  @SID_26
  Scenario: Validate attack details refine by group 1
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | VLAN Tag |
      | Risk     |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 10
    * UI Click Button "Forensics.Clear Refine"

  
  @SID_27
  Scenario: Validate attack details refine by group 2
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Forensics.Attack Details.Refine.Dropdown" apply
      | Source Port       |
      | Protocol          |
      | Device IP Address |
      | Duration          |
      | Risk              |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 1
    * UI Click Button "Forensics.Clear Refine"

##################################################### Attack PCAP file ####################################################################
  
  @SID_28
  Scenario: Validate downloaded capture file
    Then Delete downloaded file with name "attack_800-1525623158_packets.pcap"
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "800-1525623158"
    And UI Click Button "Forensics.Attack Details.DownloadPCAP"
    Then Validate downloaded file size with name "attack_800-1525623158_packets.pcap" equal to 304
    Then Delete downloaded file with name "attack_800-1525623158_packets.pcap"
    When UI Click Button "Forensics.Attack Details.Close"
    And UI logout and close browser


##################################################### Attack Details ####################################################################
  
  @SID_29
  Scenario: VRM - Login to VRM "Wizard" Test
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage
    Then UI Click Button "New Forensics Tab"

  @SID_30
  Scenario: New attack and create forensics view
    Given CLI simulate 1 attacks of type "rest_traffic_filter" on "DefensePro" 10 and wait 50 seconds
    When UI "Create" Forensics With Name "Attack_Details"
      | Output | Start Time,Action,Attack ID,Threat Category,Duration |
  
  @SID_31
  Scenario: VRM - open forensic "Attack details" table
    Then UI Click Button "My Forensics" with value "Attack_Details"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Attack_Details"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Attack_Details,0"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "7839-1402580209"
  
  @SID_32
  Scenario: Validate Behavioral DoS table
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Action" equal to "Drop"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack ID" equal to "7839-1402580209"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Threat Category" equal to "Behavioral DoS"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination IP Address" equal to "1.1.1.1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination Port" equal to "1025"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Device IP Address" equal to "172.16.22.50"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Direction" equal to "In"

    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack Name" equal to "network flood IPv4 TCP-SYN-ACK"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "Mbps" equal to "157.25"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "pps" equal to "161491"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Physical Port" equal to "1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Protocol" equal to "TCP"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Radware ID" equal to "78"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Risk" equal to "High"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Policy Name" equal to "BDOS"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source IP Address" equal to "192.85.1.2"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source Port" equal to "1024"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Status" equal to "Terminated"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "VLAN Tag" equal to "N/A"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "State" equal to "footprint-applied"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Packet Size" equal to "124"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source L4 Port" equal to "1024"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "TCP Sequence Number" equal to "123456"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "TTL" equal to "255"

    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Operator" with extension "1" equal to "OR"
    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Parameter" with extension "1" equal to "sequence-number"
    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Values" with extension "1" equal to "123456"

  
  @SID_33
  Scenario: close attack details details
    Then UI Click Button "Forensics.Attack Details.Close"

  
  @SID_34
  Scenario: Enter to 34-2206430105 details
    Given UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "34-2206430105"

  
  @SID_35
  Scenario: Validate Traffic Filters details
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Action" equal to "Drop"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack ID" equal to "34-2206430105"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Threat Category" equal to "Traffic Filters"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination IP Address" equal to "192.0.0.1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination Port" equal to "53"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Device IP Address" equal to "172.16.22.50"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Direction" equal to "In"
    Then UI Validate Element Existence By Label "Forensics.Attack Details.Detail" if Exists "true" with value "Duration"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack Name" equal to "f1"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "Mbps" equal to "11.17"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "pps" equal to "18770"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Physical Port" equal to "MNG-1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Protocol" equal to "UDP"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Radware ID" equal to "700000"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Risk" equal to "High"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Policy Name" equal to "aaa4"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source IP Address" equal to "192.85.1.2"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source Port" equal to "1024"
#   Then UI Text of "Forensics.Attack Details.Detail" with extension "Status" equal to "Terminated"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "VLAN Tag" equal to "N/A"

  @SID_36
  Scenario: close attack details details
    Then UI Click Button "Forensics.Attack Details.Close"

  @SID_37
  Scenario: Enter to 137-1414505529 details
    Given UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "137-1414505529"

  @SID_38
  Scenario: Validate SYN Flood details
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Action" equal to "Challenge"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack ID" equal to "137-1414505529"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Threat Category" equal to "SYN Flood"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination IP Address" equal to "2000::0001"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination Port" equal to "80"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Device IP Address" equal to "172.16.22.50"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Direction" equal to "Unknown"

    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack Name" equal to "SYN Flood HTTP"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "Mbps" equal to "102.49"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "pps" equal to "223890"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Physical Port" equal to "Multiple"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Protocol" equal to "TCP"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Radware ID" equal to "200000"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Risk" equal to "Medium"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Policy Name" equal to "policy1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source IP Address" equal to "Multiple"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source Port" equal to "Multiple"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Status" equal to "Terminated"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "VLAN Tag" equal to "Multiple"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Average Attack Rate" equal to "9947"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Activation Threshold" equal to "2500"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack Volume" equal to "208889"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "TCP Challenge" equal to "Transparent Proxy"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "HTTP Challenge" equal to "Cloud Authentication"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "TCP Auth. List" equal to "0"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "HTTP Auth. List" equal to "0"

  @SID_39
  Scenario: close attack details details
    Then UI Click Button "Forensics.Attack Details.Close"

  @SID_40
  Scenario: Enter to 45-1426496290 details
    Given UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "45-1426496290"

  @SID_41
  Scenario: Validate DoS details
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Action" equal to "Forward"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack ID" equal to "45-1426496290"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Threat Category" equal to "DoS"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination IP Address" equal to "198.18.252.1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination Port" equal to "80"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Device IP Address" equal to "172.16.22.50"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Direction" equal to "In"

    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack Name" equal to "pkt_rate_lmt_9"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "Mbps" equal to "0"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "pps" equal to "1296"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Physical Port" equal to "3"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Protocol" equal to "TCP"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Radware ID" equal to "600006"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Risk" equal to "Medium"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Policy Name" equal to "pph_9Pkt_lmt_252.1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source IP Address" equal to "198.18.0.1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source Port" equal to "49743"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Status" equal to "Terminated"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "VLAN Tag" equal to "N/A"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attacker IP Address" equal to "198.18.0.1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Protected Host" equal to "198.18.252.1"
    Then UI Validate Element Existence By Label "Forensics.Attack Details.Detail" if Exists "true" with value "Attack Duration [Sec]"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Current Packet Rate [Packet/Sec]" equal to "7"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Protected Port" equal to "80"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Average Packet Rate [Packet/Sec]" equal to "30"

  @SID_42
  Scenario: close attack details details
    Then UI Click Button "Forensics.Attack Details.Close"

  @SID_43
  Scenario: Enter to 531-1429625097 details
    Given UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "531-1429625097"

  @SID_44
  Scenario: Validate Intrusions details
    # since defect DE48638 will never be fixed, Action was changed from "Http 200 Ok Reset Dest" to "Http200OkResetDest"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Action" equal to "Http200OkResetDest"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack ID" equal to "531-1429625097"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Threat Category" equal to "Intrusions"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination IP Address" equal to "97.0.0.5"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination Port" equal to "80"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Device IP Address" equal to "172.16.22.50"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Direction" equal to "In"
    Then UI Validate Element Existence By Label "Forensics.Attack Details.Detail" if Exists "true" with value "Duration"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack Name" equal to "sign_seets3"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "Mbps" equal to "0"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "pps" equal to "1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Physical Port" equal to "MNG-1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Protocol" equal to "TCP"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Radware ID" equal to "320029"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Risk" equal to "High"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Policy Name" equal to "Seets_policy"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source IP Address" equal to "17.0.0.7"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source Port" equal to "26505"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Status" equal to "Occurred"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "VLAN Tag" equal to "N/A"

  @SID_45
  Scenario: close attack details details
    Then UI Click Button "Forensics.Attack Details.Close"

  @SID_46
  Scenario: Enter to 7840-1402580209 details
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "7840-1402580209"

  @SID_47
  Scenario: Validate Server Cracking details
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Action" equal to "Drop"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack ID" equal to "7840-1402580209"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Threat Category" equal to "Server Cracking"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination IP Address" equal to "1.1.1.1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination Port" equal to "80"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Device IP Address" equal to "172.16.22.50"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Direction" equal to "Out"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack Name" equal to "Brute Force Web"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "Mbps" equal to "82.14"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "pps" equal to "179244"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Physical Port" equal to "4"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Protocol" equal to "TCP"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Radware ID" equal to "400"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Risk" equal to "Medium"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Policy Name" equal to "bbt-sc1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source IP Address" equal to "192.168.43.2"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source Port" equal to "4445"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Status" equal to "Terminated"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "VLAN Tag" equal to "N/A"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Duration" equal to "13"
    Then UI Validate Element Existence By Label "Forensics.Attack Details.Detail" if Exists "true" with value "Duration"

  @SID_48
  Scenario: close attack details details
    Then UI Click Button "Forensics.Attack Details.Close"

  @SID_49
  Scenario: Enter to 136-1414505529 details
    Given UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "136-1414505529"

  @SID_50
  Scenario: Validate Anti-Scanning details
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Action" equal to "Drop"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack ID" equal to "136-1414505529"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Threat Category" equal to "Anti-Scanning"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination IP Address" equal to "10.10.1.200"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination Port" equal to "Multiple"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Device IP Address" equal to "172.16.22.50"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Direction" equal to "Unknown"

    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack Name" equal to "TCP Scan (vertical)"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "Mbps" equal to "9.33"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "pps" equal to "9867"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Physical Port" equal to "0"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Protocol" equal to "TCP"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Radware ID" equal to "350"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Risk" equal to "Medium"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Policy Name" equal to "policy1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source IP Address" equal to "192.85.1.2"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source Port" equal to "0"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Status" equal to "Terminated"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "VLAN Tag" equal to "N/A"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Avg. Time Between Probes [Sec]" equal to "0"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Blocking Duration [Sec]" equal to "10"
    # Then UI Text of "Forensics.Attack Details.Detail" with extension "Number of Probes" equal to "9957"
    # bug DE46429
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Action Reason" equal to "Configuration"

    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Outer Value" with extension "0" equal to "["

    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Operator" with extension "1" equal to "OR"
    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Parameter" with extension "1" equal to "destination-ip"
    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Value/s" with extension "1" equal to "10.10.1.200"

    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Outer Value" with extension "2" equal to "]"

    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Outer Value" with extension "3" equal to "AND"

    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Outer Value" with extension "4" equal to "["

    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Operator" with extension "5" equal to "AND"
    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Parameter" with extension "5" equal to "ttl"
    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Value/s" with extension "5" equal to "255"

    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Operator" with extension "6" equal to "AND"
    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Parameter" with extension "6" equal to "packet-size"
    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Value/s" with extension "6" equal to "124"

    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Operator" with extension "7" equal to "AND"
    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Parameter" with extension "7" equal to "sequence-number"
    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Value/s" with extension "7" equal to "123456"

    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Outer Value" with extension "8" equal to "]"

    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Operator" with extension "9" equal to "AND"
    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Parameter" with extension "9" equal to "source-ip"
    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Value/s" with extension "9" equal to "192.85.1.2"

  @SID_51
  Scenario: close attack details details
    Then UI Click Button "Forensics.Attack Details.Close"

  @SID_52
  Scenario: Enter to 7447-1402580209 details
    Given UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "7447-1402580209"

  @SID_53
  Scenario: Validate DNS Flood details
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Action" equal to "Forward"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack ID" equal to "7447-1402580209"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Threat Category" equal to "DNS Flood"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination IP Address" equal to "0.0.0.0"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination Port" equal to "0"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Device IP Address" equal to "172.16.22.50"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Direction" equal to "Unknown"
    Then UI Validate Element Existence By Label "Forensics.Attack Details.Detail" if Exists "true" with value "Duration"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack Name" equal to "DNS flood IPv4 DNS-A"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "Mbps" equal to "0"

    Then UI Text of "Forensics.Attack Details.Detail" with extension "Physical Port" equal to "0"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Protocol" equal to "UDP"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Radware ID" equal to "450"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Risk" equal to "High"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Policy Name" equal to "BDOS"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source IP Address" equal to "0.0.0.0"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source Port" equal to "0"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Status" equal to "Terminated"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "VLAN Tag" equal to "N/A"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "State" equal to "footprint-applied"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "DNS ID" equal to "1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "DNS Query Count" equal to "1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "L4 Checksum" equal to "10117"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Packet Size" equal to "124"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "TTL" equal to "255"

    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Outer Value" with extension "0" equal to "["

    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Operator" with extension "1" equal to "OR"
    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Parameter" with extension "1" equal to "checksum"
    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Value/s" with extension "1" equal to "10117"

    Then UI Text of "Forensics.Attack Details.Detail.Real-Time Signature.Outer Value" with extension "2" equal to "]"

#    Then UI Validate Text field "Forensics.Attack Details.Detail.whitelist_0" have value "mail.gooooooooooooooooooooo.uk"
#    Then UI Validate Text field "Forensics.Attack Details.Detail.whitelist_1" have value "gmail.google.com"
#    Then UI Validate Text field "Forensics.Attack Details.Detail.whitelist_2" have value "www.google.com"

  @SID_54
  Scenario: close attack details details
    Then UI Click Button "Forensics.Attack Details.Close"

  @SID_55
  Scenario: Enter to 4-1402580209 details
    Given UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "4-1402580209"

  @SID_56
  Scenario: Validate Packet Anomalies details
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Action" equal to "Drop"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack ID" equal to "4-1402580209"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Threat Category" equal to "Packet Anomalies"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination IP Address" equal to "Multiple"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination Port" equal to "0"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Device IP Address" equal to "172.16.22.50"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Direction" equal to "Unknown"
    Then UI Validate Element Existence By Label "Forensics.Attack Details.Detail" if Exists "true" with value "Duration"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack Name" equal to "Incorrect IPv4 checksum"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "Mbps" equal to "0"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "pps" equal to "1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Physical Port" equal to "0"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Protocol" equal to "IP"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Radware ID" equal to "103"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Risk" equal to "Low"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Policy Name" equal to "Packet Anomalies"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source IP Address" equal to "Multiple"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source Port" equal to "0"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Status" equal to "Occurred"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "VLAN Tag" equal to "N/A"

  @SID_57
  Scenario: Close report details
    When UI Click Button "Forensics.Attack Details.Close"

  @SID_58
  Scenario: VRM - Add New Forensics Report Attack ACL or 34-2206430105 for samples
    When UI "Create" Forensics With Name "Attack ACL"
      | Criteria | Event Criteria:Threat Category,Operator:Equals,Value:[ACL]; Event Criteria:Attack ID,Operator:Equals,Value:34-2206430105; |
      | Output   | Action,Attack ID,Threat Category,Duration                   |
    Then UI Click Button "Edit" with value "Attack ACL"
    Then UI Click Button "Expand Collapse"
    And UI Click Button "Tab" with value "criteria-tab"
    Then UI Click Button "Criteria.Any"
    Then UI Click Button "Submit" with value "Submit"
    Then UI Click Button "My Forensics" with value "Attack ACL"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Attack ACL"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Attack ACL,0"

  @SID_59
    Scenario: Enter to 78-1536381752 details
    Given UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "78-1536381752"

  @SID_60
  Scenario: Validate ACL details
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Action" equal to "Drop"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack ID" equal to "78-1536381752"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Threat Category" equal to "ACL"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination IP Address" equal to "1234:1234:1234:1234:1234:1234:1234:1235"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination Port" equal to "0"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Device IP Address" equal to "172.16.22.50"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Direction" equal to "In"
    Then UI Validate Element Existence By Label "Forensics.Attack Details.Detail" if Exists "true" with value "Duration"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack Name" equal to "Black List"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "Mbps" equal to "12618.09"
#    Then UI Text of "Forensics.Attack Details.Detail" with extension "pps" equal to "12920902"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Physical Port" equal to "T-1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Protocol" equal to "IP"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Radware ID" equal to "8"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Risk" equal to "Low"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Policy Name" equal to "Black_IPV6"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source IP Address" equal to "1234:1234:1234:1234:1234:1234:1234:1234"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Source Port" equal to "0"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Status" equal to "Occurred"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "VLAN Tag" equal to "N/A"

  @SID_61
  Scenario: close attack details details
    Then UI Click Button "Forensics.Attack Details.Close"

##################################################### Attack sampled data ####################################################################
  @SID_62
  Scenario: validate Forensic sampled data
    Given UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "34-2206430105"
    When UI Click Button "Forensics.Attack Details.LastSample"
    Then UI Validate Table record values by columns with elementLabel "Forensics.Attack Details.LastSample.table" with extension 34-2206430105 findBy index 0
      | columnName             | value      |
      | Source IP Address      | 192.85.1.2 |
      | Source Port            | 1024       |
      | Destination IP Address | 192.0.0.1  |
      | Destination Port       | 53         |
      | Phyisical Port         | MNG-1      |
      | VLAN Tag               | N/A        |
      | Protocol               | UDP        |
    
  @SID_63
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |

