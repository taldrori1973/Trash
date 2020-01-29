@TC106779
Feature: Traffic Throughput and PPS Widgets
# pre-requisites: simulator that will include 30 ports and will contain fields with various types of data units. e.g. K, M, G, T, P, E
  # select simulator 50.50.101.22 for these tests
  @SID_1
  Scenario: Login and go to ADC dashboards
    Then REST Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Open Upper Bar Item "ADC"
    Then UI Open "Dashboards" Tab
    Then UI Open "Application Dashboard" Sub Tab
    Then UI Open "Configurations" Tab
    Then UI Open Upper Bar Item "ADC"

  @SID_2
  Scenario: Go to ADC network dashboard of one ADC
    Then Sleep "90"
    Then UI Open "Dashboards" Tab
    Then UI Open "Network and System Dashboard" Sub Tab
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"

  @SID_3
  Scenario: Validate default data(15 minutes) - transmit packets

  # validation of PPS transmit widget
    #    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_01"
#      | value | count | offset |
#      | 996999.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_02"
#      | value | count | offset |
#      | 26.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_03"
#      | value | count | offset |
#      | 36.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_04"
#      | value | count | offset |
#      | 46.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_05"
#      | value | count | offset |
#      | 56.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_6"
#      | value | count | offset |
#      | 66.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_7"
#      | value | count | offset |
#      | 76.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_8"
#      | value | count | offset |
#      | 86.0   | 17    | 15     |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_01"
      | value    | count | offset |
      | 996999.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_02"
      | value | count | offset |
      | 26.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_03"
      | value | count | offset |
      | 36.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_04"
      | value | count | offset |
      | 46.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_05"
      | value | count | offset |
      | 56.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_06"
      | value | count | offset |
      | 66.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_07"
      | value | count | offset |
      | 76.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_08"
      | value | count | offset |
      | 86.0  | 17    | 15     |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with size "8"

  @SID_4
  Scenario: Validate default data(15 minutes) - transmit bw
  # ============================================== #
    # = validation of throughput transmit widget =
    # ============================================
    #    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_01"
#      | value | count | offset |
#      | 12.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_02"
#      | value | count | offset |
#      | 22.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_03"
#      | value | count | offset |
#      | 32.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_04"
#      | value | count | offset |
#      | 42.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_05"
#      | value | count | offset |
#      | 52.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_6"
#      | value | count | offset |
#      | 62.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_7"
#      | value | count | offset |
#      | 72.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_8"
#      | value | count | offset |
#      | 82.0   | 17    | 15     |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_01"
      | value | count | offset |
      | 12.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_02"
      | value | count | offset |
      | 22.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_03"
      | value | count | offset |
      | 32.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_04"
      | value | count | offset |
      | 42.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_05"
      | value | count | offset |
      | 52.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_06"
      | value | count | offset |
      |  62.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_07"
      | value | count | offset |
      |  72.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_08"
      | value | count | offset |
      |  82.0 | 17    | 15     |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with size "8"

  @SID_5
  Scenario: Validate default data(15 minutes) - receive bw
    # ============================================== #
    # = validation of throughput received widget =
    # ============================================
    Then UI Do Operation "Select" item "trafficThroughput receiveButton"
    Then UI Do Operation "Select" item "trafficPackets receiveButton"
    Then UI Validate Switch button "trafficThroughput receiveButton" with params "" isSelected "true"
    Then UI Validate Switch button "trafficPackets receiveButton" with params "" isSelected "true"
    #    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_01"
