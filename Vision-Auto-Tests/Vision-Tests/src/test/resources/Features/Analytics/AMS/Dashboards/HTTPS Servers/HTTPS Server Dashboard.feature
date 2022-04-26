@TC107643
Feature: HTTPS Server Dashboard


  @SID_1
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    Given CLI Reset radware password
    * REST Delete ES index "dp-*"


  @SID_2
  Scenario: Update Policies
    Given REST Login with user "radware" and password "radware"
    Then REST Update Policies for All DPs


  @SID_3
  Scenario:Login and Navigate to Behavioral Protections Dashboard
    Given UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage


  @SID_4
  Scenario: Validate Default View
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label          | param        | value |
      | Behavioral Tab | BDoS         | true  |
      | Behavioral Tab | DNS Flood    | false |
      | Behavioral Tab | Quantile DoS | false |
      | Behavioral Tab | HTTPS Flood  | false |
    Then UI Validate Element Existence By Label "Device Selection" if Exists "true"
    Then UI Validate Text field "Device Selection" CONTAINS "DEVICES"
    Then UI Validate Element Existence By Label "Widget Selection" if Exists "true"
    Then UI Validate Element Existence By Label "Max Min" if Exists "true"


  @SID_5
  Scenario: Move to HTTPS Flood and Validate Default View
    When UI Click Button "Behavioral Tab" with value "HTTPS Flood"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label          | param        | value |
      | Behavioral Tab | BDoS         | false |
      | Behavioral Tab | DNS Flood    | false |
      | Behavioral Tab | Quantile DoS | false |
      | Behavioral Tab | HTTPS Flood  | true  |
    Then UI Validate Element Existence By Label "Servers Button" if Exists "true"
    Then UI Validate Text field "Servers Button" EQUALS "SERVERS"
    Then UI Validate Element Existence By Label "Widget Selection" if Exists "false"
    Then UI Validate Element Existence By Label "Max Min" if Exists "true"
    Then UI Validate Text field "header HTTPS" EQUALS "DefensePro Behavioral Protections"


  @SID_6
  Scenario Outline: Validate Widgets

    Then UI Validate Element Existence By Label "Chart" if Exists "<isExist>" with value "<widget>"

    Examples:
      | widget                           | isExist |
      | Inbound Traffic                  | true    |
      | Quantile Status                  | false   |
      | DNS-A                            | false   |
      | DNS-AAAA                         | false   |
      | DNS-MX                           | false   |
      | DNS-TXT                          | false   |
      | DNS-SOA                          | false   |
      | DNS-SRV                          | false   |
      | DNS-PTR                          | false   |
      | DNS-NAPTR                        | false   |
      | DNS-Other                        | false   |
      | BDoS-UDP                         | false   |
      | BDoS-Advanced-UDP Rate-Invariant | false   |
      | BDoS-TCP SYN                     | false   |
      | BDoS-TCP SYN ACK                 | false   |
      | BDoS-TCP RST                     | false   |
      | BDoS-TCP FIN ACK                 | false   |
      | BDoS-TCP Fragmented              | false   |
      | BDoS-UDP Fragmented              | false   |
      | BDoS-ICMP                        | false   |
      | BDoS-IGMP                        | false   |
      | Excluded UDP Traffic             | false   |


  @SID_7
  Scenario: Add Policy
    Given Rest Add Policy "pol1" To DP "172.16.22.51" if Not Exist
    And Rest Add new Rule "https_servers_automation" in Profile "ProfileHttpsflood" to Policy "pol1" to DP "172.16.22.51"


  @SID_8
  Scenario: Run DP simulator PCAPs for "HTTPS attacks"
  Given CLI simulate 2 attacks of type "HTTPS" on SetId "DefensePro_Set_2" with loopDelay 5000 and wait 60 seconds

  @SID_9
  Scenario: Select Server
    When UI Select Server and save
      | name | device                  | policy |
      | test | DefensePro_172.16.22.51 | pol1   |
    * Sleep "60"

      ##Https Flood - Info Card

  @SID_10
  Scenario: Validate title tool bar
    Then UI Validate Text field "header HTTPS" EQUALS "DefensePro Behavioral Protections"
    Then UI Validate Text field "Selected Server" CONTAINS "Server Name"
    Then UI Validate Text field "Selected Server" CONTAINS "test"
    Then UI Validate Text field "Selected Device" CONTAINS "Device Name:"
    Then UI Validate Text field "Selected Device" CONTAINS "DefensePro_172.16.22.51"
    Then UI Validate Text field "Selected Policy" CONTAINS "Policy Name:"
    Then UI Validate Text field "Selected Policy" CONTAINS "pol1"

  ##https flood -  request size distribution

  @SID_11
  Scenario: Validate Https Flood distributed size graph data - Baseline
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Baseline"
      | value       | count | index | offset |
      | 0           | 47    | 0     | 0      |
      | 0.97232455  | 1     | 1     | 0      |
      | 0.77        | 1     | 2     | 0      |
      | 0.027675444 | 1     | 4     | 0      |

  @SID_12
  Scenario: Validate Https Flood distributed size graph style - Baseline
    Then UI Validate Line Chart attributes "Request-Size Distribution" with Label "Baseline"
      | attribute                 | value   |
      | pointRadius               | 0       |
      | fill                      | true    |
      | lineTension               | 0.35    |
      | borderCapStyle            | butt    |
      | borderDashOffset          | 0       |
      | borderJoinStyle           | miter   |
      | borderWidth               | 1       |
      | pointHoverRadius          | 4       |
      | pointHoverBorderWidth     | 1       |
      | backgroundColor           | #006e8a |
      | pointHoverBackgroundColor | #006e8a |
      | color                     | #006e8a |

  @SID_13
  Scenario: Validate Https Flood distributed size graph data - Real Time Traffic
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Real-Time Traffic"
      | value      | count | index | offset |
      | 0          | 46    | 0     | 0      |
      | 0.23451911 | 1     | 1     | 0      |
      | 0.214519   | 1     | 2     | 0      |
      | 0.81       | 1     | 4     | 0      |
      | 0.5        | 1     | 49    | 0      |

  @SID_14
  Scenario: Validate Https Flood distributed size graph style - Real Time Traffic
    Then UI Validate Line Chart attributes "Request-Size Distribution" with Label "Real-Time Traffic"
      | attribute                 | value   |
      | pointRadius               | 0       |
      | fill                      | false   |
      | lineTension               | 0.35    |
      | borderCapStyle            | butt    |
      | borderDashOffset          | 0       |
      | borderJoinStyle           | miter   |
      | borderWidth               | 2       |
      | pointHoverRadius          | 0       |
      | pointHoverBorderWidth     | 0       |
      | backgroundColor           | #3f3f3f |
      | pointHoverBackgroundColor | #3f3f3f |
      | color                     | #3f3f3f |
      | type                      | line    |
      | borderColor               | #3f3f3f |
      | pointHitRadius            | 0       |

  @SID_15
  Scenario: Validate Https Flood distributed size graph data - Attack Edge
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Attack Edge"
      | value      | count | index | offset |
      | 0          | 48    | 0     | 0      |
      | 1          | 1     | 1     | 0      |
      | 0.47802296 | 1     | 4     | 0      |

  @SID_16
  Scenario: Validate Https Flood distributed size graph style - Attack Edge
    Then UI Validate Line Chart attributes "Request-Size Distribution" with Label "Attack Edge"
      | attribute                 | value   |
      | pointRadius               | 0       |
      | fill                      | true    |
      | lineTension               | 0.35    |
      | borderCapStyle            | butt    |
      | borderDashOffset          | 0       |
      | borderJoinStyle           | miter   |
      | borderWidth               | 1       |
      | pointHoverRadius          | 4       |
      | pointHoverBorderWidth     | 1       |
      | backgroundColor           | #ffc107 |
      | pointHoverBackgroundColor | #ffc107 |
      | color                     | #ffc107 |
      | pointHitRadius            | 0       |
      | borderDash                | []      |

  @SID_17
  Scenario: Validate Https Flood distributed size graph data - Under Attack
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Under Attack"
      | value      | count | index | offset |
      | 0          | 46    | 0     | 0      |
      | 0.23451911 | 1     | 1     | 0      |
      | 0.214519   | 1     | 2     | 0      |
      | 0.81       | 1     | 4     | 0      |
      | 0.5        | 1     | 49    | 0      |

  @SID_18
  Scenario: Validate Https Flood distributed size graph style - Under Attack
    Then UI Validate Line Chart attributes "Request-Size Distribution" with Label "Under Attack"
      | attribute                 | value   |
      | pointRadius               | 0       |
      | fill                      | true    |
      | lineTension               | 0.35    |
      | borderCapStyle            | butt    |
      | borderDashOffset          | 0       |
      | borderJoinStyle           | miter   |
      | borderWidth               | 1       |
      | pointHoverRadius          | 4       |
      | pointHoverBorderWidth     | 1       |
      | backgroundColor           | #f41414 |
      | pointHoverBackgroundColor | #f41414 |
      | color                     | #f41414 |
      | pointHitRadius            | 0       |
      | borderDash                | []      |

