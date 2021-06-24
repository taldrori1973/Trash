@SAPRO
Feature: Sapro Communication

#  Scenario: start all devices
##    Given Play File "Alteon_LP_32.6.5.0_TEST.xmf" in device "50.50.101.101" from map "Automation_Machines" and wait 20 seconds
#    Given Play File "Alteon_LP_32.6.5.0_TEST.xmf" in device "50.50.101.101" from map "Automation_Machines"
#    Given Start all devices from map "DP_8.13[1-20]"
#
#  Scenario: stop all devices
#    Then Stop all devices from map "Danny"
#    Then Stop all devices from map "DP_8.13[1-20]"
#
#  Scenario:
#    Given Start map "Danny"
#    Given Start map "DefensePro"
#    Then Stop map "Danny"

  Scenario: start devices
#    Given From map "Danny" start devices
#      | 50.50.150.200 |
#      | 50.50.150.201 |
    Given From map "Automation_Machines" start devices
      | 50.50.100.1 |
      | 50.50.100.2 |

#  Scenario: stop devices
#    Then From map "Automation_Machines" stop devices
#      | 50.50.100.1 |
#      | 50.50.100.2 |