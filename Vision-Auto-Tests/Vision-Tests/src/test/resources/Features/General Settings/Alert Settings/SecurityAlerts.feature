@VisionSettings @TC106047

Feature: Alert Settings - Security Alerts Functionality

  @SID_1
  Scenario: Navigate to Alert Browser page
    When CLI Operations - Run Root Session command "/opt/radware/mgt-server/bin/collectors_service.sh restart" timeout 240
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Alert Settings->Security Alerts"

  @SID_2
  Scenario: Security Alerts - set and validate Parameters
    Then UI Set Checkbox "Policy Name" To "false"
    Then UI Set Checkbox "Source IP Address" To "false"
    Then UI Set Checkbox "Destination Port" To "false"
    Then UI Set Checkbox "Attack Name" To "false"
    Then UI Set Checkbox "Destination IP Address" To "false"
    Then UI Set Checkbox "Action" To "false"
    Then UI Click Button "Submit"
    Then UI validate Checkbox by label "Policy Name" if Selected "false"
    Then UI validate Checkbox by label "Source IP Address" if Selected "false"
    Then UI validate Checkbox by label "Destination Port" if Selected "false"
    Then UI validate Checkbox by label "Attack Name" if Selected "false"
    Then UI validate Checkbox by label "Destination IP Address" if Selected "false"
    Then UI validate Checkbox by label "Action" if Selected "false"

  @SID_3
  Scenario: Clear alert and attack index
    Then REST Delete ES index "dp-attack-raw-*"
    Then Sleep "2"
    Then REST Delete ES document with data ""module": "SECURITY_REPORTING"" from index "alert"

  @SID_4
  Scenario: generate single attack
    * CLI simulate 1 attacks of type "start_dos_0" on "DefensePro" 10 and wait 100 seconds

  @SID_5
  Scenario: validate alert message content no fields
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"SECURITY_REPORTING"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |awk -F"\"M_20000: " '{print $2}'|awk -F"\"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "An attack of type \"DoS\" started."

  @SID_6
  Scenario: Clear alert and attack index
    Then REST Delete ES index "dp-attack-raw-*"
    Then Sleep "2"
    Then REST Delete ES document with data ""module": "SECURITY_REPORTING"" from index "alert"

  @SID_7
  Scenario: Set attack parameters Policy Name
    Then REST Request "PUT" for "Alert Browser->Security Alerts"
      | type | value                    |
      | body | addRule=true             |
      | body | addSourceIp=false        |
      | body | addDestinationPort=false |
      | body | addAttackName=false      |
      | body | addDestinationIp=false   |
      | body | addAction=false          |

  @SID_8
  Scenario: generate single attack
    * CLI simulate 1 attacks of type "start_dos_1" on "DefensePro" 10 and wait 85 seconds

  @SID_9
  Scenario: validate alert message content one field
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"SECURITY_REPORTING"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |awk -F"\"M_20000: " '{print $2}'|awk -F"\"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "An attack of type \"DoS\" started. Detected by policy: pph_9Pkt_lmt_252.1."

  @SID_10
  Scenario: Clear alert and attack index
    Then REST Delete ES index "dp-attack-raw-*"
    Then Sleep "2"
    Then REST Delete ES document with data ""module": "SECURITY_REPORTING"" from index "alert"

  @SID_11
  Scenario: Set attack parameters Policy Name source IP
    Then REST Request "PUT" for "Alert Browser->Security Alerts"
      | type | value                    |
      | body | addRule=true             |
      | body | addSourceIp=true         |
      | body | addDestinationPort=false |
      | body | addAttackName=false      |
      | body | addDestinationIp=false   |
      | body | addAction=false          |

  @SID_12
  Scenario: generate single attack
    * CLI simulate 1 attacks of type "start_dos_2" on "DefensePro" 10 and wait 85 seconds

  @SID_13
  Scenario: validate alert message content two fields
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"SECURITY_REPORTING"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |awk -F"\"M_20000: " '{print $2}'|awk -F"\"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "An attack of type \"DoS\" started. Detected by policy: pph_9Pkt_lmt_252.1; Source IP: 198.18.0.1."

  @SID_14
  Scenario: Clear alert and attack index
    Then REST Delete ES index "dp-attack-raw-*"
    Then Sleep "2"
    Then REST Delete ES document with data ""module": "SECURITY_REPORTING"" from index "alert"

  @SID_15
  Scenario: Set attack parameters Policy Name source IP Dest Port
    Then REST Request "PUT" for "Alert Browser->Security Alerts"
      | type | value                   |
      | body | addRule=true            |
      | body | addSourceIp=true        |
      | body | addDestinationPort=true |
      | body | addAttackName=false     |
      | body | addDestinationIp=false  |
      | body | addAction=false         |

  @SID_16
  Scenario: generate single attack
    * CLI simulate 1 attacks of type "start_dos_3" on "DefensePro" 10 and wait 85 seconds

  @SID_17
  Scenario: validate alert message content three fields
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"SECURITY_REPORTING"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |awk -F"\"M_20000: " '{print $2}'|awk -F"\"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "An attack of type \"DoS\" started. Detected by policy: pph_9Pkt_lmt_252.1; Source IP: 198.18.0.1; Destination port: 80."

  @SID_18
  Scenario: Clear alert and attack index
    Then REST Delete ES index "dp-attack-raw-*"
    Then Sleep "2"
    Then REST Delete ES document with data ""module": "SECURITY_REPORTING"" from index "alert"

  @SID_19
  Scenario: Set attack parameters Policy Name source IP Dest Port Attack Name
    Then REST Request "PUT" for "Alert Browser->Security Alerts"
      | type | value                   |
      | body | addRule=true            |
      | body | addSourceIp=true        |
      | body | addDestinationPort=true |
      | body | addAttackName=true      |
      | body | addDestinationIp=false  |
      | body | addAction=false         |

  @SID_20
  Scenario: generate single attack
    * CLI simulate 1 attacks of type "start_dos_4" on "DefensePro" 10 and wait 85 seconds

  @SID_21
  Scenario: validate alert message content four field
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"SECURITY_REPORTING"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |awk -F"\"M_20000: " '{print $2}'|awk -F"\"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "An attack of type \"DoS\" started. Detected by policy: pph_9Pkt_lmt_252.1; Attack name: pkt_rate_lmt_9; Source IP: 198.18.0.1; Destination port: 80."

  @SID_22
  Scenario: Clear alert and attack index
    Then REST Delete ES index "dp-attack-raw-*"
    Then Sleep "2"
    Then REST Delete ES document with data ""module": "SECURITY_REPORTING"" from index "alert"

  @SID_23
  Scenario: Set attack parameters Policy Name source IP Dest Port Attack Name Dest IP
    Then REST Request "PUT" for "Alert Browser->Security Alerts"
      | type | value                   |
      | body | addRule=true            |
      | body | addSourceIp=true        |
      | body | addDestinationPort=true |
      | body | addAttackName=true      |
      | body | addDestinationIp=true   |
      | body | addAction=false         |

  @SID_24
  Scenario: generate single attack
    * CLI simulate 1 attacks of type "start_dos_5" on "DefensePro" 10 and wait 85 seconds

  @SID_25
  Scenario: validate alert message content five field
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"SECURITY_REPORTING"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |awk -F"\"M_20000: " '{print $2}'|awk -F"\"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "An attack of type \"DoS\" started. Detected by policy: pph_9Pkt_lmt_252.1; Attack name: pkt_rate_lmt_9; Source IP: 198.18.0.1; Destination IP: 198.18.252.1; Destination port: 80."

  @SID_26
  Scenario: Clear alert and attack index
    Then REST Delete ES index "dp-attack-raw-*"
    Then Sleep "2"
    Then REST Delete ES document with data ""module": "SECURITY_REPORTING"" from index "alert"

  @SID_27
  Scenario: Set attack parameters Policy Name source IP Dest Port Attack Name Dest IP Action
    Then REST Request "PUT" for "Alert Browser->Security Alerts"
      | type | value                   |
      | body | addRule=true            |
      | body | addSourceIp=true        |
      | body | addDestinationPort=true |
      | body | addAttackName=true      |
      | body | addDestinationIp=true   |
      | body | addAction=true          |

  @SID_28
  Scenario: generate single attack
    * CLI simulate 1 attacks of type "start_dos_6" on "DefensePro" 10 and wait 85 seconds

  @SID_29
  Scenario: validate alert message content six field
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"module":"SECURITY_REPORTING"}}]}},"from":0,"size":10}' localhost:9200/alert/_search |awk -F"\"M_20000: " '{print $2}'|awk -F"\"," '{print $1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "An attack of type \"DoS\" started. Detected by policy: pph_9Pkt_lmt_252.1; Attack name: pkt_rate_lmt_9; Source IP: 198.18.0.1; Destination IP: 198.18.252.1; Destination port: 80; Action: forward."

  @SID_30
  Scenario: Logout
    Then UI logout and close browser