@TopologyTree @TC106078

Feature: Create and Delete Sites - Sites and Devices Functionality

  @SID_1
  Scenario: cleanup and pre-requisites
    * REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
#    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='site1.1.1.1';""
    Then MYSQL DELETE FROM "site_tree_elem_abs" Table in "VISION_NG" Schema WHERE "name='site1.1.1.1'"

#    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='site1.1.1';""
    Then MYSQL DELETE FROM "site_tree_elem_abs" Table in "VISION_NG" Schema WHERE "name='site1.1.1'"

#    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='site1.1.2';""
    Then MYSQL DELETE FROM "site_tree_elem_abs" Table in "VISION_NG" Schema WHERE "name='site1.1.2'"

#    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='site1.2';""
    Then MYSQL DELETE FROM "site_tree_elem_abs" Table in "VISION_NG" Schema WHERE "name='site1.2'"

#    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='site1.1';""
    Then MYSQL DELETE FROM "site_tree_elem_abs" Table in "VISION_NG" Schema WHERE "name='site1.1'"

#    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='site1';""
    Then MYSQL DELETE FROM "site_tree_elem_abs" Table in "VISION_NG" Schema WHERE "name='site1'"

  @SID_2
  Scenario: Open the Physical Containers
    Then UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI open Topology Tree view "SitesAndClusters" site

  @SID_2
  Scenario Outline: Create sites on Sites and Devices
    Then UI Add new Site "<siteName>" under Parent "<parent>"
    Then UI ExpandAll Sites And Clusters

    Examples:
      | siteName    | parent    |
      | Site1       | Default   |
      | site1.1     | Site1     |
      | site1.2     | Site1     |
      | site1.1.1   | site1.1   |
      | site1.1.2   | site1.1   |
      | site1.1.1.1 | site1.1.1 |


  @SID_3
  Scenario: open Sites and Devices
    Then UI Open Sites and Devices

  @SID_4
  Scenario Outline: delete all sites
    Then UI Delete TopologyTree Element "<siteName>" by topologyTree Tab "Sites And Devices"
    Examples:
      | siteName    |
      | site1.1.1.1 |
      | site1.1.2   |
      | site1.1.1   |
      | site1.1     |
      | site1.2     |
      | Site1       |


  @SID_5
  Scenario: Logout
    Then UI Logout
