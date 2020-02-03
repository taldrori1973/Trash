@TC113208
Feature: AMS DefenseFlow Activations Dashboard

  @SID_1
  Scenario: VRM - Login to AMS DefenseFlow Analytics Dashboard
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Open Upper Bar Item "AMS"
    Then Sleep "7"
    When UI Open "Dashboards" Tab
    Then UI Open "DefenseFlow Analytics Dashboard" Sub Tab

  @SID_2
  Scenario: Validate DDos Attack Volume per Day (bits) - All POs
    Then UI Validate Line Chart data "DDoS Peak Attack per Selected Period" with LabelTime
      | value         | countOffset | time |
      | 1231371200000 | 100         | -0d  |

  @SID_3
  Scenario: Validate DDos Attack Activations per Day - ALL of POs
    Then UI Validate Line Chart data "DDoS Attack Activations per Selected Period" with LabelTime
      | value | countOffset | time |
      | 16    | 0           | -0d  |

  @SID_4
  Scenario: Validate Top 10 Attacks by duration
    Then UI Validate Text field "Top 10 duration name" with params "0" CONTAINS "PO_1"
    Then UI Validate Text field "Top 10 duration IP" with params "0" CONTAINS "50.50.0.0/16"
#    Then UI Validate Text field "Top 10 duration value" with params "0" EQUALS "2752:32:51"
    Then UI Validate Text field "Top 10 duration name" with params "1" CONTAINS "PO_101"
    Then UI Validate Text field "Top 10 duration IP" with params "1" CONTAINS "- 70.70.0.0/16"
    Then UI Validate Text field "Top 10 duration name" with params "2" CONTAINS "PO_10"
    Then UI Validate Text field "Top 10 duration IP" with params "2" CONTAINS "40.40.0.0/32"
    Then UI Validate Text field "Top 10 duration name" with params "3" CONTAINS "PO_102"
    Then UI Validate Text field "Top 10 duration IP" with params "3" CONTAINS "70.71.0.0/16"
    Then UI Validate Text field "Top 10 duration name" with params "4" CONTAINS "PO_103"
    Then UI Validate Text field "Top 10 duration IP" with params "4" CONTAINS "70.72.0.0/32"
    Then UI Validate Text field "Top 10 duration name" with params "5" CONTAINS "PO_104"
    Then UI Validate Text field "Top 10 duration IP" with params "5" CONTAINS "70.74.0.0/32"
    Then UI Validate Text field "Top 10 duration name" with params "6" CONTAINS "PO_105"
    Then UI Validate Text field "Top 10 duration IP" with params "6" CONTAINS "70.75.0.0/32"
    Then UI Validate Text field "Top 10 duration name" with params "7" CONTAINS "PO_106"
    Then UI Validate Text field "Top 10 duration IP" with params "7" CONTAINS "70.76.0.0/32"
    Then UI Validate Text field "Top 10 duration name" with params "8" CONTAINS "PO_107"
    Then UI Validate Text field "Top 10 duration IP" with params "8" CONTAINS "70.77.0.0/32"
    Then UI Validate Text field "Top 10 duration name" with params "9" CONTAINS "PO_108"
    Then UI Validate Text field "Top 10 duration IP" with params "9" CONTAINS "70.78.0.0/32"

  @SID_5
  Scenario: Validate Top 10 Attacks by Rate(Gbps)
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "0" CONTAINS "PO_115"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "0" CONTAINS "80.75.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "0" EQUALS "1231.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "1" CONTAINS "PO_114"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "1" CONTAINS "80.74.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "1" EQUALS "1151.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "2" CONTAINS "PO_113"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "2" CONTAINS "80.73.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "2" EQUALS "1071.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "3" CONTAINS "PO_112"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "3" CONTAINS "80.72.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "3" EQUALS "991.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "4" CONTAINS "PO_111"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "4" CONTAINS "80.71.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "4" EQUALS "911.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "5" CONTAINS "PO_109"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "5" CONTAINS "70.79.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "5" EQUALS "751.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "6" CONTAINS "PO_108"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "6" CONTAINS "70.78.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "6" EQUALS "671.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "7" CONTAINS "PO_107"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "7" CONTAINS "70.77.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "7" EQUALS "591.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "8" CONTAINS "PO_106"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "8" CONTAINS "70.76.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "8" EQUALS "511.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "9" CONTAINS "PO_105"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "9" CONTAINS "70.75.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "9" EQUALS "431.37"

  @SID_6
  Scenario: Top 10 Attacks by Rate(Mpps)
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "0" CONTAINS "PO_115"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "0" CONTAINS "80.75.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "0" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "1" CONTAINS "PO_114"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "1" CONTAINS "80.74.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "1" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "2" CONTAINS "PO_113"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "2" CONTAINS "80.73.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "2" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "3" CONTAINS "PO_112"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "3" CONTAINS "80.72.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "3" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "4" CONTAINS "PO_111"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "4" CONTAINS "80.71.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "4" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "5" CONTAINS "PO_109"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "5" CONTAINS "70.79.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "5" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "6" CONTAINS "PO_108"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "6" CONTAINS "70.78.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "6" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "7" CONTAINS "PO_107"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "7" CONTAINS "70.77.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "7" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "8" CONTAINS "PO_106"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "8" CONTAINS "70.76.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "8" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "9" CONTAINS "PO_105"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "9" CONTAINS "70.75.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "9" EQUALS "14388.08"


  @SID_7
  Scenario: change Time range to 24H
    Then UI Do Operation "Select" item "Global Time Filter"
    Then UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "24H"

