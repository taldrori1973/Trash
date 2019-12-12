
@TC111505
Feature: Scheduled task Backup Alteon

   @SID_1
  Scenario: Clean FTP server log
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/ADC_config_task*.tgz" on "GENERIC_LINUX_SERVER"

  @SID_2
  Scenario: Login and go to scheduler screen
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Go To Vision
    When UI Open scheduler window

  @SID_3
  Scenario: Create new task of export Alteon configuration
    Then UI Click Button by id "gwt-debug-scheduledTasks_NEW"
    Then UI Select "Device Configuration Backup" from Vision dropdown by Id "gwt-debug-taskType_Widget-input"
    Then UI Set Text field with id "gwt-debug-name_Widget" with "ADC_config_task"
    Then UI Set Text field with id "gwt-debug-scheduledTasks.Schedule.Daily.Time_Widget" with "11:00:00"

    Then UI Click Button by id "gwt-debug-backupDestinationParameters_Tab"
    Then UI Click Button by id "gwt-debug-backupDestination_EXTERNAL_LOCATION-input"

    Then UI Select "FTP" from Vision dropdown by Id "gwt-debug-additionalParams.transportProtocol_Widget-input"
    Then UI Set Text field with id "gwt-debug-additionalParams.pathToFile_Widget" with "/home/radware/ftp"
    Then UI Set Text field with id "gwt-debug-additionalParams.userName_Widget" with "radware"
    Then UI Set Text field with id "gwt-debug-additionalParams.password_Widget" with "radware"
    Then UI Set Text field with id "gwt-debug-additionalParams.password_DuplicatePasswordField" with "radware"
    Then UI Set Text field with id "gwt-debug-additionalParams.backupFileName_Widget" with "ADC_config_task"
    Then UI Set Text field with id "gwt-debug-additionalParams.ip_Widget" with "172.17.164.10"
    Then Sleep "15"
    Then UI Click Button by id "gwt-debug-scheduledTasksDualList_Tab"
    Then UI DualList Move deviceIndex 10 deviceType "Alteon" DualList Items to "RIGHT" , dual list id "gwt-debug-devicesList"
    Then UI Click Button by id "gwt-debug-ConfigTab_NEW_scheduledTasks_Submit"

  @SID_4
  Scenario: Run The task
    Then UI Run task with name "ADC_config_task"

  @SID_5
  Scenario: Delete The task
    Then UI Delete task with name "ADC_config_task"

  @SID_6
  Scenario: Validate exported file in FTP server
    Then CLI Run linux Command "ll /home/radware/ftp/ADC_config_task*.tgz |awk '{print$5}'" on "GENERIC_LINUX_SERVER" and validate result GTE "300"

  @SID_7
  Scenario: Cleanup
    Then UI logout and close browser
    Then CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
      | ALL     | error      | NOT_EXPECTED |

