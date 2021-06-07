@TC121704
Feature: LinkProof Indication in Table

  @SID_1
  Scenario: Login and update drivers
#    Given CLI Reset radware password
#    Then REST Vision Install License Request "vision-reporting-module-ADC"
#    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
#    Then CLI copy "/home/radware/Scripts/Alteon-32.4.0.0-DD-1.00-396.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
#    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.4.0.0-DD-1.00-396.jar" on "ROOT_SERVER_CLI" with timeOut 240
#    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    Then UI Login with user "radware" and password "radware"

  @SID_2
  Scenario: Go into system dashboard and validate device have LinkProof
    When UI Navigate to "System and Network Dashboard" page via homePage
    Given UI Click Button "Device Selection"
    Then UI Select scope from dashboard and Save Filter device type "Alteon"
      | All |

    Then UI Validate Table record values by columns with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
      | columnName | value  |
      | LinkProof  | xxxxxx |
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Validate Element Existence By Label "LinkProofTab" if Exists "true" with value "LinkProof"
    Then UI Validate the attribute "data-debug-checked" Of Label "LinkProofTab" is "EQUALS" to "false"
    Then UI Click Button "LinkProofTab"
    Then UI Validate the attribute "data-debug-checked" Of Label "LinkProofTab" is "EQUALS" to "true"



  @SID_3
  Scenario: Go into system dashboard and validate device NOT have LinkProof
    When UI Navigate to "System and Network Dashboard" page via homePage
    Given UI Click Button "Device Selection"
    Then UI Select scope from dashboard and Save Filter device type "Alteon"
      | All |

    Then UI Validate Table record values by columns with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
      | columnName | value  |
      | LinkProof  | xxxxxx |
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Validate Element Existence By Label "LinkProofTab" if Exists "false" with value "LinkProof"

  @SID_4
  Scenario: Logout
    Then UI logout and close browser