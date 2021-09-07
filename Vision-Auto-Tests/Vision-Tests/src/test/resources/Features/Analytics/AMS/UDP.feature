@TC116609
Feature: UDP widgets

  @SID_1
  Scenario: add DP
    Then REST Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then REST Add device with SetId "DefensePro_Set_7"

  @SID_2
  Scenario: Clear the vision from the attacks and run PCAP
    * CLI kill all simulator attacks on current vision
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"
    When CLI Clear vision logs

#    Given CLI simulate 100 attacks of type "testUDPAttack" on "DefensePro" 185 with loopDelay 15000 and wait 120 seconds
    Given CLI simulate 100 attacks of type "testUDPAttack" on SetId "DefensePro_Set_7" with loopDelay 15000 and wait 120 seconds with attack ID

  @SID_3
  Scenario: Login and navigate to BDOS behavioral dashboard
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | setId | ports | policies |
      | DefensePro_Set_7   |       | test     |
    Then UI Validate Line Chart data "UDP Invariant Widget" with Label "Real-Time Ratio"
      | value | min |
      | 0     | 5   |
    Then UI Validate Line Chart data "Excluded UDP Traffic" with Label "Excluded Ports"
      | value | min | valueOffset |
      | 103   | 5   | 5           |
    Then UI Click Button "Excluded UDP Traffic Outbound" with value ""
    Then UI Validate Line Chart data "Excluded UDP Traffic" with Label "Excluded Ports"
      | value | min |
      | 0     | 5   |

  @SID_4
  Scenario: navigate DP monitoring
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And  UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "Test"
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


  @SID_5
  Scenario: Clear the vision from the attacks and run PCAP
    * CLI kill all simulator attacks on current vision
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"
    When CLI Clear vision logs
#    Then REST Delete Device By IP "10.185.2.85"
    Then REST Delete device with SetID "DefensePro_Set_7" from topology tree