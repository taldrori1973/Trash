
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
    Then CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 11 and wait 210 seconds

  @Test12
  @SID_3
  Scenario:  login
    Given UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Sleep "2"
    And UI Navigate to "DefensePro Attacks" page via homePage
    When UI set "Auto Refresh" switch button to "off"

####################  BehavioralDOS attack tables ####################################################
  @Test12
  @SID_4
  Scenario:  validate tables for BehavioralDOS
    Then UI search row table in searchLabel "tableSearch" with text "BehavioralDOS"
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Policy Name" findBy cellValue "bdos1"
    Then UI Validate Element Existence By Label "Expand Tables View" if Exists "true" with value "info,Characteristics,realTimeSignature"

  @Test12
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
      |TOS                      |-                 |
      |TTL                      |255               |
      |State                    |Blocking          |

#    Then UI Validate Table record values by columns with elementLabel "RealTime\ Signature" findBy index 1
#      | columnName | value |
#      | Protocol   | IP    |


  ####################  DNS attack tables ####################################################
  @Test12
  @SID_8
  Scenario:  validate tables for DNS
    Then UI search row table in searchLabel "tableSearch" with text "DNS"
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Policy Name" findBy cellValue "BDOS"
    Then UI Validate Element Existence By Label "Expand Tables View" if Exists "true" with value "info,Characteristics,realTimeSignature"

  @Test12
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

#    Then UI Validate Table record values by columns with elementLabel "RealTime\ Signature" findBy index 1
#      | columnName | value |
#      | Protocol   | IP    |


  ####################  Https attack tables ####################################################
  @Test12
  @SID_12
  Scenario:  validate tables for Https
    Then UI search row table in searchLabel "tableSearch" with text "Https"
    Then UI click Table row by keyValue or Index with elementLabel "Attacks Table" findBy columnName "Policy Name" findBy cellValue "pol1"
    Then UI Validate Element Existence By Label "Expand Tables View" if Exists "true" with value "info,Characteristics"

  @Test12
  @SID_13
  Scenario Outline:  validate date of Info table - Https
    Then Validate Expand "Info" Table with label "<label>" Equals to "<value>"

    Examples:
      | label             | value                          |
      |Risk               |High                            |
      |Radware ID         |700                             |
      |Direction          |Unknown                         |
      |Action Type        |Drop                            |
      |Attack ID          |33-19                           |
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
      |Detection Method                 |By Rate of HTTPS Requests               |
      |Mitigation method                |Rate Limit Suspected Attackers          |
      |Auth. Method                     |302 Redirect                            |
      |Total Suspect Sources            |2,559,994,656                           |
      |Total Req. Challenged            |14                                      |
      |Total Sources Challenged         |12                                      |
      |Toatl Sources Auth.              |1,088,888                               |
      |Total Attackers Sources          |1,700,000                               |
      |Auth List Util.                  |15%                                     |
      |Req. Per Sec                     |759                                     |
      |Transitory Baseline Value        |25                                      |
      |Transitory Attack Edge Value     |26                                      |
      |Long Term Trend Baseline Value   |141                                     |
      |Long Term Trend Attack Edge Value|241                                     |