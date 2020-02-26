@Analytics_ADC
@TC106142

Feature: VRM ADC Application dashboard 3rd Drill

  @SID_1
  Scenario: Validate server fetched all applications after upgrade
    Then REST Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-reporting-module-ADC"
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
    Then UI Navigate to "Application Dashboard" page via homePage


  @SID_5
  Scenario: Navigate to Virtual Service
    Then Sleep "1"
    Then UI click Table row by keyValue or Index with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith_32326515:80"
    Then UI Validate Text field "Virtual Service.Name" with params "Rejith_32326515:80" EQUALS "Rejith_32326515:80"
    Then UI "expand" Table row by keyValue or Index with elementLabel "Virtual Service.Table" findBy columnName "Group ID" findBy cellValue "1"

  @SID_6
  Scenario: validate Conetent Rule Expand Row Widgets Titles
    Then UI Text of "Expand chart title" with extension "Rejith_32326515:80-chart-title-throughput" equal to "Throughput (bps)"
    Then UI Text of "Expand chart title" with extension "Rejith_32326515:80-chart-title-cps" equal to "Connections per Second"
    Then UI Text of "Expand chart title" with extension "Rejith_32326515:80-chart-title-concurrentConnections" equal to "Concurrent Connections"


  @SID_7
  Scenario: Validate Conetent Rule Expand Row THROUGHPUT widget
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW THROUGHPUT" with Label "1"
      | value | count | offset |
      | 29    | 30    | 2      |
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW THROUGHPUT" with Label "10"
      | value | count | offset |
      | 34    | 30    | 2      |
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW THROUGHPUT" with Label "Real4"
      | value | count | offset |
      | 83    | 30    | 2      |
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW THROUGHPUT" with Label "123abc"
      | value | count | offset |
      | 54    | 30    | 2      |
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW THROUGHPUT" with Label "123456789abcdefghijklmno...vwxyz"
      | value | count | offset |
      | 59    | 30    | 2      |

  @SID_8
  Scenario: Validate Content Rule Expand Row Connections per Second widget
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW CPS" with Label "1"
      | value | count | offset |
      | 31    | 30    | 2      |
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW CPS" with Label "10"
      | value | count | offset |
      | 37    | 30    | 2      |
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW CPS" with Label "Real4"
      | value | count | offset |
      | 85    | 30    | 2      |
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW CPS" with Label "123abc"
      | value | count | offset |
      | 56    | 30    | 2      |
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW CPS" with Label "123456789abcdefghijklmno...vwxyz"
      | value | count | offset |
      | 61    | 30    | 2      |

  @SID_9
  Scenario: Validate Content Rule Expand Row Concurrent Connections widget
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW CONCURRENT CONNECTIONS" with Label "1"
      | value | count | offset |
      | 32    | 30    | 2      |
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW CONCURRENT CONNECTIONS" with Label "10"
      | value | count | offset |
      | 35    | 30    | 2      |
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW CONCURRENT CONNECTIONS" with Label "Real4"
      | value | count | offset |
      | 86    | 30    | 2      |
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW CONCURRENT CONNECTIONS" with Label "123abc"
      | value | count | offset |
      | 57    | 30    | 2      |
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW CONCURRENT CONNECTIONS" with Label "123456789abcdefghijklmno...vwxyz"
      | value | count | offset |
      | 62    | 30    | 2      |

  @SID_10
  Scenario: Validate Validate Content Rule Expand Row Current texts
    Then UI Text of "Throughput current" with extension "2-Rejith_32326515:80" equal to "Current 259"
    Then UI Text of "cps current" with extension "2-Rejith_32326515:80" equal to "Current 270"
    Then UI Text of "Concurrent Connections current" with extension "2-Rejith_32326515:80" equal to "Current 272"

  @SID_11
  Scenario: Validate Charts after filtering
    When UI Click Button "filter by" with value "Rejith_32326515:80-legend-list-item-10-filter"
    Then UI Click Button "filter by" with value "Rejith_32326515:80-legend-list-item-123abc-filter"
    Then UI Click Button "filter by" with value "Rejith_32326515:80-legend-list-item-Real1-filter"

  @SID_12
  Scenario: Validate Content Rule Expand Row THROUGHPUT widget
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW THROUGHPUT" with Label "1"
      | value | count | offset |
      | 29    | 30    | 2      |
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW THROUGHPUT" with Label "Real4"
      | value | count | offset |
      | 83    | 30    | 2      |
#    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW THROUGHPUT" with Label "Real1"
#      | value | count | offset |
#      | 69    | 30    | 2      |
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW THROUGHPUT" with Label "123456789abcdefghijklmno...vwxyz"
      | value | count | offset |
      | 59    | 30    | 2      |

  @SID_13
  Scenario: Validate Content Rule Expand Row Connections per Second widget
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW CPS" with Label "1"
      | value | count | offset |
      | 31    | 30    | 2      |
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW CPS" with Label "Real4"
      | value | count | offset |
      | 85    | 30    | 2      |
#    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW CPS" with Label "Real1"
#      | value | count | offset |
#      | 71    | 30    | 2      |
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW CPS" with Label "123456789abcdefghijklmno...vwxyz"
      | value | count | offset |
      | 61    | 30    | 2      |

  @SID_14
  Scenario: Validate Content Rule Expand Row Concurrent Connections widget
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW CONCURRENT CONNECTIONS" with Label "1"
      | value | count | offset |
      | 32    | 30    | 2      |
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW CONCURRENT CONNECTIONS" with Label "Real4"
      | value | count | offset |
      | 86    | 30    | 2      |
#    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW CONCURRENT CONNECTIONS" with Label "Real1"
#      | value | count | offset |
#      | 72    | 30    | 2      |
    Then UI Validate Line Chart data "CONTENT RULE EXPAND ROW CONCURRENT CONNECTIONS" with Label "123456789abcdefghijklmno...vwxyz"
      | value | count | offset |
      | 62    | 30    | 2      |

  @SID_15
  Scenario: Validate Content Rule Expand Row Current texts after filter.
    Then UI Text of "Throughput current" with extension "2-Rejith_32326515:80" equal to "Current 171"
    Then UI Text of "cps current" with extension "2-Rejith_32326515:80" equal to "Current 177"
    Then UI Text of "Concurrent Connections current" with extension "2-Rejith_32326515:80" equal to "Current 180"

  @SID_16
  Scenario: validate sorting Servers information by Status
    When UI Click Button "Show In Table"
    When UI Click Button "sort by" with value "Status"
    Then UI Validate Table "Servers information" is Sorted by
      | columnName  | order     | compareMethod |
      | Status      | Ascending | HEALTH_SCORE  |
      | Server Name | Ascending | ALPHABETICAL  |
    When UI Click Button "sort by" with value "Status"
    Then UI Validate Table "Servers information" is Sorted by
      | columnName  | order      | compareMethod |
      | Status      | Descending | HEALTH_SCORE  |
      | Server Name | Ascending  | ALPHABETICAL  |
    When UI Click Button "sort by" with value "Status"
    When UI Click Button "sort by" with value "Server Name"
    Then UI Validate Table "Servers information" is Sorted by
      | columnName  | order     | compareMethod |
      | Server Name | Ascending | ALPHABETICAL  |
    When UI Click Button "sort by" with value "Server Name"
    Then UI Validate Table "Servers information" is Sorted by
      | columnName  | order      | compareMethod |
      | Server Name | Descending | ALPHABETICAL  |
    When UI Click Button "close popup table"

  @SID_17
  Scenario: Cleanup
    Then UI logout and close browser