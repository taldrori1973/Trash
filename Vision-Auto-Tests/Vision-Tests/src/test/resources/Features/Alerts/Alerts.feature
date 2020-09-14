@Functional @TC105960

Feature: Alert browser

  @SID_1
  Scenario: Add devices for Alerts
    Given CLI Reset radware password
    * REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
  | type | value                                 |
  | body | sessionInactivTimeoutConfiguration=60 |

  @SID_2
  Scenario: Acknowledge and unAcknowledge Alerts
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
#    Then UI Navigate to page via menu "Configuration"
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
#    Then UI Logout

  @SID_3
  Scenario: Device Type Alteon
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |                |
      | selectAllDevices   | true           |
      | raisedTimeUnit     | Hour/s         |
      | raisedTimeValue    | 24             |
      | severityList       |                |
      | modulesList        |                |
      | devicesTypeList    | Alteon         |
      | groupsList         |                |
      | ackUnackStatusList |                |
      | restoreDefaults    | true           |
#    Then UI Logout

  @SID_4
  Scenario: Device Type DefebsePro
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |                |
      | selectAllDevices   | true           |
      | raisedTimeUnit     | Hour/s         |
      | raisedTimeValue    | 24             |
      | severityList       |                |
      | modulesList        |                |
      | devicesTypeList    | DefensePro     |
      | groupsList         |                |
      | ackUnackStatusList |                |
      | restoreDefaults    | true           |
#    Then UI Logout

  @SID_5
  Scenario: Device Type Vision
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |                |
      | selectAllDevices   | true           |
      | raisedTimeUnit     | Hour/s         |
      | raisedTimeValue    | 24             |
      | severityList       |                |
      | modulesList        |                |
      | devicesTypeList    | Vision         |
      | groupsList         |                |
      | ackUnackStatusList |                |
      | restoreDefaults    | true           |

  @SID_6
  Scenario: Default Devices Selection
    Then UI validate SelectAllDevices Filter

#  @SID_7
#  Scenario: Multi Devices
#    When UI Login with user "radware" and password "radware"
#    Then UI validate Alerts Filter by KeyValue
#      | devicesList        |Alt_172.16.62.60_vADC-2,Alt_172.16.62.60_vADC-3,Alt_172.16.62.60_vADC-4,Alt_172.16.62.60_vADC-5|
#      | selectAllDevices   | true           |
#      | raisedTimeUnit     | Hour/s         |
#      | raisedTimeValue    | 1              |
#      | severityList       |                |
#      | modulesList        | Device General |
#      | devicesTypeList    | Alteon         |
#      | groupsList         |                |
#      | ackUnackStatusList |                |
#      | restoreDefaults    | true           |
#
#    Then UI validate Alerts Filter by KeyValue
#      | devicesList        |                |
#      | selectAllDevices   | true           |
#      | raisedTimeUnit     | Hour/s         |
#      | raisedTimeValue    | 1              |
#      | severityList       |                |
#      | modulesList        |                |
#      | devicesTypeList    |                |
#      | groupsList         |                |
#      | ackUnackStatusList |                |
#      | restoreDefaults    | true           |
#    Then UI Logout

  @SID_8
  Scenario: Single Devices
    Then UI validate Alerts Filter by KeyValue
      | devicesList        | Alt_172.16.62.60_vADC-2 |
      | selectAllDevices   | false                   |
      | raisedTimeUnit     | Hour/s                  |
      | raisedTimeValue    | 24                      |
      | severityList       |                         |
      | modulesList        | Device General          |
      | devicesTypeList    | Alteon                  |
      | groupsList         |                         |
      | ackUnackStatusList |                         |
      | restoreDefaults    | true                    |

    Then UI validate Alerts Filter by KeyValue
      | devicesList        | Alt_172.16.62.60_vADC-3 |
      | selectAllDevices   | false                   |
      | raisedTimeUnit     | Hour/s                  |
      | raisedTimeValue    | 24                      |
      | severityList       |                         |
      | modulesList        | Device General          |
      | devicesTypeList    | Alteon                  |
      | groupsList         |                         |
      | ackUnackStatusList |                         |
      | restoreDefaults    | true                    |
#    Then UI Logout

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
      | devicesList        | Alt_172.16.62.60_vADC-2                                                                              |
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
#    Then UI Logout

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
      | restoreDefaults    | true           |

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

  @SID_13
  Scenario: Uncheck Module
    Then UI module Check Negative
    Then UI Logout

  @SID_14
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
#    Then UI Logout

  @SID_15
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

  @SID_16
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
#    Then UI Logout

  @SID_17
  Scenario: Raised Time
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |        |
      | selectAllDevices   | false  |
      | raisedTimeUnit     | Hour/s |
      | raisedTimeValue    | 1      |
      | severityList       |        |
      | modulesList        |        |
      | devicesTypeList    |        |
      | groupsList         |        |
      | ackUnackStatusList |        |
      | restoreDefaults    | true   |
    Then UI validate RaisedTimeFilter with raisedTimeUnit "HOURS" with raisedTimeValue "1"
