@CLI_Negative @TC106037

Feature: Snmpwalk Tests

  @SID_1
  Scenario: Snmpwalk CPU Utilization No Response Output Test
    When CLI run snmpwalk command "cpu.utilization.User"
    Then CLI Operations - Verify that output contains regex ".*Timeout: No Response.*" negative
    And CLI run snmpwalk command "cpu.utilization.System"
    Then CLI Operations - Verify that output contains regex ".*Timeout: No Response.*" negative
    And CLI run snmpwalk command "cpu.utilization.Total"
    Then CLI Operations - Verify that output contains regex ".*Timeout: No Response.*" negative

  @SID_2
  Scenario: Snmpwalk CPU user Utilization Test
    #  1.	User cpu utilization
    When CLI snmpwalk Validate "cpu.utilization" with "User"
  @SID_3
  Scenario: Snmpwalk CPU system Utilization Test
    #  2.	System cpu utilization
    And CLI snmpwalk Validate "cpu.utilization" with "System"
  @SID_4
  Scenario: Snmpwalk CPU total Utilization Test
    #  3.	Total cpu utilization
    Then CLI snmpwalk Validate "cpu.utilization" with "Total"

  @SID_5
  Scenario: Snmpwalk Vision Hostname Test
    When CLI run snmpwalk command "Vision.Hostname"
    Then CLI Operations - Verify that output contains regex ".*vision.radware.*"

