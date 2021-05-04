
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
      | Alteon_50.50.101.22 |
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
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
    Then UI Text of "Total Statistics Label" with extension "Download Throughput" equal to "Download (bps)"
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
    Then UI Text of "Status Label" with extension "Runnung" equal to "Runnung"
    Then UI Text of "Status Value" with extension "Runnung" equal to "30"
    Then validate webUI CSS value "border-bottom-color" of label "Status Color" with params "Runnung" equals "#13d3b1"

  @SID_10
  Scenario: Validate the Down
    Then UI Text of "Status Label" with extension "Failed" equal to "Failed"
    Then UI Text of "Status Value" with extension "Failed" equal to "10"
    Then validate webUI CSS value "border-bottom-color" of label "Status Color" with params "Failed" equals "#ff4441"

  @SID_11
  Scenario: Validate the Disabled
    Then UI Text of "Status Label" with extension "Disabled" equal to "Disabled"
    Then UI Text of "Status Value" with extension "Disabled" equal to "20"
    Then validate webUI CSS value "border-bottom-color" of label "Status Color" with params "Disabled" equals "#d4d4d4"

  @SID_12
  Scenario: Validate attributes of Current Status
    Then UI Validate Pie Chart data "Status"
      | label     | backgroundcolor           |
      | Running   | rgba(4, 194, 160, 0.35)   |
      | Failed    | rgba(255, 68, 65, 0.35)   |
      | Disabled  | rgba(210, 210, 210, 0.35) |
