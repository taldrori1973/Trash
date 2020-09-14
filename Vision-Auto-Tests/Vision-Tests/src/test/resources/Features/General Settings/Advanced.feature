@VisionSettings @TC106044

Feature: Advanced Vision General Settings

  @SID_1
  Scenario: Login clear alert table and add devices
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then REST Delete ES index "alert"

  @SID_2
  Scenario: Add Alteon device
    Then UI Add "Alteon" with index 3 on "Default" site
    Then UI Wait For Device To Show Up In The Topology Tree "Alteon" device with index 3 with timeout 300

  @SID_3
  Scenario: Navigate to Advanced page
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Advanced"

  @SID_4
  Scenario: Advanced - set max backup config file Parameters
    Then UI Set Text Field "Maximum Configuration Files per Device" To "1"
    Then UI Click Button "Submit"
    Then UI Validate Text field "Maximum Configuration Files per Device" EQUALS "1"

  @SID_5
  Scenario: create device configuration file twice and verify only one exist
    Then UI export Alteon DeviceCfg by type "Alteon" with index "3" with source to upload from "Server"
    Then UI export Alteon DeviceCfg by type "Alteon" with index "3" with source to upload from "Server"
    Then UI Go To Vision
    Then UI Navigate to page "System->Device Resources->Device Backups"
    Then UI validate Table RecordsCount "1" with Identical ColumnValue "172.17.178.2" by columnKey "Device Name" by elementLabelId "DeviceFile" by deviceDriverType "VISION" findBy Type "BY_ID"

  @SID_6
  Scenario: Advanced - set log level Parameters
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Advanced"
    Then UI Select "Warning" from Vision dropdown "Minimal Log Level"
    Then UI Click Button "Submit"
    Then UI validate DropDown textOption Selection "Warning" by elementLabelId "Minimal Log Level" by deviceDriverType "VISION" findBy Type "BY_NAME"
    Then UI Select "Error" from Vision dropdown "Minimal Log Level"
    Then UI Click Button "Submit"

  @SID_7
  Scenario: Advanced - set device lock timeout Parameters
    * REST Request "PUT" for "Advanced->Advanced Parameters"
      | type                 | value                 |
      | body                 | deviceLockAgingTime=2 |
      | Returned status code | 200                   |

  @SID_8
  Scenario: Advanced - verify device unlock after timeout Parameters but not before
    When REST Lock Action on "Alteon" 3
    Then Sleep "45"
    Then REST Put Scalar on "Alteon" 3 values "sysLocation=a"
    When Sleep "60"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_00926: Alteon_* unlocked due to inactivity."}}]}},"from":0,"size":2}' localhost:9200/alert/_search |grep "\"severity\":\"INFO\""|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    When Sleep "142"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"wildcard":{"message":"M_00926: Alteon_* unlocked due to inactivity."}}]}},"from":0,"size":2}' localhost:9200/alert/_search |grep "\"severity\":\"INFO\""|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_9
  Scenario: Advanced - set OLH source Parameters
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Advanced"
    Then UI Select "Radware.com" from Vision dropdown "Online Help URL"
    Then UI Click Button "Submit"
    Then UI validate DropDown textOption Selection "Radware.com" by elementLabelId "Online Help URL" by deviceDriverType "VISION" findBy Type "BY_NAME"

  @SID_10
  Scenario: Advanced - validate OLH opens to radware.com
    Then UI Click Button by id "gwt-debug-DeviceControlBar_Help"
    Then UI validate Browser Tab Existence by URL "https://webhelp.radware.com/visionweb/en_US/index.html"

  @SID_11
  Scenario: Advanced - set results per page Parameters
    * REST Request "PUT" for "Advanced->Advanced Parameters"
      | type | value                     |
      | body | paginationResultPerPage=3 |

  @SID_12
  Scenario: create at least 4 alerts and verify 10 Alerts per Page
    Then REST Lock Action on "Alteon" 3
    Then REST Unlock Action on "Alteon" 3
    Then REST Lock Action on "Alteon" 3
    Then REST Unlock Action on "Alteon" 3
    Then REST Lock Action on "Alteon" 3
    Then REST Unlock Action on "Alteon" 3
    Then Sleep "12"
    Then UI Open Upper Bar Item "ALERTS"
    Then UI validate Table RecordsCount per Page "3" with Device Driver Type "VISION" by elementNameId "Alerts Table" findBy Type "BY_NAME"
    Then UI Open Upper Bar Item "ALERTS"

  @SID_13
  Scenario: Back to initial settings - Delete devices and Logout
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Advanced"
    Then UI Set Text Field "Maximum Configuration Files per Device" To "5"
    Then UI Select "Error" from Vision dropdown "Minimal Log Level"
    Then UI Set Text Field "Device Lock Timeout" To "10"
    Then UI Select "50" from Vision dropdown "Results per Page"
    Then UI Select "APSolute Vision Server" from Vision dropdown "Online Help URL"
    Then UI Click Button "Submit"
#    Then UI Delete "Alteon" device with index 3 from topology tree
    Then UI Logout


