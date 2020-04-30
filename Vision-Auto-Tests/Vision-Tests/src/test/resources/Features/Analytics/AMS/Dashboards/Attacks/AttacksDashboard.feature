@TC114538
Feature: AttacksDashboard


  @SID_1
  Scenario: Clean system data before Traffic Bandwidth test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-tr*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator PCAPs for Traffic Bandwidth
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 11 with loopDelay 15000 and wait 60 seconds
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000 and wait 60 seconds


#  Scenario: change the date of traffic of 55 deveice
#    Then CLI Operations - Run Root Session command "curl -XPOST -H "Content-type: application/json" -s "localhost:9200/appwall-v2-attack-raw-*/_update_by_query/?conflicts=proceed&refresh" -d '{"query":{"bool":{"must":{"term":{"tunnel":"tun_HTTP"}}}},"script":{"source":"ctx._source.receivedTimeStamp='$(echo $(date +%s%3N)-7200000|bc)L';"}}'"

  @SID_3
  Scenario:  login
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "2"
    And UI Navigate to "AMS Attacks" page via homePage

  @SID_4
  Scenario: validate traffic bandwidth bps+inbound
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value   | min |
      | 1459480 | 5   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value   | min |
      | 1027638 | 5   |

  @SID_5
  Scenario: validate traffic bandwidth bps+outbound
    When UI Click Button "outboundSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value | min |
      | 40000 | 5   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value | min |
      | 0     | 5   |

  @SID_6
  Scenario: validate traffic bandwidth pps+outbound
    When UI Click Button "outboundSwitch"
    When UI Click Button "ppsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value | min |
      | 20000 | 5   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value | min |
      | 0     | 5   |


  @SID_7
  Scenario: validate traffic bandwidth pps+inbound
    When UI Click Button "inboundSwitch"
    When UI Click Button "ppsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value    | min |
      | 11157622 | 5   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value   | min |
      | 1035926 | 5   |


  @SID_8
  Scenario: select devices
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       |          |


  @SID_9
  Scenario: validate one device bps + inbound
    When UI Click Button "inboundSwitch"
    When UI Click Button "bpsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value  | min |
      | 729740 | 5   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value  | min |
      | 513819 | 5   |

  @SID_10
  Scenario: validate traffic bandwidth bps+outbound
    When UI Click Button "outboundSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value | min |
      | 20000 | 5   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value | min |
      | 0     | 5   |

  @SID_11
  Scenario: validate traffic bandwidth pps+outbound
    When UI Click Button "outboundSwitch"
    When UI Click Button "ppsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value | min |
      | 10000 | 5   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value | min |
      | 0     | 5   |


  @SID_12
  Scenario: validate traffic bandwidth pps+inbound
    When UI Click Button "inboundSwitch"
    When UI Click Button "ppsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value   | min |
      | 5578811 | 5   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value  | min |
      | 517963 | 5   |


  @SID_13
  Scenario: Inbound Traffic Cleanup
    Given UI logout and close browser
    * CLI kill all simulator attacks on current vision

