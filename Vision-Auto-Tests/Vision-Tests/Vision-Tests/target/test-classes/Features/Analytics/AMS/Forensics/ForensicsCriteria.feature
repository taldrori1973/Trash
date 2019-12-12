@VRM_Report @TC105999

Feature: Forensic Criteria Tests

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

  @SID_3
   Scenario: VRM - Login to VRM Forensic and do data manipulation
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Open Upper Bar Item "AMS"
    And UI Open "Forensics" Tab
    # adjust duration of attack because it is around 60 sec
    Then CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query -d '{"query": {"match": {"attackIpsId": "136-1424505529"}},"script": {"source": "ctx._source.duration = '56000'"}}'" on "ROOT_SERVER_CLI"

    

# #06 #############################################################################################################################################

  @SID_4
  Scenario: VRM - Add New Forensics Report criteria - Action - Equals
    When UI "Create" Forensics With Name "Action Criteria"
      | Criteria | Event Criteria:Action,Operator:Equals,Value:[Drop]; |
      | Output   | Start Time,Attack ID, Action                        |
    When UI Generate and Validate Forensics With Name "Action Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Action Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 27
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName | value |
      | Action     | Drop  |
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab

  @SID_5
  Scenario: VRM - Add New Forensics Report criteria - Action - Not Equals
    When UI "Create" Forensics With Name "Not Action Criteria"
      | Criteria | Event Criteria:Action,Operator:Not Equals,Value:[Drop]; |
      | Output   | Start Time,Attack ID, Action                            |
    When UI Generate and Validate Forensics With Name "Not Action Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Not Action Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 9
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab

  @SID_6
  Scenario: VRM - Add New Forensics Report criteria - Attack Name - Equals
    When UI "Create" Forensics With Name "Attack name Criteria"
      | Criteria | Event Criteria:Attack Name,Operator:Equals,Value:Incorrect IPv4 checksum; |
      | Output   | Attack ID, Attack Name                                                    |
    When UI Generate and Validate Forensics With Name "Attack name Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Attack name Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 4
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName  | value                   |
      | Attack Name | Incorrect IPv4 checksum |
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab

  @SID_7
  Scenario: VRM - Add New Forensics Report criteria - Attack Name - Not Equals
    When UI "Create" Forensics With Name "Not Attack name Criteria"
      | Criteria | Event Criteria:Attack Name,Operator:Not Equals,Value:Incorrect IPv4 checksum; |
      | Output   | Start Time,Attack ID, Attack Name                                             |
    When UI Generate and Validate Forensics With Name "Not Attack name Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Not Attack name Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 32
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab

  @SID_8
  Scenario: VRM - Add New Forensics Report criteria - Attack ID - Equals
    When UI "Create" Forensics With Name "Attack ID Criteria"
      | Criteria | Event Criteria:Attack ID,Operator:Equals,Value:136-1414505529; |
      | Output   | Start Time,Attack ID                                           |
    When UI Generate and Validate Forensics With Name "Attack ID Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Attack ID Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 1
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab

  @SID_9
  Scenario: VRM - Add New Forensics Report criteria - Attack ID - Not Equals
    When UI "Create" Forensics With Name "Not Attack ID Criteria"
      | Criteria | Event Criteria:Attack ID,Operator:Not Equals,Value:136-1414505529; |
      | Output   | Start Time,Attack ID                                               |
    When UI Generate and Validate Forensics With Name "Not Attack ID Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Not Attack ID Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 35
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab


  @SID_10
  Scenario: VRM - Add New Forensics Report criteria - Destination IP - Equals
    When UI "Create" Forensics With Name "Destination IP Criteria"
      | Criteria | Event Criteria:Destination IP,Operator:Equals,IPType:IPv4,IPValue:1.1.1.1; |
      | Output   | Start Time,Attack ID                                                       |
    When UI Generate and Validate Forensics With Name "Destination IP Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Destination IP Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 2
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab


  @SID_11
  Scenario: VRM - Add New Forensics Report criteria - Destination IP - Not Equals
    When UI "Create" Forensics With Name "Not Destination IP Criteria"
      | Criteria | Event Criteria:Destination IP,Operator:Not Equals,IPType:IPv4,IPValue:1.1.1.1; |
      | Output   | Start Time,Attack ID                                                           |
    When UI Generate and Validate Forensics With Name "Not Destination IP Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Not Destination IP Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 34
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab


  @SID_12
  Scenario: VRM - Add New Forensics Report criteria - Destination Port Range - Equals
    When UI "Create" Forensics With Name "Destination port range Criteria"
      | Criteria | Event Criteria:Destination Port,Operator:Equals,portType:Port Range,portFrom:52,portTo:53; |
      | Output   | Start Time,Attack ID                                                                       |
    When UI Generate and Validate Forensics With Name "Destination port range Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Destination port range Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 2
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab


  @SID_13
  Scenario: VRM - Add New Forensics Report criteria - Destination Port Range - Not Equals
    When UI "Create" Forensics With Name "Not Destination port range Criteria"
      | Criteria | Event Criteria:Destination Port,Operator:Not Equals,portType:Port Range,portFrom:52,portTo:53; |
      | Output   | Start Time,Attack ID                                                                           |
    When UI Generate and Validate Forensics With Name "Not Destination port range Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Not Destination port range Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 34
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab

  @SID_14
  Scenario: VRM - Add New Forensics Report criteria - Destination Port - Equals
    When UI "Create" Forensics With Name "Destination Port Criteria"
      | Criteria | Event Criteria:Destination Port,Operator:Equals,portType:Port,portValue:80; |
      | Output   | Start Time,Attack ID                                                        |
    When UI Generate and Validate Forensics With Name "Destination Port Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Destination Port Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 7
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab

  @SID_15
  Scenario: VRM - Add New Forensics Report criteria - Destination Port - Not Equals
    When UI "Create" Forensics With Name "Not Destination Port Criteria"
      | Criteria | Event Criteria:Destination Port,Operator:Not Equals,portType:Port,portValue:80; |
      | Output   | Start Time,Attack ID                                                            |
    When UI Generate and Validate Forensics With Name "Not Destination Port Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Not Destination Port Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 29
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab


  @SID_16
  Scenario: VRM - Add New Forensics Report criteria - Direction - Equals
    When UI "Create" Forensics With Name "Direction Criteria"
      | Criteria | Event Criteria:Direction,Operator:Equals,Value:[Inbound]; |
      | Output   | Start Time,Attack ID, Direction                           |
    When UI Generate and Validate Forensics With Name "Direction Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Direction Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 15
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName | value |
      | Direction  | In    |
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab

  @SID_17
  Scenario: VRM - Add New Forensics Report criteria - Direction - Not Equals
    When UI "Create" Forensics With Name "Not Direction Criteria"
      | Criteria | Event Criteria:Direction,Operator:Not Equals,Value:[Inbound]; |
      | Output   | Start Time,Attack ID, Direction                               |
    When UI Generate and Validate Forensics With Name "Not Direction Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Not Direction Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 21
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab

  @SID_18
  Scenario: VRM - Add New Forensics Report criteria - Duration - Equals
    When UI "Create" Forensics With Name "Duration Criteria"
      | Criteria | Event Criteria:Duration,Operator:Equals,Value:[Less than 1 min]; |
      | Output   | Start Time,Attack ID, Duration                                   |
    When UI Generate and Validate Forensics With Name "Duration Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Duration Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 34
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab

  @SID_19
  Scenario: VRM - Add New Forensics Report criteria - Duration - Not Equals
    When UI "Create" Forensics With Name "Not Duration Criteria"
      | Criteria | Event Criteria:Duration,Operator:Not Equals,Value:[Less than 1 min]; |
      | Output   | Start Time,Attack ID, Duration                                       |
    When UI Generate and Validate Forensics With Name "Not Duration Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Not Duration Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 2
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab


# ###########################################################################


  @SID_20
  Scenario: VRM - Add New Forensics Report criteria - Protocol - Equals
    When UI "Create" Forensics With Name "Protocol Criteria"
      | Criteria | Event Criteria:Protocol,Operator:Equals,Value:[IP]; |
      | Output   | Start Time,Attack ID, Protocol                      |
    When UI Generate and Validate Forensics With Name "Protocol Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Protocol Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 11
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName | value |
      | Protocol   | IP    |
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 4
      | columnName | value |
      | Protocol   | IP    |
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 9
      | columnName | value |
      | Protocol   | IP    |
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab

  @SID_21
  Scenario: VRM - Add New Forensics Report criteria - Protocol - Not Equals
    When UI "Create" Forensics With Name "Not Protocol Criteria"
      | Criteria | Event Criteria:Protocol,Operator:Not Equals,Value:[IP]; |
      | Output   | Start Time,Attack ID, Protocol                          |
    When UI Generate and Validate Forensics With Name "Not Protocol Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Not Protocol Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 25
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab


  @SID_22
  Scenario: VRM - Add New Forensics Report criteria - Risk - Equals
    When UI "Create" Forensics With Name "Risk Criteria"
      | Criteria | Event Criteria:Risk,Operator:Equals,Value:[Low]; |
      | Output   | Start Time,Attack ID, Risk                       |
    When UI Generate and Validate Forensics With Name "Risk Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Risk Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 11
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName | value |
      | Risk       | Low   |
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab

  @SID_23
  Scenario: VRM - Add New Forensics Report criteria - Risk - Not Equals
    When UI "Create" Forensics With Name "Not Risk Criteria"
      | Criteria | Event Criteria:Risk,Operator:Not Equals,Value:[Low]; |
      | Output   | Start Time,Attack ID, Risk                           |
    When UI Generate and Validate Forensics With Name "Not Risk Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Not Risk Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 25
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab


  @SID_24
  Scenario: VRM - Add New Forensics Report criteria - Source IP - Equals
    When UI "Create" Forensics With Name "Source IP Criteria"
      | Criteria | Event Criteria:Source IP,Operator:Equals,IPType:IPv4,IPValue:0.0.0.0; |
      | Output   | Start Time,Attack ID                                                  |
    When UI Generate and Validate Forensics With Name "Source IP Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Source IP Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 6
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab


  @SID_25
  Scenario: VRM - Add New Forensics Report criteria - Source IP - Not Equals
    When UI "Create" Forensics With Name "Not Source IP Criteria"
      | Criteria | Event Criteria:Source IP,Operator:Not Equals,IPType:IPv4,IPValue:0.0.0.0; |
      | Output   | Start Time,Attack ID                                                      |
    When UI Generate and Validate Forensics With Name "Not Source IP Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Not Source IP Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 30
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab


  @SID_26
  Scenario: VRM - Add New Forensics Report criteria - Source Port - Equals
    When UI "Create" Forensics With Name "Source Port Criteria"
      | Criteria | Event Criteria:Source Port,Operator:Equals,portType:Port,portValue:0; |
      | Output   | Start Time,Attack ID                                                  |
    When UI Generate and Validate Forensics With Name "Source Port Criteria" with Timeout of 180 Seconds
    And UI Click Button "Views.report" with value "Source Port Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 17
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab


  @SID_27
  Scenario: VRM - Add New Forensics Report criteria - Source Port - Not Equals
    When UI "Create" Forensics With Name "Not Source Port Criteria"
      | Criteria | Event Criteria:Source Port,Operator:Not Equals,portType:Port,portValue:0; |
      | Output   | Start Time,Attack ID                                                      |
    When UI Generate and Validate Forensics With Name "Not Source Port Criteria" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "Not Source Port Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 19
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab


  @SID_28
  Scenario: VRM - Add New Forensics Report criteria - Threat Category - Equals
    When UI "Create" Forensics With Name "Category Criteria"
      | Criteria | Event Criteria:Threat Category,Operator:Equals,Value:[ACL]; |
      | Output   | Start Time,Attack ID, Threat Category                       |
    When UI Generate and Validate Forensics With Name "Category Criteria" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "Category Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 3
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab

  @SID_29
  Scenario: VRM - Add New Forensics Report criteria - Threat Category - Not Equals
    When UI "Create" Forensics With Name "Not Category Criteria"
      | Criteria | Event Criteria:Threat Category,Operator:Not Equals,Value:[ACL]; |
      | Output   | Start Time,Attack ID, Threat Category                           |
    When UI Generate and Validate Forensics With Name "Not Category Criteria" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "Not Category Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 33
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab

  @SID_30
  Scenario: VRM - Add New Forensics Report criteria - Threat Category - multiple Not Equals
    When UI "Create" Forensics With Name "Multiple Not Category Criteria"
      | Criteria | Event Criteria:Threat Category,Operator:Not Equals,Value:[ACL,Anti Scanning,Behavioral DoS,DoS,HTTP Flood,Intrusions,Cracking Protection,SYN Flood,Anomalies,Stateful ACL,DNS Flood,Bandwidth Management,Traffic Filters]; |
      | Output   | Start Time,Attack ID, Threat Category                                                                                                                                                                                      |
    When UI Generate and Validate Forensics With Name "Multiple Not Category Criteria" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "Multiple Not Category Criteria"
    Then UI Validate "Report.Table" Table rows count equal to 36
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab


