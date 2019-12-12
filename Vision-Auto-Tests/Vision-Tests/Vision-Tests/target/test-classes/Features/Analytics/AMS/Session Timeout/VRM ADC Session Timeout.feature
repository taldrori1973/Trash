@DP_Analytics @TC106014

Feature: VRM ADC Session Timeout

  @SID_1
  Scenario: Navigate to Connectivity and set values
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Connectivity"
    Then UI Do Operation "select" item "Inactivity Timeouts"
    Then UI Set Text Field "Inactivity Timeout for Configuration and Monitoring Perspectives" To "1"
    Then UI Set Text Field "Inactivity Timeout for Security Monitoring Perspective, APM, and DPM" To "1440"
    Then UI Click Button "Submit"
    Then UI logout and close browser

  @SID_2
  Scenario: VRM - Login to ADC "Reports" tab
    Then REST Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    Given UI Login with user "sys_admin" and password "radware"
    And UI Open Upper Bar Item "ADC"
    And UI Open "Reports" Tab

  @SID_3
  Scenario: Sleep to let configuration timeout expire
    * Sleep "130"

  @SID_4
  Scenario: VRM validate ADC Reports availability while configuration session expired
    Given UI "Create" DPMReport With Name "ADC Timeout report"
      | reportType | Application Report         |
      | devices    | virts:[Rejith_32326515:80] |
    Then UI Generate and Validate Report With Name "ADC Timeout report" with Timeout of 240 Seconds
    Then UI Click Button "Log Preview" with value "ADC Timeout report"

  @SID_5
  Scenario: VRM validate ADC dashboard availability while configuration session expired
    Then UI Open "Dashboards" Tab
    Then UI Open "Application Dashboard" Sub Tab
    Then UI Do Operation "Select" item "Application Selection"
    Then UI Select scope from dashboard and Save Filter device type "Alteon"
      | Rejith_32326515:80 |
    Then UI Validate Pie Chart data "VIRTUAL SERVICES"
      | label    | data |
      | Shutdown | 1    |
    Then UI Open "Configurations" Tab
#    Then UI logout and close browser

  @SID_6
  Scenario: Navigate to Vision Connectivity and set values
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Connectivity"
    When UI Do Operation "select" item "Inactivity Timeouts"
    Then UI Set Text Field "Inactivity Timeout for Configuration and Monitoring Perspectives" To "1"
    Then UI Set Text Field "Inactivity Timeout for Security Monitoring Perspective, APM, and DPM" To "2"
    Then UI Click Button "Submit"
    Then UI Logout

  @SID_7
  Scenario: VRM - Login to ADC "Dashboard" tab
    Given UI Login with user "sys_admin" and password "radware"
    And UI Open Upper Bar Item "ADC"
    And UI Open "Dashboards" Tab

  @SID_8
  Scenario: Sleep to let configuration timeout expire
    * Sleep "180"

  @SID_9
  Scenario: VRM validate ADC inavailability while monitoring session expired
    Then UI Open "Reports" Tab negative
    Then UI Open "Dashboards" Tab negative
    Then UI Open "Configurations" Tab
    Then UI logout and close browser

  @SID_10
  Scenario: Cleanup and revert values
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Connectivity"
    When UI Do Operation "select" item "Inactivity Timeouts"
    Then UI Set Text Field "Inactivity Timeout for Configuration and Monitoring Perspectives" To "60"
    Then UI Set Text Field "Inactivity Timeout for Security Monitoring Perspective, APM, and DPM" To "1440"
    Then UI Click Button "Submit"
    Then UI Logout
