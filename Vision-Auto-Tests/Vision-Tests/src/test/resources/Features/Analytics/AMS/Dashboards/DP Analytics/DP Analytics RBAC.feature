@TC111565
Feature: DP ANALYTICS RBAC

  @SID_1
  Scenario: Clean system attacks,database and logs
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    * CLI kill all simulator attacks on current vision
    # wait until collector cache clean up
    * Sleep "15"
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"

  @SID_2
  Scenario: Run DP simulator PCAPs for Attacks by Protection Policy  widget
    * CLI simulate 1 attacks of type "VRM_attacks" on SetId "DefensePro_Set_1"
    * CLI simulate 1 attacks of type "VRM_attacks" on SetId "DefensePro_Set_2" with attack ID
    * CLI simulate 1 attacks of type "VRM_attacks" on SetId "DefensePro_Set_3" with attack ID
    * CLI simulate 1 attacks of type "VRM_attacks" on SetId "DefensePro_Set_4" with attack ID
    * CLI simulate 1 attacks of type "VRM_attacks" on SetId "DefensePro_Set_5" and wait 240 seconds with attack ID


  @SID_3
  Scenario: Login
    When UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"

  @SID_4
  Scenario:Analytics RBAC sys_admin user
    Then UI Validate StackBar data with widget "Attacks by Protection Policy"
      | legendName       | label                          | value |
      | shlomi           | TCP Mid Flow packet            | 15    |
      | shlomchik        | BWM Limit Alert                | 9     |
      | Packet Anomalies | Incorrect IPv4 checksum        | 9     |
      | policy1          | TCP Scan (vertical)            | 6     |
      | policy1          | SYN Flood HTTP                 | 6     |
      | Black_IPV6       | Black List                     | 6     |
      | BDOS             | DOSS-Anomaly-TCP-SYN-RST       | 6     |
      | BDOS             | DNS flood IPv4 DNS-A           | 3     |
      | BDOS             | network flood IPv4 TCP-SYN-ACK | 3     |
      | BDOS             | tim                            | 3     |
      | 1                | DNS flood IPv4 DNS-A           | 6     |
      | POL_IPV6         | network flood IPv6 TCP-SYN-ACK | 3     |
      | POL_IPV6         | network flood IPv6 UDP         | 3     |
    Then UI Total "Attacks by Protection Policy" legends equal to 10


    Then UI Text of "Device Selection" equal to "DEVICES4/4"
    Then UI Text of "UpDevices" equal to "4"
    Then UI Text of "maintenanceDevices" equal to "0"
    Then UI Text of "downDevices" equal to "0"
    When UI Click Button "Device Selection"
    Then UI VRM Validate Devices policies
      | setId            | polices                | total |
      | DefensePro_Set_1 | Policy14,Policy15,BDOS | All   |
      | DefensePro_Set_2 | pol_1,policy_3         | All   |
      | DefensePro_Set_3 | Ahlam69                | All   |
    When UI VRM Select device from dashboard
      | setId |
    Then UI Text of "Device Selection.Available Devices header" contains "Devices4/4"
    Then UI VRM Total Available Device's 4
    * UI Logout

    ### see DE39973 WNBF

