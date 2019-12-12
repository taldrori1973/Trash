@TC109956
Feature: IPv6 Proxy Functionality

  @SID_1
  Scenario: IPv6 Clear and Set address on G3
    Given CLI Operations - Run Radware Session command "net ip delete G3"
    Then CLI Operations - Run Radware Session command "y" timeout 20
    Given CLI Operations - Run Radware Session command "net ip set 200a:0000:0000:0000:1001:1001:4bbb:4343 64 G3"

  @SID_2
  Scenario: Login and navigate to Connectivity page
    * CLI Clear vision logs
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Connectivity"

  @SID_3
  Scenario: Set Proxy Server Parameters by IP address
    When UI Do Operation "select" item "Proxy Server Parameters"
    Then UI Set Checkbox "Enable Proxy Server" To "true"
    Then UI Set Text Field "IP Address" To "200a:0000:0000:0000:0172:0017:0172:0089"
    Then UI Set Text Field "Port" To "8080"
    Then UI Set Checkbox "Use Authentication" To "true"
    Then UI Set Text Field "Username" To "radware"
    Then UI Set Text Field "Password" To "radware"
    Then UI Set Text field with id "gwt-debug-proxyServerPass_DuplicatePasswordField" with "radware"
    Then UI Click Button "Submit"

  @SID_4
  Scenario: Validate successful access to MIS
    Then UI Click vision dashboards
    Then UI Click security control center
    Then UI Click Button by id "gwt-debug-SUS_Tab"
    * Sleep "10"
    Then UI Validate Text field by id "gwt-debug-lastrelease_Widget" CONTAINS "000"

  @SID_5
  Scenario: Disable proxy and Logout
    Then REST Request "PUT" for "Connectivity->Proxy Server Parameters"
      | type | value                        |
      | body | proxyServerAddress=          |
      | body | proxyServerPort=             |
      | body | enableProxyServer=false      |
      | body | useAuthForProxySrvComm=false |
      | body | proxyServerUser=             |
      | body | proxyServerPass=             |

    Given CLI Operations - Run Radware Session command "net ip delete G3"
    Then CLI Operations - Run Radware Session command "y" timeout 20
    Then UI logout and close browser
