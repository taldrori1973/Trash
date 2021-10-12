@VRM_BDoS_Baseline @TC105963

Feature: VRM Application Dashboard Accessibility

  @SID_13
  Scenario: fetch Alteons
    Then CLI Run remote linux Command "result=`curl -ks -X "POST" "https://localhost/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"radware\",\"password\": \"radware\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -k -XPOST -H "Cookie: JSESSIONID=$jsession" -d '{}' https://localhost:443/mgmt/system/monitor/dpm/alteon/fetch" on "ROOT_SERVER_CLI"

  @SID_1
  Scenario: Login and open Application Dashboard
    Given REST Login with user "sys_admin" and password "radware"
    When REST Vision Install License Request "vision-reporting-module-ADC"
    Given UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "Application Dashboard" page via homePage

  @SID_14
  Scenario: DPM - Validate Dashboards accessibility - color patterns
    Then UI Validate Pie Chart data "VIRTUAL SERVICES"
      | label   | shapeType | colors  |
      | Down    | plus      | #B4121B |
      | Up      | ring      | #00843F |
      | Warning | cross     | #DF8F01 |

  @SID_2
  Scenario: Set Accessibility patterns traffic graphs
    Given UI Click Button "Accessibility Open Menu"
    Then UI Click Button "Accessibility Color Patterns" with value "Use Patterns For Colors"
    Then UI Click Button "Accessibility Open Menu"

  @SID_3
  Scenario: DPM - Validate Dashboards accessibility - color patterns
    Then UI Validate Pie Chart data "VIRTUAL SERVICES"
      | label   | shapeType | colors  |
      | Down    | plus      | #B4121B |
      | Up      | ring      | #00843F |
      | Warning | cross     | #DF8F01 |

  @SID_4
  Scenario: VRM ADC validate Accessibility patterns in DPM 1st drill
    Then UI click Table row by keyValue or Index with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith_32326515:80"
    Then UI Validate Line Chart attributes "End-To-End Time" with Label "Client RTT"
      | attribute       | value   |
      | shapeType       | plus    |
      | backgroundColor | #F1BEBE |
      | colors          | #F1BEBE |
    Then UI Validate Line Chart attributes "End-To-End Time" with Label "Server RTT"
      | attribute       | value   |
      | shapeType       | cross   |
      | backgroundColor | #9BB1C8 |
      | colors          | #9BB1C8 |

  @SID_5
  Scenario: validate Accessibility patterns in real-servers drill
    Then UI "expand" Table row by keyValue or Index with elementLabel "Virtual Service.Table" findBy columnName "Group ID" findBy cellValue "1"
    Then UI Validate Line Chart attributes "CONTENT RULE EXPAND ROW THROUGHPUT" with Label "1"
      | attribute       | value   |
      | shapeType       | plus    |
      | backgroundColor | #6296BA |
      | colors          | #6296BA |
    Then UI Validate Line Chart attributes "CONTENT RULE EXPAND ROW THROUGHPUT" with Label "10"
      | attribute       | value   |
      | shapeType       | cross   |
      | backgroundColor | #76DDFB |
      | colors          | #76DDFB |

  @SID_6
  Scenario: Go back to ADC dashboard
    Then UI Navigate to "Application Dashboard" page via homePage

  @SID_7
  Scenario: VRM ADC Set Accessibility stop auto refresh
    Given UI Click Button "Accessibility Open Menu"
    Then UI Click Button "Accessibility Auto Refresh" with value "Stop Auto-Refresh"
    Then UI Click Button "Accessibility Close"

  @SID_8
  Scenario: copy script to delete down Virts
    * CLI copy "/home/radware/ADC_delete_down_virt.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage/"

  @SID_9
  Scenario: VRM ADC Validate Dashboards Charts numbers while refresh is off
    Then CLI Run remote linux Command "/opt/radware/storage/ADC_delete_down_virt.sh localhost 35" on "ROOT_SERVER_CLI" with timeOut 30
    Then UI Navigate to "Application Dashboard" page via homePage
    Then UI Validate Pie Chart data "VIRTUAL SERVICES"
      | label   | data |
      | Down    | 4    |
      | Up      | 2    |
      | Warning | 8    |

  @SID_10
  Scenario: VRM ADC set Accessibility clear settings
    Given UI Click Button "Accessibility Open Menu"
    Then UI Click Button "Accessibility Clear" with value "Quit Accessibility"
    Then UI Click Button "Accessibility Close"

  @SID_11
  Scenario: VRM ADC validate Accessibility clear settings
    Then UI Validate Pie Chart data "VIRTUAL SERVICES"
      | label | shapeType |
      | Down  | cross     |
      | Up    | ring      |

  @SID_12
  Scenario: Cleanup
    Then UI logout and close browser
