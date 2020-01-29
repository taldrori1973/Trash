
@TC109510
Feature: Create DP v3 user using vdirect template
  @SID_1
  Scenario: Login and Sync devices with vdirect
    Then CLI Clear vision logs
    Given REST Login with user "sys_admin" and password "radware"
    Then REST Request "POST" for "Vdirect->Sync Devices"
      | type                 | value |
      | Returned status code | 200   |

  @SID_2
  Scenario: Delete V3 user from DefensePro configuration
    Given REST Lock Action on "DefensePro" 11
    Then CLI Clear vision logs
    Given REST Request "DELETE" for "Edit DefensePro->Setup->Device Security->SNMP->Users"
      | type                 | value |
      | body                 | {}    |
      | Returned status code | 200   |

  @SID_3
  Scenario: Verify no errors in vdirect log
    Then Sleep "70"
    Then CLI Check if logs contains
      | logType | expression                     | isExpected   |
#      | VDIRECT | Configuration template DefensePro_Snmp_User_Delete.vm merged | EXPECTED     |
      | VDIRECT | fatal                          | NOT_EXPECTED |
      | VDIRECT | error                          | NOT_EXPECTED |
      | VDIRECT | SSH connection error to 50.50. | IGNORE       |
      | VDIRECT | ip=50.50.                      | IGNORE       |
      | VDIRECT | 172.17.154.190                 | IGNORE       |
      | VDIRECT | Could not update server report | IGNORE       |
      | VDIRECT | 172.17.154.200                 | IGNORE       |
      | VDIRECT | 172.17.160.1                   | IGNORE       |


    Then CLI Run linux Command "grep "Configuration template DefensePro_Snmp_User_Delete.vm merged" /opt/radware/storage/vdirect/server/logs/application/vdirect.log |wc -l" on "ROOT_SERVER_CLI" and validate result GTE "1"

  @SID_4
  Scenario: Create DefensePro SNMPv3 user
    Then CLI Clear vision logs
    When REST Request "POST" for "Edit DefensePro->Setup->Device Security->SNMP->Users"
      | type                 | value                         |
      | body                 | usmUserAuthKeyChange=12345678 |
      | body                 | usmUserPrivKeyChange=12345678 |
      | Returned status code | 200                           |

  @SID_5
  Scenario: Verify no errors in vdirect log
    Then Sleep "70"
    Then CLI Check if logs contains
      | logType | expression                     | isExpected   |
      | VDIRECT | fatal                          | NOT_EXPECTED |
      | VDIRECT | error                          | NOT_EXPECTED |
#      | VDIRECT | Configuration template DefensePro_Snmp_User_Create.vm merged | EXPECTED     |
      | VDIRECT | SSH connection error to 50.50. | IGNORE       |
      | VDIRECT | 172.17.154.190                 | IGNORE       |
      | VDIRECT | 172.17.154.200                 | IGNORE       |
      | VDIRECT | 172.17.160.1                   | IGNORE       |

    Then CLI Run linux Command "grep "Configuration template DefensePro_Snmp_User_Create.vm merged" /opt/radware/storage/vdirect/server/logs/application/vdirect.log |wc -l" on "ROOT_SERVER_CLI" and validate result GTE "1"


  @SID_6
  Scenario: Verify V3 exists in DefensePro configuration
    Then REST Request "GET" for "Edit DefensePro->Setup->Device Security->SNMP->Users"
      | type                 | value                            |
      | params               | filter=usmUserName:newuser       |
      | params               | filtertype=exact                 |
      | params               | filterRange=300                  |
      | result               | "usmUserSecurityName": "newuser" |
      | result               | "usmUserPrivProtocol": "2"       |
      | result               | "usmUserAuthProtocol": "3"       |
      | Returned status code | 200                              |

  @SID_7
  Scenario: Delete created user
    Then CLI Clear vision logs
    Given REST Request "DELETE" for "Edit DefensePro->Setup->Device Security->SNMP->Users"
      | type                 | value |
      | body                 | {}    |
      | Returned status code | 200   |
    Then REST Unlock Action on "DefensePro" 11

  @SID_8
  Scenario: Verify no errors in vdirect log
    Then Sleep "70"
    Then CLI Check if logs contains
      | logType | expression                     | isExpected   |
      | VDIRECT | fatal                          | NOT_EXPECTED |
      | VDIRECT | error                          | NOT_EXPECTED |
#      | VDIRECT | Configuration template DefensePro_Snmp_User_Delete.vm merged | EXPECTED     |
      | VDIRECT | Could not update server report | IGNORE       |
      | VDIRECT | SSH connection error to 50.50. | IGNORE       |
      | VDIRECT | 172.17.154.190                 | IGNORE       |
      | VDIRECT | 172.17.154.200                 | IGNORE       |
      | VDIRECT | 172.17.160.1                   | IGNORE       |

    Then CLI Run linux Command "grep "Configuration template DefensePro_Snmp_User_Delete.vm merged" /opt/radware/storage/vdirect/server/logs/application/vdirect.log |wc -l" on "ROOT_SERVER_CLI" and validate result GTE "1"

