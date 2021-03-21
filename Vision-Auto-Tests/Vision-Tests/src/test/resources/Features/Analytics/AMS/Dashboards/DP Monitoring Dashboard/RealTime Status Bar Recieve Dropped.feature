@TC112255
Feature: VRM Real Time Status Bar Received Dropped

  @SID_1
  Scenario: Received Dropped realTime generate traffic
    Then CLI Clear vision logs
    Given CLI kill all simulator attacks on current vision
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given CLI simulate 50 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 11 with loopDelay 15000
    Given CLI simulate 50 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000 and wait 60 seconds


  @SID_2
  Scenario: Receive Drop Real Time basic
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And Sleep "2"
    Then UI Validate element "Total Traffic.Dropped" attribute
      | name  | value                                                                                                                |
      | title | 1,027,638.00                                                                                                         |
      | style | width: 42%; background-color: rgb(180, 18, 27); height: 100%; position: relative; color: white; border-radius: 15px; |
    Then UI Validate Text field "Total Traffic Dropped text" EQUALS "1.03 G"
    Then UI Validate element "Total Traffic.Received" attribute
      | name  | value                                                                                                                  |
      | title | 1,459,480.00                                                                                                           |
      | style | width: 59%; background-color: rgb(159, 204, 237); height: 100%; position: relative; color: white; border-radius: 15px; |
    Then UI Validate Text field "Total Traffic Received text" EQUALS "1.46 G"
    When UI Navigate to "VISION SETTINGS" page via homePage

  @SID_3
  Scenario: Receive Drop Real Time Filter Device
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Validate element "Total Traffic.Dropped" attribute
      | name  | value                                                                                                                |
      | title | 513,819.00                                                                                                           |
      | style | width: 42%; background-color: rgb(180, 18, 27); height: 100%; position: relative; color: white; border-radius: 15px; |
    Then UI Validate Text field "Total Traffic Dropped text" EQUALS "513.82 M"
    Then UI Validate element "Total Traffic.Received" attribute
      | name  | value                                                                                                                  |
      | title | 729,740.00                                                                                                             |
      | style | width: 59%; background-color: rgb(159, 204, 237); height: 100%; position: relative; color: white; border-radius: 15px; |
    Then UI Validate Text field "Total Traffic Received text" EQUALS "729.74 M"


  @SID_4
  Scenario: Receive Drop Real Time Filter Port
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 4     |          |
#    Then UI Validate Element Existence By Label "Total Traffic.Dropped" if Exists "false"
#    Then UI Validate Element Existence By Label "Total Traffic.Received" if Exists "false"
#   In 4.10 the styling was changed and no traffic will cause no element

    Then UI Validate element "Total Traffic.Dropped" attribute
      | name  | value                                                                                                               |
   # | title | 513,819.00   |
      | style | width: 2%; background-color: rgb(180, 18, 27); height: 100%; position: relative; color: white; border-radius: 15px; |
    Then UI Validate element "Total Traffic.Received" attribute
      | name  | value                                                                                                                 |
    #| title | 729,740.00   |
      | style | width: 2%; background-color: rgb(159, 204, 237); height: 100%; position: relative; color: white; border-radius: 15px; |
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    | 6     |          |
    Then UI Validate element "Total Traffic.Dropped" attribute
      | name  | value                                                                                                                |
      | title | 513,819.00                                                                                                           |
      | style | width: 42%; background-color: rgb(180, 18, 27); height: 100%; position: relative; color: white; border-radius: 15px; |
    Then UI Validate Text field "Total Traffic Dropped text" EQUALS "513.82 M"
    Then UI Validate element "Total Traffic.Received" attribute
      | name  | value                                                                                                                  |
      | title | 729,740.00                                                                                                             |
      | style | width: 59%; background-color: rgb(159, 204, 237); height: 100%; position: relative; color: white; border-radius: 15px; |
    Then UI Validate Text field "Total Traffic Received text" EQUALS "729.74 M"
    When UI Navigate to "VISION SETTINGS" page via homePage
    And UI Logout


  @SID_5
  Scenario: Receive Drop Real Time Filter Policy
    Given UI Login with user "sec_admin_all_pol" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | Policy14 |
    And Sleep "3"
    Then UI Validate element "Total Traffic.Dropped" attribute
      | name  | value    |
      | title | 2,322.00 |
  #  | style | height: 42%; |
    Then UI Validate element "Total Traffic.Received" attribute
      | name  | value    |
      | title | 3,089.00 |
   # | style | height: 59%; |
    And UI Logout

  @SID_6
  Scenario: Receive Drop Real Time RBAC Device
    Given UI Login with user "sec_admin_all_pol" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Validate element "Total Traffic.Dropped" attribute
      | name  | value                                                                                                                |
      | title | 513,819.00                                                                                                           |
      | style | width: 42%; background-color: rgb(180, 18, 27); height: 100%; position: relative; color: white; border-radius: 15px; |
    Then UI Validate element "Total Traffic.Received" attribute
      | name  | value                                                                                                                  |
      | title | 729,740.00                                                                                                             |
      | style | width: 59%; background-color: rgb(159, 204, 237); height: 100%; position: relative; color: white; border-radius: 15px; |
    And UI Logout


  @SID_7
  Scenario: Receive Drop Real Time RBAC policy
    Given UI Login with user "sec_mon_Policy14" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Validate element "Total Traffic.Dropped" attribute
      | name  | value    |
      | title | 2,322.00 |
  #  | style | height: 42%; |
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | Policy14 |
    # Defect- we expect to see values without the need for selecting policy
    Then UI Validate element "Total Traffic.Received" attribute
      | name  | value                                                                                                                  |
      | title | 3,089.00                                                                                                               |
      | style | width: 58%; background-color: rgb(159, 204, 237); height: 100%; position: relative; color: white; border-radius: 15px; |
    And UI Logout


  @SID_8
  Scenario: Receive Drop Real Time High Volume
    Given CLI kill all simulator attacks on current vision
    Given CLI simulate 20 attacks of type "rest_traffic_high_volume" on "DefensePro" 10 with loopDelay 15000 and wait 120 seconds
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And Sleep "3"
    Then UI Validate Text field "Total Traffic Dropped text" EQUALS "513.82 M"
    Then UI Validate Text field "Total Traffic Received text" EQUALS "1.66 T"
#  The dropped bar in this scenario is too small to be painted
#  Then UI Validate element "TOTAL TRAFFIC.Dropped" attribute
#    | name  | value     |
#    | title | 513819.00 |
#  #  | style | height: 42%; |
    Then UI Validate element "Total Traffic.Received" attribute
      | name  | value            |
      | title | 1,660,000,900.00 |
   # | style | height: 59%; |


  @SID_9
  Scenario: Receive Drop Real Time Cleared
    Given CLI kill all simulator attacks on current vision
    And Sleep "170"
#    Then UI Validate Element Existence By Label "Total Traffic.Dropped" if Exists "false"
#    Then UI Validate Element Existence By Label "Total Traffic.Received" if Exists "false"

#   In 4.10 the styling was changed and no traffic will cause no element
    Then UI Validate element "Total Traffic.Dropped" attribute
      | name  | value                                                                                                               |
   # | title | 513,819.00   |
      | style | width: 2%; background-color: rgb(180, 18, 27); height: 100%; position: relative; color: white; border-radius: 15px; |
    Then UI Validate element "Total Traffic.Received" attribute
      | name  | value                                                                                                                 |
    #| title | 729,740.00   |
      | style | width: 2%; background-color: rgb(159, 204, 237); height: 100%; position: relative; color: white; border-radius: 15px; |
    And UI Logout

  @SID_10
  Scenario: Receive Drop Real Time check logs
    When UI logout and close browser
    Then CLI Check if logs contains
      | logType     | expression                                          | isExpected   |
      | ES          | fatal\|error                                        | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error                                        | NOT_EXPECTED |
      | JBOSS       | fatal                                               | NOT_EXPECTED |
      | TOMCAT      | fatal                                               | NOT_EXPECTED |
      | TOMCAT2     | fatal                                               | NOT_EXPECTED |
      | JBOSS       | Not authorized operation launched by the user: sec_ | IGNORE       |


#      END RECEIVED DROPPED