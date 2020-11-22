@TopologyTree @TC106085
Feature: Edit SSH Access

  @SID_1
  Scenario: Open the SitesAndClusters  Containers
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI open Topology Tree view "SitesAndClusters" site

  @SID_2
  Scenario: Edit SSH Access
    Then UI Add "Alteon" with index 2 on "Default" site
    Then UI Edit Alteon device with index 2 from topology tree
      | sshUserName                  | "admin_test" |
      | sshPassword                  | "admin_test" |
      | sshPort                      | 23           |
      | snmpV3Username               | ""           |
      | useSnmpV3Authentication      | false        |
      | snmpV3AuthenticationProtocol | MD5          |
      | snmpV3AuthenticationPassword | admin        |
      | useSnmpV3Privacy             | false        |
      | snmpV3PrivacyPassword        | admin        |
      | snmpVersion                  | SNMP_V2      |
      | readCommunity                | public       |
      | writeCommunityAlteon         | private      |
      | verifyHttpAccess             | true         |
      | verifyHttpsAccess            | true         |
      | httpUserName                 | admin        |
      | httpPassword                 | admin        |
      | httpPort                     | 80           |
      | httpsPort                    | 443          |
      | registerVisionServer         | true         |
      | removeTargets                | false        |
      | visionMgtPort                | G1           |
    Then UI Edit Alteon device with index 2 from topology tree
      | sshUserName                  | "admin" |
      | sshPassword                  | "admin" |
      | sshPort                      | 22      |
      | snmpV3Username               | ""      |
      | useSnmpV3Authentication      | false   |
      | snmpV3AuthenticationProtocol | MD5     |
      | snmpV3AuthenticationPassword | admin   |
      | useSnmpV3Privacy             | false   |
      | snmpV3PrivacyPassword        | admin   |
      | snmpVersion                  | SNMP_V2 |
      | readCommunity                | public  |
      | writeCommunityAlteon         | private |
      | verifyHttpAccess             | true    |
      | verifyHttpsAccess            | true    |
      | httpUserName                 | admin   |
      | httpPassword                 | admin   |
      | httpPort                     | 80      |
      | httpsPort                    | 443     |
      | registerVisionServer         | true    |
      | removeTargets                | false   |
      | visionMgtPort                | G1      |
    Then UI Lock Device with type "Alteon" and Index 2 by Tree Tab "Sites And Devices"
    Then UI verify Device Status with deviceType "Alteon" with index 2 if Expected device Status "Up or Maintenance"
    Then UI open Topology Tree view "SitesAndClusters" site
#    Then UI Delete "Alteon" device with index 2 from topology tree

  @SID_3
    Scenario: Logout
    Then UI logout and close browser

