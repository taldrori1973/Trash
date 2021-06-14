@TC121692
Feature: EAAF Attacks Exclusion

  ## clear data
  ## send attcks:HTTPS, IP_FEED_Modified and ErtFeed_GeoFeed

  #################### Exclude DP Attacks Dashboard ###########################################
  
  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs


  @SID_2
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." Retry 240 seconds


  @SID_3
  Scenario: Clear old reports on file-system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"



  @SID_4
  Scenario: Run DP simulator - ErtFeed_GeoFeed
    Given CLI simulate 1000 attacks of type "ErtFeed_GeoFeed" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds

  @SID_5
  Scenario:  login to vision
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "2"
  
  @SID_6
  Scenario: navigate to attacks dashboard
    And UI Navigate to "DefensePro Attacks" page via homePage
    Then UI UnSelect Element with label "Accessibility Auto Refresh" and params "Stop Auto-Refresh"
    When UI set "Auto Refresh" switch button to "off"
    Given UI Click Button "Accessibility Menu"
    Then UI Select Element with label "Accessibility Auto Refresh" and params "Stop Auto-Refresh"
    Then UI Click Button "Accessibility Menu"


  @SID_7
  Scenario:  Validate data before Exclude Malicious IP Addresses
    Then UI Validate the attribute "data-debug-checked" Of Label "Exclude Malicious IP Addresses Checkbox" is "EQUALS" to "false"
    Then UI Validate "Attacks Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Attacks Table" findBy index 0
      | columnName      | value                  |
      | Attack Category | Malicious IP Addresses |

    Then UI Validate Table record values by columns with elementLabel "Attacks Table" findBy index 1
      | columnName      | value       |
      | Attack Category | Geolocation |


  @SID_8
  Scenario:  Validate data after Exclude Malicious IP Addresses
    Then UI Click Button "Exclude Malicious IP Addresses Checkbox"
    Then UI Validate the attribute "data-debug-checked" Of Label "Exclude Malicious IP Addresses Checkbox" is "EQUALS" to "true"
    Then UI Validate "Attacks Table" Table rows count EQUALS to 1
    Then UI Validate Table record values by columns with elementLabel "Attacks Table" findBy index 0
      | columnName      | value       |
      | Attack Category | Geolocation |

  @SID_9
  Scenario: Clean data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs


  @SID_10
  Scenario: Run DP simulator -IP_FEED_Modified
    Given CLI simulate 1000 attacks of type "IP_FEED_Modified" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds

  @SID_11
  Scenario:  navigate to attacks dashboard
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI Navigate to "DefensePro Attacks" page via homePage
    Then Sleep "2"

  @SID_12
  Scenario:  Validate data after check Exclude Malicious IP Addresses
    Then UI Validate the attribute "data-debug-checked" Of Label "Exclude Malicious IP Addresses Checkbox" is "EQUALS" to "false"
    Then UI Validate "Attacks Table" Table rows count EQUALS to 627
    Then UI Click Button "Exclude Malicious IP Addresses Checkbox"
    Then UI Validate the attribute "data-debug-checked" Of Label "Exclude Malicious IP Addresses Checkbox" is "EQUALS" to "true"
    Then UI Validate "Attacks Table" Table rows count EQUALS to 1


  @SID_13
  Scenario: Run DP simulator - HTTPS
    Given CLI simulate 1000 attacks of type "HTTPS" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds

  @SID_14
  Scenario:  navigate to attack dashboard
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI Navigate to "DefensePro Attacks" page via homePage
    Then Sleep "2"

  @SID_15
  Scenario:  Validate data after check Exclude Malicious IP Addresses and only HTTPS appears
    Then UI Validate the attribute "data-debug-checked" Of Label "Exclude Malicious IP Addresses Checkbox" is "EQUALS" to "false"
    Then UI Validate "Attacks Table" Table rows count EQUALS to 629
    Then UI Click Button "Exclude Malicious IP Addresses Checkbox"
    Then UI Validate the attribute "data-debug-checked" Of Label "Exclude Malicious IP Addresses Checkbox" is "EQUALS" to "true"
    Then UI Validate "Attacks Table" Table rows count EQUALS to 3
    Then UI Validate Table record values by columns with elementLabel "Attacks Table" findBy index 0
      | columnName      | value       |
      | Attack Category | HTTPS Flood |

    Then UI Validate Table record values by columns with elementLabel "Attacks Table" findBy index 1
      | columnName      | value       |
      | Attack Category | HTTPS Flood |



    #################### Exclude DP - Reports ####################################################

  @SID_16
  Scenario: Clean data System
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs


  @SID_17
  Scenario: Run DP simulator for ErtFeed_GeoFeed
    Given CLI simulate 1000 attacks of type "ErtFeed_GeoFeed" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds
    Then Sleep "30"


  @SID_18
  Scenario: Create and Generate New Report without Exclude Malicious IP Addresses
    Then UI Navigate to "AMS REPORTS" page via homepage
    Given UI "Create" Report With Name "Not Exclude DP Attacks"
      | Template | reportType:DefensePro Analytics,Widgets:[{ALL:[{Traffic Bandwidth:[pps,Inbound,All Policies]}]}], devices:[All], showTable:true |
      | Format   | Select: CSV                                                                                                                     |

    Then UI "Validate" Report With Name "Not Exclude DP Attacks"
      | Template | reportType:DefensePro Analytics,Widgets:[{ALL:[{Traffic Bandwidth:[pps,Inbound,All Policies]}]}], devices:[All], showTable:true, |
      | Format   | Select: CSV                                                                                                                      |


  @SID_19
  Scenario: Create and Generate New Report with Exclude Malicious IP Addresses
    Then UI Navigate to "AMS REPORTS" page via homepage
    Given UI "Create" Report With Name "Exclude DP Attacks"
      | Template | reportType:DefensePro Analytics,Widgets:[{ALL:[{Traffic Bandwidth:[pps,Inbound,All Policies]}]}], devices:[All], showTable:true, ExcludeMaliciousIPAddresses:true |
      | Format   | Select: CSV                                                                                                                                                       |

    Then UI "Validate" Report With Name "Exclude DP Attacks"
      | Template | reportType:DefensePro Analytics,Widgets:[{ALL:[{Traffic Bandwidth:[pps,Inbound,All Policies]}]}], devices:[All], showTable:true, ExcludeMaliciousIPAddresses:true |
      | Format   | Select: CSV                                                                                                                                                       |

    Then UI "Generate" Report With Name "Exclude DP Attacks"
      | timeOut | 60 |

  @SID_20
  Scenario: VRM report unzip local CSV file
    Then Sleep "10"
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then Sleep "10"


    ##############################  Validate Top Attacks CSV ####################################################

  @SID_21
  Scenario: VRM report validate CSV file TOP ATTACKS number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"


  @SID_22
  Scenario: VRM report validate CSV file TOP ATTACKS headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -1|grep name,ruleName,Count|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "name"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "ruleName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Count"


  @SID_23
  Scenario:VRM report validate CSV file TOP ATTACKS content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -2|tail -1|grep -oP "\"Danny Litani10\",policy1,1" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Danny Litani10""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacks-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

 ############################################       ATTACKS BY THREAT CATEGORY       ######################################################################

  @SID_24
  Scenario: VRM report validate CSV file ATTACKS BY THREAT CATEGORY number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_25
  Scenario: VRM report validate CSV file ATTACKS BY THREAT CATEGORY headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -1 |grep "name,ruleName,Count,category" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_26
  Scenario: VRM report validate CSV file ATTACKS BY THREAT CATEGORY content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2 |tail -1|grep -oP "\"Danny Litani10\",policy1,1,GeoFeed" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Danny Litani10""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Threat\ Category-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "GeoFeed"

