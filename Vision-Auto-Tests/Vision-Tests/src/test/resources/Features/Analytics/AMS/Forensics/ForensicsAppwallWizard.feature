@AWForensics @TC113209
Feature: Forensic Wizard


  @SID_1
  Scenario: Clean system data before Top Attacks test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "appwall-v2-attack-raw*"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    * CLI Clear vision logs

  @SID_2
  Scenario: Run AW attacks
    #Then CLI Run remote linux Command "/root/appwallAttacks/2serversAttack_AW.txt" on "GENERIC_LINUX_SERVER"
    ##TODO confirm 172.17.164.30 is the correct ip to be using here
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/AW_Attacks/sendAW_Attacks.sh "                     |
      | #visionIP                                                         |
      | " 172.17.164.30 5 "/home/radware/AW_Attacks/AppwallAttackTypes/"" |

  @SID_3 @Sanity
  Scenario: Login and navigate to forensic
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "AMS Forensics" page via homePage

  @SID_4 @Sanity
  Scenario: create forensic definition Wizard_test
    Given UI "Create" Forensics With Name "Wizard_test"
      | Product | Appwall |
      | Criteria | Event Criteria:Action,Operator:Not Equals,Value:[Drop]; |
      | Output  | Date and Time, Device IP, Source IP, Destination IP Address, Source Port, Cluster Manager IP, Web Application Name, Action, Attack Name, Device Host Name, Directory, Module, Severity, Violation Category, Transaction ID, Tunnel, User Name |
      | Time Definitions.Date | Quick:1D |
      | Format | Select: CSV |
      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                               |

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
      | Action     | Blocked  |

  @SID_8
  Scenario: VRM - Validate Forensic "Wizard" Delete Wizard
    When UI Delete "Wizard_test" and Cancel
    Then UI Validate Element Existence By Label "Views" if Exists "true" with value "Wizard_test"
    When UI Delete "Wizard_test" and Approve
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

