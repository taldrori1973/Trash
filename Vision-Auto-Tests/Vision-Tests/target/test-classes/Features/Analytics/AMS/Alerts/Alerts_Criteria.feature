@VRM_Alerts @TC105981

Feature: VRM Alerts Criteria

  @SID_1 @HTTPS_FLOOD
  Scenario: Clean system data
    Then CLI kill all simulator attacks on current vision
    Then REST Delete ES index "rt-alert-def-vrm"
    Then REST Delete ES index "alert"
    Then REST Delete ES index "dp-*"
    Then CLI Clear vision logs

  @SID_2
  Scenario: increase inactivity timeout to maximum
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Connectivity"
    Then UI Do Operation "select" item "Inactivity Timeouts"
    Then UI Set Text Field "Inactivity Timeout for Configuration and Monitoring Perspectives" To "60"
    Then UI Click Button "Submit"
    Then UI Logout

  @SID_3 @HTTPS_FLOOD
  Scenario: VRM - Login to VRM "Alerts" tab
    Given UI Login with user "sys_admin" and password "radware"
    And UI Open Upper Bar Item "AMS"
    And UI Open "Alerts" Tab

      ###################    CREATE All ALERT Types   ######################################################

  @SID_4
  Scenario: Create Alerts Criteria Action proxy FWD challenge
    When UI "Create" Alerts With Name "Alert_Action proxy FWD Chlng"
      | Basic Info | Description:proxy FWD challenge,Impact: absolutely no impact at all, Remedy: call support Immediately now |
      | Criteria   | Event Criteria:Action,Operator:Equals,Value:[Proxy,Forward,Challenge];                                    |
      | Schedule   | triggerThisRule:7,Within:10,selectTimeUnit:minutes,alertsPerHour:60                                       |

  @SID_5
  Scenario: Create Alerts Criteria Action Challenge
    When UI "Create" Alerts With Name "Alert_Action Challenge"
      | Basic Info | Description:Action Challenge                                        |
      | Criteria   | Event Criteria:Action,Operator:Equals,Value:[Challenge];            |
      | Schedule   | triggerThisRule:2,Within:10,selectTimeUnit:minutes,alertsPerHour:60 |

  @SID_6
  Scenario: Create Alerts Criteria Action Bypass
    When UI "Create" Alerts With Name "Alert_Action Bypass"
      | Basic Info | Description:Action                                    |
      | Criteria   | Event Criteria:Action,Operator:Equals,Value:[Bypass]; |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                     |

  @SID_7
  Scenario: Create Alerts Criteria Action Negative
    When UI "Create" Alerts With Name "Alert_Action_negative"
      | Basic Info | Description:Action Negative                                          |
      | Criteria   | Event Criteria:Action,Operator:Not Equals,Value:[Proxy,Forward];     |
      | Schedule   | triggerThisRule:29,Within:10,selectTimeUnit:minutes,alertsPerHour:60 |

  @SID_8
  Scenario: Create Alerts Criteria Attack Name
    When UI "Create" Alerts With Name "Alert Attack Name"
      | Basic Info | Description:Attack Name                                                  |
      | Criteria   | Event Criteria:Attack Name,Operator:Equals,Value:network flood IPv6 UDP; |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                                        |

  @SID_9
  Scenario: Create Alerts Criteria Attack Name Negative
    When UI "Create" Alerts With Name "Alert Attack Name Negative"
      | Basic Info | Description:Attack Name Negative                                             |
      | Criteria   | Event Criteria:Attack Name,Operator:Not Equals,Value:network flood IPv6 UDP; |
      | Schedule   | triggerThisRule:33,Within:10,selectTimeUnit:minutes,alertsPerHour:60         |

  @SID_10
  Scenario: Create Alerts Criteria Destination IPv4
    When UI "Create" Alerts With Name "Alert Destination IPv4"
      | Basic Info | Description:DST IP                                                         |
      | Criteria   | Event Criteria:Destination IP,Operator:Equals,IPType:IPv4,IPValue:1.1.1.1; |
      | Schedule   | triggerThisRule:1,Within:10,selectTimeUnit:minutes,alertsPerHour:60        |

  @SID_11
  Scenario: Create Alerts Criteria Destination IPv4 Negative
    When UI "Create" Alerts With Name "Alert Destination IPv4 Negative"
      | Basic Info | Description:DST IPv4 Negative                                                  |
      | Criteria   | Event Criteria:Destination IP,Operator:Not Equals,IPType:IPv4,IPValue:1.1.1.1; |
      | Schedule   | triggerThisRule:32,Within:10,selectTimeUnit:minutes,alertsPerHour:60           |

  @SID_12
  Scenario: Create Alerts Criteria Destination IPv6
    When UI "Create" Alerts With Name "Alert Destination IPv6"
      | Basic Info | Description:DST IP                                                           |
      | Criteria   | Event Criteria:Destination IP,Operator:Equals,IPType:IPv6,IPValue:2000::0001 |
      | Schedule   | triggerThisRule:1,Within:10,selectTimeUnit:minutes,alertsPerHour:60          |

  @SID_13
  Scenario: Create Alerts Criteria Destination Port range
    When UI "Create" Alerts With Name "Alert DST port range"
      | Basic Info | Description:DST port range                                                                 |
      | Criteria   | Event Criteria:Destination Port,Operator:Equals,portType:Port Range,portFrom:52,portTo:81; |
      | Schedule   | triggerThisRule:8,Within:10,selectTimeUnit:minutes,alertsPerHour:60                        |

  @SID_14
  Scenario: Create Alerts Criteria Action Drop
    When UI "Create" Alerts With Name "Alert_Action Drop"
      | Basic Info | Description:Action Drop                                              |
      | Criteria   | Event Criteria:Action,Operator:Equals,Value:[Drop];                  |
      | Schedule   | triggerThisRule:25,Within:10,selectTimeUnit:minutes,alertsPerHour:60 |

  @SID_15
  Scenario: Create Alerts Criteria Destination Port range Negative
    When UI "Create" Alerts With Name "Alert DST-port range Negative"
      | Basic Info | Description:DST-port range Negative                                                            |
      | Criteria   | Event Criteria:Destination Port,Operator:Not Equals,portType:Port Range,portFrom:52,portTo:81; |
      | Schedule   | triggerThisRule:25,Within:10,selectTimeUnit:minutes,alertsPerHour:60                           |

  @SID_16
  Scenario: Create Alerts Criteria Destination Port
    When UI "Create" Alerts With Name "Alert_DST_port"
      | Basic Info | Description:DST_port                                                        |
      | Criteria   | Event Criteria:Destination Port,Operator:Equals,portType:Port,portValue:53; |
      | Schedule   | triggerThisRule:1,Within:10,selectTimeUnit:minutes,alertsPerHour:60         |

  @SID_17
  Scenario: Create Alerts Criteria Direction
    When UI "Create" Alerts With Name "Alert_Direction"
      | Basic Info | Description:Direction                                               |
      | Criteria   | Event Criteria:Direction,Operator:Equals,Value:[Outbound];          |
      | Schedule   | triggerThisRule:2,Within:10,selectTimeUnit:minutes,alertsPerHour:60 |

  @SID_18
  Scenario: Create Alerts Criteria Direction Negative
    When UI "Create" Alerts With Name "Alert_Direction Negative"
      | Basic Info | Description:Direction Negative                                       |
      | Criteria   | Event Criteria:Direction,Operator:Not Equals,Value:[Outbound];       |
      | Schedule   | triggerThisRule:31,Within:10,selectTimeUnit:minutes,alertsPerHour:60 |

  @SID_19
  Scenario: Create Alerts Criteria Duration
    When UI "Create" Alerts With Name "Alert_Duration"
      | Basic Info | Description:Duration                                                 |
      | Criteria   | Event Criteria:Duration,Operator:Equals,Value:[Less than 1 min];     |
      | Schedule   | triggerThisRule:32,Within:10,selectTimeUnit:minutes,alertsPerHour:60 |

  @SID_20
  Scenario: Create Alerts Criteria Duration Negative
    When UI "Create" Alerts With Name "Alert_Duration Negative"
      | Basic Info | Description:Duration Negative                                        |
      | Criteria   | Event Criteria:Duration,Operator:Not Equals,Value:[1-5 min];         |
      | Schedule   | triggerThisRule:32,Within:10,selectTimeUnit:minutes,alertsPerHour:60 |

  @SID_21
  Scenario: Create Alerts Criteria Protocol
    When UI "Create" Alerts With Name "Alert_Protocol"
      | Basic Info | Description:Protocol                                                 |
      | Criteria   | Event Criteria:Protocol,Operator:Equals,Value:[TCP];                 |
      | Schedule   | triggerThisRule:18,Within:10,selectTimeUnit:minutes,alertsPerHour:60 |

  @SID_22
  Scenario: Create Alerts Criteria Protocol Negative
    When UI "Create" Alerts With Name "Alert_Protocol Negative"
      | Basic Info | Description:Protocol Negative                                        |
      | Criteria   | Event Criteria:Protocol,Operator:Not Equals,Value:[TCP];             |
      | Schedule   | triggerThisRule:15,Within:10,selectTimeUnit:minutes,alertsPerHour:60 |

  @SID_23
  Scenario: Create Alerts Criteria Risk
    When UI "Create" Alerts With Name "Alert_Risk"
      | Basic Info | Description:Risk                                                    |
      | Criteria   | Event Criteria:Risk,Operator:Equals,Value:[High];                   |
      | Schedule   | triggerThisRule:9,Within:10,selectTimeUnit:minutes,alertsPerHour:60 |

  @SID_24
  Scenario: Create Alerts Criteria Risk Negative
    When UI "Create" Alerts With Name "Alert_Risk Negative"
      | Basic Info | Description:Risk Negative                                            |
      | Criteria   | Event Criteria:Risk,Operator:Not Equals,Value:[High];                |
      | Schedule   | triggerThisRule:24,Within:10,selectTimeUnit:minutes,alertsPerHour:60 |

  @SID_25
  Scenario: Create Alerts Criteria Source IP
    When UI "Create" Alerts With Name "Alert_Src_IP"
      | Basic Info | Description:Src IP                                                    |
      | Criteria   | Event Criteria:Source IP,Operator:Equals,IPType:IPv4,IPValue:1.1.1.1; |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                                     |

  @SID_26
  Scenario: Create Alerts Criteria Source IP Negative
    When UI "Create" Alerts With Name "Alert_Src_IP Negative"
      | Basic Info | Description:Src IP Negative                                               |
      | Criteria   | Event Criteria:Source IP,Operator:Not Equals,IPType:IPv4,IPValue:1.1.1.1; |
      | Schedule   | triggerThisRule:33,Within:10,selectTimeUnit:minutes,alertsPerHour:60      |

  @SID_27
  Scenario: Create Alerts Criteria Source Port
    When UI "Create" Alerts With Name "Alert_Src_Port"
      | Basic Info | Description:Src Port                                                     |
      | Criteria   | Event Criteria:Source Port,Operator:Equals,portType:Port,portValue:1024; |
      | Schedule   | triggerThisRule:7,Within:10,selectTimeUnit:minutes,alertsPerHour:60      |

  @SID_28
  Scenario: Create Alerts Criteria Source Port Negative
    When UI "Create" Alerts With Name "Alert_Src_Port Negative"
      | Basic Info | Description:Src Port Negative                                                |
      | Criteria   | Event Criteria:Source Port,Operator:Not Equals,portType:Port,portValue:1024; |
      | Schedule   | triggerThisRule:26,Within:10,selectTimeUnit:minutes,alertsPerHour:60         |

  @SID_29
  Scenario: Create Alerts Criteria Category
    When UI "Create" Alerts With Name "Alert_Category"
      | Basic Info | Description:Category                                                   |
      | Criteria   | Event Criteria:Threat Category,Operator:Equals,Value:[Behavioral DoS]; |
      | Schedule   | triggerThisRule:5,Within:10,selectTimeUnit:minutes,alertsPerHour:60    |

  @SID_30
  Scenario: Create Alerts Criteria Category Negative
    When UI "Create" Alerts With Name "Alert_Category Negative"
      | Basic Info | Description:Category Negative                                         |
      | Criteria   | Event Criteria:Threat Category,Operator:Not Equals,Value:[SYN Flood]; |
      | Schedule   | triggerThisRule:32,Within:10,selectTimeUnit:minutes,alertsPerHour:60  |

  @SID_31
  Scenario: Create Alerts Criteria non-selected DP
    When UI "Create" Alerts With Name "non-selected DP"
      | Basic Info | Description:DP 12                                       |
      | devices    | index:12                                                |
      | Criteria   | Event Criteria:Attack ID,Operator:Not Equals,Value:123; |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                       |

  @SID_32
  Scenario: Create Alerts Criteria selected policy
    When UI "Create" Alerts With Name "selected policy"
      | Basic Info | Description:selected policy                                         |
      | devices    | index:10,policies:[BDOS]; index:11,policies:[pol_1];                |
      | Criteria   | Event Criteria:Attack ID,Operator:Not Equals,Value:123;             |
      | Schedule   | triggerThisRule:4,Within:10,selectTimeUnit:minutes,alertsPerHour:60 |

  @SID_33
  Scenario: Create Alerts Criteria physical port
    When UI "Create" Alerts With Name "physical port"
      | devices  | index:10,ports:[3];                                                 |
      | Criteria | Event Criteria:Attack ID,Operator:Not Equals,Value:123;             |
      | Schedule | triggerThisRule:1,Within:10,selectTimeUnit:minutes,alertsPerHour:60 |

  @SID_34
  Scenario: Create Alerts Criteria physical port and policy
    When UI "Create" Alerts With Name "physical port and policy"
      | devices  | index:10,policies:[BDOS],ports:[1];                                 |
      | Criteria | Event Criteria:Attack ID,Operator:Not Equals,Value:123;             |
      | Schedule | triggerThisRule:3,Within:10,selectTimeUnit:minutes,alertsPerHour:60 |

  @SID_35
  Scenario: Create Alerts Criteria physical port and policy Negative
    When UI "Create" Alerts With Name "physical port and policy Negative"
      | devices  | index:10,policies:[BDOS],ports:[4];                     |
      | Criteria | Event Criteria:Attack ID,Operator:Not Equals,Value:123; |
      | Schedule | checkBox:Trigger,alertsPerHour:60                       |

  @SID_36
  Scenario: Create Alerts Criteria ALL Conditions
    When UI "Create" Alerts With Name "ALL Conditions"
      | Criteria | Event Criteria:Direction,Operator:Equals,Value:Unknown;Event Criteria:Risk,Operator:Equals,Value:Low; |
      | Schedule | triggerThisRule:3,Within:10,selectTimeUnit:minutes,alertsPerHour:60                                   |

  @SID_37
  Scenario: Create Alerts Criteria Any Condition
    When UI "Create" Alerts With Name "Any Condition"
      | Criteria | Event Criteria:Attack Name,Operator:Equals,Value:TCP Mid Flow packet;Event Criteria:Source IP,Operator:Equals,IPType:IPv4,IPValue:192.85.1.2;Event Criteria:Attack ID,Operator:Equals,Value:5; |
      | Schedule | triggerThisRule:7,Within:10,selectTimeUnit:minutes,alertsPerHour:60                                                                                                                            |
    And UI Click Button "Edit" with value "Any Condition"
    Then UI Click Button "Expand Collapse"
    And UI Click Button "Tab" with value "criteria-tab"
    Then UI Click Button "Criteria.Any"
    Then UI Click Button "Submit" with value "Submit"

  @SID_38
  Scenario: Create Alerts Criteria Custom Expression
    When UI "Create" Alerts With Name "Custom Expression"
      | Criteria | Event Criteria:Destination IP,Operator:Equals,IPType:IPv4,IPValue:1.1.1.8;Event Criteria:Destination IP,Operator:Equals,IPType:IPv4,IPValue:1.1.1.9;Event Criteria:Risk,Operator:Equals,Value:Low; |
      | Schedule | triggerThisRule:2,Within:10,selectTimeUnit:minutes,alertsPerHour:60                                                                                                                                |
    Then UI Click Button "Edit" with value "Custom Expression"
    Then UI Click Button "Expand Collapse"
    And UI Click Button "Tab" with value "criteria-tab"
    And scroll Into View to label "Criteria.Custom checkBox"
    Then UI Click Button "Criteria.Custom checkBox"
    Then UI Set Text Field "Criteria.Custom textBox" To "((1 OR 2) AND 3)"
    Then UI Click Button "Submit" with value "Submit"

  @SID_39 @HTTPS_FLOOD
  Scenario: Create Alerts Threat Category HTTPS Flood Any Time Schedule
    When UI "Create" Alerts With Name "Threat Category HTTPS Flood Any Time Schedule"
      | Basic Info | Description:Threat Category HTTPS Flood Any Time Schedule           |
      | Criteria   | Event Criteria:Threat Category,Operator:Equals,Value:[HTTPS Flood]; |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                                   |

  @SID_40 @HTTPS_FLOOD
  Scenario: Create Alerts Threat Category HTTPS Flood Custom Schedule
    When UI "Create" Alerts With Name "Threat Category HTTPS Flood Custom Schedule"
      | Basic Info | Description:Threat Category HTTPS Flood Custom Schedule             |
      | Criteria   | Event Criteria:Threat Category,Operator:Equals,Value:[HTTPS Flood]; |
      | Schedule   | triggerThisRule:1,Within:10,selectTimeUnit:minutes,alertsPerHour:60 |

  @SID_41
  Scenario: Create Alerts Criteria rate bps gt Kilo
    When UI "Create" Alerts With Name "bps greater than K"
      | devices  | index:10                                                                      |
      | Criteria | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:300,Unit:K; |
      | Schedule | triggerThisRule:13,Within:10,selectTimeUnit:minutes,alertsPerHour:60          |
  @SID_42
  Scenario: Create Alerts Criteria rate bps gt Mega
    When UI "Create" Alerts With Name "bps greater than M"
      | devices  | index:10                                                                      |
      | Criteria | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:600,Unit:M; |
      | Schedule | triggerThisRule:4,Within:10,selectTimeUnit:minutes,alertsPerHour:60           |
  @SID_43
  Scenario: Create Alerts Criteria rate bps gt Giga
    When UI "Create" Alerts With Name "bps greater than G"
      | devices  | index:10                                                                    |
      | Criteria | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:2,Unit:G; |
      | Schedule | triggerThisRule:1,Within:10,selectTimeUnit:minutes,alertsPerHour:60         |
  @SID_44
  Scenario: Create Alerts Criteria rate bps gt Tera
    When UI "Create" Alerts With Name "bps greater than T"
      | devices  | index:10                                                                    |
      | Criteria | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:1,Unit:T; |
      | Schedule | checkBox:Trigger,alertsPerHour:60                                           |
  @SID_45
  Scenario: Create Alerts Criteria rate pps gt Kilo
    When UI "Create" Alerts With Name "pps greater than K"
      | devices  | index:10                                                                       |
      | Criteria | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:2000,Unit:K; |
      | Schedule | triggerThisRule:1,Within:10,selectTimeUnit:minutes,alertsPerHour:60            |

  @SID_46
  Scenario: Create Alerts Criteria rate pps gt Mega
    When UI "Create" Alerts With Name "pps greater than M"
      | devices  | index:10                                                                    |
      | Criteria | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:2,Unit:M; |
      | Schedule | triggerThisRule:1,Within:10,selectTimeUnit:minutes,alertsPerHour:60         |
  @SID_47
  Scenario: Create Alerts Criteria rate pps gt Giga
    When UI "Create" Alerts With Name "pps greater than G"
      | devices  | index:10                                                                    |
      | Criteria | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:2,Unit:G; |
      | Schedule | checkBox:Trigger,alertsPerHour:60                                           |
  @SID_48
  Scenario: Create Alerts Criteria rate pps gt Tera
    When UI "Create" Alerts With Name "pps greater than T"
      | devices  | index:10                                                                    |
      | Criteria | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:1,Unit:T; |
      | Schedule | checkBox:Trigger,alertsPerHour:60                                           |
    Then CLI Run remote linux Command "cp /opt/radware/mgt-server/third-party/tomcat/logs/catalina.out /opt/radware/storage/maintenance/catalina.out1" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "curl -XGET localhost:9200/rt-alert-def-vrm/_search?pretty -d '{"query":{"bool":{"must":[{"wildcard":{"name":"*"}}]}},"from":0,"size":50}' > /opt/radware/storage/maintenance/alerts_id.txt" on "ROOT_SERVER_CLI"


  @SID_49 @HTTPS_FLOOD
    Scenario: Clear alert browser and Run DP simulator
