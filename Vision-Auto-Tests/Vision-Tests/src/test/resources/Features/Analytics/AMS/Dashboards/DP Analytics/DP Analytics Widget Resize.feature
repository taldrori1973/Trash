@TC111564
Feature: DP ANALYTICS Look and Feel

  @SID_1
  Scenario: Login
    * REST Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    When UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "DefensePro Analytics Dashboard" page via homePage

    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
#TODO - move all below scenarios to automated after R&D will define the widget location
#  Scenario: TC101019 VRM - Validate Dashboards "Attacks by Mitigation Action" drag&drop and resize
#    When UI VRM Clear All Widgets
#    And UI VRM Select Widgets
#      | Attacks by Mitigation Action |
#    Then UI VRM Drag And Drop "Attacks by Mitigation Action-1" chart with X offset 600 and Y offset 0
#    Then UI VRM Resize "Attacks by Mitigation Action-1" chart with X offset -600 and Y offset 0
#    Then UI VRM Resize "Attacks by Mitigation Action-1" chart with X offset 0 and Y offset 300
#    Then UI VRM Resize "Attacks by Mitigation Action-1" chart with X offset -600 and Y offset -300
#
#
#  Scenario: TC100977 VRM - Validate Dashboards "Attacks by Threat Category" drag&drop and resize
#    When UI VRM Clear All Widgets
#    And UI VRM Select Widgets
#      | Attacks by Threat Category |
#    Then UI VRM Drag And Drop "Attacks by Threat Category-1" chart with X offset 600 and Y offset 0
#    Then UI VRM Drag And Drop "Attacks by Threat Category-1" chart with X offset -600 and Y offset 0
#    Then UI VRM Resize "Attacks by Threat Category-1" chart with X offset 600 and Y offset 300
#    Then UI VRM Resize "Attacks by Threat Category-1" chart with X offset -600 and Y offset -300
#
#  Scenario: TC101764 VRM - Validate Drag And Drop For "Top Attack Destination"
#    When UI VRM Clear All Widgets
#    And UI VRM Select Widgets
#      | Top Attack Destination |
#    Then UI VRM Drag And Drop "Top Attack Destination-1" chart with X offset 600 and Y offset 0
#    Then UI VRM Drag And Drop "Top Attack Destination-1" chart with X offset -600 and Y offset 0
#    Then UI VRM Resize "Top Attack Destination-1" chart with X offset 600 and Y offset 300
#    Then UI VRM Resize "Top Attack Destination-1" chart with X offset -600 and Y offset -300
#
#  Scenario: TC101768 VRM - Validate Drag And Drop For "Top Attacks by Protocol"
#    When UI VRM Clear All Widgets
#    And UI VRM Select Widgets
#      | Top Attacks by Protocol |
#    Then UI VRM Drag And Drop "Top Attacks by Protocol-1" chart with X offset 600 and Y offset 0
#    Then UI VRM Drag And Drop "Top Attacks by Protocol-1" chart with X offset -600 and Y offset 0
#    Then UI VRM Resize "Top Attacks by Protocol-1" chart with X offset 600 and Y offset 300
#    Then UI VRM Resize "Top Attacks by Protocol-1" chart with X offset -600 and Y offset -300
#
#  Scenario: TC101094 VRM - Validate Dashboards "Top Forwarded Attack Sources" drag&drop and resize
#    When UI VRM Clear All Widgets
#    And UI VRM Select Widgets
#      | Top Forwarded Attack Sources |
#    Then UI VRM Drag And Drop "Top Forwarded Attack Sources-1" chart with X offset 600 and Y offset 0
#    Then UI VRM Drag And Drop "Top Forwarded Attack Sources-1" chart with X offset -600 and Y offset 0
#    Then UI VRM Resize "Top Forwarded Attack Sources-1" chart with X offset 600 and Y offset 300
#    Then UI VRM Resize "Top Forwarded Attack Sources-1" chart with X offset -600 and Y offset -300
