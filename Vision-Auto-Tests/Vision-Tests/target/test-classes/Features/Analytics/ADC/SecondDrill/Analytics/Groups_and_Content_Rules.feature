@Analytics_ADC

  @TC105975
Feature: DPM Second Drill - Groups and Content Rules Table
  @SID_1
  Scenario: Validate server fetched all applications after upgrade
    Given REST Vision Install License Request "vision-reporting-module-ADC"
    Then CLI copy "/home/radware/Scripts/fetch_num_of_real_alteons_apps.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/root/"
    Then Validate existence of Real Alteon Apps
    Then CLI Run remote linux Command "result=`curl -ks -X "POST" "https://localhost/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"radware\",\"password\": \"radware\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -k -XPOST -H "Cookie: JSESSIONID=$jsession" -d '{}' https://localhost:443/mgmt/system/monitor/dpm/alteon/fetch" on "ROOT_SERVER_CLI"

  @SID_2
  Scenario: Import driver script and jar file
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.2.1.0-DD-1.00-110.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"

  @SID_3
  Scenario: Upload Driver to vision
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.2.1.0-DD-1.00-110.jar" on "ROOT_SERVER_CLI" with timeOut 240
    Then Sleep "120"

  @SID_4
  Scenario: Login
    When UI Login with user "sys_admin" and password "radware"
    Then UI Open Upper Bar Item "ADC"
    Then UI Open "Dashboards" Tab
    Then UI Open "Application Dashboard" Sub Tab
    Then UI Open "Configurations" Tab
    Then UI Open Upper Bar Item "ADC"
    Then UI Open "Dashboards" Tab
    Then UI Open "Application Dashboard" Sub Tab

  @SID_5
  Scenario: Navigate to Virtual Service
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith_32326515:80"
    Then UI Text of "Virtual Service.Name" with extension "Rejith_32326515:80" equal to "Rejith_32326515:80"

#Validate Widgets Titles
  @SID_6
  Scenario: TC105516 Validate Table Title
    Then UI Text of "Virtual Service.Widget Title" with extension "Groups and Content Rules" equal to "Groups and Content Rules"


    #This is not the exact data which expected to get from Alteon , deu to Alteon Bug.
  @SID_7
  Scenario: TC105517 Validate Table Content
    #Content Rule ID = 1
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy columnName "Content-Rule or Default" findBy cellValue "101"
      | columnName              | value   |
      | Status                  | UP      |
      | Content-Rule or Default | 101     |
      | Action                  | Discard |
      | Group ID                |         |
      | Throughput(bps)         |         |
      | Connectionsper Second   |         |
      | Concurrent Connections  |         |

    #Content Rule ID = 2
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy columnName "Content-Rule or Default" findBy cellValue "105"
      | columnName              | value    |
      | Status                  | UP       |
      | Content-Rule or Default | 105      |
      | Action                  | Redirect |
      | Group ID                |          |
      | Throughput(bps)         |          |
      | Connectionsper Second   |          |
      | Concurrent Connections  |          |

    #Content Rule ID = 3
#    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy columnName "Content-Rule or Default" findBy cellValue "106"
#      | columnName                   | value |
#      | Status                       | UP    |
#      | Content-Rule or Default      | 106   |
#      | Action                       | Group |
#      | Group ID                     | 1     |
#      | Throughput(bps)      | 194   |
#      |  Connectionsper Second | 94    |
#      | Concurrent Connections       | 220   |

    #Content Rule ID = 4
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy columnName "Content-Rule or Default" findBy cellValue "107"
      | columnName              | value |
      | Status                  | UP    |
      | Content-Rule or Default | 107   |
      | Action                  | Group |
      | Group ID                | 1     |
      | Throughput(bps)         | 194   |
      | Connectionsper Second   | 94    |
      | Concurrent Connections  | 220   |

    #Content Rule ID = 5
#    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy columnName "Content-Rule or Default" findBy cellValue "7"
#      | columnName                   | value      |
#      | Status                       | Admin Down |
#      | Content-Rule or Default      | 7          |
#      | Action                       | Group      |
#      | Group ID                     | 3          |
#      | Throughput(bps)      | 145.24 M   |
#      |  Connectionsper Second | 100        |
#      | Concurrent Connections       | 0          |

    #Content Rule ID = 6
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy columnName "Content-Rule or Default" findBy cellValue "0"
      | columnName              | value      |
      | Status                  | Admin Down |
      | Content-Rule or Default | 0          |
      | Action                  | Group      |
      | Group ID                | 3          |
      | Throughput(bps)         | 145.24 M   |
      | Connectionsper Second   | 100        |
      | Concurrent Connections  | 0          |

    #Content Rule ID = 7
#    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy columnName "Content-Rule or Default" findBy cellValue "1"
#      | columnName                   | value   |
#      | Status                       | Warning |
#      | Content-Rule or Default      | 1       |
#      | Action                       | Group   |
#      | Group ID                     | 4       |
#      | Throughput(bps)      | 254     |
#      |  Connectionsper Second | 564,846 |
#      | Concurrent Connections       | 230     |

    #Content Rule ID = 8
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy columnName "Content-Rule or Default" findBy cellValue "5"
      | columnName              | value   |
      | Status                  | Warning |
      | Content-Rule or Default | 5       |
      | Action                  | Group   |
      | Group ID                | 4       |
      | Throughput(bps)         | 254     |
      | Connectionsper Second   | 564,846 |
      | Concurrent Connections  | 230     |

    #Content Rule ID = 9
#    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy columnName "Content-Rule or Default" findBy cellValue "100"
#      | columnName                   | value    |
#      | Status                       | Shutdown |
#      | Content-Rule or Default      | 100      |
#      | Action                       | Group    |
#      | Group ID                     | 5        |
#      | Throughput(bps)      | 1 G      |
#      |  Connectionsper Second | 89,498   |
#      | Concurrent Connections       | 240      |

    #Content Rule ID = 10
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy columnName "Content-Rule or Default" findBy cellValue "128"
      | columnName              | value    |
      | Status                  | Shutdown |
      | Content-Rule or Default | 128      |
      | Action                  | Group    |
      | Group ID                | 5        |
      | Throughput(bps)         | 1 G      |
      | Connectionsper Second   | 89,498   |
      | Concurrent Connections  | 240      |

    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy columnName "Content-Rule or Default" findBy cellValue "Default Action"
      | columnName              | value          |
      | Status                  | Down           |
      | Content-Rule or Default | Default Action |
      | Action                  | Group          |
      | Group ID                | 2              |
      | Throughput(bps)         | 86             |
      | Connectionsper Second   | 80             |
      | Concurrent Connections  | 210            |


    # =================================== Table Sorting ================================

  #Default Sorting
  @SID_8
  Scenario: TC105747 Validate Default Sorting by Content Rule Class id
    #Content Rule ID = 1
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 0
      | columnName              | value |
      | Content-Rule or Default | 101   |

    #Content Rule ID = 2
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 1
      | columnName              | value |
      | Content-Rule or Default | 105   |


    #Content Rule ID = 4
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 2
      | columnName              | value |
      | Content-Rule or Default | 107   |

    #Content Rule ID = 6
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 3
      | columnName              | value |
      | Content-Rule or Default | 0     |

    #Content Rule ID = 8
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 4
      | columnName              | value |
      | Content-Rule or Default | 5     |

    #Content Rule ID = 10
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 5
      | columnName              | value |
      | Content-Rule or Default | 128   |


  #This Scenario was separated from the previous one because of an open defect on it.
  @SID_9
  Scenario: TC105748 Validate Default Action at Last Row in Default Sort
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 6
      | columnName              | value          |
      | Content-Rule or Default | Default Action |

  #------------------------By Status----------------------
  #First Click on Status column , The Default Status Order is : Down , Warning, Shutdown, Up, Admin Down
  @SID_10
  Scenario: TC105749 Validate Sorting by Status in Ascending Order
    When UI Click Button "Sort By" with value "healthScore"
    Then UI Validate Table "Virtual Service.Table" is Sorted by
      | columnName | order     | compareMethod |
      | Status     | Ascending | HEALTH_SCORE  |
  #Second Click on Status column, The Reversed Status Order is : Admin Down , UP, Shutdown Warning, Down
  @SID_11
  Scenario: TC105750 Validate Sorting by Status in Descending Order
    When UI Click Button "Sort By" with value "healthScore"
    Then UI Validate Table "Virtual Service.Table" is Sorted by
      | columnName | order      | compareMethod |
      | Status     | Descending | HEALTH_SCORE  |

  #Third Click on Status column
  @SID_12
  Scenario: TC105751 Validate Sorting by Default after Disable The Sorting by Status
    When UI Click Button "Sort By" with value "healthScore"
