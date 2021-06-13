@Functional @TC105960

Feature: Alert browser

  @SID_1
  Scenario: Add devices for Alerts
    Given CLI Reset radware password
    * REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |

  @SID_2
  Scenario Outline:Setup 1 - Add New Devices

    Then REST Add "Alteon" Device To topology Tree with Name "<Device Name>" and Management IP "<Device IP>" into site "<Site>"
      | attribute     | value |
      | visionMgtPort | G2    |
    Examples:
      | Device Name | Device IP | Site    |
      | Alt_1.1.1.1 | 1.1.1.1   | Default |
      | Alt_2.2.2.2 | 2.2.2.2   | Default |

  @SID_3
  Scenario: Acknowledge and unAcknowledge Alerts
    Given UI Login with user "radware" and password "radware"
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |              |
      | selectAllDevices   | true         |
      | raisedTimeUnit     | Hour/s       |
      | raisedTimeValue    | 24           |
      | severityList       |              |
      | modulesList        |              |
      | devicesTypeList    |              |
      | groupsList         |              |
      | ackUnackStatusList | Acknowledged |
      | restoreDefaults    | true         |

    Then UI validate Alerts Filter by KeyValue
      | devicesList        |                |
      | selectAllDevices   | true           |
      | raisedTimeUnit     | Hour/s         |
      | raisedTimeValue    | 24             |
      | severityList       |                |
      | modulesList        |                |
      | devicesTypeList    |                |
      | groupsList         |                |
      | ackUnackStatusList | Unacknowledged |
      | restoreDefaults    | true           |

  @SID_4
  Scenario: Device Type Alteon
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |        |
      | selectAllDevices   | true   |
      | raisedTimeUnit     | Hour/s |
      | raisedTimeValue    | 24     |
      | severityList       |        |
      | modulesList        |        |
      | devicesTypeList    | Alteon |
      | groupsList         |        |
      | ackUnackStatusList |        |
      | restoreDefaults    | true   |

  @SID_5
  Scenario: Device Type DefebsePro
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |            |
      | selectAllDevices   | true       |
      | raisedTimeUnit     | Hour/s     |
      | raisedTimeValue    | 24         |
      | severityList       |            |
      | modulesList        |            |
      | devicesTypeList    | DefensePro |
      | groupsList         |            |
      | ackUnackStatusList |            |
      | restoreDefaults    | true       |

  @SID_6
  Scenario: Device Type Vision
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |        |
      | selectAllDevices   | true   |
      | raisedTimeUnit     | Hour/s |
      | raisedTimeValue    | 24     |
      | severityList       |        |
      | modulesList        |        |
      | devicesTypeList    | Vision |
      | groupsList         |        |
      | ackUnackStatusList |        |
      | restoreDefaults    | true   |

  @SID_7
  Scenario: Default Devices Selection
    Then UI validate SelectAllDevices Filter

  @SID_8
  Scenario: Single Devices
    Then UI validate Alerts Filter by KeyValue
      | devicesList        | Alt_1.1.1.1    |
      | selectAllDevices   | false          |
      | raisedTimeUnit     | Hour/s         |
      | raisedTimeValue    | 24             |
      | severityList       |                |
      | modulesList        | Device General |
      | devicesTypeList    | Alteon         |
      | groupsList         |                |
      | ackUnackStatusList |                |
      | restoreDefaults    | true           |

    Then UI validate Alerts Filter by KeyValue
      | devicesList        | Alt_2.2.2.2    |
      | selectAllDevices   | false          |
      | raisedTimeUnit     | Hour/s         |
      | raisedTimeValue    | 24             |
      | severityList       |                |
      | modulesList        | Device General |
      | devicesTypeList    | Alteon         |
      | groupsList         |                |
      | ackUnackStatusList |                |
      | restoreDefaults    | true           |

  @SID_9
  Scenario: Filter General Filtering
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |                               |
      | selectAllDevices   | true                          |
      | raisedTimeUnit     | Hour/s                        |
      | raisedTimeValue    | 1                             |
      | severityList       | Major                         |
      | modulesList        | Device General,Vision General |
      | devicesTypeList    | DefensePro,Alteon             |
      | groupsList         |                               |
      | ackUnackStatusList | Unacknowledged                |
      | restoreDefaults    | true                          |

    Then UI validate Alerts Filter by KeyValue
      | devicesList        | Alt_1.1.1.1                                                                                          |
      | selectAllDevices   | false                                                                                                |
      | raisedTimeUnit     | Hour/s                                                                                               |
      | raisedTimeValue    | 24                                                                                                   |
      | severityList       | Major                                                                                                |
      | modulesList        | Vision Configuration,Vision General,Vision Control,Device General,Device Security,Security Reporting |
      | devicesTypeList    | DefensePro,Alteon                                                                                    |
      | groupsList         |                                                                                                      |
      | ackUnackStatusList | Unacknowledged                                                                                       |
      | restoreDefaults    | true                                                                                                 |

  @SID_10
  Scenario: Device General
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |                |
      | selectAllDevices   | true           |
      | raisedTimeUnit     | Hour/s         |
      | raisedTimeValue    | 24             |
      | severityList       | Major          |
      | modulesList        | Device General |
      | devicesTypeList    |                |
      | groupsList         |                |
      | ackUnackStatusList |                |
      | restoreDefaults    | true           |

  @SID_11
  Scenario: Device Security
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |                 |
      | selectAllDevices   | true            |
      | raisedTimeUnit     | Hour/s          |
      | raisedTimeValue    | 24              |
      | severityList       |                 |
      | modulesList        | Device Security |
      | devicesTypeList    |                 |
      | groupsList         |                 |
      | ackUnackStatusList |                 |
      | restoreDefaults    | true            |

  @SID_12
  Scenario: Security Reporting
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |                    |
      | selectAllDevices   | true               |
      | raisedTimeUnit     | Hour/s             |
      | raisedTimeValue    | 24                 |
      | severityList       |                    |
      | modulesList        | Security Reporting |
      | devicesTypeList    |                    |
      | groupsList         |                    |
      | ackUnackStatusList |                    |
      | restoreDefaults    | true               |
    Then UI Logout


