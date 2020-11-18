Feature: Landing_my_reports

  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "NEW REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  Scenario: Create New Report
    Given UI "Create" Report With Name "Traffic Report"
#      | Template-1            | reportType:DefensePro Analytics , Widgets:[Concurrent Connections],devices:[{deviceIndex:11,devicePorts:[1],devicePolicies:[BDOS,1_https]},{deviceIndex:10}]                             |
  #    | Template-1            | reportType:DefensePro Analytics , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[{deviceIndex:11,devicePorts:[1,2],devicePolicies:[BDOS,1_https]},{deviceIndex:10}] |
#      | Template-1            | reportType:DefensePro Analytics , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[All] |
#      | Template-2            | reportType:HTTPS Flood , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[Server_v4-DefensePro_172.16.22.50-pol1] |
#      | Template-3            | reportType:AppWall , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[A1,ADZ] |
#      | Template-4            | reportType:DefenseFlow Analytics , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[All] |
#      | Format                | Select: CSV                                                                                                                                                                            |
#      |Template-4             |reportType:DefensePro Analytics , Widgets:[BDoS-TCP SYN,Concurrent Connections],devices:[{devicesIndex:11,devicePorts:[1,2],devicePolicies:[BDOS,APOL]},{deviceIndex:10}]|
#      | Logo                  | reportLogoPNG.png                                                                                                                                                                      |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN,SEP,DEC]                                                                                                                                |
#      | Time Definitions.Date | Quick:This Month|

    Given UI "Validate" Report With Name "Traffic Report"
#      | Template-1            | reportType:DefensePro Analytics , Widgets:[Concurrent Connections],devices:[{deviceIndex:11,devicePorts:[1],devicePolicies:[BDOS,1_https]},{deviceIndex:10}]                             |#    | Template-1            | reportType:DefensePro Analytics , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[{deviceIndex:11,devicePorts:[1,2],devicePolicies:[BDOS,1_https]},{deviceIndex:10}] |
#      | Template-1            | reportType:DefensePro Analytics , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[All] |
#      | Template-2            | reportType:HTTPS Flood , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[Server_v4-DefensePro_172.16.22.50-pol1] |
#      | Template-3            | reportType:AppWall , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[A1,ADZ] |
#      | Template-4            | reportType:DefenseFlow Analytics , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[All] |
#      | Format                | Select: CSV                                                                                                                                                                            |
#      |Template-4             |reportType:DefensePro Analytics , Widgets:[BDoS-TCP SYN,Concurrent Connections],devices:[{devicesIndex:11,devicePorts:[1,2],devicePolicies:[BDOS,APOL]},{deviceIndex:10}]|
#      | Logo                  | reportLogoPNG.png                                                                                                                                                                      |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN,SEP,DEC]                                                                                                                                |
#      | Time Definitions.Date | Quick:This Month|


    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label          | param | value |
      | New Report Tab |       | false |
      | My reports Tab |       | true  |


    Then UI Click Button "Report Name Button"
    Then UI Click Button "Delete Report" with value "Traffic Report"
    Then UI Click Button "confirm Delete Report" with value ""
    Then UI Validate Element Existence By Label "Report Name Button" if Exists "false"
    Then UI Click Button "Close Button" with value ""
    Then UI Validate Element Existence By Label "Report Name Button" if Exists "true"


    Then UI Click Button "Edit Button" with value ""
    Given UI "Edit" Report With Name "Traffic Report"
#      | Template-1            | reportType:DefensePro Analytics , Widgets:[Concurrent Connections],devices:[{deviceIndex:11,devicePorts:[1],devicePolicies:[BDOS,1_https]},{deviceIndex:10}]                             |
 #    | Template-1            | reportType:DefensePro Analytics , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[{deviceIndex:11,devicePorts:[1,2],devicePolicies:[BDOS,1_https]},{deviceIndex:10}] |
#      | Template-1            | reportType:DefensePro Analytics , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[All] |
#      | Template-2            | reportType:HTTPS Flood , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[Server_v4-DefensePro_172.16.22.50-pol1] |
#      | Template-3            | reportType:AppWall , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[A1,ADZ] |
#      | Template-4            | reportType:DefenseFlow Analytics , Widgets:[{BDoS-TCP SYN:[pps,IPv6,15]},Concurrent Connections],devices:[All] |
#      | Format                | Select: CSV                                                                                                                                                                            |
#      |Template-4             |reportType:DefensePro Analytics , Widgets:[BDoS-TCP SYN,Concurrent Connections],devices:[{devicesIndex:11,devicePorts:[1,2],devicePolicies:[BDOS,APOL]},{deviceIndex:10}]|
#      | Logo                  | reportLogoPNG.png                                                                                                                                                                      |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN,SEP,DEC]                                                                                                                                |
#      | Time Definitions.Date | Quick:This Month|





