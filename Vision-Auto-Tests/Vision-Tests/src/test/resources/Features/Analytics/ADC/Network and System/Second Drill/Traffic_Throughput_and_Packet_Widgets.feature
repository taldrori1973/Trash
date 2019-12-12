@TC106779
Feature: Traffic Throughput and PPS Widgets
# pre-requisites: simulator that will include 30 ports and will contain fields with various types of data units. e.g. K, M, G, T, P, E
  # select simulator 50.50.101.22 for these tests
  @SID_1
  Scenario: Login
    Then REST Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Open Upper Bar Item "ADC"
    Then UI Open "Dashboards" Tab
    Then UI Open "Application Dashboard" Sub Tab
    Then UI Open "Configurations" Tab
    Then UI Open Upper Bar Item "ADC"
    Then UI Open "Dashboards" Tab
    Then UI Open "Network and System Dashboard" Sub Tab
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"

  @SID_2
  Scenario: Validate default data(15 minutes) - transmit and receive

  # validation of PPS transmit widget
    #    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_01"
#      | value | count | offset |
#      | 996999.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_02"
#      | value | count | offset |
#      | 26.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_03"
#      | value | count | offset |
#      | 36.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_04"
#      | value | count | offset |
#      | 46.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_05"
#      | value | count | offset |
#      | 56.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_6"
#      | value | count | offset |
#      | 66.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_7"
#      | value | count | offset |
#      | 76.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_8"
#      | value | count | offset |
#      | 86.0   | 30    | 1      |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_01"
      | value    | count | offset |
      | 996999.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_02"
      | value | count | offset |
      | 26.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_03"
      | value | count | offset |
      | 36.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_04"
      | value | count | offset |
      | 46.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_05"
      | value | count | offset |
      | 56.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_16"
      | value | count | offset |
      | 166.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_17"
      | value | count | offset |
      | 176.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_18"
      | value | count | offset |
      | 186.0 | 30    | 1      |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with size "8"

  # ============================================== #
    # = validation of throughput transmit widget =
    # ============================================
    #    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_01"
#      | value | count | offset |
#      | 12.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_02"
#      | value | count | offset |
#      | 22.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_03"
#      | value | count | offset |
#      | 32.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_04"
#      | value | count | offset |
#      | 42.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_05"
#      | value | count | offset |
#      | 52.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_6"
#      | value | count | offset |
#      | 62.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_7"
#      | value | count | offset |
#      | 72.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_8"
#      | value | count | offset |
#      | 82.0   | 30    | 1      |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_01"
      | value | count | offset |
      | 12.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_02"
      | value | count | offset |
      | 22.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_03"
      | value | count | offset |
      | 32.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_04"
      | value | count | offset |
      | 42.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_05"
      | value | count | offset |
      | 52.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_16"
      | value | count | offset |
      | 162.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_17"
      | value | count | offset |
      | 172.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_18"
      | value | count | offset |
      | 182.0 | 30    | 1      |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with size "8"

    # ============================================== #
    # = validation of throughput received widget =
    # ============================================
    Then UI Do Operation "Select" item "trafficThroughput receiveButton"
    Then UI Do Operation "Select" item "trafficPackets receiveButton"
    Then UI Validate Switch button "trafficThroughput receiveButton" with params "" isSelected "true"
    Then UI Validate Switch button "trafficPackets receiveButton" with params "" isSelected "true"
    #    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_01"
#      | value | count | offset |
#      | 11.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_02"
#      | value | count | offset |
#      | 21.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_03"
#      | value | count | offset |
#      | 31.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_04"
#      | value | count | offset |
#      | 41.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_05"
#      | value | count | offset |
#      | 51.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_6"
#      | value | count | offset |
#      | 61.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_7"
#      | value | count | offset |
#      | 71.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_8"
#      | value | count | offset |
#      | 81.0   | 30    | 1      |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_01"
      | value | count | offset |
      | 11.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_02"
      | value | count | offset |
      | 21.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_03"
      | value | count | offset |
      | 31.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_04"
      | value | count | offset |
      | 41.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_05"
      | value | count | offset |
      | 51.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_16"
      | value | count | offset |
      | 161.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_17"
      | value | count | offset |
      | 171.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_18"
      | value | count | offset |
      | 181.0 | 30    | 1      |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with size "8"

    # ============================================== #
    # = validation of PPS received widget =
    # ============================================

    #    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_01"