# 11 ##################################################################################################################

  @SID_31
  Scenario: VRM - Forensics Report criteria - All Conditions
    # manipulate start time of 7447-1402580209 in favour of sort test
    Then CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query -d '{"query": {"match": {"attackIpsId": "7447-1402580209"}},"script": {"inline": "ctx._source.startTime = 'ctx._source.startTime+10000'"}}'" on "ROOT_SERVER_CLI"
    When UI "Create" Forensics With Name "Criteria_AND"
      | Criteria | Event Criteria:Action,Operator:Equals,Value:[Forward,Drop];Event Criteria:Risk,Operator:Equals,Value:[High,Low];Event Criteria:Protocol,Operator:Equals,Value:UDP; |
      | Output   | Start Time,Action,Attack ID,Direction,Protocol,Threat Category,Attack Name,Risk                                                                                    |
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab
    When UI Generate and Validate Forensics With Name "Criteria_AND" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "Criteria_AND"
    Then UI Validate "Report.Table" Table rows count equal to 6
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "803-1525623158"
      | columnName | value |
      | Direction  | Out   |
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "37-1491757775"
      | columnName | value   |
      | Action     | Forward |
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "36-1491757775"
      | columnName | value |
      | Action     | Drop  |
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "45-1407864418"
      | columnName | value   |
      | Action     | Forward |
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "46-1407864418"
      | columnName | value   |
      | Action     | Forward |
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy columnName "Attack ID" findBy cellValue "7447-1402580209"
      | columnName | value   |
      | Action     | Forward |