#
#    Then UI validate Alerts Filter by KeyValue
#      | devicesList        |        |
#      | selectAllDevices   | false  |
#      | raisedTimeUnit     | Hour/s |
#      | raisedTimeValue    | 8      |
#      | severityList       |        |
#      | modulesList        |        |
#      | devicesTypeList    |        |
#      | groupsList         |        |
#      | ackUnackStatusList |        |
#      | restoreDefaults    | true   |
#    Then UI validate RaisedTimeFilter with raisedTimeUnit "HOURS" with raisedTimeValue "8"
#
#    Then UI validate Alerts Filter by KeyValue
#      | devicesList        |        |
#      | selectAllDevices   | false  |
#      | raisedTimeUnit     | Hour/s |
#      | raisedTimeValue    | 24     |
#      | severityList       |        |
#      | modulesList        |        |
#      | devicesTypeList    |        |
#      | groupsList         |        |
#      | ackUnackStatusList |        |
#      | restoreDefaults    | true   |
#    Then UI validate RaisedTimeFilter with raisedTimeUnit "HOURS" with raisedTimeValue "24"
#
#    Then UI validate Alerts Filter by KeyValue
#      | devicesList        |        |
#      | selectAllDevices   | false  |
#      | raisedTimeUnit     | Hour/s |
#      | raisedTimeValue    | 15     |
#      | severityList       |        |
#      | modulesList        |        |
#      | devicesTypeList    |        |
#      | groupsList         |        |
#      | ackUnackStatusList |        |
#      | restoreDefaults    | true   |
#    Then UI validate RaisedTimeFilter with raisedTimeUnit "MINUTES" with raisedTimeValue "15"
#    Then UI Logout

  @SID_18
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

  @SID_19
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

  @SID_20
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

  @SID_21
  Scenario: Major Alerts
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |             |
      | selectAllDevices   | true        |
      | raisedTimeUnit     | Hour/s      |
      | raisedTimeValue    | 24          |
      | severityList       | Major       |
      | modulesList        |             |
      | devicesTypeList    |             |
      | groupsList         |             |
      | ackUnackStatusList |             |
      | restoreDefaults    | true        |

  @SID_22
  Scenario: Minor Alerts
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |             |
      | selectAllDevices   | true        |
      | raisedTimeUnit     | Hour/s      |
      | raisedTimeValue    | 24          |
      | severityList       | Minor       |
      | modulesList        |             |
      | devicesTypeList    |             |
      | groupsList         |             |
      | ackUnackStatusList |             |
      | restoreDefaults    | true        |

  @SID_23
  Scenario: Uncheck Severity
    Then UI Severity Check Negative

  @SID_24
  Scenario: Warning Alerts
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |             |
      | selectAllDevices   | true        |
      | raisedTimeUnit     | Hour/s      |
      | raisedTimeValue    | 1           |
      | severityList       | Warning     |
      | modulesList        |             |
      | devicesTypeList    |             |
      | groupsList         |             |
      | ackUnackStatusList |             |
      | restoreDefaults    | true        |

  @SID_25
  Scenario: Refresh Interval
    Then UI set  RefreshInterval "60"
    Then UI set  RefreshInterval "120"
    Then UI Logout

  @SID_26
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

  @SID_27
  Scenario: Auto Refresh Button
    When UI Login with user "radware" and password "radware"
    Then UI Auto Refresh Alerts OnOFF "ON"
    Then UI set  RefreshInterval "5"
    Then UI Auto Refresh Alerts OnOFF "OFF"
    Then UI Logout

  @SID_28
  Scenario: Clear Selected Alert
    When UI Login with user "radware" and password "radware"
    Then UI clear Alerts by listOfRowIndexes "4"
    Then UI clear Alerts by listOfRowIndexes "4"
    Then UI Logout

  @SID_29
  Scenario: Clear All Alerts Button
    When UI Login with user "radware" and password "radware"
    Then UI validate Alerts Filter by KeyValue
      | devicesList        |             |
      | selectAllDevices   | false       |
      | raisedTimeUnit     | Minute/s    |
      | raisedTimeValue    | 60          |
      | severityList       | Warning     |
      | modulesList        |             |
      | devicesTypeList    |             |
      | groupsList         |             |
      | ackUnackStatusList |             |
      | restoreDefaults    | true        |
    Then UI clear All Alerts with TimeOut 0
    Then UI Logout

#  @SID_30
#  Scenario: delete Devices for Alerts
#    When UI Login with user "radware" and password "radware"
#    Then UI Delete Multiple Devices - By device Names "Alt_172.16.62.60_vADC-2,Alt_172.16.62.60_vADC-3,Alt_172.16.62.60_vADC-4,Alt_172.16.62.60_vADC-5"
#    Then UI Delete "DefensePro" device with index 2 from topology tree
#    Then UI open Topology Tree view "PhysicalContainers" site
#    Then UI Delete physical "Alteon" device with index 6 from topology tree
#    Then UI Logout







