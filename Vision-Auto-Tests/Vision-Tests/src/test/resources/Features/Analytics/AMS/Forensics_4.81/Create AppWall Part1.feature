@TC119584
Feature:Create AppWall Part1

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    * REST Delete ES index "forensics-*"
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "New Forensics" page via homePage

  @SID_2
  Scenario: create new Output Date and Time
    When UI "Create" Forensics With Name " Output Date and Time"
      | Product               | AppWall                                                                        |
      | Output                | Date and Time                                                                  |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_3
  Scenario: create new Output Device IP
    When UI "Create" Forensics With Name " Output Device IP"
      | Product               | AppWall                                                                                                          |
      | Output                | Device IP                                                                                                        |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | index:10                                                                                                         |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_4
  Scenario: create new Output Source IP
    When UI "Create" Forensics With Name " Output Source IP"
      | Product               | AppWall                                                                        |
      | Output                | Source IP                                                                      |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_5
  Scenario: create new Output Destination IP Address
    When UI "Create" Forensics With Name " Output Destination IP Address"
      | Product               | AppWall                                                                                                          |
      | Output                | Destination IP Address                                                                                           |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | index:10                                                                                                         |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                   |

  @SID_6
  Scenario: create new Output Source Port
    When UI "Create" Forensics With Name " Output Source Port"
      | Product               | AppWall                                                                        |
      | Output                | Source Port                                                                    |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_7
  Scenario: create new Output Cluster Manager IP
    When UI "Create" Forensics With Name " Output Cluster Manager IP "
      | Product               | AppWall                                                                                                          |
      | Output                | Cluster Manager IP                                                                                               |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | index:10                                                                                                         |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_8
  Scenario: create new Output Web Application Name
    When UI "Create" Forensics With Name " Output Web Application Name"
      | Product               | AppWall                                                                        |
      | Output                | Web Application Name                                                           |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[TUE]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_9
  Scenario: create new Output Event Description
    When UI "Create" Forensics With Name " Output Event Description"
      | Product               | AppWall                                                                                                          |
      | Output                | Event Description                                                                                                |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | index:10                                                                                                         |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                   |

  @SID_10
  Scenario: create new Output Action
    When UI "Create" Forensics With Name " Output Action"
      | Product               | AppWall                                                                        |
      | Output                | Action                                                                         |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Weeks,2]                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_11
  Scenario: create new Output Attack Name
    When UI "Create" Forensics With Name " Output Attack Name"
      | Product               | AppWall                                                                                                          |
      | Output                | Attack Name                                                                                                      |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | index:10                                                                                                         |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_12
  Scenario: create new Output Device Host Name
    When UI "Create" Forensics With Name " Output Device Host Name"
      | Product               | AppWall                                                                        |
      | Output                | Device Host Name                                                               |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Quick:1Y                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_13
  Scenario: create new Output Directory
    When UI "Create" Forensics With Name " Output Directory"
      | Product               | AppWall                                                                                                          |
      | Output                | Directory                                                                                                        |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | index:10                                                                                                         |
      | Time Definitions.Date | Quick:This Month                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                   |

  @SID_14
  Scenario: create new Output Module
    When UI "Create" Forensics With Name " Output Module"
      | Product               | AppWall                                                                        |
      | Output                | Module                                                                         |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_15
  Scenario: create new Output Severity
    When UI "Create" Forensics With Name " Output Severity"
      | Product               | AppWall                                                                                                          |
      | Output                | Severity                                                                                                         |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | index:10                                                                                                         |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_16
  Scenario: create new Output Threat Category
    When UI "Create" Forensics With Name " Output Threat Category"
      | Product               | AppWall                                                                        |
      | Output                | Threat Category                                                                |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_17
  Scenario: create new Output Transaction ID
    When UI "Create" Forensics With Name " Output Transaction ID"
      | Product               | AppWall                                                                                                          |
      | Output                | Transaction ID                                                                                                   |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | index:10                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                   |

  @SID_18
  Scenario: create new Output Tunnel
    When UI "Create" Forensics With Name " Output Tunnel"
      | Product               | AppWall                                                                        |
      | Output                | Tunnel                                                                         |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_19
  Scenario: create new Output User Name
    When UI "Create" Forensics With Name " Output User Name"
      | Product               | AppWall                                                                                                          |
      | Output                | User Name                                                                                                        |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | index:10                                                                                                         |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_20
  Scenario: create new Output all1
    When UI "Create" Forensics With Name " Output all1"
      | Product               | AppWall                                                                                                                                                                                                                          |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | condition.All:true                                                                                                                                                                                                               |
      | devices               | index:10                                                                                                                                                                                                                         |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                                                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                   |
      | Format                | Select: CSV                                                                                                                                                                                                                      |

  @SID_21
  Scenario: create new Output all2
    When UI "Create" Forensics With Name " Output all2"
      | Product               | AppWall                                                                                                                                                                                                                          |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | condition.All:true                                                                                                                                                                                                               |
      | devices               | index:10                                                                                                                                                                                                                         |
      | Time Definitions.Date | Quick:3M                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                                                                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                 |
      | Format                | Select: CSV With Attack Details                                                                                                                                                                                                   |

  @SID_22
  Scenario: create new Output all3
    When UI "Create" Forensics With Name " Output all3"
      | Product               | AppWall                                                                                                                                                                                                                          |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | condition.All:true                                                                                                                                                                                                               |
      | devices               | index:10                                                                                                                                                                                                                         |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                   |
      | Format                | Select: HTML                                                                                                                                                                                                                     |

  @SID_23
  Scenario: create new Output all4
    When UI "Create" Forensics With Name " Output all4"
      | Product               | AppWall                                                                                                                                                                                                                          |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | condition.All:true                                                                                                                                                                                                               |
      | devices               | index:10                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                   |
      | Format                | Select: HTML                                                                                                                                                                                                                     |

  @SID_24
  Scenario: create new Output all5
    When UI "Create" Forensics With Name " Output all5"
      | Product               | AppWall                                                                                                                                                                                                                          |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | condition.All:true                                                                                                                                                                                                               |
      | devices               | index:10                                                                                                                                                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                   |
      | Format                | Select: CSV                                                                                                                                                                                                                      |

  @SID_25
  Scenario: create new Output all6
    When UI "Create" Forensics With Name " Output all6"
      | Product               | AppWall                                                                                                                                                                                                                          |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | condition.All:true                                                                                                                                                                                                               |
      | devices               | index:10                                                                                                                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                 |
      | Format                | Select: CSV With Attack Details                                                                                                                                                                                                   |

  @SID_26
  Scenario: create new Output all7
    When UI "Create" Forensics With Name " Output all7"
      | Product               | AppWall                                                                                                                                                                                                                          |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | condition.All:true                                                                                                                                                                                                               |
      | devices               | index:10                                                                                                                                                                                                                         |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                   |
      | Format                | Select: HTML                                                                                                                                                                                                                     |

  @SID_27
  Scenario: create new Output all8
    When UI "Create" Forensics With Name " Output all8"
      | Product               | AppWall                                                                                                                                                                                                                          |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | condition.All:true                                                                                                                                                                                                               |
      | devices               | index:10                                                                                                                                                                                                                         |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                 |
      | Format                | Select: CSV                                                                                                                                                                                                                      |


  @SID_28
  Scenario: create new Output Event Description,Action,Attack Name,Device Host Name
    When UI "Create" Forensics With Name " Output Event Description_Action_Attack Name_Device Host Name"
      | Product               | AppWall                                                                        |
      | Output                | Event Description,Action,Attack Name,Device Host Name                          |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_29
  Scenario: create new Output Device IP,Source IP,Destination IP Address,Cluster Manager IP
    When UI "Create" Forensics With Name " Output Device IP_Source IP,Destination IP Address_Cluster Manager IP"
      | Product               | AppWall                                                                                                          |
      | Output                | Device IP,Source IP,Destination IP Address,Cluster Manager IP                                                    |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | index:10                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                   |

  @SID_30
  Scenario: create new Output Date and Time,Destination IP Address
    When UI "Create" Forensics With Name " Output Date and Time_Destination IP Address"
      | Product               | AppWall                                                                        |
      | Output                | Date and Time,Destination IP Address                                           |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_31
  Scenario: create new Output Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name
    When UI "Create" Forensics With Name " Output Web Application Name_Event Description_Action_Attack Name_Device Host Name_Directory_Module_Severity_Threat Category_Transaction ID_Tunnel_User Name"
      | Product               | AppWall                                                                                                                                              |
      | Output                | Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | condition.All:true                                                                                                                                   |
      | devices               | index:10                                                                                                                                             |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                   |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                          |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                     |
      | Format                | Select: CSV                                                                                                                                          |

  @SID_32
  Scenario: create new Output Action,Threat Category
    When UI "Create" Forensics With Name " Output Action_Threat Category"
      | Product               | AppWall                                                                        |
      | Output                | Action,Threat Category                                                         |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Quick:1Y                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_33
  Scenario: create new Output Web Application Name,Event Description,Attack Name,Device Host Name,Directory,Module,Severity,Transaction ID,Tunnel,User Name
    When UI "Create" Forensics With Name " Output Web Application Name_Event Description_Attack Name_Device Host Name_Directory_Module_Severity_Transaction ID_Tunnel_User Name"
      | Product               | AppWall                                                                                                                       |
      | Output                | Web Application Name,Event Description,Attack Name,Device Host Name,Directory,Module,Severity,Transaction ID,Tunnel,User Name |
      | Criteria              | condition.All:true                                                                                                            |
      | devices               | index:10                                                                                                                      |
      | Time Definitions.Date | Quick:This Month                                                                                                              |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                   |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware              |
      | Format                | Select: CSV With Attack Details                                                                                                |

  @SID_34
  Scenario: create new Output Date and Time,Device IP,Source IP,Destination IP Address,Action,Threat Category
    When UI "Create" Forensics With Name " Output Date and Time_Device IP_Source IP_Destination IP Address_Action_Threat Category"
      | Product               | AppWall                                                                         |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Action,Threat Category |
      | Criteria              | condition.All:true                                                              |
      | devices               | index:10                                                                        |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body  |
      | Format                | Select: HTML                                                                    |

  @SID_35
  Scenario: create new Output Date and Time,Device IP,Source Port,Web Application Name,Action,Attack Name,Threat Category,Transaction ID
    When UI "Create" Forensics With Name " Output Date and Time_Device IP_Source Port_Web Application Name_Action_Attack Name_Threat Category_Transaction ID"
      | Product               | AppWall                                                                                                          |
      | Output                | Date and Time,Device IP,Source Port,Web Application Name,Action,Attack Name,Threat Category,Transaction ID       |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_36
  Scenario: create new Output Source IP,Destination IP Address,Cluster Manager IP,Event Description,Device Host Name,Directory,Module,Severity,Tunnel,User Name
    When UI "Create" Forensics With Name " Output Source IP_Destination IP Address_Cluster Manager IP_Event Description_Device Host Name_Directory_Module_Severity_Tunnel_User Name"
      | Product               | AppWall                                                                                                                           |
      | Output                | Source IP,Destination IP Address,Cluster Manager IP,Event Description,Device Host Name,Directory,Module,Severity,Tunnel,User Name |
      | Criteria              | condition.All:true                                                                                                                |
      | devices               | All                                                                                                                               |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                  |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                    |
      | Format                | Select: CSV                                                                                                                       |

  @SID_36
  Scenario: create new Output Cluster Manager IP,Attack Name
    When UI "Create" Forensics With Name " Output Cluster Manager IP_Attack Name"
      | Product               | AppWall                                                                                                          |
      | Output                | Cluster Manager IP,Attack Name                                                                                   |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:3M                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                   |

  @SID_38
  Scenario: create new Output Source IP,Directory
    When UI "Create" Forensics With Name " Output Source IP_Directory"
      | Product               | AppWall                                                                        |
      | Output                | Source IP,Directory                                                            |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Quick:This Month                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_39
  Scenario: create new Output Destination IP Address,Cluster Manager IP,Event Description,Device Host Name,Severity,User Name Equal Action
    When UI "Create" Forensics With Name " Output Destination IP Address_Cluster Manager IP_Event Description_Device Host Name_Severity_User Name Equal Action"
      | Product               | AppWall                                                                                          |
      | Output                | Destination IP Address,Cluster Manager IP,Event Description,Device Host Name,Severity,User Name  |
      | Criteria              | Event Criteria:Action,Operator:Equals,Actions:Modified                                           |
      | devices               | index:10                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                   |
      | Format                | Select: HTML                                                                                     |

  @SID_40
  Scenario: create new Output Date and Time Equal Action
    When UI "Create" Forensics With Name " Output Date and Time Equal Action"
      | Product               | AppWall                                                                        |
      | Output                | Date and Time                                                                  |
      | Criteria              | Event Criteria:Action,Operator:Equals,Actions:Blocked                          |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_41
  Scenario: create new Output Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category Not Equal Action
    When UI "Create" Forensics With Name " Output Destination IP Address,Source Port_Cluster Manager IP_Web Application Name_Event Description_Action_Attack Name_Device Host Name_Directory_Module_Severity_Threat Category Not Equal Action"
      | Product               | AppWall                                                                                                                                                                    |
      | Output                | Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Actions:Reported                                                                                                                 |
      | devices               | All                                                                                                                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                            |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                           |
      | Format                | Select: CSV With Attack Details                                                                                                                                             |

  @SID_42
  Scenario: create new Output Date and Time,Device IP,Source IP,Transaction ID,Tunnel Equal Action
    When UI "Create" Forensics With Name " Output Date and Time_Device IP_Source IP_Transaction ID_Tunnel Equal Action"
      | Product               | AppWall                                                                        |
      | Output                | Date and Time,Device IP,Source IP,Transaction ID,Tunnel                        |
      | Criteria              | Event Criteria:Action,Operator:Equals,Actions:Modified,Blocked,Reported        |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_43
  Scenario: create new Output all1 Not Equal Action
    When UI "Create" Forensics With Name " Output all1 Not Equal Action"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Actions:Modified,Reported                                                                                                                                                                          |
      | devices               | All                                                                                                                                                                                                                                          |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                           |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                             |
      | Format                | Select: CSV                                                                                                                                                                                                                                  |

  @SID_44
  Scenario: create new Output all2 Not Equal Action
    When UI "Create" Forensics With Name " Output all2 Not Equal Action"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Actions:Modified,Blocked                                                                                                                                                                           |
      | devices               | All                                                                                                                                                                                                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                               |
      | Format                | Select: CSV                                                                                                                                                                                                                                  |

  @SID_45
  Scenario: create new Output all3 Not Equal Action
    When UI "Create" Forensics With Name " Output all3 Not Equal Action"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Actions:Modified,Blocked,Reported                                                                                                                                                                  |
      | devices               | All                                                                                                                                                                                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                             |
      | Format                | Select: CSV With Attack Details                                                                                                                                                                                                               |

  @SID_46
  Scenario: create new Output all1 Equal Attack Name
    When UI "Create" Forensics With Name " Output all1 Equal Attack Name"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Attack Name,Operator:Equals,Value:TCP Port Scan                                                                                                                                                                               |
      | devices               | index:10                                                                                                                                                                                                                                     |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                               |
      | Format                | Select: HTML                                                                                                                                                                                                                                 |

  @SID_47
  Scenario: create new Output all2 Not Equal Attack Name
    When UI "Create" Forensics With Name " Output all1 Not Equal Attack Name"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Attack Name,Operator:Not Equals,Value:Conn_Limit                                                                                                                                                                              |
      | devices               | All                                                                                                                                                                                                                                          |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                           |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                             |
      | Format                | Select: CSV                                                                                                                                                                                                                                  |

  @SID_48
  Scenario: create new Output all1 Equal Cluster IP
    When UI "Create" Forensics With Name " Output all1 Equal Cluster IP"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Cluster IP,Operator:Equals,IPType:IPv4,IPValue:1.1.1.1                                                                                                                                                                        |
      | devices               | All                                                                                                                                                                                                                                          |
      | Time Definitions.Date | Quick:1Y                                                                                                                                                                                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                               |
      | Format                | Select: CSV                                                                                                                                                                                                                                  |

  @SID_49
  Scenario: create new Output all2 Not Equal Cluster IP
    When UI "Create" Forensics With Name " Output all2 Not Equal Cluster IP"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Cluster IP,Operator:Not Equals,IPType:IPv4,IPValue:2.2.3.3                                                                                                                                                                    |
      | devices               | All                                                                                                                                                                                                                                          |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                             |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                                                                                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                             |
      | Format                | Select: CSV With Attack Details                                                                                                                                                                                                               |

  @SID_50
  Scenario: create new Output all3 Not Equal Cluster IP
    When UI "Create" Forensics With Name " Output all3 Not Equal Cluster IP"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Cluster IP,Operator:Not Equals,IPType:IPv6,IPValue:2001:db8:3c4d:15::1a2f:1a2b                                                                                                                                                |
      | devices               | index:10                                                                                                                                                                                                                                     |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                               |
      | Format                | Select: HTML                                                                                                                                                                                                                                 |

  @SID_51
  Scenario: create new Output all4 Equal Cluster IP
    When UI "Create" Forensics With Name " Output all4 Equal Cluster IP"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Cluster IP,Operator:Not Equals,IPType:IPv6,IPValue:2001:0db8:3c4d:0015:0000:0000:1a2f:1a2b                                                                                                                                    |
      | devices               | All                                                                                                                                                                                                                                          |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                                                                                                                                           |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                                                                                                                                                 |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                             |
      | Format                | Select: CSV                                                                                                                                                                                                                                  |

  @SID_52
  Scenario: create new Output all5 Equal Cluster IP
    When UI "Create" Forensics With Name " Output all5 Equal Cluster IP"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Cluster IP,Operator:Not Equals,IPType:IPv6,IPValue:fe80::23a1:b152                                                                                                                                                            |
      | devices               | All                                                                                                                                                                                                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                               |
      | Format                | Select: CSV                                                                                                                                                                                                                                  |

  @SID_53
  Scenario: Logout
    Then UI logout and close browser













































