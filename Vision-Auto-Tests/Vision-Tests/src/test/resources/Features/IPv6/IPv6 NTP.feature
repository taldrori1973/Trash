@Debug @TC108784
Feature: IPv6 CLI - NTP test

  @SID_1
  Scenario: NTP servers cleanup
    Then CLI Run remote linux Command "sed -i '/^server/d' /etc/ntp.conf" on "ROOT_SERVER_CLI"

  @SID_2
  Scenario: Add NTP server IPv6
        # Add ntp server and verify IP
    Then CLI Operations - Run Radware Session command "system ntp servers add 200a:1001:1001:1001:1001:1001:aaaa:3333"
    Then CLI Operations - Run Radware Session command "y"
    Then CLI Run linux Command "system ntp servers get" on "RADWARE_SERVER_CLI" and validate result CONTAINS "server 200a:1001:1001:1001:1001:1001:aaaa:3333"

  @SID_3
  Scenario: Delete NTP server IPv6
    # change ntp server and verify IP and remove the old one
    Then CLI Operations - Run Radware Session command "system ntp servers add 200a::1001:1001:1001:1001"
    Then CLI Operations - Run Radware Session command "y"
    Then CLI Operations - Run Radware Session command "system ntp servers delete 200a:1001:1001:1001:1001:1001:aaaa:3333"
    Then CLI Operations - Run Radware Session command "y"

  @SID_4
  Scenario: Verify NTP server was deleted
    Then CLI Run linux Command "grep "server 200a:1001:1001:1001:1001:1001:aaaa:3333" /etc/ntp.conf|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"

  @SID_5
  Scenario: Verify NTP server IPv6 is synchonized
    # verify NTP is sync
    #Then Sleep "60"
    Then CLI Run linux Command "system ntp service status" on "RADWARE_SERVER_CLI" and validate result CONTAINS "200a::1001:1001" in any line Retry 900 seconds
    Then CLI Operations - Run Root Session command "pwd"
    Then CLI Run linux Command "ntpstat|tail -0;echo $?" on "ROOT_SERVER_CLI" and validate result EQUALS "0" Retry 600 seconds

  @SID_6
  Scenario: Delete NTP server IPv6
    Then CLI Connect Radware
    Then CLI Operations - Run Radware Session command "system ntp servers delete 200a::1001:1001:1001:1001"
    Then CLI Operations - Run Radware Session command "y"

  @SID_7
  Scenario: Verify NTP service stopped when all servers are deleted
    Then CLI Run linux Command "system ntp service status" on "RADWARE_SERVER_CLI" and validate result EQUALS "NTP service is stopped"
    Then CLI Run linux Command "systemctl status ntp | grep Active:" on "ROOT_SERVER_CLI" and validate result CONTAINS "inactive"


