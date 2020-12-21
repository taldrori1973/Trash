Feature: Edit ADC Report tests
#
#  @SID_1
#  Scenario: Clean data before the test
#    * REST Vision Install License Request "vision-reporting-module-ADC"

  @SID_2
  Scenario: Login
    Then UI Login with user "sys_admin" and password "radware"
#
#  @SID_3
#  Scenario: Run DP simulator PCAPs for "System and Network"                               |

  @SID_4
  Scenario: Navigate to NEW REPORTS page
    Then UI Navigate to "ADC REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_5
  Scenario: Create and validate ADC Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "ADC Report"
      | Template-1            | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[app:80]                          |
      | Template-2            | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.17] |
      | Logo                  | reportLogoPNG.png                                                                                         |
      | Time Definitions.Date | Quick:1D                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                      |
      | Format                | Select: PDF                                                                                               |
    Then UI "Validate" Report With Name "ADC Report"
      | Template-1            | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[app:80]                          |
      | Template-2            | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.17] |
      | Logo                  | reportLogoPNG.png                                                                                         |
      | Time Definitions.Date | Quick:1D                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                      |
      | Format                | Select: PDF                                                                                               |

  @SID_6
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "ADC Report"
    Then UI Click Button "Generate Report Manually" with value "ADC Report"
    Then Sleep "35"
    #todo validate data Ramez

  @SID_7
  Scenario: Add Template Widget to ADC Report
    Given UI "Edit" Report With Name "ADC Report"
      | Template-1 | reportType:Application ,AddWidgets:[End-to-End Time] , Applications:[app:80] |
    Then UI "Validate" Report With Name "ADC Report"
      | Template-1 | reportType:Application ,Widgets:[Concurrent Connections,End-to-End Time] , Applications:[app:80] |

  @SID_9
  Scenario: Delete Template from ADC Report
    Given UI "Edit" Report With Name "ADC Report"
      | Template-2 | DeleteTemplate:true |
    Then UI "Validate" Report With Name "ADC Report"
      | Template-1 | reportType:Application ,Widgets:[Concurrent Connections,End-to-End Time] , Applications:[app:80] |

  @SID_11
  Scenario: Delete Template Widget from ADC Report
    Given UI "Edit" Report With Name "ADC Report"
      | Template-1 | reportType:Application ,DeleteWidgets:[Concurrent Connections] , Applications:[app:80] |
    Then UI "Validate" Report With Name "ADC Report"
      | Template-1 | reportType:Application ,Widgets:[End-to-End Time] , Applications:[app:80] |

  @SID_13
  Scenario: Create and validateADC Report2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "ADC Report2"
      | Template-1            | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[app:80]                          |
      | Template-2            | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.17] |
      | Logo                  | reportLogoPNG.png                                                                                         |
      | Time Definitions.Date | Quick:1D                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                      |
      | Format                | Select: PDF                                                                                               |
    Then UI "Validate" Report With Name "ADC Report2"
      | Template-1            | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[app:80]                          |
      | Template-2            | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.17] |
      | Logo                  | reportLogoPNG.png                                                                                         |
      | Time Definitions.Date | Quick:1D                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                      |
      | Format                | Select: PDF                                                                                               |

  @SID_14
  Scenario: Edit ADC Report2 report name
    Then UI Click Button "My Report Tab"
    Then UI Click Button "Edit Reports" with value "ADC Report2"
    Then UI Set Text Field "Report Name" To "ADC Report"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'ADC Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "ADC Report"?"
    Then UI Click Button "Yes"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'ADC Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "ADC Report"?"
    Then UI Click Button "No"

  @SID_15
  Scenario: Delete report
    Then UI Delete Report With Name "ADC Report"
    Then UI Delete Report With Name "ADC Report2"

  @SID_16
  Scenario: Logout
    Then UI logout and close browser
