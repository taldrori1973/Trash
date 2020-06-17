#
# Shay Even Zor: TOR feed tests
# Precondition:
#   1. there is a must to have alteons that are subscribed to this feature in MIS
#   2. There is a must to have Linkproof devices in the setup - at least one - in order to verify the support for this device type
#   3. All these test should run when Vision is behind proxy
#
#
@TOR
@TC106086
Feature: TOR
  # Basic client TOR task creation
  @SID_1
  Scenario: TOR Functionality
    Given UI Login with user "radware" and password "radware"
# Add relevant Alteon machine for test
    When UI open Topology Tree view "PhysicalContainers" site
    Then UI Add physical "Alteon" with index 6 on "Default (Physical)" site
    # Clean the TOR feed log before the first TOR task creation in order to check it later on
    And CLI Operations - Run Root Session command "echo '' > /opt/radware/storage/mgt-server/third-party/tomcat2/logs/torfeedservice.debug.log"
      # opening the scheduler window
    When UI Open scheduler window
    # Creating TOR task
    Then UI Add TOR feed task with name "AshrafTOR" description "Shay's first cucomber TC" with default params

    ###################################################################################################
    # verify vision DOESN'T request the feed from MIS until first time that alteon requests it from him.
    # verify that task interval is 5 minutes even if no alteon requested the feed
    ###################################################################################################
    * Sleep "330"
  #     This function checks expected interval for specific action in log file with acceptable deviation. if deviation is not acceptable, set it to 0(Zero)
    Then CLI Operations - Verify interval of 300 seconds in log "/opt/radware/storage/mgt-server/third-party/tomcat2/logs/torfeedservice.debug.log" for print "start run tor feed task" with valid deviation of 5
# check that vision avoids from fetching file in case no device requested it yet
    Then CLI Run linux Command "line=`echo $(grep -n "start run tor feed task" /opt/radware/storage/mgt-server/third-party/tomcat2/logs/torfeedservice.debug.log | tail -1 | awk "{print $1}" |  grep -oP '[^:]*' | head -1) +1 | bc`; sed -n "$line p" /opt/radware/storage/mgt-server/third-party/tomcat2/logs/torfeedservice.debug.log | grep "Feed fetch disabled. Avoid pulling file" | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    # Check tor_feed table is empty
    Then MYSQL Validate Number of Records FROM "tor_feed" Table in "VISION_NG" Schema WHERE "" Condition Applies EQUALS 0
    Then CLI Run linux Command "mysql -N -u root -prad123 vision_ng -e "select feed_response from tor_feed" | wc -w" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
# check that vision response with the right message for first time request of any alteon
    Then Run TOR request simulation script "reputationFeed.sh" at scriptPath "/home/radware/" on GENERIC_LINUX_SERVER to current SUT for Alteon 6
    Then CLI Run linux Command "line=`echo $(grep -n "received request from" /opt/radware/storage/mgt-server/third-party/tomcat2/logs/torfeedservice.debug.log | tail -1 | awk "{print $1}" |  grep -oP '[^:]*' | head -1) +1 | bc`; sed -n "$line p" /opt/radware/storage/mgt-server/third-party/tomcat2/logs/torfeedservice.debug.log | grep "Feed Fetch Started but feed is not available yet" | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"
  #    Then CLI Operations - Run Root Session command "mysql -N -u root -prad123 vision_ng -e "select feed_response from tor_feed" | wc -w"
#    Then CLI Operations - Verify last output contains
#    |status|

    When UI open Topology Tree view "SitesAndClusters" site
    Then UI Add "Alteon" with index 3 on "Default" site
    * Sleep "300"

#    # Run script that configure the TOR feed source on relevant alteons and apply the settings. NOTE: the script is ready but there is a need to determine its name
#    Then UI select Category From Advanced "Configuration"
##    When UI open OTB Advanced
#    Then UI click Table Record with ColumnValue "Alteon_Set_TOR_Feed.vm" by columnKey "File Name" by elementLabelId "Script" by deviceDriverType "VISION" findBy Type "BY_NAME"
#    And UI Execute Vision table with Action ID "_execute" by label "Script" isTriggerPopupSearch event "false"
#    And UI DualList Move deviceIndex 5 deviceType "Alteon" DualList Items to "RIGHT" , dual list id "gwt-debug-deviceListFgId_Content"
    Then UI Logout

  @TORTest @SID_2

  Scenario: Validate CLI operations
    When Run TOR request simulation script "reputationFeed.sh" at scriptPath "/home/radware/" on GENERIC_LINUX_SERVER to current SUT for Alteon 6