#  Scenario: Validate Top 10 Attacks by duration
#    Then UI Validate Text field "Top 10 duration name" with params "0" CONTAINS "PO_1"
#    Then UI Validate Text field "Top 10 duration IP" with params "0" CONTAINS "50.50.0.0/16"
##    Then UI Validate Text field "Top 10 duration value" with params "0" EQUALS "2752:32:51"
#    Then UI Validate Text field "Top 10 duration name" with params "1" CONTAINS "PO_101"
#    Then UI Validate Text field "Top 10 duration IP" with params "1" CONTAINS "- 70.70.0.0/16"
#    Then UI Validate Text field "Top 10 duration name" with params "2" CONTAINS "PO_10"
#    Then UI Validate Text field "Top 10 duration IP" with params "2" CONTAINS "40.40.0.0/32"
#    Then UI Validate Text field "Top 10 duration name" with params "3" CONTAINS "PO_102"
#    Then UI Validate Text field "Top 10 duration IP" with params "3" CONTAINS "70.71.0.0/16"
#    Then UI Validate Text field "Top 10 duration name" with params "4" CONTAINS "PO_103"
#    Then UI Validate Text field "Top 10 duration IP" with params "4" CONTAINS "70.72.0.0/32"
#    Then UI Validate Text field "Top 10 duration name" with params "5" CONTAINS "PO_104"
#    Then UI Validate Text field "Top 10 duration IP" with params "5" CONTAINS "70.74.0.0/32"
#    Then UI Validate Text field "Top 10 duration name" with params "6" CONTAINS "PO_105"
#    Then UI Validate Text field "Top 10 duration IP" with params "6" CONTAINS "70.75.0.0/32"
#    Then UI Validate Text field "Top 10 duration name" with params "7" CONTAINS "PO_106"
#    Then UI Validate Text field "Top 10 duration IP" with params "7" CONTAINS "70.76.0.0/32"
#    Then UI Validate Text field "Top 10 duration name" with params "8" CONTAINS "PO_107"
#    Then UI Validate Text field "Top 10 duration IP" with params "8" CONTAINS "70.77.0.0/32"
#    Then UI Validate Text field "Top 10 duration name" with params "9" CONTAINS "PO_108"
#    Then UI Validate Text field "Top 10 duration IP" with params "9" CONTAINS "70.78.0.0/32"

  @SID_8
  Scenario: Validate Top 10 Attacks by Rate(Gbps)
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "0" CONTAINS "PO_115"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "0" CONTAINS "80.75.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "0" EQUALS "1231.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "1" CONTAINS "PO_114"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "1" CONTAINS "80.74.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "1" EQUALS "1151.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "2" CONTAINS "PO_113"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "2" CONTAINS "80.73.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "2" EQUALS "1071.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "3" CONTAINS "PO_112"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "3" CONTAINS "80.72.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "3" EQUALS "991.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "4" CONTAINS "PO_111"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "4" CONTAINS "80.71.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "4" EQUALS "911.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "5" CONTAINS "PO_109"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "5" CONTAINS "70.79.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "5" EQUALS "751.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "6" CONTAINS "PO_108"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "6" CONTAINS "70.78.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "6" EQUALS "671.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "7" CONTAINS "PO_107"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "7" CONTAINS "70.77.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "7" EQUALS "591.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "8" CONTAINS "PO_106"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "8" CONTAINS "70.76.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "8" EQUALS "511.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "9" CONTAINS "PO_105"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "9" CONTAINS "70.75.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "9" EQUALS "431.37"

  @SID_9
  Scenario: Top 10 Attacks by Rate(Mpps)
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "0" CONTAINS "PO_115"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "0" CONTAINS "80.75.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "0" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "1" CONTAINS "PO_114"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "1" CONTAINS "80.74.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "1" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "2" CONTAINS "PO_113"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "2" CONTAINS "80.73.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "2" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "3" CONTAINS "PO_112"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "3" CONTAINS "80.72.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "3" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "4" CONTAINS "PO_111"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "4" CONTAINS "80.71.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "4" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "5" CONTAINS "PO_109"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "5" CONTAINS "70.79.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "5" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "6" CONTAINS "PO_108"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "6" CONTAINS "70.78.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "6" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "7" CONTAINS "PO_107"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "7" CONTAINS "70.77.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "7" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "8" CONTAINS "PO_106"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "8" CONTAINS "70.76.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "8" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "9" CONTAINS "PO_105"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "9" CONTAINS "70.75.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "9" EQUALS "14388.08"

  @SID_10
  Scenario: select 3 POs
    When UI Do Operation "Select" item "Protected Objects"
    Then UI Select scope from dashboard and Save Filter device type "defenseflow"
      | PO_104 |
      | PO_105 |
      | PO_106 |
    Then UI Do Operation "Select" item "Global Time Filter"
    Then UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "15m"

  @SID_11
  Scenario: Validate DDoS Peak Attack per Selected Period - 3 PO's
    Then UI Validate Line Chart data "DDoS Peak Attack per Selected Period" with LabelTime
      | value        | countOffset | time |
      | 511371200000 | 100         | -0d  |

  @SID_12
  Scenario: Validate DDoS Attack Activations per Selected Period - 3 PO's
    Then UI Validate Line Chart data "DDoS Attack Activations per Selected Period" with LabelTime
      | value | countOffset | time |
      | 3     | 0           | -0d  |

  @SID_13
  Scenario: Validate Top 10 Attacks by duration 3 PO's
    Then UI Validate Text field "Top 10 duration name" with params "0" CONTAINS "PO_104"
    Then UI Validate Text field "Top 10 duration IP" with params "0" CONTAINS "70.74.0.0/32"
