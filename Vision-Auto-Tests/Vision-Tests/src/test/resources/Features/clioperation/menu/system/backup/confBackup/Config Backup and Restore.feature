@TC108785
Feature: Backup and Restore

  @SID_1
  Scenario: Pre upgrade changes
    * CLI Clear vision logs
    # TED Configuration
    Then CLI Run remote linux Command on Vision 2 "sed -i 's/\"elasticRetentionInDays\":.*,/\"elasticRetentionInDays\":8,/g' /opt/radware/storage/ted/config/ted.cfg" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command on Vision 2 "sed -i 's/\"elasticRetentionMaxPercent\":.*,/\"elasticRetentionMaxPercent\":74,/g' /opt/radware/storage/ted/config/ted.cfg" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command on Vision 2 "sed -i 's/port .*$/port 51400/g' /etc/td-agent/td-agent.conf" on "ROOT_SERVER_CLI"
    Then CLI Operations - Run Radware Session command "net firewall open-port set 9200 open" on vision 2, timeout 5

  @SID_2
  Scenario: validate services is UP in the two machines before backup and restore
    Given validate vision server services is UP
    Given validate vision server services is UP on vision 2

  @SID_3
  Scenario: Backup from source vision, and export to target vision
    When CLI Connect Radware
    Then CLI System backup Export "scp" Protocol

  @SID_4
  Scenario: restore backup in the target vision
    Then CLI System restore backup "scp" Protocol

  @SID_5
  Scenario: validate services UP
    When validate vision server services is UP
    Then validate vision server services is UP on vision 2

  @SID_6
  Scenario: Add License to the target device
    When CLI Connect Radware
    When CLI Connect Root
    Given CLI Reset radware password
    * REST Login with activation with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Vision Install License Request "vision-reporting-module-ADC"
    * REST Vision Install License Request "vision-RTUMAX"


  @SID_7
  Scenario: Restore validation authentication mode
    When CLI Operations - Run Radware Session command "system user authentication-mode get"
    Then CLI Operations - Verify that output contains regex ".*TACACS+..*"

  @SID_8
  Scenario: Restore validation number of devices
    Then CLI Run linux Command "mysql -prad123 vision_ng -e "select count(*) from  site_tree_elem_abs where DTYPE='Device'" | grep -v + | grep -v count" on "ROOT_SERVER_CLI" and validate result EQUALS "16"

  @SID_9
  Scenario: Check logs for errors
    * CLI Check if logs contains
      | logType | expression                | isExpected   |
      | BACKUP  | fatal                     | NOT_EXPECTED |
      | BACKUP  | error                     | NOT_EXPECTED |
      | BACKUP  | fail                      | NOT_EXPECTED |
      | BACKUP  | index_not_found_exception | IGNORE       |
      | BACKUP  | \"failed\":0              | IGNORE       |
      | BACKUP  | RESTORING HOSTNAME        | IGNORE       |

  @SID_10
  Scenario: Restore validation hostname
    Then CLI Run linux Command "hostname" on "ROOT_SERVER_CLI" and validate result EQUALS "my.auto.vision"

  @SID_11
  Scenario: Restore validation AMS report definition
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "AMS Reports" page via homePage
    Then UI "Validate" Report With Name "Report_backup_restore"
      | Template              | reportType:DefensePro Analytics, Widgets:[ALL], devices:[{deviceIndex:10,  devicePolicies:[BDOS]}] |
      | Time Definitions.Date | Quick:1W                                                                                           |
      | Format                | Select: HTML                                                                                       |

  @SID_12
  Scenario: Restore validation AMS report schedule
    Then CLI copy "/home/radware/Scripts/get_scheduled_report_value.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then CLI Run linux Command "/get_scheduled_report_value.sh Report_backup_restore" on "ROOT_SERVER_CLI" and validate result EQUALS "0 34 16 1 1,2,3,4,5,6,7,8,9,10,11,12 ? *"

  @SID_13
  Scenario: Restore validation AMS report results

  @SID_14
  Scenario: Restore validation AMS alerts
    And UI Navigate to "AMS Alerts" page via homePage
    Then UI validate Checkbox by label "SwitchOff" with extension "Alert backup restore" if Selected "false"

    Then UI "Validate" Alerts With Name "Alert backup restore"
      | Basic Info | Description:description backup restore,Impact:impact backup restore, Remedy:remedy backup restore, Severity:Major |
      | Criteria   | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:100,Unit:M;                                     |
      | Schedule   | triggerThisRule:2,Within:10,selectTimeUnit:minutes,alertsPerHour:2                                                |
      | devices    | index:10, policies:[pol_1];                                                                                       |
      | Share      | Email:[nobody@alert.local],Subject:subject alert backup restore,Body:message alert backup restore                 |

  @SID_15
  Scenario: Restore validation AMS forensic definition
    And UI Navigate to "AMS Forensics" page via homePage
    Then UI "Validate" Forensics With Name "Forensic backup restore"
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                             |
      | Criteria              | Event Criteria:Attack ID,Operator:Not Equals,Value:123; Event Criteria:Attack ID,Operator:Not Equals,Value:1234;                                                                                                                             |
      | Output                | Action,Attack ID,Start Time,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Threat Category,Radware ID,Device IP Address,Attack Name,End Time,Duration,Packets,Mbits,Physical Port,Policy Name,Risk |
      | Format                | Select: HTML                                                                                                                                                                                                                                 |
      | Share                 | FTP:checked, FTP.Location:my.ftp.server, FTP.Path:/backup, FTP.Username:user1, FTP.Password:1234                                                                                                                                             |

  @SID_16
  Scenario: Restore validation AMS forensic results
    Then UI Generate and Validate Forensics With Name "Forensic backup restore" with Timeout of 300 Seconds
    Then UI Logout

  @SID_17
  Scenario: Restore validation local user
    When CLI Operations - Run Radware Session command "system user authentication-mode set Local"
    Then UI Login with user "user_backup_restore" and password "12345678"
    Then UI Logout
    Then CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"

  @SID_18
  Scenario: Restore validation Scheduled tasks triggers
    Then CLI Run linux Command "mysql -prad123 quartz -NB -e "select CRON_EXPRESSION from qrtz_cron_triggers where TRIGGER_NAME like '%AttackDesc%';"" on "ROOT_SERVER_CLI" and validate result EQUALS "0 30 1 ? * *"
    Then CLI Run linux Command "mysql -prad123 quartz -NB -e "select CRON_EXPRESSION from qrtz_cron_triggers where TRIGGER_NAME like '%OperatorToolbox%';"" on "ROOT_SERVER_CLI" and validate result EQUALS "0 1 12 ? * 2"

  @SID_19
  Scenario: Restore validation SSL certificate
    When CLI Operations - Run Radware Session command "system ssl show | grep Name"
    Then CLI Operations - Verify that output contains regex ".*my.auto.vision.*"
    When CLI Operations - Run Radware Session command "system ssl show | grep Unit"
    Then CLI Operations - Verify that output contains regex ".*floor9.*"

  @SID_20
  Scenario: Restore validation fluentd listening port
    Then CLI Run linux Command "cat /etc/td-agent/td-agent.conf |grep "port"|awk '{print $NF}'" on "ROOT_SERVER_CLI" and validate result EQUALS "51400"

  @SID_21
  Scenario: Restore validation td-agent service
    Then CLI Run linux Command "service td-agent status" on "ROOT_SERVER_CLI" and validate result CONTAINS "td-agent is running"

  @SID_22
  Scenario: Restore Validate TED status
    Then CLI Run linux Command "echo $(mysql -prad123 vision_ng -N -B -e "select count(*) from vision_license where license_str like '%reporting-module-ADC%';")-$(netstat -nlt |grep 5140|wc -l)|bc" on "ROOT_SERVER_CLI" and validate result EQUALS "0" with timeOut 600
    Then CLI Run linux Command "curl -ks -o null -w 'RESP_CODE:%{response_code}\n' -XGET https://localhost:443/ted/api/data" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200"

  @SID_23
  Scenario: Restore validation LLS running
    Then CLI LLS validate installation with expected: "Local License Server is running", timeout 1200

  @SID_24
  Scenario: Restore Validate td-agent configuration
    Then CLI Run linux Command "cat /etc/td-agent/td-agent.conf |grep "port"|awk '{print $NF}'" on "ROOT_SERVER_CLI" and validate result EQUALS "51400"

  @SID_25
  Scenario: Restore Validate TED configuration
    Then CLI Run linux Command "cat /opt/radware/storage/ted/config/ted.cfg |awk -F"elasticRetentionInDays\":" '{print$2}'|awk -F"," '{print$1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "8"
    Then CLI Run linux Command "cat /opt/radware/storage/ted/config/ted.cfg |awk -F"elasticRetentionMaxPercent\":" '{print$2}'|awk -F"," '{print$1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "74"

  @SID_26
  Scenario: Verify number of tables in vision schema
    Then CLI Run linux Command "mysql -prad123 -NB -e "select count(*) from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='vision';"" on "ROOT_SERVER_CLI" and validate result EQUALS "90"

  @SID_27
  Scenario: Verify number of tables in vision_ng schema
    Then CLI Run linux Command "mysql -prad123 -NB -e "select count(*) from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='vision_ng';"" on "ROOT_SERVER_CLI" and validate result EQUALS "166"
