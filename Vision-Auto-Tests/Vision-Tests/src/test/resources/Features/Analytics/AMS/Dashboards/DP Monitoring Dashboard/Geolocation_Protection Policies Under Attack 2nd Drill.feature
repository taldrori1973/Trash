@VRM
@TC110174

Feature: Geolocation DP Monitoring Dashboard and Map - Protection Policies - Under Attack 2nd Drill

  @SID_1

  Scenario: Update Attack Reports and Samples per Interval at Database AND misconnectivity Parameters
#    * CLI Run remote linux Command "mysql -prad123 vision_ng -e "update ap set attack_reports_per_interval=50"" on "ROOT_SERVER_CLI"
    Given MYSQL UPDATE "ap" Table in "VISION_NG" Schema SET "attack_reports_per_interval" Column Value as 50 WHERE ""
#    * CLI Run remote linux Command "mysql -prad123 vision_ng -e "update ap set attack_samples_per_interval=50"" on "ROOT_SERVER_CLI"
    Given MYSQL UPDATE "ap" Table in "VISION_NG" Schema SET "attack_samples_per_interval" Column Value as 50 WHERE ""

    * CLI Run remote linux Command "sed -i 's/mis.api.services.server=.*$/mis.api.services.server=servicestest.corp.radware.com/g' /opt/radware/mgt-server/properties/misconnectivity.properties" on "ROOT_SERVER_CLI"
    * CLI Run remote linux Command "sed -i 's|mis.subscription.url=.*$|mis.subscription.url=api/trcservices/v3/subscription|g' /opt/radware/mgt-server/properties/misconnectivity.properties" on "ROOT_SERVER_CLI"
    * CLI Run remote linux Command "sed -i 's|mis.geoip.feed.url=.*$|mis.geoip.feed.url=https://servicestest.corp.radware.com/api/trcservices/v3/msbaseline|g' /opt/radware/mgt-server/properties/misconnectivity.properties " on "ROOT_SERVER_CLI"

    * CLI Run remote linux Command "service vision restart" on "ROOT_SERVER_CLI" and wait 90 seconds

  @SID_2

  Scenario: Clean system data before "Protection Policies" test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs


#____________________________________Top Attack Source and Destination Tests____________________________________________

  @SID_3

  Scenario: Install license verify policy BDOS exists and unblock all countries
    Given REST Login with user "sys_admin" and password "radware"
    Given REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given Rest Add Policy "BDOS" To DP "172.16.22.51" if Not Exist
    Then REST Release All Blocked Countries of Device IP "172.16.22.51" and Policy Name "BDOS"


  @SID_4
  Scenario: Login and and run Geo Location task
    Given UI Login with user "sys_admin" and password "radware"

    And UI Remove All Tasks with tha Value "Geolocation Feed" at Column "Task Type"
    When UI Add New 'Update GEO Location Feed' Task with Name "GEO Location Feed" , Schedule Run Daily at Time "00:00:00" , and the Target Device List are:
      | DefensePro_172.16.22.51 |
    Then UI Run task with name "GEO Location Feed"

  @SID_5
  Scenario: Navigate to Second Drill
    Then CLI simulate 1 attacks of type "DynamicBlock" on "DefensePro" 11 and wait 45 seconds
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then  UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0

  @SID_6
  Scenario Outline: Validate Top Attack Sources data
    Given UI Click Button "DefensePro Dashboard Tab"
    Then UI Validate Element Existence By Label "Flag" if Exists "true" with value "<country>,<index>"
    Then UI Text of "TOP ATTACK SOURCES.IP" with extension "<index>" equal to "<ip>"
    Then UI Text of "TOP ATTACK SOURCES.Percentage" with extension "<index>" equal to "<percentage>"

    Examples:
      | index | country   | ip       | percentage |
      | 0     | Australia | 1.0.0.0  | 16.67%     |
      | 1     | Australia | 1.0.0.1  | 16.67%     |
      | 2     | France    | 2.2.2.3  | 16.67%     |
      | 3     | France    | 2.2.2.4  | 16.67%     |
      | 4     | Greece    | 2.84.0.0 | 16.67%     |
      | 5     | Greece    | 2.84.0.1 | 16.67%     |

  @SID_7
  Scenario Outline: Validate Top Attack Destination data
    Given UI Click Button "DefensePro Dashboard Tab"
    Then UI Validate Element Existence By Label "Flag" if Exists "true" with value "<country>,<index>"
    Then UI Text of "TOP ATTACK DESTINATION.IP" with extension "<index>" equal to "<ip>"
    Then UI Text of "TOP ATTACK DESTINATION.Percentage" with extension "<index>" equal to "<percentage>"

    Examples:
      | index | country            | ip      | percentage |
      | 0     | Australia          | 1.0.0.0 | 16.67%     |
      | 1     | Australia          | 1.0.0.1 | 16.67%     |
      | 2     | France             | 2.2.2.3 | 16.67%     |
      | 3     | France             | 2.2.2.4 | 16.67%     |
      | 4     | Russian_Federation | 5.3.0.0 | 16.67%     |
      | 5     | Russian_Federation | 5.3.0.1 | 16.67%     |


  @SID_8
  Scenario Outline: Validate Top Attack Sources Countries At Map
    Given UI Click Button "Geolocation Map Tab"
    Then Sleep "1"
    Then UI Validate the attribute "style" Of Label "Map.Country" With Params "<Country Code>" is "CONTAINS" to "fill: rgb(178, 46, 46)"
    Then UI Validate the attribute "data-info" Of Label "Map.Country" With Params "<Country Code>" is "CONTAINS" to "{"fillKey":"topTenFill"}"

    Examples:
      | Country Code |
      | AUS          |
      | FRA          |
      | GRC          |

