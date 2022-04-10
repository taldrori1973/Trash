@TC125658
Feature: Challenged inbound

  @SID_1
  Scenario: Clear data
    Given CLI Clear vision logs
    * CLI kill all simulator attacks on current vision
    Given CLI Reset radware password
    * REST Delete ES index "dp-*"


  @SID_2
  Scenario: attack challengeIng_inbound_test
    Then Sleep "10"
    Given CLI simulate 100 attacks of type "challenged_inbound_test" on SetId "DefensePro_Set_13" with loopDelay 1500 and wait 120 seconds
    * CLI kill all simulator attacks on current vision

#    ######################### Monitoring dashboard #####################################

  @SID_3
  Scenario:  navigate to DP monitoring
    When UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @SID_4
  Scenario: check bps with inbound monitoring
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |

    Then UI Validate Text field "max monitoring" EQUALS "83.76 M" with offset 5
    Then UI Validate Text field "min monitoring" EQUALS "83.68 M" with offset 5

  @SID_5
  Scenario: check bps with outbound monitoring
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value | count | offset |
      | 0     | 0     | 0      |

    Then UI Validate Text field "max monitoring" EQUALS "0.0"
    Then UI Validate Text field "min monitoring" EQUALS "0.0"

  @SID_6
  Scenario: check pps with inbound monitoring
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 84407.0 | 1     | 5      |
    Then UI Validate Text field "max monitoring" EQUALS "84.43 K" with offset 5
    Then UI Validate Text field "min monitoring" EQUALS "84.35 K" with offset 5

  @SID_7

  Scenario: check pps with outbound monitoring
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value | count | offset |
      | 0     | 0     | 0      |
    Then UI Validate Text field "max monitoring" EQUALS "0.0"
    Then UI Validate Text field "min monitoring" EQUALS "0.0"

  @SID_8
  Scenario: choose device from scope selection
    Given UI Click Button "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | setId             | ports | policies |
      | DefensePro_Set_13 |       |          |
    Then Sleep "20"

  @SID_9
  Scenario: check bps with inbound monitoring device
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |

    Then UI Validate Text field "max monitoring" EQUALS "83.76 M" with offset 5
    Then UI Validate Text field "min monitoring" EQUALS "83.68 M" with offset 5

  @SID_10
  Scenario: check bps with outbound monitoring device
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value | count | offset |
      | 0     | 0     | 0      |
    Then UI Validate Text field "max monitoring" EQUALS "0.0"
    Then UI Validate Text field "min monitoring" EQUALS "0.0"

  @SID_11
  Scenario: check pps with inbound monitoring device
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 84407.0 | 1     | 5      |
    Then UI Validate Text field "max monitoring" EQUALS "84.43 K" with offset 5
    Then UI Validate Text field "min monitoring" EQUALS "84.35 K" with offset 5


          ############# second drill of monitoring dashboard ###############

  @SID_12
  Scenario: choose the first row of downdrill
    And  UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0

  @SID_13
  Scenario: check bps with inbound second drill
    Then UI Do Operation "Select" item "Policy Traffic Bandwidth bps"
    And UI Do Operation "Select" item "Policy Traffic Bandwidth inbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |

    Then UI Validate Text field "max drillDown" EQUALS "83.7 M" with offset 5
    Then UI Validate Text field "min drillDown" EQUALS "83.7 M" with offset 5


  @SID_14
  Scenario: check pps with inbound second drill
    Then UI Do Operation "Select" item "Policy Traffic Bandwidth pps"
    And UI Do Operation "Select" item "Policy Traffic Bandwidth inbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 84407.0 | 1     | 5      |
    Then UI Validate Text field "max drillDown" EQUALS "84.4 K" with offset 5
    Then UI Validate Text field "min drillDown" EQUALS "84.3 K" with offset 5
    ############################## AMS Reports #################################

  @SID_15
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
#    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
#    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
#    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." Retry 240 seconds

    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/storage/dc_config/kvision-reporter/config/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Service "config_kvision-reporter_1" do action RESTART
    Then CLI Validate service "CONFIG_KVISION_REPORTER" is up with timeout "45" minutes

  @SID_16
  Scenario: Clear old reports on file-system
    Then Sleep "10"
    Then CLI Run remote linux Command "docker exec -it config_kvision-reporter_1 sh -c "rm /usr/local/tomcat/VRM_report*"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"

  @SID_17
  Scenario: login and navigate to ams reports

    Then UI Navigate to "AMS REPORTS" page via homepage

  @SID_18
  Scenario: Create and Generate New Report trafficBandwidth report
    Given UI "Create" Report With Name "trafficBandwidth report"
      | Template              | reportType:DefensePro Analytics, Widgets:[Traffic Bandwidth], devices:[{SetId:DefensePro_Set_13}] |
      | Time Definitions.Date | Quick:15m                                                                                         |
      | Format                | Select: PDF                                                                                       |
    Then UI "Validate" Report With Name "trafficBandwidth report"
      | Template | reportType:DefensePro Analytics, Widgets:[Traffic Bandwidth], devices:[{SetId:DefensePro_Set_13}] |
      | Format   | Select: PDF                                                                                       |
    Then UI "Generate" Report With Name "trafficBandwidth report"
      | timeOut | 90 |

  @SID_19

  Scenario: edit format to HTML New Report trafficBandwidth report
    Given UI "Edit" Report With Name "trafficBandwidth report"
      | Format | Select:HTML |

    Then UI "Validate" Report With Name "trafficBandwidth report"
      | Template | reportType:DefensePro Analytics, Widgets:[Traffic Bandwidth], devices:[{SetId:DefensePro_Set_13}] |
      | Format   | Select: HTML                                                                                        |

    Then UI "Generate" Report With Name "trafficBandwidth report"
      | timeOut | 90 |

  @SID_20

  Scenario: edit format to CSV New Report trafficBandwidth report
    Given UI "Edit" Report With Name "trafficBandwidth report"
      | Format | Select: CSV |

    Then UI "Validate" Report With Name "trafficBandwidth report"
      | Template | reportType:DefensePro Analytics,Widgets:[Traffic Bandwidth],devices:[{SetId:DefensePro_Set_13}] |
      | Format   | Select: CSV                                                                                     |

    Then UI "Generate" Report With Name "trafficBandwidth report"
      | timeOut | 90 |

  @SID_21
  Scenario: VRM report unzip local CSV file
    Then CLI Copy files contains name "VRM_report_.*.zip" from container "config_kvision-reporter_1" from path "/usr/local/tomcat" to path "/opt/radware/mgt-server/third-party/tomcat/bin/"
