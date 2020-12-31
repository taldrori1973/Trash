@TC116333
Feature: Forensics Multiple IP

  @SID_1
  Scenario: Clean system data
    * CLI Clear vision logs
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-traffic-*"
    * REST Delete ES index "dp-https-stats-*"
    * REST Delete ES index "dp-https-rt-*"
    * REST Delete ES index "dp-five-*"

  @SID_2
  Scenario: Run DP simulator
    Then CLI simulate 1000 attacks of type "tcp_udp_multiple_ip" on "DefensePro" 10 and wait 120 seconds

  @SID_3
  Scenario: VRM - Login to VRM Forensic and do data manipulation
    Given UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "AMS Forensics" page via homePage

  @SID_4
  Scenario: VRM - Add New Forensics Report criteria - Destination IP - Equals
    When UI "Create" Forensics With Name "Destination IP Criteria"
      | devices  | index:10                                                                     |
      | Criteria | Event Criteria:Destination IP,Operator:Equals,IPType:IPv4,IPValue:10.0.0.18; |
      | Output   | Attack Name,Attack ID,Source IP Address,Destination IP Address,Protocol      |
    When UI Generate and Validate Forensics With Name "Destination IP Criteria" with Timeout of 180 Seconds
    And Sleep "30"
    And UI Click Button "Views.report" with value "Destination IP Criteria"
    Then UI Validate "Report.Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy columnName "Attack Name" findBy cellValue "network flood IPv4 TCP-SYN"
      | columnName             | value      |
      | Destination IP Address | 10.0.0.18  |
      | Protocol               | TCP        |
      | Source IP Address      | 192.85.1.2 |
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy columnName "Attack Name" findBy cellValue "network flood IPv4 UDP"
      | columnName             | value      |
      | Destination IP Address | 10.0.0.18  |
      | Protocol               | UDP        |
      | Source IP Address      | 192.85.1.2 |
    And UI Navigate to "AMS Reports" page via homePage
    And UI Navigate to "AMS Forensics" page via homePage

  @SID_5
  Scenario: VRM - Add New Forensics Report criteria - Destination IP - Not Equals
    When UI "Create" Forensics With Name "Not Equals Destination IP Criteria"
      | devices  | index:10                                                                         |
      | Criteria | Event Criteria:Destination IP,Operator:Not Equals,IPType:IPv4,IPValue:10.0.0.18; |
      | Output   | Attack Name,Attack ID,Source IP Address,Destination IP Address                   |
    When UI Generate and Validate Forensics With Name "Not Equals Destination IP Criteria" with Timeout of 180 Seconds
    And Sleep "30"
    And UI Click Button "Views.report" with value "Not Equals Destination IP Criteria"
    Then UI Validate "Report.Table" Table rows count EQUALS to 0
    And UI Navigate to "AMS Reports" page via homePage
    And UI Navigate to "AMS Forensics" page via homePage

  @SID_6
  Scenario: VRM - Add New Forensics Report criteria - Source IP - Equals
    When UI "Create" Forensics With Name "Source IP Criteria"
      | devices  | index:10                                                                 |
      | Criteria | Event Criteria:Source IP,Operator:Equals,IPType:IPv4,IPValue:192.85.1.2; |
      | Output   | Attack Name,Attack ID,Source IP Address,Destination IP Address           |
    When UI Generate and Validate Forensics With Name "Source IP Criteria" with Timeout of 180 Seconds
    And UI Navigate to "AMS Reports" page via homePage
    And UI Navigate to "AMS Forensics" page via homePage
    And UI Click Button "Views.Expand" with value "Source IP Criteria"
    And UI Click Button "Views.report" with value "Source IP Criteria"
    Then UI Validate "Report.Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy columnName "Attack Name" findBy cellValue "network flood IPv4 TCP-SYN"
      | columnName             | value    |
      | Destination IP Address | Multiple |
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy columnName "Attack Name" findBy cellValue "network flood IPv4 UDP"
      | columnName             | value    |
      | Destination IP Address | Multiple |
    And UI Navigate to "AMS Reports" page via homePage
    And UI Navigate to "AMS Forensics" page via homePage

  @SID_7
  Scenario: VRM - Add New Forensics Report criteria - Source IP - Not Equals
    When UI "Create" Forensics With Name "Not Equals Source IP Criteria"
      | devices  | index:10                                                                     |
      | Criteria | Event Criteria:Source IP,Operator:Not Equals,IPType:IPv4,IPValue:192.85.1.2; |
      | Output   | Attack Name,Attack ID,Source IP Address,Destination IP Address               |
    When UI Generate and Validate Forensics With Name "Not Equals Source IP Criteria" with Timeout of 180 Seconds
    And Sleep "30"
    And UI Click Button "Views.report" with value "Not Equals Source IP Criteria"
    Then UI Validate "Report.Table" Table rows count EQUALS to 0
    And UI Navigate to "AMS Reports" page via homePage
    And UI Navigate to "AMS Forensics" page via homePage

  @SID_8
  Scenario: VRM - Add New Forensics Report criteria - All Criteria
    When UI "Create" Forensics With Name "All Criteria"
      | devices | index:10                                                       |
      | Output  | Attack Name,Attack ID,Source IP Address,Destination IP Address |
    When UI Generate and Validate Forensics With Name "All Criteria" with Timeout of 180 Seconds
    And Sleep "30"
    And UI Click Button "Views.report" with value "All Criteria"
    Then UI Validate "Report.Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy columnName "Attack Name" findBy cellValue "network flood IPv4 TCP-SYN"
      | columnName             | value    |
      | Destination IP Address | Multiple |
    Then UI Validate Table record values by columns with elementLabel "Report.Table" findBy columnName "Attack Name" findBy cellValue "network flood IPv4 UDP"
      | columnName             | value    |
      | Destination IP Address | Multiple |
    And UI Navigate to "AMS Reports" page via homePage
    And UI Navigate to "AMS Forensics" page via homePage

  @SID_9
  Scenario: Cleanup
    * CLI kill all simulator attacks on current vision
    Given UI logout and close browser



