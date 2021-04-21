@TC118775
Feature: Edit ADC Report tests

  @SID_1
  Scenario: Login and Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "ADC REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: Create and validate ADC Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "ADC Report"
      | Template-1            | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[6:80]                             |
      | Template-2            | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.17] |
      | Time Definitions.Date | Quick:1D                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                      |
      | Format                | Select:  PDF                                                                                              |
    Then UI "Validate" Report With Name "ADC Report"
      | Template-1            | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[6:80]                             |
      | Template-2            | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.17] |
      | Time Definitions.Date | Quick:1D                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                      |
      | Format                | Select: PDF                                                                                               |

  @SID_3
  Scenario: Add Template Widget to ADC Report
    Given UI "Edit" Report With Name "ADC Report"
      | Template-1 | reportType:Application ,AddWidgets:[End-to-End Time] , Applications:[6:80] |
    Then UI "Validate" Report With Name "ADC Report"
      | Template-1 | reportType:Application ,Widgets:[Concurrent Connections,End-to-End Time] , Applications:[6:80] |

  @SID_4
  Scenario: Delete Template Widget from ADC Report
    Given UI "Edit" Report With Name "ADC Report"
      | Template-1 | reportType:Application ,DeleteWidgets:[End-to-End Time] , Applications:[6:80] |
    Then UI "Validate" Report With Name "ADC Report"
      | Template-1 | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[6:80] |

  @SID_5
  Scenario: Edit Template Applications from ADC Report Report
    Given UI "Edit" Report With Name "ADC Report"
      | Template-2 | reportType:System and Network,Applications:[Alteon_172.17.164.18] |
    Then UI "Validate" Report With Name "ADC Report"
      | Template-2 | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.18] |

  @SID_6
  Scenario:Add Template to ADC Report Report
    Given UI "Edit" Report With Name "ADC Report"
      | Template-3 | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.18] |
    Then UI "Validate" Report With Name "ADC Report"
      | Template-1 | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[6:80]                             |
      | Template-2 | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.18] |
      | Template-3 | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.18] |

  @SID_7
  Scenario: Delete Template from ADC Report
    Given UI "Edit" Report With Name "ADC Report"
      | Template-3 | DeleteTemplate:true |
    Then UI "Validate" Report With Name "ADC Report"
      | Template-1 | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[6:80]                             |
      | Template-2 | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.18] |

  @SID_8
  Scenario: Create and validateADC Report2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "ADC Report2"
      | Template-1            | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[6:80]                             |
      | Template-2            | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.17] |
      | Time Definitions.Date | Quick:1D                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                      |
      | Format                | Select: PDF                                                                                               |
    Then UI "Validate" Report With Name "ADC Report2"
      | Template-1            | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[6:80]                             |
      | Template-2            | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.17] |
      | Time Definitions.Date | Quick:1D                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                      |
      | Format                | Select: PDF                                                                                               |

  @SID_9
  Scenario: Edit ADC Report2 report name
    Then UI Click Button "My Report Tab"
    Then UI Click Button "Edit Report" with value "ADC Report2"
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

  @SID_10
  Scenario: Delete report
    Then UI Delete Report With Name "ADC Report"
    Then UI Delete Report With Name "ADC Report2"

  @SID_11
  Scenario: Logout
    Then UI logout and close browser
