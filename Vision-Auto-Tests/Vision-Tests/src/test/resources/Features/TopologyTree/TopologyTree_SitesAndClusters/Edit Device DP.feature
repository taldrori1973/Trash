@TopologyTree @TC106082
Feature: Add Edit Delete Device DP

  @SID_1
  Scenario: Open the SitesAndClusters  Containers
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Open "Configurations" Tab
    Then UI Go To Vision
    Then UI open Topology Tree view "SitesAndClusters" site

  @SID_2
  Scenario: Add Device DP with wrong credentials
    Then UI Add "DefensePro_Set_3" under "Default" site expected status "FAILED"
      | snmpReadCommunity    | somethingDoesNotExist |
      | snmpWriteCommunity   | somethingDoesNotExist |
      | registerVisionServer | false                 |

  @SID_3
  Scenario: Edit Device DP connection parameters
    Then UI Edit DP device with index 12 from topology tree expected status "OK"
      | sshPort                      | 22         |
      | snmpV3Username               | ""         |
      | useSnmpV3Authentication      | false      |
    # | snmpV3AuthenticationProtocol | MD5        |
    # | snmpV3AuthenticationPassword | admin      |
    # | useSnmpV3Privacy             | false      |
    # | snmpV3PrivacyPassword        | admin      |
      | snmpVersion                  | SNMP_V2    |
      | readCommunity                | automation |
      | writeCommunityDefensePro     | automation |
    # | verifyHttpAccess             | true       |
      | verifyHttpsAccess            | true       |
      | httpUserName                 | radware    |
      | httpPassword                 | radware    |
      | httpPort                     | 80         |
      | httpsPort                    | 443        |
    # | registerVisionServer         | true       |
    # | removeTargets                | false      |
    # | visionMgtPort                | G1         |

    Then UI verify Device Status "DefensePro_Set_3" if Expected device Status "Up or Maintenance"

  @SID_4
  Scenario: Delete DP device from tree
    Then UI open Topology Tree view "SitesAndClusters" site
#    Then UI Delete "DefensePro" device with index 1 from topology tree

  @SID_5
  Scenario: Logout
    Then UI logout and close browser

