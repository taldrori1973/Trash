@VisionSettings @TC106059

Feature: Display page Functionality

  @SID_1
  Scenario: Navigate to Display page
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Display"

  @SID_2
  Scenario: Display page - Parameters
    Then UI Select "Korean" from Vision dropdown "Default Display Language"
    Then UI Select "Operator Toolbox" from Vision dropdown "Default Landing Page"
    Then UI Select "dd/MM/yyyy" from Vision dropdown "Date Format"
    Then UI Select "h:mm:ss aa" from Vision dropdown "Time Format"
    Then UI Click Button "Submit"

  @SID_3
  Scenario: Navigate to UserManagement-LocalUsers page
    Then UI Go To Vision
    Then UI Navigate to page "System->User Management->Local Users"

  @SID_4
  Scenario: validate Display page - Parameters
    Then UI Click Web element with id "gwt-debug-User_NEW"
    Then UI validate DropDown textOption Existence "Korean" by elementLabelId "Language" by deviceDriverType "VISION" findBy Type "BY_NAME"
    Then UI Open Upper Bar Item "Refresh"
    Then UI Logout
    Then UI Login with user "radware" and password "radware"
    Then UI Validate Element Existence By GWT id "Toolbox" if Exists "true"
    Then UI Validate Text field by id "gwt-debug-Global_Date" CONTAINS "AM|PM"
    Then UI Click Web element with id "gwt-debug-userInfo"
    Then UI Validate Text field by id "gwt-debug-Global_PreviousLogin" CONTAINS "AM|PM"
    Then UI Validate Text field by id "gwt-debug-Global_PreviousLogin" CONTAINS "/"

    Then UI Logout
