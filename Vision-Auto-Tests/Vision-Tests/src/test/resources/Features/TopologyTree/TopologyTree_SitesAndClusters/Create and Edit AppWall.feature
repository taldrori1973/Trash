@TopologyTree @TC106074
Feature: Create and Edit AppWall

  @SID_1
  Scenario: Open the SitesAndClusters  Containers
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI open Topology Tree view "SitesAndClusters" site

  @SID_2
  Scenario: Add Appwall 7.4.X device
    Then UI Add "AppWall_Set_2" under "Default" site
    Then UI verify Device Status "AppWall_Set_2" if Expected device Status "Up"
#    Then UI Edit AppWall with DeviceType "AppWall" with index 0 Mgt port "G1"

  @SID_3
  Scenario: delete Appwall 7.4.X device
    Then UI Delete "AppWall_Set_2" from topology tree

#  @SID_4
#  Scenario: Add Appwall iFrame device
#    Then UI Add "AppWall" with index 1 on "Default" site

  @SID_5
  Scenario: Step into iFrame

  @SID_6
  Scenario: Logout
    Then UI Logout
