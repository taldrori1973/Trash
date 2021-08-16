
Feature: Edit snmp1


  @SID_1
  Scenario:A

    Given That Current Vision is Logged In

    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get device name"
      | managedElementID | $.children[0].meIdentifier.managedElementID |
      | snmpVersion      | $.children[0].snmpVersion                   |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Update SNMP Write Community"
    And The Request Body is the following Object
      | jsonPath                                      | value                 |
      | ormID                                         | "${managedElementID}" |
      | deviceSetup.deviceAccess.snmpVersion          | "SNMP_V1"             |
    When Send Request with the Given Specification

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get device information"
    And The Request Path Parameters Are
      | id | ${managedElementID} |
    When Send Request with the Given Specification

    Then Validate That Response Body Contains
      | jsonPath                                        | value     |
      | $.deviceSetup.deviceAccess.snmpVersion          | "SNMP_V1" |
      | $.deviceSetup.deviceAccess.snmpV1WriteCommunity | "public"  |




    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Update SNMP Write Community"
    And The Request Body is the following Object
      | jsonPath                                      | value                 |
      | ormID                                         | "${managedElementID}" |
      | deviceSetup.deviceAccess.snmpV1WriteCommunity | "publicnew"           |
    When Send Request with the Given Specification

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get device information"
    And The Request Path Parameters Are
      | id | ${managedElementID} |
    When Send Request with the Given Specification

    Then Validate That Response Body Contains
      | jsonPath                                        | value       |
      | $.deviceSetup.deviceAccess.snmpVersion          | "SNMP_V1"   |
      | $.deviceSetup.deviceAccess.snmpV1WriteCommunity | "publicnew" |





    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Update SNMP Write Community"
    And The Request Body is the following Object
      | jsonPath                                      | value                 |
      | ormID                                         | "${managedElementID}" |
      | deviceSetup.deviceAccess.snmpVersion          | "${snmpVersion}"      |
      | $.deviceSetup.deviceAccess.snmpV1WriteCommunity | "public" |
    When Send Request with the Given Specification

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get device information"
    And The Request Path Parameters Are
      | id | ${managedElementID} |
    When Send Request with the Given Specification

    Then Validate That Response Body Contains
      | jsonPath                                        | value     |
      | $.deviceSetup.deviceAccess.snmpVersion          | "${snmpVersion}" |
      | $.deviceSetup.deviceAccess.snmpV1WriteCommunity | "public"  |
