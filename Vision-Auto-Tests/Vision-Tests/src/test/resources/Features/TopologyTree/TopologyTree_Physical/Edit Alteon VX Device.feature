@TopologyTree @TC106070

Feature: Edit Alteon VX Functionality

  @SID_1
  Scenario: Open the Physical Containers
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI open Topology Tree view "PhysicalContainers" site

  @SID_2
  Scenario: Add  Alteon VX
    Then UI Add physical "Alteon" with index 6 on "Default (Physical)" site
    Then UI open Topology Tree view "PhysicalContainers" site
    Then UI Edit Alteon VX device with index 6 from topology tree
      | sshUserName                  | ""         |
      | sshPassword                  | ""         |
      | sshPort                      | 22         |
      | snmpV3Username               | ""         |
      | useSnmpV3Authentication      | false      |
      | snmpV3AuthenticationProtocol | MD5        |
      | snmpV3AuthenticationPassword | admin      |
      | useSnmpV3Privacy             | false      |
      | snmpV3PrivacyPassword        | admin      |
      | snmpVersion                  | SNMP_V1    |
      | readCommunity                | automation |
      | writeCommunityAlteon         | automation |
      | verifyHttpAccess             | true       |
      | verifyHttpsAccess            | true       |
      | httpUserName                 | admin      |
      | httpPassword                 | admin      |
      | httpPort                     | 80         |
      | httpsPort                    | 443        |
      | registerVisionServer         | true       |
      | removeTargets                | false      |
      | visionMgtPort                | G1         |

    Then UI verify Device Status physical with deviceType "Alteon" with index 6 if Expected device Status "Up or Maintenance"
#    Then UI Delete physical "Alteon" device with index 6 from topology tree
    Then UI Lock Device with type "Alteon" and Index 6 by Tree Tab "Physical Containers"
    Then UI Delete physical "Alteon" device with index 6 from topology tree
    Then UI Logout

