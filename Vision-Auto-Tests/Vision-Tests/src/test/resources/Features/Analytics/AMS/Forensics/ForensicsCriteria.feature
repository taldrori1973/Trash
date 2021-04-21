@VRM_Report @TC105999

Feature: Forensic Criteria Tests

  @SID_1
  Scenario: Clean system data
#    * CLI kill all simulator attacks on current vision
#    * REST Delete ES index "dp-attack*"
#    * REST Delete ES index "forensics-*"
#    * REST Delete ES index "dpforensics-*"
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
    Then UI Navigate to "AMS Forensics" page via homepage
    # adjust duration of attack because it is around 60 sec
    Then CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query -d '{"query": {"match": {"attackIpsId": "136-1424505529"}},"script": {"source": "ctx._source.duration = '56000'"}}'" on "ROOT_SERVER_CLI"

# #06 #############################################################################################################################################

  @SID_4
  Scenario: VRM - Add New Forensics criteria - Action - Equals
    When UI "Create" Forensics With Name "Action Criteria"
      | Criteria | Event Criteria:Action,Operator:Equals,Value:Drop |
      | Output   | Start Time,Attack ID,Action                      |
    Then UI Click Button "My Forensics" with value "Action Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Action Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Action Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 25
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName | value |
      | Action     | Drop  |
    Then UI Delete Forensics With Name "Action Criteria"

  @SID_5
  Scenario: VRM - Add New Forensics criteria - Action - Not Equals
    When UI "Create" Forensics With Name "Not Action Criteria"
      | Criteria | Event Criteria:Action,Operator:Not Equals,Value:Drop |
      | Output   | Start Time,Attack ID,Action                          |
    Then UI Click Button "My Forensics" with value "Not Action Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Not Action Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Not Action Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 9
    Then UI Delete Forensics With Name "Not Action Criteria"

  @SID_6
  Scenario: VRM - Add New Forensics criteria - Attack Name - Equals
    When UI "Create" Forensics With Name "Attack name Criteria"
      | Criteria | Event Criteria:Attack Name,Operator:Equals,Value:Incorrect IPv4 checksum |
      | Output   | Attack ID,Attack Name                                                    |
    Then UI Click Button "My Forensics" with value "Attack name Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Attack name Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Attack name Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 4
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName  | value                   |
      | Attack Name | Incorrect IPv4 checksum |
    Then UI Delete Forensics With Name "Attack name Criteria"

  @SID_7
  Scenario: VRM - Add New Forensics criteria - Attack Name - Not Equals
    When UI "Create" Forensics With Name "Not Attack name Criteria"
      | Criteria | Event Criteria:Attack Name,Operator:Not Equals,Value:Incorrect IPv4 checksum |
      | Output   | Start Time,Attack ID,Attack Name                                             |
    Then UI Click Button "My Forensics" with value "Not Attack name Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Not Attack name Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Not Attack name Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 30
    Then UI Delete Forensics With Name "Not Attack name Criteria"

  @SID_8
  Scenario: VRM - Add New Forensics criteria - Destination IP - Equals
    When UI "Create" Forensics With Name "Destination IP Criteria"
      | Criteria | Event Criteria:Destination IP,Operator:Equals,IPType:IPv4,IPValue:1.1.1.1 |
      | Output   | Start Time,Attack ID                                                      |
    Then UI Click Button "My Forensics" with value "Destination IP Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Destination IP Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Destination IP Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 2
    Then UI Delete Forensics With Name "Destination IP Criteria"

  @SID_9
  Scenario: VRM - Add New Forensics criteria - Destination IP - Not Equals
    When UI "Create" Forensics With Name "Not Destination IP Criteria"
      | Criteria | Event Criteria:Destination IP,Operator:Not Equals,IPType:IPv4,IPValue:1.1.1.1 |
      | Output   | Start Time,Attack ID                                                          |
    Then UI Click Button "My Forensics" with value "Not Destination IP Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Not Destination IP Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Not Destination IP Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 20
    Then UI Delete Forensics With Name "Not Destination IP Criteria"

  @SID_10
  Scenario: VRM - Add New Forensics criteria - Destination Range - Equals
    When UI "Create" Forensics With Name "Destination Range Criteria"
      | Criteria | Event Criteria:Destination Port,Operator:Equals,portType:Range,portFrom:52,portTo:53 |
      | Output   | Start Time,Attack ID                                                                 |
    Then UI Click Button "My Forensics" with value "Destination Range Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Destination Range Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Destination Range Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 2
    Then UI Delete Forensics With Name "Destination Range Criteria"

  @SID_11
  Scenario: VRM - Add New Forensics criteria - Destination Range - Not Equals
    When UI "Create" Forensics With Name "Not Destination Range Criteria"
      | Criteria | Event Criteria:Destination Port,Operator:Not Equals,portType:Range,portFrom:52,portTo:53 |
      | Output   | Start Time,Attack ID                                                                     |
    Then UI Click Button "My Forensics" with value "Not Destination Range Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Not Destination Range Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Not Destination Range Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 32
    Then UI Delete Forensics With Name "Not Destination Range Criteria"

  @SID_12
  Scenario: VRM - Add New Forensics criteria - Destination Port - Equals
    When UI "Create" Forensics With Name "Destination Port Criteria"
      | Criteria | Event Criteria:Destination Port,Operator:Equals,portType:Single,portValue:80 |
      | Output   | Start Time,Attack ID                                                         |
    Then UI Click Button "My Forensics" with value "Destination Port Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Destination Port Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Destination Port Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 7
    Then UI Delete Forensics With Name "Destination Port Criteria"

  @SID_13
  Scenario: VRM - Add New Forensics criteria - Destination Port - Not Equals
    When UI "Create" Forensics With Name "Not Destination Port Criteria"
      | Criteria | Event Criteria:Destination Port,Operator:Not Equals,portType:Single,portValue:80 |
      | Output   | Start Time,Attack ID                                                             |
    Then UI Click Button "My Forensics" with value "Not Destination Port Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Not Destination Port Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Not Destination Port Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 27
    Then UI Delete Forensics With Name "Not Destination Port Criteria"

  @SID_14
  Scenario: VRM - Add New Forensics criteria - Direction - Equals
    When UI "Create" Forensics With Name "Direction Criteria"
      | Criteria | Event Criteria:Direction,Operator:Equals,Value:Inbound |
      | Output   | Start Time,Attack ID,Direction                         |
    Then UI Click Button "My Forensics" with value "Direction Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Direction Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Direction Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 14
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName | value |
      | Direction  | In    |
    Then UI Delete Forensics With Name "Direction Criteria"

  @SID_15
  Scenario: VRM - Add New Forensics criteria - Direction - Not Equals
    When UI "Create" Forensics With Name "Not Direction Criteria"
      | Criteria | Event Criteria:Direction,Operator:Not Equals,Value:Inbound |
      | Output   | Start Time,Attack ID,Direction                             |
    Then UI Click Button "My Forensics" with value "Not Direction Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Not Direction Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Not Direction Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 20
    Then UI Delete Forensics With Name "Not Direction Criteria"


  @SID_16
  Scenario: VRM - Add New Forensics criteria - Duration - Equals
    When UI "Create" Forensics With Name "Duration Criteria"
      | Criteria | Event Criteria:Duration,Operator:Equals,Value:Less than 1 min |
      | Output   | Start Time,Attack ID,Duration                                 |
    Then UI Click Button "My Forensics" with value "Duration Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Duration Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Duration Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 0
    Then UI Delete Forensics With Name "Duration Criteria"

  @SID_17
  Scenario: VRM - Add New Forensics criteria - Duration - Not Equals
    When UI "Create" Forensics With Name "Not Duration Criteria"
      | Criteria | Event Criteria:Duration,Operator:Not Equals,Value:Less than 1 min |
      | Output   | Start Time,Attack ID,Duration                                     |
    Then UI Click Button "My Forensics" with value "Not Duration Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Not Duration Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Not Duration Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 34
    Then UI Delete Forensics With Name "Not Duration Criteria"

