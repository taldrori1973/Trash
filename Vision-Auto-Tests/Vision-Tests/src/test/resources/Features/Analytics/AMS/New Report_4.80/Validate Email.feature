@TC118847
Feature: Validate Email

  @SID_1
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    Given CLI Reset radware password
    * REST Delete ES index "dp-*"
    Given CLI Run remote linux Command "service vision restart" on "ROOT_SERVER_CLI" and wait 185 seconds

  @SID_2
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." with timeOut 240

  @SID_3
  Scenario: Clear Database and old reports on file-system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario: Update Policies
    Given REST Login with user "radware" and password "radware"
    Then REST Update Policies for All DPs

  @SID_5
  Scenario:Login and Navigate to HTTPS Server Dashboard
    Then UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given Rest Add Policy "pol1" To DP "172.16.22.51" if Not Exist
    And Rest Add new Rule "https_servers_automation" in Profile "ProfileHttpsflood" to Policy "pol1" to DP "172.16.22.51"
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query?conflicts=proceed -d '{"query":{"term":{"deviceIp":"172.16.22.50"}},"script":{"source":"ctx._source.endTime='$(date +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"

  @SID_6
  Scenario: Run DP simulator PCAPs for "HTTPS attacks"
    Given CLI simulate 2 attacks of type "HTTPS" on "DefensePro" 11 with loopDelay 5000 and wait 60 seconds

  @SID_7
  Scenario: VRM - enabling emailing and go to VRM Reports Tab
    Given Setup email server
#    Then UI Login with user "radware" and password "radware"
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

  @SID_8
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_9
  Scenario: Create and Validate DefensePro Analytics Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DefensePro Analytics Report"
      | Template | reportType:DefensePro Analytics , Widgets:[Connections Rate]  ,devices:[All] |
      | Share    | Email:[maha],Subject:Validate Email,Body:Email Body                          |
      | Format   | Select: CSV                                                                  |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Template | reportType:DefensePro Analytics , Widgets:[Connections Rate]  ,devices:[All] |
      | Share    | Email:[maha],Subject:Validate Email,Body:Email Body                          |
      | Format   | Select: CSV                                                                  |

  @SID_10
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"

  @SID_11
  Scenario: Validate Report Email received content
    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@Radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: maha@.*.local"" EQUALS "1"
    #Attachment
    Then Validate "setup" user eMail expression "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).zip"" EQUALS "1"

  @SID_12
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_13
  Scenario: Edit The Format to PDF and validate DefensePro Analytics Report
    Then UI "Edit" Report With Name "DefensePro Analytics Report"
      | Format | Select: PDF |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Format | Select: PDF |

  @SID_14
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"

  @SID_15
  Scenario: Validate Report Email received content
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

  @SID_16
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_17
  Scenario: Edit The Format to HTML and validate DefensePro Analytics Report
    Then UI "Edit" Report With Name "DefensePro Analytics Report"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Format | Select: HTML |

  @SID_18
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"

  @SID_19
  Scenario: Validate Report Email received content
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

  @SID_20
  Scenario: Delete report
    Then UI Delete Report With Name "DefensePro Analytics Report"

  @SID_21
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_22
  Scenario: Create and Validate HTTPS Flood Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "HTTPS Flood Report"
      | Template | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[test-DefensePro_172.16.22.51-pol1] |
      | Share    | Email:[maha],Subject:Validate Email,Body:Email Body                                          |
      | Format   | Select: CSV                                                                                  |
    Then UI "Validate" Report With Name "HTTPS Flood Report"
      | Template | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[test-DefensePro_172.16.22.51-pol1] |
      | Share    | Email:[maha],Subject:Validate Email,Body:Email Body                                          |
      | Format   | Select: CSV                                                                                  |

  @SID_23
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "HTTPS Flood Report"
    Then UI Click Button "Generate Report Manually" with value "HTTPS Flood Report"
    Then Sleep "35"

  @SID_24
  Scenario: Validate Report Email received content
    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@Radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: maha@.*.local"" EQUALS "1"
    #Attachment
    Then Validate "setup" user eMail expression "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).zip"" EQUALS "1"

  @SID_25
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_26
  Scenario: Edit The Format to PDF and validate HTTPS Flood Report
    Then UI "Edit" Report With Name "HTTPS Flood Report"
      | Format | Select: PDF |
    Then UI "Validate" Report With Name "HTTPS Flood Report"
      | Format | Select: PDF |

  @SID_27
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "HTTPS Flood Report"
    Then UI Click Button "Generate Report Manually" with value "HTTPS Flood Report"
    Then Sleep "35"

  @SID_28
  Scenario: Validate Report Email received content
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

  @SID_29
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_30
  Scenario: Edit The Format to HTML and validate HTTPS Flood Report
    Then UI "Edit" Report With Name "HTTPS Flood Report"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "HTTPS Flood Report"
      | Format | Select: HTML |

  @SID_31
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "HTTPS Flood Report"
    Then UI Click Button "Generate Report Manually" with value "HTTPS Flood Report"
    Then Sleep "35"

  @SID_32
  Scenario: Validate Report Email received content
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

  @SID_33
  Scenario: Delete report
    Then UI Delete Report With Name "HTTPS Flood Report"

  @SID_34
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_35
  Scenario: Create and Validate DefenseFlow Analytics Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DefenseFlow Analytics Report"
      | Template | reportType:DefenseFlow Analytics,Widgets:[Top 10 Activations by Attack Rate (Gbps)],Protected Objects:[PO Name Space],showTable:true |
      | Share    | Email:[maha],Subject:Validate Email,Body:Email Body                                                                                  |
      | Format   | Select: CSV                                                                                                                          |
    Then UI "Validate" Report With Name "DefenseFlow Analytics Report"
      | Template | reportType:DefenseFlow Analytics,Widgets:[Top 10 Activations by Attack Rate (Gbps)],Protected Objects:[PO Name Space],showTable:true |
      | Share    | Email:[maha],Subject:Validate Email,Body:Email Body                                                                                  |
      | Format   | Select: CSV                                                                                                                          |

  @SID_36
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefenseFlow Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefenseFlow Analytics Report"
    Then Sleep "35"

  @SID_37
  Scenario: Validate Report Email received content
    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@Radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: maha@.*.local"" EQUALS "1"
    #Attachment
    Then Validate "setup" user eMail expression "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).zip"" EQUALS "1"

  @SID_38
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_39
  Scenario: Edit The Format to PDF and validate DefenseFlow Analytics Report
    Then UI "Edit" Report With Name "DefenseFlow Analytics Report"
      | Format | Select: PDF |
    Then UI "Validate" Report With Name "DefenseFlow Analytics Report"
      | Format | Select: PDF |

  @SID_40
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefenseFlow Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefenseFlow Analytics Report"
    Then Sleep "35"

  @SID_41
  Scenario: Validate Report Email received content
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

  @SID_42
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_43
  Scenario: Edit The Format to HTML and validate DefenseFlow Analytics Report
    Then UI "Edit" Report With Name "DefenseFlow Analytics Report"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "DefenseFlow Analytics Report"
      | Format | Select: HTML |

  @SID_44
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefenseFlow Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefenseFlow Analytics Report"
    Then Sleep "35"

  @SID_45
  Scenario: Validate Report Email received content
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

  @SID_46
  Scenario: Delete report
    Then UI Delete Report With Name "DefenseFlow Analytics Report"

  @SID_47
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_48
  Scenario: Create and Validate DefensePro Behavioral Protections Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DefensePro Behavioral Protections Report"
      | Template | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Share    | Email:[maha],Subject:Validate Email,Body:Email Body                                                                                               |
      | Format   | Select: CSV                                                                                                                                      |
    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report"
      | Template | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Share    | Email:[maha],Subject:Validate Email,Body:Email Body                                                                                               |
      | Format   | Select: CSV                                                                                                                                     |

  @SID_49
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Behavioral Protections Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Behavioral Protections Report"
    Then Sleep "35"

  @SID_50
  Scenario: Validate Report Email received content
    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@Radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: maha@.*.local"" EQUALS "1"
    #Attachment
    Then Validate "setup" user eMail expression "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).zip"" EQUALS "1"

  @SID_51
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_52
  Scenario: Edit The Format to PDF and validate DefensePro Behavioral Protections Report
    Then UI "Edit" Report With Name "DefensePro Behavioral Protections Report"
      | Format | Select: PDF |
    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report"
      | Format | Select: PDF |

  @SID_53
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Behavioral Protections Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Behavioral Protections Report"
    Then Sleep "35"

  @SID_54
  Scenario: Validate Report Email received content
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

  @SID_55
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_56
  Scenario: Edit The Format to HTML and validate DefensePro Behavioral Protections Report
    Then UI "Edit" Report With Name "DefensePro Behavioral Protections Report"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report"
      | Format | Select: HTML |

  @SID_57
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Behavioral Protections Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Behavioral Protections Report"
    Then Sleep "35"

  @SID_58
  Scenario: Validate Report Email received content
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

  @SID_59
  Scenario: Delete report
    Then UI Delete Report With Name "DefensePro Behavioral Protections Report"

  @SID_60
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_61
  Scenario: Create and Validate AppWall Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "AppWall Report"
      | Template | reportType:AppWall , Widgets:[OWASP Top 10] , Applications:[All] , showTable:true |
      | Share    | Email:[maha],Subject:Validate Email,Body:Email Body                               |
      | Format   | Select: CSV                                                                       |
    Then UI "Validate" Report With Name "AppWall Report"
      | Template | reportType:AppWall , Widgets:[OWASP Top 10] , Applications:[All] , showTable:true |
      | Share    | Email:[maha],Subject:Validate Email,Body:Email Body                               |
      | Format   | Select: CSV                                                                       |

  @SID_62
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "AppWall Report"
    Then UI Click Button "Generate Report Manually" with value "AppWall Report"
    Then Sleep "35"

  @SID_63
  Scenario: Validate Report Email received content
    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@Radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: maha@.*.local"" EQUALS "1"
    #Attachment
    Then Validate "setup" user eMail expression "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).zip"" EQUALS "1"

  @SID_64
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_65
  Scenario: Edit The Format to PDF and validate AppWall Report
    Then UI "Edit" Report With Name "AppWall Report"
      | Format | Select: PDF |
    Then UI "Validate" Report With Name "AppWall Report"
      | Format | Select: PDF |

  @SID_66
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "AppWall Report"
    Then UI Click Button "Generate Report Manually" with value "AppWall Report"
    Then Sleep "35"

  @SID_67
  Scenario: Validate Report Email received content
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

  @SID_68
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_69
  Scenario: Edit The Format to HTML and validate AppWall Report
    Then UI "Edit" Report With Name "AppWall Report"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "AppWall Report"
      | Format | Select: HTML |

  @SID_70
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "AppWall Report"
    Then UI Click Button "Generate Report Manually" with value "AppWall Report"
    Then Sleep "35"

  @SID_71
  Scenario: Validate Report Email received content
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

  @SID_72
  Scenario: Delete report
    Then UI Delete Report With Name "AppWall Report"

  @SID_73
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_74
  Scenario: Create and Validate EAAF Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "EAAF Report"
      | Template | reportType:EAAF , Widgets:[Totals in Selected Time Frame]      |
      | Share    | Email:[maha],Subject:Validate Email,Body:Email Body |
      | Format   | Select: CSV                                         |
    Then UI "Validate" Report With Name "EAAF Report"
      | Template | reportType:EAAF , Widgets:[Totals in Selected Time Frame]      |
      | Share    | Email:[maha],Subject:Validate Email,Body:Email Body |
      | Format   | Select: CSV                                         |

  @SID_75
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "EAAF Report"
    Then UI Click Button "Generate Report Manually" with value "EAAF Report"
    Then Sleep "35"

  @SID_76
  Scenario: Validate Report Email received content
    #subject
    Then Validate "setup" user eMail expression "grep "Subject: Validate Email"" EQUALS "1"
    #body
    Then Validate "setup" user eMail expression "grep "Email Body"" EQUALS "1"
    #From
    Then Validate "setup" user eMail expression "grep "From: Automation system <qa_test@Radware.com>"" EQUALS "1"
    #To
    Then Validate "setup" user eMail expression "grep "X-Original-To: maha@.*.local"" EQUALS "1"
    #Attachment
    Then Validate "setup" user eMail expression "grep -oP "Content-Disposition: attachment; filename=VRM_report_(\d{13}).zip"" EQUALS "1"

  @SID_77
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_78
  Scenario: Edit The Format to PDF and validate EAAF Report
    Then UI "Edit" Report With Name "EAAF Report"
      | Format | Select: PDF |
    Then UI "Validate" Report With Name "EAAF Report"
      | Format | Select: PDF |

  @SID_79
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "EAAF Report"
    Then UI Click Button "Generate Report Manually" with value "EAAF Report"
    Then Sleep "35"

  @SID_80
  Scenario: Validate Report Email received content
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

  @SID_81
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_82
  Scenario: Edit The Format to HTML and validate EAAF Report
    Then UI "Edit" Report With Name "EAAF Report"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "EAAF Report"
      | Format | Select: HTML |

  @SID_83
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "EAAF Report"
    Then UI Click Button "Generate Report Manually" with value "EAAF Report"
    Then Sleep "35"

  @SID_84
  Scenario: Validate Report Email received content
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

  @SID_85
  Scenario: Delete report
    Then UI Delete Report With Name "EAAF Report"

  @SID_86
  Scenario: Logout
    Then UI logout and close browser
