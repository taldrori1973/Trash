@TopologyTree @TC106075
Feature: Create Alteon Device

  @SID_1
  Scenario: Open the SitesAndClusters Containers
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Given REST Delete device with SetId "Alteon_Set_5" from topology tree

  @SID_2
  Scenario: Add new Site to tree
    Then UI Go To Vision
    Then UI open Topology Tree view "SitesAndClusters" site
    Then UI Add new Site "Alteon" under Parent "Default"

  @SID_3
  Scenario: Add new Alteon to site
    Then UI Add "Alteon_Set_5" under "Alteon" site
    Then UI Wait For Device To Show Up In The Topology Tree "Alteon_Set_5" with timeout 300 seconds

  @SID_4
  Scenario: Lock and verify Alteon status
    When UI verify Device Status "Alteon_Set_5" if Expected device Status "Up or Maintenance"
    Then UI Lock Device "Alteon_Set_5" under "Sites And Devices"

  @SID_5
  Scenario: Delete Alteon devices from tree
    Then UI open Topology Tree view "SitesAndClusters" site
    Then UI Delete "Alteon_Set_5" from topology tree

  @SID_6
  Scenario: Delete Alteon site
    Then UI Delete TopologyTree Element "Alteon" by topologyTree Tab "SitesAndClusters"

  @SID_7
  Scenario: logout
    Given UI logout and close browser





