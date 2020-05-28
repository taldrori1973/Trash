@TC114854
Feature: Attack Table - Expand Table Row

  
  @SID_1
  Scenario: Clean system data before Traffic Bandwidth test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-tr*"
    * REST Delete ES index "dp-atta*"
    * CLI Clear vision logs

  
  @SID_2
  Scenario: Run DP simulator PCAPs for Traffic Bandwidth
    When REST Login with user "radware" and password "radware"
    Then CLI simulate 1 attacks of type "rest_traffic_filter" on "DefensePro" 11
    Given CLI simulate 1 attacks of type "HTTPS" on "DefensePro" 11
    Given CLI simulate 1 attacks of type "IP_FEED_Modified" on "DefensePro" 11
    Then CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 11 and wait 210 seconds


  @SID_3
  Scenario:  login
    Given UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "2"
    And UI Navigate to "DefensePro Attacks" page via homePage
    When UI set "Auto Refresh" switch button to "off"
    When UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1H"


####################  BehavioralDOS attack tables ####################################################
  
  @SID_4
  Scenario:  validate tables for BehavioralDOS
    Then UI search row table in searchLabel "tableSearch" with text "BehavioralDOS"
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Policy Name" findBy cellValue "bdos1"
    Then UI Validate Element Existence By Label "Expand Tables View" if Exists "true" with value "info,Characteristics,realTimeSignature"

  
  @SID_5
  Scenario Outline:  validate date of Info table - BehavioralDOS
    Then Validate Expand "Info" Table with label "<label>" Equals to "<value>"

    Examples:
      | label             | value                          |
      |Risk               |High                            |
      |Radware ID         |82                              |
      |Direction          |Unknown                         |
      |Action Type        |Forward                         |
      |Attack ID          |46-1407864418                   |
      |Physical Port      |0                               |
      |Total Packet Count |0                               |
      |VLAN               |N/A                             |
      |MPLS RD            |N/A                             |
      |Source port        |0                               |

  @SID_6
  Scenario Outline:  validate date of Characteristics table - BehavioralDOS
    Then Validate Expand "Characteristics" Table with label "<label>" Equals to "<value>"

    Examples:
      | label                   | value            |
      |Flow Label               |0                 |
      |TCP Sequence Number      |-                 |
      |ToS                      |-                 |
      |TTL                      |255               |
      |State                    |Blocking          |
  
  @SID_7
  Scenario:  validate date of Real Time Signature table - BehavioralDOS
    Then Validate Expand  "Real Time Signature" table
      |Name       |index |value |
      |operator   |1     | OR   |
      |parameter  |1     |Fragment Offset|
      |value      |1     |2              |


  ####################  DNS attack tables ####################################################
  
  @SID_8
  Scenario:  validate tables for DNS
    Then UI search row table in searchLabel "tableSearch" with text "DNS"
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Policy Name" findBy cellValue "BDOS"
    Then UI Validate Element Existence By Label "Expand Tables View" if Exists "true" with value "info,Characteristics,realTimeSignature"

  
  @SID_9
  Scenario Outline:  validate date of Info table - DNS
    Then Validate Expand "Info" Table with label "<label>" Equals to "<value>"

    Examples:
      | label             | value                          |
      |Risk               |High                            |
      |Radware ID         |450                             |
      |Direction          |Unknown                         |
      |Action Type        |Forward                         |
      |Attack ID          |7447-1402580209                 |
      |Physical Port      |0                               |
      |Total Packet Count |0                               |
      |VLAN               |N/A                             |
      |MPLS RD            |N/A                             |
      |Source port        |0                               |

  @SID_10
  Scenario Outline:  validate date of Characteristics table - DNS
    Then Validate Expand "Characteristics" Table with label "<label>" Equals to "<value>"

    Examples:
      | label                   | value                                  |
      |DNS Query                |client_dnstypeA-a8000004                |
      |DN an Query Count        |0                                       |
      |TTL                      |255                                     |
      |DNS ID                   |1                                       |
      |DNS Query Count          |1                                       |
      |L4 Checksum              |10117                                   |
      |State                    |Blocking                                |
      |Mitigation Action        |Signature Challenge                     |

  @SID_11
  Scenario:  validate date of Real Time Signature table - DNS
    Then Validate Expand  "Real Time Signature" table
      |Name       |index |value   |
      |operator   |1     | OR     |
      |parameter  |1     |Checksum|
      |value      |1     |10117   |


  ####################  Https attack tables ####################################################
  
  @SID_12
  Scenario:  validate tables for Https
    Then UI search row table in searchLabel "tableSearch" with text "Https"
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy index 0 findBy columnName "Policy Name" findBy cellValue "pol1"
    Then UI Validate Element Existence By Label "Expand Tables View" if Exists "true" with value "info,Characteristics"

  
  @SID_13
  Scenario Outline:  validate date of Info table - Https
    Then Validate Expand "Info" Table with label "<label>" Equals to "<value>"

    Examples:
      | label             | value                          |
      |Risk               |High                            |
      |Radware ID         |700                             |
      |Direction          |Unknown                         |
      |Action Type        |Drop                            |
      |Attack ID          |33-                           |
      |Physical Port      |0                               |
      |Total Packet Count |0                               |
      |VLAN               |N/A                             |
      |MPLS RD            |N/A                             |
      |Source port        |0                               |

  @SID_14
  Scenario Outline:  validate date of Characteristics table - Https
    Then Validate Expand "Characteristics" Table with label "<label>" Equals to "<value>"

    Examples:
      | label                           | value                                  |
      |Detection Method                 |By Volume of HTTPS Responses               |
      |Mitigation method                |Rate Limit Suspected Attackers          |
      |Auth. Method                     |302 Redirect                            |
      |Total Suspect Sources            |16                           |
      |Total Req. Challenged            |14                                      |
      |Total Sources Challenged         |1,200,009                                      |
      |Toatl Sources Auth.              |13                               |
      |Total Attackers Sources          |17                              |
      |Auth List Util.                  |15%                                     |
      |Req. Per Sec                     |759                                     |
      |Transitory Baseline Value        |25 RPS                                  |
      |Transitory Attack Edge Value     |26 RPS                                  |
      |Long Term Trend Baseline Value   |141 RPS                                 |
      |Long Term Trend Attack Edge Value|241 RPS                                 |

    ####################  SynFlood attack tables ####################################################
  
  @SID_15
  Scenario:  validate tables for SynFlood
    Then UI search row table in searchLabel "tableSearch" with text "SynFlood"
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Volume" findBy cellValue "13.43 MB"
    Then UI Validate Element Existence By Label "Expand Tables View" if Exists "true" with value "info,Characteristics"

  
  @SID_16
  Scenario Outline:  validate date of Info table - SynFlood
    Then Validate Expand "Info" Table with label "<label>" Equals to "<value>"

    Examples:
      | label             | value                          |
      |Risk               |Medium                          |
      |Radware ID         |200000                          |
      |Direction          |Unknown                         |
      |Action Type        |Challenge                       |
      |Attack ID          |137-1414505529                  |
      |Physical Port      |Multiple                        |
      |Total Packet Count |223,890                         |
      |VLAN               |Multiple                        |
      |MPLS RD            |Multiple                        |
      |Source port        |Multiple                        |

  @SID_17
  Scenario Outline:  validate date of Characteristics table - SynFlood
    Then Validate Expand "Characteristics" Table with label "<label>" Equals to "<value>"

    Examples:
      | label                   | value               |
      |Activation Threshold     |2500                 |
      |TCP Challenge            |Transparent Proxy    |
      |TCP Auth. List           |0                    |
      |HTTP Challenge           |Cloud Authentication |
      |HTTP Auth. List          |0                    |

        ####################  DOS attack tables ####################################################
  
  @SID_18
  Scenario:  validate tables for DOS
    Then UI search row table in searchLabel "tableSearch" with text "DOSShield"
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Policy Name" findBy cellValue "pph_9Pkt_lmt_252.1"
    Then UI Validate Element Existence By Label "Expand Tables View" if Exists "true" with value "info,Characteristics"

  
  @SID_19
  Scenario Outline:  validate date of Info table - DOS
    Then Validate Expand "Info" Table with label "<label>" Equals to "<value>"

    Examples:
      | label             | value                          |
      |Risk               |Medium                          |
      |Radware ID         |600006                          |
      |Direction          |In                              |
      |Action Type        |Forward                         |
      |Attack ID          |45-1426496290                   |
      |Physical Port      |3                               |
      |Total Packet Count |1,296                          |
      |VLAN               |N/A                             |
      |MPLS RD            |N/A                             |
      |Source port        |49743                           |

  @SID_20
  Scenario Outline:  validate date of Characteristics table - DOS
    Then Validate Expand "Characteristics" Table with label "<label>" Equals to "<value>"

    Examples:
      | label                   | value           |
      |Current Packet Rate      |7                 |
      |Average Packet Rate      |30                 |
      |Protected Host           |198.18.252.1                 |

