
@TC112861
Feature: Vision Scale APM

  @SID_1
  Scenario: verify vision_install logs
    Then CLI Check if logs contains
      | logType        | expression | isExpected   |
      | VISION_INSTALL | fatal      | NOT_EXPECTED |
      | VISION_INSTALL | error      | NOT_EXPECTED |
      | LLS            | error      | NOT_EXPECTED |
      | LLS            | fatal      | NOT_EXPECTED |


  @SID_2
  Scenario: validate available disk space
    Then CLI Run linux Command "df -hP /opt/radware/storage|tail -1|awk -F" " '{print $5}'|awk -F"%" '{print $1}'" on "ROOT_SERVER_CLI" and validate result LTE "85"
    Then CLI Run linux Command "df -hP /opt/radware|tail -1|awk -F" " '{print $5}'|awk -F"%" '{print $1}'" on "ROOT_SERVER_CLI" and validate result LTE "30"
    Then CLI Run linux Command "df -hP /|tail -1|awk '{print $5}'|grep -oP '[\d]*'" on "ROOT_SERVER_CLI" and validate result LTE "40"
    Then CLI Run linux Command "df -hP /vz/private|tail -1|awk -F" " '{print $5}'|awk -F"%" '{print $1}'" on "ROOT_SERVER_CLI" and validate result LTE "85"

  @SID_3
  Scenario: Validate Database MariaDB Schema vision_ng without Errors
    Then CLI Run linux Command "mysqlcheck -prad123 vision_ng | grep "Incorrect information" | grep -oP '(?<=vision_ng/).[^.]*' |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"

  @SID_4
  Scenario: Validate Database MariaDB Schema vision without Errors
    Then CLI Run linux Command "mysqlcheck -prad123 vision | grep "Incorrect information" | grep -oP '(?<=vision/).[^.]*' |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"

  @SID_5
  Scenario: validate APM container is up and relevant services are running in it
    Then CLI Run linux Command "service vz status" on "ROOT_SERVER_CLI" and validate result EQUALS "OpenVZ is running..."
    Then CLI Run linux Command "vzctl exec 101 SPSERVER_INSTANCE=rad /usr/share/sharepath/server/sbin/spserver-initd.sh --action=status | grep "is running..." | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "6"

  @SID_6
  Scenario: Verify services are running
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "APSolute Vision Reporter is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "AMQP service is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Configuration server is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Collector service is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "New Reporter service is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Alerts service is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Scheduler service is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Configuration Synchronization service is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Tor feed service is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Radware vDirect is running" in any line with timeOut 15
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "VRM reporting engine is running" in any line with timeOut 15
    Then CLI Run linux Command "service vz status" on "ROOT_SERVER_CLI" and validate result EQUALS "OpenVZ is running..."

  @SID_7
  Scenario: Validate simulation davices are up and running

    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "select c.mgt_ip,f.status from site_tree_elem_abs as a inner join device_setup as b on b.row_id=a.fk_dev_setup_device_setup inner join device_access as c on c.row_id=b.fk_dev_access_device_acces inner join software as d on d.row_id=b.fk_dev_sw_software inner join hardware as e on e.row_id=b.fk_hw_hardware inner join devicestatus as f on f.row_id=a.fk_dev_status where c.mgt_ip like '%50.50%' and f.status<>'1'  order by c.mgt_ip" > /opt/radware/storage/maintenance/DeviceThatWhereDown.log" on "ROOT_SERVER_CLI"
    Then CLI Run linux Command "mysql -prad123 vision_ng -NB -e "select c.mgt_ip,f.status from site_tree_elem_abs as a inner join device_setup as b on b.row_id=a.fk_dev_setup_device_setup inner join device_access as c on c.row_id=b.fk_dev_access_device_acces inner join software as d on d.row_id=b.fk_dev_sw_software inner join hardware as e on e.row_id=b.fk_hw_hardware inner join devicestatus as f on f.row_id=a.fk_dev_status where c.mgt_ip like '%50.50%' and f.status<>'1'  order by c.mgt_ip" | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"

#  @SID_8
#  Scenario: keep reports copy on file system
#    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"

  @SID_9
  Scenario: VRM - go to VRM Reports Tab
    Given UI Login with user "radware" and password "radware"
#    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Go To Vision
    And UI Open Upper Bar Item "AMS"
    And UI Open "Reports" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

  @SID_10
  Scenario: Create new Report Analytics CSV Delivery
    Given UI "Create" Report With Name "Delivery_Test_report"
      | reportType | DefensePro Analytics Dashboard                                                            |
      | Share      | Email:[automation.vision1@radware.com, also@report.local],Subject:report delivery Subject |
      | Format     | Select: CSV                                                                               |

  @SID_11
  Scenario: Validate delivery card and generate report
    Then UI Generate and Validate Report With Name "Delivery_Test_report" with Timeout of 300 Seconds
    And Sleep "15"

  @SID_12
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"


  @SID_13
  Scenario: VRM report validate CSV file TOP ATTACKS number of lines
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv |wc -l" on "ROOT_SERVER_CLI" and validate result GTE "1"



  @SID_14
  Scenario: VRM report validate CSV file TOP ATTACKS headers
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -1|grep name,ruleName,endTime,Count|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "name"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "ruleName"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "endTime"
    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/bin/Top_Attacks.csv|head -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "Count"

  @SID_15
  Scenario: Validate services without any crash
    # if we found more then one PID
    Then CLI Run linux Command "cat /opt/radware/storage/memoryLeakCase/processesPerformance/opt_radware_mgt-server_third-party_jboss-4_2_3_GA_bin_ | grep -v PID | awk '{print $2}' | sort | uniq | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/storage/memoryLeakCase/processesPerformance/opt_radware_mgt-server_third-party_tomcat | grep -v PID | awk '{print $2}' | sort | uniq | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/storage/memoryLeakCase/processesPerformance/opt_radware_novis_tomcat | grep -v PID | awk '{print $2}' | sort | uniq | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/storage/memoryLeakCase/processesPerformance/opt_radware_storage_mgt-server_third-party_tomcat2 | grep -v PID | awk '{print $2}' | sort | uniq | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/storage/memoryLeakCase/processesPerformance/usr_lib_rabbitmq_lib_rabbitmq_server-3_5_8_sbin_plugins_ | grep -v PID | awk '{print $2}' | sort | uniq | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/storage/memoryLeakCase/processesPerformance/usr_sbin_td-agent | grep -v PID | awk '{print $2}' | sort | uniq | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/storage/memoryLeakCase/processesPerformance/var_avr_rotatelogs | grep -v PID | awk '{print $2}' | sort | uniq | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/storage/memoryLeakCase/processesPerformance/var_lib_mysql_vision_radware_err | grep -v PID | awk '{print $2}' | sort | uniq | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /opt/radware/storage/memoryLeakCase/processesPerformance/var_log_elasticsearch | grep -v PID | awk '{print $2}' | sort | uniq | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_16
  Scenario: Validate drops and error
    Then CLI Run linux Command "zgrep -i BACKPRESSURE /opt/radware/mgt-server/third-party/tomcat/logs/collector.log  /opt/radware/mgt-server/third-party/tomcat/logs/collector-*.log.gz | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
