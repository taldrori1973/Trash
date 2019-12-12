@VRM @TC108201
Feature: AMS Monitoring Dashboard - Attacks table

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    # Sleeping in order to let collector cache clean
    Then Sleep "20"
    * REST Delete ES index "dp-*"
#    * REST Delete ES index "forensics-*"
#    * REST Delete ES index "dpforensics-*"

  @SID_2
  Scenario: Run DP simulator PCAPs for Traffic Bandwidth
    Given CLI simulate 1 attacks of type "many_attacks" on "DefensePro" 10 and wait 250 seconds


  @SID_3
  Scenario: Login and navigate to VRM
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Open Upper Bar Item "AMS"
    And UI Open "Dashboards" Tab
    When UI Open "DP Monitoring Dashboard" Sub Tab


  @SID_4
  Scenario: Validate traffic graph number of attacks
#    Given UI Do Operation "Select" item "Global Time Filter"
#    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    Then UI Select Time From: 30 To: 57 Time, in Line Chart data "Traffic Bandwidth"
    Then Sleep "5"
#    Then UI Validate "Traffic Bandwidth Attacks table" Table rows count equal to 32
    Then UI Validate Table "Traffic Bandwidth Attacks table" rows is between index:30 and index:57 in "Traffic Bandwidth" Chart

    ###32
    Then UI Click Button "Attacks OK"

  @SID_5
  Scenario: Validate attacks Table, attacks is in the selected range.
    Then UI Select Time From: 0 To: 59 Time, in Line Chart data "Traffic Bandwidth"
    Then Sleep "5"
    Then UI Validate Table "Traffic Bandwidth Attacks table" rows is between index:0 and index:59 in "Traffic Bandwidth" Chart
    Then UI Click Button "Attacks OK"

  @SID_6
  Scenario: Kill Attacks and sleep
    * CLI kill all simulator attacks on current vision
    * Sleep "90"
    And UI Open "Reports" Tab
    And UI Open "Dashboards" Tab
    And UI Open "DP Monitoring Dashboard" Sub Tab

  @SID_6
  Scenario: Validate table attacks with no attacks.
    Then UI Select Time From: 57 To: 59 Time, in Line Chart data "Traffic Bandwidth"
    Then Sleep "5"
    Then UI Validate "Traffic Bandwidth Attacks table" Table rows count equal to 0
    Then UI Click Button "Attacks OK"

  @SID_7
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
