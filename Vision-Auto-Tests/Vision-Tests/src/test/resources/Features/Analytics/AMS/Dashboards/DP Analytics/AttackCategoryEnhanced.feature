@TC122311
Feature: Attack Category Enhanced

  @SID_1
  Scenario: Clean system data
    Given CLI Reset radware password
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    * CLI kill all simulator attacks on current vision
    * CLI Clear vision logs
    * REST Delete ES index "dp-*"
    * REST Delete ES index "forensics-*"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"

  @SID_2
  Scenario: Run DP simulator BDOS attack
    Given CLI simulate 1 attacks of type "many_attacks" on SetId "DefensePro_Set_1" and wait 250 seconds

    * CLI kill all simulator attacks on current vision

  @SID_3
  Scenario: Login and navigate
    When UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    Then Sleep "15"

  @SID_4
  Scenario: Validate Attacks by Threat Category Pie Chart data
    Then UI Validate Pie Chart data "Attacks by Threat Category"
      | label          | data |
      | Intrusions     | 8   |
      | TrafficFilters | 7    |
      | DNS            | 7    |
      | BehavioralDOS  | 6    |
      | DOSShield      | 2    |
      | Anti-Scanning  | 2    |
      | Anomalies      | 1    |


  @SID_5
  Scenario: Validate Top Attack Sources Pie Chart data
    Then UI Validate Pie Chart data "Top Attack Sources"
      | label       | data |
      | Multiple    | 11   |
      | 149.85.1.2  | 7    |
      | 2.2.2.1     | 3    |
      | 192.85.1.7  | 2    |
      | 190.85.1.2  | 1    |
      | 1.1.1.1     | 1    |
      | 1.3.5.8     | 1    |
      | 100.1.1.1   | 1    |
      | 12.12.12.12 | 1    |
      | 15.15.15.15 | 1    |

  @SID_6
  Scenario: Validate Attacks by Threat Category Labels and Value
    Then UI Text of "Attacks by Threat Category Label" with extension "Intrusions" equal to "Intrusions"

    Then UI Text of "Attacks by Threat Category Value" with extension "Intrusions" GTE to "24% (8)" with offset "2"

    Then UI Text of "Attacks by Threat Category Label" with extension "DNS" equal to "DNS"
    Then UI Text of "Attacks by Threat Category Value" with extension "DNS" GTE to "21% (7)" with offset "2"

    Then UI Text of "Attacks by Threat Category Label" with extension "TrafficFilters" equal to "TrafficFilters"
    Then UI Text of "Attacks by Threat Category Value" with extension "TrafficFilters" GTE to "21% (7)" with offset "2"

    Then UI Text of "Attacks by Threat Category Label" with extension "BehavioralDOS" equal to "BehavioralDOS"
    Then UI Text of "Attacks by Threat Category Value" with extension "BehavioralDOS" GTE to "18% (6)" with offset "2"

    Then UI Validate Labels from more options in pie chart "Attacks by Threat Category" Equal to "Anti-Scanning"
    Then UI Validate Value from more options in pie chart "Attacks by Threat Category" Equal to "6%" with label "Anti-Scanning" with offset "3"

    Then UI Validate Labels from more options in pie chart "Attacks by Threat Category" Equal to "DOSShield"
    Then UI Validate Value from more options in pie chart "Attacks by Threat Category" Equal to "6%" with label "DOSShield" with offset "3"

    Then UI Validate Labels from more options in pie chart "Attacks by Threat Category" Equal to "Anomalies"
    Then UI Validate Value from more options in pie chart "Attacks by Threat Category" Equal to "3" with label "Anomalies" with offset "3"

  @SID_7
  Scenario: Validate Top Attack Sources Labels and Value
    Then UI Text of "Top Attack Sources Label" with extension "Multiple" equal to "Multiple"
    Then UI Text of "Top Attack Sources Value" with extension "Multiple" GTE to "37% (11)" with offset "3"

    Then UI Text of "Top Attack Sources Label" with extension "149.85.1.2" equal to "149.85.1.2"
    Then UI Text of "Top Attack Sources Value" with extension "149.85.1.2" GTE to "24% (7)" with offset "3"

    Then UI Text of "Top Attack Sources Label" with extension "2.2.2.1" equal to "2.2.2.1"
    Then UI Text of "Top Attack Sources Value" with extension "2.2.2.1" GTE to "10% (3)" with offset "3"

