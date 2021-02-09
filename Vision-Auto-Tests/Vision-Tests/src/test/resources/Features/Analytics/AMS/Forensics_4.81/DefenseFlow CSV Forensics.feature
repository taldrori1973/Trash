@TC119567

Feature: DefenseFlow CSV Forensics

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "df-attack*"
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
  Scenario: Login and Navigate
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "New Forensics" page via homepage

  @SID_5
  Scenario: create new Forensics_DefenseFlow and validate
    Then UI Click Button "New Forensics Tab"
    When UI "Create" Forensics With Name "Forensics_DefenseFlow"
      | Product           | DefenseFlow                                                                                                      |
      | Protected Objects | All                                                                                                              |
      | Output            | All                                                                                                              |
      | Format            | Select: CSV                                                                                                      |
      | Share             | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
    Given UI "Validate" Forensics With Name "Forensics_DefenseFlow"
      | Product           | DefenseFlow                                                                                                      |
      | Protected Objects | All                                                                                                              |
      | Output            | ALL                                                                                                              |
      | Format            | Select: CSV                                                                                                      |
      | Share             | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |


  @SID_6
  Scenario: Clear FTP server logs and generate the report
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/Forensics_DefenseFlow*.zip /home/radware/ftp/Forensics_DefenseFlow*.csv" on "GENERIC_LINUX_SERVER"

  @SID_7
  Scenario: Validate delivery card and generate Forensics
    Then UI Click Button "My Forensics Tab" with value "Forensics_DefenseFlow"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensics_DefenseFlow"
    Then Sleep "35"

  @SID_8
  Scenario: Unzip CSV file
    Then CLI Run remote linux Command "unzip -o /home/radware/ftp/Forensics_DefenseFlow*.zip -d /home/radware/ftp/" on "GENERIC_LINUX_SERVER"
    Then Sleep "3"

  @SID_9
  Scenario: Validate the First line in Forensics_DefenseFlow_*.csv File
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "279"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $1}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "S.No"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $2}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Start Time"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $3}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "End Time"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $4}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Threat Category"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $5}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Attack Name"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $6}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Policy Name"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $7}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Action"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $8}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Attack ID"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $9}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Source IP"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $10}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Source Port"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $11}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Destination IP"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $12}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Destination Port"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $13}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Direction"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $14}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Protocol"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $15}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Radware ID"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $16}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Duration"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $17}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Packets"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $18}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Max PPS"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $19}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Mbits"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $20}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Max BPS"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $21}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Physical Port"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $22}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Risk"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv|head -1|tail -1|awk -F "," '{printf $23}';echo" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Vlan tag"

  @SID_10
  Scenario: Validate Threat Category
    Then CLI Run linux Command "sed -n '1d;p' /home/radware/ftp/Forensics_DefenseFlow_*.csv| awk -F "," '{print $4}' | sort | uniq| wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv |grep -w  BehavioralDOS|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "278"

  @SID_11
  Scenario: Validate Attack Name
    Then CLI Run linux Command "sed -n '1d;p' /home/radware/ftp/Forensics_DefenseFlow_*.csv| awk -F "," '{print $5}' | sort | uniq| wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "11"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv |grep -w  'HTTP (recv.pps)'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "150"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv |grep -w  'HTTP (recv.bps)'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv |grep -w  'Total (recv.pps)'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "4"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv |grep -w  'Total (recv.bps)'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "19"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv |grep -w  'UDP Port 0 (recv.pps)'|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "33"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv |grep -w  network\ flood\ IPv6\ UDP|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "18"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv |grep -w  network\ flood\ IPv4\ UDP|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "12"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv |grep -w  network\ flood\ IPv4\ TCP-SYN|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "8"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv |grep -w  HTTPS\ Flood\ Protection|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "9"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv |grep -w  External\ report|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "7"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv |grep -w  DOSS-NTP-monlist-flood|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "17"

  @SID_12
  Scenario: Validate Action
    Then CLI Run linux Command "sed -n '1d;p' /home/radware/ftp/Forensics_DefenseFlow_*.csv| awk -F "," '{print $7}' | sort | uniq| wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/ftp/Forensics_DefenseFlow_*.csv |grep -w  Drop|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "278"

  @SID_13
  Scenario: Validate Protocol
    Then CLI Run linux Command "sed -n '1d;p' /home/radware/ftp/Forensics_DefenseFlow_*.csv| awk -F "," '{print $14}' | sort | uniq| wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "5"
    Then CLI Run linux Command "sed -n '1d;p' /home/radware/ftp/Forensics_DefenseFlow_*.csv| awk -F "," '{print $14}' | grep ICMP|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "9"
    Then CLI Run linux Command "sed -n '1d;p' /home/radware/ftp/Forensics_DefenseFlow_*.csv| awk -F "," '{print $14}' | grep -w IP|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "9"
    Then CLI Run linux Command "sed -n '1d;p' /home/radware/ftp/Forensics_DefenseFlow_*.csv| awk -F "," '{print $14}' | grep NonIP|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "76"
    Then CLI Run linux Command "sed -n '1d;p' /home/radware/ftp/Forensics_DefenseFlow_*.csv| awk -F "," '{print $14}' | grep TCP|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "151"
    Then CLI Run linux Command "sed -n '1d;p' /home/radware/ftp/Forensics_DefenseFlow_*.csv| awk -F "," '{print $14}' | grep UDP|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "33"

  @SID_14
  Scenario: Delete Forensics
    Then UI Delete Forensics With Name "Forensics_DefenseFlow"

  @SID_15
  Scenario: Logout
    Then UI logout and close browser


