@TC125658
Feature: Challenged inbound

  
  @SID_1
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    Given CLI Reset radware password
    * REST Delete ES index "dp-*"

    
  @SID_2
  Scenario: attack challenged_inbound_test
    Given CLI simulate 100 attacks of type "challenged_inbound_test" on "DefensePro" 13 with loopDelay 1500 and wait 120 seconds
    Then Sleep "15"
    * CLI kill all simulator attacks on current vision

#    ######################### Monitoring dashboard #####################################
  
  @SID_3
  Scenario: Login and navigate to DP monitoring
    When UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
  
  @SID_4
  Scenario: check bps with inbound
    Then Sleep "120"
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |

    Then UI Validate Text field "max monitoring" EQUALS "83.74 M" with offset 5
    Then UI Validate Text field "min monitoring" EQUALS "0"

  @SID_5
  Scenario: check bps with outbound
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value | count | offset |
      | 0     | 0     | 0      |

    Then UI Validate Text field "max monitoring" EQUALS "0.0"
    Then UI Validate Text field "min monitoring" EQUALS "0.0"

  @SID_6
  Scenario: check pps with inbound
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 84407.0 | 1     | 5      |
    Then UI Validate Text field "max monitoring" EQUALS "84.42 K" with offset 5
    Then UI Validate Text field "min monitoring" EQUALS "0.0"

  @SID_7
  Scenario: check pps with outbound
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value | count | offset |
      | 0     | 0     | 0      |
    Then UI Validate Text field "max monitoring" EQUALS "0.0"
    Then UI Validate Text field "min monitoring" EQUALS "0.0"

  @SID_8
  Scenario: choose device and policy from scope selection
    Given UI Click Button "Device Selection"
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Analytics,index:22,policies:[Policy_4993@000010-00005-0] |

  @SID_9
  Scenario: check bps with inbound
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |

    Then UI Validate Text field "max monitoring" EQUALS "83.74 M" with offset 5
    Then UI Validate Text field "min monitoring" EQUALS "0"

  @SID_10
  Scenario: check bps with outbound
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value | count | offset |
      | 0     | 0     | 0      |
    Then UI Validate Text field "max monitoring" EQUALS "0.0"
    Then UI Validate Text field "min monitoring" EQUALS "0.0"

  @SID_11
  Scenario: check pps with inbound
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 84407.0 | 1     | 5      |
    Then UI Validate Text field "max monitoring" EQUALS "84.42 K" with offset 5
    Then UI Validate Text field "min monitoring" EQUALS "0.0"

  @SID_12
  Scenario: check pps with outbound
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value | count | offset |
      | 0     | 0     | 0      |
    Then UI Validate Text field "max monitoring" EQUALS "0.0"
    Then UI Validate Text field "min monitoring" EQUALS "0.0"

          ############# second drill of monitoring dashboard ###############

  @SID_13
  Scenario: choose the first row of downdrill
    And  UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Protections Table" findBy index 0
      | columnName      | value                      |
      | Protection Name | Policy_4993@000015-00005-0 |
      | Attack Rate     | 40.51 Mbps                 |
      | Drop Rate       | 0 Mbps                     |

  @SID_14
  Scenario: check bps with inbound
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |

    Then UI Validate Text field "max monitoring" EQUALS "83.74 M" with offset 5
    Then UI Validate Text field "min monitoring" EQUALS "0"

  @SID_15
  Scenario: check bps with outbound
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value | count | offset |
      | 0     | 0     | 0      |
    Then UI Validate Text field "max monitoring" EQUALS "0.0"
    Then UI Validate Text field "min monitoring" EQUALS "0.0"

  @SID_16
  Scenario: check pps with inbound
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 84407.0 | 1     | 5      |
    Then UI Validate Text field "max monitoring" EQUALS "84.42 K" with offset 5
    Then UI Validate Text field "min monitoring" EQUALS "0.0"

  @SID_17
  Scenario: check pps with outbound
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value | count | offset |
      | 0     | 0     | 0      |
    Then UI Validate Text field "max monitoring" EQUALS "0.0"
    Then UI Validate Text field "min monitoring" EQUALS "0.0"



    ########################### Attacks Dashboard ###############################
  @SID_18
  Scenario: navigate dp attacks
    And UI Navigate to "DefensePro Attacks" page via homePage


  @SID_19
  Scenario: validate one device bps + inbound
    When UI Click Button "inboundSwitch"
    When UI Click Button "bpsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Challenged"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |

    Then UI Validate Text field "max attacks" EQUALS "83.74 M" with offset 5
    Then UI Validate Text field "min attacks" EQUALS "0"

  @SID_20
  Scenario: validate traffic bandwidth bps+outbound
    When UI Click Button "outboundSwitch"

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Challenged"
      | value | min |
      | 0     | 5   |
    Then UI Validate Text field "max attacks" EQUALS "0.0"
    Then UI Validate Text field "min attacks" EQUALS "0.0"

  @SID_21
  Scenario: validate traffic bandwidth pps+outbound
    When UI Click Button "outboundSwitch"
    When UI Click Button "ppsSwitch"

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Challenged"
      | value | min |
      | 0     | 5   |

    Then UI Validate Text field "max attacks" EQUALS "0.0"
    Then UI Validate Text field "min attacks" EQUALS "0.0"

  @SID_22
  Scenario: validate traffic bandwidth pps+inbound
    When UI Click Button "inboundSwitch"
    When UI Click Button "ppsSwitch"

    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 84407.0 | 1     | 5      |
    Then UI Validate Text field "max attacks" EQUALS "84.42 K" with offset 5
    Then UI Validate Text field "min attacks" EQUALS "0.0"

  @SID_23
  Scenario:  validate tables for SYNFlood
    Then UI search row table in searchLabel "tableSearch" with text "SYN Flood"
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Policy Name" findBy cellValue "Policy_4993@000010-00005-0"
    Then UI Validate Element Existence By Label "Expand Tables View" if Exists "true" with value "info,Characteristics"


  @SID_24
  Scenario Outline:  validate date of Info table - SynFlood
    Then Validate Expand "Info" Table with label "<label>" Equals to "<value>"
    Examples:
      | label              | value          |
      | Risk               | Medium         |
      | Radware ID         | 200000         |
      | Direction          | Unknown        |
      | Action Type        | Challenge      |
      | Attack ID          | 137-1414505529 |
      | Physical Port      | Multiple       |
      | Total Packet Count | 223,890        |
      | VLAN               | Multiple       |
      | MPLS RD            | Multiple       |
      | Source port        | Multiple       |

  @SID_25
  Scenario Outline:  validate date of Characteristics table - SynFlood
    Then Validate Expand "Characteristics" Table with label "<label>" Equals to "<value>"
    Examples:
      | label                | value                |
      | Activation Threshold | 2500                 |
      | TCP Challenge        | Transparent Proxy    |
      | TCP Auth. List       | 0                    |
      | HTTP Challenge       | Cloud Authentication |
      | HTTP Auth. List      | 0                    |


  ############################### Analytics Dashboard ###################################

  @SID_26
  Scenario: Login and add widgets
