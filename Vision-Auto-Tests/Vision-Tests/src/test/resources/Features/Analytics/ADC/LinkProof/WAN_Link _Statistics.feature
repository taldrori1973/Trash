Feature: LinkProof - WAN Link Statistics

  @SID_1
  Scenario: Login and Navigate to System and Network Dashboard page
    Then UI Login with user "radware" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage

  @SID_2
  Scenario: Go into Link Proof dashboard in second drill
    #click on linkProof device --- add the linkproof ip
    Given UI Click Button "Device Selection"
    Then UI Select scope from dashboard and Save Filter device type "Alteon"
      | Alteon_50.50.101.22 |
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
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
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label          | param | value |
      | WAN Link Value | 1     | false |
      | WAN Link Value | 2     | false |
      | WAN Link Value | 3     | false |
      | WAN Link Value | 4     | false |
      | WAN Link Value | 5     | false |
      | WAN Link Value | 6     | false |
      | WAN Link Value | 7     | false |
      | WAN Link Value | 8     | false |
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "false" with value "1"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "false" with value "2"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "false" with value "3"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "false" with value "4"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "false" with value "5"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "false" with value "6"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "false" with value "7"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "false" with value "8"

  @SID_5
  Scenario: Validate ALL instances selected in Scope Instances
    Then UI Select list of WAN Links in LinkProof "WAN Link 1, WAN Link 2, WAN Link 3, WAN Link 4, WAN Link 5, WAN Link 6"
    Then UI Text of "Instances Number" equal to "6/6"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label          | param | value |
      | WAN Link Value | 1     | true  |
      | WAN Link Value | 2     | true  |
      | WAN Link Value | 3     | true  |
      | WAN Link Value | 4     | true  |
      | WAN Link Value | 5     | true  |
      | WAN Link Value | 6     | true  |
      | WAN Link Value | 7     | false |
      | WAN Link Value | 8     | false |
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "true" with value "1"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "true" with value "2"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "true" with value "3"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "true" with value "4"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "true" with value "5"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "true" with value "6"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "false" with value "7"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "false" with value "8"


  @SID_6
  Scenario: Validate more than the max instances selected in Scope Instances
    Then UI Select list of WAN Links in LinkProof "WAN Link 1,WAN Link 2,WAN Link 3,WAN Link 4,WAN Link 5,WAN Link 6,WAN Link 7"
    Then UI Text of "Instances Number" equal to "6/6"
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label          | param | value |
      | WAN Link Value | 1     | true  |
      | WAN Link Value | 2     | true  |
      | WAN Link Value | 3     | true  |
      | WAN Link Value | 4     | true  |
      | WAN Link Value | 5     | true  |
      | WAN Link Value | 6     | true  |
      | WAN Link Value | 7     | false |
      | WAN Link Value | 8     | false |
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "true" with value "1"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "true" with value "2"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "true" with value "3"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "true" with value "4"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "true" with value "5"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "true" with value "6"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "false" with value "7"
    Then UI Validate Element Existence By Label "WAN Link Value" if Exists "false" with value "8"

    #-------------------------------------------Upload Throughput------------------------------
  @SID_7
  Scenario: Upload Throughput chart Header
    Then UI Text of "Upload Throughput Header" equal to "Upload Throughput"

  @SID_8
  Scenario: validate Upload Throughput chart with ALL WAN Links
    Then UI Validate Line Chart attributes "Upload Throughput" with Label "Throughput"
      | value | min |
      | 11    | 10  |

  @SID_9
  Scenario: validate Upload Throughput chart with parts of WAN Links
    Then UI Click Button "CheckBox" with value "WAN Link 1"
    Then UI Validate Line Chart attributes "Upload Throughput" with Label "Throughput"
      | value | min |
      | 11    | 10  |

  @SID_10
  Scenario: validate Upload Throughput chart with NO WAN Links
    Then UI Select list of WAN Links in LinkProof ""
    Then UI Validate Line Chart attributes "Upload Throughput" with Label "Throughput"
      | value | min |
      | 11    | 10  |

  @SID_11
  Scenario: validate  Upload Throughput chart with 1 WAN Links
    Then UI Select list of WAN Links in LinkProof "WAN Link 1"
    Then UI Validate Line Chart attributes "Upload Throughput" with Label "Throughput"
      | value | min |
      | 11    | 10  |

  @SID_12
  Scenario: validate  Upload Throughput chart with NO WAN Links checked
    Then UI Select list of WAN Links in LinkProof "WAN Link 1"
    Then UI Click Button "CheckBox" with value "WAN Link 1"
    Then UI Validate Line Chart attributes "Upload Throughput" with Label "Throughput"
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