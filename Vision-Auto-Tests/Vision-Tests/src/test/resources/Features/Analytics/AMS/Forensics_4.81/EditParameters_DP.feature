@TC119482
Feature: Edit DefensePro Parameters

  @SID_1
  Scenario: Login and Navigate
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "New Forensics" page via homepage

  @SID_2
  Scenario: create new Forensics DefensePro and validate
    Then UI Click Button "New Forensics Tab"
    When UI "Create" Forensics With Name "Forensics DefensePro"
      | Product | DefensePro |
      | devices | All        |
      | Output  | Action     |
    Given UI "Validate" Forensics With Name "Forensics DefensePro"
      | Product | DefensePro |
      | devices | All        |
      | Output  | Action     |


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
    Then UI "Validate" Forensics With Name "Forensics DefensePro Updated"
      | Share | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |

  @SID_5
  Scenario: Edit Format
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Format | Select: HTML |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Format | Select: HTML |

  @SID_6
  Scenario: Edit Schedule
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Schedule | Run Every:Monthly, On Time:+6H, At Months:[AUG] |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Schedule | Run Every:Monthly, On Time:+6H, At Months:[AUG] |

  @SID_7
  Scenario: Edit Time
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:1W |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Time Definitions.Date | Quick:1W |

  @SID_8
  Scenario: Edit Output
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Output | Total Mbits Dropped,Direction |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Output | Total Mbits Dropped,Direction |

  @SID_9
  Scenario: Edit Scope
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Product | DefensePro |
      | devices | index:10   |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Product | DefensePro |
      | devices | index:10   |

  @SID_10
  Scenario: Edit Scope policy
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Product | DefensePro               |
      | devices | index:10,policies:[BDOS] |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Product | DefensePro                   |
      | devices | index:10,policies:[Policy15] |

  @SID_11
  Scenario: Edit Scope port
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | Product | DefensePro         |
      | devices | index:10,ports:[1] |
    Then UI "Validate" Forensics With Name "Forensics DefensePro"
      | Product | DefensePro         |
      | devices | index:10,ports:[1] |


#  @SID_12
#  Scenario: Edit Critiria


  @SID_13
  Scenario: Edit Name
    Then UI "Edit" Forensics With Name "Forensics DefensePro"
      | New Forensics Name | Forensics DefensePro Updated |
    Then UI "Validate" Forensics With Name "Forensics DefensePro Updated"
      | Product               | DefensePro                                                                                                       |
      | devices               | index:10                                                                                                         |
      | Output                | Total Mbits Dropped,Direction                                                                                    |
      | Format                | Select: HTML                                                                                                     |
      | Time Definitions.Date | Quick:1W                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                   |
    Then UI Delete Forensics With Name "Forensics DefensePro Updated"

  @SID_14
  Scenario: Logout
    Then UI logout and close browser


