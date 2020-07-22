@TC108242
Feature: Vision Upgrade current -3

  @SID_1
  Scenario: preparations for upgrade release -3
    Given Prerequisite for Setup force
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='16';"" on "ROOT_SERVER_CLI"
    Then CLI copy "/home/radware/Scripts/copyUpgradeLog.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then CLI copy "/home/radware/Scripts/ssh-copy-id.exp" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"


   ######################################################################################

  @SID_2
  Scenario: change fluentd listening port
#    Then CLI Run remote linux Command "dos2unix /etc/td-agent/td-agent.conf" on "ROOT_SERVER_CLI"
#    Then CLI Run remote linux Command "sed -i 's/port .*$/port 51400/g' /etc/td-agent/td-agent.conf" on "ROOT_SERVER_CLI"

  @SID_3
  Scenario: Fill partitions to max limit
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Then CLI copy "/home/radware/Scripts/fill_my_disk.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then CLI Run remote linux Command "/fill_my_disk.sh /opt/radware 84" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/fill_my_disk.sh / 84" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario: Pre Upgrade changes
    #for testing AVA Attack Capacity Grace Period with the following scenario:
      # if before upgrade the server not have the Legacy "vision-reporting-module-AMS" license and never installs the new AVA License so after upgrade No  Grace Period will be given:
    Then CLI Clear vision logs
    Then REST Vision DELETE License Request "vision-AVA-6-Gbps-attack-capacity"
    Then REST Vision DELETE License Request "vision-AVA-20-Gbps-attack-capacity"
    Then REST Vision DELETE License Request "vision-AVA-60-Gbps-attack-capacity"
    Then REST Vision DELETE License Request "vision-AVA-400-Gbps-attack-capacity"
    Then REST Vision DELETE License Request "vision-AVA-Max-attack-capacity"
    Then REST Vision DELETE License Request "vision-reporting-module-AMS"
    Then Set AVA_Grace_Period_Status to Not Set
    Then Set Server Last Upgrade Time to 30 Days Back From Now
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    Then CLI Run remote linux Command "echo "Before " $(mysql -prad123 vision -e "show create table traffic_utilizations\G" |grep "(PARTITION p" |awk -F"p" '{print$2}'|awk '{printf$1}') >  /opt/radware/sql_partition.txt" on "ROOT_SERVER_CLI"

   ######################################################################################
  @SID_5
  Scenario: Upgrade vision from release -3
    Given CLI Clear vision logs
    Then Upgrade or Fresh Install Vision

  @SID_6
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
      | UPGRADE | *.png                                                                  | IGNORE       |
      | UPGRADE | *.svg                                                                  | IGNORE       |
      | UPGRADE | inflating:                                                             | IGNORE       |
      | UPGRADE | /opt/radware/storage/www/webui/vision-dashboards/public/static/media/* | IGNORE       |
      | LLS     | fatal\| error\|fail                                                    | NOT_EXPECTED |
      | LLS     | Installation ended                                                     | IGNORE       |
      | LLS     | Setup complete!                                                        | IGNORE       |

  @SID_7
  Scenario: Check firewall settings
    Then CLI Run remote linux Command "iptables -L -n > /tmp/Upgrade-3.txt" on "ROOT_SERVER_CLI"
    Then CLI copy "/tmp/Upgrade-3.txt" from "ROOT_SERVER_CLI" to "GENERIC_LINUX_SERVER" "/tmp/Upgrade-3.txt"
    Then CLI Run linux Command "iptables -L -n | grep -w "REJECT     all"" on "ROOT_SERVER_CLI" and validate result CONTAINS "REJECT"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp | grep -w "dpt:5604"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
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
    Then CLI Run linux Command "iptables -L -n | grep -w DROP |grep -w icmp |grep -w 17" on "ROOT_SERVER_CLI" and validate result CONTAINS "DROP"
    Then CLI Run linux Command "iptables -L -n | grep -w DROP |grep -w icmp |grep -w 13" on "ROOT_SERVER_CLI" and validate result CONTAINS "DROP"
    Then CLI Run linux Command "iptables -L -n |grep "ACCEPT"|grep "state NEW" |wc -l" on "ROOT_SERVER_CLI" and validate result LTE "18"

  @SID_8
  Scenario: Check firewall6 settings
    Then CLI Run linux Command "ip6tables -L -n |tail -1|awk -F" " '{print $1,$2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "REJECT all"
    Then CLI Run linux Command "ip6tables -L -n |grep tcp|grep dpt:5604" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    #    Skipping following step till it is developed
#    Then CLI Run linux Command "ip6tables -L -n |grep tcp|grep dpt:9200" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
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

  @SID_9
  Scenario: Login with activation
    Then UI Login with user "sys_admin" and password "radware"
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15

  @SID_10
  Scenario: Validate AVA Attack Capacity Grace Period License was Not Given after Upgrade
#    Then Validate License "ATTACK_CAPACITY_LICENSE" Parameters
#      | allowedAttackCapacityGbps         | 0                    |
#      | requiredDevicesAttackCapacityGbps | 18                   |
#      | licensedDefenseProDeviceIpsList   | []                   |
#      | hasDemoLicense                    | false                |
#      | attackCapacityMaxLicenseExist     | false                |
#      | licenseViolated                   | true                 |
#      | inGracePeriod                     | false                |
#      | message                           | Insufficient License |
#      | timeToExpiration                  | -1                   |
#
#    And Validate DefenseFlow is NOT Licensed by Attack Capacity License

  @SID_11
  Scenario: Navigate to general settings page
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Basic Parameters"
    When UI Do Operation "select" item "Software"
    Then REST get Basic Parameters "lastUpgradeStatus"
    Then UI Validate Text field "Upgrade Status" EQUALS "OK"

  @SID_12
  Scenario: Create new Site
    Then UI Add new Site "Site After Upgrade" under Parent "Default"

  @SID_13
  Scenario: Add fake devices to tree
    Then REST Add "Alteon" Device To topology Tree with Name "FakeAlteon" and Management IP "4.4.4.4" into site "Default"
      | attribute | value |
    Then REST Add "DefensePro" Device To topology Tree with Name "FakeDP" and Management IP "4.4.4.5" into site "Default"
      | attribute | value |

  @SID_14
  Scenario: validate Edit Threshold script exist in vision
    Then CLI Run linux Command "ll /opt/radware/storage/vdirect/database/templates/adjust_profile_v2.vm |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "ll /opt/radware/ConfigurationTemplatesRepository/actionable/adjust_profile_v2.vm |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_15
  Scenario: Import driver script and jar file
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.2.1.0-DD-1.00-110.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.4.0.0-DD-1.00-396.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"

  @SID_16
  Scenario: Upload Driver to vision
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.2.1.0-DD-1.00-110.jar" on "ROOT_SERVER_CLI" with timeOut 240
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.4.0.0-DD-1.00-396.jar" on "ROOT_SERVER_CLI" with timeOut 240

  @SID_17
  Scenario: Validate TED status
    Then CLI Run linux Command "echo $(mysql -prad123 vision_ng -N -B -e "select count(*) from vision_license where license_str like '%reporting-module-ADC%';")-$(netstat -nlt |grep 5140|wc -l)|bc" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then CLI Run linux Command "curl -ks -o null -w 'RESP_CODE:%{response_code}\n' -XGET https://localhost:443/ted/api/data" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200"

  @SID_18
  Scenario: Visit device subscription page
    Then CLI Run linux Command "result=`curl -ks -X "POST" "https://localhost/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"radware\",\"password\": \"radware\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -ks -o null -XGET -H "Cookie: JSESSIONID=$jsession" https://localhost/mgmt/system/config/itemlist/devicesubscriptions -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" with timeOut 300 with runCommand delay 90
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"

  @SID_19
  Scenario: Delete fake devices from tree
    Then Sleep "20"
    Then REST Delete Device By IP "4.4.4.4"
    Then REST Delete Device By IP "4.4.4.5"

  @SID_20
  Scenario: Logout and Close
    Given UI logout and close browser

  @SID_21
  Scenario: Validate MySql version
    Then CLI Run linux Command "mysql -prad123 --version|awk '{print$5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "10.4.6-MariaDB,"

  @SID_22
  Scenario: Validate vdirect listener
    Then CLI Run linux Command "netstat -nlt |grep 2188|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2188"
    Then CLI Run linux Command "netstat -nlt |grep 2189|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2189"
    Then CLI Run remote linux Command "curl -ks -o null -XGET https://localhost6:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"
    Then CLI Run remote linux Command "curl -ks -o null -XGET https://localhost4:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"

  @SID_23
  Scenario: Validate LLS service is up
    Then CLI Run linux Command "curl -ks -o null -XGET http://localhost4:7070/api/1.0/hostids -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" with timeOut 300
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"
    Then CLI Run linux Command "curl -ks -o null -XGET http://localhost6:7070/api/1.0/hostids -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" with timeOut 300
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"
      #rollback to the original values
    Given CLI Run remote linux Command "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='24';"" on "ROOT_SERVER_CLI"

  @SID_24
  Scenario: Validate LLS version
    Then CLI Run linux Command "cat /opt/radware/storage/llsinstall/license-server-*/version.txt" on "ROOT_SERVER_CLI" and validate result EQUALS "2.3.0-1"

  @SID_25
  Scenario: Validate IPv6 Hostname in /etc/hosts
    Then CLI Run linux Command "if [ "$(hostname | cut -d'.' -f 1)" == "$(grep "::1" /etc/hosts|head -1|awk '{print$6}')" ]; then echo "hostname ok"; else echo "hostname not ok"; fi" on "ROOT_SERVER_CLI" and validate result EQUALS "hostname ok"
    Then CLI Run linux Command "grep "::1" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_26
  Scenario: Validate IPv4 Hostname in /etc/hosts
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep "$(hostname | cut -d'.' -f 1)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_27
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
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "td-agent is running" in any line with timeOut 15

  @SID_28
  Scenario: Verify number of tables in vision schema
    Then CLI Run linux Command "mysql -prad123 -NB -e "select count(*) from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='vision';"" on "ROOT_SERVER_CLI" and validate result EQUALS "90"

  @SID_29
  Scenario: Verify number of tables in vision_ng schema
    Then CLI Run linux Command "mysql -prad123 -NB -e "select count(*) from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='vision_ng';"" on "ROOT_SERVER_CLI" and validate result EQUALS "166"

  @SID_31
  Scenario: Validate Changed MySql partitioning number
    Then CLI Run remote linux Command "echo "After " $(mysql -prad123 vision -e "show create table traffic_utilizations\G" |grep "(PARTITION \`p" |awk -F"p" '{print$2}'|awk -F"\`" '{print$1}') >>  /opt/radware/sql_partition.txt" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "cat /opt/radware/sql_partition.txt" on "ROOT_SERVER_CLI"
    Then CLI Run linux Command "echo $(cat /opt/radware/sql_partition.txt |grep "After"|awk '{print$2}')-$(cat /opt/radware/sql_partition.txt |grep "Before"|awk '{print$2}')|bc" on "ROOT_SERVER_CLI" and validate result NOT_EQUALS "0"
