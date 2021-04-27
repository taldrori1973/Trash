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

