@VRM_BDoS_Baseline @TC105988
Feature: VRM DNS baselines

  @SID_1
  Scenario: DNS baseline pre-requisite
    Given CLI kill all simulator attacks on current vision
    Given CLI Clear vision logs
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
  #  Given REST Delete ES index "dp-dns*"
    #Given CLI simulate 100 attacks of type "dns_fuzzy_pol_1" on "DefensePro" 10 with loopDelay 60000
    #Given CLI simulate 100 attacks of type "DNS_baselines_pol_1" on "DefensePro" 10 with loopDelay 15000 and wait 120 seconds
    Given CLI simulate 200 attacks of type "baselines_pol_1" on "DefensePro" 10 with loopDelay 15000 and wait 140 seconds

  @SID_2
  Scenario: login and select device
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "  DefensePro Behavioral Protections Dashboard" page via homePage
    Then Sleep "1"
    And UI Do Operation "Select" item "Global Time Filter"
    Then Sleep "1"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | pol_1    |

  @SID_3
  Scenario: DNS baseline DNS-TXT IPv4 In QPS styling
    Then UI Validate Line Chart attributes "DNS-TXT" with Label "Suspected Edge"
      | attribute             | value   |
    # | borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ffa20d |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-TXT" with Label "Normal Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #8cba46 |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-TXT" with Label "Attack Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ff4c4c |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-TXT" with Label "Legitimate Traffic"
      | attribute             | value                   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                       |
      | fill                  | true                    |
      | lineTension           | 0.35                    |
      | borderCapStyle        | butt                    |
      | borderDashOffset      | 0                       |
      | borderJoinStyle       | miter                   |
      | borderWidth           | 1                       |
      | pointHoverRadius      | 4                       |
      | pointHoverBorderWidth | 1                       |
      | backgroundColor       | rgba(115, 134, 154, 0.1)|
      | borderColor           | rgba(115, 134, 154, 5)  |

    Then UI Validate Line Chart attributes "DNS-TXT" with Label "Total Traffic"
      | attribute             | value                    |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                        |
      | fill                  | true                     |
      | lineTension           | 0.35                     |
      | borderCapStyle        | butt                     |
      | borderDashOffset      | 0                        |
      | borderJoinStyle       | miter                    |
      | borderWidth           | 1                        |
      | pointHoverRadius      | 4                        |
      | pointHoverBorderWidth | 1                        |
      | backgroundColor       | rgba(141, 190, 214, 0.1) |
      | borderColor           | rgba(141, 190, 214, 5)   |

  @SID_4
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


  @SID_5
  Scenario: DNS baseline DNS-TXT IPv6 In QPS data
    And UI Do Operation "Select" item "DNS-TXT IPv6"
    # And UI Do Operation "Select" item "DNS-TXT Inbound"
    # And UI Do Operation "Select" item "DNS-TXT QPS"

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


  @SID_6
  Scenario: DNS baseline DNS-A IPv4 In QPS styling
    And UI Do Operation "Select" item "DNS-A IPv4"
    #And UI Do Operation "Select" item "DNS-A Inbound"
    #And UI Do Operation "Select" item "DNS-A QPS"
    Then UI Validate Line Chart attributes "DNS-A" with Label "Suspected Edge"
      | attribute             | value   |
    # | borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ffa20d |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-A" with Label "Normal Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #8cba46 |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-A" with Label "Attack Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ff4c4c |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-A" with Label "Legitimate Traffic"
      | attribute             | value                   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                       |
      | fill                  | true                    |
      | lineTension           | 0.35                    |
      | borderCapStyle        | butt                    |
      | borderDashOffset      | 0                       |
      | borderJoinStyle       | miter                   |
      | borderWidth           | 1                       |
      | pointHoverRadius      | 4                       |
      | pointHoverBorderWidth | 1                       |
      | backgroundColor       | rgba(115, 134, 154, 0.1)|
      | borderColor           | rgba(115, 134, 154, 5)  |

    Then UI Validate Line Chart attributes "DNS-A" with Label "Total Traffic"
      | attribute             | value                    |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                        |
      | fill                  | true                     |
      | lineTension           | 0.35                     |
      | borderCapStyle        | butt                     |
      | borderDashOffset      | 0                        |
      | borderJoinStyle       | miter                    |
      | borderWidth           | 1                        |
      | pointHoverRadius      | 4                        |
      | pointHoverBorderWidth | 1                        |
      | backgroundColor       | rgba(141, 190, 214, 0.1) |
      | borderColor           | rgba(141, 190, 214, 5)   |

  @SID_7
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

  @SID_8
  Scenario: BDoS baseline DNS-A IPv6 In QPS data
    And UI Do Operation "Select" item "DNS-A IPv6"
