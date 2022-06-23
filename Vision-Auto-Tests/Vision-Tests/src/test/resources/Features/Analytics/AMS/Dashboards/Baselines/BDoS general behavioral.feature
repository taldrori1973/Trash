@TC124918
Feature: BDoS General Behavioral Tests

  # to ask about scenario "increase inactivity timeout to maximum"

  @SID_1
  Scenario: BDoS baseline pre-requisite
    Given CLI kill all simulator attacks on current vision
    Given CLI Clear vision logs
#    Given REST Delete ES index "dp-bdos-baseline*"
#    Given REST Delete ES index "dp-baseline*"
    Given CLI simulate 1 attacks of type "baselines_pol_1" on SetId "DefensePro_Set_1" with loopDelay 15000 and wait 2 seconds


  @SID_2
  Scenario: Login into VRM and select device in DefensePro Behavioral Protections Dashboard
    Given UI Login with user "radware" and password "radware"
#    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then Sleep "1"
    And UI Do Operation "Select" item "Global Time Filter"
    Then Sleep "1"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | setId            | ports | policies |
      | DefensePro_Set_1 |       | pol_1    |


  @SID_3
  Scenario: min max default unselected
    Then UI Validate Switch button "Max Min" with params "" isSelected "false"



     # to continue  ************



    # By default only "BDoS" tab will be selected
  @SID_4
  Scenario: validate that BDoS is the default button clicked
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label          | param        | value |
      | Behavioral Tab | BDoS         | true  |
      | Behavioral Tab | DNS Flood    | false |
      | Behavioral Tab | Quantile DoS | false |
      | Behavioral Tab | HTTPS Flood  | false |
    Then UI Click Button "Widget Selection"

#  @SID_5
#  Scenario: validate that min/max is the default button clicked
#    Then UI Click Button "Max Min"
#    Then UI Validate the attribute of "checked " are "CONTAINS" to
#      | label   | value |
#      | Max Min | false |


  @SID_6
  Scenario Outline: Validate repository item exists
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "true" with value "<ChartName>"
    Examples:
      | ChartName                        |
      | BDoS-UDP                         |
      | BDoS-Advanced-UDP_Rate-Invariant |
      | BDoS-TCP_SYN                     |
      | BDoS-TCP_SYN_ACK                 |
      | BDoS-TCP_RST                     |
      | BDoS-TCP_FIN_ACK                 |
      | BDoS-TCP_Fragmented              |
      | BDoS-UDP_Fragmented              |
      | BDoS-ICMP                        |
      | BDoS-IGMP                        |
      | Excluded_UDP_Traffic             |

  @SID_7
  Scenario Outline: Validate repository item Not exists
    Then UI Validate Element Existence By Label "Repository Widget" if Exists "false" with value "<ChartName>"
    Examples:
      | ChartName       |
      | DNS-A           |
      | DNS-AAAA        |
      | DNS-MX          |
      | DNS-TXT         |
      | DNS-SOA         |
      | DNS-SRV         |
      | DNS-PTR         |
      | DNS-NAPTR       |
      | DNS-Other       |
      | Quantile_Status |


  @SID_8
  Scenario: close the repository widgets and then clear all
    When UI Click Button "Widget Selection"
    Then UI VRM Clear All Widgets

  @SID_9
  Scenario Outline: Validate chart existance false
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "<ChartName>"
    Examples:
      | ChartName                        |
      | BDoS-UDP                         |
      | BDoS-Advanced-UDP Rate-Invariant |
      | BDoS-TCP SYN                     |
      | BDoS-TCP SYN ACK                 |
      | BDoS-TCP RST                     |
      | BDoS-TCP FIN ACK                 |
      | BDoS-TCP Fragmented              |
      | BDoS-UDP Fragmented              |
      | BDoS-ICMP                        |
      | BDoS-IGMP                        |
      | Excluded UDP Traffic             |


  @SID_10
  Scenario: add all BDoS widgets
    Then UI VRM Select Widgets
      | BDoS-UDP                         |
      | BDoS-Advanced-UDP Rate-Invariant |
      | BDoS-TCP SYN                     |
      | BDoS-TCP SYN ACK                 |
      | BDoS-TCP RST                     |
      | BDoS-TCP FIN ACK                 |
      | BDoS-TCP Fragmented              |
      | BDoS-UDP Fragmented              |
      | BDoS-ICMP                        |
      | BDoS-IGMP                        |
      | Excluded UDP Traffic             |

  @SID_11
  Scenario Outline: Validate chart existance true
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "<ChartName>"
    Examples:
      | ChartName                          |
      | BDoS-UDP-1                         |
      | BDoS-Advanced-UDP Rate-Invariant-1 |
      | BDoS-TCP SYN-1                     |
      | BDoS-TCP SYN ACK-1                 |
      | BDoS-TCP RST-1                     |
      | BDoS-TCP FIN ACK-1                 |
      | BDoS-TCP Fragmented-1              |
      | BDoS-UDP Fragmented-1              |
      | BDoS-ICMP-1                        |
      | BDoS-IGMP-1                        |
      | Excluded UDP Traffic-1             |

  