#      | value | count | offset |
#      | 9.9999998430674944E17   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_02"
#      | value | count | offset |
#      | 25.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_03"
#      | value | count | offset |
#      | 35.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_04"
#      | value | count | offset |
#      | 45.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_05"
#      | value | count | offset |
#      | 55.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_6"
#      | value | count | offset |
#      | 65.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_7"
#      | value | count | offset |
#      | 75.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_8"
#      | value | count | offset |
#      | 85.0   | 30    | 1      |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_01"
      | value                 | count | offset |
      | 9.9999998430674944E17 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_02"
      | value | count | offset |
      | 25.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_03"
      | value | count | offset |
      | 35.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_04"
      | value | count | offset |
      | 45.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_05"
      | value | count | offset |
      | 55.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_16"
      | value | count | offset |
      | 165.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_17"
      | value | count | offset |
      | 175.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_18"
      | value | count | offset |
      | 185.0 | 30    | 1      |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with size "8"
#    Then UI Validate Line Chart rate time with "30s" for "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" chart


    # this step validates the transmit first since it's the default selection - use device 50.50.101.22 for these tests
  @SID_3
  Scenario: Validate data by user ports selection - transmit and receive
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
#      | 26.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_03"
#      | value | count | offset |
#      | 36.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_04"
#      | value | count | offset |
#      | 46.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_6"
#      | value | count | offset |
#      | 66.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_7"
#      | value | count | offset |
#      | 76.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_8"
#      | value | count | offset |
#      | 86.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_19"
#      | value | count | offset |
#      | 196.0   | 30    | 1      |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_02"
      | value | count | offset |
      | 26.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_03"
      | value | count | offset |
      | 36.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_04"
      | value | count | offset |
      | 46.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_16"
      | value | count | offset |
      | 166.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_17"
      | value | count | offset |
      | 176.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_18"
      | value | count | offset |
      | 186.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_19"
      | value | count | offset |
      | 196.0 | 30    | 1      |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with size "7"

  # ============================================== #
    # = validation of throughput transmit widget =
    # ============================================
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_02"
#      | value | count | offset |
#      | 22.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_03"
#      | value | count | offset |
#      | 32.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_04"
#      | value | count | offset |
#      | 42.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_6"
#      | value | count | offset |
#      | 62.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_7"
#      | value | count | offset |
#      | 72.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_8"
#      | value | count | offset |
#      | 82.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_19"
#      | value | count | offset |
#      | 192.0   | 30    | 1      |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_02"
      | value | count | offset |
      | 22.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_03"
      | value | count | offset |
      | 32.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_04"
      | value | count | offset |
      | 42.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_16"
      | value | count | offset |
      | 162.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_17"
      | value | count | offset |
      | 172.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_18"
      | value | count | offset |
      | 182.0 | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_19"
#      | value | count | offset |
#      | 192.0   | 30    | 1      |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with size "7"

    # ============================================== #
    # = validation of throughput received widget =
    # ============================================

    Then UI Do Operation "Select" item "trafficThroughput receiveButton"
    Then UI Do Operation "Select" item "trafficPackets receiveButton"