#  @SID_13
#  Scenario: Uncheck Module
#    Then UI module Check Negative
#    Then UI Logout

  @SID_13
  Scenario: Vision Configuration
    When UI Login with user "radware" and password "radware"
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |                      |
      | selectAllDevices   | true                 |
      | raisedTimeUnit     | Hour/s               |
      | raisedTimeValue    | 24                   |
      | severityList       |                      |
      | modulesList        | Vision Configuration |
      | devicesTypeList    |                      |
      | groupsList         |                      |
      | ackUnackStatusList |                      |
      | restoreDefaults    | true                 |

  @SID_14
  Scenario: Vision Control
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |                |
      | selectAllDevices   | true           |
      | raisedTimeUnit     | Hour/s         |
      | raisedTimeValue    | 24             |
      | severityList       |                |
      | modulesList        | Vision Control |
      | devicesTypeList    |                |
      | groupsList         |                |
      | ackUnackStatusList |                |
      | restoreDefaults    | true           |

  @SID_15
  Scenario: Vision General
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |                |
      | selectAllDevices   | true           |
      | raisedTimeUnit     | Hour/s         |
      | raisedTimeValue    | 24             |
      | severityList       |                |
      | modulesList        | Vision General |
      | devicesTypeList    |                |
      | groupsList         |                |
      | ackUnackStatusList |                |
      | restoreDefaults    | true           |

#  @SID_16
#  Scenario: Raised Time
#    Then UI validate Alerts Filter by KeyValue
#      | devicesList        |        |
#      | selectAllDevices   | false  |
#      | raisedTimeUnit     | Hour/s |
#      | raisedTimeValue    | 1      |
#      | severityList       |        |
#      | modulesList        |        |
#      | devicesTypeList    |        |
#      | groupsList         |        |
#      | ackUnackStatusList |        |
#      | restoreDefaults    | true   |
#    Then UI validate RaisedTimeFilter with raisedTimeUnit "HOURS" with raisedTimeValue "1"

  @SID_16
  Scenario: Restore Defaults
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |        |
      | selectAllDevices   | true   |
      | raisedTimeUnit     | Hour/s |
      | raisedTimeValue    | 24     |
      | severityList       |        |
      | modulesList        |        |
      | devicesTypeList    |        |
      | groupsList         |        |
      | ackUnackStatusList |        |
      | restoreDefaults    | true   |
    Then UI Logout

  @SID_17
  Scenario: Critical Alerts
    When UI Login with user "radware" and password "radware"
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |          |
      | selectAllDevices   | true     |
      | raisedTimeUnit     | Hour/s   |
      | raisedTimeValue    | 24       |
      | severityList       | Critical |
      | modulesList        |          |
      | devicesTypeList    |          |
      | groupsList         |          |
      | ackUnackStatusList |          |
      | restoreDefaults    | False    |
    Then UI Logout

  @SID_18
  Scenario: Information Alerts
    When UI Login with user "radware" and password "radware"
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |             |
      | selectAllDevices   | true        |
      | raisedTimeUnit     | Minute/s    |
      | raisedTimeValue    | 60          |
      | severityList       | Information |
      | modulesList        |             |
      | devicesTypeList    |             |
      | groupsList         |             |
      | ackUnackStatusList |             |
      | restoreDefaults    | true        |

  @SID_19
  Scenario: Major Alerts
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |        |
      | selectAllDevices   | true   |
      | raisedTimeUnit     | Hour/s |
      | raisedTimeValue    | 24     |
      | severityList       | Major  |
      | modulesList        |        |
      | devicesTypeList    |        |
      | groupsList         |        |
      | ackUnackStatusList |        |
      | restoreDefaults    | true   |

  @SID_20
  Scenario: Minor Alerts
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |        |
      | selectAllDevices   | true   |
      | raisedTimeUnit     | Hour/s |
      | raisedTimeValue    | 24     |
      | severityList       | Minor  |
      | modulesList        |        |
      | devicesTypeList    |        |
      | groupsList         |        |
      | ackUnackStatusList |        |
      | restoreDefaults    | true   |

  @SID_21
  Scenario: Uncheck Severity
    Then UI Severity Check Negative

  @SID_22
  Scenario: Warning Alerts
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |         |
      | selectAllDevices   | true    |
      | raisedTimeUnit     | Hour/s  |
      | raisedTimeValue    | 1       |
      | severityList       | Warning |
      | modulesList        |         |
      | devicesTypeList    |         |
      | groupsList         |         |
      | ackUnackStatusList |         |
      | restoreDefaults    | true    |

  @SID_23
  Scenario: Refresh Interval
    Then UI set  RefreshInterval "60"
    Then UI set  RefreshInterval "120"
    Then UI Logout

  @SID_24
  Scenario: Acknowledge All Alerts in view
    When UI Login with user "radware" and password "radware"
    Then UI Acknowledge Unacknowledge Alerts "unacknowledge" by listOfRowIndexes "1"
#    Then UI Acknowledge Unacknowledge Alerts "unacknowledge" by listOfRowIndexes "2"
#    Then UI Acknowledge Unacknowledge Alerts "unacknowledge" by listOfRowIndexes "3"
#    Then UI Acknowledge Unacknowledge Alerts "unacknowledge" by listOfRowIndexes "4"
#    Then UI Acknowledge Unacknowledge Alerts "unacknowledge" by listOfRowIndexes "5"
#    Then UI Acknowledge Unacknowledge Alerts "unacknowledge" by listOfRowIndexes "6"
#    Then UI Acknowledge Unacknowledge Alerts "unacknowledge" by listOfRowIndexes "7"
#    Then UI Acknowledge Unacknowledge Alerts "acknowledge" by listOfRowIndexes "1"
#    Then UI Acknowledge Unacknowledge Alerts "acknowledge" by listOfRowIndexes "2"
#    Then UI Acknowledge Unacknowledge Alerts "acknowledge" by listOfRowIndexes "3"
#    Then UI Acknowledge Unacknowledge Alerts "acknowledge" by listOfRowIndexes "4"
    Then UI acknowledge All Alerts
    Then UI Logout

  @SID_25
  Scenario: Auto Refresh Button
    When UI Login with user "radware" and password "radware"
    Then UI Auto Refresh Alerts OnOFF "ON"
    Then UI set  RefreshInterval "5"
    Then UI Auto Refresh Alerts OnOFF "OFF"
    Then UI Logout

