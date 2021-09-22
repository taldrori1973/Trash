@CLI_Negative @TC106033 @Debug

Feature: System ConfBackup Negative Functional Tests

  @SID_1
  Scenario: system Conf Backup Create Negative Test
    Then CLI Conf Backup Create Negative Test

  @SID_2
  Scenario: system confBackup Delete Negative Test
    Then CLI Conf Backup Delete Negative Test

  @SID_3
  Scenario: system confBackup Export Protocol "ftp" Negative Test
    Then CLI Conf Backup Export Protocol "ftp" Negative Test

  @SID_4
  Scenario: system confBackup Export Protocol "sftp" Negative Test
    Then CLI Conf Backup Export Protocol "sftp" Negative Test

  @SID_5
  Scenario: system confBackup Export Protocol "ssh" Negative Test
    Then CLI Conf Backup Export Protocol "ssh" Negative Test

  @SID_6
  Scenario: system confBackup Export Protocol "scp" Negative Test
    And CLI Conf Backup Export Protocol "scp" Negative Test

  @SID_7
  Scenario: system confBackup Export File Negative Test
    Then CLI Conf Backup Export File Negative Test

  @SID_8
  Scenario: system confBackup Import Protocol "ftp" Negative Test
    Then CLI Conf Backup Import Protocol "ftp" Negative Test

  @SID_9
  Scenario: system confBackup Import Protocol "sftp" Negative Test
    Then CLI Conf Backup Import Protocol "sftp" Negative Test

  @SID_10
  Scenario: system confBackup Import Protocol "ssh" Negative Test
    Then CLI Conf Backup Import Protocol "ssh" Negative Test

  @SID_11
  Scenario: system confBackup Import Protocol "scp" Negative Test
    Then CLI Conf Backup Import Protocol "scp" Negative Test

  @SID_12
  Scenario: system confBackup Restore Negative Test
    Then CLI Conf Backup Restore Negative Test

  @SID_13
  Scenario: system confBackup Info Negative Test
    Then CLI Conf Backup Info Negative Test

  @SID_14
  Scenario: system confBackup negative tests
    Then CLI Conf Backup Negative Test

