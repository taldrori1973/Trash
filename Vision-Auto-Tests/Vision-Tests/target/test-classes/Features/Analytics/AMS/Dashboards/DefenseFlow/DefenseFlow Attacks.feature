@TC110936
Feature: AMS DefenseFlow Attacks Dashboard

  @SID_1 @Sanity
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "df-attack*"
    * CLI Clear vision logs

  @SID_2 @Sanity
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


  @SID_3 @Sanity
  Scenario: VRM - Login to AMS DefenseFlow Analytics Dashboard
    Given UI Login with user "sys_admin" and password "radware"
    And UI Open Upper Bar Item "AMS"
    Then Sleep "7"
    When UI Open "Dashboards" Tab
    Then UI Open "DefenseFlow Analytics Dashboard" Sub Tab
    Then UI Do Operation "Select" item "Global Time Filter"
    Then UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"

  @SID_4
  Scenario: Validate TOP ATTACKS BY Duration - All POs
    Then UI Validate StackBar data with widget "Top Attacks by Duration"
      | label                      | value | legendName      |
      | HTTP (recv.pps)            | 32    | Less than 1 min |
      | UDP Port 0 (recv.pps)      | 7     | Less than 1 min |
      | Total (recv.bps)           | 1     | Less than 1 min |
      | network flood IPv6 UDP     | 6     | Less than 1 min |
      | DOSS-NTP-monlist-flood     | 5     | Less than 1 min |
      | network flood IPv4 TCP-SYN | null  | Less than 1 min |
      | External report            | 1     | Less than 1 min |
      | network flood IPv4 UDP     | 4     | Less than 1 min |
      | HTTPS Flood Protection     | 3     | Less than 1 min |
      | Total (recv.pps)           | 1     | Less than 1 min |
      | HTTP (recv.bps)            | null  | Less than 1 min |

      | HTTP (recv.pps)            | 86    | 1-5 min         |
      | UDP Port 0 (recv.pps)      | 19    | 1-5 min         |
      | Total (recv.bps)           | 17    | 1-5 min         |
      | network flood IPv6 UDP     | 6     | 1-5 min         |
      | DOSS-NTP-monlist-flood     | 7     | 1-5 min         |
      | network flood IPv4 TCP-SYN | 8     | 1-5 min         |
      | External report            | 5     | 1-5 min         |
      | network flood IPv4 UDP     | 4     | 1-5 min         |
      | HTTPS Flood Protection     | 3     | 1-5 min         |
      | Total (recv.pps)           | 2     | 1-5 min         |
      | HTTP (recv.bps)            | null  | 1-5 min         |

      | HTTP (recv.pps)            | 32    | 5-10 min        |
      | UDP Port 0 (recv.pps)      | 7     | 5-10 min        |
      | Total (recv.bps)           | 1     | 5-10 min        |
      | network flood IPv6 UDP     | 6     | 5-10 min        |
      | DOSS-NTP-monlist-flood     | 5     | 5-10 min        |
      | network flood IPv4 TCP-SYN | null  | 5-10 min        |
      | External report            | 1     | 5-10 min        |
      | network flood IPv4 UDP     | 4     | 5-10 min        |
      | HTTPS Flood Protection     | 3     | 5-10 min        |
      | Total (recv.pps)           | 1     | 5-10 min        |
      | HTTP (recv.bps)            | null  | 5-10 min        |

  @SID_5 @Sanity
  Scenario: Validate TOP ATTACKS BY Count - All POs
    Then UI Validate StackBar data with widget "Top Attacks by Count"
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

      | PO_100 | 8     | network flood IPv4 TCP-SYN |
      | PO_200 | null  | network flood IPv4 TCP-SYN |
      | PO_300 | null  | network flood IPv4 TCP-SYN |

      | PO_100 | 7     | DOSS-NTP-monlist-flood     |
      | PO_200 | 5     | DOSS-NTP-monlist-flood     |
      | PO_300 | 5     | DOSS-NTP-monlist-flood     |

      | PO_100 | 6     | network flood IPv6 UDP     |
      | PO_200 | 6     | network flood IPv6 UDP     |
      | PO_300 | 6     | network flood IPv6 UDP     |

      | PO_100 | 5     | External report            |
      | PO_200 | 1     | External report            |
      | PO_300 | 1     | External report            |

      | PO_100 | 4     | network flood IPv4 UDP     |
      | PO_200 | 4     | network flood IPv4 UDP     |
      | PO_300 | 4     | network flood IPv4 UDP     |

      | PO_100 | 3     | HTTPS Flood Protection     |
      | PO_200 | 3     | HTTPS Flood Protection     |
      | PO_300 | 3     | HTTPS Flood Protection     |

      | PO_100 | 2     | Total (recv.pps)           |
      | PO_200 | 1     | Total (recv.pps)           |
      | PO_300 | 1     | Total (recv.pps)           |


  @SID_6
  Scenario: Validate TOP Attacks Bandwidth - All POs
    Then UI Validate StackBar data with widget "Top Attacks by Bandwidth"
      | label  | value     | legendName                 |
      | PO_100 | 46853020  | DOSS-NTP-monlist-flood     |
      | PO_200 | 33339620  | DOSS-NTP-monlist-flood     |
      | PO_300 | 33339620  | DOSS-NTP-monlist-flood     |

      | PO_100 | 1530300   | HTTP (recv.bps)            |
      | PO_200 | null      | HTTP (recv.bps)            |
      | PO_300 | null      | HTTP (recv.bps)            |

      | PO_100 | 14537383  | HTTP (recv.pps)            |
      | PO_200 | 5125524   | HTTP (recv.pps)            |
      | PO_300 | 5125524   | HTTP (recv.pps)            |

      | PO_100 | 18537500  | HTTPS Flood Protection     |
      | PO_200 | 18537500  | HTTPS Flood Protection     |
      | PO_300 | 18537500  | HTTPS Flood Protection     |

      | PO_100 | 55436060  | network flood IPv4 TCP-SYN |
      | PO_200 | null      | network flood IPv4 TCP-SYN |
      | PO_300 | null      | network flood IPv4 TCP-SYN |

      | PO_100 | 25544270  | network flood IPv4 UDP     |
      | PO_200 | 25544270  | network flood IPv4 UDP     |
      | PO_300 | 25544270  | network flood IPv4 UDP     |

      | PO_100 | 40302550  | network flood IPv6 UDP     |
      | PO_200 | 40302550  | network flood IPv6 UDP     |
      | PO_300 | 40302550  | network flood IPv6 UDP     |

      | PO_100 | 108915960 | Total (recv.bps)           |
      | PO_200 | 7087430   | Total (recv.bps)           |
      | PO_300 | 7087430   | Total (recv.bps)           |

      | PO_100 | 509966    | Total (recv.pps)           |
      | PO_200 | 257195    | Total (recv.pps)           |
      | PO_300 | 257195    | Total (recv.pps)           |

      | PO_100 | 7199460   | UDP Port 0 (recv.pps)      |
      | PO_200 | 2028828   | UDP Port 0 (recv.pps)      |
      | PO_300 | 2028828   | UDP Port 0 (recv.pps)      |


  @SID_7
  Scenario: Validate Top Attack by Protocol - All POs
    Then UI Validate StackBar data with widget "Top Attacks by Protocol"
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

      | DOSS-NTP-monlist-flood     | null  | IP         |
      | External report            | null  | IP         |
      | HTTP (recv.bps)            | null  | IP         |
      | HTTP (recv.pps)            | null  | IP         |
      | HTTPS Flood Protection     | 6     | IP         |
      | network flood IPv4 TCP-SYN | null  | IP         |
      | network flood IPv4 UDP     | null  | IP         |
      | network flood IPv6 UDP     | null  | IP         |
      | Total (recv.bps)           | 3     | IP         |
      | Total (recv.pps)           | null  | IP         |
      | UDP Port 0 (recv.pps)      | null  | IP         |

      | DOSS-NTP-monlist-flood     | 17    | NonIP      |
      | External report            | 7     | NonIP      |
      | HTTP (recv.bps)            | null  | NonIP      |
      | HTTP (recv.pps)            | null  | NonIP      |
      | HTTPS Flood Protection     | null  | NonIP      |
      | network flood IPv4 TCP-SYN | 8     | NonIP      |
      | network flood IPv4 UDP     | 9     | NonIP      |
      | network flood IPv6 UDP     | 18    | NonIP      |
      | Total (recv.bps)           | 16    | NonIP      |
      | Total (recv.pps)           | 1     | NonIP      |
      | UDP Port 0 (recv.pps)      | null  | NonIP      |

      | DOSS-NTP-monlist-flood     | null  | TCP        |
      | External report            | null  | TCP        |
      | HTTP (recv.bps)            | 1     | TCP        |
      | HTTP (recv.pps)            | 150   | TCP        |
      | HTTPS Flood Protection     | null  | TCP        |
      | network flood IPv4 TCP-SYN | null  | TCP        |
      | network flood IPv4 UDP     | null  | TCP        |
      | network flood IPv6 UDP     | null  | TCP        |
      | Total (recv.bps)           | null  | TCP        |
      | Total (recv.pps)           | null  | TCP        |
      | UDP Port 0 (recv.pps)      | null  | TCP        |

      | DOSS-NTP-monlist-flood     | null  | UDP        |
      | External report            | null  | UDP        |
      | HTTP (recv.bps)            | null  | UDP        |
      | HTTP (recv.pps)            | null  | UDP        |
      | HTTPS Flood Protection     | null  | UDP        |
      | network flood IPv4 TCP-SYN | null  | UDP        |
      | network flood IPv4 UDP     | null  | UDP        |
      | network flood IPv6 UDP     | null  | UDP        |
      | Total (recv.bps)           | null  | UDP        |
      | Total (recv.pps)           | null  | UDP        |
      | UDP Port 0 (recv.pps)      | 33    | UDP        |


  @SID_8
  Scenario: Validate TOP ATTACKS BY Destination - All POs
    Then UI Validate Pie Chart data "Top Attack Destination"
      | label          | data |
      | 94.125.59.119  | 178  |
      | 94.125.59.52   | 33   |
      | 5.62.87.26     | 9    |
      | 94.125.61.203  | 9    |
      | 94.125.59.1    | 6    |
      | 94.125.59.86   | 4    |
      | 185.31.222.138 | 4    |


  @SID_9
  Scenario: Validate TOP ATTACKS BY Sources - All POs
    Then UI Validate Pie Chart data "Top Attack Sources"
      | label           | data |
      | Unknown         | 173  |
      | 100.100.100.101 | 30   |
      | 100.100.100.102 | 27   |
      | 100.100.100.103 | 20   |
      | 100.100.100.104 | 6    |
      | 100.100.100.105 | 6    |
      | 100.100.100.106 | 5    |
      | 100.100.100.107 | 4    |
      | 100.100.100.108 | 3    |
      | 100.100.100.109 | 2    |


  @SID_10
  Scenario: Validate DDos Attack Activations per Day - All POs

  @SID_11
  Scenario: Validate DDos Attack Volume per Day (Mbits) - All POs

  @SID_12
  Scenario: select two POs
    When UI Do Operation "Select" item "Protected Objects"
    Then UI Select scope from dashboard and Save Filter device type "defenseflow"
      | PO_100 |
      | PO_200 |

  @SID_13
  Scenario: Validate TOP ATTACKS BY Duration - part of POs
    Then UI Validate StackBar data with widget "Top Attacks by Duration"
      | label                      | value | legendName      | exist |
      | HTTP (recv.pps)            | 32    | Less than 1 min | true  |
      | UDP Port 0 (recv.pps)      | 7     | Less than 1 min | true  |
      | Total (recv.bps)           | 1     | Less than 1 min | true  |
      | network flood IPv6 UDP     | 6     | Less than 1 min | true  |
      | DOSS-NTP-monlist-flood     | 5     | Less than 1 min | true  |
      | network flood IPv4 TCP-SYN | null  | Less than 1 min | true  |
      | External report            | 1     | Less than 1 min | true  |
      | network flood IPv4 UDP     | 4     | Less than 1 min | true  |
      | HTTPS Flood Protection     | 3     | Less than 1 min | true  |
      | Total (recv.pps)           | 1     | Less than 1 min | true  |
      | HTTP (recv.bps)            | null  | Less than 1 min | true  |

      | HTTP (recv.pps)            | 86    | 1-5 min         | true  |
      | UDP Port 0 (recv.pps)      | 19    | 1-5 min         | true  |
      | Total (recv.bps)           | 17    | 1-5 min         | true  |
      | network flood IPv6 UDP     | 6     | 1-5 min         | true  |
      | DOSS-NTP-monlist-flood     | 7     | 1-5 min         | true  |
      | network flood IPv4 TCP-SYN | 8     | 1-5 min         | true  |
      | External report            | 5     | 1-5 min         | true  |
      | network flood IPv4 UDP     | 4     | 1-5 min         | true  |
      | HTTPS Flood Protection     | 3     | 1-5 min         | true  |
      | Total (recv.pps)           | 2     | 1-5 min         | true  |
      | HTTP (recv.bps)            | null  | 1-5 min         | true  |

    Then UI Validate StackBar data with widget "Top Attacks by Duration"
      | legendName | legendNameExist |
      | 5-10 min   | false           |

  @SID_14
  Scenario: Validate TOP ATTACKS BY Count - part of POs
  | label  | value | legendName                 | exist|
  | PO_100 | 86    | HTTP (recv.pps)            |true|
  | PO_200 | 32    | HTTP (recv.pps)            |true|
  | PO_300 | 32    | HTTP (recv.pps)            |false|

  | PO_100 | 19    | UDP Port 0 (recv.pps)      |true|
  | PO_200 | 7     | UDP Port 0 (recv.pps)      |true|
  | PO_300 | 7     | UDP Port 0 (recv.pps)      |false|

  | PO_100 | 17    | Total (recv.bps)           |true|
  | PO_200 | 1     | Total (recv.bps)           |true|
  | PO_300 | 1     | Total (recv.bps)           |false|

  | PO_100 | 8     | network flood IPv4 TCP-SYN |true|
  | PO_200 | null  | network flood IPv4 TCP-SYN |true|
  | PO_300 | null  | network flood IPv4 TCP-SYN |false|

  | PO_100 | 7     | DOSS-NTP-monlist-flood     |true|
  | PO_200 | 5     | DOSS-NTP-monlist-flood     |true|
  | PO_300 | 5     | DOSS-NTP-monlist-flood     |false|

  | PO_100 | 6     | network flood IPv6 UDP     |true|
  | PO_200 | 6     | network flood IPv6 UDP     |true|
  | PO_300 | 6     | network flood IPv6 UDP     |false|

  | PO_100 | 5     | External report            |true|
  | PO_200 | 1     | External report            |true|
  | PO_300 | 1     | External report            |false|

  | PO_100 | 4     | network flood IPv4 UDP     |true|
  | PO_200 | 4     | network flood IPv4 UDP     |true|
  | PO_300 | 4     | network flood IPv4 UDP     |false|

  | PO_100 | 3     | HTTPS Flood Protection     |true|
  | PO_200 | 3     | HTTPS Flood Protection     |true|
  | PO_300 | 3     | HTTPS Flood Protection     |false|

  | PO_100 | 2     | Total (recv.pps)           |true|
  | PO_200 | 1     | Total (recv.pps)           |true|
  | PO_300 | 1     | Total (recv.pps)           |false|


  @SID_15
  Scenario: Validate Attacks Bandwidth - part of POs
    Then UI Validate StackBar data with widget "Top Attacks by Bandwidth"
      | label  | value     | legendName                 | exist |
      | PO_100 | 46853020  | DOSS-NTP-monlist-flood     | true  |
      | PO_200 | 33339620  | DOSS-NTP-monlist-flood     | true  |
      | PO_300 | 33339620  | DOSS-NTP-monlist-flood     | false |

      | PO_100 | 1530300   | HTTP (recv.bps)            | true  |
      | PO_200 | null      | HTTP (recv.bps)            | true  |
      | PO_300 | null      | HTTP (recv.bps)            | false |

      | PO_100 | 14537383  | HTTP (recv.pps)            | true  |
      | PO_200 | 5125524   | HTTP (recv.pps)            | true  |
      | PO_300 | 5125524   | HTTP (recv.pps)            | false |

      | PO_100 | 18537500  | HTTPS Flood Protection     | true  |
      | PO_200 | 18537500  | HTTPS Flood Protection     | true  |
      | PO_300 | 18537500  | HTTPS Flood Protection     | false |

      | PO_100 | 55436060  | network flood IPv4 TCP-SYN | true  |
      | PO_200 | null      | network flood IPv4 TCP-SYN | true  |
      | PO_300 | null      | network flood IPv4 TCP-SYN | false |

      | PO_100 | 25544270  | network flood IPv4 UDP     | true  |
      | PO_200 | 25544270  | network flood IPv4 UDP     | true  |
      | PO_300 | 25544270  | network flood IPv4 UDP     | false |

      | PO_100 | 40302550  | network flood IPv6 UDP     | true  |
      | PO_200 | 40302550  | network flood IPv6 UDP     | true  |
      | PO_300 | 40302550  | network flood IPv6 UDP     | false |

      | PO_100 | 108915960 | Total (recv.bps)           | true  |
      | PO_200 | 7087430   | Total (recv.bps)           | true  |
      | PO_300 | 7087430   | Total (recv.bps)           | false |

      | PO_100 | 509966    | Total (recv.pps)           | true  |
      | PO_200 | 257195    | Total (recv.pps)           | true  |
      | PO_300 | 257195    | Total (recv.pps)           | false |

      | PO_100 | 7199460   | UDP Port 0 (recv.pps)      | true  |
      | PO_200 | 2028828   | UDP Port 0 (recv.pps)      | true  |
      | PO_300 | 2028828   | UDP Port 0 (recv.pps)      | false |


  @SID_16
  Scenario: Validate Top Attacks by Protocol - part of POs
    Then UI Validate StackBar data with widget "Top Attacks by Protocol"
      | label                      | value | legendName |
      | DOSS-NTP-monlist-flood     | null  | ICMP       |
      | External report            | null  | ICMP       |
      | HTTP (recv.bps)            | null  | ICMP       |
      | HTTP (recv.pps)            | null  | ICMP       |
      | HTTPS Flood Protection     | 2     | ICMP       |
      | network flood IPv4 TCP-SYN | null  | ICMP       |
      | network flood IPv4 UDP     | 2     | ICMP       |
      | network flood IPv6 UDP     | null  | ICMP       |
      | Total (recv.bps)           | null  | ICMP       |
      | Total (recv.pps)           | 2     | ICMP       |
      | UDP Port 0 (recv.pps)      | null  | ICMP       |

      | DOSS-NTP-monlist-flood     | null  | IP         |
      | External report            | null  | IP         |
      | HTTP (recv.bps)            | null  | IP         |
      | HTTP (recv.pps)            | null  | IP         |
      | HTTPS Flood Protection     | 4     | IP         |
      | network flood IPv4 TCP-SYN | null  | IP         |
      | network flood IPv4 UDP     | null  | IP         |
      | network flood IPv6 UDP     | null  | IP         |
      | Total (recv.bps)           | 2     | IP         |
      | Total (recv.pps)           | null  | IP         |
      | UDP Port 0 (recv.pps)      | null  | IP         |

      | DOSS-NTP-monlist-flood     | 12    | NonIP      |
      | External report            | 6     | NonIP      |
      | HTTP (recv.bps)            | null  | NonIP      |
      | HTTP (recv.pps)            | null  | NonIP      |
      | HTTPS Flood Protection     | null  | NonIP      |
      | network flood IPv4 TCP-SYN | 8     | NonIP      |
      | network flood IPv4 UDP     | 6     | NonIP      |
      | network flood IPv6 UDP     | 12    | NonIP      |
      | Total (recv.bps)           | 16    | NonIP      |
      | Total (recv.pps)           | 1     | NonIP      |
      | UDP Port 0 (recv.pps)      | null  | NonIP      |

      | DOSS-NTP-monlist-flood     | null  | TCP        |
      | External report            | null  | TCP        |
      | HTTP (recv.bps)            | 1     | TCP        |
      | HTTP (recv.pps)            | 118   | TCP        |
      | HTTPS Flood Protection     | null  | TCP        |
      | network flood IPv4 TCP-SYN | null  | TCP        |
      | network flood IPv4 UDP     | null  | TCP        |
      | network flood IPv6 UDP     | null  | TCP        |
      | Total (recv.bps)           | null  | TCP        |
      | Total (recv.pps)           | null  | TCP        |
      | UDP Port 0 (recv.pps)      | null  | TCP        |

      | DOSS-NTP-monlist-flood     | null  | UDP        |
      | External report            | null  | UDP        |
      | HTTP (recv.bps)            | null  | UDP        |
      | HTTP (recv.pps)            | null  | UDP        |
      | HTTPS Flood Protection     | null  | UDP        |
      | network flood IPv4 TCP-SYN | null  | UDP        |
      | network flood IPv4 UDP     | null  | UDP        |
      | network flood IPv6 UDP     | null  | UDP        |
      | Total (recv.bps)           | null  | UDP        |
      | Total (recv.pps)           | null  | UDP        |
      | UDP Port 0 (recv.pps)      | 26    | UDP        |


  @SID_17
  Scenario: Validate TOP ATTACKS BY Destination - part of POs
    Then UI Validate Pie Chart data "Top Attack Destination"
      | label          | data |
      | 94.125.59.119  | 138  |
      | 94.125.59.52   | 26   |
      | 5.62.87.26     | 7    |
      | 94.125.59.1    | 5    |
      | 94.125.59.86   | 4    |
      | 94.125.61.203  | 6    |
      | 185.31.222.138 | 3    |

  @SID_18
  Scenario: Validate TOP ATTACKS BY Sources - part of POs
    Then UI Validate Pie Chart data "Top Attack Sources"
      | label           | data |
      | Unknown         | 138  |
      | 100.100.100.101 | 20   |
      | 100.100.100.102 | 18   |
      | 100.100.100.103 | 14   |
      | 100.100.100.104 | 6    |
      | 100.100.100.105 | 6    |
      | 100.100.100.106 | 5    |
      | 100.100.100.107 | 4    |
      | 100.100.100.108 | 3    |
      | 100.100.100.109 | 2    |

  @SID_24
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "df-attack*"
    * CLI Clear vision logs


  @SID_25
  Scenario: Run DF simulator for DDos Attack Volume per Day
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_100_2D_Before.sh " |
      | #visionIP                                                 |
      | " Terminated"                                             |
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_100_3D_Before.sh " |
      | #visionIP                                                 |
      | " Terminated"                                             |

    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_100_5D_Before.sh " |
      | #visionIP                                                 |
      | " Terminated"                                             |
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_300_3D_Before.sh " |
      | #visionIP                                                 |
      | " Terminated"                                             |
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_300_4D_Before.sh " |
      | #visionIP                                                 |
      | " Terminated"                                             |

  @SID_26
  Scenario: select range
    Then UI Do Operation "Select" item "Global Time Filter"
    When UI select time range from "-16d" to "-1d"

  @SID_27
  Scenario: select 3 POs
    When UI Do Operation "Select" item "Protected Objects"
    Then UI Select scope from dashboard and Save Filter device type "defenseflow"
      | PO_100 |
      | PO_200 |
      | PO_300 |

  @SID_28
  Scenario: Validate DDos Attack Volume per Day (bits) - All POs
    Then UI Validate Line Chart data "Attack Volume per Day" with LabelTime
      | value        | countOffset | time |
      | 319366469000 | 10          | -5d  |
      | 319366469000 | 10          | -4d  |
      | 638732938000 | 10          | -3d  |
      | 319366469000 | 10          | -2d  |

  @SID_29
  Scenario: select two POs
    When UI Do Operation "Select" item "Protected Objects"
    Then UI Select scope from dashboard and Save Filter device type "defenseflow"
      | PO_100 |
      | PO_200 |

  @SID_30
  Scenario: Validate DDos Attack Activations per Day - part of POs
    Then UI Validate Line Chart data "Attack Volume per Day" with LabelTime
      | value        | countOffset | time |
      | 319366469000 | 10          | -5d  |
      | 319366469000 | 10          | -3d  |
      | 319366469000 | 10          | -2d  |

  @SID_32
  Scenario: Search for bad logs
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
      | ALL     | error      | NOT_EXPECTED |

  @SID_33
  Scenario: Cleanup
    When UI Open "Configurations" Tab
    Then UI logout and close browser
