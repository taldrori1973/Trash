@TC118361 @Test12
Feature: DefensePro Analytics CSV Report

  @SID_1
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." with timeOut 240


  @SID_2
  Scenario: Clear Database and old reports on file-system
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"
    Given Setup email server

  @SID_3
  Scenario: generate two attacks
    Given CLI simulate 2 attacks of type "rest_anomalies" on "DefensePro" 10 with attack ID
    Given CLI simulate 1 attacks of type "rest_dos" on "DefensePro" 10

  @SID_4
  Scenario: VRM - enabling emailing and go to VRM Reports Tab
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    #Make sure all attacks are at the same time
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"deviceIp":"172.16.22.50"}},"script":{"source":"ctx._source.endTime='$(date +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"

  @SID_5
  Scenario: VRM - enabling emailing and go to VRM Reports Tab
    And UI Go To Vision
    Then UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"
    Then UI Do Operation "select" item "Email Reporting Configuration"
    Then UI Set Checkbox "Enable" To "true"
    Then UI Set Text Field "SMTP User Name" To "qa_test@Radware.com"
    Then UI Set Text Field "Subject Header" To "Alert Notification Message"
    Then UI Set Text Field "From Header" To "Automation system"
    Then UI Set Checkbox "Enable" To "false"
    Then UI Click Button "Submit"
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
    And UI Set Checkbox "Enable" To "true"
    And UI Set Text Field "SMTP Server Address" To "172.17.164.10"
    And UI Set Text Field "SMTP Port" To "25"
    And UI Click Button "Submit"


  @SID_6
  Scenario: Navigate to AMS Reports
    And UI Navigate to "AMS Reports" page via homePage


  @SID_5
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"


  @SID_6
  Scenario: Create new Report Analytics CSV Delivery
    Given UI "Create" Report With Name "DP Analytics csv"
      | Template | reportType:DefensePro Analytics , Widgets:[ALL] , devices:[All] , showTable:true |
#      | Share                 | Email:[Test, Test2],Subject:DP Analytics csv Subject                                                                       |
      | Share    | Email:[Test, Test2],Subject:TC108070 Subject                                     |
      | Format   | Select: CSV                                                                      |


#      | Template              | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[bps,Inbound,All]}] , devices:[All] , showTable:true |
#      | Logo                  | reportLogoPNG.png                                                                                                  |
#      | Format                | Select: PDF                                                                                                        |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                    |
#      | Time Definitions.Date | Quick:Today                                                                                                        |
#      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                               |
#
  @SID_7
  Scenario: generate report
    Then UI Click Button "My Report" with value "DP Analytics csv"
    Then UI Click Button "Generate Report Manually" with value "DP Analytics csv"
    Then Sleep "35"

#########################todo
#
#  @SID_8
#  Scenario: Validate Report Email received content
#    #subject
#    Then Validate "setup" user eMail expression "grep "Subject: TC108070 Subject"" EQUALS "2"
#    #From
#    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@Radware.com>"" EQUALS "2"
#    #To
#    Then Validate "setup" user eMail expression "grep "X-Original-To: Test2@.*.local"" EQUALS "1"
#    #Attachment
#    Then Validate "setup" user eMail expression "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).zip"" EQUALS "2"


  @SID_9
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

    ############################################       TOP ATTACKS       ###################################################################################

  @SID_10
  Scenario: VRM report validate CSV file TOP ATTACKS number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"


  @SID_11
  Scenario: VRM report validate CSV file TOP ATTACKS headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -1|grep name,ruleName,Count|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "name"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "ruleName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Count"

  @SID_12
  Scenario:VRM report validate CSV file TOP ATTACKS content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -2|tail -1|grep -oP "\"Incorrect IPv4 checksum\",\"Packet Anomalies\",2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Incorrect IPv4 checksum""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Packet Anomalies""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -3|tail -1|grep -oP "DOSS-Anomaly-TCP-SYN-RST,BDOS,1" | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOSS-Anomaly-TCP-SYN-RST"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "BDOS"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    ############################################       ATTACKS BY THREAT CATEGORY       ######################################################################

  @SID_13
  Scenario: VRM report validate CSV file ATTACKS BY THREAT CATEGORY number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_14
  Scenario: VRM report validate CSV file ATTACKS BY THREAT CATEGORY headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -1 |grep "name,ruleName,Count,category" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_15
  Scenario: VRM report validate CSV file ATTACKS BY THREAT CATEGORY content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2 |tail -1|grep -oP "\"Incorrect IPv4 checksum\",\"Packet Anomalies\",2,Anomalies" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Incorrect IPv4 checksum""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Packet Anomalies""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Anomalies"


    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -3 |tail -1|grep -oP "DOSS-Anomaly-TCP-SYN-RST,BDOS,1,DOSShield"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOSS-Anomaly-TCP-SYN-RST"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "BDOS"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOSShield"


    ############################################       TOP ATTACK DESTINATION       ###########################################################################

  @SID_16
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Destinations-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_17
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Destinations-DefensePro\ Analytics.csv|head -1 |grep "ruleName,destAddress,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_18
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION content
    #################### fail
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Destinations-DefensePro Analytics.csv"|head -3 |tail -1|grep -oP "BDOS,1.1.1.8,1"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


    ############################################       TOP ATTACK SOURCES       ###############################################################################
  @SID_19
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_20
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv|head -1 |grep "ruleName,sourceAddress,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_21
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES content
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Sources-DefensePro Analytics.csv"|head -2 |tail -1|grep -oP "Packet Anomalies,Multiple,2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Sources-DefensePro Analytics.csv"|head -4 |tail -1|grep -oP "BDOS,192.85.1.8,1"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


    ############################################       ATTACK CATEGORIES BY BANDWIDTH       ###################################################################

  @SID_22
  Scenario: VRM report validate CSV file ATTACK CATEGORIES BY BANDWIDTH number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack Categories by Bandwidth-DefensePro Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_23
  Scenario: VRM report validate CSV file ATTACK CATEGORIES BY BANDWIDTH headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack Categories by Bandwidth-DefensePro Analytics.csv" |head -1 |grep "category,ruleName,packetBandwidth" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_24
  Scenario: VRM report validate CSV file ATTACK CATEGORIES BY BANDWIDTH content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack Categories by Bandwidth-DefensePro Analytics.csv"|head -3 |tail -1|grep -oP "DOSShield,BDOS,56641"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


    ############################################       ATTACK BY MITIGATION ACTION       ####################################################################

  @SID_25
  Scenario: VRM report validate CSV file ATTACK BY MITIGATION ACTION number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Mitigation Action-DefensePro Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_26
  Scenario: VRM report validate CSV file ATTACK BY MITIGATION ACTION headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Mitigation Action-DefensePro Analytics.csv"|head -1 |grep "name,actionType,ruleName,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_27
  Scenario: VRM report validate CSV file ATTACK BY MITIGATION ACTION content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Mitigation Action-DefensePro Analytics.csv"|head -2 |tail -1|grep -oP "\"Incorrect IPv4 checksum\",Drop,\"Packet Anomalies\",2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Mitigation Action-DefensePro Analytics.csv"|head -4 |tail -1|grep -oP "DOSS-Anomaly-TCP-SYN-RST,Drop,BDOS,1"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


    ############################################       ATTACKS BY PROTECTION POLICY       ####################################################################

  @SID_28
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_29
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -1|grep "name,ruleName,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "name"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "ruleName"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Count"

  @SID_30
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -2|tail -1|grep -oP "\"Incorrect IPv4 checksum\",\"Packet Anomalies\",2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Incorrect IPv4 checksum""
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Packet Anomalies""
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2"


    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -3|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOSS-Anomaly-TCP-SYN-RST"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "BDOS"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -3|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

    ############################################       CRITICAK ATTACKS BY MITIGATION ACTION      #############################################################
#  @SID_31
#  Scenario: VRM report validate CSV file CRITICAL ATTACKS BY MITIGATION ACTION number of lines
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Critical Attacks by Mitigation Action-DefensePro Analytics.csv"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"
#
#  @SID_32
#  Scenario: VRM report validate CSV file CRITICAL ATTACKS BY MITIGATION ACTION headers
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Critical Attacks by Mitigation Action-DefensePro Analytics.csv"|head -1|grep "name,actionType,ruleName,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"



      ############################################       TOP ALLOWED ATTACKERS      ############################################################################

  @SID_33
  Scenario: VRM report validate CSV file TOP ALLOWED ATTACKERS number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Allowed Attackers-DefensePro Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    # Changed result to 0 once this template was removed in 4.20

  @SID_34
  Scenario: VRM report validate CSV file TOP ALLOWED ATTACKERS headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Allowed Attackers-DefensePro Analytics.csv"|head -1|grep "NO DATA FOR SELECTED DATA SOURCE" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top_Allowed\ Attackers.csv"|head -1|grep "name,ruleName,sourceAddress,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#
  #### There is no data
#  @SID_35
#  Scenario: VRM report validate CSV file TOP ALLOWED ATTACKERS content
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Allowed Attackers-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Incorrect IPv4 checksum""
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Allowed Attackers-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Packet Anomalies""
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Allowed Attackers-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Multiple"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Allowed Attackers-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2"
#
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Allowed Attackers-DefensePro Analytics.csv"|head -3|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOSS-Anomaly-TCP-SYN-RST"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Allowed Attackers-DefensePro Analytics.csv"|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "BDOS"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Allowed Attackers-DefensePro Analytics.csv"|head -3|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#


      ############################################       TOP ATTACKS BY PROTOCOL      ########################################################################

  @SID_38
  Scenario: VRM report validate CSV file TOP ATTACKS BY PROTOCOL number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  @SID_39
  Scenario: VRM report validate CSV file TOP ATTACKS BY PROTOCOL headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -1|grep "name,ruleName,protocol,Count" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_40
  Scenario: VRM report validate CSV file TOP ATTACKS BY PROTOCOL content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -2|tail -1|grep -oP "\"Incorrect IPv4 checksum\",\"Packet Anomalies\",IP,2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -4|tail -1|grep -oP "DOSS-Anomaly-TCP-SYN-RST,BDOS,TCP,1"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


      ############################################       TOP SCANNERS      ##################################################################################
  @SID_41
  Scenario: VRM report validate CSV file TOP SCANNERS number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Scanners-DefensePro Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"

  @SID_42
  Scenario: VRM report validate CSV file TOP SCANNERS headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Scanners-DefensePro Analytics.csv"|head -1|grep "NO DATA FOR SELECTED DATA SOURCE" |wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#### There is no Data
#  @SID_43
#  Scenario: VRM report validate CSV file TOP TOP SCANNERS  content
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Scanners-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Scanners-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Packet Anomalies""
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Scanners-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Multiple"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Scanners-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Scanners-DefensePro Analytics.csv"|head -3|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.16.22.50"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Scanners-DefensePro Analytics.csv"|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "BDOS"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Scanners-DefensePro Analytics.csv"|head -3|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


  @SID_44
  Scenario: Cleanup
    Then UI Delete Report With Name "DP Analytics csv"
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
