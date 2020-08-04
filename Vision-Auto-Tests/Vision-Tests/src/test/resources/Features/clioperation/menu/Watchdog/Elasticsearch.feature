@TC112872
Feature: Elasticsearch watchdog

  @SID_1
  Scenario: make sure elasticsearch is running
    When CLI Run remote linux Command "service elasticsearch start" on "ROOT_SERVER_CLI" with timeOut 120

  @SID_2
  Scenario: kill elasticsearch pid exist
    When CLI Run remote linux Command "echo "cleared" $(date) > /opt/radware/storage/maintenance/logs/elasticsearch_watchdog.log" on "ROOT_SERVER_CLI" with timeOut 120
    When CLI Run remote linux Command "kill -14 $(service elasticsearch status |awk '{print substr($3,1)-1};')" on "ROOT_SERVER_CLI"

  @SID_3
  Scenario: verify watchdog starts elasticsearch
    Then CLI Run linux Command "service elasticsearch status|awk '{print$4,$5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "is running..." with timeOut 240

  @SID_4
  Scenario: verify watchdog logs
    Then CLI Run linux Command "grep -c "elastic health-check failed" /opt/radware/storage/maintenance/logs/elasticsearch_watchdog.log" on "ROOT_SERVER_CLI" and validate result GTE "1" with timeOut 240
    Then CLI Run linux Command "cat /opt/radware/storage/maintenance/logs/elasticsearch_watchdog.log |grep "elastic health-check failed"| wc -l" on "ROOT_SERVER_CLI" and validate result GTE "1" with timeOut 240
    Then CLI Run linux Command "grep -c "killing the process and restarting elasticsearch service" /opt/radware/storage/maintenance/logs/elasticsearch_watchdog.log" on "ROOT_SERVER_CLI" and validate result EQUALS "1" with timeOut 240

  @SID_5
  Scenario: kill elasticsearch subsys locked
    When CLI Run remote linux Command "service elasticsearch stop" on "ROOT_SERVER_CLI" with timeOut 20
    When CLI Run remote linux Command "touch /var/lock/subsys/elasticsearch" on "ROOT_SERVER_CLI"

  @SID_6
  Scenario: verify watchdog starts elasticsearch
    Then CLI Run linux Command "service elasticsearch status|awk '{print$4,$5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "is running..." with timeOut 240
