Feature : ReportTrafficBandwidthOptions

  Scenario: run attacks
    Then CLI kill all simulator attacks on current vision
    Then CLI Clear vision logs
    Then REST Delete ES index "dp-*"
    Given CLI simulate 4 attacks of type "baselines_pol_1" on "DefensePro" 10 with loopDelay 15000 and wait 60 seconds

  Scenario: Login to VRM AMS reports tab
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "AMS Reports" page via homePage


  Scenario: validate that the default selection is inbound and pps
    When UI Click Button "Add New"
    When UI Click Button "Template" with value ""
    When UI Click Button "Template" with value "DefensePro Analytics Dashboard"
    When UI Click Button "expandWidget"
    Then UI Validate the attribute "class" Of Label "Widget Option" With Params "pps_Traffic Bandwidth" is "CONTAINS" to "selected"
    Then UI Validate the attribute "class" Of Label "Widget Option" With Params "bps_Traffic Bandwidth" is "NOT CONTAINS" to "selected"
    Then UI Validate the attribute "class" Of Label "Widget Option" With Params "Inbound_Traffic Bandwidth" is "CONTAINS" to "selected"
    Then UI Validate the attribute "class" Of Label "Widget Option" With Params "Outbound_Traffic Bandwidth" is "NOT CONTAINS" to "selected"
    When UI Click Button "Widget Apply"
    When UI Click Button "Cancel"



  Scenario: Create Report of DNS baselines IPv6
    Given UI "Create" Report With Name "trafficBandwidth"
      | Design     | {"Add":[{"Traffic Bandwidth":["Outbound","pps",{"50_Traffic Bandwidth":"7"}]}]} |