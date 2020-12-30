#@TC117962
@TC118805
Feature: HTTPS Flood CSV Report


  @SID_1
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    Given CLI Reset radware password
    * REST Delete ES index "dp-traffic-*"
    * REST Delete ES index "dp-https-stats-*"
    * REST Delete ES index "dp-https-rt-*"
    * REST Delete ES index "dp-five-*"




  @SID_2
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." with timeOut 240



  @SID_2
  Scenario: Clear Database and old reports on file-system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"


  @SID_2
  Scenario: Update Policies
    Given REST Login with user "radware" and password "radware"
    Then REST Update Policies for All DPs


  @SID_3
  Scenario:Login and Navigate to HTTPS Server Dashboard
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given Rest Add Policy "pol1" To DP "172.16.22.51" if Not Exist
    And Rest Add new Rule "https_servers_automation" in Profile "ProfileHttpsflood" to Policy "pol1" to DP "172.16.22.51"
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"deviceIp":"172.16.22.50"}},"script":{"source":"ctx._source.endTime='$(date +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"


  @SID_4
  Scenario: Run DP simulator PCAPs for "HTTPS attacks"
    Given CLI simulate 2 attacks of type "HTTPS" on "DefensePro" 11 with loopDelay 5000 and wait 60 seconds



  @SID_6
  Scenario: Navigate to AMS Reports
    And UI Navigate to "AMS Reports" page via homePage


  @SID_6
  Scenario:  Add Report with HTTPS template
    Given UI "Create" Report With Name "Report HTTPS template"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic],Servers:[test-DefensePro_172.16.22.51-pol1] |
      | Format                | Select: CSV                                                                                                                |
      | Time Definitions.Date | Quick:1H                                                                                                                    |
    Then UI "Validate" Report With Name "Report HTTPS template"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic],Servers:[test-DefensePro_172.16.22.51-pol1] |
      | Format                | Select: CSV                                                                                                                |
      | Time Definitions.Date | Quick:1H                                                                                                                    |


  @SID_7
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "Report HTTPS template"
    Then UI Click Button "Generate Report Manually" with value "Report HTTPS template"
    Then Sleep "35"



  @SID_9
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

    ############################################       TOP ATTACKS       ###################################################################################
  
  @SID_10
  Scenario: VRM report validate CSV file TOP ATTACKS number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Inbound\ Traffic-HTTPS\ Flood.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"

  
  @SID_11
  Scenario: VRM report validate CSV file TOP ATTACKS headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Inbound\ Traffic-HTTPS\ Flood.csv|head -1|grep timeStamp,shortTermBaseline.attackEdge,longTermBaseline.attackEdge,shortTermBaseline.requestsBaseline,longTermBaseline.requestsBaseline|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Inbound\ Traffic-HTTPS\ Flood.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Inbound\ Traffic-HTTPS\ Flood.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "shortTermBaseline.attackEdge"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Inbound\ Traffic-HTTPS\ Flood.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "longTermBaseline.attackEdge"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Inbound\ Traffic-HTTPS\ Flood.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "shortTermBaseline.requestsBaseline"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Inbound\ Traffic-HTTPS\ Flood.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "longTermBaseline.requestsBaseline"

    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Inbound\ Traffic-HTTPS\ Flood.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "21641.0"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Inbound\ Traffic-HTTPS\ Flood.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "7002.258"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Inbound\ Traffic-HTTPS\ Flood.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "17200.0"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Inbound\ Traffic-HTTPS\ Flood.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "5075.3"



#  @SID_44
#  Scenario: Cleanup
#    Then UI Delete Report With Name "DP Analytics csv"
#    Given UI logout and close browser
#    * CLI Check if logs contains
#      | logType | expression | isExpected   |
#      | ALL     | fatal      | NOT_EXPECTED |
