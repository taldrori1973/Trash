@Analytics_ADC
@TC105974

Feature: DPM Second Drill - Validate End to End Time Section

  @SID_1
  Scenario: Import driver script and jar file
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.2.1.0-DD-1.00-110.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"

  @SID_2
  Scenario: Upload Driver to vision
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.2.1.0-DD-1.00-110.jar" on "ROOT_SERVER_CLI" with timeOut 240
    Then Sleep "120"

  @SID_3
  Scenario: Validate server fetched all applications after upgrade
    Given REST Vision Install License Request "vision-reporting-module-ADC"
    Then CLI copy "/home/radware/Scripts/fetch_num_of_real_alteons_apps.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/root/"
    Then Validate existence of Real Alteon Apps
    Then CLI Run remote linux Command "result=`curl -ks -X "POST" "https://localhost/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"radware\",\"password\": \"radware\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -k -XPOST -H "Cookie: JSESSIONID=$jsession" -d '{}' https://localhost:443/mgmt/system/monitor/dpm/alteon/fetch" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario: Login and go to DPM dashboard
    When UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "Application Dashboard" page via homePage

  @SID_5
  Scenario: Navigate to Virtual Service
    Then Sleep "3"
#    Then UI click Table row by keyValue or Index with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith_32326515:80"
    Then UI click Table row by keyValue or Index with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith_32326517:80"
#    Then UI Validate Text field "Virtual Service.Name" with params "Rejith_32326515:80" EQUALS "Rejith_32326515:80"
    Then UI Validate Text field "Virtual Service.Name" with params "Rejith_32326515:80" EQUALS "Rejith_32326517:80"

    #Validate Widget Title
  @SID_6
  Scenario: Validate End to End Time Widget Title
    Then UI Text of "Virtual Service.Widget Title" with extension "End-to-End Time" equal to "End-to-End Time"

  @SID_7
  Scenario: Validate End to End Time top widget
    Then UI Text of "Virtual Service.Current Total" with extension "value" equal to "2038.12 sec"
    Then UI Text of "Virtual Service.Current Total" with extension "title" equal to "Current Total"
    Then UI Text of "Virtual Service.Client RTT" with extension "value" equal to "0.00 ms"
    Then UI Text of "Virtual Service.Client RTT" with extension "title" equal to "Client RTT"
    Then UI Text of "Virtual Service.Server RTT" with extension "value" equal to "0.78 ms"
    Then UI Text of "Virtual Service.Server RTT" with extension "title" equal to "Server RTT"
    Then UI Text of "Virtual Service.App Response Time" with extension "value" equal to "2038.11 sec"
    Then UI Text of "Virtual Service.App Response Time" with extension "title" equal to "App Response Time"
    Then UI Text of "Virtual Service.Response Transfer Time" with extension "value" equal to "1.00 ms"
    Then UI Text of "Virtual Service.Response Transfer Time" with extension "title" equal to "Response Transfer Time"

  @SID_8
  Scenario: Validate End to End Time Line Chart
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    Then UI Validate Line Chart data "End-To-End Time" with Label "Client RTT"
      | value | count | offset |
      | 0     | 4     | 2      |
    Then UI Validate Line Chart data "End-To-End Time" with Label "Server RTT"
      | value | count | offset |
      | 0.78  | 4     | 2      |
    Then UI Validate Line Chart data "End-To-End Time" with Label "App Response Time"
      | value       | count | offset |
      | 2038114.218 | 4     | 2      |
    Then UI Validate Line Chart data "End-To-End Time" with Label "Response Transfer Time"
      | value | count | offset |
      | 1     | 4     | 2      |


  @SID_9
  Scenario:  Validate End to End Time Line Charts Attributes
    Then UI Validate Line Chart attributes "End-To-End Time" with Label "Client RTT"
      | attribute       | value   |
      | backgroundColor | #F1BEBE |
    Then UI Validate Line Chart attributes "End-To-End Time" with Label "Server RTT"
      | attribute       | value   |
      | backgroundColor | #9BB1C8 |
    Then UI Validate Line Chart attributes "End-To-End Time" with Label "App Response Time"
      | attribute       | value   |
      | backgroundColor | #8FCBD7 |
    Then UI Validate Line Chart attributes "End-To-End Time" with Label "Response Transfer Time"
      | attribute       | value   |
      | backgroundColor | #4E6D8D |

  @SID_10
  Scenario: DPM 2nd Drill logout
    Then UI logout and close browser