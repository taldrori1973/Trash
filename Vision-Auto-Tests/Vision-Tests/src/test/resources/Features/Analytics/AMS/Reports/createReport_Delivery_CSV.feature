@VRM_Report2 @TC108070

Feature:  Report AMS analytics CSV Validations

  @SID_1
  Scenario: keep reports copy on file system
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15

  @SID_2
  Scenario: Clear Database and old reports on file-system
    * REST Delete ES index "dp-*"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"

  @SID_3
  Scenario: generate two attacks
    Given CLI simulate 2 attacks of type "rest_anomalies" on "DefensePro" 10 with attack ID
    Given CLI simulate 1 attacks of type "rest_dos" on "DefensePro" 10

  @SID_4
  Scenario: VRM - enabling emailing and go to VRM Reports Tab
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Go To Vision
    Then UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"
    Then UI Do Operation "select" item "Email Reporting Configuration"
    Then UI Set Checkbox "Enable" To "true"
    Then UI Set Text Field "SMTP User Name" To "qa_test@Radware.com"
    Then UI Set Checkbox "Enable" To "false"
    Then UI Click Button "Submit"
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
    And UI Set Checkbox "Enable" To "true"
    And UI Set Text Field "SMTP Server Address" To "172.17.164.10"
    And UI Set Text Field "SMTP Port" To "25"
    And UI Click Button "Submit"
    And UI Navigate to "AMS Reports" page via homePage
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

  @SID_5
  Scenario: Clear SMTP server log files
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/radware" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/reportuser" on "GENERIC_LINUX_SERVER"

  @SID_6
  Scenario: Create new Report Analytics CSV Delivery
    Given UI "Create" Report With Name "Delivery_Test_report"
      | reportType | DefensePro Analytics Dashboard                                                            |
      | Share      | Email:[automation.vision1@radware.com, also@report.local],Subject:report delivery Subject |
      | Format | Select: CSV |

  @SID_7
  Scenario: Validate delivery card and generate report
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/radware" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/reportuser" on "GENERIC_LINUX_SERVER"
    Then UI Generate and Validate Report With Name "Delivery_Test_report" with Timeout of 300 Seconds
    And Sleep "15"

  @SID_8
  Scenario: Validate Report Email received content
    Then CLI Run remote linux Command "cat /var/spool/mail/reportuser > /tmp/reportdelivery.log" on "GENERIC_LINUX_SERVER"
    Then CLI Run linux Command "cat /var/spool/mail/reportuser|tr -d "="|tr -d "\n"|grep -o "Subject: report delivery Subject" |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /var/spool/mail/radware|tr -d "="|tr -d "\n"|grep -o "Subject: report delivery Subject" |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"

    Then CLI Run linux Command "grep "From: APSolute Vision <qa_test@Radware.com>" /var/spool/mail/reportuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "From: APSolute Vision <qa_test@Radware.com>" /var/spool/mail/radware |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"

    Then CLI Run linux Command "grep "X-Original-To: also@report.local" /var/spool/mail/reportuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "X-Original-To: automation.vision1@radware.com" /var/spool/mail/radware |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"

    Then CLI Run linux Command "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).zip" /var/spool/mail/reportuser | wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).zip" /var/spool/mail/radware | wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"

  @SID_9
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

    ############################################       TOP ATTACKS       ###################################################################################

  @SID_10
  Scenario: VRM report validate CSV file TOP ATTACKS number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"


  @SID_11
  Scenario: VRM report validate CSV file TOP ATTACKS headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -1|grep name,ruleName,endTime,Count|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "name"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "ruleName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "endTime"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Count"

  @SID_12
  Scenario:VRM report validate CSV file TOP ATTACKS content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -2|tail -1|grep -oP "\"Incorrect IPv4 checksum\",\"Packet Anomalies\",$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Incorrect IPv4 checksum""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Packet Anomalies""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -2|tail -1|awk -F "," '{printf $3}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -3|tail -1|grep -oP "DOSS-Anomaly-TCP-SYN-RST,BDOS,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),1" | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -3|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOSS-Anomaly-TCP-SYN-RST"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "BDOS"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -3|tail -1|awk -F "," '{printf $3}'|grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -3|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    ############################################       ATTACKS BY THREAT CATEGORY       ######################################################################

  @SID_13
  Scenario: VRM report validate CSV file ATTACKS BY THREAT CATEGORY number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Threat\ Category.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_14
  Scenario: VRM report validate CSV file ATTACKS BY THREAT CATEGORY headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Threat\ Category.csv|head -1 |grep "name,ruleName,endTime,Count,category" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_15
  Scenario: VRM report validate CSV file ATTACKS BY THREAT CATEGORY content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Threat\ Category.csv|head -2 |tail -1|grep -oP "\"Incorrect IPv4 checksum\",\"Packet Anomalies\",$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),2,Anomalies" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Threat\ Category.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Incorrect IPv4 checksum""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Threat\ Category.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Packet Anomalies""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Threat\ Category.csv|head -2|tail -1|awk -F "," '{printf $3}' |grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Threat\ Category.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Threat\ Category.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Anomalies"


    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Threat\ Category.csv|head -4 |tail -1|grep -oP "DOSS-Anomaly-TCP-SYN-RST,BDOS,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),1,DOSShield"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Threat\ Category.csv|head -4|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOSS-Anomaly-TCP-SYN-RST"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Threat\ Category.csv|head -4|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "BDOS"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Threat\ Category.csv|head -4|tail -1|awk -F "," '{printf $3}' |grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Threat\ Category.csv|head -4|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Threat\ Category.csv|head -4|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOSShield"


    ############################################       TOP ATTACK DESTINATION       ###########################################################################

  @SID_16
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attack\ Destination.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_17
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attack\ Destination.csv|head -1 |grep "deviceIp,destAddress,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_18
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attack Destination.csv"|head -2 |tail -1|grep -oP "172.16.22.50,Multiple,2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attack Destination.csv"|head -4 |tail -1|grep -oP "172.16.22.50,1.1.1.8,1"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


    ############################################       TOP ATTACK SOURCES       ###############################################################################

  @SID_19
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attack\ Sources.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_20
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attack\ Sources.csv|head -1 |grep "deviceIp,sourceAddress,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_21
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attack Sources.csv"|head -2 |tail -1|grep -oP "172.16.22.50,Multiple,2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attack Sources.csv"|head -4 |tail -1|grep -oP "172.16.22.50,192.85.1.8,1"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


    ############################################       ATTACK CATEGORIES BY BANDWIDTH       ###################################################################

  @SID_22
  Scenario: VRM report validate CSV file ATTACK CATEGORIES BY BANDWIDTH number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attack_Categories\ by\ Bandwidth.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_23
  Scenario: VRM report validate CSV file ATTACK CATEGORIES BY BANDWIDTH headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attack_Categories\ by\ Bandwidth.csv|head -1 |grep "ruleName,endTime,category,packetBandwidth" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_24
  Scenario: VRM report validate CSV file ATTACK CATEGORIES BY BANDWIDTH content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack_Categories by Bandwidth.csv"|head -2 |tail -1|grep -oP "\"Packet Anomalies\",$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),Anomalies,0"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack_Categories by Bandwidth.csv"|head -3 |tail -1|grep -oP "BDOS,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),DOSShield,56641"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


    ############################################       ATTACK BY MITIGATION ACTION       ####################################################################

  @SID_25
  Scenario: VRM report validate CSV file ATTACK BY MITIGATION ACTION number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by Mitigation Action.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_26
  Scenario: VRM report validate CSV file ATTACK BY MITIGATION ACTION headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Mitigation\ Action.csv|head -1 |grep "name,actionType,ruleName,endTime,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_27
  Scenario: VRM report validate CSV file ATTACK BY MITIGATION ACTION content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by Mitigation Action.csv"|head -2 |tail -1|grep -oP "\"Incorrect IPv4 checksum\",Drop,\"Packet Anomalies\",$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by Mitigation Action.csv"|head -4 |tail -1|grep -oP "DOSS-Anomaly-TCP-SYN-RST,Drop,BDOS,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),1"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


    ############################################       ATTACKS BY PROTECTION POLICY       ####################################################################

  @SID_28
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Protection\ Policy.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_29
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Protection\ Policy.csv|head -1|grep "name,ruleName,endTime,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Protection\ Policy.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "name"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Protection\ Policy.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "ruleName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Protection\ Policy.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "endTime"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Protection\ Policy.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Count"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Protection\ Policy.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS ""

  @SID_30
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Protection\ Policy.csv|head -2|tail -1|grep -oP "\"Incorrect IPv4 checksum\",\"Packet Anomalies\",$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Protection\ Policy.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Incorrect IPv4 checksum""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Protection\ Policy.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Packet Anomalies""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Protection\ Policy.csv|head -2|tail -1|awk -F "," '{printf $3}' |grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Protection\ Policy.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2"


    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Protection\ Policy.csv|head -3|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOSS-Anomaly-TCP-SYN-RST"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Protection\ Policy.csv|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "BDOS"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Protection\ Policy.csv|head -3|tail -1|awk -F "," '{printf $3}' |grep $(date +"%d")|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks_by\ Protection\ Policy.csv|head -3|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    ############################################       CRITICAK ATTACKS BY MITIGATION ACTION      #############################################################

  @SID_31
  Scenario: VRM report validate CSV file CRITICAK ATTACKS BY MITIGATION ACTION number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Critical_Attacks\ By\ Mitigation\ Action.csv|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"

  @SID_32
  Scenario: VRM report validate CSV file CRITICAK ATTACKS BY MITIGATION ACTION headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Critical_Attacks by Mitigation Action.csv"|head -1|grep "NO DATA FOR SELECTED DATA SOURCE" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"


      ############################################       TOP ALLOWED ATTACKERS      ############################################################################

  @SID_33
  Scenario: VRM report validate CSV file TOP ALLOWED ATTACKERS number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Allowed Attackers.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    # Changed result to 0 once this template was removed in 4.20

  @SID_34
  Scenario: VRM report validate CSV file TOP ALLOWED ATTACKERS headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Allowed\ Attackers.csv|head -1|grep "NO DATA FOR SELECTED DATA SOURCE" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    # Changed result to 0 once this template was removed in 4.20

      ############################################       TOP ATTACKS BY BANDWIDTH      ########################################################################

  @SID_35
  Scenario: VRM report validate CSV file TOP ATTACKS BY BANDWIDTH number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks by Bandwidth.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_36
  Scenario: VRM report validate CSV file TOP ATTACKS BY BANDWIDTH headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks\ by\ Bandwidth.csv|head -1|grep "name,ruleName,endTime,packetBandwidth,packetCount" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_37
  Scenario: VRM report validate CSV file TOP ATTACKS BY BANDWIDTH content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks\ by\ Bandwidth.csv|head -2|tail -1|grep -oP "\"Incorrect IPv4 checksum\",\"Packet Anomalies\",$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),0,2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks\ by\ Bandwidth.csv|head -3|tail -1|grep -oP "DOSS-Anomaly-TCP-SYN-RST,BDOS,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),56641,58469"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


      ############################################       TOP ATTACKS BY PROTOCOL      ########################################################################

  @SID_38
  Scenario: VRM report validate CSV file TOP ATTACKS BY PROTOCOL number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks by Protocol.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_39
  Scenario: VRM report validate CSV file TOP ATTACKS BY PROTOCOL headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks\ by\ Protocol.csv|head -1|grep "name,ruleName,protocol,endTime,Count" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_40
  Scenario: VRM report validate CSV file TOP ATTACKS BY PROTOCOL content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks by Protocol.csv"|head -2|tail -1|grep -oP "\"Incorrect IPv4 checksum\",\"Packet Anomalies\",IP,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks by Protocol.csv"|head -4|tail -1|grep -oP "DOSS-Anomaly-TCP-SYN-RST,BDOS,TCP,$(date +"%B %d %Y [0-9][0-9]:[0-9][0-9]"),1"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


      ############################################       TOP SCANNERS      ##################################################################################

  @SID_41
  Scenario: VRM report validate CSV file TOP SCANNERS number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Scanners.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"

  @SID_42
  Scenario: VRM report validate CSV file TOP SCANNERS headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Scanners.csv"|head -1|grep "NO DATA FOR SELECTED DATA SOURCE" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_43
  Scenario: VRM - just English characters
    Given UI "Create" Report With Name "just English characters"
      | reportType | DefensePro Analytics Dashboard                                                                         |
      | Share      | Email:[automation.vision1@radware.com],Subject:english characters subject,Body:english characters body |

    Given UI "Edit" Report With Name "just English characters"
      | Format | Select: PDF |

    Then UI "Validate" Report With Name "just English characters"
      | reportType | DefensePro Analytics Dashboard                                                                         |
      | Share      | Email:[automation.vision1@radware.com],Subject:english characters subject,Body:english characters body |
      | Format     | Select: PDF                                                                                            |


  @SID_44
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
