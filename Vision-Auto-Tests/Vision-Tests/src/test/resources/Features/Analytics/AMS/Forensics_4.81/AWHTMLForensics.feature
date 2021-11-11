@TC120198
Feature: AW HTML Forensics

  @SID_1 @Sanity
  Scenario: Clean system data
    Given CLI kill all simulator attacks on current vision
    Given REST Vision Install License Request "vision-AVA-AppWall"
    Given REST Delete ES index "appwall-v2-attack*"
    * REST Delete ES index "forensics-*"
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"

  @SID_2 @Sanity
  Scenario: logina
    Given UI Login with user "sys_admin" and password "radware"
    * REST Delete ES index "aw-web-application"
    * REST Delete Device By IP "172.17.164.30"
    * Browser Refresh Page
    And Sleep "10"

  @SID_3 @Sanity
  Scenario: configure the AW in vision
    Then REST Add device with SetId "AppWall_Set_1" into site "AW_site"
    And Sleep "10"
    * CLI Clear vision logs

  @SID_4
  Scenario:run AW attacks
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/AW_Attacks/sendAW_Attacks.sh "                     |
      | #visionIP                                                         |
      | " 172.17.164.30 1 "/home/radware/AW_Attacks/AppwallAttackTypes/"" |


  @SID_5
  Scenario: VRM - Login to VRM "Wizard" Test and enable emailing
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "VISION SETTINGS" page via homePage
    And UI Go To Vision
    And UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"
    And UI Do Operation "select" item "Email Reporting Configuration"
    And UI Set Checkbox "Enable" To "true"
    And UI Set Text Field "SMTP User Name" To "qa_test@radware.com"
    And UI Set Text Field "From Header" To "Automation system"
    And UI Set Checkbox "Enable" To "false"
    And UI Click Button "Submit"
    And UI Go To Vision
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
    And UI Set Checkbox "Enable" To "true"
    And UI Set Text Field "SMTP Server Address" To "172.17.164.10"
    And UI Set Text Field "SMTP Port" To "25"
    And UI Click Button "Submit"
    And UI Navigate to "AMS Forensics" page via homepage

  @SID_6
  Scenario: create new Forensics_AW and validate
    When UI "Create" Forensics With Name "Forensics_AW"
      | Product               | AppWall                                                                                                                    |
      | Application           | All                                                                                                                        |
      | Output                | Destination IP Address,Transaction ID,Source IP,Source Port,Web Application Name,Action,Severity,Threat Category,Device IP |
      | Format                | Select: HTML                                                                                                               |
      | Time Definitions.Date | Quick:Today                                                                                                                |


  @SID_7
  Scenario: Validate delivery card and generate Forensics
    Then UI Click Button "My Forensics" with value "Forensics_AW"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensics_AW"
    Then Sleep "35"

  @SID_8
  Scenario: Validate Forensics.Table
    And UI Click Button "Views.Forensic" with value "Forensics_AW,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 30


  @SID_9
  Scenario: validate data in first row
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Web Application Name" findBy cellValue "tun_http"
      | columnName     | value         |
      | Device IP      | 172.17.164.30 |
      | Source IP      | 5.62.61.109   |
      | Destination IP | 1.2.3.1       |
      | Action         | Blocked       |


#  @SID_10
#  Scenario: validate data in second row
#    Then UI Click Button "New Forensics Tab"
#    Then UI Click Button "My Forensics Tab"
#    Then Sleep "5"
#    Then UI Click Button "My Forensics" with value "Forensics_AW"
#    And UI Click Button "Views.Forensic" with value "Forensics_AW,0"
#    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Transaction ID" findBy cellValue "325510361912"
#      | columnName           | value                |
#      | Device IP            | 172.17.164.30        |
#      | Source IP            | 5.62.61.109          |
#      | Destination IP       | 1.2.3.1              |
#      | Source Port          | 60498                |
#      | Web Application Name | tun_http             |
#      | Action               | Blocked              |
#      | Severity             | High                 |
#      | Violation Category   | Cross Site Scripting |


  @SID_11
  Scenario: Delete Forensics
    Then UI Delete Forensics With Name "Forensics_AW"

  @SID_12
  Scenario: create new Forensics_MAIL and validate
    When UI "Create" Forensics With Name "Forensics_MAIL"
      | Product               | AppWall                                                  |
      | Application           | All                                                      |
      | Format                | Select: HTML                                             |
      | Share                 | Email:[ayoub],Subject:Validate Email,Body:Email Body     |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Reported |
      | Time Definitions.Date | Quick:Today                                              |

  @SID_13
  Scenario: Validate delivery card and generate Forensics
    Given Setup email server
    Given Clear email history for user "setup"
    Then UI Click Button "My Forensics" with value "Forensics_MAIL"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensics_MAIL"
    Then Sleep "35"

  @SID_14
  Scenario: Validate Forensics.Table
    And UI Click Button "Views.Forensic" with value "Forensics_MAIL,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 29


  @SID_15
  Scenario: Validate Report Forensics received content
    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: ayoub@.*.local"" EQUALS "1"


  @SID_16
  Scenario: create new Forensics_MAIL and validate
    Then UI Click Button "Deletion Forensics Instance" with value "Forensics_MAIL_0"
    When UI "Edit" Forensics With Name "Forensics_MAIL"
      | Schedule | Run Every:Daily,On Time:+2m |
      | output   | Add All                     |
    Then Sleep "180"
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "My Forensics Tab"
    Then Sleep "5"
    Then UI Click Button "My Forensics" with value "Forensics_MAIL"
    And UI Click Button "Views.Forensic" with value "Forensics_MAIL,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 30

  @SID_17
  Scenario: Delete Forensics
    Then UI Delete Forensics With Name "Forensics_MAIL"

  @SID_18
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/Forensics_MAIL*.zip /home/radware/ftp/Forensics_AW*.csv" on "GENERIC_LINUX_SERVER"

  @SID_19
  Scenario: Logout
    Then UI logout and close browser