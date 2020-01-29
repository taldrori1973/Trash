@TC107643
Feature: HTTPS Server Dashboard

  @SID_1
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    * REST Delete ES index "dp-*"
#    * REST Delete ES index "dp-attack-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-daily-https-rt-*"
#    * REST Delete ES index "dp-hourly-https-rt-*"
#    * REST Delete ES index "dp-https-stats*"

  @SID_2
  Scenario: Update Policies
    Given REST Login with user "radware" and password "radware"
    Then REST Update Policies for All DPs

  @SID_3
  Scenario:Login and Navigate to HTTPS Server Dashboard
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "HTTPS Flood Dashboard" page via homePage
    Given Rest Add Policy "pol1" To DP "172.16.22.51" if Not Exist
    And Rest Add new Rule "https_servers_automation" in Profile "ProfileHttpsflood" to Policy "pol1" to DP "172.16.22.51"
#    When UI Click Button "Widgets Selection"
#    When UI Click Button "Select Outbound Widget"
#    When UI Click Button "Add Selected Widgets"

  @SID_4
  Scenario: Run DP simulator PCAPs for "HTTPS attacks"
    Given CLI simulate 2 attacks of type "HTTPS" on "DefensePro" 11 with loopDelay 5000 and wait 60 seconds

  @SID_5
  Scenario: Select Server
    When UI Click Button "Servers Button"
    When UI Set Text Field "Server Selection.Search" To "test"
    Then UI Click Button "Server Selection.Server Name" with value "test,DefensePro_172.16.22.51,pol1"
    Then UI Click Button "Server Selection.Save"
    * Sleep "60"

      ##Https Flood - Info Card

  @SID_6
  Scenario: Validate title tool bar
    Then UI Validate Text field "header HTTPS" EQUALS "HTTPS Flood Dashboard"
    Then UI Validate Text field "Selected Server" CONTAINS "Server Name"
    Then UI Validate Text field "Selected Server" CONTAINS "test"
    Then UI Validate Text field "Selected Device" CONTAINS "Device Name:"
    Then UI Validate Text field "Selected Device" CONTAINS "DefensePro_172.16.22.51"
    Then UI Validate Text field "Selected Policy" CONTAINS "Policy Name:"
    Then UI Validate Text field "Selected Policy" CONTAINS "pol1"

  ##https flood -  request size distribution

  @SID_7
  Scenario: Validate Https Flood distributed size graph data - Baseline
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Baseline"
      | value       | count | index | offset |
      | 0           | 47    | 0     | 0      |
      | 0.97232455  | 1     | 1     | 0      |
      | 0.77        | 1     | 2     | 0      |
      | 0.027675444 | 1     | 4     | 0      |

  @SID_8
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
      | backgroundColor           | #6296BA |
      | pointHoverBackgroundColor | #6296BA |
      | color                     | #6296BA |
     #| shapeType                 | line-vertical |

  @SID_9
  Scenario: Validate Https Flood distributed size graph data - Real Time Traffic
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Real-Time Traffic"
      | value      | count | index | offset |
      | 0          | 46    | 0     | 0      |
      | 0.23451911 | 1     | 1     | 0      |
      | 0.214519   | 1     | 2     | 0      |
      | 0.81       | 1     | 4     | 0      |
      | 0.5        | 1     | 49    | 0      |

  @SID_10
  Scenario: Validate Https Flood distributed size graph style - Real Time Traffic
    Then UI Validate Line Chart attributes "Request-Size Distribution" with Label "Real-Time Traffic"
      | attribute                 | value   |
      | pointRadius               | 0       |
      | fill                      | false   |
      | lineTension               | 0.35    |
      | borderCapStyle            | butt    |
      | borderDashOffset          | 0       |
      | borderJoinStyle           | miter   |
      | borderWidth               | 3       |
      | pointHoverRadius          | 0       |
      | pointHoverBorderWidth     | 0       |
      | backgroundColor           | #3C4144 |
      | pointHoverBackgroundColor | #3C4144 |
      | color                     | #3C4144 |
     #| shapeType                 | cross-dash |
      | type                      | line    |
      | borderColor               | #3C4144 |
      | pointHitRadius            | 0       |
     #| borderDash                | [10, 5]    |

  @SID_11
  Scenario: Validate Https Flood distributed size graph data - Attack Edge
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Attack Edge"
      | value      | count | index | offset |
      | 0          | 48    | 0     | 0      |
      | 1          | 1     | 1     | 0      |
      | 0.47802296 | 1     | 4     | 0      |

  @SID_11
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
      | backgroundColor           | #F39C12 |
      | pointHoverBackgroundColor | #F39C12 |
      | color                     | #F39C12 |
     #| shapeType                 | plus    |
     #| borderColor               | #F39C12 |
      | pointHitRadius            | 0       |
      | borderDash                | []      |

  @SID_13
  Scenario: Validate Https Flood distributed size graph data - Under Attack
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Under Attack"
      | value      | count | index | offset |
      | 0          | 46    | 0     | 0      |
      | 0.23451911 | 1     | 1     | 0      |
      | 0.214519   | 1     | 2     | 0      |
      | 0.81       | 1     | 4     | 0      |
      | 0.5        | 1     | 49    | 0      |

  @SID_14
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
      | backgroundColor           | #E74C3C |
      | pointHoverBackgroundColor | #E74C3C |
      | color                     | #E74C3C |
     #| shapeType                 | plus    |
     #| borderColor               | #E74C3C |
      | pointHitRadius            | 0       |
      | borderDash                | []      |

