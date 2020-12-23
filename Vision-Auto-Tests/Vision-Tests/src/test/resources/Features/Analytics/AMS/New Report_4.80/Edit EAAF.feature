Feature: Edit EAAF tests

  @SID_1
  Scenario: Login
    Then UI Login with user "sys_admin" and password "radware"

  @SID_2
  Scenario: Navigate to NEW REPORTS page
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_3
  Scenario: Create and validate EAAF Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "EAAF Report"
      | Template-1            | reportType:EAAF , Widgets:[{Top Malicious IP Addresses:[Packets]}]    |
      | Template-2            | reportType:EAAF , Widgets:[Total Hits Summary]                        |
      | Logo                  | reportLogoPNG.png                                                     |
      | Time Definitions.Date | Quick:1D                                                              |
      | Schedule              | Run Every:Daily ,On Time:+2m                                          |
      | share                 | Email:[automation.vision1@radw are.com],Subject:mySubject,Body:myBody |
      | Format                | Select: PDF                                                           |
    Then UI "Validate" Report With Name "EAAF Report"
      | Template-1            | reportType:EAAF , Widgets:[{Top Malicious IP Addresses:[Packets]}]   |
      | Template-2            | reportType:EAAF , Widgets:[Total Hits Summary]                       |
      | Logo                  | reportLogoPNG.png                                                    |
      | Time Definitions.Date | Quick:1D                                                             |
      | Schedule              | Run Every:Daily ,On Time:+2m                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody |
      | Format                | Select: PDF                                                          |


  @SID_4
  Scenario: Add Template Widget to EAAF
    Given UI "Edit" Report With Name "EAAF Report"
      | Template-1 | reportType:EAAF , AddWidgets:[{Top Attacking Geolocations:[Events]}] |
    Then UI "Validate" Report With Name "EAAF Report"
      | Template-1 | reportType:EAAF , Widgets:[{Top Malicious IP Addresses:[Packets]},{Top Attacking Geolocations:[Events]}] |


  @SID_5
  Scenario: Delete Template Widget from EAAF
    Given UI "Edit" Report With Name "EAAF Report"
      | Template-1 | reportType:EAAF , DeleteWidgets:[{Top Attacking Geolocations:[Events]}] |
    Then UI "Validate" Report With Name "EAAF Report"
      | Template-1 | reportType:EAAF , Widgets:[{Top Malicious IP Addresses:[Packets]}] |


  @SID_6
  Scenario:Add Template to EAAF Report
    Given UI "Edit" Report With Name "EAAF Report"
      | Template-3 | reportType:EAAF , Widgets:[{EAAF Hits Timeline:[Volume]}] |
    Then UI "Validate" Report With Name "EAAF Report"
      | Template-1 | reportType:EAAF , Widgets:[{Top Malicious IP Addresses:[Packets]}] |
      | Template-2 | reportType:EAAF , Widgets:[Total Hits Summary]                     |
      | Template-3 | reportType:EAAF , Widgets:[{EAAF Hits Timeline:[Volume]}]          |

  @SID_7
  Scenario: Delete Template from EAAF
    Given UI "Edit" Report With Name "EAAF Report"
      | Template-3 | DeleteTemplate:true |
    Then UI "Validate" Report With Name "EAAF Report"
      | Template-1 | reportType:EAAF , Widgets:[{Top Malicious IP Addresses:[Packets]}] |
      | Template-2 | reportType:EAAF , Widgets:[Total Hits Summary]                     |


  @SID_8
  Scenario: Create and validate EAAF Report2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "EAAF Report2"
      | Template              | reportType:EAAF , Widgets:[Total Hits Summary,{Top Malicious IP Addresses:[Volume]}] |
      | Logo                  | reportLogoPNG.png                                                                    |
      | Time Definitions.Date | Quick:15m                                                                            |
      | Format                | Select: CSV                                                                          |
    Then UI "Validate" Report With Name "EAAF Report2"
      | Template              | reportType:EAAF , Widgets:[Total Hits Summary,{Top Malicious IP Addresses:[Volume]}] |
      | Logo                  | reportLogoPNG.png                                                                    |
      | Time Definitions.Date | Quick:15m                                                                            |
      | Format                | Select: CSV                                                                          |

  @SID_9
  Scenario: Edit DefensePro Analytics Report2 report name
    Then UI Click Button "My Reports Tab"
    Then UI Click Button "Edit Report" with value "EAAF Report2"
    Then UI Set Text Field "Report Name" To "EAAF Report"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'EAAF Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "EAAF Report"?"
    Then UI Click Button "Yes"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'EAAF Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "EAAF Report"?"
    Then UI Click Button "No"

  @SID_10
  Scenario: Delete report
    Then UI Delete Report With Name "EAAF Report"
    Then UI Delete Report With Name "EAAF Report2"

  @SID_11
  Scenario: Logout
    Then UI logout and close browser
