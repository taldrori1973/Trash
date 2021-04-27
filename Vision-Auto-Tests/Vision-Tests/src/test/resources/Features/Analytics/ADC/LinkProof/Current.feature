Feature: Current

  @SID_1
  Scenario: Login and Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage

  @SID_2
  Scenario: Go into Link Proof dashboard in second drill
    #click on linkProof device --- add the linkproof ip
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
  Scenario: Validate the Upload Throuhput (bps)
    Then UI Text of "Total Statistics Label" with extension "Upload Throuhput" equal to "Upload Throuput (bps)"
    Then UI Text of "Total Statistics Value" with extension "Upload Throuhput" equal to "42.2 M"

  @SID_6
  Scenario: Validate the Download Throuhput (bps)
    Then UI Text of "Total Statistics Label" with extension "Download Throuhput" equal to "Download (bps)"
    Then UI Text of "Total Statistics Value" with extension "Download Throuhput" equal to "65.5 K"

  @SID_7
  Scenario: Validate the Download Throuhput (bps)
    Then UI Text of "Total Statistics Label" with extension "CEC" equal to "CEC"
    Then UI Text of "Total Statistics Value" with extension "CEC" equal to "513.3 K"

#------------------------------------status Tests---------------------
  @SID_8
  Scenario: Validate the Status Header
    Then UI Text of "Status Header" equal to "Status"





