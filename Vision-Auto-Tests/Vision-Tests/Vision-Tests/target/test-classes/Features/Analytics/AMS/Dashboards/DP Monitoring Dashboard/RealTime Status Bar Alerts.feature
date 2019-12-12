@TC112252
Feature: VRM Real Time Status Bar Alerts

@SID_1
Scenario: Clear and generate alert
Given CLI kill all simulator attacks on current vision
Then CLI Clear vision logs
Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
Then REST Delete ES document with data ""module": "DEVICE_HEALTH_ERRORS"" from index "alert"
Then REST Delete ES document with data ""module": "DEVICE_THROUGHPUT_LICENSE_ERRORS"" from index "alert"
Then REST Delete ES document with data ""module": "DEVICE_THROUGHPUT_LICENSE_EXCEEDED_ERRORS"" from index "alert"
Then CLI simulate 1 attacks of type "DP_single_Oper_oos" on "DefensePro" 11 and wait 8 seconds
Then CLI simulate 1 attacks of type "DP_single_Oper_oos" on "DefensePro" 10
Then CLI simulate 1 attacks of type "DP_single_Oper_oos" on "DefensePro" 20 and wait 22 seconds

@SID_2
Scenario: Operational alerts basic DP
Given UI Login with user "sys_admin" and password "radware"
Then UI Open Upper Bar Item "AMS"
Then UI Open "Dashboards" Tab
Then UI Open "DP Monitoring Dashboard" Sub Tab
Then Sleep "3"
Then UI Text of "Health Error Count" equal to "2 Errors"
Then UI Validate Element Existence By Label "Health.Warning" if Exists "true"
#    Then UI Logout

@SID_3
Scenario: Operational alerts table
#    Given UI Login with user "sys_admin" and password "radware"
#    Then UI Open Upper Bar Item "AMS"
#    Then UI Open "Dashboards" Tab
#    Then UI Open "DP Monitoring Dashboard" Sub Tab
#    Then Sleep "3"
#    Then UI Text of "Health Error Count" equal to "2 Errors"
#    Then UI Validate Element Existence By Label "Health.Warning" if Exists "true"
Then UI Click Button "Health Error Count" with value "2 Errors"
Then UI Validate "Alerts Table" Table rows count equal to 2

@SID_4
Scenario: Operational alerts table sort
Then UI Validate Table record values by columns with elementLabel "Alerts Table" findBy index 0
| columnName  | value                                                                                                                                                                                                                                                                     |
| Device Name | DefensePro_172.16.22.50                                                                                                                                                                                                                                                   |
| Module      | DEVICE_HEALTH_ERRORS                                                                                                                                                                                                                                                      |
| Message     | M_30000: Out-of-State Protection on engine number 1 was paused, because Session-table utilization on the engine reached the Alert-Start Threshold. The protection will resume when utilization on the engine drops below the threshold, after the specified grace period. |
Then UI Click Button "Close Alert Table" with value "Close"
Then UI Logout

@SID_5
Scenario: Operational alerts RBAC
Given UI Login with user "sec_admin_all_pol" and password "radware"
Then UI Open Upper Bar Item "AMS"
Then UI Open "Dashboards" Tab
Then UI Open "DP Monitoring Dashboard" Sub Tab
Then UI Text of "Health Error Count" equal to "1 Errors"
Then UI Logout

@SID_6
Scenario: Operational alerts RBAC alert table
Given UI Login with user "sec_admin_all_pol" and password "radware"
Then UI Open Upper Bar Item "AMS"
Then UI Open "Dashboards" Tab
Then UI Open "DP Monitoring Dashboard" Sub Tab
Then UI Text of "Health Error Count" equal to "1 Errors"
Then UI Click Button "Health Error Count" with value "1 Errors"
Then UI Validate "Alerts Table" Table rows count equal to 1
Then UI Validate Table record values by columns with elementLabel "Alerts Table" findBy index 0
| columnName  | value                   |
| Device Name | DefensePro_172.16.22.50 |
| Module      | DEVICE_HEALTH_ERRORS    |
Then UI Click Button "Close Alert Table" with value "Close"
Then UI Logout

@SID_7
Scenario: Operational_alerts filter device
Given UI Login with user "sys_admin" and password "radware"
Then UI Open Upper Bar Item "AMS"
Then UI Open "Dashboards" Tab
Then UI Open "DP Monitoring Dashboard" Sub Tab
Then UI Text of "Health Error Count" equal to "2 Errors"
Then UI Do Operation "Select" item "Device Selection"
Then UI VRM Select device from dashboard and Save Filter
| index | ports | policies |
| 10    |       |          |
Then Sleep "2"
Then UI Text of "Health Error Count" equal to "1 Errors"
Then UI Click Button "Health Error Count" with value "1 Errors"
Then UI Validate "Alerts Table" Table rows count equal to 1
Then UI Validate Table record values by columns with elementLabel "Alerts Table" findBy index 0
| columnName  | value                   |
| Device Name | DefensePro_172.16.22.50 |
| Module      | DEVICE_HEALTH_ERRORS    |
Then UI Click Button "Close Alert Table" with value "Close"
Then UI Logout

@SID_8
Scenario: Operational alerts all types
Then REST Delete ES document with data ""module": "DEVICE_HEALTH_ERRORS"" from index "alert"
Then REST Delete ES document with data ""module": "DEVICE_THROUGHPUT_LICENSE_EXCEEDED_ERRORS"" from index "alert"
Then Sleep "5"
Given CLI simulate 1 attacks of type "DP_temperature_oper" on "DefensePro" 10
  # 4 (5 including clear) temperature high and 1 normal
  # OID 1.3.6.1.4.1.89.0.15
  # OID 1.3.6.1.4.1.89.0.16
  # OID 1.3.6.1.4.1.89.0.17

Given CLI simulate 1 attacks of type "DP_cert_oper" on "DefensePro" 10
  # 1 certificate alert
  # 1.3.6.1.4.1.89.0.78

Given CLI simulate 1 attacks of type "DP_fans_oper" on "DefensePro" 10
  # 5 (8) fans errors and 2 fans normal
  # OID 1.3.6.1.4.1.89.0.77

Given CLI simulate 1 attacks of type "DP_auth_oper" on "DefensePro" 10
  # (12) authentication errors not counted

  #  Given CLI simulate 1 attacks of type "DP_port_down" on "DefensePro" 10
  # 3 port errors not in list dont count OID 1.3.6.1.4.1.89.2.3.1.0

Given CLI simulate 1 attacks of type "DP_Oper_link_status_1" on "DefensePro" 10
  # 5 (10) link up/down
  # OID 1.3.6.1.4.1.89.1.1.62.16

Given CLI simulate 1 attacks of type "DP_session_oper" on "DefensePro" 10 and wait 45 seconds
  # 33 session-table
  # OID 1.3.6.1.4.1.89.35.1.104.0.1
  # OID 1.3.6.1.4.1.89.35.1.104.0.3

Given UI Login with user "sys_admin" and password "radware"
And UI Open Upper Bar Item "AMS"
And UI Open "Dashboards" Tab
And UI Open "DP Monitoring Dashboard" Sub Tab
Then UI Text of "Health Error Count" equal to "57 Errors"
Then UI Click Button "Health Error Count" with value "57 Errors"
Then UI Validate "Alerts Table" Table rows count equal to 50
Then UI Click Button "Close Alert Table" with value "Close"
  # And UI Open "Configurations" Tab
  # And UI Logout

@SID_9
Scenario: Operational alerts clear
Given CLI kill all simulator attacks on current vision
    # edit ES raisedtime over the 15 minutes
