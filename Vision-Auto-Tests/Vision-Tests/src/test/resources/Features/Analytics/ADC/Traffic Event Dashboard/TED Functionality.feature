@TED @TC110713
Feature: TED Functionality

  @SID_1
  Scenario: Pre-requirements and login
    * REST Delete ES index "alteon*"
    Then CLI Clear vision logs
    When CLI Operations - Run Radware Session command "net firewall open-port set 5140 open"
    When CLI Operations - Run Radware Session command "net firewall open-port set 9200 open"

    Then UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    Then Browser Refresh Page
    Then REST Add "Alteon" Device To topology Tree with Name "TED Automation" and Management IP "10.25.49.130" into site "Default"
      | attribute     | value   |
      | httpsPassword | admin   |
      | httpsUsername | admin   |
    Then Sleep "120"
    Then REST Add "Alteon" Device To topology Tree with Name "TED Automation2" and Management IP "10.25.49.135" into site "Default"
      | attribute     | value   |
      | httpsPassword | admin   |
      | httpsUsername | admin   |
    Then Sleep "120"
    Then REST Add "Alteon" Device To topology Tree with Name "TED Automation3" and Management IP "10.25.49.160" into site "Default"
      | attribute     | value   |
      | httpsPassword | admin   |
      | httpsUsername | admin   |

  @SID_2
  Scenario: Navigate to TED Tab
    #Given CLI simulate 2 attacks of type "1Hit" on "Alteon" 31 with loopDelay 15000 and wait 40 seconds
    And UI Navigate to "Application Dashboard" page via homePage
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1:80"
    Then UI Click Button "TED Tab"

  @SID_3
  Scenario: validate filter bar is empty and no data exists in the tedEvents Table
    Then UI Validate Text field by id "tedSearchBarInput" EQUALS ""
    Then UI Validate "tedEvent Table" Table rows count EQUALS to 0
  #TODO validate the correct "No Data Available" image appears in the table

  @SID_4
  Scenario: After Sending events - verify no data appears until refresh and refresh maintains filter bar value
    When CLI Send Traffic Events file "fieldsummarybadgevalues"
    And Sleep "20"
    Then UI Validate "tedEvent Table" Table rows count EQUALS to 0
    Then UI Click Button by id "tedSearchBarClear"
    Then UI Set Text field with id "tedSearchBarInput" with "range=7d"
    Then UI Click Button by id "tedSearchBarSearch"
    Then UI Validate "tedEvent Table" Table rows count EQUALS to 8
    Then UI Validate Text field by id "tedSearchBarTagIndex0" CONTAINS "range:7d"

  @SID_5
  Scenario: Fields Summary -> TedTopAnalyticsSummaryStateBadge value and table displays max 5 results (table offset by 1)
    Then UI Validate Text field by id "tedTopAnalyticsSummaryStateBadge" EQUALS "7"
    Then UI Click Button by id "tedTopAnalyticsSummaryStateBadge"
    Then UI Validate "tedEvent stateTable" Table rows count EQUALS to 6
    Then UI click Table row by keyValue or Index with elementLabel "tedEvent stateTable" findBy columnName "Value" findBy cellValue "Sent to client"

    Then UI Validate Text field by id "tedSearchBarTagIndex0" CONTAINS "range:7d"
    Then UI Validate Text field by id "tedSearchBarTagIndex1" CONTAINS "AND outcome:"Sent to client"

    Then UI Validate "tedEvent stateTable" Table rows count EQUALS to 2
    Then UI Click Button by id "tedTopAnalyticsSummaryStateBadge"

    Then UI Click Button by id "tedSearchBarClear"
    Then UI Set Text field with id "tedSearchBarInput" with "range=7d"
    Then UI Click Button by id "tedSearchBarSearch"

  @SID_6
  Scenario: tedEvent Table items are clickable and update query bar
    Then UI Click Button by id "tedSearchBarClear"
    Then UI Set Text field with id "tedSearchBarInput" with "range=7d AND outcome:"Sent to client""
    Then UI Click Button by id "tedSearchBarSearch"
    Then UI "collapse" Table row by keyValue or Index with elementLabel "tedEvent Table" findBy index 0
    Then UI Validate Text field by id "EventsSubPanelBoxRequestleftStateData" EQUALS "Sent to client"
    Then UI Click Button by id "EventsSubPanelBoxRequestrightQueryData"

    Then UI Validate Text field by id "tedSearchBarTagIndex0" CONTAINS "range:7d"
    Then UI Validate Text field by id "tedSearchBarTagIndex1" CONTAINS "AND outcome:"Sent to client""
    Then UI Validate Text field by id "tedSearchBarTagIndex2" CONTAINS "AND rdwrAltQuery:"?queryWithNoParameters&withParams\=true""

    Then UI "expand" Table row by keyValue or Index with elementLabel "tedEvent Table" findBy index 0

  @SID_7
  Scenario: Field Summary Badge Values
    Then UI Click Button by id "tedSearchBarClear"
    Then UI Set Text field with id "tedSearchBarInput" with "range=7d"
    Then UI Click Button by id "tedSearchBarSearch"
    ## Fields Summary - Request
    Then UI Validate Text field by id "tedTopAnalyticsSummaryStateBadge" EQUALS "7"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryQueryBadge" EQUALS "2"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryReasonBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryReqLengthBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryHostBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryReqContentBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryMethodBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryReferrerBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryPathBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryHttpVerBadge" EQUALS "1"

  ## Fields Summary - Response
    Then UI Validate Text field by id "tedTopAnalyticsSummaryRespCodeBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryRespContentBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryRespLengthBadge" EQUALS "1"

  ## Fields Summary - End-to-End Time
    Then UI Validate Text field by id "tedTopAnalyticsSummaryEteTimeBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryAppRespBadge" EQUALS "0"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryClientRttBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryTransferBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryServerRttBadge" EQUALS "1"

  ## Fields Summary - Client Parameters
    Then UI Validate Text field by id "tedTopAnalyticsSummaryLocationBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryBrowserBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryOsBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummarySourceBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryDeviceBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryXffBadge" EQUALS "0"

  ## Fields Summary - Frontend SSL
    Then UI Validate Text field by id "tedTopAnalyticsSummaryFeVerBadge" EQUALS "0"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryFeCipherBadge" EQUALS "0"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryFePolicyBadge" EQUALS "0"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryFeSniBadge" EQUALS "0"

  ## Fields Summary - Backend SSL
    Then UI Validate Text field by id "tedTopAnalyticsSummaryBeVerBadge" EQUALS "0"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryBeCipherBadge" EQUALS "0"

  ## Fields Summary - Alteon
    Then UI Validate Text field by id "tedTopAnalyticsSummaryAltContentBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryAddressBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryGroupNameBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryPortBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryServNameBadge" EQUALS "1"
    Then UI Validate Text field by id "tedTopAnalyticsSummaryInstanceBadge" EQUALS "1"

  @SID_8
  Scenario: URL encoded query values properly quoted
    Then UI Click Button by id "tedSearchBarClear"
    Then UI Set Text field with id "tedSearchBarInput" with "range=7d"
    Then UI Click Button by id "tedSearchBarSearch"
    Then UI Click Button by id "tedTopAnalyticsSummaryQueryBadge"
    Then UI Validate "tedEvent queryTable" Table rows count EQUALS to 3
    Then UI click Table row by keyValue or Index with elementLabel "tedEvent queryTable" findBy columnName "Value" findBy cellValue "?Hello%20World"
    Then UI Validate Text field by id "tedSearchBarTagIndex0" CONTAINS "range:7d"
    Then UI Validate Text field by id "tedSearchBarTagIndex1" CONTAINS "AND rdwrAltQuery:"?Hello%20World""
    Then UI Validate "tedEvent queryTable" Table rows count EQUALS to 2
    Then Sleep "5"
    Then UI Click Button by id "tedTopAnalyticsSummaryQueryBadge"

  @SID_9
  Scenario: Running 32.4.1 traffic
    * REST Delete ES index "alteon*"
    Then CLI Run remote linux Command "curl 'http://10.25.49.132/' -H 'Connection: keep-alive' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-GB,en;q=0.9,en-US;q=0.8,he;q=0.7' --compressed --insecure" on "GENERIC_LINUX_SERVER"
    And Sleep "20"
    Then UI Click Button by id "tedSearchBarClear"
    Then UI Click Button by id "tedSearchBarSearch"
    Then UI Validate "tedEvent Table" Table rows count EQUALS to 1

  @SID_10
    Scenario: Running 34.2.2 traffic
    Then CLI Run remote linux Command "curl 'http://10.25.49.137/' -H 'Connection: keep-alive' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-GB,en;q=0.9,en-US;q=0.8,he;q=0.7' --compressed --insecure" on "GENERIC_LINUX_SERVER"
    And Sleep "20"
    Then UI Click Button by id "tedSearchBarClear"
    Then UI Click Button by id "tedSearchBarSearch"
    Then UI Validate "tedEvent Table" Table rows count EQUALS to 2

  @SID_11
  Scenario: Running 32.6.0.0 traffic
    Then CLI Run remote linux Command "curl 'http://10.25.49.162/' -H 'Connection: keep-alive' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-GB,en;q=0.9,en-US;q=0.8,he;q=0.7' --compressed --insecure" on "GENERIC_LINUX_SERVER"
    And Sleep "20"
    Then UI Click Button by id "tedSearchBarClear"
    Then UI Click Button by id "tedSearchBarSearch"
    Then UI Validate "tedEvent Table" Table rows count EQUALS to 3

  @SID_12
    Scenario: Malformed cef message request
    * REST Delete ES index "alteon*"
    When CLI Send Traffic Events file "unifiedTrafficEventUpdates"
#    Then CLI Run remote linux Command "python3 /home/radware/TED/cef/cef_messages_dir.py -a 1 -i "172.17.164.101" -p "5140" -dir "/home/radware/TED/automation/unifiedTrafficEventUpdates" -t" on "GENERIC_LINUX_SERVER"
    And Sleep "20"
    Then UI Click Button by id "tedSearchBarSearch"
    Then UI Validate "tedEvent Table" Table rows count EQUALS to 3

  @SID_13
  Scenario: Cleanup
    Then REST Delete Device By IP "10.25.49.130"
    Then REST Delete Device By IP "10.25.49.135"
    Then REST Delete Device By IP "10.25.49.160"
    Then UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | FLUENTD | fatal      | NOT_EXPECTED |
      | FLUENTD | error      | NOT_EXPECTED |
