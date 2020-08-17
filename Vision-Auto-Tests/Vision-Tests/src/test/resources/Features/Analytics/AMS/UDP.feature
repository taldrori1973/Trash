Feature: UDP widgets

  Scenario: add DP
    Then REST Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then REST Add "DefensePro" Device To topology Tree with Name "10.185.2.85" and Management IP "10.185.2.85" into site "Default"
      | attribute     | value    |
      | cliUsername   | radware  |
      | cliPassword   | radware1 |
      | httpPassword  | radware1 |
      | httpsPassword | radware1 |
      | httpsUsername | radware  |
      | httpUsername  | radware  |
      | visionMgtPort | G1       |

  Scenario: Clear the vision from the attacks and run PCAP
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    When CLI Clear vision logs

    Given CLI simulate 100 attacks of type "testUDPAttack" on "DefensePro" 185 with loopDelay 15000 and wait 60 seconds

  Scenario: Login and navigate to BDOS behavioral dashboard
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 185   |       | test     |
    Then UI Validate Line Chart data "UDP Invariant Widget" with Label "Real-Time Ratio"
      | value | min |
      | 0     | 5  |
    Then UI Validate Line Chart data "Excluded UDP Traffic" with Label "Excluded Ports"
      | value | min | valueOffset |
      | 103   | 5   | 5           |
    Then UI Click Button "Excluded UDP Traffic Outbound" with value ""
    Then UI Validate Line Chart data "Excluded UDP Traffic" with Label "Excluded Ports"
      | value | min |
      | 0     | 5   |

  Scenario: navigate DP monitoring
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And  UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "test"
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Behavioral DoS"
    And UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack Status" findBy cellValue "Ongoing"
    Then UI Validate Line Chart data "UDP Invariant Widget" with Label "Real-Time Ratio"
      | value | min |
      | 0     | 10  |
    Then UI Validate Line Chart data "BDoS-UDP" with Label "Total Traffic"
      | value | min | valueOffset |
      | 83000 | 5   | 1000        |

    Then UI Text of "Detection Method" equal to "Detection Method:Advanced UDP"
    Then UI Text of "Info.Protocol" equal to "Protocol: UDP"


  Scenario: Clear the vision from the attacks and run PCAP
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    When CLI Clear vision logs
    Then REST Delete Device By IP "10.185.2.85"