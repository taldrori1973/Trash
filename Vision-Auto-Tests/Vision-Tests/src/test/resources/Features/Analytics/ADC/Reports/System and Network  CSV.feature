@TC118901
Feature: ADC System and Network Generate CSV Report
  @SID_1
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." with timeOut 240

  @SID_2
  Scenario: Login and Navigate ADC Report
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "ADC Reports" page via homePage

  @SID_3
  Scenario: Create and validate ADC Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "ADC System and Network Report"
      | Template-2            | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_50.50.101.21] |
      | Time Definitions.Date | Quick:1H                                                                                                 |
      | Format                | Select:  CSV                                                                                             |
    Then UI "Validate" Report With Name "ADC System and Network Report"
      | Template-2            | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_50.50.101.21] |
      | Time Definitions.Date | Quick:1H                                                                                                 |
      | Format                | Select: CSV                                                                                              |

  @SID_4
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "ADC Applications Report"
    Then UI Click Button "Generate Report Manually" with value "ADC Applications Report"
    Then Sleep "35"

  @SID_5
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"


 #Defect number DE62092