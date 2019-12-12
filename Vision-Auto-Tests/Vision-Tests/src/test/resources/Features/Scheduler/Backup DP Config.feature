
@TC111506
Feature: Scheduled task Backup DefensePro

  @SID_1
  Scenario: Clean FTP server log
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/DP_config_task*.txt" on "GENERIC_LINUX_SERVER"

  @SID_2
  Scenario: Login and go to scheduler screen
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Go To Vision
    When UI Open scheduler window

  @SID_3
  Scenario: Create new task of export DefensePro configuration
    Then UI Click Button by id "gwt-debug-scheduledTasks_NEW"
    Then UI Select "Device Configuration Backup" from Vision dropdown by Id "gwt-debug-taskType_Widget-input"
    Then UI Set Text field with id "gwt-debug-name_Widget" with "DP_config_task"
    Then UI Set Text field with id "gwt-debug-scheduledTasks.Schedule.Daily.Time_Widget" with "14:00:00"

    Then UI Click Button by id "gwt-debug-backupDestinationParameters_Tab"
    Then UI Click Button by id "gwt-debug-backupDestination_EXTERNAL_LOCATION-input"

    Then UI Select "FTP" from Vision dropdown by Id "gwt-debug-additionalParams.transportProtocol_Widget-input"
    Then UI Set Text field with id "gwt-debug-additionalParams.pathToFile_Widget" with "/home/radware/ftp"
    Then UI Set Text field with id "gwt-debug-additionalParams.userName_Widget" with "radware"
    Then UI Set Text field with id "gwt-debug-additionalParams.password_Widget" with "radware"
    Then UI Set Text field with id "gwt-debug-additionalParams.password_DuplicatePasswordField" with "radware"
    Then UI Set Text field with id "gwt-debug-additionalParams.backupFileName_Widget" with "DP_config_task"
    Then UI Set Text field with id "gwt-debug-additionalParams.ip_Widget" with "172.17.164.10"

    Then UI Click Button by id "gwt-debug-scheduledTasksDualList_Tab"
    Then UI Set Text field with id "gwt-debug-managementIp_SearchControl" with "DefensePro_172"
    Then UI Click Button by id "gwt-debug-devicesList_ApplyFilter"
    Then UI DualList Move deviceIndex 11 deviceType "DefensePro" DualList Items to "RIGHT" , dual list id "gwt-debug-devicesList"
    Then UI Click Button by id "gwt-debug-ConfigTab_NEW_scheduledTasks_Submit"

  @SID_4
  Scenario: Run The task
    Then UI Run task with name "DP_config_task"

  @SID_5
  Scenario: Delete The task
    Then UI Delete task with name "DP_config_task"

  @SID_6
  Scenario: Validate exported file in FTP server
    Then CLI Run linux Command "ll /home/radware/ftp/DP_config_task*.txt |awk '{print$5}'" on "GENERIC_LINUX_SERVER" and validate result GTE "3"

  @SID_7
  Scenario: Cleanup
    Then UI logout and close browser
    Then CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
      | ALL     | error      | NOT_EXPECTED |