# Inbound Request per second test
  ##https flood -  HTTPS baselines

  @SID_15
  Scenario: Validate Https Flood baseline graph Transitory Baseline data
    Then UI Validate Line Chart data "Requests per Second" with Label "Transitory Baseline"
      | value | count | offset |
      | 17200 | 60    | 5      |

  @SID_16
  Scenario: Validate Https Flood baseline graph Transitory Attack Edge data
    Then UI Validate Line Chart data "Requests per Second" with Label "Transitory Attack Edge"
      | value | count | offset |
      | 21641 | 60    | 5      |

  @SID_17
  Scenario: Validate Https Flood baseline graph Total Traffic data
    Then UI Validate Line Chart data "Requests per Second" with Label "Total Traffic"
      | value   | count | offset |
      | 25060.0 | 2     | 1      |

  @SID_18
  Scenario: Validate Https Flood baseline graph Long Trend Baseline data
    Then UI Validate Line Chart data "Requests per Second" with Label "Long-Term Trend Baseline"
      | value | count | offset |
      | 5075  | 59    | 2      |

  @SID_19
  Scenario: Validate Https Flood baseline graph Long Trend Attack Edge data
    Then UI Validate Line Chart data "Requests per Second" with Label "Long-Term Trend Attack Edge"
      | value | count | offset |
      | 7002  | 60    | 2      |

  @SID_20
  Scenario: Validate Https Flood baseline graph Legitimate Traffic data
    Then UI Validate Line Chart data "Requests per Second" with Label "Legitimate Traffic"
      | value   | count | offset |
      | 17500.0 | 2     | 1      |