#    Then UI Validate Text field "Top 10 duration value" with params "0" EQUALS "2752:32:51"
    Then UI Validate Text field "Top 10 duration name" with params "1" CONTAINS "PO_105"
    Then UI Validate Text field "Top 10 duration IP" with params "1" CONTAINS "- 70.75.0.0/32"
    Then UI Validate Text field "Top 10 duration name" with params "2" CONTAINS "PO_106"
    Then UI Validate Text field "Top 10 duration IP" with params "2" CONTAINS "70.76.0.0/32"

  @SID_14
  Scenario: Validate Top 10 Attacks by Rate(Gbps) 3 PO's
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "0" CONTAINS "PO_106"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "0" CONTAINS "70.76.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "0" EQUALS "511.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "1" CONTAINS "PO_105"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "1" CONTAINS "70.75.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "1" EQUALS "431.37"
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "2" CONTAINS "PO_104"
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "2" CONTAINS "70.74.0.0/32"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "2" EQUALS "351.37"

  @SID_15
  Scenario: Top 10 Attacks by Rate(Mpps) 3 PO's
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "0" CONTAINS "PO_106"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "0" CONTAINS "70.76.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "0" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "1" CONTAINS "PO_105"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "1" CONTAINS "70.75.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "1" EQUALS "14388.08"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "2" CONTAINS "PO_104"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "2" CONTAINS "70.74.0.0/32"
#    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "2" EQUALS "14388.08"

  @SID_16
  Scenario: Cleanup
    When UI Open "Configurations" Tab
    Then UI logout and close browser