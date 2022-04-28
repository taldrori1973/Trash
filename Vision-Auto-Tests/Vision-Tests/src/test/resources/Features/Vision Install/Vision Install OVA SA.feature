@TC110094
Feature: Vision Install OVA SA

  @SID_1
  Scenario: Fresh Install VM
    Given Prerequisite for Setup force
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
    Then UI Validate Text field "Upgrade Status" EQUALS "Fresh install"

  @SID_6
  Scenario: Validate iptables settings
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


  @SID_7
  Scenario: Validate TED status
    Then CLI Run linux Command "curl -ks -o null -w 'RESP_CODE:%{response_code}\n' -XGET https://localhost:443/ted/api/data" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200"

  @SID_8
  Scenario: Logout
    Given UI logout and close browser

  @SID_9
  Scenario: validate Edit Threshold script exist in vision
    Then CLI Run linux Command "ll /var/lib/docker/docker-root/volumes/config_vdirect/_data/templates/adjust_profile_v2.vm |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "for path in /*;do find "$path" -type f -name "adjust_profile_v2.vm" -print -quit ;done | grep /opt/radware/ConfigurationTemplatesRepository/actionable/adjust_profile_v2.vm |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1" Wait For Prompt 180 seconds

  @SID_10
  Scenario: validate available disk space
    Then CLI Run linux Command "df -hP /opt/radware/storage|tail -1|awk -F" " '{print $5}'|awk -F"%" '{print $1}'" on "ROOT_SERVER_CLI" and validate result LTE "6"
    Then CLI Run linux Command "df -hP /opt/radware|tail -1|awk -F" " '{print $5}'|awk -F"%" '{print $1}'" on "ROOT_SERVER_CLI" and validate result LTE "30"
    Then CLI Run remote linux Command "df -hP /|tail -1|awk '{print $5}'|grep -oP '[\d]*'" on "ROOT_SERVER_CLI"
    Then CLI Run linux Command "echo $(df /|tail -1|awk '{print $3}')/$(df /|tail -1|awk '{print $2}')*100|bc -l|grep -oP '^\d*'" on "ROOT_SERVER_CLI" and validate result LTE "45"

  @SID_11
  Scenario: Validate MySql version
    Then MYSQL Validate "version" Variable Value EQUALS "10.4.6-MariaDB"

  @SID_12
  Scenario: Validate vdirect listener
    Then CLI Run linux Command "netstat -nlt |grep 2188|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2188" Retry 120 seconds
    Then CLI Run linux Command "netstat -nlt |grep 2189|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2189" Retry 120 seconds
    Then CLI Run remote linux Command "curl -ks -o null -XGET https://localhost:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"

  @SID_13
  Scenario: Validate LLS version
    Then CLI Run linux Command "system lls version" on "RADWARE_SERVER_CLI" and validate result CONTAINS "LLS version: 2.7.0"

  @SID_14
  Scenario: Validate LLS service is up
    Then CLI Run linux Command "system lls service status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "Local License Server is running." in any line Retry 600 seconds
    Then CLI Run linux Command "curl -ks -o null -XGET http://localhost:7070/api/1.0/hostids -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" Retry 300 seconds
    Then CLI Check if logs contains
      | logType | expression          | isExpected   |
      | LLS     | fatal\| error\|fail | NOT_EXPECTED |

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
    Then MYSQL Validate Number of Records FROM "TABLES" Table in "INFORMATION_SCHEMA" Schema WHERE "TABLE_SCHEMA='vision_ng'" Condition Applies EQUALS 169

  @SID_19
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