#      | value | count | offset |
#      | 11.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_02"
#      | value | count | offset |
#      | 21.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_03"
#      | value | count | offset |
#      | 31.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_04"
#      | value | count | offset |
#      | 41.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_05"
#      | value | count | offset |
#      | 51.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_6"
#      | value | count | offset |
#      | 61.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_7"
#      | value | count | offset |
#      | 71.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_8"
#      | value | count | offset |
#      | 81.0   | 17    | 15     |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_01"
      | value | count | offset |
      | 11.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_02"
      | value | count | offset |
      | 21.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_03"
      | value | count | offset |
      | 31.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_04"
      | value | count | offset |
      | 41.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_05"
      | value | count | offset |
      | 51.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_06"
      | value | count | offset |
      |  61.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_07"
      | value | count | offset |
      |  71.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_08"
      | value | count | offset |
      |  81.0 | 17    | 15     |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with size "8"

  @SID_6
  Scenario: Validate default data(15 minutes) - receive packets
    # ============================================== #
    # = validation of PPS received widget =
    # ============================================

    #    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_01"
#      | value | count | offset |
#      | 9.9999998430674944E17   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_02"
#      | value | count | offset |
#      | 25.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_03"
#      | value | count | offset |
#      | 35.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_04"
#      | value | count | offset |
#      | 45.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_05"
#      | value | count | offset |
#      | 55.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_6"
#      | value | count | offset |
#      | 65.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_7"
#      | value | count | offset |
#      | 75.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_8"
#      | value | count | offset |
#      | 85.0   | 17    | 15     |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_01"
      | value                 | count | offset |
      | 9.9999998430674944E17 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_02"
      | value | count | offset |
      | 25.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_03"
      | value | count | offset |
      | 35.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_04"
      | value | count | offset |
      | 45.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_05"
      | value | count | offset |
      | 55.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_06"
      | value | count | offset |
      |  65.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_07"
      | value | count | offset |
      |  75.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_08"
      | value | count | offset |
      |  85.0 | 17    | 15     |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with size "8"
#    Then UI Validate Line Chart rate time with "30s" for "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" chart


    # this step validates the transmit first since it's the default selection - use device 50.50.101.22 for these tests
  @SID_7
  Scenario: Validate data by user ports selection - transmit packets
    Then UI Click List item by selector id "Ports List" with label "port_01" checkUncheck state "false"
    Then UI Click List item by selector id "Ports List" with label "port_05" checkUncheck state "false"
    Then UI Click List item by selector id "Ports List" with label "port_19" checkUncheck state "true"

    Then UI Do Operation "Select" item "trafficThroughput transmitButton"
    Then UI Do Operation "Select" item "trafficPackets transmitButton"
    Then UI Validate Switch button "trafficThroughput transmitButton" with params "" isSelected "true"
    Then UI Validate Switch button "trafficPackets transmitButton" with params "" isSelected "true"


  # validation of PPS transmit widget
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_02"
#      | value | count | offset |
#      | 26.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_03"
#      | value | count | offset |
#      | 36.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_04"
#      | value | count | offset |
#      | 46.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_6"
#      | value | count | offset |
#      | 66.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_7"
#      | value | count | offset |
#      | 76.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_8"
#      | value | count | offset |
#      | 86.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_19"
#      | value | count | offset |
#      | 196.0   | 17    | 15     |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_02"
      | value | count | offset |
      | 26.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_03"
      | value | count | offset |
      | 36.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_04"
      | value | count | offset |
      | 46.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_06"
      | value | count | offset |
      |  66.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_07"
      | value | count | offset |
      |  76.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_08"
      | value | count | offset |
      |  86.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_19"
      | value | count | offset |
      | 196.0 | 17    | 15     |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with size "7"

  @SID_8
  Scenario: Validate data by user ports selection - transmit bw
  # ============================================== #
    # = validation of throughput transmit widget =
    # ============================================
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_02"
#      | value | count | offset |
#      | 22.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_03"
#      | value | count | offset |
#      | 32.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_04"
#      | value | count | offset |
#      | 42.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_6"
#      | value | count | offset |
#      | 62.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_7"
#      | value | count | offset |
#      | 72.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_8"
#      | value | count | offset |
#      | 82.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_19"
#      | value | count | offset |
#      | 192.0   | 17    | 15     |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_02"
      | value | count | offset |
      | 22.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_03"
      | value | count | offset |
      | 32.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_04"
      | value | count | offset |
      | 42.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_06"
      | value | count | offset |
      |  62.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_07"
      | value | count | offset |
      |  72.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_08"
      | value | count | offset |
      |  82.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_19"
      | value | count | offset |
      | 192.0 | 17    | 15     |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with size "7"

  @SID_9
  Scenario: Validate data by user ports selection - received bw
    # ============================================== #
    # = validation of throughput received widget =
    # ============================================

    Then UI Do Operation "Select" item "trafficThroughput receiveButton"
    Then UI Do Operation "Select" item "trafficPackets receiveButton"

