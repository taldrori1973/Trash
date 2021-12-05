@TC108240
Feature: Vision Upgrade current -1

  @SID_1
  Scenario: preparations for upgrade release -1
    Given Prerequisite for Setup force

   ######################################################################################

  @SID_2
  Scenario: Start LLS service
    Given CLI Run linux Command "system lls service start" on "RADWARE_SERVER_CLI" and validate result CONTAINS "This will start the LLS service. Continue? (y/n)" in any line
    When CLI Run remote linux Command "y" on "ROOT_SERVER_CLI"
    Then CLI Run linux Command "system lls service status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "FailOverRole: MAIN" in any line Retry 180 seconds

#  @SID_3
#  Scenario: Fill partitions to max limit
#    Given CLI Reset radware password
#    Then CLI copy "/home/radware/Scripts/fill_my_disk.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
#    Then CLI Run remote linux Command "/fill_my_disk.sh /opt/radware 75" on "ROOT_SERVER_CLI"
#    Then CLI Run remote linux Command "/fill_my_disk.sh / 75" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario: Do any pre-upgrade changes
    Given REST Login with activation with user "sys_admin" and password "radware"
      # extract MySql create partition number
    Then CLI Run remote linux Command "echo "Before " $(mysql vision -e "show create table traffic_utilizations\G" |grep "(PARTITION p" |awk -F"p" '{print$2}'|awk '{printf$1}') >  /opt/radware/sql_partition.txt" on "ROOT_SERVER_CLI"

  @SID_5
  Scenario: Change TED configuration
    Given REST Login with activation with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    Then CLI Run remote linux Command "cat /opt/radware/storage/ted/config/ted.cfg" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "sed -i 's/"elasticRetentionMaxPercent":.*,/"elasticRetentionMaxPercent":74,/g' /opt/radware/storage/ted/config/ted.cfg" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "cat /opt/radware/storage/ted/config/ted.cfg" on "ROOT_SERVER_CLI"
    Then REST Vision DELETE License Request "vision-reporting-module-ADC"


   ######################################################################################
  @SID_6
  Scenario: Upgrade vision from release -1
    Given CLI Clear vision logs
    Then Upgrade or Fresh Install Vision

  @SID_7
  Scenario: Check upgrade logs
    Then CLI Check if logs contains
      | logType | expression                                                                                    | isExpected   |
      | UPGRADE | fatal                                                                                         | NOT_EXPECTED |
      | UPGRADE | fail to\|failed to                                                                            | NOT_EXPECTED |
      | UPGRADE | The upgrade of APSolute Vision server has completed successfully                              | EXPECTED     |
      | UPGRADE | Failed to connect to localhost port 8009: Connection refused                                  | IGNORE       |
      | UPGRADE | NOTE1: Some changes will not take effect untill next login.                                   | EXPECTED     |
      | UPGRADE | [ERROR]   WARNING: The script pysemver is installed in '/usr/local/bin' which is not on PATH. | IGNORE       |

#      | UPGRADE | Vision Reporter upgrade finished                                                              | EXPECTED     |
#      | UPGRADE | Successfully upgraded from AVR                                                                | EXPECTED     |
#      | UPGRADE | Upgrading vDirect services ended                                                              | EXPECTED     |
#      | UPGRADE | APSolute Vision ELASTICSEARCH upgrade finished                                                | EXPECTED     |
#      | UPGRADE | APSolute Vision AMQP upgrade finished                                                         | EXPECTED     |
#      | UPGRADE | APSolute Vision Appwall upgrade finished                                                      | EXPECTED     |
#      | UPGRADE | APSolute Vision Workflows upgrade finished                                                    | EXPECTED     |
#      | UPGRADE | APSolute Vision Databse upgrade finished                                                      | EXPECTED     |
#      | UPGRADE | APSolute Vision CLI upgrade finished                                                          | EXPECTED     |
#      | UPGRADE | APSolute Vision Web upgrade finished                                                          | EXPECTED     |
#      | UPGRADE | APSolute Vision DP upgrade finished                                                           | EXPECTED     |
#      | UPGRADE | APSolute Vision Configuration upgrade finished                                                | EXPECTED     |
#      | UPGRADE | APSolute Vision Device upgrade finished                                                       | EXPECTED     |
#      | UPGRADE | APSolute Vision Online upgrade finished                                                       | EXPECTED     |
#      | UPGRADE | APSolute Vision WEB upgrade finished                                                          | EXPECTED     |
#      | UPGRADE | APSolute Vision Application upgrade finished                                                  | EXPECTED     |
#      | UPGRADE | APSolute Vision System upgrade finished                                                       | EXPECTED     |
#      | UPGRADE | APSolute Vision OS upgrade finished                                                           | EXPECTED     |
#      | UPGRADE | APSolute Vision FluentD upgrade finished                                                      | EXPECTED     |
#      | UPGRADE | APSolute Vision TED upgrade finished                                                          | EXPECTED     |
#      | UPGRADE | ERROR                                                                                         | NOT_EXPECTED |
#      | UPGRADE | error: package MySQL-                                                                         | IGNORE       |
#      | UPGRADE | *.svg                                                                                         | IGNORE       |
#      | UPGRADE | *.png                                                                                         | IGNORE       |
#      | UPGRADE | inflating:                                                                                    | IGNORE       |
#      | UPGRADE | /opt/radware/storage/www/webui/vision-dashboards/public/static/media/*                        | IGNORE       |
#      | UPGRADE | No such image or container: *                                                                 | IGNORE       |

  @SID_8
  Scenario: Validate server is up after reset
    # Avoid reboot during an active process
    Given CLI Run linux Command "service mgtsrv status |grep 'Local License Server is upgrading in the background and will start after the process ends' |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0" Retry 600 seconds
    When CLI Run remote linux Command "reboot" on "RADWARE_SERVER_CLI"
    When Sleep "120"
    When CLI Wait for Vision Re-Connection
    Then validate vision server services are UP

  @SID_9
  Scenario: Check firewall settings
    When CLI Operations - Run Radware Session command "net firewall open-port list"
    Then CLI Operations - Verify that output contains regex "tcp\s+80"
    Then CLI Operations - Verify that output contains regex "tcp\s+443"
    Then CLI Operations - Verify that output contains regex "tcp\s+2215"
    Then CLI Operations - Verify that output contains regex "tcp\s+2189"
    Then CLI Operations - Verify that output contains regex "tcp\s+3000"
    Then CLI Operations - Verify that output contains regex "tcp\s+5671"
    Then CLI Operations - Verify that output contains regex "tcp\s+7070"
    Then CLI Operations - Verify that output contains regex "tcp\s+3306"
    Then CLI Operations - Verify that output contains regex "tcp\s+9200"

    When CLI Run linux Command "iptables -L -n | grep tcp | grep -v 10.10 |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "13"

  @SID_11
  Scenario: Login with activation
    Then UI Login with user "sys_admin" and password "radware"
    Given CLI Reset radware password
    Then REST Vision Install License Request "vision-reporting-module-ADC"


  @SID_12
  Scenario: Navigate to general settings page
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Basic Parameters"
    When UI Do Operation "select" item "Software"
    Then REST get Basic Parameters "lastUpgradeStatus"
    Then UI Validate Text field "Upgrade Status" EQUALS "OK"

  @SID_13
  Scenario: Create new Site
    Then UI Add new Site "Site After Upgrade" under Parent "Default"

  @SID_14
  Scenario: Add fake devices to tree
    Then REST Add "Alteon" Device To topology Tree with Name "FakeAlteon" and Management IP "4.4.4.4" into site "Default"
      | attribute | value |
    Then REST Add "DefensePro" Device To topology Tree with Name "FakeDP" and Management IP "4.4.4.5" into site "Default"
      | attribute | value |

  @SID_15
  Scenario: validate Edit Threshold script exist in vision
    Then CLI Run linux Command "ll /var/lib/docker/volumes/config_vdirect/_data/templates/adjust_profile_v2.vm |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "ll /opt/radware/ConfigurationTemplatesRepository/actionable/adjust_profile_v2.vm |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_16
  Scenario: Import driver script and jar file
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.2.1.0-DD-1.00-110.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.4.0.0-DD-1.00-396.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"

  @SID_17
  Scenario: Upload Driver to vision
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.2.1.0-DD-1.00-110.jar" on "ROOT_SERVER_CLI" with timeOut 240
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.4.0.0-DD-1.00-396.jar" on "ROOT_SERVER_CLI" with timeOut 240

  @SID_19
  Scenario: Validate TED status
    Then CLI Run linux Command "curl -ks -o null -w 'RESP_CODE:%{response_code}\n' -XGET https://localhost:443/ted/api/data" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200"

  @SID_20
  Scenario: Visit device subscription page
    Then CLI Run linux Command "result=`curl -ks -X "POST" "https://localhost/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"radware\",\"password\": \"radware\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -ks -o null -XGET -H "Cookie: JSESSIONID=$jsession" https://localhost/mgmt/system/config/itemlist/devicesubscriptions -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" Retry 300 seconds
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"

  @SID_21
  Scenario: Delete fake devices from tree
    Then Sleep "20"
    Then REST Delete Device By IP "4.4.4.4"
    Then REST Delete Device By IP "4.4.4.5"

  @SID_22
  Scenario: Logout and Close
    Given UI logout and close browser

  @SID_23
  Scenario: Validate MySql version
    Then MYSQL Validate "version" Variable Value EQUALS "10.4.6-MariaDB"

  @SID_24
  Scenario: Validate vdirect listener
    Then CLI Run linux Command "netstat -nlt |grep 2188|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2188" Retry 120 seconds
    Then CLI Run linux Command "netstat -nlt |grep 2189|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2189" Retry 120 seconds
    Then CLI Run remote linux Command "curl -ks -o null -XGET https://localhost:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"

  @SID_25
  Scenario: Validate LLS service is up
    Then CLI Run linux Command "system lls service status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "Local License Server is running." in any line Retry 600 seconds
    Then CLI Run linux Command "curl -ks -o null -XGET http://localhost:7070/api/1.0/hostids -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" Retry 300 seconds
    Then CLI Check if logs contains
      | logType | expression          | isExpected   |
      | LLS     | fatal\| error\|fail | NOT_EXPECTED |
      #rollback to the original values
#    Given CLI Run remote linux Command "mysql vision_ng -e "update lls_server set min_required_ram='24';"" on "ROOT_SERVER_CLI"
    When CLI Operations - Run Radware Session command "system lls service stop"
    When CLI Operations - Run Radware Session command "y" timeout 180

  @SID_26
  Scenario: Validate LLS version
    Then CLI Run linux Command "system lls version" on "RADWARE_SERVER_CLI" and validate result CONTAINS "LLS version: 2.6.0"

  @SID_27
  Scenario: Validate Changed MySql partitioning number
    Then CLI Run remote linux Command "echo "After " $(mysql vision -e "show create table traffic_utilizations\G" |grep "(PARTITION \`p" |awk -F"p" '{print$2}'|awk -F"\`" '{print$1}') >>  /opt/radware/sql_partition.txt" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "cat /opt/radware/sql_partition.txt" on "ROOT_SERVER_CLI"
    Then CLI Run linux Command "echo $(cat /opt/radware/sql_partition.txt |grep "After"|awk '{print$2}')-$(cat /opt/radware/sql_partition.txt |grep "Before"|awk '{print$2}')|bc" on "ROOT_SERVER_CLI" and validate result NOT_EQUALS "0"

  @SID_28
  Scenario: Validate IPv6 Hostname in /etc/hosts
    Then CLI Run linux Command "if [ "$(hostname | cut -d'.' -f 1)" == "$(grep "::1" /etc/hosts|head -1|awk '{print$2}')" ]; then echo "hostname ok"; else echo "hostname not ok"; fi" on "ROOT_SERVER_CLI" and validate result EQUALS "hostname ok"
    Then CLI Run linux Command "grep "::1" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_29
  Scenario: Validate IPv4 Hostname in /etc/hosts
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$3}')" /etc/hosts|grep "$(hostname | cut -d'.' -f 1)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$3}')" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_30
  Scenario: Verify services are running
    When CLI Operations - Run Radware Session command "system vision-server status"
    Then CLI Operations - Verify that output contains regex "config_kvision-lls_1\s+.*\(healthy\)"
    Then CLI Operations - Verify that output contains regex "config_kvision-dc-nginx_1\s+.*\(healthy\)"
    Then CLI Operations - Verify that output contains regex "config_kvision-rt-alert_1\s+.*\(healthy\)"
    Then CLI Operations - Verify that output contains regex "config_kvision-formatter_1\s+.*\(healthy\)"
    Then CLI Operations - Verify that output contains regex "config_kvision-vdirect_1\s+.*\(healthy\)"
    Then CLI Operations - Verify that output contains regex "config_kvision-scheduler_1\s+.*\(healthy\)"
    Then CLI Operations - Verify that output contains regex "config_kvision-vrm_1\s+.*\(healthy\)"
    Then CLI Operations - Verify that output contains regex "config_kvision-tor-feed_1\s+.*\(healthy\)"
    Then CLI Operations - Verify that output contains regex "config_kvision-alerts_1\s+.*\(healthy\)"
    Then CLI Operations - Verify that output contains regex "config_kvision-config-sync-service_1\s+.*\(healthy\)"
    Then CLI Operations - Verify that output contains regex "config_kvision-infra-autoheal_1\s+.*\(healthy\)"
    Then CLI Operations - Verify that output contains regex "config_kvision-ted_1\s+.*\(healthy\)"
    Then CLI Operations - Verify that output contains regex "config_kvision-webui_1\s+.*\(healthy\)"
    Then CLI Operations - Verify that output contains regex "config_kvision-help_1\s+.*\(healthy\)"
    Then CLI Operations - Verify that output contains regex "config_kvision-infra-fluentd_1\s+.*Up"
    Then CLI Operations - Verify that output contains regex "config_kvision-infra-ipv6nat_1\s+.*Up"
    Then CLI Operations - Verify that output contains regex "config_kvision-reporter_1\s+.*\(healthy\)"
    Then CLI Operations - Verify that output contains regex "config_kvision-collector_1\s+.*\(healthy\)"
    Then CLI Operations - Verify that output contains regex "config_kvision-configuration-service_1\s+.*\(healthy\)"
    Then CLI Operations - Verify that output contains regex "config_kvision-infra-rabbitmq_1\s+.*Up"
    Then CLI Operations - Verify that output contains regex "config_kvision-infra-efk_1\s+.*\(healthy\)"
    Then CLI Operations - Verify that output contains regex "config_kvision-infra-mariadb_1\s+.*\(healthy\)"


  @SID_31
  Scenario: Verify TED configuration
    Then CLI Run linux Command "cat /opt/radware/storage/ted/config/ted.cfg |awk -F"elasticRetentionMaxPercent\":" '{print$2}'|awk -F"," '{print$1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "74"

  @SID_32
  Scenario: Verify number of tables in vision schema
    Then CLI Run linux Command "mysql -NB -e "select count(*) from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='vision';"" on "ROOT_SERVER_CLI" and validate result EQUALS "90"

  @SID_33
  Scenario: Verify number of tables in vision_ng schema
    Then CLI Run linux Command "mysql -NB -e "select count(*) from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='vision_ng';"" on "ROOT_SERVER_CLI" and validate result EQUALS "166"