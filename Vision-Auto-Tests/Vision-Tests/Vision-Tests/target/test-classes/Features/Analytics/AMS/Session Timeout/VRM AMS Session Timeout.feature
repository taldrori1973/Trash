@DP_Analytics @TC106015

Feature: VRM AMS Session Timeout

  @SID_1
  Scenario: Navigate to Vision Connectivity and set values
    * REST Delete ES index "dp-*"
    Then REST Delete ES document with data ""module": "DEVICE_HEALTH_ERRORS"" from index "alert"
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Connectivity"
    When UI Do Operation "select" item "Inactivity Timeouts"
    Then UI Set Text Field "Inactivity Timeout for Configuration and Monitoring Perspectives" To "1"
    Then UI Set Text Field "Inactivity Timeout for Security Monitoring Perspective, APM, and DPM" To "1440"
    Then UI Click Button "Submit"
    Then UI Logout

  @SID_2
  Scenario: VRM - Login to VRM "Alerts" tab
    Given UI Login with user "sys_admin" and password "radware"
    And UI Open Upper Bar Item "AMS"
    And UI Open "Alerts" Tab

  @SID_3
  Scenario: Sleep to let configuration timeout expire
    * Sleep "120"

  @SID_4
  Scenario: VRM validate AMS Alerts availability while configuration session expired
    Then UI "Create" Alerts With Name "Alert_timeout"
      | Criteria | Event Criteria:Attack ID,Operator:Equals,Value:7839-3402580209; |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                             |
  #generate attack to trigger the alert rule
    Then CLI simulate 1 attacks of type "VRM_Alert_Severity" on "DefensePro" 10 and wait 110 seconds
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_timeout"
    Then UI Validate "Report.Table" Table rows count equal to 1
    Then UI "Uncheck" Toggle Alerts with name "Alert_timeout"
    Then UI Validate "Report.Table" Table rows count equal to 0
    Then UI Delete Alerts With Name "Alert_timeout"

  @SID_5
  Scenario: VRM validate AMS Reports availability while configuration session expired
    Then UI Open "Reports" Tab
    Then UI "Create" Report With Name "report_timeout"
      | reportType | DefensePro Analytics Dashboard |
    Then UI Validate VRM Report Existence by Name "report_timeout" if Exists "true"
    Then UI Generate and Validate Report With Name "report_timeout" with Timeout of 300 Seconds
    Then UI Click Button "Log Preview" with value "report_timeout"

  @SID_6
  Scenario: VRM validate AMS Forensics availability while configuration session expired
    Then UI Open "Forensics" Tab
    Then UI "Create" Forensics With Name "Forensics_timeout"
      |  |  |
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab
    When UI Click Button "Views.Expand" with value "Forensics_timeout"
    And UI Click Button "Views.Generate Now" with value "Forensics_timeout"
    And UI Click Button "Views.report" with value "Forensics_timeout"

  @SID_7
  Scenario: VRM validate AMS Dashboard availability while configuration session expired
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab
    Then CLI simulate 1 attacks of type "DP_single_Oper_oos" on "DefensePro" 10 and wait 30 seconds
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Text of "Health Error Count" equal to "1 Errors"
    Then UI Validate Element Existence By Label "Health.Warning" if Exists "true"
    Then UI Click Button "Health Error Count" with value "1 Errors"
    Then UI Validate "Alerts Table" Table rows count equal to 1
    Then UI Click Button "Close Alert Table" with value "Close"
    Then UI Open "Configurations" Tab
    Then UI close browser

  @SID_8
  Scenario: Navigate to Vision Connectivity and set values
#    Given UI Login with user "sys_admin" and password "radware"
#    Then UI Go To Vision
#    Then UI Navigate to page "System->General Settings->Connectivity"
#    When UI Do Operation "select" item "Inactivity Timeouts"
#    Then UI Set Text Field "Inactivity Timeout for Configuration and Monitoring Perspectives" To "1"
#    Then UI Set Text Field "Inactivity Timeout for Security Monitoring Perspective, APM, and DPM" To "2"
#    Then UI Click Button "Submit"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type                 | value                                |
      | body                 | sessionInactivTimeoutConfiguration=1 |
      | body                 | sessionInactivTimeoutMonitoring=2    |
      | Returned status code | 200                                  |
#    Then UI Logout

  @SID_9
  Scenario: VRM - Login to VRM "Alerts" tab
    Given UI Login with user "sys_admin" and password "radware"
    And UI Open Upper Bar Item "AMS"
    And UI Open "Alerts" Tab

  @SID_10
  Scenario: Sleep to let monitoring timeout expire
    * Sleep "180"

  @SID_11
  Scenario: VRM validate AMS Unavailability while monitoring session expired
    And UI Open "Reports" Tab negative
    And UI Open "Forensics" Tab negative
    Then UI logout and close browser

  @SID_12
  Scenario: Cleanup and revert values
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Connectivity"
    Then UI Do Operation "select" item "Inactivity Timeouts"
    Then UI Set Text Field "Inactivity Timeout for Configuration and Monitoring Perspectives" To "60"
    Then UI Set Text Field "Inactivity Timeout for Security Monitoring Perspective, APM, and DPM" To "1440"
    Then UI Click Button "Submit"
    Then UI Logout
