@TC118579
Feature: Edit HTTPS Flood tests

  @SID_1
  Scenario: Clean data before the test
    * REST Delete ES index "dp-traffic-*"
    * REST Delete ES index "dp-https-stats-*"
    * REST Delete ES index "dp-https-rt-*"
    * REST Delete ES index "dp-five-*"

  @SID_2
  Scenario: Login
    Then UI Login with user "sys_admin" and password "radware"

  @SID_3
  Scenario: Run DP simulator PCAPs for "HTTPS attacks"
    Given CLI simulate 1 attacks of type "HTTPS" on "DefensePro" 11 with loopDelay 15000 and wait 60 seconds

  @SID_4
  Scenario: Navigate to NEW REPORTS page
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_5
  Scenario: Create and Validate HTTPS Flood Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "HTTPS Flood Report"
      | Template-1            | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[server1-DefensePro_172.16.22.51-1_https]       |
      | Template-2            | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[server1-DefensePro_172.16.22.51-https_policy7] |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Share                 | Email:[automation.vision1@radware.com],Subject:myAdd subject,Body:myAdd body                             |
      | Time Definitions.Date | Quick:Today                                                                                              |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                              |
      | Format                | Select: PDF                                                                                              |
    Then UI "Validate" Report With Name "HTTPS Flood Report"
      | Template-1            | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[server1-DefensePro_172.16.22.51-1_https]       |
      | Template-2            | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[server1-DefensePro_172.16.22.51-https_policy7] |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Share                 | Email:[automation.vision1@radware.com],Subject:myAdd subject,Body:myAdd body                             |
      | Time Definitions.Date | Quick:Today                                                                                              |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                              |
      | Format                | Select: PDF                                                                                              |

  @SID_6
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "HTTPS Flood Report"
    Then UI Click Button "Generate Report Manually" with value "HTTPS Flood Report"
    Then Sleep "35"

  @SID_7
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

    ############################################       TOP ATTACKS       ###################################################################################
  @SID_8
  Scenario: VRM report validate CSV file TOP ATTACKS number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Inbound\ Traffic-HTTPS\ Flood.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_9
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


  @SID_10
  Scenario: Add Template Widget to HTTPS Flood Report
    Given UI "Edit" Report With Name "HTTPS Flood Report"
      | Template-1 | reportType:HTTPS Flood,AddWidgets:[Inbound Traffic],Servers:[server1-DefensePro_172.16.22.51-1_https] |
    Then UI "Validate" Report With Name "HTTPS Flood Report"
      | Template-1 | reportType:HTTPS Flood,Widgets:[Inbound Traffic,Inbound Traffic],Servers:[server1-DefensePro_172.16.22.51-1_https] |

  @SID_11
  Scenario: Delete Template from HTTPS Flood Report
    Given UI "Edit" Report With Name "HTTPS Flood Report"
      | Template-2 | DeleteTemplate:true |
    Then UI "Validate" Report With Name "HTTPS Flood Report"
      | Template-1 | reportType:HTTPS Flood,Widgets:[Inbound Traffic,Inbound Traffic],Servers:[server1-DefensePro_172.16.22.51-1_https] |

  @SID_12
  Scenario: Edit Template Servers from HTTPS Flood Report
    Given UI "Edit" Report With Name "HTTPS Flood Report"
      | Template | reportType:HTTPS Flood,Servers:[server1-DefensePro_172.16.22.51-https_policy6] |
    Then UI "Validate" Report With Name "HTTPS Flood Report"
      | Template | reportType:HTTPS Flood,Servers:[server1-DefensePro_172.16.22.51-https_policy6] |

  @SID_13
  Scenario:Add Template to HTTPS Flood
    Given UI "Edit" Report With Name "HTTPS Flood Report"
      | Template | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[server1-DefensePro_172.16.22.51-https_policy7] |
    Then UI "Validate" Report With Name "HTTPS Flood Report"
      | Template-1 | reportType:HTTPS Flood,Widgets:[Inbound Traffic,Inbound Traffic],Servers:[server1-DefensePro_172.16.22.51-https_policy6] |
      | Template-2 | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[server1-DefensePro_172.16.22.51-https_policy7]                 |

  @SID_14
  Scenario: Create and Validate HTTPS Flood Report2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "HTTPS Flood Report2"
      | Template-1            | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[server1-DefensePro_172.16.22.51-1_https]       |
      | Template-2            | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[server1-DefensePro_172.16.22.51-https_policy7] |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Share                 | Email:[automation.vision1@radware.com],Subject:myAdd subject,Body:myAdd body                             |
      | Time Definitions.Date | Quick:Today                                                                                              |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                              |
      | Format                | Select: PDF                                                                                              |
    Then UI "Validate" Report With Name "HTTPS Flood Report2"
      | Template-1            | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[server1-DefensePro_172.16.22.51-1_https]       |
      | Template-2            | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[server1-DefensePro_172.16.22.51-https_policy7] |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Share                 | Email:[automation.vision1@radware.com],Subject:myAdd subject,Body:myAdd body                             |
      | Time Definitions.Date | Quick:Today                                                                                              |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                              |
      | Format                | Select: PDF                                                                                              |

  @SID_15
  Scenario: Edit HTTPS Flood Report2 report name
    Then UI Click Button "My Report Tab"
    Then UI Click Button "Edit Report" with value "HTTPS Flood Report2"
    Then UI Set Text Field "Report Name" To "HTTPS Flood Report"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable To Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'HTTPS Flood Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "HTTPS Flood Report"?"
    Then UI Click Button "Yes"
    Then UI Text of "Error message title" equal to "Unable To Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'HTTPS Flood Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "HTTPS Flood Report"?"
    Then UI Click Button "No"

  @SID_16
  Scenario: Delete report
    Then UI Delete Report With Name "HTTPS Flood Report"
    Then UI Delete Report With Name "HTTPS Flood Report2"

  @SID_17
  Scenario: Logout
    Then UI logout and close browser
