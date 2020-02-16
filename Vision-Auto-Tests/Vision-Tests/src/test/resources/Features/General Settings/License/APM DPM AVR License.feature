@TC113488
Feature:APM DPM AVR License

  @SID_1
  Scenario: Validate APM License
    Given REST Vision DELETE License Request "vision-demo"
    And REST Vision DELETE License Request "vision-APM-reporter-server"
    And UI Login with user "radware" and password "radware"
    Then Validate Navigation to "APM" is disabled
    Then Validate License "APM_LICENSE" Parameters
      | valid | false |
    And REST Vision Install License Request "vision-APM-reporter-server"

  @SID_2
  Scenario: Validate DPM License
    Given REST Vision DELETE License Request "vision-perfreporter"
    Then Validate Navigation to "DPM" is disabled
    Then Validate License "DPM_LICENSE" Parameters
      | valid | false |
    And REST Vision Install License Request "vision-perfreporter"

  @SID_3
  Scenario: Validate AVR License
    Given REST Vision DELETE License Request "vision-security-reporter"
    Then Validate Navigation to "AVR" is disabled
    Then Validate License "AVR_LICENSE" Parameters
      | valid | false |
    And REST Vision Install License Request "vision-security-reporter"

  @SID_4
  Scenario: LogOut
    Given UI Logout


