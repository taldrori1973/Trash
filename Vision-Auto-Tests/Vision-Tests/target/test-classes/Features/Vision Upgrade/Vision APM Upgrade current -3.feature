@TC109892
Feature: Vision APM Upgrade current -3

  @SID_1
  Scenario: preparations for upgrade release -3
    Given Prerequisite for Setup force

        ######################################################################################

  @SID_2
  Scenario: Fill partitions to max limit
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Then CLI copy "/home/radware/Scripts/fill_my_disk.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
#    Then CLI copy "/home/radware/Scripts/copyUpgradeLog.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then CLI Run remote linux Command "/fill_my_disk.sh /opt/radware 88" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/fill_my_disk.sh / 88" on "ROOT_SERVER_CLI"

  @SID_25
  Scenario: Do any pre-upgrade changes
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
       #for testing AVA Attack Capacity Grace Period with the following scenario:
      # if before upgrade the server not have the Legacy "vision-reporting-module-AMS" license and never installs the new AVA License so after upgrade No  Grace Period will be given:
    Given REST Vision DELETE License Request "vision-AVA-6-Gbps-attack-capacity"
    And REST Vision DELETE License Request "vision-AVA-20-Gbps-attack-capacity"
    And REST Vision DELETE License Request "vision-AVA-60-Gbps-attack-capacity"
    And REST Vision DELETE License Request "vision-AVA-400-Gbps-attack-capacity"
    And REST Vision DELETE License Request "vision-AVA-Max-attack-capacity"

    And REST Vision Install License Request "vision-reporting-module-AMS"
    And Set AVA_Grace_Period_Status to Not Set


    ######################################################################################
  @SID_3
  Scenario: Upgrade APM vision from release -3
    Then Upgrade or Fresh Install Vision

  @SID_4
  Scenario: Check upgrade logs
    # Saving upgrade log to Generic server /home/radware/UpgradeLogs/
#    Then CLI Run remote linux Command "/copyUpgradeLog.sh" on "ROOT_SERVER_CLI"

    Then CLI Check if logs contains
      | logType | expression                                                       | isExpected   |
      | UPGRADE | fatal                                                            | NOT_EXPECTED |
    # | UPGRADE | error                                                            | NOT_EXPECTED      |
      | UPGRADE | fail to\|failed to                                               | NOT_EXPECTED |
      | UPGRADE | The upgrade of APSolute Vision server has completed successfully | EXPECTED     |
      | UPGRADE | Vision Reporter upgrade finished                                 | EXPECTED     |
      | UPGRADE | Successfully upgraded from AVR                                   | EXPECTED     |
      | UPGRADE | Upgrading vDirect services ended                                 | EXPECTED     |
      | UPGRADE | APSolute Vision ELASTICSEARCH upgrade finished                   | EXPECTED     |
      | UPGRADE | APSolute Vision AMQP upgrade finished                            | EXPECTED     |
      | UPGRADE | APSolute Vision Appwall upgrade finished                         | EXPECTED     |
      | UPGRADE | APSolute Vision Workflows upgrade finished                       | EXPECTED     |
      | UPGRADE | APSolute Vision Databse upgrade finished                         | EXPECTED     |
      | UPGRADE | APSolute Vision CLI upgrade finished                             | EXPECTED     |
      | UPGRADE | APSolute Vision Web upgrade finished                             | EXPECTED     |
      | UPGRADE | APSolute Vision DP upgrade finished                              | EXPECTED     |
      | UPGRADE | APSolute Vision Configuration upgrade finished                   | EXPECTED     |
      | UPGRADE | APSolute Vision Device upgrade finished                          | EXPECTED     |
      | UPGRADE | APSolute Vision Online upgrade finished                          | EXPECTED     |
      | UPGRADE | APSolute Vision WEB upgrade finished                             | EXPECTED     |
      | UPGRADE | APSolute Vision Application upgrade finished                     | EXPECTED     |
      | UPGRADE | APSolute Vision System upgrade finished                          | EXPECTED     |
      | UPGRADE | APSolute Vision OS upgrade finished                              | EXPECTED     |
      | UPGRADE | ERROR                                                            | NOT_EXPECTED |
      | UPGRADE | error: package MySQL-                                            | IGNORE       |
      | UPGRADE | ic_logi_error.png                                                | IGNORE       |
      | UPGRADE | tree-error.png                                                   | IGNORE       |
      | LLS     | fatal\| error\|fail                                              | NOT_EXPECTED |
      | LLS     | Installation ended                                               | EXPECTED     |
      | LLS     | Setup complete!                                                  | EXPECTED     |
      | UPGRADE | Failed to parse /etc/cgconfig.conf                               | IGNORE       |


  @SID_5
  Scenario: Check firewall settings
    Then CLI Run linux Command "iptables -L -n |tail -1|awk -F" " '{print $1,$2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "REJECT all"
    Then CLI Run linux Command "iptables -L -n |grep tcp|grep dpt:5604" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    Then CLI Run linux Command "iptables -L -n |grep tcp|grep dpt:9200" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
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

  @SID_6
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

  @SID_7
  Scenario: Login with activation
