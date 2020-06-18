@TC106793  @Analytics_ADC
Feature:System and Network Dashboard - System Summary

  @SID_1
  Scenario: Login With UI and REST
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    When UI Login with user "sys_admin" and password "radware"
    When REST Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    Then UI open Topology Tree view "PhysicalContainers" site
    Then UI Add new Site "Physical_Fake" under Parent "Default (Physical)"

  @SID_2
  Scenario Outline: Add New Devices
    Then REST Add "Alteon" Device To topology Tree with Name "<Device Name>" and Management IP "<Device IP>" into site "<Site>"
      | attribute     | value |
      | visionMgtPort | G2    |
    Examples:
      | Device Name   | Device IP     | Site                  |
      | 50.50.101.30  | 50.50.101.30  | Alteons_for_DPM-Fakes |
      | 50.50.101.31  | 50.50.101.31  | Alteons_for_DPM-Fakes |
      | 50.50.101.32  | 50.50.101.32  | Alteons_for_DPM-Fakes |
      | 50.50.101.33  | 50.50.101.33  | Physical_Fake         |
      | 50.50.32.1    | 50.50.32.1    | Alteons_for_DPM-Fakes |
      | 50.50.101.254 | 50.50.101.254 | Alteons_for_DPM-Fakes |

  @SID_3
  Scenario: Add Device to be Down from the Beginning
    Then REST Add "Alteon" Device To topology Tree with Name "50.50.101.34" and Management IP "50.50.101.34" into site "Default"
      | attribute           | value   |
      | visionMgtPort       | G2      |
      | snmpV2ReadCommunity | public1 |



  @SID_5
  Scenario: Make Some Devices Down
    Then REST Update a scalar "snmpV2ReadCommunity" value of Request "Device Tree->Update SNMPv2 Read Community" on the device Ip "50.50.101.30" with the new scalar value "public1"
    Then REST Update a scalar "snmpV2ReadCommunity" value of Request "Device Tree->Update SNMPv2 Read Community" on the device Ip "50.50.101.31" with the new scalar value "public1"
    Then REST Update a scalar "snmpV2ReadCommunity" value of Request "Device Tree->Update SNMPv2 Read Community" on the device Ip "50.50.101.32" with the new scalar value "public1"
    Then REST Update a scalar "snmpV2ReadCommunity" value of Request "Device Tree->Update SNMPv2 Read Community" on the device Ip "172.17.164.17" with the new scalar value "public1"
    Then REST Update a scalar "snmpV2ReadCommunity" value of Request "Device Tree->Update SNMPv2 Read Community" on the device Ip "172.17.154.190" with the new scalar value "public1"

  @SID_7
  Scenario: Logout and relogin with user for fake ADCs
    When UI Logout
    Then UI Login with user "ADC_Administrator_auto_fake" and password "radware"

  @SID_8
  Scenario: Navigate to Analytics ADC Network and System Dashboard
    Then UI Open Upper Bar Item "ADC"
    Then UI Open "Reports" Tab
    Then UI Open "Dashboards" Tab
    Then UI Open "Network and System Dashboard" Sub Tab
    Then UI Text of "Title" equal to "System & Network Dashboard"

#=========================================General Tests=================================================================

  @SID_9
  Scenario: Validate System Summary Section Titles
    Then UI Text of "Dashboards Widget Title" with extension "System Summary" equal to "System Summary"
    Then UI Text of "Status Chart Header" equal to "Status"
    Then UI Text of "TopByCPUUsage Chart Header" equal to "Top Devices by CPU Usage"
    Then UI Text of "TopByThroughputUsage Chart Header" equal to "Top Devices by Throughput Usage"

  @SID_10
  Scenario: Validate System Summary Devices Status Legend
    Then UI Text of "Status Legend" with extension "Down" equal to "Down"
    Then UI Text of "Status Legend" with extension "Maintenance" equal to "Maintenance"
    Then UI Text of "Status Legend" with extension "Up" equal to "Up"
    Then UI Text of "Status Legend" with extension "Unknown" equal to "Unknown"

