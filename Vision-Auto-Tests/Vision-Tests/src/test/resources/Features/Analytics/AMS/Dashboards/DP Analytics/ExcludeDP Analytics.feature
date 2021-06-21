@TC121810
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
    Then UI Validate the attribute "data-debug-checked" Of Label "Exclude Malicious IP Addresses Checkbox" is "EQUALS" to "false"


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

    Then UI Total "Top Attacks by Protocol" legends equal to 1


  @SID_10
  Scenario: VRM - Validate Dashboards "Attacks by Mitigation Action" Chart data for all DP machines
    Then Sleep "2"
    Then UI Validate StackBar data with widget "Attacks by Mitigation Action"
      | label   | value | legendName |
      | policy1 | 2     | Challenge  |

    Then UI Total "Attacks by Mitigation Action" legends equal to 1

  @SID_11
  Scenario: VRM - Validate Dashboards "Attacks by Protection Policy" Chart data for all DP machines
    Then UI Validate StackBar data with widget "Attacks by Protection Policy"
      | label          | value | legendName |
      | KolKorehalaila | 1     | policy1    |
      | Danny Litani10 | 1     | policy1    |

    Then UI Total "Attacks by Protection Policy" legends equal to 1

  @SID_12
  Scenario: VRM - Validate Dashboards "Attack Categories by Bandwidth" Chart data for all DP machines
    Then UI Validate StackBar data with widget "Attack Categories by Bandwidth"
      | label   | value  | legendName             | offset |
      | policy1 | 380919 | Malicious IP Addresses | 104000 |
      | policy1 | 331749 | GeoFeed                | 104000 |

    Then UI Total "Attack Categories by Bandwidth" legends equal to 2


  @SID_13
  Scenario:  Click on  Exclude Malicious IP Addresses
    Then UI Click Button "Exclude Malicious IP Addresses Checkbox"
    Then UI Validate the attribute "data-debug-checked" Of Label "Exclude Malicious IP Addresses Checkbox" is "EQUALS" to "true"



  @SID_14
  Scenario: VRM - Validate Dashboards "Top Attacks" Chart data for all DP machines after Exclude Malicious IP Addresses
    Then Sleep "2"
    Then UI Validate StackBar data with widget "Top Attacks"
      | label   | value | legendName     |
      | policy1 | 1     | Danny Litani10 |


    Then UI Total "Top Attacks" legends equal to 1

  @SID_15
  Scenario: VRM - Validate Dashboards "Top Attacks by Volume" Chart data for all DP machines after Exclude Malicious IP Addresses
    Then Sleep "2"
    Then UI Validate StackBar data with widget "Top Attacks by Volume"
      | label   | value  | legendName     | offset |
      | policy1 | 331749 | Danny Litani10 | 150000 |

    Then UI Total "Top Attacks by Volume" legends equal to 1

  @SID_16
  Scenario: VRM - Validate Dashboards "Attacks by Threat Category" Chart data for all DP machines after Exclude Malicious IP Addresses
    Then UI Validate Pie Chart data "Attacks by Threat Category"
      | label                  | data | exist |
      | GeoFeed                | 1    | true  |

  @SID_17
  Scenario: VRM - Validate Dashboards "Top Attack Destinations" chart data on All devices after Exclude Malicious IP Addresses
    Then UI Validate Pie Chart data "Top Attack Destinations"
      | label      | data |
      | 2000::0002 | 1    |

  @SID_18
  Scenario: VRM - Validate Dashboards "Top Attack Sources" Chart data for all DP machines after Exclude Malicious IP Addresses
    Then Sleep "2"
    Then UI Validate Pie Chart data "Top Attack Sources"
      | label    | data |
      | Multiple | 1    |

  @SID_19
  Scenario: VRM - Validate Dashboards "Top Attacks by Protocol" Chart data for all DP machines after Exclude Malicious IP Addresses
    Then UI Validate StackBar data with widget "Top Attacks by Protocol"
      | legendName | value | label          | exist |
      | TCP        | 1     | Danny Litani10 | true  |

    Then UI Total "Top Attacks by Protocol" legends equal to 1


  @SID_20
  Scenario: VRM - Validate Dashboards "Attacks by Mitigation Action" Chart data for all DP machines after Exclude Malicious IP Addresses
    Then UI Validate StackBar data with widget "Attacks by Mitigation Action"
      | label   | value | legendName |
      | policy1 | 1     | Challenge  |

    Then UI Total "Top Attacks by Protocol" legends equal to 1

  @SID_21
  Scenario: VRM - Validate Dashboards "Attacks by Protection Policy" Chart data for all DP machines after Exclude Malicious IP Addresses
    Then UI Validate StackBar data with widget "Attacks by Protection Policy"
      | label          | value | legendName |
      | Danny Litani10 | 1     | policy1    |

    Then UI Total "Attacks by Protection Policy" legends equal to 1

  @SID_22
  Scenario: VRM - Validate Dashboards "Attack Categories by Bandwidth" Chart data for all DP machines after Exclude Malicious IP Addresses
    Then UI Validate StackBar data with widget "Attack Categories by Bandwidth"
      | label   | value  | legendName             | offset |
      | policy1 | 723816 | GeoFeed                | 150000 |

    Then UI Total "Attack Categories by Bandwidth" legends equal to 1

  @SID_23
  Scenario: Logout and close browser
    Given UI logout and close browser