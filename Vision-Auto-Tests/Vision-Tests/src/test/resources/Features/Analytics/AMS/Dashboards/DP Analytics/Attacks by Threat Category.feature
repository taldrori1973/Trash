Feature: Attacks by Threat Category

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
      | label          | data | backgroundColor | shapeType  |
      | Intrusions     | 79   | #04C2A0         | plus       |
      | TrafficFilters | 69   | #4388C8         | cross      |
      | DNS            | 8    | #FFC107         | dash       |
      | BehavioralDOS  | 8    | #108282         | cross-dash |
      | DOSShield      | 6    | #088EB1         | dot        |
      | Anti-Scanning  | 2    | #6CB9FF         | dots       |
      | Anomalies      | 1    | #00BDEE         | disc       |

  @SID_4
  Scenario: Validate Attacks by Threat Category Labels and Value
    Then UI Text of "Attacks by Threat Category Label" with extension "Intrusions" equal to "Intrusions"
    Then UI Text of "Attacks by Threat Category Value" with extension "Intrusions" equal to "45.66% (79)"

    Then UI Text of "Attacks by Threat Category Label" with extension "TrafficFilters" equal to "TrafficFilters"
    Then UI Text of "Attacks by Threat Category Value" with extension "TrafficFilters" equal to "39.88% (69)"

    Then UI Text of "Attacks by Threat Category Label" with extension "DNS" equal to "DNS"
    Then UI Text of "Attacks by Threat Category Value" with extension "DNS" equal to "4.62% (8)"

    Then UI Text of "Attacks by Threat Category Label" with extension "BehavioralDOS" equal to "BehavioralDOS"
    Then UI Text of "Attacks by Threat Category Value" with extension "BehavioralDOS" equal to "3.47% (6)"

    Then UI Text of "Attacks by Threat Category Label" with extension "DOSShield" equal to "DOSShield"
    Then UI Text of "Attacks by Threat Category Value" with extension "DOSShield" equal to "4.62% (8)"

    Then UI Text of "Attacks by Threat Category Label" with extension "Anti-Scanning" equal to "Anti-Scanning"
    Then UI Text of "Attacks by Threat Category Value" with extension "Anti-Scanning" equal to "1.16% (2)"

    Then UI Text of "Attacks by Threat Category Label" with extension "Anomalies" equal to "Anomalies"
    Then UI Text of "Attacks by Threat Category Value" with extension "Anomalies" equal to "0.58% (1)"

  @SID_4
  Scenario: Unselect Intrusions checkbox and Validate Attacks by Threat Category Pie Chart data
    Then UI Click Button "Attacks by Threat Category checkbox" with value "Intrusions"
    Then UI Validate Pie Chart data "Attacks by Threat Category"
      | label          | data | backgroundColor | shapeType  |
      | Intrusions     | 44   | #04C2A0         | plus       |
      | TrafficFilters | 41   | #4388C8         | cross      |
      | DNS            | 8    | #FFC107         | dash       |
      | BehavioralDOS  | 6    | #108282         | cross-dash |
      | DOSShield      | 6    | #088EB1         | dot        |
      | Anti-Scanning  | 2    | #6CB9FF         | dots       |
      | Anomalies      | 1    | #00BDEE         | disc       |





  @SID_23
  Scenario: Logout and close browser
    Given UI logout and close browser