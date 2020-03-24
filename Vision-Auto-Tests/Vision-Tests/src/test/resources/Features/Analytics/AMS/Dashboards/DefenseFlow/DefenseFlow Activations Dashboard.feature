@TC113208
Feature: AMS DefenseFlow Activations Dashboard

  @SID_1
  Scenario: revert DefenseFlow to snapshot
    Then Revert DefenseFlow to snapshot
    * CLI kill all simulator attacks on current vision
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "df-attack*"
    * CLI Clear vision logs

  @SID_2
  Scenario: Start Attack PO_101
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 1087000000                              |
      | $.attackVolume.bytesPerSecond        | 13921400000                             |
      | $.protectedObjectName                | "PO_101"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a102" |
      | $.networksDetails.networks[0].ip     | "70.71.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "70.71.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_3
  Scenario: Start Attack PO_102
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 2087000000                              |
      | $.attackVolume.bytesPerSecond        | 23921400000                             |
      | $.protectedObjectName                | "PO_102"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a102" |
      | $.networksDetails.networks[0].ip     | "70.72.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "70.72.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_4
  Scenario: Start Attack PO_103
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 3087000000                              |
      | $.attackVolume.bytesPerSecond        | 33921400000                             |
      | $.protectedObjectName                | "PO_103"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a103" |
      | $.networksDetails.networks[0].ip     | "70.73.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "70.73.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_5
  Scenario: Start Attack PO_104
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 4087000000                              |
      | $.attackVolume.bytesPerSecond        | 43921400000                             |
      | $.protectedObjectName                | "PO_104"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a104" |
      | $.networksDetails.networks[0].ip     | "70.74.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "70.74.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_6
  Scenario: Start Attack PO_105
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 5087000000                              |
      | $.attackVolume.bytesPerSecond        | 53921400000                             |
      | $.protectedObjectName                | "PO_105"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a105" |
      | $.networksDetails.networks[0].ip     | "70.75.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "70.75.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_7
  Scenario: Start Attack PO_106
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 6087000000                              |
      | $.attackVolume.bytesPerSecond        | 63921400000                             |
      | $.protectedObjectName                | "PO_106"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a106" |
      | $.networksDetails.networks[0].ip     | "70.76.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "70.76.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_8
  Scenario: Start Attack PO_107
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 7087000000                              |
      | $.attackVolume.bytesPerSecond        | 73921400000                             |
      | $.protectedObjectName                | "PO_107"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a107" |
      | $.networksDetails.networks[0].ip     | "70.77.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "70.77.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_9
  Scenario: Start Attack PO_108
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 8087000000                              |
      | $.attackVolume.bytesPerSecond        | 83921400000                             |
      | $.protectedObjectName                | "PO_108"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a108" |
      | $.networksDetails.networks[0].ip     | "70.78.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "70.78.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_10
  Scenario: Start Attack PO_109
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 9087000000                              |
      | $.attackVolume.bytesPerSecond        | 93921400000                             |
      | $.protectedObjectName                | "PO_109"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a109" |
      | $.networksDetails.networks[0].ip     | "70.79.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "70.79.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_11
  Scenario: Start Attack PO_111
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 11087000000                             |
      | $.attackVolume.bytesPerSecond        | 113921400000                            |
      | $.protectedObjectName                | "PO_111"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a111" |
      | $.networksDetails.networks[0].ip     | "80.71.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "80.71.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_12
  Scenario: Start Attack PO_112
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 12087000000                             |
      | $.attackVolume.bytesPerSecond        | 123921400000                            |
      | $.protectedObjectName                | "PO_112"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a112" |
      | $.networksDetails.networks[0].ip     | "80.72.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "80.72.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_13
  Scenario: Start Attack PO_113
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 13087000000                             |
      | $.attackVolume.bytesPerSecond        | 133921400000                            |
      | $.protectedObjectName                | "PO_113"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a113" |
      | $.networksDetails.networks[0].ip     | "80.73.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "80.73.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_14
  Scenario: Start Attack PO_114
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 14087000000                             |
      | $.attackVolume.bytesPerSecond        | 143921400000                            |
      | $.protectedObjectName                | "PO_114"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a114" |
      | $.networksDetails.networks[0].ip     | "80.74.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "80.74.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_15
  Scenario: Start Attack PO_115
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/ExternalAttackDetection" with label "Attack Start"
    Given The Request Body is the following Object
      | jsonPath                             | value                                   |
      | $.attackVolume.packetsPerSecond      | 15087000000                             |
      | $.attackVolume.bytesPerSecond        | 153921400000                            |
      | $.protectedObjectName                | "PO_115"                                |
      | $.externalAttackId                   | "85e6777f-75f4-4515-be96-1bb9e6997a115" |
      | $.networksDetails.networks[0].ip     | "80.75.0.0"                             |
      | $.networksDetails.networks[0].prefix | "32"                                    |
      | $.protocol                           | "UDP"                                   |
      | $.sourcePort                         | 80                                      |
      | $.destinationPort                    | 80                                      |
      | $.sourceNetworks.networks[0].ip      | "80.75.0.0"                             |
      | $.sourceNetworks.networks[0].prefix  | "32"                                    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then Validate That Response Body Contains
      | jsonPath | value |
      | $.status | "ok"  |

  @SID_16
  Scenario: waiting to fetch Data from DefenseFlow
    Then Sleep "600"

  @SID_17
  Scenario: VRM - Login to AMS DefenseFlow Analytics Dashboard
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "DefenseFlow Analytics Dashboard" page via homePage

  @SID_18
  Scenario: Validate DDoS Peak Attack per Period (bits) - All POs
    Then UI Validate Line Chart data "DDoS Peak Attack per Period" with LabelTime
      | value         | countOffset | time |
      | 1231371200000 | 100         | -0d  |

  @SID_19
  Scenario: Validate DDos Attack Activations per Period - ALL of POs
    Then UI Validate Line Chart data "DDoS Attack Activations per Period" with LabelTime
      | value | countOffset | time |
      | 14    | 0           | -0d  |

  @SID_20
  Scenario: Validate Top 10 Attacks by duration
    Then UI Validate Text field "Top 10 duration name" with params "0" CONTAINS "PO_101"
    Then UI Validate Text field "Top 10 duration IP" with params "0" CONTAINS "70.71.0.0/32"