#    Given REST Login with activation with user "sys_admin" and password "radware"
    Then UI Login with user "sys_admin" and password "radware"
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15

  @SID_26
  Scenario: Validate AVA Attack Capacity Grace Period License
    Then Validate License "ATTACK_CAPACITY_LICENSE" Parameters
      | allowedAttackCapacityGbps         | 0                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | requiredDevicesAttackCapacityGbps | 18                                                                                                                                                                                                                                                                                                                                                                                                                                                |
      | licensedDefenseProDeviceIpsList   | [172.16.22.50,172.16.22.51,172.16.22.55]                                                                                                                                                                                                                                                                                                                                                                                                          |
      | hasDemoLicense                    | false                                                                                                                                                                                                                                                                                                                                                                                                                                             |
      | attackCapacityMaxLicenseExist     | false                                                                                                                                                                                                                                                                                                                                                                                                                                             |
      | licenseViolated                   | true                                                                                                                                                                                                                                                                                                                                                                                                                                              |
      | inGracePeriod                     | true                                                                                                                                                                                                                                                                                                                                                                                                                                              |
      | message                           | License Violation: The attack capacity required by devices managed by APSolute Vision exceeds the value permitted by the APSolute Vision Analytics - AMS license. Contact Radware Technical Support to purchase another license with more capacity within 30 days. After 30 days, the system will only support the attack capacity corresponding to the license. If there is no APSolute Vision Analytics - AMS license, AVA will be unavailable. |
      | timeToExpiration                  | 30                                                                                                                                                                                                                                                                                                                                                                                                                                                |

    And Validate DefenseFlow is Licensed by Attack Capacity License
  @SID_8
  Scenario: Navigate to general settings page
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Basic Parameters"
    When UI Do Operation "select" item "Software"
    Then REST get Basic Parameters "lastUpgradeStatus"
    Then UI Validate Text field "Upgrade Status" EQUALS "OK"

  @SID_9
  Scenario: validate APM container is up and relevant services are running in it
    Then CLI Run linux Command "service vz status" on "ROOT_SERVER_CLI" and validate result EQUALS "OpenVZ is running..."
    Then CLI Run linux Command "vzctl exec 101 SPSERVER_INSTANCE=rad /usr/share/sharepath/server/sbin/spserver-initd.sh --action=status | grep "is running..." | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "6"

  @SID_10
  Scenario: Validate TED status
    Then CLI Run linux Command "echo $(mysql -prad123 vision_ng -N -B -e "select count(*) from vision_license where license_str like '%reporting-module-ADC%';")-$(netstat -nlt |grep 5140|wc -l)|bc" on "ROOT_SERVER_CLI" and validate result EQUALS "0"

  @SID_11
  Scenario: Create new Site
    Then UI Add new Site "Site After Upgrade" under Parent "Default"

  @SID_12
  Scenario: Add fake devices to tree
    Then REST Add "Alteon" Device To topology Tree with Name "FakeAlteon" and Management IP "4.4.4.4" into site "Default"
      | attribute | value |
    Then REST Add "DefensePro" Device To topology Tree with Name "FakeDP" and Management IP "4.4.4.5" into site "Default"
      | attribute | value |

  @SID_13
  Scenario: validate Edit Threshold script exist in vision
    Then CLI Run linux Command "ll /opt/radware/storage/vdirect/database/templates/adjust_profile_v2.vm |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "ll /opt/radware/ConfigurationTemplatesRepository/actionable/adjust_profile_v2.vm |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_14
  Scenario: Import driver script and jar file
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.2.1.0-DD-1.00-110.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.4.0.0-DD-1.00-396.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"

  @SID_15
  Scenario: Upload Driver to vision
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.2.1.0-DD-1.00-110.jar" on "ROOT_SERVER_CLI" with timeOut 240
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.4.0.0-DD-1.00-396.jar" on "ROOT_SERVER_CLI" with timeOut 240

  @SID_16
  Scenario: Visit device subscription page
    Then REST Request "GET" for "Device Subscriptions->Table"
      | type                 | value |
      | Returned status code | 200   |

  @SID_17
  Scenario: Delete fake devices from tree
    Then Sleep "20"
    Then REST Delete Device By IP "4.4.4.4"
    Then REST Delete Device By IP "4.4.4.5"

  @SID_18
  Scenario: Logout and Close
    Given UI logout and close browser

  @SID_19
  Scenario: Validate MySql version
    Then CLI Run linux Command "mysql -prad123 --version|awk '{print$5}'" on "ROOT_SERVER_CLI" and validate result EQUALS "10.4.6-MariaDB,"

  @SID_20
  Scenario: Validate vdirect listener
    Then CLI Run linux Command "netstat -nlt |grep 2188|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2188"
    Then CLI Run linux Command "netstat -nlt |grep 2189|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2189"
    Then CLI Run remote linux Command "curl -ks -o null -XGET https://localhost6:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"
    Then CLI Run remote linux Command "curl -ks -o null -XGET https://localhost4:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"

  @SID_21
  Scenario: Validate LLS service is up
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='16';"" on "ROOT_SERVER_CLI"
#TODO
    #remove this in version GT 4.10
    When CLI Operations - Run Radware Session command "system lls service start"
    When CLI Operations - Run Radware Session command "y" timeout 180
    Then Sleep "120"

    Then CLI Run remote linux Command "curl -ks -o null -XGET http://localhost4:7070/api/1.0/hostids -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"
    Then CLI Run remote linux Command "curl -ks -o null -XGET http://localhost6:7070/api/1.0/hostids -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"
      #rollback to the original values
    Given CLI Run remote linux Command "mysql -prad123 vision_ng -e "update lls_server set min_required_ram='32';"" on "ROOT_SERVER_CLI"
    When CLI Operations - Run Radware Session command "system lls service stop"
    When CLI Operations - Run Radware Session command "y" timeout 180

  @SID_22
  Scenario: Validate LLS version
    Then CLI Run linux Command "cat /opt/radware/storage/llsinstall/license-server-*/version.txt" on "ROOT_SERVER_CLI" and validate result EQUALS "2.2.0-6"

  @SID_23
  Scenario: Validate IPv6 Hostname in /etc/hosts
    Then CLI Run linux Command "if [ "$(hostname | cut -d'.' -f 1)" == "$(grep "::1" /etc/hosts|head -1|awk '{print$6}')" ]; then echo "hostname ok"; else echo "hostname not ok"; fi" on "ROOT_SERVER_CLI" and validate result EQUALS "hostname ok"
    Then CLI Run linux Command "grep "::1" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_24
  Scenario: Validate IPv4 Hostname in /etc/hosts
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep "$(hostname | cut -d'.' -f 1)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_25
  Scenario: Verify number of tables in vision schema
    Then CLI Run linux Command "mysql -prad123 -NB -e "select count(*) from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='vision';"" on "ROOT_SERVER_CLI" and validate result EQUALS "90"

  @SID_26
  Scenario: Verify number of tables in vision_ng schema
    Then CLI Run linux Command "mysql -prad123 -NB -e "select count(*) from INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='vision_ng';"" on "ROOT_SERVER_CLI" and validate result EQUALS "166"
