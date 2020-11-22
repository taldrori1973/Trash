@TC108155
Feature: ActivationLicense_TimeBased
  @SID_1
  Scenario: validate the user can see his activation license base time in setting Manager license page
    * REST Vision Install License Request "vision-activation" from date "-4M" to date "+4M"
    Given UI Login with user "radware" and password "radware"
    When UI Go To Vision
    When UI Navigate to page "System->General Settings->License Management"
    Then UI validate Vision Table row by keyValue with elementLabel "VisionLicense" findBy columnName "Item" findBy KeyValue "APSolute Vision Activation License"
      | columnName      | value | isDate |
      | Expiration Date | +4M   | true   |
    And UI logout and close browser

  @SID_2
    Scenario: Verify that during the grace period of 30 days the user is be able to continue using Vision seamlessly
      * REST Vision Install License Request "vision-activation" from date "-4M" to date "+20d"
      Given UI Login with user "radware" and password "radware"
      Then UI Validate Popup Dialog Box, have value "The system is under a license violation:" with text Type "CAPTION"
      Then UI Click Button by id "gwt-uid-6"
      Then UI Click Button by id "gwt-debug-Dialog_Box_Confirm"
    Then UI Validate Text field by id "gwt-debug-Global_license_alert" CONTAINS "License expires in 21 days"

  @SID_3
  Scenario: Verify that during the grace period of 30 days the user is be able to continue using Vision seamlessly and go to forensics
    And UI Navigate to "AMS Forensics" page via homePage
    Given UI "Create" Forensics With Name "Wizard_test"
      | Output  | Action,Attack ID,Start Time,Threat Category,Radware ID,Device IP Address,Attack Name,Duration,Packets,Mbits,Policy Name,Risk |
    Then UI Validate Element Existence By Label "Views.Expand" if Exists "true" with value "Wizard_test"
    And UI logout and close browser

  @SID_4
    Scenario: When the grace period has expired -
      * REST Vision Install License Request vision-activation with expired date





