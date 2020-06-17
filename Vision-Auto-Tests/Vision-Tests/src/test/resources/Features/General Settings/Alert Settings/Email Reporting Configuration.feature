@VisionSettings @TC106046

Feature: Alert Settings - Email Reporting Configuration

  @SID_1
  Scenario: Email setup requirements and clear logs
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Then CLI Operations - Run Root Session command "sed -i '/mymail.local/d' /etc/hosts"
    Then CLI Operations - Run Root Session command "echo "172.17.164.10 mymail.local" >> /etc/hosts"
#    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from alrt_fltr_to_ids where device_id=(select fk_alerts_mail_filter from alertsmailnotifiersettings);""
    Then MYSQL DELETE FROM "alrt_fltr_to_ids" Table in "VISION_NG" Schema WHERE "device_id=(select fk_alerts_mail_filter from alertsmailnotifiersettings)"
    Then CLI Clear vision logs

  @SID_2
  Scenario: login and go to email page
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"
    When UI Do Operation "select" item "Email Reporting Configuration"

  @SID_3
  Scenario: set basic Email Parameters
    Then UI Set Checkbox "Enable Detailed Auditing of APSolute Vision Activity" To "false"
    Then UI Set Checkbox "Enable Detailed APSolute Vision Auditing of Device Configuration Changes" To "false"
    Then UI Set Checkbox "Enable" To "true"
    Then UI Set Text Field "SMTP Server Address" To "mymail.local"
    Then UI Set Text Field "SMTP User Name" To "user@automation.local"
    Then UI Set Text Field "Subject Header" To "This is automated test"
    Then UI Set Text Field "From Header" To "Automation system"
    Then UI Set Text Field "Recipient Email Address" To "automation.email@alert.local"
    Then UI Set Text Field "Email Sending Interval" To "30"
    Then UI Select "1" from Vision dropdown "Alerts per Email"
    Then UI Set Checkbox "Critical" To "true"
    Then UI Set Checkbox "Minor" To "true"
    Then UI Set Checkbox "Information" To "true"
    Then UI Set Checkbox "Major" To "true"
    Then UI Set Checkbox "Warning" To "true"
    Then UI Set Checkbox "Device Security" To "true"
    Then UI Set Checkbox "Device General" To "true"
    Then UI Set Checkbox "Vision General" To "true"
    Then UI Set Checkbox "Vision Control" To "true"
    Then UI Set Checkbox "Trouble Ticket" To "true"
    Then UI Set Checkbox "Vision Configuration" To "true"
    Then UI Set Checkbox "Security Reporting" To "true"
    Then UI Set Checkbox "Operator Toolbox" To "true"
    Then UI Set Checkbox "Device Health Errors" To "true"
    Then UI Set Checkbox "Vision Analytics Alerts" To "true"
    Then UI Set Checkbox "Device Throughput License Errors" To "true"
    Then UI Set Checkbox "Device Throughput License Exceeded Errors" To "true"
    Then UI Click Button "Submit"

  @SID_4
  Scenario: Validate basic UI Email Parameters
    Then UI validate Checkbox by label "Enable" if Selected "true"
    Then UI Validate Text field "SMTP Server Address" EQUALS "mymail.local"
    Then UI Validate Text field "SMTP User Name" EQUALS "user@automation.local"
    Then UI Validate Text field "Subject Header" EQUALS "This is automated test"
    Then UI Validate Text field "From Header" EQUALS "Automation system"
    Then UI Validate Text field "Recipient Email Address" EQUALS "automation.email@alert.local"
    Then UI Validate Text field "Email Sending Interval" EQUALS "30"
    Then UI validate DropDown textOption Selection "1" by elementLabelId "Alerts per Email" by deviceDriverType "VISION" findBy Type "BY_NAME"
