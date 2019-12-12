@FunctionalDDoSAttackersFeed @TC106066
Feature: DDoS attackers feed

  @Functional @SID_1
  Scenario: DDos Feed Setup - login and add DPs
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "radware" and password "radware"
    Then UI Add "DefensePro" with index 5 on "Default" site
    Then UI Add "DefensePro" with index 4 on "Default" site
    Then UI Add "DefensePro" with index 6 on "Default" site
    Then UI Add "DefensePro" with index 7 on "Default" site
    Then UI Add "DefensePro" with index 2 on "Default" site nowait
    Then UI Add "DefensePro" with index 3 on "Default" site nowait
    Then UI Add "DefensePro" with index 0 on "Default" site

  @Functional @SID_2
  Scenario: SCC dashboard - verify clean startup
    Given UI Set time format to "DEFAULT"
    When UI Go To Vision
    Then UI Click vision dashboards
    Then UI Click security control center
    Then UI Open ERT Active DDoS Feed
    Then UI Validate last DDoS feed update equal to "N/A"
    Then UI Validate DefensePro devices updated in last run equal to ""
    Then UI Validate DefensePro devices not updated in last run equal to ""
    Then UI Validate DefensePro devices not using Attackers feed subscription equal to "1"

  @Functional @SID_3
  Scenario: Add scheduled task
    Then UI Open scheduler window
    Then UI Add Attackers feed task with name "testFeed" interval "3 Hours" destination devices indexes "0,5,2,3" with default params
    Then Sleep "60"
    Then UI Close scheduler window

  @Functional @SID_4
  Scenario: Verify alert messages after task run
    Then UI Validate that after "testFeed" DDos feed task finished we have alert with message
      | M_01088: Failed to run task logic for task testFeed - M_01903: The ERT Active Attackers Feed task failed. |
    Then UI Validate that after "testFeed" DDos feed task finished we have alert with message
      | M_01904: The following DefensePro devices are not available: |
    Then UI Validate that after "testFeed" DDos feed task finished we have alert with message
      | M_01905: The following DefensePro devices are not subscribed to the ERT Active Attackers Feed service: |
    Then UI Validate that after "testFeed" DDos feed task finished we have alert with message
      | M_01902: The ERT Active Attackers Feed task updated the following DefensePro devices: |

  @Functional @SID_5
  Scenario: SCC dashboard - verify correct status after run
    When UI Go To Vision
    And UI Click vision dashboards
    And UI Click security control center
    And UI Open ERT Active DDoS Feed
    Then UI Validate last DDoS feed update date equal to "testFeed" task last run date
    Then UI Validate DefensePro devices updated in last run equal to "1"
    Then UI Validate DefensePro devices not updated in last run equal to "2"
    Then UI Validate DefensePro devices not using Attackers feed subscription equal to "1"

  @Functional @SID_6
  Scenario: Delete scheduled task
    Then UI Open scheduler window
    Then UI Delete task with name "testFeed"
    Then UI Close scheduler window

  @Functional @SID_7
  Scenario: Subscription table - verify correct values
    Then UI Validate "ERT Active Attackers Feed Subscription" column exists in device subscriptions table
    Then UI Validate "ERT Active Attackers Feed Expiration Date" column exists in device subscriptions table
    Then UI Validate "DefensePro" device with index 5 subscription contains "ERT Active Attackers Feed Subscription" equals to "Yes"
    Then UI Validate "DefensePro" device with index 5 subscription contains "ERT Active Attackers Feed Expiration Date" equals to "01.01.2050"

  @Functional @SID_8
  Scenario Outline: Verify that admin scripts are hidden
    Then UI Validate that "DefensePro Block Reputation IPs" script not exist under "<groups>" group
    And UI Validate that "DefensePro Block Reputation IPs" script not exist under "<groups>" OTB advanced category

    Examples:
      | groups            |
      | Configuration     |
      | Monitoring        |
      | Operations        |
      | High Availability |
      | Data Export       |
      | Emergency         |
      | Unassigned        |

  @Functional @SID_9
  Scenario: Scheduler - add Single task only
    When UI Open scheduler window
    And UI Add Attackers feed task with name "testFeed1" interval "3 Hours" destination devices indexes "5" with default params

  @Functional @SID_10
  Scenario: Scheduler - add failed task and delete the task
    And UI Open scheduler window
    And UI Add Attackers feed task with name "testFeed2" interval "3 Hours" destination devices indexes "5" without verify
    Then UI Validate that adding DDos feed task failed
    Then UI Close scheduler window
    Then UI Delete task with name "testFeed1"
    Then UI Close scheduler window