#    And UI Do Operation "Select" item "DNS-A Inbound"
#    And UI Do Operation "Select" item "DNS-A QPS"

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

  @SID_9
  Scenario: DNS baseline DNS-AAAA IPv4 In QPS styling
    And UI Do Operation "Select" item "DNS-AAAA IPv4"
#    And UI Do Operation "Select" item "DNS-AAAA Inbound"
#    And UI Do Operation "Select" item "DNS-AAAA QPS"
    Then UI Validate Line Chart attributes "DNS-AAAA" with Label "Suspected Edge"
      | attribute             | value   |
    # | borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ffa20d |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-AAAA" with Label "Normal Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #8cba46 |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-AAAA" with Label "Attack Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ff4c4c |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-AAAA" with Label "Legitimate Traffic"
      | attribute             | value                   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                       |
      | fill                  | true                    |
      | lineTension           | 0.35                    |
      | borderCapStyle        | butt                    |
      | borderDashOffset      | 0                       |
      | borderJoinStyle       | miter                   |
      | borderWidth           | 1                       |
      | pointHoverRadius      | 4                       |
      | pointHoverBorderWidth | 1                       |
      | backgroundColor       | rgba(115, 134, 154, 0.1)|
      | borderColor           | rgba(115, 134, 154, 5)  |

    Then UI Validate Line Chart attributes "DNS-AAAA" with Label "Total Traffic"
      | attribute             | value                    |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                        |
      | fill                  | true                     |
      | lineTension           | 0.35                     |
      | borderCapStyle        | butt                     |
      | borderDashOffset      | 0                        |
      | borderJoinStyle       | miter                    |
      | borderWidth           | 1                        |
      | pointHoverRadius      | 4                        |
      | pointHoverBorderWidth | 1                        |
      | backgroundColor       | rgba(141, 190, 214, 0.1) |
      | borderColor           | rgba(141, 190, 214, 5)   |

  @SID_10
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

  @SID_11
  Scenario: DNS baseline DNS-AAAA IPv6 In QPS data
    And UI Do Operation "Select" item "DNS-AAAA IPv6"
#    And UI Do Operation "Select" item "DNS-AAAA Inbound"
#    And UI Do Operation "Select" item "DNS-AAAA QPS"

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


  @SID_12
  Scenario: DNS baseline DNS-Other IPv4 In QPS styling
    And UI Do Operation "Select" item "DNS-Other IPv4"
#    And UI Do Operation "Select" item "DNS-Other Inbound"
#    And UI Do Operation "Select" item "DNS-Other QPS"
    Then UI Validate Line Chart attributes "DNS-Other" with Label "Suspected Edge"
      | attribute             | value   |
    # | borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ffa20d |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-Other" with Label "Normal Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #8cba46 |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-Other" with Label "Attack Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ff4c4c |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-Other" with Label "Legitimate Traffic"
      | attribute             | value                   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                       |
      | fill                  | true                    |
      | lineTension           | 0.35                    |
      | borderCapStyle        | butt                    |
      | borderDashOffset      | 0                       |
      | borderJoinStyle       | miter                   |
      | borderWidth           | 1                       |
      | pointHoverRadius      | 4                       |
      | pointHoverBorderWidth | 1                       |
      | backgroundColor       | rgba(115, 134, 154, 0.1)|
      | borderColor           | rgba(115, 134, 154, 5)  |

    Then UI Validate Line Chart attributes "DNS-Other" with Label "Total Traffic"
      | attribute             | value                    |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                        |
      | fill                  | true                     |
      | lineTension           | 0.35                     |
      | borderCapStyle        | butt                     |
      | borderDashOffset      | 0                        |
      | borderJoinStyle       | miter                    |
      | borderWidth           | 1                        |
      | pointHoverRadius      | 4                        |
      | pointHoverBorderWidth | 1                        |
      | backgroundColor       | rgba(141, 190, 214, 0.1) |
      | borderColor           | rgba(141, 190, 214, 5)   |

  @SID_13
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

  @SID_14
  Scenario: DNS baseline DNS-Other IPv6 In QPS data
    And UI Do Operation "Select" item "DNS-Other IPv6"
