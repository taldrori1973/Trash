@CLI_Positive @TC106040

Feature: Vision Server Services CLI Tests

  @SID_1
  Scenario: system vision-server help
    Given REST Login with activation with user "radware" and password "radware"
    When REST Vision Install License Request "vision-perfreporter"
    Then Sleep "60"
    Given CLI Reset radware password
    Then REST Login with activation with user "radware" and password "radware"
    When CLI Operations - Run Radware Session help command "system vision-server ?"
    Then CLI Operations - Verify that output contains regex ".*Starts/stops the APSolute Vision server..*"
    Then CLI Operations - Verify that output contains regex ".*start.*Starts the APSolute Vision server..*"
    Then CLI Operations - Verify that output contains regex ".*status.*Shows the status of the APSolute Vision server..*"
    Then CLI Operations - Verify that output contains regex ".*stop.*Stops the APSolute Vision server..*"

  @SID_2
  Scenario: system vision-server start help
    When CLI Operations - Run Radware Session help command "system vision-server start ?"
    Then CLI Operations - Verify that output contains regex "Usage: system vision-server start.*"
    Then CLI Operations - Verify that output contains regex "Starts the APSolute Vision server..*"

  @SID_4
  Scenario: system vision-server status help
    When CLI Operations - Run Radware Session help command "system vision-server status ?"
    Then CLI Operations - Verify that output contains regex "Usage: system vision-server status.*"
    Then CLI Operations - Verify that output contains regex "Shows the status of the APSolute Vision server..*"

  @SID_5
  Scenario: system vision-server stop help
    When CLI Operations - Run Radware Session help command "system vision-server stop ?"
    Then CLI Operations - Verify that output contains regex "Usage: system vision-server stop.*"
    Then CLI Operations - Verify that output contains regex "Stops the APSolute Vision server..*"

  @SID_6
  Scenario: system vision-server stop
#    When CLI Operations - Run Radware Session command "system vision-server start" timeout 1000
    When CLI Operations - Run Radware Session command "system vision-server stop" timeout 1000
    Then CLI Operations - Verify that output contains regex "shutting down reporting module service.*"
    Then CLI Operations - Verify that output contains regex "Stopping APSolute Vision Collectors Server.*\[  OK  \].*"
    Then CLI Operations - Verify that output contains regex "Stopping APSolute Vision Application Server.*\[  OK  \].*"
    Then CLI Operations - Verify that output contains regex "Stopping Configuration Microservices Server.*\[  OK  \].*"
    Then CLI Operations - Verify that output contains regex "Stopping DPM.*\[  OK  \].*"
    Then CLI Operations - Verify that output contains regex "Stopping td-agent.*\[  OK  \].*"
    Then CLI Operations - Verify that output contains regex "Stopping Local License Server.*\[  OK  \].*"

  @SID_7
  Scenario: system vision-server status stopped
    Then CLI Run linux Command " system vision-server status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "APSolute Vision Reporter is stopped" in any line Wait For Prompt 100 seconds
    Then CLI Run linux Command " system vision-server status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "APSolute Vision AMQP Service is stopped" in any line Wait For Prompt 100 seconds
    Then CLI Run linux Command " system vision-server status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "DPM is stopped" in any line Wait For Prompt 100 seconds
    Then CLI Run linux Command " system vision-server status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "Configuration server is stopped" in any line Wait For Prompt 100 seconds
    Then CLI Run linux Command " system vision-server status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "Collector service is stopped" in any line Wait For Prompt 100 seconds
    Then CLI Run linux Command " system vision-server status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "New Reporter service is stopped" in any line Wait For Prompt 100 seconds
    Then CLI Run linux Command " system vision-server status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "Alerts service is stopped" in any line Wait For Prompt 100 seconds
    Then CLI Run linux Command " system vision-server status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "Scheduler service is stopped" in any line Wait For Prompt 100 seconds
    Then CLI Run linux Command " system vision-server status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "Configuration Synchronization service is stopped" in any line Wait For Prompt 100 seconds
    Then CLI Run linux Command " system vision-server status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "Tor feed service is stopped" in any line Wait For Prompt 100 seconds
    Then CLI Run linux Command " system vision-server status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "Radware vDirect is not running" in any line Wait For Prompt 100 seconds
    Then CLI Run linux Command " system vision-server status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "VRM SSL Inspection collector service is stopped" in any line Wait For Prompt 100 seconds
    Then CLI Run linux Command " system vision-server status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "VRM SSL Inspection visualization service is stopped" in any line Wait For Prompt 100 seconds
    Then CLI Run linux Command " system vision-server status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "VRM reporting engine is stopped" in any line Wait For Prompt 100 seconds
    Then CLI Run linux Command " system vision-server status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "td-agent is not running" in any line Wait For Prompt 100 seconds
    Then CLI Run linux Command " system vision-server status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "Local License Server is stopped" in any line Wait For Prompt 100 seconds


  @SID_8
  Scenario: system vision-server start
    When CLI Operations - Run Radware Session command "system vision-server start" timeout 1000
    Then CLI Operations - Verify that output contains regex "starting reporting engine service.*"
    Then CLI Operations - Verify that output contains regex "Starting Configuration Microservices Server.*\[  OK  \].*"
    Then CLI Operations - Verify that output contains regex "Starting APSolute Vision Application Server.*\[  OK  \].*"
    Then CLI Operations - Verify that output contains regex "Starting APSolute Vision Collectors Server.*\[  OK  \].*"
    Then CLI Operations - Verify that output contains regex "Starting DPM.*"
    Then CLI Operations - Verify that output contains regex "starting reporting engine service.*"
    # It takes time till all services are up
    And Sleep "10"

  @SID_9
  Scenario: system vision-server status started
    When CLI Operations - Run Radware Session command "system vision-server status" timeout 60
    Then CLI Operations - Verify that output contains regex "AMQP service is running..*"
    Then CLI Operations - Verify that output contains regex "Configuration server is running..*"
    Then CLI Operations - Verify that output contains regex "Collector service is running..*"
    Then CLI Operations - Verify that output contains regex "New Reporter service is running..*"
    Then CLI Operations - Verify that output contains regex "Alerts service is running..*"
    Then CLI Operations - Verify that output contains regex "Scheduler service is running..*"
    Then CLI Operations - Verify that output contains regex "Configuration Synchronization service is running..*"
    Then CLI Operations - Verify that output contains regex "Tor feed service is running..*"
    Then CLI Operations - Verify that output contains regex "Radware vDirect is running.*"
    Then CLI Operations - Verify that output contains regex "VRM SSL Inspection collector service is.*"
    Then CLI Operations - Verify that output contains regex "VRM SSL Inspection visualization service is.*"
    Then CLI Operations - Verify that output contains regex "VRM reporting engine is running..*"
    Then CLI wait to vision services up for 900 seconds