@TC121782
Feature: Exclude DP Reports


  @SID_1
  Scenario: Clean data System
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs


  @SID_2
  Scenario: Run DP simulator for ErtFeed_GeoFeed
    Given CLI simulate 1000 attacks of type "ErtFeed_GeoFeed" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds
    Then Sleep "30"

  @SID_3
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." Retry 240 seconds


  @SID_4
  Scenario: Clear old reports on file-system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"


  @SID_5
  Scenario: Create and Generate New Report with Exclude Malicious IP Addresses
    Then UI Navigate to "AMS REPORTS" page via homepage
    Given UI "Create" Report With Name "Exclude DP Attacks1"
      | Template | reportType:DefensePro Analytics,Widgets:[{ALL:[{Traffic Bandwidth:[pps,Inbound,All Policies]}]}], devices:[All], showTable:true, ExcludeMaliciousIPAddresses:true |
      | Format   | Select: CSV                                                                                                                                                       |

    Then UI "Validate" Report With Name "Exclude DP Attacks1"
      | Template | reportType:DefensePro Analytics,Widgets:[{ALL:[{Traffic Bandwidth:[pps,Inbound,All Policies]}]}], devices:[All], showTable:true, ExcludeMaliciousIPAddresses:true |
      | Format   | Select: CSV                                                                                                                                                       |

    Then UI "Generate" Report With Name "Exclude DP Attacks1"
      | timeOut | 60 |


  @SID_6
  Scenario: VRM report unzip local CSV file
    Then Sleep "10"
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then Sleep "10"


    ##############################  Validate Top Attacks CSV ####################################################

  @SID_7
  Scenario: VRM report validate CSV file TOP ATTACKS number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"


  @SID_8
  Scenario: VRM report validate CSV file TOP ATTACKS headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -1|grep name,ruleName,Count|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "name"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "ruleName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Count"


  @SID_9
  Scenario:VRM report validate CSV file TOP ATTACKS content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -2|tail -1|grep -oP "\"Danny Litani10\",policy1,1" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Danny Litani10""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

 ############################################       ATTACKS BY THREAT CATEGORY       ######################################################################

  @SID_10
  Scenario: VRM report validate CSV file ATTACKS BY THREAT CATEGORY number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_11
  Scenario: VRM report validate CSV file ATTACKS BY THREAT CATEGORY headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -1 |grep "name,ruleName,Count,category" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_12
  Scenario: VRM report validate CSV file ATTACKS BY THREAT CATEGORY content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2 |tail -1|grep -oP "\"Danny Litani10\",policy1,1,GeoFeed" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Danny Litani10""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "GeoFeed"

############################################       TOP ATTACK DESTINATION       ###########################################################################
##attached bug DE66060
  @SID_13
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Destinations-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"


  @SID_14
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Destinations-DefensePro\ Analytics.csv|head -1 |grep "country,address,count,percent" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


    ##attached bug DE66060
  @SID_15
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Destinations-DefensePro Analytics.csv"|head -3 |tail -1|grep -oP "--,2000::0002,1,50.0000"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Destinations-DefensePro Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "--"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Destinations-DefensePro Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2000::0002"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Destinations-DefensePro Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Destinations-DefensePro Analytics.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "50.0000"


    ############################################       TOP ATTACK SOURCES       ###############################################################################
  @SID_16
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_17
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv|head -1 |grep "country,address,count,percent" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_18
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Sources-DefensePro Analytics.csv"|head -2 |tail -1|grep -oP "Multiple,Multiple,2,100.0000" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Multiple"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Multiple"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "100.0000"

    ############################################       ATTACK CATEGORIES BY BANDWIDTH       ###################################################################

  @SID_19
  Scenario: VRM report validate CSV file ATTACK CATEGORIES BY BANDWIDTH number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack Categories by Bandwidth-DefensePro Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_20
  Scenario: VRM report validate CSV file ATTACK CATEGORIES BY BANDWIDTH headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack Categories by Bandwidth-DefensePro Analytics.csv" |head -1 |grep "category,ruleName,packetBandwidth" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_21
  Scenario: VRM report validate CSV file ATTACK CATEGORIES BY BANDWIDTH content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack Categories by Bandwidth-DefensePro Analytics.csv"|head -3 |tail -1|grep -oP "GeoFeed,policy1,633339"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attack\ Categories\ by\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "GeoFeed"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attack\ Categories\ by\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attack\ Categories\ by\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "633339"

############################################       ATTACK BY MITIGATION ACTION       ####################################################################

  @SID_22
  Scenario: VRM report validate CSV file ATTACK BY MITIGATION ACTION number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Mitigation Action-DefensePro Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_23
  Scenario: VRM report validate CSV file ATTACK BY MITIGATION ACTION headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Mitigation Action-DefensePro Analytics.csv"|head -1 |grep "name,actionType,ruleName,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_24
  Scenario: VRM report validate CSV file ATTACK BY MITIGATION ACTION content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Mitigation Action-DefensePro Analytics.csv"|head -2 |tail -1|grep -oP "\"Danny Litani10\",Challenge,policy1,1" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Mitigation\ Action-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Danny Litani10""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Mitigation\ Action-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Challenge"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Mitigation\ Action-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Mitigation\ Action-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


     ############################################       ATTACKS BY PROTECTION POLICY       ####################################################################

  @SID_25
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_26
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -1|grep "name,ruleName,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "name"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "ruleName"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Count"

  @SID_27
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -2|tail -1|grep -oP "\"Danny Litani10\",policy1,1" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Danny Litani10""
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

############################################       Top Attacks by Duration      #############################################################

  @SID_28
  Scenario: VRM report validate CSV file Top Attacks by Duration number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_29
  Scenario: VRM report validate CSV file Top Attacks by Duration headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -1|grep "duration,name,ruleName,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "duration"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "name"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "ruleName"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Count"

  @SID_30
  Scenario: VRM report validate CSV file Top Attacks by Duration content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -2|tail -1|grep -oP "\"Danny Litani10\",policy1,1" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""5-10 min""
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Danny Litani10""
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


############################################       Top Attacks by Protocol      #############################################################
  @SID_31
  Scenario: VRM report validate CSV file Top Attacks by Protocol number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_32
  Scenario: VRM report validate CSV file Top Attacks by Protocol headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -1|grep "name,ruleName,protocol,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "name"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "ruleName"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protocol"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Count"

  @SID_33
  Scenario: VRM report validate CSV fileTop Attacks by Protocol content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -2|tail -1|grep -oP "\"Danny Litani10\",policy1,TCP,1" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Danny Litani10""
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "TCP"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

############################################       Top Attacks by Volume      #############################################################
  @SID_34
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_35
  Scenario: VRM report validate CSV fileTop Attacks by Volume headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -1|grep "name,ruleName,packetBandwidth,packetCount" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "name"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "ruleName"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "packetBandwidth"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "packetCount"

  @SID_36
  Scenario: VRM report validate CSV file Top Attacks by Volume content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -2|tail -1|grep -oP "\"Danny Litani10\",policy1,633339,525126" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Danny Litani10""
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "633339"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "525126"


  @SID_37
  Scenario: Delete Added Reports
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Delete Report With Name "Exclude DP Attacks1"




  @SID_38
  Scenario: Logout and close browser
    Given UI logout and close browser


