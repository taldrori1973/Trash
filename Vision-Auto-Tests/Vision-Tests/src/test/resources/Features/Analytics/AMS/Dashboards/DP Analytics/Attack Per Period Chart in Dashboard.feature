
Feature: Attacks Dashboard Traffic Widget

  @SID_1
  Scenario: Clean system data before Traffic Bandwidth test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-tr*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator PCAPs for Traffic Bandwidth
    Given CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10 and wait 250 seconds
    * CLI kill all simulator attacks on current vision


  @SID_4
  Scenario:  login
    Given UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "2"
    And UI Navigate to "DefensePro Analytics Dashboard" page via homePage

  @SID_5
  Scenario: Validate Attack per period chart data
    Then UI Validate Line Chart data "Attacks Per Period" with Label "Attacks"
      | value | min |
      | 0     | 10  |
      | 1     | 3   |
      | 2     | 2   |
      | 3     | 1   |

  @SID_6
  Scenario:Change time range to 1 Hour and validate values
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1H"
    Then UI Validate Line Chart data "Attacks Per Period" with Label "Attacks"
      | value | min |
      | 0     | 10  |



  @SID_7
  Scenario:Change time range to 6 Hours and validate values
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "6H"
    Then UI Validate Line Chart data "Attacks Per Period" with Label "Attacks"
      | value | min |
      | 0     | 10  |
      | 23    | 2   |

  @SID_8
  Scenario:Change time range to 12 Hours and validate values
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "12H"
    Then UI Validate Line Chart data "Attacks Per Period" with Label "Attacks"
      | value | min |
      | 0     | 10  |
      | 23    | 2   |

  @SID_9
  Scenario:Change time range to 24 Hours and validate values
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "24H"
    Then UI Validate Line Chart data "Attacks Per Period" with Label "Attacks"
      | value | min |
      | 0     | 10  |
      | 23    | 1   |

  @SID_10
  Scenario: navigate to AMS REPORTS
    When UI Navigate to "AMS REPORTS" page via homePage

  @SID_11
  Scenario: Run DP simulator PCAPs for Traffic Bandwidth
    Given CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10 and wait 250 seconds
    * CLI kill all simulator attacks on current vision

  @SID_12
  Scenario: validate DP Analytics Widget - Top Attack Destinations
    Then Validate Line Chart data "Attacks Per Period-DefensePro Analytics" with Label "Attacks" in report "attack per period widget report"
      | value | min |
      | 0     | 10  |
      | 1     | 3   |
      | 2     | 2   |
      | 3     | 1   |