#    And UI Open "Reports" Tab
#    And UI Open "Forensics" Tab

  @SID_32
  Scenario: VRM - Forensics Table Sorting
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName | value          |
      | Attack ID  | 803-1525623158 |
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 3
      | columnName | value           |
      | Attack ID  | 7447-1402580209 |
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 5
      | columnName | value         |
      | Attack ID  | 46-1407864418 |
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 2
      | columnName | value         |
      | Attack ID  | 36-1491757775 |
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab

#  Scenario: Clear forensics
#    * REST Delete ES index "forensics-*"
#    * REST Delete ES index "dpforensics-*"

  @SID_33
  Scenario: VRM - Forensics Report criteria - Any Condition
    When UI "Create" Forensics With Name "Criteria_OR"
      | Criteria | Event Criteria:Action,Operator:Equals,Value:[Forward,Drop];Event Criteria:Risk,Operator:Equals,Value:[High,Low];Event Criteria:Protocol,Operator:Equals,Value:UDP; |
      | Output   | Start Time,Action,Attack ID,Direction,Protocol,Threat Category,Attack Name,Risk                                                                                    |
    Then UI Click Button "Edit" with value "Criteria_OR"
    Then UI Click Button "Expand Collapse"
#    And UI Click Button "Criteria Card" with value "initial"
    And UI Click Button "Tab" with value "criteria-tab"
    Then UI Click Button "Criteria.Any"
