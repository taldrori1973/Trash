
@TC111533
Feature: Task OTB DefensePro Export-Import policy

  @SID_1
  Scenario: Login and go to scheduler screen
    Given CLI Reset radware password
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Request "POST" for "Vdirect->Sync Devices"
      | type                 | value |
      | Returned status code | 200   |
    Then UI Go To Vision

  @SID_2
  Scenario: Clean logs
    Then REST Delete ES index "alert"
    Then CLI Clear vision logs
    
  @SID_3
  Scenario: Create OTB export-import policy task by REST
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
     | "/home/radware/Scripts/create_task.sh " |
     | #visionIP                               |
     | " /home/radware/Scripts/OTB_task.json"  |
  
  @SID_4
  Scenario: Go to scheduler and run the task
    # Make sure a policy named BDOS with DNS and BDOS profiles exist in DP index 10
    # Import into DP index 11
    And UI Navigate to "SCHEDULER" page via homePage
    Then UI Run task with name "OTB_auto_task"
    
  @SID_5
  Scenario: Verify Vision success message
    Then Sleep "20"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"OPERATOR_TOOLBOX"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |awk -F"\"M_01414:  " '{print$2}'|awk -F"{" '{print$1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "User APSolute_Vision Operator Toolbox script DefensePro_Export_And_Import_Policy.vm was executed successfully by user APSolute_Vision on device 172.16.22.50,172.16.22.51 with parameters"

  @SID_6
  Scenario: Delete the created task
    Then UI Delete task with name "OTB_auto_task"

  @SID_7
  Scenario: Check logs for errors
    * CLI Check if logs contains
      | logType | expression                     | isExpected   |
      | VDIRECT | fatal                          | NOT_EXPECTED |
      | VDIRECT | error                          | NOT_EXPECTED |
      | VDIRECT | Could not update server report | IGNORE       |
      | VDIRECT | FAILED 172.17.154.190          | IGNORE       |