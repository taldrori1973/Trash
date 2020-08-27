@TC109703
Feature: Vision Install ODS-VL2 SA

  @SID_1
  Scenario: Fresh Install Physical
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
  Scenario: Login and install license
    * REST Login with activation with user "radware" and password "radware"
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

  @SID_4
  Scenario: Navigate to general settings page
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Basic Parameters"
    When UI Do Operation "select" item "Software"
    Then REST get Basic Parameters "lastUpgradeStatus"
    Then UI Validate Text field "Upgrade Status" EQUALS "Fresh install"

  @SID_5
  Scenario: Validate iptables settings
    Then CLI Run linux Command "iptables -n -L RH-Firewall-1-INPUT|grep "ACCEPT "|wc -l" on "ROOT_SERVER_CLI" and validate result LTE "26"
    Then CLI Run linux Command "iptables -L -n | grep -w "REJECT     all"" on "ROOT_SERVER_CLI" and validate result CONTAINS "reject-with icmp-host-prohibited"
    Then CLI Run linux Command "iptables -L -n |grep -w tcp | grep -w "dpt:5604"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
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
    Then CLI Run linux Command "ip6tables -L -n | grep -w "REJECT     all"" on "ROOT_SERVER_CLI" and validate result CONTAINS "reject-with icmp6-adm-prohibited"
    Then CLI Run linux Command "ip6tables -L -n |grep -w tcp | grep -w "dpt:5604"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
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
  Scenario: Logout
    Given UI logout and close browser

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

  @SID_11
  Scenario: Validate MySql version
    Then CLI Run linux Command "mysql -prad123 --version|awk '{print$5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "10.4.6-MariaDB,"

  @SID_12
  Scenario: Validate vdirect listener
    Then CLI Run linux Command "netstat -nlt |grep 2188|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2188"
    Then CLI Run linux Command "netstat -nlt |grep 2189|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2189"
    Then CLI Run linux Command "curl -ks -o null -XGET https://localhost6:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200"
    Then CLI Run linux Command "curl -ks -o null -XGET https://localhost4:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200"

  @SID_13
  Scenario: Validate LLS service is up
    When Sleep "90"
    Then CLI Run linux Command "curl -ks -o null -XGET http://localhost4:7070/api/1.0/hostids -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" with timeOut 300
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"
    Then CLI Run linux Command "curl -ks -o null -XGET http://localhost4:7070/api/1.0/hostids -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200" with timeOut 300
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"

  @SID_14
  Scenario: Validate LLS version
    Then CLI Run linux Command "cat /opt/radware/storage/llsinstall/license-server-*/version.txt" on "ROOT_SERVER_CLI" and validate result EQUALS "2.4.0-1"

  @SID_15
  Scenario: Validate Radware MAC addresses
    Then CLI Run linux Command "ifconfig -a G3|head -1|awk '{print$5}'|grep -E "2C:B6:9|00:3b:2"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "ifconfig -a G4|head -1|awk '{print$5}'|grep -E "2C:B6:9|00:3b:2"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "ifconfig -a G5|head -1|awk '{print$5}'|grep -E "2C:B6:9|00:3b:2"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "ifconfig -a G7|head -1|awk '{print$5}'|grep -E "2C:B6:9|00:3b:2"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "ifconfig -a eth0|head -1|awk '{print$5}'|grep -E "2C:B6:9|00:3b:2"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "ifconfig -a eth1|head -1|awk '{print$5}'|grep -E "2C:B6:9|00:3b:2"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "ifconfig -a eth4|head -1|awk '{print$5}'|grep -E "2C:B6:9|00:3b:2"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "ifconfig -a eth6|head -1|awk '{print$5}'|grep -E "2C:B6:9|00:3b:2"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "ifconfig -a eth8|head -1|awk '{print$5}'|grep -E "2C:B6:9|00:3b:2"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "ifconfig -a eth9|head -1|awk '{print$5}'|grep -E "2C:B6:9|00:3b:2"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_16
  Scenario: Validate HW status command
    Then CLI Run linux Command "/opt/radware/box/bin/system_hardware_status.sh get|awk -F"|" '{print$2}'|head -4|tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "Fan No."
    Then CLI Run linux Command "/opt/radware/box/bin/system_hardware_status.sh get|awk -F"|" '{print$3}'|head -4|tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "Status"
    Then CLI Run linux Command "/opt/radware/box/bin/system_hardware_status.sh get|awk -F"|" '{print$2}'|head -6|tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "/opt/radware/box/bin/system_hardware_status.sh get|awk -F"|" '{print$3}'|head -6|tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "OK"
    Then CLI Run linux Command "/opt/radware/box/bin/system_hardware_status.sh get|awk -F"|" '{print$2}'|head -7|tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "2"
    Then CLI Run linux Command "/opt/radware/box/bin/system_hardware_status.sh get|awk -F"|" '{print$3}'|head -7|tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "OK"
    Then CLI Run linux Command "/opt/radware/box/bin/system_hardware_status.sh get|awk -F"|" '{print$2}'|head -8|tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "3"
    Then CLI Run linux Command "/opt/radware/box/bin/system_hardware_status.sh get|awk -F"|" '{print$3}'|head -8|tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "OK"

    Then CLI Run linux Command "/opt/radware/box/bin/system_hardware_status.sh get|awk -F"|" '{print$2}'|head -12|tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "Sensor No."
    Then CLI Run linux Command "/opt/radware/box/bin/system_hardware_status.sh get|awk -F"|" '{print$3}'|head -12|tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "Temperature"
    Then CLI Run linux Command "/opt/radware/box/bin/system_hardware_status.sh get|awk -F"|" '{print$4}'|head -12|tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "Status"

    Then CLI Run linux Command "/opt/radware/box/bin/system_hardware_status.sh get|awk -F"|" '{print$2}'|head -14|tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "/opt/radware/box/bin/system_hardware_status.sh get|awk -F"|" '{print$3}'|head -14|tail -1" on "ROOT_SERVER_CLI" and validate result CONTAINS "[C]"
    Then CLI Run linux Command "/opt/radware/box/bin/system_hardware_status.sh get|awk -F"|" '{print$4}'|head -14|tail -1" on "ROOT_SERVER_CLI" and validate result EQUALS "Normal"

  @SID_17
  Scenario: Validate IPv6 Hostname in /etc/hosts
    Then CLI Run linux Command "if [ "$(hostname | cut -d'.' -f 1)" == "$(grep "::1" /etc/hosts|head -1|awk '{print$6}')" ]; then echo "hostname ok"; else echo "hostname not ok"; fi" on "ROOT_SERVER_CLI" and validate result EQUALS "hostname ok"
    Then CLI Run linux Command "grep "::1" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_18
  Scenario: Validate IPv4 Hostname in /etc/hosts
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep "$(hostname | cut -d'.' -f 1)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_20
  Scenario: Remove License
    * REST Vision DELETE License Request "vision-reporting-module-ADC"
    * REST Vision DELETE License Request "vision-AVA-Max-attack-capacity"

  @SID_21
  Scenario: Verify number of tables in vision schema
    Then CLI Run linux Command "mysql -prad123 -NB -e "select count(*) from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='vision';"" on "ROOT_SERVER_CLI" and validate result EQUALS "90"

  @SID_22
  Scenario: Verify number of tables in vision_ng schema
    Then CLI Run linux Command "mysql -prad123 -NB -e "select count(*) from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='vision_ng';"" on "ROOT_SERVER_CLI" and validate result EQUALS "166"

  @SID_19
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