# ###########################################################################


  @SID_18
  Scenario: VRM - Add New Forensics criteria - Protocol - Equals
    When UI "Create" Forensics With Name "Protocol Criteria"
      | Criteria | Event Criteria:Protocol,Operator:Equals,Value:IP |
      | Output   | Start Time,Attack ID,Protocol                    |
    Then UI Click Button "My Forensics" with value "Protocol Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Protocol Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Protocol Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 9
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName | value |
      | Protocol   | IP    |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 4
      | columnName | value |
      | Protocol   | IP    |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 9
      | columnName | value |
      | Protocol   | IP    |
    Then UI Delete Forensics With Name "Protocol Criteria"

  @SID_19
  Scenario: VRM - Add New Forensics criteria - Protocol - Not Equals
    When UI "Create" Forensics With Name "Not Protocol Criteria"
      | Criteria | Event Criteria:Protocol,Operator:Not Equals,Value:IP |
      | Output   | Start Time,Attack ID,Protocol                        |
    Then UI Click Button "My Forensics" with value "Not Protocol Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Not Protocol Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Not Protocol Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 25
    Then UI Delete Forensics With Name "Not Protocol Criteria"


  @SID_20
  Scenario: VRM - Add New Forensics criteria - Risk - Equals
    When UI "Create" Forensics With Name "Risk Criteria"
      | Criteria | Event Criteria:Risk,Operator:Equals,Value:Low |
      | Output   | Start Time,Attack ID,Risk                     |
    Then UI Click Button "My Forensics" with value "Risk Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Risk Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Risk Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 9
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName | value |
      | Risk       | Low   |
    Then UI Delete Forensics With Name "Risk Criteria"

  @SID_21
  Scenario: VRM - Add New Forensics criteria - Risk - Not Equals
    When UI "Create" Forensics With Name "Not Risk Criteria"
      | Criteria | Event Criteria:Risk,Operator:Not Equals,Value:Low |
      | Output   | Start Time,Attack ID,Risk                         |
    Then UI Click Button "My Forensics" with value "Not Risk Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Not Risk Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Not Risk Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 25
    Then UI Delete Forensics With Name "Not Risk Criteria"

  @SID_22
  Scenario: VRM - Add New Forensics criteria - Source IP - Equals
    When UI "Create" Forensics With Name "Source IP Criteria"
      | Criteria | Event Criteria:Source IP,Operator:Equals,IPType:IPv4,IPValue:0.0.0.0 |
      | Output   | Start Time,Attack ID                                                 |
    Then UI Click Button "My Forensics" with value "Source IP Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Source IP Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Source IP Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 0
    Then UI Delete Forensics With Name "Source IP Criteria"

  @SID_23
  Scenario: VRM - Add New Forensics criteria - Source IP - Not Equals
    When UI "Create" Forensics With Name "Not Source IP Criteria"
      | Criteria | Event Criteria:Source IP,Operator:Not Equals,IPType:IPv4,IPValue:0.0.0.0 |
      | Output   | Start Time,Attack ID                                                     |
    Then UI Click Button "My Forensics" with value "Not Source IP Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Not Source IP Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Not Source IP Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 20
    Then UI Delete Forensics With Name "Not Source IP Criteria"

  @SID_24
  Scenario: VRM - Add New Forensics criteria - Source Port - Equals
    When UI "Create" Forensics With Name "Source Port Criteria"
      | Criteria | Event Criteria:Source Port,Operator:Equals,portType:Single,portValue:0 |
      | Output   | Start Time,Attack ID                                                   |
    Then UI Click Button "My Forensics" with value "Source Port Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Source Port Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Source Port Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 16
    Then UI Delete Forensics With Name "Source Port Criteria"

  @SID_25
  Scenario: VRM - Add New Forensics criteria - Source Port - Not Equals
    When UI "Create" Forensics With Name "Not Source Port Criteria"
      | Criteria | Event Criteria:Source Port,Operator:Not Equals,portType:Single,portValue:0 |
      | Output   | Start Time,Attack ID                                                       |
    Then UI Click Button "My Forensics" with value "Not Source Port Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Not Source Port Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Not Source Port Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 18
    Then UI Delete Forensics With Name "Not Source Port Criteria"


  @SID_26
  Scenario: VRM - Add New Forensics criteria - Threat Category - Equals
    When UI "Create" Forensics With Name "Category Criteria"
      | Criteria | Event Criteria:Threat Category,Operator:Equals,Value:ACL |
      | Output   | Start Time,Attack ID,Threat Category                     |
    Then UI Click Button "My Forensics" with value "Category Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Category Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Category Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 2
    Then UI Delete Forensics With Name "Category Criteria"

  @SID_27
  Scenario: VRM - Add New Forensics criteria - Threat Category - Not Equals
    When UI "Create" Forensics With Name "Not Category Criteria"
      | Criteria | Event Criteria:Threat Category,Operator:Not Equals,Value:ACL |
      | Output   | Start Time,Attack ID,Threat Category                         |
    Then UI Click Button "My Forensics" with value "Not Category Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Not Category Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Not Category Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 32
    Then UI Delete Forensics With Name "Not Category Criteria"

  @SID_28
  Scenario: VRM - Add New Forensics criteria - Threat Category - multiple Not Equals
    When UI "Create" Forensics With Name "Multiple Not Category Criteria"
      | Criteria | Event Criteria:Threat Category,Operator:Not Equals,Value:[ACL,Anti Scanning,Behavioral DoS,DoS,Intrusions,Cracking Protection,SYN Flood,Anomalies,Stateful ACL,DNS Flood,Bandwidth Management,Traffic Filters] |
      | Output   | Start Time,Attack ID,Threat Category                                                                                                                                                                           |
    Then UI Click Button "My Forensics" with value "Multiple Not Category Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Multiple Not Category Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Multiple Not Category Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 34
    Then UI Delete Forensics With Name "Multiple Not Category Criteria"


  @SID_29
  Scenario: VRM - Add New Forensics criteria - Threat Category - Equals Connection PPS
    When UI "Create" Forensics With Name "Category Criteria"
      | Criteria | Event Criteria:Threat Category,Operator:Equals,Value:Connection PPS |
      | Output   | Start Time,Attack ID,Threat Category                                |
    Then UI Click Button "My Forensics" with value "Category Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Category Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Category Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 0
    Then UI Delete Forensics With Name "Category Criteria"


  @SID_30
  Scenario: VRM - Add New Forensics criteria - Threat Category - Not Equals Connection PPS
    When UI "Create" Forensics With Name "Category Criteria"
      | Criteria | Event Criteria:Threat Category,Operator:Not Equals,Value:Connection PPS |
      | Output   | Start Time,Attack ID,Threat Category                                    |
    Then UI Click Button "My Forensics" with value "Category Criteria"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Category Criteria"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Category Criteria,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 34
    Then UI Delete Forensics With Name "Category Criteria"

