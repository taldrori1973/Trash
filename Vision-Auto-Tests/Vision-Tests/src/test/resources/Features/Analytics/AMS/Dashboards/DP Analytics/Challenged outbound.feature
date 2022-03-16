@TC125659
Feature: challengeIng outbound

  @SID_1
  Scenario: Clear data
    Given CLI Clear vision logs
    * CLI kill all simulator attacks on current vision
    Given CLI Reset radware password
    * REST Delete ES index "dp-*"

  @SID_2
  Scenario: attack challengeIng_inbound_test
    Then Sleep "10"
    Given CLI simulate 100 attacks of type "challenged_outbound_test" on "DefensePro" 13 with loopDelay 1500 and wait 120 seconds

       ############################## AMS Reports #################################

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
  Scenario: login and navigate to ams reports
    When UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "AMS REPORTS" page via homepage

  @SID_6
  Scenario: Create and Generate New Report trafficBandwidth report
    Given UI "Create" Report With Name "trafficBandwidth report"
      | Template              | reportType:DefensePro Analytics, Widgets:[{Traffic Bandwidth:[pps,Outbound,All Policies]}],devices:[{deviceIndex:13}] |
      | Time Definitions.Date | Quick:15m                                                                                                             |
      | Format                | Select: PDF                                                                                                           |
    Then UI "Validate" Report With Name "trafficBandwidth report"
      | Template | reportType:DefensePro Analytics,Widgets:[Traffic Bandwidth],devices:[{deviceIndex:13}] |
      | Format   | Select: PDF                                                                            |
    Then UI "Generate" Report With Name "trafficBandwidth report"
      | timeOut | 90 |

  @SID_7

  Scenario: edit format to HTML New Report trafficBandwidth report
    Given UI "Edit" Report With Name "trafficBandwidth report"
      | Format | Select:HTML |

    Then UI "Validate" Report With Name "trafficBandwidth report"
      | Template | reportType:DefensePro Analytics,Widgets:[Traffic Bandwidth],devices:[{deviceIndex:13}] |
      | Format   | Select: HTML                                                                           |
    Then UI "Generate" Report With Name "trafficBandwidth report"
      | timeOut | 90 |

  @SID_8

  Scenario: edit format to CSV New Report trafficBandwidth report
    Given UI "Edit" Report With Name "trafficBandwidth report"
      | Format | Select: CSV |

    Then UI "Validate" Report With Name "trafficBandwidth report"
      | Template | reportType:DefensePro Analytics,Widgets:[Traffic Bandwidth],devices:[{deviceIndex:13}] |
      | Format   | Select: CSV                                                                            |

    Then UI "Generate" Report With Name "trafficBandwidth report"
      | timeOut | 90 |

  @SID_9
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then Sleep "15"

  @SID_10
  Scenario: VRM report validate CSV file Traffic Bandwidth number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "60"


