@TC108498
Feature: IPv6 RADIUS Access

  @SID_1
  Scenario: Login and navigate to RADIUS setting page
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Authentication Protocols->RADIUS Settings"

  @SID_2
  Scenario: IPv6 RADIUS setting - set Parameters
    Then UI Set Text Field "IP Address" To "200a::1001:1001:1001:1001" enter Key true
    Then UI Select "1812" from Vision dropdown "Port"
    Then UI Set Text Field "Shared Secret" To "radware" enter Key true
    Then UI Set Text field with id "gwt-debug-primarySharedSecret_DuplicatePasswordField" with "radware"
    When UI Do Operation "select" item "Secondary RADIUS"
    Then UI Set Text field with id "gwt-debug-secondaryRadiusIP_Widget" with "200a:0000:0000:0000:1001:1001:1001:1001"
    Then UI Select "1812" from Vision dropdown by Id "gwt-debug-secondaryRadiusAuthPort_Widget"
    Then UI Set Text field with id "gwt-debug-secondarySharedSecret_Widget" with "radware"
    Then UI Set Text field with id "gwt-debug-secondarySharedSecret_DuplicatePasswordField" with "radware"
    Then UI Click Button "Submit"
    When UI Do Operation "select" item "Shared Parameters"
    Then UI Select "CHAP" from Vision dropdown "Authentication Type"
    Then UI Click Button "Submit"
    Then UI Logout

  @SID_3
  Scenario: IPv6 Clear and Set address on G3
    Then CLI Operations - Run Radware Session command "net ip delete G3"
    Then CLI Operations - Run Radware Session command "y" timeout 20
    Given CLI Operations - Run Radware Session command "net ip set 200a:0000:0000:0000:1001:4001:bbbb:3333 64 G3"
    Then CLI Run remote linux Command "ifconfig > /tmp/ip.txt" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "ping6 -c 3 200a::1001:1001:1001:1001 >> /tmp/ip.txt" on "ROOT_SERVER_CLI"


  @SID_4
  Scenario: Setting Authentication mode to RADIUS
    When CLI Operations - Run Radware Session command "system user authentication-mode set RADIUS"

  @SID_5
  Scenario: RADIUS setting - Login and set back to IPv4
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Authentication Protocols->RADIUS Settings"
    Then UI Set Text Field "IP Address" To "172.17.178.20" enter Key true
    Then UI Click Button "Submit"
    Then UI logout and close browser

  @SID_6
  Scenario: Set Authentication mode to default TACACS
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    Given CLI Operations - Run Radware Session command "net ip delete G3"
    Then CLI Operations - Run Radware Session command "y" timeout 20
