@TC110094
Feature: Vision Install OVA SA

  @SID_1
  Scenario: Fresh Install VM
#    Given Prerequisite for Setup force
    Then Upgrade or Fresh Install Vision

  @SID_2
  Scenario: verify vision_install logs
    Then CLI Check if logs contains
      | logType        | expression | isExpected   |
      | VISION_INSTALL | fatal      | NOT_EXPECTED |
      | VISION_INSTALL | error      | NOT_EXPECTED |

  @SID_3
  Scenario: Validate server is up after reset
    # Avoid reboot during an active process
#    Given CLI Run linux Command "service mgtsrv status |grep 'Local License Server is upgrading in the background and will start after the process ends' |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0" Retry 600 seconds
    When CLI Operations - Run Root Session command "reboot"
    Then Sleep "180"
    When validate vision server services are UP

  @SID_4
  Scenario: Login with activation and install license
    Given REST Login with activation with user "radware" and password "radware"
    Then UI Login with user "radware" and password "radware"
    Then Validate License "ATTACK_CAPACITY_LICENSE" Parameters
      | allowedAttackCapacityGbps         | 0     |
      | requiredDevicesAttackCapacityGbps | 0     |
      | licensedDefenseProDeviceIpsList   | []    |
      | hasDemoLicense                    | false |
      | attackCapacityMaxLicenseExist     | false |
      | licenseViolated                   | false |
      | inGracePeriod                     | false |
    And Validate DefenseFlow is NOT Licensed by Attack Capacity License
    * REST Vision Install License Request "vision-reporting-module-ADC"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"

  @SID_5
  Scenario: Navigate to general settings page
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Basic Parameters"
    When UI Do Operation "select" item "Software"
    Then REST get Basic Parameters "lastUpgradeStatus"
    Then UI Validate Text field "Upgrade Status" EQUALS "NA"

  @SID_6
  Scenario: Validate iptables settings
    #there are 25 open ports without LLS and ElasticSearch
    Then CLI Run linux Command "iptables -n -L RH-Firewall-1-INPUT|grep "ACCEPT "|wc -l" on "ROOT_SERVER_CLI" and validate result LTE "27"
    Then CLI Run linux Command "iptables -L -n | grep -w "REJECT     all"" on "ROOT_SERVER_CLI" and validate result CONTAINS "reject-with icmp-host-prohibited"
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
    Then CLI Run linux Command "iptables -L -n | grep -w DROP |grep -w icmp |grep -w 13" on "ROOT_SERVER_CLI" and validate result CONTAINS "DROP"
    Then CLI Run linux Command "iptables -L -n |grep "ACCEPT"|grep "state NEW" |wc -l" on "ROOT_SERVER_CLI" and validate result LTE "18"


  @SID_7
  Scenario: Validate ip6tables settings
    Then CLI Run linux Command "ip6tables -L -n | grep -w "REJECT     all"" on "ROOT_SERVER_CLI" and validate result CONTAINS "reject-with icmp6-adm-prohibited"
    Then CLI Run linux Command "ip6tables -L -n |grep -w tcp |grep -w "dpt:1443"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w tcp |grep -w "dpt:5672"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w tcp |grep -w "dpt:5671"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w tcp |grep -w "dpt:9443"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w tcp |grep -w "dpt:2189"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w tcp |grep -w "dpt:2215"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w udp |grep -w "dpt:2215"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w tcp |grep -w "dpt:2214"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w udp |grep -w "dpt:2214"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w udp |grep -w "dpt:2088"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w udp |grep -w "dpt:162"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w tcp |grep -w "dpt:9216"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w tcp |grep -w "dpt:443"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w tcp |grep -w "dpt:80"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep "dpt:161" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"

  @SID_8
  Scenario: Validate TED status
    Then CLI Run linux Command "echo $(vision_ng -N -B -e "select count(*) from vision_license where license_str like '%reporting-module-ADC%';")-$(netstat -nlt |grep 5140|wc -l)|bc" on "ROOT_SERVER_CLI" and validate result EQUALS "0" Retry 900 seconds
    Then CLI Run linux Command "curl -ks -o null -w 'RESP_CODE:%{response_code}\n' -XGET https://localhost:443/ted/api/data" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200"

  @SID_9
  Scenario: Logout
    Given UI logout and close browser

  @SID_10
  Scenario: validate Edit Threshold script exist in vision
    Then CLI Run linux Command "ll /opt/radware/storage/vdirect/database/templates/adjust_profile_v2.vm |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "ll /opt/radware/ConfigurationTemplatesRepository/actionable/adjust_profile_v2.vm |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_11
  Scenario: validate available disk space
    Then CLI Run linux Command "df -hP /opt/radware/storage|tail -1|awk -F" " '{print $5}'|awk -F"%" '{print $1}'" on "ROOT_SERVER_CLI" and validate result LTE "6"
    Then CLI Run linux Command "df -hP /opt/radware|tail -1|awk -F" " '{print $5}'|awk -F"%" '{print $1}'" on "ROOT_SERVER_CLI" and validate result LTE "30"
    Then CLI Run remote linux Command "df -hP /|tail -1|awk '{print $5}'|grep -oP '[\d]*'" on "ROOT_SERVER_CLI"
    Then CLI Run linux Command "echo $(df /|tail -1|awk '{print $3}')/$(df /|tail -1|awk '{print $2}')*100|bc -l|grep -oP '^\d*'" on "ROOT_SERVER_CLI" and validate result LTE "45"

  @SID_12
  Scenario: Validate MySql version
    Then MYSQL Validate "version" Variable Value EQUALS "10.4.6-MariaDB"

  @SID_13
  Scenario: Validate vdirect listener
    Then CLI Run linux Command "netstat -nlt |grep 2188|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2188" Retry 120 seconds
    Then CLI Run linux Command "netstat -nlt |grep 2189|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2189" Retry 120 seconds
    Then CLI Run linux Command "curl -ks -o null -XGET https://localhost6:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200"
    Then CLI Run linux Command "curl -ks -o null -XGET https://localhost4:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200"

  @SID_14
  Scenario: Validate LLS version
    Then CLI Run linux Command "cat /opt/radware/storage/llsinstall/license-server-*/version.txt" on "ROOT_SERVER_CLI" and validate result CONTAINS "2.6.0"

  @SID_15
  Scenario: Validate IPv6 Hostname in /etc/hosts
    Then CLI Run linux Command "if [ "$(hostname | cut -d'.' -f 1)" == "$(grep "::1" /etc/hosts|head -1|awk '{print$6}')" ]; then echo "hostname ok"; else echo "hostname not ok"; fi" on "ROOT_SERVER_CLI" and validate result EQUALS "hostname ok"
    Then CLI Run linux Command "grep "::1" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_16
  Scenario: Validate IPv4 Hostname in /etc/hosts
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep "$(hostname | cut -d'.' -f 1)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_17
  Scenario: Verify number of tables in vision schema
    Then MYSQL Validate Number of Records FROM "TABLES" Table in "INFORMATION_SCHEMA" Schema WHERE "TABLE_SCHEMA='vision'" Condition Applies EQUALS 90


  @SID_18
  Scenario: Verify number of tables in vision_ng schema
    Then MYSQL Validate Number of Records FROM "TABLES" Table in "INFORMATION_SCHEMA" Schema WHERE "TABLE_SCHEMA='vision_ng'" Condition Applies EQUALS 166

  @SID_19
  Scenario: Verify services are running
    Then CLI validate service "CONFIG_KVISION_DC_NGINX" status is "UP" and health is "HEALTHY"
    Then CLI validate service "CONFIG_KVISION_FORMATTER" status is "UP" and health is "HEALTHY"
    Then CLI validate service "CONFIG_KVISION_RT_ALERT" status is "UP" and health is "HEALTHY"
    Then CLI validate service "CONFIG_KVISION_REPORTER" status is "UP" and health is "HEALTHY"
    Then CLI validate service "CONFIG_KVISION_COLLECTOR" status is "UP" and health is "HEALTHY"
    Then CLI validate service "CONFIG_KVISION_VRM" status is "UP" and health is "HEALTHY"
    Then CLI validate service "CONFIG_KVISION_CONFIG_SYNC_SERVICE" status is "UP" and health is "HEALTHY"
    Then CLI validate service "CONFIG_KVISION_VDIRECT" status is "UP" and health is "HEALTHY"
    Then CLI validate service "CONFIG_KVISION_SCHEDULER" status is "UP" and health is "HEALTHY"
    Then CLI validate service "CONFIG_KVISION_TOR_FEED" status is "UP" and health is "HEALTHY"
    Then CLI validate service "CONFIG_KVISION_CONFIGURATION_SERVICE" status is "UP" and health is "HEALTHY"
    Then CLI validate service "CONFIG_KVISION_ALERTS" status is "UP" and health is "HEALTHY"
    Then CLI validate service "CONFIG_KVISION_INFRA_AVR" status is "UP" and health is "NONE"
    Then CLI validate service "CONFIG_KVISION_LLS" status is "UP" and health is "NONE"
    Then CLI validate service "CONFIG_KVISION_TED" status is "UP" and health is "HEALTHY"
    Then CLI validate service "CONFIG_KVISION_HELP" status is "UP" and health is "HEALTHY"
    Then CLI validate service "CONFIG_KVISION_INFRA_EFK" status is "UP" and health is "HEALTHY"
    Then CLI validate service "CONFIG_KVISION_WEBUI" status is "UP" and health is "HEALTHY"
    Then CLI validate service "CONFIG_KVISION_INFRA_MARIADB" status is "UP" and health is "HEALTHY"
    Then CLI validate service "CONFIG_KVISION_INFRA_AUTOHEAL" status is "UP" and health is "HEALTHY"
    Then CLI validate service "CONFIG_KVISION_INFRA_IPV6NAT" status is "UP" and health is "NONE"
    Then CLI validate service "CONFIG_KVISION_INFRA_RABBITMQ" status is "UP" and health is "NONE"
    Then CLI validate service "CONFIG_KVISION_INFRA_FLUENTD" status is "UP" and health is "NONE"
    Then CLI validate service "NODE_EXPORTER" status is "UP" and health is "NONE"
    Then CLI validate service "MYSQK_EXPORTER" status is "UP" and health is "NONE"
    Then CLI validate service "PROMETHEUS" status is "UP" and health is "NONE"
    Then CLI validate service "ES_EXPORTER" status is "UP" and health is "NONE"
    Then CLI validate service "GRAFANA" status is "UP" and health is "NONE"
    Then CLI validate service "PROCESS_EXPORTER" status is "UP" and health is "NONE"

  @SID_20
  Scenario: Verify 32GB RAM
    Then CLI Run linux Command "echo $(grep MemTotal /proc/meminfo | awk '{print $2 / 1024}')*1|bc -l|grep -oP '^\d*'" on "ROOT_SERVER_CLI" and validate result GTE "32000"

  @SID_21
  Scenario: Verify vg_disk-lv number of partitions
    Then CLI Run linux Command "df -h | grep vg_disk-lv | wc -l" on "ROOT_SERVER_CLI" and validate result GTE "2" Retry 15 seconds

  @SID_22
  Scenario: Check lvm partitions:
    When CLI Operations - Run Root Session command "df -h"
    Then CLI Operations - Verify that output contains regex "vg_disk-lv_radware"
    Then CLI Operations - Verify that output contains regex "vg_disk-lv_storage"
    Then CLI Run linux Command "df -h | awk 'NR==5' | awk '{print $1}' | sed 's/G//'" on "ROOT_SERVER_CLI" and validate result GT "8"
    Then CLI Run linux Command "df -h | awk 'NR==7' | awk '{print $1}' | sed 's/G//'" on "ROOT_SERVER_CLI" and validate result GTE "200"