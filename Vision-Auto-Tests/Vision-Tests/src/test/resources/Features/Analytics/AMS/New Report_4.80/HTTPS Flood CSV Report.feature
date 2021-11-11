@TC118805
Feature: HTTPS Flood CSV Report


  @SID_1
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    Given CLI Reset radware password
    * REST Delete ES index "dp-*"
    Given CLI Run remote linux Command "service vision restart" on "ROOT_SERVER_CLI" and halt 185 seconds

  @SID_2
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/storage/dc_config/kvision-reporter/config/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Service "config_kvision-collector_1" do action RESTART
    Then CLI Validate service "CONFIG_KVISION_COLLECTOR" is up with timeout "45" minutes



  @SID_3
  Scenario: Clear Database and old reports on file-system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"


  @SID_4
  Scenario: Update Policies
    Given REST Login with user "radware" and password "radware"
    Then REST Update Policies for All DPs


  @SID_5
  Scenario:Login and Navigate to HTTPS Server Dashboard
    Then UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given Rest Add Policy "pol1" To DP "172.16.22.51" if Not Exist
    And Rest Add new Rule "https_servers_automation" in Profile "ProfileHttpsflood" to Policy "pol1" to DP "172.16.22.51"
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"deviceIp":"172.16.22.50"}},"script":{"source":"ctx._source.endTime='$(date +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"


  @SID_6
  Scenario: Run DP simulator PCAPs for "HTTPS attacks"
    Given CLI simulate 2 attacks of type "HTTPS" on SetId "DefensePro_Set_2" with loopDelay 5000 and wait 60 seconds



  @SID_7
  Scenario: Navigate to AMS Reports
    And UI Navigate to "AMS Reports" page via homePage


  @SID_8
  Scenario:  Add Report with HTTPS template
    Given UI "Create" Report With Name "Report HTTPS template"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic],Servers:[test-DefensePro_172.16.22.51-pol1] |
      | Format                | Select: CSV                                                                                                                |
      | Time Definitions.Date | Quick:1H                                                                                                                    |
    Then UI "Validate" Report With Name "Report HTTPS template"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic],Servers:[test-DefensePro_172.16.22.51-pol1] |
      | Format                | Select: CSV                                                                                                                |
      | Time Definitions.Date | Quick:1H                                                                                                                    |


  @SID_9
  Scenario: Validate delivery card and generate report

    Then UI "Generate" Report With Name "Report HTTPS template"
      | timeOut | 60 |


  @SID_10
  Scenario: VRM report unzip local CSV file
    Then CLI Copy files contains name "VRM_report_*.zip" from container "config_kvision-reporter_1" from path "/usr/local/tomcat" to path "/opt/radware/mgt-server/third-party/tomcat/bin/"
    Then CLI Run linux Command "ls /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

    ############################################       TOP ATTACKS       ###################################################################################
  
#  @SID_11
#  Scenario: VRM report validate CSV file TOP ATTACKS number of lines
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Request\ Per\ Second-HTTPS\ Flood.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "3"
#
#
#  @SID_12
#  Scenario: VRM report validate CSV file TOP ATTACKS headers
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Request\ Per\ Second-HTTPS\ Flood.csv|head -1|grep timeStamp,shortTermBaseline.attackEdge,longTermBaseline.attackEdge,shortTermBaseline.requestsBaseline,longTermBaseline.requestsBaseline|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Request\ Per\ Second-HTTPS\ Flood.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "timeStamp"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Request\ Per\ Second-HTTPS\ Flood.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "shortTermBaseline.attackEdge"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Request\ Per\ Second-HTTPS\ Flood.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "longTermBaseline.attackEdge"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Request\ Per\ Second-HTTPS\ Flood.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "shortTermBaseline.requestsBaseline"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Request\ Per\ Second-HTTPS\ Flood.csv|head -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "longTermBaseline.requestsBaseline"
#
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Request\ Per\ Second-HTTPS\ Flood.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "21641.0"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Request\ Per\ Second-HTTPS\ Flood.csv|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "7002.258"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Request\ Per\ Second-HTTPS\ Flood.csv|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "17200.0"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Request\ Per\ Second-HTTPS\ Flood.csv|head -2|tail -1|awk -F "," '{printf $6}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "5075.3"
#

#  @SID_13
#  Scenario: Validate Inbound Traffic - Request Size Distribution
#    Then CSV Read CSV File "Request-Size\ Distribution-HTTPS\ Flood.csv"
#      | tableName | header                                                                                                       |
#      | table1    | upperBound,rtSizeDistributionBin.fullProbability,rtSizeDistributionBin.partialProbability                    |
#      | table2    | upperBound,sizeDistributionBaselineBin.attackEdgeProbability,sizeDistributionBaselineBin.baselineProbability |
#
#    Then CSV Validate "table1" Table Size Equals to 50
#    Then CSV Validate "table2" Table Size Equals to 50
#
#    Then CSV Validate Row Number 0 at "table1" Table Equals to "00100,0.0,0.0" Regex
#    Then CSV Validate Row Number 49 at "table1" Table Equals to "16383,0.5,0.0" Regex
#
#
#    Then CSV Validate Row Number 0 at "table2" Table Equals to "00100,0.0,0.0" Regex
#    Then CSV Validate Row Number 49 at "table2" Table Equals to "16383,0.0,0.0" Regex
#
#    Then CSV Validate Column "upperBound" at "table1" Table is Sorted "NUMERICAL"
#    Then CSV Validate Column "upperBound" at "table2" Table is Sorted "NUMERICAL"
#
#    Then CSV Validate Value Frequency Under "rtSizeDistributionBin.fullProbability" Column at "table1" Table
#      | 0.0        | 46 |
#      | 0.23451911 | 1  |
#      | 0.214519   | 1  |
#      | 0.81       | 1  |
#      | 0.5        | 1  |
#    Then CSV Validate Value Frequency Under "rtSizeDistributionBin.partialProbability" Column at "table1" Table
#      | 0.0        | 48 |
#      | 0.23451911 | 1  |
#      | 0.7654809  | 1  |
#    Then CSV Validate Value Frequency Under "sizeDistributionBaselineBin.attackEdgeProbability" Column at "table2" Table
#      | 0.0        | 48 |
#      | 1.0        | 1  |
#      | 0.47802296 | 1  |
#    Then CSV Validate Value Frequency Under "sizeDistributionBaselineBin.baselineProbability" Column at "table2" Table
#      | 0.0         | 47 |
#      | 0.97232455  | 1  |
#      | 0.027675444 | 1  |
#      | 0.77        | 1  |

#  @SID_14
#  Scenario: Cleanup
#    Then UI Delete Report With Name "DP Analytics csv"
#    Given UI logout and close browser
#    * CLI Check if logs contains
#      | logType | expression | isExpected   |
#      | ALL     | fatal      | NOT_EXPECTED |

  @SID_15
  Scenario: Cleanup
    Then UI Delete Report With Name "Report HTTPS template"
    And UI logout and close browser