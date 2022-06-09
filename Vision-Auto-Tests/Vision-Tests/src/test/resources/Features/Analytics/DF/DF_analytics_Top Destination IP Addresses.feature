@TC127106
Feature:DF_analytics_Top Destination IP Addresses

  @SID_1
  Scenario:  Clean system attacks
    * CLI kill all simulator attacks on current vision
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Delete ES index "df-attack*"
    * CLI Clear vision logs


  @SID_2
  Scenario:Login and Navigate df analytics  DashBoard
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "DefenseFlow Analytics" page via homePage


  @SID_3
  Scenario:validate all PO are selected
    When UI Do Operation "Select" item "Protected Objects"
    Then UI validate CheckBox by ID "All PO" if Selected "true"

    ##############validate with BPS side Bar All Protected Object###############################
  @SID_4
  Scenario:validate side bar of top destination ip Total

    Then UI Validate Text field "SortBy destinations" EQUALS "Total"

    Then UI Validate Text field "source" with params "0" EQUALS "10.0.0.6"
    Then UI Validate Text field "total" with params "0" EQUALS "399.33 Gb"
    Then UI Validate Text field "totalPercent" with params "0" EQUALS "16.54%"


    Then UI Validate Text field "source" with params "1" EQUALS "10.0.0.8"
    Then UI Validate Text field "total" with params "1" EQUALS "360.03 Gb"
    Then UI Validate Text field "totalPercent" with params "1" EQUALS "21.24%"

    Then UI Validate Text field "source" with params "2" EQUALS "10.0.0.11"
    Then UI Validate Text field "total" with params "2" EQUALS "9.83 Gb"
    Then UI Validate Text field "totalPercent" with params "2" EQUALS "78.75%"


    Then UI Validate Text field "source" with params "3" EQUALS "10.0.0.7"
    Then UI Validate Text field "total" with params "3" EQUALS "321.5 Gb"
    Then UI Validate Text field "totalPercent" with params "3" EQUALS "13.31%"

    Then UI Validate Text field "source" with params "4" EQUALS "10.0.0.12"
    Then UI Validate Text field "total" EQUALS "311.57 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "12.90%"

    Then UI Validate Text field "source" EQUALS "10.0.0.10"
    Then UI Validate Text field "total" EQUALS "298.45 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "12.36%"


    Then UI Validate Text field "source" EQUALS "10.0.0.9"
    Then UI Validate Text field "total" EQUALS "87.02 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "12.22%"

    Then UI Validate Text field "source" EQUALS "10.0.0.5"
    Then UI Validate Text field "total" EQUALS "9.83 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "73.60%"


    Then UI Validate Text field "source" EQUALS "10.0.0.2"
    Then UI Validate Text field "total" EQUALS "3.86 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "0.16%"

    Then UI Validate Text field "source" EQUALS "10.0.0.3"
    Then UI Validate Text field "total" EQUALS "3.16 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "0.13%"


  @SID_4
  Scenario:validate side bar of top destination ip Last

    Then UI Validate Text field "source" with params "0" EQUALS "60.0.0.7"
    Then UI Validate Text field "total" with params "0" EQUALS "67.06 Mbps"
    Then UI Validate Text field "totalPercent" with params "0" EQUALS "13.49%"


    Then UI Validate Text field "source" with params "1" EQUALS "60.0.0.10"
    Then UI Validate Text field "total" with params "1" EQUALS "59.18 Mbps"
    Then UI Validate Text field "totalPercent" with params "1" EQUALS "11.90%"

    Then UI Validate Text field "source" with params "2" EQUALS "60.0.0.12"
    Then UI Validate Text field "total" with params "2" EQUALS "56.84 Mbps"
    Then UI Validate Text field "totalPercent" with params "2" EQUALS "11.43%"


    Then UI Validate Text field "source" with params "3" EQUALS "60.0.0.15"
    Then UI Validate Text field "total" with params "3" EQUALS "49.27 Mbps"
    Then UI Validate Text field "totalPercent" with params "3" EQUALS "9.91%"

    Then UI Validate Text field "source" with params "4" EQUALS "60.0.0.3"
    Then UI Validate Text field "total" EQUALS "48.48 Mbps"
    Then UI Validate Text field "totalPercent" EQUALS "9.75%"

    Then UI Validate Text field "source" EQUALS "60.0.0.2"
    Then UI Validate Text field "total" EQUALS "44.19 Mbps"
    Then UI Validate Text field "totalPercent" EQUALS "8.88%"


    Then UI Validate Text field "source" EQUALS "60.0.0.4"
    Then UI Validate Text field "total" EQUALS "43.81 Mbps"
    Then UI Validate Text field "totalPercent" EQUALS "8.81%"

    Then UI Validate Text field "source" EQUALS "60.0.0.11"
    Then UI Validate Text field "total" EQUALS "43.35 Mbps"
    Then UI Validate Text field "totalPercent" EQUALS "8.72%"


    Then UI Validate Text field "source" EQUALS "60.0.0.9"
    Then UI Validate Text field "total" EQUALS "42.72 Mbps"
    Then UI Validate Text field "totalPercent" EQUALS "8.59%"

    Then UI Validate Text field "source" EQUALS "60.0.0.13"
    Then UI Validate Text field "total" EQUALS "42.22 Mbps"
    Then UI Validate Text field "totalPercent" EQUALS "8.49%"

  @SID_4
  Scenario:validate side bar of top destination ip Average

    Then UI Validate Text field "source" with params "0" EQUALS "60.0.0.6"
    Then UI Validate Text field "total" with params "0" EQUALS "1 Kbps"
    Then UI Validate Text field "totalPercent" with params "0" EQUALS "16.56%"


    Then UI Validate Text field "source" with params "1" EQUALS "60.0.0.16"
    Then UI Validate Text field "total" with params "1" EQUALS "1 Kbps"
    Then UI Validate Text field "totalPercent" with params "1" EQUALS "14.91%"

    Then UI Validate Text field "source" with params "2" EQUALS "60.0.0.25"
    Then UI Validate Text field "total" with params "2" EQUALS "1 Kbps"
    Then UI Validate Text field "totalPercent" with params "2" EQUALS "13.81%"


    Then UI Validate Text field "source" with params "3" EQUALS "60.0.0.14"
    Then UI Validate Text field "total" with params "3" EQUALS "1 Kbps"
    Then UI Validate Text field "totalPercent" with params "3" EQUALS "13.31%"

    Then UI Validate Text field "source" with params "4" EQUALS "60.0.0.23"
    Then UI Validate Text field "total" EQUALS "1 Kbps"
    Then UI Validate Text field "totalPercent" EQUALS "12.90%"

    Then UI Validate Text field "source" EQUALS "60.0.0.22"
    Then UI Validate Text field "total" EQUALS "297.29 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "12.31%"


    Then UI Validate Text field "source" EQUALS "60.0.0.9"
    Then UI Validate Text field "total" EQUALS "295.08 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "12.22%"

    Then UI Validate Text field "source" EQUALS "60.0.0.5"
    Then UI Validate Text field "total" EQUALS "87.6 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "3.62%"


    Then UI Validate Text field "source" EQUALS "60.0.0.3"
    Then UI Validate Text field "total" EQUALS "4.39 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "0.18%"

    Then UI Validate Text field "source" EQUALS "60.0.0.2"
    Then UI Validate Text field "total" EQUALS "3.87 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "0.16%"
