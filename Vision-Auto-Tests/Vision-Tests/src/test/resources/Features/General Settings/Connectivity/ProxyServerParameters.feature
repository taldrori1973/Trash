@VisionSettings @TC106057
Feature: Connectivity Proxy Server Parameters Functionality

  @SID_1
  Scenario: Login and navigate to Connectivity page
    * CLI Clear vision logs
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Connectivity"

  @SID_2
  Scenario: copy script to validate value by REST
    * CLI copy "/home/radware/Scripts/generic_get_value.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"

  @SID_3
  Scenario: Set Proxy Server Parameters by IP address
    When UI Do Operation "select" item "Proxy Server Parameters"
    Then UI Set Checkbox "Enable Proxy Server" To "true"
    Then UI Set Text Field "IP Address" To "172.17.172.89"
    Then UI Set Text Field "Port" To "8080"
    Then UI Set Checkbox "Use Authentication" To "true"
    Then UI Set Text Field "Username" To "radware"
    Then UI Set Text Field "Password" To "radware"
    Then UI Set Text field with id "gwt-debug-proxyServerPass_DuplicatePasswordField" with "radware"
    Then UI Click Button "Submit"

  @SID_4
  Scenario: Proxy validate UI fields
    Then UI Click Button "toolbarRefresh"
    Then REST get Connectivity Parameters "proxyServerAddress"
    Then UI Validate Text field "IP Address" EQUALS ""
    Then REST get Connectivity Parameters "proxyServerPort"
    Then UI Validate Text field "Port" EQUALS ""
    Then REST get Connectivity Parameters "proxyServerUser"
    Then UI Validate Text field "Username" EQUALS ""
    Then REST get Connectivity Parameters "proxyServerPass"
    Then UI Validate Text field "Password" EQUALS ""
    Then UI Validate Text field by id "gwt-debug-proxyServerPass_DuplicatePasswordField" EQUALS ""

  @SID_5
  Scenario: Validate proxy by IP address - functionality
    When UI Go To Vision
    Then UI Click vision dashboards
    Then UI Click security control center
    Then Sleep "10"
    Then CLI Run linux Command "/generic_get_value.sh radware radware GET localhost /mgmt/monitor/scc/SUS \" 20" on "ROOT_SERVER_CLI" and validate result CONTAINS "00"
    Then CLI Run remote linux Command "/generic_get_value.sh radware radware GET localhost /mgmt/monitor/scc/SUS > /opt/radware/storage/out.txt " on "ROOT_SERVER_CLI"


  @SID_6
  Scenario: Set proxy by IP address - Negative wrong password
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Connectivity"
    Then UI Do Operation "select" item "Proxy Server Parameters"
    Then UI Set Checkbox "Enable Proxy Server" To "true"
    Then UI Set Text Field "IP Address" To "172.17.172.89"
    Then UI Set Text Field "Port" To "8080"
    Then UI Set Checkbox "Use Authentication" To "true"
    Then UI Set Text Field "Username" To "radware"
    Then UI Set Text Field "Password" To "1234"
    Then UI Set Text field with id "gwt-debug-proxyServerPass_DuplicatePasswordField" with "1234"
    Then UI Click Button "Submit"

  @SID_7
  Scenario: Validate proxy by IP address - Negative wrong password
    Then UI Click vision dashboards
    Then UI Click security control center
    * Sleep "10"
    Then CLI Run linux Command "/generic_get_value.sh radware radware GET localhost /mgmt/monitor/scc/SUS" on "ROOT_SERVER_CLI" and validate result EQUALS "{"status":"UNKNOWN"}"

    * CLI Check if logs contains
      | logType | expression                                                             | isExpected |
      | JBOSS   | you are not currently allowed to request https://services.radware.com/ | EXPECTED   |

  @SID_8
  Scenario: Validate proxy by IP address - proxy server logs

  @SID_9
  Scenario: modify local hosts file
    Then CLI Operations - Run Root Session command "sed -i '/myproxy.local/d' /etc/hosts"
    Then CLI Operations - Run Root Session command "echo "172.17.172.89 myproxy.local" >> /etc/hosts"

  @SID_10
  Scenario: Proxy Server Set Parameters by Name
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Connectivity"
    When UI Do Operation "select" item "Proxy Server Parameters"
    Then UI Set Checkbox "Enable Proxy Server" To "true"
    Then UI Set Text Field "IP Address" To "myproxy.local"
    Then UI Set Text Field "Port" To "8080"
    Then UI Set Checkbox "Use Authentication" To "true"
    Then UI Set Text Field "Username" To "radware"
    Then UI Set Text Field "Password" To "radware"
    Then UI Set Text field with id "gwt-debug-proxyServerPass_DuplicatePasswordField" with "radware"
    Then UI Click Button "Submit"

  @SID_11
  Scenario: Validate proxy by Name - functionality
    * CLI Clear vision logs
    When UI Go To Vision
    Then UI Click vision dashboards
    Then UI Click security control center
    Then Sleep "15"
    Then CLI Run linux Command "/generic_get_value.sh radware radware GET localhost /mgmt/monitor/scc/SUS \" 20" on "ROOT_SERVER_CLI" and validate result CONTAINS "00"

  @SID_12
  Scenario: Validate proxy by Name - proxy server and vision logs
  | logType | expression                                                             | isExpected |
  | JBOSS   | you are not currently allowed to request https://services.radware.com/ | false      |
  | ALL     | fatal                                                                  | false      |


  @SID_13
  Scenario: Logout
    Then UI logout and close browser
