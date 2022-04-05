@TC114538
Feature: Attacks Dashboard Traffic Widget


  @SID_1
  Scenario: Clean system data before Traffic Bandwidth test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-tr*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator PCAPs for Traffic Bandwidth
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on SetId "DefensePro_Set_2" and wait 120 seconds

  @SID_3
  Scenario: change the date of traffic of 51 device
    Then CLI copy "/home/radware/Scripts/changeDate.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    When CLI Run remote linux Command "chmod 777 /changeDate.sh" on "ROOT_SERVER_CLI" with timeOut 120
    When CLI Run remote linux Command "/changeDate.sh dp-traffic-raw- 172.16.22.51 2" on "ROOT_SERVER_CLI" with timeOut 500

    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on SetId "DefensePro_Set_1" with loopDelay 15000 and wait 120 seconds


  @SID_4
  Scenario:  login
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "2"
    And UI Navigate to "DefensePro Attacks" page via homePage


  @SID_5
  Scenario: validate one device bps + inbound1
    When UI Click Button "inboundSwitch"
    When UI Click Button "bpsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value   | min |
      | 1459480 | 0   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value   | min |
      | 1027638 | 0   |

#    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Excluded"
#      | value   | min |
#      | 1027638 | 5   |

  @SID_6
  Scenario: validate traffic bandwidth bps+outbound
    When UI Click Button "outboundSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value | min |
      | 40000 | 0   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value | min |
      | 0     | 5   |

#    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Excluded"
#      | value   | min |
#      | 1027638 | 5   |

  @SID_7
  Scenario: validate traffic bandwidth pps+outbound1
    When UI Click Button "outboundSwitch"
    When UI Click Button "ppsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value | min |
      | 20000 | 0   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value | min |
      | 0     | 5   |

#    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Excluded"
#      | value   | min |
#      | 1027638 | 5   |


  @SID_8
  Scenario: validate traffic bandwidth pps+inbound1
    When UI Click Button "inboundSwitch"
    When UI Click Button "ppsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value    | min |
      | 11157622 | 0   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value   | min |
      | 1035926 | 0   |

    #    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Excluded"
#      | value   | min |
#      | 1027638 | 5   |


  @SID_9
  Scenario: select new time filer
    Given UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"

  @SID_10
  Scenario: validate traffic bandwidth bps+inbound
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value   | min |
      | 5578811 | 0   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value  | min |
      | 517963 | 0   |

    #    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Excluded"
#      | value   | min |
#      | 1027638 | 5   |

  @SID_11
  Scenario: validate traffic bandwidth bps+outbound
    When UI Click Button "outboundSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value | min |
      | 10000 | 0   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value | min |
      | 0     | 1   |

    #    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Excluded"
#      | value   | min |
#      | 1027638 | 5   |

  @SID_12
  Scenario: validate traffic bandwidth pps+outbound2
    When UI Click Button "outboundSwitch"
    When UI Click Button "ppsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value | min |
      | 10000 | 0   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value | min |
      | 0     | 1   |

    #    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Excluded"
#      | value   | min |
#      | 1027638 | 5   |


  @SID_13
  Scenario: validate traffic bandwidth pps+inbound2
    When UI Click Button "inboundSwitch"
    When UI Click Button "ppsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value   | min |
      | 5578811 | 0   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value  | min |
      | 517963 | 0   |

    #    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Excluded"
#      | value   | min |
#      | 1027638 | 5   |


  @SID_14
  Scenario: select devices
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_2 |       |          |


  @SID_15
  Scenario: validate one device bps + inbound2
    When UI Click Button "inboundSwitch"
    When UI Click Button "bpsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value  | min |
      | 729740 | 0   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value  | min |
      | 513819 | 0   |

    #    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Excluded"
#      | value   | min |
#      | 1027638 | 5   |

  @SID_16
  Scenario: validate traffic bandwidth bps+outbound
    When UI Click Button "outboundSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value | min |
      | 20000 | 0   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value | min |
      | 0     | 1   |

    #    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Excluded"
#      | value   | min |
#      | 1027638 | 5   |

  @SID_17
  Scenario: validate traffic bandwidth pps+outbound3
    When UI Click Button "outboundSwitch"
    When UI Click Button "ppsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value | min |
      | 10000 | 0   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value | min |
      | 0     | 1   |

    #    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Excluded"
#      | value   | min |
#      | 1027638 | 5   |


  @SID_18
  Scenario: validate traffic bandwidth pps+inbound3
    When UI Click Button "inboundSwitch"
    When UI Click Button "ppsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value   | min |
      | 5578811 | 0   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value  | min |
      | 517963 | 0   |

    #    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Excluded"
#      | value   | min |
#      | 1027638 | 5   |


  @SID_19
  Scenario: Inbound Traffic Cleanup
    Given UI logout and close browser
    * CLI kill all simulator attacks on current vision