# Inbound Request per second test
  ##https flood -  HTTPS baselines

  @SID_19
  Scenario: Validate Https Flood baseline graph Transitory Baseline data
    Then UI Validate Line Chart data "Requests per Second" with Label "Transitory Baseline"
      | value | count | offset |
      | 17200 | 60    | 5      |

  @SID_20
  Scenario: Validate Https Flood baseline graph Transitory Attack Edge data
    Then UI Validate Line Chart data "Requests per Second" with Label "Transitory Attack Edge"
      | value | count | offset |
      | 21641 | 60    | 5      |

  @SID_21
  Scenario: Validate Https Flood baseline graph Total Traffic data
    Then UI Validate Line Chart data "Requests per Second" with Label "Total Traffic"
      | value   | count | offset |
      | 25060.0 | 2     | 1      |

  @SID_22
  Scenario: Validate Https Flood baseline graph Long Trend Baseline data
    Then UI Validate Line Chart data "Requests per Second" with Label "Long-Term Trend Baseline"
      | value | count | offset |
      | 5075  | 59    | 2      |

  @SID_23
  Scenario: Validate Https Flood baseline graph Long Trend Attack Edge data
    Then UI Validate Line Chart data "Requests per Second" with Label "Long-Term Trend Attack Edge"
      | value | count | offset |
      | 7002  | 60    | 2      |

  @SID_24
  Scenario: Validate Https Flood baseline graph Legitimate Traffic data
    Then UI Validate Line Chart data "Requests per Second" with Label "Legitimate Traffic"
      | value   | count | offset |
      | 17500.0 | 2     | 1      |

  @SID_25
  Scenario: Validate Https Flood baseline graph Transitory Baseline styling
    Then UI Validate Line Chart attributes "Requests per Second" with Label "Transitory Baseline"
      | attribute             | value   |
      | backgroundColor       | #04c2a0 |
      | steppedLine           | true    |
      | pointHoverBorderWidth | 1       |
      | borderColor           | #04c2a0 |
      | pointHitRadius        | 10      |
      | pointRadius           | 0       |
      | pointHoverRadius      | 4       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | borderDashOffset      | 0       |
      | borderCapStyle        | butt    |
      | lineTension           | 0.35    |
      | fill                  | false   |

  @SID_26
  Scenario: Validate Https Flood baseline graph Transitory Attack Edge styling
    Then UI Validate Line Chart attributes "Requests per Second" with Label "Transitory Attack Edge"
      | attribute             | value   |
      | backgroundColor       | #aa0a13 |
      | steppedLine           | true    |
      | pointHoverBorderWidth | 1       |
      | borderColor           | #aa0a13 |
      | pointHitRadius        | 10      |
      | pointRadius           | 0       |
      | pointHoverRadius      | 4       |
      | borderJoinStyle       | miter   |
      | borderDashOffset      | 0       |
      | borderWidth           | 2.5     |
      | borderCapStyle        | butt    |
      | lineTension           | 0.35    |
      | fill                  | false   |

  @SID_27
  Scenario: Validate Https Flood baseline graph Total Traffic styling
    Then UI Validate Line Chart attributes "Requests per Second" with Label "Total Traffic"
      | attribute             | value   |
      | backgroundColor       | #9aeeea |
      | pointHoverBorderWidth | 1       |
      | borderColor           | #088eb1 |
      | pointHitRadius        | 10      |
      | pointRadius           | 0       |
      | pointHoverRadius      | 4       |
      | borderJoinStyle       | miter   |
      | borderDashOffset      | 0       |
      | borderWidth           | 1       |
      | borderCapStyle        | butt    |
      | lineTension           | 0.35    |
      | fill                  | true    |
      | borderColor           | #088eb1 |
      | color                 | #9aeeea |

  @SID_28
  Scenario: Validate Https Flood baseline graph Long Trend Baseline styling
    Then UI Validate Line Chart attributes "Requests per Second" with Label "Long-Term Trend Baseline"
      | attribute             | value   |
      | backgroundColor       | #0a7474 |
      | steppedLine           | true    |
      | pointHoverBorderWidth | 1       |
      | borderColor           | #0a7474 |
      | pointHitRadius        | 10      |
      | pointRadius           | 0       |
      | pointHoverRadius      | 4       |
      | borderJoinStyle       | miter   |
      | borderDashOffset      | 0       |
      | borderWidth           | 2.5     |
      | borderCapStyle        | butt    |
      | lineTension           | 0.35    |
      | fill                  | false   |

  @SID_29
  Scenario: Validate Https Flood baseline graph Long Trend Attack Edge styling
    Then UI Validate Line Chart attributes "Requests per Second" with Label "Long-Term Trend Attack Edge"
      | attribute             | value   |
      | backgroundColor       | #FF4441 |
      | steppedLine           | true    |
      | pointHoverBorderWidth | 1       |
      | borderColor           | #ff4441 |
      | pointHitRadius        | 10      |
      | pointRadius           | 0       |
      | pointHoverRadius      | 4       |
      | borderJoinStyle       | miter   |
      | borderDashOffset      | 0       |
      | borderWidth           | 2.5     |
      | borderCapStyle        | butt    |
      | lineTension           | 0.35    |
      | fill                  | false   |

  @SID_30
  Scenario: Validate Https Flood baseline graph Legitimate Traffic styling
    Then UI Validate Line Chart attributes "Requests per Second" with Label "Legitimate Traffic"
      | attribute             | value   |
      | backgroundColor       | #9ec3cb |
      | pointHoverBorderWidth | 1       |
      | borderColor           | #4388c8 |
      | pointHitRadius        | 10      |
      | pointRadius           | 0       |
      | pointHoverRadius      | 4       |
      | borderJoinStyle       | miter   |
      | borderDashOffset      | 0       |
      | borderWidth           | 1       |
      | borderCapStyle        | butt    |
      | lineTension           | 0.35    |
      | fill                  | true    |
      | color                 | #9ec3cb |

