Feature: ConnectionPPS


  @SID_1
  Scenario: Clean system attacks,database and logs
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs


  @SID_2
  Scenario: Run DF simulator
    And CLI simulate 1000 attacks of type "/home/radware/onlyPPSOngoing" on "DefensePro" 10 and wait 40 seconds


  @SID_3
  Scenario: VRM - Validate Dashboards "Concurrent Connections" Chart data for only DP version 8 machines
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1m"

  @SID_4
  Scenario: validate first drill
    Then UI Validate Element Existence By Label "Under Attack" if Exists "true"
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 0
      | columnName        | value                   |
      | Policy Status     | underAttack             |
      | Device            | DefensePro_172.16.22.50 |
      | Policy Name       | test                    |
      | Attack Categories | Connection PPS          |

  @SID_5
  Scenario: Validate to second drill
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Attack Categories" findBy cellValue "Connection PPS"
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Connection PPS"
      | columnName      | value          |
      | Protection Name | Connection PPS |

  @SID_6
  Scenario: Validate 3 drill
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Connection PPS"
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName          | value         |
      | Attack ID           | 35-1584643708 |
      | Attack Name         | pps-limit     |
      | Policy Name         | test          |
      | Source Address      | 1.1.1.1       |
      | Destination Address | 1.1.1.2       |
      | Risk                | High          |

  @SID_7
  Scenario: clear
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs





