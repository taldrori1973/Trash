Feature: GRE and Ip in Ip

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    Then CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Run PCAP
    Given CLI simulate 100 attacks of type "gre" on "DefensePro" 10 with loopDelay 15000
    Given CLI simulate 100 attacks of type "ipinip" on "DefensePro" 10 with loopDelay 15000 and wait 50 seconds

  @SID_3
  Scenario: Login
    When UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @SID_4
  Scenario: validate table count
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "ACL"
    Then UI Validate "Protection Policies.Protections Table" Table rows count EQUALS to 2


  @SID_5
  Scenario: Go To 3 drill and validate IP in IP
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "40-1610292248"
    Then UI Text of "Info.Protocol" contains "IP in IP"

  @SID_6
  Scenario: Go To 3 drill and validate GRE
    Then UI Click Button "Protection Policies.GO BACK"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "ACL"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "34-1610292248"
    Then UI Text of "Info.Protocol" contains "GRE"

  @SID_7
  Scenario: validate the protocol in DP attack dashboard
    When UI Navigate to "DefensePro Attacks" page via homePage