#  @SID_11
#  Scenario: VRM report validate CSV file Traffic Bandwidth headers
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -1|grep averageTrafficValue,deviceIp,averageDiscards,maxTrafficValue,policyName,maxDiscards|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "averageTrafficValue"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ BandwidthDefensePro\ Analytics.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "averageDiscards"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "maxTrafficValue"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "maxDiscards"
#
#
#  @SID_12
#  Scenario:VRM report validate CSV file Traffic Bandwidth content
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|grep -oP "83625.2814814814,10.185.2.85,0,83781,Policy_4993@000015-00005-0,0" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "83625.2814814814"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "10.185.2.85"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "83781"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Policy_4993@000015-00005-0"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "0"


  @SID_11
  Scenario: Delete Added Reports
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Delete Report With Name "trafficBandwidth report"
#
#    ######################### Monitoring dashboard #####################################
#
  @SID_12
  Scenario:navigate to DP monitoring
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @SID_13
  Scenario: check bps with inbound Monitoring
    Then Sleep "10"
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value | count | offset |
      | 0     | 55    | 3      |

    Then UI Validate Text field "max monitoring" EQUALS "0"
    Then UI Validate Text field "min monitoring" EQUALS "0"

  @SID_14
  Scenario: check bps with outbound Monitoring
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 83470.0 | 2     | 5      |

    Then UI Validate Text field "max monitoring" EQUALS "83.5 M"
    Then UI Validate Text field "min monitoring" EQUALS "0"

  @SID_15
  Scenario: check pps with inbound Monitoring
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value | count | offset |
      | 0     | 57    | 3      |
    Then UI Validate Text field "max monitoring" EQUALS "0.0"
    Then UI Validate Text field "min monitoring" EQUALS "0.0"

  @SID_16
  Scenario: check pps with outbound Monitoring
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 84151.0 | 2     | 5      |
    Then UI Validate Text field "max monitoring" EQUALS "84.17 K"
    Then UI Validate Text field "min monitoring" EQUALS "0.0"

  @SID_17
  Scenario: choose device from scope selection
    Given UI Click Button "Device Selection"
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Analytics,index:13 |

  @SID_18
  Scenario: check bps with inbound Monitoring policy
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value | count | offset |
      | 0     | 57    | 3      |

    Then UI Validate Text field "max monitoring" EQUALS "0"
    Then UI Validate Text field "min monitoring" EQUALS "0"

  @SID_19
  Scenario: check bps with outbound Monitoring policy
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 83470.0 | 2     | 5      |

    Then UI Validate Text field "max monitoring" EQUALS "83.5 M"
    Then UI Validate Text field "min monitoring" EQUALS "0"

  @SID_20
  Scenario: check pps with inbound Monitoring policy
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value | count | offset |
      | 0     | 56    | 3      |
    Then UI Validate Text field "max monitoring" EQUALS "0.0"
    Then UI Validate Text field "min monitoring" EQUALS "0.0"

  @SID_21
  Scenario: check pps with outbound Monitoring policy
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 84151.0 | 2     | 5      |
    Then UI Validate Text field "max monitoring" EQUALS "84.17 K"
    Then UI Validate Text field "min monitoring" EQUALS "0.0"

          ############# second drill of monitoring dashboard ###############

