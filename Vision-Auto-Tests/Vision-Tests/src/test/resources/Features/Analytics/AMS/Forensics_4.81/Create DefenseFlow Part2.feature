@TC119588
Feature:Create DefenseFlow Part2

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    * REST Delete ES index "forensics-*"
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "New Forensics" page via homePage

  @SID_2
  Scenario: create new Output Total Mbits Dropped Action Not Equals
    When UI "Create" Forensics With Name "Output Total Mbits Dropped Action Not Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Total Mbits Dropped                                                                                              |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Http 403 Forbidden                                             |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_3
  Scenario: create new Output Max bps Action Not Equals
    When UI "Create" Forensics With Name "Output Max bps Action Not Equals"
      | Product               | DefenseFlow                                                                     |
      | Output                | Max bps                                                                        |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Http 403 Forbidden Reset Dest |
      | devices               | All                                                                             |
      | Time Definitions.Date | Quick:1Y                                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body  |
      | Format                | Select: CSV                                                                     |

  @SID_4
  Scenario: create new Output Physical Port Action Not Equals
    When UI "Create" Forensics With Name "Output Physical Port Action Not Equals"
      | Product               | DefenseFlow                                                                                                                                    |
      | Output                | Physical Port                                                                                                                                  |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:[Modified,Source Reset,Source and Destination Reset,Http 200 Ok,Http 403 Forbidden Reset Dest] |
      | devices               | All                                                                                                                                            |
      | Time Definitions.Date | Quick:This Month                                                                                                                               |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                                    |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                               |
      | Format                | Select: CSV With Attack Details                                                                                                                 |

  @SID_5
  Scenario: create new Output Risk Action Not Equals
    When UI "Create" Forensics With Name "Output Risk Action Not Equals"
      | Product               | DefenseFlow                                                                                                                                                                                                                                |
      | Output                | Risk                                                                                                                                                                                                                                       |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:[Modified,Forward,Drop,Source Reset,Destination Reset,Source and Destination Reset,Bypass,Challenge,Http 200 Ok,Http 200 Ok Reset Dest,Http 403 Forbidden,Http 403 Forbidden Reset Dest]   |
      | devices               | index:10                                                                                                                                                                                                                                   |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                             |
      | Format                | Select: HTML                                                                                                                                                                                                                               |

  @SID_6
  Scenario: create new Output VLAN Tag Attack ID Equals
    When UI "Create" Forensics With Name "Output VLAN Tag Attack ID Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | VLAN Tag                                                                                                         |
      | Criteria              | Event Criteria:Attack ID,Operator:Equals,Value:33-33                                                             |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_7
  Scenario: create new Output Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped Attack ID Not Equals
    When UI "Create" Forensics With Name "Output Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped Attack ID Not Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped             |
      | Criteria              | Event Criteria:Attack ID,Operator:Not Equals,Value:111111                                                        |
      | devices               | All                                                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                   |
      | Format                | Select: CSV                                                                                                      |

  @SID_8
  Scenario: create new Output Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag Attack Name Equals
    When UI "Create" Forensics With Name "Output Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag Attack Name Equals"
      | Product               | DefenseFlow                                                                                                                                     |
      | Output                | Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag |
      | Criteria              | Event Criteria:Attack Name,Operator:Equals,Value:TCP Port Scan                                                                                  |
      | devices               | All                                                                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                 |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                |
      | Format                | Select: CSV With Attack Details                                                                                                                  |

  @SID_9
  Scenario: create new Output Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps Attack Name Not Equals
    When UI "Create" Forensics With Name "Output Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps Attack Name Not Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps           |
      | Criteria              | Event Criteria:Attack Name,Operator:Not Equals,Value:Conn_Limit                                                  |
      | devices               | index:10                                                                                                         |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                   |
      | Format                | Select: HTML                                                                                                     |

  @SID_10
  Scenario: create new Output Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action Attack Rate in bps Greater than
    When UI "Create" Forensics With Name "Output Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action Attack Rate in bps Greater than"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action                                         |
      | Criteria              | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:500,Unit:M                                     |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_11
  Scenario: create new Output Policy Name,Source IP Address Attack Rate in bps Greater than
    When UI "Create" Forensics With Name "Output Policy Name,Source IP Address Attack Rate in bps Greater than"
      | Product               | DefenseFlow                                                                    |
      | Output                | Policy Name,Source IP Address                                                  |
      | Criteria              | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:17778,Unit:K |
      | devices               | All                                                                            |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_12
  Scenario: create new Output Destination IP Address,Destination Port,Direction Attack Rate in bps Greater than
    When UI "Create" Forensics With Name "Output Destination IP Address,Destination Port,Direction Attack Rate in bps Greater than"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Destination IP Address,Destination Port,Direction                                                                |
      | Criteria              | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:1.7,Unit:G                                     |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:3M                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                   |

  @SID_13
  Scenario: create new Output All Attack Rate in bps Greater than
    When UI "Create" Forensics With Name "Output All Attack Rate in bps Greater than"
      | Product               | DefenseFlow                                                                                                                                                                                                                                                                                        |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag |
      | Criteria              | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:1,Unit:T                                                                                                                                                                                                                         |
      | devices               | index:10                                                                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                     |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                       |

  @SID_14
  Scenario: create new Output Device IP Address Attack Rate in pps Greater than
    When UI "Create" Forensics With Name "Output Device IP Address Attack Rate in pps Greater than"
      | Product               | DefenseFlow                                                                    |
      | Output                | Device IP Address                                                              |
      | Criteria              | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:500,Unit:M   |
      | devices               | index:10                                                                       |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_15
  Scenario: create new Output End Time Attack Rate in pps Greater than
    When UI "Create" Forensics With Name "Output End Time Attack Rate in pps Greater than"
      | Product               | DefenseFlow                                                                    |
      | Output                | End Time                                                                       |
      | Criteria              | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:17778,Unit:K |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_16
  Scenario: create new Output Start Time Attack Rate in pps Greater than
    When UI "Create" Forensics With Name "Output Start Time Attack Rate in pps Greater than"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Start Time                                                                                                       |
      | Criteria              | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:1.7,Unit:G                                     |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                   |

  @SID_17
  Scenario: create new Output Threat Category Attack Rate in pps Greater than
    When UI "Create" Forensics With Name "Output Threat Category Attack Rate in pps Greater than"
      | Product               | DefenseFlow                                                                    |
      | Output                | Threat Category                                                                |
      | Criteria              | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:1,Unit:T     |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Days,2]                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_18
  Scenario: create new Output Attack Name1 Destination IP Equal
    When UI "Create" Forensics With Name "Output Attack Name1 Destination IP Equal"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Attack Name                                                                                                      |
      | Criteria              | Event Criteria:Destination IP,Operator:Equals,IPType:IPv4,IPValue:2.2.2.2                                        |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_19
  Scenario: create new Output Attack Name2 Destination IP Not Equal
    When UI "Create" Forensics With Name "Output Attack Name2 Destination IP Not Equal"
      | Product               | DefenseFlow                                                                    |
      | Output                | Attack Name                                                                    |
      | Criteria              | Event Criteria:Destination IP,Operator:Not Equals,IPType:IPv4,IPValue:4.4.4.1  |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1D                                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_20
  Scenario: create new Output Action Destination IP Equal
    When UI "Create" Forensics With Name "Output Action Destination IP Equal"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Action                                                                                                           |
      | Criteria              | Event Criteria:Destination IP,Operator:Equals,IPType:IPv6,IPValue:::ffff:0:255.255.255.255                       |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                   |

  @SID_21
  Scenario: create new Output Attack ID Destination IP Not Equal
    When UI "Create" Forensics With Name "Output Attack ID Destination IP Not Equal"
      | Product               | DefenseFlow                                                                                    |
      | Output                | Attack ID                                                                                      |
      | Criteria              | Event Criteria:Destination IP,Operator:Not Equals,IPType:IPv6,IPValue:64:ff9b::255.255.255.255 |
      | devices               | index:10                                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                 |
      | Format                | Select: HTML                                                                                   |

  @SID_22
  Scenario: create new Output Policy Name Destination IP Equal
    When UI "Create" Forensics With Name "Output Policy Name Destination IP Equal"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Policy Name                                                                                                      |
      | Criteria              | Event Criteria:Destination IP,Operator:Equals,IPType:IPv6,IPValue:2001:0db8:3c4d:0015:0000:0000:1a2f:1a2b        |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_23
  Scenario: create new Output Source IP Address Destination IP Equal
    When UI "Create" Forensics With Name "Output Source IP Address Destination IP Equal"
      | Product               | DefenseFlow                                                                                   |
      | Output                | Source IP Address                                                                             |
      | Criteria              | Event Criteria:Destination IP,Operator:Equals,IPType:IPv6,IPValue:2001:db8:3c4d:15::1a2f:1a2b |
      | devices               | All                                                                                           |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                |
      | Format                | Select: CSV                                                                                   |

  @SID_24
  Scenario: create new Output Source Port Destination Port Equal
    When UI "Create" Forensics With Name "Output Source Port Destination Port Equal"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Source Port                                                                                                      |
      | Criteria              | Event Criteria:Destination Port,Operator:Equals,portType:Port,portValue:80                                       |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                   |

  @SID_25
  Scenario: create new Output Destination IP Address Destination Port Not Equal
    When UI "Create" Forensics With Name "Output Destination IP Address Destination Port Not Equal"
      | Product               | DefenseFlow                                                                    |
      | Output                | Destination IP Address                                                         |
      | Criteria              | Event Criteria:Destination Port,Operator:Not Equals,portType:Port,portValue:0  |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_26
  Scenario: create new Output Destination Port Destination Port Equal
    When UI "Create" Forensics With Name "Output Destination Port Destination Port Equal"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Destination Port                                                                                                 |
      | Criteria              | Event Criteria:Destination Port,Operator:Equals,portType:Port,portValue:53                                       |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_27
  Scenario: create new Output Direction Destination Port Equal
    When UI "Create" Forensics With Name "Output Direction Destination Port Equal"
      | Product               | DefenseFlow                                                                              |
      | Output                | Direction                                                                                |
      | Criteria              | Event Criteria:Destination Port,Operator:Equals,portType:Port Range,portFrom:1,portTo:20 |
      | devices               | All                                                                                      |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body           |
      | Format                | Select: CSV                                                                              |

  @SID_28
  Scenario: create new Output Protocol Destination Port Not Equal
    When UI "Create" Forensics With Name "Output Protocol Destination Port Not Equal"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Protocol                                                                                                         |
      | Criteria              | Event Criteria:Destination Port,Operator:Not Equals,portType:Port Range,portFrom:90,portTo:100                   |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                   |

  @SID_29
  Scenario: create new Output Radware ID Direction Equal
    When UI "Create" Forensics With Name "Output Radware ID Direction Equal"
      | Product               | DefenseFlow                                                                    |
      | Output                | Radware ID                                                                     |
      | Criteria              | Event Criteria:Direction,Operator:Equals,Value:[Inbound]                       |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Weeks,2]                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_30
  Scenario: create new Output Duration Direction Equal
    When UI "Create" Forensics With Name "Output Duration Direction Equal"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Duration                                                                                                         |
      | Criteria              | Event Criteria:Direction,Operator:Equals,Value:[Outbound]                                                        |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_31
  Scenario: create new Output Total Packets Dropped Direction Equal
    When UI "Create" Forensics With Name "Output Total Packets Dropped Direction Equal"
      | Product               | DefenseFlow                                                                    |
      | Output                | Total Packets Dropped                                                          |
      | Criteria              | Event Criteria:Direction,Operator:Equals,Value:[Unknown]                       |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1Y                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_32
  Scenario: create new Output Max pps Direction Equal
    When UI "Create" Forensics With Name "Output Max pps Direction Equal"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Max pps                                                                                                          |
      | Criteria              | Event Criteria:Direction,Operator:Equals,Value:[Both]                                                            |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:This Month                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                   |

  @SID_33
  Scenario: create new Output Total Mbits Dropped Direction Not Equal
    When UI "Create" Forensics With Name "Output Total Mbits Dropped Direction Not Equal"
      | Product               | DefenseFlow                                                                    |
      | Output                | Total Mbits Dropped                                                            |
      | Criteria              | Event Criteria:Direction,Operator:Not Equals,Value:[Outbound,Unknown]          |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_34
  Scenario: create new Output Max bps Direction Equal
    When UI "Create" Forensics With Name "Output Max bps Direction Equal"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Max bps                                                                                                         |
      | Criteria              | Event Criteria:Direction,Operator:Equals,Value:[Inbound,Outbound,Unknown,both]                                   |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_35
  Scenario: create new Output Physical Port Direction Not Equal
    When UI "Create" Forensics With Name "Output Physical Port Direction Not Equal"
      | Product               | DefenseFlow                                                                        |
      | Output                | Physical Port                                                                      |
      | Criteria              | Event Criteria:Direction,Operator:Not Equals,Value:[Inbound,Outbound,Unknown,both] |
      | devices               | All                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body     |
      | Format                | Select: CSV                                                                        |

  @SID_36
  Scenario: create new Output Risk Duration Equal
    When UI "Create" Forensics With Name "Output Risk Duration Equal"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Risk                                                                                                             |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[Less than 1 min]                                                  |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                   |

  @SID_37
  Scenario: create new Output VLAN Tag Duration Equal
    When UI "Create" Forensics With Name "Output VLAN Tag Duration Equal"
      | Product               | DefenseFlow                                                                    |
      | Output                | VLAN Tag                                                                       |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[1-5 min]                        |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_38
  Scenario: create new Output Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped Duration Equal
    When UI "Create" Forensics With Name "Output Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped Duration Equal"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped             |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[5-10 min]                                                         |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_39
  Scenario: create new Output Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag Duration Equal
    When UI "Create" Forensics With Name "Output Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag Duration Equal"
      | Product               | DefenseFlow                                                                                                                                     |
      | Output                | Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[10-30 min]                                                                                       |
      | devices               | All                                                                                                                                             |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                  |
      | Format                | Select: CSV                                                                                                                                     |

  @SID_40
  Scenario: create new Output Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps Duration Equal
    When UI "Create" Forensics With Name "Output Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps Duration Equal"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps           |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[30-60 min]                                                        |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:3M                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                   |

  @SID_41
  Scenario: create new Output Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action Duration Equal
    When UI "Create" Forensics With Name "Output Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action Duration Equal"
      | Product               | DefenseFlow                                                                    |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action       |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[More than 1 hour]               |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Quick:This Month                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_42
  Scenario: create new Output Policy Name,Source IP Address Duration Not Equal
    When UI "Create" Forensics With Name "Output Policy Name,Source IP Address Not Duration Equal"
      | Product               | DefenseFlow                                                                      |
      | Output                | Policy Name,Source IP Address                                                    |
      | Criteria              | Event Criteria:Duration,Operator:Not Equals,Value:[5-10 min,10-30 min,30-60 min] |
      | devices               | index:10                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body   |
      | Format                | Select: HTML                                                                     |

  @SID_43
  Scenario: create new Output Destination IP Address,Destination Port,Direction Duration Equal
    When UI "Create" Forensics With Name "Output Destination IP Address,Destination Port,Direction Duration Equal"
      | Product               | DefenseFlow                                                                       |
      | Output                | Destination IP Address,Destination Port,Direction                                |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[Less than 1 min,More than 1 hour] |
      | devices               | index:10                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body   |
      | Format                | Select: CSV                                                                      |


  @SID_44
  Scenario: create new Output All Duration Equal
    When UI "Create" Forensics With Name "Output All Duration Equal"
      | Product               | DefenseFlow                                                                                                                                                                                                                                                                                        |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[Less than 1 min,1-5 min,5-10 min,10-30 min,30-60 min,More than 1 hour]                                                                                                                                                                              |
      | devices               | All                                                                                                                                                                                                                                                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                                                                                                                                                    |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                   |
      | Format                | Select: CSV With Attack Details                                                                                                                                                                                                                                                                     |

  @SID_45
  Scenario: create new Output Start Time Duration Not Equal
    When UI "Create" Forensics With Name "Output Start Time Duration Not Equal"
      | Product               | DefenseFlow                                                                    |
      | Output                | Start Time                                                                     |
      | Criteria              | Event Criteria:Duration,Operator:Not Equals,Value:[1-5 min,5-10 min,10-30 min] |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_46
  Scenario: create new Output End Time Duration Not Equal
    When UI "Create" Forensics With Name "Output End Time Duration Not Equal"
      | Product               | DefenseFlow                                                                                                               |
      | Output                | End Time                                                                                                                  |
      | Criteria              | Event Criteria:Duration,Operator:Not Equals,Value:[Less than 1 min,1-5 min,5-10 min,10-30 min,30-60 min,More than 1 hour] |
      | devices               | All                                                                                                                       |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                        |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                               |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware          |
      | Format                | Select: CSV                                                                                                               |

  @SID_47
  Scenario: create new Output Device IP Address Max bps Greater than
    When UI "Create" Forensics With Name "Output Device IP Address Max bps Greater than"
      | Product               | DefenseFlow                                                                    |
      | Output                | Device IP Address                                                              |
      | Criteria              | Event Criteria:Max bps,Operator:Greater than,RateValue:500,Unit:M              |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_48
  Scenario: create new Output Threat Category Max bps Greater than
    When UI "Create" Forensics With Name "Output Threat Category Max bps Greater than"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Threat Category                                                                                                  |
      | Criteria              | Event Criteria:Max bps,Operator:Greater than,RateValue:17778,Unit:K                                              |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                   |

  @SID_49
  Scenario: create new Output Attack Name1 Max bps Greater than
    When UI "Create" Forensics With Name "Output Attack Name1 Max bps Greater than"
      | Product               | DefenseFlow                                                                    |
      | Output                | Attack Name                                                                    |
      | Criteria              | Event Criteria:Max bps,Operator:Greater than,RateValue:1.7,Unit:G              |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_50
  Scenario: create new Output Attack Name2 Max bps Greater than
    When UI "Create" Forensics With Name "Output Attack Name2 Max bps Greater than"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Attack Name                                                                                                      |
      | Criteria              | Event Criteria:Max bps,Operator:Greater than,RateValue:1,Unit:T                                                  |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_51
  Scenario: Logout
    Then UI logout and close browser