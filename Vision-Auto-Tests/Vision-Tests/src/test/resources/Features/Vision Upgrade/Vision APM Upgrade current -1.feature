@TC108239

Feature: Vision APM Upgrade current -1

  @SID_1
  Scenario: preparations for upgrade release -1
    Given Prerequisite for Setup force


    ######################################################################################

  @SID_2
  Scenario: Fill partitions to max limit
    Then CLI copy "/home/radware/Scripts/fill_my_disk.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then CLI Run remote linux Command "/fill_my_disk.sh /opt/radware 78" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/fill_my_disk.sh / 78" on "ROOT_SERVER_CLI"

  @SID_3
  Scenario: Do any pre-upgrade changes
    Given CLI Reset radware password
    # extract MySql create partition number
    Then CLI Run remote linux Command "echo "before " $(mysql -prad123 vision -e "show create table traffic_utilizations\G" |grep "(PARTITION p" |awk -F"p" '{print$2}'|awk '{printf$1}') >  /opt/radware/sql_partition.txt" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "sed -i 's/port .*$/port 51400/g' /etc/td-agent/td-agent.conf" on "ROOT_SERVER_CLI"

    ######################################################################################
  @SID_4
  Scenario: Upgrade APM vision from release -1
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='16';"" on "ROOT_SERVER_CLI"
    Given CLI Clear vision logs
    Then Upgrade or Fresh Install Vision


  @SID_5
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
      | UPGRADE | APSolute Vision FluentD upgrade finished                               | EXPECTED     |
      | UPGRADE | APSolute Vision TED upgrade finished                                   | EXPECTED     |
      | UPGRADE | ERROR                                                                  | NOT_EXPECTED |
      | UPGRADE | error: package MySQL-                                                  | IGNORE       |
      | UPGRADE | *.svg                                                                  | IGNORE       |
      | UPGRADE | *.png                                                                  | IGNORE       |
      | UPGRADE | inflating:                                                             | IGNORE       |
      | UPGRADE | Failed to parse /etc/cgconfig.conf                                     | IGNORE       |
      | UPGRADE | error loading /etc/cgconfig.conf: Cgroup mounting failed               | IGNORE       |
      | UPGRADE | Error: cannot mount cpuset to /cgroup/cpuset: Device or resource busy  | IGNORE       |
      | UPGRADE | /opt/radware/storage/www/webui/vision-dashboards/public/static/media/* | IGNORE       |
      | UPGRADE | No such image or container: *                                          | IGNORE       |

  @SID_6
  Scenario: Validate server is up after reset
    # Avoid reboot during an active process
    Given CLI Run linux Command "service mgtsrv status |grep 'Local License Server is upgrading in the background and will start after the process ends' |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0" Retry 600 seconds
    When CLI Run remote linux Command "reboot" on "ROOT_SERVER_CLI"
    When Sleep "120"
    When CLI Wait for Vision Re-Connection
    Then validate vision server services is UP

  @SID_7
  Scenario: Check firewall settings
    Then CLI Run linux Command "iptables -L -n |tail -1|awk -F" " '{print $1,$2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "REJECT all"
    Then CLI Run linux Command "iptables -L -n |grep tcp|grep dpt:1443" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep tcp|grep dpt:5672" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep tcp|grep dpt:5671" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep tcp|grep dpt:9443" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep tcp|grep dpt:2189" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep tcp|grep dpt:2215" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep udp|grep dpt:2215" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep tcp|grep dpt:2214" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep udp|grep dpt:2214" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep udp|grep dpt:2088" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep udp|grep dpt:162" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep tcp|grep dpt:9216" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep tcp|grep dpt:443" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep tcp|grep dpt:80" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep tcp|grep dpt:22" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep "icmp type 13"" on "ROOT_SERVER_CLI" and validate result CONTAINS "DROP"
    Then CLI Run linux Command "iptables -L -n |grep "icmp type 17"" on "ROOT_SERVER_CLI" and validate result CONTAINS "DROP"

  @SID_8
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

  @SID_9
  Scenario: Login with activation
    Then UI Login with user "sys_admin" and password "radware"
    Given CLI Reset radware password

  @SID_10
  Scenario: Navigate to general settings page
    Then UI Navigate to "VISION SETTINGS" page via homePage
    Then UI Navigate to page "System->General Settings->Basic Parameters"
    When UI Do Operation "select" item "Software"
    Then REST get Basic Parameters "lastUpgradeStatus"
    Then UI Validate Text field "Upgrade Status" EQUALS "OK"

  @SID_11
  Scenario: Validate TED status
    Then CLI Run linux Command "echo $(mysql -prad123 vision_ng -N -B -e "select count(*) from vision_license where license_str like '%reporting-module-ADC%';")-$(netstat -nlt |grep 5140|wc -l)|bc" on "ROOT_SERVER_CLI" and validate result EQUALS "0" Retry 900 seconds

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
  Scenario: Validate fluentd configuration
    Then CLI Run linux Command "cat /etc/td-agent/td-agent.conf |grep "port"|awk '{print $NF}'" on "ROOT_SERVER_CLI" and validate result CONTAINS "51400" in any line

  @SID_18
  Scenario: Visit device subscription page
    Then CLI Run linux Command "result=`curl -ks -X "POST" "https://localhost/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"radware\",\"password\": \"radware\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -ks -o null -XGET -H "Cookie: JSESSIONID=$jsession" https://localhost/mgmt/system/config/itemlist/devicesubscriptions -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" Wait For Prompt 90 seconds Retry 300 seconds
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
    Then CLI Run remote linux Command "cat /opt/radware/sql_partition.txt" on "ROOT_SERVER_CLI"
    Then CLI Run linux Command "mysql -prad123 --version|awk '{print$5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "10.4.6-MariaDB,"

  @SID_22
  Scenario: Validate vdirect listener
    Then CLI Run linux Command "netstat -nlt |grep 2188|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2188" Retry 120 seconds
    Then CLI Run linux Command "netstat -nlt |grep 2189|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2189" Retry 120 seconds
    Then CLI Run remote linux Command "curl -ks -o null -XGET https://localhost6:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"
    Then CLI Run remote linux Command "curl -ks -o null -XGET https://localhost4:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"

  @SID_23
  Scenario: Validate LLS service is up
    Then CLI Run linux Command "system lls service status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "is running" in any line Retry 600 seconds
    Then CLI Run linux Command "curl -ks -o null -XGET http://localhost4:7070/api/1.0/hostids -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" Retry 300 seconds
    Then CLI Run linux Command "curl -ks -o null -XGET http://localhost6:7070/api/1.0/hostids -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" Retry 300 seconds
    Then CLI Check if logs contains
      | logType | expression          | isExpected   |
      | LLS     | fatal\| error\|fail | NOT_EXPECTED |
      #rollback to the original values
    Given CLI Run remote linux Command "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='32';"" on "ROOT_SERVER_CLI"
    When CLI Operations - Run Radware Session command "system lls service stop"
    When CLI Operations - Run Radware Session command "y" timeout 180


  @SID_24
  Scenario: Validate LLS version
    Then CLI Run linux Command "cat /opt/radware/storage/llsinstall/license-server-*/version.txt" on "ROOT_SERVER_CLI" and validate result EQUALS "2.5.0-2"

  @SID_25
  Scenario: Validate Changed MySql partitioning number
    Then CLI Run remote linux Command "echo "after " $(mysql -prad123 vision -e "show create table traffic_utilizations\G" |grep "(PARTITION \`p" |awk -F"p" '{print$2}'|awk -F"\`" '{print$1}') >>  /opt/radware/sql_partition.txt" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "cat /opt/radware/sql_partition.txt" on "ROOT_SERVER_CLI"
    Then CLI Run linux Command "echo $(cat /opt/radware/sql_partition.txt |grep "after"|awk '{print$2}')-$(cat /opt/radware/sql_partition.txt |grep "before"|awk '{print$2}')|bc" on "ROOT_SERVER_CLI" and validate result NOT_EQUALS "0"

  @SID_26
  Scenario: Validate IPv6 Hostname in /etc/hosts
    Then CLI Run linux Command "if [ "$(hostname | cut -d'.' -f 1)" == "$(grep "::1" /etc/hosts|head -1|awk '{print$6}')" ]; then echo "hostname ok"; else echo "hostname not ok"; fi" on "ROOT_SERVER_CLI" and validate result EQUALS "hostname ok"
    Then CLI Run linux Command "grep "::1" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_27
  Scenario: Validate IPv4 Hostname in /etc/hosts
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep "$(hostname | cut -d'.' -f 1)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_28
  Scenario: Verify number of tables in vision schema
    Then CLI Run linux Command "mysql -prad123 -NB -e "select count(*) from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='vision';"" on "ROOT_SERVER_CLI" and validate result EQUALS "90"

  @SID_29
  Scenario: Verify number of tables in vision_ng schema
    Then CLI Run linux Command "mysql -prad123 -NB -e "select count(*) from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='vision_ng';"" on "ROOT_SERVER_CLI" and validate result EQUALS "166"

  @SID_30
  Scenario: validate APM container is up and relevant services are running in it
    Then CLI Run linux Command "service vz status" on "ROOT_SERVER_CLI" and validate result EQUALS "OpenVZ is running..."
    Then CLI Run linux Command "vzctl exec 101 SPSERVER_INSTANCE=rad /usr/share/sharepath/server/sbin/spserver-initd.sh --action=status | grep "is running..." | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "6" Retry 600 seconds

  @SID_31
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

  @SID_32
  Scenario: Validate APM is running
    Given That Current Vision is Logged In
    And New Request Specification from File "Vision/SystemManagement" with label "Get Share Path State"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    And Validate That Response Body Contains
      | jsonPath         | value     |
      | $.sharePathState | "Running" |