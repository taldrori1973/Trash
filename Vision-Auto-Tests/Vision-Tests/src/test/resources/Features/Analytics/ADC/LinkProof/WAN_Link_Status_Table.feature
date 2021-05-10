@run

Feature: WAN Link Status Table

  @SID_1
  Scenario: Login and Navigate to System and Network Dashboard page
    Then UI Login with user "radware" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage

  @SID_2
  Scenario: Go into Link Proof dashboard in second drill
    #click on linkProof device --- add the linkproof ip
    Given UI Click Button "Device Selection"
    Then UI Select scope from dashboard and Save Filter device type "Alteon"
      | Alteon_50.50.101.22 |
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Text of "LinkProofTab" equal to "LinkProof"
    Then UI Click Button "LinkProofTab"
    Then UI Text of "WAN Link Status Header" equal to "WAN Link Status"

  @SID_3
  Scenario: Validate The total number of row in table
    Then UI Validate "WAN Link Status Table" Table rows count EQUALS to 4

  @SID_4
  Scenario: Validate WAN Link Status Table table by Status Sorting
    Then UI Validate Table "WAN Link Status Table" is Sorted by
      | columnName | order      | compareMethod   |
      | Status     | DESCENDING | WAN_LINK_STATUS |
    Then UI Validate Table "WAN Link Status Table" is Sorted by
      | columnName | order     | compareMethod   |
      | Status     | Ascending | WAN_LINK_STATUS |



  @SID_5
  Scenario: Validate WAN1
    Then UI Validate Table record values by columns with elementLabel "WAN Link Status Table" findBy columnName "WAN Link ID" findBy cellValue "WAN1"
      | columnName  | value   |
      | Status      | Failed  |
      | WAN Link IP | 3.3.3.3 |
      | CEC         | 0       |
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Upload Throughput" findBy cellValue "150 Mbps / 384.8 Mbps 39%"
    Then UI validate Vision Table row by keyValue with elementLabel "WAN Link Status Table" findBy columnName "Download Throughput" findBy cellValue "167.8 Mbps / 209.7 Mbps 80%"


  Scenario: Logout
    Then UI logout and close browser