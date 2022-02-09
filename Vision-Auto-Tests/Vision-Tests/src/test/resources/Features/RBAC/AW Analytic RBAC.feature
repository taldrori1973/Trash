@TC125233
Feature: AW Analytics User RBAC

  @SID_1
  Scenario: Clear Database and Login And Go to Vision
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." Retry 240 seconds
    * REST Delete ES index "dp-*"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_.*" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"
    Given UI Login with user "radware" and password "radware"
    Given UI Go To Vision
    Given UI Navigate to page "System->User Management->Local Users"

  @SID_2
  Scenario Outline: Create users and verify
    When UI Create New User With User Name "<User Name>" ,Role "<Role>" ,Scope "<Scope>" ,Password "<Password>"
    Then  UI User With User Name "<User Name>" ,Role "<Role>" ,Scope "<Scope>" Exists
    Examples:
      | User Name              | Role                   | Scope | Password        |
      | AppWall_Analytics_User | AppWall Analytics User | [ALL] | Radware1234!@#$ |

  @SID_3
  Scenario: Edit User Management Settings
    Then UI Navigate to page "System->User Management->Authentication Mode"
    Then UI Select "Local" from Vision dropdown "Authentication Mode"
    Then UI Click Button "Submit"
    Then UI Logout

  @SID_4
  Scenario: AW_ANALYTICS_User RBAC Validation
    When UI Login with user "AppWall_Analytics_User" and password "Radware1234!@#$"
    And Sleep "10"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AVR                                         | no       |
      | DPM                                         | no       |
      | ANALYTICS ADC                               | no       |
      | ANALYTICS AMS                               | yes      |
      | DefensePro Behavioral Protections Dashboard | no       |
      | HTTPS Flood Dashboard                       | no       |
      | DefensePro Analytics Dashboard              | no       |
      | DefensePro Monitoring Dashboard             | no       |
      | DefenseFlow Analytics Dashboard             | no       |
      | AppWall Dashboard                           | yes      |
      | AMS Reports                                 | yes      |
      | AMS Forensics                               | yes      |
      | AMS Alerts                                  | yes      |
      | vDirect                                     | no       |
      | GEL Dashboard                               | no       |
      | EAAF Dashboard                              | no       |
      | VISION SETTINGS                             | no       |


  @SID_5
  Scenario: Create a new Report and Validate Exictance
    Then UI Navigate to "AMS Reports" page via homePage
    Given UI "Create" Report With Name "OverAllAppWallReport"
      | Template | reportType:AppWall , Widgets:[Top Sources,Attacks by Action] , Applications:[All] , showTable:false |

    Then UI "Validate" Report With Name "OverAllAppWallReport"
      | Template | reportType:AppWall , Widgets:[Top Sources,Attacks by Action] , Applications:[All] , showTable:false |

    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "OverAllAppWallReport"

  @SID_6
  Scenario: Edit Report Validation
    Given UI "Edit" Report With Name "OverAllAppWallReport"
      | Template-3            | reportType:AppWall , Widgets:[Attack Severity] , Applications:[All] , showTable:false |
      | Time Definitions.Date | Quick:15m                                                                             |

    Then UI "Validate" Report With Name "OverAllAppWallReport"
      | Template-3            | reportType:AppWall , Widgets:[Attack Severity] , Applications:[All] , showTable:false |
      | Time Definitions.Date | Quick:15m                                                                             |

  @SID_7
  Scenario: Validate Enabled/Disabled Report Templates
    Then UI Click Button "Edit Report" with value "OverAllAppWallReport"
    Then UI Validate the attribute of "data-debug-enabled" are "EQUAL" to
      | label    | param                             | value |
      | Template | DefensePro Analytics              | false |
      | Template | DefensePro Behavioral Protections | false |
      | Template | HTTPS Flood                       | false |
      | Template | DefenseFlow Analytics             | false |
      | Template | AppWall                           | true  |
      | Template | ERT Active Attackers Feed         | false |
    Then UI Click Button "Close Edit Tab"


  @SID_8
  Scenario: Generate report and Validate Generated Report in CLI
    Then UI "Generate" Report With Name "OverAllAppWallReport"
      | timeOut | 120 |
    Then UI Click Button "Log Preview" with value "OverAllAppWallReport_0"
    Then CLI Run linux Command "ll /opt/radware/mgt-server/third-party/tomcat/bin/ | grep 'VRM_report_.*.pdf' | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_.*.pdf" on "ROOT_SERVER_CLI"


  @SID_9
  Scenario: Edit report to CSV format and Validate Generated Report
    Then UI "Edit" Report With Name "OverAllAppWallReport"
      | Format | Select: CSV |
    Then UI "Validate" Report With Name "OverAllAppWallReport"
      | Format | Select: CSV |
    Then UI "Generate" Report With Name "OverAllAppWallReport"
      | timeOut | 120 |
    Then CLI Run linux Command "ll /opt/radware/mgt-server/third-party/tomcat/bin/ | grep VRM_report_.*.zip | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_.*.zip" on "ROOT_SERVER_CLI"


  @SID_10
  Scenario: Edit report to HTML format and Validate Generated Report
    Then UI "Edit" Report With Name "OverAllAppWallReport"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "OverAllAppWallReport"
      | Format | Select: HTML |
    Then UI "Generate" Report With Name "OverAllAppWallReport"
      | timeOut | 120 |
    Then CLI Run linux Command "ll /opt/radware/mgt-server/third-party/tomcat/bin/ | grep VRM_report_.*.html | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_.*.html" on "ROOT_SERVER_CLI"

  @SID_11
  Scenario: Delete Report Validation
    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "OverAllAppWallReport"
    Then UI Delete Report With Name "OverAllAppWallReport"
    Then UI Validate Element Existence By Label "My Report" if Exists "false" with value "OverAllAppWallReport"

  @SID_12
  Scenario: create new Forensics_AW and validate
    Then UI Navigate to "AMS Forensics" page via homepage
    When UI "Create" Forensics With Name "Forensics_AW"
      | Product               | AppWall                                                                                                                    |
      | Application           | All                                                                                                                        |
      | Output                | Destination IP Address,Transaction ID,Source IP,Source Port,Web Application Name,Action,Severity,Threat Category,Device IP |
      | Format                | Select: CSV                                                                                                                |
      | Time Definitions.Date | Quick:Today                                                                                                                |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware           |

  @SID_13
  Scenario: Forensic New Category Validate ForensicsView
    Then UI Click Button "My Forensics" with value "Forensics_AW"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensics_AW"
    Then Sleep "20"
    Then UI Validate Element Existence By Label "Generate Snapshot Forensics Manually" if Exists "true" with value "Forensics_AW"
    Then UI Click Button "Views.Forensic" with value "Forensics_AW,0"
    Then UI Validate Element Existence By Label "Forensics View" if Exists "true" with value "Forensics_AW"

  @SID_14
  Scenario: Edit Forensics to HTML format and Validate Generated Forensics
    When UI "Edit" Forensics With Name "Forensics_AW"
      | Format | Select: HTML |
    Then UI Click Button "My Forensics" with value "Forensics_AW"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensics_AW"
    Then Sleep "20"
    Then UI Validate Element Existence By Label "Generate Snapshot Forensics Manually" if Exists "true" with value "Forensics_AW"
    Then UI Click Button "Views.Forensic" with value "Forensics_AW,1"
    Then UI Validate Element Existence By Label "Forensics View" if Exists "true" with value "Forensics_AW"

  @SID_15
  Scenario: Validate Enabled/Disabled Forensics Product Templates
    Then UI Click Button "Edit Forensics" with value "Forensics_AW"
    Then UI Validate the attribute of "data-debug-enabled" are "EQUAL" to
      | label   | param       | value |
      | Product | DefensePro  | false |
      | Product | DefenseFlow | false |
      | Product | AppWall     | true  |
    Then UI Click Button "Close Edit Tab"

  @SID_16
  Scenario: Delete Forensics and Validation
    Then UI Validate Element Existence By Label "My Forensics" if Exists "true" with value "Forensics_AW"
    Then UI Delete Forensics With Name "Forensics_AW"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "false" with value "Forensics_AW"

  @SID_17
  Scenario: Create Alert Delivery
    And UI Navigate to "AMS Alerts" page via homePage
    When UI "Create" Alerts With Name "Alert Delivery"
      | Product    | Appwall                                                                                                                     |
      | Basic Info | Description:Alert Delivery Description,Impact: Our network is down,Remedy: Please protect real quick!,Severity:Critical     |
      | Criteria   | Event Criteria:Action,Operator:Not Equals,Value:[Blocked];                                                                  |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                                                                                           |
      | Share      | Email:[automation.vision1@alert.local, automation.vision2@alert.local],Subject:Alert Delivery Subj,Body:Alert Delivery Body |
    And Sleep "10"

  @SID_18
  Scenario: Validate License Enable/Disable
    Then UI Click Button "Add New"
    Then UI Validate the attribute of "data-debug-enabled" are "EQUAL" to
      | label          | param      | value |
      | Product Button | defensepro | false |
      | Product Button | appwall    | true  |
    Then UI Click Button "Close"

  @SID_19
  Scenario: Delete Alert and Validation
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "true" with value "Alert Delivery"
    When UI Delete Alerts With Name "Alert Delivery"
    Then Sleep "5"
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "false" with value "Alert Delivery"
    Then UI Logout

  @SID_20
  Scenario Outline: Delete All Users
    Given UI Login with user "radware" and password "radware"
    Given UI Go To Vision
    Given UI Navigate to page "System->User Management->Local Users"
    When UI Delete User With User Name "<User Name>"
    Examples:
      | User Name              |
      | AppWall_Analytics_User |

  @SID_21
  Scenario: Change Authentication Mode to TACACS
    Then UI Navigate to page "System->User Management->Authentication Mode"
    Then UI Select "TACACS+" from Vision dropdown "Authentication Mode"
    Then UI Click Button "Submit"
    Then UI logout and close browser
