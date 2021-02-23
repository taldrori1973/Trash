@TC119484

Feature: Edit AppWall Parameters

  @SID_1
  Scenario: Login and Navigate
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "New Forensics" page via homepage

  @SID_2
  Scenario: create new Forensics AppWall and validate
    Then UI Click Button "New Forensics Tab"
    When UI "Create" Forensics With Name "Forensics AppWall"
      | Product      | AppWall |
      | Applications | All     |
    Given UI "Validate" Forensics With Name "Forensics AppWall"
      | Product      | AppWall |
      | Applications | All     |

  @SID_3
  Scenario: Edit Email
    Then UI "Edit" Forensics With Name "Forensics AppWall"
      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
    Then UI "Validate" Forensics With Name "Forensics AppWall"
      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |

  @SID_4
  Scenario: Edit Email FTP
    Then UI "Edit" Forensics With Name "Forensics AppWall"
      | Share | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
    Then UI "Validate" Forensics With Name "Forensics AppWall"
      | Share | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |

  @SID_5
  Scenario: Edit Format
    Then UI "Edit" Forensics With Name "Forensics AppWall"
      | Format | Select: HTML |
    Then UI "Validate" Forensics With Name "Forensics AppWall"
      | Format | Select: HTML |

  @SID_6
  Scenario: Edit Schedule
    Then UI "Edit" Forensics With Name "Forensics AppWall"
      | Schedule | Run Every:Monthly, On Time:+6H, At Months:[AUG] |
    Then UI "Validate" Forensics With Name "Forensics AppWall"
      | Schedule | Run Every:Monthly, On Time:+6H, At Months:[AUG] |

  @SID_7
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics AppWall"
      | Time Definitions.Date | Quick:Today |
    Then UI "Validate" Forensics With Name "Forensics AppWall"
      | Time Definitions.Date | Quick:Today |

  @SID_8
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics AppWall"
      | Time Definitions.Date | Quick:Yesterday |
    Then UI "Validate" Forensics With Name "Forensics AppWall"
      | Time Definitions.Date | Quick:Yesterday |

  @SID_9
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics AppWall"
      | Time Definitions.Date | Quick:This Month |
    Then UI "Validate" Forensics With Name "Forensics AppWall"
      | Time Definitions.Date | Quick:This Month |

  @SID_10
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics AppWall"
      | Time Definitions.Date | Quick:1D |
    Then UI "Validate" Forensics With Name "Forensics AppWall"
      | Time Definitions.Date | Quick:1D |

  @SID_11
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics AppWall"
      | Time Definitions.Date | Quick:1W |
    Then UI "Validate" Forensics With Name "Forensics AppWall"
      | Time Definitions.Date | Quick:1W |

  @SID_12
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics AppWall"
      | Time Definitions.Date | Quick:1M |
    Then UI "Validate" Forensics With Name "Forensics AppWall"
      | Time Definitions.Date | Quick:1M |

  @SID_13
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics AppWall"
      | Time Definitions.Date | Quick:3M |
    Then UI "Validate" Forensics With Name "Forensics AppWall"
      | Time Definitions.Date | Quick:3M |

  @SID_14
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics AppWall"
      | Time Definitions.Date | Quick:1Y |
    Then UI "Validate" Forensics With Name "Forensics AppWall"
      | Time Definitions.Date | Quick:1Y |

  @SID_15
  Scenario: Edit Output
    Then UI "Edit" Forensics With Name "Forensics AppWall"
      | Output | Source IP |
    Then UI "Validate" Forensics With Name "Forensics AppWall"
      | Output | Source IP |

  @SID_16
  Scenario: Edit Scope
    Then UI "Edit" Forensics With Name "Forensics AppWall"
      | Product      | AppWall |
      | Applications | Vision  |
    Then UI "Validate" Forensics With Name "Forensics AppWall"
      | Product      | AppWall |
      | Applications | Vision  |

  @SID_17
  Scenario: Edit Criteria
    Then UI "Edit" Forensics With Name "Forensics AppWall"
      | Criteria | Event Criteria:Action,Operator:Not Equals,Value:Modified |
    Then UI "Validate" Forensics With Name "Forensics AppWall"
      | Criteria | Event Criteria:Action,Operator:Not Equals,Value:Modified |

  @SID_18
  Scenario: Edit Forensics Product
    Then UI Click Button "Edit Forensics" with value "Forensics AppWall"
    Then UI Validate the attribute of "data-debug-enabled" are "EQUAL" to
      | label   | param       | value |
      | Product | DefensePro  | false |
      | Product | DefenseFlow | false |
      | Product | AppWall     | true  |
    Then UI Click Button "save"

  @SID_18
  Scenario: Edit Name
    Then UI Click Button "Edit Forensics" with value "Forensics AppWall"
    Then UI Set Text Field "Forensics Name" To "Forensics AppWall Updated"
    Then UI Click Button "save"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "true" with value "Forensics AppWall Updated"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "false" with value "Forensics AppWall"
    Then UI Delete Forensics With Name "Forensics AppWall Updated"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "false" with value "Forensics AppWall Updated"

  @SID_19
  Scenario: Logout
    Then UI logout and close browser


