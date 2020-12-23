@runa
Feature:test

  #Temprorary test - by Ayoub and Ramez

  Scenario: maha test
    Given UI Login with user "radware" and password "radware"
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies       |
      | 10    |       | BDOS, Policy14 |
      | 11    |       | BDOS, Policy14 |
#    Then UI "Validate" Report With Name "OverallDFReport1"
#      | reportType         | DefenseFlow Analytics Dashboard                                                  |
#      | projectObjects     | PO_100,PO_200,PO_300                                                             |
#      | Design             | Widgets:[Top Attacks by Duration,Top Attack Destination,Top Attacks by Protocol] |
#      | Customized Options | addLogo: reportLogoPNG.png                                                       |
#    When UI "Create" Report With Name "OverallDFReport"
#      | reportType         | DefenseFlow Analytics Dashboard                                              |
#      | projectObjects     | All                                                                          |
#      | Design             | Add:[Top Attacks by Duration,Top Attack Destination,Top Attacks by Protocol] |
#      | Customized Options | addLogo: reportLogoPNG.png                                                   |
#    Given UI "Create" Report With Name "Analytics_Dev10Policy14Dev11Policy14"
#      | reportType | DefensePro Analytics Dashboard |
#      | devices    | index:10,policies:[Policy14]; index:11,policies:[Policy14];  |

  Scenario: Create Report of Traffic Global Kbps Inbound
    Given UI "Validate" Report With Name "Traffic Report"
      | Template-1            | reportType:DefensePro Analytics , Widgets:[Concurrent Connections],devices:[{deviceIndex:11,devicePorts:[1],devicePolicies:[BDOS,1_https]},{deviceIndex:10}]                             |
#      | Template-1            | reportType:DefensePro Analytics , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[{deviceIndex:11,devicePorts:[1,2],devicePolicies:[BDOS,1_https]},{deviceIndex:10}] |
##      | Template-1            | reportType:DefensePro Analytics , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[All] |
##      | Template-2            | reportType:HTTPS Flood , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[Server_v4-DefensePro_172.16.22.50-pol1] |
##       | Template-3            | reportType:AppWall , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[A1,ADZ] |
##      | Template-4            | reportType:DefenseFlow Analytics , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[All] |
#      | Format                | Select: CSV                                                                                                                                                                            |
##      |Template-4             |reportType:DefensePro Analytics , Widgets:[BDoS-TCP SYN,Concurrent Connections],devices:[{devicesIndex:11,devicePorts:[1,2],devicePolicies:[BDOS,APOL]},{deviceIndex:10}]|
#      | Logo                  | reportLogoPNG.png                                                                                                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN,SEP,DEC]                                                                                                                                |
##      | Time Definitions.Date | Quick:This Month                                                                                                                                                                       |

    Given UI "Edit" Report With Name "Traffic Report"
      | Template-1            | reportType:DefensePro Analytics , Widgets:[Concurrent Connections],devices:[{deviceIndex:11,devicePorts:[1],devicePolicies:[BDOS,1_https]},{deviceIndex:10}]                             |
      | Template-1            | reportType:DefensePro Analytics , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[{deviceIndex:11,devicePorts:[1,2],devicePolicies:[BDOS,1_https]},{deviceIndex:10}] |
      | Template-1            | reportType:DefensePro Analytics , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[All], showTable:true |
      | Template_1            |AddWidgets[], DeleteWidgets:[] editWidgets:[{BDoS-TCP SYN:[pps,IPv6,15]}]                                                      |
      |Template_1             |DeleteTemplate|
      | Template-2            | reportType:HTTPS Flood , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[Server_v4-DefensePro_172.16.22.50-pol1] |
      | Template-3            | reportType:AppWall , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[A1,ADZ] |
      | Template-4            | reportType:DefenseFlow Analytics , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[All] |
      | Format                | Select: CSV                                                                                                                                                                            |
#      |Template-4             |reportType:DefensePro Analytics , Widgets:[BDoS-TCP SYN,Concurrent Connections],devices:[{devicesIndex:11,devicePorts:[1,2],devicePolicies:[BDOS,APOL]},{deviceIndex:10}]|
      | Logo                  | reportLogoPNG.png                            a                                                                                                                                          |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN,SEP,DEC]                                                                                                                                |
#      | Time Definitions.Date | Quick:This Month                                                                                                                                                                       |





#    When UI "Create" Report With Name "monthly Forensic"
#      | Schedule | Run Every:Once, On Time:+6H |
##      | Time Definitions.Date | Quick:This Month                             |
##      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN,SEP,DEC] |
#
#    When UI "Validate" Report With Name "monthly Forensic"
##      | Time Definitions.Date | Quick:This Month                             |
#      | Schedule | Run Every:Once, On Time:+6H |

#      | Share                 | Email:[Test, Test2],Subject:TC108070 Subject            |
#      | Format                | Select: CSV                                             |
#      | Logo                  | addLogo: reportLogoPNG.png                              |

#  @SID_1
#  Scenario: Clean system data before "Protection Policies" test
##    * CLI kill all simulator attacks on current vision
##    Given CLI Reset radware password
##    Then CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
#    * REST Delete ES index "dp-*"
#    * CLI Clear vision logs
##
#  @SID_2
#  Scenario: Run DP simulator PCAPs for "Protection Policies" - just traffic
#    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 185 with loopDelay 15000
#    And CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 185 with loopDelay 15000
#    And CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 185 with loopDelay 15000 and wait 50 seconds
#
#
#  @SID_3
#  Scenario: Login and navigate to VRM
#    Given UI Login with user "radware" and password "radware"
##    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
#    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
#    Given UI Click Button "Global Time Filter"
#    When UI Click Button "Global Time Filter.Quick Range" with value "1H"
#
#  @SID_4
#  Scenario: Validate first peace time policy - just traffic
#    When UI Do Operation "Select" item "Device Selection"
#    And UI VRM Select device from dashboard and Save Filter
#      | index | ports | policies |
#      | 10    |       |          |
#    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 0
#      | columnName            | value                   |
#      | Site                  | RealDPs_Version_8_site  |
#      | Device                | DefensePro_172.16.22.50 |
#      | Policy Name           | Policy150               |
#      | Policy Status         | peace                   |
#      | Total Inbound Traffic | 7.48 Mbps               |
#      | Attack Rate           | 0                       |
#      | Drop Rate             | 0 bps                   |
#      | Attack Categories     | None                    |


#  Scenario: validate report data
#    Then validate report generation with name "my report" and generation number 3
#      | line | column | text      |
#      | 1    | 3      | 7775.22   |
#      | 8    | 6      | blablabla |
#
#
#    Then UI Validate Line Chart data "Top Attacks" in report "my report" generation number "4" and template name "my template"
#      | value       | count | valueOffset |
#      | flood-xxx   | 6     | 0           |
#      | flood-xxxx  | 1     | 1           |
#      | flood-xxxxx | 1     | 0           |








#  Scenario: Validate Report of Traffic Global Kbps Inbound
#    Given UI "Create" Report With Name "Traffic Report"
#      | Template            | reportType:DefensePro Analytics ; Widgets:[Traffic Bandwidth,Concurrent Connections];devices:index:10,ports:[1],policies:[BDOS] |
#      | Template-1            | reportType:DefensePro Analytics ; Widgets:[Traffic Bandwidth,Concurrent Connections];devices:index:11,ports:[1],policies:[BDOS] |
#      | Format                | Select: CSV                                                                                                                     |
#      | Time Definitions.Date | Quick:1H                                                                                                                        |













