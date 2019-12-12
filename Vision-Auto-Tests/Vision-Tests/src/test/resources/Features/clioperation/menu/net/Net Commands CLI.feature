@CLI_Positive @TC106026

Feature: Net CLI Commands Tests

  @SID_1
  Scenario: net help
    When CLI Operations - Run Radware Session command "net ?"
    Then CLI Operations - Verify that output contains regex ".*Network configuration..*"
    Then CLI Operations - Verify that output contains regex ".*dns.*DNS parameters..*"
    Then CLI Operations - Verify that output contains regex ".*firewall.*Firewall parameters..*"
    Then CLI Operations - Verify that output contains regex ".*ip.*IP address configuration..*"
    Then CLI Operations - Verify that output contains regex ".*nat.*Configures the NAT settings for client-server access..*"
    Then CLI Operations - Verify that output contains regex ".*physical-interface.*Physical interface parameters..*"
    Then CLI Operations - Verify that output contains regex ".*route.*Routing parameters..*"

  @SID_2
  Scenario: net dns help
    When CLI Operations - Run Radware Session command "net dns ?"
    Then CLI Operations - Verify that output contains regex ".*DNS parameters..*"
    Then CLI Operations - Verify that output contains regex ".*delete.*Deletes DNS server entries..*"
    Then CLI Operations - Verify that output contains regex ".*get.*Displays the DNS table..*"
    Then CLI Operations - Verify that output contains regex ".*set.*Creates DNS servers entries..*"

  @SID_3
  Scenario: net dns set help
    When CLI Operations - Run Radware Session command "net dns set ?"
    Then CLI Operations - Verify that output contains regex ".*Creates DNS servers entries..*"
    Then CLI Operations - Verify that output contains regex ".*primary.*Creates the primary DNS server entry..*"
    Then CLI Operations - Verify that output contains regex ".*secondary.*Creates the secondary DNS server entry..*"
    Then CLI Operations - Verify that output contains regex ".*tertiary.*Creates the tertiary DNS server entry..*"
    When CLI Operations - Run Radware Session command "net dns set primary ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: net dns set primary <IP address>.*"
    Then CLI Operations - Verify that output contains regex ".*Creates the primary DNS server entry..*"
    When CLI Operations - Run Radware Session command "net dns set secondary ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: net dns set secondary <IP address>.*"
    Then CLI Operations - Verify that output contains regex ".*Creates the secondary DNS server entry..*"
    When CLI Operations - Run Radware Session command "net dns set tertiary ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: net dns set tertiary <IP address>.*"
    Then CLI Operations - Verify that output contains regex ".*Creates the tertiary DNS server entry..*"

  @SID_4
  Scenario: net dns get help
    When CLI Operations - Run Radware Session command "net dns get ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: net dns get.*"
    Then CLI Operations - Verify that output contains regex ".*Displays the DNS table..*"

  @SID_5
  Scenario: net dns set primary & get
    When CLI Operations - Run Radware Session command "net dns set primary 1.2.3.4"
    When CLI Operations - Run Radware Session command "net dns get"
    Then CLI Operations - Verify that output contains regex ".*Primary.*1.2.3.4.*"

  @SID_6
  Scenario: net dns set secondary & get
    When CLI Operations - Run Radware Session command "net dns set secondary 1.1.1.1"
    When CLI Operations - Run Radware Session command "net dns get"
    Then CLI Operations - Verify that output contains regex ".*Secondary.*1.1.1.1.*"

  @SID_7
  Scenario: net dns set tertiary & get
    When CLI Operations - Run Radware Session command "net dns set tertiary 2.2.2.2"
    When CLI Operations - Run Radware Session command "net dns get"
    Then CLI Operations - Verify that output contains regex ".*Tertiary.*2.2.2.2.*"

  @SID_8
  Scenario: net dns delete help
    When CLI Operations - Run Radware Session command "net dns delete ?"
    Then CLI Operations - Verify that output contains regex ".*Deletes DNS server entries..*"
    Then CLI Operations - Verify that output contains regex ".*primary.*Deletes the primary DNS server entry..*"
    Then CLI Operations - Verify that output contains regex ".*secondary.*Deletes the secondary DNS server entry..*"
    Then CLI Operations - Verify that output contains regex ".*tertiary.*Deletes the tertiary DNS server entry..*"
    When CLI Operations - Run Radware Session command "net dns delete primary ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: net dns delete primary.*"
    Then CLI Operations - Verify that output contains regex ".*Deletes the primary DNS server entry..*"
    When CLI Operations - Run Radware Session command "net dns delete secondary ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: net dns delete secondary.*"
    Then CLI Operations - Verify that output contains regex ".*Deletes the secondary DNS server entry..*"
    When CLI Operations - Run Radware Session command "net dns delete tertiary ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: net dns delete tertiary.*"
    Then CLI Operations - Verify that output contains regex ".*Deletes the tertiary DNS server entry..*"

  @SID_9
  Scenario: net firewall help
    When CLI Operations - Run Radware Session command "net firewall ?"
    Then CLI Operations - Verify that output contains regex ".*Firewall parameters..*"
    Then CLI Operations - Verify that output contains regex ".*open-port.*Firewall open port parameters..*"
    When CLI Operations - Run Radware Session command "net firewall open-port ?"
    Then CLI Operations - Verify that output contains regex ".*Firewall open port parameters..*"
    Then CLI Operations - Verify that output contains regex ".*list.*Lists the currently open TCP ports in the firewall..*"
    Then CLI Operations - Verify that output contains regex ".*set.*Opens or closes the specified TCP port in the firewall..*"
    When CLI Operations - Run Radware Session command "net firewall open-port list ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: net firewall open-port list.*"
    Then CLI Operations - Verify that output contains regex ".*Lists the currently open TCP ports in the firewall..*"
    When CLI Operations - Run Radware Session command "net firewall open-port set ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: net firewall open-port set <PORT_NUMBER> <open/close>.*"
    Then CLI Operations - Verify that output contains regex ".*Opens or closes the specified TCP port in the firewall..*"

  @SID_10
  Scenario: net firewall open-port set & list - open
    Then CLI Operations - Run Radware Session command "net firewall open-port set 1500 open"
    Then CLI Operations - Run Radware Session command "net firewall open-port list"
    Then CLI Operations - Verify that output contains regex ".*1500.*"
    Then CLI Operations - Run Radware Session command "net firewall open-port set 1500 close"

  @SID_11
  Scenario: net ip help
    Then CLI Operations - Run Radware Session command "net ip ?"
    Then CLI Operations - Verify that output contains regex ".*IP address configuration..*"
    Then CLI Operations - Verify that output contains regex ".*delete.*Deletes an IP address entry..*"
    Then CLI Operations - Verify that output contains regex ".*get.*Displays network interface information..*"
    Then CLI Operations - Verify that output contains regex ".*management.*Management device configuration..*"
    Then CLI Operations - Verify that output contains regex ".*set.*Creates an IP address entry..*"
