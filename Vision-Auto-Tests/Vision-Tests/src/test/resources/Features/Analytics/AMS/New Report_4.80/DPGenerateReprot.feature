@TC118728
Feature: DPGenerateReport

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    Then Sleep "20"
    * REST Delete ES index "dp-traffic-*"
    * REST Delete ES index "dp-https-stats-*"
    * REST Delete ES index "dp-https-rt-*"
    * REST Delete ES index "dp-five-*"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator
    Given CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10 and wait 250 seconds

  @SID_3
  Scenario: Login and navigate
    Given UI Login with user "radware" and password "radware"
    When UI Navigate to "AMS REPORTS" page via homePage

  @SID_4
  Scenario: validate DP Analytics Widget - Top Attack Destinations
    Then CLI Run linux Command "service iptables stop" on "ROOT_SERVER_CLI" and validate result CONTAINS "Unloading modules"
    Then UI Validate Pie Chart data "Top Attack Destinations-DefensePro Analytics" in Report "DPAndDPBehavioralReport"
      | label    | data |
      | 1.1.1.10 | 5    |
      | 0.0.0.0  | 5    |
      | 1.1.1.1  | 2    |

  @SID_5
  Scenario: validate DP Analytics Widget - Top Attack Sources
    Then UI Validate Pie Chart data "Top Attack Sources-DefensePro Analytics" in Report "DPAndDPBehavioralReport"
      | label      | data |
      | 192.85.1.2 | 8    |
      | 0.0.0.0    | 6    |
      | 1.1.1.1    | 1    |

  @SID_6
  Scenario: validate DP Analytics Widget - Attacks by Protection Policy
    Then Validate Line Chart data "Attacks by Protection Policy-DefensePro Analytics" with Label "DOSS-Anomaly-TCP-SYN-RST" in report "DPAndDPBehavioralReport"
      | value | count | offset |
      | 2     | 1     | 0      |

    Then Validate Line Chart data "Attacks by Protection Policy-DefensePro Analytics" with Label "DNS flood IPv4 DNS-A" in report "DPAndDPBehavioralReport"
      | value | count | offset |
      | 1     | 1     | 0      |
      | 2     | 1     | 0      |

  @SID_7
  Scenario: DNS baseline pre-requisite
    Given CLI kill all simulator attacks on current vision
    Given CLI Clear vision logs
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    Given CLI simulate 200 attacks of type "baselines_pol_1" on "DefensePro" 10 with loopDelay 15000 and wait 140 seconds

  @SID_8
    Then UI Validate StackBar Timedata with widget "BDoS-TCP SYN ACK-DefensePro Behavioral Protections" in report "dpBehavioral"
      | value | min | label              |
      | 44000 | 10  | Legitimate Traffic |
      | 66680 | 10  | Total Traffic      |

  @SID_9
    Then UI Validate StackBar Timedata with widget "BDoS-TCP FIN ACK-DefensePro Behavioral Protections" in report "dpBehavioral"
      | value | min | label              |
      | 44160 | 10  | Legitimate Traffic |
      | 46000 | 10  | Total Traffic      |


  @SID_10
  Scenario: start IPTABLES
    Then CLI Run linux Command "service iptables start" on "ROOT_SERVER_CLI" and validate result CONTAINS "Loading additional modules"