#Content Rule ID = 1
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 0
      | columnName              | value |
      | Content-Rule or Default | 101   |

    #Content Rule ID = 2
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 1
      | columnName              | value |
      | Content-Rule or Default | 105   |

    #Content Rule ID = 4
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 2
      | columnName              | value |
      | Content-Rule or Default | 107   |

    #Content Rule ID = 6
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 3
      | columnName              | value |
      | Content-Rule or Default | 0     |

    #Content Rule ID = 8
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 4
      | columnName              | value |
      | Content-Rule or Default | 5     |

    #Content Rule ID = 10
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 5
      | columnName              | value |
      | Content-Rule or Default | 128   |

  #This Scenario was separated from the previous one because of an open defect on it.
  @SID_13
  Scenario: TC105752 Validate Default Action at Last Row after Disable The Sorting by Status
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 6
      | columnName              | value          |
      | Content-Rule or Default | Default Action |
  #------------------------By Current Throughput----------------------

  #First Click on Current Throughput column
  @SID_14
  Scenario: TC105753 Validate Sorting by Current Throughput in Ascending Order
    When UI Click Button "Sort By" with value "throughput"
    Then UI Validate Table "Virtual Service.Table" is Sorted by
      | columnName      | order     | compareMethod  |
      | Throughput(bps) | Ascending | BIT_BYTE_UNITS |

  #Second Click on Current Throughput column
  @SID_15
  Scenario: TC105754 Validate Sorting by Current Throughput in Descending Order
    When UI Click Button "Sort By" with value "throughput"
    Then UI Validate Table "Virtual Service.Table" is Sorted by
      | columnName      | order      | compareMethod  |
      | Throughput(bps) | Descending | BIT_BYTE_UNITS |

  #Third Click on Current Throughput column
  @SID_16
  Scenario: TC105755 Validate Sorting by Default after Disable The Sorting by Current Throughput
    When UI Click Button "Sort By" with value "throughput"
#Content Rule ID = 1
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 0
      | columnName              | value |
      | Content-Rule or Default | 101   |

    #Content Rule ID = 2
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 1
      | columnName              | value |
      | Content-Rule or Default | 105   |

    #Content Rule ID = 4
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 2
      | columnName              | value |
      | Content-Rule or Default | 107   |

    #Content Rule ID = 6
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 3
      | columnName              | value |
      | Content-Rule or Default | 0     |

    #Content Rule ID = 8
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 4
      | columnName              | value |
      | Content-Rule or Default | 5     |

    #Content Rule ID = 10
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 5
      | columnName              | value |
      | Content-Rule or Default | 128   |

  #This Scenario was separated from the previous one because of an open defect on it.
  @SID_17
  Scenario: TC105756 Validate Default Action at Last Row after Disable The Sorting by Current Throughput
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 6
      | columnName              | value          |
      | Content-Rule or Default | Default Action |

  #------------------------By Current Connections----------------------

  #First Click on Current Connections column
  @SID_18
  Scenario: TC105757 Validate Sorting by Current Connections in Ascending Order
    When UI Click Button "Sort By" with value "cps"
    Then UI Validate Table "Virtual Service.Table" is Sorted by
      | columnName             | order     | compareMethod |
      | Connectionsper Second | Ascending | NUMERICAL     |

  #Second Click on Current Connections column
  @SID_19
  Scenario: TC105758 Validate Sorting by Current Connections in Descending Order
    When UI Click Button "Sort By" with value "cps"
    Then UI Validate Table "Virtual Service.Table" is Sorted by
      | columnName             | order      | compareMethod |
      | Connectionsper Second | Descending | NUMERICAL     |

  #Third Click on Current Connections column
  @SID_20
  Scenario: TC105759 Validate Sorting by Default after Disable The Sorting by Current Connections
    When UI Click Button "Sort By" with value "cps"
