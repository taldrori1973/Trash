@TC111691
Feature: CLI system java certificate-algorithm

  @SID_1
  Scenario: System Java menu
    When CLI Operations - Run Radware Session command "system java ?"
    Then CLI Operations - Verify that output contains regex "Java settings.*"
    Then CLI Operations - Verify that output contains regex "certificate-algorithm.*Java certificate algorithms settings.*"

  @SID_2
  Scenario: system java certificate-algorithm menu
    When CLI Operations - Run Radware Session command "system java certificate-algorithm ?"
    Then CLI Operations - Verify that output contains regex "Java certificate algorithms settings.*"
    Then CLI Operations - Verify that output contains regex "get.*Displays the tolerance level for certificate algorithms used by java.*"


  @SID_3
  Scenario: system java certificate-algorithm get menu
    When CLI Operations - Run Radware Session command "system java certificate-algorithm get ?"
    Then CLI Operations - Verify that output contains regex "tolerance level for certificate algorithms used by java.*"


  @SID_4
  Scenario: verify changes in java.security
    Then CLI Run linux Command "grep "^jdk.tls.disabledAlgorithms" /usr/lib/jvm/java-1.8.0/jre/lib/security/java.security|grep "MD5" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then CLI Run linux Command "grep "^jdk.certpath.disabledAlgorithms=" /usr/lib/jvm/java-1.8.0/jre/lib/security/java.security|grep "MD5" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"

  @SID_5
  Scenario: Verify services are running
    When CLI validate service "all" status is "up" and health is "healthy" retry for 600 seconds
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "APSolute Vision Reporter is running" in any line
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "AMQP service is running" in any line
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Configuration server is running" in any line
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Collector service is running" in any line
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "New Reporter service is running" in any line
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Alerts service is running" in any line
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Scheduler service is running" in any line
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Configuration Synchronization service is running" in any line
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Tor feed service is running" in any line
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Radware vDirect is running" in any line
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "VRM reporting engine is running" in any line
