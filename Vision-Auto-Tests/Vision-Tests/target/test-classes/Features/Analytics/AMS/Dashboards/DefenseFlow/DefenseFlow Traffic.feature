@TC110997
Feature: AMS DefenseFlow Traffic Dashboard

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "df-attack*"
    * REST Delete ES index "df-traffic*"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    * CLI Clear vision logs

  @SID_2
  Scenario: Generate DefenseFlow traffic events
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER" and wait 120 seconds and wait for prompt "False"
      | "nohup /home/radware/curl_DF_traffic_auto.sh " |
      | #visionIP                                |
      | " PO_300 20"                             |

  @SID_3
  Scenario: VRM - Login to AMS DefenseFlow Analytics Dashboard
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "DefenseFlow Analytics Dashboard" page via homePage
#    Then UI Do Operation "Select" item "Global Time Filter"
#    Then UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"

  @SID_4
  Scenario: Validate traffic BW all POs
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Inbound"
      | value                                         | min |
      | 8083.1999999999998181010596454143524169921875 | 4   |

    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | min |
      | 4016  | 4   |
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Discarded Inbound"
      | value | min |
      | 2024  | 4   |
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Clean"
      | value                                          | min |
      | 815.200000000000045474735088646411895751953125 | 4   |
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Diverted"
      | value | min |
      | 1620  | 4   |


  @SID_5
  Scenario: Validate Traffic Rate - All POs

    Then UI Validate Line Chart data "Traffic Rate" with Label "Inbound"
      | value  | min |
      | 700933 | 4   |
    Then UI Validate Line Chart data "Traffic Rate" with Label "Dropped"
      | value  | min |
      | 320000 | 4   |
    Then UI Validate Line Chart data "Traffic Rate" with Label "Discarded Inbound"
      | value | min |
      | 32000 | 4   |

    Then UI Validate Line Chart data "Traffic Rate" with Label "Clean"
      | value  | min |
      | 109300 | 4   |

    Then UI Validate Line Chart data "Traffic Rate" with Label "Diverted"
      | value  | min |
      | 425000 | 4   |

  @SID_6
  Scenario: select two POs
    When UI Do Operation "Select" item "Protected Objects"
    Then UI Select scope from dashboard and Save Filter device type "defenseflow"
      | PO_100 |
      | PO_200 |


  @SID_7
  Scenario: Validate Traffic Bandwidth - part of POs
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Inbound"
      | value                                         | count |
      | 8083.1999999999998181010596454143524169921875 | 0     |

    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Dropped"
      | value | count |
      | 4016  | 0     |
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Discarded Inbound"
      | value | count |
      | 2024  | 0     |
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Clean"
      | value                                          | count |
      | 815.200000000000045474735088646411895751953125 | 0     |
    Then UI Validate Line Chart data "Traffic Bandwidth" with Label "Diverted"
      | value | count |
      | 1620  | 0     |

  @SID_8
  Scenario: Validate Traffic Rate - part of POs

    Then UI Validate Line Chart data "Traffic Rate" with Label "Inbound"
      | value  | count |
      | 700933 | 0     |
    Then UI Validate Line Chart data "Traffic Rate" with Label "Dropped"
      | value  | count |
      | 320000 | 0     |
    Then UI Validate Line Chart data "Traffic Rate" with Label "Discarded Inbound"
      | value | count |
      | 32000 | 0     |

    Then UI Validate Line Chart data "Traffic Rate" with Label "Clean"
      | value  | count |
      | 109300 | 0     |

    Then UI Validate Line Chart data "Traffic Rate" with Label "Diverted"
      | value  | count |
      | 425000 | 0     |


  @SID_9
  Scenario: Validate Line Chart attributes
    Then UI Validate Line Chart attributes "Traffic Bandwidth" with Label "Inbound"
      | attribute | value              |
      | color     | rgb(169, 207, 233) |

    Then UI Validate Line Chart attributes "Traffic Bandwidth" with Label "Discarded Inbound"
      | attribute | value              |
      | color     | rgb(128, 128, 128) |

    Then UI Validate Line Chart attributes "Traffic Bandwidth" with Label "Clean"
      | attribute | value            |
      | color     | rgb(170,206,186) |

    Then UI Validate Line Chart attributes "Traffic Rate" with Label "Dropped"
      | attribute | value                  |
      | color     | rgba(236, 52, 52, 0.3) |

    Then UI Validate Line Chart attributes "Traffic Rate" with Label "Diverted"
      | attribute | value              |
      | color     | rgba(140,186,70,1) |
    Then CLI kill all simulator attacks on current vision

  @SID_10
  Scenario: Search for bad logs
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
      | ALL     | error      | NOT_EXPECTED |

  @SID_10
  Scenario: Cleanup
    And UI Navigate to "HOME" page via homePage
    Then UI logout and close browser