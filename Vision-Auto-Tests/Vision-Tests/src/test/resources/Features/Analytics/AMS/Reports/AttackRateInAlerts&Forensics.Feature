@TC114383
Feature: AttackRateInAlerts&Forensics

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-attack*"
    * REST Delete ES index "forensics-*"
    * REST Delete ES index "dpforensics-*"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator
    Given CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10
    And CLI simulate 1 attacks of type "rest_black_ip46" on "DefensePro" 20 with attack ID
    And CLI simulate 1 attacks of type "vrm_bdos" on "DefensePro" 21 with attack ID
    And CLI simulate 2 attacks of type "https_new2" on "DefensePro" 11 with loopDelay 15000 and wait 230 seconds
    Given CLI simulate 1 attacks of type "pps_traps" on "DefensePro" 10

  @SID_3
  Scenario: VRM - Login to VRM Forensic and do data manipulation
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "AMS Forensics" page via homePage

  @SID_4
  Scenario: modify one attack's rate value to over 2TB
    Then CLI Run remote linux Command "curl -XPOST "localhost:9200/dp-attack-raw-*/_update_by_query/?conflicts=proceed" -d '{"query":{"bool": {"must": [{"match": {"attackIpsId": "7839-1402580209"}}]}},"script": {"inline": "ctx._source.averageAttackPacketRatePps ='3000000000L'; ctx._source.averageAttackRateBps = '2001000000000L'"}}'" on "ROOT_SERVER_CLI"

  @SID_5
  Scenario: VRM - Forensics Report criteria - PPS greater than Kilo
    When UI "Create" Forensics With Name "PPS greater than K"
      | Criteria | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:2,Unit:K; |
      | Output   | Start Time,Action,Attack ID,Threat Category,Attack Name,Risk                |
    And UI Navigate to "AMS Reports" page via homePage
    And UI Navigate to "AMS Forensics" page via homePage
    When UI Generate and Validate Forensics With Name "PPS greater than K" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "PPS greater than K"
    And UI Navigate to "HOME" page via homePage
    And UI Navigate to "AMS Forensics" page via homePage
    And UI Click Button "Views.Expand" with value "PPS greater than K"
    And UI Click Button "Views.report" with value "PPS greater than K"
    Then UI Validate "Report.Table" Table rows count equal to 10

  @SID_6
  Scenario: VRM - Forensics Report criteria - PPS greater than Mega
    When UI "Create" Forensics With Name "PPS greater than M"
      | Criteria | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:2,Unit:M; |
      | Output   | Start Time,Action,Attack ID,Threat Category,Attack Name,Risk                |
    And UI Navigate to "AMS Reports" page via homePage
    And UI Navigate to "AMS Forensics" page via homePage
    When UI Generate and Validate Forensics With Name "PPS greater than M" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "PPS greater than M"
    Then UI Validate "Report.Table" Table rows count equal to 3

  @SID_7
  Scenario: VRM - Forensics Report criteria - PPS greater than Giga
    When UI "Create" Forensics With Name "PPS greater than G"
      | Criteria | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:2,Unit:G; |
      | Output   | Start Time,Action,Attack ID,Threat Category,Attack Name,Risk                |
    And UI Navigate to "AMS Reports" page via homePage
    And UI Navigate to "AMS Forensics" page via homePage
    When UI Generate and Validate Forensics With Name "PPS greater than G" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "PPS greater than G"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_8
  Scenario: modify one attack's rate value to over 2TB
    Then CLI Run remote linux Command "curl -XPOST "localhost:9200/dp-attack-raw-*/_update_by_query/?conflicts=proceed" -d '{"query":{"bool": {"must": [{"match": {"attackIpsId": "7839-1402580209"}}]}},"script": {"inline": "ctx._source.averageAttackPacketRatePps ='2001000000000L'; ctx._source.averageAttackRateBps = '2001000000000L'"}}'" on "ROOT_SERVER_CLI"

  @SID_9
  Scenario: VRM - Forensics Report criteria - PPS greater than Tera
    When UI "Create" Forensics With Name "PPS greater than T"
      | Criteria | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:2,Unit:T; |
      | Output   | Start Time,Action,Attack ID,Threat Category,Attack Name,Risk                |
    And UI Navigate to "AMS Reports" page via homePage
    And UI Navigate to "AMS Forensics" page via homePage
    When UI Generate and Validate Forensics With Name "PPS greater than T" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "PPS greater than T"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_10
  Scenario: VRM - Forensics Report criteria - bps greater than Kilo
    When UI "Create" Forensics With Name "bps greater than K"
      | Criteria | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:3900,Unit:K; |
      | Output   | Start Time,Action,Attack ID,Threat Category,Attack Name,Risk                   |
    And UI Navigate to "AMS Reports" page via homePage
    And UI Navigate to "AMS Forensics" page via homePage
    When UI Generate and Validate Forensics With Name "bps greater than K" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "bps greater than K"
    Then CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_search -d '{"query":{"bool":{"must":[{"match_all":{}}]}},"from":0,"size":1000}' > /opt/radware/storage/bps.txt" on "ROOT_SERVER_CLI"
    Then UI Validate "Report.Table" Table rows count equal to 9

  @SID_11
  Scenario: VRM - Forensics Report criteria - bps greater than Mega
    When UI "Create" Forensics With Name "bps greater than M"
      | Criteria | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:2,Unit:M; |
      | Output   | Start Time,Action,Attack ID,Threat Category,Attack Name,Risk                |
    And UI Navigate to "AMS Reports" page via homePage
    And UI Navigate to "AMS Forensics" page via homePage
    When UI Generate and Validate Forensics With Name "bps greater than M" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "bps greater than M"
    Then UI Validate "Report.Table" Table rows count equal to 10

  @SID_12
  Scenario: VRM - Forensics Report criteria - bps greater than Giga
    When UI "Create" Forensics With Name "bps greater than G"
      | Criteria | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:2,Unit:G; |
      | Output   | Start Time,Action,Attack ID,Threat Category,Attack Name,Risk                |
    And UI Navigate to "AMS Reports" page via homePage
    And UI Navigate to "AMS Forensics" page via homePage
    When UI Generate and Validate Forensics With Name "bps greater than G" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "bps greater than G"
    Then UI Validate "Report.Table" Table rows count equal to 3


  @SID_13
  Scenario: VRM - Forensics Report criteria - bps greater than Tera
    When UI "Create" Forensics With Name "bps greater than T"
      | Criteria | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:2,Unit:T; |
      | Output   | Start Time,Action,Attack ID,Threat Category,Attack Name,Risk                |
    And UI Navigate to "AMS Reports" page via homePage
    And UI Navigate to "AMS Forensics" page via homePage
    When UI Generate and Validate Forensics With Name "bps greater than T" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "bps greater than T"
    Then UI Validate "Report.Table" Table rows count equal to 1

  ######################################################################################################################

  @SID_15
  Scenario: Clean system data
    Then CLI kill all simulator attacks on current vision
    Then REST Delete ES index "rt-alert-def-vrm"
    Then REST Delete ES index "alert"
    Then REST Delete ES index "dp-*"
    Then CLI Clear vision logs


  @SID_16
  Scenario: increase inactivity timeout to maximum
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Connectivity"
    Then UI Do Operation "select" item "Inactivity Timeouts"
    Then UI Set Text Field "Inactivity Timeout for Configuration and Monitoring Perspectives" To "60"
    Then UI Click Button "Submit"
    Then UI Logout


  @SID_17
  Scenario: VRM - Login to VRM "Alerts" tab
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS Alerts" page via homePage
    Then CLI Run remote linux Command "rm -rf /opt/radware/storage/maintenance/catalina.out*" on "ROOT_SERVER_CLI"


  @SID1_8
  Scenario: Create Alerts Criteria rate bps gt Kilo
    When UI "Create" Alerts With Name "bps greater than K"
      | devices  | index:10                                                                      |
      | Criteria | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:300,Unit:K; |
      | Schedule | triggerThisRule:13,Within:10,selectTimeUnit:minutes,alertsPerHour:60          |

  @SID_19
  Scenario: Create Alerts Criteria rate bps gt Mega
    When UI "Create" Alerts With Name "bps greater than M"
      | devices  | index:10                                                                      |
      | Criteria | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:600,Unit:M; |
      | Schedule | triggerThisRule:4,Within:10,selectTimeUnit:minutes,alertsPerHour:60           |

  @SID_20
  Scenario: Create Alerts Criteria rate bps gt Giga
    When UI "Create" Alerts With Name "bps greater than G"
      | devices  | index:10                                                                    |
      | Criteria | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:2,Unit:G; |
      | Schedule | triggerThisRule:1,Within:10,selectTimeUnit:minutes,alertsPerHour:60         |

  @SID_21
  Scenario: Create Alerts Criteria rate pps gt Giga
    When UI "Create" Alerts With Name "pps greater than G"
      | devices  | index:10                                                                    |
      | Criteria | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:2,Unit:G; |
      | Schedule | checkBox:Trigger,alertsPerHour:60                                           |

  @SID_22
  Scenario: Create Alerts Criteria rate pps gt Tera
    When UI "Create" Alerts With Name "pps greater than T"
      | devices  | index:10                                                                    |
      | Criteria | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:1,Unit:T; |
      | Schedule | checkBox:Trigger,alertsPerHour:60                                           |
    Then CLI Run remote linux Command "cp /opt/radware/mgt-server/third-party/tomcat/logs/catalina.out /opt/radware/storage/maintenance/catalina.out1" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "curl -XGET localhost:9200/rt-alert-def-vrm/_search?pretty -d '{"query":{"bool":{"must":[{"wildcard":{"name":"*"}}]}},"from":0,"size":50}' > /opt/radware/storage/maintenance/alerts_id.txt" on "ROOT_SERVER_CLI"


  @SID_23
  Scenario: Clear alert browser and Run DP simulator
    Then REST Delete ES index "alert"
    And CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10
    Given CLI simulate 1 attacks of type "pps_traps" on "DefensePro" 10 and wait 210 seconds
    Then UI Navigate to "AMS Forensics" page via homePage
    Then UI Navigate to "AMS Alerts" page via homePage


  @SID_24
  Scenario: modify one attack's rate value to 2TB
    Then CLI Run remote linux Command "now=`date +%s%3N`; curl -XPOST "localhost:9200/dp-attack-raw-*/_update_by_query/?conflicts=proceed" -d '{"query":{"bool": {"must": [{"match": {"attackIpsId": "7839-1402580209"}}]}},"script": {"inline": "ctx._source.averageAttackPacketRatePps ='2001000000000L'; ctx._source.averageAttackRateBps = '2001000000000L'; ctx._source.endTime = '$now'L"}}'" on "ROOT_SERVER_CLI"
    * Sleep "60"
    Then CLI Run remote linux Command "cp /opt/radware/mgt-server/third-party/tomcat/logs/catalina.out /opt/radware/storage/maintenance/catalina.out2" on "ROOT_SERVER_CLI"


  @SID_25
  Scenario: VRM Validate Alert criteria bps greater than Kilo
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "bps greater than K"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_26
  Scenario: VRM Validate Alert criteria bps greater than Mega
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "bps greater than M"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_27
  Scenario: VRM Validate Alert criteria pps greater than Tera
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "pps greater than T"
    Then UI Validate "Report.Table" Table rows count equal to 1


  @SID_28
  Scenario: Clean system data
    Then CLI kill all simulator attacks on current vision
    Then REST Delete ES index "rt-alert-def-vrm"
    Then REST Delete ES index "alert"
    Then REST Delete ES index "dp-*"
    Then CLI Clear vision logs

  @SID_29
  Scenario: VRM - Login to VRM "Alerts" tab
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS Alerts" page via homePage

  @SID_30
  Scenario: Create Alerts Criteria rate bps gt Kilo
    When UI "Create" Alerts With Name "bps greater than K -1"
      | devices  | index:10                                                                      |
      | Criteria | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:300,Unit:K; |
      | Schedule | triggerThisRule:13,Within:10,selectTimeUnit:minutes,alertsPerHour:60          |

  @SID_31
  Scenario:edit to G
    Then UI Click Button "Edit" with value "bps greater than K -1"
    Then UI Click Button "Expand Collapse"
    And UI Click Button "Tab" with value "criteria-tab"
    And scroll Into View to label "Criteria.Custom checkBox"
    Then UI Click Button "Criteria.Unit" with value ""
    Then UI Click Button "Criteria.Unit" with value "G"
    Then UI Click Button "Submit" with value "Submit"


  @SID_32
  Scenario: validate the edition
    #TODO should actualize the code of validate Alerts
    Then UI Click Button "Edit" with value "bps greater than K -1"
    Then UI Click Button "Expand Collapse"
    Then UI Click Button "Expand Collapse"
    And UI Click Button "Tab" with value "criteria-tab"
    And scroll Into View to label "Criteria.Custom checkBox"
    Then UI Text of "Criteria.Unit" with extension "" equal to "G"
    Then UI Click Button "Submit" with value "Submit"

  @SID_33
  Scenario: Validate that there is just greater than in maxPps and maxBps
    Then UI Click Button "Edit" with value "bps greater than K -1"
    Then UI Click Button "Expand Collapse"
    Then UI Click Button "Expand Collapse"
    And UI Click Button "Tab" with value "criteria-tab"
    And scroll Into View to label "Criteria.Custom checkBox"
    And UI Click Button "Criteria.Event Criteria" with value ""
    And UI Click Button "Criteria.Event Criteria" with value "Max bps"
    And UI Click Button "Criteria.Operator" with value ""
    Then UI Validate that number of elements of label "Criteria.Operator" with value "" is "2"


