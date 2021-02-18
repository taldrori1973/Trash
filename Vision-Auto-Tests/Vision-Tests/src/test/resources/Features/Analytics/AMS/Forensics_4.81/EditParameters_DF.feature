@TC119483
Feature: Edit DefenseFlow Parameters

  @SID_1
  Scenario: Login and Navigate
    * REST Delete ES index "forensics-*"
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "New Forensics" page via homepage

  @SID_2
  Scenario: create new Forensics DefenseFlow and validate
    Then UI Click Button "New Forensics Tab"
    When UI "Create" Forensics With Name "Forensics DefenseFlow"
      | Product           | DefenseFlow |
      | Protected Objects | All         |
      | Output            | Action      |
    Given UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Product           | DefenseFlow |
      | Protected Objects | All         |
      | Output            | Action      |

  @SID_3
  Scenario: Edit Email
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |

  @SID_4
  Scenario: Edit Email FTP
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Share | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Share | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |

  @SID_5
  Scenario: Edit Format
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Format | Select: CSV |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Format | Select: CSV |

  @SID_6
  Scenario: Edit Format
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Format | Select: CSVWithDetails |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Format | Select: CSVWithDetails |

  @SID_7
  Scenario: Edit Format
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Format | Select: HTML |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Format | Select: HTML |

  @SID_8
  Scenario: Edit Schedule
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Schedule | Run Every:Monthly, On Time:+6H, At Months:[AUG] |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Schedule | Run Every:Monthly, On Time:+6H, At Months:[AUG] |

  @SID_9
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Time Definitions.Date | Quick:Today |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Time Definitions.Date | Quick:Today |
    Then UI Text of "Forensics Time Type" equal to "Today"

  @SID_10
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Time Definitions.Date | Quick:Yesterday |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Time Definitions.Date | Quick:Yesterday |

  @SID_11
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Time Definitions.Date | Quick:This Month |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Time Definitions.Date | Quick:This Month |

  @SID_12
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Time Definitions.Date | Quick:1D |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Time Definitions.Date | Quick:1D |

  @SID_13
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Time Definitions.Date | Quick:1W |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Time Definitions.Date | Quick:1W |

  @SID_14
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Time Definitions.Date | Quick:1M |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Time Definitions.Date | Quick:1M |

  @SID_15
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Time Definitions.Date | Quick:3M |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Time Definitions.Date | Quick:3M |

  @SID_16
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Time Definitions.Date | Quick:1Y |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Time Definitions.Date | Quick:1Y |

  @SID_17
  Scenario: Edit Output
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Output | Direction |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Output | Direction |

  @SID_18
  Scenario: Edit Scope
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Product           | DefenseFlow   |
      | Protected Objects | PO Name Space |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Product           | DefenseFlow   |
      | Protected Objects | PO Name Space |

  @SID_19
  Scenario: Edit Criteria
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Criteria | Event Criteria:Action,Operator:Not Equals,Value:Http 403 Forbidden |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Criteria | Event Criteria:Action,Operator:Not Equals,Value:Http 403 Forbidden |

  @SID_20
  Scenario: Edit Name
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | New Forensics Name | Forensics DefenseFlow Updated |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow Updated"
      | Product               | DefenseFlow                                                                                                      |
      | Protected Objects     | PO Name Space                                                                                                    |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Http 403 Forbidden                                               |
      | Output                | Direction                                                                                                        |
      | Format                | Select: HTML                                                                                                     |
      | Time Definitions.Date | Quick:1Y |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                   |
    Then UI Delete Forensics With Name "Forensics DefenseFlow Updated"

  @SID_21
  Scenario: Logout
    Then UI logout and close browser


