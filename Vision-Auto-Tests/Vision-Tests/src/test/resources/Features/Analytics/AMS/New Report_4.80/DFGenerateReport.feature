@TC118823
Feature: DFGenerateReport


  @SID_1 @Sanity
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "df-attack*"
    * CLI Clear vision logs

  @SID_2 @Sanity
  Scenario: Change DF management IP to IP of Generic Linux
    When CLI Operations - Run Radware Session command "system df management-ip set 172.17.164.10"
    When CLI Operations - Run Radware Session command "system df management-ip get"
    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 172.17.164.10"


  @SID_3 @Sanity
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
  Scenario: VRM - Login to AMS DefenseFlow Analytics Dashboard
    Then UI Login with user "radware" and password "radware"

  @SID_5
  Scenario: validate destination
    Then CLI Run linux Command "service iptables stop" on "ROOT_SERVER_CLI" and validate result CONTAINS "Unloading modules"
    Then UI Validate Pie Chart data "Top Attack Destination-DefenseFlow Analytics" in Report "dfGenerateReport"
      | label          | data |
      | 94.125.59.119  | 178  |
      | 94.125.59.52   | 33   |
      | 5.62.87.26     | 9    |
      | 94.125.61.203  | 9    |
      | 94.125.59.1    | 6    |
      | 185.31.222.138 | 4    |

  @SID_6
  Scenario: validate count
    Then UI Validate StackBar data with widget "Top Attacks by Count-DefenseFlow Analytics" in report "dfGenerateReport"
      | label  | value | legendName                 |
      | PO_100 | 86    | HTTP (recv.pps)            |
      | PO_200 | 32    | HTTP (recv.pps)            |
      | PO_300 | 32    | HTTP (recv.pps)            |

      | PO_100 | 19    | UDP Port 0 (recv.pps)      |
      | PO_200 | 7     | UDP Port 0 (recv.pps)      |
      | PO_300 | 7     | UDP Port 0 (recv.pps)      |

      | PO_100 | 17    | Total (recv.bps)           |
      | PO_200 | 1     | Total (recv.bps)           |
      | PO_300 | 1     | Total (recv.bps)           |

      | PO_100 | 6     | network flood IPv6 UDP     |
      | PO_200 | 6     | network flood IPv6 UDP     |
      | PO_300 | 6     | network flood IPv6 UDP     |

      | PO_100 | 7     | DOSS-NTP-monlist-flood     |
      | PO_200 | 5     | DOSS-NTP-monlist-flood     |
      | PO_300 | 5     | DOSS-NTP-monlist-flood     |

  @SID_7
  Scenario: validate protocols
    Then UI Validate StackBar data with widget "Top Attacks by Protocol-DefenseFlow Analytics" in report "dfGenerateReport"
      | label                      | value | legendName |
      | DOSS-NTP-monlist-flood     | null  | ICMP       |
      | External report            | null  | ICMP       |
      | HTTP (recv.bps)            | null  | ICMP       |
      | HTTP (recv.pps)            | null  | ICMP       |
      | HTTPS Flood Protection     | 3     | ICMP       |
      | network flood IPv4 TCP-SYN | null  | ICMP       |
      | network flood IPv4 UDP     | 3     | ICMP       |
      | network flood IPv6 UDP     | null  | ICMP       |
      | Total (recv.bps)           | null  | ICMP       |
      | Total (recv.pps)           | 3     | ICMP       |
      | UDP Port 0 (recv.pps)      | null  | ICMP       |

  @SID_8
  Scenario: validate that generate report exist in UI
  Scenario: create new OWASP Top 10 1
    Given UI "Create" Report With Name "DF Report"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[DDoS Attack Activations per Period],Protected Objects:[All], showTable:true |
      | Time Definitions.Date | Quick:This Week                                                                                                       |
    Then UI "Generate" Report With Name "DF Report"
      | timeOut | 60 |

    Then UI Click Button "Log Preview" with value "DF Report_0"
    Then UI Validate generate report with name "DF Report" is exist

  @SID_9
  Scenario: start IPTABLES
    Then CLI Run linux Command "service iptables start" on "ROOT_SERVER_CLI" and validate result CONTAINS "Loading additional modules"









