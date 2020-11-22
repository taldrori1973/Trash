@TC112730
Feature: Forensics CSV with Attack details

  @SID_1
  Scenario: Clean system data
    Given CLI Reset radware password
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    * CLI kill all simulator attacks on current vision
    * CLI Clear vision logs
    * REST Delete ES index "dp-*"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"

  @SID_2
  Scenario: Run DP simulator BDOS attack
    And CLI simulate 1 attacks of type "rest_burst" on "DefensePro" 10 and wait 30 seconds

  @SID_3
  Scenario: login and go to forensic tab
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homePage

  @SID_4
  Scenario: Create Forensics Report csv_detailed
    When UI "Create" Forensics With Name "TC112730"
      | Share  | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                               |
      | Output | Action,Attack ID,Start Time,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Threat Category,Radware ID,Device IP Address,Attack Name,End Time,Duration,Packets,Mbits,Physical Port,,Risk, Policy Name |
      | Format | Select: CSV_WITH_DETAILS                                                                                                                                                                                                                                    |

  @SID_5
  Scenario: Clear FTP server logs and generate the report
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/TC112730*.zip /home/radware/ftp/TC112730*.csv" on "GENERIC_LINUX_SERVER"
    Then UI Generate and Validate Forensics With Name "TC112730" with Timeout of 300 Seconds
    Then Sleep "30"

  @SID_6
  Scenario: Unzip CSV file
    Then CLI Run remote linux Command "unzip -o /home/radware/ftp/TC112730*.zip -d /home/radware/ftp/" on "GENERIC_LINUX_SERVER"
    Then Sleep "3"

  @SID_7
  Scenario: Validate detailed csv DOS Shield
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv|head -$(echo $(grep -n "network flood IPv4 TCP-SYN-ACK" /home/radware/ftp/TC112730_*.csv |cut -f1 -d:)+1|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "State,BurstAttackBlocking"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv|head -$(echo $(grep -n "network flood IPv4 TCP-SYN-ACK" /home/radware/ftp/TC112730_*.csv |cut -f1 -d:)+19|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Is Burst Active,1"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv|head -$(echo $(grep -n "network flood IPv4 TCP-SYN-ACK" /home/radware/ftp/TC112730_*.csv |cut -f1 -d:)+20|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Current Burst Number,10"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv|head -$(echo $(grep -n "network flood IPv4 TCP-SYN-ACK" /home/radware/ftp/TC112730_*.csv |cut -f1 -d:)+21|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Average Burst Duration,28.0"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv|head -$(echo $(grep -n "network flood IPv4 TCP-SYN-ACK" /home/radware/ftp/TC112730_*.csv |cut -f1 -d:)+22|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Average Time between Bursts,64.5"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv|head -$(echo $(grep -n "network flood IPv4 TCP-SYN-ACK" /home/radware/ftp/TC112730_*.csv |cut -f1 -d:)+23|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Average Burst Rate,726581"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv|head -$(echo $(grep -n "network flood IPv4 TCP-SYN-ACK" /home/radware/ftp/TC112730_*.csv |cut -f1 -d:)+24|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Max Average Burst Rate,800002"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv|head -$(echo $(grep -n "network flood IPv4 TCP-SYN-ACK" /home/radware/ftp/TC112730_*.csv |cut -f1 -d:)+26|bc)|tail -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "*********************************************************************"
    Then CLI Run linux Command "cat /home/radware/ftp/TC112730_*.csv | wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "28"

  @SID_8
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
