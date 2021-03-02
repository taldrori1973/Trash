@TC119418

Feature: Deletion Instance

  @SID_1
  Scenario: Login
    * REST Delete ES index "forensics-*"
    Then UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Vision Install License Request "vision-AVA-AppWall"
    * REST Vision Install License Request "vision-reporting-module-AMS"

  @SID_2
  Scenario: Navigate to NEW ForensicsS page
    Then UI Navigate to "New Forensics" page via homepage
    Then UI Click Button "New Forensics Tab"

  @SID_3
  Scenario: Create and validate Forensics DefensePro
    When UI "Create" Forensics With Name "Forensics DefensePro"
      | Product | DefensePro          |
      | Format  | Select: CSV         |
    When UI "Validate" Forensics With Name "Forensics DefensePro"
      | Product | DefensePro          |
      | Format  | Select: CSV         |

  @SID_4
  Scenario: Validate delivery card and generate Forensics
    Then UI Click Button "My Forensics" with value "Forensics DefensePro"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensics DefensePro"
    Then Sleep "35"


  @SID_5
  Scenario: Edit The Format and validate
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Format | Select: HTML |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Format | Select: HTML |

  @SID_6
  Scenario: Validate delivery card and generate Forensics
    Then UI Click Button "My Forensics" with value "Forensics DefensePro"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensics DefensePro"
    Then Sleep "35"

  @SID_7
  Scenario: Edit The Time and validate
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:1D |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:1D |

  @SID_8
  Scenario: Validate delivery card and generate Forensics
    Then UI Click Button "My Forensics" with value "Forensics DefensePro"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensics DefensePro"
    Then Sleep "35"

  @SID_9
  Scenario: Deletion Forensics Instance
    Then UI Validate Deletion of Forensics instance "Deletion Forensics Instance" with value "Forensics DefensePro_2"
    Then UI Validate Deletion of Forensics instance "Deletion Forensics Instance" with value "Forensics DefensePro_1"
    Then UI Validate Deletion of Forensics instance "Deletion Forensics Instance" with value "Forensics DefensePro_0"

  @SID_10
  Scenario: Edit The Time and validate
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:1W |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:1W |

  @SID_11
  Scenario: Validate delivery card and generate Forensics
    Then UI Click Button "My Forensics" with value "Forensics DefensePro"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensics DefensePro"
    Then Sleep "35"

  @SID_12
  Scenario: Deletion Forensics Instance
    Then UI Validate Deletion of Forensics instance "Deletion Forensics Instance" with value "Forensics DefensePro_0"

  @SID_13
  Scenario: Delete Forensics
    Then UI Delete Forensics With Name "Forensics DefensePro"

  @SID_14
  Scenario: Logout
    Then UI logout and close browser
