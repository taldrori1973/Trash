@TestScopeSelection
Feature: New Scope Selection Implementation

  Scenario: Login and Navigate to DP Monitoring Page
    Given UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage

  @SID_2
  Scenario: create new Report
    Given UI "Create" Report With Name "Inbound Traffic 1"
      | Template              | reportType:HTTPS Flood , Widgets:[Inbound Traffic], Servers:[server_1-DefensePro_Set_20-pol_1] |
      | Format                | Select: CSV                                                                                                                  |
      | Logo                  | reportLogoPNG.png                                                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                  |
      | Time Definitions.Date | Quick:Today                                                                                                                  |
      | Share                 | Email:[sravani.varada@radware.com],Subject:myEdit subject,Body:myEdit body                                               |

#    Given UI "Create" Report With Name "Traffic Bandwidth Report1"
#      | Template-1            | reportType:DefensePro Analytics, Widgets:[{Traffic Bandwidth:[pps,Outbound,All Policies]}], devices:[{SetId:DefensePro_Set_20, devicePorts:[AllPorts], devicePolicies:[All]}]|
#      | Logo                  | reportLogoPNG.png                                                                                           |
#      | Format                | Select: CSV                                                                                                 |
#      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                             |
#      | Time Definitions.Date | Quick:Today                                                                                                 |
#      | share                 | Email:[sravani.varada@radware.com],Subject:mySubject,Body:myBody                                        |
#
#    Given UI "Create" Report With Name "DefensePro Behavioral Protections Report"
#      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,bps,Inbound]}] ,devices:[{SetId:DefensePro_Set_20, devicePolicies:[EAAF2]}] |
#      | Time Definitions.Date | Relative:[Months,3]                                                                                                                                                    |
#      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                            |
#      | Share                 | Email:[sravani.varada@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                             |
#      | Format                | Select: CSV                                                                                                                                                            |


#    Then UI Navigate to "DefensePro Monitoring Dashboard" page via homepage
#
#  Scenario: Select policies in DP monitoring dashboard
#    Then UI "Select" Scope Polices
#      | devices | type:DefensePro Analytics,SetId:DefensePro_Set_20,policies:[EAAF2, EAAF4, PO_100] |
##      | devices | type:DefensePro Behavioral Protections,index:10,policies:[SGNS-Global-12] |
#
#  Scenario: Unselect one policy in DP monitoring dashboard
#    Then UI "UnSelect" Scope Polices
#      | devices | type:DefensePro Analytics,SetId:DefensePro_Set_20,policies:[EAAF2] |
#
#  Scenario: Validate policy in DP monitoring dashboard
#    Then UI "Validate" Scope Polices
#      | devices | type:DefensePro Analytics,SetId:DefensePro_Set_20,policies:[EAAF4, PO_100] |