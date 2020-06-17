@TC111534
Feature: DefenseFlow operation - export configuration

  @SID_1
  Scenario: Login and Clean data
    Given UI Login with user "sys_admin" and password "radware"
#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_file where dev_type='DefenseFlow';"" on "ROOT_SERVER_CLI"
    Then MYSQL DELETE FROM "device_file" Table in "VISION_NG" Schema WHERE "dev_type='DefenseFlow'"

  @SID_2
  Scenario: Move to DefenseFlow configuration screen
#    Then UI Click Button by id "gwt-debug-applicationMenu"
#    Then UI Click Button by id "gwt-debug-Global_defenseFlow_Old"
    Then UI Navigate to "Configuration" page via homePage
  @SID_3
  Scenario: Export configuration to server
    Then UI Click Button by id "gwt-debug-DeviceControlBar_Operations"
    Then UI Click Button by id "gwt-debug-DeviceControlBar_Operations_getfromdevice_Configuration"
    Then UI Click Button by id "gwt-debug-System.DfcConfigurationDownload.Destination_System.System.DfcConfigurationDownload.Destination.Server-input"
    Then UI Click Button by id "gwt-debug-Dialog_Box_OK"

  @SID_4
  Scenario: Validate backup file in server table
    When UI Go To Vision
    Then UI Navigate to page "System->Device Resources->Device Backups"
    Then UI validate Table RecordsCount "1" with Identical ColumnValue "DefenseFlow" by columnKey "Device Name" by elementLabelId "DeviceFile" by deviceDriverType "VISION" findBy Type "BY_ID"
