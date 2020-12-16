@TC118728
Feature: DPGenerateReport

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    Then Sleep "20"
    * REST Delete ES index "dp-*"
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
Scenario: start IPTABLES
  Then CLI Run linux Command "service iptables start" on "ROOT_SERVER_CLI" and validate result CONTAINS "Loading additional modules"

