@VRM_Alerts @TC105985

Feature: VRM Alerts Severity

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "rt-alert-def-vrm"
    * REST Delete ES index "alert"
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs

  @SID_2
  Scenario: VRM - Login to VRM Alerts Tab
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI clear All Alerts with TimeOut 5
    And UI Open Upper Bar Item "AMS"
    And UI Open "Alerts" Tab

  @SID_3
  Scenario: Create Alert Severities
    Then UI "Create" Alerts With Name "Alert Minor"
      | Basic Info | Description:,Impact:,Remedy:,Severity:Minor                      |
      | Criteria   | Event Criteria:Attack Name,Operator:Equals,Value:SYN Flood HTTP; |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                                |

    Then UI "Create" Alerts With Name "Alert Major"
      | Basic Info | Description:,Impact:,Remedy:,Severity:Major                      |
      | Criteria   | Event Criteria:Attack Name,Operator:Equals,Value:SYN Flood HTTP; |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                                |

    Then UI "Create" Alerts With Name "Alert Critical"
      | Basic Info | Description:,Impact:,Remedy:,Severity:Critical                   |
      | Criteria   | Event Criteria:Attack Name,Operator:Equals,Value:SYN Flood HTTP; |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                                |

    Then UI "Create" Alerts With Name "Alert Info"
      | Basic Info | Description:,Impact:,Remedy:,Severity:Info           |
      | Criteria   | Event Criteria:Action,Operator:Equals,Value:Forward; |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                    |

    Then UI "Create" Alerts With Name "Alert Warning"
      | Basic Info | Description:,Impact:,Remedy:,Severity:Warning        |
      | Criteria   | Event Criteria:Action,Operator:Equals,Value:Forward; |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                    |

  @SID_4
  Scenario: Run DP simulator VRM_Alert_Severity
    Given CLI simulate 1 attacks of type "VRM_Alert_Severity" on "DefensePro" 10 and wait 95 seconds

  @SID_5
  Scenario: refresh Alerts View
    And UI Open "Reports" Tab
    And UI Open "Alerts" Tab

  @SID_6
  Scenario: VRM Validate Severity Alert Minor
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert Minor"
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName | value |
      | Severity   | MINOR |

  @SID_7
  Scenario: VRM Validate Severity Alert Major
    When UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert Major"
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName | value |
      | Severity   | MAJOR |

  @SID_8
  Scenario: VRM Validate Severity Alert Critical
    When UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert Critical"
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName | value    |
      | Severity   | CRITICAL |

  @SID_9
  Scenario: VRM Validate Severity Alert info
    When UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert Info"
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName | value |
      | Severity   | INFO  |

  @SID_10
  Scenario: VRM Validate Severity Alert Warning
    When UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert Warning"
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName | value   |
      | Severity   | WARNING |

  @SID_11
  Scenario: go back to vision
    Then UI Open "Configurations" Tab

  @SID_12
  Scenario: VRM Validate Alert browser details severity Warning
    Then CLI Run linux Command "curl -XPOST -s -d'{"_source":{"includes":"userName"},"query":{"bool":{"must":[{"wildcard":{"message":"*Alert Name: Alert Warning*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search;echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "{"userName":"APSolute_Vision"}"
    Then CLI Run linux Command "curl -XPOST -s -d'{"_source":{"includes":"deviceType"},"query":{"bool":{"must":[{"wildcard":{"message":"*Alert Name: Alert Warning*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search;echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "{"deviceType":"DEFENSE_PRO"}"
    Then CLI Run linux Command "curl -XPOST -s -d'{"_source":{"includes":"module"},"query":{"bool":{"must":[{"wildcard":{"message":"*Alert Name: Alert Warning*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search;echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "{"module":"ANALYTICS_ALERTS"}"
    Then CLI Run linux Command "curl -XPOST -s -d'{"_source":{"includes":"severity"},"query":{"bool":{"must":[{"wildcard":{"message":"*Alert Name: Alert Warning*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search;echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "{"severity":"WARNING"}"

  @SID_13
  Scenario: VRM Validate Alert browser severity info
    Then CLI Run linux Command "curl -XPOST -s -d'{"_source":{"includes":"severity"},"query":{"bool":{"must":[{"wildcard":{"message":"*Alert Name: Alert Info*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search;echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "{"severity":"INFO"}"

  @SID_14
  Scenario: VRM Validate Alert browser severity Critical
    Then CLI Run linux Command "curl -XPOST -s -d'{"_source":{"includes":"severity"},"query":{"bool":{"must":[{"wildcard":{"message":"*Alert Name: Alert Major*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search;echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "{"severity":"MAJOR"}"

  @SID_15
  Scenario: VRM Validate Alert browser severity Major
   Then UI Validate Alert Property by other Property
     | columnNameBy | valueBy                 | columnNameExpected | valueExpected |
     | Message      | Alert Name: Alert Major | Severity           | Major         |

  @SID_16
  Scenario: VRM Validate Alert browser severity Minor
    Then CLI Run linux Command "curl -XPOST -s -d'{"_source":{"includes":"userName"},"query":{"bool":{"must":[{"wildcard":{"message":"*Alert Name: Alert Warning*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search;echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "{"userName":"APSolute_Vision"}"
    Then CLI Run linux Command "curl -XPOST -s -d'{"_source":{"includes":"deviceType"},"query":{"bool":{"must":[{"wildcard":{"message":"*Alert Name: Alert Warning*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search;echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "{"deviceType":"DEFENSE_PRO"}"
    Then CLI Run linux Command "curl -XPOST -s -d'{"_source":{"includes":"module"},"query":{"bool":{"must":[{"wildcard":{"message":"*Alert Name: Alert Warning*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search;echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "{"module":"ANALYTICS_ALERTS"}"
    Then CLI Run linux Command "curl -XPOST -s -d'{"_source":{"includes":"severity"},"query":{"bool":{"must":[{"wildcard":{"message":"*Alert Name: Alert Minor*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search;echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "{"severity":"MINOR"}"

  @SID_17
  Scenario: Cleanup
    And UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