############################################       TOP ATTACK DESTINATION       ###########################################################################
##attached bug DE66060
  @SID_27
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Destinations-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"


  @SID_28
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Destinations-DefensePro\ Analytics.csv|head -1 |grep "country,address,count,percent" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


    ##attached bug DE66060
  @SID_29
  Scenario: VRM report validate CSV file TOP ATTACK DESTINATION content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Destinations-DefensePro Analytics.csv"|head -3 |tail -1|grep -oP "--,2000::0002,1,50.0000"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Destinations-DefensePro Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "--"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Destinations-DefensePro Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2000::0002"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Destinations-DefensePro Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Destinations-DefensePro Analytics.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "50.0000"


    ############################################       TOP ATTACK SOURCES       ###############################################################################
  @SID_30
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_31
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv|head -1 |grep "country,address,count,percent" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_32
  Scenario: VRM report validate CSV file TOP ATTACK SOURCES content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attack Sources-DefensePro Analytics.csv"|head -2 |tail -1|grep -oP "Multiple,Multiple,2,100.0000" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Multiple"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Multiple"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attack\ Sources-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "100.0000"

    ############################################       ATTACK CATEGORIES BY BANDWIDTH       ###################################################################

  @SID_33
  Scenario: VRM report validate CSV file ATTACK CATEGORIES BY BANDWIDTH number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack Categories by Bandwidth-DefensePro Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_34
  Scenario: VRM report validate CSV file ATTACK CATEGORIES BY BANDWIDTH headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack Categories by Bandwidth-DefensePro Analytics.csv" |head -1 |grep "category,ruleName,packetBandwidth" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_35
  Scenario: VRM report validate CSV file ATTACK CATEGORIES BY BANDWIDTH content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attack Categories by Bandwidth-DefensePro Analytics.csv"|head -3 |tail -1|grep -oP "GeoFeed,policy1,633339"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attack\ Categories\ by\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "GeoFeed"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attack\ Categories\ by\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attack\ Categories\ by\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "633339"

