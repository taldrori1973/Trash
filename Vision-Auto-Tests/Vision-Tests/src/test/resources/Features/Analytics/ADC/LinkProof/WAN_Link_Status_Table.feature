
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
  Scenario: Validate the number of rows in WAN Link Status Table
    Then UI Validate "WAN Link Status Table" Table rows count EQUALS to 4


  @SID_4
  Scenario: Validate WAN1 Row
    Then UI Validate Table record values by columns with elementLabel "LinkProofTab" findBy columnName "WAN Link ID" findBy cellValue "WAN1"
      | columnName          | value   |
      | Status              | Failed  |
      | WAN Link IP         | 3.3.3.3 |
      | Upload Throughput   | 39%     |
      | Download Throughput | 80%     |
      | CEC                 | 0       |

  @SID_5
  Scenario: Validate WAN2 Row
    Then UI Validate Table record values by columns with elementLabel "LinkProofTab" findBy columnName "WAN Link ID" findBy cellValue "WAN2"
      | columnName          | value |
      | Status              |       |
      | WAN Link IP         |       |
      | Upload Throughput   |       |
      | Download Throughput |       |
      | CEC                 |       |

  @SID_6
  Scenario: Validate WAN3 Row
    Then UI Validate Table record values by columns with elementLabel "LinkProofTab" findBy columnName "WAN Link ID" findBy cellValue "WAN3"
      | columnName          | value |
      | Status              |       |
      | WAN Link IP         |       |
      | Upload Throughput   |       |
      | Download Throughput |       |
      | CEC                 |       |

  @SID_
  Scenario: Logout
    Then UI logout and close browser