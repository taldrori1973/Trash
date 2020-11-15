@TC109638
Feature: Vision Install KVM APM

  @SID_1
  Scenario: Fresh Install APM on KVM
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
  Scenario: Login with activation and install license
    Given REST Login with activation with user "radware" and password "radware"
    Then UI Login with user "radware" and password "radware"

    Then Validate License "ATTACK_CAPACITY_LICENSE" Parameters
      | allowedAttackCapacityGbps         | 0                    |
      | requiredDevicesAttackCapacityGbps | 0                    |
      | licensedDefenseProDeviceIpsList   | []                   |
      | hasDemoLicense                    | false                |
      | attackCapacityMaxLicenseExist     | false                |
      | licenseViolated                   | false                |
      | inGracePeriod                     | false                |
    And Validate DefenseFlow is NOT Licensed by Attack Capacity License

    * REST Vision Install License Request "vision-reporting-module-ADC"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"

  @SID_4
  Scenario: Navigate and validate general settings page
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Basic Parameters"
    When UI Do Operation "select" item "Software"
    Then REST get Basic Parameters "lastUpgradeStatus"
    Then UI Validate Text field "Upgrade Status" EQUALS "Fresh install"
    Then UI Validate Text field "MAC Address of Port G4" CONTAINS ":"

  @SID_5
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

  @SID_6
  Scenario: Validate ip6tables settings
    Then CLI Run linux Command "ip6tables -n -L RH-Firewall-1-INPUT | grep -w "REJECT     all"" on "ROOT_SERVER_CLI" and validate result CONTAINS "reject-with icmp6-adm-prohibited"
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
    Then CLI Run linux Command "ip6tables -L -n |grep -w tcp |grep -w "dpt:22"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"

  @SID_7
  Scenario: Validate TED status
    Then CLI Run linux Command "echo $(mysql -prad123 vision_ng -N -B -e "select count(*) from vision_license where license_str like '%reporting-module-ADC%';")-$(netstat -nlt |grep 5140|wc -l)|bc" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then CLI Run linux Command "curl -ks -o null -w 'RESP_CODE:%{response_code}\n' -XGET https://localhost:443/ted/api/data" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200"

  @SID_8
  Scenario: Create new Site
    Then UI Add new Site "Site After Fresh" under Parent "Default"

  @SID_9
  Scenario: validate Edit Threshold script exist in vision
    Then CLI Run linux Command "ll /opt/radware/storage/vdirect/database/templates/adjust_profile_v2.vm |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "ll /opt/radware/ConfigurationTemplatesRepository/actionable/adjust_profile_v2.vm |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_10
  Scenario: validate available disk space
    Then CLI Run linux Command "df -hP /opt/radware/storage|tail -1|awk -F" " '{print $5}'|awk -F"%" '{print $1}'" on "ROOT_SERVER_CLI" and validate result LTE "6"
    Then CLI Run linux Command "df -hP /opt/radware|tail -1|awk -F" " '{print $5}'|awk -F"%" '{print $1}'" on "ROOT_SERVER_CLI" and validate result LTE "30"
    Then CLI Run remote linux Command "df -hP /|tail -1|awk '{print $5}'|grep -oP '[\d]*'" on "ROOT_SERVER_CLI"
    Then CLI Run linux Command "echo $(df /|tail -1|awk '{print $3}')/$(df /|tail -1|awk '{print $2}')*100|bc -l|grep -oP '^\d*'" on "ROOT_SERVER_CLI" and validate result LTE "45"
    Then CLI Run linux Command "df -hP /vz/private|tail -1|awk -F" " '{print $5}'|awk -F"%" '{print $1}'" on "ROOT_SERVER_CLI" and validate result LTE "15"

  @SID_11
  Scenario: Validate MySql version
    Then CLI Run linux Command "mysql -prad123 --version|awk '{print$5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "10.4.6-MariaDB,"

  @SID_12
  Scenario: Validate vdirect listener
    Then CLI Run linux Command "netstat -nlt |grep 2188|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2188"
    Then CLI Run linux Command "netstat -nlt |grep 2189|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2189"
    Then CLI Run linux Command "curl -ks -o null -XGET https://localhost6:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" with timeOut 300 with runCommand delay 90
    Then CLI Run linux Command "curl -ks -o null -XGET https://localhost4:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" with timeOut 300 with runCommand delay 90

  @SID_13
  Scenario: Validate LLS version
    Then CLI Run linux Command "cat /opt/radware/storage/llsinstall/license-server-*/version.txt" on "ROOT_SERVER_CLI" and validate result EQUALS "2.4.0-2"

  @SID_14
  Scenario: Validate IPv6 Hostname in /etc/hosts
    Then CLI Run linux Command "if [ "$(hostname | cut -d'.' -f 1)" == "$(grep "::1" /etc/hosts|head -1|awk '{print$6}')" ]; then echo "hostname ok"; else echo "hostname not ok"; fi" on "ROOT_SERVER_CLI" and validate result EQUALS "hostname ok"
    Then CLI Run linux Command "grep "::1" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_15
  Scenario: Validate IPv4 Hostname in /etc/hosts
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep "$(hostname | cut -d'.' -f 1)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_16
  Scenario: Validate minimum RAM for LLS
    Then CLI Run linux Command "mysql -prad123 vision_ng -NBe "select min_required_ram from lls_server;"" on "ROOT_SERVER_CLI" and validate result EQUALS "24"

  @SID_17
  Scenario: Validate LLS service is up
    When Sleep "120"
    Then CLI Run linux Command "curl -ks -o null -XGET http://localhost4:7070/api/1.0/hostids -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" with timeOut 300
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"
    Then CLI Run linux Command "curl -ks -o null -XGET http://localhost6:7070/api/1.0/hostids -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" with timeOut 300
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"

  @SID_18
  Scenario: Verify number of tables in vision schema
    Then CLI Run linux Command "mysql -prad123 -NB -e "select count(*) from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='vision';"" on "ROOT_SERVER_CLI" and validate result EQUALS "90"

  @SID_19
  Scenario: Verify number of tables in vision_ng schema
    Then CLI Run linux Command "mysql -prad123 -NB -e "select count(*) from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='vision_ng';"" on "ROOT_SERVER_CLI" and validate result EQUALS "166"

  @SID_20
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

  @SID_21
  Scenario: Verify vg_disk-lv number of partitions
    Then CLI Run linux Command "df -h | grep vg_disk-lv | wc -l" on "ROOT_SERVER_CLI" and validate result GTE "2" with timeOut 15
