@TC120197
Feature: AW CSV Forensics

  @SID_1 @Sanity
  Scenario: Clean system data
    Given CLI kill all simulator attacks on current vision
    Given REST Vision Install License Request "vision-AVA-AppWall"
    Given REST Delete ES index "appwall-v2-attack*"
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
    Then REST Add "AppWall" Device To topology Tree with Name "Appwall_SA_172.17.164.30" and Management IP "172.17.164.30" into site "AW_site"
      | attribute     | value  |
      | httpPassword  | kavado |
      | httpsPassword | kavado |
      | httpsUsername | admin  |
      | httpUsername  | admin  |
      | visionMgtPort | G1     |
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
    Then UI Navigate to "AMS Forensics" page via homepage

  @SID_6
  Scenario: create new Forensics_AW and validate
    When UI "Create" Forensics With Name "Forensics_AW"
      | Product               | AppWall                                                                                                                    |
      | Application           | All                                                                                                                        |
      | Output                | Destination IP Address,Transaction ID,Source IP,Source Port,Web Application Name,Action,Severity,Threat Category,Device IP |
      | Format                | Select: CSV                                                                                                                |
      | Time Definitions.Date | Quick:Today                                                                                                                |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware           |

  @SID_7
  Scenario: Clear FTP server logs and generate the report
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/Forensics_AW*.zip /home/radware/ftp/Forensics_AW*.csv" on "GENERIC_LINUX_SERVER"

  @SID_8
  Scenario: Validate delivery card and generate Forensics
    Then UI Click Button "My Forensics" with value "Forensics_AW"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensics_AW"
    Then Sleep "35"


  @SID_9
  Scenario: Validate Forensics.Table
    And UI Click Button "Views.Forensic" with value "Forensics_AW,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 30


  @SID_10
  Scenario: Unzip CSV file
    Then CLI Run remote linux Command "unzip -o /home/radware/ftp/Forensics_AW*.zip -d /home/radware/ftp/" on "GENERIC_LINUX_SERVER"
    Then Sleep "3"

  @SID_11
  Scenario: Validate the First line in Forensics_AW_*.csv File
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "31"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv|head -1|tail -1|awk -F "," '{printf $1}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Device IP"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv|head -1|tail -1|awk -F "," '{printf $2}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Source IP"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv|head -1|tail -1|awk -F "," '{printf $3}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Destination IP"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv|head -1|tail -1|awk -F "," '{printf $4}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Source Port"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv|head -1|tail -1|awk -F "," '{printf $5}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Application Name"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv|head -1|tail -1|awk -F "," '{printf $6}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Action"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv|head -1|tail -1|awk -F "," '{printf $7}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Severity"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv|head -1|tail -1|awk -F "," '{printf $8}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Violation Category"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv|head -1|tail -1|awk -F "," '{printf $9}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Transaction ID"


  @SID_12
  Scenario: Validate Threat Category
    Then CLI Run linux Command "sed -n '1d;p' /home/radware/ftp/Forensics_AW_*.csv| awk -F "," '{print $3}' | sort | uniq| wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv |grep -w  1.2.3.1|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "30"

  @SID_13
  Scenario: Validate Applications
    Then CLI Run linux Command "sed -n '1d;p' /home/radware/ftp/Forensics_AW_*.csv| awk -F "," '{print $5}' | sort | uniq| wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv |grep -w  'tun_http'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "28"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv |grep -w  'Default Web Application'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2"

  @SID_14
  Scenario: Validate Severity
    Then CLI Run linux Command "sed -n '1d;p' /home/radware/ftp/Forensics_AW_*.csv| awk -F "," '{print $6}' | sort | uniq| wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "3"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv |grep -w  Blocked|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "28"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv |grep -w  Modified|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv |grep -w  Reported|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"

  @SID_15
  Scenario: Validate Violation Category
    Then CLI Run linux Command "sed -n '1d;p' /home/radware/ftp/Forensics_AW_*.csv| awk -F "," '{print $8}' | sort | uniq| wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "5"
    Then CLI Run linux Command "sed -n '1d;p' /home/radware/ftp/Forensics_AW_*.csv| awk -F "," '{print $8}' | grep Injections|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "12"
    Then CLI Run linux Command "sed -n '1d;p' /home/radware/ftp/Forensics_AW_*.csv| awk -F "," '{print $8}' | grep -w 'Cross Site Scripting'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "6"
    Then CLI Run linux Command "sed -n '1d;p' /home/radware/ftp/Forensics_AW_*.csv| awk -F "," '{print $8}' | grep 'Access Control'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "10"
    Then CLI Run linux Command "sed -n '1d;p' /home/radware/ftp/Forensics_AW_*.csv| awk -F "," '{print $8}' | grep Misconfiguration|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "sed -n '1d;p' /home/radware/ftp/Forensics_AW_*.csv| awk -F "," '{print $8}' | grep 'HTTP RFC Violations'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"

  @SID_16
  Scenario: Delete Forensics
    Then UI Delete Forensics With Name "Forensics_AW"


  @SID_17
  Scenario: create new Forensics_AW and validate
    When UI "Create" Forensics With Name "Forensics_AW_Schedule"
      | Product     | AppWall                                                                                                          |
      | Application | All                                                                                                              |
      | output      | Add All                                                                                                          |
      | Format      | Select: CSV                                                                                                      |
      | Share       | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Criteria    | Event Criteria:Action,Operator:Not Equals,Value:Reported                                                         |
      | Schedule    | Run Every:Daily,On Time:+2m                                                                                      |


  @SID_18
  Scenario: Clear FTP server logs and generate the report
    Then Sleep "130"
    And UI Navigate to "AMS Reports" page via homePage
    Then UI Navigate to "AMS Forensics" page via homepage
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/Forensics_AW*.zip /home/radware/ftp/Forensics_AW*.csv" on "GENERIC_LINUX_SERVER"

  @SID_19
  Scenario: Validate Forensics.Table
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "My Forensics" with value "Forensics_AW_Schedule"
    And UI Click Button "Views.Forensic" with value "Forensics_AW_Schedule,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 29

  @SID_20
  Scenario: Unzip CSV file
    Then CLI Run remote linux Command "unzip -o /home/radware/ftp/Forensics_AW_Schedule*.zip -d /home/radware/ftp/" on "GENERIC_LINUX_SERVER"
    Then Sleep "3"

  @SID_21
  Scenario: Validate the First line in Forensics_AW_*.csv File
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_Schedule_*.csv |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "29"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "30"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv|head -1|tail -1|awk -F "," '{printf $1}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Device IP"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv|head -1|tail -1|awk -F "," '{printf $2}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Source IP"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv|head -1|tail -1|awk -F "," '{printf $3}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Destination IP"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv|head -1|tail -1|awk -F "," '{printf $4}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Source Port"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv|head -1|tail -1|awk -F "," '{printf $5}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Application Name"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv|head -1|tail -1|awk -F "," '{printf $6}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Action"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv|head -1|tail -1|awk -F "," '{printf $7}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Severity"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv|head -1|tail -1|awk -F "," '{printf $8}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Violation Category"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_AW_*.csv|head -1|tail -1|awk -F "," '{printf $9}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Transaction ID"


  @SID_22
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_23
  Scenario: create new Forensics_AW and validate
    When UI "Create" Forensics With Name "Forensics_AW_Email"
      | Product               | Appwall                                              |
      | Format                | Select: CSV                                          |
      | Share                 | Email:[ayoub],Subject:Validate Email,Body:Email Body |
      | Time Definitions.Date | Quick:Today                                          |

  @SID_24
  Scenario: Validate delivery card and generate Forensics
    Then UI Click Button "My Forensics" with value "Forensics_AW_Email"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensics_AW_Email"
    Then Sleep "35"

  @SID_25
  Scenario: Validate Forensics.Table
    And UI Click Button "Views.Forensic" with value "Forensics_AW_Email,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 30

  @SID_26
  Scenario: Validate Report Forensics received content
    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: ayoub@.*.local"" EQUALS "1"

  @SID_27
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_28
  Scenario: Logout
    Then UI logout and close browser