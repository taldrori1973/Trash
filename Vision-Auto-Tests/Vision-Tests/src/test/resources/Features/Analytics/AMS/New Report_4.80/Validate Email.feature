@TC118847
Feature: Validate Email
  @SID_1
  Scenario: VRM - enabling emailing and go to VRM Reports Tab
    Given Setup email server
    Then UI Login with user "radware" and password "radware"
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

  @SID_2
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_3
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

  @SID_4
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"

  @SID_5
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

  @SID_6
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_7
  Scenario: Edit The Format to PDF and validate DefensePro Analytics Report
    Then UI "Edit" Report With Name "DefensePro Analytics Report"
      | Format | Select: PDF |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Format | Select: PDF |

  @SID_8
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"

  @SID_9
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

  @SID_10
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_11
  Scenario: Edit The Format to HTML and validate DefensePro Analytics Report
    Then UI "Edit" Report With Name "DefensePro Analytics Report"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Format | Select: HTML |

  @SID_12
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"

  @SID_13
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

  @SID_14
  Scenario: Delete report
    Then UI Delete Report With Name "DefensePro Analytics Report"

  @SID_15
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_16
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

  @SID_17
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "HTTPS Flood Report"
    Then UI Click Button "Generate Report Manually" with value "HTTPS Flood Report"
    Then Sleep "35"

  @SID_18
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

  @SID_19
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_20
  Scenario: Edit The Format to PDF and validate HTTPS Flood Report
    Then UI "Edit" Report With Name "HTTPS Flood Report"
      | Format | Select: PDF |
    Then UI "Validate" Report With Name "HTTPS Flood Report"
      | Format | Select: PDF |

  @SID_21
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "HTTPS Flood Report"
    Then UI Click Button "Generate Report Manually" with value "HTTPS Flood Report"
    Then Sleep "35"

  @SID_22
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

  @SID_23
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_24
  Scenario: Edit The Format to HTML and validate HTTPS Flood Report
    Then UI "Edit" Report With Name "HTTPS Flood Report"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "HTTPS Flood Report"
      | Format | Select: HTML |

  @SID_25
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "HTTPS Flood Report"
    Then UI Click Button "Generate Report Manually" with value "HTTPS Flood Report"
    Then Sleep "35"

  @SID_26
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

  @SID_27
  Scenario: Delete report
    Then UI Delete Report With Name "HTTPS Flood Report"

  @SID_28
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_29
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

  @SID_30
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefenseFlow Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefenseFlow Analytics Report"
    Then Sleep "35"

  @SID_31
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

  @SID_32
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_33
  Scenario: Edit The Format to PDF and validate DefenseFlow Analytics Report
    Then UI "Edit" Report With Name "DefenseFlow Analytics Report"
      | Format | Select: PDF |
    Then UI "Validate" Report With Name "DefenseFlow Analytics Report"
      | Format | Select: PDF |

  @SID_34
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefenseFlow Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefenseFlow Analytics Report"
    Then Sleep "35"

  @SID_35
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

  @SID_36
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_37
  Scenario: Edit The Format to HTML and validate DefenseFlow Analytics Report
    Then UI "Edit" Report With Name "DefenseFlow Analytics Report"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "DefenseFlow Analytics Report"
      | Format | Select: HTML |

  @SID_38
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefenseFlow Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefenseFlow Analytics Report"
    Then Sleep "35"

  @SID_39
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

  @SID_40
  Scenario: Delete report
    Then UI Delete Report With Name "DefenseFlow Analytics Report"

  @SID_41
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_42
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

  @SID_43
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Behavioral Protections Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Behavioral Protections Report"
    Then Sleep "35"

  @SID_44
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

  @SID_45
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_46
  Scenario: Edit The Format to PDF and validate DefensePro Behavioral Protections Report
    Then UI "Edit" Report With Name "DefensePro Behavioral Protections Report"
      | Format | Select: PDF |
    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report"
      | Format | Select: PDF |

  @SID_47
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Behavioral Protections Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Behavioral Protections Report"
    Then Sleep "35"

  @SID_48
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

  @SID_49
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_50
  Scenario: Edit The Format to HTML and validate DefensePro Behavioral Protections Report
    Then UI "Edit" Report With Name "DefensePro Behavioral Protections Report"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report"
      | Format | Select: HTML |

  @SID_51
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Behavioral Protections Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Behavioral Protections Report"
    Then Sleep "35"

  @SID_52
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

  @SID_53
  Scenario: Delete report
    Then UI Delete Report With Name "DefensePro Behavioral Protections Report"

  @SID_54
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_55
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

  @SID_56
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "AppWall Report"
    Then UI Click Button "Generate Report Manually" with value "AppWall Report"
    Then Sleep "35"

  @SID_57
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

  @SID_58
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_59
  Scenario: Edit The Format to PDF and validate AppWall Report
    Then UI "Edit" Report With Name "AppWall Report"
      | Format | Select: PDF |
    Then UI "Validate" Report With Name "AppWall Report"
      | Format | Select: PDF |

  @SID_60
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "AppWall Report"
    Then UI Click Button "Generate Report Manually" with value "AppWall Report"
    Then Sleep "35"

  @SID_61
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

  @SID_62
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_63
  Scenario: Edit The Format to HTML and validate AppWall Report
    Then UI "Edit" Report With Name "AppWall Report"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "AppWall Report"
      | Format | Select: HTML |

  @SID_64
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "AppWall Report"
    Then UI Click Button "Generate Report Manually" with value "AppWall Report"
    Then Sleep "35"

  @SID_65
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

  @SID_66
  Scenario: Delete report
    Then UI Delete Report With Name "AppWall Report"

  @SID_67
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_68
  Scenario: Create and Validate EAAF Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "EAAF Report"
      | Template | reportType:EAAF , Widgets:[Total Hits Summary]      |
      | Share    | Email:[maha],Subject:Validate Email,Body:Email Body |
      | Format   | Select: CSV                                         |
    Then UI "Validate" Report With Name "EAAF Report"
      | Template | reportType:EAAF , Widgets:[Total Hits Summary]      |
      | Share    | Email:[maha],Subject:Validate Email,Body:Email Body |
      | Format   | Select: CSV                                         |

  @SID_69
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "EAAF Report"
    Then UI Click Button "Generate Report Manually" with value "EAAF Report"
    Then Sleep "35"

  @SID_70
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

  @SID_71
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_72
  Scenario: Edit The Format to PDF and validate EAAF Report
    Then UI "Edit" Report With Name "EAAF Report"
      | Format | Select: PDF |
    Then UI "Validate" Report With Name "EAAF Report"
      | Format | Select: PDF |

  @SID_73
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "EAAF Report"
    Then UI Click Button "Generate Report Manually" with value "EAAF Report"
    Then Sleep "35"

  @SID_74
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

  @SID_75
  Scenario: Clear SMTP server log files
    Given Clear email history for user "setup"

  @SID_76
  Scenario: Edit The Format to HTML and validate EAAF Report
    Then UI "Edit" Report With Name "EAAF Report"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "EAAF Report"
      | Format | Select: HTML |

  @SID_77
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "EAAF Report"
    Then UI Click Button "Generate Report Manually" with value "EAAF Report"
    Then Sleep "35"

  @SID_78
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

  @SID_79
  Scenario: Delete report
    Then UI Delete Report With Name "EAAF Report"

  @SID_80
  Scenario: Logout
    Then UI logout and close browser