#    Given CLI simulate 1 attacks of type "rest_traffic_filter" on "DefensePro" 11
    Then REST Delete ES index "alert"
    And CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10 and wait 210 seconds
    Then UI Open "Forensics" Tab
    Then UI Open "Alerts" Tab

  @SID_50
  Scenario: modify one attack's rate value to 2TB
    Then CLI Run remote linux Command "now=`date +%s%3N`; curl -XPOST "localhost:9200/dp-attack-raw-*/_update_by_query/?conflicts=proceed" -d '{"query":{"bool": {"must": [{"match": {"attackIpsId": "7839-1402580209"}}]}},"script": {"inline": "ctx._source.averageAttackPacketRatePps ='2001000000000L'; ctx._source.averageAttackRateBps = '2001000000000L'; ctx._source.endTime = '$now'L"}}'" on "ROOT_SERVER_CLI"
    * Sleep "60"
    Then CLI Run remote linux Command "cp /opt/radware/mgt-server/third-party/tomcat/logs/catalina.out /opt/radware/storage/maintenance/catalina.out2" on "ROOT_SERVER_CLI"

   ###################    VALIDATE ALERTS   ######################################################

  @SID_51
  Scenario: VRM Validate Alert criteria Action proxy FWD Challenge
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Action proxy FWD Chlng"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_52
  Scenario: VRM Validate Alert criteria Action Challenge
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Action Challenge"
    Then UI Validate "Report.Table" Table rows count equal to 1
    Then CLI Run remote linux Command "cp /opt/radware/mgt-server/third-party/tomcat/logs/catalina.out /opt/radware/storage/maintenance/catalina.out3" on "ROOT_SERVER_CLI"

  @SID_53
  Scenario: VRM Validate Alert criteria Action Drop
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Action Drop"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_54
  Scenario: VRM Validate Alert criteria Action Bypass
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Action Bypass"
    Then UI Validate "Report.Table" Table rows count equal to 0

  @SID_55
  Scenario: VRM Validate Alert criteria Action negative
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Action_negative"
    Then UI Validate "Report.Table" Table rows count equal to 1
    Then CLI Run remote linux Command "cp /opt/radware/mgt-server/third-party/tomcat/logs/catalina.out /opt/radware/storage/maintenance/catalina.out4" on "ROOT_SERVER_CLI"

  @SID_56
  Scenario: VRM Validate Alert criteria Attack Name
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert Attack Name"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_57
  Scenario: VRM Validate Alert criteria Attack Name Negative
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert Attack Name Negative"
    Then UI Validate "Report.Table" Table rows count equal to 1
    Then CLI Run remote linux Command "cp /opt/radware/mgt-server/third-party/tomcat/logs/catalina.out /opt/radware/storage/maintenance/catalina.out5" on "ROOT_SERVER_CLI"

  @SID_58
  Scenario: VRM Validate Alert criteria Destination IPv4
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert Destination IPv4"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_59
  Scenario: VRM Validate Alert criteria Destination IPv4 Negative
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert Destination IPv4 Negative"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_60
  Scenario: VRM Validate Alert criteria Destination IPv6
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert Destination IPv6"
    Then UI Validate "Report.Table" Table rows count equal to 1
    Then CLI Run remote linux Command "cp /opt/radware/mgt-server/third-party/tomcat/logs/catalina.out /opt/radware/storage/maintenance/catalina.out6" on "ROOT_SERVER_CLI"

  @SID_61
  Scenario: VRM Validate Alert criteria DST port range
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert DST port range"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_62
  Scenario: VRM Validate Alert criteria DST-port range Negative
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert DST-port range Negative"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_63
  Scenario: VRM Validate Alert criteria DST_port
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_DST_port"
    Then UI Validate "Report.Table" Table rows count equal to 1
    Then CLI Run remote linux Command "cp /opt/radware/mgt-server/third-party/tomcat/logs/catalina.out /opt/radware/storage/maintenance/catalina.out7" on "ROOT_SERVER_CLI"

  @SID_64
  Scenario: VRM Validate Alert criteria Direction
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Direction"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_65
  Scenario: VRM Validate Alert criteria Direction Negative
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Direction Negative"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_66
  Scenario: VRM Validate Alert criteria Duration
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Duration"
    Then UI Validate "Report.Table" Table rows count equal to 1
    Then CLI Run remote linux Command "cp /opt/radware/mgt-server/third-party/tomcat/logs/catalina.out /opt/radware/storage/maintenance/catalina.out8" on "ROOT_SERVER_CLI"

  @SID_67
  Scenario: VRM Validate Alert criteria Duration Negative
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Duration Negative"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_68
  Scenario: VRM Validate Alert criteria Protocol
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Protocol"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_69
  Scenario: VRM Validate Alert criteria Protocol Negative
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Protocol Negative"
    Then UI Validate "Report.Table" Table rows count equal to 1
    Then CLI Run remote linux Command "cp /opt/radware/mgt-server/third-party/tomcat/logs/catalina.out /opt/radware/storage/maintenance/catalina.out9" on "ROOT_SERVER_CLI"

  @SID_70
  Scenario: VRM Validate Alert criteria Risk
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Risk"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_71
  Scenario: VRM Validate Alert criteria Risk Negative
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Risk Negative"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_72
  Scenario: VRM Validate Alert criteria Src_IP
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Src_IP"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_73
  Scenario: VRM Validate Alert criteria Src_IP Negative
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Src_IP Negative"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_74
  Scenario: VRM Validate Alert criteria Src_Port
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Src_Port"
    Then UI Validate "Report.Table" Table rows count equal to 1
    Then CLI Run remote linux Command "cp /opt/radware/mgt-server/third-party/tomcat/logs/catalina.out /opt/radware/storage/maintenance/catalina.out10" on "ROOT_SERVER_CLI"

  @SID_75
  Scenario: VRM Validate Alert criteria Src_Port Negative
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Src_Port Negative"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_76
  Scenario: VRM Validate Alert criteria Category
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Category"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_77
  Scenario: VRM Validate Alert criteria Category Negative
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert_Category Negative"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_78
  Scenario: VRM Validate Alert criteria non-selected DP
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "non-selected DP"
    Then UI Validate "Report.Table" Table rows count equal to 0
    Then CLI Run remote linux Command "cp /opt/radware/mgt-server/third-party/tomcat/logs/catalina.out /opt/radware/storage/maintenance/catalina.out11" on "ROOT_SERVER_CLI"

  @SID_79
  Scenario: VRM Validate Alert criteria selected policy
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "selected policy"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_80
  Scenario: VRM Validate Alert criteria physical port
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "physical port"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_81
  Scenario: VRM Validate Alert criteria physical port and policy
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "physical port and policy"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_82
  Scenario: VRM Validate Alert criteria physical port and policy Negative
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "physical port and policy Negative"
    Then UI Validate "Report.Table" Table rows count equal to 0
    Then CLI Run remote linux Command "cp /opt/radware/mgt-server/third-party/tomcat/logs/catalina.out /opt/radware/storage/maintenance/catalina.out12" on "ROOT_SERVER_CLI"

  @SID_83
  Scenario: RM Validate Alert criteria All Conditions
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "ALL Conditions"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_84
  Scenario: VRM Validate Alert criteria Any Condition
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Any Condition"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_85
  Scenario: VRM Validate Alert criteria Custom Expression
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Custom Expression"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_86
  Scenario: VRM Validate Alert criteria bps greater than Kilo
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "bps greater than K"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_87
  Scenario: VRM Validate Alert criteria bps greater than Mega
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "bps greater than M"
    Then UI Validate "Report.Table" Table rows count equal to 1
  @SID_88
  Scenario: VRM Validate Alert criteria bps greater than Giga
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "bps greater than G"
    Then UI Validate "Report.Table" Table rows count equal to 1
    Then CLI Run remote linux Command "cp /opt/radware/mgt-server/third-party/tomcat/logs/catalina.out /opt/radware/storage/maintenance/catalina.out13" on "ROOT_SERVER_CLI"

  @SID_89
  Scenario: VRM Validate Alert criteria bps greater than Tera
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "bps greater than T"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_90
  Scenario: VRM Validate Alert criteria pps greater than Kilo
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "pps greater than K"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_91
  Scenario: VRM Validate Alert criteria pps greater than Mega
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "pps greater than M"
    Then UI Validate "Report.Table" Table rows count equal to 1
  @SID_92
  Scenario: VRM Validate Alert criteria pps greater than Giga
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "pps greater than G"
    Then UI Validate "Report.Table" Table rows count equal to 1
  @SID_93
  Scenario: VRM Validate Alert criteria pps greater than Tera
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "pps greater than T"
    Then UI Validate "Report.Table" Table rows count equal to 1

  ######################  VALIDATING IN ALERT TABLE THE NUMBER OF ATTACKS TRIGGERING EACH ALERT   ###############################################

  @SID_94
  Scenario: VRM Alert go back to vision and clear security monitoring alerts
    # to avoid configuration timeout
    When UI Logout
    And UI Login with user "sys_admin" and password "radware"
    Then REST Delete ES document with data ""module": "SECURITY_REPORTING"" from index "alert"
    Then Sleep "2"
    Then REST Delete ES document with data ""module": "INSITE_GENERAL"" from index "alert"
    And Sleep "7"

    Then CLI Run remote linux Command "curl -XPOST localhost:9200/alert/_search -d'{"query":{"bool":{"must":[{"term":{"module":"ANALYTICS_ALERTS"}}],"must_not":[],"should":[]}},"from":0,"size":100,"sort":[],"aggs":{}}' > /opt/radware/storage/maintenance/allalerts.log" on "ROOT_SERVER_CLI"

  @SID_95
  Scenario: VRM Validate Alert browser details Alert_Action proxy FWD Chlng
