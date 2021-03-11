@VisionSettings @TC106052

Feature: Authentication Protocols - TACACS+ settings Functionality

  @SID_1
  Scenario: Navigate to TACACS+ setting page
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Authentication Protocols->TACACS+ Settings"

  @SID_2
  Scenario: TACACS+ setting - set Parameters
    Then UI Set Text Field "IP Address" To "172.17.167.166" enter Key true
    Then UI Set Text Field "Shared Secret" To "radware" enter Key true
    Then UI Set Text field with id "gwt-debug-primarySharedSecret_DuplicatePasswordField" with "radware"
    Then UI Set Text field with id "gwt-debug-secondaryTacacsIP_Widget" with "172.17.167.165"
    Then UI Set Text field with id "gwt-debug-secondarySharedSecret_Widget" with "radware"
    Then UI Set Text field with id "gwt-debug-secondarySharedSecret_DuplicatePasswordField" with "radware"
    When UI Do Operation "select" item "Shared Parameters"
    Then UI Set Text Field "Minimal Required Privilege Level" To "1" enter Key true
    Then UI Set Text Field "Service Name" To "connection" enter Key true
    Then UI Click Button "Submit"

    Then REST get TacacsSettings Parameters "primaryTacacsIP" Expected result "172.17.167.166"
    Then UI Validate Text field "IP Address" EQUALS ""
    Then REST get TacacsSettings Parameters "primarySharedSecret"
    Then UI Validate Text field "Shared Secret" EQUALS ""
    Then REST get TacacsSettings Parameters "primarySharedSecret"
    Then UI Validate Text field by id "gwt-debug-primarySharedSecret_DuplicatePasswordField" EQUALS ""
    Then REST get TacacsSettings Parameters "minimalRequiredPrivilegeLevel"
    Then UI Validate Text field "Minimal Required Privilege Level" EQUALS ""
    Then REST get TacacsSettings Parameters "serviceName"
    Then UI Validate Text field "Service Name" EQUALS ""
    When UI Do Operation "select" item "Secondary TACACS+"
    Then REST get TacacsSettings Parameters "secondaryTacacsIP" Expected result "172.17.167.165"
    Then UI Validate Text field by id "gwt-debug-secondaryTacacsIP_Widget" EQUALS "172.17.167.165"
    Then REST get TacacsSettings Parameters "secondarySharedSecret"
    Then UI Validate Text field by id "gwt-debug-secondarySharedSecret_Widget" EQUALS ""
    Then REST get TacacsSettings Parameters "secondarySharedSecret"
    Then UI Validate Text field by id "gwt-debug-secondarySharedSecret_DuplicatePasswordField" EQUALS ""

  @SID_3
  Scenario: TACACS+ setting - set and validate Authentication Mode
    Then UI Navigate to page "System->User Management->Authentication Mode"
    Then UI Select "TACACS+" from Vision dropdown "Authentication Mode"
    Then UI Click Button "Submit"
    Then REST get UserManagement Settings "authenticationMode"
    Then UI validate DropDown textOption Selection "TACACS+" by elementLabelId "Authentication Mode" by deviceDriverType "VISION" findBy Type "BY_NAME"
    Then UI Logout

  @SID_4
  Scenario: TACACS+ settings - Login with TACACS+ user
    Given UI Login with user "user1" and password "radware"
    Then UI Logout

  @SID_5
  Scenario: TACACS+ settings - validate TACACS+ functionality - negative Login
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Authentication Protocols->TACACS+ Settings"
    Then UI Set Text Field "IP Address" To "172.17.166.166" enter Key true
    Then UI Set Text field with id "gwt-debug-secondaryTacacsIP_Widget" with "172.17.177.166"
    Then UI Click Button "Submit"
    Then UI Logout
    Then UI Login with user "user1" and password "radware" negative

  @SID_6
  Scenario: TACACS+ settings - validate TACACS+ functionality - negative Login
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Authentication Protocols->TACACS+ Settings"
    Then UI Set Text Field "IP Address" To "172.17.167.166" enter Key true
    Then UI Set Text field with id "gwt-debug-secondaryTacacsIP_Widget" with "172.17.167.166"
    Then UI Click Button "Submit"
    Then UI Logout

  @SID_7
  Scenario: TACACS+ setting - set and validate Authentication Mode -  back to tacacs
    Then CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
#    Given UI Login with user "radware" and password "radware"
#    Then UI Navigate to page "System->User Management->Authentication Mode"
#    Then UI Select "Local" from Vision dropdown "Authentication Mode"
#    Then UI Click Button "Submit"
#    Then REST get UserManagement Settings "authenticationMode"
#    Then UI validate DropDown textOption Selection "Local" by elementLabelId "Authentication Mode" by deviceDriverType "VISION" findBy Type "BY_NAME"
#    Then UI Logout

