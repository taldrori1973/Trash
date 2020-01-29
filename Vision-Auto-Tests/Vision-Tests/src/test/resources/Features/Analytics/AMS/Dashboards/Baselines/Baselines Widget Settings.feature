@VRM_BDoS_Baseline @TC105986

Feature: Baselines Widget Settings

  @SID_1
  Scenario: BDoS baseline widget Settings pre-requisite
    Given CLI kill all simulator attacks on current vision
    Given CLI Clear vision logs
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
#    Given REST Delete ES index "dp-bdos-baseline*"
#    Given REST Delete ES index "dp-baseline*"
    Given CLI simulate 100 attacks of type "rest_bdosdns" on "DefensePro" 11 with loopDelay 15000
    Given CLI simulate 100 attacks of type "baselines_pol_1" on "DefensePro" 10 with loopDelay 15000 and wait 140 seconds

  @SID_2
  Scenario: Login into VRM and select device and policy
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "  DefensePro Behavioral Protections Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | pol_1    |

  @SID_3
  Scenario: DP baselines widget settings Cancel
  Then UI Do Operation "select" item "BDoS-TCP SYN IPv6"
  Then UI Do Operation "hover" item "BDoS-TCP SYN ACK IPv4"
  Then UI Do Operation "select" item "BDoS-TCP SYN ACK Widget Settings"
  Then UI Do Operation "select" item "Widget Settings Cancel"

    And UI Do Operation "Select" item "BDoS-TCP SYN ACK IPv4"
    And UI Do Operation "Select" item "BDoS-TCP SYN ACK Inbound"
    And UI Do Operation "Select" item "BDoS-TCP SYN ACK bps"
    And Sleep "2"
    And UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Suspected Edge"
      | value | count | offset |
      | 464   | 13    | 4      |
    And UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 322   | 13    | 4      |
    And UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Attack Edge"
      | value | count | offset |
      | 628   | 13    | 4      |
    And UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 44000 | 13    | 4      |
    And UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 66680 | 13    | 4      |

  @SID_4
  Scenario: DP baselines widget settings Save
    Then UI Do Operation "select" item "BDoS-TCP SYN IPv6"
    Then UI Do Operation "hover" item "BDoS-TCP SYN ACK IPv6"
    Then UI Do Operation "select" item "BDoS-TCP SYN ACK Widget Settings"
    Then UI VRM Select device from dashboard
      | index | ports | policies |
      | 11    |       | BDOS     |
    And UI Do Operation "select" item "Widget Settings Save"

  @SID_5
  Scenario: DP baselines widget settings Save - validate values
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Suspected Edge"
      | value | count | offset |
      | 105   | 13    | 6      |
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 96    | 13    | 6      |
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Attack Edge"
      | value | count | offset |
      | 115   | 13    | 6      |
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 0     | 13    | 6      |
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 1727  | 13    | 6      |

  @SID_6
  Scenario: DP baselines widget settings Save - validate values of other widget
    When UI Do Operation "Select" item "BDoS-TCP SYN IPv4"
    When UI Do Operation "Select" item "BDoS-TCP SYN Inbound"
    When UI Do Operation "Select" item "BDoS-TCP SYN bps"
    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Suspected Edge"
      | value | count | offset |
      | 464   | 13    | 4      |
    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Normal Edge"
      | value | count | offset |
      | 322   | 13    | 4      |
    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Attack Edge"
      | value | count | offset |
      | 628   | 13    | 4      |
    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Legitimate Traffic"
      | value | count | offset |
      | 44800 | 13    | 4      |
    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Total Traffic"
      | value | count | offset |
      | 46640 | 13    | 4      |

  @SID_7
  Scenario: DP baselines widget settings Default
    Then UI Do Operation "select" item "BDoS-TCP SYN IPv6"
    Then UI Do Operation "hover" item "BDoS-TCP SYN ACK IPv4"
    Then UI Do Operation "select" item "BDoS-TCP SYN ACK Widget Settings"
    Then UI Do Operation "select" item "Widget Settings Default"
    And Sleep "1"

  @SID_8
  Scenario: DP baselines widget settings Default - validate values
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Suspected Edge"
      | value | count | offset |
      | 464   | 13    | 4      |
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 322   | 13    | 4      |
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Attack Edge"
      | value | count | offset |
      | 628   | 13    | 4      |
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 44000 | 13    | 4      |
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 66680 | 13    | 4      |

  @SID_9
  Scenario: BDoS baselines Widget Settings Clear and check logs
    Then CLI kill all simulator attacks on current vision
    Then UI logout and close browser
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal        | NOT_EXPECTED |
