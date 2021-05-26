@TopologyTree @TC106068

Feature: Create Alteon VX Functionality

  @SID_1
  Scenario: Open the Physical Containers
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI open Topology Tree view "PhysicalContainers" site

  @SID_2
  Scenario: Add  Alteon VX
    Then UI Add physical "Alteon_Set_4" under "Default (Physical)" site
    Then UI open Topology Tree view "PhysicalContainers" site
    Then UI Add new Site "Alteon_VX" under Parent "Default (Physical)"
    Then UI ExpandAll Physical Containers
    Then UI open Topology Tree view "SitesAndClusters" site
    Then UI open Topology Tree view "PhysicalContainers" site
    Then UI Lock Device "Alteon_Set_4" under "Physical Containers"
    Then UI Timeout in seconds "5"

  @SID_3
  Scenario: Delete Alteon VX
    Then UI open Topology Tree view "PhysicalContainers" site
#    Then UI Delete physical "Alteon" device with index 6 from topology tree
    Then UI Delete TopologyTree Element "Alteon_VX" by topologyTree Tab "Physical Containers"

  @SID_4
  Scenario: Logout
    Then UI Logout
