@VRM_Alerts @TC105984

Feature: VRM Alerts Schedule

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "rt-alert-def-vrm"
    * REST Delete ES index "alert"
    * REST Delete ES index "dp-attack-raw-*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator before configuring alerts
    Given CLI simulate 1 attacks of type "rest_anomalies" on "DefensePro" 10

  @SID_3
  Scenario: VRM - Login to VRM "Wizard" Test
    Given UI Login with user "sys_admin" and password "radware"

    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "AMS Alerts" page via homePage


  @SID_4
  Scenario: Create Alert schedule every minute
    When UI "Create" Alerts With Name "Alert_schedule_60_per_hr"
      | Criteria | Event Criteria:Attack ID,Operator:Not Equals,Value:1; |
      | Schedule | checkBox:Trigger,alertsPerHour:60                     |
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "true" with value "Alert_schedule_60_per_hr"

  @SID_5
  Scenario: Create Alert schedule once per hour
    When UI "Create" Alerts With Name "Alert_schedule_1_per_hr"
      | Criteria | Event Criteria:Attack ID,Operator:Not Equals,Value:1; |
      | Schedule | checkBox:Trigger,alertsPerHour:1                      |
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "true" with value "Alert_schedule_1_per_hr"

  @SID_6
  Scenario: Create Alert schedule 3 times in 3 minutes
    When UI "Create" Alerts With Name "Alert_schedule_3_times_3_min"
      | devices  | index:10,policies:[BDOS];                                          |
      | Criteria | Event Criteria:Attack ID,Operator:Not Equals,Value:1;              |
      | Schedule | triggerThisRule:2,Within:3,selectTimeUnit:minutes,alertsPerHour:60 |
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "true" with value "Alert_schedule_3_times_3_min"

  @SID_7
  Scenario: Create Alert schedule 5 times in 2 minutes
    When UI "Create" Alerts With Name "Alert_schedule_5_times_2_min"
      | devices  | index:10,policies:[BDOS];                                          |
      | Criteria | Event Criteria:Attack ID,Operator:Not Equals,Value:1;              |
      | Schedule | triggerThisRule:4,Within:3,selectTimeUnit:minutes,alertsPerHour:60 |
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "true" with value "Alert_schedule_5_times_2_min"

  @SID_8
  Scenario: Create Alert schedule 2 times in 2 hours
    When UI "Create" Alerts With Name "Alert_schedule_2_times_2_hrs"
      | Criteria | Event Criteria:Destination IP,Operator:Equals,IPType:IPv4,IPValue:1.1.1.1; |
      | Schedule | triggerThisRule:2,Within:120,selectTimeUnit:hours,alertsPerHour:60           |
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "true" with value "Alert_schedule_2_times_2_hrs"

  @SID_9
  Scenario: Create Alert schedule 9 times in 3 minutes
    When UI "Create" Alerts With Name "Alert_schedule_9_times_3_min"
      | Criteria | Event Criteria:Attack ID,Operator:Not Equals,Value:1;              |
      | Schedule | triggerThisRule:8,Within:3,selectTimeUnit:minutes,alertsPerHour:60 |
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "true" with value "Alert_schedule_9_times_3_min"

  @SID_10
  Scenario: Create Alert schedule ignore historical attacks
    When UI "Create" Alerts With Name "ignore historical attacks"
      | Criteria | Event Criteria:Threat Category,Operator:Equals,Value:Anomalies;  |
      | Schedule | checkBox:Trigger,alertsPerHour:60                                |
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "true" with value "ignore historical attacks"

  @SID_11
  Scenario: Create Alert schedule once per day
    When UI "Create" Alerts With Name "Alert_schedule_1_per_day"
      | Criteria | Event Criteria:Attack ID,Operator:Not Equals,Value:1;           |
      | Schedule | triggerThisRule:7,Within:120,selectTimeUnit:days,alertsPerHour:60 |
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "true" with value "Alert_schedule_1_per_day"

  Scenario: Clean system data
     * REST Delete ES index "alert"
    # workaround to delete the alert which are created for creating alerts ...


  @SID_12
  Scenario: Run DP simulator
    Given CLI simulate 1 attacks of type "VRM_Alerts_Schedule" on "DefensePro" 10 and wait 250 seconds

  @SID_13
  Scenario: Validate Alert schedule every minute
    When UI "Check" all the Toggle Alerts
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_schedule_60_per_hr"
    Then UI Validate "Report.Table" Table rows count EQUALS to 3

  @SID_14
  Scenario: Validate Alert schedule once per hour
    When UI "Check" all the Toggle Alerts
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_schedule_1_per_hr"
    #To cover running on next to an round hour (we can have two lines)
    Then UI Validate "Report.Table" Table rows count GTE to 1
    Then UI Validate "Report.Table" Table rows count LTE to 2

  @SID_15
  Scenario: Validate Alert schedule 3 times in 3 minutes
    When UI "Check" all the Toggle Alerts
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_schedule_3_times_3_min"
    Then UI Validate "Report.Table" Table rows count GTE to 1
    Then UI Validate "Report.Table" Table rows count LTE to 2

  @SID_16
  Scenario: Validate Alert schedule 5 times in 3 minutes
    When UI "Check" all the Toggle Alerts
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_schedule_5_times_2_min"
    Then UI Validate "Report.Table" Table rows count EQUALS to 1

  @SID_17
  Scenario: Validate Alert schedule 2 times in 2 hrs
    When UI "Check" all the Toggle Alerts
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_schedule_2_times_2_hrs"
    Then UI Validate "Report.Table" Table rows count EQUALS to 1


  @SID_18
  Scenario: Validate Alert schedule 9 times in 3 min
    When UI "Check" all the Toggle Alerts
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_schedule_9_times_3_min"
    Then UI Validate "Report.Table" Table rows count EQUALS to 0

  @SID_19
  Scenario: Validate Alert schedule ignore historical attacks
    When UI "Check" all the Toggle Alerts
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "ignore historical attacks"
    Then UI Validate "Report.Table" Table rows count EQUALS to 0

  @SID_20
  Scenario: Validate Alert schedule one per day
    When UI "Check" all the Toggle Alerts
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_schedule_1_per_day"
    Then UI Validate "Report.Table" Table rows count EQUALS to 1

  @SID_21
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