#    And UI Do Operation "Select" item "DNS-Other Inbound"
#    And UI Do Operation "Select" item "DNS-Other QPS"

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


  @SID_15
  Scenario: DNS baseline DNS-MX IPv4 In QPS styling
    And UI Do Operation "Select" item "DNS-MX IPv4"
#    And UI Do Operation "Select" item "DNS-MX Inbound"
#    And UI Do Operation "Select" item "DNS-MX QPS"
    Then UI Validate Line Chart attributes "DNS-MX" with Label "Suspected Edge"
      | attribute             | value   |
    # | borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ffa20d |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-MX" with Label "Normal Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #8cba46 |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-MX" with Label "Attack Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ff4c4c |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-MX" with Label "Legitimate Traffic"
      | attribute             | value                   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                       |
      | fill                  | true                    |
      | lineTension           | 0.35                    |
      | borderCapStyle        | butt                    |
      | borderDashOffset      | 0                       |
      | borderJoinStyle       | miter                   |
      | borderWidth           | 1                       |
      | pointHoverRadius      | 4                       |
      | pointHoverBorderWidth | 1                       |
      | backgroundColor       | rgba(115, 134, 154, 0.1)|
      | borderColor           | rgba(115, 134, 154, 5)  |

    Then UI Validate Line Chart attributes "DNS-MX" with Label "Total Traffic"
      | attribute             | value                    |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                        |
      | fill                  | true                     |
      | lineTension           | 0.35                     |
      | borderCapStyle        | butt                     |
      | borderDashOffset      | 0                        |
      | borderJoinStyle       | miter                    |
      | borderWidth           | 1                        |
      | pointHoverRadius      | 4                        |
      | pointHoverBorderWidth | 1                        |
      | backgroundColor       | rgba(141, 190, 214, 0.1) |
      | borderColor           | rgba(141, 190, 214, 5)   |

  @SID_16
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

  @SID_17
  Scenario: DNS baseline DNS-MX IPv6 In QPS data
    And UI Do Operation "Select" item "DNS-MX IPv6"
#    And UI Do Operation "Select" item "DNS-MX Inbound"
#    And UI Do Operation "Select" item "DNS-MX QPS"

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


  @SID_18
  Scenario: DNS baseline DNS-NAPTR IPv4 In QPS
    And UI Do Operation "Select" item "DNS-NAPTR IPv4"