#  @SID_28
#  Scenario: Clear Selected Alert
#    When UI Login with user "radware" and password "radware"
#    Then UI clear Alerts by listOfRowIndexes "4"
#    Then UI clear Alerts by listOfRowIndexes "4"
#    Then UI Logout

  @SID_26
  Scenario: Clear All Alerts Button
    When UI Login with user "radware" and password "radware"
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |          |
      | selectAllDevices   | false    |
      | raisedTimeUnit     | Minute/s |
      | raisedTimeValue    | 60       |
      | severityList       | Warning  |
      | modulesList        |          |
      | devicesTypeList    |          |
      | groupsList         |          |
      | ackUnackStatusList |          |
      | restoreDefaults    | true     |
    Then UI clear All Alerts with TimeOut 0
    Then UI Logout

  @SID_27
  Scenario: Tear Down - Delete Devices
#    When UI Open "Configurations" Tab
    Then REST Login with user "radware" and password "radware"
    Then REST Delete Device By IP "1.1.1.1"
    Then REST Delete Device By IP "2.2.2.2"

  @SID_28
  Scenario: Preparations - clear all alerts and delete local user
    Given UI Login with user "radware" and password "radware"
    Then REST Delete ES index "alert"
    Given That Current Vision is Logged In
    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Local Users"
      | ormID | $[?(@.name=='cucumber')].ormID |
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Delete an Item from the Server"
    And The Request Path Parameters Are
      | item | user     |
      | id   | ${ormID} |
    When Send Request with the Given Specification


  @SID_29
  Scenario: Create Local User and Validate alert
    Given That Current Vision is Logged In
    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Local Users"
      | ormID | $[?(@.name=='cucumber')].ormID |
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Delete an Item from the Server"
    And The Request Path Parameters Are
      | item | user     |
      | id   | ${ormID} |
    When Send Request with the Given Specification
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Create Local User"
    Given The Request Body is the following Object
      | jsonPath                                                       | value             |
      | $.name                                                         | "cucumber"        |
      | $.password                                                     | "Radware1234!@#$" |
      | $.requireDeviceLock                                            | true              |
      | $.userSettings.userLocale                                      | "en_US"           |
      | $.parameters.roleGroupPairList[0].groupName                    | "[ALL]"           |
      | $.parameters.roleGroupPairList[0].roleName                     | "SYS_ADMIN"       |
      | $.networkPolicies[0].networkProtectionRuleId.deviceId          | "[ALL]"           |
      | $.networkPolicies[0].networkProtectionRuleId.rsIDSNewRulesName | "[ALL]"           |
      | $.roleGroupPairList[0].groupName                               | "[ALL]"           |
      | $.roleGroupPairList[0].roleName                                | "SYS_ADMIN"       |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |
#    Then Sleep "240"
    Then UI Validate Alert record Content by KeyValue with columnName "Message" with content "User radware added account cucumber."
      | columnName   | value          |
      | Severity     | Info           |
      | Module       | Vision General |
      | Product Name | Vision         |
      | User Name    | radware        |

  @SID_30
  Scenario: Delete Local User
    Given That Current Vision is Logged In
    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Local Users"
      | ormID | $[?(@.name=='cucumber')].ormID |
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Delete an Item from the Server"
    And The Request Path Parameters Are
      | item | user     |
      | id   | ${ormID} |
    When Send Request with the Given Specification
    Then UI logout and close browser









