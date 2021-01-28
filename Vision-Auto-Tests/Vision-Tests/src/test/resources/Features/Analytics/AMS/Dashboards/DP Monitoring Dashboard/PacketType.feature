Feature: Packet Type testing
  #  ==========================================Setup================================================
  @SID_1
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    Given CLI Run remote linux Command "service vision restart" on "ROOT_SERVER_CLI" and wait 185 seconds

  @SID_2
  Scenario: Update Policies
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given REST Login with user "radware" and password "radware"
    Then REST Update Policies for All DPs

  @SID_3
  Scenario: Copy and run add https server script
    Then CLI copy "/home/radware/Scripts/add_https_server.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then CLI Run remote linux Command "/add_https_server.sh 172.16.22.51 pol1 test 1.1.1.2" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario:Login and Navigate to HTTPS Flood Dashboard
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @SID_5
  Scenario: Run DP simulator PCAPs for "HTTPS attacks"
    Given CLI simulate 1 attacks of type "HTTPS" on "DefensePro" 11 with loopDelay 15000 and wait 60 seconds
    Then CLI Run linux Command "service iptables stop" on "ROOT_SERVER_CLI" and validate result CONTAINS "Unloading modules"

  @SID_6
  Scenario: validate table to validate paketType : Decrypted-HTTPS
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "p2"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Intrusions"
    Then UI Validate "Protection Policies.Events Table" Table rows count EQUALS to 1
    Then UI validate Table row by keyValue with elementLabel "Protection Policies.Events Table" findBy columnName "Packet Type" findBy cellValue "Decrypted HTTPS"

  @SID_7
  Scenario: validate table to validate paketType : Decrypted-HTTPS
    Then UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "p2"
    Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "SYN Flood"
    Then UI Validate "Protection Policies.Events Table" Table rows count EQUALS to 1
    Then UI validate Table row by keyValue with elementLabel "Protection Policies.Events Table" findBy columnName "Packet Type" findBy cellValue "Regular"

