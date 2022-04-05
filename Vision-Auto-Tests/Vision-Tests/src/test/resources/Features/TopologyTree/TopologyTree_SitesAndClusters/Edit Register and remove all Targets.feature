@TopologyTree @TC106084
Feature: Edit Register and remove all Targets.

  @SID_1
  Scenario: Login and Open the SitesAndClusters Containers
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI open Topology Tree view "SitesAndClusters" site

  @SID_2
  Scenario: Add Alteon to tree
    Then UI Add "Alteon_Set_5" under "Default" site
  @SID_3
  Scenario: Edit Register and remove all Targets
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
      | removeTargets                | true    |
      | visionMgtPort                | G1      |

  @SID_4
  Scenario: Lock and verify device status
    Then UI Lock Device "Alteon_Set_5" under "Sites And Devices"
    Then UI verify Device Status "Alteon_Set_5" if Expected device Status "Up or Maintenance"

  @SID_5
  Scenario: Delete device from tree
    Then UI open Topology Tree view "SitesAndClusters" site
#    Then UI Delete "Alteon" device with index 2 from topology tree

  @SID_6
  Scenario: Logout
    Then UI logout and close browser

