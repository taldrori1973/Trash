@TC123478
  Feature: QDos Quantile Traffic Badnwidth New Widget

    @SID_1
    Scenario: Clean data before sending Qdos attack
      * CLI kill all simulator attacks on current vision
      * REST Delete ES index "dp-*"
      * CLI Clear vision logs

    @SID_2
    Scenario: Run DP simulator - QDos_Ahlam4
      Given CLI simulate 1000 attacks of type "QDos_Ahlam4" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds
      Then Sleep "5"
      * CLI kill all simulator attacks on current vision


    @SID_3
    Scenario:  login to vision and navigate to DP Monitoring
      Given UI Login with user "radware" and password "radware"
      Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
      Then UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
      Then Sleep "30"


    @SID_4
    Scenario: Enter DefensePro Dashboard Via "Protection Policies" table
      Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy columnName "Policy Name" findBy cellValue "p1"
      Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Quantile DoS"


    @SID_5
    Scenario: validate QDos State attack ID 38-1630605835
      Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "38-1630605835"
      Then UI Validate Line Chart data "Quantile-Traffic-Badnwidth" with Label "Received"
        | value  | count |
        | 26152  | 1   |
        | 25818  | 1   |
        | 25870  | 1   |
        | 25812  | 1   |
        | 25788  | 1   |
        | 25971  | 1   |
        | 25257  | 1   |
        | 25491  | 1   |
        | 25430  | 1   |
      And UI Validate Line Chart data "Quantile-Traffic-Badnwidth" with Label "Dropped"
        | value  | count |
        | 26074  | 1   |
        | 25607  | 1   |
        | 25922  | 1   |
        | 25747  | 1   |
        | 25806  | 1   |
        | 26028  | 1   |
        | 25525  | 1   |
        | 25852  | 1   |
        | 25794  | 1   |
      And UI Validate Line Chart data "Quantile-Traffic-Badnwidth" with Label "Attack Edge"
        | value  | count |
        | 3529  | 9   |


    @SID_6
    Scenario: back to the previous page to choose the second Attack ID
      When UI Click Button "Protection Policies.GO BACK" with value " GO BACK"
      Then UI click Table row by keyValue or Index with elementLabel "Protection Policies.Protections Table" findBy columnName "Protection Name" findBy cellValue "Quantile DoS"



    @SID_7
    Scenario: validate QDos State attack ID 39-1630605835
      Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Events Table" findBy columnName "Attack ID" findBy cellValue "39-1630605835"
      Then UI Validate Line Chart data "Quantile-Traffic-Badnwidth" with Label "Received"
        | value  | count |
        | 25897  | 1   |
        | 25575  | 1   |
        | 25814  | 1   |
        | 25808  | 1   |
        | 25955  | 1   |
        | 25977  | 1   |
        | 25942  | 1   |
        | 25768  | 1   |
        | 25742  | 1   |
      And UI Validate Line Chart data "Quantile-Traffic-Badnwidth" with Label "Dropped"
        | value  | count |
        | 25841  | 1   |
        | 25478  | 1   |
        | 25782  | 1   |
        | 25408  | 1   |
        | 25619  | 1   |
        | 25712  | 1   |
        | 25724  | 1   |
        | 25630  | 1   |
        | 25899  | 1   |
      And UI Validate Line Chart data "Quantile-Traffic-Badnwidth" with Label "Attack Edge"
        | value  | count |
        | 2230  | 9   |


    @SID_8
    Scenario: Stop generating attacks and Logout
      Then CLI kill all simulator attacks on current vision
      Then UI logout and close browser