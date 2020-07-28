@TC112253
Feature: VRM Real Time Status Bar BW by Policy


  Scenario: Login and Navigate
    Given REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage


  @SID_1
  Scenario: BW by policy Clean system data before test
    When CLI kill all simulator attacks on current vision
    When CLI Clear vision logs
    When REST Delete ES index "dp-*"
    When CLI simulate 2 attacks of type "rest_traffic" on "DefensePro" 10 with loopDelay 15000
    When CLI simulate 90 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 20 with loopDelay 15000
    When CLI simulate 90 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 11 with loopDelay 15000
    When CLI simulate 90 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000 and wait 130 seconds
    When Sleep "30"


  @SID_2
  Scenario: BW by policy basic
    Then UI Total Pie Chart data "Bandwidth per Policy"
      | size | offset |
      | 10   | 0      |
  # DE38477 will-never-fix
#    The Offset is 10% of th expected value
    Then UI Validate Pie Chart data "Bandwidth per Policy"
      | label     | data | offsetPercentage |
      | Policy150 | 7479 | 10%              |
      | Policy20  | 3152 | 10%              |
      | Policy200 | 3152 | 10%              |
      | Policy19  | 3099 | 10%              |
      | Policy190 | 3099 | 10%              |
      | Policy14  | 3089 | 10%              |
      | Policy140 | 3089 | 10%              |
      | Policy16  | 2885 | 10%              |
      | Policy160 | 2885 | 10%              |
#      | Policy18  | 2512 | 10%              |
#The last policy was ignored becuase of run time data change

  @SID_3
  Scenario: BW by policy filter by device
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    And Sleep "5"
    Then UI Total Pie Chart data "Bandwidth per Policy"
      | size | offset |
      | 10   | 0      |

    Then UI Validate Pie Chart data "Bandwidth per Policy"
      | label     | data | offsetPercentage |
      | Policy150 | 7479 | 10%              |
      | Policy20  | 3152 | 10%              |
      | Policy200 | 3152 | 10%              |
      | Policy19  | 3099 | 10%              |
      | Policy190 | 3099 | 10%              |
      | Policy14  | 3089 | 10%              |
      | Policy140 | 3089 | 10%              |
      | Policy16  | 2885 | 10%              |
      | Policy160 | 2885 | 10%              |
      | Policy18  | 2512 | 10%              |

  @SID_4
  Scenario: BW by policy filter by policy in
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | Policy14 |
    And Sleep "3"
    Then UI Total Pie Chart data "Bandwidth per Policy"
      | size | offset |
      | 1    | 0      |
    Then UI Validate Pie Chart data "Bandwidth per Policy"
      | label    | data   | offsetPercentage |
      | Policy14 | 3089.0 | 10%              |

  @SID_5
  Scenario: BW by policy filter by policy out
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | Policy15 |
    And Sleep "3"
#Then UI Total Pie Chart data "Bandwidth per Policy"
#| size | offset |
#| 0    | 0      |
    Then UI Validate Pie Chart data "Bandwidth per Policy"
      | label    | exist |
      | Policy15 | false |

#    The Policy14 is not exist in WebUI but exit on Session Storage , the test will always fail.
#    Then UI Validate Pie Chart data "Bandwidth per Policy"
#      | label    | exist |
#      | Policy14 | false |

    And UI Logout

  @SID_6
  Scenario: BW by policy RBAC device
    Given UI Login with user "sec_mon_all_pol" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And Sleep "2"
    Then UI Total Pie Chart data "Bandwidth per Policy"
      | size | offset |
      | 10   | 0      |
    Then UI Validate Pie Chart data "Bandwidth per Policy"
      | label     | data | offsetPercentage |
      | Policy150 | 7479 | 10%              |
      | Policy20  | 3152 | 10%              |
      | Policy200 | 3152 | 10%              |
      | Policy19  | 3099 | 10%              |
      | Policy190 | 3099 | 10%              |
      | Policy14  | 3089 | 10%              |
      | Policy140 | 3089 | 10%              |
      | Policy16  | 2885 | 10%              |
      | Policy160 | 2885 | 10%              |
      | Policy18  | 2512 | 10%              |
    And UI Logout

  @SID_7
  Scenario: BW by policy RBAC policy
    Given UI Login with user "sec_mon_Policy14" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And Sleep "2"
    Then UI Total Pie Chart data "Bandwidth per Policy"
      | size | offset |
      | 1    | 0      |
    Then UI Validate Pie Chart data "Bandwidth per Policy"
      | label    | data   | offsetPercentage |
      | Policy14 | 3089.0 | 10%              |
    Then UI Validate Pie Chart data "Bandwidth per Policy"
      | label     | exist |
      | Policy140 | false |

    And UI logout and close browser


  @SID_8
  Scenario: BW by policy clean and new
    And CLI kill all simulator attacks on current vision
    Given CLI simulate 14 attacks of type "Maxim31_30" on "DefensePro" 10 with loopDelay 15000 and wait 120 seconds
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Total Pie Chart data "Bandwidth per Policy"
      | size | offset |
      | 2    | 0      |
    Then UI Validate Pie Chart data "Bandwidth per Policy"
      | label   | data      | offsetPercentage |
      | Maxim30 | 3435973.0 | 10%              |
      | Maxim31 | 6871947.0 | 10%              |

  @SID_9
  Scenario: BW by policy check logs
    Then UI logout and close browser
    Then CLI kill all simulator attacks on current vision
    Then CLI Check if logs contains
      | logType     | expression                                          | isExpected   |
      | ES          | fatal\|error                                        | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error                                        | NOT_EXPECTED |
      | JBOSS       | fatal                                               | NOT_EXPECTED |
      | TOMCAT      | fatal                                               | NOT_EXPECTED |
      | TOMCAT2     | fatal                                               | NOT_EXPECTED |
      | JBOSS       | Not authorized operation launched by the user: sec_ | IGNORE       |

#      END BW BY POLICY


