@TC121705
Feature: LinkProof - WAN Link Statistics

  @SID_1
  Scenario: Login and Navigate to System and Network Dashboard page
    Then UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    When UI Navigate to "System and Network Dashboard" page via homePage

  @SID_2
  Scenario: Go into Link Proof dashboard in second drill
    #click on linkProof device --- add the linkproof ip
    Given UI Click Button "Device Selection"
    Then UI Select scope from dashboard and Save Filter device type "Alteon"
      | LP_simulator_101 |
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "LP_simulator_101"
    Then UI Click Button "LinkProofTab"
    Then UI Text of "WAN Link Statistics Header" equal to "WAN Link Statistics"


      #----------------!!!!!!!!!! v sign to check - write tests

  @SID_3
  Scenario: Validate Scope Instances
    Then UI Text of "Scope Instances Label" equal to "Select up to 6 WAN Link to view"
    Then UI Text of "Instances Number" equal to "6/9"
    Then UI Click Button "Expand Scope WAN Links"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label          | param                          | value |
      | WAN Link Value | Giora123                       | true  |
      | WAN Link Value | mansour_1                      | true  |
      | WAN Link Value | Prometheus_is_no_team_to_be_in | true  |
      | WAN Link Value | Ahlam_WAN                      | true  |
      | WAN Link Value | Edi_Call_Lior                  | true  |
      | WAN Link Value | EdiWanLinks                    | true  |
      | WAN Link Value | Radware1                       | false |
      | WAN Link Value | w1                             | false |
      | WAN Link Value | w2                             | false |
    Then UI Click Button "Expand Scope WAN Links"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "Giora123"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "mansour_1"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "Prometheus_is_no_team_to_be_in"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "Ahlam_WAN"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "Edi_Call_Lior"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "EdiWanLinks"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "Radware1"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "w1"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "w2"

  @SID_4
  Scenario: Validate NO instances selected in Scope Instances
    Then UI Select list of WAN Links in LinkProof ""
    Then UI Text of "Instances Number" equal to "0/9"
    Then UI Click Button "Expand Scope WAN Links"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label          | param                          | value |
      | WAN Link Value | Giora123                       | false |
      | WAN Link Value | mansour_1                      | false |
      | WAN Link Value | Prometheus_is_no_team_to_be_in | false |
      | WAN Link Value | Ahlam_WAN                      | false |
      | WAN Link Value | Edi_Call_Lior                  | false |
      | WAN Link Value | EdiWanLinks                    | false |
      | WAN Link Value | Radware1                       | false |
      | WAN Link Value | w1                             | false |
      | WAN Link Value | w2                             | false |
    Then UI Click Button "Expand Scope WAN Links"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "Giora123"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "mansour_1"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "Prometheus_is_no_team_to_be_in"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "Ahlam_WAN"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "Edi_Call_Lior"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "EdiWanLinks"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "Radware1"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "w1"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "w2"


  @SID_5
  Scenario: Validate ALL instances selected in Scope Instances
    Then UI Select list of WAN Links in LinkProof "Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks"
    Then UI Text of "Instances Number" equal to "6/9"
    Then UI Click Button "Expand Scope WAN Links"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label          | param                          | value |
      | WAN Link Value | Giora123                       | true  |
      | WAN Link Value | mansour_1                      | true  |
      | WAN Link Value | Prometheus_is_no_team_to_be_in | false |
      | WAN Link Value | Ahlam_WAN                      | false |
      | WAN Link Value | Edi_Call_Lior                  | false |
      | WAN Link Value | EdiWanLinks                    | true  |
      | WAN Link Value | Radware1                       | true  |
      | WAN Link Value | w1                             | true  |
      | WAN Link Value | w2                             | true  |
    Then UI Click Button "Expand Scope WAN Links"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "Giora123"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "mansour_1"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "Prometheus_is_no_team_to_be_in"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "Ahlam_WAN"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "Edi_Call_Lior"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "EdiWanLinks"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "Radware1"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "w1"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "w2"


  @SID_6
  Scenario: Validate more than the max instances selected in Scope Instances
    Then UI Select list of WAN Links in LinkProof "Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks,Ahlam_WAN"
    Then UI Text of "Instances Number" equal to "6/9"
    Then UI Click Button "Expand Scope WAN Links"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label          | param                          | value |
      | WAN Link Value | Giora123                       | true  |
      | WAN Link Value | mansour_1                      | true  |
      | WAN Link Value | Prometheus_is_no_team_to_be_in | false |
      | WAN Link Value | Ahlam_WAN                      | false |
      | WAN Link Value | Edi_Call_Lior                  | false |
      | WAN Link Value | EdiWanLinks                    | true  |
      | WAN Link Value | Radware1                       | true  |
      | WAN Link Value | w1                             | true  |
      | WAN Link Value | w2                             | true  |
    Then UI Click Button "Expand Scope WAN Links"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "Giora123"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "mansour_1"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "Prometheus_is_no_team_to_be_in"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "Ahlam_WAN"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "Edi_Call_Lior"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "EdiWanLinks"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "Radware1"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "w1"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "w2"

    #-------------------------------------------Upload Throughput------------------------------
  @SID_7
  Scenario: Upload Throughput chart Header
    Then UI Text of "Upload Throughput Header" equal to "Upload Throughput"

  @SID_8
  Scenario: validate Upload Throughput chart with ALL WAN Links
    Then UI Validate Line Chart attributes "LinkProofLineChartUpload" with Label "WAN1"
      | attribute       | value   |
      | backgroundColor | #9B97F4 |
    Then UI Validate Line Chart attributes "LinkProofLineChartUpload" with Label "WAN1"
      | attribute   | value   |
      | borderColor | #9B97F4 |
    Then UI Validate Line Chart attributes "LinkProofLineChartUpload" with Label "WAN1"
      | attribute | value |
      | fill      | false |

  @SID_9
  Scenario: validate Upload Throughput chart with parts of WAN Links
    Then UI Click Button "CheckBox" with value "WAN1"
    Then UI Validate Line Chart attributes "LinkProofLineChartUpload" with Label "Throughput"
      | value | min |
      | 11    | 10  |

  @SID_10
  Scenario: validate Upload Throughput chart with NO WAN Links
    Then UI Select list of WAN Links in LinkProof ""
    Then UI Validate Line Chart attributes "LinkProofLineChartUpload" with Label "Throughput"
      | value | min |
      | 11    | 10  |

  @SID_11
  Scenario: validate  Upload Throughput chart with 1 WAN Links
    Then UI Select list of WAN Links in LinkProof "WAN Link 1"
    Then UI Validate Line Chart attributes "LinkProofLineChartUpload" with Label "Throughput"
      | value | min |
      | 11    | 10  |

  @SID_12
  Scenario: validate  Upload Throughput chart with NO WAN Links checked
    Then UI Select list of WAN Links in LinkProof "WAN Link 1"
    Then UI Click Button "CheckBox" with value "WAN Link 1"
    Then UI Validate Line Chart attributes "LinkProofLineChartUpload" with Label "Throughput"
      | value | min |
      | 11    | 10  |


   ################################ Download Throughput #####################################################

  @SID_13
  Scenario: Download Throughput chart
    Then UI Text of "Download Throughput Header" equal to "Download Throughput"

  @SID_14
  Scenario: validate bps Download Throughput chart with ALL WAN Links
    When UI Click Button "bpsSwitch"
    Then UI Validate Line Chart attributes "Download Throughput" with Label "Throughput"
      | value | min |
      | 11    | 10  |

  @SID_15
  Scenario: validate Usage Download Throughput chart with ALL WAN Links
    When UI Click Button "usageSwitch"
    Then UI Validate Line Chart attributes "Download Throughput" with Label "Throughput"
      | value | min |
      | 11    | 10  |

  @SID_16
  Scenario: validate bps Download Throughput chart with part of WAN Links
    Then UI Click Button "CheckBox" with value "WAN Link 1"
    When UI Click Button "bpsSwitch"
    Then UI Validate Line Chart attributes "Download Throughput" with Label "Throughput"
      | value | min |
      | 11    | 10  |

  @SID_17
  Scenario: validate bps Download Throughput chart with part of WAN Links
    Then UI Click Button "CheckBox" with value "WAN Link 1"
    When UI Click Button "usageSwitch"
    Then UI Validate Line Chart attributes "Download Throughput" with Label "Throughput"
      | value | min |
      | 11    | 10  |


       ################################ CEC #####################################################

  @SID_18
  Scenario: Download CEC chart
    Then UI Text of "CEC Header" equal to "CEC"

  @SID_19
  Scenario: validate CEC chart null data
    Then UI Select list of WAN Links in LinkProof ""
    #check null data

  @SID_20
  Scenario: validate CEC chart with part of WAN Links
    Then UI Select list of WAN Links in LinkProof "w1,w2"
    Then UI Validate Line Chart attributes "LinkProofLineChartCEC" with Label "w1"
      | value | min |
      | 11    | 10  |
    Then UI Validate Line Chart attributes "LinkProofLineChartCEC" with Label "w2"
      | value | min |
      | 11    | 10  |

  @SID_21
  Scenario: validate CEC chart with part of WAN Links
    Then UI Click Button "CheckBox" with value "w1"
    Then UI Validate Line Chart attributes "LinkProofLineChartCEC" with Label "w2"
      | value | min |
      | 12    | 10  |

  @SID_22
  Scenario: validate CEC chart with ALL WAN Links
    Then UI Select list of WAN Links in LinkProof "w1,w2,w3,w4,w5,w6,w7"
    Then UI Validate Line Chart attributes "LinkProofLineChartCEC" with Label "w1"
      | value | min |
      | 11    | 10  |
    Then UI Validate Line Chart attributes "LinkProofLineChartCEC" with Label "w2"
      | value | min |
      | 11    | 10  |
    Then UI Validate Line Chart attributes "LinkProofLineChartCEC" with Label "w3"
      | value | min |
      | 11    | 10  |
    Then UI Validate Line Chart attributes "LinkProofLineChartCEC" with Label "w4"
      | value | min |
      | 11    | 10  |
    Then UI Validate Line Chart attributes "LinkProofLineChartCEC" with Label "w5"
      | value | min |
      | 11    | 10  |
    Then UI Validate Line Chart attributes "LinkProofLineChartCEC" with Label "w6"
      | value | min |
      | 11    | 10  |

  @SID_23
  Scenario: validate CEC chart with part of WAN Links
    Then UI Click Button "CheckBox" with value "w1,w2"
    Then UI Validate Line Chart attributes "LinkProofLineChartCEC" with Label "w3"
      | value | min |
      | 11    | 10  |
    Then UI Validate Line Chart attributes "LinkProofLineChartCEC" with Label "w4"
      | value | min |
      | 11    | 10  |
    Then UI Validate Line Chart attributes "LinkProofLineChartCEC" with Label "w5"
      | value | min |
      | 11    | 10  |
    Then UI Validate Line Chart attributes "LinkProofLineChartCEC" with Label "w6"
      | value | min |
      | 11    | 10  |

  @SID_24
  Scenario: Logout
    Then UI logout and close browser