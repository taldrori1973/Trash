@run200
Feature: This is an example how to add tests for new changes in an elastic search index mapping
#This Feature File should run on Servers for Upgrade Only
#Getting the number of mapping attributes :
#  go to jsonPath tool , and run the following path : <$.<index Name>.mappings..type> on the result of :
#  http://<IP>:9200/<Index Name>

  Scenario: Revert to Snapshot
    Given Prerequisite for Setup

  Scenario Outline: Install Relevant Licenses
    Given REST Vision Install License Request "<license>"
    Examples:
      | license                        |
      | vision-AVA-Max-attack-capacity |

#  Scenario: Other Prerequisite if needed
  Scenario Outline:Validation before Upgrade
    Then CLI simulate <Attacks Number> attacks of type "<Attack Name>" on "<Device Type>" <Device Index> and wait <Wait Time> seconds
    Given Validate that the Number of the Mapping Attributes at Index "<Index Name Prefix>" with Week Slice <Week Slice> Equals to <Expected Number of Mapping Attributes>
    Examples:
      | Index Name Prefix | Week Slice | Attacks Number | Attack Name  | Device Type | Device Index | Wait Time | Expected Number of Mapping Attributes |
      | dp-sampled-data-* | 2          | 1              | DynamicBlock | DefensePro  | 11           | 45        | 13                                    |


  Scenario: Upgrade Vision
    When Upgrade or Fresh Install Vision

  Scenario Outline:Run Migration Tasks
    Then Run ElasticSearch Migration Task "<Migration Task>" and Wait <Wait Time> Seconds
    Examples:
      | Migration Task               | Wait Time |
      | DPAttackSamplesMigrationTask | 120       |
#      | BDoSBaseLineRatesMigrationTask | 120       |
#      | DFAttackMigrationTask          | 120       |
#      | DPAttackDurationMigrationTask  | 120       |

  Scenario Outline:Validation After Upgrade
    Given Validate that the Number of the Mapping Attributes at Index "<Index Name Prefix>" with Week Slice <Week Slice> Equals to <Expected Number of Mapping Attributes>
    Examples:
      | Index Name Prefix | Week Slice | Expected Number of Mapping Attributes |
      | dp-sampled-data-* | 2          | 14                                    |