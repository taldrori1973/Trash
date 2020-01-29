@Analytics_ADC

@TC105977
Feature: ADC Application Second Drill - Global Tests

  @SID_1 @Sanity
  Scenario: Validate server fetched all applications after upgrade
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Then REST Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    Then CLI copy "/home/radware/Scripts/fetch_num_of_real_alteons_apps.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/root/"
#    Then REST Login with activation with user "radware" and password "radware"
    Then Validate existence of Real Alteon Apps
    Then CLI Run remote linux Command "result=`curl -ks -X "POST" "https://localhost/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"radware\",\"password\": \"radware\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -k -XPOST -H "Cookie: JSESSIONID=$jsession" -d '{}' https://localhost:443/mgmt/system/monitor/dpm/alteon/fetch" on "ROOT_SERVER_CLI"
  @SID_2 @Sanity
  Scenario: Import driver script and jar file
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.2.1.0-DD-1.00-110.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"

  @SID_3 @Sanity
  Scenario: Upload Driver to vision
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.2.1.0-DD-1.00-110.jar" on "ROOT_SERVER_CLI" with timeOut 240

  @SID_4 @Sanity
  Scenario: Login
    When UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "ADC Reports" page via homePage
    And UI Navigate to "Application Dashboard" page via homePage

  @SID_5 @Sanity
  Scenario: Navigate to Virtual Service
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith_32326515:80"
    Then UI Validate Text field "Virtual Service.Name" with params "Rejith_32326515:80" EQUALS "Rejith_32326515:80"

    #=====================Start of Validate Time Ranges===============
  @SID_6
  Scenario: TC105601 Validate Time Range of 2 minutes
    When UI Click Button "Global Time Filter"
    Then UI Click Button "Global Time Filter.Quick Range" with value "2m"
      #will test only RPS and one of the other charts because all of them are with same behavior
    Then UI Validate Line Chart data "THROUGHPUT" with Label "Throughput"
      | value | count | offset |
      | 11    | 4     | 1      |

    Then UI Validate Line Chart data "REQUESTS PER SECOND" with Label "HTTP 2"
      | value | count | offset |
      | 15    | 4     | 1      |
    Then UI Validate Line Chart data "REQUESTS PER SECOND" with Label "HTTP 1.1"
      | value | count | offset |
      | 16    | 4     | 1      |
    Then UI Validate Line Chart data "REQUESTS PER SECOND" with Label "HTTP 1.0"
      | value | count | offset |
      | 17    | 4     | 1      |

    #=====================End of Validate Time Ranges=================
  @SID_7
  Scenario: TC105604 Validate Go Back to Dashboard Button
    When UI Click Button "GO BACK"
    Then UI Text of "Virtual Service.Widget Title" with extension "Summary" equal to "Summary"
  @SID_8
  Scenario: Navigate to Virtual Service
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith_32326515:443"
    Then UI Validate Text field "Virtual Service.Name" with params "Rejith_32326515:443" EQUALS "Rejith_32326515:443"
  @SID_9
  Scenario: TC105603 Validate Analytics And SSL Toolbar Tabs
    When UI Click Button "Virtual Service.Toolbar Tab" with value "ssl"
    Then UI Text of "Virtual Service.Widget Title" with extension "SSL Connections per Second" equal to "SSL Connections per Second"
    When UI Click Button "Virtual Service.Toolbar Tab" with value "analytics"
    Then UI Text of "Virtual Service.Widget Title" with extension "Throughput (bps)" equal to "Throughput (bps)"

  @SID_10 @Sanity
  Scenario: DPM 2nd Drill logout
    Then UI logout and close browser
