@ADC @TC105966
Feature: DPM Virtual Services Table


  @SID_1
  Scenario: Login and open application dashboard
    * REST Vision Install License Request "vision-reporting-module-ADC"
    Then UI Login with user "sys_admin" and password "radware"
    And UI Open Upper Bar Item "ADC"
    Then UI Open "Reports" Tab
    And UI Open "Dashboards" Tab
    And UI Open "Application Dashboard" Sub Tab

#=========================================Validate table records and tooltip============================================

  @SID_2
  Scenario:Validate Table record values
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1_32326516:80"
      | columnName             | value         |
      | Application Name       | 1_32326516:80 |
      | Protocol               | http          |
      | IP Address             | 101.41.1.100  |
      | Throughput(bps)        | 2.29          |
      | Connectionsper Second  | 246           |
      | Groups(Up/Total)       | 0/2           |
      | Real Servers(Up/Total) | 0/13          |
      | ConcurrentConnections  | 0             |

    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:200"
      | columnName             | value           |
      | Application Name       | virtserver1:200 |
      | Protocol               | Basic-SLB       |
      | IP Address             | 66.66.66.66     |
      | Throughput(bps)        | 0               |
      | Connectionsper Second  | 0               |
      | Groups(Up/Total)       | 0/1             |
      | Real Servers(Up/Total) | 0/3             |
      | ConcurrentConnections  | 0               |

    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:443"
      | columnName             | value           |
      | Application Name       | virtserver1:443 |
      | Protocol               | https           |
      | IP Address             | 66.66.66.66     |
      | Throughput(bps)        | 0               |
      | Connectionsper Second  | 0               |
      | Groups(Up/Total)       | 0/1             |
      | Real Servers(Up/Total) | 0/4             |
      | ConcurrentConnections  | 0               |

    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:80"
      | columnName             | value          |
      | Application Name       | virtserver1:80 |
      | Protocol               | http           |
      | IP Address             | 66.66.66.66    |
      | Throughput(bps)        | 0              |
      | Connectionsper Second  | 0              |
      | Groups(Up/Total)       | 0/2            |
      | Real Servers(Up/Total) | 0/7            |
      | ConcurrentConnections  | 0              |

    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:443"
      | columnName             | value              |
      | Application Name       | virtualserver2:443 |
      | Protocol               | https              |
      | IP Address             | 9.9.9.9            |
      | Throughput(bps)        | 0                  |
      | Connectionsper Second  | 0                  |
      | Groups(Up/Total)       | 0/1                |
      | Real Servers(Up/Total) | 0/3                |
      | ConcurrentConnections  | 0                  |

    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:80"
      | columnName             | value             |
      | Application Name       | virtualserver2:80 |
      | Protocol               | http              |
      | IP Address             | 9.9.9.9           |
      | Throughput(bps)        | 0                 |
      | Connectionsper Second  | 0                 |
      | Groups(Up/Total)       | 0/1               |
      | Real Servers(Up/Total) | 0/3               |
      | ConcurrentConnections  | 0                 |

    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:110"
      | columnName             | value              |
      | Application Name       | virtualserver3:110 |
      | Protocol               | pop3               |
      | IP Address             | 9.9.9.10           |
      | Throughput(bps)        | 0                  |
      | Connectionsper Second  | 0                  |
      | Groups(Up/Total)       | 0/1                |
      | Real Servers(Up/Total) | 0/3                |
      | ConcurrentConnections  | 0                  |

    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:443"
      | columnName             | value              |
      | Application Name       | virtualserver3:443 |
      | Protocol               | https              |
      | IP Address             | 9.9.9.10           |
      | Throughput(bps)        | 0                  |
      | Connectionsper Second  | 0                  |
      | Groups(Up/Total)       | 0/1                |
      | Real Servers(Up/Total) | 0/4                |
      | ConcurrentConnections  | 0                  |

    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:80"
      | columnName             | value             |
      | Application Name       | virtualserver3:80 |
      | Protocol               | http              |
      | IP Address             | 9.9.9.10          |
      | Throughput(bps)        | 0                 |
      | Connectionsper Second  | 0                 |
      | Groups(Up/Total)       | 0/1               |
      | Real Servers(Up/Total) | 0/4               |
      | ConcurrentConnections  | 0                 |

    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1234_32326515:80"
      | columnName       | value            |
      | Application Name | 1234_32326515:80 |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1234_32326515:80"
      | columnName | value |
      | Protocol   | http  |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1234_32326515:80"
      | columnName | value        |
      | IP Address | 101.41.1.100 |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1234_32326515:80"
      | columnName      | value |
      | Throughput(bps) | 4 bps |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1234_32326515:80"
      | columnName            | value |
      | Connectionsper Second | 6     |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1234_32326515:80"
      | columnName                 | value |
      | Groups(Up/Total)(Up/Total) | 1     |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1234_32326515:80"
      | columnName             | value |
      | Real Servers(Up/Total) | 1     |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1234_32326515:80"
      | columnName            | value |
      | ConcurrentConnections | 0     |

    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith:80"
      | columnName             | value                |
      | Application Name       | Rejith:80            |
      | Protocol               | http                 |
      | IP Address             | 3000:0:0:0:0:0:0:144 |
      | Throughput(bps)        | 11                   |
      | Connectionsper Second  | 13                   |
      | Groups(Up/Total)       | 0/1                  |
      | Real Servers(Up/Total) | 0/3                  |
      | ConcurrentConnections  | 0                    |

    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "2:443"
      | columnName             | value                                   |
      | Application Name       | 2:443                                   |
      | Protocol               | https                                   |
      | IP Address             | 2001:AAAA:1111:2222:3333:ABAB:0003:0001 |
      | Throughput(bps)        | 100.31                                  |
      | Connectionsper Second  | 4                                       |
      | Groups(Up/Total)       | 0/1                                     |
      | Real Servers(Up/Total) | 0/1                                     |
      | ConcurrentConnections  | 0                                       |

    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith:88"
      | columnName             | value                |
      | Application Name       | Rejith:88            |
      | Protocol               | http                 |
      | IP Address             | 3000:0:0:0:0:0:0:144 |
      | Throughput(bps)        | 11                   |
      | Connectionsper Second  | 13                   |
      | Groups(Up/Total)       | 0/0                  |
      | Real Servers(Up/Total) | 0/0                  |
      | ConcurrentConnections  | 0                    |

    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtmax_255-ABC.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccccddddddddddddddddddddeeeeeeeeeeeeeeeeeeeffffffffffffgh:80"
      | columnName             | value                                                                                                                                                                                                                                                              |
      | Application Name       | virtmax_255-ABC.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccccddddddddddddddddddddeeeeeeeeeeeeeeeeeeeffffffffffffgh:80 |
      | Protocol               | http                                                                                                                                                                                                                                                               |
      | IP Address             | 7.7.7.100                                                                                                                                                                                                                                                          |
      | Throughput(bps)        | 9.22                                                                                                                                                                                                                                                               |
      | Connectionsper Second  | 2,147,483,647                                                                                                                                                                                                                                                      |
      | Groups(Up/Total)       | 0/1                                                                                                                                                                                                                                                                |
      | Real Servers(Up/Total) | 0/1                                                                                                                                                                                                                                                                |
      | ConcurrentConnections  | 0                                                                                                                                                                                                                                                                  |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith:443"
      | columnName             | value                |
      | Application Name       | Rejith:443           |
      | Protocol               | https                |
      | IP Address             | 3000:0:0:0:0:0:0:144 |
      | Throughput(bps)        | 18                   |
      | Connectionsper Second  | 20                   |
      | Groups(Up/Total)       | 0/1                  |
      | Real Servers(Up/Total) | 0/3                  |
      | ConcurrentConnections  | 0                    |


  @SID_3
  Scenario:Validate Table record tooltip values
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1:80"

      | columnName             | value        |
      | Application Name       | 1:80         |
      | Protocol               | http         |
      | IP Address             | 101.41.1.100 |
      | Throughput(bps)        | 2.29         |
      | Connectionsper Second  | 246          |
      | Groups(Up/Total)       | 0/2          |
      | Real Servers(Up/Total) | 0/2          |
      | ConcurrentConnections  | 0            |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:200"
      | columnName             | value           |
      | Application Name       | virtserver1:200 |
      | Protocol               | Basic-SLB       |
      | IP Address             | 66.66.66.66     |
      | Throughput(bps)        | 0               |
      | Connectionsper Second  | 0               |
      | Groups(Up/Total)       | 0/1             |
      | Real Servers(Up/Total) | 0/3             |
      | ConcurrentConnections  | 0               |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:443"
      | columnName             | value           |
      | Application Name       | virtserver1:443 |
      | Protocol               | https           |
      | IP Address             | 66.66.66.66     |
      | Throughput(bps)        | 0               |
      | Connectionsper Second  | 0               |
      | Groups(Up/Total)       | 0/1             |
      | Real Servers(Up/Total) | 0/4             |
      | ConcurrentConnections  | 0               |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:80"
      | columnName             | value          |
      | Application Name       | virtserver1:80 |
      | Protocol               | http           |
      | IP Address             | 66.66.66.66    |
      | Throughput(bps)        | 0              |
      | Connectionsper Second  | 0              |
      | Groups(Up/Total)       | 0/2            |
      | Real Servers(Up/Total) | 0/7            |
      | ConcurrentConnections  | 0              |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:443"
      | columnName             | value              |
      | Application Name       | virtualserver2:443 |
      | Protocol               | https              |
      | IP Address             | 9.9.9.9            |
      | Throughput(bps)        | 0                  |
      | Connectionsper Second  | 0                  |
      | Groups(Up/Total)       | 0/1                |
      | Real Servers(Up/Total) | 0/3                |
      | ConcurrentConnections  | 0                  |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:80"
      | columnName             | value             |
      | Application Name       | virtualserver2:80 |
      | Protocol               | http              |
      | IP Address             | 9.9.9.9           |
      | Throughput(bps)        | 0                 |
      | Connectionsper Second  | 0                 |
      | Groups(Up/Total)       | 0/1               |
      | Real Servers(Up/Total) | 0/3               |
      | ConcurrentConnections  | 0                 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:110"
      | columnName             | value              |
      | Application Name       | virtualserver3:110 |
      | Protocol               | pop3               |
      | IP Address             | 9.9.9.10           |
      | Throughput(bps)        | 0                  |
      | Connectionsper Second  | 0                  |
      | Groups(Up/Total)       | 0/1                |
      | Real Servers(Up/Total) | 0/3                |
      | ConcurrentConnections  | 0                  |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:443"
      | columnName             | value              |
      | Application Name       | virtualserver3:443 |
      | Protocol               | https              |
      | IP Address             | 9.9.9.10           |
      | Throughput(bps)        | 0                  |
      | Connectionsper Second  | 0                  |
      | Groups(Up/Total)       | 0/1                |
      | Real Servers(Up/Total) | 0/4                |
      | ConcurrentConnections  | 0                  |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:80"
      | columnName             | value             |
      | Application Name       | virtualserver3:80 |
      | Protocol               | http              |
      | IP Address             | 9.9.9.10          |
      | Throughput(bps)        | 0                 |
      | Connectionsper Second  | 0                 |
      | Groups(Up/Total)       | 0/1               |
      | Real Servers(Up/Total) | 0/4               |
      | ConcurrentConnections  | 0                 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1234:80"
      | columnName             | value        |
      | Application Name       | 1234:80      |
      | Protocol               | http         |
      | IP Address             | 101.41.1.100 |
      | Throughput(bps)        | 4            |
      | Connectionsper Second  | 6            |
      | Groups(Up/Total)       | 0/1          |
      | Real Servers(Up/Total) | 0/1          |
      | ConcurrentConnections  | 0            |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith:80"
      | columnName             | value                |
      | Application Name       | Rejith:80            |
      | Protocol               | http                 |
      | IP Address             | 3000:0:0:0:0:0:0:144 |
      | Throughput(bps)        | 11                   |
      | Connectionsper Second  | 13                   |
      | Groups(Up/Total)       | 0/1                  |
      | Real Servers(Up/Total) | 0/3                  |
      | ConcurrentConnections  | 0                    |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "2:443"
      | columnName             | value                                   |
      | Application Name       | 2:443                                   |
      | Protocol               | https                                   |
      | IP Address             | 2001:AAAA:1111:2222:3333:ABAB:0003:0001 |
      | Throughput(bps)        | 100.31                                  |
      | Connectionsper Second  | 4                                       |
      | Groups(Up/Total)       | 0/1                                     |
      | Real Servers(Up/Total) | 0/1                                     |
      | ConcurrentConnections  | 0                                       |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith:88"
      | columnName             | value                |
      | Application Name       | Rejith:88            |
      | Protocol               | http                 |
      | IP Address             | 3000:0:0:0:0:0:0:144 |
      | Throughput(bps)        | 11                   |
      | Connectionsper Second  | 13                   |
      | Groups(Up/Total)       | 0/0                  |
      | Real Servers(Up/Total) | 0/0                  |
      | ConcurrentConnections  | 0                    |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtmax_255-ABC.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccccddddddddddddddddddddeeeeeeeeeeeeeeeeeeeffffffffffffgh:80"
      | columnName             | value                                                                                                                                                                                                                                                              |
      | Application Name       | virtmax_255-ABC.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccccddddddddddddddddddddeeeeeeeeeeeeeeeeeeeffffffffffffgh:80 |
      | Protocol               | http                                                                                                                                                                                                                                                               |
      | IP Address             | 7.7.7.100                                                                                                                                                                                                                                                          |
      | Throughput(bps)        | 9.22                                                                                                                                                                                                                                                               |
      | Connectionsper Second  | 2,147,483,647                                                                                                                                                                                                                                                      |
      | Groups(Up/Total)       | 0/1                                                                                                                                                                                                                                                                |
      | Real Servers(Up/Total) | 0/1                                                                                                                                                                                                                                                                |
      | ConcurrentConnections  | 0                                                                                                                                                                                                                                                                  |
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith:443"
      | columnName             | value                |
      | Application Name       | Rejith:443           |
      | Protocol               | https                |
      | IP Address             | 3000:0:0:0:0:0:0:144 |
      | Throughput(bps)        | 18                   |
      | Connectionsper Second  | 20                   |
      | Groups(Up/Total)       | 0/1                  |
      | Real Servers(Up/Total) | 0/3                  |
      | ConcurrentConnections  | 0                    |


  #================================================Table Sorting Scenarios==============================================

  #Primary : Status Score by ascending order , Secondary: Virtual Service Name by ascending order.

  @SID_4
  Scenario: Validate virtual services table by Status (default case)
    Then UI Validate "virts table" Table rows count EQUALS to 15
    Then UI Validate "virts table" Table sorting by "Status"


  #Primary : THROUGHPUT by descending order , Secondary: Virtual Service Name by ascending order , Tertiary: Status Score by ascending order.

  @SID_5
  Scenario: Validate virtual services table by THROUGHPUT
    When UI Click Button "ThroughputSorting"
    Then UI Validate "virts table" Table rows count EQUALS to 15
    Then UI Validate "virts table" Table sorting by "Current Throughput"


  #Primary : Status Score by ascending order , Secondary: Virtual Service Name by ascending order.

  @SID_6
  Scenario: Validate virtual services table by Status (Sort Button)
    When UI Click Button "Status"
    Then UI Validate "virts table" Table rows count EQUALS to 15
    Then UI Validate "virts table" Table sorting by "Status"


    #Primary : Virtual Service Name by ascending order.

  @SID_7
  Scenario: Validate virtual services table by SERVICE NAME
    When UI Click Button "SERVICE NAME"
    Then UI Validate "virts table" Table rows count EQUALS to 15
    Then UI Validate "virts table" Table sorting by "Service Name"


  #=======================================================Filter Scenarios==============================================

  #-----------------------------Filter Results-----------------------------

  @SID_8
  Scenario: Filter table By Virtual Service Name
    Given UI Click Button "Status"

    When UI Set Text Field "virts table Search TextBox" To "1:80"
    And Sleep "3"

    Then UI Validate "virts table" Table rows count EQUALS to 3

    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1:80"
      | columnName       | value |
      | Application Name | 1:80  |

    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:80"
      | columnName       | value          |
      | Application Name | virtserver1:80 |

    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1234:80"
      | columnName       | value   |
      | Application Name | 1234:80 |

    When UI Set Text Field "virts table Search TextBox" To "virt"
    And Sleep "3"

    Then UI Validate "virts table" Table rows count EQUALS to 9

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:200"
      | columnName       | value           |
      | Application Name | virtserver1:200 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:443"
      | columnName       | value           |
      | Application Name | virtserver1:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:80"
      | columnName       | value          |
      | Application Name | virtserver1:80 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:443"
      | columnName       | value              |
      | Application Name | virtualserver2:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:80"
      | columnName       | value             |
      | Application Name | virtualserver2:80 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:110"
      | columnName       | value              |
      | Application Name | virtualserver3:110 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:443"
      | columnName       | value              |
      | Application Name | virtualserver3:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:80"
      | columnName       | value             |
      | Application Name | virtualserver3:80 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtmax_255-ABC.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccccddddddddddddddddddddeeeeeeeeeeeeeeeeeeeffffffffffffgh:80"
      | columnName       | value                                                                                                                                                                                                                                                              |
      | Application Name | virtmax_255-ABC.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccccddddddddddddddddddddeeeeeeeeeeeeeeeeeeeffffffffffffgh:80 |

  @SID_9
  Scenario:Filter table By Protocol
    When UI Set Text Field "virts table Search TextBox" To "basic"
    And Sleep "3"

    Then UI Validate "virts table" Table rows count EQUALS to 1
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:200"
      | columnName       | value           |
      | Application Name | virtserver1:200 |


    When UI Set Text Field "virts table Search TextBox" To "http"
    And Sleep "3"

    Then UI Validate "virts table" Table rows count EQUALS to 13
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1:80"
      | columnName       | value |
      | Application Name | 1:80  |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:443"
      | columnName       | value           |
      | Application Name | virtserver1:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:80"
      | columnName       | value          |
      | Application Name | virtserver1:80 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:443"
      | columnName       | value              |
      | Application Name | virtualserver2:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:80"
      | columnName       | value             |
      | Application Name | virtualserver2:80 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:443"
      | columnName       | value              |
      | Application Name | virtualserver3:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:80"
      | columnName       | value             |
      | Application Name | virtualserver3:80 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1234:80"
      | columnName       | value   |
      | Application Name | 1234:80 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith:80"
      | columnName       | value     |
      | Application Name | Rejith:80 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "2:443"
      | columnName       | value |
      | Application Name | 2:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith:88"
      | columnName       | value     |
      | Application Name | Rejith:88 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtmax_255-ABC.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccccddddddddddddddddddddeeeeeeeeeeeeeeeeeeeffffffffffffgh:80"
      | columnName       | value                                                                                                                                                                                                                                                              |
      | Application Name | virtmax_255-ABC.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccccddddddddddddddddddddeeeeeeeeeeeeeeeeeeeffffffffffffgh:80 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith:443"
      | columnName       | value      |
      | Application Name | Rejith:443 |


    When UI Set Text Field "virts table Search TextBox" To "https"
    And Sleep "3"

    Then UI Validate "virts table" Table rows count EQUALS to 5
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:443"
      | columnName       | value           |
      | Application Name | virtserver1:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:443"
      | columnName       | value              |
      | Application Name | virtualserver2:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:443"
      | columnName       | value              |
      | Application Name | virtualserver3:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "2:443"
      | columnName       | value |
      | Application Name | 2:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith:443"
      | columnName       | value      |
      | Application Name | Rejith:443 |

  @SID_10
  Scenario: Filter table By IP
    When UI Set Text Field "virts table Search TextBox" To "9.9.9"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 5
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:443"
      | columnName       | value              |
      | Application Name | virtualserver2:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:80"
      | columnName       | value             |
      | Application Name | virtualserver2:80 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:110"
      | columnName       | value              |
      | Application Name | virtualserver3:110 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:443"
      | columnName       | value              |
      | Application Name | virtualserver3:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:80"
      | columnName       | value             |
      | Application Name | virtualserver3:80 |

    When UI Set Text Field "virts table Search TextBox" To "9.9.9.10"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 3
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:110"
      | columnName       | value              |
      | Application Name | virtualserver3:110 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:443"
      | columnName       | value              |
      | Application Name | virtualserver3:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:80"
      | columnName       | value             |
      | Application Name | virtualserver3:80 |


  #-----------------------------Filter with Status sort-----------------------------

  @SID_11
  Scenario: Validate Sorting By Status After Filtering By Virtual Service Name
    When UI Set Text Field "virts table Search TextBox" To "1:80"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 3
    Then UI Validate "virts table" Table sorting by "Status"

    When UI Set Text Field "virts table Search TextBox" To "virt"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 9
    Then UI Validate "virts table" Table sorting by "Status"


  @SID_12
  Scenario: Validate Sorting By Status After Filtering By Protocol
    When UI Set Text Field "virts table Search TextBox" To "basic"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 1
    Then UI Validate "virts table" Table sorting by "Status"

    When UI Set Text Field "virts table Search TextBox" To "http"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 13
    Then UI Validate "virts table" Table sorting by "Status"

    When UI Set Text Field "virts table Search TextBox" To "https"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 5
    Then UI Validate "virts table" Table sorting by "Status"


  @SID_13
  Scenario: Validate Sorting By Status After Filtering By IP
    When UI Set Text Field "virts table Search TextBox" To "9.9.9"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 5
    Then UI Validate "virts table" Table sorting by "Status"

    When UI Set Text Field "virts table Search TextBox" To "9.9.9.10"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 3
    Then UI Validate "virts table" Table sorting by "Status"





  #-----------------------------Filter with Throughput sort-----------------------------

  @SID_14
  Scenario: Validate Sorting By Throughput After Filtering By Virtual Service Name
    When UI Click Button "THROUGHPUT"
    When UI Set Text Field "virts table Search TextBox" To "1:80"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 3
    Then UI Validate "virts table" Table sorting by "Throughput"

    When UI Set Text Field "virts table Search TextBox" To "virt"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 9
    Then UI Validate "virts table" Table sorting by "Throughput"

  @SID_15
  Scenario:Validate Sorting By Throughput After Filtering By Protocol
    When UI Set Text Field "virts table Search TextBox" To "basic"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 1
    Then UI Validate "virts table" Table sorting by "Throughput"

    When UI Set Text Field "virts table Search TextBox" To "http"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 13
    Then UI Validate "virts table" Table sorting by "Throughput"

    When UI Set Text Field "virts table Search TextBox" To "https"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 5
    Then UI Validate "virts table" Table sorting by "Throughput"


  @SID_16
  Scenario: Validate Sorting By Throughput After Filtering By IP
    When UI Set Text Field "virts table Search TextBox" To "9.9.9"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 5
    Then UI Validate "virts table" Table sorting by "Throughput"

    When UI Set Text Field "virts table Search TextBox" To "9.9.9.10"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 3
    Then UI Validate "virts table" Table sorting by "Throughput"



    #-----------------------------Filter with Service Name sort-----------------------------

  @SID_17
  Scenario: Validate Sorting By Service Name After Filtering By Virtual Service Name
    When UI Click Button "SERVICE NAME"
    When UI Set Text Field "virts table Search TextBox" To "1:80"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 3
    Then UI Validate "virts table" Table sorting by "Service Name"

    When UI Set Text Field "virts table Search TextBox" To "virt"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 9
    Then UI Validate "virts table" Table sorting by "Service Name"

  @SID_18
  Scenario: Validate Sorting By Service Name After Filtering By Protocol
    When UI Set Text Field "virts table Search TextBox" To "basic"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 1
    Then UI Validate "virts table" Table sorting by "Service Name"

    When UI Set Text Field "virts table Search TextBox" To "http"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 13
    Then UI Validate "virts table" Table sorting by "Service Name"

    When UI Set Text Field "virts table Search TextBox" To "https"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 5
    Then UI Validate "virts table" Table sorting by "Service Name"

  @SID_19
  Scenario: Validate Sorting By Service Name After Filtering By IP
    When UI Set Text Field "virts table Search TextBox" To "9.9.9"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 5
    Then UI Validate "virts table" Table sorting by "Service Name"

    When UI Set Text Field "virts table Search TextBox" To "9.9.9.10"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 3
    Then UI Validate "virts table" Table sorting by "Service Name"



  #**********************************************Device Selection*******************************************************

  #===============================================Select Two devices====================================================

  #-----------------------------Sorting-----------------------------

  @SID_20
  Scenario: Validate Table Sorting After selecting Two Devices
    Given UI Set Text Field "virts table Search TextBox" To ""
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter device type "Alteon"
      | index |
      | 11    |
      | 14    |
    When UI Click Button "Status"
    Then UI Validate "virts table" Table rows count EQUALS to 10
    Then UI Validate "virts table" Table sorting by "Status"

    When UI Click Button "THROUGHPUT"
    Then UI Validate "virts table" Table rows count EQUALS to 10
    Then UI Validate "virts table" Table sorting by "THROUGHPUT"

    When UI Click Button "SERVICE NAME"
    Then UI Validate "virts table" Table rows count EQUALS to 10
    Then UI Validate "virts table" Table sorting by "SERVICE NAME"


  #==========================================Filtering on two devices===================================================

  #-----------------------------Filter Result-----------------------------
  @SID_21
  Scenario: Filter table By Virtual Service Name After Selecting Two Devices
    Given UI Click Button "Status"
    When UI Set Text Field "virts table Search TextBox" To "1:80"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 1


    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:80"
      | columnName       | value          |
      | Application Name | virtserver1:80 |

    When UI Set Text Field "virts table Search TextBox" To "virt"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 9
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:200"
      | columnName       | value           |
      | Application Name | virtserver1:200 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:443"
      | columnName       | value           |
      | Application Name | virtserver1:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:80"
      | columnName       | value          |
      | Application Name | virtserver1:80 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:443"
      | columnName       | value              |
      | Application Name | virtualserver2:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:80"
      | columnName       | value             |
      | Application Name | virtualserver2:80 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:110"
      | columnName       | value              |
      | Application Name | virtualserver3:110 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:443"
      | columnName       | value              |
      | Application Name | virtualserver3:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:80"
      | columnName       | value             |
      | Application Name | virtualserver3:80 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtmax_255-ABC.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccccddddddddddddddddddddeeeeeeeeeeeeeeeeeeeffffffffffffgh:80"
      | columnName       | value                                                                                                                                                                                                                                                              |
      | Application Name | virtmax_255-ABC.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccccddddddddddddddddddddeeeeeeeeeeeeeeeeeeeffffffffffffgh:80 |

  @SID_22
  Scenario: Filter table By Protocol After Selecting Two Devices
    When UI Set Text Field "virts table Search TextBox" To "basic"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 1
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:200"
      | columnName       | value           |
      | Application Name | virtserver1:200 |

    When UI Set Text Field "virts table Search TextBox" To "http"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 8
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:443"
      | columnName       | value           |
      | Application Name | virtserver1:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:80"
      | columnName       | value          |
      | Application Name | virtserver1:80 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:443"
      | columnName       | value              |
      | Application Name | virtualserver2:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:80"
      | columnName       | value             |
      | Application Name | virtualserver2:80 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:443"
      | columnName       | value              |
      | Application Name | virtualserver3:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:80"
      | columnName       | value             |
      | Application Name | virtualserver3:80 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "2:443"
      | columnName       | value |
      | Application Name | 2:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtmax_255-ABC.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccccddddddddddddddddddddeeeeeeeeeeeeeeeeeeeffffffffffffgh:80"
      | columnName       | value                                                                                                                                                                                                                                                              |
      | Application Name | virtmax_255-ABC.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccccddddddddddddddddddddeeeeeeeeeeeeeeeeeeeffffffffffffgh:80 |

    When UI Set Text Field "virts table Search TextBox" To "https"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 4
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:443"
      | columnName       | value           |
      | Application Name | virtserver1:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:443"
      | columnName       | value              |
      | Application Name | virtualserver2:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:443"
      | columnName       | value              |
      | Application Name | virtualserver3:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "2:443"
      | columnName       | value |
      | Application Name | 2:443 |

  @SID_23
  Scenario: Filter table By IP After Selecting Two Devices
    When UI Set Text Field "virts table Search TextBox" To "9.9.9"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 5
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:443"
      | columnName       | value              |
      | Application Name | virtualserver2:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:80"
      | columnName       | value             |
      | Application Name | virtualserver2:80 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:110"
      | columnName       | value              |
      | Application Name | virtualserver3:110 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:443"
      | columnName       | value              |
      | Application Name | virtualserver3:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:80"
      | columnName       | value             |
      | Application Name | virtualserver3:80 |

    When UI Set Text Field "virts table Search TextBox" To "9.9.9.10"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 3
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:110"
      | columnName       | value              |
      | Application Name | virtualserver3:110 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:443"
      | columnName       | value              |
      | Application Name | virtualserver3:443 |

    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:80"
      | columnName       | value             |
      | Application Name | virtualserver3:80 |


  #-----------------------------Filter with Status sort-----------------------------
  @SID_24
  Scenario: Validate Sorting By Status After Selecting Two Devices Filtered By Virtual Service Name
    When UI Set Text Field "virts table Search TextBox" To "1:80"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 1
    Then UI Validate "virts table" Table sorting by "Status"


  @SID_25
  Scenario: Validate Sorting By Status After Selecting Two Devices Filtered By Protocol
    When UI Set Text Field "virts table Search TextBox" To "https"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 4
    Then UI Validate "virts table" Table sorting by "Status"


  @SID_26
  Scenario: Validate Sorting By Status After Selecting Two Devices Filtered By IP
    When UI Set Text Field "virts table Search TextBox" To "9.9.9.10"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 3
    Then UI Validate "virts table" Table sorting by "Status"

  #-----------------------------Filter with Throughput sort-----------------------------

  @SID_27
  Scenario: Validate Sorting By Throughput After Selecting Two Devices Filtered By Virtual Service Name
    When UI Click Button "THROUGHPUT"
    When UI Set Text Field "virts table Search TextBox" To "1:80"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 1
    Then UI Validate "virts table" Table sorting by "Throughput"

  @SID_28
  Scenario: Validate Sorting By Throughput After Selecting Two Devices Filtered By Protocol
    When UI Set Text Field "virts table Search TextBox" To "https"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 4
    Then UI Validate "virts table" Table sorting by "Throughput"

  @SID_29
  Scenario: Validate Sorting By Throughput After Selecting Two Devices Filtered By IP
    When UI Set Text Field "virts table Search TextBox" To "101.41.1.100"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 3
    Then UI Validate "virts table" Table sorting by "Throughput"

  #-----------------------------Filter with Service Name sort-----------------------------

  @SID_30
  Scenario: Validate Sorting By Service Name After Selecting Two Devices Filtered By Virtual Service Name
    When UI Click Button "ApplicationNameSorting"
    When UI Set Text Field "virts table Search TextBox" To "1:80"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 1
    Then UI Validate "virts table" Table sorting by "Service Name"


  @SID_31
  Scenario: Validate Sorting By Service Name After Selecting Two Devices Filtered By Protocol
    When UI Set Text Field "virts table Search TextBox" To "https"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 4
    Then UI Validate "virts table" Table sorting by "Service Name"


  @SID_32
  Scenario: Validate Sorting By Service Name After Selecting Two Devices Filtered By IP
    When UI Set Text Field "virts table Search TextBox" To "9.9.9.10"
    And Sleep "3"
    Then UI Validate "virts table" Table rows count EQUALS to 3
    Then UI Validate "virts table" Table sorting by "Service Name"


    #====================================Select One Device and One virtName=============================================

  @SID_33
  Scenario: Table Content After Selecting One Device And One Virtual Service
    Given UI Set Text Field "virts table Search TextBox" To ""
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter device type "Alteon"
      | index | virtualServices |
      | 14    | virtserver1:200 |
    Then UI Validate "virts table" Table rows count EQUALS to 1
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:200"
      | columnName       | value           |
      | Application Name | virtserver1:200 |


  @SID_34
  Scenario: Cleanup
    Then UI logout and close browser
