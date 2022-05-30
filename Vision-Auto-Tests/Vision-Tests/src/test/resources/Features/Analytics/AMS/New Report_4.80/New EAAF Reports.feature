@TC126828
Feature: New EAAF Mode Reports

  @SID_1
  Scenario: Login and navigate to EAAF dashboard and Clean system attacks
    Then Play File "empty_file.xmf" in device "50.50.100.1" from map "Automation_Machines" and wait 20 seconds
    * REST Delete ES index "eaaf-attack-*"
    * REST Delete ES index "attack-*"
    * CLI Clear vision logs
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/storage/dc_config/kvision-reporter/config/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Service "config_kvision-reporter_1" do action RESTART
    Then CLI Validate service "CONFIG_KVISION_REPORTER" is up with timeout "45" minutes
    Given UI Login with user "radware" and password "radware"
#    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"

  @SID_2
  Scenario: PLAY DP_sim_8.28 file and Navigate EAAF DashBoard
    Given Play File "DP_sim_8.28.xmf" in device "50.50.100.1" from map "Automation_Machines" and wait 20 seconds
    Then Sleep "300"
    Then Play File "empty_file.xmf" in device "50.50.100.1" from map "Automation_Machines" and wait 20 seconds
    And UI Navigate to "EAAF Dashboard" page via homePage

  @SID_3
  Scenario: Delete old reports on file-system
    Then CLI Run remote linux Command "docker exec -it config_kvision-reporter_1 sh -c "rm /usr/local/tomcat/VRM_report*"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario: Navigate to AMS Reports
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "AMS Reports" page via homePage


  @SID_5
  Scenario: create EAAF Reports PDF
    Given UI "Create" Report With Name "EAAF PDF"
      | Template | reportType:ERT Active Attackers Feed , Widgets:[ALL],devices:[All] |
      | Format   | Select: PDF                                                        |
    Then UI "Validate" Report With Name "EAAF PDF"
      | Template | reportType:ERT Active Attackers Feed , Widgets:[ALL],devices:[All] |
      | Format   | Select: PDF                                                        |


  @SID_6
  Scenario: generate report And Click on Show PDF Report
    Then UI "Generate" Report With Name "EAAF PDF"
      | timeOut | 120 |

  @SID_7
  Scenario: create EAAF Reports HTML
    Given UI "Create" Report With Name "EAAF HTML"
      | Template | reportType:ERT Active Attackers Feed , Widgets:[ALL],devices:[All] |
      | Format   | Select: HTML                                                       |
    Then UI "Validate" Report With Name "EAAF HTML"
      | Template | reportType:ERT Active Attackers Feed , Widgets:[ALL],devices:[All] |
      | Format   | Select: HTML                                                       |


  @SID_8
  Scenario: generate report And Click on Show HTML Report
    Then UI "Generate" Report With Name "EAAF HTML"
      | timeOut | 120 |

  @SID_9
  Scenario: create new CSV Report
    Given UI "Create" Report With Name "EAAF CSV"
      | Template | reportType:ERT Active Attackers Feed , Widgets:[ALL],devices:[All] |
      | Format   | Select: CSV                                                        |
    Then UI "Validate" Report With Name "EAAF CSV"
      | Template | reportType:ERT Active Attackers Feed , Widgets:[ALL],devices:[All] |
      | Format   | Select: CSV                                                        |

  @SID_10
  Scenario: generate report
    Then UI "Generate" Report With Name "EAAF CSV"
      | timeOut | 120 |

  @SID_11
  Scenario: Navigate to EAAF Dashboard and return to AMS Reports to Refresh
    And UI Navigate to "EAAF Dashboard" page via homePage
    And UI Navigate to "AMS Reports" page via homePage


  @SID_12
  Scenario: VRM report unzip local CSV file
    Then CLI Copy files contains name "VRM_report_[0-9]+.zip" from container "config_kvision-reporter_1" from path "/usr/local/tomcat/" to path "/opt/radware/mgt-server/third-party/tomcat/bin"
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_13
  Scenario: EAAF report validate DATA CSV file Breakdown by Malicious
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Breakdown by Malicious Activity.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Breakdown by Malicious Activity.csv"|head -1|tail -1|grep volume,attacks,category,packets|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Breakdown by Malicious Activity.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "1989"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Breakdown by Malicious Activity.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "3"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Breakdown by Malicious Activity.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "2006"


  @SID_14
  Scenario: EAAF report validate DATA CSV file EAAF Hits Timeline
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/EAAF Hits Timeline.csv"|head -1|tail -1|grep timeStamp,volume,attacks,packets|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/EAAF Hits Timeline.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "1989"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/EAAF Hits Timeline.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "3"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/EAAF Hits Timeline.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "2006"


  @SID_15
  Scenario: EAAF report validate DATA CSV file Hits per Distinct IP Addresses Analysis
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Hits per Distinct IP Addresses Analysis.csv"|head -1|tail -1|grep timeStamp,sourceIp,packets|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Hits per Distinct IP Addresses Analysis.csv"|head -6|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "11"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Hits per Distinct IP Addresses Analysis.csv"|head -6|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "10030"


  @SID_16
  Scenario: EAAF report validate DATA CSV file Top Attacking Geolocations
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations.csv"|head -1|tail -1|grep volume,attacks,countryCode,packets|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "284"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "IN"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "287"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations.csv"|head -3|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "284"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations.csv"|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations.csv"|head -3|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "SE"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations.csv"|head -3|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "287"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations.csv"|head -4|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "284"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations.csv"|head -4|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations.csv"|head -4|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "VN"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations.csv"|head -4|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "287"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations.csv"|head -5|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "283"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations.csv"|head -5|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations.csv"|head -5|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "CN"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Top Attacking Geolocations.csv"|head -5|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "286"


  @SID_17
  Scenario: Open Log Preview EAAF PDF Report
    Then UI Click Button "Reports List Item" with value "EAAF PDF"
    Then UI Click Button "Log Preview" with value "EAAF PDF_0"
    Then Sleep "5"

  @SID_18
  Scenario: Validate Show Report Top Malicious Chart PDF
    Then UI Validate Text field "Top Malicious Row" with params "0" EQUALS "287.0"
    Then UI Validate Text field "Top Malicious Row" with params "1" EQUALS "287.0"
    Then UI Validate Text field "Top Malicious Row" with params "2" EQUALS "287.0"
    Then UI Validate Text field "Top Malicious Row" with params "3" EQUALS "286.0"
    Then UI Validate Text field "Top Malicious Row" with params "4" EQUALS "144.0"
    Then UI Validate Text field "Top Malicious Row" with params "5" EQUALS "143.0"
    Then UI Validate Text field "Top Malicious Row" with params "6" EQUALS "143.0"
    Then UI Validate Text field "Top Malicious Row" with params "7" EQUALS "143.0"
    Then UI Validate Text field "Top Malicious Row" with params "8" EQUALS "143.0"

  @SID_19
  Scenario: Validate Show Report Top Attacking Countries Chart PDF
    Then UI Validate Text field "Top Attacking Countries Row" with params "0" EQUALS "287.0"
    Then UI Validate Text field "Top Attacking Countries Row" with params "1" EQUALS "287.0"
    Then UI Validate Text field "Top Attacking Countries Row" with params "2" EQUALS "287.0"
    Then UI Validate Text field "Top Attacking Countries Row" with params "3" EQUALS "286.0"
    Then UI Validate Text field "Top Attacking Countries Row" with params "4" EQUALS "144.0"
    Then UI Validate Text field "Top Attacking Countries Row" with params "5" EQUALS "143.0"
    Then UI Validate Text field "Top Attacking Countries Row" with params "6" EQUALS "143.0"
    Then UI Validate Text field "Top Attacking Countries Row" with params "7" EQUALS "143.0"
    Then UI Validate Text field "Top Attacking Countries Row" with params "8" EQUALS "143.0"


  @SID_20
  Scenario: Validate Show Report Breakdown by Malicious Activity Chart PDF
    Then UI Validate Text field "Breakdown by Malicious Row" with params "0" EQUALS "2K"


  @SID_21
  Scenario: Validate Show Report EAAF Timeline Chart PDF
    Then UI Validate Text field "EAAF Timeline Total Attacks" EQUALS "3"
    Then UI Validate Text field "EAAF Timeline Total Packets" EQUALS "2 K"
    Then UI Validate Text field "EAAF Timeline Total Valume" EQUALS "2 M"


  @SID_22
  Scenario: Open Log Preview EAAF PDF Report
    Then UI Click Button "Reports List Item" with value "EAAF HTML"
    Then UI Click Button "Log Preview" with value "EAAF HTML_0"
    Then Sleep "5"

  @SID_23
  Scenario: Validate Show Report Top Malicious Chart HTML
    Then UI Validate Text field "Top Malicious Row" with params "0" EQUALS "287.0"
    Then UI Validate Text field "Top Malicious Row" with params "1" EQUALS "287.0"
    Then UI Validate Text field "Top Malicious Row" with params "2" EQUALS "287.0"
    Then UI Validate Text field "Top Malicious Row" with params "3" EQUALS "286.0"
    Then UI Validate Text field "Top Malicious Row" with params "4" EQUALS "144.0"
    Then UI Validate Text field "Top Malicious Row" with params "5" EQUALS "143.0"
    Then UI Validate Text field "Top Malicious Row" with params "6" EQUALS "143.0"
    Then UI Validate Text field "Top Malicious Row" with params "7" EQUALS "143.0"
    Then UI Validate Text field "Top Malicious Row" with params "8" EQUALS "143.0"

  @SID_24
  Scenario: Validate Show Report Top Attacking Countries Chart HTML
    Then UI Validate Text field "Top Attacking Countries Row" with params "0" EQUALS "287.0"
    Then UI Validate Text field "Top Attacking Countries Row" with params "1" EQUALS "287.0"
    Then UI Validate Text field "Top Attacking Countries Row" with params "2" EQUALS "287.0"
    Then UI Validate Text field "Top Attacking Countries Row" with params "3" EQUALS "286.0"
    Then UI Validate Text field "Top Attacking Countries Row" with params "4" EQUALS "144.0"
    Then UI Validate Text field "Top Attacking Countries Row" with params "5" EQUALS "143.0"
    Then UI Validate Text field "Top Attacking Countries Row" with params "6" EQUALS "143.0"
    Then UI Validate Text field "Top Attacking Countries Row" with params "7" EQUALS "143.0"
    Then UI Validate Text field "Top Attacking Countries Row" with params "8" EQUALS "143.0"


  @SID_25
  Scenario: Validate Show Report Breakdown by Malicious Activity Chart HTML
    Then UI Validate Text field "Breakdown by Malicious Row" with params "0" EQUALS "2K"


  @SID_26
  Scenario: Validate Show Report EAAF Timeline Chart HTML
    Then UI Validate Text field "EAAF Timeline Total Attacks" EQUALS "3"
    Then UI Validate Text field "EAAF Timeline Total Packets" EQUALS "2 K"
    Then UI Validate Text field "EAAF Timeline Total Valume" EQUALS "2 M"


#  @SID_24
#  Scenario: Validate Show Report BreakDown by Malicious Chart
#    Then Validate Line Chart data "Hits per Distinct IP Addresses Analysis-ERT Active Attackers Feed" with Label "packets" in report "EAAF Report Distinct IP Addresses"
#      | value | min |
#      | 10030 | 1   |
#
#    Then Validate Line Chart data "Hits per Distinct IP Addresses Analysis-ERT Active Attackers Feed" with Label "addresses" in report "EAAF Report Distinct IP Addresses"
#      | value | min |
#      | 11    | 1   |


  @SID_27
  Scenario: Delete reports
    Then UI Delete Report With Name "EAAF CSV"
    Then UI Delete Report With Name "EAAF HTML"
    Then UI Delete Report With Name "EAAF PDF"


  @SID_28
  Scenario: Logout
    Then UI logout and close browser