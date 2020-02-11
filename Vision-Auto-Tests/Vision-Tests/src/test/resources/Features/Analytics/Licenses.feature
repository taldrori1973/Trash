@VRM @TC106016
@License_validation
Feature: ADC License Validation


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
    Given REST Vision Install License Request "vision-reporting-module-ADC"
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "Application Dashboard" page via homePage
    Then UI Navigate to "System and Network Dashboard" page via homePage
    Then UI Navigate to "ADC Reports" page via homePage
    Then UI Logout

  @SID_13
  Scenario: Logout
    * UI close browser