####################  AntiScanning attack tables ####################################################
  
  @SID_21
  Scenario:  validate tables for AntiScanning
    Then UI search row table in searchLabel "tableSearch" with text "AntiScanning"
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Volume" findBy cellValue "1.22 MB"
    Then UI Validate Element Existence By Label "Expand Tables View" if Exists "true" with value "info,Characteristics,realTimeSignature,top-attacks-sessions"

  
  @SID_22
  Scenario Outline:  validate date of Info table - AntiScanning
    Then Validate Expand "Info" Table with label "<label>" Equals to "<value>"

    Examples:
      | label             | value                   |
      |Risk               |Medium                   |
      |Radware ID         |350                      |
      |Direction          |Unknown                  |
      |Action Type        |Drop                     |
      |Attack ID          |136-1414505529           |
      |Physical Port      |0                        |
      |Total Packet Count |9,867                    |
      |VLAN               |N/A                      |
      |MPLS RD            |N/A                      |
      |Source port        |0                        |

  @SID_23
  Scenario Outline:  validate date of Characteristics table - AntiScanning
    Then Validate Expand "Characteristics" Table with label "<label>" Equals to "<value>"

    Examples:
      | label                   | value          |
      |Action Reason            |Configuration   |
      |Blocking Duration        |10              |

  
  @SID_24
  Scenario:  validate date of Real Time Signature table - AntiScanning
    Then Validate Expand  "Real Time Signature" table
      |Name       |index |value   |
      |operator   |1     | OR     |
      |parameter  |1     |Destination Ip|
      |value      |1     |10.10.1.200   |
      |operator   |5     | AND     |
      |parameter  |5     |Ttl|
      |value      |5     |255|
      |operator   |6     | AND     |
      |parameter  |6     |Packet Size|
      |value      |6     |124|
      |operator   |7     | AND     |
      |parameter  |7     |Sequence Number|
      |value      |7     |123456|

  @SID_25
  Scenario:  validate date of Scan Details table - AntiScanning
    Then Validate Expand  "Scan Details" table
      |Name            |index |value   |
      |destinationIp   |0     | 10.10.1.200     |
      |destinationPort |0     |22261|
      |flag            |0     |SYN   |
      |destinationIp   |1     | 10.10.1.200     |
      |destinationPort |1     |35915|
      |flag            |1     |SYN   |
      |destinationIp   |2     | 10.10.1.200     |
      |destinationPort |2     |57620|
      |flag            |2     |SYN   |
      |destinationIp   |3     | 10.10.1.200     |
      |destinationPort |3     |61578|
      |flag            |3     |SYN   |
      |destinationIp   |4     | 10.10.1.200     |
      |destinationPort |4     |30789|
      |flag            |4     |SYN   |
      |destinationIp   |5     | 10.10.1.200     |
      |destinationPort |5     |6931|
      |flag            |5     |SYN   |
      |destinationIp   |6     | 10.10.1.200     |
      |destinationPort |6     |43704|
      |flag            |6     |SYN   |
      |destinationIp   |7     | 10.10.1.200     |
      |destinationPort |7     |54620|
      |flag            |7     |SYN   |
      |destinationIp   |8     | 10.10.1.200     |
      |destinationPort |8     |27310|
      |flag            |8     |SYN   |
      |destinationIp   |9     | 10.10.1.200     |
      |destinationPort |9     |46423|
      |flag            |9     |SYN   |
      |destinationIp   |10     | 10.10.1.200     |
      |destinationPort |10     |64922|
      |flag            |10     |SYN   |
      |destinationIp   |11     | 10.10.1.200     |
      |destinationPort |11     |32461|
      |flag            |11     |SYN   |
  ####################  Traffic Filter attack tables ####################################################
  
  @SID_26
  Scenario:  validate tables for Traffic Filter
    Then UI search row table in searchLabel "tableSearch" with text "Traffic"
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Attack Category" findBy cellValue "Traffic Filters"
    Then UI Validate Element Existence By Label "Expand Tables View" if Exists "true" with value "info,Characteristics"

  
  @SID_27
  Scenario Outline:  validate date of Info table - Traffic Filter
    Then Validate Expand "Info" Table with label "<label>" Equals to "<value>"

    Examples:
      | label             | value             |
      |Risk               |High               |
      |Radware ID         |700000             |
      |Direction          |In                 |
      |Action Type        |Drop               |
      |Attack ID          |34-2206430105      |
      |Physical Port      |MNG-1              |
      |Total Packet Count |18,770             |
      |VLAN               |N/A                |
      |MPLS RD            |N/A                |
      |Source port        |1024               |

  @SID_28
  Scenario Outline:  validate date of Characteristics table - Traffic Filter
    Then Validate Expand "Characteristics" Table with label "<label>" Equals to "<value>"

    Examples:
      | label               | value           |
      |Filter Name          |f1               |
      |Filter ID            |700000           |


    ####################  ACL attack tables ####################################################

  @SID_29
  Scenario:  validate tables for ACL
    Then UI search row table in searchLabel "tableSearch" with text "RWTI_4076"
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Policy Name" findBy cellValue "RWTI_4076"
    Then UI Validate Element Existence By Label "Expand Tables View" if Exists "true" with value "info"


  @SID_30
  Scenario Outline:  validate date of Info table - ACL
    Then Validate Expand "Info" Table with label "<label>" Equals to "<value>"

    Examples:
      | label             | value             |
      |Risk               |Low               |
      |Radware ID         |8             |
      |Direction          |In                 |
      |Action Type        |Drop               |
      |Attack ID          |4109-103     |
      |Physical Port      |T-1              |
      |Total Packet Count |128             |
      |VLAN               |N/A                |
      |MPLS RD            |N/A                |
      |Source port        |0               |



    ####################  StatefulACL attack tables ####################################################

  @SID_31
  Scenario:  validate tables for StatefulACL
    Then UI search row table in searchLabel "tableSearch" with text "StatefulACL"
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Policy Name" findBy cellValue "shlomi"
    Then UI Validate Element Existence By Label "Expand Tables View" if Exists "true" with value "info"


  @SID_32
  Scenario Outline:  validate date of Info table - StatefulACL
    Then Validate Expand "Info" Table with label "<label>" Equals to "<value>"

    Examples:
      | label             | value             |
      |Risk               |Medium               |
      |Radware ID         |748             |
      |Direction          |In                 |
      |Action Type        |Drop               |
      |Attack ID          |7448-1402580209      |
      |Physical Port      |1              |
      |Total Packet Count |1             |
      |VLAN               |N/A                |
      |MPLS RD            |N/A                |
      |Source port        |1024               |


    ####################  Anomalies attack tables ####################################################

  @SID_33
  Scenario:  validate tables for Anomalies
    Then UI search row table in searchLabel "tableSearch" with text "Anomalies"
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Protocol" findBy cellValue "IP"
    Then UI Validate Element Existence By Label "Expand Tables View" if Exists "true" with value "info"


  @SID_34
  Scenario Outline:  validate date of Info table - Anomalies
    Then Validate Expand "Info" Table with label "<label>" Equals to "<value>"

    Examples:
      | label             | value             |
      |Risk               |Low               |
      |Radware ID         |103             |
      |Direction          |Unknown                 |
      |Action Type        |Drop               |
      |Attack ID          |8-1402580209      |
      |Physical Port      |0              |
      |Total Packet Count |1             |
      |VLAN               |N/A                |
      |MPLS RD            |N/A                |
      |Source port        |0              |



    ####################  Intrusions attack tables ####################################################

  @SID_35
  Scenario:  validate tables for Intrusions
    Then UI search row table in searchLabel "tableSearch" with text "Intrusions"
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Attack Name" findBy cellValue "sign_seets3"
    Then UI Validate Element Existence By Label "Expand Tables View" if Exists "true" with value "info"


  @SID_36
  Scenario Outline:  validate date of Info table - Intrusions
    Then Validate Expand "Info" Table with label "<label>" Equals to "<value>"

    Examples:
      | label             | value             |
      |Risk               |High               |
      |Radware ID         |320029             |
      |Direction          |In                 |
      |Action Type        |Http200OkResetDest               |
      |Attack ID          |531-1429625097      |
      |Physical Port      |MNG-1              |
      |Total Packet Count |1             |
      |VLAN               |N/A                |
      |MPLS RD            |N/A                |
      |Source port        |26505              |


  @SID_37
  Scenario: Traffic Cleanup
    Given UI logout and close browser
