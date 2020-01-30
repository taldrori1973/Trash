

Feature: AMS DefenseFlow Attacks Dashboard

  Scenario: VRM - Login to AMS DefenseFlow Analytics Dashboard
    Given UI Login with user "radware" and password "radware"
    And UI Open Upper Bar Item "AMS"
    Then Sleep "7"
    When UI Open "Dashboards" Tab
    Then UI Open "DefenseFlow Analytics Dashboard" Sub Tab

    Scenario: Top 10 Attacks by duration
      Then UI Validate Text field "Top 10 duration name" with params "0" EQUALS "PO_1001 "
      Then UI Validate Text field "Top 10 duration IP" with params "0" EQUALS "- Multiple"
      Then UI Validate Text field "Top 10 duration value" with params "0" EQUALS "2752:32:51"
      Then UI Validate Text field "Top 10 duration name" with params "1" EQUALS "Municipal_Accounting "
      Then UI Validate Text field "Top 10 duration IP" with params "1" EQUALS "- 72.29.107.0/26"
      Then UI Validate Text field "Top 10 duration value" with params "1" EQUALS "2357:49:56"
      Then UI Validate Text field "Top 10 duration name" with params "2" EQUALS "po-name_duration_2"
      Then UI Validate Text field "Top 10 duration IP" with params "2" EQUALS "- 104.37.111.96/27"
      Then UI Validate Text field "Top 10 duration value" with params "2" EQUALS "2357:49:55"
      Then UI Validate Text field "Top 10 duration name" with params "3" EQUALS "PO_10000 "
      Then UI Validate Text field "Top 10 duration IP" with params "3" EQUALS "- Multiple"
      Then UI Validate Text field "Top 10 duration value" with params "3" EQUALS "2357:49:19"

  Scenario: Top 10 Attacks by Rate (Gbps)
    Then UI Validate Text field "Top 10 maxBandwidthBps name" with params "0" EQUALS "PO_1001 "
    Then UI Validate Text field "Top 10 maxBandwidthBps IP" with params "0" EQUALS "- Multiple"
    Then UI Validate Text field "Top 10 maxBandwidthBps value" with params "0" EQUALS "0"


  Scenario: Top 10 Attacks by Rate (Mpps)
    Then UI Validate Text field "Top 10 maxPacketRatePps name" with params "0" EQUALS "PO_1001 "
    Then UI Validate Text field "Top 10 maxPacketRatePps IP" with params "0" EQUALS "- Multiple"
    Then UI Validate Text field "Top 10 maxPacketRatePps value" with params "0" EQUALS "0"


