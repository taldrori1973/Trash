@AWForensics @TC113209
Feature: Appwall Forensic Wizard

  
  @SID_1 @Sanity
  Scenario: Clean system data before Forensics Appwall Test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "forensics-*"
    * REST Delete ES index "appwall-v2-attack-raw*"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    And Sleep "5"
    * CLI Clear vision logs

  
  @SID_2 @Sanity
  Scenario: Login and navigate to forensics
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Vision Install License Request "vision-AVA-AppWall"
    * REST Vision Install License Request "vision-reporting-module-AMS"
    Then REST Add device with SetId "AppWall_Set_1" into site "AW_site"
    Then Browser Refresh Page
    Then UI Navigate to "AMS Forensics" page via homepage
    Then UI Click Button "New Forensics Tab"

  
  @SID_3
  Scenario: Run AW attacks
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/AW_Attacks/sendAW_Attacks.sh "                     |
      | #visionIP                                                         |
      | " 172.17.164.30 5 "/home/radware/AW_Attacks/AppwallAttackTypes/"" |
    And Sleep "120"

  
  @SID_4 @Sanity
  Scenario: create forensic definition Wizard_test
    Given UI "Create" Forensics With Name "Wizard_test"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Criteria | Event Criteria:Action,Operator:Not Equals,Value:[Modified]; |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Time Definitions.Date | Quick:1D |
      | Format | Select: CSV |
      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                               |

  @SID_5 @Sanity
  Scenario: Forensic wizard test Validate ForensicsView
    Then UI Click Button "My Forensics" with value "Wizard_test"
    Then UI Validate Element Existence By Label "Generate Snapshot Forensics Manually" if Exists "true" with value "Wizard_test"



  @SID_6 @Sanity
  Scenario: Forensic wizard test Generate Now
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Wizard_test"
    Then Sleep "35"
    
    When UI Click Button "Views.Forensic" with value "Wizard_test,0"

  @SID_7
  Scenario: VRM - Forensic wizard test Validate Table
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName | value |
      | Device Host Name     | appwall  |

  @SID_8
  Scenario: VRM - Validate Forensic "Wizard" Delete Wizard
    Then UI Click Button "Delete Forensics" with value "Wizard_test"
    Then UI Click Button "Cancel Delete Forensics"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "true" with value "Wizard_test"
    Then UI Delete Forensics With Name "Wizard_test"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "false" with value "Wizard_test"


  @SID_9 @Sanity
  Scenario: Logout
    When UI logout and close browser
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal\|error | NOT_EXPECTED |

