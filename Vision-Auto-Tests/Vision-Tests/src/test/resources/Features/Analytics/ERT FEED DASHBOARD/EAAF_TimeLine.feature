@TC126456 @Test12
Feature: EAAF TimeLine

  @SID_1
  Scenario: delete data from elastic search
#    Given Play File "empty_file.xmf" in device "50.50.100.1" from map "Automation_Machines" and wait 20 seconds
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "eaaf-attack-*"
    Then Sleep "5"


  @SID_2
  Scenario: login and navigate ERT dashboard
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
#    Then Sleep "300"
    Given Play File "DP_sim_8.28.xmf" in device "50.50.100.1" from map "Automation_Machines" and wait 20 seconds
    Then Sleep "300"
    And UI Navigate to "EAAF Dashboard" page via homePage
    Given Play File "empty_file.xmf" in device "50.50.100.1" from map "Automation_Machines" and wait 20 seconds
    Then Sleep "30"


  @SID_3
  Scenario: Validate Default Selected tab of EAAF-Timeline
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label   | param         | value |
      | Attacks | EAAF-Timeline | false |
      | Packets | EAAF-Timeline | true  |
      | Volume  | EAAF-Timeline | false |


  @SID_4
  Scenario: Validate Total Attacks value of EAAF-Timeline
    When UI Click Button "Attacks" with value "EAAF-Timeline"
    Then UI Validate Text field "Total Values" with params "Attacks" EQUALS "3"

    Then UI Validate Line Chart data "EAAF Hits Timeline attacks" with LabelTime
      | value | count |
      | 3     | 1     |


  @SID_5
  Scenario: Validate Total Packets value of EAAF-Timeline
    When UI Click Button "Packets" with value "EAAF-Timeline"
    Then UI Validate Text field "Total Values" with params "Packets" EQUALS "2 K"

    Then UI Validate Line Chart data "EAAF Hits Timeline packets" with LabelTime
      | value | count |
      | 2006  | 1     |

  @SID_6
  Scenario: Validate Total Volume value of EAAF-Timeline
    When UI Click Button "Volume" with value "EAAF-Timeline"
    Then UI Validate Text field "Total Values" with params "Volume" EQUALS "2 M"

    Then UI Validate Line Chart data "EAAF Hits Timeline volume" with LabelTime
      | value   | count |
      | 1989000 | 1     |

  @SID_7
  Scenario: Logout
    Then UI logout and close browser