#  @SID_21
#  Scenario: Validate Https Flood baseline graph 24H
#    When UI Click Button "Time Picker"
#    When UI Click Button "Time Range 24H" with value "24H"
#    Then UI Validate Line Chart data "Requests per Second" with Label "Legitimate Traffic"
#      | value | count | offset |
#      | null  | 24    | 1      |
#
#  @SID_22
#  Scenario: Validate Https Flood baseline graph 12H
#    When UI Click Button "Time Picker"
#    When UI Click Button "Time Range 12H" with value "12H"
#    Then UI Validate Line Chart data "Requests per Second" with Label "Legitimate Traffic"
#      | value | count | offset |
#      | null  | 12    | 1      |
#
#  @SID_23
#  Scenario: Validate Https Flood baseline graph 6H
#    When UI Click Button "Time Picker"
#    When UI Click Button "Time Range 6H" with value "6H"
#    Then UI Validate Line Chart data "Requests per Second" with Label "Legitimate Traffic"
#      | value | count | offset |
#      | null  | 6     | 1      |
#
#  @SID_24
#  Scenario: Validate Https Flood baseline graph 3H
#    When UI Click Button "Time Picker"
#    When UI Click Button "Time Range 3H" with value "3H"
#    Then UI Validate Line Chart data "Requests per Second" with Label "Legitimate Traffic"
#      | value | count | offset |
#      | null  | 3     | 1      |
#
#  @SID_25
#  Scenario: Validate Https Flood baseline graph 1H
#    When UI Click Button "Time Picker"
#    When UI Click Button "Time Range 1H" with value "1H"
#    Then UI Validate Line Chart data "Requests per Second" with Label "Legitimate Traffic"
#      | value   | count | offset |
#      | null    | 238   | 1      |
#      | 17500.0 | 2     | 1      |
#
#  @SID_26
#  Scenario: Validate Https Flood baseline graph 30m
#    When UI Click Button "Time Picker"
#    When UI Click Button "Time Range 30m" with value "30m"
#    Then UI Validate Line Chart data "Requests per Second" with Label "Legitimate Traffic"
#      | value   | count | offset |
#      | null    | 118   | 1      |
#      | 17500.0 | 2     | 1      |
#
#  @SID_27
#  Scenario: Validate Https Flood baseline graph 15m
#    When UI Click Button "Time Picker"
#    When UI Click Button "Time Range 15m" with value "15m"
#    Then UI Validate Line Chart data "Requests per Second" with Label "Legitimate Traffic"
#      | value   | count | offset |
#      | null    | 57    | 1      |
#      | 17500.0 | 2     | 1      |

  @SID_28
  Scenario: Validate Https Flood baseline graph Transitory Baseline styling
    Then UI Validate Line Chart attributes "Requests per Second" with Label "Transitory Baseline"
      | attribute             | value   |
      | backgroundColor       | #8CBA46 |
      | steppedLine           | true    |
      | pointHoverBorderWidth | 1       |
      | borderColor           | #8CBA46 |
      | pointHitRadius        | 10      |
      | pointRadius           | 0       |
      | pointHoverRadius      | 4       |
      | borderJoinStyle       | miter   |
      | borderWidth           | 2.5     |
      | borderDashOffset      | 0       |
      | borderCapStyle        | butt    |
      | lineTension           | 0.35    |
      | fill                  | false   |

  @SID_29
  Scenario: Validate Https Flood baseline graph Transitory Attack Edge styling
    Then UI Validate Line Chart attributes "Requests per Second" with Label "Transitory Attack Edge"
      | attribute             | value          |
      | backgroundColor       | rgb(154, 1, 1) |
      | steppedLine           | true           |
      | pointHoverBorderWidth | 1              |
      | borderColor           | rgb(154, 1, 1) |
      | pointHitRadius        | 10             |
      | pointRadius           | 0              |
      | pointHoverRadius      | 4              |
      | borderJoinStyle       | miter          |
      | borderDashOffset      | 0              |
      | borderWidth           | 2.5            |
      | borderCapStyle        | butt           |
      | lineTension           | 0.35           |
      | fill                  | false          |

  @SID_30
  Scenario: Validate Https Flood baseline graph Total Traffic styling
    Then UI Validate Line Chart attributes "Requests per Second" with Label "Total Traffic"
      | attribute             | value                    |
      | backgroundColor       | rgba(169, 207, 233, 0.8) |
      | pointHoverBorderWidth | 1                        |
      | borderColor           | rgb(169, 207, 233)       |
      | pointHitRadius        | 10                       |
      | pointRadius           | 0                        |
      | pointHoverRadius      | 4                        |
      | borderJoinStyle       | miter                    |
      | borderDashOffset      | 0                        |
      | borderWidth           | 1                        |
      | borderCapStyle        | butt                     |
      | lineTension           | 0.35                     |
      | fill                  | true                     |
      | borderColor           | rgb(169, 207, 233)       |
      | color                 | rgba(169, 207, 233, 0.8) |

  @SID_31
  Scenario: Validate Https Flood baseline graph Long Trend Baseline styling
    Then UI Validate Line Chart attributes "Requests per Second" with Label "Long-Term Trend Baseline"
      | attribute             | value   |
      | backgroundColor       | #67853B |
      | steppedLine           | true    |
      | pointHoverBorderWidth | 1       |
      | borderColor           | #67853B |
      | pointHitRadius        | 10      |
      | pointRadius           | 0       |
      | pointHoverRadius      | 4       |
      | borderJoinStyle       | miter   |
      | borderDashOffset      | 0       |
      | borderWidth           | 2.5     |
      | borderCapStyle        | butt    |
      | lineTension           | 0.35    |
      | fill                  | false   |

  @SID_32
  Scenario: Validate Https Flood baseline graph Long Trend Attack Edge styling
    Then UI Validate Line Chart attributes "Requests per Second" with Label "Long-Term Trend Attack Edge"
      | attribute             | value   |
      | backgroundColor       | #EC3434 |
      | steppedLine           | true    |
      | pointHoverBorderWidth | 1       |
      | borderColor           | #EC3434 |
      | pointHitRadius        | 10      |
      | pointRadius           | 0       |
      | pointHoverRadius      | 4       |
      | borderJoinStyle       | miter   |
      | borderDashOffset      | 0       |
      | borderWidth           | 2.5     |
      | borderCapStyle        | butt    |
      | lineTension           | 0.35    |
      | fill                  | false   |

  @SID_33
  Scenario: Validate Https Flood baseline graph Legitimate Traffic styling
    Then UI Validate Line Chart attributes "Requests per Second" with Label "Legitimate Traffic"
      | attribute             | value                 |
      | backgroundColor       | rgba(66, 75, 83, 0.5) |
      | pointHoverBorderWidth | 1                     |
      | borderColor           | rgba(66, 75, 83, 0.5) |
      | pointHitRadius        | 10                    |
      | pointRadius           | 0                     |
      | pointHoverRadius      | 4                     |
      | borderJoinStyle       | miter                 |
      | borderDashOffset      | 0                     |
      | borderWidth           | 1                     |
      | borderCapStyle        | butt                  |
      | lineTension           | 0.35                  |
      | fill                  | true                  |
      | color                 | rgba(66, 75, 83, 0.5) |


  ##https Otbound tests - Response Bandwidth