#    Then UI Validate Text field "Top 10 duration value" with params "0" EQUALS "2752:32:51"
    Then UI Validate Text field "Top 10 duration name" with params "1" CONTAINS "PO_102"
    Then UI Validate Text field "Top 10 duration IP" with params "1" CONTAINS "- 70.72.0.0/32"
    Then UI Validate Text field "Top 10 duration name" with params "2" CONTAINS "PO_103"
    Then UI Validate Text field "Top 10 duration IP" with params "2" CONTAINS "70.73.0.0/32"
    Then UI Validate Text field "Top 10 duration name" with params "3" CONTAINS "PO_104"
    Then UI Validate Text field "Top 10 duration IP" with params "3" CONTAINS "70.74.0.0/32"
    Then UI Validate Text field "Top 10 duration name" with params "4" CONTAINS "PO_105"
    Then UI Validate Text field "Top 10 duration IP" with params "4" CONTAINS "70.75.0.0/32"
    Then UI Validate Text field "Top 10 duration name" with params "5" CONTAINS "PO_106"
    Then UI Validate Text field "Top 10 duration IP" with params "5" CONTAINS "70.76.0.0/32"
    Then UI Validate Text field "Top 10 duration name" with params "6" CONTAINS "PO_107"
    Then UI Validate Text field "Top 10 duration IP" with params "6" CONTAINS "70.77.0.0/32"
    Then UI Validate Text field "Top 10 duration name" with params "7" CONTAINS "PO_108"
    Then UI Validate Text field "Top 10 duration IP" with params "7" CONTAINS "70.78.0.0/32"
    Then UI Validate Text field "Top 10 duration name" with params "8" CONTAINS "PO_109"
    Then UI Validate Text field "Top 10 duration IP" with params "8" CONTAINS "70.79.0.0/32"
    Then UI Validate Text field "Top 10 duration name" with params "9" CONTAINS "PO_111"
    Then UI Validate Text field "Top 10 duration IP" with params "9" CONTAINS "80.71.0.0/32"

  @SID_21
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

  @SID_22
  Scenario: Top 10 Attacks by Rate(Mpps)
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "0" CONTAINS "PO_115"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "0" CONTAINS "80.75.0.0/32"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "0" EQUALS "15087.00"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "1" CONTAINS "PO_114"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "1" CONTAINS "80.74.0.0/32"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "1" EQUALS "14087.00"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "2" CONTAINS "PO_113"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "2" CONTAINS "80.73.0.0/32"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "2" EQUALS "13087.00"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "3" CONTAINS "PO_112"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "3" CONTAINS "80.72.0.0/32"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "3" EQUALS "12087.00"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "4" CONTAINS "PO_111"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "4" CONTAINS "80.71.0.0/32"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "4" EQUALS "11087.00"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "5" CONTAINS "PO_109"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "5" CONTAINS "70.79.0.0/32"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "5" EQUALS "9087.00"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "6" CONTAINS "PO_108"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "6" CONTAINS "70.78.0.0/32"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "6" EQUALS "8087.00"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "7" CONTAINS "PO_107"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "7" CONTAINS "70.77.0.0/32"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "7" EQUALS "7087.00"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "8" CONTAINS "PO_106"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "8" CONTAINS "70.76.0.0/32"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "8" EQUALS "6087.00"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "9" CONTAINS "PO_105"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "9" CONTAINS "70.75.0.0/32"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "9" EQUALS "5087.00"


  @SID_23
  Scenario: change Time range to 12H
    Then UI Do Operation "Select" item "Global Time Filter"
    Then UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "12H"

  @SID_24
  Scenario: Validate DDoS Peak Attack per Period (bits) - All POs
    Then UI Validate Line Chart data "DDoS Peak Attack per Period" with LabelTime
      | value         | countOffset | time |
      | 1231371200000 | 100         | -0d  |

  @SID_25
  Scenario: Validate DDos Attack Activations per Period - ALL of POs
    Then UI Validate Line Chart data "DDoS Attack Activations per Period" with LabelTime
      | value | countOffset | time |
      | 14    | 0           | -0d  |

  @SID_26
  Scenario: Validate Top 10 Attacks by duration
    Then UI Validate Text field "Top 10 duration name" with params "0" CONTAINS "PO_101"
    Then UI Validate Text field "Top 10 duration IP" with params "0" CONTAINS "70.71.0.0/32"
#    Then UI Validate Text field "Top 10 duration value" with params "0" EQUALS "2752:32:51"
    Then UI Validate Text field "Top 10 duration name" with params "1" CONTAINS "PO_102"
    Then UI Validate Text field "Top 10 duration IP" with params "1" CONTAINS "- 70.72.0.0/32"
    Then UI Validate Text field "Top 10 duration name" with params "2" CONTAINS "PO_103"
    Then UI Validate Text field "Top 10 duration IP" with params "2" CONTAINS "70.73.0.0/32"
    Then UI Validate Text field "Top 10 duration name" with params "3" CONTAINS "PO_104"
    Then UI Validate Text field "Top 10 duration IP" with params "3" CONTAINS "70.74.0.0/32"

  @SID_27
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

  @SID_28
  Scenario: Top 10 Attacks by Rate(Mpps)
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "0" CONTAINS "PO_115"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "0" CONTAINS "80.75.0.0/32"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "0" EQUALS "15087.00"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "1" CONTAINS "PO_114"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "1" CONTAINS "80.74.0.0/32"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "1" EQUALS "14087.00"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "2" CONTAINS "PO_113"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "2" CONTAINS "80.73.0.0/32"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "2" EQUALS "13087.00"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "3" CONTAINS "PO_112"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "3" CONTAINS "80.72.0.0/32"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "3" EQUALS "12087.00"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "4" CONTAINS "PO_111"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "4" CONTAINS "80.71.0.0/32"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "4" EQUALS "11087.00"

  @SID_29
  Scenario: select 3 POs
    When UI Do Operation "Select" item "Protected Objects"
    Then UI Select scope from dashboard and Save Filter device type "defenseflow"
      | PO_104 |
      | PO_105 |
      | PO_106 |
    Then UI Do Operation "Select" item "Global Time Filter"
    Then UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "15m"

  @SID_30
  Scenario: Validate DDoS Peak Attack per Selected Period - 3 PO's
    Then UI Validate Line Chart data "DDoS Peak Attack per Period" with LabelTime
      | value        | countOffset | time |
      | 511371200000 | 100         | -0d  |

  @SID_31
  Scenario: Validate DDoS Attack Activations per Selected Period - 3 PO's
    Then UI Validate Line Chart data "DDoS Attack Activations per Period" with LabelTime
      | value | countOffset | time |
      | 3     | 0           | -0d  |

  @SID_32
  Scenario: Validate Top 10 Attacks by duration 3 PO's
    Then UI Validate Text field "Top 10 duration name" with params "0" CONTAINS "PO_104"
    Then UI Validate Text field "Top 10 duration IP" with params "0" CONTAINS "70.74.0.0/32"
#    Then UI Validate Text field "Top 10 duration value" with params "0" EQUALS "2752:32:51"
    Then UI Validate Text field "Top 10 duration name" with params "1" CONTAINS "PO_105"
    Then UI Validate Text field "Top 10 duration IP" with params "1" CONTAINS "- 70.75.0.0/32"
    Then UI Validate Text field "Top 10 duration name" with params "2" CONTAINS "PO_106"
    Then UI Validate Text field "Top 10 duration IP" with params "2" CONTAINS "70.76.0.0/32"

  @SID_33
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

  @SID_34
  Scenario: Top 10 Attacks by Rate(Mpps) 3 PO's
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "0" CONTAINS "PO_106"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "0" CONTAINS "70.76.0.0/32"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "0" EQUALS "6087.00"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "1" CONTAINS "PO_105"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "1" CONTAINS "70.75.0.0/32"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "1" EQUALS "5087.00"
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "2" CONTAINS "PO_104"
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "2" CONTAINS "70.74.0.0/32"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "2" EQUALS "4087.00"

  @SID_35
  Scenario: Cleanup
    When UI Open "Configurations" Tab
    Then UI logout and close browser