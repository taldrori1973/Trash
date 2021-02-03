@TC111696
Feature: CLI System Database Maintenance

  @SID_1
  Scenario: system database maintenance menu
    Given CLI Reset radware password
    Then REST Login with activation with user "radware" and password "radware"
    When CLI Operations - Run Radware Session command "system database maintenance ?"
    Then CLI Operations - Verify that output contains regex ".*check.*Checks whether the database needs optimization.*"
    Then CLI Operations - Verify that output contains regex ".*driver_table( |\t)+Database maintenance commands for the driver_table.*"
    Then CLI Operations - Verify that output contains regex ".*optimize( |\t)+Optimizes the relevant tables.*"

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
    When CLI Operations - Run Radware Session command "system database maintenance driver_table ?"
    Then CLI Operations - Verify that output contains regex ".*Database maintenance commands for the driver_table.*"
    Then CLI Operations - Verify that output contains regex ".*delete( |\t)+Deletes all device drivers from the system.*"

  @SID_5
  Scenario: system database maintenance driver_table delete menu
    When CLI Operations - Run Radware Session command "system database maintenance driver_table delete ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: system database maintenance driver_table delete Deletes all device drivers from the system.*"
    Then CLI Operations - Verify that output contains regex ".*Stops the server. Deletes all device drivers from the system. Starts the server.*"

  @SID_6
  Scenario: Load a device driver into database
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_driver where device_version like "%6.14.%";"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "service vision restart" on "ROOT_SERVER_CLI" and wait 120 seconds

    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/DefensePro-6.14.03-DD-1.00-28.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"

    Then CLI Run linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/DefensePro-6.14.03-DD-1.00-28.jar" on "ROOT_SERVER_CLI" and validate result CONTAINS "Upload of device driver succeeded" Wait For Prompt 90 seconds

  @SID_7
  Scenario: verify the driver is in database
    Then CLI Run linux Command "mysql -prad123 vision_ng -N -B -e "select driver_name from device_driver where driver_name like '%6.14.03%';"" on "ROOT_SERVER_CLI" and validate result EQUALS "DefensePro-6.14.03-DD-1.00-28.jar"

  @SID_8
  Scenario: system database maintenance driver_table delete cancel
    When CLI Operations - Run Radware Session command "system database maintenance driver_table delete"
    When CLI Operations - Run Radware Session command "n"

  @SID_9
  Scenario: system database maintenance driver_table delete
    When CLI Operations - Run Radware Session command "system database maintenance driver_table delete"
    When CLI Operations - Run Radware Session command "y" timeout 360

  @SID_10
  Scenario: verify the driver is not in database
    Then CLI Run linux Command "mysql -prad123 vision_ng -N -B -e "select driver_name from device_driver where driver_name like '%6.14.03%';"|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"

  @SID_11
  Scenario: Verify services are running
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "APSolute Vision Reporter is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "AMQP service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Configuration server is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Collector service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "New Reporter service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Alerts service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Scheduler service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Configuration Synchronization service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Tor feed service is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Radware vDirect is running" in any line Retry 600 seconds
    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "VRM reporting engine is running" in any line Retry 600 seconds
