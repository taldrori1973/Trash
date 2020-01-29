@TC106846
Feature: ADC Network Global Time

  @Shay_Global
  @SID_1
  Scenario: Login to ADC network tab and stop auto-refresh
    Then UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    When UI Navigate to "ANALYTICS ADC" page via homePage
    Then Sleep "30"
    When UI Navigate to "System and Network Dashboard" page via homePage

    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"
    Then UI Click Button "accessibility button" with value ""
#    Then UI Click Button "Auto-refresh" with value ""
    Then UI Click Button "Close accessibility" with value ""
    * Sleep "60"

  @SID_2
  Scenario: validate default time frame equals to 15m
    Then UI Validate Text field "Global Time Component" CONTAINS "15m"
    Then UI validate max time frame in line chart "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" equals to "15m" with offset "2"

#  @SID_3
#  Scenario: validate the toolTip
#    Given UI Click Button "Global Time Filter"
#    Then UI Validate Element tooltip value with elementLabel "Global Time tooltip" equal to "Select time"

  @SID_4
  Scenario: validate the Quick Range_15m
    Given UI Click Button "Global Time Filter"
    When UI Click Button "Global Time Filter.Quick Range" with value "15m"
    Then UI Validate Text field "Global Time Component" CONTAINS "15m"
    Then UI validate max time frame in line chart "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" equals to "15m" with offset "2"

  @SID_5
  Scenario: validate the Quick Range_30m
    Given UI Click Button "Global Time Filter"
    When UI Click Button "Global Time Filter.Quick Range" with value "30m"
    Then UI Validate Text field "Global Time Component" CONTAINS "30m"
    Then UI validate max time frame in line chart "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" equals to "30m" with offset "2"

  @SID_6
  Scenario: validate the Quick Range_1H
    Given UI Click Button "Global Time Filter"
    When UI Click Button "Global Time Filter.Quick Range" with value "1H"
    Then UI Validate Text field "Global Time Component" CONTAINS "1H"
    Then UI validate max time frame in line chart "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" equals to "59m" with offset "2"

  @SID_7
  Scenario: validate the Quick Range_1D
    Given UI Click Button "Global Time Filter"
    When UI Click Button "Global Time Filter.Quick Range" with value "1D"
    Then UI Validate Text field "Global Time Component" CONTAINS "1D"
    Then UI validate max time frame in line chart "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" equals to "24H" with offset "2"

  @SID_8
  Scenario: validate the Quick Range_1W
    Given UI Click Button "Global Time Filter"
    When UI Click Button "Global Time Filter.Quick Range" with value "1W"
    Then UI Validate Text field "Global Time Component" CONTAINS "1W"
    Then UI validate max time frame in line chart "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" equals to "7D" with offset "2"

  @SID_9
  Scenario: validate the Quick Range_1M
    Given UI Click Button "Global Time Filter"
    When UI Click Button "Global Time Filter.Quick Range" with value "1M"
    Then UI Validate Text field "Global Time Component" CONTAINS "1M"
    Then UI validate max time frame in line chart "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" equals to "1M" with offset "2"

  @SID_10
  Scenario: validate the Quick Range_3M
    Given UI Click Button "Global Time Filter"
    When UI Click Button "Global Time Filter.Quick Range" with value "3M"
    Then UI Validate Text field "Global Time Component" CONTAINS "3M"
    Then UI validate max time frame in line chart "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" equals to "3M" with offset "2"

  @Shay_Global
  @SID_11
  Scenario: validate time range
    Given UI Click Button "Global Time Filter"
    When UI select time range from "-3H" to "-1m"
#    When UI Click Button "Global Time Apply"
    Then UI Validate Text field "Global Time Component" CONTAINS "-"
    Then UI validate max time frame in line chart "NETWORK-TRAFFIC-WIDGET-PACKETS-TRANSMIT" equals to "2H" with offset "2"

  @SID_12
  Scenario: validate disabled apply button
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"
    Given UI Click Button "Global Time Filter"
    When UI select time range from "aaa"
    Then UI Validate Element EnableDisable status By Label "Global Time Apply" is Enabled "false"
    When UI select time range to "aaa"
    Then UI Validate Element EnableDisable status By Label "Global Time Apply" is Enabled "false"
    Then UI Click Button "Global Time Filter"

  @SID_13
  Scenario: CleanUp
    Then UI logout and close browser



    