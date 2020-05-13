@TC114832
Feature: attackTable

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-attack*"
    * REST Delete ES index "dp-tr*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 11 with loopDelay 15000
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000
    Given CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 11
    And CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10 and wait 230 seconds

    When CLI Run remote linux Command "^C" on "ROOT_SERVER_CLI"
    Then Sleep "10"
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"status":"Terminated"}},"script":{"source":"ctx._source.startTime='$(date -d "-2 hour" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"
    Then Sleep "5"
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"status":"Terminated"}},"script":{"source":"ctx._source.endTime='$(date -d "-1 hour" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"status":"Terminated"}},"script":{"source":"ctx._source.endTime='$(date -d "-1 hour" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"status":"Terminated"}},"script":{"source":"ctx._source.endTime='$(date -d "-1 hour" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"status":"Terminated"}},"script":{"source":"ctx._source.endTime='$(date -d "-1 hour" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"

    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-traffic-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"deviceIp":"172.16.22.51"}},"script":{"source":"ctx._source.timeStamp='$(date -d "-1 hour" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"


  @SID_3
  Scenario:  login
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "2"
    And UI Navigate to "DefensePro Attacks" page via homePage

  @SID_4
  Scenario: validate the table count
    Then UI Validate "Attacks Table" Table rows count EQUALS to 14

  @SID_5
  Scenario: validate scope selection with table
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |
    Then UI Validate "Attacks Table" Table rows count EQUALS to 12

    Then UI Validate search in table "Attacks Table" in searchLabel "tableSearch" with text "ACL"
      | columnName  | Value               |
      | Attack Name | Black List          |
      | Attack Name | TCP Mid Flow packet |
    Then UI Validate "Attacks Table" Table rows count EQUALS to 6

  @SID_6
  Scenario: validate all the data
    And UI Navigate to "HOME" page via homePage
    And UI Navigate to "DefensePro Attacks" page via homePage
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |

    And UI Do Operation "Select" item "Global Time Filter"
    Then Sleep "1"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
    Then UI Validate "Attacks Table" Table rows count EQUALS to 35


  @SID_7
  Scenario: validate sampleData
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Policy Name" findBy cellValue "Black_IPV6"
    Then UI Click Button "Sample Data Button" with value ""
    Then UI Validate "SampleDataTable" Table rows count EQUALS to 2
    Then UI Click Button "closeTable"


  @SID_8
  Scenario: validate the frames1
    And UI Navigate to "HOME" page via homePage
    And UI Navigate to "DefensePro Attacks" page via homePage

    Then UI Select Time From: 0 To: 2 Time, in Line Chart data "Attacks Dashboard Traffic Widget" with timeFormat "yyyy-MM-dd'T'HH:mm:ssXXX"
    Then UI Validate "Attacks Table" Table rows count EQUALS to 6

  @SID_9
  Scenario: Validate downloaded capture file
    And UI Do Operation "Select" item "Global Time Filter"
    Then Sleep "1"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
    Then Delete downloaded file with name "attack_7839-1402580209_packets.cap"
    When UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Destination Ports" findBy cellValue "1025"
    And UI Click Button "PCAP"
    Then Validate downloaded file size with name "attack_7839-1402580209_packets.cap" equal to 7
    Then Delete downloaded file with name "attack_7839-1402580209_packets.cap"
    And UI logout and close browser