#    Then UI Validate Alert Property by other Property
#      | columnNameBy | valueBy                                                                                                                                                                                                                                      | columnNameExpected | valueExpected |
#      | Message      | M_30000: Vision Analytics Alerts Alert Name: Alert_Action proxy FWD Chlng Severity: MINOR Description: proxy FWD challenge Impact: absolutely no impact at all Remedy: call support Immediately now Device IP: 172.16.22.50 Attacks Count: 8 | Product Name       | DefensePro    |
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Action proxy FWD Chlng \nSeverity: MINOR \nDescription: proxy FWD challenge \nImpact: absolutely no impact at all \nRemedy: call support Immediately now \nDevice IP: 172.16.22.50 \n*Attacks Count: 8 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_96
  Scenario: VRM Validate Alert browser details Alert_Action Challenge
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Action Challenge \nSeverity: MINOR \nDescription: Action Challenge \nImpact: N/A \nRemedy: N/A \nDevice IP: 172.16.22.50 \n*Attacks Count: 3 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_97
  Scenario: VRM Validate Alert browser details Alert_Action Drop
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Action Drop \nSeverity: MINOR \nDescription: Action Drop \nImpact: N/A \nRemedy: N/A \nDevice IP: 172.16.22.50 \n*Attacks Count: 26 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_98
  Scenario: VRM Validate Alert browser details Alert_Action Bypass
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Action Bypass \n*Attacks Count: 1 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_99
  Scenario: VRM Validate Alert browser details Alert_Action_negative
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Action_negative * \n*Attacks Count: 30 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_100
  Scenario: VRM Validate Alert browser details Alert Attack Name
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert Attack Name \n*Attacks Count: 1 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_101
  Scenario: VRM Validate Alert browser details Alert Attack Name Negative
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert Attack Name Negative \n*Attacks Count: 34 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_102
  Scenario: VRM Validate Alert browser details Alert Destination IPv4
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert Destination IPv4 \n*Attacks Count: 2 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_103
  Scenario: VRM Validate Alert browser details Alert Destination IPv4 Negative
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert Destination IPv4 Negative \n*Attacks Count: 33 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_104
  Scenario: VRM Validate Alert browser details Alert Destination IPv6
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert Destination IPv6 \n*Attacks Count: 2 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_105
  Scenario: VRM Validate Alert browser details Alert DST port range
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert DST port range \n*Attacks Count: 9 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_106
  Scenario: VRM Validate Alert browser details Alert DST-port range Negative
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert DST-port range Negative \n*Attacks Count: 26 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_107
  Scenario: VRM Validate Alert browser details Alert_DST_port
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_DST_port \n*Attacks Count: 2 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_108
  Scenario: VRM Validate Alert browser details Alert_Direction
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Direction \n*Attacks Count: 3 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_109
  Scenario: VRM Validate Alert browser details Alert_Direction Negative
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Direction Negative \n*Attacks Count: 32 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_110
  Scenario: VRM Validate Alert browser details Alert_Duration
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Duration \n*Attacks Count: 33 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_111
  Scenario: VRM Validate Alert browser details Alert_Duration Negative
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Duration Negative \n*Attacks Count: 33 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_112
  Scenario: VRM Validate Alert browser details Alert_Protocol
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Protocol \n*Attacks Count: 19 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_113
  Scenario: VRM Validate Alert browser details Alert_Protocol Negative
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Protocol Negative \n*Attacks Count: 16 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_114
  Scenario: VRM Validate Alert browser details Alert_Risk
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Risk \n*Attacks Count: 10 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_115
  Scenario: VRM Validate Alert browser details Alert_Risk Negative
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Risk Negative \n*Attacks Count: 25 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"


  @SID_116
  Scenario: VRM Validate Alert browser details Alert_Src_IP
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Src_IP \n*Attacks Count: 1 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_117
  Scenario: VRM Validate Alert browser details Alert_Src_IP Negative
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Src_IP Negative \n*Attacks Count: 34 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_118
  Scenario: VRM Validate Alert browser details Alert_Src_Port
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Src_Port \n*Attacks Count: 8 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_119
  Scenario: VRM Validate Alert browser details Alert_Src_Port Negative
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Src_Port Negative \n*Attacks Count: 27 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_120
  Scenario: VRM Validate Alert browser details Alert_Category
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Category \n*Attacks Count: 6 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_121
  Scenario: VRM Validate Alert browser details Alert_Category Negative
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Alert_Category Negative \n*Attacks Count: 33 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_122
  Scenario: VRM Validate Alert browser details selected policy
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: selected policy \n*Attacks Count: 5 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_123
  Scenario: VRM Validate Alert browser details physical port
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: physical port \n*Attacks Count: 2 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_124
  Scenario: VRM Validate Alert browser details physical port and policy
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: physical port and policy \n*Attacks Count: 4 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_125
  Scenario: VRM Validate Alert browser details All Conditions
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: All Conditions \n*Attacks Count: 4 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "[1]{1}"

  @SID_126
  Scenario: VRM Validate Alert browser details Any Conditions
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Any Conditions \n*Attacks Count: 8 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "[1]{1}"

  @SID_127
  Scenario: VRM Validate Alert browser details Custom Expression
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Custom Expression \n*Attacks Count: 3 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "[1]{1}"

  @SID_128
  Scenario: VRM Validate Alert browser details bps greater than Kilo
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: bps greater than K \n*Attacks Count: 14 \n"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
  @SID_129
  Scenario: VRM Validate Alert browser details bps greater than Mega
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: bps greater than M \n*Attacks Count: 5 \n"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
  @SID_130
  Scenario: VRM Validate Alert browser details bps greater than Giga
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: bps greater than G \n*Attacks Count: 2 \n"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
  @SID_131
  Scenario: VRM Validate Alert browser details bps greater than Tera
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: bps greater than T \n*Attacks Count: 1 \n"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
  @SID_132
  Scenario: VRM Validate Alert browser details pps greater than Kilo
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: pps greater than K \n*Attacks Count: 2 \n"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
  @SID_133
  Scenario: VRM Validate Alert browser details pps greater than Mega
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: pps greater than M \n*Attacks Count: 2 \n"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
  @SID_134
  Scenario: VRM Validate Alert browser details pps greater than Giga
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: pps greater than G \n*Attacks Count: 1 \n"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
  @SID_135
  Scenario: VRM Validate Alert browser details pps greater than Tera
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: pps greater than T \n*Attacks Count: 1 \n"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_136
  Scenario: Verify alert table sorting in modal popup
    Then UI Open Upper Bar Item "AMS"
    Then UI Open "Alerts" Tab
    Then UI "Check" all the Toggle Alerts
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert Destination IPv4"
    Then UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy index 0
    Then UI Validate Table record values by columns with elementLabel "Alert details" findBy index 0
      | columnName  | value |
      | Policy Name | BDOS  |
    Then UI Validate Table record values by columns with elementLabel "Alert details" findBy index 1
      | columnName  | value   |
      | Policy Name | bbt-sc1 |
    Then UI Click Button "Table Details OK" with value "OK"

  @SID_137
  Scenario: Verify alert details table in modal popup
    Then UI "Check" all the Toggle Alerts
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert Destination IPv4"
    Then UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy index 0
    Then UI Validate Table record values by columns with elementLabel "Alert details" findBy columnName "Direction" findBy cellValue "In"
      | columnName             | value                          |
      | Threat Category        | Behavioral DOS                  |
      | Attack Name            | network flood IPv4 TCP-SYN-ACK |
      | Policy Name            | BDOS                           |
      | Source IP Address      | 192.85.1.2                     |
      | Destination IP Address | 1.1.1.1                        |
      | Destination Port       | 1025                           |
      | Direction              | In                             |
      | Protocol               | TCP                            |

    Then UI Validate Table record values by columns with elementLabel "Alert details" findBy columnName "Direction" findBy cellValue "Out"
      | columnName             | value           |
      | Threat Category        | Server Cracking  |
      | Attack Name            | Brute Force Web |
      | Policy Name            | bbt-sc1         |
      | Source IP Address      | 192.168.43.2    |
      | Destination IP Address | 1.1.1.1         |
      | Destination Port       | 80              |
      | Direction              | Out             |
      | Protocol               | TCP             |
    Then UI Click Button "Table Details OK" with value "OK"

  @SID_138 @HTTPS_FLOOD
  Scenario: Clear alert browser and Run DP simulator for HTTPS
    Then REST Delete ES index "alert"
    And CLI simulate 1 attacks of type "https_new2" on "DefensePro" 11
    And CLI simulate 1 attacks of type "https_new2_trap" on "DefensePro" 11 with loopDelay 15000 and wait 90 seconds

  @SID_139 @HTTPS_FLOOD
  Scenario: VRM Validate Alert Threat Category HTTPS Flood Any Time Schedule
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Threat Category HTTPS Flood Any Time Schedule"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_140 @HTTPS_FLOOD
  Scenario: VRM Validate Alert Threat Category HTTPS Flood Custom Schedule
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Threat Category HTTPS Flood Custom Schedule"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_141 @HTTPS_FLOOD
  Scenario: VRM Validate Alert browser for HTTPS Flood Any Schedule
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: Threat Category HTTPS Flood Any Time Schedule \nSeverity: MINOR \nDescription: Threat Category HTTPS Flood Any Time Schedule \nImpact: N/A \nRemedy: N/A \nDevice IP: 172.16.22.51 \nAttacks Count: 1 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_142 @HTTPS_FLOOD
  Scenario: Verify alert details table in modal popup for HTTPS Flood
    Then UI "Check" all the Toggle Alerts
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Threat Category HTTPS Flood Any Time Schedule"
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName        | value                   |
      | Severity          | MINOR                   |
      | Device Name       | DefensePro_172.16.22.51 |
      | Device IP Address | 172.16.22.51            |

    Then UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy index 0
    Then UI Validate Table record values by columns with elementLabel "Alert details" findBy index 0
      | columnName             | value                   |
      | Threat Category        | HTTPS Flood             |
      | Attack Name            | HTTPS_HTTP_HTTPS_HTTPSS |
      | Policy Name            | pol                     |
      | Source IP Address      | 111.111.111.111         |
      | Destination IP Address | 22.222.222.222          |
      | Destination Port       | 22222                   |
      | Direction              | Unknown                 |
      | Protocol               | IP                      |
    Then UI Click Button "Table Details OK" with value "OK"

  @SID_143 @HTTPS_FLOOD
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
