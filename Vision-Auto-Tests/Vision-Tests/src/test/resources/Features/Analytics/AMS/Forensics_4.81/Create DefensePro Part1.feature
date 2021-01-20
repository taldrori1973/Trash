
Feature:DefensePro Part1

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage

  @SID_2
  Scenario: create new Output Device IP Address
    When UI "Create" Forensics With Name " Output Device IP Address"
      | Product               | DefensePro                                                                     |
      | Output                | Device IP Address                                                              |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV with Attack Detail                                                 |

  @SID_3
  Scenario: create new Output End Time
    When UI "Create" Forensics With Name "Output End Time"
      | Product               | DefensePro                                                                     |
      | Output                | End Time                                                                       |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV with Attack Detail                                                 |

  @SID_4
  Scenario: create new Output Start Time
    When UI "Create" Forensics With Name "Output Start Time"
      | Product               | DefensePro                                                                     |
      | Output                | Start Time                                                                     |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV with Attack Detail                                                 |

  @SID_5
  Scenario: create new Output Threat Category
    When UI "Create" Forensics With Name "Output Threat Category"
      | Product               | DefensePro                                                                     |
      | Output                | Threat Category                                                                |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                    |
      | Format                | Select: HTML                                                                   |

  @SID_6
  Scenario: create new Output Attack Name1
    When UI "Create" Forensics With Name "Output Attack Name1"
      | Product               | DefensePro                                                                     |
      | Output                | Attack Name                                                                    |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                    |
      | Format                | Select: HTML                                                                   |

  @SID_7
  Scenario: create new Output Attack Name2
    When UI "Create" Forensics With Name "Output Attack Name2"
      | Product               | DefensePro                                                                     |
      | Output                | Attack Name                                                                    |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                    |
      | Format                | Select: CSV                                                                    |

  @SID_8
  Scenario: create new Output Action
    When UI "Create" Forensics With Name "Output Action"
      | Product               | DefensePro                                                                                                       |
      | Output                | Action                                                                                                           |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | index:10                                                                                                         |
      | Time Definitions.Date | Quick:1D                                                                                                         |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_9
  Scenario: create new Output Attack ID
    When UI "Create" Forensics With Name "Output Attack ID"
      | Product               | DefensePro                                                                     |
      | Output                | Attack ID                                                                      |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Schedule              | Run Every:once, On Time:+6H                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV with Attack Detail                                                 |

  @SID_10
  Scenario: create new Output Policy Name
    When UI "Create" Forensics With Name "Output Policy Name"
      | Product               | DefensePro                                                                                                       |
      | Output                | Policy Name                                                                                                      |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_11
  Scenario: create new Output Source IP Address
    When UI "Create" Forensics With Name "Output Source IP Address"
      | Product               | DefensePro                                                                     |
      | Output                | Source IP Address                                                              |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV with Attack Detail                                                 |

  @SID_12
  Scenario: create new Output Source Port
    When UI "Create" Forensics With Name "Output Source Port"
      | Product               | DefensePro                                                                                                       |
      | Output                | Source Port                                                                                                      |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_13
  Scenario: create new Output Destination IP Address
    When UI "Create" Forensics With Name "Output Destination IP Address"
      | Product               | DefensePro                                                                     |
      | Output                | Destination IP Address                                                         |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_14
  Scenario: create new Output Destination Port
    When UI "Create" Forensics With Name "Output Destination Port"
      | Product               | DefensePro                                                                                                       |
      | Output                | Destination Port                                                                                                 |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | index:10                                                                                                         |
      | Time Definitions.Date | Quick:This Month                                                                                                 |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_15
  Scenario: create new Output Direction
    When UI "Create" Forensics With Name "Output Direction"
      | Product               | DefensePro                                                                                                       |
      | Output                | Direction                                                                                                        |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:Yesterday                                                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_16
  Scenario: create new Output Protocol
    When UI "Create" Forensics With Name "Output Protocol"
      | Product               | DefensePro                                                                     |
      | Output                | Protocol                                                                       |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1D                                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_17
  Scenario: create new Output Radware ID
    When UI "Create" Forensics With Name "Output Radware ID"
      | Product               | DefensePro                                                                                                       |
      | Output                | Radware ID                                                                                                       |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_18
  Scenario: create new Output Duration
    When UI "Create" Forensics With Name "Output Duration"
      | Product               | DefensePro                                                                     |
      | Output                | Duration                                                                       |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Hours,3]                                                             |
      | Schedule              | Run Every:Once, On Time:+6H                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTNL                                                                   |

  @SID_19
  Scenario: create new Output Total Packets Dropped
    When UI "Create" Forensics With Name "Output Total Packets Dropped"
      | Product               | DefensePro                                                                                                       |
      | Output                | Total Packets Dropped                                                                                            |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_20
  Scenario: create new Output Max pps
    When UI "Create" Forensics With Name "Output Max pps"
      | Product               | DefensePro                                                                     |
      | Output                | Max pps                                                                        |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1Y                                                                       |
      | Schedule              | Run Every:Once, On Time:+6H                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_21
  Scenario: create new Output Total Mbits Dropped
    When UI "Create" Forensics With Name "Output Total Mbits Dropped"
      | Product               | DefensePro                                                                                                       |
      | Output                | Total Mbits Dropped                                                                                              |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:Today                                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUL]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_22
  Scenario: create new Output Max Kbps
    When UI "Create" Forensics With Name "Output Max Kbps"
      | Product               | DefensePro                                                                     |
      | Output                | Max Kbps                                                                       |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_23
  Scenario: create new Output Physical Port
    When UI "Create" Forensics With Name "Output Physical Port"
      | Product               | DefensePro                                                                                                       |
      | Output                | Physical Port                                                                                                    |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_24
  Scenario: create new Output Risk
    When UI "Create" Forensics With Name "Output Risk"
      | Product               | DefensePro                                                                     |
      | Output                | Risk                                                                           |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_25
  Scenario: create new Output VLAN Tag
    When UI "Create" Forensics With Name "Output VLAN Tag"
      | Product               | DefensePro                                                                                                       |
      | Output                | VLAN Tag                                                                                                         |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:1W                                                                                                         |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_26
  Scenario: create new Output Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped
    When UI "Create" Forensics With Name "Output Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped"
      | Product               | DefensePro                                                                                           |
      | Output                | Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped |
      | Criteria              | condition.All:true                                                                                   |
      | devices               | index:10                                                                                             |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                       |
      | Format                | Select: HTML                                                                                         |

  @SID_27
  Scenario: create new Output Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag
    When UI "Create" Forensics With Name "Output Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag"
      | Product               | DefensePro                                                                                                                                      |
      | Output                | Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag |
      | Criteria              | condition.All:true                                                                                                                              |
      | devices               | All                                                                                                                                             |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                                                 |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                |
      | Format                | Select: CSV                                                                                                                                     |

  @SID_28
  Scenario: create new Output Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps
    When UI "Create" Forensics With Name "Output Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps"
      | Product               | DefensePro                                                                                             |
      | Output                | Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps |
      | Criteria              | condition.All:true                                                                                     |
      | devices               | All                                                                                                    |
      | Time Definitions.Date | Quick:Today                                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
      | Format                | Select: CSV                                                                                            |

  @SID_29
  Scenario: create new Output Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action
    When UI "Create" Forensics With Name "Output Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action"
      | Product               | DefensePro                                                                                                       |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action                                         |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_30
  Scenario: create new Output Policy Name,Source IP Address
    When UI "Create" Forensics With Name "Output Policy Name,Source IP Address"
      | Product               | DefensePro                                                                     |
      | Output                | Policy Name,Source IP Address                                                  |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_31
  Scenario: create new Output Destination IP Address,Destination Port,Direction
    When UI "Create" Forensics With Name "Output Destination IP Address,Destination Port,Direction"
      | Product               | DefensePro                                                                                                       |
      | Output                | Destination IP Address,Destination Port,Direction                                                                |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_32
  Scenario: create new Output All
    When UI "Create" Forensics With Name "Output All"
      | Product               | DefensePro                                                                                                                                                                                                                                                                                         |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag |
      | Criteria              | condition.All:true                                                                                                                                                                                                                                                                                 |
      | devices               | All                                                                                                                                                                                                                                                                                                |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                                                                                                                                                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                     |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                        |

  @SID_33
  Scenario: create new Output Start Time Equals
    When UI "Create" Forensics With Name "Output Start Time Equals"
      | Product               | DefensePro                                                                                                       |
      | Output                | Start Time                                                                                                       |
      | Criteria              | Event Criteria:Action,Operator:Equals,Actions:Modified                                                           |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_34
  Scenario: create new Output End Time Equals
    When UI "Create" Forensics With Name "Output End Time Equals"
      | Product               | DefensePro                                                                     |
      | Output                | End Time                                                                       |
      | Criteria              | Event Criteria:Action,Operator:Equals,Actions:Forward                          |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Months,2]                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_35
  Scenario: create new Output Device IP Address Equals
    When UI "Create" Forensics With Name "Output Device IP Address Equals"
      | Product               | DefensePro                                                                                                       |
      | Output                | Device IP Address                                                                                                |
      | Criteria              | Event Criteria:Action,Operator:Equals,Actions:Drop                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:Today                                                                                                      |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_36
  Scenario: create new Output Threat Category Equals
    When UI "Create" Forensics With Name "Output Threat Category Equals"
      | Product               | DefensePro                                                                     |
      | Output                | Threat Category                                                                |
      | Criteria              | Event Criteria:Action,Operator:Equals,Actions:Source Reset                     |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_37
  Scenario: create new Output Attack Name1 Equals
    When UI "Create" Forensics With Name "Output Attack Name1 Equals"
      | Product               | DefensePro                                                                                                       |
      | Output                | Attack Name                                                                                                      |
      | Criteria              | Event Criteria:Action,Operator:Equals,Actions:Destination Reset                                                  |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_38
  Scenario: create new Output Attack Name2 Equals
    When UI "Create" Forensics With Name "Output Attack Name2 Equals"
      | Product               | DefensePro                                                                     |
      | Output                | Attack Name                                                                    |
      | Criteria              | Event Criteria:Action,Operator:Equals,Actions:Source and Destination Reset     |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Quick:Today                                                                    |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_39
  Scenario: create new Output Action Equals
    When UI "Create" Forensics With Name "Output Action Equals"
      | Product               | DefensePro                                                                                                       |
      | Output                | Action                                                                                                           |
      | Criteria              | Event Criteria:Action,Operator:Equals,Actions:Bypass                                                             |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_40
  Scenario: create new Output Attack ID Equals
    When UI "Create" Forensics With Name "Output Attack ID Equals"
      | Product               | DefensePro                                                                     |
      | Output                | Attack ID                                                                      |
      | Criteria              | Event Criteria:Action,Operator:Equals,Actions:Challenge                        |
      | devices               | All                                                                            |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_41
  Scenario: create new Output Policy Name Equals
    When UI "Create" Forensics With Name "Output Policy Name Equals"
      | Product               | DefensePro                                                                                                       |
      | Output                | Policy Name                                                                                                      |
      | Criteria              | Event Criteria:Action,Operator:Equals,Actions:Http 200 Ok                                                        |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:This Month                                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUL]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_42
  Scenario: create new Output Source IP Address Equals
    When UI "Create" Forensics With Name "Output Source IP Address Equals"
      | Product               | DefensePro                                                                     |
      | Output                | Source IP Address                                                              |
      | Criteria              | Event Criteria:Action,Operator:Equals,Actions:Http 200 Ok Reset Dest           |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Hours,3]                                                             |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_43
  Scenario: create new Output Source Port Equals
    When UI "Create" Forensics With Name "Output Source Port Equals"
      | Product               | DefensePro                                                                                                       |
      | Output                | Source Port                                                                                                      |
      | Criteria              | Event Criteria:Action,Operator:Equals,Actions:Http 403 Forbidden                                                 |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_44
  Scenario: create new Output Destination IP Address Equals
    When UI "Create" Forensics With Name "Output Destination IP Address Equals"
      | Product               | DefensePro                                                                     |
      | Output                | Destination IP Address                                                         |
      | Criteria              | Event Criteria:Action,Operator:Equals,Actions:Http 403 Forbidden Reset Dest    |
      | devices               | All                                                                            |
      | Schedule              | Run Every:once, On Time:+6H                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_45
  Scenario: create new Output Destination Port Equals
    When UI "Create" Forensics With Name "Output Destination Port Equals"
      | Product               | DefensePro                                                                                                                                 |
      | Output                | Destination Port                                                                                                                           |
      | Criteria              | Event Criteria:Action,Operator:Equals,Actions:Modified,Source Reset,Source and Destination Reset,Http 200 Ok,Http 403 Forbidden Reset Dest |
      | devices               | All                                                                                                                                        |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                           |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                           |
      | Format                | Select: CSV with Attack Detail                                                                                                             |


  @SID_46
  Scenario: create new Output Direction Equals
    When UI "Create" Forensics With Name "Output Direction Equals"
      | Product               | DefensePro                                                                                                                                                                                                                             |
      | Output                | Direction                                                                                                                                                                                                                              |
      | Criteria              | Event Criteria:Action,Operator:Equals,Actions:Modified,Forward,Drop,Source Reset,Destination Reset,Source and Destination Reset,Bypass,Challenge,Http 200 Ok,Http 200 Ok Reset Dest,Http 403 Forbidden,Http 403 Forbidden Reset Dest   |
      | devices               | index:10                                                                                                                                                                                                                               |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                         |
      | Format                | Select: HTML                                                                                                                                                                                                                           |

  @SID_47
  Scenario: create new Output Protocol Not Equals
    When UI "Create" Forensics With Name "Output Protocol Not Equals"
      | Product               | DefensePro                                                                                                       |
      | Output                | Protocol                                                                                                         |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Actions:Source and Destination Reset                                   |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_48
  Scenario: create new Output Radware ID Not Equals
    When UI "Create" Forensics With Name "Output Radware ID Not Equals"
      | Product               | DefensePro                                                                     |
      | Output                | Radware ID                                                                     |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Actions:Bypass                       |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:3M                                                                       |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_49
  Scenario: create new Output Duration Not Equals
    When UI "Create" Forensics With Name "Output Duration Not Equals"
      | Product               | DefensePro                                                                                                       |
      | Output                | Duration                                                                                                         |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Actions:Challenge                                                      |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_50
  Scenario: create new Output Total Packets Dropped Not Equals
    When UI "Create" Forensics With Name "Output Total Packets Dropped Not Equals"
      | Product               | DefensePro                                                                     |
      | Output                | Total Packets Dropped                                                          |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Actions:Http 200 Ok                  |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Months,4]                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_51
  Scenario: create new Output Max pps Not Equals
    When UI "Create" Forensics With Name "Output Max pps Not Equals"
      | Product               | DefensePro                                                                                                       |
      | Output                | Max pps                                                                                                          |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Actions:Http 200 Ok Reset Dest                                         |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |


  @SID_52
  Scenario: Logout
    Then UI logout and close browser














