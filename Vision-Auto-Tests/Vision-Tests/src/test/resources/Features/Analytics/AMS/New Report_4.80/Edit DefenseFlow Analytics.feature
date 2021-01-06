@TC118576
Feature: Edit DefenseFlow Analytics tests

  @SID_1
  Scenario: Login
    Then UI Login with user "radware" and password "radware"

  @SID_2
  Scenario: Navigate to NEW REPORTS page
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_3
  Scenario: Create and validate DefenseFlow Analytics Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DefenseFlow Analytics Report"
      | Template-1            | reportType:DefenseFlow Analytics,Widgets:[Top 10 Activations by Attack Rate (Gbps)],Protected Objects:[PO Name Space],showTable:true |
      | Template-2            | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO_1],showTable:true                               |
      | Logo                  | reportLogoPNG.png                                                                                                                    |
      | Share                 | Email:[automation.vision1@radware.com],Subject:myAdd subject,Body:myAdd body                                                         |
      | Time Definitions.Date | Quick:Today                                                                                                                          |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                          |
      | Format                | Select: PDF                                                                                                                          |
    Then UI "Validate" Report With Name "DefenseFlow Analytics Report"
      | Template-1            | reportType:DefenseFlow Analytics,Widgets:[Top 10 Activations by Attack Rate (Gbps)],Protected Objects:[PO Name Space],showTable:true |
      | Template-2            | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO_1],showTable:true                               |
      | Logo                  | reportLogoPNG.png                                                                                                                    |
      | Share                 | Email:[automation.vision1@radware.com],Subject:myAdd subject,Body:myAdd body                                                         |
      | Time Definitions.Date | Quick:Today                                                                                                                          |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                          |
      | Format                | Select: PDF                                                                                                                          |


  @SID_4
  Scenario: Add Template Widget to DefenseFlow Analytics
    Given UI "Edit" Report With Name "DefenseFlow Analytics Report"
      | Template-1 | reportType:DefenseFlow Analytics,AddWidgets:[Top Attack Destination],Protected Objects:[PO Name Space],showTable:true |
    Then UI "Validate" Report With Name "DefenseFlow Analytics Report"
      | Template-1 | reportType:DefenseFlow Analytics,Widgets:[Top 10 Activations by Attack Rate (Gbps),Top Attack Destination],Protected Objects:[PO Name Space],showTable:true |

  @SID_5
  Scenario: Delete Template Widget from DefenseFlow Analytics
    Given UI "Edit" Report With Name "DefenseFlow Analytics Report"
      | Template-1 | reportType:DefenseFlow Analytics,DeleteWidgets:[Top Attack Destination],Protected Objects:[PO Name Space],showTable:true |
    Then UI "Validate" Report With Name "DefenseFlow Analytics Report"
      | Template-1 | reportType:DefenseFlow Analytics,Widgets:[Top 10 Activations by Attack Rate (Gbps)],Protected Objects:[PO Name Space],showTable:true |

  @SID_6
  Scenario: Edit Template Protected Objects from DefenseFlow Analytics Report
    Given UI "Edit" Report With Name "DefenseFlow Analytics Report"
      | Template-1 | reportType:DefenseFlow Analytics,Protected Objects:[PO_1],showTable:true |
    Then UI "Validate" Report With Name "DefenseFlow Analytics Report"
      | Template-1 | reportType:DefenseFlow Analytics,Widgets:[Top 10 Activations by Attack Rate (Gbps)],Protected Objects:[PO_1],showTable:true |

  @SID_7
  Scenario:Add Template to DefenseFlow Analytics Report
    Given UI "Edit" Report With Name "DefenseFlow Analytics Report"
      | Template-3 | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO_1],showTable:true |
    Then UI "Validate" Report With Name "DefenseFlow Analytics Report"
      | Template-1 | reportType:DefenseFlow Analytics,Widgets:[Top 10 Activations by Attack Rate (Gbps)],Protected Objects:[PO_1],showTable:true |
      | Template-2 | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO_1],showTable:true                      |
      | Template-3 | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO_1],showTable:true                      |

  @SID_8
  Scenario: Delete Template from DefenseFlow Analytics
    Given UI "Edit" Report With Name "DefenseFlow Analytics Report"
      | Template-3 | DeleteTemplate:true |
    Then UI "Validate" Report With Name "DefenseFlow Analytics Report"
      | Template-1 | reportType:DefenseFlow Analytics,Widgets:[Top 10 Activations by Attack Rate (Gbps)],Protected Objects:[PO_1],showTable:true |
      | Template-2 | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Rate],Protected Objects:[PO_1],showTable:true                      |

  @SID_9
  Scenario: Create and validate DefenseFlow Analytics Report2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DefenseFlow Analytics Report2"
      | Template-1            | reportType:DefenseFlow Analytics,Widgets:[Top 10 Activations by Attack Rate (Gbps)],Protected Objects:[PO Name Space],showTable:true |
    Then UI "Validate" Report With Name "DefenseFlow Analytics Report2"
      | Template-1            | reportType:DefenseFlow Analytics,Widgets:[Top 10 Activations by Attack Rate (Gbps)],Protected Objects:[PO Name Space],showTable:true |

  @SID_10
  Scenario: Edit DefenseFlow Analytics Report2 report name
    Then UI Click Button "My Reports Tab"
    Then UI Click Button "Edit Report" with value "DefenseFlow Analytics Report2"
    Then UI Set Text Field "Report Name" To "DefenseFlow Analytics Report"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'DefenseFlow Analytics Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "DefenseFlow Analytics Report"?"
    Then UI Click Button "Yes"
    Then UI Text of "Error message title" equal to "Unable to Save Report"
    Then UI Text of "Error message description" equal to "Report name must be unique. There is already another report with name 'DefenseFlow Analytics Report'"
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "DefenseFlow Analytics Report"?"
    Then UI Click Button "No"

  @SID_11
  Scenario: Delete report
    Then UI Delete Report With Name "DefenseFlow Analytics Report"
    Then UI Delete Report With Name "DefenseFlow Analytics Report2"

  @SID_12
  Scenario: Logout
    Then UI logout and close browser
