@TC108222
Feature: AMS HTTPS System Aggregation

  @SID_1
  Scenario: Get necessary scripts
    Then CLI copy "/home/radware/Scripts/leave_two_documents_https.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then CLI copy "/home/radware/Scripts/get_ES_key_value_https.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then CLI copy "/home/radware/Scripts/HTTPS_Reindex_rt_prevHour.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then CLI Clear vision logs

  @SID_2
  Scenario: Configure two documents in index adc-system-hourly with known values
  # in this scenario we run a shell file thatr delete all documents and leave only two documens
  # each document will set a different value every field in order verify that the aggigation performs an everage calulation
    And REST Delete ES index "dp-https-rt*"
    Given CLI simulate 2 attacks of type "HTTPS" on SetId "DefensePro_Set_1" with loopDelay 5000 and wait 90 seconds

    * CLI Run remote linux Command on "ROOT_SERVER_CLI" and wait for prompt "True"
      | "/leave_two_documents_https.sh dp-https-rt 172.16.22.50 Outbound BaselineOutbound" |

    * CLI Run remote linux Command on "ROOT_SERVER_CLI" and wait for prompt "True"
      | "/HTTPS_Reindex_rt_prevHour.sh" |


    #* CLI Run remote linux Command "/HTTPS_Reindex_rt_prevHour.sh" on "ROOT_SERVER_CLI"
    * Sleep "30"

  @SID_3
  Scenario: Run System aggregation CLI command on demand
    And REST Delete ES index "dp-hourly*"
    Then CLI Clear vision logs
#    Then CLI Run remote linux Command "curl -X POST --header 'Content-Type: application/json' --header 'Accept: */*' 'http://localhost:10080/reporter/mgmt/monitor/reporter/internal-dashboard/scheduledTasks?jobClassName=com.reporter.dp.task.https.DPHttpsDataHourlyAggTask'" on "ROOT_SERVER_CLI"
    Then CLI Run linux Command "curl -w 'RESP_CODE:%{response_code}\n' -XPOST 'http://localhost:8080/reporter/internal-dashboard/scheduledTasks?jobClassName=com.reporter.dp.task.https.DPHttpsDataHourlyAggTask'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200"
    * Sleep "30"
    * CLI Check if logs contains
      | logType | expression                                            | isExpected |
      | TOMCAT  | DPHttpsDataHourlyPerformer: aggregation task finished | EXPECTED   |

  @SID_4
  Scenario: validate average values of fields in index dp-hourly-https-rt
    Then CLI Run linux Command "/get_ES_key_value_https.sh dp-hourly-https-rt 172.16.22.50 Outbound BaselineOutbound bandwidthLongBaseline" on "ROOT_SERVER_CLI" and validate result EQUALS "135.0"
    Then CLI Run linux Command "/get_ES_key_value_https.sh dp-hourly-https-rt 172.16.22.50 Outbound BaselineOutbound bandwidthLongAttackEdge" on "ROOT_SERVER_CLI" and validate result EQUALS "145.0"
    Then CLI Run linux Command "/get_ES_key_value_https.sh dp-hourly-https-rt 172.16.22.50 Outbound BaselineOutbound bandwidthShortBaseline" on "ROOT_SERVER_CLI" and validate result EQUALS "155.0"
    Then CLI Run linux Command "/get_ES_key_value_https.sh dp-hourly-https-rt 172.16.22.50 Outbound BaselineOutbound bandwidthShortAttackEdge" on "ROOT_SERVER_CLI" and validate result EQUALS "165.0"
    Then CLI Run linux Command "/get_ES_key_value_https.sh dp-hourly-https-rt 172.16.22.50 Outbound BaselineOutbound responseSizeBaseline" on "ROOT_SERVER_CLI" and validate result EQUALS "175.0"
    Then CLI Run linux Command "/get_ES_key_value_https.sh dp-hourly-https-rt 172.16.22.50 Outbound BaselineOutbound responseSizeAttackEdge" on "ROOT_SERVER_CLI" and validate result EQUALS "185.0"