#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_02"
#      | value | count | offset |
#      | 21.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_03"
#      | value | count | offset |
#      | 31.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_04"
#      | value | count | offset |
#      | 41.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_6"
#      | value | count | offset |
#      | 61.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_7"
#      | value | count | offset |
#      | 71.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_8"
#      | value | count | offset |
#      | 81.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_19"
#      | value | count | offset |
#      | 191.0   | 30    | 1      |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_02"
      | value | count | offset |
      | 21.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_03"
      | value | count | offset |
      | 31.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_04"
      | value | count | offset |
      | 41.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_16"
      | value | count | offset |
      | 161.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_17"
      | value | count | offset |
      | 171.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_18"
      | value | count | offset |
      | 181.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_19"
      | value | count | offset |
      | 191.0 | 30    | 1      |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with size "7"

    # ============================================== #
    # = validation of PPS received widget =
    # ============================================

#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_02"
#      | value | count | offset |
#      | 25.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_03"
#      | value | count | offset |
#      | 35.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_04"
#      | value | count | offset |
#      | 45.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_6"
#      | value | count | offset |
#      | 65.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_7"
#      | value | count | offset |
#      | 75.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_8"
#      | value | count | offset |
#      | 85.0   | 30    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_19"
#      | value | count | offset |
#      | 195.0   | 30    | 1      |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_02"
      | value | count | offset |
      | 25.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_03"
      | value | count | offset |
      | 35.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_04"
      | value | count | offset |
      | 45.0  | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_16"
      | value | count | offset |
      | 165.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_17"
      | value | count | offset |
      | 175.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_18"
      | value | count | offset |
      | 185.0 | 30    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_19"
      | value | count | offset |
      | 195.0 | 30    | 1      |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with size "7"

    Then UI Do Operation "Select" item "trafficThroughput transmitButton"
    Then UI Do Operation "Select" item "trafficPackets receiveButton"

  @SID_4
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

  @SID_5
  Scenario: Validate data by various time selections - quick range
    Then UI Do Operation "Select" item "trafficThroughput transmitButton"
    Then UI Do Operation "Select" item "trafficPackets transmitButton"
    Then UI Do Operation "Select" item "Global Time Filter"
    Then UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "30m"

  # validation of PPS transmit widget
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_02"
#      | value | count | offset |
#      | 26.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_03"
#      | value | count | offset |
#      | 36.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_04"
#      | value | count | offset |
#      | 46.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_6"
#      | value | count | offset |
#      | 66.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_7"
#      | value | count | offset |
#      | 76.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_8"
#      | value | count | offset |
#      | 86.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_19"
#      | value | count | offset |
#      | 196.0   | 60    | 1      |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_02"
      | value | count | offset |
      | 26.0  | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_03"
      | value | count | offset |
      | 36.0  | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_04"
      | value | count | offset |
      | 46.0  | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_16"
      | value | count | offset |
      | 166.0 | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_17"
      | value | count | offset |
      | 176.0 | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_18"
      | value | count | offset |
      | 186.0 | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_19"
      | value | count | offset |
      | 196.0 | 60    | 1      |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with size "7"

  # ============================================== #
    # = validation of throughput transmit widget =
    # ============================================
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_02"
#      | value | count | offset |
#      | 22.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_03"
#      | value | count | offset |
#      | 32.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_04"
#      | value | count | offset |
#      | 42.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_6"
#      | value | count | offset |
#      | 62.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_7"
#      | value | count | offset |
#      | 72.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_8"
#      | value | count | offset |
#      | 82.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_19"
#      | value | count | offset |
#      | 192.0   | 60    | 1      |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_02"
      | value | count | offset |
      | 22.0  | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_03"
      | value | count | offset |
      | 32.0  | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_04"
      | value | count | offset |
      | 42.0  | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_16"
      | value | count | offset |
      | 162.0 | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_17"
      | value | count | offset |
      | 172.0 | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_18"
      | value | count | offset |
      | 182.0 | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_19"
      | value | count | offset |
      | 192.0 | 60    | 1      |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with size "7"

    Then UI Do Operation "Select" item "trafficPackets receiveButton"
    Then UI Do Operation "Select" item "trafficThroughput receiveButton"


    # ============================================== #
    # = validation of throughput received widget =
    # ============================================

