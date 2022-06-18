@TC124282
Feature: AW RBAC - New AW roles

  @SID_1
  Scenario: login
    Given UI Login with user "radware" and password "radware"
#
#  @SID_2
#  Scenario: run AW attacks
#    Given CLI kill all simulator attacks on current vision
#    Given REST Vision Install License Request "vision-AVA-AppWall"
#    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
#    * REST Vision Install License Request "vision-reporting-module-AMS"
#    Given REST Delete ES index "appwall-v2-attack*"
#    * REST Delete ES index "forensics-*"
#    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
#      | "/home/radware/AW_Attacks/sendAW_Attacks.sh "                       |
#      | #visionIP                                                           |
#      | " 10.206.187.11  1 "/home/radware/AW_Attacks/Integrated_AW_Attack/""   |
#
  @SID_3
  Scenario: Navigate User Management
    Given UI Go To Vision
    Given UI Navigate to page "System->User Management->Local Users"
#
  @SID_4
  Scenario Outline: Create users and verify
    When UI Create New User With User Name "<User Name>", Role "<Role>", Scope "<Scope>", Password "<Password>"
    Then Sleep "10"
    Then  UI User With User Name "<User Name>" ,Role "<Role>" ,Scope "<Scope>" Exists
    Then Sleep "10"
    Examples:
      | User Name             | Role                             | Scope | Password         |
      | AW_Viewer             | Integrated AppWall Viewer        | [ALL] | Radware1234!@#$5 |
      | aw-admin              | Integrated AppWall Administrator | [ALL] | Radware1234!@#$5 |
#
#  @SID_5
#  Scenario: Edit User Management Settings
#    Then UI Navigate to page "System->User Management->Authentication Mode"
#    Then UI Select "Local" from Vision dropdown "Authentication Mode"
#    Then UI Click Button "Submit"
#    Then UI Logout
#
#  @SID_6
#  Scenario: AppWall_Viewer RBAC Validation
#    When UI Login with user "AW_Viewer" and password "Radware1234!@#$5"
#    And Sleep "10"
#    Then UI Validate user rbac
#      | operations                                  | accesses |
#      | DPM                                         | no       |
#      | ANALYTICS ADC                               | yes      |
#      | ANALYTICS AMS                               | yes      |
#      | DefensePro Behavioral Protections Dashboard | no       |
#      | HTTPS Flood Dashboard                       | no       |
#      | DefensePro Analytics Dashboard              | no       |
#      | DefensePro Monitoring Dashboard             | no       |
#      | DefenseFlow Analytics Dashboard             | no       |
#      | AppWall Dashboard                           | yes      |
#      | AMS Reports                                 | yes      |
#      | AMS Forensics                               | yes      |
#      | AMS Alerts                                  | yes      |
#      | vDirect                                     | no       |
#      | GEL Dashboard                               | no       |
#      | EAAF Dashboard                              | no       |
#      | VISION SETTINGS                             | yes      |
#
#
#  @SID_7
#  Scenario: Create One Report Validation
#    And UI Navigate to "AMS Reports" page via homePage
#    Given UI "Create" Report With Name "OverAllAppWallReport"
#      | Template              | reportType:AppWall , Widgets:[Top Sources,Attacks by Action] , Applications:[All] , showTable:false|
#
#    Then UI "Validate" Report With Name "OverAllAppWallReport"
#      | Template              | reportType:AppWall , Widgets:[Top Sources,Attacks by Action] , Applications:[All] , showTable:false|
#
#    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "OverAllAppWallReport"
#
#  @SID_8
#  Scenario: Edit Report Validation
#    Given UI "Edit" Report With Name "OverAllAppWallReport"
#      | Template-3 | reportType:AppWall , Widgets:[Attack Severity] , Applications:[All] , showTable:false |
#      | Time Definitions.Date | Quick:15m          |
#
#    Then UI "Validate" Report With Name "OverAllAppWallReport"
#      | Template-3 | reportType:AppWall , Widgets:[Attack Severity] , Applications:[All] , showTable:false |
#      | Time Definitions.Date | Quick:15m          |
#
#  @SID_9
#  Scenario: Validate delivery card and generate report
#    Then UI "Generate" Report With Name "OverAllAppWallReport"
#      | timeOut | 120 |
#
#  @SID_10
#  Scenario: Delete Report Validation
#    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "OverAllAppWallReport"
#    Then UI Delete Report With Name "OverAllAppWallReport"
#    Then UI Validate Element Existence By Label "My Report" if Exists "false" with value "OverAllAppWallReport"

