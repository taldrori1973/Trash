@TC119585
Feature:Create AppWall Part2

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage

  @SID_2
  Scenario: create new Output all1 Equal Destination IP
    When UI "Create" Forensics With Name "Output all1 Equal Destination IP"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Destination IP,Operator:Equals,IPType:IPv4,IPValue:1.1.1.1                                                                                                                                                                    |
      | devices               | All                                                                                                                                                                                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                             |
      | Format                | Select: CSV with Attack Detail                                                                                                                                                                                                               |

  @SID_3
  Scenario: create new Output all2 Not Equal Destination IP
    When UI "Create" Forensics With Name "Output all2 Not Equal Destination IP"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Destination IP,Operator:Not Equals,IPType:IPv4,IPValue:2.2.3.3                                                                                                                                                                |
      | devices               | index:10                                                                                                                                                                                                                                     |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                               |
      | Format                | Select: HTML                                                                                                                                                                                                                                 |

  @SID_4
  Scenario: create new Output all3 Not Equal Destination IP
    When UI "Create" Forensics With Name "Output all3 Not Equal Destination IP"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Destination IP,Operator:Not Equals,IPType:IPv6,IPValue:2001:db8:3c4d:15::1a2f:1a2b                                                                                                                                            |
      | devices               | All                                                                                                                                                                                                                                          |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                           |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                             |
      | Format                | Select: CSV                                                                                                                                                                                                                                  |

  @SID_5
  Scenario: create new Output all4 Equal Destination IP
    When UI "Create" Forensics With Name "Output all4 Equal Destination IP"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Destination IP,Operator:Equals,IPType:IPv6,IPValue:2001:0db8:3c4d:0015:0000:0000:1a2f:1a2b                                                                                                                                    |
      | devices               | All                                                                                                                                                                                                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                               |
      | Format                | Select: CSV                                                                                                                                                                                                                                  |

  @SID_6
  Scenario: create new Output all5 Equal Destination IP
    When UI "Create" Forensics With Name "Output all5 Equal Destination IP"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Destination IP,Operator:Equals,IPType:IPv6,IPValue:fe80::23a1:b152                                                                                                                                                            |
      | devices               | All                                                                                                                                                                                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                                                                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                             |
      | Format                | Select: CSV with Attack Detail                                                                                                                                                                                                               |

  @SID_7
  Scenario: create new Output all Equal Device Host Name
    When UI "Create" Forensics With Name "Output all Equal Device Host Name"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Device Host Name,Operator:Equals,Value:Name                                                                                                                                                                                   |
      | devices               | index:10                                                                                                                                                                                                                                     |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                               |
      | Format                | Select: HTML                                                                                                                                                                                                                                 |

  @SID_8
  Scenario: create new Output all Not Equal Device Host Name
    When UI "Create" Forensics With Name "Output all Not Equal Device Host Name"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Device Host Name,Operator:Not Equals,Value:Name                                                                                                                                                                               |
      | devices               | All                                                                                                                                                                                                                                          |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                           |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                             |
      | Format                | Select: CSV                                                                                                                                                                                                                                  |

  @SID_9
  Scenario: create new Output all1 Equal Device IP
    When UI "Create" Forensics With Name "Output all1 Equal Device IP"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Device IP,Operator:Equals,IPType:IPv4,IPValue:1.1.1.1                                                                                                                                                                         |
      | devices               | All                                                                                                                                                                                                                                          |
      | Time Definitions.Date | Quick:1Y                                                                                                                                                                                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                               |
      | Format                | Select: CSV                                                                                                                                                                                                                                  |

  @SID_10
  Scenario: create new Output all2 Not Equal Device IP
    When UI "Create" Forensics With Name "Output all2 Not Equal Device IP"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Device IP,Operator:Not Equals,IPType:IPv4,IPValue:2.2.3.3                                                                                                                                                                     |
      | devices               | All                                                                                                                                                                                                                                          |
      | Time Definitions.Date | Quick:This Month                                                                                                                                                                                                                             |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                                                                                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                             |
      | Format                | Select: CSV with Attack Detail                                                                                                                                                                                                               |

  @SID_11
  Scenario: create new Output all3 Not Equal Device IP
    When UI "Create" Forensics With Name "Output all3 Not Equal Device IP"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Device IP,Operator:Not Equals,IPType:IPv6,IPValue:2001:db8:3c4d:15::1a2f:1a2b                                                                                                                                                 |
      | devices               | index:10                                                                                                                                                                                                                                     |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                               |
      | Format                | Select: HTML                                                                                                                                                                                                                                 |

  @SID_12
  Scenario: create new Output all4 Equal Device IP
    When UI "Create" Forensics With Name "Output all4 Equal Device IP"
      | Product               | AppWall                                                                                                                                                                                                                                      |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Device IP,Operator:Equals,IPType:IPv6,IPValue:2001:0db8:3c4d:0015:0000:0000:1a2f:1a2b                                                                                                                                         |
      | devices               | All                                                                                                                                                                                                                                          |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                                                                                                                                           |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                                                                                                                                                 |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                             |
      | Format                | Select: CSV                                                                                                                                                                                                                                  |

  @SID_13
  Scenario: create new Output Event Description,Action,Attack Name,Device Host Name Equal Device IP
    When UI "Create" Forensics With Name "Output Event Description,Action,Attack Name,Device Host Name Equal Device IP"
      | Product               | AppWall                                                                        |
      | Output                | Event Description,Action,Attack Name,Device Host Name                          |
      | Criteria              | Event Criteria:Device IP,Operator:Equals,IPType:IPv6,IPValue:fe80::23a1:b152   |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_14
  Scenario: create new Directory Equal
    When UI "Create" Forensics With Name "Directory Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Device IP,Source IP,Destination IP Address,Cluster Manager IP                                                    |
      | Criteria              | Event Criteria:Directory,Operator:Equals,Value:Name                                                              |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_15
  Scenario: create new Directory Not Equal
    When UI "Create" Forensics With Name "Directory Not Equal"
      | Product               | AppWall                                                                        |
      | Output                | Date and Time,Source Port                                                      |
      | Criteria              | Event Criteria:Directory,Operator:Not Equals,Value:Name                        |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_16
  Scenario: create new Module Equal
    When UI "Create" Forensics With Name "Module Equal"
      | Product               | AppWall                                                                                                                                              |
      | Output                | Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Module,Operator:Equals,Value:Name                                                                                                     |
      | devices               | All                                                                                                                                                  |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                   |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                          |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                     |
      | Format                | Select: CSV                                                                                                                                          |

  @SID_17
  Scenario: create new Module Not Equal
    When UI "Create" Forensics With Name "Module Not Equal"
      | Product               | AppWall                                                                        |
      | Output                | Action,Threat Category                                                         |
      | Criteria              | Event Criteria:Module,Operator:Not Equals,Value:Name                           |
      | devices               | All                                                                            |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_18
  Scenario: create new Transaction ID Equal
    When UI "Create" Forensics With Name "Transaction ID Equal"
      | Product               | AppWall                                                                                                                       |
      | Output                | Web Application Name,Event Description,Attack Name,Device Host Name,Directory,Module,Severity,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Transaction ID,Operator:Equals,Value:Name                                                                      |
      | devices               | All                                                                                                                           |
      | Time Definitions.Date | Quick:3M                                                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                               |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware              |
      | Format                | Select: CSV with Attack Detail                                                                                                |

  @SID_19
  Scenario: create new Transaction ID Not Equal
    When UI "Create" Forensics With Name "Transaction ID Not Equal"
      | Product               | AppWall                                                                         |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Action,Threat Category |
      | Criteria              | Event Criteria:Transaction ID,Operator:Not Equals,Value:Name                    |
      | devices               | index:10                                                                        |
      | Time Definitions.Date | Quick:This Month                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body  |
      | Format                | Select: HTML                                                                    |

  @SID_20
  Scenario: create new Severity1 Equal
    When UI "Create" Forensics With Name "Severity1 Equal"
      | Product               | AppWall                                                                                                    |
      | Output                | Date and Time,Device IP,Source Port,Web Application Name,Action,Attack Name,Threat Category,Transaction ID |
      | Criteria              | Event Criteria:Severity,Operator:Equals,Value:[Critical]                                                   |
      | devices               | index:10                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                             |
      | Format                | Select: HTML                                                                                               |

  @SID_21
  Scenario: create new Severity2 Equal
    When UI "Create" Forensics With Name "Severity2 Equal"
      | Product               | AppWall                                                                                                                           |
      | Output                | Source IP,Destination IP Address,Cluster Manager IP,Event Description,Device Host Name,Directory,Module,Severity,Tunnel,User Name |
      | Criteria              | Event Criteria:Severity,Operator:Equals,Value:[High]                                                                              |
      | devices               | All                                                                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                    |
      | Format                | Select: CSV                                                                                                                       |

  @SID_22
  Scenario: create new Severity3 Not Equal
    When UI "Create" Forensics With Name "Severity3 Not Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Cluster Manager IP,Attack Name                                                                                   |
      | Criteria              | Event Criteria:Severity,Operator:Not Equals,Value:[Medium]                                                       |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_23
  Scenario: create new Severity4 Not Equal
    When UI "Create" Forensics With Name "Severity4 Not Equal"
      | Product               | AppWall                                                                        |
      | Output                | Source IP                                                                      |
      | Criteria              | Event Criteria:Severity,Operator:Not Equals,Value:[Lowest]                     |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Days,2]                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_24
  Scenario: create new Severity5 Equal
    When UI "Create" Forensics With Name "Severity5 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Destination IP Address,Cluster Manager IP,Event Description,Device Host Name,Severity,User Name                  |
      | Criteria              | Event Criteria:Severity,Operator:Equals,Value:[emergency]                                                        |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_25
  Scenario: create new Severity6 Equal
    When UI "Create" Forensics With Name "Severity6 Equal"
      | Product               | AppWall                                                                        |
      | Output                | Date and Time                                                                  |
      | Criteria              | Event Criteria:Severity,Operator:Equals,Value:[alert]                          |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1D                                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_26
  Scenario: create new Severity7 Equal
    When UI "Create" Forensics With Name "Severity7 Equal"
      | Product               | AppWall                                                                                                                                                                    |
      | Output                | Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category |
      | Criteria              | Event Criteria:Severity,Operator:Equals,Value:[error]                                                                                                                      |
      | devices               | All                                                                                                                                                                        |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                           |
      | Schedule              | Run Every:once, On Time:+6H                                                                                                                                                |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                           |
      | Format                | Select: CSV with Attack Detail                                                                                                                                             |

  @SID_27
  Scenario: create new Severity8 Not Equal
    When UI "Create" Forensics With Name "Severity8 Not Equal"
      | Product               | AppWall                                                                        |
      | Output                | Date and Time,Device IP,Source IP,Transaction ID,Tunnel                        |
      | Criteria              | Event Criteria:Severity,Operator:Not Equals,Value:[error]                      |
      | devices               | index:10                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_28
  Scenario: create new Severity9 Not Equal
    When UI "Create" Forensics With Name "Severity9 Not  Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Event Description,Action,Attack Name,Device Host Name                                                            |
      | Criteria              | Event Criteria:Severity,Operator:Not Equals,Value:[notice]                                                       |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_29
  Scenario: create new Severity10 Not Equal
    When UI "Create" Forensics With Name "Severity10 Not Equal"
      | Product               | AppWall                                                                        |
      | Output                | Device IP,Source IP,Destination IP Address,Cluster Manager IP                  |
      | Criteria              | Event Criteria:Severity,Operator:Not Equals,Value:[information]                |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_30
  Scenario: create new Severity11 Equal
    When UI "Create" Forensics With Name "Severity11 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Date and Time,Source Port                                                                                        |
      | Criteria              | Event Criteria:Severity,Operator:Equals,Value:[debug]                                                            |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_31
  Scenario: create new Severity12 Equal
    When UI "Create" Forensics With Name "Severity12 Equal"
      | Product               | AppWall                                                                                                                                              |
      | Output                | Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Severity,Operator:Equals,Value:[emergency,alert,warning,notice,information]                                                           |
      | devices               | index:10                                                                                                                                             |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                       |
      | Format                | Select: HTML                                                                                                                                         |

  @SID_32
  Scenario: create new Severity13 Equal
    When UI "Create" Forensics With Name "Severity13 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Action,Threat Category                                                                                           |
      | Criteria              | Event Criteria:Severity,Operator:Equals,Value:[Medium,Lowest]                                                    |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_33
  Scenario: create new Severity14 Not Equal
    When UI "Create" Forensics With Name "Severity14 Not Equal"
      | Product               | AppWall                                                                                                                       |
      | Output                | Web Application Name,Event Description,Attack Name,Device Host Name,Directory,Module,Severity,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Severity,Operator:Not Equals,Value:[Medium,Lowest,error]                                                       |
      | devices               | All                                                                                                                           |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                |
      | Format                | Select: CSV                                                                                                                   |

  @SID_34
  Scenario: create new Severity15 Equal
    When UI "Create" Forensics With Name "Severity15 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Action,Threat Category                                  |
      | Criteria              | Event Criteria:Severity,Operator:Equals,Value:[Critical]                                                         |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_35
  Scenario: create new Severity16 Equal
    When UI "Create" Forensics With Name "Severity16 Equal"
      | Product               | AppWall                                                                                                                            |
      | Output                | Date and Time,Device IP,Source Port,Web Application Name,Action,Attack Name,Threat Category,Transaction ID                         |
      | Criteria              | Event Criteria:Severity,Operator:Equals,Value:[Critical,High,Medium,Lowest,emergency,alert,error,warning,notice,information,debug] |
      | devices               | index:10                                                                                                                           |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                     |
      | Format                | Select: HTML                                                                                                                       |

  @SID_36
  Scenario: create new Severity17 Not Equal
    When UI "Create" Forensics With Name "Severity17 Not Equal"
      | Product               | AppWall                                                                                                                                |
      | Output                | Source IP,Destination IP Address,Cluster Manager IP,Event Description,Device Host Name,Directory,Module,Severity,Tunnel,User Name      |
      | Criteria              | Event Criteria:Severity,Operator:Not Equals,Value:[Critical,High,Medium,Lowest,emergency,alert,error,warning,notice,information,debug] |
      | devices               | index:10                                                                                                                               |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                            |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                       |
      | Format                | Select: CSV                                                                                                                            |

  @SID_37
  Scenario: create new Source IP1 Equal
    When UI "Create" Forensics With Name "Source IP1 Equal"
      | Product               | AppWall                                                                        |
      | Output                | Cluster Manager IP,Attack Name                                                 |
      | Criteria              | Event Criteria:Source IP,Operator:Equals,IPType:IPv4,IPValue:1.1.1.1           |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1Y                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |

  @SID_38
  Scenario: create new Source IP2 Not Equal
    When UI "Create" Forensics With Name "Source IP2 Not Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Source IP                                                                                                        |
      | Criteria              | Event Criteria:Source IP,Operator:Not Equals,IPType:IPv4,IPValue:2.2.3.3                                         |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:This Month                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_39
  Scenario: create new Source IP3 Not Equal
    When UI "Create" Forensics With Name "Source IP3 Not Equal"
      | Product               | AppWall                                                                                         |
      | Output                | Destination IP Address,Cluster Manager IP,Event Description,Device Host Name,Severity,User Name |
      | Criteria              | Event Criteria:Source IP,Operator:Not Equals,IPType:IPv6,IPValue:2001:db8:3c4d:15::1a2f:1a2b    |
      | devices               | index:10                                                                                        |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |
      | Format                | Select: HTML                                                                                    |

  @SID_40
  Scenario: create new Source IP4 Equal
    When UI "Create" Forensics With Name "Source IP4 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Date and Time                                                                                                    |
      | Criteria              | Event Criteria:Source IP,Operator:Equals,IPType:IPv6,IPValue:2001:0db8:3c4d:0015:0000:0000:1a2f:1a2b             |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_41
  Scenario: create new Source IP5 Equal
    When UI "Create" Forensics With Name "Source IP5 Equal"
      | Product               | AppWall                                                                                                                                                                    |
      | Output                | Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category |
      | Criteria              | Event Criteria:Source IP,Operator:Equals,IPType:IPv6,IPValue:fe80::23a1:b152                                                                                               |
      | devices               | All                                                                                                                                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                             |
      | Format                | Select: CSV                                                                                                                                                                |

  @SID_42
  Scenario: create new Source Port1 Equal
    When UI "Create" Forensics With Name "Source Port1 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Date and Time,Device IP,Source IP,Transaction ID,Tunnel                                                           |
      | Criteria              | Event Criteria:Source Port,Operator:Equals,portType:Port,portValue:1024                                          |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV with Attack Detail                                                                                   |

  @SID_43
  Scenario: create new Source Port2 Not Equal
    When UI "Create" Forensics With Name "Source Port2 Not Equal"
      | Product               | AppWall                                                                        |
      | Output                | Event Description,Action,Attack Name,Device Host Name                          |
      | Criteria              | Event Criteria:Source Port,Operator:Not Equals,portType:Port,portValue:88      |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |

  @SID_44
  Scenario: create new Source Port3 Equal
    When UI "Create" Forensics With Name "Source Port3 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Device IP,Source IP,Destination IP Address,Cluster Manager IP                                                    |
      | Criteria              | Event Criteria:Source Port,Operator:Equals,portType:Port Range,portFrom:50,portTo:90                             |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |

  @SID_45
  Scenario: create new Source Port4 Not Equal
    When UI "Create" Forensics With Name "Source Port4 Not Equal"
      | Product               | AppWall                                                                                 |
      | Output                | Date and Time,Source Port                                                               |
      | Criteria              | Event Criteria:Source Port,Operator:Not Equals,portType:Port Range,portFrom:0,portTo:24 |
      | devices               | All                                                                                     |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                        |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body          |
      | Format                | Select: CSV                                                                             |

  @SID_46
  Scenario: Logout
    Then UI logout and close browser



























































































































