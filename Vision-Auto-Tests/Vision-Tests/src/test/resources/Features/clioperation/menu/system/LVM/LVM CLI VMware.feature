@TC111448
Feature: LVM CLI VMware

  @SID_1
  Scenario: Check current storage partition size
    When CLI Run linux Command "df -P /opt/radware/storage |tail -1|awk '{print$2}'" on "ROOT_SERVER_CLI" and validate result LTE "245000000"

  @SID_2
  Scenario: Run LVM script quit
    When CLI Run remote linux Command "printf 'quit\n' |/opt/radware/box/bin/system_storage_lvm.sh" on "ROOT_SERVER_CLI" with timeOut 30
    When CLI Run linux Command "df -P /opt/radware/storage |tail -1|awk '{print$2}'" on "ROOT_SERVER_CLI" and validate result LTE "245000000"

  @SID_3
  Scenario: Run LVM script default
    When CLI Run remote linux Command "printf 'default\n' |/opt/radware/box/bin/system_storage_lvm.sh" on "ROOT_SERVER_CLI" with timeOut 120

  @SID_4
  Scenario: verify storage partition size increased by 20GB
    When CLI Run linux Command "df -P /opt/radware/storage |tail -1|awk '{print$2}'" on "ROOT_SERVER_CLI" and validate result GTE "200000000"

  @SID_5
  Scenario: reboot
    Then CLI Operations - Run Root Session command "service mysql stop" timeout 30
    Then CLI Operations - Run Root Session command "service elasticsearch stop" timeout 30
    Then CLI Operations - Run Root Session command "reboot"
    Then Sleep "720"
    Then CLI Connect Root

  @SID_6
  Scenario: verify storage partition size
    When CLI Run linux Command "df -P /opt/radware/storage |tail -1|awk '{print$2}'" on "ROOT_SERVER_CLI" and validate result GTE "200000000"

  @SID_7
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
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "VRM reporting engine is running" in any line with timeOut 300
