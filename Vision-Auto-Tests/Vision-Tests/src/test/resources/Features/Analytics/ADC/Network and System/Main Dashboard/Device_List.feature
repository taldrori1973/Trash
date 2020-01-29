@TC106928
Feature: System And Network - Device List

  @SID_1
  Scenario: Login With UI and REST
    When UI Login with user "sys_admin" and password "radware"
    When REST Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-reporting-module-ADC"

  @SID_2
  Scenario Outline:Setup 1 - Add New Devices

    Then REST Add "Alteon" Device To topology Tree with Name "<Device Name>" and Management IP "<Device IP>" into site "<Site>"
      | attribute     | value |
      | visionMgtPort | G2    |
    Examples:
      | Device Name          | Device IP     | Site               |
      | Alteon_50.50.101.30  | 50.50.101.30  | Default            |
      | Alteon_50.50.101.31  | 50.50.101.31  | Default            |
      | Alteon_50.50.101.32  | 50.50.101.32  | Default            |
      | Alteon_50.50.101.33  | 50.50.101.33  | Default (Physical) |
      | Alteon_50.50.32.1    | 50.50.32.1    | Default            |
      | Alteon_50.50.101.254 | 50.50.101.254 | Default            |

  @SID_3
  Scenario: Setup 2 - Add Device to be Down from the Beginning
    Then REST Add "Alteon" Device To topology Tree with Name "50.50.101.34" and Management IP "50.50.101.34" into site "Default"
      | attribute           | value   |
      | visionMgtPort       | G2      |
      | snmpV2ReadCommunity | public1 |

    Then UI Click Web element with id "gwt-debug-Global_Refresh"
    Then Browser Refresh Page

  @SID_4
  Scenario Outline: Setup 3 - UI Edit and Submit New Devices To Update Status at Topology Tree
    Then UI Click Edit device Then Submit to Refresh with IP "<Device IP>" from topology tree "<Tree>"
    Examples:
      | Device IP            | Tree                |
      | 50.50.101.30         | Sites and Devices   |
      | 50.50.101.31         | Sites and Devices   |
      | 50.50.101.32         | Sites and Devices   |
      | 50.50.101.33         | Physical Containers |
      | 50.50.32.1           | Sites and Devices   |
      | 50.50.101.254        | Sites and Devices   |
      | 50.50.101.34         | Sites and Devices   |

  @SID_5
  Scenario: Setup 4 - Sleep Then Make Some Devices Down

    Then Sleep "20"

    Then REST Update a scalar "snmpV2ReadCommunity" value of Request "Device Tree->Update SNMPv2 Read Community" on the device Ip "50.50.101.30" with the new scalar value "public1"
    Then REST Update a scalar "snmpV2ReadCommunity" value of Request "Device Tree->Update SNMPv2 Read Community" on the device Ip "50.50.101.31" with the new scalar value "public1"
    Then REST Update a scalar "snmpV2ReadCommunity" value of Request "Device Tree->Update SNMPv2 Read Community" on the device Ip "50.50.101.32" with the new scalar value "public1"
    Then REST Update a scalar "snmpV2ReadCommunity" value of Request "Device Tree->Update SNMPv2 Read Community" on the device Ip "172.17.164.17" with the new scalar value "public1"
    Then REST Update a scalar "snmpV2ReadCommunity" value of Request "Device Tree->Update SNMPv2 Read Community" on the device Ip "172.17.154.190" with the new scalar value "public1"

    Then Browser Refresh Page


  @SID_6
  Scenario Outline: Setup 5 - UI Edit and Submit Down Devices To Update Status at Topology Tree
    Then UI Click Edit device Then Submit to Refresh with IP "<Device IP>" from topology tree "Sites and Devices"
    Examples:
      | Device IP      |
      | 50.50.101.30   |
      | 50.50.101.31   |
      | 50.50.101.32   |
      | 172.17.164.17  |
      | 172.17.154.190 |

  @SID_7
  Scenario: Navigation
    Then UI Open Upper Bar Item "ADC"
    Then UI Open "Dashboards" Tab
    And UI Open "Network and System Dashboard" Sub Tab
    Then UI Open "Configurations" Tab
    Then UI Open Upper Bar Item "ADC"
    Then UI Open "Dashboards" Tab
    And UI Open "Network and System Dashboard" Sub Tab
    Then UI Text of "Title" equal to "System & Network Dashboard"