#    When UI Login with user "radware" and password "radware"
#    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    Then UI Click Button "Widget Selection"
    Then UI Click Button "Widget Selection.Clear Dashboard"
    Then UI Click Button "Widget Selection.Remove All Confirm"
    Then UI Click Button "Traffic Bandwidth widget"
    Then UI Click Button "Widget Selection.Add Selected Widgets"
    Then UI Click Button "Widget Selection"
    Then Sleep "65"

  @SID_27
  Scenario: check bps with inbound
    Then UI Do Operation "Select" item "Traffic Bandwidth bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |

    Then UI Validate Text field "max analytics" EQUALS "83.74 M" with offset 5
    Then UI Validate Text field "min analytics" EQUALS "0"

  @SID_28
  Scenario: check bps with outbound
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value | count | offset |
      | 0     | 0     | 0      |

    Then UI Validate Text field "max analytics" EQUALS "0.0"
    Then UI Validate Text field "min analytics" EQUALS "0.0"

  @SID_29
  Scenario: check pps with inbound
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "traffic-bandwidth-1" with Label "Challenged"
      | value   | count | offset |
      | 84407.0 | 1     | 5      |
    Then UI Validate Text field "max analytics" EQUALS "84.42 K" with offset 5
    Then UI Validate Text field "min analytics" EQUALS "0.0"

  @SID_30
  Scenario: check pps with outbound
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value | count | offset |
      | 0     | 5     | 5      |
    Then UI Validate Text field "max analytics" EQUALS "0.0"
    Then UI Validate Text field "min analytics" EQUALS "0.0"

  @SID_31
  Scenario: choose device and policy from scope selection
    Given UI Click Button "Device Selection"
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Analytics,index:22,policies:[Policy_4993@000010-00005-0] |

  @SID_32
  Scenario: check bps with inbound
    Then UI Do Operation "Select" item "Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "traffic-bandwidth" with Label "Challenged"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |

    Then UI Validate Text field "max analytics" EQUALS "83.74 M" with offset 5
    Then UI Validate Text field "min analytics" EQUALS "0"

  @SID_33
  Scenario: check bps with outbound
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value | count | offset |
      | 0     | 0     | 0      |

    Then UI Validate Text field "max analytics" EQUALS "83745.0" with offset 5
    Then UI Validate Text field "min analytics" EQUALS "0.0"

  @SID_34
  Scenario: check pps with inbound
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "traffic-bandwidth-1" with Label "Challenged"
      | value   | count | offset |
      | 84407.0 | 1     | 5      |
    Then UI Validate Text field "max analytics" EQUALS "84.42 K" with offset 5
    Then UI Validate Text field "min analytics" EQUALS "0.0"

  @SID_35
  Scenario: check pps with outbound
    And UI Do Operation "Select" item "Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Traffic Bandwidth-1" with Label "Challenged"
      | value | count | offset |
      | 0     | 0     | 0      |
    Then UI Validate Text field "max analytics" EQUALS "83745.0"
    Then UI Validate Text field "min analytics" EQUALS "0.0"


    ############################## AMS Reports #################################



  @SID_36
  Scenario: Clean data System
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs


  @SID_37
  Scenario: to be edited when we got the relevant pcap
    Given CLI simulate 1000 attacks of type "challenged_inbound_test" on "DefensePro" 22 and wait 120 seconds
    Then Sleep "30"


  @SID_38
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." Retry 240 seconds


  @SID_39
  Scenario: Clear old reports on file-system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"


  @SID_40
  Scenario:  login to vision
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "10"


  @SID_41
  Scenario: Clear old reports on file-system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"


  @SID_42
  Scenario: Create and Generate New Report trafficBandwidth report
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "trafficBandwidth report"
      | Template | reportType:DefensePro Analytics, Widgets:[{Traffic Bandwidth}], devices:[{deviceIndex:22, devicePolicies:[Policy_4993@000010-00005-0]}] |
      | Format   | Select: PDF                                                                                                                             |
    Then UI "Validate" Report With Name "Widgets 3_7_8_11_13 Report 2"
      | Template | reportType:DefensePro Analytics, Widgets:[{Traffic Bandwidth}], devices:[{deviceIndex:22, devicePolicies:[Policy_4993@000010-00005-0]}] |
      | Format   | Select: PDF                                                                                                                             |

    Then UI Click Button "My Report" with value "trafficBandwidth report"
    Then UI Click Button "Generate Report Manually" with value "trafficBandwidth report"

  @SID_43

  Scenario: edit format to HTML New Report trafficBandwidth report
    Given UI "Edit" Report With Name "trafficBandwidth report"
      | Format | Select:HTML |

    Then UI "Validate" Report With Name "trafficBandwidth report"
      | Template | reportType:DefensePro Analytics, Widgets:[{Traffic Bandwidth}], devices:[{deviceIndex:22, devicePolicies:[Policy_4993@000010-00005-0]}]] |
      | Format   | Select:HTML                                                                                                                              |

    Then UI Click Button "My Report" with value "trafficBandwidth report"
    Then UI Click Button "Generate Report Manually" with value "trafficBandwidth report"

  @SID_44

  Scenario: edit format to CSV New Report trafficBandwidth report
    Given UI "Edit" Report With Name "trafficBandwidth report"
      | Format | Select: CSV |

    Then UI "Validate" Report With Name "trafficBandwidth report"
      | Template | reportType:DefensePro Analytics, Widgets:[{Traffic Bandwidth}], devices:[{deviceIndex:22, devicePolicies:[Policy_4993@000010-00005-0]}] |
      | Format   | Select: CSV                                                                                                                             |

    Then UI Click Button "My Report" with value "trafficBandwidth report"
    Then UI Click Button "Generate Report Manually" with value "trafficBandwidth report"

  @SID_45
  Scenario: VRM report unzip local CSV file
    Then Sleep "10"
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then Sleep "10"

  @SID_46
  Scenario: VRM report validate CSV file Traffic Bandwidth number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"


  @SID_47
  Scenario: VRM report validate CSV file Traffic Bandwidth headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -1|grep averageTrafficValue,deviceIp,averageDiscards,maxTrafficValue,policyName,maxDiscards|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "averageTrafficValue"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ BandwidthDefensePro\ Analytics.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "deviceIp"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "averageDiscards"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "maxTrafficValue"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "policyName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "maxDiscards"


  @SID_48
  Scenario:VRM report validate CSV file Traffic Bandwidth content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|grep -oP "83625.2814814814,10.185.2.85,0,83781,Policy_4993@000015-00005-0,0" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "83625.2814814814"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "10.185.2.85"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "83781"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Policy_4993@000015-00005-0"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Traffic\ Bandwidth-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "0"


  @SID_49
  Scenario: Delete Added Reports
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Delete Report With Name "trafficBandwidth report"


  @SID_50
  Scenario: Logout and close browser
    Given UI logout and close browser