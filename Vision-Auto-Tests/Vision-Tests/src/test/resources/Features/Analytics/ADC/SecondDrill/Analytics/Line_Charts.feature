@Analytics_ADC
@TC105976
Feature: Second Drill - Validate General Charts

  @SID_1
  Scenario: Import driver script and jar file
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.2.1.0-DD-1.00-110.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.4.0.0-DD-1.00-396.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"

  @SID_2
  Scenario: Upload Driver to vision
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.2.1.0-DD-1.00-110.jar" on "ROOT_SERVER_CLI" with timeOut 240
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.4.0.0-DD-1.00-396.jar" on "ROOT_SERVER_CLI" with timeOut 240

  @SID_3
  Scenario: Validate server fetched all applications after upgrade
    Given REST Vision Install License Request "vision-reporting-module-ADC"
    Then CLI copy "/home/radware/Scripts/fetch_num_of_real_alteons_apps.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/root/"
    Then Validate existence of Real Alteon Apps
    Then CLI Run remote linux Command "result=`curl -ks -X "POST" "https://localhost/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"radware\",\"password\": \"radware\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -k -XPOST -H "Cookie: JSESSIONID=$jsession" -d '{}' https://localhost:443/mgmt/system/monitor/dpm/alteon/fetch" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario: Login and move to ADC application dashboard
    When UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "Application Dashboard" page via homePage
  @SID_5
  Scenario: Navigate to Virtual Service
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith_32326515:80"
    Then UI Validate Text field "Virtual Service.Name" with params "Rejith_32326515:80" EQUALS "Rejith_32326515:80"
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"

#Validate Widgets Titles
  @SID_6
  Scenario: TC105363 Validate Right Side Diagrams Line Charts Titles
    Then UI Text of "Virtual Service.Widget Title" with extension "Throughput (bps)" equal to "Throughput (bps)"
    Then UI Text of "Virtual Service.Widget Title" with extension "Concurrent Connections" equal to "Concurrent Connections"
    Then UI Text of "Virtual Service.Widget Title" with extension "Connections per Second" equal to "Connections per Second"
    Then UI Text of "Virtual Service.Widget Title" with extension "Requests per Second" equal to "Requests per Second"


# Validate Charts with data on time range : 2m
  @SID_7
  Scenario: TC105291 Validate Virtual Service Throughput widget
    Then UI Validate Line Chart data "THROUGHPUT" with Label "Throughput"
      | value | count | offset |
      | 11    | 5     | 2      |

  @SID_8
  Scenario: TC105292 Validate Virtual Service Connection per Second - cps widget
    Then UI Validate Line Chart data "CPS" with Label "Connections per Second"
      | value | count | offset |
      | 13    | 5     | 2      |

  @SID_9
  Scenario: TC105293 Validate Virtual Service Concurrent Connections widget
    Then UI Validate Line Chart data "CONCURRENT CONNECTIONS" with Label "Concurrent Connections"
      | value | count | offset |
      | 14    | 5     | 2      |

  @SID_10
  Scenario: TC105294 Validate Virtual Service Requests per Second widget
    Then UI Validate Line Chart data "REQUESTS PER SECOND" with Label "HTTP 2"
      | value | count | offset |
      | 15    | 5     | 2      |
    Then UI Validate Line Chart data "REQUESTS PER SECOND" with Label "HTTP 1.1"
      | value | count | offset |
      | 16    | 5     | 2      |
    Then UI Validate Line Chart data "REQUESTS PER SECOND" with Label "HTTP 1.0"
      | value | count | offset |
      | 17    | 5     | 2      |


  @SID_11
  Scenario: Validate Virtual Service Line Charts Attributes
    Then UI Validate Line Chart attributes "THROUGHPUT" with Label "Throughput"
      | attribute       | value                 |
      | backgroundColor | rgba(95, 173, 226,1) |

    Then UI Validate Line Chart attributes "CPS" with Label "Connections per Second"
      | attribute       | value                  |
      | backgroundColor | rgba(169, 203, 226,1) |


    Then UI Validate Line Chart attributes "CONCURRENT CONNECTIONS" with Label "Concurrent Connections"
      | attribute       | value                  |
      | backgroundColor | rgba(166, 228, 246,1) |


    Then UI Validate Line Chart attributes "REQUESTS PER SECOND" with Label "HTTP 2"
      | attribute       | value                   |
      | backgroundColor | rgba(145, 196, 231,1) |
    Then UI Validate Line Chart attributes "REQUESTS PER SECOND" with Label "HTTP 1.1"
      | attribute       | value                    |
      | backgroundColor | rgba(122, 174, 210,1) |
    Then UI Validate Line Chart attributes "REQUESTS PER SECOND" with Label "HTTP 1.0"
      | attribute       | value                   |
      | backgroundColor | rgba(166, 228, 246,1) |

  @SID_12
  Scenario: DPM 2nd Drill logout
    Then UI logout and close browser
