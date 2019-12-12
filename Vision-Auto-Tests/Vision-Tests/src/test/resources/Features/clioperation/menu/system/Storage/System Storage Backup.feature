@TC111676
Feature: CLI System Storage Backup

  @SID_1
  Scenario: System Storage menu
    When CLI Operations - Run Radware Session command "system storage ?"
    Then CLI Operations - Verify that output contains regex "Generic command to manage storage locations."
    Then CLI Operations - Verify that output contains regex "backup.*Sets the location of the backup files."

  @SID_2
  Scenario: System Storage backup menu
    When CLI Operations - Run Radware Session command "system storage backup ?"
    Then CLI Operations - Verify that output contains regex "Sets the location of the backup files."
    Then CLI Operations - Verify that output contains regex "The location can be either a hardcoded local location or a specified remote location."
    Then CLI Operations - Verify that output contains regex "info.*Lists the location of the backup files."
    Then CLI Operations - Verify that output contains regex "local.*Saves the backups to the hardcoded local directory."
    Then CLI Operations - Verify that output contains regex "local.*Saves the backups to the hardcoded local directory."

  @SID_3
  Scenario: System Storage backup info menu
    When CLI Operations - Run Radware Session command "system storage backup info ?"
    Then CLI Operations - Verify that output contains regex "Usage: system storage backup info"
    Then CLI Operations - Verify that output contains regex "Lists the location of the backup files."

  @SID_4
  Scenario: System Storage backup local menu
    When CLI Operations - Run Radware Session command "system storage backup local ?"
    Then CLI Operations - Verify that output contains regex "Usage: system storage backup local"
    Then CLI Operations - Verify that output contains regex "Saves the backups to the hardcoded local directory."

  @SID_5
  Scenario: System Storage backup remote menu
    When CLI Operations - Run Radware Session command "system storage backup remote ?"
    Then CLI Operations - Verify that output contains regex "Usage: system storage backup remote <protocol://server:/path/to/store>"
    Then CLI Operations - Verify that output contains regex ".*Saves the backups to a remote directory using either NFS or CIFS.*"
    Then CLI Operations - Verify that output contains regex "Supported patterns:"
    Then CLI Operations - Verify that output contains regex ".*nfs://server:/path/to/store"
    Then CLI Operations - Verify that output contains regex ".*cifs://server:/path/to/store"

  @SID_6
  Scenario: System Storage Backup remote NFS
    When CLI Operations - Run Radware Session command "system storage backup remote nfs://172.17.164.10:/mnt/shared" timeout 120
    Then CLI Operations - Verify that output contains regex "Setting backup to remote storage.*[  OK  ]"
    When CLI Operations - Run Radware Session command "system storage backup info" timeout 30
    Then CLI Operations - Verify that output contains regex "The server is configured to save the backup data to the remote directory nfs://172.17.164.10:/mnt/shared."

  @SID_7
  Scenario: Verify backup is saved remotely
    When CLI Run remote linux Command "rm -rf /mnt/shared/test.txt" on "GENERIC_LINUX_SERVER"
    When CLI Run remote linux Command "touch /opt/radware/external/backup/test.txt" on "ROOT_SERVER_CLI"
    Then CLI Run linux Command "[ -f /mnt/shared/test.txt ] && echo "test.txt exists" || echo "test.txt not exists"" on "GENERIC_LINUX_SERVER" and validate result EQUALS "test.txt exists"

  @SID_8
  Scenario: System Storage Backup local
    When CLI Operations - Run Radware Session command "system storage backup local" timeout 180
    When CLI Operations - Run Radware Session command "system storage backup info" timeout 30
    Then CLI Operations - Verify that output contains regex "The server is configured to save the backup data to the local directory."

  @SID_9
  Scenario: Verify backup is saved locally
    When CLI Run remote linux Command "rm -f /opt/radware/storage/backup/text.txt" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "touch /opt/radware/storage/backup/test.txt" on "ROOT_SERVER_CLI"
    Then CLI Run linux Command "[ -f /opt/radware/storage/backup/test.txt ] && echo "test.txt exists" || echo "test.txt not exists"" on "ROOT_SERVER_CLI" and validate result EQUALS "test.txt exists"
