@TC111675
Feature: CLI System Hostname

  @SID_1
  Scenario: System hostname set cancel
    Given CLI Reset radware password
    #wait after reset password
    And Sleep "3"
    And REST Login with activation with user "radware" and password "radware"
    And CLI Operations - Run Radware Session command "system hostname set myserver.auto"
    And CLI Operations - Run Radware Session command "n"
    Then CLI Operations - Verify that output contains regex "Updating the hostname cancelled."

  @SID_2
  Scenario: system hostname set myserver.local
    When CLI Operations - Run Radware Session command "system hostname set myserver.auto"
    When CLI Operations - Run Radware Session command "y" timeout 120
    When CLI Operations - Run Radware Session command "n" timeout 720

  @SID_3
  Scenario: Validate IPv6 Hostname in /etc/hosts
    Then CLI Run linux Command " if [ "$(hostname)" == "$(grep "::1" /etc/hosts|head -3| grep -v ip6 |awk '{print$3}')" ]; then echo "hostname ok"; else echo "hostname not ok"; fi" on "ROOT_SERVER_CLI" and validate result EQUALS "hostname ok"
    Then CLI Run linux Command "grep "::1" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result GTE "1"

  @SID_4
  Scenario: Validate IPv4 Hostname in /etc/hosts
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep "$(hostname | cut -d'.' -f 1)"|wc -l" on "ROOT_SERVER_CLI" and validate result GTE "1"
    Then CLI Run linux Command "grep "$(hostname -i|awk '{print$2}')" /etc/hosts|grep " $(hostname)"|wc -l" on "ROOT_SERVER_CLI" and validate result GTE "1"

  @SID_5
  Scenario: system hostname get
    When CLI Operations - Run Radware Session command "system hostname get"
    Then CLI Operations - Verify that output contains regex "myserver.auto"

  @SID_6
  Scenario: Verify services are running
    When CLI validate service "all" status is "up" and health is "healthy" retry for 600 seconds