#    Then CLI Operations - Run Radware Session command "net ip set?"
#    Then CLI Operations - Verify that output contains regex ".*Usage: net ip set <Address IP> <Netmask IP> <G1|G2|G3|G4|G5|G7>.*"
#    Then CLI Operations - Verify that output contains regex ".*Creates an IP address entry for the device network interface..*"
    Then CLI Operations - Run Radware Session command "net ip get ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: net ip get.*"
    Then CLI Operations - Verify that output contains regex ".*Displays network interface information..*"
    Then CLI Operations - Run Radware Session command "net ip delete ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: net ip delete <G1|G2|G3|G4|G5|G7>.*"
    Then CLI Operations - Verify that output contains regex ".*Deletes an IP address entry and removes all routes to any destinations through the specified interface..*"
    Then CLI Operations - Run Radware Session command "net ip management ?"
    Then CLI Operations - Verify that output contains regex ".*Management device interface configuration..*"
    Then CLI Operations - Verify that output contains regex ".*set.*Sets the management interface of the device ..*"
    Then CLI Operations - Run Radware Session command "net ip management set ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: net ip management set <G1|G2|G3>.*"
    Then CLI Operations - Verify that output contains regex ".*Sets the management interface of the device..*"

  @SID_12
  Scenario: net ip set & get
    Then CLI Operations - Run Radware Session command "net ip set 172.17.173.2 255.255.0.0 G2"
    Then CLI Operations - Run Radware Session command "net ip get"
    Then CLI Operations - Verify that output contains regex ".*G2.*172.17.173.2.*255.255.0.0.*"
    Then CLI Operations - Run Radware Session command "net ip delete G2"
    Then CLI Operations - Run Radware Session command "y"

  @SID_13
  Scenario: net nat help
    When CLI Operations - Run Radware Session command "net nat ?"
    Then CLI Operations - Verify that output contains regex ".*get.*Gets the NAT-host configuration for the server..*"
    Then CLI Operations - Verify that output contains regex ".*set.*Sets the NAT-host configuration for the server..*"
    When CLI Operations - Run Radware Session command "net nat get ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: net nat get.*"
    Then CLI Operations - Verify that output contains regex ".*Gets the NAT-host configuration for the server..*"
    When CLI Operations - Run Radware Session command "net nat set ?"
    Then CLI Operations - Verify that output contains regex ".*hostname.*Sets the NAT hostname for the APSolute Vision server..*"
    Then CLI Operations - Verify that output contains regex ".*ip.*Sets the NAT IP address for the APSolute Vision server..*"
    Then CLI Operations - Verify that output contains regex ".*none.*Removing server NAT configuration..*"

  @SID_14
  Scenario: net route help
    When CLI Operations - Run Radware Session command "net route ?"
    Then CLI Operations - Verify that output contains regex ".*Routing parameters..*"
    Then CLI Operations - Verify that output contains regex ".*delete.*Removes a route entry or a default gateway..*"
    Then CLI Operations - Verify that output contains regex ".*get.*Displays route information..*"
    Then CLI Operations - Verify that output contains regex ".*set.*Sets a route entry or a default gateway..*"
    When CLI Operations - Run Radware Session command "net route set ?"
    Then CLI Operations - Verify that output contains regex ".*Sets a route entry or a default gateway..*"
    Then CLI Operations - Verify that output contains regex ".*default.*Setss the default route..*"
    Then CLI Operations - Verify that output contains regex ".*host.*Sets a new host route.*"
    Then CLI Operations - Verify that output contains regex ".*net.*Sets a new net route..*"
    When CLI Operations - Run Radware Session command "net route delete ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: net route delete <Net IP> <Netmask IP> <Gateway IP> \[ dev <G1|G2|G3|G4|G5|G7> \].*"
    Then CLI Operations - Verify that output contains regex ".*Removes a route entry or a default gateway..*"
    When CLI Operations - Run Radware Session command "net route get ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: net route get.*"
    Then CLI Operations - Verify that output contains regex ".*Displays the Active Interface Routing Table..*"
    Then CLI Operations - Verify that output contains regex ".*U \(route is up\).*"
    Then CLI Operations - Verify that output contains regex ".*H \(target is a host\).*"
    Then CLI Operations - Verify that output contains regex ".*G \(use gateway\).*"
    Then CLI Operations - Verify that output contains regex ".*R \(reinstate route for dynamic routing\).*"
    Then CLI Operations - Verify that output contains regex ".*D \(dynamically installed by daemon or redirect\).*"
    Then CLI Operations - Verify that output contains regex ".*M \(modified from routing daemon or redirect\).*"
    Then CLI Operations - Verify that output contains regex ".*A \(installed by addrconf\).*"
    Then CLI Operations - Verify that output contains regex ".*! \(reject route\).*"

  @SID_15
  Scenario: net route set & get & delete
    When CLI Operations - Run Radware Session command "net route set net 172.18.0.0 255.255.0.0 172.17.0.5 G1"
    When CLI Operations - Run Radware Session command "net route get"
    Then CLI Operations - Verify that output contains regex ".*172.18.0.0.*172.17.0.5.*255.255.0.0.*UG.*0.*0.*0.*G1.*"
    When CLI Operations - Run Radware Session command "net route delete 172.18.0.0 255.255.0.0 172.17.0.5 G1"
    When CLI Operations - Run Radware Session command "net route set host 172.18.7.7 172.17.2.2 G1"
    When CLI Operations - Run Radware Session command "net route get"
    Then CLI Operations - Verify that output contains regex ".*172.18.7.7.*172.17.2.2.*255.255.255.255.*UGH.*0.*0.*0.*G1.*"
    When CLI Operations - Run Radware Session command "net route delete 172.18.7.7 255.255.255.255 172.17.2.2 G1"

  @SID_16
  Scenario: net nat set & get
    When CLI Operations - Run Radware Session command "net nat set hostname radware"
    Then CLI Operations - Verify that output contains regex ".*The server will be accessible to clients using the hostname radware..*"
    When CLI Operations - Run Radware Session command "y" timeout 3000
    When CLI Operations - Run Radware Session command "net nat get"
    Then CLI Operations - Verify that output contains regex ".*Server hostname:radware.*"
    When CLI Operations - Run Radware Session command "net nat set ip 1.1.1.1"
    When CLI Operations - Run Radware Session command "y" timeout 3000
    When CLI Operations - Run Radware Session command "net nat get"
    Then CLI Operations - Verify that output contains regex ".*Server NAT host IP: <1.1.1.1>.*"
    When CLI Operations - Run Radware Session command "net nat set none"
    Then CLI Operations - Verify that output contains regex ".*The server will be accessible to clients only using the internal Management IP address..*"
    When CLI Operations - Run Radware Session command "y" timeout 3000
    When CLI Operations - Run Radware Session command "net nat get"
    Then CLI Operations - Verify that output contains regex ".*No NAT is configured for the server..*"

  @SID_17
  Scenario: net ip management set & ip get
    When CLI Operations - Run Radware Session command "net ip management set G2"
    When CLI Operations - Run Radware Session command "N" timeout 30
#    And  CLI Operations - Run Radware Session command "net ip get"
#    Then CLI Operations - Verify that output contains regex ".*G2.*\*.*"
    When CLI Operations - Run Radware Session command "net ip management set G1"
#    When CLI Operations - Run Radware Session command "y" timeout 3000
    When CLI Operations - Run Radware Session command "net ip get | grep G1"
    Then CLI Operations - Verify that output contains regex "G1.*\*.*"




































































