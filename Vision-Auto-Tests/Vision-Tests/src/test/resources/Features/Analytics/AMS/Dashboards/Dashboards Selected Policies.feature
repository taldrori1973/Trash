@Test12
Feature: Dashboards Selected Policies

  @SID_1
  Scenario: login and select device
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
   Then UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then Sleep "1"
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Analytics, index:10,policies:[pol1,BDOS,SSL] |

    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics, index:10,policies:[pol1,BDOS,SSL] |