@TC112256
Feature: VRM Real Time Status Bar Traffic Composition

  @SID_1
  Scenario: Traffic Composition Clean system data before test
  # Written by YL
    Given CLI kill all simulator attacks on current vision
    Then CLI Clear vision logs
    # The 2 duplicate attacks are to verify that UI is only looking at last minute
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given CLI simulate 2 attacks of type "rest_traffic" on "DefensePro" 10 with loopDelay 15000
    Given CLI simulate 80 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 20 with loopDelay 15000
    Given CLI simulate 80 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 11 with loopDelay 15000
    Given CLI simulate 80 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000 and wait 115 seconds

  @SID_2
  Scenario: Traffic Composition protocols basic
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And Sleep "5"
    Then UI Validate Pie Chart data "Traffic Composition"
      | label | data    | backgroundcolor          |
      | ICMP  | 240000  | rgba(235, 129, 116, 0.7) |
      | IGMP  | 6000    | rgba(95, 182, 199, 0.7)  |
      | OTHER | 60000   | rgba(154, 145, 150, 0.7) |
      | SCTP  | 20000   | rgba(203, 114, 152, 0.7) |
      | TCP   | 1002442 | rgba(70, 91, 108, 0.7)   |
      | UDP   | 131038  | rgba(127, 205, 181, 0.7) |

  @SID_3
  Scenario: Traffic Composition protocols filter device
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    And Sleep "2"
    Then UI Validate Pie Chart data "Traffic Composition"
      | label | data   | backgroundcolor          |
      | ICMP  | 120000 | rgba(235, 129, 116, 0.7) |
      | IGMP  | 3000   | rgba(95, 182, 199, 0.7)  |
      | OTHER | 30000  | rgba(154, 145, 150, 0.7) |
      | SCTP  | 10000  | rgba(203, 114, 152, 0.7) |
      | TCP   | 501221 | rgba(70, 91, 108, 0.7)   |
      | UDP   | 65519  | rgba(127, 205, 181, 0.7) |

  @SID_4
  Scenario: Traffic Composition protocols filter policy in
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | Policy14 |
    And Sleep "2"
    Then UI Validate Pie Chart data "Traffic Composition"
      | label | data | backgroundcolor          |
      | ICMP  | 0    | rgba(235, 129, 116, 0.7) |
      | IGMP  | 0    | rgba(95, 182, 199, 0.7)  |
      | OTHER | 0    | rgba(154, 145, 150, 0.7) |
      | SCTP  | 0    | rgba(203, 114, 152, 0.7) |
      | TCP   | 2070 | rgba(70, 91, 108, 0.7)   |
      | UDP   | 1019 | rgba(127, 205, 181, 0.7) |

  @SID_5
  Scenario: Traffic Composition protocols filter policy outbound
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | Policy15 |
    And Sleep "2"
    Then UI Validate Pie Chart data "Traffic Composition"
      | label | data   |
      | ICMP  | 66666  |
      | IGMP  | 33     |
      | OTHER | 100000 |
      | SCTP  | 60000  |
      | TCP   | 2086   |
      | UDP   | 1028   |
    Then UI Validate Pie Chart data "Traffic Composition"
      | label | backgroundcolor          |
      | ICMP  | rgba(235, 129, 116, 0.7) |
      | IGMP  | rgba(95, 182, 199, 0.7)  |
      | OTHER | rgba(154, 145, 150, 0.7) |
      | SCTP  | rgba(203, 114, 152, 0.7) |
      | TCP   | rgba(70, 91, 108, 0.7)   |
      | UDP   | rgba(127, 205, 181, 0.7) |
