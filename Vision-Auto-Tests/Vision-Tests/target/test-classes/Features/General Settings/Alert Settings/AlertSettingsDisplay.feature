@VisionSettings @TC106045

Feature: Alert Settings - Display Functionality

  @SID_1
  Scenario: Navigate to Alert Browser page
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"

  @SID_2
  Scenario: Display - set and validate Parameters
    Then UI Set Checkbox "Enable Detailed Auditing of APSolute Vision Activity" To "true"
    Then UI Set Checkbox "Enable Detailed APSolute Vision Auditing of Device Configuration Changes" To "true"
    When UI Do Operation "select" item "Display"
    Then UI Set Text Field "Refresh Interval" To "16"
    Then UI Click Button "Submit"
    Then UI Validate Text field "Refresh Interval" EQUALS "16"

  @SID_3
  Scenario: Delete devices and Logout
    Then UI Logout
