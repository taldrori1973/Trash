@SED @TC126266
Feature: SED Functionality

  @SID_1
  Scenario: Pre-requirements and login
    Given CLI Operations - Run Radware Session command "net firewall open-port set 5140 open"
    Given CLI Operations - Run Radware Session command "net firewall open-port set 9200 open"
    * REST Delete ES index "alteon*"
    Then CLI Clear vision logs
    Given CLI Run remote linux Command "/home/radware/hackMe40.sh 2 10.25.86.43" on "GENERIC_LINUX_SERVER"
    Then UI Login with user "radware" and password "radware"

  @SID_2
  Scenario: Navigate to SED Tab
    And UI Navigate to "Application Dashboard" page via homePage
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "hackMeBank8640:443"
    Then UI Click Button "sed"

  @SID_3
  Scenario: validate filter bar is empty and data exists in the sedEvents Table
    Then UI Validate Text field by id "sedSearchBarInput" EQUALS ""
    Then UI Validate "sedEvent Table" Table rows count EQUALS to 12

  @SID_4
  Scenario: After Sending events - verify no data appears until refresh and refresh maintains filter bar value
    Given UI Set Text field with id "sedSearchBarInput" with "range=7d"
    Then UI Validate "sedEvent Table" Table rows count EQUALS to 12
    Then UI Validate Text field by id "sedSearchBarTagIndex0" CONTAINS "range:7d"
    Then UI Click Button by id "sedSearchBarClearImage"

  @SID_5
  Scenario: Fields Summary -> SedTopAnalyticsSummaryStateBadge value and table displays max 5 results (table offset by 1)
    Then UI Set Text field with id "sedSearchBarInput" with "range=7d"
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryActionBadge" EQUALS "2"
    Then UI Click Button by id "sedAnalyticsPanelSummaryActionBadge"
    Then UI Validate "sedEvent actionTable" Table rows count EQUALS to 4
    Then UI click Table row by keyValue or Index with elementLabel "sedEvent actionTable" findBy columnName "Value" findBy cellValue "Blocked"

    Then UI Validate Text field by id "sedSearchBarTagIndex0" CONTAINS "range:7d"
    Then UI Validate Text field by id "sedSearchBarTagIndex1" CONTAINS "AND rdwrAltAct:Blocked"

    Then UI Click Button by id "sedSearchBarClearImage"
    Then UI Click Button by id "sedAnalyticsPanelSummaryActionBadge"

  @SID_6
  Scenario: sedEvent Table items are clickable and update query bar
#    Then UI "expand" Table row by keyValue or Index with elementLabel "tedEvent Table" findBy index 0
    Given UI Set Text field with id "sedSearchBarInput" with "range=7d"
    Then UI Click Button by id "sedHistogramCollapseButton"
    Then UI Click Button by id "toggle0Image"
    Then UI Validate Text field by id "sedEventsTableBoxActionBody0ActionMid" EQUALS "Modified"
    Then UI Click Button by id "toggle0Image"
    Then UI Validate Text field by id "sedSearchBarTagIndex0" CONTAINS "range:7d"
#    Then UI Validate Text field by id "sedSearchBarTagIndex1" CONTAINS "AND outcome:"Sent to client""
    Then UI Click Button by id "toggle0Image"
    Then UI Click Button by id "sedSearchBarClearImage"

  @SID_7
  Scenario: Field Summary Badge Values
    ## Fields Summary - Attack Details
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryActionBadge" EQUALS "2"
    Then UI Validate Text field by id "sedAnalyticsPanelSummarySeverityBadge" EQUALS "2"
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryTypeBadge" EQUALS "4"
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryRuleIdBadge" EQUALS "1"
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryProtectionBadge" EQUALS "5"
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryTitleBadge" EQUALS "5"
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryCategoryBadge" EQUALS "3"
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryOwaspBadge" EQUALS "3"
  ## Fields Summary - Request/Response
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryHostnameBadge" EQUALS "1"
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryUriBadge" EQUALS "4"
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryMethodBadge" EQUALS "2"
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryCodeBadge" EQUALS "1"
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryWafPolicyBadge" EQUALS "1"
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryHostBadge" EQUALS "1"
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryAppPathBadge" EQUALS "1"
  ## Fields Summary - Client Parameters
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryAddressBadge" EQUALS "1"
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryWebUserBadge" EQUALS "1"
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryLocationBadge" EQUALS "0"
    Then UI Validate Text field by id "sedAnalyticsPanelSummaryUserRoleBadge" EQUALS "1"

  @SID_8
  Scenario: URL encoded protection values properly quoted
    Then UI Set Text field with id "sedSearchBarInput" with "range=7d"
    Then UI Click Button by id "sedAnalyticsPanelSummaryProtectionBadge"
    Then UI Validate "sedEvent protectionTable" Table rows count EQUALS to 7
    Then UI click Table row by keyValue or Index with elementLabel "sedEvent protectionTable" findBy columnName "Value" findBy cellValue "Vulnerabilities"
    Then UI Validate Text field by id "sedSearchBarTagIndex0" CONTAINS "range:7d"
    Then UI Validate Text field by id "sedSearchBarTagIndex1" CONTAINS "AND rdwrAltModule:Vulnerabilities"
    Then UI Validate "sedEvent protectionTable" Table rows count EQUALS to 3
#    Then Sleep "5"
    Then UI Click Button by id "sedAnalyticsPanelSummaryProtection"
    Then UI Click Button by id "sedSearchBarClearImage"

  @SID_9
  Scenario: Validate SED graph text fields
    Then UI Validate Text field by id "sedHistogramChartLegendItem1Badge" EQUALS "8"
    Then UI Validate Text field by id "sedHistogramChartLegendItem2Badge" EQUALS "0"
    Then UI Validate Text field by id "sedHistogramChartLegendItem3Badge" EQUALS "4"

  @SID_10
  Scenario: Cleanup
    Then UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | FLUENTD | fatal      | NOT_EXPECTED |
      | FLUENTD | error      | NOT_EXPECTED |
