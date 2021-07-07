@run
Feature: test

  @SID_1
  Scenario: Login and Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage


  @SID_8
  Scenario: create new Download Throughput bps1
    Then UI "Select" Scope Polices
      | devices | index:10,policies:[pol1,BDOS,SSL] |


    Then UI "Validate" Scope Polices
      | devices | index:10,policies:[pol1,BDOS,SSL] |


    Then UI "UnSelect" Scope Polices
      | devices | index:10,policies:[BDOS] |

    Then UI "Validate" Scope Polices
      | devices | index:10,policies:[pol1,SSL] |


    Then UI "Select" Scope Polices
      | devices | index:10,policies:[SSL2] |





