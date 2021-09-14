@VRM_Report2 @TC106002
Feature: Forensics Output


  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * REST Delete ES index "forensics-*"
    * REST Delete ES index "dpforensics-*"
    * CLI Clear vision logs
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |


  @SID_2
  Scenario: Run DP simulator
    And CLI simulate 1 attacks of type "rest_black_ip46" on SetId "DefensePro_Set_2" and wait 30 seconds
#    Given CLI simulate 20 attacks of type "DNS_States" on "DefensePro" 11 with loopDelay 15000 and wait 40 seconds

  @SID_3
  Scenario: VRM - Login to VRM "Wizard" Test
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Navigate to "AMS Forensics" page via homepage

  @SID_4
  Scenario: VRM - edit dynamic values in DB
    # move start time to Aug 1st 2018 03:00:00
    When CLI Run remote linux Command "curl -XPOST -H "Content-Type:application/json" localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "78-1526381752"}},"script": {"source": "ctx._source.startTime=1533081600000L"}}'" on "ROOT_SERVER_CLI"
    Then Sleep "5"
    # move end time to Aug 1st 2018 03:00:09
    When CLI Run remote linux Command "curl -XPOST -H "Content-Type:application/json" localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "78-1526381752"}},"script": {"source": "ctx._source.endTime=1533081609000L"}}'" on "ROOT_SERVER_CLI"
    Then Sleep "5"
    # edit dst port to 44444 to make it different from src port
    When CLI Run remote linux Command "curl -XPOST -H "Content-Type:application/json" localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "78-1526381752"}},"script": {"source": "ctx._source.destPort=44444"}}'" on "ROOT_SERVER_CLI"
    Then Sleep "5"
    # editing duration
    When CLI Run remote linux Command "curl -XPOST -H "Content-Type:application/json" localhost:9200/dp-attack-raw-*/_update_by_query/?refresh -d '{"query": {"match": {"attackIpsId": "78-1526381752"}},"script": {"source": "ctx._source.duration=15000"}}'" on "ROOT_SERVER_CLI"


  @SID_5
  Scenario: VRM - Create Forensics Report all output columns

    Given UI "Create" Forensics With Name "All Output Fields"
      | Time Definitions.Date | Absolute:[01.08.2018 01:00:00, +0d]                                                                                                                                                                                                                                      |
      | Output                | Action,Attack ID,Start Time,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Threat Category,Radware ID,Device IP Address,Attack Name,End Time,Duration,Total Packets Dropped,Total Mbits Dropped,Physical Port,Policy Name,Risk |

    Then UI Click Button "My Forensics" with value "All Output Fields"
    Then UI Validate Element Existence By Label "Generate Snapshot Forensics Manually" if Exists "true" with value "All Output Fields"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "All Output Fields"
    Then Sleep "35"

    Then UI Click Button "Views.Forensic" with value "All Output Fields,0"

  @SID_6
  Scenario: VRM - Validate Forensics output Action
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName | value |
      | Action     | Drop  |

  @SID_7
  Scenario: VRM - Validate Forensics output Attack ID
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName | value         |
      | Attack ID  | 78-1526381752 |

  @SID_8
  Scenario: VRM - Validate Forensics output Destination Port
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName       | value |
      | Destination Port | 44444 |

  @SID_9
  Scenario: VRM - Validate Forensics output Start Time
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName | value                |
      | Start Time | 01.08.2018, 03:00:00 |

  @SID_10
  Scenario: VRM - Validate Forensics output Threat Category
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName      | value |
      | Threat Category | ACL   |

  @SID_11
  Scenario: VRM - Validate Forensics output Radware ID
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName | value |
      | Radware ID | 8     |

  @SID_12
  Scenario: VRM - Validate Forensics output Device IP Address
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName        | value        |
      | Device IP Address | 172.16.22.51 |

  @SID_13
  Scenario: VRM - Validate Forensics output Attack Name
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName  | value      |
      | Attack Name | Black List |

  @SID_14
  Scenario: VRM - Validate Forensics output End Time
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName | value                |
      | End Time   | 01.08.2018, 03:00:09 |

  @SID_15
  Scenario: VRM - Validate Forensics output Duration
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName | value |
      | Duration   | 15    |


  @SID_16
  Scenario: VRM - Validate Forensics output pps
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName            | value    |
      | Total Packets Dropped | 38580044 |


  @SID_17
  Scenario: VRM - Validate Forensics output Mbits
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName          | value    |
      | Total Mbits Dropped | 37675.89 |

  @SID_18
  Scenario: VRM - Validate Forensics output Physical Port
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName    | value |
      | Physical Port | T-1   |

  @SID_19
  Scenario: VRM - Validate Forensics output Policy Name
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName  | value      |
      | Policy Name | Black_IPV6 |


  @SID_20
  Scenario: VRM - Validate Forensics output Risk
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName | value |
      | Risk       | Low   |


  @SID_21
  Scenario: VRM - Validate Forensics output Direction
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName | value |
      | Direction  | In    |


  @SID_22
  Scenario: VRM - Validate Forensics output Protocol
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName | value |
      | Protocol   | IP    |

  @SID_23
  Scenario: VRM - Validate Forensics output Source Port
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName  | value |
      | Source Port | 0     |

  @SID_24
  Scenario: VRM - Validate Forensics output Source IP Address
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName        | value                                   |
      | Source IP Address | 1234:1234:1234:1234:1234:1234:1234:1234 |

  @SID_25
  Scenario: VRM - Validate Forensics output Destination IP Address
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName             | value                                   |
      | Destination IP Address | 1234:1234:1234:1234:1234:1234:1234:1235 |
    # Then UI Delete "All Output Fields" and Approve



  @SID_26
  Scenario: VRM - Add New Forensics Report output - first group
    When UI "Create" Forensics With Name "radware_radware3"
      | Output | Action,Source IP Address,Attack ID,Start Time,Source Port,Destination IP Address |
    When UI Click Button "Edit Forensics" with value "radware_radware3"
    Then UI Click Button "Output Tab"
    Then UI Click Button "outputExpandOrCollapse"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Action" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Source IP Address" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Attack ID" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Start Time" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Source Port" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Destination IP Address" is "EQUALS" to "true"
    Then UI Click Button "outputExpandOrCollapse"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

    Then UI Click Button "My Forensics" with value "radware_radware3"
    Then UI Validate Element Existence By Label "Generate Snapshot Forensics Manually" if Exists "true" with value "radware_radware3"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "radware_radware3"
    Then Sleep "35"

    Then UI Click Button "Views.Forensic" with value "radware_radware3,0"

    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName             | value         |
      | Action                 | Drop          |
      | Source IP Address      | 1.1.1.1       |
      | Attack ID              | 77-1526381752 |
      | Source Port            | 0             |
      | Destination IP Address | 2.2.2.1       |

    When UI "Edit" Forensics With Name "radware_radware3"
      | Output | Policy Name |

    When UI Click Button "Edit Forensics" with value "radware_radware3"
    Then UI Click Button "Output Tab"
    Then UI Click Button "outputExpandOrCollapse"
    Then UI Validate the attribute "aria-selected" Of Label "Output Value" With Params "Policy Name" is "EQUALS" to "true"
    Then UI Click Button "outputExpandOrCollapse"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

    Then UI Click Button "My Forensics" with value "radware_radware3"
    Then UI Validate Element Existence By Label "Generate Snapshot Forensics Manually" if Exists "true" with value "radware_radware3"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "radware_radware3"
    Then Sleep "35"

    Then UI Click Button "Views.Forensic" with value "radware_radware3,0"

    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy index 0
      | columnName  | value      |
      | Policy Name | Black_IPV4 |


  @SID_27
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
