@TC106971
Feature: ADC System Aggregation

  @SID_1
  Scenario: Get necessary scripts
    Then CLI copy "/home/radware/Scripts/leave_two_documents.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then CLI copy "/home/radware/Scripts/get_ES_key_value.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"

  @SID_2
  Scenario: Configure two documents in index adc-system-hourly with known values
  # in this scenario we run a shell file thatr delete all documents and leave only two documens
  # each document will set a different value every field in order verify that the aggigation performs an everage calulation
    When CLI Run remote linux Command "/leave_two_documents.sh adc-system-raw 50.50.101.21" on "ROOT_SERVER_CLI"
#    * Sleep "20"

  @SID_3
  Scenario: Run System aggregation CLI command on demand
    And REST Delete ES index "dp-hourly*"
    * Sleep "10"
    Then CLI Run remote linux Command "curl -X POST --header 'Content-Type: application/json' --header 'Accept: */*' 'http://localhost:10080/reporter/mgmt/monitor/reporter/internal-dashboard/scheduledTasks?jobClassName=com.reporter.alteon.task.AdcSystemMonitoringHourlyAggTask'" on "ROOT_SERVER_CLI"
    * Sleep "30"


  @SID_4
  Scenario: validate average values of fields in index adc-system-hourly
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly mpCpu					 50.50.101.21" on "ROOT_SERVER_CLI" and validate result EQUALS "15.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly cpuSpAvg				     50.50.101.21" on "ROOT_SERVER_CLI" and validate result EQUALS "25.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly memSpAvg				     50.50.101.21" on "ROOT_SERVER_CLI" and validate result EQUALS "35.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly cpuSpMax				     50.50.101.21" on "ROOT_SERVER_CLI" and validate result EQUALS "45.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly memSpMax				     50.50.101.21" on "ROOT_SERVER_CLI" and validate result EQUALS "55.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly throughputCapacity		 50.50.101.21" on "ROOT_SERVER_CLI" and validate result EQUALS "65.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly throughputUsage			 50.50.101.21" on "ROOT_SERVER_CLI" and validate result EQUALS "75.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly throughputUsagePercent	 50.50.101.21" on "ROOT_SERVER_CLI" and validate result EQUALS "85.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly maxSessions				 50.50.101.21" on "ROOT_SERVER_CLI" and validate result EQUALS "95.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly currentSessions			 50.50.101.21" on "ROOT_SERVER_CLI" and validate result EQUALS "85.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly sessionTableUtilization	 50.50.101.21" on "ROOT_SERVER_CLI" and validate result EQUALS "75.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly maxIpRoutes				 50.50.101.21" on "ROOT_SERVER_CLI" and validate result EQUALS "65.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly currentIpRoutes			 50.50.101.21" on "ROOT_SERVER_CLI" and validate result EQUALS "55.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly routeTableUtilization	 50.50.101.21" on "ROOT_SERVER_CLI" and validate result EQUALS "45.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly hardDiskTotal			 50.50.101.21" on "ROOT_SERVER_CLI" and validate result EQUALS "35.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly hardDiskUsage			 50.50.101.21" on "ROOT_SERVER_CLI" and validate result EQUALS "25.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly hardDiskUtilization		 50.50.101.21" on "ROOT_SERVER_CLI" and validate result EQUALS "15.0"

