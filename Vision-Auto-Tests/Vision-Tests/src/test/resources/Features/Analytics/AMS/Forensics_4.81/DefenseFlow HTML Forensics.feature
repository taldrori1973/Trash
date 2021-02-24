@TC119794

Feature: DefenseFlow HTML Forensics

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "df-attack*"
    * REST Delete ES index "forensics-*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Change DF management IP to IP of Generic Linux
    When CLI Operations - Run Radware Session command "system df management-ip set 172.17.164.10"
    When CLI Operations - Run Radware Session command "system df management-ip get"
    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 172.17.164.10"

  @SID_3
  Scenario: Run DF simulator
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_100.sh " |
      | #visionIP                                       |
      | " Terminated"                                   |
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_200.sh " |
      | #visionIP                                       |
      | " Terminated"                                   |
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER" and wait 30 seconds
      | "/home/radware/curl_DF_attacks-auto_PO_300.sh " |
      | #visionIP                                       |
      | " Terminated"                                   |

  @SID_4
  Scenario: Login and Navigate
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "New Forensics" page via homepage

  @SID_5
  Scenario: create new Forensics_DefenseFlow and validate
    Then UI Click Button "New Forensics Tab"
    When UI "Create" Forensics With Name "Forensics_DefenseFlow"
      | Product           | DefenseFlow                                                                                                                                                                                                                                                                                                   |
      | Protected Objects | All                                                                                                                                                                                                                                                                                                           |
      | Output            | Start Time,End Time,Threat Category,Attack Name,Policy Name,Source IP Address,Destination IP Address,Destination Port,Direction,Protocol,Device IP Address,Action,Attack ID,Source Port,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag,Packet Type |
      | Format            | Select: CSV                                                                                                                                                                                                                                                                                                   |
      | Share             | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                              |
    Given UI "Validate" Forensics With Name "Forensics_DefenseFlow"
      | Product           | DefenseFlow                                                                                                                                                                                                                                                                                                   |
      | Protected Objects | All                                                                                                                                                                                                                                                                                                           |
      | Output            | Start Time,End Time,Threat Category,Attack Name,Policy Name,Source IP Address,Destination IP Address,Destination Port,Direction,Protocol,Device IP Address,Action,Attack ID,Source Port,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag,Packet Type |
      | Format            | Select: CSV                                                                                                                                                                                                                                                                                                   |
      | Share             | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                              |

  @SID_6
  Scenario: Generate
    Then UI Click Button "My Forensics" with value "Forensics_DefenseFlow"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensics_DefenseFlow"
    Then Sleep "35"

  @SID_7
  Scenario: Validate Forensics.Table
    And UI Click Button "Views.Forensic" with value "Forensics_DefenseFlow"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 278

  @SID_8
  Scenario: Validate Threat Category
    And UI Click Button "Views.Forensic" with value "Forensics_DefenseFlow"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 278
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Threat Category" findBy cellValue "Behavioral DoS"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "category"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 278
    And UI Click Button "Clear Refine"


  @SID_9
  Scenario: Validate Attack Name
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "HTTP (recv.pps)"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 150
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "HTTP (recv.bps)"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 1
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "Total (recv.pps)"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 4
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "Total (recv.bps)"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 19
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "UDP Port 0 (recv.pps)"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 33
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "network flood IPv6 UDP"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 18
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "network flood IPv4 UDP"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 12
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "network flood IPv6 TCP-SYN"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 8
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "network flood Protection"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 9
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "External report"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 7
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "DOSS-NTP-monlist-flood"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 17
    And UI Click Button "Clear Refine"

  @SID_10
  Scenario: Validate Action
    And UI Click Button "Views.Forensic" with value "Forensics_DefenseFlow"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 278
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Action" findBy cellValue "Drop"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "actionType"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 278
    And UI Click Button "Clear Refine"

  @SID_11
  Scenario: Validate Protocol
    And UI Click Button "Views.Forensic" with value "Forensics_DefenseFlow"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 278
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Protocol" findBy cellValue "ICMP"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "protocol"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 9
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Protocol" findBy cellValue "IP"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "protocol"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 9
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Protocol" findBy cellValue "NonIP"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "protocol"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 76
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Protocol" findBy cellValue "TCP"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "protocol"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 151
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Protocol" findBy cellValue "UDP"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "protocol"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 33
    And UI Click Button "Clear Refine"

