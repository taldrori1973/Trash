@TopologyTree @TC106076
Feature: Create Device DP

  @SID_1 @Sanity
  Scenario: Open the SitesAndClusters  Containers
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI open Topology Tree view "SitesAndClusters" site

  @SID_2 @Sanity
  Scenario: Add new DefensePro
    Then UI Add "DefensePro" on SetId "DefensePro_Set_6" under "Default" site

  @SID_3
  Scenario: verify DP status and lock DP
    Then UI Lock Device with type "DefensePro" and Index 2 by Tree Tab "Sites And Devices"
    Then UI verify Device Status with deviceType "defensePro" with index 2 if Expected device Status "Up or Maintenance"
    Then UI open Topology Tree view "SitesAndClusters" site

  @SID_4 @Sanity
  Scenario: Delete DefensePro
    Then UI Delete "DefensePro_Set_6" from topology tree

  @SID_5 @Sanity
  Scenario: Logout
    Then UI logout and close browser
