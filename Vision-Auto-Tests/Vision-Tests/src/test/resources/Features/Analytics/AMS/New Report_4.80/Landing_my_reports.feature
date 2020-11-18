Feature: Landing_my_reports

  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "NEW REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  Scenario: Create New Report
    Given UI "Create" Report With Name "DefensePro Analytics Report"
      | Time Definitions.Date | Quick: 1H                                                                                                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+2m                                                                                                                               |
      | Share                 | Email:[Test, Test2],Subject:TC108070 Subject                                                                                                                 |
      | Format                | Select: CSV                                                                                                                                                  |
     # | Logo                  | addLogo: reportLogoPNG.png                                                                                                                                   |
      | Template-1            | reportType:DefensePro Analytics , Widgets:[Concurrent Connections],devices:[{deviceIndex:11,devicePorts:[1],devicePolicies:[BDOS,1_https]},{deviceIndex:10}] |

    Given UI "Validate" Report With Name "DefensePro Analytics Report"
      | Time Definitions.Date | Quick: 1H                                                                                                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+2m                                                                                                                               |
      | Share                 | Email:[Test, Test2],Subject:TC108070 Subject                                                                                                                 |
      | Format                | Select: CSV                                                                                                                                                  |
     # | Logo                  | addLogo: reportLogoPNG.png                                                                                                                                   |
      | Template-1            | reportType:DefensePro Analytics , Widgets:[Concurrent Connections],devices:[{deviceIndex:11,devicePorts:[1],devicePolicies:[BDOS,1_https]},{deviceIndex:10}] |

    Then UI Validate Element Existence By Label "Generate By Schedule" if Exists "true" with value "DefensePro Analytics Report,on"
    Then UI Click Button "Generate By Schedule" with value "DefensePro Analytics Report,on"
    Then UI Validate Element Existence By Label "Generate By Schedule" if Exists "true" with value "DefensePro Analytics Report,off"

    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label          | param | value |
      | New Report Tab |       | false |
      | My Reports Tab |       | true  |

    Then UI Click Button "Edit Report" with value "DefensePro Analytics Report"
    Given UI "Edit" Report With Name "DefensePro Analytics Report"
      | Time Definitions.Date | Quick: 1H                                                                                                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+2m                                                                                                                               |
      | Share                 | Email:[Test, Test2],Subject:TC108070 Subject                                                                                                                 |
      | Format                | Select: CSV                                                                                                                                                  |
    #  | Logo                  | addLogo: reportLogoPNG.png
      | Template-1            | reportType:DefensePro Analytics , Widgets:[Concurrent Connections],devices:[{deviceIndex:11,devicePorts:[1],devicePolicies:[BDOS,1_https]},{deviceIndex:10}] |

    Given UI "Validate" Report With Name "DefensePro Analytics Report"
      | Time Definitions.Date | Quick: 1H                                                                                                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+2m                                                                                                                               |
      | Share                 | Email:[Test, Test2],Subject:TC108070 Subject                                                                                                                 |
      | Format                | Select: CSV                                                                                                                                                  |
     # | Logo                  | addLogo: reportLogoPNG.png                                                                                                                                   |
      | Template-1            | reportType:DefensePro Analytics , Widgets:[Concurrent Connections],devices:[{deviceIndex:11,devicePorts:[1],devicePolicies:[BDOS,1_https]},{deviceIndex:10}] |

#delete - a7lam
    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "DefensePro Analytics Report"
    Then UI Click Button "Delete Report" with value "DefensePro Analytics Report"
    Then UI Click Button "Close Report"
    Then UI Validate Element Existence By Label "My Report" if Exists "true" with value "DefensePro Analytics Report"
    Then UI Click Button "Delete Report" with value "DefensePro Analytics Report"
    Then UI Click Button "confirm Delete Report" with value ""
    Then UI Validate Element Existence By Label "My Report" if Exists "false" with value "DefensePro Analytics Report"

    Given UI "Create" Report With Name "DefensePro Analytics Report"
      | Time Definitions.Date | Quick: 1H                                                                                                                                                    |
      | Share                 | Email:[Test, Test2],Subject:TC108070 Subject                                                                                                                 |
      | Format                | Select: CSV                                                                                                                                                  |
     # | Logo                  | addLogo: reportLogoPNG.png                                                                                                                                   |
      | Template-1            | reportType:DefensePro Analytics , Widgets:[Concurrent Connections],devices:[{deviceIndex:11,devicePorts:[1],devicePolicies:[BDOS,1_https]},{deviceIndex:10}] |

    Given UI "Validate" Report With Name "DefensePro Analytics Report"
      | Time Definitions.Date | Quick: 1H                                                                                                                                                    |
      | Share                 | Email:[Test, Test2],Subject:TC108070 Subject                                                                                                                 |
      | Format                | Select: CSV                                                                                                                                                  |
     # | Logo                  | addLogo: reportLogoPNG.png                                                                                                                                   |
      | Template-1            | reportType:DefensePro Analytics , Widgets:[Concurrent Connections],devices:[{deviceIndex:11,devicePorts:[1],devicePolicies:[BDOS,1_https]},{deviceIndex:10}] |

    Then UI Validate Element Existence By Label "Generate By Schedule" if Exists "true" with value "DefensePro Analytics Report,off_disabled"
    Then UI Click Button "Generate By Schedule" with value "DefensePro Analytics Report,on"
    Then UI Validate Element Existence By Label "Generate By Schedule" if Exists "true" with value "DefensePro Analytics Report,off_disabled"


#    Then UI Text of "Name Tab" equal to "Report Name*"