############################################       ATTACK BY MITIGATION ACTION       ####################################################################

  @SID_36
  Scenario: VRM report validate CSV file ATTACK BY MITIGATION ACTION number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Mitigation Action-DefensePro Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_37
  Scenario: VRM report validate CSV file ATTACK BY MITIGATION ACTION headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Mitigation Action-DefensePro Analytics.csv"|head -1 |grep "name,actionType,ruleName,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_38
  Scenario: VRM report validate CSV file ATTACK BY MITIGATION ACTION content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Mitigation Action-DefensePro Analytics.csv"|head -2 |tail -1|grep -oP "\"Danny Litani10\",Challenge,policy1,1" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Mitigation\ Action-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Danny Litani10""
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Mitigation\ Action-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Challenge"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Mitigation\ Action-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Attacks\ by\ Mitigation\ Action-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


     ############################################       ATTACKS BY PROTECTION POLICY       ####################################################################

  @SID_39
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_40
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -1|grep "name,ruleName,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "name"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "ruleName"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Count"

  @SID_41
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -2|tail -1|grep -oP "\"Danny Litani10\",policy1,1" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Danny Litani10""
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Attacks by Protection Policy-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

############################################       Top Attacks by Duration      #############################################################

  @SID_42
  Scenario: VRM report validate CSV file Top Attacks by Duration number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_43
  Scenario: VRM report validate CSV file Top Attacks by Duration headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -1|grep "duration,name,ruleName,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "duration"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "name"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "ruleName"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Count"

  @SID_44
  Scenario: VRM report validate CSV file Top Attacks by Duration content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -2|tail -1|grep -oP "\"Danny Litani10\",policy1,1" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""5-10 min""
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Danny Litani10""
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Duration-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"


############################################       Top Attacks by Protocol      #############################################################
  @SID_45
  Scenario: VRM report validate CSV file Top Attacks by Protocol number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_46
  Scenario: VRM report validate CSV file Top Attacks by Protocol headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -1|grep "name,ruleName,protocol,Count" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "name"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "ruleName"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "protocol"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Count"

  @SID_47
  Scenario: VRM report validate CSV fileTop Attacks by Protocol content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -2|tail -1|grep -oP "\"Danny Litani10\",policy1,TCP,1" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Danny Litani10""
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "TCP"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Protocol-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

############################################       Top Attacks by Volume      #############################################################
  @SID_48
  Scenario: VRM report validate CSV file ATTACKS BY PROTECTION POLICY number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_49
  Scenario: VRM report validate CSV fileTop Attacks by Volume headers
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -1|grep "name,ruleName,packetBandwidth,packetCount" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "name"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "ruleName"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "packetBandwidth"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "packetCount"

  @SID_50
  Scenario: VRM report validate CSV file Top Attacks by Volume content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -2|tail -1|grep -oP "\"Danny Litani10\",policy1,633339,525126" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS ""Danny Litani10""
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policy1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "633339"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacks by Volume-DefensePro Analytics.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "525126"


  @SID_51
  Scenario: Delete Added Reports
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Delete Report With Name "Not Exclude DP Attacks"
    Then UI Delete Report With Name "Exclude DP Attacks"



  @SID_52
  Scenario: Logout and close browser
    Given UI logout and close browser