#   Scenario: TC105300 Analytics RBAC filter devices by site
#     When UI Login with user "sys_admin" and password "radware"
#     And UI Open Upper Bar Item "AMS"
#     And UI Open "Dashboards" Tab
#     And UI Open "DP Analytics" Sub Tab
#     And UI Do Operation "Select" item "Global Time Filter"
#     And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
#     When UI Click Button "Device Selection"
#     When UI VRM Select device from dashboard
#       | index |
#     Then UI Text of "Device Selection.Available Devices header" contains "Devices3/3"
#     Then UI VRM Total Available Device's 3
#     When UI Set Text Field "Device Selection.Search" To "FakeDPs_Old_Version_site"
#     Then UI VRM Total Available Device's 0
#     When UI Set Text Field "Device Selection.Search" To "RealDPs_Version_8_site"
#     Then UI VRM Total Available Device's 2
#     When UI Set Text Field "Device Selection.Search" To "VA_DPs_Version_8_site"
#     Then UI VRM Total Available Device's 1
#
#   Scenario: TC105301 Analytics RBAC filter devices by logical group
#     When UI Set Text Field "Device Selection.Search" To "DPs_Mixed_Versions_LogicalGroup"
#     Then UI VRM Total Available Device's 3
#     When UI Set Text Field "Device Selection.Search" To "DPs_Old_Versions_LogicalGroup"
#     Then UI VRM Total Available Device's 0
#     When UI Set Text Field "Device Selection.Search" To "DPs_version_8_LogicalGroup"
#     Then UI VRM Total Available Device's 3
#     Then UI Open "Configurations" Tab
#     * UI Logout

  @SID_5
  Scenario:Analytics RBAC sec_mon_DP50_policy1 user
    Given UI Login with user "sec_mon_DP50_policy1" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And Sleep "3"
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"

    Then UI Validate StackBar data with widget "Attacks by Protection Policy"
      | legendName | label               | value |
      | policy1    | TCP Scan (vertical) | 2     |
      | policy1    | SYN Flood HTTP      | 2     |
    Then UI Text of "Device Selection" equal to "DEVICES1/1"
    Then UI Text of "UpDevices" equal to "1"
    Then UI Text of "maintenanceDevices" equal to "0"
    Then UI Text of "downDevices" equal to "0"

    When UI Click Button "Device Selection"
    Then UI VRM Validate Devices policies
      | setId            | polices | total |
      | DefensePro_Set_1 | policy1 | 1     |
    Then UI Total "Attacks by Protection Policy" legends equal to 1

    When UI VRM Select device from dashboard
      | setId |
    Then UI Text of "Device Selection.Available Devices header" contains "Devices1/1"
    Then UI VRM Total Available Device's 1
    * UI Logout

  @SID_6
  Scenario: Analytics RBAC sec_mon_DP50_policy1 user search options
    Given UI Login with user "sec_mon_DP50_policy1" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And Sleep "3"
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
    When UI Click Button "Device Selection"
    When UI VRM Select device from dashboard
      | setId |
    When UI Set Text Field "Device Selection.Search" To "FakeDPs_Old_Version_site"
    Then UI VRM Total Available Device's 0
    When UI Set Text Field "Device Selection.Search" To "RealDPs_Version_8_site"
    Then UI VRM Total Available Device's 0
    When UI Set Text Field "Device Selection.Search" To "VA_DPs_Version_8_site"
    Then UI VRM Total Available Device's 0
    When UI Set Text Field "Device Selection.Search" To "DPs_Mixed_Versions_LogicalGroup"
    Then UI VRM Total Available Device's 0
    When UI Set Text Field "Device Selection.Search" To "DPs_Old_Versions_LogicalGroup"
    Then UI VRM Total Available Device's 0
    When UI Set Text Field "Device Selection.Search" To "DPs_version_8_LogicalGroup"
    Then UI VRM Total Available Device's 0
    * UI Logout

  @SID_7
  Scenario:Analytics RBAC sec_mon_all_pol user
    Given UI Login with user "sec_mon_all_pol" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
    And Sleep "3"
    Then UI Validate StackBar data with widget "Attacks by Protection Policy"
      | legendName       | label                          | value |
      | BDOS             | DNS flood IPv4 DNS-A           | 1     |
      | BDOS             | DOSS-Anomaly-TCP-SYN-RST       | 2     |
      | BDOS             | network flood IPv4 TCP-SYN-ACK | 1     |
      | BDOS             | tim                            | 1     |
      | shlomi           | TCP Mid Flow packet            | 5     |
      | shlomchik        | BWM Limit Alert                | 3     |
      | policy1          | TCP Scan (vertical)            | 2     |
      | policy1          | SYN Flood HTTP                 | 2     |
      | 1                | DNS flood IPv4 DNS-A           | 2     |
      | Black_IPV6       | Black List                     | 2     |
      | Packet Anomalies | Incorrect IPv4 checksum        | 3     |
    Then UI Total "Attacks by Protection Policy" legends equal to 10
    Then UI Text of "Device Selection" equal to "DEVICES1/1"
    Then UI Text of "UpDevices" equal to "1"
    Then UI Text of "maintenanceDevices" equal to "0"
    Then UI Text of "downDevices" equal to "0"

    When UI Click Button "Device Selection"
    Then UI VRM Validate Devices policies
      | setId            | polices  | total |
      | DefensePro_Set_1 | Policy15 | All   |

    When UI VRM Select device from dashboard
      | setId |
    Then UI Text of "Device Selection.Available Devices header" contains "Devices1/1"
    Then UI VRM Total Available Device's 1
    Then UI Logout

  @SID_8
  Scenario:Analytics RBAC sec_admin_all_pol user
    Given UI Login with user "sec_admin_all_pol" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
    And Sleep "3"
    Then UI Validate StackBar data with widget "Attacks by Protection Policy"
      | legendName       | label                          | value |
      | BDOS             | DNS flood IPv4 DNS-A           | 1     |
      | BDOS             | DOSS-Anomaly-TCP-SYN-RST       | 2     |
      | BDOS             | network flood IPv4 TCP-SYN-ACK | 1     |
      | BDOS             | tim                            | 1     |
      | shlomi           | TCP Mid Flow packet            | 5     |
      | shlomchik        | BWM Limit Alert                | 3     |
      | policy1          | TCP Scan (vertical)            | 2     |
      | policy1          | SYN Flood HTTP                 | 2     |
      | 1                | DNS flood IPv4 DNS-A           | 2     |
      | Black_IPV6       | Black List                     | 2     |
      | Packet Anomalies | Incorrect IPv4 checksum        | 3     |
    Then UI Total "Attacks by Protection Policy" legends equal to 10
    Then UI Text of "Device Selection" equal to "DEVICES1/1"
    Then UI Text of "UpDevices" equal to "1"
    Then UI Text of "maintenanceDevices" equal to "0"
    Then UI Text of "downDevices" equal to "0"

    When UI Click Button "Device Selection"
    Then UI VRM Validate Devices policies
      | setId            | polices  | total |
      | DefensePro_Set_1 | Policy15 | All   |

    When UI VRM Select device from dashboard
      | setId |
    Then UI Text of "Device Selection.Available Devices header" contains "Devices1/1"
    Then UI VRM Total Available Device's 1
    Then UI Logout

  @SID_9
  Scenario: Analytics RBAC sec_mon_BDOS user
    Given UI Login with user "sec_mon_BDOS" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
    And Sleep "3"
    Then UI Validate StackBar data with widget "Attacks by Protection Policy"
      | legendName | label                          | value |
      | BDOS       | DNS flood IPv4 DNS-A           | 1     |
      | BDOS       | DOSS-Anomaly-TCP-SYN-RST       | 2     |
      | BDOS       | network flood IPv4 TCP-SYN-ACK | 1     |
      | BDOS       | tim                            | 1     |
    Then UI Total "Attacks by Protection Policy" legends equal to 1
    Then UI Text of "Device Selection" equal to "DEVICES1/1"
    Then UI Text of "UpDevices" equal to "1"
    Then UI Text of "maintenanceDevices" equal to "0"
    Then UI Text of "downDevices" equal to "0"

    When UI Click Button "Device Selection"
    Then UI VRM Validate Devices policies
      | setId            | polices | total |
      | DefensePro_Set_1 | BDOS    | 1     |

    When UI VRM Select device from dashboard
      | setId |
    Then UI Text of "Device Selection.Available Devices header" contains "Devices1/1"
    Then UI VRM Total Available Device's 1
    Then UI Logout

  @SID_10
  Scenario: Analytics RBAC sec_admin_all_pol_51 user
    Given UI Login with user "sec_admin_all_pol_51" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
    And Sleep "3"
    Then UI Validate StackBar data with widget "Attacks by Protection Policy"
      | legendName       | label                          | value |
      | BDOS             | DNS flood IPv4 DNS-A           | 1     |
      | BDOS             | DOSS-Anomaly-TCP-SYN-RST       | 2     |
      | BDOS             | network flood IPv4 TCP-SYN-ACK | 1     |
      | BDOS             | tim                            | 1     |
      | shlomi           | TCP Mid Flow packet            | 5     |
      | shlomchik        | BWM Limit Alert                | 3     |
      | policy1          | SYN Flood HTTP                 | 2     |
      | policy1          | TCP Scan (vertical)            | 2     |
      | Packet Anomalies | Incorrect IPv4 checksum        | 3     |
      | Black_IPV6       | Black List                     | 2     |
      | 1                | DNS flood IPv4 DNS-A           | 2     |
    Then UI Total "Attacks by Protection Policy" legends equal to 10
    Then UI Text of "Device Selection" equal to "DEVICES1/1"
    Then UI Text of "UpDevices" equal to "1"
    Then UI Text of "maintenanceDevices" equal to "0"
    Then UI Text of "downDevices" equal to "0"

    When UI Click Button "Device Selection"
    Then UI VRM Validate Devices policies
      | setId            | polices | total |
      | DefensePro_Set_2 | pol1 | ALl   |

    When UI VRM Select device from dashboard
      | setId |
    Then UI Text of "Device Selection.Available Devices header" contains "Devices1/1"
    Then UI VRM Total Available Device's 1
    Then UI Logout

  @SID_11
  Scenario: Analytics RBAC sec_mon_DP50_POL_IPV6 user
    Given UI Login with user "sec_mon_DP50_POL_IPV6" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
    And Sleep "3"
    Then UI Validate StackBar data with widget "Attacks by Protection Policy"
      | legendName | label                          | value |
      | POL_IPV6   | network flood IPv6 TCP-SYN-ACK | 1     |
      | POL_IPV6   | network flood IPv6 UDP         | 1     |
    Then UI Total "Attacks by Protection Policy" legends equal to 1
    Then UI Text of "Device Selection" equal to "DEVICES1/1"
    Then UI Text of "UpDevices" equal to "1"
    Then UI Text of "maintenanceDevices" equal to "0"
    Then UI Text of "downDevices" equal to "0"

    When UI Click Button "Device Selection"
    Then UI VRM Validate Devices policies
      | setId            | polices  | total |
      | DefensePro_Set_1 | POL_IPV6 | 1     |

    When UI VRM Select device from dashboard
      | setId |
    Then UI Text of "Device Selection.Available Devices header" contains "Devices1/1"
    Then UI VRM Total Available Device's 1
    Then UI Logout

  @SID_12
  Scenario: Analytics RBAC sec_admin_DP50_policy1 user
    Given UI Login with user "sec_admin_DP50_policy1" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
    And Sleep "3"
    Then UI Validate StackBar data with widget "Attacks by Protection Policy"
      | legendName | label               | value |
      | policy1    | SYN Flood HTTP      | 2     |
      | policy1    | TCP Scan (vertical) | 2     |
    Then UI Total "Attacks by Protection Policy" legends equal to 1
    Then UI Text of "Device Selection" equal to "DEVICES1/1"
    Then UI Text of "UpDevices" equal to "1"
    Then UI Text of "maintenanceDevices" equal to "0"
    Then UI Text of "downDevices" equal to "0"

    When UI Click Button "Device Selection"
    Then UI VRM Validate Devices policies
      | setId            | polices | total |
      | DefensePro_Set_1 | policy1 | 1     |

    When UI VRM Select device from dashboard
      | setId |
    Then UI Text of "Device Selection.Available Devices header" contains "Devices1/1"
    Then UI VRM Total Available Device's 1


  @SID_13
  Scenario: Stop attack and search for bad logs
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |

  @SID_14
  Scenario: Cleanup
    Given UI logout and close browser
