@TC119482
Feature: Edit DefensePro Parameters

  @SID_1
  Scenario: Login and Navigate
    * REST Delete ES index "forensics-*"
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "New Forensics" page via homepage

  @SID_2
  Scenario: create new Forensics DefensePro and validate
    Then UI Click Button "New Forensics Tab"
    When UI "Create" Forensics With Name "Forensics DefensePro"
      | Product | DefensePro |
      | devices | All        |
    Given UI "Validate" Forensics With Name "Forensics DefensePro"
      | Product | DefensePro |
      | devices | All        |

  @SID_3
  Scenario: Edit Email
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Share | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |

  @SID_4
  Scenario: Edit Email FTP
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Share | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Share | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |

  @SID_5
  Scenario: Edit Format
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Format | Select: CSV |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Format | Select: CSV |

  @SID_6
  Scenario: Edit Format
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Format | Select: CSVWithDetails |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Format | Select: CSVWithDetails |

  @SID_7
  Scenario: Edit Format
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Format | Select: HTML |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Format | Select: HTML |

  @SID_8
  Scenario: Edit Schedule
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Schedule | Run Every:Monthly, On Time:+6H, At Months:[AUG] |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Schedule | Run Every:Monthly, On Time:+6H, At Months:[AUG] |

  @SID_9
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:Today |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:Today |

  @SID_11
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:Yesterday |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:Yesterday |

  @SID_12
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:This Month |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:This Month |


  @SID_13
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:1D |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:1D |

  @SID_14
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:1W |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:1W |


  @SID_15
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:1M |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:1M |

  @SID_16
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:3M |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:3M |

  @SID_17
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:1Y |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:1Y |

  @SID_18
  Scenario: Edit Output
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Output | Direction |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Output | Direction |

  @SID_19
  Scenario: Edit Scope
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Product | DefensePro |
      | devices | index:10   |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Product | DefensePro |
      | devices | index:10   |

  @SID_20
  Scenario: Edit Scope policy
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Product | DefensePro               |
      | devices | index:10,policies:[BDOS] |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Product | DefensePro                   |
      | devices | index:10,policies:[Policy15] |

  @SID_21
  Scenario: Edit Scope port
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Product | DefensePro                             |
      | devices | index:10,policies:[Policy15],ports:[1] |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Product | DefensePro                             |
      | devices | index:10,policies:[Policy15],ports:[1] |

  @SID_22
  Scenario: Edit Criteria
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Criteria | Event Criteria:Action,Operator:Not Equals,Value:Http 403 Forbidden |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Criteria | Event Criteria:Action,Operator:Not Equals,Value:Http 403 Forbidden |

  @SID_23
  Scenario: Edit Name
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | New Forensics Name | Forensics DefensePro Updated |
    Then UI "Validate" Forensics With Name "Forensics DefensePro Updated"
      | Product               | DefensePro                                                                                                       |
      | devices               | index:10,policies:[Policy15],ports:[1]                                                                           |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Http 403 Forbidden                                               |
      | Output                | Direction                                                                                                        |
      | Format                | Select: HTML                                                                                                     |
      | Time Definitions.Date | Quick:1Y                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                   |
    Then UI Delete Forensics With Name "Forensics DefensePro Updated"

  @SID_24
  Scenario: Logout
    Then UI logout and close browser


