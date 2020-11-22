@TC111504
Feature: IPv6 Scheduled task Backup Alteon

  @SID_1
  Scenario: Delete Alteon and site if exists
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_file where fk_dev_site_tree_el=(select row_id from site_tree_elem_abs where name='Alteon_200a::172:17:164:19');"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from dpm_virtual_services where fk_device=(select row_id from site_tree_elem_abs where name='Alteon_200a::172:17:164:19');"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='Alteon_200a::172:17:164:19';"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_setup where fk_dev_access_device_acces=(select row_id from device_access where mgt_ip="200a:0:0:0:172:17:164:19");"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_access where mgt_ip="200a:0:0:0:172:17:164:19";"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='Alteons-IPv6';"" on "ROOT_SERVER_CLI"

  @SID_2
  Scenario: Add IPv6 Alteon and clean FTP server log
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/ADC_config_IPv6_task*.tgz" on "GENERIC_LINUX_SERVER"
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.2.1.0-DD-1.00-110.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.2.1.0-DD-1.00-110.jar" on "ROOT_SERVER_CLI" with timeOut 240
    Then CLI Run remote linux Command "service iptables restart" on "ROOT_SERVER_CLI"
    # This is to WA DE52911
    Then Sleep "90"

  @SID_3
  Scenario: Login and go to scheduler screen
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Add new Site "Alteons-IPv6" under Parent "Default"
    Then UI Add "Alteon" with index 40 on "Alteons-IPv6" site
    When UI Open scheduler window

  @SID_4
  Scenario: Create new task of export Alteon configuration
    Then UI Click Button by id "gwt-debug-scheduledTasks_NEW"
    Then UI Select "Device Configuration Backup" from Vision dropdown by Id "gwt-debug-taskType_Widget-input"
    Then UI Set Text field with id "gwt-debug-name_Widget" with "IPv6_export_task"
    Then UI Set Text field with id "gwt-debug-scheduledTasks.Schedule.Daily.Time_Widget" with "13:00:00"

    Then UI Click Button by id "gwt-debug-backupDestinationParameters_Tab"
    Then UI Click Button by id "gwt-debug-backupDestination_EXTERNAL_LOCATION-input"

    Then UI Select "FTP" from Vision dropdown by Id "gwt-debug-additionalParams.transportProtocol_Widget-input"
    Then UI Set Text field with id "gwt-debug-additionalParams.pathToFile_Widget" with "/home/radware/ftp"
    Then UI Set Text field with id "gwt-debug-additionalParams.userName_Widget" with "radware"
    Then UI Set Text field with id "gwt-debug-additionalParams.password_Widget" with "radware"
    Then UI Set Text field with id "gwt-debug-additionalParams.password_DuplicatePasswordField" with "radware"
    Then UI Set Text field with id "gwt-debug-additionalParams.backupFileName_Widget" with "ADC_config_IPv6_task"
    Then UI Set Text field with id "gwt-debug-additionalParams.ip_Widget" with "200a:0000:0000:0000:172:17:164:10"

    Then UI Click Button by id "gwt-debug-scheduledTasksDualList_Tab"
    Then UI Set Text field with id "gwt-debug-managementIp_SearchControl" with "Alteon"
    Then UI Click Button by id "gwt-debug-devicesList_ApplyFilter"
    Then UI DualList Move deviceIndex 40 deviceType "Alteon" DualList Items to "RIGHT" , dual list id "gwt-debug-devicesList"
    Then UI DualList Move deviceIndex 40 deviceType "Alteon" DualList Items to "RIGHT" , dual list id "gwt-debug-devicesList"
    Then UI Click Button by id "gwt-debug-ConfigTab_NEW_scheduledTasks_Submit"

  @SID_5
  Scenario: Run The task
    Then UI Run task with name "IPv6_export_task"

  @SID_6
  Scenario: Delete The task
    Then UI Delete task with name "IPv6_export_task"

  @SID_7
  Scenario: Validate exported file in FTP server

    Then CLI Run linux Command "ll /home/radware/ftp/ADC_config_IPv6_task*.tgz |awk '{print$5}'" on "GENERIC_LINUX_SERVER" and validate result GTE "3"

  @SID_8
  Scenario: Delete Alteon devices from tree
    Then UI open Topology Tree view "SitesAndClusters" site
    Then UI Delete "Alteon" device with index 40 from topology tree

  @SID_9
  Scenario: Cleanup
    Then UI logout and close browser
    Then CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
      | ALL     | error      | NOT_EXPECTED |