####************************ to be edit
  @SID_4
  Scenario:validate side bar of top destination ip Max

    Then UI Validate Text field "source" with params "0" EQUALS "10.0.0.6"
    Then UI Validate Text field "total" with params "0" EQUALS "399.33 Gb"
    Then UI Validate Text field "totalPercent" with params "0" EQUALS "16.54%"


    Then UI Validate Text field "source" with params "1" EQUALS "10.0.0.8"
    Then UI Validate Text field "total" with params "1" EQUALS "360.03 Gb"
    Then UI Validate Text field "totalPercent" with params "1" EQUALS "21.24%"

    Then UI Validate Text field "source" with params "2" EQUALS "10.0.0.11"
    Then UI Validate Text field "total" with params "2" EQUALS "9.83 Gb"
    Then UI Validate Text field "totalPercent" with params "2" EQUALS "78.75%"


    Then UI Validate Text field "source" with params "3" EQUALS "10.0.0.7"
    Then UI Validate Text field "total" with params "3" EQUALS "321.5 Gb"
    Then UI Validate Text field "totalPercent" with params "3" EQUALS "13.31%"

    Then UI Validate Text field "source" with params "4" EQUALS "10.0.0.12"
    Then UI Validate Text field "total" EQUALS "311.57 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "12.90%"

    Then UI Validate Text field "source" EQUALS "10.0.0.10"
    Then UI Validate Text field "total" EQUALS "298.45 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "12.36%"


    Then UI Validate Text field "source" EQUALS "10.0.0.9"
    Then UI Validate Text field "total" EQUALS "87.02 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "12.22%"

    Then UI Validate Text field "source" EQUALS "10.0.0.5"
    Then UI Validate Text field "total" EQUALS "9.83 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "73.60%"


    Then UI Validate Text field "source" EQUALS "10.0.0.2"
    Then UI Validate Text field "total" EQUALS "3.86 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "0.16%"

    Then UI Validate Text field "source" EQUALS "10.0.0.3"
    Then UI Validate Text field "total" EQUALS "3.16 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "0.13%"

       ################ validate with PPS ###################
  @SID_9
  Scenario:validate side bar of top destinations ip

    Then UI Select "pps" from Vision dropdown "Units"
    Then UI Select "Total" from Vision dropdown "Sort By"
    Then UI Validate Text field "source" EQUALS "60.0.0.3"
    Then UI Validate Text field "total" EQUALS "1.56 Kp"
    Then UI Validate Text field "totalPercent" EQUALS "14.20%"


    Then UI Validate Text field "source" EQUALS "60.0.0.5"
    Then UI Validate Text field "total" EQUALS "1.51 Kp"
    Then UI Validate Text field "totalPercent" EQUALS "13.79%"

    Then UI Validate Text field "source" EQUALS "60.0.0.4"
    Then UI Validate Text field "total" EQUALS "1.48 Kp"
    Then UI Validate Text field "totalPercent" EQUALS "13.45%"


    Then UI Validate Text field "source" EQUALS "60.0.0.7"
    Then UI Validate Text field "total" EQUALS "1.18 Kp"
    Then UI Validate Text field "totalPercent" EQUALS "10.79%"

    Then UI Validate Text field "source" EQUALS "60.0.0.6"
    Then UI Validate Text field "total" EQUALS "1.09 Kp"
    Then UI Validate Text field "totalPercent" EQUALS "9.96%"

    Then UI Validate Text field "source" EQUALS "60.0.0.15"
    Then UI Validate Text field "total" EQUALS "1 Kp"
    Then UI Validate Text field "totalPercent" EQUALS "9.13%"


    Then UI Validate Text field "source" EQUALS "60.0.0.13"
    Then UI Validate Text field "total" EQUALS "800 p"
    Then UI Validate Text field "totalPercent" EQUALS "7.29%"

    Then UI Validate Text field "source" EQUALS "60.0.0.2"
    Then UI Validate Text field "total" EQUALS "793 p"
    Then UI Validate Text field "totalPercent" EQUALS "7.22%"


    Then UI Validate Text field "source" EQUALS "60.0.0.12"
    Then UI Validate Text field "total" EQUALS "785 p"
    Then UI Validate Text field "totalPercent" EQUALS "7.15%"

    Then UI Validate Text field "source" EQUALS "60.0.0.11"
    Then UI Validate Text field "total" EQUALS "766 p"
    Then UI Validate Text field "totalPercent" EQUALS "6.98%"

  @SID_4
  Scenario:validate side bar of top destination ip Last

    Then UI Validate Text field "source" with params "0" EQUALS "10.0.0.6"
    Then UI Validate Text field "total" with params "0" EQUALS "399.33 Gb"
    Then UI Validate Text field "totalPercent" with params "0" EQUALS "16.54%"


    Then UI Validate Text field "source" with params "1" EQUALS "10.0.0.8"
    Then UI Validate Text field "total" with params "1" EQUALS "360.03 Gb"
    Then UI Validate Text field "totalPercent" with params "1" EQUALS "21.24%"

    Then UI Validate Text field "source" with params "2" EQUALS "10.0.0.11"
    Then UI Validate Text field "total" with params "2" EQUALS "9.83 Gb"
    Then UI Validate Text field "totalPercent" with params "2" EQUALS "78.75%"


    Then UI Validate Text field "source" with params "3" EQUALS "10.0.0.7"
    Then UI Validate Text field "total" with params "3" EQUALS "321.5 Gb"
    Then UI Validate Text field "totalPercent" with params "3" EQUALS "13.31%"

    Then UI Validate Text field "source" with params "4" EQUALS "10.0.0.12"
    Then UI Validate Text field "total" EQUALS "311.57 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "12.90%"

    Then UI Validate Text field "source" EQUALS "10.0.0.10"
    Then UI Validate Text field "total" EQUALS "298.45 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "12.36%"


    Then UI Validate Text field "source" EQUALS "10.0.0.9"
    Then UI Validate Text field "total" EQUALS "87.02 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "12.22%"

    Then UI Validate Text field "source" EQUALS "10.0.0.5"
    Then UI Validate Text field "total" EQUALS "9.83 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "73.60%"


    Then UI Validate Text field "source" EQUALS "10.0.0.2"
    Then UI Validate Text field "total" EQUALS "3.86 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "0.16%"

    Then UI Validate Text field "source" EQUALS "10.0.0.3"
    Then UI Validate Text field "total" EQUALS "3.16 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "0.13%"

  @SID_4
  Scenario:validate side bar of top destination ip Average

    Then UI Validate Text field "source" with params "0" EQUALS "10.0.0.6"
    Then UI Validate Text field "total" with params "0" EQUALS "399.33 Gb"
    Then UI Validate Text field "totalPercent" with params "0" EQUALS "16.54%"


    Then UI Validate Text field "source" with params "1" EQUALS "10.0.0.8"
    Then UI Validate Text field "total" with params "1" EQUALS "360.03 Gb"
    Then UI Validate Text field "totalPercent" with params "1" EQUALS "21.24%"

    Then UI Validate Text field "source" with params "2" EQUALS "10.0.0.11"
    Then UI Validate Text field "total" with params "2" EQUALS "9.83 Gb"
    Then UI Validate Text field "totalPercent" with params "2" EQUALS "78.75%"


    Then UI Validate Text field "source" with params "3" EQUALS "10.0.0.7"
    Then UI Validate Text field "total" with params "3" EQUALS "321.5 Gb"
    Then UI Validate Text field "totalPercent" with params "3" EQUALS "13.31%"

    Then UI Validate Text field "source" with params "4" EQUALS "10.0.0.12"
    Then UI Validate Text field "total" EQUALS "311.57 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "12.90%"

    Then UI Validate Text field "source" EQUALS "10.0.0.10"
    Then UI Validate Text field "total" EQUALS "298.45 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "12.36%"


    Then UI Validate Text field "source" EQUALS "10.0.0.9"
    Then UI Validate Text field "total" EQUALS "87.02 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "12.22%"

    Then UI Validate Text field "source" EQUALS "10.0.0.5"
    Then UI Validate Text field "total" EQUALS "9.83 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "73.60%"


    Then UI Validate Text field "source" EQUALS "10.0.0.2"
    Then UI Validate Text field "total" EQUALS "3.86 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "0.16%"

    Then UI Validate Text field "source" EQUALS "10.0.0.3"
    Then UI Validate Text field "total" EQUALS "3.16 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "0.13%"

  @SID_4
  Scenario:validate side bar of top destination ip Max

    Then UI Validate Text field "source" with params "0" EQUALS "10.0.0.6"
    Then UI Validate Text field "total" with params "0" EQUALS "399.33 Gb"
    Then UI Validate Text field "totalPercent" with params "0" EQUALS "16.54%"


    Then UI Validate Text field "source" with params "1" EQUALS "10.0.0.8"
    Then UI Validate Text field "total" with params "1" EQUALS "360.03 Gb"
    Then UI Validate Text field "totalPercent" with params "1" EQUALS "21.24%"

    Then UI Validate Text field "source" with params "2" EQUALS "10.0.0.11"
    Then UI Validate Text field "total" with params "2" EQUALS "9.83 Gb"
    Then UI Validate Text field "totalPercent" with params "2" EQUALS "78.75%"


    Then UI Validate Text field "source" with params "3" EQUALS "10.0.0.7"
    Then UI Validate Text field "total" with params "3" EQUALS "321.5 Gb"
    Then UI Validate Text field "totalPercent" with params "3" EQUALS "13.31%"

    Then UI Validate Text field "source" with params "4" EQUALS "10.0.0.12"
    Then UI Validate Text field "total" EQUALS "311.57 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "12.90%"

    Then UI Validate Text field "source" EQUALS "10.0.0.10"
    Then UI Validate Text field "total" EQUALS "298.45 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "12.36%"


    Then UI Validate Text field "source" EQUALS "10.0.0.9"
    Then UI Validate Text field "total" EQUALS "87.02 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "12.22%"

    Then UI Validate Text field "source" EQUALS "10.0.0.5"
    Then UI Validate Text field "total" EQUALS "9.83 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "73.60%"


    Then UI Validate Text field "source" EQUALS "10.0.0.2"
    Then UI Validate Text field "total" EQUALS "3.86 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "0.16%"

    Then UI Validate Text field "source" EQUALS "10.0.0.3"
    Then UI Validate Text field "total" EQUALS "3.16 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "0.13%"




