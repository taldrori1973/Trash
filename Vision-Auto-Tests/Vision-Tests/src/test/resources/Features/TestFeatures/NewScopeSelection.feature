@TestScopeSelection
Feature: New Scope Selection Implementation

  Scenario: Login and Navigate to DP Monitoring Page
    Given UI Login with user "radware" and password "radware"
    Then UI Navigate to "DefensePro Monitoring Dashboard" page via homepage

  Scenario: Validate Scope Selection window


    Then UI "Select" Scope Polices
      | devices | SetId:DefensePro_Set_20,ports:[10],policies:[SGNS-Global-12, SGNS-Global-15] |
#      | devices | SetId:DefensePro_Set_21,ports:[10, 25],policies:[policy10] |

#      | devices | type:DefensePro Behavioral Protections,index:10,ports:[10],policies:[SSL2] |