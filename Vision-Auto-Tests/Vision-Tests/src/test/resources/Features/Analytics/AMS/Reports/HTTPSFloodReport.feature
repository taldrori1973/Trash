@TC108556
Feature: HTTPS Flood Report

#  ==========================================Setup================================================
  @SID_1
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-traffic-*"
    * REST Delete ES index "dp-https-stats-*"
    * REST Delete ES index "dp-https-rt-*"
    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "vrm-scheduled-report-*"

  @SID_2
  Scenario: Update Policies
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given REST Login with user "radware" and password "radware"
    Then REST Update Policies for All DPs


  @SID_3
  Scenario: Copy and run add https server script
    Then CLI copy "/home/radware/Scripts/add_https_server.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then CLI Run remote linux Command "/add_https_server.sh 172.16.22.51 pol1 test 1.1.1.2" on "ROOT_SERVER_CLI"


  @SID_4
  Scenario:Login and Navigate to HTTPS Flood Dashboard
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "AMS Reports" page via homePage
    Then UI Validate Element Existence By Label "Add New" if Exists "true"


  @SID_5
  Scenario: Run DP simulator PCAPs for "HTTPS attacks"
    Given CLI simulate 1 attacks of type "HTTPS" on "DefensePro" 11 with loopDelay 15000 and wait 60 seconds


# =============================================Create Reports===========================================================
#    Default is Inbound Traffic only
  @SID_6
  Scenario: Create New Report with With Default Values
    When UI "Create" Report With Name "HTTPS Flood Default"
      | reportType | HTTPS Flood                                                        |
      | policy     | serverName:test,deviceName:DefensePro_172.16.22.51,policyName:pol1 |
    Then UI Validate Element Existence By Label "Title" if Exists "true" with value "HTTPS Flood Default"
    Then UI "Validate" Report With Name "HTTPS Flood Default"
      | Design                | Widgets:[Inbound Traffic]                                          |
      | Time Definitions.Date | Quick:1H                                                           |
      | policy                | serverName:test,deviceName:DefensePro_172.16.22.51,policyName:pol1 |
      | Format                | Select: PDF                                                        |

  @SID_7
  Scenario: Create New Report with Inbound Traffic Template With Default Values
    Then UI "Create" Report With Name "Inbound Traffic with Default Values"
      | reportType | HTTPS Flood                                                        |
      | Design     | Add:[Inbound Traffic]                                              |
      | policy     | serverName:test,deviceName:DefensePro_172.16.22.51,policyName:pol1 |
    Then UI Validate Element Existence By Label "Title" if Exists "true" with value "Inbound Traffic with Default Values"
    Then UI "Validate" Report With Name "Inbound Traffic with Default Values"
      | Design                | Widgets:[Inbound Traffic]                                          |
      | Time Definitions.Date | Quick:1H                                                           |
      | policy                | serverName:test,deviceName:DefensePro_172.16.22.51,policyName:pol1 |
      | Format                | Select: PDF                                                        |

  @SID_8

  Scenario: Create New Report with Outbound Traffic Template With Default Values
      #TODO when DP supports outbound
#    Then UI "Create" Report With Name "Outbound Traffic with Default Values"
#      | reportType | HTTPS Flood                                                        |
#      | Design     | Add:[Outbound Traffic]                                             |
#      | policy     | serverName:test,deviceName:DefensePro_172.16.22.51,policyName:pol1 |
#    Then UI Validate Element Existence By Label "Title" if Exists "true" with value "Outbound Traffic with Default Values"
#    Then UI "Validate" Report With Name "Outbound Traffic with Default Values"
#      | Design                | Widgets:[Outbound Traffic]                                         |
#      | Time Definitions.Date | Quick:1H                                                           |
#      | policy                | serverName:test,deviceName:DefensePro_172.16.22.51,policyName:pol1 |
#      | Format                | Select: PDF                                                        |

  @SID_9
  Scenario: Create New Report with Inbound and Outbound Traffic Template With Default Values
      #TODO when DP supports outbound
