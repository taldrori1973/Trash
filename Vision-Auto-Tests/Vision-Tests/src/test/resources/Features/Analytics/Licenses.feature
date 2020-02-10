@VRM @TC106016
@License_validation
Feature: ADC License Validation

  @SID_1
  Scenario: Login UI
    When UI Login with user "sys_admin" and password "radware"


  @SID_7
  Scenario: Remove ADC license and validate error message
    * REST Vision DELETE License Request "vision-reporting-module-ADC"
    When UI Login with user "sys_admin" and password "radware"





  @SID_10
  Scenario: Add ADC License and validate no error message
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    When UI Login with user "sys_admin" and password "radware"


  @SID_11
  Scenario: Add ADC license and validate no error message for Application Dashboard
    Given UI Open "Configurations" Tab
    When UI Open Upper Bar Item "ADC"
    And UI Open "Dashboards" Tab
    And UI Open "Application Dashboard" Sub Tab

  @SID_12
  Scenario: Add ADC license and validate no error message for Network and System Dashboard
    Given UI Open "Configurations" Tab
    When UI Open Upper Bar Item "ADC"
    And UI Open "Dashboards" Tab
    And UI Open "Network and System Dashboard" Sub Tab
    Given UI Open "Configurations" Tab

  @SID_13
  Scenario: Logout
    * UI logout and close browser

