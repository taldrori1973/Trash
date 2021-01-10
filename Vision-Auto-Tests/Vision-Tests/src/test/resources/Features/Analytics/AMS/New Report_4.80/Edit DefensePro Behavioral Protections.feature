@TC118804
Feature:Edit DefensePro Behavioral Protections

#  @SID_1
#  Scenario: BDoS baseline widget Settings pre-requisite
#    Given CLI kill all simulator attacks on current vision
#    Given CLI Clear vision logs
#    Then REST Delete ES index "dp-attack
#    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
#    Given CLI simulate 100 attacks of type "rest_bdosdns" on "DefensePro" 10 with loopDelay 15000
#    Given CLI simulate 100 attacks of type "baselines_pol_1" on "DefensePro" 10 with loopDelay 15000 and wait 140 seconds
#
  @SID_1
  Scenario: Login
    Then UI Login with user "radware" and password "radware"


  @SID_2
  Scenario: Navigate to NEW REPORTS page
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_3
  Scenario: Create and validate DefensePro Behavioral Protections Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DefensePro Behavioral Protections Report"
      | Template-1            | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv4]}], devices:[{deviceIndex:10, devicePolicies:[BDOS]}]                             |
      | Template-2            | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv6, bps, Outbound]}], devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Logo                  | reportLogoPNG.png                                                                                                                                       |
      | Time Definitions.Date | Quick:1D                                                                                                                                                |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                                                            |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                                    |
      | Format                | Select: PDF                                                                                                                                             |
    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report"
      | Template-1            | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv4]}], devices:[{deviceIndex:10, devicePolicies:[BDOS]}]                             |
      | Template-2            | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv6, bps, Outbound]}], devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Logo                  | reportLogoPNG.png                                                                                                                                       |
      | Time Definitions.Date | Quick:1D                                                                                                                                                |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                                                            |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                                    |
      | Format                | Select: PDF                                                                                                                                             |


  @SID_4
  Scenario: Add Template Widget to DefensePro Behavioral Protections 1
    Given UI "Edit" Report With Name "DefensePro Behavioral Protections Report"
      | Template-1 | reportType:DefensePro Behavioral Protections, AddWidgets:[{BDoS-UDP:[IPv4, bps,Outbound]}], devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report"
      | Template-1 | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv4]},{BDoS-UDP:[IPv4, bps,Outbound]}], devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |

  @SID_5
  Scenario: Add Template Widget to DefensePro Behavioral Protections 2
    Given UI "Edit" Report With Name "DefensePro Behavioral Protections Report"
      | Template-2 | reportType:DefensePro Behavioral Protections, AddWidgets:[{BDoS-TCP SYN:[IPv6, bps, Outbound]}], devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report"
      | Template-2 | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv6, bps, Outbound]},{BDoS-TCP SYN:[IPv6, bps, Outbound]}], devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |

  @SID_6
  Scenario: Delete Template Widget from DefensePro Behavioral Protections 1
    Given UI "Edit" Report With Name "DefensePro Behavioral Protections Report"
      | Template-2 | reportType:DefensePro Behavioral Protections, DeleteWidgets:[{BDoS-TCP SYN:[IPv6, bps, Outbound]}], devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report"
      | Template-2 | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv6, bps, Outbound]}], devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |

  @SID_7
  Scenario: Edit Template Devices from DefensePro Behavioral Protections Report 1
    Given UI "Edit" Report With Name "DefensePro Behavioral Protections Report"
      | Template-1 | reportType:DefensePro Behavioral Protections,devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report"
      | Template-1 | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv4]},{BDoS-UDP:[IPv4, bps,Outbound]}], devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |

  @SID_8
  Scenario: Edit Template Devices from DefensePro Behavioral Protections Report 2
    Given UI "Edit" Report With Name "DefensePro Behavioral Protections Report"
      | Template-2 | reportType:DefensePro Behavioral Protections,devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report"
      | Template-2 | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv6, bps, Outbound]}], devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |

  @SID_9
  Scenario:Add Template to DefensePro Behavioral Protections Report
    Given UI "Edit" Report With Name "DefensePro Behavioral Protections Report"
      | Template-3 | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN ACK:[IPv4,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report"
      | Template-1 | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv4]},{BDoS-UDP:[IPv4, bps,Outbound]}], devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Template-2 | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv6, bps, Outbound]}], devices:[{deviceIndex:11, devicePolicies:[BDOS]}]     |
      | Template-3 | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN ACK:[IPv4,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[BDOS]}]          |

  @SID_10
  Scenario: Delete Template from DefensePro Behavioral Protections Report
    Given UI "Edit" Report With Name "DefensePro Behavioral Protections Report"
      | Template-3 | DeleteTemplate:true |
    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report"
      | Template-1 | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv4]},{BDoS-UDP:[IPv4, bps,Outbound]}], devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Template-2 | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv6, bps, Outbound]}], devices:[{deviceIndex:11, devicePolicies:[BDOS]}]     |

  @SID_11
  Scenario: Edit The Time and validate
    Then UI "Edit" Report With Name "DefensePro Behavioral Protections Report"
      | Time Definitions.Date | Quick:15m |
    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report"
      | Time Definitions.Date | Quick:15m |

  @SID_12
  Scenario: Edit The Format and validate
    Then UI "Edit" Report With Name "DefensePro Behavioral Protections Report"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report"
      | Format | Select: HTML |

  @SID_13
  Scenario: Create and validate DefensePro Behavioral Protections Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DefensePro Behavioral Protections Report 2"
      | Template-1            | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv4]}], devices:[{deviceIndex:10, devicePolicies:[BDOS]}]                             |
      | Template-2            | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv6, bps, Outbound]}], devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Logo                  | reportLogoPNG.png                                                                                                                                       |
      | Time Definitions.Date | Quick:1D                                                                                                                                                |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                                                            |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                                    |
      | Format                | Select: PDF                                                                                                                                             |
    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report 2"
      | Template-1            | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv4]}], devices:[{deviceIndex:10, devicePolicies:[BDOS]}]                             |
      | Template-2            | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv6, bps, Outbound]}], devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Logo                  | reportLogoPNG.png                                                                                                                                       |
      | Time Definitions.Date | Quick:1D                                                                                                                                                |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                                                            |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                                    |
      | Format                | Select: PDF                                                                                                                                             |

  @SID_14
  Scenario: Edit DefensePro Behavioral Protections Report 2
    Then UI Click Button "My Reports Tab"
    Then UI Click Button "Edit Report" with value "DefensePro Behavioral Protections Report 2"
    Then UI Set Text Field "Report Name" To "DefensePro Behavioral Protections Report"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'DefensePro Behavioral Protections Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "DefensePro Behavioral Protections Report"?"
    Then UI Click Button "Yes"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'DefensePro Behavioral Protections Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "DefensePro Behavioral Protections Report"?"
    Then UI Click Button "No"

  @SID_15
  Scenario: Delete report
    Then UI Delete Report With Name "DefensePro Behavioral Protections Report"
    Then UI Delete Report With Name "DefensePro Behavioral Protections Report 2"

  @SID_16
  Scenario: Logout
    Then UI logout and close browser