#  @SID_11
#  Scenario: Update SUS for two DPs
#    Then UI Go To Vision
#    And UI Update security signatures for DefensePro number 6
#    And UI Update security signatures for DefensePro number 7
#
#  @SID_12
#  Scenario: Create DP cluster
#    Then UI Go To Vision
#    And UI Create DP cluster with Name "testCluster" with primary 6 and secondary 7
#    Then UI Wait for "testCluster" cluster to be created 400 seconds
#
#  @SID_13
#  Scenario: Create scheduled task for one DP
#    When UI Open scheduler window
#    And UI Add Attackers feed task with name "testFeed" interval "3 Hours" destination devices indexes "6" with default params
#    Then UI Close scheduler window
#
#  @SID_14
#  Scenario: Verify vision requests feed for one DP only and delete the task
#    And CLI Validate that Vision request an attackers feed for DefensePro with index 6
#    And CLI Validate that Vision did not request an attackers feed for DefensePro with index 7
#    And UI Wait for "testFeed" task success
#    When UI Delete task with name "testFeed"
#    Then UI Close scheduler window
#
#  @SID_15
#  Scenario: Break DP cluster
#    And UI Brake "testCluster" DP cluster

  @Functional @SID_11
  Scenario: IP list is filled in DP
    When UI Add "DefensePro" with index 5 on "Default" site
    And UI Select "DefensePro" device from tree with index 5
    And UI Open black list in DefensePro 5
    And UI Fill in the black list table in DefensePro 5

  @Functional @SID_12
  Scenario: Run feed task on DP 5
    And UI Open scheduler window
    And UI Add Attackers feed task with name "testFeed" interval "3 Hours" destination devices indexes "5" with default params
    Then UI Close scheduler window

  @Functional @SID_13
  Scenario: Verify alert messages after run
    And UI Validate that after "testFeed" DDos feed task finished we have alert with message
      | M_01088: Failed to run task logic for task testFeed - M_01903: The ERT Active Attackers Feed task failed. |
    And UI Validate that after "testFeed" DDos feed task finished we have alert with message
      | M_01906: Updating the following DefensePro devices with the ERT Active Attackers Feed failed: |
    And UI Validate that after "testFeed" DDos feed task finished we have alert with message
      | The number of Access List rules has exceeded capacity. Remove some rules. |
    When UI Delete task with name "testFeed"
    Then UI Close scheduler window

  @Functional @SID_14
  Scenario: Get number of Black list rows in DP 0
    Given UI Select "DefensePro" device from tree with index 0
    And UI Open black list in DefensePro 0
    When UI Get black list rows number
    Then CLI Operations - Run Root Session command "cd /opt/radware/storage/vdirect/server/logs/application/"
    Then CLI Operations - Run Root Session command "dd if=/dev/null of=vdirect.log bs=1 count=0"

  @SID_15
  Scenario: Basic Functionality
    And UI Open scheduler window
    And UI Add Attackers feed task with name "testFeed" interval "3 Hours" destination devices indexes "0,5,2,3" with default params
    Then UI Close scheduler window

  @SID_16
  Scenario: Basic Functionality
    Then CLI Validate that Vision request an attackers feed for DefensePro with index 0
    Then CLI Validate that Vision request an attackers feed for DefensePro with index 5
    Then CLI Validate that Vision did not request an attackers feed for DefensePro with index 2
    Then CLI Validate that Vision did not request an attackers feed for DefensePro with index 3
    Then CLI Validate that Vision was send attackers feed for DefensePro with index 5

  @SID_17
  Scenario: Basic Functionality
    Then UI Validate that after "testFeed" DDos feed task finished we have alert with message
      | M_01088: Failed to run task logic for task testFeed - M_01903: The ERT Active Attackers Feed task failed. |
    Then UI Validate that after "testFeed" DDos feed task finished we have alert with message
      | M_01904: The following DefensePro devices are not available: |
    Then UI Validate that after "testFeed" DDos feed task finished we have alert with message
      | M_01905: The following DefensePro devices are not subscribed to the ERT Active Attackers Feed service: |
    Then UI Validate that after "testFeed" DDos feed task finished we have alert with message
      | M_01902: The ERT Active Attackers Feed task updated the following DefensePro devices: |

  @SID_18
  Scenario: Basic Functionality
    When UI Select "DefensePro" device from tree with index 5
    And UI Open black list in DefensePro 5
    And UI Validate black list rows number that its name start with "RWTI" equal to 300
    And CLI Operations - Run Root Session command "cd /opt/radware/storage/vdirect/server/logs/application/"
    And CLI Operations - Run Root Session command "grep "Created a new black list rule" vdirect.log"
    Then CLI Operations - Verify that the output Lines number as expected 300

  @SID_19
  Scenario: Basic Functionality
    When UI Select "DefensePro" device from tree with index 0
    And UI Open black list in DefensePro 0
    Then UI verify black list rows number
    When UI Delete task with name "testFeed"

  @SID_25
  Scenario: Basic Functionality
    And UI Add Attackers feed task with name "testFeed" interval "3 Hours" destination devices indexes "5" with default params
    Then UI Close scheduler window

  @SID_26
  Scenario: Basic Functionality
    And UI Wait for "testFeed" task success
    When UI Delete task with name "testFeed"
    Then UI Close scheduler window

  @Functional @SID_27
  Scenario: deletion script
    When UI Click on "DefensePro Delete Active Attackers Feed BlackList" OTB script Run With Params from "Operations" OTB category
    And UI DualList Move deviceIndex 5 deviceType "DefensePro" DualList Items to "LEFT" , dual list id "gwt-debug-#device#defensePros"
    And UI Click OTB script run submit
    And UI Wait for OTB running script output popup 300 seconds
    And UI Click OTB script run cancel

  @SID_28
  Scenario: Basic Functionality
    And UI Select "DefensePro" device from tree with index 5
    And UI Open black list in DefensePro 5
    Then UI Validate black list rows number that its name start with "RWTI" equal to 0
    Then UI Logout

