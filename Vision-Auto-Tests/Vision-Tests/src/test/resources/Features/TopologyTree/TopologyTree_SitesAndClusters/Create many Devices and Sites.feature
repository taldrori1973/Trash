@TopologyTree @TC106077
Feature: Create many Devices and Sites

  @SID_1
  Scenario: Open the SitesAndClusters Containers
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI open Topology Tree view "SitesAndClusters" site

  @SID_2
  Scenario: Add new Sites
    Then UI Add new Site "Site123" under Parent "Default"
#    Then UI Add "DefensePro" with index 8 on "Site123" site
#    Then UI Add "DefensePro" with index 9 on "Site123" site nowait
    Then UI Add new Site "MultipleUsers1" under Parent "Default"
    Then UI Add new Site "MultipleUsers2" under Parent "Default"
    Then UI Add new Site "MultipleUsers3" under Parent "Default"
    Then UI Add new Site "MultipleUsers4" under Parent "Default"
  @SID_3
  Scenario: Add DefensePro to site
    Then UI Add "DefensePro" with index 5 on "Site123" site
  @SID_4
  Scenario: Add multiple Alteon devices
    Then UI Add 20 multiple "Alteon" Devices
      | DeviceName           | ODS4_                                               |
      | Parent               | Default                                             |
      | BaseIP               | 10.205.194                                          |
      | visionMgtPort        | G1                                                  |
      | AddMultiDeviceDelay  | 1500                                                |
      | snmpVersion          | SNMP_V2                                             |
      | snmpV2ReadCommunity  | public                                              |
      | snmpV2WriteCommunity | private                                             |
      | verifyHttpAccess     | true                                                |
      | verifyHttpsAccess    | true                                                |
      | httpUsername         | admin                                               |
      | httpPassword         | admin                                               |
      | httpPort             | 80                                                  |
      | httpsPort            | 443                                                 |
      | sshUsername          | admin                                               |
      | sshPassword          | admin                                               |
      | registerVisionServer | true                                                |
      | removeTargets        | false                                               |
      | visionMgtPort        | G1                                                  |

  @SID_5
  Scenario: Delete multiple Alteon devices
    Then UI delete 20 "ODS4_" Devices
  @SID_6
  Scenario: Delete multiple sites
    Then UI delete 4 "MultipleUsers" Sites
  @SID_7
  Scenario: Delete DefensePro
#    Then UI Delete "DefensePro" device with index 5 from topology tree
#    Then UI Delete "DefensePro" device with index 8 from topology tree
#    Then UI Delete "DefensePro" device with index 9 from topology tree
  @SID_8
  Scenario: Delete last site
    Then UI Delete TopologyTree Element "Site123" by topologyTree Tab "Sites And Devices"
  @SID_9
  Scenario: Logout
    Then UI Logout





