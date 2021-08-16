@TC111696
Feature: CLI System Database Maintenance

  @SID_1
  Scenario: system database maintenance menu
    Given CLI Reset radware password
    When CLI System Database Maintenance Sub Menu Test


  @SID_2
  Scenario: system database maintenance check menu
    When CLI Operations - Run Radware Session command "system database maintenance check ?"
    Then CLI Operations - Verify that output contains regex ".*Checks whether the database needs optimization.*"

  @SID_3
  Scenario: system database maintenance optimize menu
    When CLI Operations - Run Radware Session command "system database maintenance optimize ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: system database maintenance optimize.*"
    Then CLI Operations - Verify that output contains regex ".*Optimizes the relevant tables.*"

  @SID_4
  Scenario: system database maintenance driver_table menu
    When CLI System Database Maintenance Driver Table Sub Menu Test

  @SID_5
  Scenario: system database maintenance driver_table delete menu
    When CLI Operations - Run Radware Session command "system database maintenance driver_table delete ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: system database maintenance driver_table delete Deletes all device drivers from the system.*"
    Then CLI Operations - Verify that output contains regex ".*Stops the server. Deletes all device drivers from the system. Starts the server.*"

  @SID_6
  Scenario: Load a device driver into database
    Then Clear Radware Session
    Then MYSQL DELETE FROM "device_driver" Table in "vision_ng" Schema WHERE "device_version like '%6.14.%'"
    Then CLI Server Stop
    Then CLI Server Start
    When CLI validate service "all" status is "up" and health is "healthy" retry for 600 seconds
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/DefensePro-6.14.03-DD-1.00-28.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"

    Then CLI Run linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/DefensePro-6.14.03-DD-1.00-28.jar" on "ROOT_SERVER_CLI" and validate result CONTAINS "Upload of device driver succeeded" Wait For Prompt 90 seconds

  @SID_7
  Scenario: verify the driver is in database
    When MYSQL Validate Single Value by SELECT "driver_name" Column FROM "vision_ng" Schema and "device_driver" Table WHERE "driver_name like '%6.14.03%'" EQUALS "DefensePro-6.14.03-DD-1.00-28.jar"

  @SID_8
  Scenario: system database maintenance driver_table delete
    When CLI System Database Maintenance Driver Table Delete Test

  @SID_9
  Scenario: Verify services are running
    When CLI validate service "all" status is "up" and health is "healthy" retry for 600 seconds

  @SID_10
  Scenario: verify the driver is not in database
    Then MYSQL Validate Number of Records FROM "device_driver" Table in "vision_ng" Schema WHERE "driver_name like '%6.14.03%'" Condition Applies EQUALS 0 Retry 10 seconds


