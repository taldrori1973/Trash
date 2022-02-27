@TC124863
Feature: DefensePro Behavioral DNS General Tests

  @SID_1
  Scenario: login and Verify default Tab BDoS
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label          | param        | value |
      | Behavioral Tab | BDoS         | true  |
      | Behavioral Tab | DNS Flood    | false |
      | Behavioral Tab | Quantile DoS | false |
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-TXT"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-MX"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-AAAA"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-SRV"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-A"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-SOA"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-Other"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-NAPTR"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-PTR"


  @SID_2
  Scenario: DNS baseline pre-requisite
    Then UI Click Button "Behavioral Tab" with value "DNS Flood"
    Given CLI kill all simulator attacks on current vision
    Given CLI Clear vision logs
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    Given CLI simulate 200 attacks of type "baselines_pol_1" on SetId "DefensePro_Set_1" with loopDelay 15000 and wait 140 seconds

  @SID_3
  Scenario: select device and Policy
    And UI Do Operation "Select" item "Global Time Filter"
    Then Sleep "1"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_1 |       | pol_1    |

  @SID_4
  Scenario: Validate Scope Selection Stability
    Then UI Click Button "Behavioral Tab" with value "BDoS"
    Then Sleep "2"
    And UI Do Operation "Select" item "Device Selection"
    Then UI Validate the attribute of "class" are "EQUAL" to
      | label                                     | param        | value   |
      | DefensePro Analytics_RationScopeSelection | 172.16.22.50 | checked |
      | DefensePro Analytics_RationScopeSelection | 172.16.22.51 |         |
      | DefensePro Analytics_RationScopeSelection | 172.16.22.25 |         |
    Then UI Click Button "Device Selection.Cancel"
    Then UI Click Button "Behavioral Tab" with value "DNS Flood"
    And UI Do Operation "Select" item "Device Selection"
    Then UI Validate the attribute of "class" are "EQUAL" to
      | label                                     | param        | value   |
      | DefensePro Analytics_RationScopeSelection | 172.16.22.50 | checked |
      | DefensePro Analytics_RationScopeSelection | 172.16.22.51 |         |
      | DefensePro Analytics_RationScopeSelection | 172.16.22.25 |         |
    Then UI Click Button "Device Selection.Cancel"


  @SID_5
  Scenario: Remove DNS Widgets
    Then UI Click Button "Widget remove" with value "DNS-TXT"
    Then UI Click Button "Widget remove" with value "DNS-MX"
    Then UI Click Button "Widget remove" with value "DNS-AAAA"
    Then UI Click Button "Widget remove" with value "DNS-SRV"

  @SID_6
  Scenario: Validate Charts existence
    Then UI Click Button "Behavioral Tab" with value "BDoS"
    Then Sleep "2"
    Then UI Click Button "Behavioral Tab" with value "DNS Flood"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-TXT"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-MX"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-AAAA"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-SRV"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-A"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-SOA"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-Other"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-NAPTR"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-PTR"

  @SID_7
  Scenario: Settings label for DNS-A Chart
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-A,IPv4"
    And UI Click Button "Chart Settings" with value "DNS-A"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI validate Checkbox by label "DPPolicycheck" if Selected "false"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,19_Characters_19_Ch"
    Then UI Click Button "Widget Settings Save"
    And UI Click Button "Chart Settings" with value "DNS-A"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI validate Checkbox by label "DPPolicycheck" if Selected "true"
    Then UI Click Button "Widget Settings Cancel"

  @SID_8
  Scenario: Validate DNS Widget Repository
    Then UI Click Button "Widget Selection"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "true" with value "DNS-A"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "true" with value "DNS-AAAA"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "true" with value "DNS-MX"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "true" with value "DNS-TXT"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "true" with value "DNS-SOA"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "true" with value "DNS-SRV"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "true" with value "DNS-PTR"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "true" with value "DNS-NAPTR"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "true" with value "DNS-Other"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "false" with value "BDoS-UDP"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "false" with value "BDoS-Advanced-UDP_Rate-Invariant"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "false" with value "BDoS-TCP_SYN"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "false" with value "BDoS-TCP_SYN_ACK"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "false" with value "BDoS-TCP_RST"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "false" with value "BDoS-TCP_FIN_ACK"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "false" with value "BDoS-TCP_Fragmented"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "false" with value "BDoS-UDP_Fragmented"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "false" with value "BDoS-ICMP"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "false" with value "BDoS-IGMP"
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "false" with value "Excluded_UDP_Traffic"
    Then UI Click Button "Widget Selection"


  @SID_9
  Scenario: Validate DNS Default form
    Then UI Navigate to "Application Dashboard" page via homePage
    Then UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Click Button "Behavioral Tab" with value "DNS Flood"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-TXT"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-MX"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-AAAA"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-SRV"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-A"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-SOA"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-Other"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-NAPTR"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-PTR"

  @SID_10
  Scenario: DNS baselines add all baselines types
    When UI VRM Clear All Widgets
    And UI VRM Select Widgets
      | DNS-A     |
      | DNS-TXT   |
      | DNS-AAAA  |
      | DNS-MX    |
      | DNS-NAPTR |
      | DNS-PTR   |
      | DNS-SOA   |
      | DNS-SRV   |
      | DNS-Other |

    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-TXT-1,IPv6"
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-AAAA-1,IPv6"
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-MX-1,IPv6"
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-PTR-1,IPv6"
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-SOA-1,IPv6"
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-SRV-1,IPv6"
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-Other-1,IPv6"
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-NAPTR-1,IPv6"
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-A-1,IPv6"


  @SID_11
  Scenario: Validate Default Widgets
    Then UI Navigate to "Application Dashboard" page via homePage
    Then UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Click Button "Behavioral Tab" with value "DNS Flood"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-TXT"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-MX"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-AAAA"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-SRV"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-A"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-SOA"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-Other"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-NAPTR"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-PTR"

  @SID_12
  Scenario: Validate Default Widgets After Clear ALL
    When UI VRM Clear All Widgets
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-TXT"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-MX"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-AAAA"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-SRV"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-A"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-SOA"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-Other"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-NAPTR"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-PTR"
    Then UI Navigate to "Application Dashboard" page via homePage
    Then UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Click Button "Behavioral Tab" with value "DNS Flood"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-TXT"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-MX"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-AAAA"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-SRV"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-A"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-SOA"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-Other"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-NAPTR"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-PTR"

  @SID_13
  Scenario: Validate Information Message After Clear ALL
    When UI VRM Clear All Widgets
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-TXT"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-MX"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-AAAA"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-SRV"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-A"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-SOA"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-Other"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-NAPTR"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-PTR"
    Then UI logout and close browser

  @SID_14
  Scenario: Validate Chart Number Reset
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Click Button "Behavioral Tab" with value "DNS Flood"
    When UI VRM Clear All Widgets
    And UI VRM Select Widgets
      | DNS-A |
    And UI VRM Select Widgets
      | DNS-A |
    And UI VRM Select Widgets
      | DNS-A |
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-A-3"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-A-2"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-A-1"
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "DNS-A"

  @SID_15
  Scenario: Validate No Widgets Selected Message
    When UI VRM Clear All Widgets
    Then UI Validate Element Existence By Label "Repo button" if Exists "true"
    Then UI Click Button "Repo button"
    Then UI Click Button "Repository Widget" with value "DNS-A"
    Then UI Click Button "Widget Selection.Add Selected Widgets"
    Then UI Click Button "Widget Selection"
    Then UI Validate Element Existence By Label "Repo button" if Exists "false"
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "DNS-A-1"

  @SID_16
  Scenario: Create Report of DNS baselines IPv4
    And UI Navigate to "AMS Reports" page via homePage
    Given UI "Create" Report With Name "DNS Baselines Report"
      | reportType | DefensePro Behavioral Protections Dashboard                                                                                                                                                              |
      | Design     | {"Add":[{"DNS-A":["IPv4"]},{"DNS-AAAA":["IPv4"]},{"DNS-MX":["IPv4"]},{"DNS-SRV":["IPv4"]},{"DNS-TXT":["IPv4"]},{"DNS-SOA":["IPv4"]},{"DNS-PTR":["IPv4"]},{"DNS-NAPTR":["IPv4"]},{"DNS-Other":["IPv4"]}]} |
      | devices    | SetId:DefensePro_Set_1,policies:[pol_1]                                                                                                                                                                  |
      | Format     | Select: PDF                                                                                                                                                                                              |
    Then UI "Generate" Report With Name "DNS Baselines Report"
      | timeOut | 120 |
    Then UI Click Button "Log Preview" with value "DNS Baselines Report_0"
    Then UI Validate Element Existence By Label "Max button" if Exists "true" with value "DNS-TXT"
    Then UI Validate Element Existence By Label "Min button" if Exists "true" with value "DNS-TXT"
    Then UI Validate Element Existence By Label "Max button" if Exists "true" with value "DNS-A"
    Then UI Validate Element Existence By Label "Min button" if Exists "true" with value "DNS-A"
    Then UI Validate Element Existence By Label "Max button" if Exists "true" with value "DNS-AAAA"
    Then UI Validate Element Existence By Label "Min button" if Exists "true" with value "DNS-AAAA"
    Then UI Validate Element Existence By Label "Max button" if Exists "true" with value "DNS-MX"
    Then UI Validate Element Existence By Label "Min button" if Exists "true" with value "DNS-MX"
    Then UI Validate Element Existence By Label "Max button" if Exists "true" with value "DNS-NAPTR"
    Then UI Validate Element Existence By Label "Min button" if Exists "true" with value "DNS-NAPTR"
    Then UI Validate Element Existence By Label "Max button" if Exists "true" with value "DNS-PTR"
    Then UI Validate Element Existence By Label "Min button" if Exists "true" with value "DNS-PTR"
    Then UI Validate Element Existence By Label "Max button" if Exists "true" with value "DNS-SOA"
    Then UI Validate Element Existence By Label "Min button" if Exists "true" with value "DNS-SOA"
    Then UI Validate Element Existence By Label "Max button" if Exists "true" with value "DNS-SRV"
    Then UI Validate Element Existence By Label "Min button" if Exists "true" with value "DNS-SRV"
    Then UI Validate Element Existence By Label "Max button" if Exists "true" with value "DNS-Other"
    Then UI Validate Element Existence By Label "Min button" if Exists "true" with value "DNS-Other"


  @SID_17
  Scenario: kill all simulator attacks and logout
    Then UI logout and close browser
    Then CLI kill all simulator attacks on current vision

