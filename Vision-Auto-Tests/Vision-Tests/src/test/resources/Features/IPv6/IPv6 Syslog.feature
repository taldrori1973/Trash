@TC108881
Feature: Alert Settings - Syslog Reporting Functionality IPv6

  @SID_1
  Scenario: Syslog IPv6 cleanup
#    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from syslog_filter_to_severities;""
    Then MYSQL DELETE FROM "syslog_filter_to_severities" Table in "VISION_NG" Schema WHERE ""

#    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from syslog_filter_to_device_ids;""
    Then MYSQL DELETE FROM "syslog_filter_to_device_ids" Table in "VISION_NG" Schema WHERE ""

#    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from syslog_filter_to_modules;""
    Then MYSQL DELETE FROM "syslog_filter_to_modules" Table in "VISION_NG" Schema WHERE ""

#    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from syslog_server;""
    Then MYSQL DELETE FROM "syslog_server" Table in "VISION_NG" Schema WHERE ""

#    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from syslog_filter;""
    Then MYSQL DELETE FROM "syslog_filter" Table in "VISION_NG" Schema WHERE ""

#    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "update syslog_global_params set enable_syslog_reporting=b'0';""
    Then MYSQL UPDATE "syslog_global_params" Table in "VISION_NG" Schema SET "enable_syslog_reporting" Column Value as false WHERE ""
#    Then UI Add "Alteon" with index 40 on "Default" site
    Then CLI Clear vision logs

  @SID_2
  Scenario: Login and Navigate to Alert Browser page IPv6
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"

  @SID_3
  Scenario: Syslog Reporting - enable syslog IPv6
    When UI Do Operation "select" item "Syslog Reporting"
#    Then UI Set Checkbox "Enable Detailed Auditing of APSolute Vision Activity" To "true"
#    Then UI Set Checkbox "Enable Detailed APSolute Vision Auditing of Device Configuration Changes" To "true"
    Then UI Set Checkbox "Enable Syslog Reporting" To "true"
    Then UI Set Checkbox "Enable Encryption" To "false"
    Then UI Set Checkbox "Enable Authentication" To "false"
    Then UI Click Button "Submit"

  @SID_4
  Scenario: Syslog Reporting - add syslog server parameters IPv6
    Then UI Click Web element with id "gwt-debug-alertBrowserSettings_NEW"
    Then UI Set Checkbox "Enable Server" To "true"
    Then UI Select "Audit Messages" from Vision dropdown "Report"
    Then UI Set Text Field "Syslog Server Address" To "200a:0000:0000:0000:1001:1001:1001:1001"
    Then UI Set Text Field "L4 Destination Port" To "514"
#    Then UI Select "Local Use 1" from Vision dropdown "Syslog Facility"
    Then UI Click Button "Submit"

  @SID_5
  Scenario: Syslog Reporting - Generate alert
#    Then UI DualList Move deviceIndex 40 deviceType "Alteon" DualList Items to "RIGHT" , dual list id "gwt-debug-syslogFilter.deviceOrmIds"
    Then CLI Run remote linux Command "ssh root@172.17.178.20 'echo "cleared" $(date) > /var/log/syslog'" on "GENERIC_LINUX_SERVER"
    Then UI Set Checkbox "Enable Detailed Auditing of APSolute Vision Activity" To "true"
    Then UI Click Button "Submit"
    Then UI Set Checkbox "Enable Detailed Auditing of APSolute Vision Activity" To "false"
    Then UI Click Button "Submit"

  @SID_6
  Scenario: Syslog IPv6 Reporting - verify alert recieved in syslog server
#    Then UI Set Checkbox "Critical" To "false"
#    Then UI Set Checkbox "Minor" To "true"
#    Then UI Set Checkbox "Information" To "true"
#    Then UI Set Checkbox "Major" To "false"
#    Then UI Set Checkbox "Warning" To "true"
    Then Sleep "10"
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/syslog|tr "\n" " ";echo'" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "changed the detailed APSolute Vision activity auditing alerts feature to"



#  @SID_7
#  Scenario: Syslog Reporting - add syslog server modules IPv6
#    Then UI Set Checkbox "Device Security" To "true"
#    Then UI Set Checkbox "Vision General" To "true"
#    Then UI Set Checkbox "Vision Control" To "false"
#    Then UI Set Checkbox "Device General" To "true"
#    Then UI Set Checkbox "Vision Configuration" To "true"
#    Then UI Set Checkbox "Security Reporting" To "true"
#    Then UI Set Checkbox "Warning" To "true"
#    Then UI Set Checkbox "Trouble Ticket" To "false"
#    Then UI Set Checkbox "Operator Toolbox" To "false"

#  @SID_7
#  Scenario: Syslog Reporting - add save and validate success IPv6
#    Then UI Click Button "Submit"
#    Then UI Open Upper Bar Item "Refresh"
#    Then UI validate Vision Table row by keyValue with elementLabel "Syslog Server" findBy columnName "Syslog Server Address" findBy cellValue "10.205.103.204"

#  @SID_8
#  Scenario: Syslog Reporting - validate Parameters IPv6
#    Then UI Click Web element with id "gwt-debug-alertBrowserSettings_RowID_0_CellID_syslogServerAddress"
#    Then UI Click Web element with id "gwt-debug-alertBrowserSettings_EDIT"
#    Then UI validate Vision DualList by ID "gwt-debug-syslogFilter.deviceOrmIds" with rightList "" with leftList "DefensePro_172.16.22.26,Alteon_172.17.178.2"
#    Then UI validate Checkbox by label "Critical" if Selected "false"
#    Then UI validate Checkbox by label "Minor" if Selected "true"
#    Then UI validate Checkbox by label "Information" if Selected "true"
#    Then UI validate Checkbox by label "Major" if Selected "false"
#    Then UI validate Checkbox by label "Warning" if Selected "true"
#    Then UI validate Checkbox by label "Device Security" if Selected "true"
#    Then UI validate Checkbox by label "Vision General" if Selected "true"
#    Then UI validate Checkbox by label "Vision Control" if Selected "false"
#    Then UI validate Checkbox by label "Device General" if Selected "true"
#    Then UI validate Checkbox by label "Vision Configuration" if Selected "true"
#    Then UI validate Checkbox by label "Security Reporting" if Selected "true"
#    Then UI validate Checkbox by label "Warning" if Selected "true"
#    Then UI validate Checkbox by label "Trouble Ticket" if Selected "false"
#    Then UI validate Checkbox by label "Operator Toolbox" if Selected "false"
#    Then CLI tcpDump Values Validation following vision-device event execution by command "tcpdump -s 0 -i G1 -X port 514" by expectedValues "SYSLOG" by deviceIp "172.16.22.26" by body "{ "rsIpFragmentQueuingLimit":"46" }"

#  @SID_9
#  Scenario: Delete devices IPv6
#    Then UI Delete "Alteon" device with index 40 from topology tree

  @SID_7
  Scenario: disable syslog Logout and check logs IPv6
#    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "update syslog_global_params set enable_syslog_reporting=b'0';""
    Then MYSQL UPDATE "syslog_global_params" Table in "VISION_NG" Schema SET "enable_syslog_reporting" Column Value as false WHERE ""

    Then UI logout and close browser
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal        | NOT_EXPECTED |