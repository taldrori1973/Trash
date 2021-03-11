@VisionSettings @TC106061

Feature: Radware Cloud DDoS Protection

  @SID_1
  Scenario: Navigate to Radware Cloud DDoS Protection page
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Radware Cloud DDoS Protection Settings"

  @SID_2
  Scenario: set Radware Cloud DDoS Protection
    Then UI Set Text Field "Radware Cloud DDoS Protection URL" To "https://www.google.com"
    Then UI Click Button "Submit"
    Then UI Timeout in seconds "10"

  @SID_3
  Scenario: validate Radware Cloud DDoS Protection
    Then UI Open Upper Bar Item "Cloud DDoS Portal"
    Then UI validate Browser Tab Existence by URL "https://www.google.com"
    Then UI Logout
