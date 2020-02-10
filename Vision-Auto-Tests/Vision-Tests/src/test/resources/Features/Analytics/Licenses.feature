@VRM @TC106016
@License_validation
Feature: ADC License Validation

  @SID_1
  Scenario: Login UI
    When UI Login with user "sys_admin" and password "radware"


  @SID_7
  Scenario: Remove ADC license and validate error message
    Given REST Vision DELETE License Request "vision-reporting-module-ADC"
    Given UI Login with user "sys_admin" and password "radware"
    Then Validate Navigation to "Application Dashboard" is disabled
    Then Validate Navigation to "System and Network Dashboard" is disabled
    Then Validate Navigation to "ADC Reports" is disabled
    Then UI Logout



  @SID_10
  Scenario: Add ADC License and validate no error message
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    When UI Login with user "sys_admin" and password "radware"




  @SID_13
  Scenario: Logout
    * UI logout and close browser

