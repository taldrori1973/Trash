@TC109413
Feature: Vision Install KVM SA

  @SID_1
  Scenario: Fresh Install on KVM
    Given Prerequisite for Setup force
    Then Upgrade or Fresh Install Vision

  @SID_2
  Scenario: verify vision_install logs
    Then CLI Check if logs contains
      | logType        | expression | isExpected   |
      | VISION_INSTALL | fatal      | NOT_EXPECTED |
      | VISION_INSTALL | error      | NOT_EXPECTED |
      | LLS            | error      | NOT_EXPECTED |
      | LLS            | fatal      | NOT_EXPECTED |

  @SID_3
  Scenario: Validate server is up after reset
    # Avoid reboot during an active process
    Given CLI Run linux Command "service mgtsrv status |grep 'Local License Server is upgrading in the background and will start after the process ends' |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0" Retry 600 seconds
    When CLI Run remote linux Command "reboot" on "RADWARE_SERVER_CLI"
    Then Sleep "180"
    When validate vision server services are UP

  @SID_4
  Scenario: Login with activation and install licenses
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
  Scenario: Navigate and validate general settings page
    When UI Go To Vision
    And UI Navigate to page "System->General Settings->Basic Parameters"
    And UI Do Operation "select" item "Software"
    Then REST get Basic Parameters "lastUpgradeStatus"
    Then UI Validate Text field "Upgrade Status" EQUALS "Fresh install"
    Then UI Validate Text field "MAC Address of Port G4" EQUALS "Unsupported"

  @SID_6
  Scenario: Validate iptables settings
    #there are 25 open ports without LLS and ElasticSearch
    Then CLI Run linux Command "iptables -n -L RH-Firewall-1-INPUT|grep "ACCEPT "|wc -l" on "ROOT_SERVER_CLI" and validate result LTE "27"
    Then CLI Run linux Command "iptables -L -n | grep -w "REJECT     all"" on "ROOT_SERVER_CLI" and validate result CONTAINS "reject-with icmp-host-prohibited"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp |grep -w "dpt:5671"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp |grep -w "dpt:2189"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp |grep -w "dpt:2215"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w udp |grep -w "dpt:2088"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w udp |grep -w "dpt:162"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp |grep -w "dpt:443"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp |grep -w "dpt:80"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp |grep -w "dpt:22"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep -w icmp |grep -w 17" on "ROOT_SERVER_CLI" and validate result CONTAINS "DROP"
    Then CLI Run linux Command "iptables -L -n | grep -w DROP |grep -w icmp |grep -w 13" on "ROOT_SERVER_CLI" and validate result CONTAINS "DROP"
    Then CLI Run linux Command "iptables -L -n |grep "ACCEPT"|grep "state NEW" |wc -l" on "ROOT_SERVER_CLI" and validate result LTE "18"

  @SID_7
  Scenario: Validate ip6tables settings
    Then CLI Run linux Command "ip6tables -L -n | grep -w "REJECT     all"" on "ROOT_SERVER_CLI" and validate result CONTAINS "reject-with icmp6-port-unreachable"
    Then CLI Run linux Command "ip6tables -L -n |grep -w tcp |grep -w "dpt:5671"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w tcp |grep -w "dpt:2189"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w tcp |grep -w "dpt:2215"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w udp |grep -w "dpt:2088"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w udp |grep -w "dpt:162"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w tcp |grep -w "dpt:443"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w tcp |grep -w "dpt:80"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "ip6tables -L -n |grep -w tcp |grep -w "dpt:22"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"

  @SID_8
  Scenario: Validate TED status
    Then CLI Run linux Command "curl -ks -o null -w 'RESP_CODE:%{response_code}\n' -XGET https://localhost:443/ted/api/data" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200"

  @SID_9
  Scenario: Create new Site
    Then UI Add new Site "Site After Fresh" under Parent "Default"

  @SID_10
  Scenario: validate Edit Threshold script exist in vision
    Then CLI Run linux Command "ll /var/lib/docker/docker-root/volumes/config_vdirect/_data/templates/adjust_profile_v2.vm |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "for path in /*;do find "$path" -type f -name "adjust_profile_v2.vm" -print -quit ;done | grep /opt/radware/ConfigurationTemplatesRepository/actionable/adjust_profile_v2.vm |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1" Wait For Prompt 180 seconds

  @SID_11
  Scenario: validate available disk space
    Then CLI Run linux Command "df -hP /opt/radware/storage|tail -1|awk -F" " '{print $5}'|awk -F"%" '{print $1}'" on "ROOT_SERVER_CLI" and validate result LTE "6"
    Then CLI Run linux Command "df -hP /opt/radware|tail -1|awk -F" " '{print $5}'|awk -F"%" '{print $1}'" on "ROOT_SERVER_CLI" and validate result LTE "30"
    Then CLI Run remote linux Command "df -hP /|tail -1|awk '{print $5}'|grep -oP '[\d]*'" on "ROOT_SERVER_CLI"
    Then CLI Run linux Command "echo $(df /|tail -1|awk '{print $3}')/$(df /|tail -1|awk '{print $2}')*100|bc -l|grep -oP '^\d*'" on "ROOT_SERVER_CLI" and validate result LTE "45"

  @SID_12
  Scenario: Validate MySql version
    Then MYSQL Validate "version" Variable Value EQUALS "10.5.9-MariaDB"


  @SID_13
  Scenario: Validate vDirect listener
    Then CLI Run linux Command "netstat -nlt |grep 2188|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2188" Retry 120 seconds
    Then CLI Run linux Command "netstat -nlt |grep 2189|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2189" Retry 120 seconds
    Then CLI Run remote linux Command "curl -ks -o null -XGET https://localhost:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"

  @SID_14
  Scenario: Validate LLS service is up
    Then CLI Run linux Command "system lls service status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "Local License Server is running." in any line Retry 600 seconds
    Then CLI Run linux Command "curl -ks -o null -XGET http://localhost:7070/api/1.0/hostids -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" Retry 300 seconds
    Then CLI Check if logs contains
      | logType | expression          | isExpected   |
      | LLS     | fatal\| error\|fail | NOT_EXPECTED |

  @SID_15
  Scenario: Validate LLS version
    Then CLI Run linux Command "system lls version" on "RADWARE_SERVER_CLI" and validate result CONTAINS "LLS version: 2.8.0"

  @SID_16
  Scenario: Validate IPv6 Hostname in /etc/hosts
    Then CLI Run linux Command "if [ "$(hostname | cut -d'.' -f 1)" == "$(grep "::1" /etc/hosts|head -1|awk '{print$2}')" ]; then echo "hostname ok"; else echo "hostname not ok"; fi" on "ROOT_SERVER_CLI" and validate result EQUALS "hostname ok"
    Then CLI Run linux Command "grep "::1" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_17
  Scenario: Validate IPv4 Hostname in /etc/hosts
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$3}')" /etc/hosts|grep "$(hostname | cut -d'.' -f 1)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$3}')" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_18
  Scenario: Verify number of tables in vision schema
    Then MYSQL Validate Number of Records FROM "TABLES" Table in "INFORMATION_SCHEMA" Schema WHERE "TABLE_SCHEMA='vision'" Condition Applies EQUALS 71

  @SID_19
  Scenario: Verify number of tables in vision_ng schema
    Then MYSQL Validate Number of Records FROM "TABLES" Table in "INFORMATION_SCHEMA" Schema WHERE "TABLE_SCHEMA='vision_ng'" Condition Applies EQUALS 165

  @SID_20
  Scenario: Verify services are running
    When CLI Operations - Run Radware Session command "system vision-server status"
    Then CLI Operations - Verify that output contains regex "config_kvision-lls_1\s+.*Up"
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

  @SID_21
  Scenario: Verify vg_disk-lv number of partitions
    Then CLI Run linux Command "df -h | grep vg_disk-lv | wc -l" on "ROOT_SERVER_CLI" and validate result GTE "2" Retry 15 seconds

  @SID_22
  Scenario: Check lvm partitions:
    Given CLI Operations - Run Root Session command "df -h"
    When CLI Operations - Verify that output contains regex "vg_disk-lv_radware"
    And CLI Operations - Verify that output contains regex "vg_disk-lv_storage"
    Then CLI Run linux Command "df -h |grep vg_disk-lv_radware | awk '{print $2}' | sed 's/G//'" on "ROOT_SERVER_CLI" and validate result GT "30"
    Then CLI Run linux Command "df -h |grep vg_disk-lv_storage | awk '{print $2}' | sed 's/G//'" on "ROOT_SERVER_CLI" and validate result GTE "350"

    @SID_23
    Scenario: Clean and CLose
      Then UI logout and close browser