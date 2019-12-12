@TopologyTree @TC106076
Feature: Create Device DP


  @SID_1 @Sanity
  Scenario: Open the SitesAndClusters  Containers
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI open Topology Tree view "SitesAndClusters" site

  @SID_2 @Sanity
  Scenario: Add new DefensePro
    Then UI Add "DefensePro" with index 2 on "Default" site
  @SID_3
  Scenario: verify DP status and lock DP
#    Then UI Add new Site "DPs" under Parent "Default"
#    Then UI Add "DefensePro" with index 8 on "DPs" site
#    Then UI Add "DefensePro" with index 9 on "DPs" site nowait

    Then UI Lock Device with type "DefensePro" and Index 2 by Tree Tab "Sites And Devices"
    Then UI verify Device Status with deviceType "defensePro" with index 2 if Expected device Status "Up or Maintenance"
    Then UI open Topology Tree view "SitesAndClusters" site
#    Then UI Delete "DefensePro" device with index 8 from topology tree
#    Then UI Delete "DefensePro" device with index 9 from topology tree
#    Then UI Delete TopologyTree Element "DPs" by topologyTree Tab "SitesAndClusters"


  @SID_4 @Sanity
  Scenario: Delete DefensePro
#    Then UI Delete "DefensePro" device with index 2 from topology tree
  @SID_5
  Scenario: Logout
    Then UI Logout