Then CLI Run remote linux Command "curl -XPOST localhost:9200/alert/_update_by_query/?pretty -d '{"query": {"match": {"module": "DEVICE_HEALTH_ERRORS"}},"script": {"source": "ctx._source.raisedTime = 'ctx._source.raisedTime-1080000'"}}'" on "ROOT_SERVER_CLI"
Then CLI Run remote linux Command "curl -XPOST localhost:9200/alert/_update_by_query/?pretty -d '{"query": {"match": {"module": "DEVICE_THROUGHPUT_LICENSE_ERRORS"}},"script": {"source": "ctx._source.raisedTime = 'ctx._source.raisedTime-1080000'"}}'" on "ROOT_SERVER_CLI" and wait 45 seconds
Then UI Text of "Health Error Count" equal to "0 Errors"
Then UI Validate Element Existence By Label "Health.Ok" if Exists "true"
And UI logout and close browser

@SID_10
Scenario: Operational alerts check logs
Then UI logout and close browser
And CLI Check if logs contains
| logType     | expression   | isExpected   |
| ES          | fatal\|error | NOT_EXPECTED |
| MAINTENANCE | fatal\|error | NOT_EXPECTED |
| JBOSS       | fatal        | NOT_EXPECTED |
| TOMCAT      | fatal        | NOT_EXPECTED |
| TOMCAT2     | fatal        | NOT_EXPECTED |

