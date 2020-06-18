@TC111503
Feature: IPv6 Export device configuration

  @SID_1
  Scenario: Login and clear device configuration table
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Then UI Login with user "radware" and password "radware"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from dpm_virtual_services where fk_device=(select row_id from site_tree_elem_abs where name='Alteon_200a::172:17:164:19');"" on "ROOT_SERVER_CLI"
    Then MYSQL DELETE FROM "" Table in "VISION_NG" Schema WHERE ""

    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_file where dev_type='Alteon';"" on "ROOT_SERVER_CLI"
    Then MYSQL DELETE FROM "" Table in "VISION_NG" Schema WHERE ""

    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='Alteon_200a::172:17:164:19';"" on "ROOT_SERVER_CLI"
    Then MYSQL DELETE FROM "" Table in "VISION_NG" Schema WHERE ""

    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_setup where fk_dev_access_device_acces=(select row_id from device_access where mgt_ip="200a:0:0:0:172:17:164:19");"" on "ROOT_SERVER_CLI"
    Then MYSQL DELETE FROM "" Table in "VISION_NG" Schema WHERE ""

    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_access where mgt_ip="200a:0:0:0:172:17:164:19";"" on "ROOT_SERVER_CLI"
    Then MYSQL DELETE FROM "" Table in "VISION_NG" Schema WHERE ""

    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='Alteons-IPv6';"" on "ROOT_SERVER_CLI"
    Then MYSQL DELETE FROM "" Table in "VISION_NG" Schema WHERE ""

  @SID_2
  Scenario: Upload Driver to vision
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.2.1.0-DD-1.00-110.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.2.1.0-DD-1.00-110.jar" on "ROOT_SERVER_CLI" with timeOut 240
    Then Sleep "90"

  @SID_3
  Scenario: Add new IPv6 Alteon to site
    Then UI Add new Site "Alteons-IPv6" under Parent "Default"
    Then UI Add "Alteon" with index 40 on "Alteons-IPv6" site

  @SID_4
  Scenario: Export Alteon configuration to server
    Then UI export Alteon DeviceCfg by type "Alteon" with index "40" with source to upload from "Server"

  @SID_5
  Scenario: Validate backup file in vision server
    Then UI Go To Vision
    Then UI Navigate to page "System->Device Resources->Device Backups"
    Then UI validate Table RecordsCount "1" with Identical ColumnValue "Alteon_200a::172:17:164:19" by columnKey "Device Name" by elementLabelId "DeviceFile" by deviceDriverType "VISION" findBy Type "BY_ID"

  @SID_6
  Scenario: Delete Alteon devices from tree
    Then UI open Topology Tree view "SitesAndClusters" site
    Then UI Delete "Alteon" device with index 40 from topology tree

  @SID_7
  Scenario: logout
    Then UI logout and close browser