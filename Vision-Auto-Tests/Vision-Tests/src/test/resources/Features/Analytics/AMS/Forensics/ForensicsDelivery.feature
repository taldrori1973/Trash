@VRM_Alerts @TC106000

Feature: Forensics Delivery

  @SID_1
  Scenario: Clean system data
    When CLI kill all simulator attacks on current vision
    When CLI Clear vision logs
    * REST Delete ES index "dp-*"
    * REST Delete ES index "forensics-*"
    Given CLI Reset radware password
    When REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"


  @SID_2
  Scenario: VRM - Login to VRM "Wizard" Test and enable emailing
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "VISION SETTINGS" page via homePage
    And UI Go To Vision
    And UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"
    And UI Do Operation "select" item "Email Reporting Configuration"
    And UI Set Checkbox "Enable" To "true"
    And UI Set Text Field "SMTP User Name" To "qa_test@radware.com"
    And UI Set Text Field "From Header" To "APSolute Vision"
    And UI Set Checkbox "Enable" To "false"
    And UI Click Button "Submit"
    And UI Go To Vision
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
    And UI Set Checkbox "Enable" To "true"
    And UI Set Text Field "SMTP Server Address" To "172.17.164.10"
    And UI Set Text Field "SMTP Port" To "25"
    And UI Click Button "Submit"
    Then UI Navigate to "AMS Forensics" page via homepage

  @SID_3
  Scenario: validate Forensics Report empty delivery
    Given UI "Create" Forensics With Name "Email Validate"
      | Share  | Email:[automation.vision1@forensic.local],Subject:Forensic Email Validate                                                                                                                                                                  |
      | Output | Action,Attack ID,Start Time,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Threat Category,Radware ID,Device IP Address,Attack Name,End Time,Duration,Packet Type,Physical Port,Policy Name,Risk |
      | Format | Select: HTML                                                                                                                                                                                                                               |



    When CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/forensicuser" on "GENERIC_LINUX_SERVER"
    Then UI Click Button "My Forensics" with value "Email Validate"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Email Validate"
    Then Sleep "35"

    Then CLI Run linux Command "grep "From qa_test@radware.com" /var/spool/mail/forensicuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "X-Original-To: automation.vision1@forensic.local" /var/spool/mail/forensicuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "Subject: Forensic Email Validate" /var/spool/mail/forensicuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "grep -o -e "Forensics report" -e "No Available Data" /var/spool/mail/forensicuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2"

    Then UI Logout

  @SID_4
  Scenario: Run DP simulator and clear email logs
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/forensicuser" on "GENERIC_LINUX_SERVER"
    And CLI simulate 4 attacks of type "rest_intrusion" on "DefensePro" 10 and wait 35 seconds

  @SID_5
  Scenario: login and generate the forensic report "Email Validate"
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage

    Then UI Click Button "My Forensics" with value "Email Validate"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Email Validate"
    Then Sleep "35"
    #For debug use to have the ability to view what was generated
    Then UI Click Button "Views.Forensic" with value "Email Validate,0"
    Then Sleep "5"

  @SID_6
  Scenario: validate Forensics Report email no ftp format HTML
    Then CLI Run remote linux Command "cat /var/spool/mail/forensicuser > /tmp/forensicmail" on "GENERIC_LINUX_SERVER"

    Then CLI Run linux Command "ll /var/spool/mail/" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "forensicuser" in any line Wait For Prompt 30 seconds
    Then CLI Run linux Command "ll /tmp/" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "forensicmail" in any line Wait For Prompt 30 seconds


    Then CLI Run remote linux Command "awk -F "</th><th>" '{printf $2}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "Start Time"
    Then CLI Run remote linux Command "awk -F "</td><td>" '{printf $2}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "(\d{2})/(\d{2})/(\d{4}) (\d{2}):(\d{2}):(\d{2})"

    Then CLI Run remote linux Command "awk -F "</th><th>" '{printf $4}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "Device IP"
    Then CLI Run remote linux Command "awk -F "</td><td>" '{printf $4}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "172.16.22.50"

    Then CLI Run remote linux Command "awk -F "</th><th>" '{printf $5}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "Threat Category"
    Then CLI Run remote linux Command "awk -F "</td><td>" '{printf $5}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "Intrusions"

    Then CLI Run remote linux Command "awk -F "</th><th>" '{printf $6}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "Attack Name"
    Then CLI Run remote linux Command "awk -F "</td><td>" '{printf $6}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "\btim\b"

    Then CLI Run remote linux Command "awk -F "</th><th>" '{printf $7}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "Policy Name"
    Then CLI Run remote linux Command "awk -F "</td><td>" '{printf $7}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "\bBDOS\b"

    Then CLI Run remote linux Command "awk -F "</th><th>" '{printf $8}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "Action"
    Then CLI Run remote linux Command "awk -F "</td><td>" '{printf $8}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "\bDrop\b"

    Then CLI Run remote linux Command "awk -F "</th><th>" '{printf $9}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "Attack ID"
    Then CLI Run remote linux Command "awk -F "</td><td>" '{printf $9}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "7716-1402580209"

    Then CLI Run remote linux Command "awk -F "</th><th>" '{printf $10}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "Source IP"
    Then CLI Run remote linux Command "awk -F "</td><td>" '{printf $10}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "192.85.1.77"

    Then CLI Run remote linux Command "awk -F "</th><th>" '{printf $11}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "Source Port"
    Then CLI Run remote linux Command "awk -F "</td><td>" '{printf $11}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "\b1055\b"

    Then CLI Run remote linux Command "awk -F "</th><th>" '{printf $12}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "Destination IP"
    Then CLI Run remote linux Command "awk -F "</td><td>" '{printf $12}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "1.1.1.9"

    Then CLI Run remote linux Command "awk -F "</th><th>" '{printf $13}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "Destination Port"
    Then CLI Run remote linux Command "awk -F "</td><td>" '{printf $13}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "\b80\b"

    Then CLI Run remote linux Command "awk -F "</th><th>" '{printf $14}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "Direction"
    Then CLI Run remote linux Command "awk -F "</td><td>" '{printf $14}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "\bIn\b"

    Then CLI Run remote linux Command "awk -F "</th><th>" '{printf $15}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "Protocol"
    Then CLI Run remote linux Command "awk -F "</td><td>" '{printf $15}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "\bTCP\b"

    Then CLI Run remote linux Command "awk -F "</th><th>" '{printf $16}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "Radware ID"
    Then CLI Run remote linux Command "awk -F "</td><td>" '{printf $16}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "\b300000\b"

    Then CLI Run remote linux Command "awk -F "</th><th>" '{printf $17}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "\bDuration\b"
    Then CLI Run remote linux Command "awk -F "</td><td>" '{printf $17}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "(\d{2})"

    Then CLI Run remote linux Command "awk -F "</th><th>" '{printf $18}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "Packet Type"
    Then CLI Run remote linux Command "awk -F "</td><td>" '{printf $18}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "\bRegular\b"

    Then CLI Run remote linux Command "awk -F "</th><th>" '{printf $19}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "Physical Port"
    Then CLI Run remote linux Command "awk -F "</td><td>" '{printf $19}' /var/spool/mail/forensicuser;echo" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "\b1\b"

    Then CLI Run remote linux Command "grep -oP '(?<=<th>)[^</th>]*' /var/spool/mail/forensicuser | tail -1" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "\bRisk\b"
    Then CLI Run remote linux Command "grep -oP '(?<=<td>)[^</td>]*' /var/spool/mail/forensicuser | tail -1" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "\bLow\b"

  @SID_7
  Scenario: Logout
    Then UI Logout

  @SID_8
  Scenario: Verify VRM Forensics Email Delivery Sender
    Then CLI Run linux Command "grep "From: APSolute Vision <qa_test@radware.com>" /var/spool/mail/forensicuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run remote linux Command "ll /var/spool/mail/forensicuser" on "GENERIC_LINUX_SERVER"
    Then CLI Run linux Command "grep "From: APSolute Vision <qa_test@radware.com>" /var/spool/mail/forensicuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"

  @SID_9
  Scenario: Verify VRM Forensics Email Delivery Recipients
    Then CLI Run linux Command "grep "X-Original-To: automation.vision1@forensic.local" /var/spool/mail/forensicuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"

  @SID_10
  Scenario: Verify Forensics Email Delivery Subject
    Then CLI Run linux Command "cat /var/spool/mail/forensicuser|tr -d "="|tr -d "\n"|grep -o "Subject: Forensic Email Validate" |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run remote linux Command "cat /var/spool/mail/forensicuser > /tmp/spool.log" on "GENERIC_LINUX_SERVER"

  @SID_11
  Scenario: Modify Forensics Report email no FTP content CSV attachment
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage
    When UI "Edit" Forensics With Name "Email Validate"
      | Format | Select: CSV |

  @SID_12
  Scenario: Logout
    Then UI Logout

  @SID_13
  Scenario: VRM - go to vision and disable emailing
    Given UI Login with user "sys_admin" and password "radware"
    And UI Go To Vision
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
    And UI Set Checkbox "Enable" To "false"
    And UI Click Button "Submit"
    Then UI Logout

  @SID_14
  Scenario: VRM - Login to VRM and go to forensic
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage

  @SID_15
  Scenario: Create Forensics Report FTP_export by server IP no email
    When UI "Create" Forensics With Name "FTP_export"
      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                           |
      | Output | Action,Attack ID,Start Time,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Threat Category,Radware ID,Device IP Address,Attack Name,End Time,Duration,Packet Type,Physical Port,Policy Name,Risk |
      | Format | Select: CSV                                                                                                                                                                                                                                |
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/FTP_export*.zip /home/radware/ftp/FTP_export*.csv" on "GENERIC_LINUX_SERVER"

    Then UI Click Button "My Forensics" with value "FTP_export"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "FTP_export"
    Then Sleep "35"

  @SID_16
  Scenario: validate Forensics Report FTP csv file
    Then Sleep "3"
    # validate csv number of rows, columns order, values
    Then CLI Run remote linux Command "unzip -o /home/radware/ftp/FTP_export*.zip -d /home/radware/ftp/" on "GENERIC_LINUX_SERVER"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $1}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "S.No"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $2}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Start Time"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $3}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "End Time"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $4}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Device IP Address"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $5}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Threat Category"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $6}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Attack Name"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $7}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Policy Name"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $8}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Action"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $9}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Attack ID"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $10}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Source IP Address"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $11}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Source Port"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $12}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Destination IP Address"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $13}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Destination Port"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $14}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Direction"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $15}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Protocol"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $16}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Radware ID"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $17}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Duration"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $18}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Packet Type"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $19}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Physical Port"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -1|awk -F "," '{printf $20}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Risk"

    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -2|tail -1|awk -F "," '{printf $1}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -2|tail -1|awk -F "," '{printf $4}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "172.16.22.50"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -2|tail -1|awk -F "," '{printf $5}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Intrusions"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -2|tail -1|awk -F "," '{printf $6}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "tim"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -2|tail -1|awk -F "," '{printf $7}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "BDOS"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -2|tail -1|awk -F "," '{printf $8}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Drop"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -2|tail -1|awk -F "," '{printf $9}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "7716-1402580209"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -2|tail -1|awk -F "," '{printf $10}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "192.85.1.77"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -2|tail -1|awk -F "," '{printf $11}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1055"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -2|tail -1|awk -F "," '{printf $12}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1.1.1.9"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -2|tail -1|awk -F "," '{printf $13}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "80"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -2|tail -1|awk -F "," '{printf $14}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "In"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -2|tail -1|awk -F "," '{printf $15}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "TCP"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -2|tail -1|awk -F "," '{printf $16}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "300000"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -2|tail -1|awk -F "," '{printf $18}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Regular"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -2|tail -1|awk -F "," '{printf $19}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |head -2|tail -1|awk -F "," '{printf $20}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Low"

    Then CLI Run remote linux Command "cp /home/radware/ftp/FTP_export*.csv /tmp/" on "GENERIC_LINUX_SERVER"

  @SID_17
  Scenario: validate Forensics Report FTP export by server name
    Then CLI Operations - Run Root Session command "sed -i '/myftp/d' /etc/hosts"
    Then CLI Operations - Run Root Session command "echo "172.17.164.10 myftp" >> /etc/hosts"
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/FTP_export*.zip /home/radware/ftp/FTP_export*.csv" on "GENERIC_LINUX_SERVER"
    When UI "Edit" Forensics With Name "FTP_export"
      | Share | FTP:checked, FTP.Location:myftp, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
    Then UI Navigate to "AMS Reports" page via homePage
    Then UI Navigate to "AMS Forensics" page via homepage
    Then UI Click Button "My Forensics" with value "FTP_export"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "FTP_export"
    Then Sleep "35"
    Then CLI Run remote linux Command "unzip -o /home/radware/ftp/FTP_export*.zip -d /home/radware/ftp/" on "GENERIC_LINUX_SERVER"
    Then CLI Run linux Command "cat /home/radware/ftp/FTP_export*.csv |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2"

  @SID_18
  Scenario: validate username digits in FTP
    When UI "Create" Forensics With Name "FTPDigits"
      | Share | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:123123, FTP.Password:radware |
    Then UI Validate Element Existence By Label "My Forensics" if Exists "true" with value "FTPDigits"
    Then UI Delete Forensics With Name "Email Validate"
    Then UI Delete Forensics With Name "FTP_export"
    Then UI Delete Forensics With Name "FTPDigits"


  @SID_19
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
