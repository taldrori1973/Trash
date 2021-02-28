@VRM_Report2 @TC106006
Feature: Forensic Wizard


  @SID_1 @Sanity
  Scenario: Clean system data before Top Attacks test
    And CLI Reset radware password
    Given CLI kill all simulator attacks on current vision
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"
    * REST Delete ES index "forensics-*"

    And REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    And CLI Clear vision logs

  @SID_2 @Sanity
  Scenario: Run DP simulator PCAPs for Top Attacks test
    Given CLI simulate 1 attacks of type "rest_anomalies" on "DefensePro" 10 and wait 30 seconds

  
  @SID_3 @Sanity
  Scenario: Login and navigate to forensic
    Given UI Login with user "sys_admin" and password "radware"
   * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "New Forensics" page via homepage
#    Then UI Click Button "New Forensics Tab"

  
  @SID_4 @Sanity
  Scenario: create forensic definition Wizard_test
    Given UI "Create" Forensics With Name "Wizard_test"
      | Output  | Action,Attack ID,Start Time,Threat Category,Radware ID,Device IP Address,Attack Name,Duration,Packet Type,Max bps,Policy Name,Risk |

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
      | Action     | Drop  |
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy index 0
    Then UI Text of "Forensics.Attack Details.Detail" with extension "Action" equal to "Drop"
    Then UI Click Button "Forensics.Attack Details.Close"

  @SID_8
  Scenario: VRM - Validate Forensic "Wizard" Delete Wizard
    Then UI Click Button "Delete Forensics" with value "Wizard_test"
    Then UI Click Button "Cancel Delete Forensics"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "true" with value "Wizard_test"
    Then UI Delete Forensics With Name "Wizard_test"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "false" with value "Wizard_test"

   @SID_9
    Scenario: validate creation forensics with long name and description
     When UI "Create" Forensics With Name "Loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooongname"
      |Basic Info|Description:looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooongDescreption|

  
  @SID_10
  Scenario: VRM forensic validate max 10 generations in view
    Given UI "Create" Forensics With Name "validateMaxViews"
      | Output  | Action,Attack ID,Start Time,Threat Category,Radware ID,Device IP Address,Attack Name,Duration,Packet Type,Max bps,Policy Name,Risk |

    Then UI Click Button "My Forensics" with value "validateMaxViews"
    Then UI Validate Element Existence By Label "Generate Snapshot Forensics Manually" if Exists "true" with value "validateMaxViews"

    Then CLI Connect Radware
    
    Then UI Validate max generate snapshot in Forensics is 10 when add 11 snapshots

  @SID_11 @Sanity
  Scenario: Logout
    When UI logout and close browser
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal\|error | NOT_EXPECTED |