#    And UI Do Operation "Select" item "DNS-NAPTR Inbound"
#    And UI Do Operation "Select" item "DNS-NAPTR QPS"
    Then UI Validate Line Chart attributes "DNS-NAPTR" with Label "Suspected Edge"
      | attribute             | value   |
    # | borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ffa20d |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-NAPTR" with Label "Normal Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #8cba46 |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-NAPTR" with Label "Attack Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ff4c4c |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-NAPTR" with Label "Legitimate Traffic"
      | attribute             | value                   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                       |
      | fill                  | true                    |
      | lineTension           | 0.35                    |
      | borderCapStyle        | butt                    |
      | borderDashOffset      | 0                       |
      | borderJoinStyle       | miter                   |
      | borderWidth           | 1                       |
      | pointHoverRadius      | 4                       |
      | pointHoverBorderWidth | 1                       |
      | backgroundColor       | rgba(115, 134, 154, 0.1)|
      | borderColor           | rgba(115, 134, 154, 5)  |

    Then UI Validate Line Chart attributes "DNS-NAPTR" with Label "Total Traffic"
      | attribute             | value                    |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                        |
      | fill                  | true                     |
      | lineTension           | 0.35                     |
      | borderCapStyle        | butt                     |
      | borderDashOffset      | 0                        |
      | borderJoinStyle       | miter                    |
      | borderWidth           | 1                        |
      | pointHoverRadius      | 4                        |
      | pointHoverBorderWidth | 1                        |
      | backgroundColor       | rgba(141, 190, 214, 0.1) |
      | borderColor           | rgba(141, 190, 214, 5)   |

  @SID_19
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

  @SID_20
  Scenario: DNS baseline DNS-NAPTR IPv6 In QPS data
    And UI Do Operation "Select" item "DNS-NAPTR IPv6"
#    And UI Do Operation "Select" item "DNS-NAPTR Inbound"
#    And UI Do Operation "Select" item "DNS-NAPTR QPS"

    Then UI Validate Line Chart data "DNS-NAPTR" with Label "Suspected Edge"
      | value | count | offset |
      | 184   | 16    | 7      |

    Then UI Validate Line Chart data "DNS-NAPTR" with Label "Normal Edge"
      | value | count | offset |
      | 185   | 16    | 7      |

    Then UI Validate Line Chart data "DNS-NAPTR" with Label "Attack Edge"
      | value | count | offset |
      | 189   | 16    | 7      |

    Then UI Validate Line Chart data "DNS-NAPTR" with Label "Legitimate Traffic"
      | value | count | offset |
      | 220   | 16    | 7      |

    Then UI Validate Line Chart data "DNS-NAPTR" with Label "Total Traffic"
      | value | count | offset |
      | 240   | 16    | 7      |

  # END DNS NAPTR


  @SID_21
  Scenario: DNS baseline DNS-PTR IPv4 In QPS styling
    And UI Do Operation "Select" item "DNS-PTR IPv4"
#    And UI Do Operation "Select" item "DNS-PTR Inbound"
#    And UI Do Operation "Select" item "DNS-PTR QPS"
    And UI Validate Line Chart attributes "DNS-PTR" with Label "Suspected Edge"
      | attribute             | value   |
    # | borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ffa20d |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    And UI Validate Line Chart attributes "DNS-PTR" with Label "Normal Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #8cba46 |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-PTR" with Label "Attack Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ff4c4c |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-PTR" with Label "Legitimate Traffic"
      | attribute             | value                   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                       |
      | fill                  | true                    |
      | lineTension           | 0.35                    |
      | borderCapStyle        | butt                    |
      | borderDashOffset      | 0                       |
      | borderJoinStyle       | miter                   |
      | borderWidth           | 1                       |
      | pointHoverRadius      | 4                       |
      | pointHoverBorderWidth | 1                       |
      | backgroundColor       | rgba(115, 134, 154, 0.1)|
      | borderColor           | rgba(115, 134, 154, 5)  |

    Then UI Validate Line Chart attributes "DNS-PTR" with Label "Total Traffic"
      | attribute             | value                    |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                        |
      | fill                  | true                     |
      | lineTension           | 0.35                     |
      | borderCapStyle        | butt                     |
      | borderDashOffset      | 0                        |
      | borderJoinStyle       | miter                    |
      | borderWidth           | 1                        |
      | pointHoverRadius      | 4                        |
      | pointHoverBorderWidth | 1                        |
      | backgroundColor       | rgba(141, 190, 214, 0.1) |
      | borderColor           | rgba(141, 190, 214, 5)   |

  @SID_22
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


  @SID_23
  Scenario: DNS baseline DNS-PTR IPv6 In QPS data
    And UI Do Operation "Select" item "DNS-PTR IPv6"
