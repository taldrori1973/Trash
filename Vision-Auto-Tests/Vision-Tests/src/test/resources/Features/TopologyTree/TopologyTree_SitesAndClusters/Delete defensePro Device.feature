@TopologyTree @TC106079
Feature: Delete DefensePro Device

  @SID_1
  Scenario: Open the SitesAndClusters Containers
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI open Topology Tree view "SitesAndClusters" site
    Then CLI Clear vision logs

  @SID_2
  Scenario: Add Site and DefensePro Device
#    Then UI Add new Site "Delete Device" under Parent "Default"
    Then UI Add "DefensePro" with index 1 on "Default" site
  @SID_3
  Scenario: Delete DefensePro Device from site
    Then UI Delete "DefensePro" device with index 1 from topology tree
  @SID_4
  Scenario: Delete site
#    Then UI Delete TopologyTree Element "Delete Device" by topologyTree Tab "SitesAndClusters"
  @SID_5
  Scenario: Logout and check logs
    Then UI Logout
    And CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
