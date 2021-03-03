@TC119794

Feature: DefenseFlow HTML Forensics
  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Vision Install License Request "vision-AVA-AppWall"
    * REST Vision Install License Request "vision-reporting-module-AMS"
    * REST Delete ES index "df-attack*"
    * REST Delete ES index "forensics-*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Change DF management IP to IP of Generic Linux
    When CLI Operations - Run Radware Session command "system df management-ip set 172.17.164.10"
    When CLI Operations - Run Radware Session command "system df management-ip get"
    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 172.17.164.10"

  @SID_3
  Scenario: Run DF simulator
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_100.sh " |
      | #visionIP                                       |
      | " Terminated"                                   |
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_PO_200.sh " |
      | #visionIP                                       |
      | " Terminated"                                   |
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER" and wait 30 seconds
      | "/home/radware/curl_DF_attacks-auto_PO_300.sh " |
      | #visionIP                                       |
      | " Terminated"                                   |


  @SID_4
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
    And UI Navigate to "New Forensics" page via homepage

  @SID_5
  Scenario: create new Forensics_DefenseFlow and validate
    When UI "Create" Forensics With Name "Forensics_DefenseFlow"
      | Product               | DefenseFlow                                                                                                                                                                                                                                                                                                   |
      | Protected Objects     | All                                                                                                                                                                                                                                                                                                           |
      | Output                | Start Time,End Time,Threat Category,Attack Name,Policy Name,Source IP Address,Destination IP Address,Destination Port,Direction,Protocol,Device IP Address,Action,Attack ID,Source Port,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag,Packet Type |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                   |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                              |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Http 403 Forbidden                                                                                                                                                                                                                                            |
      | Time Definitions.Date | Quick:Today                                                                                                                                                                                                                                                                                                   |

  @SID_6
  Scenario: Clear FTP server logs and generate the report
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/Forensics_DefenseFlow*.zip /home/radware/ftp/Forensics_DefenseFlow*.csv" on "GENERIC_LINUX_SERVER"

  @SID_7
  Scenario: Validate delivery card and generate Forensics
    Then UI Click Button "My Forensics" with value "Forensics_DefenseFlow"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensics_DefenseFlow"
    Then Sleep "35"

  @SID_8
  Scenario: Validate Forensics.Table
    And UI Click Button "Views.Forensic" with value "Forensics_DefenseFlow,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 278

  @SID_9
  Scenario: Validate Threat Category
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Threat Category" findBy cellValue "Behavioral DoS"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "category"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 278
    And UI Click Button "Clear Refine"

  @SID_10
  Scenario: Validate Attack Name
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "HTTP (recv.pps)"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 150
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "HTTP (recv.bps)"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 1
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "Total (recv.pps)"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 4
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "Total (recv.bps)"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 19
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "UDP Port 0 (recv.pps)"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 33
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "network flood IPv6 UDP"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 18
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "network flood IPv4 UDP"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 12
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "network flood IPv4 TCP-SYN"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 8
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "HTTPS Flood Protection"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 9
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Attack Name" findBy cellValue "DOSS-NTP-monlist-flood"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "name"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 17
    And UI Click Button "Clear Refine"

  @SID_11
  Scenario: Validate Action
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Action" findBy cellValue "Drop"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "actionType"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 278
    And UI Click Button "Clear Refine"

  @SID_12
  Scenario: Validate Protocol
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Protocol" findBy cellValue "IP"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "protocol"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 9
    And UI Click Button "Clear Refine"
    Then UI click Table row by keyValue or Index with elementLabel "Forensics.Table" findBy columnName "Protocol" findBy cellValue "NonIP"
    And UI Click Button "Refine View"
    And UI Click Button "Refine by"
    And UI Click Button "Refine by Value" with value "protocol"
    And UI Click Button "Apply"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 76
    And UI Click Button "Clear Refine"

  @SID_13
  Scenario: Delete Forensics
    Then UI Delete Forensics With Name "Forensics_DefenseFlow"

  @SID_14
  Scenario: create new Forensics_DefenseFlow and validate
    When UI "Create" Forensics With Name "Forensics_DefenseFlow"
      | Product               | DefenseFlow                                                                                                                                                                                                                                                                                                   |
      | Protected Objects     | All                                                                                                                                                                                                                                                                                                           |
      | Output                | Start Time,End Time,Threat Category,Attack Name,Policy Name,Source IP Address,Destination IP Address,Destination Port,Direction,Protocol,Device IP Address,Action,Attack ID,Source Port,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag,Packet Type |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                   |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                              |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Http 403 Forbidden                                                                                                                                                                                                                                            |
      | Time Definitions.Date | Quick:Today                                                                                                                                                                                                                                                                                                   |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                                                                   |

  @SID_15
  Scenario: Clear FTP server logs and generate the report
    Then Sleep "100"
    And UI Navigate to "AMS Reports" page via homePage
    And UI Navigate to "New Forensics" page via homepage
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/Forensics_DefenseFlow*.zip /home/radware/ftp/Forensics_DefenseFlow*.csv" on "GENERIC_LINUX_SERVER"

  @SID_16
  Scenario: Validate Forensics.Table
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "My Forensics" with value "Forensics_DefenseFlow"
    And UI Click Button "Views.Forensic" with value "Forensics_DefenseFlow,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 278

  @SID_17
  Scenario: Delete Forensics
    Then UI Delete Forensics With Name "Forensics_DefenseFlow"

  @SID_18
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_19
  Scenario: create new Forensics_DefenseFlow and validate
    When UI "Create" Forensics With Name "Forensics_DefenseFlow"
      | Product               | DefenseFlow                                                                                                                                                                                                                                                                                                   |
      | Protected Objects     | All                                                                                                                                                                                                                                                                                                           |
      | Output                | Start Time,End Time,Threat Category,Attack Name,Policy Name,Source IP Address,Destination IP Address,Destination Port,Direction,Protocol,Device IP Address,Action,Attack ID,Source Port,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag,Packet Type |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                                   |
      | Share                 | Email:[maha],Subject:Validate Email,Body:Email Body                                                                                                                                                                                                                                                           |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Http 403 Forbidden                                                                                                                                                                                                                                            |
      | Time Definitions.Date | Quick:Today                                                                                                                                                                                                                                                                                                   |

  @SID_20
  Scenario: Validate delivery card and generate Forensics
    Then UI Click Button "My Forensics" with value "Forensics_DefenseFlow"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensics_DefenseFlow"
    Then Sleep "35"

  @SID_21
  Scenario: Validate Forensics.Table
    And UI Click Button "Views.Forensic" with value "Forensics_DefenseFlow,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 278

  @SID_22
  Scenario: Validate Report Forensics received content
    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: maha@.*.local"" EQUALS "1"

  @SID_23
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_24
  Scenario: Delete Forensics
    Then UI Delete Forensics With Name "Forensics_DefenseFlow"

  @SID_25
  Scenario: Logout
    Then UI logout and close browser