#    Then UI validate Vision DualList by ID "gwt-debug-alertsMailNotifierSettings.alertsMailNotifierFilter.deviceOrmIds" with rightList "DefensePro_172.16.22.26,Alteon_172.17.178.2" with leftList ""
    Then UI validate Checkbox by label "Critical" if Selected "true"
    Then UI validate Checkbox by label "Minor" if Selected "true"
    Then UI validate Checkbox by label "Information" if Selected "true"
    Then UI validate Checkbox by label "Major" if Selected "true"
    Then UI validate Checkbox by label "Warning" if Selected "true"
    Then UI validate Checkbox by label "Device Security" if Selected "true"
    Then UI validate Checkbox by label "Vision General" if Selected "true"
    Then UI validate Checkbox by label "Vision Control" if Selected "true"
    Then UI validate Checkbox by label "Trouble Ticket" if Selected "true"
    Then UI validate Checkbox by label "Device General" if Selected "true"
    Then UI validate Checkbox by label "Vision Configuration" if Selected "true"
    Then UI validate Checkbox by label "Security Reporting" if Selected "true"
    Then UI validate Checkbox by label "Operator Toolbox" if Selected "true"
    Then UI validate Checkbox by label "Device Health Errors" if Selected "true"
    Then UI validate Checkbox by label "Vision Analytics Alerts" if Selected "true"
    Then UI validate Checkbox by label "Device Throughput License Errors" if Selected "true"
    Then UI validate Checkbox by label "Device Throughput License Exceeded Errors" if Selected "true"
#    Then UI Set Checkbox "Enable" To "false"
#    Then UI Click Button "Submit"

  @SID_5
  Scenario: test Email filter by devices Alteon negative
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    When REST Lock Action on "Alteon" 12
    Then REST Unlock Action on "Alteon" 12
    When REST Lock Action on "DefensePro" 11
    Then REST Unlock Action on "DefensePro" 11
    Then Sleep "35"
    Then CLI Run linux Command "cat /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run remote linux Command "/bin/cp /var/spool/mail/alertuser /tmp/alertuser" on "GENERIC_LINUX_SERVER"


  @SID_6
  Scenario: test Email filter by devices Alteon
    Then UI DualList Move deviceIndex 12 deviceType "Alteon" DualList Items to "RIGHT" , dual list id "gwt-debug-alertsMailNotifierSettings.alertsMailNotifierFilter.deviceOrmIds"
    Then UI Click Button "Submit"
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    When REST Lock Action on "Alteon" 12
    Then REST Unlock Action on "Alteon" 12
    Then Sleep "35"
    Then CLI Run linux Command "cat /var/spool/mail/alertuser |grep "INFO"|awk '{print$10}'|head -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.101.21"
    Then CLI Run linux Command "cat /var/spool/mail/alertuser |grep "INFO"|awk '{print$12}'|head -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Alteon_50.50.101.21"

  @SID_7
  Scenario: test Email filter by devices DefensePro
    Then UI DualList Move deviceIndex 11 deviceType "DefensePro" DualList Items to "RIGHT" , dual list id "gwt-debug-alertsMailNotifierSettings.alertsMailNotifierFilter.deviceOrmIds"
    Then UI Click Button "Submit"
    Then Sleep "30"
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    When REST Lock Action on "DefensePro" 11
    Then REST Unlock Action on "DefensePro" 11
    Then Sleep "35"
    Then CLI Run linux Command "cat /var/spool/mail/alertuser |grep "INFO"|awk '{print$10}'|head -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "172.16.22.51"
    Then CLI Run linux Command "cat /var/spool/mail/alertuser |grep "INFO"|awk '{print$12}'|head -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "DefensePro_172.16.22.51"
    Then CLI Run remote linux Command "/bin/cp /var/spool/mail/alertuser /tmp/alertuser_step7" on "GENERIC_LINUX_SERVER"

  @SID_8
  Scenario: Verify recieved mail TO
    Then CLI Run linux Command "grep "X-Original-To: automation.email@alert.local" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "2"

  @SID_9
  Scenario: Verify recieved mail count
    Then CLI Run linux Command "grep "Message-ID" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "2"

  @SID_10
  Scenario: Verify recieved mail BODY
    Then CLI Run linux Command "cat /var/spool/mail/alertuser |grep "DefensePro_172.16.22.51, 172.16.22.51 unlocked by user sys_admin"|wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "1"
    Then CLI Run linux Command "cat /var/spool/mail/alertuser |grep "DefensePro_172.16.22.51, 172.16.22.51 locked by user sys_admin"|wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "1"

  @SID_11
  Scenario: Verify recieved mail FROM
    Then CLI Run linux Command "cat /var/spool/mail/alertuser |grep "From\: "|head -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "From: Automation system <user@automation.local>"


  @SID_12
  Scenario: Verify recieved mail SUBJECT
    Then CLI Run linux Command "cat /var/spool/mail/alertuser |grep "Subject\: "|head -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Subject: This is automated test"
    Then CLI Run remote linux Command "/bin/cp /var/spool/mail/alertuser /tmp/alertuser_step12" on "GENERIC_LINUX_SERVER"

  @SID_13
  Scenario: Verify recieved mail USER
    Then CLI Run linux Command "cat /var/spool/mail/alertuser |grep "From "|awk '{print$2}'|head -1" on "GENERIC_LINUX_SERVER" and validate result EQUALS "user@automation.local"

  @SID_14
  Scenario: test Email filter by severity
    Then UI Set Checkbox "Critical" To "false"
    Then UI Set Checkbox "Minor" To "false"
    Then UI Set Checkbox "Information" To "true"
    Then UI Set Checkbox "Major" To "false"
    Then UI Set Checkbox "Warning" To "false"
    Then UI Click Button "Submit"
    Then Sleep "30"
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    When REST Lock Action on "DefensePro" 11
    Then REST Unlock Action on "DefensePro" 11
    Then Sleep "35"
    Then CLI Run linux Command "grep -i "INFO" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "2"
    Then UI Set Checkbox "Critical" To "true"
    Then UI Set Checkbox "Minor" To "true"
    Then UI Set Checkbox "Information" To "true"
    Then UI Set Checkbox "Major" To "true"
    Then UI Set Checkbox "Warning" To "true"
    Then UI Click Button "Submit"

  @SID_15
  Scenario: test Email filter by severity negative
    Then UI Set Checkbox "Critical" To "true"
    Then UI Set Checkbox "Information" To "false"
    Then UI Click Button "Submit"
    Then Sleep "30"
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    Then REST Lock Action on "DefensePro" 11
    Then REST Unlock Action on "DefensePro" 11
    Then Sleep "35"
    Then CLI Run linux Command "grep -i "INFO" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then UI Set Checkbox "Information" To "true"


  @SID_16
  Scenario: test Email filter by detailed vision activity ON
    Then UI Set Checkbox "Enable Detailed Auditing of APSolute Vision Activity" To "true"
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    * REST Request "PUT" for "Advanced->Advanced Parameters"
      | type                 | value                 |
      | body                 | deviceLockAgingTime=12|
      | Returned status code | 200                   |
    Then Sleep "40"
    Then CLI Run linux Command "grep -i "User radware has changed the Device Lock Timeout to 12" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "1"
    Then CLI Run remote linux Command "/bin/cp /var/spool/mail/alertuser /tmp/alertuser_step16" on "GENERIC_LINUX_SERVER"

  @SID_17
  Scenario: test Email filter by detailed vision activity OFF
    Then UI Set Checkbox "Enable Detailed Auditing of APSolute Vision Activity" To "true"
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    * REST Request "PUT" for "Advanced->Advanced Parameters"
      | type                 | value                 |
      | body                 | deviceLockAgingTime=11|
      | Returned status code | 200                   |
    Then Sleep "40"
    Then CLI Run linux Command "grep -i "User radware has changed the Device Lock Timeout to 11" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run remote linux Command "/bin/cp /var/spool/mail/alertuser /tmp/alertuser_step16" on "GENERIC_LINUX_SERVER"

  @SID_18
  Scenario: test Email filter by detailed device configuration OFF
    Then UI Set Checkbox "Enable Detailed APSolute Vision Auditing of Device Configuration Changes" To "false"
    Then UI Click Button "Submit"
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    Then REST Lock Action on "DefensePro" 11
    Then REST Put Scalar on "DefensePro" 11 values "sysLocation=Undetailed"
    Then Sleep "35"
    Then CLI Run linux Command "grep -i "User sys_admin set value to scalar sysLocation (Location)" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "1"
    Then CLI Run linux Command "grep -i "User sys_admin set value to scalar sysLocation (Location): Undetailed" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run remote linux Command "/bin/cp /var/spool/mail/alertuser /tmp/alertuser_step17" on "GENERIC_LINUX_SERVER"

  @SID_19
  Scenario: test Email filter by detailed device configuration ON
    Then UI Set Checkbox "Enable Detailed APSolute Vision Auditing of Device Configuration Changes" To "true"
    Then UI Click Button "Submit"
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    Then REST Put Scalar on "DefensePro" 11 values "sysLocation=detailed"
    Then Sleep "35"
    Then CLI Run linux Command "grep "User sys_admin set value to scalar sysLocation (Location): detailed" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "1"
    Then REST Unlock Action on "DefensePro" 11
    Then CLI Run remote linux Command "/bin/cp /var/spool/mail/alertuser /tmp/alertuser_step18" on "GENERIC_LINUX_SERVER"

  @SID_20
  Scenario: Number of alerts per email
    Then UI Select "6" from Vision dropdown "Alerts per Email"
    Then UI Click Button "Submit"
    Then Sleep "35"
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    When REST Lock Action on "DefensePro" 11
    Then REST Unlock Action on "DefensePro" 11
    When REST Lock Action on "DefensePro" 11
    Then REST Unlock Action on "DefensePro" 11
    When REST Lock Action on "DefensePro" 11
    Then REST Unlock Action on "DefensePro" 11
    Then Sleep "35"
    Then CLI Run linux Command "grep -i "locked by user sys_admin" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "6"
    Then CLI Run linux Command "grep -i "Subject: " /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result LTE "5"
    Then CLI Run remote linux Command "/bin/cp /var/spool/mail/alertuser /tmp/alertuser_step19" on "GENERIC_LINUX_SERVER"

  @SID_21
  Scenario: test Email filter by module Device Health Errors
    Then UI Set Checkbox "Device Security" To "false"
    Then UI Set Checkbox "Vision General" To "false"
    Then UI Set Checkbox "Vision Control" To "false"
    Then UI Set Checkbox "Trouble Ticket" To "false"
    Then UI Set Checkbox "Device General" To "false"
    Then UI Set Checkbox "Vision Configuration" To "false"
    Then UI Set Checkbox "Security Reporting" To "false"
    Then UI Set Checkbox "Operator Toolbox" To "false"
    Then UI Set Checkbox "Device Health Errors" To "true"
    Then UI Set Checkbox "Vision Analytics Alerts" To "false"
    Then UI Set Checkbox "Device Throughput License Errors" To "false"
    Then UI Set Checkbox "Device Throughput License Exceeded Errors" To "false"
    Then UI Click Button "Submit"
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    When REST Lock Action on "DefensePro" 11
    Then REST Unlock Action on "DefensePro" 11
    Then CLI simulate 1 attacks of type "DP_single_Oper_oos" on "DefensePro" 11 and wait 35 seconds
    #  add clear command due to switching from CLI simulate command to CLI run command
    Then CLI Run remote linux Command "clear" on "GENERIC_LINUX_SERVER"
    Then CLI Run linux Command "grep -i "DEVICE_GENERAL" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then Sleep "3"
    Then CLI Run linux Command "grep -i "DEVICE_HEALTH_ERRORS" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "1"
    Then CLI Run remote linux Command "/bin/cp /var/spool/mail/alertuser /tmp/alertuser_step20" on "GENERIC_LINUX_SERVER"

  @SID_22
  Scenario: test Email filter by module Device Health Errors
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
#    Then UI Set Checkbox "Device Security" To "true"
#    Then UI Set Checkbox "Vision General" To "true"
#    Then UI Set Checkbox "Vision Control" To "true"
#    Then UI Set Checkbox "Trouble Ticket" To "true"
#    Then UI Set Checkbox "Device General" To "false"
    Then UI Set Checkbox "Vision Configuration" To "true"
    Then UI Set Checkbox "Security Reporting" To "true"