#    And UI Do Operation "Select" item "DNS-PTR Inbound"
#    And UI Do Operation "Select" item "DNS-PTR QPS"

    Then UI Validate Line Chart data "DNS-PTR" with Label "Suspected Edge"
      | value | count | offset |
      | 3806  | 16    | 7      |

    Then UI Validate Line Chart data "DNS-PTR" with Label "Normal Edge"
      | value | count | offset |
      | 3600  | 16    | 7      |

    Then UI Validate Line Chart data "DNS-PTR" with Label "Attack Edge"
      | value | count | offset |
      | 4024  | 16    | 7      |

    Then UI Validate Line Chart data "DNS-PTR" with Label "Legitimate Traffic"
      | value | count | offset |
      | 140   | 16    | 7      |

    Then UI Validate Line Chart data "DNS-PTR" with Label "Total Traffic"
      | value | count | offset |
      | 150   | 16    | 7      |

  # END DNS PTR


  @SID_24
  Scenario: DNS baseline DNS-SOA IPv4 In QPS styling
    And UI Do Operation "Select" item "DNS-SOA IPv4"
#    And UI Do Operation "Select" item "DNS-SOA Inbound"
#    And UI Do Operation "Select" item "DNS-SOA QPS"
    Then UI Validate Line Chart attributes "DNS-SOA" with Label "Suspected Edge"
      | attribute             | value   |
    # | borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ffa20d |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-SOA" with Label "Normal Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #8cba46 |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-SOA" with Label "Attack Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ff4c4c |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-SOA" with Label "Legitimate Traffic"
      | attribute             | value                   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                       |
      | fill                  | true                    |
      | lineTension           | 0.35                    |
      | borderCapStyle        | butt                    |
      | borderDashOffset      | 0                       |
      | borderJoinStyle       | miter                   |
      | borderWidth           | 1                       |
      | pointHoverRadius      | 4                       |
      | pointHoverBorderWidth | 1                       |
      | backgroundColor       | rgba(115, 134, 154, 0.1)|
      | borderColor           | rgba(115, 134, 154, 5)  |

    Then UI Validate Line Chart attributes "DNS-SOA" with Label "Total Traffic"
      | attribute             | value                    |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                        |
      | fill                  | true                     |
      | lineTension           | 0.35                     |
      | borderCapStyle        | butt                     |
      | borderDashOffset      | 0                        |
      | borderJoinStyle       | miter                    |
      | borderWidth           | 1                        |
      | pointHoverRadius      | 4                        |
      | pointHoverBorderWidth | 1                        |
      | backgroundColor       | rgba(141, 190, 214, 0.1) |
      | borderColor           | rgba(141, 190, 214, 5)   |

  @SID_25
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

  @SID_26
  Scenario: DNS baseline DNS-SOA IPv6 In QPS data
    And UI Do Operation "Select" item "DNS-SOA IPv6"
#    And UI Do Operation "Select" item "DNS-SOA Inbound"
#    And UI Do Operation "Select" item "DNS-SOA QPS"

    Then UI Validate Line Chart data "DNS-SOA" with Label "Suspected Edge"
      | value | count | offset |
      | 184   | 17    | 6      |

    Then UI Validate Line Chart data "DNS-SOA" with Label "Normal Edge"
      | value | count | offset |
      | 180   | 17    | 6      |

    Then UI Validate Line Chart data "DNS-SOA" with Label "Attack Edge"
      | value | count | offset |
      | 189   | 17    | 6      |

    Then UI Validate Line Chart data "DNS-SOA" with Label "Legitimate Traffic"
      | value | count | offset |
      | 200   | 17    | 6      |

    Then UI Validate Line Chart data "DNS-SOA" with Label "Total Traffic"
      | value | count | offset |
      | 220   | 17    | 6      |

  # END DNS SOA

  @SID_27
  Scenario: DNS baseline DNS-SRV IPv4 In QPS styling
    And UI Do Operation "Select" item "DNS-SRV IPv4"
#    And UI Do Operation "Select" item "DNS-SRV Inbound"
#    And UI Do Operation "Select" item "DNS-SRV QPS"
    Then UI Validate Line Chart attributes "DNS-SRV" with Label "Suspected Edge"
      | attribute             | value   |
    # | borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ffa20d |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-SRV" with Label "Normal Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #8cba46 |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-SRV" with Label "Attack Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ff4c4c |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |

    Then UI Validate Line Chart attributes "DNS-SRV" with Label "Legitimate Traffic"
      | attribute             | value                   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                       |
      | fill                  | true                    |
      | lineTension           | 0.35                    |
      | borderCapStyle        | butt                    |
      | borderDashOffset      | 0                       |
      | borderJoinStyle       | miter                   |
      | borderWidth           | 1                       |
      | pointHoverRadius      | 4                       |
      | pointHoverBorderWidth | 1                       |
      | backgroundColor       | rgba(115, 134, 154, 0.1)|
      | borderColor           | rgba(115, 134, 154, 5)  |

    Then UI Validate Line Chart attributes "DNS-SRV" with Label "Total Traffic"
      | attribute             | value                    |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                        |
      | fill                  | true                     |
      | lineTension           | 0.35                     |
      | borderCapStyle        | butt                     |
      | borderDashOffset      | 0                        |
      | borderJoinStyle       | miter                    |
      | borderWidth           | 1                        |
      | pointHoverRadius      | 4                        |
      | pointHoverBorderWidth | 1                        |
      | backgroundColor       | rgba(141, 190, 214, 0.1) |
      | borderColor           | rgba(141, 190, 214, 5)   |

  @SID_28
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

  @SID_29
  Scenario: DNS baseline DNS-SRV IPv6 In QPS data
    And UI Do Operation "Select" item "DNS-SRV IPv6"
