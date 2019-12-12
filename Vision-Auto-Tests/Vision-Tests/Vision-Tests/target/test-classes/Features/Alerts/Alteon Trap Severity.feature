@TC108227
Feature: Alteon Trap Severity

  @SID_1
  Scenario: clear logs and alerts index
    Then CLI Clear vision logs
    Then CLI kill all simulator attacks on current vision
    Then REST Delete ES index "alert"

  @SID_2
  Scenario: send pcap with all types of severities
    When CLI simulate 1 attacks of type "ADC_severities" on "Alteon" 15 and wait 60 seconds

  @SID_3
  Scenario: validate Alteon trap severities
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: 0CR*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |grep "\"severity\":\"CRITICAL\"" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: 1CR*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |grep "\"severity\":\"CRITICAL\"" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: 2CR*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |grep "\"severity\":\"CRITICAL\"" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: 3MJ*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |grep "\"severity\":\"MAJOR\"" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: 4WR*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |grep "\"severity\":\"WARNING\"" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: 5IF*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |grep "\"severity\":\"INFO\"" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: 6IF*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |grep "\"severity\":\"INFO\"" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: 7IF*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |grep "\"severity\":\"INFO\"" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_4
  Scenario: validate Alteon trap module
    Then CLI Run linux Command "curl -XPOST -s -d'{"_source":{"includes":"module"},"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: 7IF*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search;echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "{"module":"DEVICE_GENERAL"}"

  @SID_5
  Scenario: validate Alteon trap product name
    Then CLI Run linux Command "curl -XPOST -s -d'{"_source":{"includes":"deviceType"},"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: 7IF*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search;echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "{"deviceType":"ALTEON"}"

  @SID_6
  Scenario: validate Alteon trap SID
    Then CLI Run linux Command "curl -XPOST -s -d'{"_source":{"includes":"trapSid"},"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: 7IF*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search;echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "{"trapSid":"1.3.6.1.4.1.1872.2.5.7.1000.0"}"

  @SID_7
  Scenario: check logs
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal        | NOT_EXPECTED |