#    And UI Click Button "Summary Card" with value "initial"
    Then UI Click Button "Submit" with value "Submit"
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab
    When UI Generate and Validate Forensics With Name "Criteria_OR" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "Criteria_OR"
    Then UI Validate "Report.Table" Table rows count equal to 33
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab

  @SID_34
  Scenario: VRM - Forensics Report criteria - Custom Condition
    When UI "Create" Forensics With Name "Criteria_Custom"
      | Criteria | Event Criteria:Action,Operator:Equals,Value:[Drop];Event Criteria:Protocol,Operator:Not Equals,Value:[UDP];Event Criteria:Action,Operator:Equals,Value:Forward;Event Criteria:Protocol,Operator:Equals,Value:[UDP]; |
      | Output   | Start Time,Action,Attack ID,Direction,Protocol,Threat Category,Attack Name,Risk                                                                                                                                     |
    And UI Click Button "Edit" with value "Criteria_Custom"
    Then UI Click Button "Expand Collapse"
#    And UI Click Button "Criteria Card" with value "initial"
    And UI Click Button "Tab" with value "criteria-tab"
    And scroll Into View to label "Criteria.Custom checkBox"
    Then UI Click Button "Criteria.Custom checkBox"
    When UI Set Text Field "Criteria.Custom textBox" To "((1 AND 2) OR (3 AND 4))"
