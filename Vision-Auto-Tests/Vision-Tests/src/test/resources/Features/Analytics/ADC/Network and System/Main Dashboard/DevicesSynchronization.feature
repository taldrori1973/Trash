
@TC107130
Feature: DPM System And Network dashboard - Refreshing

  @SID_1
  Scenario: Login and Open Two Tabs and Navigate Tab 2 to Dashboard
    When UI Login with user "sys_admin" and password "radware" negative
    Then Browser Duplicate Tab Number 1
    Then Sleep "2"
    Then Browser Switch to Tab Number 2
    Then Sleep "2"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI Text of "Title" equal to "System & Network Dashboard"


#    ===================First Test , When Add New Device=================

  @SID_2

  Scenario: Switch to Tab 1
    When Browser Switch to Tab Number 1

  @SID_3

  Scenario: Add Device To Topology Tree
    Then UI Add "Alteon" Device To topology Tree with Name "50.50.101.30" and Management IP "50.50.101.30" into site "Default"
      | registerDeviceEvents | true |
      | visionMgtPort        | G2   |

  @SID_4
  Scenario: Switch to Tab 2
    When Browser Switch to Tab Number 2


#    Scenario Assumption : there are 7 devices with status up at the server ,
#    so with adding the new device the status widgets should be with 8 devices up.

  @SID_5
  Scenario: Validate Device Available at Status Widget , Device List and Device Selection After Adding it as UP
    Then Sleep "100"

#   Device Status
    Then UI Validate Pie Chart data "Status"
      | label       | data |
      | Down        | 0    |
      | Maintenance | 0    |
      | Up          | 8    |
      | Unknown     | 0    |

#    Device Selection List
    Then UI Text of "Dashboards.Network and System Dashboard.Device Selection" equal to "DEVICES 8/8"


#    Devices List
    Then UI Validate Table record values by columns with elementLabel "Dashboards.Network and System Dashboard.Device List.Table" findBy columnName "Management IP" findBy cellValue "50.50.101.30"
      | columnName               | value        |
      | Status                   | Up           |
      | Device Name              | 50.50.101.30 |
      | Management IP            | 50.50.101.30 |
      | Form Factor              | Standalone   |
      | Version                  | 32.2.1.0     |
      | Platform                 | 6024VL       |
      | High Availability Status | NONE         |
      | CurrentThroughput (bps)  | 2.9 M        |
      | CPU Usage                | 55%          |

#   Top By CPU
    Then UI Text of "Dashboards.Network and System Dashboard.TopByCPUUsage_deviceName" with extension "2" equal to "50.50.101.30"
    Then UI Text of "Dashboards.Network and System Dashboard.TopByCPUUsage_value" with extension "2" equal to "55%"
    Then UI Validate element "Dashboards.Network and System Dashboard.TopByCPUUsage_progress" attribute with param "2"
      | name  | value      |
      | style | width: 55% |


#   Top By Throughput
    Then UI Text of "Dashboards.Network and System Dashboard.TopByThroughputUsage_deviceName" with extension "2" equal to "50.50.101.30"
    Then UI Text of "Dashboards.Network and System Dashboard.TopByThroughputUsage_value" with extension "2" equal to "30.45%"
    Then UI Validate element "Dashboards.Network and System Dashboard.TopByThroughputUsage_progress" attribute with param "2"
      | name  | value         |
      | style | width: 30.45% |


#    ===================Second Test , When Change Device Name=================

  @SID_6
  Scenario: Switch to Tab 1
    When Browser Switch to Tab Number 1

  @SID_7

  Scenario: Change Device Name
    Then UI Edit Alteon device with Device Name "50.50.101.30" from topology tree
      | newDeviceName | 50.50.101.30-Changed |


  @SID_8
  Scenario: Switch to Tab 2
    When Browser Switch to Tab Number 2

  @SID_9
  Scenario: Validate Device Available at Status Widget , Device List and Device Selection After Changing Device Name
    Then Sleep "30"

#   Device Status
    Then UI Validate Pie Chart data "Status"
      | label       | data |
      | Down        | 0    |
      | Maintenance | 0    |
      | Up          | 8    |
      | Unknown     | 0    |

#    Device Selection List
    Then UI Text of "Dashboards.Network and System Dashboard.Device Selection" equal to "DEVICES 8/8"


#    Devices List
    Then UI Validate Table record values by columns with elementLabel "Dashboards.Network and System Dashboard.Device List.Table" findBy columnName "Management IP" findBy cellValue "50.50.101.30"
      | columnName               | value                |
      | Status                   | Up                   |
      | Device Name              | 50.50.101.30-Changed |
      | Management IP            | 50.50.101.30         |
      | Form Factor              | Standalone           |
      | Version                  | 32.2.1.0             |
      | Platform                 | 6024VL               |
      | High Availability Status | NONE                 |
      | CurrentThroughput (bps)  | 2.9 M                |
      | CPU Usage                | 55%                  |

