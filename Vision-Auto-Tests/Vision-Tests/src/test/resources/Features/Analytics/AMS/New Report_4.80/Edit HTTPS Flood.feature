
Feature: Edit HTTPS Flood tests

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: Create HTTPS Flood Reporteport
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "HTTPS Flood"
      | Template | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
    Then UI "Validate" Report With Name "HTTPS Flood"
      | Template | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |

  @SID_3
  Scenario: Add Logo to HTTPS Flood
    Given UI "Edit" Report With Name "HTTPS Flood"
      | Logo | addLogo: reportLogoPNG.png |
    Then UI "Validate" Report With Name "HTTPS Flood"
      | Logo | addLogo: reportLogoPNG.png |

  @SID_4
  Scenario: Add Share to HTTPS Flood
    Given UI "Edit" Report With Name "HTTPS Flood"
      | Share | Email:[automation.vision1@radware.com],Subject:myAdd subject,Body:myAdd body |
    Then UI "Validate" Report With Name "HTTPS Flood"
      | Share | Email:[automation.vision1@radware.com],Subject:myAdd subject,Body:myAdd body |

  @SID_5
  Scenario: Add Time to HTTPS Flood
    Given UI "Edit" Report With Name "HTTPS Flood"
      | Time Definitions.Date | Quick:Today |
    Then UI "Validate" Report With Name "HTTPS Flood"
      | Time Definitions.Date | Quick:Today |

  @SID_6
  Scenario: Add Schedule to HTTPS Flood
    Given UI "Edit" Report With Name "HTTPS Flood"
      | Schedule | Run Every:Daily,On Time:+2m |
    Then UI "Validate" Report With Name "HTTPS Flood"
      | Schedule | Run Every:Daily,On Time:+2m |

  @SID_7
  Scenario: Add Format to HTTPS Flood
    Given UI "Edit" Report With Name "HTTPS Flood"
      | Format | Select: CSV |
    Then UI "Validate" Report With Name "HTTPS Flood"
      | Format | Select: CSV |

  @SID_8
  Scenario: Edit Format to HTTPS Flood
    Given UI "Edit" Report With Name "HTTPS Flood"
      | Format | Select: PDF |
    Then UI "Validate" Report With Name "HTTPS Flood"
      | Format | Select: PDF |

  @SID_9
  Scenario: Edit Share to HTTPS Flood
    Given UI "Edit" Report With Name "HTTPS Flood"
      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
    Then UI "Validate" Report With Name "HTTPS Flood"
      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |

  @SID_10
  Scenario: Edit Time to HTTPS Flood
    Given UI "Edit" Report With Name "HTTPS Flood"
      | Time Definitions.Date | Quick:15m |
    Then UI "Validate" Report With Name "HTTPS Flood"
      | Time Definitions.Date | Quick:15m |

  @SID_11
  Scenario: Edit Schedule to HTTPS Flood
    Given UI "Edit" Report With Name "HTTPS Flood"
      | Schedule | Run Every:once, On Time:+6H |
    Then UI "Validate" Report With Name "HTTPS Flood"
      | Schedule | Run Every:once, On Time:+6H |

  @SID_12
  Scenario: Edit Template Servers to HTTPS Flood
    Given UI "Edit" Report With Name "HTTPS Flood"
      | Template | reportType:HTTPS Flood,Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-https_policy6] |
    Then UI "Validate" Report With Name "HTTPS Flood"
      | Template | reportType:HTTPS Flood,Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-https_policy6] |

  @SID_13
  Scenario: Add Template Widget to HTTPS Flood
    Given UI "Edit" Report With Name "HTTPS Flood"
      | Template | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-https_policy6] |
    Then UI "Validate" Report With Name "HTTPS Flood"
      | Template | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-https_policy6] |

  @SID_14
  Scenario: Add new Template to HTTPS Flood
    Given UI "Edit" Report With Name "HTTPS Flood"
      | Template-2 | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-https_policy7] |
    Then UI "Validate" Report With Name "HTTPS Flood"
      | Template-2 | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-https_policy7] |

  @SID_15
  Scenario: Delete Template-2 to HTTPS Flood
    Given UI "Edit" Report With Name "HTTPS Flood"
      | Template_2 | DeleteTemplate |

  @SID_16
  Scenario: Edit report name HTTPS Flood
    Given UI "Edit" Report With Name "HTTPS Flood"
      | New Report Name | HTTPS Flood Report |
    Then UI "Validate" Report With Name "HTTPS Flood Report"
      | Template              | reportType:HTTPS Flood,Widgets:[Inbound Traffic,Inbound Traffic],Servers:[Server1-DefensePro_172.16.22.51-1_https] |
      | Schedule              | Run Every:once, On Time:+6H                                                                                |
      | Time Definitions.Date | Quick:15m                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                             |
      | Format                | Select: PDF                                                                                                |
      | Logo                  | addLogo:reportLogoPNG.png                                                                                          |

  @SID_17
  Scenario: Delete Report
    Then UI Delete Report With Name "HTTPS Flood Report"

  @SID_18
  Scenario: Logout
    Then UI logout and close browser