#  @SID_34
#  Scenario: Validate Https Response Bandwidth graph Transitory Baseline data
#    Then UI Validate Line Chart data "Response Bandwidth" with Label "Transitory Baseline"
#      | value              | count | offset |
#      | null       | 57    | 1      |
#      | 10070.6284 | 2     | 1      |
#
#  @SID_35
#  Scenario: Validate Https Response Bandwidth graph Transitory Attack Edge data
#    Then UI Validate Line Chart data "Response Bandwidth" with Label "Transitory Attack Edge"
#      | value              | count | offset |
#      | null               | 57    | 1      |
#      | 15120.576985000002 | 2     | 1      |
#
#  @SID_36
#  Scenario: Validate Https Response Bandwidth graph Long Trend Baseline data
#    Then UI Validate Line Chart data "Response Bandwidth" with Label "Long-Term Trend Baseline"
#      | value    | count | offset |
#      | null     | 57    | 1      |
#      | 140.9568 | 2     | 1      |
#
#  @SID_37
#  Scenario: Validate Https Response Bandwidth graph Long-Term Trend Attack Edge data
#    Then UI Validate Line Chart data "Response Bandwidth" with Label "Long-Term Trend Attack Edge"
#      | value     | count | offset |
#      | null      | 57    | 1      |
#      | 240.82397 | 2     | 1      |
#
#  @SID_38
#  Scenario: Validate Https Response Bandwidth graph Legitimate Traffic data
#    Then UI Validate Line Chart data "Response Bandwidth" with Label "Real-Time Traffic"
#      | value  | count | offset |
#      | null   | 57    | 1      |
#      | 6379.5 | 2     | 1      |
#
#  @SID_39
#  Scenario: Validate Https Response Bandwidth graph 24H
#    When UI Click Button "Time Picker"
#    When UI Click Button "Time Range 24H" with value "24H"
#    Then UI Validate Line Chart data "Average Response Size" with Label "Real-Time Traffic"
#      | value | count | offset |
#      | null  | 24    | 1      |
#    Then UI Validate Line Chart data "Response Bandwidth" with Label "Long-Term Trend Attack Edge"
#      | value | count | offset |
#      | null  | 24    | 1      |
#
#  @SID_40
#  Scenario: Validate Https Response Bandwidth graph 12H
#    When UI Click Button "Time Picker"
#    When UI Click Button "Time Range 12H" with value "12H"
#    Then UI Validate Line Chart data "Average Response Size" with Label "Real-Time Traffic"
#      | value | count | offset |
#      | null  | 12    | 1      |
#    Then UI Validate Line Chart data "Response Bandwidth" with Label "Long-Term Trend Attack Edge"
#      | value | count | offset |
#      | null  | 12    | 1      |
#
#  @SID_41
#  Scenario: Validate Https Response Bandwidth graph 6H
#    When UI Click Button "Time Picker"
#    When UI Click Button "Time Range 6H" with value "6H"
#    Then UI Validate Line Chart data "Average Response Size" with Label "Real-Time Traffic"
#      | value | count | offset |
#      | null  | 6    | 1      |
#    Then UI Validate Line Chart data "Response Bandwidth" with Label "Long-Term Trend Attack Edge"
#      | value | count | offset |
#      | null  | 6    | 1      |
#
#  @SID_42
#  Scenario: Validate Https Response Bandwidth graph 3H
#    When UI Click Button "Time Picker"
#    When UI Click Button "Time Range 3H" with value "3H"
#    Then UI Validate Line Chart data "Average Response Size" with Label "Real-Time Traffic"
#      | value | count | offset |
#      | null  | 3    | 1      |
#    Then UI Validate Line Chart data "Response Bandwidth" with Label "Long-Term Trend Attack Edge"
#      | value | count | offset |
#      | null  | 3    | 1      |
#
#  @SID_43
#  Scenario: Validate Https Response Bandwidth graph 1H
#    When UI Click Button "Time Picker"
#    When UI Click Button "Time Range 1H" with value "1H"
#    Then UI Validate Line Chart data "Average Response Size" with Label "Real-Time Traffic"
#      | value | count | offset |
#      | null  | 238   | 1      |
#    Then UI Validate Line Chart data "Response Bandwidth" with Label "Long-Term Trend Attack Edge"
#      | value | count | offset |
#      | null  | 238   | 1      |
#
#  @SID_44
#  Scenario: Validate Https Response Bandwidth graph 30m
#    When UI Click Button "Time Picker"
#    When UI Click Button "Time Range 30m" with value "30m"
#    Then UI Validate Line Chart data "Average Response Size" with Label "Real-Time Traffic"
#      | value | count | offset |
#      | null  | 118   | 1      |
#    Then UI Validate Line Chart data "Response Bandwidth" with Label "Long-Term Trend Attack Edge"
#      | value | count | offset |
#      | null  | 118   | 1      |
#
#  @SID_45
#  Scenario: Validate Https Response Bandwidth graph 15m
#    When UI Click Button "Time Picker"
#    When UI Click Button "Time Range 15m" with value "15m"
#    Then UI Validate Line Chart data "Average Response Size" with Label "Real-Time Traffic"
#      | value | count | offset |
#      | null  | 58    | 1      |
#    Then UI Validate Line Chart data "Response Bandwidth" with Label "Long-Term Trend Attack Edge"
#      | value | count | offset |
#      | null  | 58    | 1      |
#
#  @SID_46
#  Scenario: Validate Https Response Bandwidth graph Transitory Baseline styling
#    Then UI Validate Line Chart attributes "Response Bandwidth" with Label "Transitory Baseline"
#      | attribute             | value   |
#      | backgroundColor       | #8CBA46 |
#      | steppedLine           | true    |
#      | pointHoverBorderWidth | 1       |
#      | borderColor           | #8CBA46 |
#      | pointHitRadius        | 10      |
#      | pointRadius           | 0       |
#      | pointHoverRadius      | 4       |
#      | borderJoinStyle       | miter   |
#      | borderWidth           | 2.5     |
#      | borderDashOffset      | 0       |
#      | borderCapStyle        | butt    |
#      | lineTension           | 0.35    |
#      | fill                  | false   |
#
#  @SID_47
#  Scenario: Validate Https Response Bandwidth graph Transitory Attack Edge styling
#    Then UI Validate Line Chart attributes "Response Bandwidth" with Label "Transitory Attack Edge"
#      | attribute             | value          |
#      | backgroundColor       | rgb(154, 1, 1) |
#      | steppedLine           | true           |
#      | pointHoverBorderWidth | 1              |
#      | borderColor           | rgb(154, 1, 1) |
#      | pointHitRadius        | 10             |
#      | pointRadius           | 0              |
#      | pointHoverRadius      | 4              |
#      | borderJoinStyle       | miter          |
#      | borderDashOffset      | 0              |
#      | borderWidth           | 2.5            |
#      | borderCapStyle        | butt           |
#      | lineTension           | 0.35           |
#      | fill                  | false          |
#
#  @SID_48
#  Scenario: Validate Https Response Bandwidth graph Long Trend Baseline styling
#    Then UI Validate Line Chart attributes "Response Bandwidth" with Label "Long-Term Trend Baseline"
#      | attribute             | value   |
#      | backgroundColor       | #67853B |
#      | steppedLine           | true    |
#      | pointHoverBorderWidth | 1       |
#      | borderColor           | #67853B |
#      | pointHitRadius        | 10      |
#      | pointRadius           | 0       |
#      | pointHoverRadius      | 4       |
#      | borderJoinStyle       | miter   |
#      | borderDashOffset      | 0       |
#      | borderWidth           | 2.5     |
#      | borderCapStyle        | butt    |
#      | lineTension           | 0.35    |
#      | fill                  | false   |
#
#  @SID_49
#  Scenario: Validate Https Response Bandwidth graph Long Trend Attack Edge styling
#    Then UI Validate Line Chart attributes "Response Bandwidth" with Label "Long-Term Trend Attack Edge"
#      | attribute             | value   |
#      | backgroundColor       | #EC3434 |
#      | steppedLine           | true    |
#      | pointHoverBorderWidth | 1       |
#      | borderColor           | #EC3434 |
#      | pointHitRadius        | 10      |
#      | pointRadius           | 0       |
#      | pointHoverRadius      | 4       |
#      | borderJoinStyle       | miter   |
#      | borderDashOffset      | 0       |
#      | borderWidth           | 2.5     |
#      | borderCapStyle        | butt    |
#      | lineTension           | 0.35    |
#      | fill                  | false   |
#
#  @SID_50
#  Scenario: Validate Https Response Bandwidth graph Legitimate Traffic styling
#    Then UI Validate Line Chart attributes "Response Bandwidth" with Label "Real-Time Traffic"
#      | attribute             | value                    |
#      | backgroundColor       | rgba(169, 207, 233, 0.8) |
#      | pointHoverBorderWidth | 1                        |
#      | borderColor           | rgba(169, 207, 233, 0.8) |
#      | pointHitRadius        | 10                       |
#      | pointRadius           | 0                        |
#      | pointHoverRadius      | 4                        |
#      | borderJoinStyle       | miter                    |
#      | borderDashOffset      | 0                        |
#      | borderWidth           | 1                        |
#      | borderCapStyle        | butt                     |
#      | lineTension           | 0.35                     |
#      | fill                  | true                     |
#      | color                 | rgba(169, 207, 233, 0.8) |
#
#  ##https Otbound tests - Average Response Size
#
#  @SID_51
#  Scenario: Validate Https Average Response Size graph Long Trend Baseline data
#    Then UI Validate Line Chart data "Average Response Size" with Label "Long-Term Trend Baseline"
#      | value              | count | offset |
#      | null               | 57    | 3      |
#      | 370.47839999999997 | 2     | 1      |
#
#  @SID_52
#  Scenario: Validate Https Average Response Size graph Long-Term Trend Attack Edge data
#    Then UI Validate Line Chart data "Average Response Size" with Label "Long-Term Trend Attack Edge"
#      | value       | count | offset |
#      | null        | 57    | 3      |
#      | 5620.761985 | 2     | 1      |
#
#  @SID_53
#  Scenario: Validate Https Average Response Size graph Legitimate Traffic data
#    Then UI Validate Line Chart data "Average Response Size" with Label "Real-Time Traffic"
#      | value  | count | offset |
#      | null   | 57    | 3      |
#      | 6129.5 | 2     | 1      |
#
#  @SID_54
#  Scenario: Validate Https Average Response Size graph Long Trend Baseline styling
#    Then UI Validate Line Chart attributes "Average Response Size" with Label "Long-Term Trend Baseline"
#      | attribute             | value   |
#      | backgroundColor       | #67853B |
#      | steppedLine           | true    |
#      | pointHoverBorderWidth | 1       |
#      | borderColor           | #67853B |
#      | pointHitRadius        | 10      |
#      | pointRadius           | 0       |
#      | pointHoverRadius      | 4       |
#      | borderJoinStyle       | miter   |
#      | borderDashOffset      | 0       |
#      | borderWidth           | 2.5     |
#      | borderCapStyle        | butt    |
#      | lineTension           | 0.35    |
#      | fill                  | false   |
#
#  @SID_55
#  Scenario: Validate Https Average Response Size graph Long Trend Attack Edge styling
#    Then UI Validate Line Chart attributes "Average Response Size" with Label "Long-Term Trend Attack Edge"
#      | attribute             | value   |
#      | backgroundColor       | #EC3434 |
#      | steppedLine           | true    |
#      | pointHoverBorderWidth | 1       |
#      | borderColor           | #EC3434 |
#      | pointHitRadius        | 10      |
#      | pointRadius           | 0       |
#      | pointHoverRadius      | 4       |
#      | borderJoinStyle       | miter   |
#      | borderDashOffset      | 0       |
#      | borderWidth           | 2.5     |
#      | borderCapStyle        | butt    |
#      | lineTension           | 0.35    |
#      | fill                  | false   |
#
#  @SID_56
#  Scenario: Validate Https Average Response Size graph Legitimate Traffic styling
#    Then UI Validate Line Chart attributes "Average Response Size" with Label "Real-Time Traffic"
#      | attribute             | value                    |
#      | backgroundColor       | rgba(169, 207, 233, 0.8) |
#      | pointHoverBorderWidth | 1                        |
#      | borderColor           | rgb(169, 207, 233)       |
#      | pointHitRadius        | 10                       |
#      | pointRadius           | 0                        |
#      | pointHoverRadius      | 4                        |
#      | borderJoinStyle       | miter                    |
#      | borderDashOffset      | 0                        |
#      | borderWidth           | 1                        |
#      | borderCapStyle        | butt                     |
#      | lineTension           | 0.35                     |
#      | fill                  | true                     |
#      | color                 | rgba(169, 207, 233, 0.8) |


# verify 1. refrest occured 2. new data displayed
  @SID_57
  Scenario: Run DP simulator PCAPs for Https Flood - Make Change
    Given CLI simulate 2 attacks of type "HTTPS-Twist" on "DefensePro" 11 with loopDelay 5000 and wait 180 seconds

  Scenario: Re-Select Server
#    When UI Open Upper Bar Item "AMS"
#    When UI Open "Dashboards" Tab
#    Then UI Open "HTTPS Servers Dashboard" Sub Tab
    When UI Click Button "Servers Button"
    When UI Set Text Field "Server Selection.Search" To "test"
    Then UI Click Button "Server Selection.Server Name" with value "test,DefensePro_172.16.22.51,pol1"
    Then UI Click Button "Server Selection.Save"

#  @SID_58
#  Scenario: Validate Https Flood distributed size graph data - Baseline - After Change
#    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Baseline"
#      | value       | count | index | offset      |
#      | 0.6         | 1     | 0     | 0.1         |
#      | 0.97232455  | 1     | 1     | 0.00000001  |
#      | 0.77        | 1     | 2     | 0.01        |
#      | 0.027675444 | 1     | 4     | 0.000000001 |
#      | 0           | 46    | 5     | 0.1         |

  @SID_59
  Scenario: Validate Https Flood distributed size graph data - Real Time Traffic - After Change
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Real-Time Traffic"
      | value      | count | index | offset |
      | 0          | 46    | 0     | 0      |
      | 0.23451911 | 1     | 1     | 0      |
      | 0.214519   | 1     | 2     | 0      |
      | 0.81       | 1     | 4     | 0      |
      | 0.5        | 1     | 49    | 0      |

  @SID_60
  Scenario: Validate Https Flood distributed size graph data - Attack Edge - After Change
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Attack Edge"
      | value      | count | index | offset     |
      | 0          | 48    | 0     | 0          |
      | 1          | 1     | 1     | 0          |
      | 0.47802296 | 1     | 4     | 0.00000001 |

  @SID_61
  Scenario: Validate Https Flood distributed size graph data - Under Attack - After Change
    Then UI Validate Line Chart data "Request-Size Distribution" with Label "Under Attack"
      | value      | count | index | offset |
      | 0          | 46    | 0     | 0      |
      | 0.23451911 | 1     | 1     | 0      |
      | 0.214519   | 1     | 2     | 0      |
      | 0.81       | 1     | 4     | 0      |
      | 0.5        | 1     | 49    | 0      |

  @SID_62
  Scenario: Logout
    Then UI logout and close browser
