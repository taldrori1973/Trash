@TED @TC110713
Feature: TED Functionality

  @SID_1
  Scenario: Pre-requirements and login
    * REST Delete ES index "alteon*"
    Then CLI Clear vision logs
    When CLI Operations - Run Radware Session command "net firewall open-port set 5140 open"
    When CLI Operations - Run Radware Session command "net firewall open-port set 9200 open"
    Given CLI Run remote linux Command "/home/radware/hackMe40.sh 2 10.25.86.43" on "GENERIC_LINUX_SERVER"
    Then UI Login with user "radware" and password "radware"

  @SID_2
  Scenario: Navigate to TED Tab
    Given UI Navigate to "Application Dashboard" page via homePage
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "hackMeBank8640:443"
    Then UI Click Button "ted"

  @SID_3
  Scenario: validate filter bar is empty and no data exists in the tedEvents Table
    Given UI Validate Text field by id "tedSearchBarInput" EQUALS ""
    Then UI Validate "tedEvent Table" Table rows count EQUALS to 20

  @SID_4
  Scenario: After Sending events - verify no data appears until refresh and refresh maintains filter bar value
    Given UI Set Text field with id "tedSearchBarInput" with "range=7d"
    Then UI Validate "tedEvent Table" Table rows count EQUALS to 20
    Then UI Validate Text field by id "tedSearchBarTagIndex0" CONTAINS "range:7d"
    Then UI Click Button by id "tedSearchBarClearImage"

  @SID_5
  Scenario: Fields Summary -> TedTopAnalyticsSummaryStateBadge value and table displays max 5 results (table offset by 1)
    Then UI Set Text field with id "tedSearchBarInput" with "range=7d"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryStateBadge" EQUALS "4"
    Then UI Click Button by id "tedAnalyticsPanelSummaryStateBadge"
    Then UI Validate "tedEvent stateTable" Table rows count EQUALS to 6
    Then UI click Table row by keyValue or Index with elementLabel "tedEvent stateTable" findBy columnName "Value" findBy cellValue "Connection Failure"

    Then UI Validate Text field by id "tedSearchBarTagIndex0" CONTAINS "range:7d"
    Then UI Validate Text field by id "tedSearchBarTagIndex1" CONTAINS "AND outcome:"Connection Failure"

    Then UI Click Button by id "tedSearchBarClearImage"
    Then UI Click Button by id "tedAnalyticsPanelSummaryStateBadge"

  @SID_6
  Scenario: tedEvent Table items are clickable and update query bar
#    Then UI "expand" Table row by keyValue or Index with elementLabel "tedEvent Table" findBy index 0
    Given UI Set Text field with id "tedSearchBarInput" with "range=7d"
    Then UI Click Button by id "toggle0Image"
    Then UI Validate Text field by id "tedEventsTableBoxRequestBody0State" EQUALS "Sent to client"
    Then UI Click Button by id "tedEventsTableBoxRequestBody0StateInner"
    Then UI Validate Text field by id "tedSearchBarTagIndex0" CONTAINS "range:7d"
    Then UI Validate Text field by id "tedSearchBarTagIndex1" CONTAINS "AND outcome:"Sent to client""
    Then UI Click Button by id "toggle0Image"
    Then UI Click Button by id "tedSearchBarClearImage"

  @SID_7
  Scenario: Field Summary Badge Values
#    Then UI Set Text field with id "tedSearchBarInput" with "range=7d"
    ## Fields Summary - Request
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryStateBadge" EQUALS "4"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryQueryBadge" EQUALS "6"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryReasonBadge" EQUALS "4"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryReqLengthBadge" EQUALS "1"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryHostBadge" EQUALS "1"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryReqCTypeBadge" EQUALS "0"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryMethodBadge" EQUALS "2"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryReferBadge" EQUALS "1"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryPathBadge" EQUALS "9"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryHttpVerBadge" EQUALS "1"
  ## Fields Summary - Response
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryCodeBadge" EQUALS "2"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryRespCTypeBadge" EQUALS "2"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryRespLengthBadge" EQUALS "2"
  ## Fields Summary - End-to-End Time
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryEteBadge" EQUALS "1"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryAppRespBadge" EQUALS "1"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryClientRttBadge" EQUALS "1"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryRespTransBadge" EQUALS "1"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryServerRttBadge" EQUALS "1"
  ## Fields Summary - Client Parameters
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryLocationBadge" EQUALS "0"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryBrowserBadge" EQUALS "1"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryOsBadge" EQUALS "1"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryCSourceBadge" EQUALS "1"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryDeviceBadge" EQUALS "1"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryXffBadge" EQUALS "0"
  ## Fields Summary - Frontend SSL
    Then UI Validate Text field by id "tedAnalyticsPanelSummarySslFVerBadge" EQUALS "1"
    Then UI Validate Text field by id "tedAnalyticsPanelSummarySslFCipherBadge" EQUALS "1"
    Then UI Validate Text field by id "tedAnalyticsPanelSummarySslFPolicyBadge" EQUALS "1"
    Then UI Validate Text field by id "tedAnalyticsPanelSummarySslFHostBadge" EQUALS "0"
  ## Fields Summary - Backend SSL
    Then UI Validate Text field by id "tedAnalyticsPanelSummarySslBVerBadge" EQUALS "0"
    Then UI Validate Text field by id "tedAnalyticsPanelSummarySslBCipherBadge" EQUALS "0"
  ## Fields Summary - Alteon
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryAltClassBadge" EQUALS "0"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryAltAddressBadge" EQUALS "1"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryAltGroupBadge" EQUALS "1"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryAltPortBadge" EQUALS "1"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryAltNameBadge" EQUALS "1"
    Then UI Validate Text field by id "tedAnalyticsPanelSummaryAltInstBadge" EQUALS "1"

  @SID_8
  Scenario: URL encoded query values properly quoted
    Then UI Set Text field with id "tedSearchBarInput" with "range=7d"
    Then UI Click Button by id "tedAnalyticsPanelSummaryQueryBadge"
    Then UI Validate "tedEvent queryTable" Table rows count EQUALS to 7
    Then UI click Table row by keyValue or Index with elementLabel "tedEvent queryTable" findBy columnName "Value" findBy cellValue "cmd.exe\=101"
    Then UI Validate Text field by id "tedSearchBarTagIndex0" CONTAINS "range:7d"
    Then UI Validate Text field by id "tedSearchBarTagIndex1" CONTAINS "AND rdwrAltQuery:"cmd.exe\\=101""
    Then UI Validate "tedEvent queryTable" Table rows count EQUALS to 3
    Then UI Click Button by id "tedAnalyticsPanelSummaryQueryBadge"
    Then UI Click Button by id "tedSearchBarClearImage"

  @SID_9
  Scenario: Validate TED graph text fields
    Then UI Validate Text field by id "tedHistogramChartLegendItem1Badge" EQUALS "12"
    Then UI Validate Text field by id "tedHistogramChartLegendItem2Badge" EQUALS "20"
    Then UI Validate Text field by id "tedHistogramChartLegendItem3Badge" EQUALS "2"

  @SID_10
  Scenario: Cleanup
    Then UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | FLUENTD | fatal      | NOT_EXPECTED |
      | FLUENTD | error      | NOT_EXPECTED |
