Feature: Edit DefensePro Analytics tests

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: DefensePro Analytics Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DefensePro Analytics"
      | Template | reportType:DefensePro Analytics,Widgets:[Attacks by Mitigation Action],devices:[{deviceIndex:11,devicePorts:[1],devicePolicies:[BDOS]}] |
    Then UI "Validate" Report With Name "DefensePro Analytics"
      | Template | reportType:DefensePro Analytics,Widgets:[Attacks by Mitigation Action],devices:[{deviceIndex:11,devicePorts:[1],devicePolicies:[BDOS]}] |

#  @SID_3
#  Scenario: Add Logo to DefensePro Analytics
#    Given UI "Edit" Report With Name "DefensePro Analytics"
#      | Logo |  reportLogoPNG.png |
#    Then UI "Validate" Report With Name "DefensePro Analytics"
#      | Logo |  reportLogoPNG.png |
#
#  @SID_4
#  Scenario: Add Share to DefensePro Analytics
#    Given UI "Edit" Report With Name "DefensePro Analytics"
#      | Share | Email:[automation.vision1@radware.com],Subject:myAdd subject,Body:myAdd body |
#    Then UI "Validate" Report With Name "DefensePro Analytics"
#      | Share | Email:[automation.vision1@radware.com],Subject:myAdd subject,Body:myAdd body |
#
#  @SID_5
#  Scenario: Add Time to DefensePro Analytics
#    Given UI "Edit" Report With Name "DefensePro Analytics"
#      | Time Definitions.Date | Quick:Today |
#    Then UI "Validate" Report With Name "DefensePro Analytics"
#      | Time Definitions.Date | Quick:Today |
#
#  @SID_6
#  Scenario: Add Schedule to DefensePro Analytics
#    Given UI "Edit" Report With Name "DefensePro Analytics"
#      | Schedule | Run Every:Daily,On Time:+2m |
#    Then UI "Validate" Report With Name "DefensePro Analytics"
#      | Schedule | Run Every:Daily,On Time:+2m |
#
#  @SID_7
#  Scenario: Add Format to DefensePro Analytics
#    Given UI "Edit" Report With Name "DefensePro Analytics"
#      | Format | Select: CSV |
#    Then UI "Validate" Report With Name "DefensePro Analytics"
#      | Format | Select: CSV |
#
#  @SID_8
#  Scenario: Edit Format to DefensePro Analytics
#    Given UI "Edit" Report With Name "DefensePro Analytics"
#      | Format | Select: PDF |
#    Then UI "Validate" Report With Name "DefensePro Analytics"
#      | Format | Select: PDF |
#
#  @SID_9
#  Scenario: Edit Share to DefensePro Analytics
#    Given UI "Edit" Report With Name "DefensePro Analytics"
#      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
#    Then UI "Validate" Report With Name "DefensePro Analytics"
#      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
#
#  @SID_10
#  Scenario: Edit Time to DefensePro Analytics
#    Given UI "Edit" Report With Name "DefensePro Analytics"
#      | Time Definitions.Date | Quick:15m |
#    Then UI "Validate" Report With Name "DefensePro Analytics"
#      | Time Definitions.Date | Quick:15m |
#
#  @SID_11
#  Scenario: Edit Schedule to DefensePro Analytics
#    Given UI "Edit" Report With Name "DefensePro Analytics"
#      | Schedule | Run Every:once, On Time:+6H |
#    Then UI "Validate" Report With Name "DefensePro Analytics"
#      | Schedule | Run Every:once, On Time:+6H |

  @SID_12
  Scenario: Edit Template devices to DefensePro Analytics
    Given UI "Edit" Report With Name "DefensePro Analytics"
      | Template | reportType:DefensePro Analytics,devices:[{deviceIndex:10,devicePorts:[1],devicePolicies:[BDOS]}] |
    Then UI "Validate" Report With Name "DefensePro Analytics"
      | Template | reportType:DefensePro Analytics,devices:[{deviceIndex:10,devicePorts:[1],devicePolicies:[BDOS]}] |

  @SID_13
  Scenario: Add Template Widget to DefensePro Analytics
    Given UI "Edit" Report With Name "DefensePro Analytics"
      | Template | reportType:DefensePro Analytics,AddWidgets:[Top Attacks],devices:[{deviceIndex:10,devicePorts:[1],devicePolicies:[BDOS]}] |
    Then UI "Validate" Report With Name "DefensePro Analytics"
      | Template | reportType:DefensePro Analytics,AddWidgets:[Top Attacks],devices:[{deviceIndex:10,devicePorts:[1],devicePolicies:[BDOS]}] |

  @SID_14
  Scenario: Add new Template to DefensePro Analytics
    Given UI "Edit" Report With Name "DefensePro Analytics"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attacks],devices:[{deviceIndex:10,devicePorts:[1],devicePolicies:[bdos1]}] |
    Then UI "Validate" Report With Name "DefensePro Analytics"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attacks],devices:[{deviceIndex:10,devicePorts:[1],devicePolicies:[bdos1]}] |

  @SID_15
  Scenario: Delete Template-2 to DefensePro Analytics
    Given UI "Edit" Report With Name "DefensePro Analytics"
      | Template_2 | DeleteTemplate |

  @SID_16
  Scenario: Edit report name DefensePro Analytics
    Given UI "Edit" Report With Name "DefensePro Analytics"
      | New Report Name | DefensePro Analytics Report |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Template              | reportType:DefensePro Analytics,Widgets:[Attacks by Mitigation Action,Top Attacks],devices:[{deviceIndex:10,devicePorts:[1],devicePolicies:[BDOS]}] |
      | Schedule              | Run Every:once, On Time:+6H                                                                                                                         |
      | Time Definitions.Date | Quick:15m                                                                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                      |
      | Format                | Select: PDF                                                                                                                                         |
      | Logo                  | reportLogoPNG.png                                                                                                                                   |

  @SID_17
  Scenario: Delete Report
    Then UI Delete Report With Name "DefensePro Analytics Report"

#  @SID_18
#  Scenario: Validate delivery card and generate report
#    Then UI Click Button "My Report" with value "DP Analytics csv"
#    Then UI Click Button "Generate Report Manually" with value "DP Analytics csv"
#    Then Sleep "35"

  @SID_18
  Scenario: Logout
    Then UI logout and close browser

    