@VisionSettings @TC106054

Feature: Connectivity Event Notification Functionality

  @SID_1
  Scenario: Navigate to Connectivity page
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Connectivity"

  @SID_2
  Scenario: Event Notification
    When UI Do Operation "select" item "Event Notification"
    Then UI Set Checkbox "Remove All Other Targets of Device Events" To "true"
    Then UI validate Checkbox by label "Remove All Other Targets of Device Events" if Selected "true"
    Then UI Click Web element with id "gwt-debug-registerServerForEvents2_Widget"
    Then UI Click Web element with id "gwt-debug-Dialog_Box_OK"

    Then UI Logout
