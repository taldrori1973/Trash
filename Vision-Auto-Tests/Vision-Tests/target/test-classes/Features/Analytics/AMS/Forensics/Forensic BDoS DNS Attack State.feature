@TC108793
Feature: AMS forensic BDoS and DNS Attack State

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * CLI Clear vision logs
    * REST Delete ES index "dp-*"

  @SID_2
  Scenario: generate BDoS attacks with all possible states
    Given CLI simulate 1 attacks of type "DNS_States" on "DefensePro" 10
    Given CLI simulate 1 attacks of type "Burst_States" on "DefensePro" 11

  @SID_3
  Scenario: Login and enter forensic tab
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Open Upper Bar Item "AMS"
    And UI Open "Forensics" Tab

  @SID_4
  Scenario: Create forensic report for BDoS and DNS attacks
    When UI "Create" Forensics With Name "BDoS_DNS_State"
      | Output | Attack ID,Threat Category,Attack Name |

  @SID_5
  Scenario: Generate the forensic report
    Given UI Generate and Validate Forensics With Name "BDoS_DNS_State" with Timeout of 300 Seconds

  @SID_6
  Scenario: validate attack state of 60-1514816419
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "60-1514816419"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Burst Attack Signature Blocking"
    When UI Click Button "Report.Attack Details.Close"

  @SID_7
  Scenario: validate attack state of 61-1514816419
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "61-1514816419"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Strictness Anomaly"
    When UI Click Button "Report.Attack Details.Close"

  @SID_8
  Scenario: validate attack state of 62-1514816419
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "62-1514816419"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Anomaly"
    When UI Click Button "Report.Attack Details.Close"

  @SID_9
  Scenario: validate attack state of 63-1514816419
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "63-1514816419"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Real-Time Signature Blocking"
    When UI Click Button "Report.Attack Details.Close"

  @SID_10
  Scenario: validate attack state of 64-1514816419
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "64-1514816419"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Real-Time Signature Analysis"
    When UI Click Button "Report.Attack Details.Close"

  @SID_11
  Scenario: validate attack state of 65-1514816419
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "65-1514816419"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Normal"
    When UI Click Button "Report.Attack Details.Close"

  @SID_12
  Scenario: validate attack state of 40-1528993409
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "40-1528993409"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Normal"
    When UI Click Button "Report.Attack Details.Close"

  @SID_13
  Scenario: validate attack state of 41-1528993409
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "41-1528993409"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Real-Time Signature Analysis"
    When UI Click Button "Report.Attack Details.Close"

  @SID_14
  Scenario: validate attack state of 42-1528993409
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "42-1528993409"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Real-Time Signature Challenge"
    When UI Click Button "Report.Attack Details.Close"

  @SID_15
  Scenario: validate attack state of 43-1528993409
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "43-1528993409"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Real-Time Signature Rate Limit"
    When UI Click Button "Report.Attack Details.Close"

  @SID_16
  Scenario: validate attack state of 44-1528993409
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "44-1528993409"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Collective Challenge"
    When UI Click Button "Report.Attack Details.Close"

  @SID_17
  Scenario: validate attack state of 45-1528993409
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "45-1528993409"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Collective Rate Limit"
    When UI Click Button "Report.Attack Details.Close"

  @SID_18
  Scenario: validate attack state of 46-1528993409
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "46-1528993409"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Collective Challenge"
    When UI Click Button "Report.Attack Details.Close"

  @SID_19
  Scenario: validate attack state of 47-1528993409
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "47-1528993409"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Collective Rate Limit"
    When UI Click Button "Report.Attack Details.Close"

  @SID_20
  Scenario: validate attack state of 48-1528993409
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "48-1528993409"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Anomaly"
    When UI Click Button "Report.Attack Details.Close"

  @SID_21
  Scenario: validate attack state of 49-1528993409
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "49-1528993409"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Real-Time Signature Challenge"
    When UI Click Button "Report.Attack Details.Close"

  @SID_22
  Scenario: validate attack state of 50-1528993409
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "50-1528993409"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Collective Challenge"
    When UI Click Button "Report.Attack Details.Close"

  @SID_23
  Scenario: validate attack state of 51-1528993409
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "51-1528993409"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Collective Rate Limit"
    When UI Click Button "Report.Attack Details.Close"

  @SID_24
  Scenario: Clear ES for new attacks
    Given CLI kill all simulator attacks on current vision
    Given REST Delete ES index "dp-*"
    # Wait for clean to finish
    And Sleep "30"
    Then CLI Run remote linux Command "curl -XGET localhost:9200/dp-attack-raw-*/_search?pretty" on "ROOT_SERVER_CLI"
    Given CLI simulate 1 attacks of type "newstate2" on "DefensePro" 11
    Given CLI simulate 1 attacks of type "newstate3" on "DefensePro" 11
    Given CLI simulate 1 attacks of type "newstate4" on "DefensePro" 11 and wait 90 seconds
    Then CLI Run remote linux Command "curl -XGET localhost:9200/dp-attack-raw-*/_search?pretty" on "ROOT_SERVER_CLI"
    When UI "Create" Forensics With Name "BDoS_DNS_State"
      | Output | Attack ID,Threat Category,Attack Name |
    Given UI Generate and Validate Forensics With Name "BDoS_DNS_State" with Timeout of 300 Seconds

  @SID_25
  Scenario: validate network flood IPv4 UDP attack state of 51-1577804729
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "51-1577804729"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Anomaly – Rate Limit"
    When UI Click Button "Report.Attack Details.Close"

  @SID_26
  Scenario: validate Behavioral DoS attack state of 35-1578309882
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "35-1578309882"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Overblocking Anomaly – Rate Limit"
    When UI Click Button "Report.Attack Details.Close"

  @SID_27
  Scenario: validate Behavioral DoS attack state of 36-1578309882
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "36-1578309882"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Real-Time Signature Analysis – Rate Limit"
    When UI Click Button "Report.Attack Details.Close"

  @SID_28
  Scenario: Second clear ES for new attack
    Given CLI kill all simulator attacks on current vision
    Given REST Delete ES index "dp-*"
    And Sleep "30"
    # Wait for clean to finish
    Given CLI simulate 1 attacks of type "newstate1" on "DefensePro" 10 and wait 90 seconds
    When UI "Create" Forensics With Name "BDoS_DNS_State"
      | Output | Attack ID,Threat Category,Attack Name |
    Given UI Generate and Validate Forensics With Name "BDoS_DNS_State" with Timeout of 300 Seconds

  @SID_29
  Scenario: validate network flood IPv4 UDP attack state of 51-1577804729
    When UI Click Button "Views.report" with value "BDoS_DNS_State"
    And UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "51-1577804729"
    Then UI Text of "Report.Attack Details.Detail" with extension "State" equal to "Strictness Anomaly – Rate Limit"
    When UI Click Button "Report.Attack Details.Close"

  @SID_30
  Scenario: Logout
    Then UI logout and close browser