#  @FunctionalNoRun @SID_10
#  Scenario: vision HA
#    ############# Make visions HA setup #############
#    When CLI Switch to "DISABLED" vision
#    And CLI Set config sync mode to "STANDBY" with timeout 30
#    And CLI Set config sync peer
#    And CLI Switch to "DISABLED" vision
#    And CLI Set config sync mode to "ACTIVE" with timeout 30
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
#    And CLI Set config sync mode to "DISABLED" with timeout 30
#    And CLI Switch to "STANDBY" vision
#    And CLI Set config sync mode to "ACTIVE" with timeout 30
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



#  @Functional @SID_11
#  Scenario: Backup & Restore
#    ############# configuration backup & restore #############
#    And UI Add "DefensePro" with index 5 on "Default" site
#    And UI Open scheduler window
#    And UI Add Attackers feed task with name "backupFeed" interval "3 Hours" destination devices indexes "5" with default params
#    And CLI Create configuration backup with name "feedConfBackup"
#    And CLI Export configuration backup with name "feedConfBackup" to remote server using "ftp" protocol
#    And CLI Delete configuration backup with name "feedConfBackup"
#    And UI Delete task with name "backupFeed"
#    And CLI Switch to "DISABLED" vision
#    And CLI Import configuration backup with name "feedConfBackup" from remote server using "ftp" protocol
#    And CLI Restore configuration backup with name "feedConfBackup"
#    And UI Switch to "DISABLED" vision
#    And UI Login with user "radware" and password "radware"
#    Then UI Open scheduler window
#    And UI Validate that task with name "backupFeed" exists
#    And UI Close scheduler window
#    ############# full backup & restore #############
#    When CLI Switch to "DISABLED" vision
#    And CLI Create full backup with name "feedFullBackup"
#    And CLI Export full backup with name "feedFullBackup" to remote server using "ftp" protocol
#    And CLI Delete full backup with name "feedFullBackup"
#    And UI Delete task with name "backupFeed"
#    And CLI Switch to "DISABLED" vision
#    And CLI Import full backup with name "feedFullBackup" from remote server using "ftp" protocol
#    And CLI Restore full backup with name "feedFullBackup"
#    And UI Switch to "DISABLED" vision
#    And UI Login with user "radware" and password "radware"
#    Then UI Open scheduler window
#    And UI Validate that task with name "backupFeed" exists
#    And UI Close scheduler window
#    And UI Delete "DefensePro" device with index 5 from topology tree
#    And UI Delete task with name "backupFeed"
#    And UI Close scheduler window

  @Functional @SID_29
  Scenario: Cleanup Vision devices
#    When CLI Cleanup without server Ip the vision HA setup
#    And UI Switch to "DISABLED" vision
