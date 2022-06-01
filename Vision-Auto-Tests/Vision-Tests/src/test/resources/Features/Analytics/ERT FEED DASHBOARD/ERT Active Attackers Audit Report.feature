@TC126494
Feature:ERT Active Attackers Audit Report

  @SID_1
  Scenario: Login and navigate to EAAF dashboard and Clean system attacks
    Then Play File "empty_file.xmf" in device "50.50.100.1" from map "Automation_Machines" and wait 20 seconds
#    * REST Delete ES index "eaaf-attack-data-*"
#    * REST Delete ES index "attack-*"
    * CLI Clear vision logs
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"

  @SID_2
  Scenario: PLAY DP_sim_8.28 file and Navigate EAAF DashBoard
    Given Play File "DP_sim_8.28.xmf" in device "50.50.100.1" from map "Automation_Machines" and wait 20 seconds
    Then Sleep "300"
    And UI Navigate to "EAAF Dashboard" page via homePage
    Then Play File "empty_file.xmf" in device "50.50.100.1" from map "Automation_Machines" and wait 20 seconds


  @SID_3
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/storage/dc_config/kvision-reporter/config/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Service "config_kvision-reporter_1" do action RESTART
    Then CLI Validate service "CONFIG_KVISION_REPORTER" is up with timeout "45" minutes

  @SID_4
  Scenario: Clear Database and old reports on file-system
    Then CLI Run remote linux Command "docker exec -it config_kvision-reporter_1 sh -c \"rm /usr/local/tomcat/VRM_report*\"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"

  @SID_5
  Scenario: validate that we can select just ERT Active Attackers Audit Report template and just in CSV format
    Then UI Navigate to "AMS Reports" page via homePage
    Given UI Click Button "New Report Tab"
    Then UI Set Text Field "Report Name" To "new ert"
    Then UI Click Button "Add Template" with value "ERT Active Attackers Audit Report"
    Then UI Validate the attribute "data-debug-enabled" Of Label "Template" With Params "HTTPS Flood" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-enabled" Of Label "Template" With Params "DefenseFlow Analytics" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-enabled" Of Label "Template" With Params "AppWall" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-enabled" Of Label "Template" With Params "ERT Active Attackers Feed" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-enabled" Of Label "Template" With Params "DefensePro Behavioral Protections" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-enabled" Of Label "Template" With Params "DefensePro Analytics" is "EQUALS" to "false"

    Then UI Click Button "Schedule Tab"
    Then UI Validate the attribute "data-debug-checked" Of Label "Format Type" With Params "PDF" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Format Type" With Params "HTML" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Format Type" With Params "CSV" is "EQUALS" to "true"


  @SID_6
  Scenario: create new Report With Name "EAAF CSV
    Given UI "Create" Report With Name "EAAF CSV"
      | Template              | reportType:ERT Active Attackers Audit Report , Widgets:[ERT Active Attackers Audit Report],devices:[All] |
      | Time Definitions.Date | Quick:1D                                                                                                |
      | Format                | Select: CSV                                                                                              |
    Then UI "Validate" Report With Name "EAAF CSV"
      | Template              | reportType:ERT Active Attackers Audit Report , Widgets:[ERT Active Attackers Audit Report],devices:[All] |
      | Time Definitions.Date | Quick:1D                                                                                                |
      | Format                | Select: CSV                                                                                              |

  @SID_7
  Scenario: edit the report to validate templates are disabled and just CSV
    Then UI Click Button "Edit Report" with value "EAAF CSV"
    Then UI Validate the attribute "data-debug-enabled" Of Label "Template" With Params "HTTPS Flood" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-enabled" Of Label "Template" With Params "DefenseFlow Analytics" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-enabled" Of Label "Template" With Params "AppWall" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-enabled" Of Label "Template" With Params "ERT Active Attackers Feed" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-enabled" Of Label "Template" With Params "DefensePro Behavioral Protections" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-enabled" Of Label "Template" With Params "DefensePro Analytics" is "EQUALS" to "false"

    Then UI Click Button "Schedule Tab"
    Then UI Validate the attribute "data-debug-checked" Of Label "Format Type" With Params "PDF" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Format Type" With Params "HTML" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Format Type" With Params "CSV" is "EQUALS" to "true"
    Then UI Click Button "cancel"

  @SID_8
  Scenario: generate report
    Then UI "Generate" Report With Name "EAAF CSV"
      | timeOut | 60 |

  @SID_9
  Scenario: VRM report unzip local CSV file
    Then CLI Copy files contains name "VRM_report_*.zip" from container "config_kvision-reporter_1" from path "/usr/local/tomcat" to path "/opt/radware/mgt-server/third-party/tomcat/bin/"
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then Sleep "10"

  @SID_10
  Scenario: EAAF report validate CSV file number of lines
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/ERT Active Attackers Audit Report.csv" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_11
  Scenario: EAAF report validate CSV file header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/ERT Active Attackers Audit Report.csv"|head -1|tail -1|grep volume,categoryAgg,distinct_count,packets|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_12
  Scenario: EAAF report validate CSV file content
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/ERT Active Attackers Audit Report.csv"|head -2|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result CONTAINS "100"
  @SID_13
  Scenario: Logout and Close Browser
    Then UI logout and close browser