#    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then Sleep "10"

  @SID_22
  Scenario: VRM report validate CSV file Traffic Bandwidth number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "61"

#
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


  @SID_23
  Scenario: Delete Added Reports
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Delete Report With Name "trafficBandwidth report"




    ########################### Attacks Dashboard ###############################
  @SID_24
  Scenario: navigate dp attacks
    And UI Navigate to "DefensePro Attacks" page via homePage
    Then Sleep "5"
#    Then UI Click Button "Accessibility Button"
#    Then UI Click Button "Stop AutoRefresh"
#    Then UI Click Button "Close Accessibility"


  @SID_25
  Scenario: validate one device bps + inbound Attacks
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1H"
    When UI Click Button "inboundSwitch"
    When UI Click Button "bpsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Challenged"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |

    Then UI Validate Text field "max attacks" EQUALS "83.76 M" with offset 5
    Then UI Validate Text field "min attacks" EQUALS "83.68 M" with offset 5

  @SID_26
  Scenario: validate traffic bandwidth bps+outbound Attacks
    When UI Click Button "outboundSwitch"

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Challenged"
      | value | count | offset |
      | 0     | 0     | 0      |
    Then UI Validate Text field "max attacks" EQUALS "0.0"
    Then UI Validate Text field "min attacks" EQUALS "0.0"

  @SID_27
  Scenario: validate traffic bandwidth pps+inbound Attacks
    When UI Click Button "inboundSwitch"
    When UI Click Button "ppsSwitch"

    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 84407.0 | 1     | 5      |
    Then UI Validate Text field "max attacks" EQUALS "84.43 K" with offset 5
    Then UI Validate Text field "min attacks" EQUALS "84.35 K" with offset 5

  @SID_28
  Scenario: validate traffic bandwidth pps+outbound Attacks
    When UI Click Button "outboundSwitch"
    When UI Click Button "ppsSwitch"

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Challenged"
      | value | count | offset |
      | 0     | 0     | 0      |

    Then UI Validate Text field "max attacks" EQUALS "0.0"
    Then UI Validate Text field "min attacks" EQUALS "0.0"



  ############################### Analytics Dashboard ###################################

  @SID_29
  Scenario: analytics dashboard
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    Then UI Click Button "Widget Selection"
    Then UI Click Button "Widget Selection.Clear Dashboard"
    Then UI Click Button "Widget Selection.Remove All Confirm"
    Then UI Click Button "Traffic Bandwidth widget"
    Then UI Click Button "Widget Selection.Add Selected Widgets"
    Then UI Click Button "Widget Selection"
    Then Sleep "30"

  @SID_30
  Scenario: select all devices
    Given UI Click Button "Device Selection"
    Given UI Click Button "AllScopeSelection"
    Given UI Click Button "Device Selection.Save Filter"

  @SID_31
  Scenario: check bps with inbound Analytics
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1H"
    Then UI Do Operation "Select" item "Traffic Bandwidth bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |

    Then UI Validate Text field "max analytics" EQUALS "83.8 M" with offset 5
    Then UI Validate Text field "min analytics" EQUALS "83.7 M" with offset 5

  @SID_32
  Scenario: check bps with outbound Analytics
    Then UI Do Operation "Select" item "Traffic Bandwidth bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value | count | offset |
      | 0     | 0     | 0      |

    Then UI Validate Text field "max analytics" EQUALS "0.0"
    Then UI Validate Text field "min analytics" EQUALS "0.0"

  @SID_33
  Scenario: check pps with inbound Analytics
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value   | count | offset |
      | 84407.0 | 1     | 5      |
    Then UI Validate Text field "max analytics" EQUALS "84.4 K" with offset 5
    Then UI Validate Text field "min analytics" EQUALS "84.4 K" with offset 5

  @SID_34
  Scenario: check pps with outbound Analytics
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value | count | offset |
      | 0     | 0     | 0      |
    Then UI Validate Text field "max analytics" EQUALS "0.0"
    Then UI Validate Text field "min analytics" EQUALS "0.0"

  @SID_35
  Scenario: choose device and policy from scope selection analytics
    Given UI Click Button "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | setId             | ports | policies |
      | DefensePro_Set_13 |       |          |

  @SID_36
  Scenario: check bps with inbound Analytics policy
    Then UI Do Operation "Select" item "Traffic Bandwidth bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |

    Then UI Validate Text field "max analytics" EQUALS "83.8 M" with offset 5
    Then UI Validate Text field "min analytics" EQUALS "83.7 M" with offset 5

  @SID_37
  Scenario: check bps with outbound Analytics policy
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value | count | offset |
      | 0     | 0     | 0      |

    Then UI Validate Text field "max analytics" EQUALS "0.0" with offset 5
    Then UI Validate Text field "min analytics" EQUALS "0.0"

  @SID_38
  Scenario: check pps with inbound Analytics policy
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value   | count | offset |
      | 84407.0 | 1     | 5      |
    Then UI Validate Text field "max analytics" EQUALS "84.4 K" with offset 5
    Then UI Validate Text field "min analytics" EQUALS "84.4 K" with offset 5

  @SID_39
  Scenario: check pps with outbound Analytics policy
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value | count | offset |
      | 0     | 0     | 0      |
    Then UI Validate Text field "max analytics" EQUALS "0.0"
    Then UI Validate Text field "min analytics" EQUALS "0.0"


  @SID_40
  Scenario: Logout and close browser
    * CLI kill all simulator attacks on current vision
    Given UI logout and close browser