#=========================================Default Case All devices Selected=============================================

  @SID_11
  Scenario: Validate Status Chart Data
    Then UI Validate Pie Chart data "Status"
      | label       | data |
      | Down        | 0    |
      | Maintenance | 3    |
      | Up          | 4    |
      | Unknown     | 1    |

  @SID_12
  Scenario: Validate  "Top Devices by CPU Usage" Chart data values
    Then UI Text of "TopByCPUUsage_deviceName" with extension "0" equal to "Alteon_50.50.101.22"
    Then UI Text of "TopByCPUUsage_value" with extension "0" equal to "99%"
    Then UI Validate element "TopByCPUUsage_progress" attribute with param "0"
      | name  | value      |
      | style | width: 99% |

    Then UI Text of "TopByCPUUsage_deviceName" with extension "1" equal to "Alteon_50.50.101.21"
    Then UI Text of "TopByCPUUsage_value" with extension "1" equal to "77%"
    Then UI Validate element "TopByCPUUsage_progress" attribute with param "1"
      | name  | value      |
      | style | width: 77% |


#    Then UI Text of "TopByCPUUsage_deviceName" with extension "2" equal to "LinkProof NG_172.17.154.200"
#    Then UI Text of "TopByCPUUsage_value" with extension "2" equal to "2%"
#    Then UI Validate element "TopByCPUUsage_progress" attribute with param "3"
#      | name  | value     |
#      | style | width: 2% |
#
#    Then UI Text of "TopByCPUUsage_deviceName" with extension "3" equal to "Alteon_172.17.164.18"
#    Then UI Text of "TopByCPUUsage_value" with extension "3" equal to "2%"
#    Then UI Validate element "TopByCPUUsage_progress" attribute with param "3"
#      | name  | value     |
#      | style | width: 2% |


#    Then UI Text of "TopByCPUUsage_deviceName" with extension "4" equal to "50.50.101.33"
#    Then UI Text of "TopByCPUUsage_value" with extension "4" equal to "1%"
#    Then UI Validate element "TopByCPUUsage_progress" attribute with param "4"
#      | name  | value     |
#      | style | width: 1% |

  @SID_13
  Scenario: Validate "Top Devices by Throughput Usage" Chart data values
    Then UI Text of "TopByThroughputUsage_deviceName" with extension "0" equal to "Alteon_50.50.101.22"
    Then UI Text of "TopByThroughputUsage_value" with extension "0" equal to "90.45%"
    Then UI Validate element "TopByThroughputUsage_progress" attribute with param "0"
      | name  | value         |
      | style | width: 90.45% |

    Then UI Text of "TopByThroughputUsage_deviceName" with extension "1" equal to "Alteon_50.50.101.21"
    Then UI Text of "TopByThroughputUsage_value" with extension "1" equal to "60.45%"
    Then UI Validate element "TopByThroughputUsage_progress" attribute with param "1"
      | name  | value         |
      | style | width: 60.45% |

#    Then UI Text of "TopByThroughputUsage_deviceName" with extension "2" equal to "50.50.101.33"
#    Then UI Text of "TopByThroughputUsage_value" with extension "2" equal to "1.45%"
#    Then UI Validate element "TopByThroughputUsage_progress" attribute with param "2"
#      | name  | value        |
#      | style | width: 1.45% |


#=========================================Scope Selection===============================================================

  @SID_14
  Scenario: Validate All Devices Are Available at Device Selection List
    Then UI Text of "Device Selection" equal to "DEVICES 3/3"
    Then UI Click Button "Device Selection"
    Then UI Text of "Device Selection.Header" equal to "Devices3/3"
#    Then UI Text of "Device Selection.Select Device Label" with extension "Alteon_172.17.164.17" equal to "Alteon_172.17.164.17"
#    Then UI Text of "Device Selection.Select Device Label" with extension "Alteon_172.17.164.18" equal to "Alteon_172.17.164.18"
    Then UI Text of "Device Selection.Select Device Label" with extension "Alteon_50.50.101.11" equal to "Alteon_50.50.101.11"
    Then UI Text of "Device Selection.Select Device Label" with extension "Alteon_50.50.101.21" equal to "Alteon_50.50.101.21"
    Then UI Text of "Device Selection.Select Device Label" with extension "Alteon_50.50.101.22" equal to "Alteon_50.50.101.22"
    Then UI Text of "Device Selection.Select Device Label" with extension "50.50.101.30" equal to "50.50.101.30"
    Then UI Text of "Device Selection.Select Device Label" with extension "50.50.101.31" equal to "50.50.101.31"
    Then UI Text of "Device Selection.Select Device Label" with extension "50.50.101.32" equal to "50.50.101.32"
    Then UI Text of "Device Selection.Select Device Label" with extension "50.50.101.33" equal to "50.50.101.33"
    Then UI Text of "Device Selection.Select Device Label" with extension "50.50.101.254" equal to "50.50.101.254"
    Then UI Text of "Device Selection.Select Device Label" with extension "LinkProof NG_172.17.154.200" equal to "LinkProof NG_172.17.154.200"
    Then UI Text of "Device Selection.Select Device Label" with extension "LinkProof NG_172.17.154.190" equal to "LinkProof NG_172.17.154.190"
    Then UI Click Button "Device Selection"