#      END OPERATIONAL ALERT


  @SID_11
  Scenario: Throughput alerts generate
    Given REST Delete ES document with data ""module": "DEVICE_THROUGHPUT_LICENSE_ERRORS"" from index "alert"
    Given REST Delete ES document with data ""module": "DEVICE_HEALTH_ERRORS"" from index "alert"
    Given REST Delete ES document with data ""module": "DEVICE_THROUGHPUT_LICENSE_EXCEEDED_ERRORS"" from index "alert"
    Then CLI Clear vision logs
    And Sleep "2"
    Given CLI simulate 1 attacks of type "DP_throuput_90" on "DefensePro" 11 and wait 20 seconds

  @SID_12
  Scenario: Throughput alerts basic
    Given UI Login with user "sys_admin" and password "radware"
    And UI Open Upper Bar Item "AMS"
    And UI Open "Dashboards" Tab
    And UI Open "DP Monitoring Dashboard" Sub Tab
    And Sleep "4"
    Then UI Text of "Utilization Throughput Status" equal to "1 Errors"
    Then UI Text of "Health Error Count" equal to "0 Errors"
    Then UI Validate Element Existence By Label "Throughput.Warning" if Exists "true"
    Then UI Validate Element Existence By Label "Health.Warning" if Exists "false"
    And UI Logout

  @SID_13
  Scenario: Throughput alerts basic alert table
    Given UI Login with user "sys_admin" and password "radware"
    And UI Open Upper Bar Item "AMS"
    And UI Open "Dashboards" Tab
    And UI Open "DP Monitoring Dashboard" Sub Tab
    And Sleep "4"
    Then UI Click Button "Utilization Throughput Status" with value "1 Errors"
    Then UI Validate "Alerts Table" Table rows count equal to 1
    Then UI Validate Table record values by columns with elementLabel "Alerts Table" findBy index 0
      | columnName  | value                                                                       |
      | Device Name | DefensePro_172.16.22.51                                                     |
      | Module      | DEVICE_THROUGHPUT_LICENSE_ERRORS                                            |
      | Message     | M_30000: Throughput has reached 90% of the limit of your throughput license |
      | Severity    | WARNING                                                                     |
    Then UI Click Button "Close Alert Table" with value "Close"
    And UI Logout

  @SID_14
  Scenario: Throughput alerts RBAC
    Given CLI simulate 1 attacks of type "DP_throuput_exceed" on "DefensePro" 10 and wait 22 seconds
    Given UI Login with user "sec_admin_all_pol" and password "radware"
    And UI Open Upper Bar Item "AMS"
    And UI Open "Dashboards" Tab
    And UI Open "DP Monitoring Dashboard" Sub Tab
    And Sleep "2"
    Then UI Text of "Utilization Throughput Status" equal to "1 Errors"
    Then UI Text of "Health Error Count" equal to "0 Errors"
    Then UI Validate Element Existence By Label "Throughput.Error" if Exists "true"
    Then UI Validate Element Existence By Label "Health.Warning" if Exists "false"
    And UI Open "Configurations" Tab
    And UI Logout
    Given UI Login with user "sys_admin" and password "radware"
    And UI Open Upper Bar Item "AMS"
    And UI Open "Dashboards" Tab
    And UI Open "DP Monitoring Dashboard" Sub Tab
    And Sleep "2"
    Then UI Text of "Utilization Throughput Status" equal to "2 Errors"
    Then UI Text of "Health Error Count" equal to "0 Errors"
    Then UI Validate Element Existence By Label "Throughput.Error" if Exists "true"
    And UI Logout

  @SID_15
  Scenario: Throughput alerts RBAC alert table
    Given UI Login with user "sec_admin_all_pol" and password "radware"
    Then UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab
    And Sleep "2"
    Then UI Click Button "Utilization Throughput Status" with value "1 Errors"
    Then UI Validate "Alerts Table" Table rows count equal to 1
    Then UI Validate Table record values by columns with elementLabel "Alerts Table" findBy index 0
      | columnName  | value                                                                                                                                                                                        |
      | Device Name | DefensePro_172.16.22.50                                                                                                                                                                      |
      | Module      | DEVICE_THROUGHPUT_LICENSE_EXCEEDED_ERRORS                                                                                                                                                    |
      | Message     | M_30000: Throughput has exceeded the limit of your throughput license. Traffic exceeding the limit is being dropped. To upgrade your throughput license, contact the technical support team. |
      | Severity    | WARNING                                                                                                                                                                                      |
    Then UI Click Button "Close Alert Table" with value "Close"
    And UI Logout

  @SID_16
  Scenario: Throughput alerts filter device
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab
    And Sleep "2"
    Then UI Text of "Utilization Throughput Status" equal to "2 Errors"
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 11    |       |          |
    And Sleep "2"
    Then UI Text of "Utilization Throughput Status" equal to "1 Errors"
    Then UI Validate Element Existence By Label "Throughput.Warning" if Exists "true"
    And UI Logout

  @SID_17
  Scenario: Throughput alerts clear
  # edit ES raisedtime over the 15 minutes
    And CLI Run remote linux Command "curl -XPOST localhost:9200/alert/_update_by_query/?pretty -d '{"query": {"match": {"module": "DEVICE_HEALTH_ERRORS"}},"script": {"source": "ctx._source.raisedTime = 'ctx._source.raisedTime-1080000'"}}'" on "ROOT_SERVER_CLI"
    And CLI Run remote linux Command "curl -XPOST localhost:9200/alert/_update_by_query/?pretty -d '{"query": {"match": {"module": "DEVICE_THROUGHPUT_LICENSE_EXCEEDED_ERRORS"}},"script": {"source": "ctx._source.raisedTime = 'ctx._source.raisedTime-1080000'"}}'" on "ROOT_SERVER_CLI"
    And CLI Run remote linux Command "curl -XPOST localhost:9200/alert/_update_by_query/?pretty -d '{"query": {"match": {"module": "DEVICE_THROUGHPUT_LICENSE_ERRORS"}},"script": {"source": "ctx._source.raisedTime = 'ctx._source.raisedTime-1080000'"}}'" on "ROOT_SERVER_CLI" and wait 60 seconds
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab
    And Sleep "2"
    Then UI Text of "Health Error Count" equal to "0 Errors"
    Then UI Text of "Utilization Throughput Status" equal to "0 Errors"
    Then UI Validate Element Existence By Label "Throughput.Ok" if Exists "true"
    Then UI Validate Element Existence By Label "Health.Ok" if Exists "true"
    And UI Logout

  @SID_18
  Scenario: Throughput alerts check logs
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal        | NOT_EXPECTED |

#      END THROUGHPUT ALERTS