# ****************************************************************************************************
# screen configuration saved when switching between tabs
  @SID_12
  Scenario Outline:: remove first  4 widgets
    Then UI Click Button "Widget remove" with value "<ChartName>"
    Examples:
      | ChartName                          |
      | BDoS-UDP-1                         |
      | BDoS-Advanced-UDP Rate-Invariant-1 |
      | BDoS-TCP SYN-1                     |
      | BDoS-TCP SYN ACK-1                 |

  @SID_13
  Scenario: switch tab
    When UI Click Button "Behavioral Tab" with value "DNS Flood"
    Then Sleep "2"
    Then UI Click Button "Behavioral Tab" with value "BDoS"

  @SID_14
  Scenario Outline: Validate deleted charts still not exist after switching tabs
    Then UI Validate Element Existence By Label "Chart" if Exists "false" with value "<ChartName>"
    Examples:
      | ChartName                          |
      | BDoS-UDP-1                         |
      | BDoS-Advanced-UDP Rate-Invariant-1 |
      | BDoS-TCP SYN-1                     |
      | BDoS-TCP SYN ACK-1                 |

  @SID_15
  Scenario Outline: Validate chart existance
    Then UI Validate Element Existence By Label "Chart" if Exists "true" with value "<ChartName>"
    Examples:
      | ChartName              |
      | BDoS-TCP RST-1         |
      | BDoS-TCP FIN ACK-1     |
      | BDoS-TCP Fragmented-1  |
      | BDoS-UDP Fragmented-1  |
      | BDoS-ICMP-1            |
      | BDoS-IGMP-1            |
      | Excluded UDP Traffic-1 |

  @SID_16
  Scenario: navigate between Dashboards
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And Sleep "3"
    And UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage

  @SID_17
  Scenario Outline: switch buttons for the first 4 charts
    Then UI Do Operation "Select" item "Behavioral Chart" with value "<ChartName>"
    Examples:
      | ChartName                                 |
      | BDoS-UDP,IPv6                             |
      | BDoS-UDP,pps                              |
      | BDoS-UDP,Outbound                         |

      | BDoS-Advanced-UDP Rate-Invariant,IPv6     |
      | BDoS-Advanced-UDP Rate-Invariant,Outbound |

      | BDoS-TCP SYN,IPv6                         |
      | BDoS-TCP SYN,pps                          |
      | BDoS-TCP SYN,Outbound                     |

      | BDoS-TCP SYN ACK,IPv6                     |
      | BDoS-TCP SYN ACK,pps                      |
      | BDoS-TCP SYN ACK,Outbound                 |

  @SID_18
  Scenario Outline:Scope selection need to be kept between tabs
    Then Sleep "1"
    Then UI Click Button "Behavioral Tab" with value "<ChartName>"
    Examples:
      | ChartName    |
      | DNS Flood    |
      | Quantile DoS |
      | BDoS         |

  @SID_19
  Scenario: validate switch buttons still save the last changing
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label            | param                                     | value |
      | Behavioral Chart | BDoS-UDP,IPv4                             | true  |
      | Behavioral Chart | BDoS-UDP,bps                              | true  |
      | Behavioral Chart | BDoS-UDP,Inbound                         | true  |

      | Behavioral Chart | BDoS-Advanced-UDP Rate-Invariant,IPv4     | true  |
      | Behavioral Chart | BDoS-Advanced-UDP Rate-Invariant,Inbound | true  |

      | Behavioral Chart | BDoS-TCP SYN,IPv4                         | true  |
      | Behavioral Chart | BDoS-TCP SYN,bps                          | true  |
      | Behavioral Chart | BDoS-TCP SYN,Inbound                     | true  |

      | Behavioral Chart | BDoS-TCP SYN ACK,IPv4                     | true  |
      | Behavioral Chart | BDoS-TCP SYN ACK,bps                      | true  |
      | Behavioral Chart | BDoS-TCP SYN ACK,Inbound                 | true  |



# *************************************************************
# Scope selection need to be kept between tabs

#  @SID_20
#  Scenario: switch tab
#    When UI Click Button "Behavioral Tab" with value "DNS"
#    Then Sleep "2"
#    Then UI Click Button "Behavioral Tab" with value "BDoS"

#   
#  @SID_21
#  Scenario: Scope selection need to be kept between tabs
#    Then UI "Validate" Scope Polices
#      | devices | type:DEVICES,SetId:DefensePro_Set_1,policies:[pol_1] |
#    Then UI Click Button "Behavioral Tab" with value "DNS"
#    Then UI "Validate" Scope Polices
#      | devices | type:DEVICES,SetId:DefensePro_Set_1,policies:[pol_1] |
#    Then Sleep "2"
#    Then UI Click Button "Behavioral Tab" with value "QDoS"
#    Then UI "Validate" Scope Polices
#      | devices | type:DEVICES,SetId:DefensePro_Set_1,policies:[pol_1] |
#    Then Sleep "2"
#    Then UI Click Button "Behavioral Tab" with value "BDoS"
#    Then UI "Validate" Scope Polices
#      | devices | type:DEVICES,SetId:DefensePro_Set_1,policies:[pol_1] |


  @SID_22
  Scenario Outline:Scope selection need to be saved between tabs
    Then UI Click Button "Behavioral Tab" with value "<ChartName>"
    Then UI "Validate" Scope Polices
      | devices | type:DEVICES,SetId:DefensePro_Set_1,policies:[pol_1] |
    Examples:
      | ChartName    |
      | DNS Flood    |
      | BDoS         |
      | Quantile DoS |

  @SID_23
  Scenario: kill all simulator attacks and logout
    Then UI logout and close browser
    Then CLI kill all simulator attacks on current vision