#   Top By CPU
    Then UI Text of "Dashboards.Network and System Dashboard.TopByCPUUsage_deviceName" with extension "2" equal to "50.50.101.30-Changed"
    Then UI Text of "Dashboards.Network and System Dashboard.TopByCPUUsage_value" with extension "2" equal to "55%"
    Then UI Validate element "Dashboards.Network and System Dashboard.TopByCPUUsage_progress" attribute with param "2"
      | name  | value      |
      | style | width: 55% |


#   Top By Throughput
    Then UI Text of "Dashboards.Network and System Dashboard.TopByThroughputUsage_deviceName" with extension "2" equal to "50.50.101.30-Changed"
    Then UI Text of "Dashboards.Network and System Dashboard.TopByThroughputUsage_value" with extension "2" equal to "30.45%"
    Then UI Validate element "Dashboards.Network and System Dashboard.TopByThroughputUsage_progress" attribute with param "2"
      | name  | value         |
      | style | width: 30.45% |


#  ===================Third Test , When Device goes Down=================

  @SID_10
  Scenario: Switch to Tab 1
    When Browser Switch to Tab Number 1

  @SID_11
  Scenario: Make Device Down
    Then UI Edit Alteon device with Device Name "50.50.101.30" from topology tree
      | snmpVersion   | SNMP_V2  |
      | readCommunity | public1 |

  @SID_12
  Scenario: Switch to Tab 2
    When Browser Switch to Tab Number 2

  @SID_13
  Scenario: Validate Device Available at Status Widget , Device List and Device Selection After Making it as Down
    Then Sleep "30"

    #   Device Status
    Then UI Validate Pie Chart data "Status"
      | label       | data |
      | Down        | 1    |
      | Maintenance | 0    |
      | Up          | 7    |
      | Unknown     | 0    |

#    Device Selection List
    Then UI Text of "Dashboards.Network and System Dashboard.Device Selection" equal to "DEVICES 8/8"



    #    Devices List
    Then UI Validate Table record values by columns with elementLabel "Dashboards.Network and System Dashboard.Device List.Table" findBy columnName "Management IP" findBy cellValue "50.50.101.30"
      | columnName               | value                |
      | Status                   | Down                 |
      | Device Name              | 50.50.101.30-Changed |
      | Management IP            | 50.50.101.30         |
      | Form Factor              | Standalone           |
      | Version                  | 32.2.1.0             |
      | Platform                 | 6024VL               |
      | High Availability Status | NONE                 |
      | CurrentThroughput (bps)  |                      |
      | CPU Usage                |                      |


    #   Top By CPU - Should not be available when it's down
    Then UI Text of "Dashboards.Network and System Dashboard.TopByCPUUsage_deviceName" with extension "2" equal to "LinkProof NG_172.17.154.190"


#   Top By Throughput - Should not be available when it's down
    Then UI Validate Element Existence By Label "Dashboards.Network and System Dashboard.TopByThroughputUsage_deviceName" if Exists "false" with value "2"



#  ===================Fourth Test , When Device Deleted =================

  @SID_14
  Scenario: Switch to Tab 1
    When Browser Switch to Tab Number 1

  @SID_15
  Scenario: Delete Device
    Then UI Delete device with Name "50.50.101.30-Changed" from topology tree


  @SID_16
  Scenario: Switch to Tab 2
    When Browser Switch to Tab Number 2

  @SID_17
  Scenario: Validate Device is Not Available at Status Widget , Device List and Device Selection After Deleting it
    Then Sleep "30"
    #   Device Status
    Then UI Validate Pie Chart data "Status"
      | label       | data |
      | Down        | 0    |
      | Maintenance | 0    |
      | Up          | 7    |
      | Unknown     | 0    |

#    Device Selection List - Should Not be available at the List
    Then UI Text of "Dashboards.Network and System Dashboard.Device Selection" equal to "DEVICES 7/7"


#    Devices List - Should Not be available at the List
    Then UI Table Validate Value Existence in Table "Dashboards.Network and System Dashboard.Device List.Table" with Column Name "Management IP" and Value "50.50.101.30" if Exists "false"


#   Top By CPU - Should not be available
    Then UI Text of "Dashboards.Network and System Dashboard.TopByCPUUsage_deviceName" with extension "2" equal to "LinkProof NG_172.17.154.190"


#   Top By Throughput - Should not be available
    Then UI Validate Element Existence By Label "Dashboards.Network and System Dashboard.TopByThroughputUsage_deviceName" if Exists "false" with value "2"

  @SID_18
  Scenario: Logout
    Then UI logout and close browser
