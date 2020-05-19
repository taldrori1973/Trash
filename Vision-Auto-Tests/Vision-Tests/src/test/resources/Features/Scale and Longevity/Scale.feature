#@
Feature: Scale Test

  @SID_1
  Scenario: verify vision_install logs
    Then CLI Check if logs contains
      | logType        | expression | isExpected   |
      | VISION_INSTALL | fatal      | NOT_EXPECTED |
      | VISION_INSTALL | error      | NOT_EXPECTED |


  @SID_2
  Scenario: Validate iptables settings
    Then CLI Run linux Command "iptables -n -L RH-Firewall-1-INPUT|grep "ACCEPT "|wc -l" on "ROOT_SERVER_CLI" and validate result LTE "27"
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


  @SID_3
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

  @SID_4
  Scenario: Validate TED status
    Then CLI Run linux Command "echo $(mysql -prad123 vision_ng -N -B -e "select count(*) from vision_license where license_str like '%reporting-module-ADC%';")-$(netstat -nlt |grep 5140|wc -l)|bc" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then CLI Run linux Command "curl -ks -o null -w 'RESP_CODE:%{response_code}\n' -XGET https://localhost:443/ted/api/data" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200"

  @SID_5
  Scenario: validate Edit Threshold script exist in vision
    Then CLI Run linux Command "ll /opt/radware/storage/vdirect/database/templates/adjust_profile_v2.vm |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "ll /opt/radware/ConfigurationTemplatesRepository/actionable/adjust_profile_v2.vm |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_6
  Scenario: validate available disk space
    Then CLI Run linux Command "df -hP /opt/radware/storage|tail -1|awk -F" " '{print $5}'|awk -F"%" '{print $1}'" on "ROOT_SERVER_CLI" and validate result LTE "6"
    Then CLI Run linux Command "df -hP /opt/radware|tail -1|awk -F" " '{print $5}'|awk -F"%" '{print $1}'" on "ROOT_SERVER_CLI" and validate result LTE "30"
    Then CLI Run remote linux Command "df -hP /|tail -1|awk '{print $5}'|grep -oP '[\d]*'" on "ROOT_SERVER_CLI"
    Then CLI Run linux Command "echo $(df /|tail -1|awk '{print $3}')/$(df /|tail -1|awk '{print $2}')*100|bc -l|grep -oP '^\d*'" on "ROOT_SERVER_CLI" and validate result LTE "45"
    Then Sleep "2"
    Then CLI Run linux Command "df -hP /vz/private|tail -1|awk -F" " '{print $5}'|awk -F"%" '{print $1}'" on "ROOT_SERVER_CLI" and validate result LTE "15"


  @SID_7
  Scenario: Validate vdirect listener
    Then CLI Run linux Command "netstat -nlt |grep 2188|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2188"
    Then CLI Run linux Command "netstat -nlt |grep 2189|awk '{print$4}'" on "ROOT_SERVER_CLI" and validate result EQUALS ":::2189"
    Then CLI Run linux Command "curl -ks -o null -XGET https://localhost6:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200"
    Then CLI Run linux Command "curl -ks -o null -XGET https://localhost4:2189 -w 'RESP_CODE:%{response_code}\n'" on "ROOT_SERVER_CLI" and validate result EQUALS "RESP_CODE:200"

  @SID_8
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
    Then CLI Run linux Command "service vz status" on "ROOT_SERVER_CLI" and validate result EQUALS "OpenVZ is running..."