# verify 1. refresh occurred 2. new data displayed

  @SID_31
  Scenario: Run DP simulator PCAPs for Https Flood - Make Change
    Given CLI simulate 2 attacks of type "HTTPS-Twist" on SetId "DefensePro_Set_2" with loopDelay 5000 and wait 180 seconds


  @SID_32
  Scenario: Re-Select Server
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    When UI Click Button "Behavioral Tab" with value "HTTPS Flood"
    When UI Click Button "Servers Button"
    When UI Set Text Field "Server Selection.Search" To "test"
    Then UI Click Button "Server Selection.Server Name" with value "test,DefensePro_172.16.22.51,pol1"
    Then UI Click Button "Server Selection.Save"


  @SID_33
  Scenario: Validate Https Flood distributed size graph data - Real Time Traffic - After Change
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Real-Time Traffic"
      | value      | count | index | offset |
      | 0          | 46    | 0     | 0      |
      | 0.23451911 | 1     | 1     | 0      |
      | 0.214519   | 1     | 2     | 0      |
      | 0.81       | 1     | 4     | 0      |
      | 0.5        | 1     | 49    | 0      |


  @SID_34
  Scenario: Validate Https Flood distributed size graph data - Attack Edge - After Change
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Attack Edge"
      | value      | count | index | valueOffset |
      | 0          | 48    | 0     | 0           |
      | 0.47802296 | 1     | 4     | 1           |
      | 1          | 1     | 1     | 0           |

  @SID_35
  Scenario: Validate Https Flood distributed size graph data - Under Attack - After Change
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Under Attack"
      | value      | count | index | offset |
      | 0          | 46    | 0     | 0      |
      | 0.23451911 | 1     | 1     | 0      |
      | 0.214519   | 1     | 2     | 0      |
      | 0.81       | 1     | 4     | 0      |
      | 0.5        | 1     | 49    | 0      |


###################### Min\Max Analytics ###########################################

  @SID_36
  Scenario: Check Min - Max Traffic
    Then UI Validate Element Existence By Label "Max Traffic" if Exists "false"
    Then UI Validate Element Existence By Label "Min Traffic" if Exists "false"
    Then UI Do Operation "Select" item "Max Min"
    Then UI Validate Text field "Max Traffic" EQUALS "17.5 K"
    Then UI Validate Text field "Min Traffic" EQUALS "17.5 K"
    Then UI Validate Element Existence By Label "Max Traffic" if Exists "true"
    Then UI Validate Element Existence By Label "Min Traffic" if Exists "true"


  @SID_37
  Scenario: Logout
    Then UI logout and close browser
