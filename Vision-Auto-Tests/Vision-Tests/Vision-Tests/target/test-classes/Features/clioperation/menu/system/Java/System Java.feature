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
    Then CLI Operations - Verify that output contains regex "set.*Update the tolerance level for certificates algorithms used by java.*"

  @SID_3
  Scenario: system java certificate-algorithm get menu
    When CLI Operations - Run Radware Session command "system java certificate-algorithm get ?"
    Then CLI Operations - Verify that output contains regex "tolerance level for certificate algorithms used by java.*"

  @SID_4
  Scenario: system java certificate-algorithm set menu
    When CLI Operations - Run Radware Session command "system java certificate-algorithm set ?"
    Then CLI Operations - Verify that output contains regex "Usage: system java certificate-algorithm set  \[tolerant \| strict\].*"
    Then CLI Operations - Verify that output contains regex ".*Update the tolerance level for certificates algorithms used by java.*"
    Then CLI Operations - Verify that output contains regex ".*Options: \[tolerant \| strict\].*"
    Then CLI Operations - Verify that output contains regex ".*Use: 'tolerant' to allow certificates that include an MD5-based digital signature. Use 'strict' otherwise.*"

  @SID_5
  Scenario: system java certificate-algorithm set strict cancel
    Then CLI Run linux Command "no | /opt/radware/box/bin/system java certificate-algorithm set strict" on "ROOT_SERVER_CLI" and validate result CONTAINS "The settings will take effect after the next server restart" in any line
    Then CLI Run linux Command "no | /opt/radware/box/bin/system java certificate-algorithm set strict" on "ROOT_SERVER_CLI" and validate result CONTAINS "Do you want to restart the server now" in any line
    Then CLI Run linux Command "no | /opt/radware/box/bin/system java certificate-algorithm set strict" on "ROOT_SERVER_CLI" and validate result CONTAINS "Restarting server cancelled" in any line

  @SID_6
  Scenario: system java certificate-algorithm set strict
    Then CLI Operations - Run Root Session command "yes | /opt/radware/box/bin/system java certificate-algorithm set strict" timeout 360

  @SID_7
  Scenario: system java certificate-algorithm get
    When CLI Operations - Run Radware Session command "system java certificate-algorithm get"
    Then CLI Operations - Verify that output contains regex "Java tolerance level: strict.*"

  @SID_8
  Scenario: verify changes in java.security
    Then CLI Run linux Command "grep "^jdk.tls.disabledAlgorithms" /usr/lib/jvm/java-1.8.0/jre/lib/security/java.security" on "ROOT_SERVER_CLI" and validate result CONTAINS " MD5withRSA,"
    Then CLI Run linux Command "grep "^jdk.certpath.disabledAlgorithms=" /usr/lib/jvm/java-1.8.0/jre/lib/security/java.security" on "ROOT_SERVER_CLI" and validate result CONTAINS " MD5,"

  @SID_9
  Scenario: system java certificate-algorithm set tolerant
    Then CLI Operations - Run Root Session command "yes | /opt/radware/box/bin/system java certificate-algorithm set tolerant" timeout 360

  @SID_10
  Scenario: system java certificate-algorithm get
    When CLI Operations - Run Radware Session command "system java certificate-algorithm get"
    Then CLI Operations - Verify that output contains regex "Java tolerance level: tolerant.*"

  @SID_11
  Scenario: verify changes in java.security
    Then CLI Run linux Command "grep "^jdk.tls.disabledAlgorithms" /usr/lib/jvm/java-1.8.0/jre/lib/security/java.security|grep "MD5" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then CLI Run linux Command "grep "^jdk.certpath.disabledAlgorithms=" /usr/lib/jvm/java-1.8.0/jre/lib/security/java.security|grep "MD5" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"

  @SID_12
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
