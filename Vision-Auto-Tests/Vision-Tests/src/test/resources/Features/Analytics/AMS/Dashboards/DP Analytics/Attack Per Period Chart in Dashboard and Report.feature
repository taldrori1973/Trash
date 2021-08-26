@TC122760
Feature: Attacks Per Period Chart in Dashboard and Report

  @SID_1
  Scenario: Clean system data before Attack per period test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs


  @SID_2
  Scenario: Run DP simulator PCAPs for Attack per period
    Given CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10 and wait 250 seconds
    * CLI kill all simulator attacks on current vision


  @SID_3
  Scenario:  login
    Given UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "2"
    And UI Navigate to "DefensePro Analytics Dashboard" page via homePage

  @SID_4
  Scenario: Validate Attack per period chart data
    Then UI Validate Line Chart data "Attacks Per Period" with Label "Attacks"
      | value | min | offset |
      | 1     | 3   | 5      |
      | 2     | 2   | 5      |
      | 3     | 1   | 5      |
      | 5     | 1   | 5      |

  @SID_5
  Scenario:Change time range to 1 Hour and validate values
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1H"
    Then UI Validate Line Chart data "Attacks Per Period" with Label "Attacks"
      | value | min | offset |
      | 1     | 3   | 5      |
      | 2     | 2   | 5      |
      | 3     | 1   | 5      |
      | 5     | 1   | 5      |

  @SID_6
  Scenario:Change time range to 6 Hours and validate values
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "6H"
    Then UI Validate Line Chart data "Attacks Per Period" with Label "Attacks"
      | value | min | offset |
      | 23    | 1   | 5      |

  @SID_7
  Scenario:Change time range to 12 Hours and validate values
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "12H"
    Then UI Validate Line Chart data "Attacks Per Period" with Label "Attacks"
      | value | min | offset |
      | 23    | 1   | 5      |

  @SID_8
  Scenario:Change time range to 24 Hours and validate values
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "24H"
    Then UI Validate Line Chart data "Attacks Per Period" with Label "Attacks"
      | value | min | offset |
      | 23    | 1   | 5      |

  @SID_9
  Scenario: navigate to AMS REPORTS
    When UI Navigate to "AMS REPORTS" page via homePage

  @SID_10
  Scenario: Run DP simulator PCAPs for Attack per period
    Given CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10 and wait 250 seconds
    * CLI kill all simulator attacks on current vision

  @SID_11
  Scenario: validate DP Analytics Widget - Attacks Per Period
    Then Validate Line Chart data "Attacks Per Period-DefensePro Analytics" with Label "Attacks" in report "attack per period widget report"
      | value | min | offset |
      | 1     | 3   | 5      |
      | 2     | 2   | 5      |
      | 3     | 1   | 5      |
      | 5     | 1   | 5      |

  @SID_12
  Scenario: Cleanup
    Given UI logout and close browser
