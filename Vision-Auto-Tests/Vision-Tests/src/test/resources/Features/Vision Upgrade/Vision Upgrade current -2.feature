@TC108241
Feature: Vision Upgrade current -2

  @SID_1
  Scenario: preparations for upgrade release -2
    Given Prerequisite for Setup force
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='16';"" on "ROOT_SERVER_CLI"


   ######################################################################################

  @SID_2
  Scenario: change fluentd listening port
    Then CLI Run remote linux Command "dos2unix /etc/td-agent/td-agent.conf" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "sed -i 's/port .*$/port 51400/g' /etc/td-agent/td-agent.conf" on "ROOT_SERVER_CLI"


  @SID_3
  Scenario: Pre Upgrade changes
    Given CLI Reset radware password
    # fill partitions to max
    Then CLI copy "/home/radware/Scripts/fill_my_disk.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then CLI Run remote linux Command "/fill_my_disk.sh /opt/radware 84" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/fill_my_disk.sh / 84" on "ROOT_SERVER_CLI"

    # delete ADC analytics license if exists
    Then CLI Run remote linux Command "echo "Before " $(mysql -prad123 vision -e "show create table traffic_utilizations\G" |grep "(PARTITION p" |awk -F"p" '{print$2}'|awk '{printf$1}') >  /opt/radware/sql_partition.txt" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from vision_license where license_str like '%reporting-module-ADC%';"" on "ROOT_SERVER_CLI"
 #for testing AVA Attack Capacity Grace Period with the following scenario:
      # if before upgrade the server have the Legacy "vision-reporting-module-AMS" license and never installs the new AVA License so after upgrade Grace Period will be given:
    Given REST Vision DELETE License Request "vision-AVA-6-Gbps-attack-capacity"
    And REST Vision DELETE License Request "vision-AVA-20-Gbps-attack-capacity"
    And REST Vision DELETE License Request "vision-AVA-60-Gbps-attack-capacity"
    And REST Vision DELETE License Request "vision-AVA-400-Gbps-attack-capacity"
    And REST Vision DELETE License Request "vision-AVA-Max-attack-capacity"
    And REST Vision Install License Request "vision-reporting-module-AMS"
    And Set AVA_Grace_Period_Status to Not Set
    And Set Server Last Upgrade Time to 30 Days Back From Now

  @SID_4
  Scenario Outline:ES Index Validation before Upgrade
    Then CLI simulate <Attacks Number> attacks of type "<Attack Name>" on "<Device Type>" <Device Index> and wait <Wait Time> seconds
    Examples:
      | Attacks Number | Attack Name  | Device Type | Device Index | Wait Time |
      | 1              | DynamicBlock | DefensePro  | 11           | 45        |

   ######################################################################################
  @SID_5
  Scenario: Upgrade vision from release -2
    Given CLI Clear vision logs
    Then Upgrade or Fresh Install Vision

  @SID_6
  Scenario Outline:  Run Migration Tasks
    Then Run ElasticSearch Migration Task "<Migration Task>" and Wait <Wait Time> Seconds
    Examples:
      | Migration Task               | Wait Time |
      | DPAttackSamplesMigrationTask | 120       |

  @SID_7
  Scenario Outline:ES Indices New Mappings Validation After Upgrade
    Given Validate that the Number of the Mapping Attributes at Index "<Index Name Prefix>" with Week Slice <Week Slice> Equals to <Expected Number of Mapping Attributes>
    Examples:
      | Index Name Prefix | Week Slice | Expected Number of Mapping Attributes |
      | dp-sampled-data-* | 2          | 14                                    |

  @SID_8
  Scenario: Check upgrade logs
    # Saving upgrade log to Generic server /home/radware/UpgradeLogs/
    Then CLI Run remote linux Command "/copyUpgradeLog.sh" on "ROOT_SERVER_CLI"

    Then CLI Check if logs contains
      | logType | expression                                                             | isExpected   |
      | UPGRADE | fatal                                                                  | NOT_EXPECTED |
      | UPGRADE | fail to\|failed to                                                     | NOT_EXPECTED |
      | UPGRADE | The upgrade of APSolute Vision server has completed successfully       | EXPECTED     |
      | UPGRADE | Vision Reporter upgrade finished                                       | EXPECTED     |
      | UPGRADE | Successfully upgraded from AVR                                         | EXPECTED     |
      | UPGRADE | Upgrading vDirect services ended                                       | EXPECTED     |
      | UPGRADE | APSolute Vision ELASTICSEARCH upgrade finished                         | EXPECTED     |
      | UPGRADE | APSolute Vision AMQP upgrade finished                                  | EXPECTED     |
      | UPGRADE | APSolute Vision Appwall upgrade finished                               | EXPECTED     |
      | UPGRADE | APSolute Vision Workflows upgrade finished                             | EXPECTED     |
      | UPGRADE | APSolute Vision Databse upgrade finished                               | EXPECTED     |
      | UPGRADE | APSolute Vision CLI upgrade finished                                   | EXPECTED     |
      | UPGRADE | APSolute Vision Web upgrade finished                                   | EXPECTED     |
      | UPGRADE | APSolute Vision DP upgrade finished                                    | EXPECTED     |
      | UPGRADE | APSolute Vision Configuration upgrade finished                         | EXPECTED     |
      | UPGRADE | APSolute Vision Device upgrade finished                                | EXPECTED     |
      | UPGRADE | APSolute Vision Online upgrade finished                                | EXPECTED     |
      | UPGRADE | APSolute Vision WEB upgrade finished                                   | EXPECTED     |
      | UPGRADE | APSolute Vision Application upgrade finished                           | EXPECTED     |
      | UPGRADE | APSolute Vision System upgrade finished                                | EXPECTED     |
      | UPGRADE | APSolute Vision OS upgrade finished                                    | EXPECTED     |
      | UPGRADE | ERROR                                                                  | NOT_EXPECTED |
      | UPGRADE | error: package MySQL-                                                  | IGNORE       |
      | UPGRADE | inflating:                                                             | IGNORE       |
      | UPGRADE | *.png                                                                  | IGNORE       |
      | UPGRADE | *.svg                                                                  | IGNORE       |
      | UPGRADE | /opt/radware/storage/www/webui/vision-dashboards/public/static/media/* | IGNORE       |
      | UPGRADE | No such image or container: *                                          | IGNORE       |


  @SID_9
  Scenario: Check firewall settings
    Then CLI Run remote linux Command "iptables -L -n > /tmp/Upgrade-2.txt" on "ROOT_SERVER_CLI"
    Then CLI copy "/tmp/Upgrade-2.txt" from "ROOT_SERVER_CLI" to "GENERIC_LINUX_SERVER" "/tmp/Upgrade-2.txt"
    Then CLI Run linux Command "iptables -L -n | grep -w "REJECT     all"" on "ROOT_SERVER_CLI" and validate result CONTAINS "REJECT"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp |grep -w "dpt:9200"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp |grep -w "dpt:1443"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp |grep -w "dpt:5672"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp |grep -w "dpt:5671"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp |grep -w "dpt:9443"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp |grep -w "dpt:2189"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp |grep -w "dpt:2215"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w udp |grep -w "dpt:2215"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp |grep -w "dpt:2214"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w udp |grep -w "dpt:2214"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w udp |grep -w "dpt:2088"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w udp |grep -w "dpt:162"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp |grep -w "dpt:9216"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp |grep -w "dpt:443"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp |grep -w "dpt:80"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp |grep -w "dpt:22"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w icmp |grep -w 17" on "ROOT_SERVER_CLI" and validate result CONTAINS "DROP"
    Then CLI Run linux Command "iptables -L -n |grep -w icmp |grep -w 13" on "ROOT_SERVER_CLI" and validate result CONTAINS "DROP"
    Then CLI Run linux Command "iptables -L -n |grep "ACCEPT"|grep "state NEW" |wc -l" on "ROOT_SERVER_CLI" and validate result LTE "18"

  @SID_10
  Scenario: Check firewall6 settings
    Then CLI Run linux Command "ip6tables -L -n |tail -1|awk -F" " '{print $1,$2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "REJECT all"
    Then CLI Run linux Command "ip6tables -L -n |grep tcp|grep dpt:1443" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep tcp|grep dpt:5672" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep tcp|grep dpt:5671" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep tcp|grep dpt:9443" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep tcp|grep dpt:2189" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep tcp|grep dpt:2215" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep udp|grep dpt:2215" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep tcp|grep dpt:2214" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep udp|grep dpt:2214" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep udp|grep dpt:2088" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep udp|grep dpt:162" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep tcp|grep dpt:9216" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep tcp|grep dpt:443" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep tcp|grep dpt:80" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep tcp|grep dpt:22" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"

  @SID_11
  Scenario: Login with activation
    Then UI Login with user "sys_admin" and password "radware"
    Given CLI Reset radware password

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
    Then CLI Run linux Command "ll /opt/radware/storage/vdirect/database/templates/adjust_profile_v2.vm |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
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

  @SID_18
  Scenario: Validate TED status when no ADC license
    Then CLI Run linux Command "echo $(mysql -prad123 vision_ng -N -B -e "select count(*) from vision_license where license_str like '%reporting-module-ADC%';")-$(netstat -nlt |grep 5140|wc -l)|bc" on "ROOT_SERVER_CLI" and validate result EQUALS "0" Retry 600 seconds
    Then CLI Run linux Command "curl -ks -o null -w 'RESP_CODE:%{response_code}\n' -XGET https://localhost:443/ted/api/data" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:503"

  @SID_19
  Scenario: Validate TED status with ADC license
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    Then Sleep "30"
    Then CLI Run linux Command "curl -ks -o null -w 'RESP_CODE:%{response_code}\n' -XGET https://localhost:443/ted/api/data" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200"

  @SID_20
  Scenario: Visit device subscription page
    Then CLI Run linux Command "result=`curl -ks -X "POST" "https://localhost/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"radware\",\"password\": \"radware\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -ks -o null -XGET -H "Cookie: JSESSIONID=$jsession" https://localhost/mgmt/system/config/itemlist/devicesubscriptions -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" Retry 180 seconds
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
    Then CLI Run linux Command "mysql -prad123 --version|awk '{print$5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "10.4.6-MariaDB,"

  @SID_24
  Scenario: Validate vdirect listener
    Then CLI Run linux Command "netstat -nlt |grep 2188|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2188" Retry 120 seconds
    Then CLI Run linux Command "netstat -nlt |grep 2189|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2189" Retry 120 seconds
    Then CLI Run remote linux Command "curl -ks -o null -XGET https://localhost6:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"
    Then CLI Run remote linux Command "curl -ks -o null -XGET https://localhost4:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"

  @SID_25
  Scenario: Validate LLS service is up
    Then CLI Run linux Command "system lls service status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "is running" in any line Retry 600 seconds
    Then CLI Run linux Command "curl -ks -o null -XGET http://localhost4:7070/api/1.0/hostids -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" Retry 300 seconds
    Then CLI Run linux Command "curl -ks -o null -XGET http://localhost6:7070/api/1.0/hostids -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" Retry 300 seconds
    Then CLI Check if logs contains
      | logType | expression                                                           | isExpected   |
      | LLS     | fatal\| error\|fail                                                  | NOT_EXPECTED |
      #rollback to the original values
    Given CLI Run remote linux Command "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='24';"" on "ROOT_SERVER_CLI"
    When CLI Operations - Run Radware Session command "system lls service stop"
    When CLI Operations - Run Radware Session command "y" timeout 180

  @SID_26
  Scenario: Validate LLS version
    Then CLI Run linux Command "cat /opt/radware/storage/llsinstall/license-server-*/version.txt" on "ROOT_SERVER_CLI" and validate result EQUALS "2.4.0-2"

  @SID_27
  Scenario: Validate IPv6 Hostname in /etc/hosts
    Then CLI Run linux Command "if [ "$(hostname | cut -d'.' -f 1)" == "$(grep "::1" /etc/hosts|head -1|awk '{print$6}')" ]; then echo "hostname ok"; else echo "hostname not ok"; fi" on "ROOT_SERVER_CLI" and validate result EQUALS "hostname ok"
    Then CLI Run linux Command "grep "::1" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_28
  Scenario: Validate IPv4 Hostname in /etc/hosts
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep "$(hostname | cut -d'.' -f 1)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_29
  Scenario: Verify services are running
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "APSolute Vision Reporter is running" in any line
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "AMQP service is running" in any line
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Configuration server is running" in any line
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Collector service is running" in any line
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "New Reporter service is running" in any line
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Alerts service is running" in any line
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Scheduler service is running" in any line
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Configuration Synchronization service is running" in any line
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Tor feed service is running" in any line
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Radware vDirect is running" in any line
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "VRM reporting engine is running" in any line
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "td-agent is running" in any line

  @SID_30
  Scenario: Verify number of tables in vision schema
    Then CLI Run linux Command "mysql -prad123 -NB -e "select count(*) from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='vision';"" on "ROOT_SERVER_CLI" and validate result EQUALS "90"

  @SID_31
  Scenario: Verify number of tables in vision_ng schema
    Then CLI Run linux Command "mysql -prad123 -NB -e "select count(*) from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='vision_ng';"" on "ROOT_SERVER_CLI" and validate result EQUALS "166"

  @SID_32
  Scenario: Validate Changed MySql partitioning number
    Then CLI Run remote linux Command "echo "After " $(mysql -prad123 vision -e "show create table traffic_utilizations\G" |grep "(PARTITION \`p" |awk -F"p" '{print$2}'|awk -F"\`" '{print$1}') >>  /opt/radware/sql_partition.txt" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "cat /opt/radware/sql_partition.txt" on "ROOT_SERVER_CLI"
    Then CLI Run linux Command "echo $(cat /opt/radware/sql_partition.txt |grep "After"|awk '{print$2}')-$(cat /opt/radware/sql_partition.txt |grep "Before"|awk '{print$2}')|bc" on "ROOT_SERVER_CLI" and validate result NOT_EQUALS "0"