#################### CHART ########################################################

############## validating if  5 checked and the Chart bps#########################
  @SID_5
  Scenario:validate line chart data first 5 are checked
    Then UI Validate the attribute "data-debug-checked" Of Label "source" With Params "0" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "source" With Params "1" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "source" With Params "2" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "source" With Params "3" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "source" With Params "4" is "EQUALS" to "true"

    Then UI Validate the attribute "data-debug-checked" Of Label "source" With Params "5" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "source" With Params "6" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "source" With Params "7" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "source" With Params "8" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "source" With Params "9" is "EQUALS" to "false"

######################## to edit when adding the session storage ######################
    Then UI Validate Line Chart data "top source" with Label "top source"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |

  @SID_6
  Scenario:validate line chart data
    Then UI Select "Last" from Vision dropdown "Sort By"
    Then UI Validate Line Chart data "top source" with Label "top source"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |

  @SID_7
  Scenario:validate line chart data
    Then UI Select "Average" from Vision dropdown "Sort By"

    Then UI Validate Line Chart data "top source" with Label "top source"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |

  @SID_8
  Scenario:validate line chart data
    Then UI Select "Max" from Vision dropdown "Sort By"
    Then UI Validate Line Chart data "top source" with Label "top source"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |


############## validating if  5 checked and the Chart PPS #########################
@SID_10
Scenario:validate line chart data
  Then UI Select "pps" from Vision dropdown "Units"
    Then UI Select "Total" from Vision dropdown "Sort By"
    Then UI Validate Line Chart data "top source" with Label "top source"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |
  @SID_11
  Scenario:validate line chart data
    Then UI Select "Last" from Vision dropdown "Sort By"
    Then UI Validate Line Chart data "top source" with Label "top source"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |



  @SID_12
  Scenario:validate line chart data
    Then UI Select "Average" from Vision dropdown "Sort By"
    Then UI Validate Line Chart data "top source" with Label "top source"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |


  @SID_13
  Scenario:validate line chart data
    Then UI Select "Max" from Vision dropdown "Sort By"
    Then UI Validate Line Chart data "top source" with Label "top source"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |


    ################## validate filtering protected object #########################

  @SID_14
    Scenario: choose OP from the scope selection
    When UI Do Operation "Select" item "Protected Objects"
    Then UI Select scope from dashboard and Save Filter device type "defenseflow"
      | PO_100 |
      | PO_200 |

  @SID_15
  Scenario:validate side bar of top destination ip

    Then UI Select "bps" from Vision dropdown "Units"
    Then UI Select "Total" from Vision dropdown "Sort By"
    Then UI Validate Text field "source" EQUALS "192.85.1.2"
    Then UI Validate Text field "total" EQUALS "9.83 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "78.75%"


    Then UI Validate Text field "source" EQUALS "192.85.1.22"
    Then UI Validate Text field "total" EQUALS "2.65 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "21.24%"

    Then UI Validate Text field "source" EQUALS "192.85.1.2"
    Then UI Validate Text field "total" EQUALS "9.83 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "78.75%"


    Then UI Validate Text field "source" EQUALS "192.85.1.22"
    Then UI Validate Text field "total" EQUALS "2.65 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "21.24%"

    Then UI Validate Text field "source" EQUALS "192.85.1.2"
    Then UI Validate Text field "total" EQUALS "9.83 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "78.75%"

    Then UI Validate Text field "source" EQUALS "192.85.1.2"
    Then UI Validate Text field "total" EQUALS "9.83 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "78.75%"


    Then UI Validate Text field "source" EQUALS "192.85.1.22"
    Then UI Validate Text field "total" EQUALS "2.65 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "21.24%"

    Then UI Validate Text field "source" EQUALS "192.85.1.2"
    Then UI Validate Text field "total" EQUALS "9.83 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "78.75%"


    Then UI Validate Text field "source" EQUALS "192.85.1.22"
    Then UI Validate Text field "total" EQUALS "2.65 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "21.24%"

    Then UI Validate Text field "source" EQUALS "192.85.1.2"
    Then UI Validate Text field "total" EQUALS "9.83 Gb"
    Then UI Validate Text field "totalPercent" EQUALS "78.75%"




  @SID_16
  Scenario:validate line chart data pps first 5 are checked
    Then UI Validate the attribute "data-debug-checked" Of Label "source 1" With Params "" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "source 2" With Params "" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "source 1" With Params "" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "source 2" With Params "" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "source 1" With Params "" is "EQUALS" to "true"

    Then UI Validate the attribute "data-debug-checked" Of Label "source 1" With Params "" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "source 2" With Params "" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "source 1" With Params "" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "source 2" With Params "" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "source 1" With Params "" is "EQUALS" to "false"

    Then UI Validate Line Chart data "top source" with Label "top source"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |



  @SID_17
  Scenario:validate line chart data
    Then UI Select "Last" from Vision dropdown "Sort By"
    Then UI Validate Line Chart data "top source" with Label "top source"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |



  @SID_18
  Scenario:validate line chart data
    Then UI Select "Average" from Vision dropdown "Sort By"
    Then UI Validate Line Chart data "top source" with Label "top source"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |


  @SID_19
  Scenario:validate line chart data
    Then UI Select "Max" from Vision dropdown "Sort By"
    Then UI Validate Line Chart data "top source" with Label "top source"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |






  @SID_21
  Scenario:validate line chart data pps first 5 are checked
    Then UI Validate the attribute "data-debug-checked" Of Label "source 1" With Params "" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "source 2" With Params "" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "source 1" With Params "" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "source 2" With Params "" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "source 1" With Params "" is "EQUALS" to "true"

    Then UI Validate the attribute "data-debug-checked" Of Label "source 1" With Params "" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "source 2" With Params "" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "source 1" With Params "" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "source 2" With Params "" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "source 1" With Params "" is "EQUALS" to "false"

    Then UI Validate Line Chart data "top source" with Label "top source"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |



  @SID_22
  Scenario:validate line chart data
    Then UI Select "Last" from Vision dropdown "Sort By"
    Then UI Validate Line Chart data "top source" with Label "top source"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |



  @SID_23
  Scenario:validate line chart data
    Then UI Select "Average" from Vision dropdown "Sort By"
    Then UI Validate Line Chart data "top source" with Label "top source"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |


  @SID_24
  Scenario:validate line chart data
    Then UI Select "Max" from Vision dropdown "Sort By"
    Then UI Validate Line Chart data "top source" with Label "top source"
      | value   | count | offset |
      | 83733.0 | 1     | 5      |