#  When run Remote Script "reputationFeed.sh" at scriptPath "/home/radware" on IP "172.17.164.100" with script params "172.17.178.58"
#  And Sleep "700"
    # Veify that after first request from alteon, the task fetched the feed from MIS and requested it for ALL alteons AND linkproof devices
    # need to fetch the macs of all alteons and linkproofs(without the semicolons) and verify in "/opt/radware/storage/mgt-server/third-party/tomcat2/logs/torfeedservice.debug.log" log at the
    # "Fetching from MIS for mac addresses" that the mac list followed contains ALL the macs
    # in order to get the macs of all the alteons and linkproof, you can use this command: "mysql -N -u root -prad123 vision_ng -e "select base_mac_addr from hardware where row_id IN (SELECT fk_hw_hardware from device_setup WHERE row_id IN(SELECT fk_dev_setup_device_setup from site_tree_elem_abs where type_column IN (\"Alteon\",\"LinkProof\")))" | sed 's/\://g'"
    Then CLI Operations - Verify TOR request for all Alteons and Linkproof
    * Sleep "10"

    # Verify that actual checksum of feed file is equal to the value in the fed response
  # you can use this command to download the file from the tor_feed table "mysql -u root -prad123 vision_ng -e "select feed_file INTO DUMPFILE '/var/lib/mysql-files/tor_feed.zip' from tor_feed""
  # perform md5sum on that file and verfify it's equal to the md5 as it appear in "feed_response" column
  # you can fetch the md5 value from feed response by this command "mysql -N -u root -prad123 vision_ng -e "select feed_response from tor_feed" | grep -oP '(?<=md5":").[^"]*'"
    And CLI Operations - Verify TOR feed downloaded successfully


  ###########################################################################################
  # Verify that "Schedule" section doesn't exist in TOR feed setup screen on edit task mode #
 ############################################################################################
  @SID_3
  Scenario: TOR task allowed parameters
    Given UI Login with user "radware" and password "radware"
    When UI Open scheduler window
    # need to implement opening already exist TOR task
#      And UI open already TOR task details window
    And UI Select task by name "AshrafTOR"
    And UI Execute Vision table with Action ID "_EDIT" by label "Task List" isTriggerPopupSearch event "false"
    Then UI verify web element not exist
      | Schedule |
    Then UI Logout

  # Verify that "Run Now" becomes disabled when marking the TOR feed task
#  Scenario: Disabling manual run on TOR task
#    Given UI Login with user "radware" and password "radware"
#    When UI Open scheduler window
#
#    # need to implement marking of already existing TOR task in tasks table
#    # need to implement "run now" button validity. element: "<td class="RunNow_Enable Table_Tool_Item" id="gwt-debug-scheduledTasks_runNow" role="menuitem" title="Run Now"></td>"
#    And UI Select task by name "AttackersFeedTask"
#    Then UI Validate Element EnableDisable status By Label "Run Now" is Enabled "true"
#    And UI Select task by name "AshrafTOR"
#    Then UI Validate Element EnableDisable status By Label "Run Now" is Enabled "true"
#    Then UI Logout

  # Verify system allows only one instance of TOR task type

  @SID_5

  Scenario: Verifying only one TOR task instance
    Given UI Login with user "radware" and password "radware"
    # the string should be "TorFeedTask" in this case
    When UI Open scheduler window
    When UI Click Web element with id "gwt-debug-scheduledTasks_NEW"
    Then UI validate DropDown textOption Existence "ERT IP Reputation Feed for Alteon" by elementLabelId "Task Type" by deviceDriverType "VISION" findBy Type "BY_NAME"
    Then UI Add TOR feed task with name "AshrafTOR_2" description "Some text" with default params negative
    Then UI Logout
    # Verify popup message when saying only one instance is allowed from that task type. "Configuration Error M_01909: Task of this type already exists."
#    //================ to do================
#    And UI popups configuration error message
#  @SID_6
#  @Shay_TOR
#
#  Scenario: Verify popup message when saying only one instance is allowed from that task type
#    # Verify all possible responses
#    # request from another machine the feed for subscribed device, not subscribed device, when MIS connection is disabled, etc.
##    Scenario: Verify all possible responses
  @SID_7

  Scenario: TOR closure
    Given UI Login with user "radware" and password "radware"
    Then UI Delete physical "Alteon" device with index 6 from topology tree
    Then UI Delete "Alteon" device with index 3 from topology tree
    Then UI logout and close browser