#    Then UI "Create" Report With Name "Inbound and Outbound Traffic with Default Values"
#      | reportType | HTTPS Flood                                                        |
#      | Design     | Add:[Inbound Traffic,Outbound Traffic]                             |
#      | policy     | serverName:test,deviceName:DefensePro_172.16.22.51,policyName:pol1 |
#    Then UI Validate Element Existence By Label "Title" if Exists "true" with value "Inbound and Outbound Traffic with Default Values"
#    Then UI "Validate" Report With Name "Inbound and Outbound Traffic with Default Values"
#      | Design                | Widgets:[Inbound Traffic,Outbound Traffic]                         |
#      | Time Definitions.Date | Quick:1H                                                           |
#      | policy                | serverName:test,deviceName:DefensePro_172.16.22.51,policyName:pol1 |
#      | Format                | Select: PDF                                                        |

  @SID_10
  Scenario: Create New Report with With HTML Format
    Then UI "Create" Report With Name "HTML Format"
      | reportType | HTTPS Flood                                                        |
      | Design     | Add:[Inbound Traffic]                                              |
      | policy     | serverName:test,deviceName:DefensePro_172.16.22.51,policyName:pol1 |
      | Format     | Select: HTML                                                       |
    Then UI Validate Element Existence By Label "Title" if Exists "true" with value "HTML Format"
    Then UI "Validate" Report With Name "HTML Format"
      | Design                | Widgets:[Inbound Traffic]                                          |
      | Time Definitions.Date | Quick:1H                                                           |
      | policy                | serverName:test,deviceName:DefensePro_172.16.22.51,policyName:pol1 |
      | Format                | Select: HTML                                                       |

  @SID_11
  Scenario: Create New Report with With CSV Format
    Then UI "Create" Report With Name "CSV Format"
      | reportType | HTTPS Flood                                                        |
      | Design     | Add:[Inbound Traffic]                                              |
      | policy     | serverName:test,deviceName:DefensePro_172.16.22.51,policyName:pol1 |
      | Format     | Select: CSV                                                        |
    Then UI Validate Element Existence By Label "Title" if Exists "true" with value "CSV Format"
    Then UI "Validate" Report With Name "CSV Format"
      | Design                | Widgets:[Inbound Traffic]                                          |
      | Time Definitions.Date | Quick:1H                                                           |
      | policy                | serverName:test,deviceName:DefensePro_172.16.22.51,policyName:pol1 |
      | Format                | Select: CSV                                                        |


# =============================================Generate Reports===========================================================

  @SID_12
  Scenario: Generate Reports
    #TODO when DP supports outbound
    Then UI Generate and Validate Report With Name "HTTPS Flood Default" with Timeout of 300 Seconds
    Then UI Generate and Validate Report With Name "Inbound Traffic with Default Values" with Timeout of 300 Seconds
#    Then UI Generate and Validate Report With Name "Outbound Traffic with Default Values" with Timeout of 300 Seconds
#    Then UI Generate and Validate Report With Name "Inbound and Outbound Traffic with Default Values" with Timeout of 300 Seconds
    Then UI Generate and Validate Report With Name "HTML Format" with Timeout of 300 Seconds


  @SID_13
  Scenario: Activate Keep Reports Copy on File System Flag and Clear old Reports
    Then CLI Activate Keep Reports Copy on File System Flag with Timeout 720 Seconds Then Sleep 120 Seconds
    Then CLI Clear Old Reports on File System

  @SID_14
  Scenario: Generate CSV Report and Unzip it
    Then UI Generate and Validate Report With Name "CSV Format" with Timeout of 300 Seconds
    Then CLI UnZIP Local Report ZIP File to CSV Files

  @SID_15
  Scenario: Validate Inbound Traffic - Request Per Second
    Then CSV Read CSV File "Request_per Second.csv"
      | tableName | header                                                                                                                                  |
      | table1    | timeStamp,rtRate.full,rtRate.partial                                                                                                    |
      | table2    | timeStamp,shortTermBaseline.attackEdge,longTermBaseline.attackEdge,shortTermBaseline.requestsBaseline,longTermBaseline.requestsBaseline |

    Then CSV Validate "table1" Table Size Equals to 1
    And Sleep "3"
    Then CSV Validate "table2" Table Size Equals to 1

    Then CSV Validate Row Number 0 at "table1" Table Equals to ".*,25060.0,17500.0" Regex
    And Sleep "3"
    Then CSV Validate Row Number 0 at "table2" Table Equals to ".*,21641.0,7002.258,17200.0,5075.3" Regex

  @SID_16
  Scenario: Validate Inbound Traffic - Request Size Distribution
    Then CSV Read CSV File "Request-Size_Distribution.csv"
      | tableName | header                                                                                                       |
      | table1    | upperBound,rtSizeDistributionBin.fullProbability,rtSizeDistributionBin.partialProbability                    |
      | table2    | upperBound,sizeDistributionBaselineBin.attackEdgeProbability,sizeDistributionBaselineBin.baselineProbability |

    Then CSV Validate "table1" Table Size Equals to 50
    Then CSV Validate "table2" Table Size Equals to 50

    Then CSV Validate Row Number 0 at "table1" Table Equals to "00100,0.0,0.0" Regex
    Then CSV Validate Row Number 49 at "table1" Table Equals to "16383,0.5,0.0" Regex


    Then CSV Validate Row Number 0 at "table2" Table Equals to "00100,0.0,0.0" Regex
    Then CSV Validate Row Number 49 at "table2" Table Equals to "16383,0.0,0.0" Regex

    Then CSV Validate Column "upperBound" at "table1" Table is Sorted "NUMERICAL"
    Then CSV Validate Column "upperBound" at "table2" Table is Sorted "NUMERICAL"

    Then CSV Validate Value Frequency Under "rtSizeDistributionBin.fullProbability" Column at "table1" Table
      | 0.0        | 46 |
      | 0.23451911 | 1  |
      | 0.214519   | 1  |
      | 0.81       | 1  |
      | 0.5        | 1  |
    Then CSV Validate Value Frequency Under "rtSizeDistributionBin.partialProbability" Column at "table1" Table
      | 0.0        | 48 |
      | 0.23451911 | 1  |
      | 0.7654809  | 1  |
    Then CSV Validate Value Frequency Under "sizeDistributionBaselineBin.attackEdgeProbability" Column at "table2" Table
      | 0.0        | 48 |
      | 1.0        | 1  |
      | 0.47802296 | 1  |
    Then CSV Validate Value Frequency Under "sizeDistributionBaselineBin.baselineProbability" Column at "table2" Table
      | 0.0         | 47 |
      | 0.97232455  | 1  |
      | 0.027675444 | 1  |
      | 0.77        | 1  |


  @SID_17
  Scenario: Validate Outbound Traffic - Response Bandwidth
    #TODO when DP supports outbound
#    Then CSV Read CSV File "Response_Bandwidth.csv"
#      | tableName | header                                                                                                                                                                                                                  |
#      | table1    | timeStamp,outboundBaseline.bandwidthShortAttackEdge,monitoringDataCategory,outboundBaseline.bandwidthLongAttackEdge,outboundBaseline.bandwidthShortBaseline,outboundBaseline.bandwidthLongBaseline,rtOutbound.bandwidth |

#    Then CSV Validate "table1" Table Size Equals to 2
#
#    Then CSV Validate Row Number 0 at "table1" Table Equals to "\d{13},15120.576985000002,BaselineOutbound,240.82397,10070.6284,140.9568,NaN" Regex
#    Then CSV Validate Row Number 1 at "table1" Table Equals to "\d{13},NaN,RealTimeOutbound,NaN,NaN,NaN,6379.5" Regex

  @SID_18
  Scenario: Validate Outbound Traffic - Average Response Size
        #TODO when DP supports outbound
#    Then CSV Read CSV File "Average_Response Size.csv"
#      | tableName | header                                                                                                                                 |
#      | table1    | timeStamp,rtOutbound.responseSize,monitoringDataCategory,outboundBaseline.responseSizeAttackEdge,outboundBaseline.responseSizeBaseline |

#    Then CSV Validate "table1" Table Size Equals to 2
#
#    Then CSV Validate Row Number 0 at "table1" Table Equals to "\d{13},NaN,BaselineOutbound,5620.761985,370.47839999999997" Regex
#    Then CSV Validate Row Number 1 at "table1" Table Equals to "\d{13},6129.5,RealTimeOutbound,NaN,NaN" Regex


  @SID_19
  Scenario: cleanup and check logs
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal        | NOT_EXPECTED |
    * UI logout and close browser
    * CLI kill all simulator attacks on current vision
