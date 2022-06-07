@VRM_BDoS_Baseline @TC105988
Feature: VRM DNS baselines

  @SID_1
  Scenario: DNS baseline pre-requisite
    Given CLI kill all simulator attacks on current vision
    Given CLI Clear vision logs
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    When REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    When CLI simulate 200 attacks of type "baselines_pol_1" on SetId "DefensePro_Set_1" with loopDelay 15000 and wait 140 seconds

  @SID_2
  Scenario: login and select device
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then Sleep "1"
    Then UI Click Button "Behavioral Tab" with value "DNS Flood"
    Then Sleep "1"
    And UI Do Operation "Select" item "Global Time Filter"
    Then Sleep "1"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_1 |       | pol_1    |
    And UI Do Operation "Select" item "Max Min"

  @SID_3
  Scenario: DNS baseline DNS-TXT IPv4 In QPS data
    Then UI Validate Line Chart data "DNS-TXT" with Label "Suspected Edge"
      | value | count | offset |
      | 739   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-TXT" with Label "Normal Edge"
      | value | count | offset |
      | 720   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-TXT" with Label "Attack Edge"
      | value | count | offset |
      | 758   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-TXT" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4720  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-TXT" with Label "Total Traffic"
      | value | count | offset |
      | 4360  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-TXT" with Label "Max"
      | value | count | offset |
      | 4720  | 1     | 1      |
    Then UI Validate Line Chart data "DNS-TXT" with Label "Min"
      | value | count | offset |
      | 4720  | 1     | 1      |

  @SID_4
  Scenario: DNS baseline DNS-TXT IPv6 In QPS data
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-TXT,IPv6"
    Then Sleep "5"
    Then UI Validate Line Chart data "DNS-TXT" with Label "Suspected Edge"
      | value | count | offset |
      | 739   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-TXT" with Label "Normal Edge"
      | value | count | offset |
      | 720   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-TXT" with Label "Attack Edge"
      | value | count | offset |
      | 758   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-TXT" with Label "Legitimate Traffic"
      | value | count | offset |
      | 180   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-TXT" with Label "Total Traffic"
      | value | count | offset |
      | 180   | 13    | 6      |
  # END DNS TEXT

  @SID_5
  Scenario: DNS baseline DNS-A IPv4 In QPS data
    Then UI Validate Line Chart data "DNS-A" with Label "Suspected Edge"
      | value | count | offset |
      | 7253  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-A" with Label "Normal Edge"
      | value | count | offset |
      | 6750  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-A" with Label "Attack Edge"
      | value | count | offset |
      | 7794  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-A" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4560  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-A" with Label "Total Traffic"
      | value | count | offset |
      | 4200  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-A" with Label "Max"
      | value | count | offset |
      | 4560  | 1     | 1      |
    Then UI Validate Line Chart data "DNS-A" with Label "Min"
      | value | count | offset |
      | 4560  | 1     | 1      |

  @SID_6
  Scenario: BDoS baseline DNS-A IPv6 In QPS data
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-A,IPv6"
    Then Sleep "5"
    Then UI Validate Line Chart data "DNS-A" with Label "Suspected Edge"
      | value | count | offset |
      | 7253  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-A" with Label "Normal Edge"
      | value | count | offset |
      | 6750  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-A" with Label "Attack Edge"
      | value | count | offset |
      | 7794  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-A" with Label "Legitimate Traffic"
      | value | count | offset |
      | 100   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-A" with Label "Total Traffic"
      | value | count | offset |
      | 110   | 13    | 6      |
  # END DNS A

  @SID_7
  Scenario: DNS baseline DNS-AAAA IPv4 In QPS data
    Then UI Validate Line Chart data "DNS-AAAA" with Label "Suspected Edge"
      | value | count | offset |
      | 1386  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-AAAA" with Label "Normal Edge"
      | value | count | offset |
      | 1350  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-AAAA" with Label "Attack Edge"
      | value | count | offset |
      | 1423  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-AAAA" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4680  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-AAAA" with Label "Total Traffic"
      | value | count | offset |
      | 4320  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-AAAA" with Label "Max"
      | value | count | offset |
      | 4680  | 1     | 1      |
    Then UI Validate Line Chart data "DNS-AAAA" with Label "Min"
      | value | count | offset |
      | 4680  | 1     | 1      |

  @SID_8
  Scenario: DNS baseline DNS-AAAA IPv6 In QPS data
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-AAAA,IPv6"
    Then Sleep "5"
    Then UI Validate Line Chart data "DNS-AAAA" with Label "Suspected Edge"
      | value | count | offset |
      | 1386  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-AAAA" with Label "Normal Edge"
      | value | count | offset |
      | 1350  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-AAAA" with Label "Attack Edge"
      | value | count | offset |
      | 1423  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-AAAA" with Label "Legitimate Traffic"
      | value | count | offset |
      | 160   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-AAAA" with Label "Total Traffic"
      | value  | count | offset |
      | 844403 | 13    | 6      |
  # END DNS AAAA

  @SID_9
  Scenario: DNS baseline DNS-Other IPv4 In QPS data
    Then UI Validate Line Chart data "DNS-Other" with Label "Suspected Edge"
      | value | count | offset |
      | 184   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-Other" with Label "Normal Edge"
      | value | count | offset |
      | 280   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-Other" with Label "Attack Edge"
      | value | count | offset |
      | 189   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-Other" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4880  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-Other" with Label "Total Traffic"
      | value | count | offset |
      | 4520  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-Other" with Label "Max"
      | value | count | offset |
      | 4880  | 1     | 1      |
    Then UI Validate Line Chart data "DNS-Other" with Label "Min"
      | value | count | offset |
      | 4880  | 1     | 1      |

  @SID_10
  Scenario: DNS baseline DNS-Other IPv6 In QPS data
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-Other,IPv6"
    Then Sleep "5"
    Then UI Validate Line Chart data "DNS-Other" with Label "Suspected Edge"
      | value | count | offset |
      | 184   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-Other" with Label "Normal Edge"
      | value | count | offset |
      | 200   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-Other" with Label "Attack Edge"
      | value | count | offset |
      | 189   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-Other" with Label "Legitimate Traffic"
      | value | count | offset |
      | 260   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-Other" with Label "Total Traffic"
      | value | count | offset |
      | 280   | 13    | 6      |
  # END DNS OTHER

  @SID_11
  Scenario: DNS baseline DNS-MX IPv4 In QPS data
    Then UI Validate Line Chart data "DNS-MX" with Label "Suspected Edge"
      | value | count | offset |
      | 3806  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-MX" with Label "Normal Edge"
      | value | count | offset |
      | 3600  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-MX" with Label "Attack Edge"
      | value | count | offset |
      | 4024  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-MX" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4600  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-MX" with Label "Total Traffic"
      | value | count | offset |
      | 4240  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-MX" with Label "Max"
      | value | count | offset |
      | 4600  | 1     | 1      |
    Then UI Validate Line Chart data "DNS-MX" with Label "Min"
      | value | count | offset |
      | 4600  | 1     | 1      |

  @SID_12
  Scenario: DNS baseline DNS-MX IPv6 In QPS data
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-MX,IPv6"
    Then Sleep "5"
    Then UI Validate Line Chart data "DNS-MX" with Label "Suspected Edge"
      | value | count | offset |
      | 3806  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-MX" with Label "Normal Edge"
      | value | count | offset |
      | 3650  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-MX" with Label "Attack Edge"
      | value | count | offset |
      | 4024  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-MX" with Label "Legitimate Traffic"
      | value | count | offset |
      | 120   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-MX" with Label "Total Traffic"
      | value | count | offset |
      | 130   | 13    | 6      |
  # END DNS MX

  @SID_13
  Scenario: DNS baseline DNS-NAPTR IPv4 In QPS data
    Then UI Validate Line Chart data "DNS-NAPTR" with Label "Suspected Edge"
      | value | count | offset |
      | 184   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-NAPTR" with Label "Normal Edge"
      | value | count | offset |
      | 260   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-NAPTR" with Label "Attack Edge"
      | value | count | offset |
      | 189   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-NAPTR" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4800  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-NAPTR" with Label "Total Traffic"
      | value | count | offset |
      | 4440  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-NAPTR" with Label "Max"
      | value | count | offset |
      | 4800  | 1     | 1      |
    Then UI Validate Line Chart data "DNS-NAPTR" with Label "Min"
      | value | count | offset |
      | 4800  | 1     | 1      |

  @SID_14
  Scenario: DNS baseline DNS-NAPTR IPv6 In QPS data
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-NAPTR,IPv6"
    Then Sleep "5"
    Then UI Validate Line Chart data "DNS-NAPTR" with Label "Suspected Edge"
      | value | count | offset |
      | 184   | 16    | 9      |
    Then UI Validate Line Chart data "DNS-NAPTR" with Label "Normal Edge"
      | value | count | offset |
      | 185   | 16    | 9      |
    Then UI Validate Line Chart data "DNS-NAPTR" with Label "Attack Edge"
      | value | count | offset |
      | 189   | 16    | 9      |
    Then UI Validate Line Chart data "DNS-NAPTR" with Label "Legitimate Traffic"
      | value | count | offset |
      | 220   | 16    | 9      |
    Then UI Validate Line Chart data "DNS-NAPTR" with Label "Total Traffic"
      | value | count | offset |
      | 240   | 16    | 9      |
  # END DNS NAPTR

  @SID_15
  Scenario: DNS baseline DNS-PTR IPv4 In QPS data
    And UI Validate Line Chart data "DNS-PTR" with Label "Suspected Edge"
      | value | count | offset |
      | 3806  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-PTR" with Label "Normal Edge"
      | value | count | offset |
      | 3600  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-PTR" with Label "Attack Edge"
      | value | count | offset |
      | 4024  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-PTR" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4640  | 13    | 6      |
    And UI Validate Line Chart data "DNS-PTR" with Label "Total Traffic"
      | value | count | offset |
      | 4280  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-PTR" with Label "Max"
      | value | count | offset |
      | 4640  | 1     | 1      |
    Then UI Validate Line Chart data "DNS-PTR" with Label "Min"
      | value | count | offset |
      | 4640  | 1     | 1      |

  @SID_16
  Scenario: DNS baseline DNS-PTR IPv6 In QPS data
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-PTR,IPv6"
    Then Sleep "5"
    Then UI Validate Line Chart data "DNS-PTR" with Label "Suspected Edge"
      | value | count | offset |
      | 3806  | 16    | 9      |
    Then UI Validate Line Chart data "DNS-PTR" with Label "Normal Edge"
      | value | count | offset |
      | 3600  | 16    | 9      |
    Then UI Validate Line Chart data "DNS-PTR" with Label "Attack Edge"
      | value | count | offset |
      | 4024  | 16    | 9      |
    Then UI Validate Line Chart data "DNS-PTR" with Label "Legitimate Traffic"
      | value | count | offset |
      | 140   | 16    | 9      |
    Then UI Validate Line Chart data "DNS-PTR" with Label "Total Traffic"
      | value | count | offset |
      | 150   | 16    | 9      |
  # END DNS PTR

  @SID_17
  Scenario: DNS baseline DNS-SOA IPv4 In QPS data
    Then UI Validate Line Chart data "DNS-SOA" with Label "Suspected Edge"
      | value | count | offset |
      | 184   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-SOA" with Label "Normal Edge"
      | value | count | offset |
      | 250   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-SOA" with Label "Attack Edge"
      | value | count | offset |
      | 189   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-SOA" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4760  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-SOA" with Label "Total Traffic"
      | value | count | offset |
      | 4400  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-SOA" with Label "Max"
      | value | count | offset |
      | 4760  | 1     | 1      |
    Then UI Validate Line Chart data "DNS-SOA" with Label "Min"
      | value | count | offset |
      | 4760  | 1     | 1      |

  @SID_18
  Scenario: DNS baseline DNS-SOA IPv6 In QPS data
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-SOA,IPv6"
    Then Sleep "5"
    Then UI Validate Line Chart data "DNS-SOA" with Label "Suspected Edge"
      | value | count | offset |
      | 184   | 17    | 9      |
    Then UI Validate Line Chart data "DNS-SOA" with Label "Normal Edge"
      | value | count | offset |
      | 180   | 17    | 9      |
    Then UI Validate Line Chart data "DNS-SOA" with Label "Attack Edge"
      | value | count | offset |
      | 189   | 17    | 9      |
    Then UI Validate Line Chart data "DNS-SOA" with Label "Legitimate Traffic"
      | value | count | offset |
      | 200   | 17    | 9      |
    Then UI Validate Line Chart data "DNS-SOA" with Label "Total Traffic"
      | value | count | offset |
      | 220   | 17    | 9      |
  # END DNS SOA

  @SID_19
  Scenario: DNS baseline DNS-SRV IPv4 In QPS data
    Then UI Validate Line Chart data "DNS-SRV" with Label "Suspected Edge"
      | value | count | offset |
      | 184   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-SRV" with Label "Normal Edge"
      | value | count | offset |
      | 270   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-SRV" with Label "Attack Edge"
      | value | count | offset |
      | 189   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-SRV" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4840  | 13    | 6      |
    And UI Validate Line Chart data "DNS-SRV" with Label "Total Traffic"
      | value | count | offset |
      | 4480  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-SRV" with Label "Max"
      | value | count | offset |
      | 4840  | 1     | 1      |
    Then UI Validate Line Chart data "DNS-SRV" with Label "Min"
      | value | count | offset |
      | 4840  | 1     | 1      |

  @SID_20
  Scenario: DNS baseline DNS-SRV IPv6 In QPS data
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-SRV,IPv6"
    Then Sleep "5"
    Then UI Validate Line Chart data "DNS-SRV" with Label "Suspected Edge"
      | value | count | offset |
      | 184   | 13    | 10     |
    Then UI Validate Line Chart data "DNS-SRV" with Label "Normal Edge"
      | value | count | offset |
      | 190   | 13    | 10     |
    Then UI Validate Line Chart data "DNS-SRV" with Label "Attack Edge"
      | value | count | offset |
      | 189   | 13    | 10     |
    Then UI Validate Line Chart data "DNS-SRV" with Label "Legitimate Traffic"
      | value | count | offset |
      | 240   | 13    | 10     |
    And UI Validate Line Chart data "DNS-SRV" with Label "Total Traffic"
      | value | count | offset |
      | 260   | 13    | 10     |
  # END DNS SRV

  @SID_21
  Scenario: DNS baseline Filter
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | SetId            | ports | policies       |
      | DefensePro_Set_1 |       | policy_1,pol_1 |
    Then UI Remove Session Storage "DNS-A"
    Then Sleep "35"
    Then UI Validate Session Storage "DNS-A" exists "false"
    And UI Open "Configurations" Tab
    And UI Logout

  @SID_22
  Scenario: DNS baseline RBAC data
    Given UI Login with user "sec_admin_allDPs_pol_1_policy" and password "radware"
    Then UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then Sleep "1"
    Then UI Click Button "Behavioral Tab" with value "DNS Flood"
    When UI Do Operation "Select" item "Global Time Filter"
    Then Sleep "1"
    When UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | SetId            | ports | policies |
      | DefensePro_Set_1 |       | pol_1    |
    Then Sleep "5"
    Then UI Validate Line Chart data "DNS-TXT" with Label "Suspected Edge"
      | value | count | offset |
      | 739   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-TXT" with Label "Normal Edge"
      | value | count | offset |
      | 720   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-TXT" with Label "Attack Edge"
      | value | count | offset |
      | 758   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-TXT" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4720  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-TXT" with Label "Total Traffic"
      | value | count | offset |
      | 4360  | 13    | 6      |
    Then UI logout and close browser

  @SID_23
  Scenario: DNS baseline RBAC negative
    Given UI Login with user "sec_admin_DP50_policy1" and password "radware"
    When UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    When Sleep "1"
    When UI Click Button "Behavioral Tab" with value "DNS Flood"
    When UI Do Operation "Select" item "Device Selection"
    When UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_1 |       | policy1  |
    * UI Open "Configurations" Tab
    Then UI logout and close browser

  @SID_24
  Scenario: DNS baselines clear all widgets
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then Sleep "1"
    Then UI Click Button "Behavioral Tab" with value "DNS Flood"
    When UI Do Operation "Select" item "Global Time Filter"
    Then Sleep "1"
    When UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_1 |       | pol_1    |
    Then UI VRM Clear All Widgets

  @SID_25
  Scenario: DNS baselines use duplicate widgets
    Then UI VRM Select Widgets
      | DNS-A |
    Then UI VRM Select Widgets
      | DNS-A |
    And UI Do Operation "Select" item "Behavioral Chart" with value "DNS-A-1,IPv6"
    Then UI Validate Line Chart data "DNS-A-2" with Label "Suspected Edge"
      | value | count | offset |
      | 7253  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-A-2" with Label "Normal Edge"
      | value | count | offset |
      | 6750  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-A-2" with Label "Attack Edge"
      | value | count | offset |
      | 7794  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-A-2" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4560  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-A-2" with Label "Total Traffic"
      | value | count | offset |
      | 4200  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-A-1" with Label "Suspected Edge"
      | value | count | offset |
      | 7253  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-A-1" with Label "Normal Edge"
      | value | count | offset |
      | 6750  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-A-1" with Label "Attack Edge"
      | value | count | offset |
      | 7794  | 13    | 6      |
    Then UI Validate Line Chart data "DNS-A-1" with Label "Legitimate Traffic"
      | value | count | offset |
      | 100   | 13    | 6      |
    Then UI Validate Line Chart data "DNS-A-1" with Label "Total Traffic"
      | value | count | offset |
      | 110   | 13    | 6      |
    Then UI logout and close browser

  @SID_26
  Scenario: DNS baselines check logs
    Then CLI kill all simulator attacks on current vision
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal        | NOT_EXPECTED |