#Content Rule ID = 1
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 0
      | columnName              | value |
      | Content-Rule or Default | 101   |

    #Content Rule ID = 2
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 1
      | columnName              | value |
      | Content-Rule or Default | 105   |

    #Content Rule ID = 4
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 2
      | columnName              | value |
      | Content-Rule or Default | 107   |

    #Content Rule ID = 6
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 3
      | columnName              | value |
      | Content-Rule or Default | 0     |

    #Content Rule ID = 8
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 4
      | columnName              | value |
      | Content-Rule or Default | 5     |

    #Content Rule ID = 10
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 5
      | columnName              | value |
      | Content-Rule or Default | 128   |

  #This Scenario was separated from the previous one because of an open defect on it.
  @SID_21
  Scenario: TC105760 Validate Default Action at Last Row after Disable The Sorting by Current Connections
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 6
      | columnName              | value          |
      | Content-Rule or Default | Default Action |
  #------------------------By Concurrent Connections----------------------

  #First Click on Concurrent Connections column
  @SID_22
  Scenario: TC105762 Validate Sorting by Concurrent Connections in Ascending Order
    When UI Click Button "Sort By" with value "concurrentConnections"
    Then UI Validate Table "Virtual Service.Table" is Sorted by
      | columnName             | order     | compareMethod |
      | Concurrent Connections | Ascending | NUMERICAL     |

  #Second Click on Concurrent Connections column
  @SID_23
  Scenario: TC105763 Validate Sorting by Concurrent Connections in Descending Order
    When UI Click Button "Sort By" with value "concurrentConnections"
    Then UI Validate Table "Virtual Service.Table" is Sorted by
      | columnName             | order      | compareMethod |
      | Concurrent Connections | Descending | NUMERICAL     |

  #Third Click on Concurrent Connections column
  @SID_24
  Scenario: TC105764 Validate Sorting by Default after Disable The Sorting by Concurrent Connections
    When UI Click Button "Sort By" with value "concurrentConnections"
#Content Rule ID = 1
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 0
      | columnName              | value |
      | Content-Rule or Default | 101   |

    #Content Rule ID = 2
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 1
      | columnName              | value |
      | Content-Rule or Default | 105   |

    #Content Rule ID = 4
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 2
      | columnName              | value |
      | Content-Rule or Default | 107   |

    #Content Rule ID = 6
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 3
      | columnName              | value |
      | Content-Rule or Default | 0     |

    #Content Rule ID = 8
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 4
      | columnName              | value |
      | Content-Rule or Default | 5     |

    #Content Rule ID = 10
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 5
      | columnName              | value |
      | Content-Rule or Default | 128   |


  #This Scenario was separated from the previous one because of an open defect on it.
  @SID_25
  Scenario: TC105765 Validate Default Action at Last Row after Disable The Sorting by Concurrent Connections
    Then UI Validate Table record values by columns with elementLabel "Virtual Service.Table" findBy index 6
      | columnName              | value          |
      | Content-Rule or Default | Default Action |

  @SID_26
  Scenario: DPM 2nd Drill logout
    Then UI logout and close browser
