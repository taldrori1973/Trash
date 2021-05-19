
Feature: LinkProof - WAN Link Statistics

  @SID_1
  Scenario: Login and Navigate to System and Network Dashboard page
    Then UI Login with user "radware" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage
  
  @SID_2
  Scenario: Go into Link Proof dashboard in second drill
    #click on linkProof device --- add the linkproof ip
    Given UI Click Button "Device Selection"
    Then UI Select scope from dashboard and Save Filter device type "linkProof"
      | linkProof |
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "linkProof"
    Then UI Click Button "LinkProofTab"
    Then UI Text of "WAN Link Statistics Header" equal to "WAN Link Statistics"

  @SID_3
  Scenario: Validate Scope Instances
    Then UI Text of "Scope Instances Label" equal to "Select up to 6 WAN Link to view"
    Then UI Text of "Instances Number" equal to "6/6"
    #defult 6 selected

  #----------------!!!!!!!!!! v sign to check - write tests

  @SID_4
  Scenario: Validate NO instances selected in Scope Instances
    Then UI Select list of WAN Links in LinkProof ""
    Then UI Text of "Instances Number" equal to "0/6"
    Then UI Click Button "Expand Scope WAN Links"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label          | param | value |
      | WAN Link Value | WAN1  | false |
      | WAN Link Value | WAN2  | false |
      | WAN Link Value | WAN3  | false |
      | WAN Link Value | WAN4  | false |
      | WAN Link Value | WAN5  | false |
      | WAN Link Value | WAN6  | false |
      | WAN Link Value | WAN7  | false |
    Then UI Click Button "Expand Scope WAN Links"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "WAN1"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "WAN2"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "WAN3"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "WAN4"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "WAN5"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "WAN6"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "WAN7"

    
  @SID_5
  Scenario: Validate ALL instances selected in Scope Instances
    Then UI Select list of WAN Links in LinkProof "WAN1,WAN2,WAN3,WAN4,WAN5,WAN6"
    Then UI Text of "Instances Number" equal to "6/6"
    Then UI Click Button "Expand Scope WAN Links"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label          | param | value |
      | WAN Link Value | WAN1  | true  |
      | WAN Link Value | WAN2  | true  |
      | WAN Link Value | WAN3  | true  |
      | WAN Link Value | WAN4  | true  |
      | WAN Link Value | WAN5  | true  |
      | WAN Link Value | WAN6  | true  |
      | WAN Link Value | WAN7  | false |
    Then UI Click Button "Expand Scope WAN Links"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "WAN1"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "WAN2"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "WAN3"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "WAN4"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "WAN5"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "WAN6"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "WAN7"


  @SID_6
  Scenario: Validate more than the max instances selected in Scope Instances
    Then UI Select list of WAN Links in LinkProof "WAN1,WAN2,WAN3,WAN4,WAN5,WAN6,WAN7"
    Then UI Text of "Instances Number" equal to "6/6"
    Then UI Click Button "Expand Scope WAN Links"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label          | param | value |
      | WAN Link Value | WAN1  | true  |
      | WAN Link Value | WAN2  | true  |
      | WAN Link Value | WAN3  | true  |
      | WAN Link Value | WAN4  | true  |
      | WAN Link Value | WAN5  | true  |
      | WAN Link Value | WAN6  | true  |
      | WAN Link Value | WAN7  | false |
    Then UI Click Button "Expand Scope WAN Links"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "WAN1"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "WAN2"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "WAN3"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "WAN4"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "WAN5"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "true" with value "WAN6"
    Then UI Validate Element Existence By Label "WAN Link checkbox" if Exists "false" with value "WAN7"

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
      | 11    | 10  |

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