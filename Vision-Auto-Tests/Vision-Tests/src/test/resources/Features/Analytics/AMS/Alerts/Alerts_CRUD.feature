@VRM_Alerts
@TC105982

Feature: VRM Alerts CRUD

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "rt-alert-def-vrm"
    * REST Delete ES index "alert"
    * REST Delete ES index "dp-attack*"
    * CLI Clear vision logs

  @SID_2
  Scenario: VRM - Login to VRM "Alerts" tab
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "AMS Alerts" page via homePage

  @SID_3
  Scenario: Create Alert basic
    When UI "Create" Alerts With Name "Alert_Src_Port"
      | Basic Info | Description:Src Port,Impact:some impact,Remedy: who knows,Severity:Info   |
      | devices    | [DefensePro_172.16.22.50]                                                 |
      | Criteria   | Event Criteria:Source Port,Operator:Equals,portType:Port,portValue:1024;  |
      | Schedule   | triggerThisRule:2,Within:4,selectTimeUnit:days,alertsPerHour:60           |

    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "true" with value "Alert_Src_Port"

  @SID_4
  Scenario: Edit Alert fields
    When UI "Edit" Alerts With Name "Alert_Src_Port"
      | Basic Info | Description:Src Port modified,Impact:Another impact,Remedy: I know,Severity:Warning                                                 |
      | devices    | [DefensePro_172.16.22.50]                                                                                                           |
      | Criteria   | Event Criteria:Source Port,Operator:Not Equals,portType:Port,portValue:1024; |
      | Schedule   | checkBox:Trigger,alertsPerHour:1                                                                                                    |

  @SID_5
  Scenario: Create Alert To_be_Disabled
    When UI "Create" Alerts With Name "To_be_Disabled"
      | Basic Info | Description:To_be_Disabled,Impact:some impact,Remedy: I know,Severity:Warning |
      | devices    | [All]                                                   |
      | Criteria   | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:600,Unit:M; |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                       |
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "true" with value "To_be_Disabled"

  @SID_6
  Scenario: Disable Alert
    Then UI Set Checkbox "SwitchOff" with extension "To_be_Disabled" To "true"

  @SID_7
  Scenario: generate attack to trigger alert
    Given CLI simulate 1 attacks of type "VRM_Alert_Severity" on SetId "DefensePro_Set_1" and wait 90 seconds

  @SID_8
  Scenario: validate results for edit Alert fields
    And UI Navigate to "AMS Reports" page via homePage
    And UI Navigate to "AMS Alerts" page via homePage
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Src_Port"
    Then UI Validate "Report.Table" Table rows count EQUALS to 1
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName | value   |
      | Severity   | WARNING |

  @SID_9
  Scenario: validate Alert details table
    Then UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy index 0
    Then UI Validate "Alert details" Table rows count EQUALS to 5
    Then UI Validate Table record values by columns with elementLabel "Alert details" findBy columnName "Threat Category" findBy cellValue "DNS Flood"
      | columnName       | value                |
      | Attack Name      | DNS flood IPv4 DNS-B |
      | Policy Name      | 1                    |
      | Destination Port | 53                   |
    Then UI Validate Table record values by columns with elementLabel "Alert details" findBy columnName "Threat Category" findBy cellValue "SYN Flood"
      | columnName       | value          |
      | Attack Name      | Syn Flood HTTP |
      | Policy Name      | policy1        |
      | Destination Port | 80             |

    Then UI Click Button "Table Details Close"

  @SID_10
  Scenario: Validate Disabled Alert not triggered
    Then UI "Check" all the Toggle Alerts
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "To_be_Disabled"
    Then UI Validate "Report.Table" Table rows count EQUALS to 0

  @SID_11
  Scenario: validate Delete Alert
    When UI Delete Alerts With Name "Alert_Src_Port"
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "false" with value "Alert_Src_Port"

  @SID_12
  Scenario: Create Alerts Criteria Max pps
    When UI "Create" Alerts With Name "Max pps greater than K"
      | devices  | [All]                                                                  |
      | Criteria | Event Criteria:Max pps,Operator:Greater than,RateValue:300,Unit:K;     |
      | Schedule | triggerThisRule:13,Within:10,selectTimeUnit:minutes,alertsPerHour:60   |
    Then UI "Validate" Alerts With Name "Max pps greater than K"
      | devices  | [All]                                                                  |
      | Criteria | Event Criteria:Max pps,Operator:Greater than,RateValue:300,Unit:K;     |
      | Schedule | triggerThisRule:13,Within:10,selectTimeUnit:minutes,alertsPerHour:60   |

  @SID_13
  Scenario: Edit Alerts Value Max pps
    When UI "Edit" Alerts With Name "Max pps greater than K"
      | devices  | [All]                                                                         |
      | Criteria | Event Criteria:Max pps,Operator:Greater than,RateValue:600,Unit:M;            |
      | Schedule | triggerThisRule:13,Within:10,selectTimeUnit:minutes,alertsPerHour:60          |
    Then UI "Validate" Alerts With Name "Max pps greater than K"
      | devices  | [All]                                                                         |
      | Criteria | Event Criteria:Max pps,Operator:Greater than,RateValue:600,Unit:M;            |
      | Schedule | triggerThisRule:13,Within:10,selectTimeUnit:minutes,alertsPerHour:60          |

  @SID_14
  Scenario: Edit Alerts Criteria Max pps
    When UI "Edit" Alerts With Name "Max pps greater than K"
      | devices  | [All]                                                                         |
      | Criteria | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:300,Unit:K; |
      | Schedule | triggerThisRule:13,Within:10,selectTimeUnit:minutes,alertsPerHour:60          |
    Then UI "Validate" Alerts With Name "Max pps greater than K"
      | devices  | [All]                                                                         |
      | Criteria | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:300,Unit:K; |
      | Schedule | triggerThisRule:13,Within:10,selectTimeUnit:minutes,alertsPerHour:60          |
    Then UI Delete Alerts With Name "Max pps greater than K"

      @SID_15
  Scenario: Cleanup
    And UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |