Feature: PolicyCPU



@SID_1
Scenario: Clean system data before Traffic Bandwidth test
* CLI kill all simulator attacks on current vision
* REST Delete ES index "dp-*"
* CLI Clear vision logs

@SID_2
Scenario: Run DP simulator PCAPs for Traffic Bandwidth
Given CLI simulate 1000 attacks of type "dp_two_policies.pcap" on "DefensePro" 11 with loopDelay 15000
Given CLI simulate 1000 attacks of type "dp_two_policies.pcap" on "DefensePro" 10 with loopDelay 15000 and wait 120 seconds

@SID_3
Scenario: change the date
When CLI Run remote linux Command "^C" on "ROOT_SERVER_CLI"
Then Sleep "10"
When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-concurrent-connection-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"policyUtil":"61"}},"script":{"source":"ctx._source._id='aaaa'"}}'" on "ROOT_SERVER_CLI"
When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"_id":"aaaa"}},"script":{"source":"ctx._source.timestamp='$(date -d "-1 hour" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"
Then Sleep "5"
When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"_id":"aaaa"}},"script":{"source":"ctx._source.recivedTimestamp='$(date -d "-1 hour" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"


@SID_4
Scenario:  login
Given UI Login with user "sys_admin" and password "radware"
Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
Then Sleep "2"
Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage



@SID_5
Scenario: validate that the overloaded devices forom
Then UI Validate Text field "numberOverloadedDevices" EQUALS "1"
Then UI Click Button "overloadedDevicesButton"
Then UI Validate Text field "deviceName" EQUALS "DefensePro_172.16.22.50"
Then UI Validate Text field "cpuDeviceNumber" EQUALS "59"
Then UI Click Button "deviceName"
Then UI Validate Text field "cpuPolicyName" with params "1" EQUALS "puPolicy1"
Then UI Validate Text field "cpuPolicyValue" with params "1" EQUALS "59"
Then UI Validate Text field "cpuPolicyName" with params "2" EQUALS "puPolicy2"
Then UI Validate Text field "cpuPolicyValue" with params "2" EQUALS "0"


@SID_7
Scenario: enter to drill-2
Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "puPolicy"


@SID_8
Scenario: validate PolicyCPU Utilization
Then UI Validate Line Chart data "DP Policy Traffic Utilization underAttack Widget" with Label "CPU"
| value | min |
| 59    | 5   |
| 61    | 5   |


@SID_19
Scenario: Inbound Traffic Cleanup
Given UI logout and close browser
* CLI kill all simulator attacks on current vision