#-----------------------------------------Select One Device-------------------------------------------------------------

  @SID_15
  Scenario: Validate System Summary Widgets when One Device is Selected
    When UI Click Button "Device Selection"
    Then UI Click Button "Device Selection.Select All Label"
    Then UI Click Button "Device Selection.Select Device Label" with value "Alteon_50.50.101.21"
    Then UI Text of "Device Selection.Header" equal to "Devices1/12"
    Then UI Click Button "Device Selection.Save"
    Then UI Text of "Device Selection" equal to "DEVICES 1/12"

#   Validate Status Chart Data
    Then UI Validate Pie Chart data "Status"
      | label       | data |
      | Down        | 0    |
      | Maintenance | 0    |
      | Up          | 1    |
      | Unknown     | 0    |

#   Validate  "Top Devices by CPU Usage" Chart data values
    Then UI Text of "TopByCPUUsage_deviceName" with extension "0" equal to "Alteon_50.50.101.21"
    Then UI Text of "TopByCPUUsage_value" with extension "0" equal to "77%"
    Then UI Validate element "TopByCPUUsage_progress" attribute with param "0"
      | name  | value      |
      | style | width: 77% |


#   Validate "Top Devices by Throughput Usage" Chart data values
    Then UI Text of "TopByThroughputUsage_deviceName" with extension "0" equal to "Alteon_50.50.101.21"
    Then UI Text of "TopByThroughputUsage_value" with extension "0" equal to "60.45%"
    Then UI Validate element "TopByThroughputUsage_progress" attribute with param "0"
      | name  | value         |
      | style | width: 60.45% |


#-----------------------------------------Select Multiple Devices-------------------------------------------------------

  @SID_16
  Scenario: Validate System Summary Widgets when Multiple Devices are Selected
    When UI Click Button "Device Selection"
    Then UI Click Button "Device Selection.Select All Label"
    Then UI Click Button "Device Selection.Select All Label"
    Then UI Click Button "Device Selection.Select Device Label" with value "50.50.101.254"
    Then UI Click Button "Device Selection.Select Device Label" with value "Alteon_172.17.164.17"
    Then UI Click Button "Device Selection.Select Device Label" with value "LinkProof NG_172.17.154.200"
    Then UI Click Button "Device Selection.Select Device Label" with value "Alteon_50.50.101.22"
    Then UI Text of "Device Selection.Header" equal to "Devices4/12"
    Then UI Click Button "Device Selection.Save"
    Then UI Text of "Device Selection" equal to "DEVICES 4/12"

#   Validate Status Chart Data
    Then UI Validate Pie Chart data "Status"
      | label       | data |
      | Down        | 1    |
      | Maintenance | 0    |
      | Up          | 2    |
      | Unknown     | 1    |

#   Validate  "Top Devices by CPU Usage" Chart data values
    Then UI Text of "TopByCPUUsage_deviceName" with extension "0" equal to "Alteon_50.50.101.22"
    Then UI Text of "TopByCPUUsage_value" with extension "0" equal to "99%"
    Then UI Validate element "TopByCPUUsage_progress" attribute with param "0"
      | name  | value      |
      | style | width: 99% |


    Then UI Text of "TopByCPUUsage_deviceName" with extension "1" equal to "LinkProof NG_172.17.154.200"
    Then UI Text of "TopByCPUUsage_value" with extension "1" equal to "2%"
    Then UI Validate element "TopByCPUUsage_progress" attribute with param "1"
      | name  | value     |
      | style | width: 2% |


#   Validate "Top Devices by Throughput Usage" Chart data values
    Then UI Text of "TopByThroughputUsage_deviceName" with extension "0" equal to "Alteon_50.50.101.22"
    Then UI Text of "TopByThroughputUsage_value" with extension "0" equal to "90.45%"
    Then UI Validate element "TopByThroughputUsage_progress" attribute with param "0"
      | name  | value         |
      | style | width: 90.45% |