#  @SID_22
#  Scenario: choose the first row of downdrill
#    And  UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
#
#  @SID_23
#  Scenario: check bps with inbound second drill
#    Then UI Do Operation "Select" item "Policy Traffic Bandwidth.bps"
#    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Inbound"
#    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
#      | value | count | offset |
#      | 0     | 33    | 3      |
#
#    Then UI Validate Text field "max drillDown" EQUALS "0"
#    Then UI Validate Text field "min drillDown" EQUALS "0"
#
#  @SID_24
#  Scenario: check bps with outbound second drill
#    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Outbound"
#    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
#      | value   | count | offset |
#      | 83470.0 | 2     | 5      |
#
#    Then UI Validate Text field "max drillDown" EQUALS "83.5 M"
#    Then UI Validate Text field "min drillDown" EQUALS "83.42 M"
#
#  @SID_25
#  Scenario: check pps with inbound second drill
#    Then UI Do Operation "Select" item "Policy Traffic Bandwidth.pps"
#    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Inbound"
#    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
#      | value | count | offset |
#      | 0     | 33    | 3      |
#    Then UI Validate Text field "max drillDown" EQUALS "0.0"
#    Then UI Validate Text field "min drillDown" EQUALS "0.0"
#
#  @SID_26
#  Scenario: check pps with outbound second drill
#    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Outbound"
#    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
#      | value   | count | offset |
#      | 84151.0 | 2     | 5      |
#    Then UI Validate Text field "max drillDown" EQUALS "84.17 K"
#    Then UI Validate Text field "min drillDown" EQUALS "84.09 K"



    ########################### Attacks Dashboard ###############################

  @SID_22
  Scenario:  navigate to attacks dashboard
    And UI Navigate to "DefensePro Attacks" page via homePage


  @SID_23
  Scenario: validate one device bps + inbound attacks
    When UI Click Button "inboundSwitch"
    When UI Click Button "bpsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Challenged"
      | value | count | offset |
      | 0     | 56    | 3      |

    Then UI Validate Text field "max attacks" EQUALS "0"
    Then UI Validate Text field "min attacks" EQUALS "0"

  @SID_24
  Scenario: validate traffic bandwidth bps+outbound attacks
    When UI Click Button "outboundSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Challenged"
      | value   | count | offset |
      | 83470.0 | 2     | 5      |

    Then UI Validate Text field "max attacks" EQUALS "83.5 M"
    Then UI Validate Text field "min attacks" EQUALS "0"

  @SID_25
  Scenario: validate traffic bandwidth pps+inbound attacks
    When UI Click Button "inboundSwitch"
    When UI Click Button "ppsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Challenged"
      | value | count | offset |
      | 0     | 56    | 3      |
    Then UI Validate Text field "max attacks" EQUALS "0.0"
    Then UI Validate Text field "min attacks" EQUALS "0.0"

  @SID_26
  Scenario: validate traffic bandwidth pps+outbound attacks
    When UI Click Button "outboundSwitch"
    When UI Click Button "ppsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Challenged"
      | value   | count | offset |
      | 84151.0 | 2     | 5      |
    Then UI Validate Text field "max attacks" EQUALS "84.17 K"
    Then UI Validate Text field "min attacks" EQUALS "84.09 K"


  ############################### Analytics Dashboard ###################################

  @SID_27
  Scenario: Login and add widgets
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    Then UI Click Button "Widget Selection"
    Then UI Click Button "Widget Selection.Clear Dashboard"
    Then UI Click Button "Widget Selection.Remove All Confirm"
    Then UI Click Button "Traffic Bandwidth widget"
    Then UI Click Button "Widget Selection.Add Selected Widgets"
    Then UI Click Button "Widget Selection"
    Then Sleep "20"

  @SID_28
  Scenario: select all devices
    Given UI Click Button "Device Selection"
    Given UI Click Button "AllScopeSelection"
    Given UI Click Button "Device Selection.Save Filter"

  @SID_29
  Scenario: check bps with inbound Analytics
    Then UI Do Operation "Select" item "Traffic Bandwidth bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value | count | offset |
      | 0     | 56    | 3      |
    Then UI Validate Text field "max analytics" EQUALS "0"
    Then UI Validate Text field "min analytics" EQUALS "0"

  @SID_30
  Scenario: check bps with outbound Analytics
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value   | count | offset |
      | 83470.0 | 2     | 5      |

    Then UI Validate Text field "max analytics" EQUALS "83.5 M"
    Then UI Validate Text field "min analytics" EQUALS "0"

  @SID_31
  Scenario: check pps with inbound Analytics
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value | count | offset |
      | 0     | 56    | 3      |
    Then UI Validate Text field "max analytics" EQUALS "0.0"
    Then UI Validate Text field "min analytics" EQUALS "0.0"

  @SID_32
  Scenario: check pps with outbound Analytics
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value   | count | offset |
      | 84151.0 | 2     | 5      |
    Then UI Validate Text field "max analytics" EQUALS "84.2 K"
    Then UI Validate Text field "min analytics" EQUALS "0.0"

  @SID_33
  Scenario: choose device and policy from scope selection
    Given UI Click Button "Device Selection"
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Analytics,index:13 |

  @SID_34
  Scenario: check bps with inbound Analytics policy
    Then UI Do Operation "Select" item "Traffic Bandwidth bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value | count | offset |
      | 0     | 57    | 3      |
    Then UI Validate Text field "max analytics" EQUALS "0"
    Then UI Validate Text field "min analytics" EQUALS "0"

  @SID_35
  Scenario: check bps with outbound Analytics policy
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value   | count | offset |
      | 83470.0 | 2     | 5      |

    Then UI Validate Text field "max analytics" EQUALS "84.2 M"
    Then UI Validate Text field "min analytics" EQUALS "0"

  @SID_36
  Scenario: check pps with inbound Analytics policy
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value | count | offset |
      | 0     | 58    | 3      |
    Then UI Validate Text field "max analytics" EQUALS "0.0"
    Then UI Validate Text field "min analytics" EQUALS "0.0"

  @SID_37
  Scenario: check pps with outbound Analytics policy
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value   | count | offset |
      | 84151.0 | 2     | 5      |
    Then UI Validate Text field "max analytics" EQUALS "84.2 K"
    Then UI Validate Text field "min analytics" EQUALS "0.0"


  @SID_38
  Scenario: Logout and close browser
    * CLI kill all simulator attacks on current vision
    Given UI logout and close browser