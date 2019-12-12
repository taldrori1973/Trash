#@TC108916
#Feature: IPv6 Config Sync
#
#  Scenario: vision HA
#    ############# Make visions HA setup #############
#    When CLI Switch to "DISABLED" vision
#    And CLI Set config sync mode to "STANDBY" with timeout 600
#    And CLI Set config sync peer
#    And CLI Switch to "DISABLED" vision
#    And CLI Set config sync mode to "ACTIVE" with timeout 600
#    And CLI Set config sync peer
#    ##by the end of the first section the active server is 145(second vision of the sut)##
#    ############# Add feed task #############
#    And UI Switch to "ACTIVE" vision
#    And UI Login with user "radware" and password "radware"
#    Then UI Add "DefensePro" with index 5 on "Default" site
#    And UI Open scheduler window
#    And UI Add Attackers feed task with name "HAFeed" interval "3 Hours" destination devices indexes "5" with default params
#    ############# Make switchover #############
#    And CLI Make manual sync
#    And CLI Set config sync mode to "DISABLED" with timeout 600
#    And CLI Switch to "STANDBY" vision
#    And CLI Set config sync mode to "ACTIVE" with timeout 600
#    ############# Verify that the task exists in current primary #############
#    And UI Switch to "ACTIVE" vision
#    And UI Login with user "radware" and password "radware"
#    And UI Open scheduler window
#    Then UI Validate that task with name "HAFeed" exists
#    And UI Close scheduler window
#    When UI Run task with name "HAFeed"
#    Then UI Wait for "HAFeed" task success
#    ############# clear scenario data #############
#    When CLI Cleanup without server Ip the vision HA setup
#    And UI Switch to "DISABLED" vision
#    And UI Login with user "radware" and password "radware"
#
