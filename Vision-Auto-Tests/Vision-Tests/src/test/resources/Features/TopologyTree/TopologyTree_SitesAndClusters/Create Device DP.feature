@TopologyTree @TC106076
Feature: Create Device DP

  @SID_1 @Sanity
  Scenario: Open the SitesAndClusters  Containers
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Given REST Delete device with SetID "DefensePro_Set_6" from topology tree

  @SID_2 @Sanity
  Scenario: Add new DefensePro
    Given UI Go To Vision
    When UI open Topology Tree view "SitesAndClusters" site
    Then UI Add "DefensePro_Set_6" under "Default" site

  @SID_3
  Scenario: verify DP status and lock DP
    Then UI Lock Device "DefensePro_Set_6" under "Sites And Devices"
    Then UI verify Device Status "DefensePro_Set_6" if Expected device Status "Up or Maintenance"
    Then UI open Topology Tree view "SitesAndClusters" site

  @SID_4 @Sanity
  Scenario: Delete DefensePro
    Then UI Delete "DefensePro_Set_6" from topology tree

  @SID_5 @Sanity
  Scenario: Logout
    Then UI logout and close browser
