@DFForensics @TC113513
Feature: Defense Flow Forensic Wizard

  @SID_1 @Sanity
  Scenario: Clean system data before Forensics Appwall Test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dfforensics*"
    * REST Delete ES index "df-attack-raw*"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720

    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    * CLI Clear vision logs

  @SID_2 @Sanity
  Scenario: Change DF managment IP to IP of Generic Linux
    When CLI Operations - Run Radware Session command "system df management-ip set 172.17.164.10"
    When CLI Operations - Run Radware Session command "system df management-ip get"
    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 172.17.164.10"

  @SID_3 @Sanity
  Scenario: Login and navigate to forensics
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Vision Install License Request "vision-reporting-module-AMS"
    And UI Navigate to "AMS Forensics" page via homePage

  @SID_4 @Sanity
  Scenario: Run AW attacks
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_101.sh "                     |
      | #visionIP |
      | " Terminated" |

  @SID_5 @Sanity
  Scenario: create forensic definition Wizard_test
    Given UI "Create" Forensics With Name "Wizard_test"
      | Product | DefenseFlow |
      | Output  | Start Time, End Time, Attack Name, Action, Attack ID, Policy Name, Source IP Address, Source Port, Max pps, Max bps |
      | Time Definitions.Date | Quick:1D |
      | Format | Select: CSV |
      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |

  @SID_6 @Sanity
  Scenario: create forensic definition Second_view
    Given UI "Create" Forensics With Name "Source_Address"
      | Product | DefenseFlow |
      | Criteria | Event Criteria:Source IP,Operator:Equals,IPType:IPv4,IPValue:100.100.100.103; |
      | Output  | Start Time, End Time, Attack Name, Action, Attack ID, Policy Name, Source IP Address, Source Port, Max pps, Max bps |
      | Time Definitions.Date | Quick:1D |
      | Format | Select: CSV |
      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |

  @SID_7 @Sanity
  Scenario: Forensic wizard test Validate ForensicsView
    When UI Click Button "Views.Expand" with value "Wizard_test"
    Then UI Validate Element Existence By Label "Views.Generate Now" if Exists "true" with value "Wizard_test"


  @SID_8 @Sanity
  Scenario: Forensic wizard test Generate Now
    When UI Click Button "Views.Generate Now" with value "Wizard_test"
    And Sleep "120"
    When UI Click Button "Views.report" with value "Wizard_test"


  @SID_9
  Scenario: VRM - Forensic wizard test Validate Table
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName | value |
      | Action     | Drop  |
    Then UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy index 0
    Then UI Text of "Report.Attack Details.Detail" with extension "Action" equal to "Drop"
    Then UI Click Button "Report.Attack Details.Close"

  @SID_10
  Scenario: VRM - Validate Forensic "Wizard" Delete Wizard
    When UI Delete "Wizard_test" and Cancel
    Then UI Validate Element Existence By Label "Views" if Exists "true" with value "Wizard_test"
    When UI Delete "Wizard_test" and Approve
    And Sleep "1"
    Then UI Validate Element Existence By Label "Views" if Exists "false" with value "Wizard_test"

  @SID_11 @Sanity
  Scenario: Forensic wizard test Validate ForensicsView
    When UI Click Button "Views.Expand" with value "Source_Address"
    Then UI Validate Element Existence By Label "Views.Generate Now" if Exists "true" with value "Source_Address"

  @SID_12 @Sanity
  Scenario: Forensic wizard test Generate Now
    When UI Click Button "Views.Generate Now" with value "Source_Address"
    When UI Click Button "Views.report" with value "Source_Address"

  @SID_13
  Scenario: VRM - Forensic wizard test Validate Table
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName | value |
      | Source IP Address     | 100.100.100.103  |
    Then UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy index 0
    Then UI Text of "Report.Attack Details.Detail" with extension "Action" equal to "Drop"
    Then UI Click Button "Report.Attack Details.Close"

  @SID_14
  Scenario: Validate attack details refine by Action
    When UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy columnName "Attack Name" findBy cellValue "HTTP (recv.pps)"
    And UI Click Button "Report.Attack Details.Refine View"
    And UI Select Multi items from dropdown "Report.Attack Details.Refine.Dropdown" apply
      | Attack Name |
    Then UI Validate "Report.Table" Table rows count EQUALS to 3
    * UI Click Button "Report.Clear Refine"
  @SID_15
  Scenario: VRM - Validate Forensic "Wizard" Delete Wizard
    When UI Delete "Source_Address" and Cancel
    Then UI Validate Element Existence By Label "Views" if Exists "true" with value "Source_Address"
    When UI Delete "Source_Address" and Approve
    And Sleep "1"
    Then UI Validate Element Existence By Label "Views" if Exists "false" with value "Source_Address"

#    ------------------- Ahlam - Add test for Connection PPS  -----------------

  @SID_16
  Scenario: create forensic definition Second_view
    Given UI "Create" Forensics With Name "Category_ConnectionPPS"
      | Product | DefenseFlow |
      | Criteria | Event Criteria:Threat Category,Operator:Equals,Value:[Connection PPS]; |
      | Output  | Start Time, End Time, Attack Name, Action, Attack ID, Policy Name, Source IP Address, Source Port, Max pps, Max bps |
      | Time Definitions.Date | Quick:1D |
      | Format | Select: CSV |
      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |


  @SID_17
  Scenario: Forensic wizard test Validate ForensicsView
    When UI Click Button "Views.Expand" with value "Category_ConnectionPPS"
    Then UI Validate Element Existence By Label "Views.Generate Now" if Exists "true" with value "Category_ConnectionPPS"


  @SID_18
  Scenario: Forensic wizard test Generate Now
    When UI Click Button "Views.Generate Now" with value "Category_ConnectionPPS"
    And Sleep "120"
    When UI Click Button "Views.report" with value "Category_ConnectionPPS"
    Then UI Validate "Report.Table" Table rows count EQUALS to 1


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

