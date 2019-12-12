@TopologyTree @TC106083
Feature: Edit Device SNMP Alteon and HTTPS Access

  @SID_1
  Scenario: Login and Open the SitesAndClusters Containers
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI open Topology Tree view "SitesAndClusters" site

  @SID_2
  Scenario: Edit Device SNMP Alteon and HTTPS Access
    Then UI Add "Alteon" with index 2 on "Default" site
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
      | snmpVersion                  | SNMP_V1 |
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

  @SID_3
  Scenario: Lock and verify device status
    Then UI Lock Device with type "Alteon" and Index 2 by Tree Tab "Sites And Devices"
    Then UI verify Device Status with deviceType "Alteon" with index 2 if Expected device Status "Up or Maintenance"
  @SID_4
  Scenario: Delete Alteon device
    Then UI open Topology Tree view "SitesAndClusters" site
#    Then UI Delete "Alteon" device with index 2 from topology tree
  @SID_5
  Scenario: Logout
    Then UI logout and close browser

