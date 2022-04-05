@TC109747
Feature: IPv6 TACACS+ Functionality

  @SID_1
  Scenario: Navigate to TACACS+ setting page
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Authentication Protocols->TACACS+ Settings"

  @SID_2
  Scenario: TACACS+ setting - set Parameters
    When UI Set Text Field "IP Address" To "200a:0000:0000:0000:172:17:164:52" enter Key true
    When UI Set Text Field "Shared Secret" To "radware" enter Key true
    When UI Set Text field with id "gwt-debug-primarySharedSecret_DuplicatePasswordField" with "radware"
    When UI Do Operation "select" item "Shared Parameters"
    When UI Set Text Field "Minimal Required Privilege Level" To "1" enter Key true
    When UI Set Text Field "Service Name" To "connection" enter Key true
    When UI Click Button "Submit"

    Then REST get TacacsSettings Parameters "primaryTacacsIP" Expected result "200a:0000:0000:0000:172:17:164:52"
    Then UI Validate Text field "IP Address" EQUALS "200a:0000:0000:0000:172:17:164:52"

  @SID_3
  Scenario: TACACS+ setting - set and validate Authentication Mode
    Then CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    Then UI Logout

  @SID_4
  Scenario: TACACS+ settings - Login with TACACS+ user
    Given UI Login with user "user_tac_v6" and password "radware"
    Then UI logout and close browser

  @SID_5
  Scenario: TACACS+ settings back to default
    Then REST Request "PUT" for "Vision Authentication->TACACS"
      | type | value                           |
      | body | primaryTacacsIP=172.17.167.166  |
      | body | primaryTacacsAuthPort=49        |
      | body | primarySharedSecret=radware     |
      | body | minimalRequiredPrivilegeLevel=0 |
      | body | serviceName=connection          |

  @SID_6
  Scenario: TACACS+ setting - set Authentication Mode LOCAL
    When CLI Operations - Run Radware Session command "system user authentication-mode set Local"

