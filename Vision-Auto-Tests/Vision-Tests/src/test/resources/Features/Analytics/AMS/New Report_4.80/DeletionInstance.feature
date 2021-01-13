@TC119052
Feature: Deletion Instance

  @SID_1
  Scenario: Login
    Then UI Login with user "radware" and password "radware"

  @SID_2
  Scenario: Navigate to NEW REPORTS page
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_3
  Scenario: Create and validate DefensePro Analytics Report
    Given UI "Create" Report With Name "DefensePro Analytics Report"
      | Template              | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                    |
      | Time Definitions.Date | Quick:1D                                                                                             |
      | Format                | Select: CSV                                                                                          |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Template              | reportType:DefensePro Analytics,Widgets:[Connections Rate],devices:[{deviceIndex:10}],showTable:true |
      | Logo                  | reportLogoPNG.png                                                                                    |
      | Time Definitions.Date | Quick:1D                                                                                             |
      | Format                | Select: CSV                                                                                          |

  @SID_4
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"

  @SID_5
  Scenario: Edit The Format and validate
    Then UI "Edit" Report With Name "DefensePro Analytics Report"
      | Format | Select: PDF |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Format | Select: PDF |

  @SID_6
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"

  @SID_7
  Scenario: Edit The Time and validate
    Then UI "Edit" Report With Name "DefensePro Analytics Report"
      | Time Definitions.Date | Quick:15m |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Time Definitions.Date | Quick:15m |

  @SID_8
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"

  @SID_9
  Scenario: Deletion Report Instance
    Then UI Validate Deletion of report instance "Deletion Report Instance" with value "DefensePro Analytics Report_2"
    Then UI Validate Deletion of report instance "Deletion Report Instance" with value "DefensePro Analytics Report_1"
    Then UI Validate Deletion of report instance "Deletion Report Instance" with value "DefensePro Analytics Report_0"

  @SID_10
  Scenario: Edit The Time and validate
    Then UI "Edit" Report With Name "DefensePro Analytics Report"
      | Time Definitions.Date | Quick:1H |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Time Definitions.Date | Quick:1H |

  @SID_11
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"

  @SID_12
  Scenario: Edit The Share Email and validate
    Then UI "Edit" Report With Name "DefensePro Analytics Report"
      | share | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | share | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody |

  @SID_13
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Generate Report Manually" with value "DefensePro Analytics Report"
    Then Sleep "35"

  @SID_14
  Scenario: Deletion Report Instance
    Then UI Validate Deletion of report instance "Deletion Report Instance" with value "DefensePro Analytics Report_1"
    Then UI Validate Deletion of report instance "Deletion Report Instance" with value "DefensePro Analytics Report_0"

  @SID_15
  Scenario: Delete report
    Then UI Delete Report With Name "DefensePro Analytics Report"

  @SID_16
  Scenario: Logout
    Then UI logout and close browser
