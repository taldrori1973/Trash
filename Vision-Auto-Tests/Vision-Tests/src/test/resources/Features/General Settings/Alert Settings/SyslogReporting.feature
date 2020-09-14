@VisionSettings @TC106048

Feature: Alert Settings - Syslog Reporting Functionality

  @SID_1
  Scenario: Add Alteon and DP devices
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Add "DefensePro" with index 1 on "Default" site
    Then UI Add "Alteon" with index 3 on "Default" site
    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from syslog_filter_to_severities;""
    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from syslog_filter_to_device_ids;""
    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from syslog_filter_to_modules;""
    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from syslog_server;""
    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from syslog_filter;""
    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "update syslog_global_params set enable_syslog_reporting=b'0';""
#    Then UI Add "Alteon" with index 40 on "Default" site
    Then CLI Clear vision logs


  @SID_2
  Scenario: Navigate to Alert Browser page
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"

  @SID_3
  Scenario: Syslog Reporting - enable syslog
    When UI Do Operation "select" item "Syslog Reporting"
    Then UI Set Checkbox "Enable Detailed Auditing of APSolute Vision Activity" To "true"
    Then UI Set Checkbox "Enable Detailed APSolute Vision Auditing of Device Configuration Changes" To "true"
    Then UI Set Checkbox "Enable Syslog Reporting" To "true"
    Then UI Set Checkbox "Enable Encryption" To "false"
    Then UI Set Checkbox "Enable Authentication" To "false"
    Then UI Click Button "Submit"

  @SID_4
  Scenario: Syslog Reporting - add syslog server parameters
    Then UI Click Web element with id "gwt-debug-alertBrowserSettings_NEW"
    Then UI Set Checkbox "Enable Server" To "true"
    Then UI Select "Audit Messages" from Vision dropdown "Report"
    Then UI Set Text Field "Syslog Server Address" To "172.17.178.20"
    Then UI Set Text Field "L4 Destination Port" To "514"
    Then UI Select "Local Use 4" from Vision dropdown "Syslog Facility"

  @SID_5
  Scenario: Syslog Reporting - add syslog server devices
    Then UI DualList Move deviceIndex 3 deviceType "Alteon" DualList Items to "RIGHT" , dual list id "gwt-debug-syslogFilter.deviceOrmIds"
    Then UI DualList Move deviceIndex 1 deviceType "DefensePro" DualList Items to "RIGHT" , dual list id "gwt-debug-syslogFilter.deviceOrmIds"


  @SID_6
  Scenario: Syslog Reporting - add syslog server severities
    Then UI Set Checkbox "Critical" To "false"
    Then UI Set Checkbox "Minor" To "true"
    Then UI Set Checkbox "Information" To "true"
    Then UI Set Checkbox "Major" To "false"
    Then UI Set Checkbox "Warning" To "true"

  @SID_7
  Scenario: Syslog Reporting - add syslog server modules
    Then UI Set Checkbox "Device Security" To "true"
    Then UI Set Checkbox "Vision General" To "true"
    Then UI Set Checkbox "Vision Control" To "false"
    Then UI Set Checkbox "Device General" To "true"
    Then UI Set Checkbox "Vision Configuration" To "true"
    Then UI Set Checkbox "Security Reporting" To "true"
    Then UI Set Checkbox "Warning" To "true"
    Then UI Set Checkbox "Trouble Ticket" To "false"
    Then UI Set Checkbox "Operator Toolbox" To "false"

  @SID_8
  Scenario: Syslog Reporting - add save and validate success
    Then UI Click Button "Submit"
    Then UI Open Upper Bar Item "Refresh"
    Then UI validate Vision Table row by keyValue with elementLabel "Syslog Server" findBy columnName "Syslog Server Address" findBy cellValue "172.17.178.20"

  @SID_9
  Scenario: Syslog Reporting - validate Parameters
    Then UI Click Web element with id "gwt-debug-alertBrowserSettings_RowID_0_CellID_syslogServerAddress"
    Then UI Click Web element with id "gwt-debug-alertBrowserSettings_EDIT"
#    Then UI validate Vision DualList by ID "gwt-debug-syslogFilter.deviceOrmIds" with rightList "" with leftList "DefensePro_172.16.22.24,Alteon_172.17.178.2"
    Then UI validate Checkbox by label "Critical" if Selected "false"
    Then UI validate Checkbox by label "Minor" if Selected "true"
    Then UI validate Checkbox by label "Information" if Selected "true"
    Then UI validate Checkbox by label "Major" if Selected "false"
    Then UI validate Checkbox by label "Warning" if Selected "true"
    Then UI validate Checkbox by label "Device Security" if Selected "true"
    Then UI validate Checkbox by label "Vision General" if Selected "true"
    Then UI validate Checkbox by label "Vision Control" if Selected "false"
    Then UI validate Checkbox by label "Device General" if Selected "true"
    Then UI validate Checkbox by label "Vision Configuration" if Selected "true"
    Then UI validate Checkbox by label "Security Reporting" if Selected "true"
    Then UI validate Checkbox by label "Warning" if Selected "true"
    Then UI validate Checkbox by label "Trouble Ticket" if Selected "false"
    Then UI validate Checkbox by label "Operator Toolbox" if Selected "false"
#    Then CLI tcpDump Values Validation following vision-device event execution by command "tcpdump -s 0 -i G1 -X port 514" by expectedValues "SYSLOG" by deviceIp "172.16.22.26" by body "{ "rsIpFragmentQueuingLimit":"46" }"

  @SID_10
  Scenario: Clear syslog server logs
#    Then UI Delete "DefensePro" device with index 3 from topology tree
#    Then UI Delete "Alteon" device with index 3 from topology tree

  @SID_11
  Scenario: Logout
    Then UI Logout