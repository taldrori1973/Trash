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
    Given CLI simulate 1 attacks of type "many_attacks" on "DefensePro" 10 and wait 250 seconds

  @SID_3
  Scenario: Login and navigate
    When UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage

  @SID_4
  Scenario: Validate Attacks by Threat Category Pie Chart data
    Then UI Validate Pie Chart data "Attacks by Threat Category"
      | label          | data |
      | Intrusions     | 9    |
      | TrafficFilters | 7    |
      | DNS            | 7    |
      | BehavioralDOS  | 6    |
      | DOSShield      | 3    |
      | Anti-Scanning  | 2    |
      | Anomalies      | 1    |

  @SID_5
  Scenario: Validate Attacks by Threat Category Labels and Value
    Then UI Text of "Attacks by Threat Category Label" with extension "Intrusions" equal to "Intrusions"
    Then UI Text of "Attacks by Threat Category Value" with extension "Intrusions" GTE to "25% (9)" with offset "2"

    Then UI Text of "Attacks by Threat Category Label" with extension "TrafficFilters" equal to "TrafficFilters"
    Then UI Text of "Attacks by Threat Category Value" with extension "TrafficFilters" GTE to "17% (9)" with offset "2"

    Then UI Text of "Attacks by Threat Category Label" with extension "DNS" equal to "DNS"
    Then UI Text of "Attacks by Threat Category Value" with extension "TrafficFilters" GTE to "17% (9)" with offset "2"

    Then UI Text of "Attacks by Threat Category Label" with extension "BehavioralDOS" equal to "BehavioralDOS"
    Then UI Text of "Attacks by Threat Category Value" with extension "BehavioralDOS" GTE to "10% (9)" with offset "2"

#    Then UI Text of "Attacks by Threat Category Label" with extension "DOSShield" equal to "DOSShield"
#    Then UI Text of "Attacks by Threat Category Value" with extension "DOSShield" GTE to "4% (9)" with offset "5"
#
#    Then UI Text of "Attacks by Threat Category Label" with extension "Anti-Scanning" equal to "Anti-Scanning"
#    Then UI Text of "Attacks by Threat Category Value" with extension "Anti-Scanning" GTE to "1% (9)" with offset "5"
#
#    Then UI Text of "Attacks by Threat Category Label" with extension "Anomalies" equal to "Anomalies"
#    Then UI Text of "Attacks by Threat Category Value" with extension "Anomalies" GTE to "17% (9)" with offset "5"



  @SID_6
  Scenario: Logout and close browser
    Given UI logout and close browser