#Validate Widgets Titles
  @SID_8
  Scenario: Validate Table Title
    Then UI Text of "Dashboards Widget Title" with extension "Device List" equal to "Device List"

    #This is not the exact data which expected to get from Alteon , deu to Alteon Bug.
  @SID_9
  Scenario: Validate Table Content
    #Management IP= 50.50.101.30

    Then UI Validate "Device List.Table" Table rows count equal to 12 with offset 0

      #ToDo check color
    Then UI Validate Table record values by columns with elementLabel "Device List.Table" findBy columnName "Management IP" findBy cellValue "50.50.101.30"
      | columnName              | value       |
      | Status                  | Down          |
      | Device Name             | Alteon_50.50.101.30 |
      | Management IP           | 50.50.101.30|
      | Form Factor             | Standalone  |
      | Version                 | 32.2.1.0    |
      | Platform                | 6024VL      |
      | High Availability Status| NONE        |
      | CurrentThroughput (bps) |              |
      | CPU Usage               |             |

    #Management IP= 50.50.101.31
    Then UI Validate Table record values by columns with elementLabel "Device List.Table" findBy columnName "Management IP" findBy cellValue "50.50.101.31"
      | columnName              | value       |
      | Status                  | Down        |
      | Device Name             | Alteon_50.50.101.31 |
      | Management IP           | 50.50.101.31|
      | Form Factor             | VA          |
      | Version                 | 32.2.1.0    |
      | Platform                | VA          |
      | High Availability Status| BACKUP      |
      | CurrentThroughput (bps) |             |
      | CPU Usage               |             |

    #Management IP= 50.50.101.32
    Then UI Validate Table record values by columns with elementLabel "Device List.Table" findBy columnName "Management IP" findBy cellValue "50.50.101.32"
      | columnName              | value       |
      | Status                  | Down        |
      | Device Name             | Alteon_50.50.101.32 |
      | Management IP           | 50.50.101.32|
      | Form Factor             | VADC        |
      | Version                 | 32.2.1.0    |
      | Platform                | 8420 SL     |
      | High Availability Status| ACTIVE      |
      | CurrentThroughput (bps) |             |
      | CPU Usage               |             |

    #Management IP= 50.50.101.33
    Then UI Validate Table record values by columns with elementLabel "Device List.Table" findBy columnName "Management IP" findBy cellValue "50.50.101.33"
      | columnName              | value       |
      | Status                  | Up          |
      | Device Name             | Alteon_50.50.101.33 |
      | Management IP           | 50.50.101.33|
      | Form Factor             | VX          |
      | Version                 | 32.2.1.0    |
      | Platform                | 5208 EL     |
      | High Availability Status| DISABLED    |
      | CurrentThroughput (bps) | 141.6 K     |
      | CPU Usage               | 1%          |


    # =================================== Table Sorting ================================


  #Default Order is : Down , Warning, Shutdown, Up, Admin Down + Device Name
  @SID_10
  Scenario:  Validate Default Sorting
    Then UI Validate Table "Devices table" is Sorted by
      | columnName | order     | compareMethod |
      | Status     | Ascending | SYSTEM_STATUS  |
  #Second Click on Status column, The Reversed Status Order is : Admin Down , UP, Shutdown Warning, Down

  #------------------------By Status----------------------
  @SID_11
  Scenario:  Validate Sorting by Status in Ascending Order
    When UI Click Button "Sort By" with value "deviceStatus"
    Then UI Validate Table "Devices table" is Sorted by
      | columnName | order     | compareMethod |
      | Status     | Ascending | SYSTEM_STATUS |
  #Second Click on Status column, The Reversed Status Order is : Admin Down , UP, Shutdown Warning, Down
  @SID_12
  Scenario: Validate Sorting by Status in Descending Order
    When UI Click Button "Sort By" with value "deviceStatus"
    Then UI Validate Table "Devices table" is Sorted by
      | columnName      | order      | compareMethod |
      | Status     | Descending  | SYSTEM_STATUS  |

  @SID_13
  Scenario: Validate Sorting by Default after Disable The Sorting by Current Status
    When UI Click Button "Sort By" with value "deviceStatus"
  # Validate Default Sorting
    Then UI Validate Table "Devices table" is Sorted by
      | columnName | order     | compareMethod |
      | Status     | Ascending | SYSTEM_STATUS  |

  #------------------------By Device Name----------------------

  #First Click on Current Throughput column
  @SID_14
  Scenario: Validate Sorting by Device Name in Ascending Order
    When UI Click Button "Sort By" with value "deviceName"
    Then UI Validate Table "Devices table" is Sorted by
      | columnName      | order     | compareMethod  |
      | Device Name     | Ascending | ALPHABETICAL   |

  #Second Click on Current Throughput column
  @SID_15
  Scenario: Validate Sorting by Device Name in Descending Order
    When UI Click Button "Sort By" with value "deviceName"
    Then UI Validate Table "Devices table" is Sorted by
      | columnName      | order      | compareMethod  |
      | Device Name     | Descending | ALPHABETICAL   |


  #Third Click on Current Throughput column
  @SID_16
  Scenario: Validate Sorting by Default after Disable The Sorting by Device Name
    When UI Click Button "Sort By" with value "deviceName"
  # Validate Default Sorting
    Then UI Validate Table "Devices table" is Sorted by
      | columnName | order     | compareMethod |
      | Status     | Ascending | SYSTEM_STATUS  |

  #------------------------By Managment IP----------------------

  #First Click on Current Throughput column
  @SID_17
  Scenario: Validate Sorting by Device IP in Ascending Order
    When UI Click Button "Sort By" with value "deviceIP"
    Then UI Validate Table "Devices table" is Sorted by
      | columnName      | order     | compareMethod  |
      | Management IP    | Ascending | IPORVERSIONS |

  #Second Click on Current Throughput column
  @SID_17
  Scenario: Validate Sorting by Device IP in Descending Order
    When UI Click Button "Sort By" with value "deviceIP"
    Then UI Validate Table "Devices table" is Sorted by
      | columnName      | order      | compareMethod  |
      | Management IP    | Descending | IPORVERSIONS |


  #Third Click on Current Throughput column
  @SID_18
  Scenario: Validate Sorting by Default after Disable The Sorting by Device IP
    When UI Click Button "Sort By" with value "deviceIP"
  # Validate Default Sorting
    Then UI Validate Table "Devices table" is Sorted by
      | columnName | order     | compareMethod |
      | Status     | Ascending | SYSTEM_STATUS  |

  #------------------------By Form Factory----------------------

  #First Click on Current Throughput column
  @SID_19
  Scenario: Validate Sorting by Form Factor in Ascending Order
    When UI Click Button "Sort By" with value "formFactor"
    Then UI Validate Table "Devices table" is Sorted by
      | columnName      | order     | compareMethod  |
      | Form Factor     | Ascending | ALPHABETICAL |

  #Second Click on Current Throughput column
  @SID_20
  Scenario: Validate Sorting by Form Factor in Descending Order
    When UI Click Button "Sort By" with value "formFactor"
    Then UI Validate Table "Devices table" is Sorted by
      | columnName      | order      | compareMethod  |
      | Form Factor     | Descending | ALPHABETICAL |


  #Third Click on Current Throughput column
  @SID_21
  Scenario: Validate Sorting by Default after Disable The Sorting by Form Factor
    When UI Click Button "Sort By" with value "formFactor"
  # Validate Default Sorting
    Then UI Validate Table "Devices table" is Sorted by
      | columnName | order     | compareMethod |
      | Status     | Ascending | SYSTEM_STATUS  |

  #------------------------By Version----------------------

  #First Click on Current Throughput column
  @SID_22
  Scenario: Validate Sorting by Version in Ascending Order
    When UI Click Button "Sort By" with value "softwareVersion"
    Then UI Validate Table "Devices table" is Sorted by
      | columnName      | order     | compareMethod  |
      | Version         | Ascending | IPORVERSIONS |

  #Second Click on Current Throughput column
  @SID_23
  Scenario: Validate Sorting by Version in Descending Order
    When UI Click Button "Sort By" with value "softwareVersion"
    Then UI Validate Table "Devices table" is Sorted by
      | columnName      | order      | compareMethod  |
      | Version         | Descending | IPORVERSIONS |

  @SID_24
  Scenario: Validate Sorting by Default after Disable The Sorting by Version
    When UI Click Button "Sort By" with value "softwareVersion"
  # Validate Default Sorting
    Then UI Validate Table "Devices table" is Sorted by
      | columnName | order     | compareMethod |
      | Status     | Ascending | SYSTEM_STATUS  |

  #Third Click on Current Throughput column
  @SID_25
  Scenario: Validate Table record tooltip values
    Then UI Validate Table record tooltip values with elementLabel "Device List.Table" findBy columnName "Status" findBy cellValue "Up"
      | columnName        | value         |
      | Status            | Up            |

    Then UI Validate Table record tooltip values with elementLabel "Device List.Table" findBy columnName "Status" findBy cellValue "Down"
      | columnName        | value         |
      | Status            | Down          |

    Then UI Validate Table record tooltip values with elementLabel "Device List.Table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.30"
      | columnName        | value         |
      | Device Name       | Alteon_50.50.101.30   |

    Then UI Validate Table record tooltip values with elementLabel "Device List.Table" findBy columnName "Management IP" findBy cellValue "50.50.101.21"
      | columnName        | value         |
      | Management IP     | 50.50.101.21  |

    Then UI Validate Table record tooltip values with elementLabel "Device List.Table" findBy columnName "Form Factor" findBy cellValue "VADC"
      | columnName        | value         |
      | Form Factor       | VADC          |

    Then UI Validate Table record tooltip values with elementLabel "Device List.Table" findBy columnName "Version" findBy cellValue "32.2.1.0"
      | columnName        | value         |
      | Version           | 32.2.1.0        |

    Then UI Validate Table record tooltip values with elementLabel "Device List.Table" findBy columnName "Platform" findBy cellValue "8420 SL"
      | columnName        | value         |
      | Platform          | 8420 SL       |

    Then UI Validate Table record tooltip values with elementLabel "Device List.Table" findBy columnName "High Availability Status" findBy cellValue "DISABLED"
      | columnName        | value         |
      | High Availability Status | DISABLED |

    Then UI Validate Table record tooltip values with elementLabel "Device List.Table" findBy columnName "CurrentThroughput (bps)" findBy cellValue "8.63 M"
      | columnName                | value     |
      | CurrentThroughput (bps)  | 8.63 M    |

    Then UI Validate Table record tooltip values with elementLabel "Device List.Table" findBy columnName "CPU Usage" findBy cellValue "77%"
      | columnName        | value         |
      | CPU usage         | 77%           |



  @SID_26
  Scenario: validate search table
    Then UI Validate search in table "Devices table" in searchLabel "searchLabel" with text "AC"
      | columnName    | Value          |
      | Management IP | 172.17.154.200 |
      | Management IP | 172.17.164.17  |
      | Management IP | 172.17.154.190 |
      | Management IP | 50.50.101.32   |
      | Management IP | 50.50.101.31   |
    Then UI Validate "Device List.Table" Table rows count equal to 5 with offset 0

    Then UI Validate search in table "Devices table" in searchLabel "searchLabel" with text "ac ACT"
      | columnName    | Value          |
      | Management IP | 172.17.154.200 |
      | Management IP | 172.17.154.190 |
      | Management IP | 50.50.101.32   |
    Then UI Validate "Device List.Table" Table rows count equal to 3 with offset 0

    Then UI Validate search in table "Devices table" in searchLabel "searchLabel" with text "ac ACT ST"
      | columnName    | Value          |
      | Management IP | 172.17.154.200 |
      | Management IP | 172.17.154.190 |
    Then UI Validate "Device List.Table" Table rows count equal to 2 with offset 0

    Then UI Validate search in table "Devices table" in searchLabel "searchLabel" with text "ac ACT ST 19"
      | columnName    | Value          |
      | Management IP | 172.17.154.190 |
    Then UI Validate "Device List.Table" Table rows count equal to 1 with offset 0





  @SID_27
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

    Then REST Update a scalar "snmpV2ReadCommunity" value of Request "Device Tree->Update SNMPv2 Read Community" on the device Ip "172.17.164.17" with the new scalar value "public"
    Then REST Update a scalar "snmpV2ReadCommunity" value of Request "Device Tree->Update SNMPv2 Read Community" on the device Ip "172.17.154.190" with the new scalar value "public"


    Then UI Click Edit device Then Submit to Refresh with IP "172.17.164.17" from topology tree "Sites and Devices"
    Then UI Click Edit device Then Submit to Refresh with IP "172.17.154.190" from topology tree "Sites and Devices"

    Then Browser Refresh Page
    Then UI Click Web element with id "gwt-debug-Global_Refresh"


  @SID_28
  Scenario: DPM 2nd Drill logout
    Then UI logout and close browser
