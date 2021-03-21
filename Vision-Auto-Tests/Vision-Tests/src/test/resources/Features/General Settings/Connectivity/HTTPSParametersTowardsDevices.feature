@VisionSettings @TC106055

Feature: Connectivity HTTPS Parameters Functionality

  @SID_1
  Scenario: Add devices and Navigate to Connectivity page
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Connectivity"

  @SID_2
  Scenario: Set HTTP/S Parameters Towards Device
    When UI Do Operation "select" item "HTTP/S Parameters Towards Devices"
    Then UI Set Text Field "Default HTTP Port" To "100"
    Then UI Set Text Field "Default HTTPS Port" To "101"
    Then UI Set Text Field "Connection Timeout" To "50"
    Then UI Set Text Field "Socket Timeout" To "60"
    Then UI Set Text Field "Long Operation Connection Timeout" To "120"
    Then UI Set Text Field "Long Operation Socket Timeout" To "130"
    Then UI Click Button "Submit"

  @SID_3
  Scenario: validate HTTP/S UI parameters
    Then REST get Connectivity Parameters "httpL4PortTowardsDevices"
    Then UI Validate Text field "Default HTTP Port" EQUALS ""
    Then REST get Connectivity Parameters "httpsL4PortTowardsDevices"
    Then UI Validate Text field "Default HTTPS Port" EQUALS ""
    Then REST get Connectivity Parameters "httpConnectionTimeout"
    Then UI Validate Text field "Connection Timeout" EQUALS ""
    Then REST get Connectivity Parameters "httpSocketTimeout"
    Then UI Validate Text field "Socket Timeout" EQUALS ""
    Then REST get Connectivity Parameters "httpLongOperationConnectionTimeout"
    Then UI Validate Text field "Long Operation Connection Timeout" EQUALS ""
    Then REST get Connectivity Parameters "httpLongOperationSocketTimeout"
    Then UI Validate Text field "Long Operation Socket Timeout" EQUALS ""

  @SID_4
  Scenario: validate HTTP/S Parameters in add Alteon menu
    Then UI click Topology Tree Operation "gwt-debug-DeviceTreeAdd"
    Then UI Select "Alteon" from Vision dropdown "Type"
    When UI Do Operation "select" item "HTTP/S Access"
    Then UI Validate Text field "HTTP Port" EQUALS "100"
    Then UI Validate Text field "HTTPS Port" EQUALS "101"
    Then UI Click Web element with id "gwt-debug-device_properties_CancelButton"

  @SID_5
  Scenario: validate HTTP/S Parameters in add DP menu
    Then UI click Topology Tree Operation "gwt-debug-DeviceTreeAdd"
    Then UI Select "DefensePro" from Vision dropdown "Type"
    When UI Do Operation "select" item "HTTP/S Access"
    Then UI Validate Text field "HTTP Port" EQUALS "100"
    Then UI Validate Text field "HTTPS Port" EQUALS "101"
    Then UI Click Web element with id "gwt-debug-device_properties_CancelButton"

  @SID_6
  Scenario: validate HTTP/S Parameters in add LinkProof menu
    Then UI click Topology Tree Operation "gwt-debug-DeviceTreeAdd"
    Then UI Select "LinkProof NG" from Vision dropdown "Type"
    When UI Do Operation "select" item "HTTP/S Access"
    Then UI Validate Text field "HTTP Port" EQUALS "100"
    Then UI Validate Text field "HTTPS Port" EQUALS "101"
    Then UI Click Web element with id "gwt-debug-device_properties_CancelButton"

  @SID_7
  Scenario: validate HTTP/S Parameters in add AppWall menu
    Then UI click Topology Tree Operation "gwt-debug-DeviceTreeAdd"
    Then UI Select "AppWall" from Vision dropdown "Type"
    Then UI Validate Text field "HTTPS Port" EQUALS "101"
    Then UI Click Web element with id "gwt-debug-device_properties_CancelButton"

  @SID_8
  Scenario: Set HTTP/S Parameters back to default
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Connectivity"
    When UI Do Operation "select" item "HTTP/S Parameters Towards Devices"
    Then UI Set Text Field "Default HTTP Port" To "80"
    Then UI Set Text Field "Default HTTPS Port" To "443"
    Then UI Set Text Field "Connection Timeout" To "20"
    Then UI Set Text Field "Socket Timeout" To "20"
    Then UI Set Text Field "Long Operation Connection Timeout" To "100"
    Then UI Set Text Field "Long Operation Socket Timeout" To "100"
    Then UI Click Button "Submit"

  @SID_9
  Scenario: Logout
    Then UI Logout