#    And UI Do Operation "Select" item "DNS-SRV Inbound"
#    And UI Do Operation "Select" item "DNS-SRV QPS"

    Then UI Validate Line Chart data "DNS-SRV" with Label "Suspected Edge"
      | value | count | offset |
      | 184   | 17    | 8      |

    Then UI Validate Line Chart data "DNS-SRV" with Label "Normal Edge"
      | value | count | offset |
      | 190   | 17    | 8      |

    Then UI Validate Line Chart data "DNS-SRV" with Label "Attack Edge"
      | value | count | offset |
      | 189   | 17    | 8      |

    Then UI Validate Line Chart data "DNS-SRV" with Label "Legitimate Traffic"
      | value | count | offset |
      | 240   | 17    | 8      |

    And UI Validate Line Chart data "DNS-SRV" with Label "Total Traffic"
      | value | count | offset |
      | 260   | 17    | 8      |

  # END DNS SRV


  @SID_30
  Scenario: DNS baseline Filter
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies        |
      | 10    |       | policy_1, pol_1 |
    Then UI Remove Session Storage "DNS-A"
    Then Sleep "35"
    Then UI Validate Session Storage "DNS-A" exists "false"
    And UI Open "Configurations" Tab
    And UI Logout


  @SID_31
  Scenario: DNS baseline RBAC data
    Given UI Login with user "sec_admin_allDPs_pol_1_policy" and password "radware"
    When UI Open Upper Bar Item "AMS"
    When UI Open "Dashboards" Tab
    Then UI Open "DP DNS Baseline" Sub Tab
    When UI Do Operation "Select" item "Global Time Filter"
    When UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | pol_1    |
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
  @SID_32
  Scenario: DNS baseline RBAC styling
    Then UI Validate Line Chart attributes "DNS-TXT" with Label "Suspected Edge"
      | attribute             | value   |
    # | borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ffa20d |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |
    Then UI Validate Line Chart attributes "DNS-TXT" with Label "Normal Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #8cba46 |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |
    Then UI Validate Line Chart attributes "DNS-TXT" with Label "Attack Edge"
      | attribute             | value   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0       |
      | fill                  | false   |
      | borderColor           | #ff4c4c |
      | lineTension           | 0.35    |
      | borderCapStyle        | butt    |
      | borderDashOffset      | 0       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | pointHoverRadius      | 4       |
      | pointHoverBorderWidth | 1       |
    Then UI Validate Line Chart attributes "DNS-TXT" with Label "Legitimate Traffic"
      | attribute             | value                   |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                       |
      | fill                  | true                    |
      | lineTension           | 0.35                    |
      | borderCapStyle        | butt                    |
      | borderDashOffset      | 0                       |
      | borderJoinStyle       | miter                   |
      | borderWidth           | 1                       |
      | pointHoverRadius      | 4                       |
      | pointHoverBorderWidth | 1                       |
      | backgroundColor       | rgba(115, 134, 154, 0.1)|
      | borderColor           | rgba(115, 134, 154, 5)  |
    Then UI Validate Line Chart attributes "DNS-TXT" with Label "Total Traffic"
      | attribute             | value                    |
     #| borderDash            | [4, 6]  |
      | pointRadius           | 0                        |
      | fill                  | true                     |
      | lineTension           | 0.35                     |
      | borderCapStyle        | butt                     |
      | borderDashOffset      | 0                        |
      | borderJoinStyle       | miter                    |
      | borderWidth           | 1                        |
      | pointHoverRadius      | 4                        |
      | pointHoverBorderWidth | 1                        |
      | backgroundColor       | rgba(141, 190, 214, 0.1) |
      | borderColor           | rgba(141, 190, 214, 5)   |

    * UI Open "Configurations" Tab
    * UI Logout

  @SID_33
  Scenario: DNS baseline RBAC negative
    Given UI Login with user "sec_admin_DP50_policy1" and password "radware"
    When UI Open Upper Bar Item "AMS"
    When UI Open "Dashboards" Tab
    Then UI Open "DP DNS Baseline" Sub Tab
    # Then UI Validate Session Storage "DNS-A" exists "false"
    # Then UI Validate Session Storage "DNS-TXT" exists "false"
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | policy1  |
    #Then UI Validate Session Storage "DNS-A" exists "false"
    #Then UI Validate Session Storage "DNS-TXT" exists "false"
    * UI Open "Configurations" Tab
    * UI Logout

  @SID_34
  Scenario: DNS baselines clear all widgets
    Given UI Login with user "sys_admin" and password "radware"
    When UI Open Upper Bar Item "AMS"
    When UI Open "Dashboards" Tab
    Then UI Open "DP DNS Baseline" Sub Tab
    Then UI Do Operation "Select" item "Global Time Filter"
    Then UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    Then UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | pol_1    |
    Then UI VRM Clear All Widgets

  @SID_35
  Scenario: DNS baselines use duplicate widgets
  # Given UI Login with user "sys_admin" and password "radware"
#    When UI Open Upper Bar Item "AMS"
#    When UI Open "Dashboards" Tab
#    Then UI Open "DP DNS Baseline" Sub Tab
    Then UI VRM Select Widgets
      | DNS-A |
    Then UI VRM Select Widgets
      | DNS-A |

    Then UI Do Operation "Select" item "DNS-A-1 IPv6"
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

  @SID_36
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
    
    Then UI Do Operation "Select" item "DNS-TXT-1 IPv6"
    Then UI Do Operation "Select" item "DNS-AAAA-1 IPv6"
    Then UI Do Operation "Select" item "DNS-MX-1 IPv6"
    Then UI Do Operation "Select" item "DNS-NAPTR-1 IPv6"
    Then UI Do Operation "Select" item "DNS-PTR-1 IPv6"
    Then UI Do Operation "Select" item "DNS-SOA-1 IPv6"
    Then UI Do Operation "Select" item "DNS-SRV-1 IPv6"
    Then UI Do Operation "Select" item "DNS-Other-1 IPv6"

#    Then UI Open "Configurations" Tab
    Then UI logout and close browser

  @SID_37
  Scenario: DNS baselines check logs
    Then CLI kill all simulator attacks on current vision
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal        | NOT_EXPECTED |
