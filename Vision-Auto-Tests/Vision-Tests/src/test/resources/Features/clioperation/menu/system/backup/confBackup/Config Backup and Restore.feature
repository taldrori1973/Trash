@TC108785
Feature: Backup and Restore


  @SID_1
  Scenario: Pre upgrade changes
    * CLI Clear vision logs
    Then CLI Run remote linux Command on Vision 2 "sed -i 's/\"elasticRetentionInDays\":.*,/\"elasticRetentionInDays\":8,/g' /opt/radware/storage/ted/config/ted.cfg" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command on Vision 2 "sed -i 's/\"elasticRetentionMaxPercent\":.*,/\"elasticRetentionMaxPercent\":74,/g' /opt/radware/storage/ted/config/ted.cfg" on "ROOT_SERVER_CLI"


  @SID_2
  Scenario: validate services is UP in the two machines before backup and restore
    Given validate vision server services are UP
    Given validate vision server services are UP on vision 2

  @SID_3
  Scenario: Backup from source vision, and export to target vision
    When CLI Connect Radware
    Then CLI System backup Export "scp" Protocol

  @SID_4
  Scenario: restore backup in the target vision
    Then CLI System restore backup "scp" Protocol

  @SID_5
  Scenario: validate services UP
    When validate vision server services are UP
    Then validate vision server services are UP on vision 2

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
    Then CLI Run linux Command "mysql vision_ng -e "select count(*) from  site_tree_elem_abs where DTYPE='Device'" | grep -v + | grep -v count" on "ROOT_SERVER_CLI" and validate result EQUALS "7"

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
      | Template              | reportType:DefensePro Analytics, Widgets:[Traffic Bandwidth, Connections Rate, Concurrent Connections, Top Attacks, Top Attacks by Volume, Top Attacks by Protocol, Critical Attacks by Mitigation Action, Attacks by Threat Category, Attacks by Mitigation Action, Top Attack Destinations, Top Attack Sources, Top Scanners, Top Probed IP Addresses, Attacks by Protection Policy, Attack Categories by Bandwidth, Top Allowed Attackers, Top Attacks by Duration, Top Attacks by Signature], devices:[All] |
      | Time Definitions.Date | Quick:1W                                                                                          |
      | Format                | Select: HTML                                                                                      |

  @SID_12
  Scenario: Restore validation AMS alerts
    And UI Navigate to "AMS Alerts" page via homePage
    Then UI "Validate" Alerts With Name "Alert backup restore"
      | Basic Info | Description:description backup restore,Impact:impact backup restore, Remedy:remedy backup restore, Severity:Major |
      | Criteria   | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:100,Unit:M;                                     |
      | Schedule   | triggerThisRule:2,Within:10,selectTimeUnit:minutes,alertsPerHour:2                                                |
      | devices    | index:10                                                                                       |
      | Share      | Email:[nobody@alert.local],Subject:subject alert backup restore,Body:message alert backup restore                 |

  @SID_13
  Scenario: Restore validation AMS forensic definition
    And UI Navigate to "AMS Forensics" page via homePage
    Then UI "Validate" Forensics With Name "Forensic backup restore"
      | Criteria | Event Criteria:Action,Operator:Not Equals,Value:Drop,devices:[All] |
      | Output   | Start Time,Attack ID,Action                          |

  @SID_14
  Scenario: Restore validation AMS forensic results
    Then UI Click Button "My Forensics" with value "Forensic backup restore"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensic backup restore"
    Then Sleep "35"
    Then UI Logout

  @SID_15
  Scenario: Restore validation local user
    When CLI Operations - Run Radware Session command "system user authentication-mode set Local"
    Then UI Login with user "user_backup_restore" and password "12345678"
    Then UI Logout
    Then CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"

  @SID_16
  Scenario: Restore validation Scheduled tasks triggers
    Then CLI Run linux Command "mysql quartz -NB -e "select CRON_EXPRESSION from qrtz_cron_triggers where TRIGGER_NAME like '%AttackDesc%';"" on "ROOT_SERVER_CLI" and validate result EQUALS "0 0 12 ? * 1"
    Then CLI Run linux Command "mysql quartz -NB -e "select CRON_EXPRESSION from qrtz_cron_triggers where TRIGGER_NAME like '%OperatorToolbox%';"" on "ROOT_SERVER_CLI" and validate result EQUALS "0 0 12 ? * 1"

  @SID_17
  Scenario: Restore validation SSL certificate
    When CLI Operations - Run Radware Session command "system ssl show | grep subject"
    Then CLI Operations - Verify that output contains regex "APSolute Vision Server"
    When CLI Operations - Run Radware Session command "system ssl show | grep Unit"
    Then CLI Operations - Verify that output contains regex ".*NA*"


  @SID_18
  Scenario: Restore Validate TED status
    Then CLI Run linux Command "curl -ks -o null -w 'RESP_CODE:%{response_code}\n' -XGET https://localhost:443/ted/api/data" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200"

  @SID_19
  Scenario: Restore validation LLS running
    Then CLI LLS validate installation with expected: "Local License Server is running", timeout 1200


  @SID_20
  Scenario: Restore Validate TED configuration
    Then CLI Run linux Command "cat /opt/radware/storage/ted/config/ted.cfg |awk -F"elasticRetentionInDays\":" '{print$2}'|awk -F"," '{print$1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "14"
    Then CLI Run linux Command "cat /opt/radware/storage/ted/config/ted.cfg |awk -F"elasticRetentionMaxPercent\":" '{print$2}'|awk -F"," '{print$1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "75"

  @SID_21
  Scenario: Verify number of tables in vision schema
    Then CLI Run linux Command "mysql -NB -e "select count(*) from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='vision';"" on "ROOT_SERVER_CLI" and validate result EQUALS "90"

  @SID_22
  Scenario: Verify number of tables in vision_ng schema
    Then CLI Run linux Command "mysql -NB -e "select count(*) from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='vision_ng';"" on "ROOT_SERVER_CLI" and validate result EQUALS "169"