#    Then UI Set Checkbox "Operator Toolbox" To "true"
    Then UI Set Checkbox "Device Health Errors" To "false"
#    Then UI Set Checkbox "Vision Analytics Alerts" To "true"
#    Then UI Set Checkbox "Device Throughput License Errors" To "true"
#    Then UI Set Checkbox "Device Throughput License Exceeded Errors" To "true"
    Then UI Click Button "Submit"
    When REST Lock Action on "DefensePro" 11
    Then REST Unlock Action on "DefensePro" 11
    Then CLI simulate 1 attacks of type "rest_intrusion" on "DefensePro" 11
    Then CLI simulate 1 attacks of type "DP_single_Oper_oos" on "DefensePro" 11 and wait 50 seconds
    Then CLI Run linux Command "grep -i "DEVICE_GENERAL" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"
    Then CLI Run linux Command "grep -i "SECURITY_REPORTING" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "1"
    Then CLI Run linux Command "grep -i "INSITE_CONFIGURATION" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result GTE "1"
    Then CLI Run remote linux Command "/bin/cp /var/spool/mail/alertuser /tmp/alertuser_step21" on "GENERIC_LINUX_SERVER"

  @SID_23
  Scenario: Email filter by device DefenseFlow - Alerts negative
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_alert_login.sh " |
      | #visionIP                               |
    Then Sleep "35"
    Then CLI Run linux Command "grep -i "DefenseFlow" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"


  @SID_24
  Scenario: test Email filter by device DefenseFlow - Attacks negative
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    Then CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_attacks-auto_single.sh " |
      | #visionIP                                       |
      | Started                                         |
    Then Sleep "35"
    Then CLI Run linux Command "grep -i "DefenseFlow" /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"


  @SID_25
  Scenario: test Email filter by device DefenseFlow - Alerts
#    Then UI DualList Move deviceIndex 12 deviceType "Alteon" DualList Items to "RIGHT" , dual list id "gwt-debug-alertsMailNotifierSettings.alertsMailNotifierFilter.deviceOrmIds"

  @SID_26
  Scenario: test Email filter by device DefenseFlow - Attacks
#    Then UI DualList Move deviceIndex 12 deviceType "Alteon" DualList Items to "RIGHT" , dual list id "gwt-debug-alertsMailNotifierSettings.alertsMailNotifierFilter.deviceOrmIds"

  @SID_27
  Scenario: test Email disabled
    Then UI Set Checkbox "Enable" To "false"
    Then UI Click Button "Submit"
    Then Sleep "34"
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/alertuser" on "GENERIC_LINUX_SERVER"
    When REST Lock Action on "Alteon" 12
    Then REST Unlock Action on "Alteon" 12
    When REST Lock Action on "DefensePro" 11
    Then REST Unlock Action on "DefensePro" 11
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=55 |
    Then Sleep "40"
    Then CLI Run linux Command "cat /var/spool/mail/alertuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"

  @SID_28
  Scenario: Cleanup
    Then UI Logout
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
      | ALL     | error      | NOT_EXPECTED |
      | ALL     | fail       | NOT_EXPECTED |

