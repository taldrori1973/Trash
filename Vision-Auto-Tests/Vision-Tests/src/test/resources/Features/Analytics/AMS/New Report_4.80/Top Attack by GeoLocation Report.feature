@TC122728
Feature: Top Attacking By GeoLocation Widget In Report


  @SID_1
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    Given CLI Reset radware password
    * REST Delete ES index "dp-*"
    Given CLI Run remote linux Command "service vision restart" on "ROOT_SERVER_CLI" and halt 60 seconds


  @SID_2
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." Retry 240 seconds


  @SID_3
  Scenario: Clear Database and old reports on file-system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"


  @SID_4
  Scenario: Run DP simulator PCAPs for "GEO" and "ErtFeed_GeoFeed"
    Given CLI simulate 1 attacks of type "GeoPlus10" on "DefensePro" 10 and wait 60 seconds
    * CLI kill all simulator attacks on current vision

  @SID_5
  Scenario: VRM - enabling emailing and go to VRM Reports Tab
    Given UI Login with user "radware" and password "radware"
    Given Setup email server
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Go To Vision
    Then UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"
    Then UI Do Operation "select" item "Email Reporting Configuration"
    Then UI Set Checkbox "Enable" To "true"
    Then UI Set Text Field "SMTP User Name" To "qa_test@Radware.com"
    Then UI Set Text Field "Subject Header" To "Alert Notification Message"
    Then UI Set Text Field "From Header" To "Automation system"
    Then UI Set Checkbox "Enable" To "false"
    Then UI Click Button "Submit"
    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
    And UI Set Checkbox "Enable" To "true"
    And UI Set Text Field "SMTP Server Address" To "172.17.164.10"
    And UI Set Text Field "SMTP Port" To "25"
    And UI Click Button "Submit"
    And UI Navigate to "AMS Reports" page via homePage

  @SID_6
  Scenario: Clear SMTP server log files in first step
    Given Clear email history for user "setup"

  @SID_7
  Scenario: Navigate
    Then UI Navigate to "AMS REPORTS" page via homepage

  @SID_8
  Scenario: create new Top Attacking By GeoLocation Report with Summary Table
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacking By GeoLocation Report with Summary Table"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attacking Geolocations],devices:[All],showTable:true |
      | Format   | Select: PDF                                                                                       |
    Then UI "Validate" Report With Name "Top Attacking By GeoLocation Report with Summary Table"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attacking Geolocations],devices:[All],showTable:true |
      | Format   | Select: PDF                                                                                       |
    Then UI "Generate" Report With Name "Top Attacking By GeoLocation Report with Summary Table"
      | timeOut | 90 |

  @SID_9
  Scenario: Show Top Attacking By GeoLocation Report with Summary Table after the create
    Then UI Click Button "Log Preview" with value "Top Attacking By GeoLocation Report with Summary Table_0"
    Then UI Text of "Total Summary Table" equal to "Total (for all countries):12"

  @SID_10
  Scenario: Edit share email in Top Attacking By GeoLocation Report with Summary Table
    Given UI "Edit" Report With Name "Top Attacking By GeoLocation Report with Summary Table"
      | Share | Email:[maha],Subject:Validate Email,Body:Email Body |
    Then UI "Validate" Report With Name "Top Attacking By GeoLocation Report with Summary Table"
      | Share | Email:[maha],Subject:Validate Email,Body:Email Body |
    Then UI "Generate" Report With Name "Top Attacking By GeoLocation Report with Summary Table"
      | timeOut | 90 |

  @SID_11
  Scenario: Show Top Attacking By GeoLocation Report with Summary Table after edit share email
    Then UI Click Button "Log Preview" with value "Top Attacking By GeoLocation Report with Summary Table_0"
    Then UI Text of "Total Summary Table" equal to "Total (for all countries):12"

  @SID_12
  Scenario: Validate Report Email received content after edit share email
    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@Radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: maha@.*.local"" EQUALS "1"
    #Attachment
    Then Validate "setup" user eMail expression "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).pdf"" EQUALS "1"

  @SID_13
  Scenario: Clear SMTP server log files after edit share email
    Given Clear email history for user "setup"


  @SID_14
  Scenario: Edit format Top Attacking By GeoLocation Report with Summary Table
    Given UI "Edit" Report With Name "Top Attacking By GeoLocation Report with Summary Table"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "Top Attacking By GeoLocation Report with Summary Table"
      | Format | Select: HTML |
    Then UI "Generate" Report With Name "Top Attacking By GeoLocation Report with Summary Table"
      | timeOut | 90 |

  @SID_15
  Scenario: Show Top Attacking By GeoLocation Report with Summary Table after edit format
    Then UI Click Button "Log Preview" with value "Top Attacking By GeoLocation Report with Summary Table_0"
    Then UI Text of "Total Summary Table" equal to "Total (for all countries):12"

  @SID_16
  Scenario: Validate Report Email received content  after edit format and share
    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@Radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: maha@.*.local"" EQUALS "1"
    #Attachment
    Then Validate "setup" user eMail expression "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).html"" EQUALS "1"

  @SID_17
  Scenario: Clear SMTP server log files  after edit format and share
    Given Clear email history for user "setup"

  @SID_18
  Scenario: Delete report Top Attacking By GeoLocation Report with Summary Table
    Then UI Delete Report With Name "Top Attacking By GeoLocation Report with Summary Table"

  @SID_19
  Scenario: create new Top Attacking By GeoLocation without summary table
    Given UI "Create" Report With Name "Top Attacking By GeoLocation Report without Summary Table"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attacking Geolocations],devices:[All],showTable:false |
      | Format   | Select: PDF                                                                                        |
    Then UI "Validate" Report With Name "Top Attacking By GeoLocation Report without Summary Table"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attacking Geolocations],devices:[All],showTable:false |
      | Format   | Select: PDF                                                                                        |
    Then UI "Generate" Report With Name "Top Attacking By GeoLocation Report without Summary Table"
      | timeOut | 90 |

  @SID_20
  Scenario: Show Top Attacking By GeoLocation Report without Summary Table
    Then UI Click Button "Log Preview" with value "Top Attacking By GeoLocation Report without Summary Table_0"
    Then UI Validate Element Existence By Label "Total Summary Table" if Exists "false"

  @SID_21
  Scenario: Edit format to html in Top Attacking By GeoLocation without summary table
    Given UI "Edit" Report With Name "Top Attacking By GeoLocation Report without Summary Table"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "Top Attacking By GeoLocation Report without Summary Table"
      | Format | Select: HTML |
    Then UI "Generate" Report With Name "Top Attacking By GeoLocation Report without Summary Table"
      | timeOut | 90 |

  @SID_22
  Scenario: Show Top Attacking By GeoLocation Report without Summary Table after edit html format
    Then UI Click Button "Log Preview" with value "Top Attacking By GeoLocation Report without Summary Table_0"
    Then UI Validate Element Existence By Label "Total Summary Table" if Exists "false"

  @SID_23
  Scenario: Delete report Top Attacking By GeoLocation Report without Summary Table
    Then UI Delete Report With Name "Top Attacking By GeoLocation Report without Summary Table"

  @SID_24
  Scenario: old reports on file-system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"

  @SID_25
  Scenario: Create and Generate New Report with 10 plus countries

    Given UI "Create" Report With Name "Top 10 Attacking by GeoLocation"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attacking Geolocations], devices:[All], showTable:true |
      | Format   | Select: CSV                                                                                         |
    Then UI "Validate" Report With Name "Top 10 Attacking by GeoLocation"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attacking Geolocations], devices:[All], showTable:true |
      | Format   | Select: CSV                                                                                         |
    Then UI "Generate" Report With Name "Top 10 Attacking by GeoLocation"
      | timeOut | 90 |


  @SID_26
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then Sleep "20"


    #############################  Validate Top Attacking By GeoLocation CSV ####################################################

  @SID_27
  Scenario: VRM report validate New Report with 10 plus countries number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "14"
    Then Sleep "10"


  @SID_28
  Scenario: VRM report validate New Report with 10 plus countries headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Country"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Count"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Percent"
    Then Sleep "10"


  @SID_29
  Scenario:VRM report validate New Report with 10 plus countries content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -2|tail -1|grep -oP "Multiple,1,10.0000" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Multiple"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "10.0000"
    Then Sleep "10"

  @SID_30
  Scenario:VRM report validate New Report with 10 plus countries content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -3|tail -1|grep -oP "CN,1,10.0000" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "CN"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "10.0000"

  @SID_31
  Scenario:VRM report validate New Report with 10 plus countries content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -4|tail -1|grep -oP "FR,1,10.0000" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -4|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "FR"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -4|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -4|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "10.0000"

  @SID_32
  Scenario:VRM report validate New Report with 10 plus countries content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -5|tail -1|grep -oP "IN,1,10.0000" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -5|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "IN"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -5|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -5|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "10.0000"

  @SID_33
  Scenario:VRM report validate New Report with 10 plus countries content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -6|tail -1|grep -oP "KR,1,10.0000" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -6|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "KR"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -6|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -6|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "10.0000"

  @SID_34
  Scenario:VRM report validate New Report with 10 plus countries content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -7|tail -1|grep -oP "LT,1,10.0000" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -7|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "LT"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -7|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -7|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "10.0000"

  @SID_35
  Scenario:VRM report validate New Report with 10 plus countries content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -8|tail -1|grep -oP "MD,1,10.0000" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -8|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "MD"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -8|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -8|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "10.0000"

  @SID_36
  Scenario:VRM report validate New Report with 10 plus countries content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -9|tail -1|grep -oP "MX,1,10.0000" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -9|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "MX"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -9|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -9|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "10.0000"

  @SID_37
  Scenario:VRM report validate New Report with 10 plus countries content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -10|tail -1|grep -oP "SE,1,10.0000" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -10|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "SE"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -10|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -10|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "10.0000"

  @SID_38
  Scenario:VRM report validate New Report with 10 plus countries content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -11|tail -1|grep -oP "SG,1,10.0000" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -11|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "SG"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -11|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -11|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "10.0000"

  @SID_39
  Scenario:VRM report validate New Report with 10 plus countries content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -13|tail -1|grep -oP "Total Count,,10" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -13|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Total Count"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -13|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "10"

  @SID_40
  Scenario:VRM report validate New Report with 10 plus countries content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|tail -1|grep -oP "Total Hits,,12" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Total Hits"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "12"


  @SID_41
  Scenario: Delete report Top Attacking By GeoLocation Report without Summary Table
    Then UI Delete Report With Name "Top 10 Attacking by GeoLocation"


  @SID_42
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    Given CLI Reset radware password
    * REST Delete ES index "dp-*"


  @SID_43
  Scenario: Run DP simulator PCAPs for "GEO" and "ErtFeed_GeoFeed"
    Given CLI simulate 1 attacks of type "GEO" on "DefensePro" 10 and wait 0 seconds
    Given CLI simulate 1 attacks of type "ErtFeed_GeoFeed" on "DefensePro" 10 and wait 60 seconds
    * CLI kill all simulator attacks on current vision

  @SID_44
  Scenario: create new Top Attacking By GeoLocation Report with Summary Table
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacking By GeoLocation Report with Summary Table"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attacking Geolocations],devices:[All],showTable:true |
      | Format   | Select: PDF                                                                                       |
    Then UI "Validate" Report With Name "Top Attacking By GeoLocation Report with Summary Table"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attacking Geolocations],devices:[All],showTable:true |
      | Format   | Select: PDF                                                                                       |
    Then UI "Generate" Report With Name "Top Attacking By GeoLocation Report with Summary Table"
      | timeOut | 90 |

  @SID_45
  Scenario: Show Top Attacking By GeoLocation Report with Summary Table after the create
    Then UI Click Button "Log Preview" with value "Top Attacking By GeoLocation Report with Summary Table_0"
    Then UI Text of "Total Summary Table" equal to "Total (for all countries):3"

  @SID_46
  Scenario: create new Top Attacking By GeoLocation without summary table
    Given UI "Create" Report With Name "Top Attacking By GeoLocation Report without Summary Table"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attacking Geolocations],devices:[All],showTable:false |
      | Format   | Select: PDF                                                                                        |
    Then UI "Validate" Report With Name "Top Attacking By GeoLocation Report without Summary Table"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attacking Geolocations],devices:[All],showTable:false |
      | Format   | Select: PDF                                                                                        |
    Then UI "Generate" Report With Name "Top Attacking By GeoLocation Report without Summary Table"
      | timeOut | 90 |

  @SID_47
  Scenario: Show Top Attacking By GeoLocation Report without Summary Table
    Then UI Click Button "Log Preview" with value "Top Attacking By GeoLocation Report without Summary Table_0"
    Then UI Validate Element Existence By Label "Total Summary Table" if Exists "false"

  @SID_48
  Scenario: old reports on file-system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"

  @SID_49
  Scenario: Create and Generate New Report with Exclude Malicious IP Addresses
    Then UI Navigate to "AMS REPORTS" page via homepage
    Given UI "Create" Report With Name "Exclude Top Attacking by GeoLocation"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attacking Geolocations], devices:[All], ExcludeMaliciousIPAddresses:true |
      | Format   | Select: CSV                                                                                                           |
    Then UI "Validate" Report With Name "Exclude Top Attacking by GeoLocation"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attacking Geolocations], devices:[All], ExcludeMaliciousIPAddresses:true |
      | Format   | Select: CSV                                                                                                           |
    Then UI "Generate" Report With Name "Exclude Top Attacking by GeoLocation"
      | timeOut | 90 |

  @SID_50
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then Sleep "10"


    #############################  Validate Top Attacking By GeoLocation CSV ####################################################

  @SID_51
  Scenario: VRM report validate CSV Exclude Top Attacking by GeoLocation number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "6"
    Then Sleep "10"


  @SID_52
  Scenario: VRM report validate CSV file Exclude Top Attacking by GeoLocation headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Country"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Count"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Percent"
    Then Sleep "10"


  @SID_53
  Scenario:VRM report validate CSV file Exclude Top Attacking by GeoLocation content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -2|tail -1|grep -oP "CN,1,50.0000" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "CN"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "50.0000"
    Then Sleep "10"

  @SID_54
  Scenario:VRM report validate CSV file Exclude Top Attacking by GeoLocation content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -3|tail -1|grep -oP "Multiple,1,50.0000" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Multiple"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -3|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "50.0000"

  @SID_55
  Scenario:VRM report validate CSV file Exclude Top Attacking by GeoLocation content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -5|tail -1|grep -oP "Total Count,,2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -5|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Total Count"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|head -5|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_56
  Scenario:VRM report validate CSV file Exclude Top Attacking by GeoLocation content
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|tail -1|grep -oP "Total Hits,,2" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Total Hits"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top\ Attacking\ Geolocations-DefensePro\ Analytics.csv|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "2"

  @SID_57
  Scenario: Delete report Exclude Top Attacking by GeoLocation
    Then UI Delete Report With Name "Exclude Top Attacking by GeoLocation"

  @SID_58
  Scenario: Logout and close browser
    Given UI logout and close browser