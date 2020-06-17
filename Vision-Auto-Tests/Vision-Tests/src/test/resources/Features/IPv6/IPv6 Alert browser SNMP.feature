@TC108897
Feature: IPv6 Alert Browser SNMP

  @SID_1
  Scenario: IPv6 SNMP trap Cleanup
#    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from alert_rule;""
    Then MYSQL DELETE FROM "alert_rule" Table in "VISION_NG" Schema WHERE ""

#    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from snmp_target_server;""
    Then MYSQL DELETE FROM "snmp_target_server" Table in "VISION_NG" Schema WHERE ""

#    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from alrt_fltr_to_categories where category=(select row_id from alertsfilter where name='ProfileV6');""
    Then MYSQL DELETE FROM "alrt_fltr_to_categories" Table in "VISION_NG" Schema WHERE "category=(select row_id from alertsfilter where name='ProfileV6')"


    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from alrt_fltr_to_logical_grp_ids where alert_filter_id=(select row_id from alertsfilter where name='ProfileV6');""


    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from alrt_fltr_to_ids where device_id=(select row_id from alertsfilter where name='ProfileV6');""


    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from alrt_fltr_to_severities where severity=(select row_id from alertsfilter where name='ProfileV6');""


    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from alrt_fltr_to_modules where module=(select row_id from alertsfilter where name='ProfileV6');""

    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from alertsfilter where name='ProfileV6';""
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    Then REST Request "PUT" for "Vision Authentication->TACACS"
      | type | value                           |
      | body | primaryTacacsIP=172.17.167.166  |
      | body | primaryTacacsAuthPort=49        |
      | body | primarySharedSecret=radware     |
      | body | minimalRequiredPrivilegeLevel=0 |
      | body | serviceName=connection          |
    Then CLI Clear vision logs

  @SID_2
  Scenario: IPv6 SNMP trap login and create alert profile
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"
    When UI Do Operation "select" item "Alert profiles"
    Then UI Click Web element with id "gwt-debug-alertProfileSettings_NEW"
    Then UI Set Text Field "Name" To "ProfileV6"
    Then UI Click Button "Submit"

  @SID_3
  Scenario: IPv6 SNMP trap Configure target server
    When UI Do Operation "select" item "SNMP Reporting Configuration"
    Then UI Click Web element with id "gwt-debug-SnmpTargets_NEW"
    Then UI Click Button by id "gwt-debug-snmpVersion_SNMP_V2-input"
    Then UI Set Text field with id "gwt-debug-name_Widget" with "Server V6"
    Then UI Set Text field with id "gwt-debug-ipAddress_Widget" with "200a:0000:0000:0000:1001:1001:1001:1001"
    Then UI Set Text field with id "gwt-debug-port_Widget" with "162"
    Then UI Set Text field with id "gwt-debug-community_Widget" with "publicv6"
    Then UI Click Button "Submit"

  @SID_4
  Scenario: IPv6 SNMP trap Configure rule
    Then UI Click Web element with id "gwt-debug-alertrule_NEW"
    Then UI Set Text Field "Name" To "Rule V6"
    Then UI Select "ProfileV6" from Vision dropdown by Id "gwt-debug-snmpProfile.name_Widget-input"
    Then UI Select "Server V6" from Vision dropdown by Id "gwt-debug-snmpTarget.name_Widget-input"
    Then UI Click Button "Submit"
    Then UI logout and close browser

  @SID_5
  Scenario: IPv6 SNMP trap clear snmpd server log
    Then CLI Run remote linux Command "ssh root@172.17.178.20 'echo "cleared" $(date) > /var/log/snmptrap.log'" on "GENERIC_LINUX_SERVER"

  @SID_6
  Scenario: IPv6 SNMP trap Generate trap
    Then REST Request "POST" for "Login"
      | type                 | value               |
      | body                 | username=wrong_name |
      | body                 | password=wrong_pass |
      | Returned status code | 401                 |
    * Sleep "12"

  @SID_7
  Scenario: IPv6 SNMP delete alert rule
    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from alert_rule;""

  @SID_8
  Scenario: IPv6 Verify application trap received at snmpd server
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log |grep -a "Community:"|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Community: TRAP2, SNMP v2c, community publicv6"
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log |grep -a "iso.3.6.1.4.1.89.35.10.1.2"|tail -5'" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "iso.3.6.1.4.1.89.35.10.1.2 = STRING: "M_00864: Account wrong_name failed to log in."" in any line
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log |grep -a "iso.3.6.1.4.1.89.35.10.1.3"|tail -5'" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "iso.3.6.1.4.1.89.35.10.1.3 = STRING: "wrong_name"" in any line
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log |grep -a "iso.3.6.1.4.1.89.35.10.1.4"|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "iso.3.6.1.4.1.89.35.10.1.4 = STRING: "INFO""
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log |grep -a "iso.3.6.1.4.1.89.35.10.1.5"|tail -1'" on "GENERIC_LINUX_SERVER" and validate result EQUALS "iso.3.6.1.4.1.89.35.10.1.5 = STRING: "INSITE_GENERAL""
    Then CLI Run linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log |grep -a "Agent Hostname: UDP/IPv6: "|tail -1'" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "[200a::172:17:164:111]"
    Then CLI Run remote linux Command "ssh root@172.17.178.20 'cat /var/log/snmptrap.log > /tmp/trapfile.txt'" on "GENERIC_LINUX_SERVER"

  @SID_9
  Scenario: IPv6 SNMP trap - cleanup
    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from alert_rule;""
    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from snmp_target_server;""
    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from alrt_fltr_to_categories where category=(select row_id from alertsfilter where name='ProfileV6');""
    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from alrt_fltr_to_logical_grp_ids where alert_filter_id=(select row_id from alertsfilter where name='ProfileV6');""
    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from alrt_fltr_to_ids where device_id=(select row_id from alertsfilter where name='ProfileV6');""
    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from alrt_fltr_to_severities where severity=(select row_id from alertsfilter where name='ProfileV6');""
    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from alrt_fltr_to_modules where module=(select row_id from alertsfilter where name='ProfileV6');""
    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from alertsfilter where name='ProfileV6';""
    Given CLI Run remote linux Command "service vision restart" on "ROOT_SERVER_CLI" and wait 185 seconds
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |