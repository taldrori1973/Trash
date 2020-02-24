@DFForensics @TC113513
Feature: Defense Flow Forensic Wizard

  @SID_1 @Sanity
  Scenario: Clean system data before Forensics Appwall Test
    * CLI kill all simulator attacks on current vision
#    * REST Delete ES index "dfforensics*"
#    * REST Delete ES index "df-attack-raw*"

    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    * CLI Clear vision logs

  @SID_2 @Sanity
  Scenario: Login and navigate to forensics
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Vision Install License Request "vision-reporting-module-AMS"
    And UI Navigate to "AMS Forensics" page via homePage

  @SID_3 @Sanity
  Scenario: Run AW attacks
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_101.sh "                     |
      | #visionIP |
      | " Terminated" |


  @SID_4 @Sanity
  Scenario: create forensic definition Wizard_test
    Given UI "Create" Forensics With Name "Wizard_test"
      | Product | DefenseFlow |
      | Output  | Start Time, End Time, Attack Name, Action, Attack ID, Policy Name, Source IP Address, Source Port, Max pps, Max bps |
      | Time Definitions.Date | Quick:1D |
      | Format | Select: CSV |
      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                               |
    And Sleep "120"

  @SID_5 @Sanity
  Scenario: Forensic wizard test Validate ForensicsView
    When UI Click Button "Views.Expand" with value "Wizard_test"
    Then UI Validate Element Existence By Label "Views.Generate Now" if Exists "true" with value "Wizard_test"


  @SID_6 @Sanity
  Scenario: Forensic wizard test Generate Now
    When UI Click Button "Views.Generate Now" with value "Wizard_test"
    When UI Click Button "Views.report" with value "Wizard_test"

  @SID_7
  Scenario: VRM - Forensic wizard test Validate Table
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName | value |
      | Action     | Drop  |
    Then UI click Table row by keyValue or Index with elementLabel "Report.Table" findBy index 0
    Then UI Text of "Report.Attack Details.Detail" with extension "Action" equal to "Drop"
    Then UI Click Button "Report.Attack Details.Close"

  @SID_8
  Scenario: VRM - Validate Forensic "Wizard" Delete Wizard
    When UI Delete "Wizard_test" and Cancel
    Then UI Validate Element Existence By Label "Views" if Exists "true" with value "Wizard_test"
    When UI Delete "Wizard_test" and Approve
    And Sleep "1"
    Then UI Validate Element Existence By Label "Views" if Exists "false" with value "Wizard_test"

  @SID_9
  Scenario: Logout
    When UI logout and close browser
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal\|error | NOT_EXPECTED |

