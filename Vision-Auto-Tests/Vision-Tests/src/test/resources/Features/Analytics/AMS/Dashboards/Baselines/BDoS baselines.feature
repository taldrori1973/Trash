@VRM_BDoS_Baseline @TC105987

Feature: VRM BDoS baselines

  @SID_1
  Scenario: increase inactivity timeout to maximum
    Given REST Send simple body request from File "Vision/SystemManagement.json" with label "Set Authentication Mode"
      | jsonPath             | value    |
      | $.authenticationMode | "TACACS" |
    Given REST Send simple body request from File "Vision/SystemManagement.json" with label "Set connectivity options"
      | jsonPath             | value    |
      | $.sessionInactivTimeoutConfiguration | 60 |

  @SID_2
  Scenario: BDoS baseline pre-requisite
    Given CLI kill all simulator attacks on current vision
#    Given CLI Clear vision logs
    Given REST Delete ES index "dp-bdos-baseline*"
    Given REST Delete ES index "dp-baseline*"
    Given CLI simulate 400 attacks of type "baselines_pol_1" on SetId "DefensePro_Set_1" with loopDelay 15000 and wait 140 seconds

  @SID_3
  Scenario: Login into VRM and select device
    Given UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
#    Then Sleep "1"
    And UI Do Operation "Select" item "Global Time Filter"
#    Then Sleep "1"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | pol_1    |

  @SID_4
  Scenario: BDoS baseline TCP-SYN IPv4 In bps
    Then Sleep "2"
    Then UI Validate Line Chart attributes "BDoS-TCP SYN" with Label "Suspected Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Suspected Edge"
      | value | count | offset |
      | 464   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP SYN" with Label "Normal Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Normal Edge"
      | value | count | offset |
      | 322   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP SYN" with Label "Attack Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Attack Edge"
      | value | count | offset |
      | 628   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP SYN" with Label "Legitimate Traffic"
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
      | backgroundColor       | rgba(115, 134, 154, 0.1) |
      | borderColor           | rgba(115, 134, 154, 5)   |
    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Legitimate Traffic"
      | value | count | offset |
      | 44800 | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP SYN" with Label "Total Traffic"
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
    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Total Traffic"
      | value | count | offset |
      | 46640 | 13    | 6      |

  @SID_5
  Scenario: BDoS baseline TCP-SYN IPv6 In bps
    Then UI Do Operation "Select" item "BDoS-TCP SYN IPv6"
    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Suspected Edge"
      | value | count | offset |
      | 464   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Normal Edge"
      | value | count | offset |
      | 322   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Attack Edge"
      | value | count | offset |
      | 628   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Legitimate Traffic"
      | value | count | offset |
      | 96    | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Total Traffic"
      | value | count | offset |
      | 480   | 13    | 6      |

  @SID_6
  Scenario: BDoS baseline TCP-SYN IPv4 Out bps
    Then UI Do Operation "Select" item "BDoS-TCP SYN IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP SYN Outbound"

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Suspected Edge"
      | value | count | offset |
      | 192   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Normal Edge"
      | value | count | offset |
      | 322   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Attack Edge"
      | value | count | offset |
      | 192   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Legitimate Traffic"
      | value | count | offset |
      | 44720 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Total Traffic"
      | value | count | offset |
      | 46560 | 13    | 6      |

  @SID_7
  Scenario: BDoS baseline TCP-SYN IPv6 Out bps
    Then UI Do Operation "Select" item "BDoS-TCP SYN IPv6"

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Suspected Edge"
      | value | count | offset |
      | 32000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Normal Edge"
      | value | count | offset |
      | 322   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Attack Edge"
      | value | count | offset |
      | 40000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Legitimate Traffic"
      | value | count | offset |
      | 80    | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Total Traffic"
      | value | count | offset |
      | 464   | 13    | 6      |

  @SID_8
  Scenario: BDoS baseline TCP-SYN IPv4 In pps
    Then UI Do Operation "Select" item "BDoS-TCP SYN IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP SYN Inbound"
    Then UI Do Operation "Select" item "BDoS-TCP SYN pps"

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Suspected Edge"
      | value | count | offset |
      | 7000  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Normal Edge"
      | value | count | offset |
      | 630   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Attack Edge"
      | value | count | offset |
      | 7400  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4400  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Total Traffic"
      | value | count | offset |
      | 4860  | 13    | 6      |

  @SID_9
  Scenario: BDoS baseline TCP-SYN IPv6 In pps
    Then UI Do Operation "Select" item "BDoS-TCP SYN IPv6"

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Suspected Edge"
      | value | count | offset |
      | 17001 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Normal Edge"
      | value | count | offset |
      | 630   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Attack Edge"
      | value | count | offset |
      | 18001 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4300  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Total Traffic"
      | value | count | offset |
      | 5500  | 13    | 6      |

  @SID_10
  Scenario: BDoS baseline TCP-SYN IPv4 Out pps
    Then UI Do Operation "Select" item "BDoS-TCP SYN IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP SYN Outbound"

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Suspected Edge"
      | value | count | offset |
      | 25000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Normal Edge"
      | value | count | offset |
      | 630   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Attack Edge"
      | value | count | offset |
      | 26000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4380  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Total Traffic"
      | value | count | offset |
      | 4840  | 13    | 6      |

  @SID_11
  Scenario: BDoS baseline TCP-SYN IPv6 Out pps
    Then UI Do Operation "Select" item "BDoS-TCP SYN IPv6"

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Suspected Edge"
      | value   | count | offset |
      | 5000000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Normal Edge"
      | value | count | offset |
      | 630   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Attack Edge"
      | value   | count | offset |
      | 5300000 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4250  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Total Traffic"
      | value | count | offset |
      | 5450  | 13    | 6      |

  #   END TCP SYN BASIC


  @SID_12
  Scenario: BDoS baseline TCP FIN ACK IPv4 In bps
    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK Inbound"
    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK bps"
    Then UI Validate Line Chart attributes "BDoS-TCP FIN ACK" with Label "Suspected Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Suspected Edge"
      | value | count | offset |
      | 464   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP FIN ACK" with Label "Normal Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 322   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP FIN ACK" with Label "Attack Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Attack Edge"
      | value | count | offset |
      | 628   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP FIN ACK" with Label "Legitimate Traffic"
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
      | backgroundColor       | rgba(115, 134, 154, 0.1) |
      | borderColor           | rgba(115, 134, 154, 5)   |
    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 44160 | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP FIN ACK" with Label "Total Traffic"
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
    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 46000 | 13    | 6      |

  @SID_13
  Scenario: BDoS baseline TCP FIN ACK IPv6 In bps
    Then Sleep "2"
    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK IPv6"
#    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK Inbound"
#    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK bps"
    Then Sleep "2"

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Suspected Edge"
      | value | count | offset |
      | 464   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 322   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Attack Edge"
      | value | count | offset |
      | 628   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 61    | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 352   | 13    | 6      |

  @SID_14
  Scenario: BDoS baseline TCP FIN ACK IPv4 Out bps
    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK Outbound"
#    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK bps"
    Then Sleep "2"

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Suspected Edge"
      | value | count | offset |
      | 4     | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 322   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Attack Edge"
      | value | count | offset |
      | 5     | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 44080 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 45920 | 13    | 6      |

  @SID_15
  Scenario: BDoS baseline TCP FIN ACK IPv6 Out bps
    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK IPv6"
#    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK Outbound"
#    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK bps"
    Then Sleep "2"

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Suspected Edge"
      | value | count | offset |
      | 1960  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 322   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Attack Edge"
      | value | count | offset |
      | 2000  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 61    | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 336   | 13    | 6      |

  @SID_16
  Scenario: BDoS baseline TCP FIN ACK IPv4 In pps
    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK Inbound"
    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK pps"

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Suspected Edge"
      | value | count | offset |
      | 10080 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 672   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Attack Edge"
      | value | count | offset |
      | 10280 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4240  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 4700  | 13    | 6      |

  @SID_17
  Scenario: BDoS baseline TCP FIN ACK IPv6 In pps
    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK IPv6"

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Suspected Edge"
      | value | count | offset |
      | 1200  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 672   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Attack Edge"
      | value | count | offset |
      | 1300  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 3900  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 5100  | 13    | 6      |

  @SID_18
  Scenario: BDoS baseline TCP FIN ACK IPv4 Out pps
    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK Outbound"

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Suspected Edge"
      | value   | count | offset |
      | 1000000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 672   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Attack Edge"
      | value   | count | offset |
      | 1500000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4220  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 4680  | 13    | 6      |

  @SID_19
  Scenario: BDoS baseline TCP FIN ACK IPv6 Out pps
    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK IPv6"

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Suspected Edge"
      | value  | count | offset |
      | 255000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 672   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Attack Edge"
      | value  | count | offset |
      | 260000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 3850  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP FIN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 5050  | 13    | 6      |

  #   END TCP FIN ACK BASIC

  @SID_20
  Scenario: BDoS baseline TCP Fragmented IPv4 In bps
    Then UI Do Operation "Select" item "BDoS-TCP Fragmented IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP Fragmented Inbound"
    Then UI Do Operation "Select" item "BDoS-TCP Fragmented bps"
    Then UI Validate Line Chart attributes "BDoS-TCP Fragmented" with Label "Suspected Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Suspected Edge"
      | value | count | offset |
      | 232   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP Fragmented" with Label "Normal Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Normal Edge"
      | value | count | offset |
      | 161   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP Fragmented" with Label "Attack Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Attack Edge"
      | value | count | offset |
      | 314   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP Fragmented" with Label "Legitimate Traffic"
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
      | backgroundColor       | rgba(115, 134, 154, 0.1) |
      | borderColor           | rgba(115, 134, 154, 5)   |
    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Legitimate Traffic"
      | value | count | offset |
      | 43840 | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP Fragmented" with Label "Total Traffic"
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
    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Total Traffic"
      | value | count | offset |
      | 45760 | 13    | 6      |

  @SID_21
  Scenario: BDoS baseline TCP Fragmented IPv6 In bps
    Then UI Do Operation "Select" item "BDoS-TCP Fragmented IPv6"

    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Suspected Edge"
      | value | count | offset |
      | 232   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Normal Edge"
      | value | count | offset |
      | 161   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Attack Edge"
      | value | count | offset |
      | 314   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Legitimate Traffic"
      | value | count | offset |
      | 60    | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Total Traffic"
      | value | count | offset |
      | 288   | 13    | 6      |

  @SID_22
  Scenario: BDoS baseline TCP Fragmented IPv4 Out bps
    Then UI Do Operation "Select" item "BDoS-TCP Fragmented IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP Fragmented Outbound"

    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Suspected Edge"
      | value | count | offset |
      | 20    | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Normal Edge"
      | value | count | offset |
      | 161   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Attack Edge"
      | value | count | offset |
      | 28    | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Legitimate Traffic"
      | value | count | offset |
      | 43760 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Total Traffic"
      | value | count | offset |
      | 45680 | 13    | 6      |

  @SID_23
  Scenario: BDoS baseline TCP Fragmented IPv6 Out bps
    Then UI Do Operation "Select" item "BDoS-TCP Fragmented IPv6"

    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Suspected Edge"
      | value | count | offset |
      | 2204  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Normal Edge"
      | value | count | offset |
      | 161   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Attack Edge"
      | value | count | offset |
      | 2208  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Legitimate Traffic"
      | value | count | offset |
      | 59    | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Total Traffic"
      | value | count | offset |
      | 272   | 13    | 6      |

  @SID_24
  Scenario: BDoS baseline TCP Fragmented IPv4 In pps
    Then UI Do Operation "Select" item "BDoS-TCP Fragmented IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP Fragmented Inbound"
    Then UI Do Operation "Select" item "BDoS-TCP Fragmented pps"

    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Suspected Edge"
      | value | count | offset |
      | 11280 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Normal Edge"
      | value | count | offset |
      | 40    | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Attack Edge"
      | value | count | offset |
      | 11280 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4160  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Total Traffic"
      | value | count | offset |
      | 4640  | 13    | 6      |

  @SID_25
  Scenario: BDoS baseline TCP Fragmented IPv6 In pps
    Then UI Do Operation "Select" item "BDoS-TCP Fragmented IPv6"

    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Suspected Edge"
      | value  | count | offset |
      | 750000 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Normal Edge"
      | value | count | offset |
      | 40    | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Attack Edge"
      | value  | count | offset |
      | 760000 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Legitimate Traffic"
      | value | count | offset |
      | 3700  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Total Traffic"
      | value | count | offset |
      | 4900  | 13    | 6      |

  @SID_26
  Scenario: BDoS baseline TCP Fragmented IPv4 Out pps
    Then UI Do Operation "Select" item "BDoS-TCP Fragmented IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP Fragmented Outbound"

    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Suspected Edge"
      | value | count | offset |
      | 3500  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Normal Edge"
      | value | count | offset |
      | 40    | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Attack Edge"
      | value | count | offset |
      | 4500  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4140  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Total Traffic"
      | value | count | offset |
      | 4620  | 13    | 6      |

  @SID_27
  Scenario: BDoS baseline TCP Fragmented IPv6 Out pps
    Then UI Do Operation "Select" item "BDoS-TCP Fragmented IPv6"
#    Then UI Do Operation "Select" item "BDoS-TCP Fragmented Outbound"
#    Then UI Do Operation "Select" item "BDoS-TCP Fragmented pps"

    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Suspected Edge"
      | value | count | offset |
      | 400   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Normal Edge"
      | value | count | offset |
      | 40    | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Attack Edge"
      | value | count | offset |
      | 444   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Legitimate Traffic"
      | value | count | offset |
      | 3650  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP Fragmented" with Label "Total Traffic"
      | value | count | offset |
      | 4850  | 13    | 6      |

  #   END TCP Fragmented BASIC

  @SID_28
  Scenario: BDoS baseline TCP RST IPv4 In bps
    Then UI Do Operation "Select" item "BDoS-TCP RST IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP RST Inbound"
    Then UI Do Operation "Select" item "BDoS-TCP RST bps"
    Then UI Validate Line Chart attributes "BDoS-TCP RST" with Label "Suspected Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Suspected Edge"
      | value | count | offset |
      | 929   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP RST" with Label "Normal Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Normal Edge"
      | value | count | offset |
      | 645   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP RST" with Label "Attack Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Attack Edge"
      | value | count | offset |
      | 1256  | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP RST" with Label "Legitimate Traffic"
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
      | backgroundColor       | rgba(115, 134, 154, 0.1) |
      | borderColor           | rgba(115, 134, 154, 5)   |
    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Legitimate Traffic"
      | value | count | offset |
      | 44640 | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP RST" with Label "Total Traffic"
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
    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Total Traffic"
      | value | count | offset |
      | 46480 | 13    | 6      |

  @SID_29
  Scenario: BDoS baseline TCP RST IPv6 In bps
    Then UI Do Operation "Select" item "BDoS-TCP RST IPv6"
#    Then UI Do Operation "Select" item "BDoS-TCP RST Inbound"
#    Then UI Do Operation "Select" item "BDoS-TCP RST bps"

    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Suspected Edge"
      | value | count | offset |
      | 929   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Normal Edge"
      | value | count | offset |
      | 645   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Attack Edge"
      | value | count | offset |
      | 1256  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Legitimate Traffic"
      | value | count | offset |
      | 64    | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Total Traffic"
      | value | count | offset |
      | 448   | 13    | 6      |

  @SID_30
  Scenario: BDoS baseline TCP RST IPv4 Out bps
    Then UI Do Operation "Select" item "BDoS-TCP RST IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP RST Outbound"
#    Then UI Do Operation "Select" item "BDoS-TCP RST bps"

    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Suspected Edge"
      | value | count | offset |
      | 208   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Normal Edge"
      | value | count | offset |
      | 645   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Attack Edge"
      | value | count | offset |
      | 216   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Legitimate Traffic"
      | value | count | offset |
      | 44560 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Total Traffic"
      | value | count | offset |
      | 46400 | 13    | 6      |

  @SID_31
  Scenario: BDoS baseline TCP RST IPv6 Out bps
    Then UI Do Operation "Select" item "BDoS-TCP RST IPv6"
#    Then UI Do Operation "Select" item "BDoS-TCP RST Outbound"
#    Then UI Do Operation "Select" item "BDoS-TCP RST bps"

    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Suspected Edge"
      | value | count | offset |
      | 88    | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Normal Edge"
      | value | count | offset |
      | 645   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Attack Edge"
      | value | count | offset |
      | 88    | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Legitimate Traffic"
      | value | count | offset |
      | 63    | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Total Traffic"
      | value | count | offset |
      | 432   | 13    | 6      |

  @SID_32
  Scenario: BDoS baseline TCP RST IPv4 In pps
    Then UI Do Operation "Select" item "BDoS-TCP RST IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP RST Inbound"
    Then UI Do Operation "Select" item "BDoS-TCP RST pps"

    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Suspected Edge"
      | value | count | offset |
      | 7400  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Normal Edge"
      | value | count | offset |
      | 1344  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Attack Edge"
      | value | count | offset |
      | 7418  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4360  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Total Traffic"
      | value | count | offset |
      | 4820  | 13    | 6      |

  @SID_33
  Scenario: BDoS baseline TCP RST IPv6 In pps
    Then UI Do Operation "Select" item "BDoS-TCP RST IPv6"
#    Then UI Do Operation "Select" item "BDoS-TCP RST Inbound"
#    Then UI Do Operation "Select" item "BDoS-TCP RST pps"

    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Suspected Edge"
      | value | count | offset |
      | 18001 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Normal Edge"
      | value | count | offset |
      | 1344  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Attack Edge"
      | value | count | offset |
      | 19001 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4200  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Total Traffic"
      | value | count | offset |
      | 5400  | 13    | 6      |

  @SID_34
  Scenario: BDoS baseline TCP RST IPv4 Out pps
    Then UI Do Operation "Select" item "BDoS-TCP RST IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP RST Outbound"
    Then UI Do Operation "Select" item "BDoS-TCP RST pps"

    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Suspected Edge"
      | value | count | offset |
      | 27000 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Normal Edge"
      | value | count | offset |
      | 1344  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Attack Edge"
      | value | count | offset |
      | 28000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4340  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Total Traffic"
      | value | count | offset |
      | 4800  | 13    | 6      |

  @SID_35
  Scenario: BDoS baseline TCP RST IPv6 Out pps
    Then UI Do Operation "Select" item "BDoS-TCP RST IPv6"
    Then UI Do Operation "Select" item "BDoS-TCP RST Outbound"
    Then UI Do Operation "Select" item "BDoS-TCP RST pps"

    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Suspected Edge"
      | value | count | offset |
      | 11110 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Normal Edge"
      | value | count | offset |
      | 1344  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Attack Edge"
      | value | count | offset |
      | 11111 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4150  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP RST" with Label "Total Traffic"
      | value | count | offset |
      | 5350  | 13    | 6      |

  #   END TCP RST BASIC

  @SID_36
  Scenario: BDoS baseline TCP-SYN ACK IPv4 In bps
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK Inbound"
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK bps"
    Then UI Validate Line Chart attributes "BDoS-TCP SYN ACK" with Label "Suspected Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Suspected Edge"
      | value | count | offset |
      | 464   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP SYN ACK" with Label "Normal Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 322   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP SYN ACK" with Label "Attack Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Attack Edge"
      | value | count | offset |
      | 628   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP SYN ACK" with Label "Legitimate Traffic"
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
      | backgroundColor       | rgba(115, 134, 154, 0.1) |
      | borderColor           | rgba(115, 134, 154, 5)   |
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 44000 | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP SYN ACK" with Label "Total Traffic"
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
    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 66680 | 13    | 6      |

  @SID_37
  Scenario: BDoS baseline TCP-SYN ACK IPv6 In bps
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK IPv6"
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK Inbound"
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK bps"

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Suspected Edge"
      | value | count | offset |
      | 464   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 322   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Attack Edge"
      | value | count | offset |
      | 628   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 60    | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 320   | 13    | 6      |

  @SID_38
  Scenario: BDoS baseline TCP-SYN ACK IPv4 Out bps
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK Outbound"
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK bps"

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Suspected Edge"
      | value | count | offset |
      | 6     | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 322   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Attack Edge"
      | value | count | offset |
      | 7     | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 43920 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 45840 | 13    | 6      |

  @SID_39
  Scenario: BDoS baseline TCP-SYN ACK IPv6 Out bps
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK IPv6"
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK Outbound"
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK bps"

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Suspected Edge"
      | value | count | offset |
      | 2080  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 322   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Attack Edge"
      | value | count | offset |
      | 2120  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 60    | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 304   | 13    | 6      |

  @SID_40
  Scenario: BDoS baseline TCP-SYN ACK IPv4 In pps
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK Inbound"
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK pps"

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Suspected Edge"
      | value | count | offset |
      | 10280 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 652   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Attack Edge"
      | value | count | offset |
      | 11280 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4200  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Total Traffic"
      | value  | count | offset |
      | 154353 | 13    | 6      |

  @SID_41
  Scenario: BDoS baseline TCP-SYN ACK IPv6 In pps
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK IPv6"
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK Inbound"
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK pps"

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Suspected Edge"
      | value  | count | offset |
      | 700000 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 650   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Attack Edge"
      | value  | count | offset |
      | 750000 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 3800  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 5000  | 13    | 6      |

  @SID_42
  Scenario: BDoS baseline TCP-SYN ACK IPv4 Out pps
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK IPv4"
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK Outbound"
    # Then UI Do Operation "Select" item "BDoS-TCP SYN ACK pps"

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Suspected Edge"
      | value | count | offset |
      | 1500  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 650   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Attack Edge"
      | value | count | offset |
      | 2500  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4180  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 4660  | 13    | 6      |

  @SID_43
  Scenario: BDoS baseline TCP-SYN ACK IPv6 Out pps
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK IPv6"
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK Outbound"
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK pps"

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Suspected Edge"
      | value  | count | offset |
      | 270000 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Normal Edge"
      | value | count | offset |
      | 650   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Attack Edge"
      | value  | count | offset |
      | 275000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Legitimate Traffic"
      | value | count | offset |
      | 3750  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN ACK" with Label "Total Traffic"
      | value | count | offset |
      | 4950  | 13    | 6      |

  #   END TCP SYN ACK BASIC

  @SID_44
  Scenario: BDoS baseline UDP IPv4 In bps
    Then UI Do Operation "Select" item "BDoS-UDP IPv4"
    Then UI Do Operation "Select" item "BDoS-UDP Inbound"
    Then UI Do Operation "Select" item "BDoS-UDP bps"
    Then UI Validate Line Chart attributes "BDoS-UDP" with Label "Suspected Edge"
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
    Then UI Validate Line Chart data "BDoS-UDP" with Label "Suspected Edge"
      | value | count | offset |
      | 2575  | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-UDP" with Label "Normal Edge"
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
    Then UI Validate Line Chart data "BDoS-UDP" with Label "Normal Edge"
      | value | count | offset |
      | 2048  | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-UDP" with Label "Attack Edge"
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
    Then UI Validate Line Chart data "BDoS-UDP" with Label "Attack Edge"
      | value | count | offset |
      | 3238  | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-UDP" with Label "Legitimate Traffic"
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
      | backgroundColor       | rgba(115, 134, 154, 0.1) |
      | borderColor           | rgba(115, 134, 154, 5)   |
    Then UI Validate Line Chart data "BDoS-UDP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 45280 | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-UDP" with Label "Total Traffic"
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
    Then UI Validate Line Chart data "BDoS-UDP" with Label "Total Traffic"
      | value | count | offset |
      | 66480 | 13    | 6      |

  @SID_45
  Scenario: BDoS baseline UDP IPv6 In bps
    Then UI Do Operation "Select" item "BDoS-UDP IPv6"
    Then UI Do Operation "Select" item "BDoS-UDP Inbound"
    Then UI Do Operation "Select" item "BDoS-UDP bps"

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Suspected Edge"
      | value | count | offset |
      | 2902  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Normal Edge"
      | value | count | offset |
      | 2048  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Attack Edge"
      | value | count | offset |
      | 3507  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 192   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Total Traffic"
      | value | count | offset |
      | 576   | 13    | 6      |

  @SID_46
  Scenario: BDoS baseline UDP IPv4 Out bps
    Then UI Do Operation "Select" item "BDoS-UDP IPv4"
    Then UI Do Operation "Select" item "BDoS-UDP Outbound"
    Then UI Do Operation "Select" item "BDoS-UDP bps"

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Suspected Edge"
      | value | count | offset |
      | 0     | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Normal Edge"
      | value | count | offset |
      | 2048  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Attack Edge"
      | value | count | offset |
      | 0     | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 45200 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Total Traffic"
      | value | count | offset |
      | 47040 | 13    | 6      |

  @SID_47
  Scenario: BDoS baseline UDP IPv6 Out bps
    Then UI Do Operation "Select" item "BDoS-UDP IPv6"
    Then UI Do Operation "Select" item "BDoS-UDP Outbound"
    Then UI Do Operation "Select" item "BDoS-UDP bps"

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Suspected Edge"
      | value | count | offset |
      | 0     | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Normal Edge"
      | value | count | offset |
      | 2048  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Attack Edge"
      | value | count | offset |
      | 0     | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 176   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Total Traffic"
      | value | count | offset |
      | 560   | 13    | 6      |

  @SID_48
  Scenario: BDoS baseline UDP IPv4 In pps
    Then UI Do Operation "Select" item "BDoS-UDP IPv4"
    Then UI Do Operation "Select" item "BDoS-UDP Inbound"
    Then UI Do Operation "Select" item "BDoS-UDP pps"

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Suspected Edge"
      | value | count | offset |
      | 30000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Normal Edge"
      | value | count | offset |
      | 731   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Attack Edge"
      | value | count | offset |
      | 32000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4520  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-UDP" with Label "Total Traffic"
      | value | count | offset |
      | 4980  | 13    | 6      |

  @SID_49
  Scenario: BDoS baseline UDP IPv6 In pps
    Then UI Do Operation "Select" item "BDoS-UDP IPv6"
    Then UI Do Operation "Select" item "BDoS-UDP Inbound"
    Then UI Do Operation "Select" item "BDoS-UDP pps"

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Suspected Edge"
      | value | count | offset |
      | 13000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Normal Edge"
      | value | count | offset |
      | 731   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Attack Edge"
      | value | count | offset |
      | 13500 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-UDP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4600  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Total Traffic"
      | value | count | offset |
      | 5800  | 13    | 6      |

  @SID_50
  Scenario: BDoS baseline UDP IPv4 Out pps
    Then UI Do Operation "Select" item "BDoS-UDP IPv4"
    Then UI Do Operation "Select" item "BDoS-UDP Outbound"
    Then UI Do Operation "Select" item "BDoS-UDP pps"

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Suspected Edge"
      | value | count | offset |
      | 2500  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-UDP" with Label "Normal Edge"
      | value | count | offset |
      | 731   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-UDP" with Label "Attack Edge"
      | value | count | offset |
      | 2500  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4500  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Total Traffic"
      | value | count | offset |
      | 4960  | 13    | 6      |

  @SID_51
  Scenario: BDoS baseline UDP IPv6 Out pps
    Then UI Do Operation "Select" item "BDoS-UDP IPv6"
    Then UI Do Operation "Select" item "BDoS-UDP Outbound"
    Then UI Do Operation "Select" item "BDoS-UDP pps"

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Suspected Edge"
      | value  | count | offset |
      | 900000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Normal Edge"
      | value | count | offset |
      | 731   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Attack Edge"
      | value  | count | offset |
      | 950000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4550  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-UDP" with Label "Total Traffic"
      | value | count | offset |
      | 5750  | 13    | 6      |

  #   END UDP BASIC

  @SID_52
  Scenario: BDoS baseline UDP-Fragmented IPv4 In bps
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented IPv4"
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented Inbound"
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented bps"
    Then UI Validate Line Chart attributes "BDoS-UDP Fragmented" with Label "Suspected Edge"
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
    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Suspected Edge"
      | value | count | offset |
      | 1037  | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-UDP Fragmented" with Label "Normal Edge"
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
    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Normal Edge"
      | value | count | offset |
      | 768   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-UDP Fragmented" with Label "Attack Edge"
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
    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Attack Edge"
      | value | count | offset |
      | 1402  | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-UDP Fragmented" with Label "Legitimate Traffic"
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
      | backgroundColor       | rgba(115, 134, 154, 0.1) |
      | borderColor           | rgba(115, 134, 154, 5)   |
    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Legitimate Traffic"
      | value | count | offset |
      | 45120 | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-UDP Fragmented" with Label "Total Traffic"
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
    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Total Traffic"
      | value | count | offset |
      | 46960 | 13    | 6      |

  @SID_53
  Scenario: BDoS baseline UDP-Fragmented IPv6 In bps
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented IPv6"
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented Inbound"
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented bps"

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Suspected Edge"
      | value | count | offset |
      | 1037  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Normal Edge"
      | value | count | offset |
      | 768   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Attack Edge"
      | value | count | offset |
      | 1402  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Legitimate Traffic"
      | value | count | offset |
      | 160   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Total Traffic"
      | value | count | offset |
      | 544   | 13    | 6      |

  @SID_54
  Scenario: BDoS baseline UDP-Fragmented IPv4 Out bps
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented IPv4"
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented Outbound"
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented bps"

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Suspected Edge"
      | value | count | offset |
      | 20    | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Normal Edge"
      | value | count | offset |
      | 768   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Attack Edge"
      | value | count | offset |
      | 160   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Legitimate Traffic"
      | value | count | offset |
      | 45040 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Total Traffic"
      | value | count | offset |
      | 46880 | 13    | 6      |

  @SID_55
  Scenario: BDoS baseline UDP-Fragmented IPv6 Out bps
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented IPv6"
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented Outbound"
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented bps"

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Suspected Edge"
      | value | count | offset |
      | 0     | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Normal Edge"
      | value | count | offset |
      | 768   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Attack Edge"
      | value | count | offset |
      | 24    | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Legitimate Traffic"
      | value | count | offset |
      | 144   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Total Traffic"
      | value | count | offset |
      | 528   | 13    | 6      |

  @SID_56
  Scenario: BDoS baseline UDP-Fragmented IPv4 In pps
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented IPv4"
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented Inbound"
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented pps"

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Suspected Edge"
      | value | count | offset |
      | 2500  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Normal Edge"
      | value | count | offset |
      | 192   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Attack Edge"
      | value | count | offset |
      | 2600  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4480  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Total Traffic"
      | value | count | offset |
      | 4940  | 13    | 6      |

  @SID_57
  Scenario: BDoS baseline UDP-Fragmented IPv6 In pps
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented IPv6"
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented Inbound"
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented pps"

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Suspected Edge"
      | value | count | offset |
      | 14000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Normal Edge"
      | value | count | offset |
      | 192   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Attack Edge"
      | value | count | offset |
      | 15001 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4500  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Total Traffic"
      | value | count | offset |
      | 5700  | 13    | 6      |

  @SID_58
  Scenario: BDoS baseline UDP-Fragmented IPv4 Out pps
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented IPv4"
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented Outbound"
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented pps"

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Suspected Edge"
      | value | count | offset |
      | 2000  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Normal Edge"
      | value | count | offset |
      | 192   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Attack Edge"
      | value | count | offset |
      | 2100  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4460  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Total Traffic"
      | value | count | offset |
      | 4920  | 13    | 6      |

  @SID_59
  Scenario: BDoS baseline UDP-Fragmented IPv6 Out pps
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented IPv6"
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented Outbound"
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented pps"

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Suspected Edge"
      | value | count | offset |
      | 4000  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Normal Edge"
      | value | count | offset |
      | 192   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Attack Edge"
      | value | count | offset |
      | 4000  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4450  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-UDP Fragmented" with Label "Total Traffic"
      | value | count | offset |
      | 5650  | 13    | 6      |

  #   END UDP Fragmented BASIC

  @SID_60
  Scenario: BDoS baseline BDoS-ICMP IPv4 In bps
    Then UI Do Operation "Select" item "BDoS-ICMP IPv4"
    Then UI Do Operation "Select" item "BDoS-ICMP Inbound"
    Then UI Do Operation "Select" item "BDoS-ICMP bps"
    Then UI Validate Line Chart attributes "BDoS-ICMP" with Label "Suspected Edge"
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
    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Suspected Edge"
      | value | count | offset |
      | 182   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-ICMP" with Label "Normal Edge"
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
    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Normal Edge"
      | value | count | offset |
      | 92    | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-ICMP" with Label "Attack Edge"
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
    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Attack Edge"
      | value | count | offset |
      | 323   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-ICMP" with Label "Legitimate Traffic"
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
      | backgroundColor       | rgba(115, 134, 154, 0.1) |
      | borderColor           | rgba(115, 134, 154, 5)   |
    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 45600 | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-ICMP" with Label "Total Traffic"
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
    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Total Traffic"
      | value | count | offset |
      | 1040  | 13    | 6      |

  @SID_61
  Scenario: BDoS baseline BDoS-ICMP IPv6 In bps
    Then UI Do Operation "Select" item "BDoS-ICMP IPv6"
    Then UI Do Operation "Select" item "BDoS-ICMP Inbound"
    Then UI Do Operation "Select" item "BDoS-ICMP bps"

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Suspected Edge"
      | value | count | offset |
      | 182   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Normal Edge"
      | value | count | offset |
      | 92    | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Attack Edge"
      | value | count | offset |
      | 323   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 256   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Total Traffic"
      | value | count | offset |
      | 640   | 13    | 6      |

  @SID_62
  Scenario: BDoS baseline BDoS-ICMP IPv4 Out bps
    Then UI Do Operation "Select" item "BDoS-ICMP IPv4"
    Then UI Do Operation "Select" item "BDoS-ICMP Outbound"
    Then UI Do Operation "Select" item "BDoS-ICMP bps"

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Suspected Edge"
      | value | count | offset |
      | 16    | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Normal Edge"
      | value | count | offset |
      | 92    | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Attack Edge"
      | value | count | offset |
      | 16    | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 45520 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Total Traffic"
      | value | count | offset |
      | 960   | 13    | 6      |

  @SID_63
  Scenario: BDoS baseline BDoS-ICMP IPv6 Out bps
    Then UI Do Operation "Select" item "BDoS-ICMP IPv6"
    Then UI Do Operation "Select" item "BDoS-ICMP Outbound"
    Then UI Do Operation "Select" item "BDoS-ICMP bps"

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Suspected Edge"
      | value | count | offset |
      | 32    | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Normal Edge"
      | value | count | offset |
      | 92    | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Attack Edge"
      | value | count | offset |
      | 112   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 240   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Total Traffic"
      | value | count | offset |
      | 624   | 13    | 6      |

  @SID_64
  Scenario: BDoS baseline BDoS-ICMP IPv4 In pps
    Then UI Do Operation "Select" item "BDoS-ICMP IPv4"
    Then UI Do Operation "Select" item "BDoS-ICMP Inbound"
    Then UI Do Operation "Select" item "BDoS-ICMP pps"

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Suspected Edge"
      | value | count | offset |
      | 0     | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Normal Edge"
      | value | count | offset |
      | 160   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Attack Edge"
      | value | count | offset |
      | 0     | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4600  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Total Traffic"
      | value | count | offset |
      | 0     | 13    | 6      |

  @SID_65
  Scenario: BDoS baseline BDoS-ICMP IPv6 In pps
    Then UI Do Operation "Select" item "BDoS-ICMP IPv6"
    Then UI Do Operation "Select" item "BDoS-ICMP Inbound"
    Then UI Do Operation "Select" item "BDoS-ICMP pps"

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Suspected Edge"
      | value | count | offset |
      | 15001 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Normal Edge"
      | value | count | offset |
      | 160   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Attack Edge"
      | value | count | offset |
      | 16001 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4800  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Total Traffic"
      | value | count | offset |
      | 6000  | 13    | 6      |

  @SID_66
  Scenario: BDoS baseline BDoS-ICMP IPv4 Out pps
    Then UI Do Operation "Select" item "BDoS-ICMP IPv4"
    Then UI Do Operation "Select" item "BDoS-ICMP Outbound"
    Then UI Do Operation "Select" item "BDoS-ICMP pps"

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Suspected Edge"
      | value | count | offset |
      | 21000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Normal Edge"
      | value | count | offset |
      | 160   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Attack Edge"
      | value | count | offset |
      | 22000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4580  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Total Traffic"
      | value | count | offset |
      | 0     | 13    | 6      |

  @SID_67
  Scenario: BDoS baseline BDoS-ICMP IPv6 Out pps
    Then UI Do Operation "Select" item "BDoS-ICMP IPv6"
    Then UI Do Operation "Select" item "BDoS-ICMP Outbound"
    Then UI Do Operation "Select" item "BDoS-ICMP pps"

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Suspected Edge"
      | value | count | offset |
      | 14000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Normal Edge"
      | value | count | offset |
      | 160   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Attack Edge"
      | value | count | offset |
      | 14500 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4750  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-ICMP" with Label "Total Traffic"
      | value | count | offset |
      | 5950  | 13    | 6      |

  #   END ICMP BASIC


  @SID_68
  Scenario: BDoS baseline IGMP IPv4 In bps
    Then UI Do Operation "Select" item "BDoS-IGMP IPv4"
    Then UI Do Operation "Select" item "BDoS-IGMP Inbound"
    Then UI Do Operation "Select" item "BDoS-IGMP bps"
    Then UI Validate Line Chart attributes "BDoS-IGMP" with Label "Suspected Edge"
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
    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Suspected Edge"
      | value | count | offset |
      | 182   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-IGMP" with Label "Normal Edge"
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
    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Normal Edge"
      | value | count | offset |
      | 92    | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-IGMP" with Label "Attack Edge"
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
    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Attack Edge"
      | value | count | offset |
      | 323   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-IGMP" with Label "Legitimate Traffic"
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
      | backgroundColor       | rgba(115, 134, 154, 0.1) |
      | borderColor           | rgba(115, 134, 154, 5)   |
    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 44960 | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-IGMP" with Label "Total Traffic"
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
    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Total Traffic"
      | value | count | offset |
      | 46800 | 13    | 6      |


  @SID_69
  Scenario: BDoS baseline IGMP IPv6 In bps
    Then UI Do Operation "Select" item "BDoS-IGMP IPv6"
    Then UI Do Operation "Select" item "BDoS-IGMP Inbound"
    Then UI Do Operation "Select" item "BDoS-IGMP bps"

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Suspected Edge"
      | value | count | offset |
      | 182   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Normal Edge"
      | value | count | offset |
      | 92    | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Attack Edge"
      | value | count | offset |
      | 323   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 128   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Total Traffic"
      | value | count | offset |
      | 512   | 13    | 6      |


  @SID_70
  Scenario: BDoS baseline IGMP IPv4 Out bps
    Then UI Do Operation "Select" item "BDoS-IGMP IPv4"
    Then UI Do Operation "Select" item "BDoS-IGMP Outbound"
    Then UI Do Operation "Select" item "BDoS-IGMP bps"

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Suspected Edge"
      | value | count | offset |
      | 176   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Normal Edge"
      | value | count | offset |
      | 92    | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Attack Edge"
      | value | count | offset |
      | 184   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 44880 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Total Traffic"
      | value | count | offset |
      | 46720 | 13    | 6      |


  @SID_71
  Scenario: BDoS baseline IGMP IPv6 Out bps
    Then UI Do Operation "Select" item "BDoS-IGMP IPv6"
    Then UI Do Operation "Select" item "BDoS-IGMP Outbound"
    Then UI Do Operation "Select" item "BDoS-IGMP bps"

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Suspected Edge"
      | value | count | offset |
      | 124   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Normal Edge"
      | value | count | offset |
      | 92    | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Attack Edge"
      | value | count | offset |
      | 132   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 112   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Total Traffic"
      | value | count | offset |
      | 496   | 13    | 6      |


  @SID_72
  Scenario: BDoS baseline IGMP IPv4 In pps
    Then UI Do Operation "Select" item "BDoS-IGMP IPv4"
    Then UI Do Operation "Select" item "BDoS-IGMP Inbound"
    Then UI Do Operation "Select" item "BDoS-IGMP pps"

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Suspected Edge"
      | value | count | offset |
      | 42477 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Normal Edge"
      | value | count | offset |
      | 160   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Attack Edge"
      | value | count | offset |
      | 52477 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4440  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Total Traffic"
      | value | count | offset |
      | 4900  | 13    | 6      |


  @SID_73
  Scenario: BDoS baseline IGMP IPv6 In pps
    Then UI Do Operation "Select" item "BDoS-IGMP IPv6"
    Then UI Do Operation "Select" item "BDoS-IGMP Inbound"
    Then UI Do Operation "Select" item "BDoS-IGMP pps"

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Suspected Edge"
      | value | count | offset |
      | 16001 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Normal Edge"
      | value | count | offset |
      | 160   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Attack Edge"
      | value | count | offset |
      | 17001 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4400  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Total Traffic"
      | value | count | offset |
      | 5600  | 13    | 6      |


  @SID_74
  Scenario: BDoS baseline IGMP IPv4 Out pps
    Then UI Do Operation "Select" item "BDoS-IGMP IPv4"
    Then UI Do Operation "Select" item "BDoS-IGMP Outbound"
    Then UI Do Operation "Select" item "BDoS-IGMP pps"

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Suspected Edge"
      | value | count | offset |
      | 23000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Normal Edge"
      | value | count | offset |
      | 160   | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Attack Edge"
      | value | count | offset |
      | 24000 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4420  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Total Traffic"
      | value | count | offset |
      | 4880  | 13    | 6      |


  @SID_75
  Scenario: BDoS baseline IGMP IPv6 Out pps
    Then UI Do Operation "Select" item "BDoS-IGMP IPv6"
    Then UI Do Operation "Select" item "BDoS-IGMP Outbound"
    Then UI Do Operation "Select" item "BDoS-IGMP pps"

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Suspected Edge"
      | value | count | offset |
      | 17500 | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Normal Edge"
      | value | count | offset |
      | 160   | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Attack Edge"
      | value | count | offset |
      | 27500 | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4350  | 13    | 6      |


    Then UI Validate Line Chart data "BDoS-IGMP" with Label "Total Traffic"
      | value | count | offset |
      | 5550  | 13    | 6      |
    And UI Navigate to "HOME" page via homePage
    And UI Logout

  #   END IGMP BASIC

  @SID_76
  Scenario: BDoS baseline RBAC
    Given UI Login with user "sec_admin_allDPs_pol_1_policy" and password "radware"
    And UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    When UI Do Operation "Select" item "Global Time Filter"
    When UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | pol_1    |
    Then UI Validate Line Chart attributes "BDoS-TCP SYN" with Label "Suspected Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Suspected Edge"
      | value | count | offset |
      | 464   | 13    | 6      |
    Then UI Validate Line Chart attributes "BDoS-TCP SYN" with Label "Normal Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Normal Edge"
      | value | count | offset |
      | 322   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP SYN" with Label "Attack Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Attack Edge"
      | value | count | offset |
      | 628   | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP SYN" with Label "Legitimate Traffic"
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
      | backgroundColor       | rgba(115, 134, 154, 0.1) |
      | borderColor           | rgba(115, 134, 154, 5)   |
    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Legitimate Traffic"
      | value | count | offset |
      | 44800 | 13    | 6      |

    Then UI Validate Line Chart attributes "BDoS-TCP SYN" with Label "Total Traffic"
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
    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Total Traffic"
      | value | count | offset |
      | 46640 | 13    | 6      |

    And UI Do Operation "Select" item "BDoS-TCP SYN IPv6"
    And UI Do Operation "Select" item "BDoS-TCP SYN Inbound"
    And UI Do Operation "Select" item "BDoS-TCP SYN bps"
    Then UI Validate Line Chart attributes "BDoS-TCP SYN" with Label "Suspected Edge"
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
    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Suspected Edge"
      | value | count | offset |
      | 464   | 13    | 6      |
    And UI Navigate to "HOME" page via homePage
    And UI logout and close browser


  @SID_77
  Scenario: BDoS baseline TCP-SYN RBAC negative
    Given UI Login with user "sec_admin_DP50_policy1" and password "radware"
#     When UI Open Upper Bar Item "AMS"
#    Then UI Validate Session Storage "BDoS-TCP SYN" exists "false"
#    When UI Open "Dashboards" Tab
#    Then UI Open "DP BDoS Baseline" Sub Tab
    And UI Navigate to "ANALYTICS AMS" page via homePage
    Then UI Validate Session Storage "BDoS-TCP SYN" exists "false"
    And UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    # Then UI Validate Session Storage "BDoS-TCP SYN" exists "false"
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | policy1  |
    Then UI Validate Line Chart data "BDoS-TCP SYN" with Label "Suspected Edge"
      | value | count | offset |
      | null  | 31    | 31     |
    # Then UI Validate Session Storage "BDoS-TCP SYN" exists "true"
    And UI Navigate to "HOME" page via homePage
    And UI logout and close browser

  @SID_78
  Scenario: baselines clear all widgets
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    And UI Do Operation "Select" item "Device Selection"
    Then UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | pol_1    |
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    When UI VRM Clear All Widgets

  @SID_79
  Scenario: BDoS baselines use duplicate widgets
    When UI VRM Select Widgets
      | BDoS-TCP SYN |
    And UI Do Operation "Select" item "BDoS-TCP SYN-1 IPv6"
    And UI Do Operation "Select" item "BDoS-TCP SYN-1 Outbound"
    And UI Do Operation "Select" item "BDoS-TCP SYN-1 pps"
    And UI VRM Select Widgets
      | BDoS-TCP SYN |

    Then UI Validate Line Chart data "BDoS-TCP SYN-1" with Label "Suspected Edge"
      | value   | count | offset |
      | 5000000 | 13    | 6      |
    Then UI Validate Line Chart data "BDoS-TCP SYN-1" with Label "Normal Edge"
      | value | count | offset |
      | 630   | 13    | 6      |
    Then UI Validate Line Chart data "BDoS-TCP SYN-1" with Label "Attack Edge"
      | value   | count | offset |
      | 5300000 | 13    | 6      |
    Then UI Validate Line Chart data "BDoS-TCP SYN-1" with Label "Legitimate Traffic"
      | value | count | offset |
      | 4250  | 13    | 6      |
    Then UI Validate Line Chart data "BDoS-TCP SYN-1" with Label "Total Traffic"
      | value | count | offset |
      | 5450  | 13    | 6      |

    Then UI Validate Line Chart data "BDoS-TCP SYN-2" with Label "Suspected Edge"
      | value | count | offset |
      | 464   | 13    | 6      |
    Then UI Validate Line Chart data "BDoS-TCP SYN-2" with Label "Normal Edge"
      | value | count | offset |
      | 322   | 13    | 6      |
    Then UI Validate Line Chart data "BDoS-TCP SYN-2" with Label "Attack Edge"
      | value | count | offset |
      | 628   | 13    | 6      |
    Then UI Validate Line Chart data "BDoS-TCP SYN-2" with Label "Legitimate Traffic"
      | value | count | offset |
      | 44800 | 13    | 6      |
    Then UI Validate Line Chart data "BDoS-TCP SYN-2" with Label "Total Traffic"
      | value | count | offset |
      | 46640 | 13    | 6      |

  @SID_80
  Scenario: BDoS baselines add all baselines types
    And UI VRM Select Widgets
      | BDoS-TCP SYN ACK    |
      | BDoS-TCP FIN ACK    |
      | BDoS-TCP Fragmented |
      | BDoS-TCP RST        |
      | BDoS-UDP            |
      | BDoS-UDP Fragmented |
      | BDoS-ICMP           |
      | BDoS-IGMP           |
    Then UI Do Operation "Select" item "BDoS-IGMP-1 IPv6"
    Then UI Do Operation "Select" item "BDoS-IGMP-1 Outbound"
    Then UI Do Operation "Select" item "BDoS-IGMP-1 pps"

    Then UI Do Operation "Select" item "BDoS-ICMP-1 IPv6"
    Then UI Do Operation "Select" item "BDoS-ICMP-1 Outbound"
    Then UI Do Operation "Select" item "BDoS-ICMP-1 pps"

    Then UI Do Operation "Select" item "BDoS-UDP Fragmented-1 IPv6"
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented-1 Outbound"
    Then UI Do Operation "Select" item "BDoS-UDP Fragmented-1 pps"

    Then UI Do Operation "Select" item "BDoS-TCP RST-1 IPv6"
    Then UI Do Operation "Select" item "BDoS-TCP RST-1 Outbound"
    Then UI Do Operation "Select" item "BDoS-TCP RST-1 pps"

    Then UI Do Operation "Select" item "BDoS-TCP Fragmented-1 IPv6"
    Then UI Do Operation "Select" item "BDoS-TCP Fragmented-1 Outbound"
    Then UI Do Operation "Select" item "BDoS-TCP Fragmented-1 pps"

    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK-1 IPv6"
    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK-1 Outbound"
    Then UI Do Operation "Select" item "BDoS-TCP FIN ACK-1 pps"

    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK-1 IPv6"
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK-1 Outbound"
    Then UI Do Operation "Select" item "BDoS-TCP SYN ACK-1 pps"

    Then UI Do Operation "Select" item "BDoS-UDP-1 IPv6"
    Then UI Do Operation "Select" item "BDoS-UDP-1 Outbound"
    Then UI Do Operation "Select" item "BDoS-UDP-1 pps"

    And UI Navigate to "HOME" page via homePage
    Then UI logout and close browser

  @SID_81
  Scenario: BDoS baselines check logs
    Then CLI kill all simulator attacks on current vision
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal        | NOT_EXPECTED |
