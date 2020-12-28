@noam99
Feature: Edit AppWall tests


  @SID_1
  Scenario: Login
    Then UI Login with user "sys_admin" and password "radware"


  @SID_2
  Scenario: Navigate to NEW REPORTS page
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_3
  Scenario: Create and validate AppWall Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "AppWall Report"
      | Template-1            | reportType:AppWall , Widgets:[Geolocation] , Applications:[All] , showTable:false          |
      | Template-2            | reportType:AppWall , Widgets:[Attacks by Action] , Applications:[Vision] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                          |
      | Time Definitions.Date | Quick:1D                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body             |
      | Format                | Select: PDF                                                                                |
    Then UI "Validate" Report With Name "AppWall Report"
      | Template-1            | reportType:AppWall , Widgets:[Geolocation] , Applications:[All] , showTable:false          |
      | Template-2            | reportType:AppWall , Widgets:[Attacks by Action] , Applications:[Vision] , showTable:false |
      | Logo                  | reportLogoPNG.png                                                                          |
      | Time Definitions.Date | Quick:1D                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body             |
      | Format                | Select: PDF                                                                                |


  @SID_4
  Scenario: Add Template Widget to AppWall
    Given UI "Edit" Report With Name "AppWall Report"
      | Template-1            | reportType:AppWall , AddWidgets:[Top Sources] , Applications:[All] , showTable:false                      |
    Then UI "Validate" Report With Name "AppWall Report"
      | Template-1            | reportType:AppWall , Widgets:[Geolocation,Top Sources] , Applications:[All] , showTable:false             |


  @SID_5
  Scenario: Delete Template Widget from AppWall
    Given UI "Edit" Report With Name "AppWall Report"
      | Template-1            | reportType:AppWall , DeleteWidgets:[Top Sources] , Applications:[All] , showTable:false          |
    Then UI "Validate" Report With Name "AppWall Report"
      | Template-1            | reportType:AppWall , Widgets:[Geolocation] , Applications:[All] , showTable:false          |

  @SID_6
  Scenario: Edit Template Devices from AppWall Report
    Given UI "Edit" Report With Name "AppWall Report"
      | Template-1            | reportType:AppWall,Applications:[Vision]                                                      |
    Then UI "Validate" Report With Name "AppWall Report"
      | Template-1            | reportType:AppWall , Widgets:[Geolocation] , Applications:[Vision] , showTable:false          |

  @SID_7
  Scenario:Add Template to AppWall Report
    Given UI "Edit" Report With Name "AppWall Report"
      | Template-3            | reportType:AppWall , Widgets:[Attack Severity] , Applications:[Vision] , showTable:false   |
    Then UI "Validate" Report With Name "AppWall Report"
      | Template-1            | reportType:AppWall , Widgets:[Geolocation] , Applications:[Vision] , showTable:false       |
      | Template-2            | reportType:AppWall , Widgets:[Attacks by Action] , Applications:[Vision] , showTable:false |
      | Template-3            | reportType:AppWall , Widgets:[Attack Severity] , Applications:[Vision] , showTable:false   |

  @SID_8
  Scenario: Delete Template from AppWall
    Given UI "Edit" Report With Name "AppWall Report"
      | Template-3            | DeleteTemplate:true                                                                        |
    Then UI "Validate" Report With Name "AppWall Report"
      | Template-1            | reportType:AppWall , Widgets:[Geolocation] , Applications:[Vision] , showTable:false       |
      | Template-2            | reportType:AppWall , Widgets:[Attacks by Action] , Applications:[Vision] , showTable:false |

  @SID_9
  Scenario: Edit The Time and validate
    Then UI "Edit" Report With Name "AppWall Report"
      | Time Definitions.Date | Quick:15m |
    Then UI "Validate" Report With Name "AppWall Report"
      | Time Definitions.Date | Quick:15m |

  @SID_10
  Scenario: Edit The Format and validate
    Then UI "Edit" Report With Name "AppWall Report"
      | Format | Select: HTML |
    Then UI "Validate" Report With Name "AppWall Report"
      | Format | Select: HTML |


  @SID_11
  Scenario: Create and validate AppWall Report2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "AppWall Report2"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10] , Applications:[All] , showTable:true|
      | Logo                  | reportLogoPNG.png                                                                |
      | Time Definitions.Date | Quick:15m                                                                        |
      | Format                | Select: CSV                                                                      |
    Then UI "Validate" Report With Name "AppWall Report2"
      | Template              | reportType:AppWall , Widgets:[OWASP Top 10] , Applications:[All] , showTable:true|
      | Logo                  | reportLogoPNG.png                                                                |
      | Time Definitions.Date | Quick:15m                                                                        |
      | Format                | Select: CSV                                                                      |

  @SID_12
  Scenario: Edit AppWall Report2 report name
    Then UI Click Button "My Report Tab"
    Then UI Click Button "Edit Report" with value "AppWall Report2"
    Then UI Set Text Field "Report Name" To "AppWall Report"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'AppWall Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "AppWall Report"?"
    Then UI Click Button "Yes"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'AppWall Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "AppWall Report"?"
    Then UI Click Button "No"

  @SID_13
  Scenario: Delete report
    Then UI Delete Report With Name "AppWall Report"
    Then UI Delete Report With Name "AppWall Report2"

  @SID_14
  Scenario: Logout
    Then UI logout and close browser

