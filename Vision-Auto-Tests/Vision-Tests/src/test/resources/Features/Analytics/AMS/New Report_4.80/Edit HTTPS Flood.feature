
Feature: Edit HTTPS Flood tests
#  @SID_1
#  Scenario: Clean data before the test
#    * REST Delete ES index "dp-*"

  @SID_2
  Scenario: Login
    Then UI Login with user "sys_admin" and password "radware"

  @SID_3
  Scenario: Run DP simulator PCAPs for "HTTPS attacks"
    Given CLI simulate 1 attacks of type "HTTPS" on "DefensePro" 11 with loopDelay 15000 and wait 60 seconds

  @SID_4
  Scenario: Navigate to NEW REPORTS page
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_5
  Scenario: Create and Validate HTTPS Flood Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "HTTPS Flood"
      | Template-1            | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https]       |
      | Template-2            | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-https_policy7] |
      | Logo                  | reportLogoPNG.png                                                                                                               |
      | Share                 | Email:[automation.vision1@radware.com],Subject:myAdd subject,Body:myAdd body                                                    |
      | Time Definitions.Date | Quick:Today                                                                                                                     |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                     |
      | Format                | Select: PDF                                                                                                                     |
    Then UI "Validate" Report With Name "HTTPS Flood"
      | Template-1            | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https]       |
      | Template-2            | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-https_policy7] |
      | Logo                  | reportLogoPNG.png                                                                                                               |
      | Share                 | Email:[automation.vision1@radware.com],Subject:myAdd subject,Body:myAdd body                                                    |
      | Time Definitions.Date | Quick:Today                                                                                                                     |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                     |
      | Format                | Select: PDF                                                                                                                     |

  @SID_6
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "HTTPS Flood csv"
    Then UI Click Button "Generate Report Manually" with value "HTTPS Flood csv"
    Then Sleep "35"

  @SID_7
  Scenario: Add Template Widget to HTTPS Flood
    Given UI "Edit" Report With Name "HTTPS Flood"
      | Template-1 | reportType:HTTPS Flood,AddWidgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |
    Then UI "Validate" Report With Name "HTTPS Flood"
      | Template-1 | reportType:HTTPS Flood,AddWidgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-1_https] |

  @SID_8
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "HTTPS Flood csv"
    Then UI Click Button "Generate Report Manually" with value "HTTPS Flood csv"
    Then Sleep "35"

  @SID_9
  Scenario: Delete Template  to HTTPS Flood
    Given UI "Edit" Report With Name "HTTPS Flood"
      | Template_1 | DeleteTemplate |
    Then UI "Validate" Report With Name "HTTPS Flood"
      | Template-1 | reportType:HTTPS Flood,Widgets:[Inbound Traffic],Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-https_policy7]                                                             |

  @SID_10
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "HTTPS Flood csv"
    Then UI Click Button "Generate Report Manually" with value "HTTPS Flood csv"
    Then Sleep "35"

  @SID_11
  Scenario: Edit Template Servers to HTTPS Flood
    Given UI "Edit" Report With Name "HTTPS Flood"
      | Template | reportType:HTTPS Flood,Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-https_policy6] |
    Then UI "Validate" Report With Name "HTTPS Flood"
      | Template | reportType:HTTPS Flood,Servers:[aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-DefensePro_172.16.22.51-https_policy6] |

  @SID_12
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "HTTPS Flood csv"
    Then UI Click Button "Generate Report Manually" with value "HTTPS Flood csv"
    Then Sleep "35"

  @SID_13
  Scenario: Logout
    Then UI logout and close browser