#-----------------------------------------Select All Devices------------------------------------------------------------

  @SID_17
  Scenario: Validate System Summary Widgets when All Devices are Selected
    When UI Click Button "Device Selection"
    Then UI Click Button "Device Selection.Select All Label"
    Then UI Text of "Device Selection.Header" equal to "Devices12/12"
    Then UI Click Button "Device Selection.Save"
    Then UI Text of "Device Selection" equal to "DEVICES 12/12"

#   Validate Status Chart Data
    Then UI Validate Pie Chart data "Status"
      | label       | data |
      | Down        | 5    |
      | Maintenance | 0    |
      | Up          | 6    |
      | Unknown     | 1    |

#   Validate  "Top Devices by CPU Usage" Chart data values
    Then UI Text of "TopByCPUUsage_deviceName" with extension "0" equal to "Alteon_50.50.101.22"
    Then UI Text of "TopByCPUUsage_value" with extension "0" equal to "99%"
    Then UI Validate element "TopByCPUUsage_progress" attribute with param "0"
      | name  | value      |
      | style | width: 99% |

    Then UI Text of "TopByCPUUsage_deviceName" with extension "1" equal to "Alteon_50.50.101.21"
    Then UI Text of "TopByCPUUsage_value" with extension "1" equal to "77%"
    Then UI Validate element "TopByCPUUsage_progress" attribute with param "1"
      | name  | value      |
      | style | width: 77% |


    Then UI Text of "TopByCPUUsage_deviceName" with extension "2" equal to "LinkProof NG_172.17.154.200"
    Then UI Text of "TopByCPUUsage_value" with extension "2" equal to "2%"
    Then UI Validate element "TopByCPUUsage_progress" attribute with param "3"
      | name  | value     |
      | style | width: 2% |

    Then UI Text of "TopByCPUUsage_deviceName" with extension "3" equal to "Alteon_172.17.164.18"
    Then UI Text of "TopByCPUUsage_value" with extension "3" equal to "2%"
    Then UI Validate element "TopByCPUUsage_progress" attribute with param "3"
      | name  | value     |
      | style | width: 2% |


    Then UI Text of "TopByCPUUsage_deviceName" with extension "4" equal to "50.50.101.33"
    Then UI Text of "TopByCPUUsage_value" with extension "4" equal to "1%"
    Then UI Validate element "TopByCPUUsage_progress" attribute with param "4"
      | name  | value     |
      | style | width: 1% |

#   Validate "Top Devices by Throughput Usage" Chart data values
    Then UI Text of "TopByThroughputUsage_deviceName" with extension "0" equal to "Alteon_50.50.101.22"
    Then UI Text of "TopByThroughputUsage_value" with extension "0" equal to "90.45%"
    Then UI Validate element "TopByThroughputUsage_progress" attribute with param "0"
      | name  | value         |
      | style | width: 90.45% |

    Then UI Text of "TopByThroughputUsage_deviceName" with extension "1" equal to "Alteon_50.50.101.21"
    Then UI Text of "TopByThroughputUsage_value" with extension "1" equal to "60.45%"
    Then UI Validate element "TopByThroughputUsage_progress" attribute with param "1"
      | name  | value         |
      | style | width: 60.45% |

    Then UI Text of "TopByThroughputUsage_deviceName" with extension "2" equal to "50.50.101.33"
    Then UI Text of "TopByThroughputUsage_value" with extension "2" equal to "1.45%"
    Then UI Validate element "TopByThroughputUsage_progress" attribute with param "2"
      | name  | value        |
      | style | width: 1.45% |


#=========================================Scope Selection With Filtering================================================


#-----------------------------------------Select All Device which contains "Alteon"-------------------------------------

  @SID_18
  Scenario: Validate System Summary Widgets Selecting All Devices which include the word "Alteon"
    When UI Click Button "Device Selection"
    Then UI Click Button "Device Selection.Select All Label"

    Then UI Set Text Field "Device Selection.Filter" To "Alteon"
    Then UI Click Button "Device Selection.Select All Label"
    Then UI Click Button "Device Selection.Save"

#   Validate Status Chart Data
    Then UI Validate Pie Chart data "Status"
      | label       | data |
      | Down        | 1    |
      | Maintenance | 0    |
      | Up          | 4    |
      | Unknown     | 0    |

