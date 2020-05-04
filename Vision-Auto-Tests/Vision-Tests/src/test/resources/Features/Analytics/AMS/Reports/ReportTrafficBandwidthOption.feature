@TC114570
Feature: ReportTrafficBandwidthOptions

  @SID_1
  Scenario: Login to VRM AMS reports tab
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "AMS Reports" page via homePage


  @SID_2
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


  @SID_3
  Scenario: Create Report with trtaffic Bandwidth Options
    Given UI "Create" Report With Name "trafficBandwidth"
      | Design     | {"Add":[{"Traffic Bandwidth":["Outbound","pps",{"Traffic Bandwidth_Numberpolicies":"7"}]}]} |

    Then UI "Validate" Report With Name "trafficBandwidth"
      | Design     | Widgets:[Traffic Bandwidth]|

    @SID_4
    Scenario: validate the traffic bandwidth options
    Then UI validate togglesData in report "trafficBandwidth" with widget "Traffic Bandwidth"
      | text     | value    | selected |
      | custom   | 7        | true     |
      | pps      | pps      | true     |
      | Outbound | Outbound | true     |