#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_02"
#      | value | count | offset |
#      | 21.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_03"
#      | value | count | offset |
#      | 31.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_04"
#      | value | count | offset |
#      | 41.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_6"
#      | value | count | offset |
#      | 61.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_7"
#      | value | count | offset |
#      | 71.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_8"
#      | value | count | offset |
#      | 81.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_19"
#      | value | count | offset |
#      | 191.0   | 17    | 15     |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_02"
      | value | count | offset |
      | 21.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_03"
      | value | count | offset |
      | 31.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_04"
      | value | count | offset |
      | 41.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_06"
      | value | count | offset |
      |  61.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_07"
      | value | count | offset |
      |  71.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_08"
      | value | count | offset |
      |  81.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_19"
      | value | count | offset |
      | 191.0 | 17    | 15     |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with size "7"

  @SID_10
  Scenario: Validate data by user ports selection - received packets
    # ============================================== #
    # = validation of PPS received widget =
    # ============================================

#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_02"
#      | value | count | offset |
#      | 25.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_03"
#      | value | count | offset |
#      | 35.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_04"
#      | value | count | offset |
#      | 45.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_6"
#      | value | count | offset |
#      | 65.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_7"
#      | value | count | offset |
#      | 75.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_8"
#      | value | count | offset |
#      | 85.0   | 17    | 15     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_19"
#      | value | count | offset |
#      | 195.0   | 17    | 15     |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_02"
      | value | count | offset |
      | 25.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_03"
      | value | count | offset |
      | 35.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_04"
      | value | count | offset |
      | 45.0  | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_06"
      | value | count | offset |
      |  65.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_07"
      | value | count | offset |
      |  75.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_08"
      | value | count | offset |
      |  85.0 | 17    | 15     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_19"
      | value | count | offset |
      | 195.0 | 17    | 15     |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with size "7"

    Then UI Do Operation "Select" item "trafficThroughput transmitButton"
    Then UI Do Operation "Select" item "trafficPackets receiveButton"

  @SID_11
  Scenario: Validate user selection persistence in refresh
    * Sleep "30"
    Then UI Validate Switch button "trafficThroughput transmitButton" with params "" isSelected "true"
    Then UI Validate Switch button "trafficPackets receiveButton" with params "" isSelected "true"
    Then UI Validate Switch button "trafficThroughput receiveButton" with params "" isSelected "false"
    Then UI Validate Switch button "trafficPackets transmitButton" with params "" isSelected "false"
    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with size "7"
    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with size "7"
    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with size "7"
    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with size "7"

  @SID_12
  Scenario: Validate data by various time selections - quick range transmit packets
    Then UI Do Operation "Select" item "trafficThroughput transmitButton"
    Then UI Do Operation "Select" item "trafficPackets transmitButton"
    Then UI Do Operation "Select" item "Global Time Filter"
    Then UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "30m"

  # validation of PPS transmit widget
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_02"
#      | value | count | offset |
#      | 26.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_03"
#      | value | count | offset |
#      | 36.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_04"
#      | value | count | offset |
#      | 46.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_6"
#      | value | count | offset |
#      | 66.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_7"
#      | value | count | offset |
#      | 76.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_8"
#      | value | count | offset |
#      | 86.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_19"
#      | value | count | offset |
#      | 196.0   | 32    | 30     |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_02"
      | value | count | offset |
      | 26.0  | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_03"
      | value | count | offset |
      | 36.0  | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_04"
      | value | count | offset |
      | 46.0  | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_06"
      | value | count | offset |
      |  66.0 | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_07"
      | value | count | offset |
      |  76.0 | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_08"
      | value | count | offset |
      |  86.0 | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_19"
      | value | count | offset |
      | 196.0 | 32    | 30     |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with size "7"

  @SID_13
  Scenario: Validate data by various time selections - quick range transmit bw
  # ============================================== #
    # = validation of throughput transmit widget =
    # ============================================
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_02"
#      | value | count | offset |
#      | 22.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_03"
#      | value | count | offset |
#      | 32.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_04"
#      | value | count | offset |
#      | 42.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_6"
#      | value | count | offset |
#      | 62.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_7"
#      | value | count | offset |
#      | 72.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_8"
#      | value | count | offset |
#      | 82.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_19"
#      | value | count | offset |
#      | 192.0   | 32    | 30     |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_02"
      | value | count | offset |
      | 22.0  | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_03"
      | value | count | offset |
      | 32.0  | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_04"
      | value | count | offset |
      | 42.0  | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_06"
      | value | count | offset |
      |  62.0 | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_07"
      | value | count | offset |
      |  72.0 | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_08"
      | value | count | offset |
      |  82.0 | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_19"
      | value | count | offset |
      | 192.0 | 32    | 30     |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with size "7"

    Then UI Do Operation "Select" item "trafficPackets receiveButton"
    Then UI Do Operation "Select" item "trafficThroughput receiveButton"

  @SID_14
  Scenario: Validate data by various time selections - quick range received bw
    # ============================================== #
    # = validation of throughput received widget =
    # ============================================

