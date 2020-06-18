
@TC111876
Feature: DefensePro Network Policy Import to Device

  @SID_1
  Scenario: Login and cleanup
    When UI Login with user "sys_admin" and password "radware"
    Then REST Delete ES index "alert"
    Then CLI Run remote linux Command "rm -f /home/radware/Scripts/DP_config" on "GENERIC_LINUX_SERVER"
    Then CLI Clear vision logs

  @SID_2
  Scenario: Delete Network policy from DP if exists
    Given Rest delete Policy "auto_import_DP" from DP if Exist
      | index |
      | 11    |

  @SID_3
  Scenario: Delete Network template from vision if exists
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_exported_file where name='auto_import_DP';"" on "ROOT_SERVER_CLI"
    Then MYSQL DELETE FROM "device_exported_file" Table in "VISION_NG" Schema WHERE "name='auto_import_DP'"
  @SID_4
  Scenario: Upload network policy to vision
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "nohup /home/radware/Scripts/upload_policy.sh " |
      | #visionIP                                       |
      | " /home/radware/Scripts/auto_import_DP"         |

  @SID_5
  Scenario: Import network policy to DefensePro
    And UI Navigate to "SCHEDULER" page via homePage
    Then UI Click Button by id "gwt-debug-ToolBox_ADVANCED"
    Then UI Click Button by id "gwt-debug-NetworkProtectionNode-content"
    Then UI Set Text field with id "gwt-debug-name_SearchControl" with "auto"
    Then UI Click Button by id "gwt-debug-DPConfigurationTemplatesTable_ApplyFilter"
    Then UI click Table Record with ColumnValue "auto_import_DP" by columnKey "File Name" by elementLabelId "gwt-debug-DPConfigurationTemplatesTable" by deviceDriverType "VISION" findBy Type "BY_NAME"
    Then UI Click Button by id "gwt-debug-DPConfigurationTemplatesTable_Send_to_Devices"
    Then UI DualList Move deviceIndex 11 deviceType "DefensePro" DualList Items to "RIGHT" , dual list id "gwt-debug-deviceIpAddresses"
    Then UI Click Web element with id "gwt-debug-ConfigTab_EDIT_DPConfigTemplates.SendFileToDevice_Submit"
    Then Sleep "10"

  @SID_6
  Scenario: Download DP configuration
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "nohup /home/radware/Scripts/download_DP_config.sh " |
      | #visionIP                                            |
      | " 172.16.22.51"                                      |

  @SID_7
  Scenario: Verify network policy in device configuration
    When CLI Run linux Command "grep "auto_import_DP" /home/radware/Scripts/DP_config" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "dp policies-config table setCreate auto_import_DP -sn 12.4.4.4"

  @SID_8
  Scenario: Verify alert message
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"match":{"module":"DEVICE_GENERAL"}},{"match":{"severity":"INFO"}},{"match":{"userName":"sys_admin"}},{"wildcard":{"message":"*User sys_admin uploaded file DefensePro Template auto_import_DP to device*successfully*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search | grep "hits\":{\"total\":1" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_9
  Scenario: Cleanup
    Then UI logout and close browser
    And CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
      | ALL     | error      | NOT_EXPECTED |
