@TC121703
Feature: Current

  @SID_1
  Scenario: Login and Navigate to System and Network Dashboard page
    Then UI Login with user "radware" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage

  @SID_2
  Scenario: Go into Link Proof dashboard in second drill
    #click on linkProof device --- add the linkproof ip
    Given UI Click Button "Device Selection"
    Then UI Select scope from dashboard and Save Filter device type "Alteon"
      | Simulator-50.50.101.101 |
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Simulator-50.50.101.101"
    Then UI Text of "LinkProofTab" equal to "LinkProof"
    Then UI Click Button "LinkProofTab"

  @SID_3
  Scenario: Validate the Current Header
    Then UI Text of "Current Header" equal to "Current"

    #------------------------------------Total Statistics Tests---------------------
  @SID_4
  Scenario: Validate the Total Statistics Header
    Then UI Text of "Total Statistics Header" equal to "Total Statistics"

  @SID_5
  Scenario: Validate the Upload Throughput (bps)
    Then UI Text of "Total Statistics Label" with extension "Upload Throughput" equal to "Upload Throughput (bps)"
    Then UI Text of "Total Statistics Value" with extension "Upload Throughput" equal to "42.2 M"

  @SID_6
  Scenario: Validate the Download Throughput (bps)
    Then UI Text of "Total Statistics Label" with extension "Download Throughput" equal to "Download Throughput (bps)"
    Then UI Text of "Total Statistics Value" with extension "Download Throughput" equal to "65.5 K"

  @SID_7
  Scenario: Validate the Download Throughput (bps)
    Then UI Text of "Total Statistics Label" with extension "CEC" equal to "CEC"
    Then UI Text of "Total Statistics Value" with extension "CEC" equal to "513.3 K"

#------------------------------------status Tests---------------------
  @SID_8
  Scenario: Validate the Status Header
    Then UI Text of "Status Header" equal to "Status"

  @SID_9
  Scenario: Validate the Running
    Then UI Text of "Status Label" with extension "Running" equal to "Running"
    Then UI Text of "Status Value" with extension "Running" equal to "2"
    Then validate webUI CSS value "background-color" of label "Status Color" with params "Running" equals "rgb(19, 211, 177)"

  @SID_10
  Scenario: Validate the Down
    Then UI Text of "Status Label" with extension "failed" equal to "Failed"
    Then UI Text of "Status Value" with extension "failed" equal to "7"
    Then validate webUI CSS value "background-color" of label "Status Color" with params "failed" equals "rgb(255, 68, 65)"

  @SID_11
  Scenario: Validate the Disabled
    Then UI Text of "Status Label" with extension "Disabled" equal to "Disabled"
    Then UI Text of "Status Value" with extension "Disabled" equal to "0"
    Then validate webUI CSS value "background-color" of label "Status Color" with params "Disabled" equals "rgb(212, 212, 212)"

  @SID_12
  Scenario: Validate attributes of Current Status
    Then UI Validate Pie Chart data "linkProofDoughnutChart"
      | label    | backgroundcolor | data |
      | Running  | #13d3b1         | 2    |
      | Failed   | #ff4441         | 7    |
      | Disabled | #d4d4d4         | 0    |

  @SID_13
  Scenario: Logout
    Then UI logout and close browser