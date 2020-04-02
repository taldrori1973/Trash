@VRM_Alerts
@TC108541
Feature: VRM Alerts Criteria HTTPS Flood
  @SID_1
  Scenario: Clean system data
    Then CLI kill all simulator attacks on current vision
    Then REST Delete ES index "rt-alert-def-vrm"
    Then REST Delete ES index "alert"
    Then REST Delete ES index "dp-*"
    Then CLI Clear vision logs
  @SID_2
  Scenario: VRM - Login to VRM "Alerts" tab
    Given UI Login with user "radware" and password "radware"
    And UI Open Upper Bar Item "AMS"
    And UI Open "Alerts" Tab

  @SID_3
  Scenario: Create Alerts Threat Category HTTPS Flood Any Time Schedule
    When UI "Create" Alerts With Name "Threat Category HTTPS Flood Any Time Schedule"
      | Basic Info | Description:Threat Category HTTPS Flood Any Time Schedule           |
      | Criteria   | Event Criteria:Threat Category,Operator:Equals,Value:[HTTPS Flood]; |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                                   |


  @SID_4
  Scenario: Create Alerts Threat Category HTTPS Flood Custom Schedule
    When UI "Create" Alerts With Name "Threat Category HTTPS Flood Custom Schedule"
      | Basic Info | Description:Threat Category HTTPS Flood Custom Schedule             |
      | Criteria   | Event Criteria:Threat Category,Operator:Equals,Value:[HTTPS Flood]; |
      | Schedule   | triggerThisRule:1,Within:10,selectTimeUnit:minutes,alertsPerHour:60 |

  @SID_5
  Scenario: Clear alert browser and Run DP simulator
    Then REST Delete ES index "alert"
    And CLI simulate 1 attacks of type "https_new2" on "DefensePro" 11
    And CLI simulate 1 attacks of type "https_new2_trap" on "DefensePro" 11 and wait 60 seconds
    Then UI Open "Forensics" Tab
    Then UI Open "Alerts" Tab

  @SID_6
  Scenario: VRM Validate Alert Threat Category HTTPS Flood Any Time Schedule
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Threat Category HTTPS Flood Any Time Schedule"
    Then UI Validate "Report.Table" Table rows count EQUALS to 2

  @SID_7
  Scenario: VRM Validate Alert Threat Category HTTPS Flood Custom Schedule
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Threat Category HTTPS Flood Custom Schedule"
    Then UI Validate "Report.Table" Table rows count EQUALS to 1

  @SID_8
  Scenario: VRM Validate Alert browser for HTTPS Flood Any Schedule
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Threat Category HTTPS Flood Any Time Schedule \nSeverity: MINOR \nDescription: Threat Category HTTPS Flood Any Time Schedule \nImpact: N/A \nRemedy: N/A \nDevice IP: 172.16.22.51 \nAttacks Count: 1 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b2\b"

  @SID_9
  Scenario: VRM Validate Alert browser HTTPS Flood Custom Schedule
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Threat Category HTTPS Flood Custom Schedule \nSeverity: MINOR \nDescription: Threat Category HTTPS Flood Custom Schedule \nImpact: N/A \nRemedy: N/A \nDevice IP: 172.16.22.51 \nAttacks Count: 2 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"
  @SID_11
  Scenario: Verify alert details table in modal popup for HTTPS Flood
    Then UI "Check" all the Toggle Alerts
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Threat Category HTTPS Flood Any Time Schedule"
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName        | value                   |
      | Severity          | MINOR                   |
      | Device Name       | DefensePro_172.16.22.51 |
      | Device IP Address | 172.16.22.51            |

    Then UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy index 0
    Then UI Validate Table record values by columns with elementLabel "Alert details" findBy index 0
      | columnName             | value                   |
      | Threat Category        | HTTPS Flood             |
      | Attack Name            | HTTPS_HTTP_HTTPS_HTTPSS |
      | Policy Name            | pol                     |
      | Source IP Address      | 111.111.111.111         |
      | Destination IP Address | 22.222.222.222          |
      | Destination Port       | 22222                   |
      | Direction              | Unknown                 |
      | Protocol               | IP                      |
    Then UI Click Button "Table Details OK" with value "OK"

  @SID_10
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