#    Then UI Text of "Top Attack Sources Label" with extension "100.1.1.1" equal to "100.1.1.1"
#    Then UI Text of "Top Attack Sources Value" with extension "100.1.1.1" GTE to "3% (2)" with offset "3"
#    Then UI Validate Labels from more options in pie chart "100.1.1.1" Equal to "100.1.1.1"
#    Then UI Validate Value from more options in pie chart "100.1.1.1" Equal to "3.45%" with label "100.1.1.1" with offset "3"

    Then UI Validate Labels from more options in pie chart "Top Attack Sources" Equal to "190.85.1.2"
    Then UI Validate Value from more options in pie chart "Top Attack Sources" Equal to "3%" with label "190.85.1.2" with offset "3"

    Then UI Validate Labels from more options in pie chart "Top Attack Sources" Equal to "1.1.1.1"
    Then UI Validate Value from more options in pie chart "Top Attack Sources" Equal to "3.03%" with label "1.1.1.1" with offset "3"

    Then UI Validate Labels from more options in pie chart "Top Attack Sources" Equal to "1.3.5.8"
    Then UI Validate Value from more options in pie chart "Top Attack Sources" Equal to "3.03%" with label "1.3.5.8" with offset "3"

    Then UI Validate Labels from more options in pie chart "Top Attack Sources" Equal to "192.85.1.7"
    Then UI Validate Value from more options in pie chart "Top Attack Sources" Equal to "7%" with label "192.85.1.7" with offset "3"

    Then UI Validate Labels from more options in pie chart "Top Attack Sources" Equal to "12.12.12.12"
    Then UI Validate Value from more options in pie chart "Top Attack Sources" Equal to "3.03%" with label "12.12.12.12" with offset "3"

    Then UI Validate Labels from more options in pie chart "Top Attack Sources" Equal to "15.15.15.15"
    Then UI Validate Value from more options in pie chart "Top Attack Sources" Equal to "3.03%" with label "15.15.15.15" with offset "3"


  @SID_8
  Scenario: delete all attacks and kill simulator
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"


  @SID_9
  Scenario: send ErtFeed_GeoFeed attack
    Given CLI simulate 1 attacks of type "ErtFeed_GeoFeed" on SetId "DefensePro_Set_1" and wait 250 seconds
    * CLI kill all simulator attacks on current vision
    Then Sleep "15"


  @SID_10
  Scenario: Validate Attacks by Threat Category Pie Chart data
    Then UI Validate Pie Chart data "Attacks by Threat Category"
      | label                  | data |
      | Malicious IP Addresses | 1    |
      | GeoFeed                | 1    |

  @SID_11
  Scenario: Validate Attacks by Threat Category Pie Chart data
    Then UI Validate Pie Chart data "Top Attack Sources"
      | label    | data |
      | Multiple | 2    |

  @SID_12
  Scenario: Validate Attacks by Threat Category Labels and Value
    Then UI Text of "Attacks by Threat Category Label" with extension "Malicious IP Addresses" equal to "Malicious IP Addresses"
    Then UI Text of "Attacks by Threat Category Value" with extension "Malicious IP Addresses" GTE to "50% (1)" with offset "0"

    Then UI Text of "Attacks by Threat Category Label" with extension "GeoFeed" equal to "GeoFeed"
    Then UI Text of "Attacks by Threat Category Value" with extension "GeoFeed" GTE to "50% (1)" with offset "0"

  @SID_13
  Scenario: Validate Top Attack Sources Labels and Value
    Then UI Text of "Top Attack Sources Label" with extension "Multiple" equal to "Multiple"
    Then UI Text of "Top Attack Sources Value" with extension "Multiple" GTE to "100% (2)" with offset "0"

  @SID_14
  Scenario: Validate Attacks by Threat Category Labels and Value Exclude Malicious IP Addresses
    Then UI Click Button "Exclude Malicious IP Addresses Checkbox"
    Then UI Text of "Attacks by Threat Category Label" with extension "GeoFeed" equal to "GeoFeed"
    Then UI Text of "Attacks by Threat Category Value" with extension "GeoFeed" GTE to "100% (1)" with offset "0"

  @SID_15
  Scenario: Validate Top Attack Sources Labels and Value
    Then UI Text of "Top Attack Sources Label" with extension "Multiple" equal to "Multiple"
    Then UI Text of "Top Attack Sources Value" with extension "Multiple" GTE to "100% (1)" with offset "0"


  @SID_16
  Scenario: Logout and close browser
    Given UI logout and close browser