# 11 ##################################################################################################################

  @SID_31
  Scenario: VRM - Forensics criteria - All Conditions
    # manipulate start time of 7447-1402580209 in favour of sort test
    Then CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query -d '{"query": {"match": {"attackIpsId": "7447-1402580209"}},"script": {"inline": "ctx._source.startTime = 'ctx._source.startTime+10000'"}}'" on "ROOT_SERVER_CLI"
    When UI "Create" Forensics With Name "Criteria_AND"
      | Criteria | Event Criteria:Action,Operator:Equals,Value:[Forward,Drop];Event Criteria:Risk,Operator:Equals,Value:[High,Low];Event Criteria:Protocol,Operator:Equals,Value:UDP |
      | Output   | Start Time,Action,Attack ID,Direction,Protocol,Threat Category,Attack Name,Risk                                                                                   |
    Then UI Click Button "My Forensics" with value "Criteria_AND"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Criteria_AND"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Criteria_AND,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 6
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "803-1525623158"
      | columnName | value |
      | Direction  | Out   |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "37-1491757775"
      | columnName | value   |
      | Action     | Forward |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "36-1491757775"
      | columnName | value |
      | Action     | Drop  |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "45-1407864418"
      | columnName | value   |
      | Action     | Forward |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "46-1407864418"
      | columnName | value   |
      | Action     | Forward |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "7447-1402580209"
      | columnName | value   |
      | Action     | Forward |


  @SID_32
  Scenario: VRM - Forensics Table Sorting
