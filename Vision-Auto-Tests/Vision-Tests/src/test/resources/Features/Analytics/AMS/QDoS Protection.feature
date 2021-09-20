@TC122558 @Test12

Feature: QDoS Protection & Attack Category

  @SID_1
  Scenario: Clean  data before sending Qdos attack
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs


  @SID_2
  Scenario: Run DP simulator - QDos_Ahlam4
    Given CLI simulate 1000 attacks of type "QDos_Ahlam4" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds
    Then Sleep "5"
    * CLI kill all simulator attacks on current vision


  @SID_3
  Scenario:  login to vision
    Given UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "2"

  ### Forensics #####

  @SID_4
  Scenario:  Navigate to Forensics
    Given UI Navigate to "AMS Forensics" page via homePage


  @SID_5
  Scenario: create new Forensics with QDos Attack
    Given UI "Create" Forensics With Name "QDos Attack"
      | Product | DefensePro |
    Then UI "Validate" Forensics With Name "QDos Attack"
      | Product | DefensePro |

  @SID_6
  Scenario: Validate delivery card and generate Forensics
    Then UI Click Button "My Forensics" with value "QDos Attack"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "QDos Attack"
    Then Sleep "35"

  @SID_7
  Scenario: Validate Forensics.Table for QDos Attack
    And UI Click Button "Views.Forensic" with value "QDos Attack,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "QDoS"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Action" equal to "Drop"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Threat Category" equal to "QuantileDoS"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination IP Address" equal to "Multiple"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination Port" equal to "1024"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Device IP Address" equal to "172.16.22.51"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Direction" equal to "In"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack Name" equal to "QDoS"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Physical Port" equal to "1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Protocol" equal to "TCP"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Radware ID" equal to "900"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Risk" equal to "High"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Policy Name" equal to "p1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Status" equal to "Ongoing"
    When UI Click Button "Forensics.Attack Details.Close"


  @SID_8
  Scenario: Clean system  before sending Qdos attack
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs

  @SID_9
  Scenario: Run DP simulator with QDos_Ahlam4 attack
    Given CLI simulate 1000 attacks of type "QDos_Ahlam4" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds
      * CLI kill all simulator attacks on current vision



  @SID_10
  Scenario: Create Forensics with  QDos Attack and CSV Format
    Given UI "Create" Forensics With Name "CSV QDos Attack"
      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format | Select: CSV                                                                                                      |
    Then UI "Validate" Forensics With Name "CSV QDos Attack"
      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format | Select: CSV                                                                                                      |


  @SID_11
  Scenario: Validate delivery and generate CSV Forensics
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/CSV QDos Attack.zip /home/radware/ftp/CSV QDos Attack.csv" on "GENERIC_LINUX_SERVER"
    Then UI Click Button "My Forensics" with value "CSV QDos Attack"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "CSV QDos Attack"
    Then Sleep "35"


  @SID_12
  Scenario: Unzip CSV file
    Then CLI Run remote linux Command "unzip -o /home/radware/ftp/CSV\ QDos\ Attack_*.zip -d /home/radware/ftp/" on "GENERIC_LINUX_SERVER"
    Then Sleep "3"


  @SID_13
  Scenario: Validate Forensics.Table of QDos Attack1
    And UI Click Button "Views.Forensic" with value "CSV QDos Attack,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2


  @SID_14
  Scenario: Validate The number of rows attacks , numberOfRecords
    Then CLI Run linux Command "cat /home/radware/ftp/CSV\ QDos\ Attack_*.csv |grep 'S.No,Start Time,End Time,Threat Category,Attack Name,Policy Name,Source IP Address,Destination IP Address,Destination Port,Direction,Protocol' |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/ftp/CSV\ QDos\ Attack_*.csv |grep 'QuantileDoS,QDoS,p1,0.0.0.0,0.0.0.0,0,In,IP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"



  @SID_15
  Scenario: Create Forensics with  QDos Attack and CSV Format
    Given UI "Create" Forensics With Name "CSVWithDetails QDos Attack"
      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format | Select: CSVWithDetails                                                                                           |
    Then UI "Validate" Forensics With Name "CSVWithDetails QDos Attack"
      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format | Select: CSVWithDetails                                                                                           |


  @SID_16
  Scenario: Validate delivery and generate CSVWithDetails Forensics
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/CSV QDos Attack.zip /home/radware/ftp/CSVWithDetails QDos Attack.csv" on "GENERIC_LINUX_SERVER"
    Then UI Click Button "My Forensics" with value "CSVWithDetails QDos Attack"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "CSVWithDetails QDos Attack"
    Then Sleep "35"


  @SID_17
  Scenario: Unzip CSV file
    Then CLI Run remote linux Command "unzip -o /home/radware/ftp/CSVWithDetails\ QDos\ Attack_*.zip -d /home/radware/ftp/" on "GENERIC_LINUX_SERVER"
    Then Sleep "3"


  @SID_18
  Scenario: Validate Forensics.Table of QDos Attack1
    And UI Click Button "Views.Forensic" with value "CSVWithDetails QDos Attack,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2


  @SID_19
  Scenario: Validate The number of rows attacks , numberOfRecords
    Then CLI Run linux Command "cat /home/radware/ftp/CSVWithDetails\ QDos\ Attack_*.csv |grep 'S.No,Start Time,End Time,Threat Category,Attack Name,Policy Name,Source IP Address,Destination IP Address,Destination Port,Direction,Protocol' |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/ftp/CSVWithDetails\ QDos\ Attack_*.csv |grep 'QuantileDoS,QDoS,p1,0.0.0.0,0.0.0.0,0,In,IP' |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"


  @SID_20
  Scenario: Run DP simulator - many_attacks
    Given CLI simulate 1000 attacks of type "many_attacks" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds
    Then Sleep "5"
    * CLI kill all simulator attacks on current vision


  @SID_21
  Scenario: create new Forensics with QDos Attack and many attacks
    Given UI "Create" Forensics With Name "QDos Attack1"
      | Product | DefensePro |
    Then UI "Validate" Forensics With Name "QDos Attack1"
      | Product | DefensePro |

  @SID_22
  Scenario: Validate delivery and generate Forensics
    Then UI Click Button "My Forensics" with value "QDos Attack1"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "QDos Attack1"
    Then Sleep "35"

  @SID_23
  Scenario: Validate Forensics.Table of QDos Attack1
    And UI Click Button "Views.Forensic" with value "QDos Attack1,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 27


  @SID_24
  Scenario: Edit Forensics
    When UI "Edit" Forensics With Name "QDos Attack1"
      | Criteria | Event Criteria:Threat Category,Operator:Equals,Value:Quantile DoS |
    Then UI "Validate" Forensics With Name "QDos Attack1"
      | Criteria | Event Criteria:Threat Category,Operator:Equals,Value:Quantile DoS |

  @SID_25
  Scenario: Validate delivery and generate Forensics for QDos Attack1
    Then UI Click Button "My Forensics" with value "QDos Attack1"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "QDos Attack1"
    Then Sleep "35"


  @SID_26
  Scenario: Validate Forensics.Table for QDos Attack1
    And UI Click Button "Views.Forensic" with value "QDos Attack1,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "QDoS"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Action" equal to "Drop"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Threat Category" equal to "QuantileDoS"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination IP Address" equal to "Multiple"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination Port" equal to "1024"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Device IP Address" equal to "172.16.22.51"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Direction" equal to "In"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack Name" equal to "QDoS"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Physical Port" equal to "1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Protocol" equal to "TCP"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Radware ID" equal to "900"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Risk" equal to "High"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Policy Name" equal to "p1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Status" equal to "Terminated"
    When UI Click Button "Forensics.Attack Details.Close"


  @SID_27
  Scenario: Delete Forensics
    Then UI Delete Forensics With Name "QDos Attack1"
    Then UI Delete Forensics With Name "QDos Attack"
    Then UI Delete Forensics With Name "CSV QDos Attack"
    Then UI Delete Forensics With Name "CSVWithDetails QDos Attack"

  ### Attacks Dashboard ###


  @SID_28
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs

  @SID_29
  Scenario: Run DP simulator - QDos_Ahlam4 attack
    Given CLI simulate 1000 attacks of type "QDos_Ahlam4" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds
    * CLI kill all simulator attacks on current vision

    
  @SID_30
  Scenario: Navigate to DefensePro Attacks dashboard
    And UI Navigate to "DefensePro Attacks" page via homePage
    Then Sleep "5"
    When UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1H"
    Then UI UnSelect Element with label "Accessibility Auto Refresh" and params "Stop Auto-Refresh"
    When UI set "Auto Refresh" switch button to "off"
    Given UI Click Button "Accessibility Menu"
    Then UI Select Element with label "Accessibility Auto Refresh" and params "Stop Auto-Refresh"
    Then UI Click Button "Accessibility Menu"

  @SID_33
  Scenario:  Validate rows count for Attacks Table and Sort rows
    Then UI Validate "Attacks Table" Table rows count EQUALS to 2
    Then Sort "UP" rows in Attacks Table By ColName "lastPeriodPacketRate"

  @SID_31
  Scenario:  Validate Attacks Table Values first row
    Then UI Validate Table record values by columns with elementLabel "Attacks Table" findBy index 0
      | columnName             | value        |
      | Attack Name            | QDoS         |
      | Attack Category        | Quantile DoS |
      | Policy Name            | p1           |
      | Packet Rate            | 2197         |
      | Status                 | Ongoing      |
      | Protocol               | TCP          |
      | Device IP Address      | 172.16.22.51 |
      | Volume                 | 394.61 MB    |
      | Source IP Address      | 192.85.1.2   |
      | Destination IP Address | Multiple     |
      | Destination Port       | 1024         |

  @SID_31
  Scenario:  Validate Attacks Table Values second row
    Then UI Validate Table record values by columns with elementLabel "Attacks Table" findBy index 1
      | columnName             | value        |
      | Attack Name            | QDoS         |
      | Attack Category        | Quantile DoS |
      | Policy Name            | p1           |
      | Packet Rate            | 2211         |
      | Status                 | Ongoing      |
      | Protocol               | TCP          |
      | Device IP Address      | 172.16.22.51 |
      | Volume                 | 396.45 MB    |
      | Source IP Address      | 192.85.1.2   |
      | Destination IP Address | Multiple     |
      | Destination Port       | 1024         |

  @SID_31
  Scenario:  click on first row in attack label
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Packet Rate" findBy cellValue "2197"


  @SID_32
  Scenario Outline:  validate date of Info table
    Then Validate Expand "Info" Table with label "<label>" Equals to "<value>"
    Examples:
      | label              | value   |
      | Risk               | High    |
      | Radware ID         | 900     |
      | Direction          | In      |
      | Action Type        | Drop    |
      | Physical Port      | 1       |
      | Total Packet Count | 263,774 |
      | VLAN               | N/A     |
      | MPLS RD            | N/A     |
      | Source port        | 0       |
      | Packet Type        | Regular |


  @SID_42
  Scenario Outline:  validate data of Characteristics table
    Then Validate Expand "Characteristics" Table with label "<label>" Equals to "<value>"
    Examples:
      | label                              | value                         |
      | Quantile Number                    | 40                            |
      | Attacked Quantile IP Address Range | 192.0.199.147 - 192.0.204.157 |
      | Current Policy Bandwidth           | 164 Mbps                      |
      | Detection Sensitivity              | 2%                            |
      | Peacetime Quantile Bandwidth       | 3.3 Mbps                      |
      | Dropped Quantile Bandwidth         | 25.6 Mbps                     |
      | Current Quantile Bandwidth         | 25.8 Mbps                     |
      | Quantile Rate Limit                | Moderate 150%, 2.2 Mbps       |
      | Mitigation Method                  | Quantile Top Talkers          |


  @SID_31
  Scenario:  close first row and click on second row in attacks table
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Packet Rate" findBy cellValue "2197"
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Packet Rate" findBy cellValue "2211"

  @SID_32
  Scenario Outline:  validate date of Info table
    Then Validate Expand "Info" Table with label "<label>" Equals to "<value>"
    Examples:
      | label              | value   |
      | Risk               | High    |
      | Radware ID         | 900     |
      | Direction          | In      |
      | Action Type        | Drop    |
      | Physical Port      | 1       |
      | Total Packet Count | 265,008 |
      | VLAN               | N/A     |
      | MPLS RD            | N/A     |
      | Source port        | 0       |
      | Packet Type        | Regular |

  @SID_39
  Scenario Outline:  validate data of Characteristics table
    Then Validate Expand "Characteristics" Table with label "<label>" Equals to "<value>"
    Examples:
      | label                              | value                        |
      | Quantile Number                    | 1                            |
      | Attacked Quantile IP Address Range | 0:0:0:0:0:0:0:0 - 192.0.5.47 |
      | Current Policy Bandwidth           | 164 Mbps                     |
      | Detection Sensitivity              | 2%                           |
      | Peacetime Quantile Bandwidth       | 3.3 Mbps                     |
      | Dropped Quantile Bandwidth         | 25.9 Mbps                    |
      | Current Quantile Bandwidth         | 25.5 Mbps                    |
      | Quantile Rate Limit                | Moderate 150%, 3.5 Mbps      |
      | Mitigation Method                  | Quantile Top Talkers         |

    ### Alrerts #####

  @SID_41
  Scenario: Clean system data before QDos
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs

  @SID_42
  Scenario: Navigate to Alerts
    And UI Navigate to "AMS Alerts" page via homePage


  @SID_43
  Scenario: Create Alert basic
    When UI "Create" Alerts With Name "QDos Alerts"
      | Basic Info | Description:QDos Attacks                                          |
      | Criteria   | Event Criteria:Threat Category,Operator:Equals,Value:Quantile DoS |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                                 |


  @SID_44
  Scenario: Run DP simulator - QDos_Ahlam4
    Given CLI simulate 1000 attacks of type "QDos_Ahlam4" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds
      * CLI kill all simulator attacks on current vision


  @SID_45
  Scenario: VRM Validate Alert Threat Category HTTPS Flood Any Time Schedule
    Then UI "Check" all the Toggle Alerts
    When UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "QDos Alerts"
    Then UI Validate "Report.Table" Table rows count EQUALS to 1
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName        | value                   |
      | Severity          | MINOR                   |
      | Device Name       | DefensePro_172.16.22.51 |
      | Device IP Address | 172.16.22.51            |
    Then UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy index 0
    Then UI Validate Table record values by columns with elementLabel "Alert details" findBy index 0
      | columnName             | value       |
      | Threat Category        | QuantileDoS |
      | Attack Name            | QDoS        |
      | Policy Name            | p1          |
      | Source IP Address      | 192.85.1.2  |
      | Destination IP Address | Multiple    |
      | Destination Port       | 1024        |
      | Direction              | In          |
      | Protocol               | TCP         |
    Then UI Click Button "Table Details OK" with value "OK"

  @SID_46
  Scenario: VRM Validate Alert browser for QDos attack
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: QDos Alerts \nSeverity: MINOR \nDescription: QDos Attacks \nImpact: N/A \nRemedy: N/A \nDevice IP: 172.16.22.51 \nAttacks Count: 1 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"

  @SID_47
  Scenario: Delete Alerts
    Then UI Delete Alerts With Name "QDos Alerts"



    ### DP Monitoring ###


  @SID_48
  Scenario: Clean system data before sending Qdos attack
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs

  @SID_49
  Scenario: Run DP simulator - QDos_Ahlam4
    Given CLI simulate 1000 attacks of type "QDos_Ahlam4" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds
    * CLI kill all simulator attacks on current vision


  @SID_50
  Scenario:  Navigate to DefensePro Monitoring Dashboard
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then Sleep "30"


  @SID_51
  Scenario: Validate first under attack policy - attacks
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 0
      | columnName            | value                   |
      | Site                  | RealDPs_Version_8_site  |
      | Device                | DefensePro_172.16.22.51 |
      | Policy Name           | p1                      |
      | Policy Status         | underAttack             |
      | Total Inbound Traffic | 168.01 Mbps             |
      | Attack Rate           | 52.74 Mbps              |
      | Drop Rate             | 52.74 Mbps              |
      | Attack Category       | Quantile DoS            |


  @SID_52
  Scenario: Entering to the under attack policy 
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0

  @SID_53
  Scenario: validate events
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Protections Table" findBy index 0
      | columnName      | value        |
      | Protection Name | Quantile DoS |
      | Attack Rate     | 51.53 Mbps   |
      | Drop Rate       | 51.53 Mbps   |
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy index 0
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "39-1630605835"

  @SID_46
  Scenario: Validate Characteristics card data -monitoring
    Then UI Validate Text field "Characteristics Labels" with params "40" EQUALS "40"
    Then UI Validate Text field "Characteristics Labels" with params "192.0.199.147 - 192.0.204.157" EQUALS "192.0.199.147 - 192.0.204.157"
    Then UI Validate Text field "Characteristics Labels" with params "164 Mbps" EQUALS "164 Mbps"
    Then UI Validate Text field "Characteristics Labels" with params "2%" EQUALS "2%"
    Then UI Validate Text field "Characteristics Labels" with params "3.3 Mbps" EQUALS "3.3 Mbps"
    Then UI Validate Text field "Characteristics Labels" with params "25.6 Mbps" EQUALS "25.6 Mbps"
    Then UI Validate Text field "Characteristics Labels" with params "25.8 Mbps" EQUALS "25.8 Mbps"
    Then UI Validate Text field "Characteristics Labels" with params "Quantile Top Talkers" EQUALS "Quantile Top Talkers"


  @SID_44
  Scenario: Navigate to DefensePro Monitoring Dashboard
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy index 0
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "38-1630605835"

  @SID_44
  Scenario: Validate Characteristics card data -monitoring
    Then UI Validate Text field "Characteristics Labels" with params "1" EQUALS "1"
    Then UI Validate Text field "Characteristics Labels" with params "0:0:0:0:0:0:0:0 - 192.0.5.47" EQUALS "0:0:0:0:0:0:0:0 - 192.0.5.47"
    Then UI Validate Text field "Characteristics Labels" with params "164 Mbps" EQUALS "164 Mbps"
    Then UI Validate Text field "Characteristics Labels" with params "2%" EQUALS "2%"
    Then UI Validate Text field "Characteristics Labels" with params "3.3 Mbps" EQUALS "3.3 Mbps"
    Then UI Validate Text field "Characteristics Labels" with params "25.9 Mbps" EQUALS "25.9 Mbps"
    Then UI Validate Text field "Characteristics Labels" with params "25.5 Mbps" EQUALS "25.5 Mbps"
    Then UI Validate Text field "Characteristics Labels" with params "Quantile Top Talkers" EQUALS "Quantile Top Talkers"

  @SID_54
  Scenario: click and validate Quantile Status chart
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    Then UI Click Button "Quantiles Status"
    Then UI Validate Virtical StackBar data with widget "qdosChart"
      | label | value | legendName   |
      | 0     | 25852 | Under Attack |
      | 1     | 2430  | Peacetime    |
      | 5     | 2070  | Peacetime    |
      | 10    | 2178  | Peacetime    |
      | 20    | 2001  | Peacetime    |
      | 30    | 2124  | Peacetime    |
      | 39    | 25768 | Under Attack |
      | 40    | 2211  | Peacetime    |
      | 45    | 2417  | Peacetime    |

    Then UI Click Button "Exit button"


  @SID_55
  Scenario: Logout and close browser
    Given UI logout and close browser
    Given UI Logout





