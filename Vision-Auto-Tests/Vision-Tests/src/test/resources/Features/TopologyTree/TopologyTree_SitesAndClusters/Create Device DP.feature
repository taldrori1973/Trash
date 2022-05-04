@TopologyTree @TC106076
Feature: Create Device DP

  @SID_1 @Sanity
  Scenario: Open the SitesAndClusters  Containers
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Given REST Delete device with DeviceID "DefensePro_172.16.22.25" from topology tree

  @SID_2 @Sanity
  Scenario: Add new DefensePro
    Given UI Go To Vision
    When UI open Topology Tree view "SitesAndClusters" site
    When UI Add with DeviceID "DefensePro_172.16.22.25" under "Default" site

  @SID_3
  Scenario: verify DP status and lock DP
    When UI Lock Device with DeviceID "DefensePro_172.16.22.25" under "Sites And Devices"
    Then UI verify Device Status with DeviceID "DefensePro_172.16.22.25" if Expected device Status "Up or Maintenance"

  @SID_4 @Sanity
  Scenario: Delete DefensePro
    When UI open Topology Tree view "SitesAndClusters" site
    Then UI Delete with DeviceID "DefensePro_172.16.22.25" from topology tree

  @SID_5 @Sanity
  Scenario: Logout
    Given UI logout and close browser
