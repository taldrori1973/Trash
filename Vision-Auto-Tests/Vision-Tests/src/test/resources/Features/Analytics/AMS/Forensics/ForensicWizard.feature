@VRM_Report2 @TC106006
Feature: Forensic Wizard


  @SID_1
  Scenario: Clean system data before Top Attacks test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator PCAPs for Top Attacks test
    Given CLI simulate 1 attacks of type "rest_anomalies" on "DefensePro" 10

  @SID_3 @Sanity
  Scenario: Login and navigate to forensic
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Navigate to "AMS Forensics" page via homePage

  @SID_4 @Sanity
  Scenario: create forensic definition Wizard_test
    Given UI "Create" Forensics With Name "Wizard_test"
      | Output  | Action,Attack ID,Start Time,Threat Category,Radware ID,Device IP Address,Attack Name,Duration,Packets,Mbits,Policy Name,Risk |

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
    Then UI Validate Element Existence By Label "Views" if Exists "false" with value "Wizard_test"

   @SID_9
    Scenario: validate creation forensics with long name and description
     When UI "Create" Forensics With Name "Loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooongname"
      |Basic Info|Description:looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooongDescreption|

  @SID_10
  Scenario: VRM forensic validate max 10 generations in view
    Then CLI Connect Radware
    Then UI Validate max generate Forensics is 10

  @SID_11
  Scenario: Logout
    When UI logout and close browser
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal\|error | NOT_EXPECTED |

