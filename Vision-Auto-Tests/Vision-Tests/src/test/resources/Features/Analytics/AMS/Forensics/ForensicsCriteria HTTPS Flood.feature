@VRM_Report

Feature: Forensic Criteria HTTPS Flood Tests

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * REST Delete ES index "forensics-*"
    * REST Delete ES index "dpforensics-*"
    * CLI Clear vision logs
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |

  @SID_2
  Scenario: Run DP simulator
    Given CLI simulate 2 attacks of type "https_new2" on "DefensePro" 11 with loopDelay 15000 and wait 30 seconds
  @SID_3
  Scenario: VRM - Login to VRM "Wizard" Test
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Open Upper Bar Item "AMS"
    And UI Open "Forensics" Tab

  @SID_4
  Scenario: VRM - Add New Forensics Report criteria - Threat Category - Equals - HTTPS Flood
    When UI "Create" Forensics With Name "Threat Category HTTPS Flood"
      | Criteria | Event Criteria:Threat Category,Operator:Equals,Value:[HTTPS Flood]; |
    When UI Generate and Validate Forensics With Name "Threat Category HTTPS Flood" with Timeout of 300 Seconds
    And Sleep "30"
    Then UI Click Button "Views.report" with value "Threat Category HTTPS Flood"
    Then UI Validate "Report.Table" Table rows count EQUALS to 1
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName      | value       |
      | Threat Category | HTTPS Flood |
    Then UI Open "Reports" Tab
    Then UI Open "Forensics" Tab
  @SID_4
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |