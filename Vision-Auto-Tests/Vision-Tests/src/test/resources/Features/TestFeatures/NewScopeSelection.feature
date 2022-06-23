@TestScopeSelection
Feature: New Scope Selection Implementation

  Scenario: Login and Navigate to AMS REPORTS Page
    Given UI Login with user "radware" and password "radware"
#    Then UI Navigate to "AMS REPORTS" page via homepage

#----------Tests------------

#    Given UI "Create" Report With Name "DefensePro Behavioral Protections Report"
#      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,bps,Inbound]}] ,devices:[{SetId:DefensePro_Set_2, devicePolicies:[1_https]}] |
#      | Time Definitions.Date | Relative:[Months,3]                                                                                                                              |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                      |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                   |
#      | Format                | Select: CSV                                                                                                                                      |
#    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report"
#      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,bps,Inbound]}] ,devices:[{SetId:DefensePro_Set_2, devicePolicies:[1_https]}] |
#      | Time Definitions.Date | Relative:[Months,3]                                                                                                                              |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                      |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                   |
#      | Format                | Select: CSV                                                                                                                                      |
#    Given UI "Create" Report With Name "DefensePro Analytics Report"
#      | Template | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[{SetId:DefensePro_Set_21, devicePolicies:[EAAF,EAAF2]}],showTable:true |
#    Then UI "Validate" Report With Name "DefensePro Analytics Report"
#      | Template | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[{SetId:DefensePro_Set_21, devicePolicies:[EAAF,EAAF2]}],showTable:true |
#
#  Scenario: Edit DefensePro Analytics Report
#    Then UI Click Button "My Report Tab"
#    Then UI Click Button "Edit Report" with value "DefensePro Analytics Report"
#    Then UI "Select" Scope Polices
#      | devices | type:DefensePro Analytics,SetId:DefensePro_Set_21,policies:[EAAF,EAAF2,EAAF3] |
#    Then UI Click Button "save"

#  Scenario: Validate scope policies for DefensePro Analytics Report
#    Then UI Click Button "My Report Tab"
#    Then UI Click Button "Edit Report" with value "DefensePro Analytics Report"
#    Then UI "UnSelect" Scope Polices
#      | devices | type:DefensePro Analytics,SetId:DefensePro_Set_21,policies:[EAAF] |
#    Then UI Click Button "save"


#    Then UI Click Button "My Report Tab"
#    Then UI Click Button "Edit Report" with value "DefensePro Analytics Report"
#    Then UI "Validate" Scope Polices
#      | devices | type:DefensePro Analytics,SetId:DefensePro_Set_21,policies:[EAAF2] |
#    Then UI Click Button "save"
#    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report"
#      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,bps,Inbound]}] ,devices:[{SetId:DefensePro_Set_21, devicePolicies:[EAAF]}] |

#----------AMS REPORTS-------------

#  Scenario: create and validate AMS report
#    Given UI "Create" Report With Name "DefenseFlow Analytics Report1"
#      | Template              | reportType:DefenseFlow Analytics,Protected Objects:[PO_Sravany_test_1,PO_Sravany_test_2],Widgets:[Top Attacks by Duration,Top Attack Destination,Top Attacks by Protocol] |
#      | Time Definitions.Date | Relative:[Days,2]                                                                                                                                           |
#      | Format                | Select: CSV                                                                                                                                                               |
#    Then UI "Edit" Report With Name "DefenseFlow Analytics Report1"
#      | Template              | reportType:DefenseFlow Analytics,Protected Objects:[PO_Sravany_test_3,PO_Sravany_test_2],Widgets:[Top Attacks by Duration,Top Attack Destination,Top Attacks by Protocol] |
#      | Time Definitions.Date | Relative:[Days,2]                                                                                                                                           |
#      | Format                | Select: PDF                                                                                                                                                               |
#
#    Given UI "Create" Report With Name "AppWall Report1"
#      | Template              | reportType:AppWall , Widgets:[OWASP Top 10] , Applications:[hackMe8640] , showTable:false |
#      | Time Definitions.Date | Relative:[Days,2]                                                                         |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                              |
#      | Format                | Select: HTML                                                                              |
#    Then UI "Edit" Report With Name "AppWall Report1"
#      | Template              | reportType:AppWall , Widgets:[OWASP Top 10] , Applications:[hackMe8640] , showTable:false |
#      | Time Definitions.Date | Relative:[Days,2]                                                                         |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                              |
#      | Format                | Select: PDF                                                                              |
#
#    Given UI "Create" Report With Name "ERT Active Attackers Feed Report"
#      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Packets]},{Breakdown by Malicious Activity:[Volume]},{EAAF Hits Timeline:[Attacks]}] ,devices:[{SetId:DefensePro_Set_21, devicePolicies:[All]}] |
#      | Logo                  | reportLogoPNG.png                                                                                                                                                                |
#      | Time Definitions.Date | Quick:15m                                                                                                                                                                        |
#      | Format                | Select: CSV                                                                                                                                                                      |
#    Then UI "Edit" Report With Name "ERT Active Attackers Feed Report"
#      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Packets]},{Breakdown by Malicious Activity:[Volume]},{EAAF Hits Timeline:[Attacks]}] ,devices:[{SetId:DefensePro_Set_21, devicePolicies:[All]}] |
#      | Logo                  | reportLogoPNG.png                                                                                                                                                                |
#      | Time Definitions.Date | Quick:15m                                                                                                                                                                        |
#      | Format                | Select: PDF                                                                                                                                                                      |
#
#    Given UI "Create" Report With Name "ERT Active Attackers Audit Report"
#      | Template              | reportType:ERT Active Attackers Audit Report , Widgets:[ERT Active Attackers Audit Report],devices:[All] |
#      | Time Definitions.Date | Quick:15m                                                                                                |
#      | Format                | Select: CSV                                                                                              |
#    Then UI "Edit" Report With Name "ERT Active Attackers Audit Report"
#      | Template              | reportType:ERT Active Attackers Audit Report , Widgets:[ERT Active Attackers Audit Report],devices:[{SetId:DefensePro_Set_20, devicePolicies:[All]}] |
#      | Time Definitions.Date | Quick:15m                                                                                                |
#      | Format                | Select: PDF                                                                                              |

#    Given UI "Create" Report With Name "HTTPS Flood Report1"
#      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic], Servers:[server_1-DefensePro_Set_21-pol_1] |
#      | Format                | Select: CSV                                                                                                                  |
#      | Logo                  | reportLogoPNG.png                                                                                                            |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                  |
#      | Time Definitions.Date | Quick:Today                                                                                                                  |
#      | Share                 | Email:[sravani.varada@radware.com],Subject:myEdit subject,Body:myEdit body                                               |
#    Then UI "Edit" Report With Name "HTTPS Flood Report1"
#      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic], Servers:[server_1-DefensePro_Set_21-pol1] |
#      | Format                | Select: PDF                                                                                                                  |
#      | Logo                  | reportLogoPNG.png                                                                                                            |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                  |
#      | Time Definitions.Date | Quick:Today                                                                                                                  |
#      | Share                 | Email:[sravani.varada@radware.com],Subject:myEdit subject,Body:myEdit body                                               |

#    Given UI "Create" Report With Name "DefensePro Analytics Report1"
#      | Template              | reportType:DefensePro Analytics, Widgets:[{Traffic Bandwidth:[pps,Outbound,All Policies]}], devices:[{SetId:DefensePro_Set_20, devicePorts:[All], devicePolicies:[All]}] |
#      | Logo                  | reportLogoPNG.png                                                                                                                                                             |
#      | Format                | Select: CSV                                                                                                                                                                   |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                                                                               |
#      | Time Definitions.Date | Quick:Today                                                                                                                                                                   |
#      | share                 | Email:[sravani.varada@radware.com],Subject:mySubject,Body:myBody                                                                                                              |
#    Then UI "Edit" Report With Name "DefensePro Analytics Report1"
#      | Template              | reportType:DefensePro Analytics, Widgets:[{Traffic Bandwidth:[pps,Outbound,All Policies]}], devices:[{SetId:DefensePro_Set_20, devicePorts:[All], devicePolicies:[All]}] |
#      | Logo                  | reportLogoPNG.png                                                                                                                                                             |
#      | Format                | Select: PDF                                                                                                                                                                   |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                                                                               |
#      | Time Definitions.Date | Quick:Today                                                                                                                                                                   |
#      | share                 | Email:[sravani.varada@radware.com],Subject:mySubject,Body:myBody                                                                                                              |

#    Given UI "Create" Report With Name "DefensePro Behavioral Protections Report1"
#      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,bps,Inbound]}] ,devices:[{SetId:DefensePro_Set_21, devicePolicies:[EAAF2]}] |
#      | Time Definitions.Date | Relative:[Months,3]                                                                                                                               |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                             |
#      | Share                 | Email:[sravani.varada@radware.com],Subject:myEdit subject,Body:myEdit body                                                                              |
#      | Format                | Select: CSV                                                                                                                                             |
#    Then UI "Edit" Report With Name "DefensePro Behavioral Protections Report1"
#      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,bps,Inbound]}] ,devices:[{SetId:DefensePro_Set_21, devicePolicies:[EAAF4]}] |
#      | Time Definitions.Date | Relative:[Months,3]                                                                                                                                     |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                             |
#      | Share                 | Email:[sravani.varada@radware.com],Subject:myEdit subject,Body:myEdit body                                                                              |
#      | Format                | Select: PDF                                                                                                                                             |

#----------ADC REPORTS-------------

  Scenario: Create and validate ADC Report
    And UI Navigate to "ADC Reports" page via homePage
#
#    Given UI "Create" Report With Name "ADC Applications Report"
#      | Template              | reportType:Application ,Widgets:[ALL] , Applications:[hackMeBank8640:80] |
#      | Time Definitions.Date | Quick:1H                                                                 |
#      | Format                | Select:  CSV                                                             |
#    Then UI "Edit" Report With Name "ADC Applications Report"
#      | Template              | reportType:Application ,Widgets:[ALL] , Applications:[hackMeBank8640:443] |
#      | Time Definitions.Date | Quick:1H                                                                  |
#      | Format                | Select: PDF                                                               |
#
#    Given UI "Create" Report With Name "ADC Report1"
#      | Template              | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_86.40] |
#      | Time Definitions.Date | Quick:1H                                                                                                   |
#      | Format                | Select:  CSV                                                                                               |
#    Then UI "Edit" Report With Name "ADC Report1"
#      | Template              | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_86.40] |
#      | Time Definitions.Date | Quick:1H                                                                                                   |
#      | Format                | Select:  PDF                                                                                                |

#    Given UI "Create" Report With Name "ADC LinkProof Report1"
#      | Template              | reportType:LinkProof ,Widgets:[Upload Throughput,Download Throughput,CEC] , devices:[Alt_90.20] ,WANLinks:[wan1,wan2] |
#      | Time Definitions.Date | Quick:1H                                                                                                                        |
#      | Format                | Select:  CSV                                                                                                                    |
#    Then UI "Edit" Report With Name "ADC LinkProof Report1"
#      | Template              | reportType:LinkProof ,Widgets:[Upload Throughput,Download Throughput,CEC] , devices:[Alt_90.20] ,WANLinks:[wan1,wan2] |
#      | Time Definitions.Date | Quick:1H                                                                                                                        |
#      | Format                | Select: PDF                                                                                                                     |

#----------FORENSICS Creation-------------

#  Scenario: Navigate to Forensics Page
#    Then UI Navigate to "AMS Forensics" page via homepage
#
#  Scenario: create new Forensics
#    Given UI "Create" Forensics With Name "DP Forensics1"
#      | Product  | DefensePro                                                                             |
#      | Output   | Attack Name                                                                            |
#      | Criteria | condition.All:true                                                                     |
#      | devices  | SetId:DefensePro_Set_21, devicePorts:[AllPorts], devicePolicies:[EAAF2, EAAF4] |
#      | Schedule | Run Every:Monthly, On Time:+6H, At Months:[JUL,AUG]                            |
#      | Format   | Select: CSV                                                                            |
#    Given UI "Edit" Forensics With Name "DP Forensics1"
#      | Product  | DefensePro                                                                             |
#      | Output   | Attack Name                                                                            |
#      | Criteria | condition.All:true                                                                     |
#      | devices  | SetId:DefensePro_Set_21, devicePorts:[AllPorts], devicePolicies:[EAAF3] |
##      | Schedule | Run Every:Monthly, On Time:+6H, At Months:[JUL,AUG]                            |
#      | Format   | Select: HTML                                                                            |
#
#    Given UI "Create" Forensics With Name "AppWall Forensic1"
#      | Product               | AppWall                                                                                                                    |
#      | Application           | hackMe8640                                                                                                                 |
#      | Output                | Destination IP Address,Transaction ID,Source IP,Source Port,Web Application Name,Action,Severity,Threat Category,Device IP |
#      | Format                | Select: CSV                                                                                                                |
#      | Time Definitions.Date | Quick:Today                                                                                                                |
#      | Share                 | Email:[sravani.varada@radware.com],Subject:myEdit subject,Body:myEdit body                                                 |
#    Given UI "Edit" Forensics With Name "AppWall Forensic1"
#      | Product               | AppWall                                                                                                                    |
#      | Application           | hackMe8640                                                                                                                 |
#      | Output                | Destination IP Address,Transaction ID,Source IP,Source Port,Web Application Name,Action,Severity,Threat Category,Device IP |
#      | Format                | Select: HTML                                                                                                                |
#      | Time Definitions.Date | Quick:Today                                                                                                                |
#      | Share                 | Email:[sravani.varada@radware.com],Subject:myEdit subject,Body:myEdit body                                                 |
#
#    Given UI "Create" Forensics With Name "DefenseFlow Forensic2"
#      | Product               | DefenseFlow                                                                                                |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Connection PPS]                                      |
#      | Protected Objects     | PO_Sravany_test_1,PO_Sravany_test_2                                                                        |
#      | Output                | Start Time,End Time,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Max pps,Max bps |
#      | Time Definitions.Date | Quick:1D                                                                                                   |
#      | Format                | Select: CSV                                                                                                |
#      | Share                 | Email:[sravani.varada@radware.com],Subject:myEdit subject,Body:myEdit body                                 |
#    Given UI "Edit" Forensics With Name "DefenseFlow Forensic2"
#      | Product               | DefenseFlow                                                                                                |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Connection PPS]                                      |
#      | Protected Objects     | PO_Sravany_test_1,PO_Sravany_test_2                                                                        |
#      | Output                | Start Time,End Time,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Max pps,Max bps |
#      | Time Definitions.Date | Quick:1D                                                                                                   |
#      | Format                | Select: HTML                                                                                                |
#      | Share                 | Email:[sravani.varada@radware.com],Subject:myEdit subject,Body:myEdit body                                 |

#----------Reports Validation------------

#  Scenario: Reports Validation
#    Then UI "Validate" Report With Name "DefenseFlow Analytics Report1"
#      | Template              | reportType:DefenseFlow Analytics,Protected Objects:[PO_Sravany_test_2,PO_Sravany_test_1],Widgets:[Top Attacks by Duration,Top Attack Destination,Top Attacks by Protocol] |
#      | Time Definitions.Date | Relative:[Days,2]                                                                                                                                          |
#      | Format                | Select: PDF                                                                                                                                                               |

#    Then UI "Validate" Report With Name "AppWall Report1"
#      | Template              | reportType:AppWall , Widgets:[OWASP Top 10] , Applications:[hackMe8640] , showTable:false |
#      | Time Definitions.Date | Relative:[Days,2]                                                                         |
##      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                              |
#      | Format                | Select: PDF                                                                              |
#
#    Then UI "Validate" Report With Name "ERT Active Attackers Feed Report"
##      | Template              | reportType:ERT Active Attackers Feed , Widgets:[{Top Malicious IP Addresses:[Packets]},{Breakdown by Malicious Activity:[Volume]},{EAAF Hits Timeline:[Attacks]}] ,devices:[{SetId:DefensePro_Set_21, devicePolicies:[All]}] |
#      | Logo                  | reportLogoPNG.png                                                                                                                                                                |
#      | Time Definitions.Date | Quick:15m                                                                                                                                                                        |
#      | Format                | Select: PDF                                                                                                                                                                      |
#
#    Then UI "Validate" Report With Name "ERT Active Attackers Audit Report"
##      | Template              | reportType:ERT Active Attackers Audit Report , Widgets:[ERT Active Attackers Audit Report],devices:[{SetId:DefensePro_Set_20, devicePolicies:[All]}] |
#      | Time Definitions.Date | Quick:15m                                                                                                |
#      | Format                | Select: CSV                                                                                              |

#    Then UI "Validate" Report With Name "HTTPS Flood Report1"
#      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic], Servers:[server_1-DefensePro_Set_21-pol1] |
#      | Format                | Select: PDF                                                                                                                  |
#      | Logo                  | reportLogoPNG.png                                                                                                            |
#      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                  |
#      | Time Definitions.Date | Quick:Today                                                                                                                  |
#      | Share                 | Email:[sravani.varada@radware.com],Subject:myEdit subject,Body:myEdit body                                               |

#    Then UI "Validate" Report With Name "DefensePro Analytics Report1"
##     | Template              | reportType:DefensePro Analytics, Widgets:[{Traffic Bandwidth:[pps,Outbound,All Policies]}], devices:[{SetId:DefensePro_Set_20, devicePorts:[All], devicePolicies:[All]}]  |
#      | Logo                  | reportLogoPNG.png                                                                                                                                                             |
#      | Format                | Select: PDF                                                                                                                                                                   |
##      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                                                                               |
#      | Time Definitions.Date | Quick:Today                                                                                                                                                                   |
#      | share                 | Email:[sravani.varada@radware.com],Subject:mySubject,Body:myBody                                                                                                              |

