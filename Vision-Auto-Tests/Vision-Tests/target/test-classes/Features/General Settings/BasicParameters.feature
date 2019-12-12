@VisionSettings @TC106053

Feature: Basic Parameters Functionality

  @SID_1
  Scenario: login and Navigate to Basic Parameters page
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Basic Parameters"

  @SID_2
  Scenario: Basic Parameters - server-client time
    Then UI Click Web element with id "gwt-debug-MgtServer.MC.Overview.CheckServerTime_Widget"
    Then Sleep "4"
    Then UI Validate Popup Dialog Box, have value "The APSolute Vision server and the local PC date and time settings are synchronized." with text Type "MESSAGE"
  @SID_3
  Scenario: Basic Parameters - management IP
    Then REST get Basic Parameters "managementIp"
    Then UI Validate Text field "Management IP Address" EQUALS ""
  @SID_4
  Scenario: Basic Parameters - hostname
    Then REST get Basic Parameters "hostname"
    Then UI Validate Text field "Hostname" EQUALS ""
  @SID_5
  Scenario: Basic Parameters - hardware platform
    Then REST get Basic Parameters "hardwarePlatform"
    Then UI Validate Text field "Hardware Platform" EQUALS ""
  @SID_6
  Scenario: Basic Parameters - MAC addresses
    Then REST get Basic Parameters "macG1"
    Then UI Validate Text field "MAC Address of Port G1" EQUALS ""
    Then REST get Basic Parameters "macG2"
    Then UI Validate Text field "MAC Address of Port G2" EQUALS ""
    Then REST get Basic Parameters "macG3"
    Then UI Validate Text field "MAC Address of Port G3" EQUALS ""
    Then REST get Basic Parameters "macG4"
    Then UI Validate Text field "MAC Address of Port G4" EQUALS ""
#  @SID_7
#  Scenario: Basic Parameters - server uptime
#    Then REST get Basic Parameters "uptime"
#    Then UI Validate Text field "Vision Server Uptime" CONTAINS "" cut Characters Number 25
  # commented this step because it is not testing the correct way
  @SID_8
  Scenario: Basic Parameters - server time
    Then REST get Basic Parameters "serverTime"
#    Then UI Validate Text field "APSolute Vision Server Time" CONTAINS "" cut Characters Number 4

  @SID_9
  Scenario: Basic Parameters - last upgrade status
    When UI Do Operation "select" item "Software"
    Then REST get Basic Parameters "lastUpgradeStatus"
    Then UI Validate Text field "Upgrade Status" EQUALS ""
  @SID_10
  Scenario: Basic Parameters - last upgrade date
    Then REST get Basic Parameters "lastUpgradeDate"
    Then UI Validate Text field "Last Upgrade" EQUALS ""
  @SID_11
  Scenario: Basic Parameters - Software version
    Then REST get Basic Parameters "software_version"
    Then UI Validate Text field "Software Version" EQUALS ""

  @SID_12
  Scenario: Basic Parameters - Hardware
    When UI Do Operation "select" item "Hardware"
    When REST get Basic Parameters "ramSize"
    Then UI Validate Text field "RAM Size" EQUALS ""

  @SID_13
  Scenario: Basic Parameters - Attack Descriptions File
    When UI Do Operation "select" item "Attack Descriptions File"
    Then UI Click Web element with id "gwt-debug-attackDescLastUpdate_ActionButton"
    Then UI Click Web element with id "gwt-debug-MgtServer.UpdateAttackDescFromClient.UpdateFrom_MgtServer.UpdateAttackDescFromClient.UpdateFrom.Radware-input"
    Then UI Click Web element with id "gwt-debug-MgtServer.UpdateAttackDescFromClient.UpdateFromSite_Widget"
    Then UI Timeout in seconds "5"
    Then UI Click Web element with id "gwt-debug-Dialog_Box_Close"
    Then UI Timeout in seconds "120"
    Then UI Open Upper Bar Item "Refresh"
    Then REST get Basic Parameters "attackDescLastUpdate"
    Then UI Validate Text field "Attack Descriptions File Last Update" EQUALS ""
  @SID_14
  Scenario: Logout
    Then UI Logout







