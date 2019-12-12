@VisionSettings @TC106058

Feature: Connectivity SNMP Parameters

  @SID_1
  Scenario: Add devices and Navigate to Connectivity page
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Go To Vision
    Then UI Add "DefensePro" with index 5 on "Default" site
    Then UI Add "Alteon" with index 3 on "Default" site
    Then UI Wait For Device To Show Up In The Topology Tree "DefensePro" device with index 5 with timeout 300
    Then UI Wait For Device To Show Up In The Topology Tree "Alteon" device with index 3 with timeout 300
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Connectivity"

  @SID_2
  Scenario: SNMP parameters - bad port
#    Then CLI tcpDump Interval Validation with command "timeout 50 tcpdump -s 0 -i G1 -X port 161 and dst host 172.16.22.31 | grep sysObjectID" by Interval "15" with Threshold "1"
    Then UI Set Text Field "Port" To "165"
    Then UI Set Text Field "Timeout" To "4"
    Then UI Set Text Field "Retries" To "2"
    Then UI Click Button "Submit"
    Then REST get Connectivity Parameters "snmpHostPort"
    Then UI Validate Text field "Port" EQUALS ""
    Then UI Select "Alteon" device from tree with index 3
    Then UI Timeout in seconds "90"
    Then UI Open Upper Bar Item "Refresh"
    Then UI Validate InfoPane Property "STATUS" with expectedResult "Down"

  @SID_3
  Scenario: SNMP parameters - back to correct port
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Connectivity"

    Then UI Set Text Field "Port" To "161"
    Then UI Click Button "Submit"
    Then REST get Connectivity Parameters "snmpTimeOut"
    Then UI Validate Text field "Timeout" EQUALS ""
    Then REST get Connectivity Parameters "snmpNumberOfRetries"
    Then UI Validate Text field "Retries" EQUALS ""
    Then UI Select "Alteon" device from tree with index 3
    Then UI Timeout in seconds "90"
    Then UI Open Upper Bar Item "Refresh"
    Then UI Validate InfoPane Property "STATUS" with expectedResult "Up"

  @SID_3
  Scenario: Delete devices and Logout
#    Then UI Delete "DefensePro" device with index 5 from topology tree
#    Then UI Delete "Alteon" device with index 3 from topology tree
    Then UI Logout
    



