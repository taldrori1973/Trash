@TC108472
Feature: IPv6 CLI - IP DNS ROUTE

  @SID_1
  Scenario: IPv6 Clear and Set address on G3
    Given CLI Operations - Run Radware Session command "net ip delete G3"
    Then CLI Operations - Run Radware Session command "y" timeout 20
    Given CLI Operations - Run Radware Session command "net ip set 200a:0000:0000:0000:1001:1001:bbbb:3333 64 G3"

  @SID_2
  Scenario: IPv6 Set primary DNS server
    Given CLI Operations - Run Radware Session command "net dns set primary 200a::1001:1001:1001:1001"
  @SID_3
  Scenario: IPv6 verify DNS resolution 
  Then CLI Run linux Command "ping -c1 host1.vision6.local |head -1 |awk -F"(" '{printf $2}'|awk -F")" '{printf $1"\n"}'" on "ROOT_SERVER_CLI" and validate result EQUALS "172.17.11.11"
    Then CLI Run remote linux Command "ifconfig > /tmp/ifconfig.txt" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario: IPv6 Edit primary DNS to bad server
    Given CLI Operations - Run Radware Session command "net dns set primary 200a:0000:0000:0000:1001:1001:2002:2002"

  @SID_5
  Scenario: IPv6 verify DNS resolution
    Then CLI Run linux Command "ping -c1 host1.vision6.local |head -1 |awk -F"(" '{printf $2}'|awk -F")" '{printf $1"\n"}'" on "ROOT_SERVER_CLI" and validate result CONTAINS "unknown host host1.vision6.local"

  @SID_6
  Scenario: Set primary DNS server back to IPv4
    Given CLI Operations - Run Radware Session command "net dns set primary 10.221.1.47"
    Given CLI Operations - Run Radware Session command "net dns set tertiary 200a:0000:0000:0000:1001:1001:1001:1001"


  @SID_7
  Scenario: IPv6 verify No route to remote IPv6 address
    Given CLI Operations - Run Radware Session command "net route delete 3005:1001:1001:1001:1001:1001:1001:1001 128 200a::1001:1001:1001:1001"
#    Then CLI Run linux Command "timeout 5 tracepath6 3005:1001:1001:1001:1001:1001:1001:1001" on "ROOT_SERVER_CLI" and validate result CONTAINS "Network is unreachable"

  @SID_8
  Scenario: IPv6 Add route to remote IPv6 address and verify ping
    Given CLI Operations - Run Radware Session command "net route set host 3005:1001:1001:1001:1001:1001:1001:1001 200a::1001:1001:1001:1001"
    Then CLI Run linux Command "ping6 -c1 3005:1001:1001:1001:1001:1001:1001:1001 |head -2|tail -1" on "ROOT_SERVER_CLI" and validate result CONTAINS "64 bytes from 3005:1001:1001:1001:1001:1001:1001:1001"
    Then CLI Run linux Command "ping6 -c1 3005:1001:1001:1001:1001:1001:1001:1001 |head -5|tail -1" on "ROOT_SERVER_CLI" and validate result CONTAINS "0% packet loss"

  @SID_9
  Scenario: reboot and verify settings are kept
#    Given CLI Operations - Run Radware Session command "reboot"
#    Then CLI Operations - Run Radware Session command "y"
    Then CLI Operations - Run Root Session command "reboot"
    Then Sleep "240"
    Then CLI Connect Root
    Then CLI Run linux Command "cat /etc/resolv.conf" on "ROOT_SERVER_CLI" and validate result CONTAINS "nameserver 200a:0000:0000:0000:1001:1001:1001:1001" in any line
    Then CLI Run linux Command "/sbin/ip -6 route show |grep 3005" on "ROOT_SERVER_CLI" and validate result CONTAINS "3005:1001:1001:1001:1001:1001:1001:1001 via 200a::1001:1001:1001:1001 dev G3"

  @SID_10
  Scenario: IPv6 Delete route to remote IPv6 address
    Then CLI Connect Radware
    Given CLI Operations - Run Radware Session command "net route delete 3005:1001:1001:1001:1001:1001:1001:1001 128 200a::1001:1001:1001:1001"
    Then CLI Run linux Command "ping6 -w2 -q 3005:1001:1001:1001:1001:1001:1001:1001" on "ROOT_SERVER_CLI" and validate result CONTAINS "Network is unreachable"

  @SID_11
  Scenario: IPv6 Clear IPv6 address on G3
    Given CLI Operations - Run Radware Session command "net ip delete G3"
    Then CLI Operations - Run Radware Session command "y" timeout 20
