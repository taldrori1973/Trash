@TC106971
Feature: ADC System Aggregation

  @SID_1
  Scenario: Get necessary scripts
    Then CLI copy "/home/radware/Scripts/uVision_leave_two_documents.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then CLI copy "/home/radware/Scripts/get_ES_key_value.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"

  @SID_2
  Scenario: Configure two documents in index adc-system-hourly with known values
  # in this scenario we run a shell file thatr delete all documents and leave only two documens
  # each document will set a different value every field in order verify that the aggigation performs an everage calulation
    When CLI Run remote linux Command "/uVision_leave_two_documents.sh adc-system-raw #getSUTValue(setid:Alteon_Sim_Set_2);" on "ROOT_SERVER_CLI"
#    * Sleep "20"

  @SID_3
  Scenario: Run System aggregation CLI command on demand
    And REST Delete ES index "adc-system-hourly*"
    * Sleep "10"
    Then CLI Run remote linux Command "curl -X POST --header 'Content-Type: application/json' --header 'Accept: */*' 'http://localhost:8080/reporter/internal-dashboard/scheduledTasks?jobClassName=com.reporter.alteon.task.AdcSystemMonitoringHourlyAggTask'" on "ROOT_SERVER_CLI"
    * Sleep "30"


  @SID_4
  Scenario: validate average values of fields in index adc-system-hourly
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly mpCpu					 #getSUTValue(setid:Alteon_Sim_Set_2);" on "ROOT_SERVER_CLI" and validate result EQUALS "15.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly cpuSpAvg				     #getSUTValue(setid:Alteon_Sim_Set_2);" on "ROOT_SERVER_CLI" and validate result EQUALS "25.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly memSpAvg				     #getSUTValue(setid:Alteon_Sim_Set_2);" on "ROOT_SERVER_CLI" and validate result EQUALS "35.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly cpuSpMax				     #getSUTValue(setid:Alteon_Sim_Set_2);" on "ROOT_SERVER_CLI" and validate result EQUALS "45.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly memSpMax				     #getSUTValue(setid:Alteon_Sim_Set_2);" on "ROOT_SERVER_CLI" and validate result EQUALS "55.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly throughputCapacity		 #getSUTValue(setid:Alteon_Sim_Set_2);" on "ROOT_SERVER_CLI" and validate result EQUALS "65.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly throughputUsage			 #getSUTValue(setid:Alteon_Sim_Set_2);" on "ROOT_SERVER_CLI" and validate result EQUALS "75.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly throughputUsagePercent	 #getSUTValue(setid:Alteon_Sim_Set_2);" on "ROOT_SERVER_CLI" and validate result EQUALS "85.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly maxSessions				 #getSUTValue(setid:Alteon_Sim_Set_2);" on "ROOT_SERVER_CLI" and validate result EQUALS "95.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly currentSessions			 #getSUTValue(setid:Alteon_Sim_Set_2);" on "ROOT_SERVER_CLI" and validate result EQUALS "85.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly sessionTableUtilization	 #getSUTValue(setid:Alteon_Sim_Set_2);" on "ROOT_SERVER_CLI" and validate result EQUALS "75.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly maxIpRoutes				 #getSUTValue(setid:Alteon_Sim_Set_2);" on "ROOT_SERVER_CLI" and validate result EQUALS "65.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly currentIpRoutes			 #getSUTValue(setid:Alteon_Sim_Set_2);" on "ROOT_SERVER_CLI" and validate result EQUALS "55.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly routeTableUtilization	 #getSUTValue(setid:Alteon_Sim_Set_2);" on "ROOT_SERVER_CLI" and validate result EQUALS "45.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly hardDiskTotal			 #getSUTValue(setid:Alteon_Sim_Set_2);" on "ROOT_SERVER_CLI" and validate result EQUALS "35.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly hardDiskUsage			 #getSUTValue(setid:Alteon_Sim_Set_2);" on "ROOT_SERVER_CLI" and validate result EQUALS "25.0"
    Then CLI Run linux Command "/get_ES_key_value.sh adc-system-hourly hardDiskUtilization		 #getSUTValue(setid:Alteon_Sim_Set_2);" on "ROOT_SERVER_CLI" and validate result EQUALS "15.0"