#    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
#      | columnName | value          |
#      | Attack ID  | 7447-1402580209 |
#    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 3
#      | columnName | value           |
#      | Attack ID  | 803-1525623158 |
#    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 5
#      | columnName | value         |
#      | Attack ID  | 46-1407864418 |
#    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 2
#      | columnName | value         |
#      | Attack ID  | 37-1491757775 |
    Then UI Delete Forensics With Name "Criteria_AND"


  @SID_33
  Scenario: VRM - Forensics criteria - Any Condition
    When UI "Create" Forensics With Name "Criteria_OR"
      | Criteria | Event Criteria:Action,Operator:Equals,Value:[Forward,Drop];Event Criteria:Risk,Operator:Equals,Value:[High,Low];Event Criteria:Protocol,Operator:Equals,Value:UDP |
      | Output   | Start Time,Action,Attack ID,Direction,Protocol,Threat Category,Attack Name,Risk                                                                                   |
    Then UI Click Button "My Forensics" with value "Criteria_OR"
    Then UI Click Button "Edit Forensics" with value "Criteria_OR"
    Then UI Click Button "Criteria Tab"
    Then UI Select Element with label "Criteria Apply To" and params "any"
    Then UI Click Button "save"
    Then UI Click Button "My Forensics" with value "Criteria_OR"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Criteria_OR"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Criteria_OR,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 31
    Then UI Delete Forensics With Name "Criteria_OR"


  @SID_34
  Scenario: VRM - Forensics criteria - Custom Condition
    When UI "Create" Forensics With Name "Criteria_Custom"
      | Criteria | Event Criteria:Action,Operator:Equals,Value:Drop;Event Criteria:Protocol,Operator:Not Equals,Value:UDP;Event Criteria:Action,Operator:Equals,Value:Forward;Event Criteria:Protocol,Operator:Equals,Value:UDP |
      | Output   | Start Time,Action,Attack ID,Direction,Protocol,Threat Category,Attack Name,Risk                                                                                                                              |
    Then UI Click Button "My Forensics" with value "Criteria_Custom"
    Then UI Click Button "Edit Forensics" with value "Criteria_Custom"
    Then UI Click Button "Criteria Tab"
    Then UI Select Element with label "Criteria Apply To" and params "custom"
    When UI Set Text Field "customTextField" To "((1 AND 2) OR (3 AND 4))"
    Then UI Click Button "save"
    Then UI Click Button "My Forensics" with value "Criteria_Custom"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Criteria_Custom"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Criteria_Custom,0"
    Then UI Validate "Forensics.Table" Table rows count GTE to 27
    Then UI Delete Forensics With Name "Criteria_Custom"

  @SID_35
  Scenario: Cleanup
    Then UI Open "Configurations" Tab
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
