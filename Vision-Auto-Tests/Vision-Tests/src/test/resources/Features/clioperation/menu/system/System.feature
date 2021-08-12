@CLI_Positive @TC106038
Feature: System Tests

  @SID_1
  Scenario: Verifying sub menu of system cmd
    Then CLI System Sub Menu Test
#####################################################################################################################
  @SID_2
  Scenario: Cli System help
    When CLI Operations - Run Radware Session command "system ?"
    Then CLI Operations - Verify that output contains regex ".*System parameters..*"
    Then CLI Operations - Verify that output contains regex ".*apm.*Manages APM..*"
    Then CLI Operations - Verify that output contains regex ".*audit-log.*Audit log settings..*"
    Then CLI Operations - Verify that output contains regex ".*backup.*Manages system backup..*"
    Then CLI Operations - Verify that output contains regex ".*cleanup.*APSolute Vision server data-cleanup commands..*"
    Then CLI Operations - Verify that output contains regex ".*config-sync.*Manages configuration synchronization..*"
    Then CLI Operations - Verify that output contains regex ".*database.*Database commands..*"
    Then CLI Operations - Verify that output contains regex ".*date.*Date settings..*"
    Then CLI Operations - Verify that output contains regex ".*df.*Manages DefenseFlow..*"
    Then CLI Operations - Verify that output contains regex ".*dpm.*Manages the Device Performance Monitor..*"
    Then CLI Operations - Verify that output contains regex ".*exporter.*Events exporter configuration..*"
    Then CLI Operations - Verify that output contains regex ".*hardware.*Displays the system hardware..*"
    Then CLI Operations - Verify that output contains regex ".*hostname.*Hostname settings..*"
    Then CLI Operations - Verify that output contains regex ".*java.*Java settings..*"
    Then CLI Operations - Verify that output contains regex ".*ntp.*Network Time Protocol settings..*"
    Then CLI Operations - Verify that output contains regex ".*package.*Lists the packages used by APSolute Vision..*"
    Then CLI Operations - Verify that output contains regex ".*snmp.*Simple Network Management Protocol settings..*"
    Then CLI Operations - Verify that output contains regex ".*ssl.*Manages SSL..*"
    Then CLI Operations - Verify that output contains regex ".*statistics.*Displays system resources statistics..*"
    Then CLI Operations - Verify that output contains regex ".*storage.*Manages system storage..*"
    Then CLI Operations - Verify that output contains regex ".*tcpdump.*Generate a network traffic capture..*"
    Then CLI Operations - Verify that output contains regex ".*terminal.*Terminal settings..*"
    Then CLI Operations - Verify that output contains regex ".*timezone.*Timezone settings..*"
    Then CLI Operations - Verify that output contains regex ".*upgrade.*Run system upgrade.*"
    Then CLI Operations - Verify that output contains regex ".*user.*Manages user settings..*"
    Then CLI Operations - Verify that output contains regex ".*version.*Shows software versions..*"
    Then CLI Operations - Verify that output contains regex ".*vision-server.*Starts/stops the APSolute Vision server..*"
    Then CLI Operations - Verify that output contains regex ".*vrm.*Manages the VRM..*"






