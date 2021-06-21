@Test12
Feature: Exclude DP Analytics Dashboard

  @SID_1
  Scenario: Clean data System
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs


  @SID_2
  Scenario: Run DP simulator for ErtFeed_GeoFeed
    Given CLI simulate 1000 attacks of type "ErtFeed_GeoFeed" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds
    Then Sleep "30"

  @SID_3
  Scenario: Login and add widgets
    When UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage


  @SID_4
  Scenario: VRM - Validate Dashboards "Top Attacks" Chart data for all DP machines
    Then Sleep "2"
    Then UI Validate StackBar data with widget "Top Attacks"
      | label   | value | legendName     |
      | policy1 | 1     | Danny Litani10 |
      | policy1 | 1     | KolKorehalaila |

    Then UI Total "Top Attacks" legends equal to 2

  @SID_5
  Scenario: VRM - Validate Dashboards "Top Attacks by Volume" Chart data for all DP machines
    Then Sleep "2"
    Then UI Validate StackBar data with widget "Top Attacks by Volume"
      | label   | value  | legendName     | offset |
      | policy1 | 380919 | KolKorehalaila | 104000 |
      | policy1 | 331749 | Danny Litani10 | 104000 |

    Then UI Total "Top Attacks by Volume" legends equal to 2

  @SID_6
  Scenario: VRM - Validate Dashboards "Attacks by Threat Category" Chart data for all DP machines
    Then UI Validate Pie Chart data "Attacks by Threat Category"
      | label                  | data | exist |
      | Malicious IP Addresses | 1    | true  |
      | GeoFeed                | 1    | true  |

  @SID_7
  Scenario: VRM - Validate Dashboards "Top Attack Destinations" chart data on All devices
    Then UI Validate Pie Chart data "Top Attack Destinations"
      | label      | data |
      | 2000::0001 | 1    |
      | 2000::0002 | 1    |

  @SID_8
  Scenario: VRM - Validate Dashboards "Top Attack Sources" Chart data for all DP machines
    Then UI Validate Pie Chart data "Top Attack Sources"
      | label    | data |
      | Multiple | 2    |

  @SID_9
  Scenario: VRM - Validate Dashboards "Top Attacks by Protocol" Chart data for all DP machines
    Then UI Validate StackBar data with widget "Top Attacks by Protocol"
      | legendName | value | label          | exist |
      | TCP        | 1     | KolKorehalaila | true  |
      | TCP        | 1     | Danny Litani10 | true  |

    Then UI Total "Top Attacks by Protocol" legends equal to 2

  @SID_29
  Scenario: VRM - Validate Dashboards "Attack Categories by Bandwidth" Chart data for all DP machines
    Then UI Validate StackBar data with widget "Attack Categories by Bandwidth"
      | label   | value | legendName | offset |
      | policy1 | 2     | SynFlood   | 1000   |

    Then UI Total "Attack Categories by Bandwidth" legends equal to 1
