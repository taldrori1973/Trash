Feature: Edit DefenseFlow Analytics tests
  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: Top Attacks by Duration Report 
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Top Attacks by Duration"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Duration],Protected Objects:[PO Name Space] |
    Then UI "Validate" Report With Name "Top Attacks by Duration"
      | Template              | reportType:DefenseFlow Analytics,Widgets:[Top Attacks by Duration],Protected Objects:[PO Name Space] |

  @SID_3
  Scenario: Add Logo to Top Attacks by Duration
    Given UI "Edit" Report With Name "Top Attacks by Duration"
      | Logo | addLogo:reportLogoPNG.png |
    Then UI "Validate" Report With Name "Top Attacks by Duration"
      | Logo | addLogo:reportLogoPNG.png |

  @SID_4
  Scenario: Add Share to Top Attacks by Duration
    Given UI "Edit" Report With Name "Top Attacks by Duration"
      | Share | Email:[automation.vision1@radware.com],Subject:myAdd subject,Body:myAdd body |
    Then UI "Validate" Report With Name "Top Attacks by Duration"
      | Share | Email:[automation.vision1@radware.com],Subject:myAdd subject,Body:myAdd body |

  @SID_5
  Scenario: Add Time to Top Attacks by Duration
    Given UI "Edit" Report With Name "Top Attacks by Duration"
      | Time Definitions.Date | Quick:Today |
    Then UI "Validate" Report With Name "Top Attacks by Duration"
      | Time Definitions.Date | Quick:Today |

  @SID_6
  Scenario: Add Schedule to Top Attacks by Duration
    Given UI "Edit" Report With Name "Top Attacks by Duration"
      | Schedule | Run Every:Daily,On Time:+2m |
    Then UI "Validate" Report With Name "Top Attacks by Duration"
      | Schedule | Run Every:Daily,On Time:+2m |

  @SID_7
  Scenario: Add Format to Top Attacks by Duration
    Given UI "Edit" Report With Name "Top Attacks by Duration"
      | Format | Select: CSV |
    Then UI "Validate" Report With Name "Top Attacks by Duration"
      | Format | Select: CSV |

  @SID_8
  Scenario: Edit Format to Top Attacks by Duration
    Given UI "Edit" Report With Name "Top Attacks by Duration"
      | Format | Select: PDF |
    Then UI "Validate" Report With Name "Top Attacks by Duration"
      | Format | Select: PDF |

  @SID_9
  Scenario: Edit Share to Top Attacks by Duration
    Given UI "Edit" Report With Name "Top Attacks by Duration"
      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
    Then UI "Validate" Report With Name "Top Attacks by Duration"
      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |

  @SID_10
  Scenario: Edit Time to Top Attacks by Duration
    Given UI "Edit" Report With Name "Top Attacks by Duration"
      | Time Definitions.Date | Quick:15m |
    Then UI "Validate" Report With Name "Top Attacks by Duration"
      | Time Definitions.Date | Quick:15m |

  @SID_11
  Scenario: Edit Schedule to Top Attacks by Duration
    Given UI "Edit" Report With Name "Top Attacks by Duration"
      | Schedule | Run Every:once, On Time:+6H |
    Then UI "Validate" Report With Name "Top Attacks by Duration"
      | Schedule | Run Every:once, On Time:+6H |

  @SID_12
  Scenario: Edit Template Protected Objects to Top Attacks by Duration
    Given UI "Edit" Report With Name "Top Attacks by Duration"
      | Template | reportType:DefenseFlow Analytics,Protected Objects:[ALL] |
    Then UI "Validate" Report With Name "Top Attacks by Duration"
      | Template | reportType:DefenseFlow Analytics,Protected Objects:[ALL] |

  @SID_13
  Scenario: Add Template Widget to Top Attacks by Duration
    Given UI "Edit" Report With Name "Top Attacks by Duration"
      | Template | reportType:DefenseFlow Analytics,AddWidgets[Traffic Rate],Protected Objects:[ALL]|
    Then UI "Validate" Report With Name "Top Attacks by Duration"
      | Template | reportType:DefenseFlow Analytics,AddWidgets[Traffic Rate],Protected Objects:[ALL]|

  @SID_14
  Scenario: Add new Template to Top Attacks by Duration
    Given UI "Edit" Report With Name "Top Attacks by Duration"
      | Template-2 | reportType:DefenseFlow Analytics,Widgets:[Inbound Traffic],[PO_1] |
    Then UI "Validate" Report With Name "Top Attacks by Duration"
      | Template-2 | reportType:DefenseFlow Analytics,Widgets:[Inbound Traffic],[PO_1] |

  @SID_15
  Scenario: Delete Template-2 to Top Attacks by Duration
    Given UI "Edit" Report With Name "Top Attacks by Duration"
      |Template_2             |DeleteTemplate|

  @SID_16
  Scenario: Edit report name Top Attacks by Duration
    Given UI "Edit" Report With Name "Top Attacks by Duration"
      | New Report Name | Top Attacks by Duration Report |
    Then UI "Validate" Report With Name "Top Attacks by Duration Report"
      | Template | reportType:Top Attacks by Duration,Widgets:[Inbound Traffic,Traffic Rate],Protected Objects:[ALL] |
      | Schedule | Run Every:once, On Time:+6H |
      | Time Definitions.Date | Quick:15m |
      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format | Select: PDF |
      | Logo | addLogo:reportLogoPNG.png |

  @SID_17
  Scenario: Delete Report
    Then UI Delete Report With Name "Top Attacks by Duration Report"

  @SID_18
  Scenario: Logout
    Then UI logout and close browser
