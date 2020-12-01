
@TC117966
Feature: Landing my reports basic tests
  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: Create New Report
    Given UI "Create" Report With Name "DefensePro Analytics Report"
      | Time Definitions.Date | Quick: 1H                                                                                                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+2m                                                                                                                                            |
      | Share                 | Email:[Test, Test2],Subject:TC108070 Subject                                                                                                                              |
      | Format                | Select: CSV                                                                                                                                                               |
      | Template-1 | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}]  ,devices:[All]                                                                              |

#  @SID_6
#  Scenario: Validate ToolTip
#    Then UI Set Text Field "Search Report" To "DefensePro Analytics Report"
##    Then UI Text of "Report Info" with extension "DefensePro Analytics Report" equal to ""
#    Then UI Text of "Report Info" with extension "DefensePro Analytics Report" contains ""
#

  @SID_3
  Scenario: Validate Report
    Given UI "Validate" Report With Name "DefensePro Analytics Report"
      | Time Definitions.Date | Quick: 1H                                                                                                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+2m                                                                                                                                            |
      | Share                 | Email:[Test, Test2],Subject:TC108070 Subject                                                                                                                              |
      | Format                | Select: CSV                                                                                                                                                               |
      | Template-1 | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}]  ,devices:[All]                                                                              |

  @SID_4
  Scenario: Change from New Report to My Reports
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label          | param | value |
      | New Report Tab |       | false |
      | My Reports Tab |       | true  |

  @SID_5
  Scenario: Validate Enable and Disable the Generate By Schedule
    Then UI Validate Element Existence By Label "Generate By Schedule" if Exists "true" with value "DefensePro Analytics Report,on"
    Then UI Click Button "Generate By Schedule" with value "DefensePro Analytics Report,on"
    Then UI Validate Element Existence By Label "Generate By Schedule" if Exists "true" with value "DefensePro Analytics Report,off"

#  @SID_6
#  Scenario: Validate ToolTip
#    Then UI Text of "Report Info" with extension "DefensePro Analytics Report" equal to ""

  @SID_7
  Scenario: Edit Report
    Then UI Click Button "Edit Report" with value "DefensePro Analytics Report"
    Given UI "Edit" Report With Name "DefensePro Analytics Report"
      | Time Definitions.Date | Quick: 1H                                                                                                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+2m                                                                                                                                            |
      | Share                 | Email:[Test, Test2],Subject:TC108070 Subject                                                                                                                              |
      | Format                | Select: CSV                                                                                                                                                               |
      | Template-1 | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}]  ,devices:[{deviceIndex:11,devicePorts:[1],devicePolicies:[BDOS,1_https]},{deviceIndex:10} ] |

  @SID_8
  Scenario: Validate  Report
    Given UI "Validate" Report With Name "DefensePro Analytics Report"
      | Time Definitions.Date | Quick: 1H                                                                                                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+2m                                                                                                                                            |
      | Share                 | Email:[Test, Test2],Subject:TC108070 Subject                                                                                                                              |
      | Format                | Select: CSV                                                                                                                                                               |
      | Template-1 | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}]  ,devices:[{deviceIndex:11,devicePorts:[1],devicePolicies:[BDOS,1_https]},{deviceIndex:10} ] |

  @SID_9
  Scenario: Delete Report
#delete - a7lam
#    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "DefensePro Analytics Report"
#    Then UI Click Button "Delete Report" with value "DefensePro Analytics Report"
    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "DefensePro Analytics Report"
    Then UI Delete Report With Name "DefensePro Analytics Report"
    Then UI Validate Element Existence By Label "My Report" if Exists "false" with value "DefensePro Analytics Report"

  @SID_10
  Scenario: Create New Report
    Given UI "Create" Report With Name "DefensePro Analytics Report"
      | Time Definitions.Date | Quick: 1H                                                                                                                                                                 |
      | Share                 | Email:[Test, Test2],Subject:TC108070 Subject                                                                                                                              |
      | Format                | Select: CSV                                                                                                                                                               |
      | Template-1 | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}]  ,devices:[All]                                                                              |

  @SID_11
  Scenario: Validate Report
    Given UI "Validate" Report With Name "DefensePro Analytics Report"
      | Time Definitions.Date | Quick: 1H                                                                                                                                                                 |
      | Share                 | Email:[Test, Test2],Subject:TC108070 Subject                                                                                                                              |
      | Format                | Select: CSV                                                                                                                                                               |
      | Template-1 | reportType:DefensePro Analytics , Widgets:[{Traffic Bandwidth:[pps,Outbound,50]}]  ,devices:[All]                                                                              |

  @SID_12
  Scenario: Validate Enable and Disable the Generate By Schedule
    Then UI Validate Element Existence By Label "Generate By Schedule" if Exists "true" with value "DefensePro Analytics Report,off_disabled"

  @SID_13
  Scenario: Logout
    Then UI logout and close browser