#    And UI Click Button "Summary Card" with value "initial"
    Then UI Click Button "Submit" with value "Submit"
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab
    When UI Generate and Validate Forensics With Name "Criteria_Custom" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "Criteria_Custom"
    Then UI Validate "Report.Table" Table rows count equal to 29
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab

  @SID_35
  Scenario: VRM - Forensics Report criteria - All Conditions max selections
    When UI "Create" Forensics With Name "Criteria_10_Conditions"
      | Criteria | Event Criteria:Protocol,Operator:Not Equals,Value:Non-IP; Event Criteria:Risk,Operator:Not Equals,Value:Info; Event Criteria:Direction,Operator:Not Equals,Value:Both; Event Criteria:Attack Name,Operator:Not Equals,Value:TCP Mid Flow packet; Event Criteria:Duration,Operator:Not Equals,Value:[More than 1 hour]; Event Criteria:Direction,Operator:Equals,Value:Inbound; Event Criteria:Attack ID,Operator:Not Equals,Value:803-1525623158; Event Criteria:Attack ID,Operator:Not Equals,Value:800-1525623158; Event Criteria:Attack ID,Operator:Not Equals,Value:37-1491757775; Event Criteria:Action,Operator:Equals,Value:[Drop]; |
      | Output   | Start Time,Action,Attack ID,Direction,Protocol,Threat Category,Attack Name,Risk                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab
    When UI Generate and Validate Forensics With Name "Criteria_10_Conditions" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "Criteria_10_Conditions"
    Then UI Validate "Report.Table" Table rows count equal to 8

  @SID_36
  Scenario: modify one attack's rate value to over 2TB
    Then CLI Run remote linux Command "curl -XPOST "localhost:9200/dp-attack-raw-*/_update_by_query/?conflicts=proceed" -d '{"query":{"bool": {"must": [{"match": {"attackIpsId": "7839-1402580209"}}]}},"script": {"inline": "ctx._source.averageAttackPacketRatePps ='3000000000L'; ctx._source.averageAttackRateBps = '2001000000000L'"}}'" on "ROOT_SERVER_CLI"

  @SID_37
  Scenario: VRM - Forensics Report criteria - PPS greater than Kilo
    When UI "Create" Forensics With Name "PPS greater than K"
      | Criteria | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:2,Unit:K; |
      | Output   | Start Time,Action,Attack ID,Threat Category,Attack Name,Risk                |
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab
    When UI Generate and Validate Forensics With Name "PPS greater than K" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "PPS greater than K"
    Then UI Validate "Report.Table" Table rows count equal to 10

  @SID_38
  Scenario: VRM - Forensics Report criteria - PPS greater than Mega
    When UI "Create" Forensics With Name "PPS greater than M"
      | Criteria | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:2,Unit:M; |
      | Output   | Start Time,Action,Attack ID,Threat Category,Attack Name,Risk                |
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab
    When UI Generate and Validate Forensics With Name "PPS greater than M" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "PPS greater than M"
    Then UI Validate "Report.Table" Table rows count equal to 3

  @SID_39
  Scenario: VRM - Forensics Report criteria - PPS greater than Giga
    When UI "Create" Forensics With Name "PPS greater than G"
      | Criteria | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:2,Unit:G; |
      | Output   | Start Time,Action,Attack ID,Threat Category,Attack Name,Risk                |
    Then UI Open "Reports" Tab
    Then UI Open "Forensics" Tab
    When UI Generate and Validate Forensics With Name "PPS greater than G" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "PPS greater than G"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_40
  Scenario: modify one attack's rate value to over 2TB
    Then CLI Run remote linux Command "curl -XPOST "localhost:9200/dp-attack-raw-*/_update_by_query/?conflicts=proceed" -d '{"query":{"bool": {"must": [{"match": {"attackIpsId": "7839-1402580209"}}]}},"script": {"inline": "ctx._source.averageAttackPacketRatePps ='2001000000000L'; ctx._source.averageAttackRateBps = '2001000000000L'"}}'" on "ROOT_SERVER_CLI"

  @SID_41
  Scenario: VRM - Forensics Report criteria - PPS greater than Tera
    When UI "Create" Forensics With Name "PPS greater than T"
      | Criteria | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:2,Unit:T; |
      | Output   | Start Time,Action,Attack ID,Threat Category,Attack Name,Risk                |
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab
    When UI Generate and Validate Forensics With Name "PPS greater than T" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "PPS greater than T"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_42
  Scenario: VRM - Forensics Report criteria - bps greater than Kilo
    When UI "Create" Forensics With Name "bps greater than K"
      | Criteria | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:3900,Unit:K; |
      | Output   | Start Time,Action,Attack ID,Threat Category,Attack Name,Risk                   |
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab
    When UI Generate and Validate Forensics With Name "bps greater than K" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "bps greater than K"
    Then CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_search -d '{"query":{"bool":{"must":[{"match_all":{}}]}},"from":0,"size":1000}' > /opt/radware/storage/bps.txt" on "ROOT_SERVER_CLI"
    Then UI Validate "Report.Table" Table rows count equal to 9

  @SID_43
  Scenario: VRM - Forensics Report criteria - bps greater than Mega
    When UI "Create" Forensics With Name "bps greater than M"
      | Criteria | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:2,Unit:M; |
      | Output   | Start Time,Action,Attack ID,Threat Category,Attack Name,Risk                |
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab
    When UI Generate and Validate Forensics With Name "bps greater than M" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "bps greater than M"
    Then UI Validate "Report.Table" Table rows count equal to 10

  @SID_44
  Scenario: VRM - Forensics Report criteria - bps greater than Giga
    When UI "Create" Forensics With Name "bps greater than G"
      | Criteria | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:2,Unit:G; |
      | Output   | Start Time,Action,Attack ID,Threat Category,Attack Name,Risk                |
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab
    When UI Generate and Validate Forensics With Name "bps greater than G" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "bps greater than G"
    Then UI Validate "Report.Table" Table rows count equal to 3


  @SID_45
  Scenario: VRM - Forensics Report criteria - bps greater than Tera
    When UI "Create" Forensics With Name "bps greater than T"
      | Criteria | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:2,Unit:T; |
      | Output   | Start Time,Action,Attack ID,Threat Category,Attack Name,Risk                |
    And UI Open "Reports" Tab
    And UI Open "Forensics" Tab
    When UI Generate and Validate Forensics With Name "bps greater than T" with Timeout of 300 Seconds
    And UI Click Button "Views.report" with value "bps greater than T"
    Then UI Validate "Report.Table" Table rows count equal to 1

  @SID_46
  Scenario: Cleanup
    Then UI Open "Configurations" Tab
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
