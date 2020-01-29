@VRM @TC105992

Feature: DP Monitoring Dashboard - Protection Policies - Peace Time

  @SID_1
  Scenario: Clean system data before "Protection Policies" test
    * CLI kill all simulator attacks on current vision
    Then CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Run DP simulator PCAPs for "Protection Policies" - just traffic
    Given CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 20 with loopDelay 15000
    And CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000
    And CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 11 with loopDelay 15000 and wait 60 seconds

  @SID_3
  Scenario: Login and navigate to VRM
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @SID_4
  Scenario: Validate first peace time policy - just traffic
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 0
      | columnName            | value                  |
      | Site                  | RealDPs_Version_8_site |
      | Policy Name           | Policy150              |
      | Policy Status         | peace                  |
      | Total Inbound Traffic | 7.48 Mbps              |
      | Attack Rate           | 0                      |
      | Drop Rate             | 0 bps                  |
      | Attack Categories     | None                   |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 1
      | columnName            | value                  |
      | Site                  | RealDPs_Version_8_site |
      | Policy Name           | Policy150              |
      | Policy Status         | peace                  |
      | Total Inbound Traffic | 7.48 Mbps              |
      | Attack Rate           | 0                      |
      | Drop Rate             | 0 bps                  |
      | Attack Categories     | None                   |

  @SID_5
  Scenario: Validate middle peace time policy - just traffic
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 10
      | columnName            | value                  |
      | Site                  | RealDPs_Version_8_site |
      | Policy Name           | Policy14               |
      | Policy Status         | peace                  |
      | Total Inbound Traffic | 3.09 Mbps              |
      | Attack Rate           | 0                      |
      | Drop Rate             | 0 bps                  |
      | Attack Categories     | None                   |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 11
      | columnName            | value                  |
      | Site                  | RealDPs_Version_8_site |
      | Policy Status         | peace                  |
      | Total Inbound Traffic | 3.09 Mbps              |
      | Attack Rate           | 0                      |
      | Drop Rate             | 0 bps                  |
      | Attack Categories     | None                   |

  @SID_6
  Scenario: Validate last peace time policy - just traffic
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 36
      | columnName            | value                  |
      | Site                  | RealDPs_Version_8_site |
      | Policy Name           | Policy23              |
      | Policy Status         | peace                  |
      | Total Inbound Traffic | 480 Kbps               |
      | Attack Rate           | 0                      |
      | Drop Rate             | 0 bps                  |
      | Attack Categories     | None                   |
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Table" findBy index 37
      | columnName            | value                  |
      | Site                  | RealDPs_Version_8_site |
      | Policy Name           | Policy230              |
      | Policy Status         | peace                  |
      | Total Inbound Traffic | 480 Kbps               |
      | Attack Rate           | 0                      |
      | Drop Rate             | 0 bps                  |
      | Attack Categories     | None                   |

  @SID_7
  Scenario:  Entering to the peace time policy first drill down
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0

  @SID_8
  Scenario:  Validate Traffic Composition widget for first peace time policy
    Then UI Validate Pie Chart data "Traffic Composition"
      | label | data |
      | ICMP  | 2133 |
      | TCP   | 1066 |
      | UDP   | 1025 |
      | SCTP  | 586  |
      | IGMP  | 3    |
      | OTHER | 2666 |

  @SID_9
  Scenario: Validate Dashboards "Policy Traffic Bandwidth" Widget data for first peace time policy
    When UI Do Operation "Select" item "Policy Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Received"
      | value | min |
      | 7479  | 5   |
    Then  UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Dropped"
      | value | min |
      |  5790 | 5   |
    When UI Do Operation "Select" item "Policy Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Received"
      | value | count |
      | 7479  | 0     |
    Then UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Received"
      | value | min |
      | null  | 5     |
    Then  UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Dropped"
      | value | count |
      |  5790 | 0     |
    When UI Do Operation "Select" item "Policy Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Received"
      | value  | count |
      | 230013 | 0     |
    Then  UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Dropped"
      | value  | count |
      | 115568 | 0     |
    When UI Do Operation "Select" item "Policy Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Received"
      | value  | min |
      | 230013 | 5   |
    Then  UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Dropped"
      | value  | min |
      | 115568 | 5   |

  @SID_10
  Scenario: Entering to the peace time policy first drill down
    When UI Click Button "Protection Policies.GO BACK" with value " GO BACK"
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 10
    # this should by Policy14
  @SID_11
  Scenario: Validate Traffic Composition widget for peace time policy
    Then UI Validate Pie Chart data "Traffic Composition"
      | label | data |
      | TCP   | 2070 |
      | UDP   | 1019 |
      | ICMP  | 0    |
      | IGMP  | 0    |
      | OTHER | 0    |
      | SCTP  | 0    |

  @SID_12
  Scenario: Validate Dashboards "Policy Traffic Bandwidth" Widget data
    When UI Do Operation "Select" item "Policy Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Received"
      | value | min |
      | 3089  | 3   |
      #| 4644  | 4   |
    Then  UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Dropped"
      | value | min |
     # | 9288  | 3   |
      | 2322  | 4   |
    When UI Do Operation "Select" item "Policy Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Received"
      | value | count |
      | null | 0     |
      | 9267  | 0     |
    Then  UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Dropped"
      | value | count |
      | 9288  | 0     |
      | 6966  | 0     |
    When UI Do Operation "Select" item "Policy Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Received"
      | value | count |
      | 12460 | 0     |
      | 9345  | 0     |
    Then  UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Dropped"
      | value | count |
      | 8328  | 0     |
      | 6246  | 0     |
    When UI Do Operation "Select" item "Policy Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Received"
      | value | min |
      #| 12460 | 3   |
      | 3115  | 4   |
    Then  UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Dropped"
      | value | min |
    #  | 8328  | 3   |
      | 2082  | 4   |

  @SID_13
  Scenario: Entering to the peace time policy first drill down
    When UI Click Button "Protection Policies.GO BACK" with value " GO BACK"
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 37

  @SID_14
  Scenario: Validate Traffic Composition widget for second peace time policy
    Then UI Validate Pie Chart data "Traffic Composition"
      | label | data |
      | UDP   | 480  |
      | ICMP  | 0    |
      | IGMP  | 0    |
      | OTHER | 0    |
      | SCTP  | 0    |
      | TCP   | 0    |

  @SID_15
  Scenario: Validate Dashboards "Policy Traffic Bandwidth" Widget data
    When UI Do Operation "Select" item "Policy Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Received"
      | value | min |
      | 480   | 4   |
    Then  UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Dropped"
      | value | min |
      | 582   | 4   |
    When UI Do Operation "Select" item "Policy Traffic Bandwidth.bps"
    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Received"
      | value | count |
      | 480   | 0     |
    Then  UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Dropped"
      | value | count |
      | 582   | 0     |
    When UI Do Operation "Select" item "Policy Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Outbound"
    Then UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Received"
      | value | count |
      | 587   | 0     |
    Then  UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Dropped"
      | value | count |
      | 587   | 0     |
    When UI Do Operation "Select" item "Policy Traffic Bandwidth.pps"
    And UI Do Operation "Select" item "Policy Traffic Bandwidth.Inbound"
    Then UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Received"
      | value | min |
      | 587   | 4   |
    Then  UI Validate Line Chart data "Policy Traffic Bandwidth" with Label "Dropped"
      | value | min |
      | 587   | 4   |

  @SID_16
    Scenario: Logout and kill traffic generation
    * CLI kill all simulator attacks on current vision
    And UI Logout

  @SID_17
    Scenario: generate attack for peace time and move it back
       * CLI simulate 1000 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000
       * CLI simulate 1 attacks of type "rest_anomalies" on "DefensePro" 10
       * CLI simulate 1 attacks of type "rest_intrusion_port0" on "DefensePro" 10
       * CLI simulate 1 attacks of type "Ascan_Policy14" on "DefensePro" 10 and wait 30 seconds
       # Move the attacks endTime 23 hours and startTime 36 hours backwards
       Then CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"physicalPort": "0"}},"script": {"inline": "ctx._source.startTime = 'ctx._source.startTime-129600000';ctx._source.endTime = 'ctx._source.endTime-82800000'"}}'" on "ROOT_SERVER_CLI"
       And Sleep "7"
       # move Intrusion 7727-1402580209 End and Start times 36 Hrs backwards to validate it is NOT in the list
       When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"physicalPort": "1"}},"script": {"inline": "ctx._source.startTime = 'ctx._source.startTime-129600000'; ctx._source.endTime = 'ctx._source.endTime-129600000'"}}'" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "date > /opt/radware/debug.txt" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_search?pretty -d '{"query": {"match": {"physicalPort": "1"}}}' >> /opt/radware/debug.txt" on "ROOT_SERVER_CLI"

  @SID_18
  Scenario: Login and navigate to VRM
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @SID_19
    Scenario: Validate terminated 23 hrs attack existence for peace time
      Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "Policy14"
      When UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Anti-Scanning"
      Then UI Validate "Protection Policies.Events Table" Table rows count equal to 1
      Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
        | columnName  | value               |
        | Attack Name | TCP Scan (vertical) |
      Then UI Click Switch button "Protection Policies.Protections Table.Switch Button" and set the status to "ON"
      Then UI Validate "Protection Policies.Events Table" Table rows count equal to 2
      Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName  | value    |
      | Policy Name | Policy14 |
      Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 1
      | columnName  | value    |
      | Policy Name | Policy14 |
      Then UI Click Button "Protection Policies.GO BACK"

  @SID_20
    Scenario: validate occurred 23 hrs attack existence for peace time
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "Policy14"
    When UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Intrusions"
    Then UI Validate "Protection Policies.Events Table" Table rows count equal to 1
    Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
      | columnName    | value    |
      | Attack Name   | tim      |
      | Attack Status | Occurred |
      Then UI Click Button "Protection Policies.GO BACK"

  @SID_21
  Scenario: validate older than 24 hrs attack not in list
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "Policy14"
    When UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Intrusions"
    Then UI Validate "Protection Policies.Events Table" Table rows count equal to 1
    When UI Click Button "Protection Policies.GO BACK"

  @SID_22
    Scenario: DE41619 Validate GENERAL POLICY 23 hrs attack existence for peace time
      Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
      Then UI Validate Table record values by columns with elementLabel "Protection Policies.Protections Table" findBy index 0
        | columnName      | value       |
        | Protection Name | Anomalies   |
      Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy index 0
      Then UI Validate "Protection Policies.Events Table" Table rows count equal to 1
      Then UI Validate Table record values by columns with elementLabel "Protection Policies.Events Table" findBy index 0
        | columnName  | value                    |
        | Attack Name | Incorrect IPv4 checksum  |

  @SID_23
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI kill all simulator attacks on current vision

