@TC110243
Feature: Upload Device Driver

  @Sanity
  @SID_1
  Scenario: Import script and jar file
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.2.1.0-DD-1.00-110.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"

  @Sanity
  @SID_2
  Scenario: Upload Driver to vision
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.2.1.0-DD-1.00-110.jar" on "ROOT_SERVER_CLI" with timeOut 240

  @Sanity
  @SID_3
  Scenario: REST update all drivers to latest
    Given CLI Reset radware password
    Then REST Request "PUT" for "Device Driver->Update Latest All"
      | type | value |