#   Validate  "Top Devices by CPU Usage" Chart data values
    Then UI Text of "TopByCPUUsage_deviceName" with extension "0" equal to "Alteon_50.50.101.22"
    Then UI Text of "TopByCPUUsage_value" with extension "0" equal to "99%"
    Then UI Validate element "TopByCPUUsage_progress" attribute with param "0"
      | name  | value      |
      | style | width: 99% |

    Then UI Text of "TopByCPUUsage_deviceName" with extension "1" equal to "Alteon_50.50.101.21"
    Then UI Text of "TopByCPUUsage_value" with extension "1" equal to "77%"
    Then UI Validate element "TopByCPUUsage_progress" attribute with param "1"
      | name  | value      |
      | style | width: 77% |
    Then UI Text of "TopByCPUUsage_deviceName" with extension "2" equal to "Alteon_172.17.164.18"
    Then UI Text of "TopByCPUUsage_value" with extension "2" equal to "2%"
    Then UI Validate element "TopByCPUUsage_progress" attribute with param "2"
      | name  | value     |
      | style | width: 2% |
#   Validate "Top Devices by Throughput Usage" Chart data values
    Then UI Text of "TopByThroughputUsage_deviceName" with extension "0" equal to "Alteon_50.50.101.22"
    Then UI Text of "TopByThroughputUsage_value" with extension "0" equal to "90.45%"
    Then UI Validate element "TopByThroughputUsage_progress" attribute with param "0"
      | name  | value         |
      | style | width: 90.45% |

    Then UI Text of "TopByThroughputUsage_deviceName" with extension "1" equal to "Alteon_50.50.101.21"
    Then UI Text of "TopByThroughputUsage_value" with extension "1" equal to "60.45%"
    Then UI Validate element "TopByThroughputUsage_progress" attribute with param "1"
      | name  | value         |
      | style | width: 60.45% |

#-----------------------------------------Select All Devices which contains "154"------------------------------------------------------------

  @SID_19
  Scenario: Validate System Summary Widgets Selecting All Devices which include the word "154"
    When UI Click Button "Device Selection"
    Then UI Click Button "Device Selection.Select All Label"
    Then UI Click Button "Device Selection.Select All Label"
    Then UI Set Text Field "Device Selection.Filter" To "154"
    Then UI Click Button "Device Selection.Select All Label"
    Then UI Click Button "Device Selection.Save"
#   Validate Status Chart Data
    Then UI Validate Pie Chart data "Status"
      | label       | data |
      | Down        | 1    |
      | Maintenance | 0    |
      | Up          | 1    |
      | Unknown     | 0    |
#   Validate  "Top Devices by CPU Usage" Chart data values
    Then UI Text of "TopByCPUUsage_deviceName" with extension "0" equal to "LinkProof NG_172.17.154.200"
    Then UI Text of "TopByCPUUsage_value" with extension "0" equal to "2%"
    Then UI Validate element "TopByCPUUsage_progress" attribute with param "0"
      | name  | value     |
      | style | width: 2% |
#   Validate "Top Devices by Throughput Usage" Chart No Data Available
    Then UI Text of "No Data Available" equal to "!No Data Available"

#===============================================Tear Down===============================================================

  @SID_20
  Scenario: Tear Down - Delete Devices and Restore Configurations
    When UI Open "Configurations" Tab
    Then REST Login with user "radware" and password "radware"
    Then REST Delete Device By IP "50.50.101.30"
    Then REST Delete Device By IP "50.50.101.31"
    Then REST Delete Device By IP "50.50.101.32"
    Then REST Delete Device By IP "50.50.101.33"
    Then REST Delete Device By IP "50.50.101.34"
    Then REST Delete Device By IP "50.50.32.1"
    Then REST Delete Device By IP "50.50.101.254"

#    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='Physical_Fake';""
    Then MYSQL DELETE FROM "site_tree_elem_abs" Table in "VISION_NG" Schema WHERE "name='Physical_Fake'"

    Then REST Update a scalar "snmpV2ReadCommunity" value of Request "Device Tree->Update SNMPv2 Read Community" on the device Ip "172.17.164.17" with the new scalar value "public"
    Then REST Update a scalar "snmpV2ReadCommunity" value of Request "Device Tree->Update SNMPv2 Read Community" on the device Ip "172.17.154.190" with the new scalar value "public"


  @SID_21
  Scenario: Logout
    Then UI logout and close browser