@TopologyTree @TC106068

Feature: Create Alteon VX Functionality

  @SID_1
  Scenario: Open the Physical Containers
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI open Topology Tree view "PhysicalContainers" site

  @SID_2
  Scenario: Add  Alteon VX
    Then UI Add physical "Alteon" with index 6 on "Default (Physical)" site
    Then UI open Topology Tree view "PhysicalContainers" site
    Then UI Add new Site "Alteon_VX" under Parent "Default (Physical)"
    Then UI ExpandAll Physical Containers
    Then UI open Topology Tree view "SitesAndClusters" site
    Then UI open Topology Tree view "PhysicalContainers" site
    Then UI Lock Device with type "Alteon" and Index 6 by Tree Tab "Physical Containers"
    Then UI Timeout in seconds "5"

  @SID_3
  Scenario: Delete Alteon VX
    Then UI open Topology Tree view "PhysicalContainers" site
#    Then UI Delete physical "Alteon" device with index 6 from topology tree
    Then UI Delete TopologyTree Element "Alteon_VX" by topologyTree Tab "Physical Containers"

  @SID_4
  Scenario: Logout
    Then UI Logout
