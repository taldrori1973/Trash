@TC123979
Feature: New DP  Protection & Attack Category (Layer-7 Signature)


  @SID_1
  Scenario: Clean data before sending snmp_l7apsig attack
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs


  @SID_2
  Scenario:  login to vision and Install License
    Given UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
#    Then UI Navigate to "AMS Forensics" page via homePage
#    Then Sleep "30"



     #    <<<<<<<<<       Alert        >>>>>>>>>

  @SID_3
  Scenario: navigate to alert and Create Alert Category with name Encrypted_Flood    Encrypted Flood
    Given UI Navigate to "AMS Alerts" page via homePage
    Then Sleep "5"
    Then UI "Create" Alerts With Name "Encrypted_Flood"
      | Product    | DefensePro                                                                                                                     |
      | Basic Info | Description:New Threat category name Encrypted Flood,Impact: Our network is down,Remedy: Please protect real quick!,Severity:Critical |
      | Criteria   | Event Criteria:Threat Category,Operator:Equals,Value:[Encrypted Flood];                                                           |
      | Schedule   | checkBox:Trigger,alertsPerHour:10                                                                                                |
#       | Share      | Email:[automation.vision1@alert.local, automation.vision2@alert.local],Subject:Alert Delivery Subj,Body:Alert Delivery Body      |
#     And Sleep "120"



#   <<<<<<<<<<<<<<<<<<<<< Attack >>>>>>>>>>>>>>>>>>>>
  @SID_4
  Scenario: Run DP simulator - snmp_l7apsig
    Given CLI simulate 1000 attacks of type "snmp_l7apsig" on "DefensePro" 11 with loopDelay 15000 and wait 70 seconds



  @SID_5
  Scenario: validate results for edit Alert fields
    And UI Navigate to "AMS Reports" page via homePage
    And UI Navigate to "AMS Alerts" page via homePage
    Then Sleep "10"
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Encrypted_Flood"
    Then UI Validate "Report.Table" Table rows count EQUALS to 1
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName | value   |
      | Severity   | CRITICAL |


  @SID_6
  Scenario: validate Alert details table
    Then UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy index 0
    Then UI Validate "Alert details" Table rows count EQUALS to 1
    Then UI Validate Table record values by columns with elementLabel "Alert details" findBy columnName "Threat Category" findBy cellValue "Encrypted Flood"
      | columnName       | value                |
      | Threat Category     | Encrypted Flood |
    Then UI Click Button "Table Details Close"



  @SID_7
  Scenario: validate Delete Alert
    When UI Delete Alerts With Name "Encrypted_Flood"
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "false" with value "Encrypted_Flood"


#    <<<<<<<<<<<<<<<<<<<  DP monitoring validation table >>>>>>>>>>>>>>>>
  @SID_8
   Scenario:  navigate to DP monitoring and validate table Protection Policies with attack Category name "Encrypted Flood"
     Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
     And Sleep "30"
     Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 0
       | columnName            | value                  |
       | Attack Category     | Encrypted Flood |



    # <<<<<<<<<<<<<<<<<<<<<<<  DP attack validation table  >>>>>>>>>>>>>>>>>>>
   @SID_9
   Scenario:  navigate to attack dashboard and validate attack category Encrypted Flood
#     Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
     Given UI Navigate to "DefensePro Attacks" page via homePage
     Then Sleep "2"
     Then UI Validate Table record values by columns with elementLabel "Attacks Table" findBy index 0
       | columnName      | value       |
       | Attack Category | Encrypted Flood |



#      <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<   Forensics      >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  @SID_10
  Scenario: Navigate to Forensics and create new Forensics with name Encrypted_Flood
    Given UI Navigate to "AMS Forensics" page via homePage
    Then Sleep "30"
    Given UI "Create" Forensics With Name "Encrypted_Flood"
      | Product | DefensePro |
      | Output                | Start Time,End Time,Threat Category,Attack Name,Policy Name,Source IP Address,Destination IP Address,Destination Port,Direction,Protocol,Device IP Address,Action,Attack ID,Source Port,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag,Packet Type |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                   |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:Encrypted Flood                                                                                                                                                                                                                                   |
      | Time Definitions.Date | Quick:Today|

  @SID_11
  Scenario: Forensic New Category Validate ForensicsView
    Then UI Click Button "My Forensics" with value "Encrypted_Flood"
    Then UI Validate Element Existence By Label "Generate Snapshot Forensics Manually" if Exists "true" with value "Encrypted_Flood"


   @SID_12
   Scenario: Forensic test Generate Encrypted_Flood
     Then UI Click Button "Generate Snapshot Forensics Manually" with value "Encrypted_Flood"
     Then Sleep "35"
     When UI Click Button "Views.Forensic" with value "Encrypted_Flood,0"


   @SID_13
   Scenario: VRM - Forensic Encrypted_Flood Validate Table
     Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
       | columnName | value |
       | Threat Category     | Encrypted Flood  |
     Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy index 0
     Then UI Text of "Forensics.Attack Details.Detail" with extension "Threat Category" equal to "Encrypted Flood"
     Then UI Click Button "Forensics.Attack Details.Close"

   @SID_14
   Scenario: VRM - Validate Forensic "Encrypted_Flood" Delete
     Then UI Click Button "Delete Forensics" with value "Encrypted_Flood"
     Then UI Click Button "Cancel Delete Forensics"
     Then UI Validate Element Existence By Label "My Forensics" if Exists "true" with value "Encrypted_Flood"
     Then UI Delete Forensics With Name "Encrypted_Flood"
     And Sleep "1"
     Then UI Validate Element Existence By Label "My Forensics" if Exists "false" with value "Encrypted_Flood"
     Then Sleep "5"



     # <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<    cleanup    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  @SID_15
  Scenario: Stop generating attacks and Logout
    Then CLI kill all simulator attacks on current vision
    Then UI logout and close browser