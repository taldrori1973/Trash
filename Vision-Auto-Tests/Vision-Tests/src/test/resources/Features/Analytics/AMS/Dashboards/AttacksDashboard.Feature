@TC114538
Feature: AttacksDashboard


  @SID_1
  Scenario: Clean system data before Traffic Bandwidth test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-tr*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator PCAPs for Traffic Bandwidth
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000 and wait 120 seconds


  @SID_3
    Given UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "2"
    And UI Navigate to "AMS Attacks" page via homePage

  @SID_4
  Scenario: validate traffic bandwidth bps+inbound
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value  | min |
      | 729740 | 5   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value  | min |
      | 513819 | 5   |

  @SID_5
  Scenario: validate traffic bandwidth bps+outbound
    When UI Click Button "outboundSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value | min |
      | 20000 | 5   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value | min |
      | 0     | 5   |

  @SID_6
  Scenario: validate traffic bandwidth pps+outbound
    When UI Click Button "outboundSwitch"
    When UI Click Button "ppsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value | min |
      | 10000 | 5   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value | min |
      | 0     | 5   |


  @SID_7
  Scenario: validate traffic bandwidth pps+inbound
    When UI Click Button "inboundSwitch"
    When UI Click Button "ppsSwitch"
    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Received"
      | value   | min |
      | 5578811 | 5   |

    Then UI Validate Line Chart data "Attacks Dashboard Traffic Widget" with Label "Dropped"
      | value  | min |
      | 517963 | 5   |

  @SID_8
  Scenario: Inbound Traffic Cleanup
    Given UI logout and close browser
    * CLI kill all simulator attacks on current vision