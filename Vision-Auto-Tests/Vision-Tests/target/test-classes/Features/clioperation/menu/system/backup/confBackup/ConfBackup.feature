@CLI_Positive @TC106032

Feature: System ConfBackup Functional Tests


  @SID_1
  Scenario: system confBackup menu
    Then CLI System Conf Backup Sub Menu


  @SID_2
  Scenario: system confBackup save
    Then CLI Conf Backup Save Test

  @SID_3
  Scenario: system confBackup info
    Then CLI Conf Backup Info

  @SID_4
  Scenario: system confBackup list
    Then CLI System Conf Backup List

  @SID_5
  Scenario: system confBackup export ftp
    Then CLI Verify System ConfBackup Export "ftp" Protocol


  @SID_6
  Scenario: system confBackup export sftp
    Then CLI Verify System ConfBackup Export "sftp" Protocol

  @SID_6
  Scenario: system confBackup export ssh
    Then CLI Verify System ConfBackup Export "ssh" Protocol

  @SID_7
  Scenario: system confBackup export scp
    Then CLI Verify System ConfBackup Export "scp" Protocol


  @SID_8
  Scenario: system confBackup export file
    Then CLI System ConfBackup Export File

  @SID_9
  Scenario: system confBackup create
    Then CLI Verify System Conf Backup Create

  @SID_10
  Scenario: system confBackup restore
    Then CLI Verify System Conf Backup Restore

  @SID_11
  Scenario: system confBackup delete
    Then CLI Verify System conf Backup Delete

  @SID_12
  Scenario: system confBackup import ftp
    Then CLI Verify System Conf Backup Import "ftp" Protocol

  @SID_13
  Scenario: system confBackup import sftp
    Then CLI Verify System Conf Backup Import "sftp" Protocol

  @SID_14
  Scenario: system confBackup import ssh
    Then CLI Verify System Conf Backup Import "ssh" Protocol

  @SID_15
  Scenario: system confBackup import scp
    Then CLI Verify System Conf Backup Import "scp" Protocol

  @SID_16
  Scenario: system confBackup functional tests
    Then CLI Verify System Conf Backup Import File