#    And UI Logout

  @SID_6
  Scenario: Traffic Composition protocols filter port negative
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 7     |          |
    And Sleep "2"
    Then UI Validate Pie Chart data "Traffic Composition"
      | label | data |
      | IGMP  | 0    |
      | SCTP  | 0    |
      | TCP   | 0    |
      | UDP   | 0    |
      | ICMP  | 0    |
      | OTHER | 0    |
    Then UI Validate Pie Chart data "Traffic Composition"
      | label | backgroundcolor          |
      | IGMP  | rgba(95, 182, 199, 0.7)  |
      | SCTP  | rgba(203, 114, 152, 0.7) |
      | TCP   | rgba(70, 91, 108, 0.7)   |
      | UDP   | rgba(127, 205, 181, 0.7) |
      | ICMP  | rgba(235, 129, 116, 0.7) |
      | OTHER | rgba(154, 145, 150, 0.7) |
    When UI Navigate to "VISION SETTINGS" page via homePage

  @SID_7
  Scenario: Traffic Composition protocols filter port positive
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 6     |          |
    And Sleep "2"
    Then UI Validate Pie Chart data "Traffic Composition"
      | label | data   |
      | ICMP  | 120000 |
      | IGMP  | 3000   |
      | OTHER | 30000  |
      | SCTP  | 10000  |
      | TCP   | 501221 |
      | UDP   | 65519  |
    Then UI Validate Pie Chart data "Traffic Composition"
      | label | backgroundcolor          |
      | ICMP  | rgba(235, 129, 116, 0.7) |
      | IGMP  | rgba(95, 182, 199, 0.7)  |
      | OTHER | rgba(154, 145, 150, 0.7) |
      | SCTP  | rgba(203, 114, 152, 0.7) |
      | UDP   | rgba(127, 205, 181, 0.7) |
      | TCP   | rgba(70, 91, 108, 0.7)   |
    And UI Logout

  @SID_8
  Scenario: Traffic Composition protocols RBAC device
    Given UI Login with user "sec_mon_all_pol" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And Sleep "2"
    Then UI Validate Pie Chart data "Traffic Composition"
      | label | data   |
      | ICMP  | 120000 |
      | IGMP  | 3000   |
      | OTHER | 30000  |
      | SCTP  | 10000  |
      | TCP   | 501221 |
      | UDP   | 65519  |
    Then UI Validate Pie Chart data "Traffic Composition"
      | label | backgroundcolor          |
      | ICMP  | rgba(235, 129, 116, 0.7) |
      | IGMP  | rgba(95, 182, 199, 0.7)  |
      | OTHER | rgba(154, 145, 150, 0.7) |
      | SCTP  | rgba(203, 114, 152, 0.7) |
      | UDP   | rgba(127, 205, 181, 0.7) |
      | TCP   | rgba(70, 91, 108, 0.7)   |
    Then UI Open "Configurations" Tab
    And UI Logout

  @SID_9
  Scenario: Traffic Composition protocols RBAC policy
    Given UI Login with user "sec_mon_Policy14" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | Policy14 |
    And Sleep "2"
    Then UI Validate Pie Chart data "Traffic Composition"
      | label | data |
      | ICMP  | 0    |
      | IGMP  | 0    |
      | OTHER | 0    |
      | SCTP  | 0    |
      | TCP   | 2070 |
      | UDP   | 1019 |
    Then UI Validate Pie Chart data "Traffic Composition"
      | label | backgroundcolor          |
      | ICMP  | rgba(235, 129, 116, 0.7) |
      | IGMP  | rgba(95, 182, 199, 0.7)  |
      | OTHER | rgba(154, 145, 150, 0.7) |
      | SCTP  | rgba(203, 114, 152, 0.7) |
      | TCP   | rgba(70, 91, 108, 0.7)   |
      | UDP   | rgba(127, 205, 181, 0.7) |
    Then UI Open "Configurations" Tab
    Then UI logout and close browser
    And CLI kill all simulator attacks on current vision

  @SID_10
  Scenario: Traffic Composition protocol check logs
    Then CLI Check if logs contains
      | logType     | expression                                          | isExpected   |
      | ES          | fatal\|error                                        | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error                                        | NOT_EXPECTED |
      | JBOSS       | fatal                                               | NOT_EXPECTED |
      | TOMCAT      | fatal                                               | NOT_EXPECTED |
      | TOMCAT2     | fatal                                               | NOT_EXPECTED |
      | JBOSS       | Not authorized operation launched by the user: sec_ | IGNORE       |


#      END TRAFFIC PROTOCOLS