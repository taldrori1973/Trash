@TC112254
Feature: VRM Real Time Status Bar Inbound Traffic

  @SID_1
  Scenario: Inbound Traffic Basic
  # Written by YL
  # Run pcap from two DPs and validate correct values
    When CLI Clear vision logs
    Given CLI kill all simulator attacks on current vision
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given CLI simulate 30 attacks of type "rest_traffic_diff_Policy15out" on SetId "DefensePro_Set_1" with loopDelay 15000
    Given CLI simulate 30 attacks of type "rest_traffic_diff_Policy15out" on SetId "DefensePro_Set_2" with loopDelay 15000 and wait 60 seconds
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And Sleep "3"
    Then UI Validate Text field "Inbound Traffic Kbps" EQUALS "1.46 G"
    Then UI Validate Text field "Inbound Traffic PPS" EQUALS "11.16 M"
    Then UI Validate Text field "Inbound Traffic CPS" EQUALS "12.67 K"
    And UI Logout

  @SID_2
  Scenario: Inbound Traffic Filter Device
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_1 |       |          |
    And Sleep "2"
    Then UI Validate Text field "Inbound Traffic Kbps" EQUALS "729.74 M"
    Then UI Validate Text field "Inbound Traffic PPS" EQUALS "5.58 M"
    Then UI Validate Text field "Inbound Traffic CPS" EQUALS "6.33 K"
    And UI Logout

  @SID_3
  Scenario:Inbound Traffic RBAC Device
    Given UI Login with user "sec_admin_all_pol" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Validate Text field "Inbound Traffic Kbps" EQUALS "729.74 M"
    Then UI Validate Text field "Inbound Traffic PPS" EQUALS "5.58 M"
    Then UI Validate Text field "Inbound Traffic CPS" EQUALS "6.33 K"
    And UI Logout

  @SID_4
  Scenario: Inbound Traffic RBAC policy
    Given UI Login with user "sec_mon_Policy14" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_1 |       | Policy14 |
    Then UI Validate Text field "Inbound Traffic Kbps" EQUALS "3.09 M"
    Then UI Validate Text field "Inbound Traffic PPS" EQUALS "3.12 K"
    Then UI Validate Text field "Inbound Traffic CPS" EQUALS "422.00"
    And UI Logout

  @SID_5
  Scenario: Inbound Traffic Filter Port
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_1 | 1,3,7 |          |
    And Sleep "2"
    Then UI Validate Text field "Inbound Traffic Kbps" EQUALS "0"
    Then UI Validate Text field "Inbound Traffic PPS" EQUALS "0"
    Then UI Validate Text field "Inbound Traffic CPS" EQUALS "0"
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_1 | 4     |          |
    And Sleep "2"
    Then UI Validate Text field "Inbound Traffic Kbps" EQUALS "0"
    Then UI Validate Text field "Inbound Traffic PPS" EQUALS "0"
    Then UI Validate Text field "Inbound Traffic CPS" EQUALS "0"

    Then UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_1 | 6     |          |
    And Sleep "2"
    Then UI Validate Text field "Inbound Traffic Kbps" EQUALS "729.74 M"
    Then UI Validate Text field "Inbound Traffic PPS" EQUALS "5.58 M"
    Then UI Validate Text field "Inbound Traffic CPS" EQUALS "4.25 K"
    And UI Logout

  @SID_6
  Scenario: Inbound Traffic Filter Policy In
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_1 |       | Policy14 |
    Then UI Validate Text field "Inbound Traffic Kbps" EQUALS "3.09 M"
    Then UI Validate Text field "Inbound Traffic PPS" EQUALS "3.12 K"
    Then UI Validate Text field "Inbound Traffic CPS" EQUALS "422.00"
    And UI Logout

  @SID_7
  Scenario: Inbound Traffic Filter Policy Out
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_1 |       | Policy15 |
    Then UI Validate Text field "Inbound Traffic Kbps" EQUALS "0"
    Then UI Validate Text field "Inbound Traffic PPS" EQUALS "0"
    Then UI Validate Text field "Inbound Traffic CPS" EQUALS "0"
    And UI Logout

  @SID_8
  Scenario: Inbound Traffic High Volume

    Given CLI kill all simulator attacks on current vision
    Given CLI simulate 30 attacks of type "rest_traffic_high_volume" on SetId "DefensePro_Set_1" with loopDelay 15000 and wait 90 seconds
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Validate Text field "Inbound Traffic Kbps" EQUALS "1.66 T"
    Then UI Validate Text field "Inbound Traffic PPS" EQUALS "1.4 G"
    Then UI Validate Text field "Inbound Traffic CPS" EQUALS "103.88 M"
    And UI Logout

  @SID_9
  Scenario: Inbound Traffic Cleared
    Given CLI kill all simulator attacks on current vision
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And Sleep "150"
    Then UI Validate Text field "Inbound Traffic Kbps" EQUALS "0"
    Then UI Validate Text field "Inbound Traffic PPS" EQUALS "0"
    Then UI Validate Text field "Inbound Traffic CPS" EQUALS "0"
    And UI Logout

  @SID_10
  Scenario: Inbound Traffic check logs
    * UI logout and close browser
    * CLI Check if logs contains
      | logType     | expression                                          | isExpected   |
      | ES          | fatal\|error                                        | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error                                        | NOT_EXPECTED |
      | JBOSS       | fatal                                               | NOT_EXPECTED |
      | TOMCAT      | fatal                                               | NOT_EXPECTED |
      | TOMCAT2     | fatal                                               | NOT_EXPECTED |
      | JBOSS       | Not authorized operation launched by the user: sec_ | IGNORE       |

#      END INBOUND TRAFFIC
