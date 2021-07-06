@run
Feature: test

  @SID_1
  Scenario: Login and Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage


  @SID_8
  Scenario: create new Download Throughput bps1
    Then UI "Select" Scope Polices
      | devices | index:10,policies:[BDOS,pol1,SSL]|

    Then UI "UnSelect" Scope Polices
      | devices | index:10,policies:[BDOS]|


#    Then UI "Validate" Scope Polices
#      | devices | index:10,policies:[BDOS,policy1,Policy14] |

#
#
#    Then UI "Validate" Forensics With Name "Output Action Max pps Greater than"
#      | Product               | DefensePro                                                                     |
#      | Output                | Action                                                                         |
#      | Criteria              | Event Criteria:Max pps,Operator:Greater than,RateValue:500,Unit:M              |
#      | devices               | index:10                                                                       |
#      | Time Definitions.Date | Relative:[Weeks,2]                                                             |
#      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
#      | Format                | Select: HTML                                                                   |