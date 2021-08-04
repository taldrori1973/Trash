@TC122558

Feature: QDoS Protection & Attack Category

  @Test12
  @SID_1
  Scenario: Clean system data before Traffic Bandwidth test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs

    ## Run trap.pcap
  @Test12
  @SID_2
  Scenario: Run DP simulator - trap
    Given CLI simulate 1000 attacks of type "trap" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds
    Then Sleep "5"
    * CLI kill all simulator attacks on current vision

  @Test12
  @SID_3
  Scenario:  login to vision
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "2"



  ### Forensics #####
  # 1. create Forensics with Qdos category
  # 2. validate that get row in table and validate values
  #3. check values in All formats

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
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 1
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "QDoS"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Action" equal to "Drop"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack ID" equal to "710-1626720668"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Threat Category" equal to "QuantileDoS"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination IP Address" equal to "0.0.0.0"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination Port" equal to "0"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Device IP Address" equal to "172.16.22.51"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Direction" equal to "In"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack Name" equal to "QDoS"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Physical Port" equal to "1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Protocol" equal to "IP"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Radware ID" equal to "900"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Risk" equal to "High"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Policy Name" equal to "p1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Status" equal to "Started"
    When UI Click Button "Forensics.Attack Details.Close"

#  
#  @SID_9
#  Scenario: Edit Forensics with QDos Attack to CSV Format
#    Given UI "Edit" Forensics With Name "QDos Attack"
#      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format | Select: CSVWithDetails                                                                                           |
#    Then UI "Validate" Forensics With Name "QDos Attack"
#      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
#      | Format | Select: CSVWithDetails                                                                                           |
#
#  
#  @SID_10
#  Scenario: Validate delivery and generate CSV Forensics
#    Then UI Click Button "My Forensics" with value "QDos Attack"
#    Then UI Click Button "Generate Snapshot Forensics Manually" with value "QDos Attack"
#    Then Sleep "35"


  @SID_8
  Scenario: Run DP simulator - many_attacks
    Given CLI simulate 1000 attacks of type "many_attacks" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds
    Then Sleep "5"
    * CLI kill all simulator attacks on current vision


  @SID_9
  Scenario: create new Forensics with QDos Attack and many attacks
    Given UI "Create" Forensics With Name "QDos Attack1"
      | Product | DefensePro |
    Then UI "Validate" Forensics With Name "QDos Attack1"
      | Product | DefensePro |

  @SID_10
  Scenario: Validate delivery and generate Forensics
    Then UI Click Button "My Forensics" with value "QDos Attack1"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "QDos Attack1"
    Then Sleep "35"

  @SID_11
  Scenario: Validate Forensics.Table of QDos Attack1
    And UI Click Button "Views.Forensic" with value "QDos Attack1,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 26


  @SID_12
  Scenario: Edit Forensics
    When UI "Edit" Forensics With Name "QDos Attack1"
      | Criteria | Event Criteria:Threat Category,Operator:Equals,Value:Quantile DoS |
    Then UI "Validate" Forensics With Name "QDos Attack1"
      | Criteria | Event Criteria:Threat Category,Operator:Equals,Value:Quantile DoS |

  @SID_13
  Scenario: Validate delivery and generate Forensics for QDos Attack1
    Then UI Click Button "My Forensics" with value "QDos Attack1"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "QDos Attack1"
    Then Sleep "35"


  @SID_14
  Scenario: Validate Forensics.Table for QDos Attack1
    And UI Click Button "Views.Forensic" with value "QDos Attack1,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 1
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "QDoS"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Action" equal to "Drop"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack ID" equal to "710-1626720668"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Threat Category" equal to "QuantileDoS"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination IP Address" equal to "0.0.0.0"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Destination Port" equal to "0"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Device IP Address" equal to "172.16.22.51"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Direction" equal to "In"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Attack Name" equal to "QDoS"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Physical Port" equal to "1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Protocol" equal to "IP"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Radware ID" equal to "900"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Risk" equal to "High"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Policy Name" equal to "p1"
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Status" equal to "Terminated"
    When UI Click Button "Forensics.Attack Details.Close"


  @SID_15
  Scenario: Delete Forensics
    Then UI Delete Forensics With Name "QDos Attack1"
    Then UI Delete Forensics With Name "QDos Attack"



  ### Attacks Dashboard ###

   # 1. check "Attacks Category" column value will be " QuantileDoS "
  # 2. validate value og table

  @SID_15
  Scenario: Clean system data before Traffic Bandwidth test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs

  @SID_16
  Scenario: Run DP simulator - trap
    Given CLI simulate 1000 attacks of type "trap" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds

  @SID_17
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

  @SID_17
  Scenario:  Validate Attacks Table Values
    Then UI Validate Table record values by columns with elementLabel "Attacks Table" findBy index 0
      | columnName             | value        |
      | Attack Name            | QDoS         |
      | Attack Category        | QuantileDoS  |
      | Policy Name            | p1           |
      | Packet Rate            | 0            |
      | Status                 | Started      |
      | Protocol               | IP           |
      | Device IP Address      | 172.16.22.51 |
      | Volume                 | 0 B          |
      | Source IP Address      | 0.0.0.0      |
      | Destination IP Address | 0.0.0.0      |
      | Destination Port       | 0            |
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Policy Name" findBy cellValue "p1"

  @SID_18
  Scenario Outline:  validate date of Info table
    Then Validate Expand "Info" Table with label "<label>" Equals to "<value>"
    Examples:
      | label              | value          |
      | Risk               | High           |
      | Radware ID         | 900            |
      | Direction          | In             |
      | Action Type        | Drop           |
      | Attack ID          | 710-1626720668 |
      | Physical Port      | 1              |
      | Total Packet Count | 0              |
      | VLAN               | N/A            |
      | MPLS RD            | N/A            |
      | Source port        | 0              |
      | Packet Type        | N/A            |

  @SID_19
  Scenario:  Validate rows count for Attacks Table
    Then UI Validate "Attacks Table" Table rows count EQUALS to 1




    ### Alrerts #####
  # 1. create alert with Qdos category then run attack
  # 2. validate that get row in table and validate values
  #3. check values in All formats


  @SID_15
  Scenario: Clean system data before Traffic Bandwidth test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs


  @SID_2
  Scenario: Navigate to Alerts
    And UI Navigate to "AMS Alerts" page via homePage


  @SID_3
  Scenario: Create Alert basic
    When UI "Create" Alerts With Name "QDos Alerts"
      | Basic Info | Description:QDos Attacks                                          |
      | Criteria   | Event Criteria:Threat Category,Operator:Equals,Value:Quantile DoS |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                                 |


  @SID_16
  Scenario: Run DP simulator - trap
    Given CLI simulate 1000 attacks of type "trap" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds


  @SID_6
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
      | Source IP Address      | 0.0.0.0     |
      | Destination IP Address | 0.0.0.0     |
      | Destination Port       | 0           |
      | Direction              | In          |
      | Protocol               | IP          |
    Then UI Click Button "Table Details OK" with value "OK"


  @SID_6
  Scenario: VRM Validate Alert browser for HTTPS Flood Any Schedule
    Then CLI Run remote linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_30000: Vision Analytics Alerts \nAlert Name: QDos Alerts \nSeverity: MINOR \nDescription: QDos Attacks \nImpact: N/A \nRemedy: N/A \nDevice IP: 172.16.22.51 \nAttacks Count: 1 \n"}}]}},"from":0,"size":100}' localhost:9200/alert/_search?pretty |grep "ANALYTICS_ALERTS" |wc -l" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "\b2\b"


    ### DP Monitoring ###
  # 1. check "Attacks Categories" column value will be " QuantileDoS "
  # 2. in 2 drill Protection Name will be  "Quantile DoS"

  @SID_15
  Scenario: Clean system data before Traffic Bandwidth test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs

  @SID_16
  Scenario: Run DP simulator - trap
    Given CLI simulate 1000 attacks of type "trap" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds

  @Test12
  @SID_4
  Scenario:  Navigate to DefensePro Monitoring Dashboard
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @Test12
  @SID_5
  Scenario: Validate first under attack policy - traffic and attacks
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 0
      | columnName            | value                   |
      | Site                  | RealDPs_Version_8_site  |
      | Device                | DefensePro_172.16.22.51 |
      | Policy Name           | p1                      |
      | Policy Status         | underAttack             |
      | Total Inbound Traffic | 0 bps                   |
      | Attack Rate           | 0                       |
      | Drop Rate             | 0 bps                   |
      | Attack Categories     | Quantile DoS            |

  @Test12
  @SID_4
  Scenario: Entering to the under attack policy 2nd drill
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0

  1
  @SID_8
  Scenario: validate events by Category table rows - sort by Alphabet
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Protections Table" findBy index 0
      | columnName      | value        |
      | Protection Name | Quantile DoS |
      | Attack Rate     | 0 bps        |
      | Drop Rate       | 0 bps        |

  @SID_20
  Scenario: Logout and close browser
    Given UI logout and close browser
    Given UI Logout




