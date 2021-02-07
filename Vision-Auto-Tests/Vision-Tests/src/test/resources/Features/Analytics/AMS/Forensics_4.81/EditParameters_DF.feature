@TC119483
Feature: Edit DefenseFlow Parameters

  @SID_1
  Scenario: Login and Navigate
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
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow Updated"
      | Share | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |

  @SID_5
  Scenario: Edit Format
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Format | Select: HTML |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Format | Select: HTML |

  @SID_6
  Scenario: Edit Schedule
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Schedule | Run Every:Monthly, On Time:+6H, At Months:[AUG] |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Schedule | Run Every:Monthly, On Time:+6H, At Months:[AUG] |

  @SID_7
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Time Definitions.Date | Quick:1W |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Time Definitions.Date | Quick:1W |

  @SID_8
  Scenario: Edit Output
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Output | Total Mbits Dropped,Direction |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Output | Total Mbits Dropped,Direction |

  @SID_9
  Scenario: Edit Scope
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | Product           | DefenseFlow   |
      | Protected Objects | PO Name Space |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow"
      | Product           | DefenseFlow   |
      | Protected Objects | PO Name Space |

#  @SID_10
#  Scenario: Edit Critiria

  @SID_11
  Scenario: Edit Name
    Then UI "Edit" Forensics With Name "Forensics DefenseFlow"
      | New Forensics Name | Forensics DefenseFlow Updated |
    Then UI "Validate" Forensics With Name "Forensics DefenseFlow Updated"
      | Product               | DefenseFlow                                                                                                      |
      | Protected Objects     | PO Name Space                                                                                                    |
      | Output                | Total Mbits Dropped,Direction                                                                                    |
      | Format                | Select: HTML                                                                                                     |
      | Time Definitions.Date | Quick:1W                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                   |
    Then UI Delete Forensics With Name "Forensics DefenseFlow Updated"

  @SID_12
  Scenario: Logout
    Then UI logout and close browser


