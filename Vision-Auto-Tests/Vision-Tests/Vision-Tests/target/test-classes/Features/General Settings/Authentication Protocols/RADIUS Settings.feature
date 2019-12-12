@VisionSettings @TC106051

Feature: Authentication Protocols - RADIUS settings Functionality

  @SID_1
  Scenario: Navigate to RADIUS setting page
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "radware" and password "radware"
    Then UI Open "Configurations" Tab
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Authentication Protocols->RADIUS Settings"

  @SID_2
  Scenario: RADIUS setting - set Parameters
    Then UI Set Text Field "IP Address" To "172.17.178.20" enter Key true
    Then UI Select "1812" from Vision dropdown "Port"
    Then UI Set Text Field "Shared Secret" To "radware" enter Key true
    Then UI Set Text field with id "gwt-debug-primarySharedSecret_DuplicatePasswordField" with "radware"
    When UI Do Operation "select" item "Secondary RADIUS"
    Then UI Set Text field with id "gwt-debug-secondaryRadiusIP_Widget" with "172.17.178.20"
    Then UI Select "1812" from Vision dropdown by Id "gwt-debug-secondaryRadiusAuthPort_Widget"
    Then UI Set Text field with id "gwt-debug-secondarySharedSecret_Widget" with "radware"
    Then UI Set Text field with id "gwt-debug-secondarySharedSecret_DuplicatePasswordField" with "radware"
    Then UI Click Button "Submit"
    When UI Do Operation "select" item "Shared Parameters"
    Then UI Set Text Field "Timeout" To "7" enter Key true
    Then UI Set Text Field "Retries" To "3" enter Key true
    Then UI Select "CHAP" from Vision dropdown "Authentication Type"
    Then UI Click Button "Submit"

  @SID_3
  Scenario: RADIUS setting - validate Parameters
    Then REST get RadiusSettings Parameters "primaryRadiusIP"
    Then UI Validate Text field "IP Address" EQUALS ""
    Then REST get RadiusSettings Parameters "primaryRadiusAuthPort"
    Then UI Validate Text field "Port" EQUALS ""
    Then REST get RadiusSettings Parameters "primarySharedSecret"
    Then UI Validate Text field "Shared Secret" EQUALS ""
    Then UI Validate Text field by id "gwt-debug-primarySharedSecret_DuplicatePasswordField" EQUALS ""
    Then UI Click Web element with id "gwt-debug-RadiusAAGWConfig.secondaryRadius_Tab"
    Then REST get RadiusSettings Parameters "secondaryRadiusIP"
    Then UI Validate Text field by id "gwt-debug-secondaryRadiusIP_Widget" EQUALS ""
    Then REST get RadiusSettings Parameters "secondaryRadiusAuthPort"
    Then UI Validate Text field by id "gwt-debug-secondaryRadiusAuthPort_Widget-input" EQUALS ""
    Then REST get RadiusSettings Parameters "secondarySharedSecret"
    Then UI Validate Text field by id "gwt-debug-secondarySharedSecret_Widget" EQUALS ""
    Then UI Validate Text field by id "gwt-debug-secondarySharedSecret_DuplicatePasswordField" EQUALS ""

    When UI Do Operation "select" item "Shared Parameters"
    Then REST get RadiusSettings Parameters "timeout"
    Then UI Validate Text field "Timeout" EQUALS ""
    Then REST get RadiusSettings Parameters "retries"
    Then UI Validate Text field "Retries" EQUALS ""
    Then REST get RadiusSettings Parameters "radiusAuthenticatorType"
    Then UI validate DropDown textOption Selection "" by elementLabelId "Authentication Type" by deviceDriverType "VISION" findBy Type "BY_NAME"

  @SID_4
  Scenario: RADIUS setting - set and validate Authentication Mode
    Then UI Navigate to page "System->User Management->User Management Settings"
    Then UI Select "RADIUS" from Vision dropdown "Authentication Mode"
    Then UI Click Button "Submit"
    Then REST get UserManagement Settings "authenticationMode"
    Then UI validate DropDown textOption Selection "" by elementLabelId "Authentication Mode" by deviceDriverType "VISION" findBy Type "BY_NAME"
    Then UI Logout

  @SID_5
  Scenario: RADIUS settings - Login with RADIUS user
    Given UI Login with user "stas" and password "radware"
    Then UI Logout

  @SID_6
  Scenario: RADIUS settings - validate Radius functionality - negative Login
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Authentication Protocols->RADIUS Settings"
    Then UI Select "1645" from Vision dropdown "Port"
    When UI Do Operation "select" item "Secondary RADIUS"
    Then UI Select "1645" from Vision dropdown by Id "gwt-debug-secondaryRadiusAuthPort_Widget-input"
    Then UI Click Button "Submit"
    Then UI Logout
    Then UI Login with user "stas" and password "radware" negative

  @SID_7
  Scenario: RADIUS setting - set and validate Authentication Mode -  back to tacacs
    Then CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
#    Given UI Login with user "radware" and password "radware"
#    Then UI Go To Vision
#    Then UI Navigate to page "System->User Management->User Management Settings"
#    Then UI Select "Local" from Vision dropdown "Authentication Mode"
#    Then UI Click Button "Submit"
#    Then REST get UserManagement Settings "authenticationMode"
#    Then UI validate DropDown textOption Selection "Local" by elementLabelId "Authentication Mode" by deviceDriverType "VISION" findBy Type "BY_NAME"
#    Then UI Logout







