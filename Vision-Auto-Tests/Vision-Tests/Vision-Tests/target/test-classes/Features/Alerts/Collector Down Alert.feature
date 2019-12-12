
@TC106972
Feature: Collector Down watchdog Alert

  @SID_1
  Scenario: Clear alert index and watchdog logs and reduce retries
    When CLI Run remote linux Command "sed -i 's/watchdog.collector.max.service.retries=[0-9]*/watchdog.collector.max.service.retries=1/g' /opt/radware/mgt-server/properties/watchdogs.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "echo $(date) " Cleared" > /opt/radware/storage/maintenance/logs/collector_watchdog.log" on "ROOT_SERVER_CLI"
    Then REST Delete ES index "alert"
    Then CLI Clear vision logs

  @SID_2
  Scenario: Stop collector service and Sleep
    Given CLI Run remote linux Command "pkill -f "Dcollector.properties.location=/opt/radware/mgt-server/third-party/tomcat/"" on "ROOT_SERVER_CLI"
    * Sleep "360"

  @SID_3
  Scenario: Verify collector down generating alert MODULE
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_60096: Collector service went down, analytics data cannot be collected"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "\"module\" : \"INSITE_GENERAL\""|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_4
  Scenario: Verify collector down generating alert SEVERITY
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_60096: Collector service went down, analytics data cannot be collected"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "\"severity\" : \"WARNING\""|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running."

  @SID_5
  Scenario: Verify watchdog is starting the collector and Alert triggered with recovery message MODULE
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_60097: Collector service has been recovered"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "\"module\" : \"INSITE_GENERAL\""|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_6
  Scenario: Verify Alert triggered with recovery message SEVERITY
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_60097: Collector service has been recovered"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "\"severity\" : \"INFO\""|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_7
  Scenario: Check logs and set watchdog retries to default
    # sleep in case next scenario needs the collector fully started
    When Sleep "300"
    Then CLI Run remote linux Command "sed -i 's/watchdog.collector.max.service.retries=[0-9]*/watchdog.collector.max.service.retries=12/g' /opt/radware/mgt-server/properties/watchdogs.properties" on "ROOT_SERVER_CLI"
    And CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |