
@TC112727
Feature: GET device details API

  @SID_1
  Scenario: set TACACS login
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"

  @SID_2
    Scenario: Add device and import script
    Then REST Login with user "radware" and password "radware"
    Then REST Add "Alteon" Device To topology Tree with Name "FakeAlteon" and Management IP "1.1.1.1" into site "Default"
      | attribute | value |

    Then CLI copy "/home/radware/Scripts/mask_password.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"

  @SID_3
  Scenario Outline: Validate API password in reply - ADC
    # results are number of "*****" masked fields. masked fields are snmpV3Username, snmpV3AuthenticationPassword, snmpV3PrivacyPassword, httpUsername, httpPassword, httpsUsername, httpsPassword, cliUsername, cliPassword
    Then CLI Run linux Command "/mask_password.sh <DeviceIP> <ROLE>" on "ROOT_SERVER_CLI" and validate result EQUALS "<RESULT>"

    Examples:
      | ROLE                               | DeviceIP | RESULT |
      | ADC_Certificate_Administrator_user | 1.1.1.1  | 9      |
      | ADC_Administrator_user             | 1.1.1.1  | 9      |
      | ADC_Operator_user                  | 1.1.1.1  | 9      |
      | Device_Administrator_user          | 1.1.1.1  | 0      |
      | Device_Configurator_user           | 1.1.1.1  | 9      |
      | Device_Operator_user               | 1.1.1.1  | 9      |
      | Device_Viewer_user                 | 1.1.1.1  | 9      |
      | Vision_Administrator_user          | 1.1.1.1  | 0      |
      | Vision_Reporter_user               | 1.1.1.1  | 9      |
      | SYSTEM_USER_user                   | 1.1.1.1  | 0      |
      | Certificate_Administrator_user     | 1.1.1.1  | 9      |
      | Real_Server_Operator_user          | 1.1.1.1  | 9      |
      | Security_Administrator_user        | 1.1.1.1  | 0      |
      | Security_Monitor_user              | 1.1.1.1  | 9      |
      | User_Administrator_user            | 1.1.1.1  | 9      |
      | sys_admin                          | 1.1.1.1  | 0      |

  @SID_4
  Scenario: Delete ADC device
    Then REST Login with user "radware" and password "radware"
    Then REST Delete Device By IP "1.1.1.1"
    Then Sleep "3"


  @SID_5
  Scenario: Add device DP
    Then REST Login with user "radware" and password "radware"
    Then REST Add "DefensePro" Device To topology Tree with Name "FakeDP" and Management IP "2.2.2.2" into site "Default"
      | attribute | value |

  @SID_6
  Scenario Outline: Validate API password in reply - DP
    # results are number of "*****" masked fields. masked fields are snmpV3Username, snmpV3AuthenticationPassword, snmpV3PrivacyPassword, httpUsername, httpPassword, httpsUsername, httpsPassword, cliUsername, cliPassword
    Then CLI Run linux Command "/mask_password.sh <DeviceIP> <ROLE>" on "ROOT_SERVER_CLI" and validate result EQUALS "<RESULT>"

    Examples:
      | ROLE                               | DeviceIP | RESULT |
      | ADC_Certificate_Administrator_user | 2.2.2.2  | 9      |
      | ADC_Administrator_user             | 2.2.2.2  | 9      |
      | ADC_Operator_user                  | 2.2.2.2  | 9      |
      | Device_Administrator_user          | 2.2.2.2  | 0      |
      | Device_Configurator_user           | 2.2.2.2  | 9      |
      | Device_Operator_user               | 2.2.2.2  | 9      |
      | Device_Viewer_user                 | 2.2.2.2  | 9      |
      | Vision_Administrator_user          | 2.2.2.2  | 0      |
      | Vision_Reporter_user               | 2.2.2.2  | 9      |
      | SYSTEM_USER_user                   | 2.2.2.2  | 0      |
      | Certificate_Administrator_user     | 2.2.2.2  | 9      |
      | Real_Server_Operator_user          | 2.2.2.2  | 9      |
      | Security_Administrator_user        | 2.2.2.2  | 0      |
      | Security_Monitor_user              | 2.2.2.2  | 9      |
      | User_Administrator_user            | 2.2.2.2  | 9      |
      | sys_admin                          | 2.2.2.2  | 0      |

  @SID_7
  Scenario: Delete added device
    Then REST Login with user "radware" and password "radware"
    Then REST Delete Device By IP "2.2.2.2"
    Then Sleep "3"

  @SID_8
  Scenario: Add device AppWall
    Then REST Login with user "radware" and password "radware"
    Then REST Add "AppWall" Device To topology Tree with Name "FakeAW" and Management IP "3.3.3.3" into site "Default"
      | attribute | value |

  @SID_9
  Scenario Outline: Validate API password in reply - AppWall
    # results are number of "*****" masked fields. masked fields are snmpV3Username, snmpV3AuthenticationPassword, snmpV3PrivacyPassword, httpUsername, httpPassword, httpsUsername, httpsPassword, cliUsername, cliPassword
    Then CLI Run linux Command "/mask_password.sh <DeviceIP> <ROLE>" on "ROOT_SERVER_CLI" and validate result EQUALS "<RESULT>"

    Examples:
      | ROLE                               | DeviceIP | RESULT |
      | ADC_Certificate_Administrator_user | 3.3.3.3  | 9      |
      | ADC_Administrator_user             | 3.3.3.3  | 9      |
      | ADC_Operator_user                  | 3.3.3.3  | 9      |
      | Device_Administrator_user          | 3.3.3.3  | 0      |
      | Device_Configurator_user           | 3.3.3.3  | 9      |
      | Device_Operator_user               | 3.3.3.3  | 9      |
      | Device_Viewer_user                 | 3.3.3.3  | 9      |
      | Vision_Administrator_user          | 3.3.3.3  | 0      |
      | Vision_Reporter_user               | 3.3.3.3  | 9      |
      | SYSTEM_USER_user                   | 3.3.3.3  | 0      |
      | Certificate_Administrator_user     | 3.3.3.3  | 9      |
      | Real_Server_Operator_user          | 3.3.3.3  | 9      |
      | Security_Administrator_user        | 3.3.3.3  | 0      |
      | Security_Monitor_user              | 3.3.3.3  | 9      |
      | User_Administrator_user            | 3.3.3.3  | 9      |
      | sys_admin                          | 3.3.3.3  | 0      | 


  @SID_10
  Scenario: Delete added device
    Then REST Login with user "radware" and password "radware"
    Then REST Delete Device By IP "3.3.3.3"