#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_02"
#      | value | count | offset |
#      | 21.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_03"
#      | value | count | offset |
#      | 31.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_04"
#      | value | count | offset |
#      | 41.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_6"
#      | value | count | offset |
#      | 61.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_7"
#      | value | count | offset |
#      | 71.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_8"
#      | value | count | offset |
#      | 81.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_19"
#      | value | count | offset |
#      | 191.0   | 32    | 30     |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_02"
      | value | count | offset |
      | 21.0  | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_03"
      | value | count | offset |
      | 31.0  | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_04"
      | value | count | offset |
      | 41.0  | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_06"
      | value | count | offset |
      |  61.0 | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_07"
      | value | count | offset |
      |  71.0 | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_08"
      | value | count | offset |
      |  81.0 | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_19"
      | value | count | offset |
      | 191.0 | 32    | 30     |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with size "7"

  @SID_15
  Scenario: Validate data by various time selections - quick range received packets
    # ============================================== #
    # = validation of PPS received widget =
    # ============================================

#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_02"
#      | value | count | offset |
#      | 25.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_03"
#      | value | count | offset |
#      | 35.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_04"
#      | value | count | offset |
#      | 45.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_6"
#      | value | count | offset |
#      | 65.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_7"
#      | value | count | offset |
#      | 75.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_8"
#      | value | count | offset |
#      | 85.0   | 32    | 30     |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_19"
#      | value | count | offset |
#      | 195.0   | 32    | 30     |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_02"
      | value | count | offset |
      | 25.0  | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_03"
      | value | count | offset |
      | 35.0  | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_04"
      | value | count | offset |
      | 45.0  | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_06"
      | value | count | offset |
      |  65.0 | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_07"
      | value | count | offset |
      |  75.0 | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_08"
      | value | count | offset |
      |  85.0 | 32    | 30     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_19"
      | value | count | offset |
      | 195.0 | 32    | 30     |

  @SID_15
  Scenario: Validate data by various time selections - 1H transmit packets
    Then UI Do Operation "Select" item "Global Time Filter"
    Then UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1H"
    Then UI Do Operation "Select" item "trafficPackets transmitButton"
    Then UI Do Operation "Select" item "trafficThroughput transmitButton"

  # validation of PPS transmit widget
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_02"
#      | value | count | offset |
#      | 26.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_03"
#      | value | count | offset |
#      | 36.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_04"
#      | value | count | offset |
#      | 46.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_6"
#      | value | count | offset |
#      | 66.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_7"
#      | value | count | offset |
#      | 76.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_8"
#      | value | count | offset |
#      | 86.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_19"
#      | value | count | offset |
#      | 196.0   | 120    | 1      |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_02"
      | value | count | offset |
      | 26.0  | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_03"
      | value | count | offset |
      | 36.0  | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_04"
      | value | count | offset |
      | 46.0  | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_06"
      | value | count | offset |
      |  66.0 | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_07"
      | value | count | offset |
      |  76.0 | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_08"
      | value | count | offset |
      |  86.0 | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_19"
      | value | count | offset |
      | 196.0 | 64    | 60     |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with size "7"

  @SID_16
  Scenario: Validate data by various time selections - 1H transmit bw
  # ============================================== #
    # = validation of throughput transmit widget =
    # ============================================
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_02"
#      | value | count | offset |
#      | 22.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_03"
#      | value | count | offset |
#      | 32.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_04"
#      | value | count | offset |
#      | 42.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_6"
#      | value | count | offset |
#      | 62.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_7"
#      | value | count | offset |
#      | 72.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_8"
#      | value | count | offset |
#      | 82.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_19"
#      | value | count | offset |
#      | 192.0   | 120    | 1      |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_02"
      | value | count | offset |
      | 22.0  | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_03"
      | value | count | offset |
      | 32.0  | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_04"
      | value | count | offset |
      | 42.0  | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_06"
      | value | count | offset |
      |  62.0 | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_07"
      | value | count | offset |
      |  72.0 | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_08"
      | value | count | offset |
      |  82.0 | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_19"
      | value | count | offset |
      | 192.0 | 64    | 60     |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with size "7"

  @SID_17
  Scenario: Validate data by various time selections - 1H received bw
    Then UI Do Operation "Select" item "trafficThroughput receiveButton"
    Then UI Do Operation "Select" item "trafficPackets receiveButton"
    # ============================================== #
    # = validation of throughput received widget =
    # ============================================

