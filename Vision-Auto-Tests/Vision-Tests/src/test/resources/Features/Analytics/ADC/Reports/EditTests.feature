@TC118775
Feature: Edit ADC Report tests

  @SID_1
  Scenario: Login and Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "ADC REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario Outline: Create and validate ADC Report
#    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "<ReportName>"
      | Template-1            | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[<ApplicationName>]               |
      | Template-2            | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.17] |
      | Time Definitions.Date | Quick:1D                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                      |
      | Format                | Select:  PDF                                                                                              |
    Then UI "Validate" Report With Name "<ReportName>"
      | Template-1            | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[<ApplicationName>]               |
      | Template-2            | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.17] |
      | Time Definitions.Date | Quick:1D                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                      |
      | Format                | Select: PDF                                                                                               |

    Examples:
      | ReportName | ApplicationName                                      |
      | ADC Report | Rejith_#convertIpToHexa(Alteon_Set_Simulators_3);:80 |

  @SID_3
  Scenario Outline: Add Template Widget to ADC Report
    Given UI "Edit" Report With Name "<ReportName>"
      | Template-1 | reportType:Application ,AddWidgets:[End-to-End Time] , Applications:[<ApplicationName>] |
    Then UI "Validate" Report With Name "<ReportName>"
      | Template-1 | reportType:Application ,Widgets:[Concurrent Connections,End-to-End Time] , Applications:[<ApplicationName>] |

    Examples:
      | ReportName | ApplicationName                                      |
      | ADC Report | Rejith_#convertIpToHexa(Alteon_Set_Simulators_3);:80 |

  @SID_4
  Scenario Outline: Delete Template Widget from ADC Report
    Given UI "Edit" Report With Name "<ReportName>"
      | Template-1 | reportType:Application ,DeleteWidgets:[End-to-End Time] , Applications:[<ApplicationName>] |
    Then UI "Validate" Report With Name "<ReportName>"
      | Template-1 | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[<ApplicationName>] |

    Examples:
      | ReportName | ApplicationName                                      |
      | ADC Report | Rejith_#convertIpToHexa(Alteon_Set_Simulators_3);:80 |

  @SID_5
  Scenario Outline: Edit Template Applications from ADC Report Report
    Given UI "Edit" Report With Name "<ReportName>"
      | Template-2 | reportType:System and Network,Applications:[<ApplicationName>] |
    Then UI "Validate" Report With Name "ADC Report"
      | Template-2 | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[<ApplicationName>] |

    Examples:
      | ReportName | ApplicationName                                      |
      | ADC Report | Rejith_#convertIpToHexa(Alteon_Set_Simulators_3);:80 |

  @SID_6
  Scenario Outline:Add Template to ADC Report Report
    Given UI "Edit" Report With Name "<ReportName>"
      | Template-3 | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.18] |
    Then UI "Validate" Report With Name "<ReportName>"
      | Template-1 | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[<ApplicationName>]              |
      | Template-2 | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.18] |
      | Template-3 | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.18] |

    Examples:
      | ReportName | ApplicationName                                      |
      | ADC Report | Rejith_#convertIpToHexa(Alteon_Set_Simulators_3);:80 |

  @SID_7
  Scenario Outline: Delete Template from ADC Report
    Given UI "Edit" Report With Name "<ReportName>"
      | Template-3 | DeleteTemplate:true |
    Then UI "Validate" Report With Name "<ReportName>"
      | Template-1 | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[<ApplicationName>]              |
      | Template-2 | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.18] |

    Examples:
      | ReportName | ApplicationName                                      |
      | ADC Report | Rejith_#convertIpToHexa(Alteon_Set_Simulators_3);:80 |

  @SID_8
  Scenario Outline: Create and validateADC Report2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "<ReportName>"
      | Template-1            | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[<ApplicationName>]              |
      | Template-2            | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.17] |
      | Time Definitions.Date | Quick:1D                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                      |
      | Format                | Select: PDF                                                                                               |
    Then UI "Validate" Report With Name "<ReportName>"
      | Template-1            | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[<ApplicationName>]              |
      | Template-2            | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.17] |
      | Time Definitions.Date | Quick:1D                                                                                                  |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                      |
      | Format                | Select: PDF                                                                                               |

    Examples:
      | ReportName | ApplicationName                                      |
      | ADC Report2 | Rejith_#convertIpToHexa(Alteon_Set_Simulators_3);:80 |

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
