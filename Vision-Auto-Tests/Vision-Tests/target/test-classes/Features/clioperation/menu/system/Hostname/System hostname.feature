@TC111675
Feature: CLI System Hostname

  @SID_1
  Scenario: System hostname set cancel
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Then Sleep "5"
    Then REST Login with activation with user "radware" and password "radware"
    When CLI Operations - Run Radware Session command "system hostname set myserver.auto"
    When CLI Operations - Run Radware Session command "n"
    Then CLI Operations - Verify that output contains regex "Updating the hostname cancelled."

  @SID_2
  Scenario: system hostname set myserver.local
    When CLI Operations - Run Radware Session command "system hostname set myserver.auto"
    When CLI Operations - Run Radware Session command "y" timeout 120
    When CLI Operations - Run Radware Session command "n" timeout 720

  @SID_3
  Scenario: Validate IPv6 Hostname in /etc/hosts
    Then CLI Run remote linux Command "cat /etc/hosts" on "ROOT_SERVER_CLI"
    Then CLI Run linux Command "if [ "$(hostname | cut -d'.' -f 1)" == "$(grep "::1" /etc/hosts|head -1|awk '{print$6}')" ]; then echo "hostname ok"; else echo "hostname not ok"; fi" on "ROOT_SERVER_CLI" and validate result EQUALS "hostname ok"
    Then CLI Run linux Command "grep "::1" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_4
  Scenario: Validate IPv4 Hostname in /etc/hosts
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep "$(hostname | cut -d'.' -f 1)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_5
  Scenario: system hostname get
    When CLI Operations - Run Radware Session command "system hostname get"
    Then CLI Operations - Verify that output contains regex "myserver.auto"

  @SID_6
  Scenario: Verify services are running
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "APSolute Vision Reporter is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "AMQP service is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Configuration server is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Collector service is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "New Reporter service is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Alerts service is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Scheduler service is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Configuration Synchronization service is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Tor feed service is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Radware vDirect is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "VRM reporting engine is running" in any line with timeOut 15


