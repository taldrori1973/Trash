Feature: topNAttacks


  @SID_1
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." Wait For Prompt 240 seconds

  @SID_2
  Scenario: Clear old reports on file-system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"
    Given Setup email server

  @SID_3
  Scenario: Clean system attacks,database and logs
    * CLI kill all simulator attacks on current vision
    * Sleep "15"
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs
    * CLI Run remote linux Command "curl -X GET localhost:9200/_cat/indices?v | grep dp-attack-raw >> /opt/radware/storage/maintenance/dp-attack-before-streaming" on "ROOT_SERVER_CLI"
    * CLI Run remote linux Command "curl -X POST localhost:9200/dp-attack-raw-*/_search -d '{"query":{"bool":{"must":[{"match_all":{}}],"must_not":[],"should":[]}},"from":0,"size":1000,"sort":[],"aggs":{}}' >> /opt/radware/storage/maintenance/attack-raw-index-before-stream" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario: Run DP simulator PCAPs for EAAF widgets and arrange the data for automation needs
    * CLI simulate 1 attacks of type "many_attacks" on "DefensePro" 10
    * CLI simulate 2 attacks of type "IP_FEED_Modified" on "DefensePro" 11
    * CLI simulate 1 attacks of type "IP_FEED_Modified" on "DefensePro" 10 and wait 80 seconds


  @SID_5
  Scenario: Login as sys_admin and update Attack Description File
    Given UI Login with user "radware" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @SID_6
  Scenario: validate Top attacks sources in 2drill down
    Then Sleep "3"
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Device" findBy cellValue "DP_172.15.22.50"
    Then UI Validate Element Existence By Label "topAttackSource" if Exists "true" with value "0"
    Then UI Validate Element Existence By Label "topAttackDestination" if Exists "true" with value "0"

  @SID_7
  Scenario: validate 3 drill down
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "DNS Flood"
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Source Address" findBy cellValue "0.0.0.0"
    Then UI Validate Text field "TOP ATTACK SOURCES.IP" with params "0" EQUALS "192.85.1.7"

  @SID_8
  Scenario: validate global policy
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "Global Policy"

  @SID_9
  Scenario: validate analytics dashboard
    When UI Navigate to "DefensePro Analytics Dashboard" page via homePage

  @SID_10
  Scenario: validate Rbac
    Then UI Logout
    * CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10 and wait 100 seconds
    Given UI Login with user "userWithPolicy" and password "radware"
    When UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    Then UI Validate Text field "TOP ATTACK SOURCES.IP" with params "0" MatchRegex "^((?!192.85.1.7|2.2.2.1|192.85.1.2|1.1.1.1|1.3.5.8).)*"