# _____________________________________________________Dynamic Block Tests______________________________________________



#Block Country From Top Ten
  @SID_9
  Scenario: Block Australia at Map then Validate Block
    Given UI Click Button "Geolocation Map Tab"
    Then Sleep "1"
    When UI Click SVG Element "Map.Country" with Params "AUS"
    Then Sleep "1"
    Then UI Click Button "Map.Time Frame Selector" with value "3H"

    Then Sleep "2"
    Then UI Validate the attribute "style" Of Label "Map.Country" With Params "AUS" is "CONTAINS" to "fill: rgb(2, 146, 184)"
    Then UI Validate the attribute "data-info" Of Label "Map.Country" With Params "AUS" is "CONTAINS" to "{"fillKey":"dynamicBlockFill"}"

  @SID_10
  Scenario: Change Australia Block Duration from The Map
    Given UI Click Button "Geolocation Map Tab"
    Then Sleep "1"
    When UI Click SVG Element "Map.Country" with Params "AUS"
    Then Sleep "1"
    Then UI Click Button "Map.Time Frame Selector" with value "1H"
    Then Sleep "2"
    Then UI Validate the attribute "style" Of Label "Map.Country" With Params "AUS" is "CONTAINS" to "fill: rgb(2, 146, 184)"
    Then UI Validate the attribute "data-info" Of Label "Map.Country" With Params "AUS" is "CONTAINS" to "{"fillKey":"dynamicBlockFill"}"

  @SID_11
  Scenario: Release Australia Block
    Given UI Click Button "Geolocation Map Tab"
    Then Sleep "1"
    When UI Click SVG Element "Map.Country" with Params "AUS"
    Then Sleep "1"
    Then UI Click Button "Map.Time Frame Selector" with value "1H"
    Then Sleep "2"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "AUS" is "CONTAINS" to "fill: rgb(178, 46, 46)"
    Then UI Validate the attribute "data-info" Of Label "Map.Country" With Params "AUS" is "CONTAINS" to "{"fillKey":"topTenFill"}"


  @SID_12
  Scenario: Block Australia Again After Release Block then Validate Block
    Given UI Click Button "Geolocation Map Tab"
    Then Sleep "1"
    When UI Click SVG Element "Map.Country" with Params "AUS"
    Then Sleep "1"
    Then UI Click Button "Map.Time Frame Selector" with value "3H"

    Then Sleep "2"
    Then UI Validate the attribute "style" Of Label "Map.Country" With Params "AUS" is "CONTAINS" to "fill: rgb(2, 146, 184)"
    Then UI Validate the attribute "data-info" Of Label "Map.Country" With Params "AUS" is "CONTAINS" to "{"fillKey":"dynamicBlockFill"}"


#  Block Allowed Country
  @SID_13
  Scenario: Block China at Map then Validate Block
    Given UI Click Button "Geolocation Map Tab"
    And Sleep "1"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "CHN" is "CONTAINS" to "fill: rgb(90, 90, 90)"

    When UI Click SVG Element "Map.Country" with Params "CHN"
    And Sleep "1"
    Then UI Click Button "Map.Time Frame Selector" with value "6H"

    Then Sleep "2"
    Then UI Validate the attribute "style" Of Label "Map.Country" With Params "CHN" is "CONTAINS" to "fill: rgb(2, 146, 184)"
    Then UI Validate the attribute "data-info" Of Label "Map.Country" With Params "CHN" is "CONTAINS" to "{"fillKey":"dynamicBlockFill"}"

  @SID_14
  Scenario: Change China Block Duration from The Map
    Given UI Click Button "Geolocation Map Tab"
    Then Sleep "1"
    When UI Click SVG Element "Map.Country" with Params "CHN"
    Then Sleep "1"
    Then UI Click Button "Map.Time Frame Selector" with value "72H"
    Then Sleep "2"
    Then UI Validate the attribute "style" Of Label "Map.Country" With Params "CHN" is "CONTAINS" to "fill: rgb(2, 146, 184)"
    Then UI Validate the attribute "data-info" Of Label "Map.Country" With Params "CHN" is "CONTAINS" to "{"fillKey":"dynamicBlockFill"}"

  @SID_15
  Scenario: Release China Block
    Given UI Click Button "Geolocation Map Tab"
    Then Sleep "1"
    When UI Click SVG Element "Map.Country" with Params "CHN"
    Then Sleep "1"
    Then UI Click Button "Map.Time Frame Selector" with value "72H"
    Then Sleep "2"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "CHN" is "CONTAINS" to "fill: rgb(90, 90, 90)"

  @SID_16
  Scenario: Tear Down
    * CLI Run remote linux Command "sed -i 's/mis.api.services.server=.*$/mis.api.services.server=services.radware.com/g' /opt/radware/mgt-server/properties/misconnectivity.properties" on "ROOT_SERVER_CLI"
    * CLI Run remote linux Command "sed -i 's|mis.subscription.url=.*$|mis.subscription.url=api/securityupdate/v1/subscription|g' /opt/radware/mgt-server/properties/misconnectivity.properties" on "ROOT_SERVER_CLI"
    * CLI Run remote linux Command "sed -i 's|mis.geoip.feed.url=.*$|mis.geoip.feed.url=https://services.radware.com/api/TRCServices/v3/msbaseline|g' /opt/radware/mgt-server/properties/misconnectivity.properties " on "ROOT_SERVER_CLI"

    * CLI Run remote linux Command "service vision restart" on "ROOT_SERVER_CLI" and wait 90 seconds

  @SID_17
  Scenario: Protection Policies Cleanup
    Given UI logout and close browser
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