#  @SID_11
#  Scenario: create new Forensics_AW and validate
#    Then UI Navigate to "AMS Forensics" page via homepage
#    When UI "Create" Forensics With Name "Forensics_AW"
#      | Product               | AppWall                                                                                                                    |
#      | Applications          | All                                                                                                                        |
#      | Output                | Destination IP Address,Transaction ID,Source IP,Source Port,Web Application Name,Action,Severity,Threat Category,Device IP |
#      | Format                | Select: CSV                                                                                                                |
#      | Time Definitions.Date | Quick:Today                                                                                                                |
#      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware           |
#
#  @SID_12
#  Scenario: Validate delivery card and generate Forensics
#    Then UI Click Button "My Forensics" with value "Forensics_AW"
#    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensics_AW"
#    Then Sleep "35"
#
#  @SID_13
#  Scenario: Validate Forensics.Table
#    And UI Click Button "Views.Forensic" with value "Forensics_AW,0"
#    Then UI Validate "Forensics.Table" Table rows count EQUALS to 0
#    Then UI Delete Forensics With Name "Forensics_AW"
#    Then Sleep "10"
#    Then UI Validate Element Existence By Label "My Forensics" if Exists "false" with value "Forensics_AW"


  @SID_14
  Scenario: Create Alert Delivery
    And UI Navigate to "AMS Alerts" page via homePage
    When UI "Create" Alerts With Name "Alert Delivery"
      | Product    | Appwall  |
      | Basic Info | Description:Alert Delivery Description,Impact: Our network is down,Remedy: Please protect real quick!,Severity:Critical     |
      | Criteria   | Event Criteria:Action,Operator:Not Equals,Value:[Blocked];      |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                                                                                           |
      | Share      | Email:[automation.vision1@alert.local, automation.vision2@alert.local],Subject:Alert Delivery Subj,Body:Alert Delivery Body |
    And Sleep "120"


  @SID_15
  Scenario: Run AW simulator VRM_Alert_Severity
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/AW_Attacks/sendAW_Attacks.sh "                     |
      | #visionIP                                                         |
      | " 10.206.187.11 1 "/home/radware/AW_Attacks/Integrated_AW_Attack/""        |
    And Sleep "95"


  @SID_16
  Scenario: validate results for edit Alert fields
    And UI Navigate to "AMS Reports" page via homePage
    And UI Navigate to "AMS Alerts" page via homePage
    Then Sleep "10"
    Then UI "Uncheck" all the Toggle Alerts
    Then UI "Check" Toggle Alerts with name "Alert Delivery"
    Then UI Validate "Report.Table" Table rows count EQUALS to 1
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy index 0
      | columnName | value   |
      | Severity   | CRITICAL |

  @SID_17
  Scenario: validate Delete Alert
    And UI Navigate to "AMS Alerts" page via homePage
    When UI Delete Alerts With Name "Alert Delivery"
    Then Sleep "10"
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "false" with value "Alert Delivery"
    * UI Logout

  @SID_18
  Scenario: AppWall_Administrator
    When UI Login with user "aw-admin" and password "Radware1234!@#$5"
    And Sleep "10"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | DPM                                         | no       |
      | ANALYTICS ADC                               | yes      |
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
      | VISION SETTINGS                             | yes      |




  @SID_19
  Scenario: Create One Report Validation
    Then UI Navigate to "AMS Reports" page via homePage
    Given UI "Create" Report With Name "OverAllAppWallReport"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Attacks by Action] , Applications:[All] , showTable:false|
      | Logo                  | reportLogoPNG.png                                                                |



    Then UI "Validate" Report With Name "OverAllAppWallReport"
      | Template              | reportType:AppWall , Widgets:[Top Sources,Attacks by Action] , Applications:[All] , showTable:false|
      | Logo                  | reportLogoPNG.png                                                                |


    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "OverAllAppWallReport"

  @SID_20
  Scenario: Edit Report Validation
    Given UI "Edit" Report With Name "OverAllAppWallReport"
      | Template-3 | reportType:AppWall , Widgets:[Attack Severity] , Applications:[All] , showTable:false |
      | Time Definitions.Date | Quick:15m          |

    Then UI "Validate" Report With Name "OverAllAppWallReport"
      | Template-3 | reportType:AppWall , Widgets:[Attack Severity] , Applications:[All] , showTable:false |
      | Time Definitions.Date | Quick:15m          |

  @SID_21
  Scenario: Validate delivery card and generate report
    Then UI "Generate" Report With Name "OverAllAppWallReport"
      | timeOut | 120 |

  @SID_22
  Scenario: Delete Report Validation
    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "OverAllAppWallReport"
    Then UI Delete Report With Name "OverAllAppWallReport"
    Then UI Validate Element Existence By Label "My Report" if Exists "false" with value "OverAllAppWallReport"


  @SID_23
  Scenario: create new Forensics_AW and validate
    Then UI Navigate to "AMS Forensics" page via homepage
    When UI "Create" Forensics With Name "Forensics_AW"
      | Product               | AppWall                                                                                                                    |
      | Applications          | All                                                                                                                        |
      | Output                | Destination IP Address,Transaction ID,Source IP,Source Port,Web Application Name,Action,Severity,Threat Category,Device IP |
      | Format                | Select: CSV                                                                                                                |
      | Time Definitions.Date | Quick:Today                                                                                                                |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware           |

  @SID_24
  Scenario: Validate delivery card and generate Forensics
    Then UI Click Button "My Forensics" with value "Forensics_AW"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensics_AW"
    Then Sleep "35"

  @SID_25
  Scenario: Validate Forensics.Table
    And UI Click Button "Views.Forensic" with value "Forensics_AW,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 1
    Then UI Delete Forensics With Name "Forensics_AW"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "false" with value "Forensics_AW"

  @SID_26
  Scenario: Create Alert Delivery
    And UI Navigate to "AMS Alerts" page via homePage
    When UI "Create" Alerts With Name "Alert Delivery"
      | Product | Appwall |
      | Basic Info | Description:Alert Delivery Description,Impact: Our network is down,Remedy: Please protect real quick!,Severity:Critical     |
      | Criteria   | Event Criteria:Action,Operator:Not Equals,Value:[Blocked];     |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                                                                                           |
      | Share      | Email:[automation.vision1@alert.local, automation.vision2@alert.local],Subject:Alert Delivery Subj,Body:Alert Delivery Body |
    And Sleep "120"

  @SID_27
  Scenario: Run DP simulator VRM_Alert_Severity
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/AW_Attacks/sendAW_Attacks.sh "                     |
      | #visionIP                                                         |
      | " 172.17.154.19 1 "/home/radware/AW_Attacks/Integrated_AW_Attack/""        |
    And Sleep "95"



  @SID_28
  Scenario: validate Delete Alert
    And UI Navigate to "AMS Alerts" page via homePage
    When UI Delete Alerts With Name "Alert Delivery"
    Then Sleep "10"
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "false" with value "Alert Delivery"
    * UI Logout


  @SID_29
  Scenario Outline: Delete All Users
    Given UI Login with user "radware" and password "radware"
    Given UI Go To Vision
    Given UI Navigate to page "System->User Management->Local Users"
    When UI Delete User With User Name "<User Name>"
    Examples:
      | User Name   |
      | AW_Viewer   |
      | aw-admin    |

  @SID_30
  Scenario: Login And Go to Vision
    Given UI Go To Vision
    Then UI Navigate to page "System->User Management->Authentication Mode"
    Then UI Select "TACACS+" from Vision dropdown "Authentication Mode"
    Then UI Click Button "Submit"
    Then UI logout and close browser