#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_02"
#      | value | count | offset |
#      | 21.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_03"
#      | value | count | offset |
#      | 31.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_04"
#      | value | count | offset |
#      | 41.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_6"
#      | value | count | offset |
#      | 61.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_7"
#      | value | count | offset |
#      | 71.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_8"
#      | value | count | offset |
#      | 81.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_19"
#      | value | count | offset |
#      | 191.0   | 120    | 1      |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_02"
      | value | count | offset |
      | 21.0  | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_03"
      | value | count | offset |
      | 31.0  | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_04"
      | value | count | offset |
      | 41.0  | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_06"
      | value | count | offset |
      |  61.0 | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_07"
      | value | count | offset |
      |  71.0 | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_08"
      | value | count | offset |
      |  81.0 | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_19"
      | value | count | offset |
      | 191.0 | 64    | 60     |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with size "7"

  @SID_18
  Scenario: Validate data by various time selections - 1H received packets
    # ============================================== #
    # = validation of PPS received widget =
    # ============================================

#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_02"
#      | value | count | offset |
#      | 25.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_03"
#      | value | count | offset |
#      | 35.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_04"
#      | value | count | offset |
#      | 45.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_6"
#      | value | count | offset |
#      | 65.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_7"
#      | value | count | offset |
#      | 75.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_8"
#      | value | count | offset |
#      | 85.0   | 120    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_19"
#      | value | count | offset |
#      | 195.0   | 120    | 1      |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_02"
      | value | count | offset |
      | 25.0  | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_03"
      | value | count | offset |
      | 35.0  | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_04"
      | value | count | offset |
      | 45.0  | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_06"
      | value | count | offset |
      |  65.0 | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_07"
      | value | count | offset |
      |  75.0 | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_08"
      | value | count | offset |
      |  85.0 | 64    | 60     |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_19"
      | value | count | offset |
      | 195.0 | 64    | 60     |

  @SID_19
  Scenario: Cleanup
    Then UI Open "Configurations" Tab
    Then UI logout and close browser



