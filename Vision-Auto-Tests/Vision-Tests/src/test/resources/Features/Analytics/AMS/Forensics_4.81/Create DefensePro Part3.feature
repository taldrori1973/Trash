
Feature:DefensePro Part3

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage

  @SID_2
  Scenario: create new Output Action Max pps Greater than
    When UI "Create" Forensics With Name "Output Action Max pps Greater than"
      | Product               | DefensePro                                                                     |
      | Output                | Action                                                                         |
      | Criteria              | Event Criteria:Max pps,Operator:Greater than,RateValue:500,Unit:M              |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Weeks,2]                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_3
  Scenario: create new Output Attack ID Max pps Greater than
    When UI "Create" Forensics With Name "Output Attack ID Max pps Greater than"
      | Product               | DefensePro                                                                                                       |
      | Output                | Attack ID                                                                                                        |
      | Criteria              | Event Criteria:Max pps,Operator:Greater than,RateValue:17778,Unit:K                                              |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_4
  Scenario: create new Output Policy Name Max pps Greater than
    When UI "Create" Forensics With Name "Output Policy Name Max pps Greater than"
      | Product               | DefensePro                                                                     |
      | Output                | Policy Name                                                                    |
      | Criteria              | Event Criteria:Max pps,Operator:Greater than,RateValue:1.7,Unit:G              |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1Y                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_5
  Scenario: create new Output Source IP Address Max pps Greater than
    When UI "Create" Forensics With Name "Output Source IP Address Max pps Greater than"
      | Product               | DefensePro                                                                                                       |
      | Output                | Source IP Address                                                                                                |
      | Criteria              | Event Criteria:Max pps,Operator:Greater than,RateValue:1,Unit:T                                                  |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:This Month                                                                                                 |
      | Schedule              | Run Every:once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_6
  Scenario: create new Output Source Port Protocol Equal
    When UI "Create" Forensics With Name "Output Source Port Protocol Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Source Port                                                                    |
      | Criteria              | Event Criteria:Protocol,Operator:Equals,Value:[IP]                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_7
  Scenario: create new Output Destination IP Address Protocol Equal
    When UI "Create" Forensics With Name "Output Destination IP Address Protocol Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Destination IP Address                                                                                           |
      | Criteria              | Event Criteria:Protocol,Operator:Equals,Value:[TCP]                                                              |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_8
  Scenario: create new Output Destination Port Protocol Equal
    When UI "Create" Forensics With Name "Output Destination Port Protocol Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Destination Port                                                               |
      | Criteria              | Event Criteria:Protocol,Operator:Equals,Value:[UDP]                            |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_9
  Scenario: create new Output Direction Protocol Equal
    When UI "Create" Forensics With Name "Output Direction Protocol Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Direction                                                                                                        |
      | Criteria              | Event Criteria:Protocol,Operator:Equals,Value:[ICMP]                                                             |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_10
  Scenario: create new Output Protocol Protocol Equal
    When UI "Create" Forensics With Name "Output Protocol Protocol Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Protocol                                                                       |
      | Criteria              | Event Criteria:Protocol,Operator:Equals,Value:[IGMP]                           |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_11
  Scenario: create new Output Radware ID Protocol Equal
    When UI "Create" Forensics With Name "Output Radware ID Protocol Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Radware ID                                                                                                       |
      | Criteria              | Event Criteria:Protocol,Operator:Equals,Value:[Non-IP]                                                           |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_12
  Scenario: create new Output Duration Protocol Equal
    When UI "Create" Forensics With Name "Output Duration Protocol Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Duration                                                                       |
      | Criteria              | Event Criteria:Protocol,Operator:Equals,Value:[SCTP]                           |
      | devices               | All                                                                            |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_13
  Scenario: create new Output Total Packets Dropped Protocol Equal
    When UI "Create" Forensics With Name "Output Total Packets Dropped Protocol Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Total Packets Dropped                                                                                            |
      | Criteria              | Event Criteria:Protocol,Operator:Equals,Value:[ICMPv6]                                                           |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:3M                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_14
  Scenario: create new Output Max pps Protocol Equal
    When UI "Create" Forensics With Name "Output Max pps Protocol Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Max pps                                                                        |
      | Criteria              | Event Criteria:Protocol,Operator:Equals,Value:[Other]                          |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Quick:This Month                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_15
  Scenario: create new Output Total Mbits Dropped Protocol Equal
    When UI "Create" Forensics With Name "Output Total Mbits Dropped Protocol Equal"
      | Product               | DefensePro                                                                                    |
      | Output                | Total Mbits Dropped                                                                           |
      | Criteria              | Event Criteria:Protocol,Operator:Equals,Value:[IP,TCP,UDP,ICMP,IGMP,Non-IP,SCTP,ICMPv6,Other] |
      | devices               | index:10                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                |
      | Format                | Select: HTML                                                                                  |

  @SID_16
  Scenario: create new Output Max Kbps Protocol Not Equal
    When UI "Create" Forensics With Name "Output Max Kbps Protocol Not Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Max Kbps                                                                       |
      | Criteria              | Event Criteria:Protocol,Operator:Not Equals,Value:[ICMP,IGMP,Non-IP]           |
      | devices               | All                                                                            |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_17
  Scenario: create new Output Physical Port Protocol Not Equal
    When UI "Create" Forensics With Name "Output Physical Port Protocol Not Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Physical Port                                                                                                    |
      | Criteria              | Event Criteria:Protocol,Operator:Not Equals,Value:[IP,TCP,UDP]                                                   |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:3M                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_18
  Scenario: create new Output Risk Protocol Equal
    When UI "Create" Forensics With Name "Output Risk Protocol Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Risk                                                                           |
      | Criteria              | Event Criteria:Protocol,Operator:Equals,Value:[ICMPv6,Other]                   |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Quick:This Month                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_19
  Scenario: create new Output VLAN Tag Protocol Not Equal
    When UI "Create" Forensics With Name "Output VLAN Tag Protocol Not Equal"
      | Product               | DefensePro                                                                                        |
      | Output                | VLAN Tag                                                                                          |
      | Criteria              | Event Criteria:Protocol,Operator:Not Equals,Value:[IP,TCP,UDP,ICMP,IGMP,Non-IP,SCTP,ICMPv6,Other] |
      | devices               | index:10                                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                    |
      | Format                | Select: HTML                                                                                      |

  @SID_20
  Scenario: create new Output Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped Risk Equal
    When UI "Create" Forensics With Name "Output Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped Risk Equal"
      | Product               | DefensePro                                                                                           |
      | Output                | Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped |
      | Criteria              | Event Criteria:Risk,Operator:Equals,Value:[Info]                                                     |
      | devices               | All                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                       |
      | Format                | Select: CSV                                                                                          |

  @SID_21
  Scenario: create new Output Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag Risk Equal
    When UI "Create" Forensics With Name "Output Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag Risk Equal"
      | Product               | DefensePro                                                                                                                                      |
      | Output                | Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag |
      | Criteria              | Event Criteria:Risk,Operator:Equals,Value:[Low]                                                                                                 |
      | devices               | All                                                                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                 |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                |
      | Format                | Select: CSV with Attack Detail                                                                                                                  |

  @SID_22
  Scenario: create new Output Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps Risk Equal
    When UI "Create" Forensics With Name "Output Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps Risk Equal"
      | Product               | DefensePro                                                                                             |
      | Output                | Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps |
      | Criteria              | Event Criteria:Risk,Operator:Equals,Value:[Medium]                                                     |
      | devices               | index:10                                                                                               |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                       |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
      | Format                | Select: HTML                                                                                           |

  @SID_23
  Scenario: create new Output Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action Risk Equal
    When UI "Create" Forensics With Name "Output Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action Risk Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action                                         |
      | Criteria              | Event Criteria:Risk,Operator:Equals,Value:[High]                                                                 |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_24
  Scenario: create new Output Policy Name,Source IP Address Risk Equal
    When UI "Create" Forensics With Name "Output Policy Name,Source IP Address Risk Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Policy Name,Source IP Address                                                  |
      | Criteria              | Event Criteria:Risk,Operator:Equals,Value:[Info,Low,Medium,High]               |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_25
  Scenario: create new Output Destination IP Address,Destination Port,Direction Risk Not Equal
    When UI "Create" Forensics With Name "Output Destination IP Address,Destination Port,Direction Risk Not Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Destination IP Address,Destination Port,Direction                                                                |
      | Criteria              | Event Criteria:Risk,Operator:Not Equals,Value:[Low,Medium]                                                       |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_26
  Scenario: create new Output All Risk Equal
    When UI "Create" Forensics With Name "Output All Risk Equal"
      | Product               | DefensePro                                                                                                                                                                                                                                                                                         |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag |
      | Criteria              | Event Criteria:Risk,Operator:Equals,Value:[Low,Medium]                                                                                                                                                                                                                                             |
      | devices               | index:10                                                                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                                     |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                                       |

  @SID_27
  Scenario: create new Output Device IP Address Risk Not Equal
    When UI "Create" Forensics With Name "Output Device IP Address Risk Not Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Device IP Address                                                                                                |
      | Criteria              | Event Criteria:Risk,Operator:Not Equals,Value:[Info,High]                                                        |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_28
  Scenario: create new Output End Time Risk Equal
    When UI "Create" Forensics With Name "Output End Time Risk Equal"
      | Product               | DefensePro                                                                     |
      | Output                | End Time                                                                       |
      | Criteria              | Event Criteria:Risk,Operator:Equals,Value:[Medium,High]                        |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1Y                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_29
  Scenario: create new Output Start Time Risk Not Equal
    When UI "Create" Forensics With Name "Output Start Time Risk Not Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Start Time                                                                                                       |
      | Criteria              | Event Criteria:Risk,Operator:Not Equals,Value:[Info,Low,Medium,High]                                             |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:This Month                                                                                                 |
      | Schedule              | Run Every:once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_30
  Scenario: create new Output Threat Category Source IP Equal
    When UI "Create" Forensics With Name "Output Threat Category Source IP Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Threat Category                                                                |
      | Criteria              | Event Criteria:Source IP,Operator:Equals,IPType:IPv4,IPValue:2.2.2.2           |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_31
  Scenario: create new Output Attack Name1 Source IP Not Equal
    When UI "Create" Forensics With Name "Output Attack Name1 Source IP Not Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Attack Name                                                                                                      |
      | Criteria              | Event Criteria:Source IP,Operator:Not Equals,IPType:IPv4,IPValue:4.4.4.1                                         |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_32
  Scenario: create new Output Attack Name2 Source IP Equal
    When UI "Create" Forensics With Name "Output Attack Name2 Source IP Equal"
      | Product               | DefensePro                                                                            |
      | Output                | Attack Name                                                                           |
      | Criteria              | Event Criteria:Source IP,Operator:Equals,IPType:IPv6,IPValue:::ffff:0:255.255.255.255 |
      | devices               | All                                                                                   |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                      |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body        |
      | Format                | Select: CSV                                                                           |

  @SID_33
  Scenario: create new Output Action Source IP Not Equal
    When UI "Create" Forensics With Name "Output Action Source IP Not Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Action                                                                                                           |
      | Criteria              | Event Criteria:Source IP,Operator:Not Equals,IPType:IPv6,IPValue:64:ff9b::255.255.255.255                        |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:3M                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_34
  Scenario: create new Output Attack ID Source IP Equal
    When UI "Create" Forensics With Name "Output Attack ID Source IP Equal"
      | Product               | DefensePro                                                                                           |
      | Output                | Attack ID                                                                                            |
      | Criteria              | Event Criteria:Source IP,Operator:Equals,IPType:IPv6,IPValue:2001:0db8:3c4d:0015:0000:0000:1a2f:1a2b |
      | devices               | index:10                                                                                             |
      | Time Definitions.Date | Quick:This Month                                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                       |
      | Format                | Select: HTML                                                                                         |

  @SID_35
  Scenario: create new Output Policy Name Source IP Equal
    When UI "Create" Forensics With Name "Output Policy Name Source IP Equal"
      | Product               | DefensePro                                                                               |
      | Output                | Policy Name                                                                              |
      | Criteria              | Event Criteria:Source IP,Operator:Equals,IPType:IPv6,IPValue:2001:db8:3c4d:15::1a2f:1a2b |
      | devices               | index:10                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body           |
      | Format                | Select: HTML                                                                             |

  @SID_36
  Scenario: create new Output Source IP Address Source Port Equal
    When UI "Create" Forensics With Name "Output Source IP Address Source Port Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Source IP Address                                                              |
      | Criteria              | Event Criteria:Source Port,Operator:Equals,portType:Port,portValue:100         |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_37
  Scenario: create new Output Source Ports Source Port Not Equal
    When UI "Create" Forensics With Name "Output Source Port Source Port Not Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Source Port                                                                                                      |
      | Criteria              | Event Criteria:Source Port,Operator:Not Equals,portType:Port,portValue:1024                                      |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_38
  Scenario: create new Output Destination IP Address Source Port Equal
    When UI "Create" Forensics With Name "Output Destination IP Address Source Port Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Destination IP Address                                                         |
      | Criteria              | Event Criteria:Source Port,Operator:Equals,portType:Port,portValue:53          |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_39
  Scenario: create new Output Destination Port Source Port Equal
    When UI "Create" Forensics With Name "Output Destination Port Source Port Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Destination Port                                                                                                 |
      | Criteria              | Event Criteria:Source Port,Operator:Equals,portType:Port Range,portFrom:100,portTo:1024                          |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_40
  Scenario: create new Output Direction Source Port Not Equal
    When UI "Create" Forensics With Name "Output Direction Source Port Not Equal"
      | Product               | DefensePro                                                                                |
      | Output                | Direction                                                                                 |
      | Criteria              | Event Criteria:Source Port,Operator:Not Equals,portType:Port Range,portFrom:90,portTo:100 |
      | devices               | All                                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body            |
      | Format                | Select: CSV                                                                               |

  @SID_41
  Scenario: create new Output Protocol Threat Category Equal
    When UI "Create" Forensics With Name "Output Protocol Threat Category Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Protocol                                                                                                         |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[ACL]                                                       |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_42
  Scenario: create new Output Radware ID Threat Category Equal
    When UI "Create" Forensics With Name "Output Radware ID Threat Category Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Radware ID                                                                     |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Anti Scanning]           |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_43
  Scenario: create new Output Duration Threat Category Equal
    When UI "Create" Forensics With Name "Output Duration Threat Category Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Duration                                                                                                         |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Behavioral DoS]                                            |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_44
  Scenario: create new Output Total Packets Dropped Threat Category Equal
    When UI "Create" Forensics With Name "Output Total Packets Dropped Threat Category Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Total Packets Dropped                                                          |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[DoS]                     |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1Y                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_45
  Scenario: create new Output Max pps Threat Category Equal
    When UI "Create" Forensics With Name "Output Max pps Threat Category Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Max pps                                                                                                          |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[HTTP Flood]                                                |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:This Month                                                                                                 |
      | Schedule              | Run Every:once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_46
  Scenario: create new Output Total Mbits Dropped Threat Category Equal
    When UI "Create" Forensics With Name "Output Total Mbits Dropped Threat Category Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Total Mbits Dropped                                                            |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[HTTPS Flood]             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_47
  Scenario: create new Output Max Kbps Threat Category Equal
    When UI "Create" Forensics With Name "Output Max Kbps Threat Category Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Max Kbps                                                                                                         |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Intrusions]                                                |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_48
  Scenario: create new Output Physical Port Threat Category Equal
    When UI "Create" Forensics With Name "Output Physical Port Threat Category Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Physical Port                                                                  |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Cracking Protection]     |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_49
  Scenario: create new Output Risk Threat Category Equal
    When UI "Create" Forensics With Name "Output Risk Threat Category Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Risk                                                                                                             |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[SYN Flood]                                                 |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_50
  Scenario: create new Output VLAN Tag Threat Category Equal
    When UI "Create" Forensics With Name "Output VLAN Tag Threat Category Equal"
      | Product               | DefensePro                                                                     |
      | Output                | VLAN Tag                                                                       |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Anomalies]               |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Days,2]                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_51
  Scenario: create new Output Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped Threat Category Equal
    When UI "Create" Forensics With Name "Output Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped Threat Category Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped             |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Stateful ACL]                                              |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,4]                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR]                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_52
  Scenario: create new Output Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag Threat Category Equal
    When UI "Create" Forensics With Name "Output Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag Threat Category Equal"
      | Product               | DefensePro                                                                                                                                       |
      | Output                | Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag  |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[DNS Flood]                                                                                 |
      | devices               | All                                                                                                                                              |
      | Time Definitions.Date | Quick:1D                                                                                                                                         |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                   |
      | Format                | Select: CSV                                                                                                                                      |

  @SID_53
  Scenario: create new Output Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps Threat Category Equal
    When UI "Create" Forensics With Name "Output Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps Threat Category Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps           |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Bandwidth Management]                                      |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_54
  Scenario: create new Output Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action Threat Category Equal
    When UI "Create" Forensics With Name "Output Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action Threat Category Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action       |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Traffic Filters]         |
      | devices               | index:10                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_55
  Scenario: create new Output Policy Name,Source IP Address Threat Category Equal
    When UI "Create" Forensics With Name "Output Policy Name,Source IP Address Threat Category Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Policy Name,Source IP Address                                                                                    |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Malicious IP Addresses]                                    |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_56
  Scenario: create new Output Destination IP Address,Destination Port,Direction Threat Category Equal
    When UI "Create" Forensics With Name "Output Destination IP Address,Destination Port,Direction Threat Category Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Destination IP Address,Destination Port,Direction                              |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Geolocation]             |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_57
  Scenario: create new Output All Threat Category Equal
    When UI "Create" Forensics With Name "Output All Threat Category Equal"
      | Product               | DefensePro                                                                                                                                                                                                                                                                                         |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max Kbps,Physical Port,Risk,VLAN Tag |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Connection PPS]                                                                                                                                                                                                                              |
      | devices               | All                                                                                                                                                                                                                                                                                                |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                                                                                                                                                                                                       |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                   |
      | Format                | Select: CSV with Attack Detail                                                                                                                                                                                                                                                                     |

  @SID_58
  Scenario: create new Output Start Time Threat Category Equal
    When UI "Create" Forensics With Name "Output Start Timen Threat Category Equal"
      | Product               | DefensePro                                                                                                                                                                                                                                                                          |
      | Output                | Start Time                                                                                                                                                                                                                                                                          |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[ACL,Anti Scanning,Behavioral DoS,DoS,HTTP Flood,HTTPS Flood,Intrusions,Cracking Protection,SYN Flood,Anomalies,Stateful ACL,DNS Flood,Bandwidth Management,Traffic Filters,Malicious IP Addresses,Geolocation,Connection PPS] |
      | devices               | index:10                                                                                                                                                                                                                                                                            |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                                                                                                                                                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                      |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                        |

  @SID_59
  Scenario: create new Output End Time Threat Category Equal
    When UI "Create" Forensics With Name "Output End Time Threat Category Equal"
      | Product               | DefensePro                                                                                                            |
      | Output                | End Time                                                                                                              |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Anti Scanning,Behavioral DoS,DoS,Cracking Protection,SYN Flood] |
      | devices               | All                                                                                                                   |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                   |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware      |
      | Format                | Select: CSV                                                                                                           |

  @SID_60
  Scenario: create new Output Device IP Address Threat Category Not Equal
    When UI "Create" Forensics With Name "Output Device IP Address Threat Category Not Equal"
      | Product               | DefensePro                                                                                                                                      |
      | Output                | Device IP Address                                                                                                                               |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[HTTP Flood,HTTPS Flood,Anomalies,Stateful ACL,Traffic Filters,Malicious IP Addresses] |
      | devices               | All                                                                                                                                             |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                  |
      | Format                | Select: CSV                                                                                                                                     |

  @SID_61
  Scenario: create new Output Threat Category Threat Category Not Equal
    When UI "Create" Forensics With Name "Output Threat Category Threat Category Not Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Threat Category                                                                                                  |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[DNS Flood,Connection PPS],condition.Any:true;                             |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_62
  Scenario: create new Output Attack Name1,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps Threat Category Not Equal
    When UI "Create" Forensics With Name "Output Attack Name1,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps Threat Category Not Equal"
      | Product               | DefensePro                                                                                                                                                                                                                                                                              |
      | Output                | Attack Name,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps                                                                                                                                                                                                                  |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[ACL,Anti Scanning,Behavioral DoS,DoS,HTTP Flood,HTTPS Flood,Intrusions,Cracking Protection,SYN Flood,Anomalies,Stateful ACL,DNS Flood,Bandwidth Management,Traffic Filters,Malicious IP Addresses,Geolocation,Connection PPS] |
      | devices               | index:10                                                                                                                                                                                                                                                                                |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                                                          |
      | Format                | Select: HTML                                                                                                                                                                                                                                                                            |

  @SID_63
  Scenario: create new Output Attack Name2,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps Custom
    When UI "Create" Forensics With Name "Output Attack Name2,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps Custom"
      | Product               | DefensePro                                                                                                                                             |
      | Output                | Attack Name,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps                                                                                 |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Actions:Http 403 Forbidden;Event Criteria:Duration,Operator:Equals,Value:[5-10 min],condition.Custom:1 AND 2 |
      | devices               | All                                                                                                                                                    |
      | Schedule              | Run Every:once, On Time:+6H                                                                                                                            |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                       |
      | Format                | Select: CSV                                                                                                                                            |

  @SID_64
  Scenario: create new Output Start Time,End Time,Device IP Address,Action,Source IP Address,Source Port,Destination IP Address,Destination Port Custom
    When UI "Create" Forensics With Name "Output Start Time,End Time,Device IP Address,Action,Source IP Address,Source Port,Destination IP Address,Destination Port Custom"
      | Product               | DefensePro                                                                                                                                                        |
      | Output                | Start Time,End Time,Device IP Address,Action,Source IP Address,Source Port,Destination IP Address,Destination Port                                                |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Actions:Challenge,Event Criteria:Threat Category,Operator:Equals,Value:[Malicious IP Addresses],condition.Custom:1 OR 2 |
      | devices               | All                                                                                                                                                               |
      | Time Definitions.Date | Quick:1Y                                                                                                                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                    |
      | Format                | Select: CSV                                                                                                                                                       |

  @SID_65
  Scenario: Logout
    Then UI logout and close browser





































































