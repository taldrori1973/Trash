Feature: attackTable

@SID_1
Scenario: Clean system data
* CLI kill all simulator attacks on current vision
* REST Delete ES index "dp-attack*"
* REST Delete ES index "dp-tr*"
* CLI Clear vision logs

@SID_2
Scenario: Run DP simulator
Given CLI simulate 10 attacks of type "VRM_attacks" on "DefensePro" 10
And CLI simulate 2 attacks of type "VRM_attacks" on "DefensePro" 11
And CLI simulate 2 attacks of type "https_new2" on "DefensePro" 10
Given CLI simulate 1 attacks of type "pps_traps" on "DefensePro" 11 with loopDelay 15000 and wait 230 seconds


When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"ruleName":"shlomi"}},"script":{"source":"ctx._source.startTime='$(date -d "-2 hour" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"
Then Sleep "10"
When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"status":"Occurred"}},"script":{"source":"ctx._source.status='Terminated'"}}'" on "ROOT_SERVER_CLI"
When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"ruleName":"shlomi"}},"script":{"source":"ctx._source.endTime='$(date -d "-1 hour" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"





Scenario:  login
Given UI Login with user "radware" and password "radware"
Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
Then Sleep "2"
And UI Navigate to "AMS Attacks" page via homePage


Scenario: validate the table count
Then UI Validate "Attacks Table" Table rows count EQUALS to 32

Scenario: validate scope selection with table
Then UI Do Operation "Select" item "Device Selection"
Then UI VRM Select device from dashboard and Save Filter
| index | ports | policies |
| 10    |       |          |
Then UI Validate "Attacks Table" Table rows count EQUALS to 11

Then UI Validate search in table "Attacks Table" in searchLabel "tableSearch" with text "ACL"
| columnName    | Value          |
| Attack Name | Black List |
Then UI Validate "Attacks Table" Table rows count EQUALS to 1




Scenario: validate all the data
Then UI Do Operation "Select" item "Device Selection"
Then UI VRM Select device from dashboard and Save Filter
| index | ports | policies |

And UI Do Operation "Select" item "Global Time Filter"
Then Sleep "1"
And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
Then UI Validate "Attacks Table" Table rows count EQUALS to 37



