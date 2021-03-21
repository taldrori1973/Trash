@TopologyTree @TC106069

Feature: Create and Delete Sites Physical container

  @SID_1
  Scenario: Cleanup and pre-requisite
#    Given CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='site1.2.1_Physical';""
    Given MYSQL DELETE FROM "site_tree_elem_abs" Table in "VISION_NG" Schema WHERE "name='site1.2.1_Physical'"

#    Given CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='site1.1.2_Physical';""
    Given MYSQL DELETE FROM "site_tree_elem_abs" Table in "VISION_NG" Schema WHERE "name='site1.1.2_Physical'"

#    Given CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='site1.1.1_Physical';""
    Given MYSQL DELETE FROM "site_tree_elem_abs" Table in "VISION_NG" Schema WHERE "name='site1.1.1_Physical'"

#    Given CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='site1.2_Physical';""
    Given MYSQL DELETE FROM "site_tree_elem_abs" Table in "VISION_NG" Schema WHERE "name='site1.2_Physical'"

#    Given CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='site1.1_Physical';""
    Given MYSQL DELETE FROM "site_tree_elem_abs" Table in "VISION_NG" Schema WHERE "name='site1.1_Physical'"

#    Given CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='Site1_Physical';""
    Given MYSQL DELETE FROM "site_tree_elem_abs" Table in "VISION_NG" Schema WHERE "name='Site1_Physical'"
  @SID_2
  Scenario: Open the Physical Containers
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI open Topology Tree view "PhysicalContainers" site

  @SID_3
  Scenario Outline: Create Physical Sites
    Then UI Add new Site "<siteName>" under Parent "<parent>"
    Then UI ExpandAll Physical Containers

    Examples:
      | siteName             | parent             |
      | Site1_Physical       | Default (Physical) |
      | site1.1_Physical     | Site1_Physical     |
      | site1.2_Physical     | Site1_Physical     |
      | site1.1.1_Physical   | site1.1_Physical   |
      | site1.1.2_Physical   | site1.1_Physical   |
      | site1.2.1_Physical   | site1.2_Physical   |

  @SID_4
  Scenario Outline: delete all sites
    Then UI Delete TopologyTree Element "<siteName>" by topologyTree Tab "Physical Containers"
    Examples:
      | siteName |
      | site1.2.1_Physical |
      | site1.1.2_Physical |
      | site1.1.1_Physical |
      | site1.2_Physical   |
      | site1.1_Physical   |
      | Site1_Physical     |

  @SID_5
    Scenario: Logout
      Then UI Logout

