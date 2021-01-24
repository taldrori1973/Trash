Feature: Deletion Instance

  @SID_1
  Scenario: Login
    Then UI Login with user "radware" and password "radware"

  @SID_2
  Scenario: Navigate to NEW ForensicsS page
    Then UI Navigate to "New Forensics" page via homepage
    Then UI Click Button "New Forensics Tab"

  @SID_3
  Scenario: Create and validate Forensics DefensePro
    When UI "Create" Forensics With Name "Forensics DefensePro"
      | Product               | DefensePro                                                                     |
      | Output                | Total Mbits Dropped                                                            |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Actions:Http 403 Forbidden           |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    When UI "Validate" Forensics With Name "Forensics DefensePro"
      | Product               | DefensePro                                                                     |
      | Output                | Total Mbits Dropped                                                            |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Actions:Http 403 Forbidden           |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |


  @SID_4
  Scenario: Validate delivery card and generate Forensics
    Then UI "Generate" Forensics With Name "Forensics DefensePro"
      | timeOut | 60 |


  @SID_5
  Scenario: Edit The Format and validate
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Format | Select: PDF |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Format | Select: PDF |

  @SID_6
  Scenario: Validate delivery card and generate Forensics
    Then UI "Generate" Forensics With Name "Forensics DefensePro"
      | timeOut | 60 |

  @SID_7
  Scenario: Edit The Time and validate
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:15m |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:15m |

  @SID_8
  Scenario: Validate delivery card and generate Forensics
    Then UI "Generate" Forensics With Name "Forensics DefensePro"
      | timeOut | 60 |

  @SID_9
  Scenario: Deletion Forensics Instance
    Then UI Validate Deletion of Forensics instance "Deletion Forensics Instance" with value "Forensics DefensePro_2"
    Then UI Validate Deletion of Forensics instance "Deletion Forensics Instance" with value "Forensics DefensePro_1"
    Then UI Validate Deletion of Forensics instance "Deletion Forensics Instance" with value "Forensics DefensePro_0"

  @SID_10
  Scenario: Edit The Time and validate
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:1H |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:1H |

  @SID_11
  Scenario: Validate delivery card and generate Forensics
    Then UI "Generate" Forensics With Name "Forensics DefensePro"
      | timeOut | 60 |

  @SID_12
  Scenario: Edit The Share Email and validate
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | share | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | share | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody |

  @SID_13
  Scenario: Validate delivery card and generate Forensics
    Then UI "Generate" Forensics With Name "Forensics DefensePro"
      | timeOut | 60 |

  @SID_14
  Scenario: Deletion Forensics Instance
    Then UI Validate Deletion of Forensics instance "Deletion Forensics Instance" with value "Forensics DefensePro_1"
    Then UI Validate Deletion of Forensics instance "Deletion Forensics Instance" with value "Forensics DefensePro_0"

  @SID_15
  Scenario: Delete Forensics
    Then UI Delete Forensics With Name "Forensics DefensePro"

  @SID_16
  Scenario: Logout
    Then UI logout and close browser