#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_02"
#      | value | count | offset |
#      | 21.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_03"
#      | value | count | offset |
#      | 31.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_04"
#      | value | count | offset |
#      | 41.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_6"
#      | value | count | offset |
#      | 61.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_7"
#      | value | count | offset |
#      | 71.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_8"
#      | value | count | offset |
#      | 81.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_19"
#      | value | count | offset |
#      | 191.0   | 60    | 1      |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_02"
      | value | count | offset |
      | 21.0  | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_03"
      | value | count | offset |
      | 31.0  | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_04"
      | value | count | offset |
      | 41.0  | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_16"
      | value | count | offset |
      | 161.0 | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_17"
      | value | count | offset |
      | 171.0 | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_18"
      | value | count | offset |
      | 181.0 | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_19"
      | value | count | offset |
      | 191.0 | 60    | 1      |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with size "7"

    # ============================================== #
    # = validation of PPS received widget =
    # ============================================

#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_02"
#      | value | count | offset |
#      | 25.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_03"
#      | value | count | offset |
#      | 35.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_04"
#      | value | count | offset |
#      | 45.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_6"
#      | value | count | offset |
#      | 65.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_7"
#      | value | count | offset |
#      | 75.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_8"
#      | value | count | offset |
#      | 85.0   | 60    | 1      |
#    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_19"
#      | value | count | offset |
#      | 195.0   | 60    | 1      |

    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_02"
      | value | count | offset |
      | 25.0  | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_03"
      | value | count | offset |
      | 35.0  | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_04"
      | value | count | offset |
      | 45.0  | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_16"
      | value | count | offset |
      | 165.0 | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_17"
      | value | count | offset |
      | 175.0 | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_18"
      | value | count | offset |
      | 185.0 | 60    | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_19"
      | value | count | offset |
      | 195.0 | 60    | 1      |


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
      | 26.0  | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_03"
      | value | count | offset |
      | 36.0  | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_04"
      | value | count | offset |
      | 46.0  | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_16"
      | value | count | offset |
      | 166.0 | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_17"
      | value | count | offset |
      | 176.0 | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_18"
      | value | count | offset |
      | 186.0 | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with Label "port_19"
      | value | count | offset |
      | 196.0 | 120   | 1      |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" with size "7"

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
      | 22.0  | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_03"
      | value | count | offset |
      | 32.0  | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_04"
      | value | count | offset |
      | 42.0  | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_16"
      | value | count | offset |
      | 162.0 | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_17"
      | value | count | offset |
      | 172.0 | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_18"
      | value | count | offset |
      | 182.0 | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with Label "port_19"
      | value | count | offset |
      | 192.0 | 120   | 1      |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-TRANSMIT" with size "7"

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
      | 21.0  | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_03"
      | value | count | offset |
      | 31.0  | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_04"
      | value | count | offset |
      | 41.0  | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_16"
      | value | count | offset |
      | 161.0 | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_17"
      | value | count | offset |
      | 171.0 | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_18"
      | value | count | offset |
      | 181.0 | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with Label "port_19"
      | value | count | offset |
      | 191.0 | 120   | 1      |

    Then UI validate dataSets of lineChart "NETWORK-TRAFFIC-WIDGET-THROUGHPUT-RECEIVED" with size "7"

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
      | 25.0  | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_03"
      | value | count | offset |
      | 35.0  | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_04"
      | value | count | offset |
      | 45.0  | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_16"
      | value | count | offset |
      | 165.0 | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_17"
      | value | count | offset |
      | 175.0 | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_18"
      | value | count | offset |
      | 185.0 | 120   | 1      |
    Then UI Validate Line Chart data "NETWORK-TRAFFIC-WIDGET-PACKETS-RECEIVED" with Label "port_19"
      | value | count | offset |
      | 195.0 | 120   | 1      |

  @SID_6
  Scenario: Cleanup
    Then UI logout and close browser