#    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report1"
#      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,bps,Inbound]}] ,devices:[{SetId:DefensePro_Set_21, devicePolicies:[EAAF4]}] |
#      | Time Definitions.Date | Relative:[Months,3]                                                                                                                                     |
#      | Share                 | Email:[sravani.varada@radware.com],Subject:myEdit subject,Body:myEdit body                                                                              |
#      | Format                | Select: PDF                                                                                                                                             |
#
#    Then UI "Validate" Report With Name "ADC Applications Report"
#      | Template              | reportType:Application ,Widgets:[ALL] , Applications:[hackMeBank8640:443] |
#      | Time Definitions.Date | Quick:1H                                                                  |
#      | Format                | Select: PDF                                                               |
#
#    Then UI "Validate" Report With Name "ADC Report1"
#      | Template              | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_86.40] |
#      | Time Definitions.Date | Quick:1H                                                                                                   |
#      | Format                | Select:  PDF                                                                                                |

    Then UI "Validate" Report With Name "ADC LinkProof Report1"
      | Template              | reportType:LinkProof ,Widgets:[Upload Throughput,Download Throughput,CEC] , devices:[Alt_90.20] ,WANLinks:[wan1,wan2] |
      | Time Definitions.Date | Quick:1H                                                                                                                        |
      | Format                | Select: PDF                                                                                                                     |

#-----------Forensics Validation---------

#  Scenario: Forensics Validation
#      Given UI "Validate" Forensics With Name "DP Forensics1"
#      | Product  | DefensePro                                                                             |
#      | Output   | Attack Name                                                                            |
#      | Criteria | condition.All:true                                                                     |
#      | devices  | SetId:DefensePro_Set_21, devicePorts:[AllPorts], devicePolicies:[EAAF3] |
##      | Schedule | Run Every:Monthly, On Time:+6H, At Months:[JUL,AUG]                            |
#      | Format   | Select: HTML                                                                            |

#      Given UI "Validate" Forensics With Name "AppWall Forensic1"
#      | Product               | AppWall                                                                                                                    |
#      | Application           | hackMe8640                                                                                                                 |
#      | Output                | Destination IP Address,Transaction ID,Source IP,Source Port,Web Application Name,Action,Severity,Threat Category,Device IP |
#      | Format                | Select: HTML                                                                                                                |
#      | Time Definitions.Date | Quick:Today                                                                                                                |
#      | Share                 | Email:[sravani.varada@radware.com],Subject:myEdit subject,Body:myEdit body                                                 |
#
#      Given UI "Validate" Forensics With Name "DefenseFlow Forensic2"
#      | Product               | DefenseFlow                                                                                                |
#      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Connection PPS]                                      |
#      | Protected Objects     | PO_Sravany_test_1,PO_Sravany_test_2                                                                        |
#      | Output                | Start Time,End Time,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Max pps,Max bps |
#      | Time Definitions.Date | Quick:1D                                                                                                   |
#      | Format                | Select: HTML                                                                                                |
#      | Share                 | Email:[sravani.varada@radware.com],Subject:myEdit subject,Body:myEdit body                                 |

#------------ALERTS Creation-----------

#  Scenario: Navigate to Alerts
#    And UI Navigate to "AMS Alerts" page via homePage
#
#  Scenario: Create Alert Delivery
#    When UI "Create" Alerts With Name "Alert Delivery"
#      | Product    | Appwall                                                                                                                     |
#      | Basic Info | Description:Alert Delivery Description,Impact: Our network is down,Remedy: Please protect real quick!,Severity:Critical     |
#      | Criteria   | Event Criteria:Action,Operator:Not Equals,Value:[Blocked];                                                                  |
#      | Schedule   | checkBox:Trigger,alertsPerHour:60                                                                                           |
#      | Share      | Email:[automation.vision1@alert.local, automation.vision2@alert.local],Subject:Alert Delivery Subj,Body:Alert Delivery Body |

#
#----------------------------------------------------------------------

#    Then UI Navigate to "DefensePro Monitoring Dashboard" page via homepage
#
#  Scenario: Select policies in DP monitoring dashboard
#    Then UI "Select" Scope Polices
#      | devices | type:DefensePro Analytics,SetId:DefensePro_Set_20,policies:[EAAF2, EAAF4, PO_100] |
##      | devices | type:DefensePro Behavioral Protections,SetId:DefensePro_Set_1,policies:[SGNS-Global-12] |
#
#  Scenario: Unselect one policy in DP monitoring dashboard
#    Then UI "UnSelect" Scope Polices
#      | devices | type:DefensePro Analytics,SetId:DefensePro_Set_20,policies:[EAAF2] |
#
#  Scenario: Validate policy in DP monitoring dashboard
#    Then UI "Validate" Scope Polices
#      | devices | type:DefensePro Analytics,SetId:DefensePro_Set_20,policies:[EAAF4, PO_100] |