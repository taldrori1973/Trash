@TopologyTree @TC106080
Feature: Delete Site

  @SID_1
  Scenario: Cleanup and pre-requisite
    Given CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='SiteA.2';""
    Given CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='SiteA.1';""
    Given CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='SiteA';""

  @SID_2
  Scenario: Login
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision

  @SID_3
  Scenario: Add site and sub-sites
    Then UI Add new Site "SiteA" under Parent "Default"
    Then UI open Topology Tree view "SitesAndClusters" site
    Then UI ExpandAll Sites And Clusters
    Then UI Add new Site "SiteA.1" under Parent "SiteA"
    Then UI ExpandAll Sites And Clusters
    Then UI Add new Site "SiteA.2" under Parent "SiteA"
    Then UI ExpandAll Sites And Clusters

  @SID_4
  Scenario: Delete site and sub-sites
    Then UI Delete TopologyTree Element "SiteA.1" by topologyTree Tab "SitesAndClusters"
    Then UI Delete TopologyTree Element "SiteA.2" by topologyTree Tab "SitesAndClusters"
    Then UI Delete TopologyTree Element "SiteA" by topologyTree Tab "SitesAndClusters"
  @SID_4
  Scenario: Logout
    Then UI Logout
