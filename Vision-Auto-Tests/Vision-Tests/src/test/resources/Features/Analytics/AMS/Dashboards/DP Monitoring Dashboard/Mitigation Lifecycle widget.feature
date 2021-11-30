@TC124098
Feature: Attack Level "Mitigation Lifecycle"

   
  @SID_1
  Scenario: Clean data before sending Qdos attack
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs
   
  @SID_2
  Scenario: Run DP simulator - QDos_Ahlam4
    Given CLI simulate 1000 attacks of type "QDos_Ahlam4" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds
    Then Sleep "5"
    * CLI kill all simulator attacks on current vision

   
  @SID_3
  Scenario:  login to vision and navigate to DP Monitoring
    Given UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then Sleep "30"


  @SID_4
  Scenario: Enter DefensePro Dashboard Via "Protection Policies" table
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "p1"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Quantile DoS"


  @SID_5
  Scenario: validate QDos State attack ID 38-1630605835
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "38-1630605835"
    Then UI Validate Line Chart data "Mitigation Life Cycle" with Label "Quantile Top Talkers"
      | value  | count |
      | 26074  | 1   |
      | 25607  | 1   |
      | 25922  | 1   |
      | 25747  | 1   |
      | 25806  | 1   |
      | 26028  | 1   |
      | 25525  | 1   |
      | 25852  | 1   |
      | 25794  | 1   |

  @SID_6
  Scenario: back to the previous page to choose the second Attack ID
    When UI Click Button "Protection Policies.GO BACK" with value " GO BACK"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Quantile DoS"



  @SID_7
  Scenario: validate QDos State attack ID 39-1630605835
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "39-1630605835"
    Then UI Validate Line Chart data "Mitigation Life Cycle" with Label "Quantile Top Talkers"
      | value  | count |
      | 25841  | 1   |
      | 25478  | 1   |
      | 25782  | 1   |
      | 25408  | 1   |
      | 25619  | 1   |
      | 25712  | 1   |
      | 25724  | 1   |
      | 25630  | 1   |
      | 25899  | 1   |








    # <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<   another attack   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  @SID_1
  Scenario: Clean data before sending Qdos attack
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
   # * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator - test_pcap
    Given CLI simulate 1 attacks of type "test_pcap" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds
    Then Sleep "5"
    * CLI kill all simulator attacks on current vision


  @SID_3
  Scenario:  navigate to DP Monitoring
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then Sleep "30"


  @SID_4
  Scenario: Enter DefensePro Dashboard Via "Protection Policies" table
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "p1"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Quantile DoS"


  @SID_5
  Scenario: validate QDos State attack ID 35-1637605817
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "35-1637605817"
    Then UI Validate Line Chart data "Mitigation Life Cycle" with Label "Real-Time Signature (RTS)"
      | value  | count |
      | 1562  | 6   |
    Then UI Validate Line Chart data "Mitigation Life Cycle" with Label "Quantile Rate-Limit"
      | value  | count |
      | 781  | 6   |
    Then UI Validate Line Chart data "Mitigation Life Cycle" with Label "Quantile Top Talkers"
      | value  | count |
      | 781  | 6   |





  #      <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<   Forensics      >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
   
  @SID_10
  Scenario: Navigate to Forensics and create new Forensics with name QuantileDoS
    Given UI Navigate to "AMS Forensics" page via homePage
    Then Sleep "30"
    Given UI "Create" Forensics With Name "QuantileDoS"
      | Product | DefensePro |
      | Output                | Start Time,End Time,Threat Category,Attack Name,Policy Name,Source IP Address,Destination IP Address,Destination Port,Direction,Protocol,Device IP Address,Action,Attack ID,Source Port,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag,Packet Type |
      | Format                | Select: CSV with Attack Details                                                                                                                                                                                                                                                                                                   |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:Quantile DoS                                                                                                                                                                                                                                   |
      | Time Definitions.Date | Quick:Today|
   
  @SID_11
  Scenario: Forensic New Category Validate ForensicsView
    Then UI Click Button "My Forensics" with value "QuantileDoS"
    Then UI Validate Element Existence By Label "Generate Snapshot Forensics Manually" if Exists "true" with value "QuantileDoS"

   
  @SID_12
  Scenario: Forensic test Generate Quantile DoS
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "QuantileDoS"
    Then Sleep "45"
    When UI Click Button "Views.Forensic" with value "QuantileDoS,0"

   
  @SID_13
  Scenario: VRM - Forensic Quantile DoS Validate Table
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName | value |
      | Threat Category     | Quantile DoS  |
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy index 0
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Threat Category" equal to "QuantileDoS"
    Then UI Click Button "Forensics.Attack Details.Close"


  @SID_14
  Scenario: VRM - Validate Forensic "Quantile DoS" Delete
    Then UI Click Button "Delete Forensics" with value "QuantileDoS"
    Then UI Click Button "Cancel Delete Forensics"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "true" with value "QuantileDoS"
    Then UI Delete Forensics With Name "QuantileDoS"
    And Sleep "1"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "false" with value "QuantileDoS"
    Then Sleep "5"



# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< logout >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  @SID_8
  Scenario: Stop generating attacks and Logout
    Then CLI kill all simulator attacks on current vision
    Then UI logout and close browser



