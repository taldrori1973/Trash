@VRM @TC105995
Feature: DP Monitoring Dashboard - Protection Policies - Under Attack

  @SID_1
  Scenario: Clean system data before "Protection Policies" test
    * CLI kill all simulator attacks on current vision
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Then CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator PCAPs for "Protection Policies" - just traffic
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 20 with loopDelay 15000
    And CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000
    And CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 11 with loopDelay 15000 and wait 50 seconds

  @SID_3
  Scenario: Login and navigate to VRM
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Open Upper Bar Item "AMS"
    And UI Open "Dashboards" Tab
    When UI Open "DP Monitoring Dashboard" Sub Tab

  @SID_4
  Scenario: Validate first peace time policy - just traffic
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 0
      | columnName            | value                   |
      | Site                  | RealDPs_Version_8_site  |
      | Device                | DefensePro_172.16.22.50 |
      | Policy Name           | Policy150               |
      | Policy Status         | peace                   |
      | Total Inbound Traffic | 7.48 Mbps               |
      | Attack Rate           | 0                       |
      | Drop Rate             | 0 bps                   |
      | Attack Categories     | None                    |

  @SID_5
  Scenario: Validate last peace time policy - just traffic
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 37
      | columnName            | value                   |
      | Site                  | RealDPs_Version_8_site  |
      | Device                | DefensePro_172.16.22.51 |
      | Policy Name           | Policy230               |
      | Policy Status         | peace                   |
      | Total Inbound Traffic | 480 Kbps                |
      | Attack Rate           | 0                       |
      | Drop Rate             | 0 bps                   |
      | Attack Categories     | None                    |

  @SID_6
  Scenario: Run DP simulator PCAPs for "Protection Policies" - traffic and attacks
    # Given CLI kill all simulator attacks on current vision
    Given CLI simulate 1000 attacks of type "rest_dos" on "DefensePro" 20
    And CLI simulate 1000 attacks of type "ongoing_Protect_4_1" on "DefensePro" 10
    And CLI simulate 1000 attacks of type "rest_ascan_ongoing" on "DefensePro" 11 and wait 100 seconds

  @SID_7
  Scenario: Validate first under attack policy - traffic and attacks
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 0
      | columnName            | value                   |
      | Site                  | RealDPs_Version_8_site  |
      | Device                | DefensePro_172.16.22.50 |
      | Policy Name           | Protect_5_1             |
      | Policy Status         | underAttack             |
      | Total Inbound Traffic | 1.95 Gbps               |
      | Attack Rate           | 1.95 Gbps               |
      | Drop Rate             | 1.95 Gbps               |
      | Attack Categories     | Behavioral DoS          |

  @SID_8
  Scenario: Validate last under attack policy - - traffic and attacks
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 3
      | columnName            | value                    |
      | Site                  | RealDPs_Version_8_site   |
      | Device                | DefensePro_172.16.22.50  |
      | Policy Name           | Protect_4_1              |
      | Policy Status         | underAttack              |
      | Total Inbound Traffic | 781.69 Mbps              |
      | Drop Rate             | 100 Mbps                 |
      | Attack Categories     | SYN Flood                |

  @SID_9
  Scenario: Validate first peace time policy - traffic and attacks
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 5
      | columnName            | value                   |
      | Site                  | RealDPs_Version_8_site  |
      | Device                | DefensePro_172.16.22.50 |
      | Policy Name           | Protect_1_1             |
      | Policy Status         | peace                   |
      | Total Inbound Traffic | 1 Gbps                  |
      | Attack Rate           | 0                       |
      | Drop Rate             | 0 bps                   |
      | Attack Categories     | None                    |

  @SID_10
  Scenario: Validate last peace time policy - traffic and attacks
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 43
      | columnName            | value                   |
      | Site                  | RealDPs_Version_8_site  |
      | Device                | DefensePro_172.16.22.51 |
      | Policy Name           | Policy230               |
      | Policy Status         | peace                   |
      | Total Inbound Traffic | 480 Kbps                |
      | Attack Rate           | 0                       |
      | Drop Rate             | 0 bps                   |
      | Attack Categories     | None                    |

  @SID_11
  Scenario: Validate protection Policies with one device selected
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 0
      | columnName            | value                   |
      | Site                  | RealDPs_Version_8_site  |
      | Device                | DefensePro_172.16.22.50 |
      | Policy Name           | Protect_5_1             |
      | Policy Status         | underAttack             |
      | Total Inbound Traffic | 1.95 Gbps               |
      | Attack Rate           | 1.95 Gbps               |
      | Drop Rate             | 1.95 Gbps               |
      | Attack Categories     | Behavioral DoS          |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 3
      | columnName            | value                    |
      | Site                  | RealDPs_Version_8_site   |
      | Device                | DefensePro_172.16.22.50  |
      | Policy Name           | Protect_4_1              |
      | Policy Status         | underAttack              |
      | Total Inbound Traffic | 781.69 Mbps              |
      | Drop Rate             | 100 Mbps                 |
      | Attack Categories     | SYN Flood                |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 4
      | columnName            | value                   |
      | Site                  | RealDPs_Version_8_site  |
      | Device                | DefensePro_172.16.22.50 |
      | Policy Name           | Protect_1_1             |
      | Policy Status         | peace                   |
      | Total Inbound Traffic | 1 Gbps                  |
      | Attack Rate           | 0                       |
      | Drop Rate             | 0 bps                   |
      | Attack Categories     | None                    |

  @SID_12
  Scenario: Run DP simulator PCAPs for "Protection Policies" - Global Policy attacks
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI simulate 30 attacks of type "rest_black_ip46" on "DefensePro" 10
    * CLI simulate 40 attacks of type "rest_anomalies" on "DefensePro" 11 with loopDelay 5000 and wait 60 seconds
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
      | 11    |       |          |

  @SID_13
  Scenario: Validate global policy for first device - traffic and attacks
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy columnName "Attack Categories" findBy cellValue "ACL"
      | columnName            | value                   |
      | Site                  | RealDPs_Version_8_site  |
      | Device                | DefensePro_172.16.22.50 |
      | Policy Name           | Global Policy           |
      | Policy Status         | underAttack             |
      | Total Inbound Traffic | 5.2 Gbps               |
      | Attack Rate           | 5.2 Gbps               |
      | Drop Rate             | 5.2 Gbps               |
      | Attack Categories     | ACL                     |

  @SID_14
  Scenario: Validate global policy for second device - traffic and attacks
    # Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 5
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy columnName "Attack Categories" findBy cellValue "Anomalies"

      | columnName            | value                   |
      | Site                  | RealDPs_Version_8_site  |
      | Device                | DefensePro_172.16.22.51 |
      | Policy Name           | Global Policy           |
      | Policy Status         | underAttack             |
      | Total Inbound Traffic | 0 bps                   |
      | Attack Rate           | 0                       |
      | Drop Rate             | 0 bps                   |
      | Attack Categories     | Anomalies               |

  @SID_15
  Scenario: Protection Policies Cleanup
    Given UI logout and close browser
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
