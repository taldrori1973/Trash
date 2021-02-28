@DFForensics @TC113513
Feature: Defense Flow Forensic Wizard

  
  @SID_1 @Sanity
  Scenario: Clean system data before Forensics Appwall Test
    Given CLI kill all simulator attacks on current vision
    * REST Delete ES index "forensics-*"
    And REST Delete ES index "dfforensics*"
    And REST Delete ES index "df-attack-raw*"
    And CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    And CLI Reset radware password

    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    * CLI Clear vision logs

  
  @SID_2 @Sanity
  Scenario: Change DF management IP to IP of Generic Linux
    When CLI Operations - Run Radware Session command "system df management-ip set 172.17.164.10"
    When CLI Operations - Run Radware Session command "system df management-ip get"
    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 172.17.164.10"

  
  @SID_3 @Sanity
  Scenario: Login and navigate to forensics
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Vision Install License Request "vision-reporting-module-AMS"
    Then UI Navigate to "New Forensics" page via homepage
    Then UI Click Button "New Forensics Tab"
  
  @SID_4 @Sanity
  Scenario: Run DF attacks
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_101.sh "                     |
      | #visionIP |
      | " Terminated" |

  
  @SID_5 @Sanity
  Scenario: create forensic definition Wizard_test
    Given UI "Create" Forensics With Name "Wizard_test"
      | Product | DefenseFlow |
      | Output  | Start Time,End Time,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Max pps,Max bps |
      | Time Definitions.Date | Quick:1D |
      | Format | Select: CSV |
      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |


  
  @SID_6 @Sanity
  Scenario: create forensic definition Second_view
    Given UI "Create" Forensics With Name "Source_Address"
      | Product | DefenseFlow |
      | Criteria | Event Criteria:Source IP,Operator:Equals,IPType:IPv4,IPValue:100.100.100.103; |
      | Output  | Start Time,End Time,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Max pps,Max bps |
      | Time Definitions.Date | Quick:1D |
      | Format | Select: CSV |
      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |

  
  @SID_7 @Sanity
  Scenario: Forensic wizard test Validate ForensicsView
    Then UI Click Button "My Forensics" with value "Wizard_test"
    Then UI Validate Element Existence By Label "Generate Snapshot Forensics Manually" if Exists "true" with value "Wizard_test"
  
  @SID_8 @Sanity
  Scenario: Forensic wizard test Generate Wizard_test
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Wizard_test"
    Then Sleep "35"
    When UI Click Button "Views.Forensic" with value "Wizard_test,0"

  @SID_9
  Scenario: VRM - Forensic wizard test Validate Table
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName | value |
      | Action     | Drop  |
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy index 0
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Action" equal to "Drop"
    Then UI Click Button "Forensics.Attack Details.Close"

  @SID_10
  Scenario: VRM - Validate Forensic "Wizard" Delete Wizard
    Then UI Click Button "Delete Forensics" with value "Wizard_test"
    Then UI Click Button "Cancel Delete Forensics"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "true" with value "Wizard_test"
    Then UI Delete Forensics With Name "Wizard_test"
    And Sleep "1"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "false" with value "Wizard_test"

  
  @SID_11 @Sanity
  Scenario: Forensic Source_Address Validate ForensicsView
    Then UI Click Button "My Forensics" with value "Source_Address"
    Then UI Validate Element Existence By Label "Generate Snapshot Forensics Manually" if Exists "true" with value "Source_Address"

  
  @SID_12 @Sanity
  Scenario: Forensic wizard test Generate Source_Address
    When UI Click Button "Generate Snapshot Forensics Manually" with value "Source_Address"
    When UI Click Button "Views.Forensic" with value "Source_Address,0"

  
  @SID_13
  Scenario: Forensic wizard test Validate Table
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName | value |
      | Source IP Address     | 100.100.100.103  |
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy index 0
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Action" equal to "Drop"
    Then UI Click Button "Forensics.Attack Details.Close"

  
  @SID_14
  Scenario: Validate attack details refine by Action
    When UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "HTTP (recv.pps)"
    And UI Click Button "Refine View"
    And UI Select Multi items from dropdown "Refine by" apply
      | Attack Name |
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 3
    * UI Click Button "Clear Refine"
  @SID_15
  Scenario: VRM - Validate Forensic "Source_Address" Delete Wizard
    Then UI Click Button "Delete Forensics" with value "Source_Address"
    Then UI Click Button "Cancel Delete Forensics"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "true" with value "Source_Address"
    Then UI Delete Forensics With Name "Source_Address"
    And Sleep "1"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "false" with value "Source_Address"


#    ------------------- Ahlam - Add test for Connection PPS  -----------------

  
  @SID_16
  Scenario: create forensic definition Category_ConnectionPPS
    Given UI "Create" Forensics With Name "Category_ConnectionPPS"
      | Product | DefenseFlow |
      | Criteria | Event Criteria:Threat Category,Operator:Equals,Value:[ConnectionPPS] |
      | Output  | Start Time,End Time,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Max pps,Max bps |
      | Time Definitions.Date | Quick:1D |
      | Format | Select: CSV |
      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |

  
  @SID_17
  Scenario: Forensic Category_ConnectionPPS Validate ForensicsView
    Then UI Click Button "My Forensics" with value "Category_ConnectionPPS"
    Then UI Validate Element Existence By Label "Generate Snapshot Forensics Manually" if Exists "true" with value "Category_ConnectionPPS"

  
  @SID_18
  Scenario: Forensic wizard test Generate Category_ConnectionPPS
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Category_ConnectionPPS"
    Then Sleep "35"
    When UI Click Button "Views.Forensic" with value "Category_ConnectionPPS,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 1

  @SID_19 @Sanity
  Scenario: Logout
    When UI logout and close browser
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal\|error | NOT_EXPECTED |

