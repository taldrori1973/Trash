@CLI_Positive @TC106023

Feature: Net Nat CLI Tests

  @SID_1
  Scenario: net Sub Menu
    Given CLI net Sub Menu

  @SID_2
  Scenario: Net Nat Get IP
    When CLI Net Nat Get IP

  @SID_3
  Scenario: Net Nat Get None
    And CLI Net Nat Get None

  @SID_4
  Scenario: Net Nat Get HostName
    And CLI Net Nat Get HostName

  @SID_5
  Scenario: Net Nat Sub Menu
    And CLI Net Nat Sub Menu

  @SID_6
  Scenario: Net Nat Set Sub Menu
    And CLI Net Nat Set Sub Menu

  @SID_7
  Scenario: Net Nat Set HostName
#    And CLI Net Nat Set IP
#    Then CLI Net Nat Set Host Name
    When CLI Operations - Run Radware Session command "net nat set hostname myhostnat"
    When CLI Operations - Run Radware Session command "y" timeout 360

    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "APSolute Vision Reporter is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "AMQP service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Configuration server is running" in any line Retry 900 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Collector service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "New Reporter service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Alerts service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Scheduler service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Configuration Synchronization service is running" in any line Retry 900 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Tor feed service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Radware vDirect is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "VRM reporting engine is running" in any line Retry 600 seconds


  @SID_8
  Scenario: Validate IPv6 Hostname in /etc/hosts
    Then CLI Run linux Command "if [ "$(hostname | cut -d'.' -f 1)" == "$(grep "::1" /etc/hosts|head -1|awk '{print$6}')" ]; then echo "hostname ok"; else echo "hostname not ok"; fi" on "ROOT_SERVER_CLI" and validate result EQUALS "hostname ok"
    Then CLI Run linux Command "grep "::1" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_9
  Scenario: Validate IPv4 Hostname in /etc/hosts
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep "$(hostname | cut -d'.' -f 1)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run remote linux Command "cat /etc/hosts" on "ROOT_SERVER_CLI"

  @SID_10
  Scenario: Net Nat Set none
    When CLI Operations - Run Radware Session command "net nat set none"
    When CLI Operations - Run Radware Session command "y" timeout 360

  @SID_11
  Scenario: Verify services are running
    Then CLI Connect Root
    Then CLI Run remote linux Command "service mgtsrv restart" on "ROOT_SERVER_CLI" with timeOut 360
    # ToDo remove after services bug fix
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "APSolute Vision Reporter is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "AMQP service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Configuration server is running" in any line Retry 900 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Collector service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "New Reporter service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Alerts service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Scheduler service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Configuration Synchronization service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Tor feed service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Radware vDirect is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "VRM reporting engine is running" in any line Retry 600 seconds
