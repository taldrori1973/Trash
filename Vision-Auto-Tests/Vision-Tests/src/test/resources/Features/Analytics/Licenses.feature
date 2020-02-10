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




  @SID_13
  Scenario: Logout
    * UI logout and close browser

