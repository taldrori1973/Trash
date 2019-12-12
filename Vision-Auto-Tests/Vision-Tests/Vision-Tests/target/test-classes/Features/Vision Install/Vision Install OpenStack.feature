@TC110743
Feature: Vision for OpenStack
#@Debug
#  Scenario: test
#    Then test

  @SID_1
  Scenario: Login and setup
    Given OpenStack Login
  Then CLI Operations - Run Radware Session command "system version"
    Then OpenStack Remove Old Resources
    Given OpenStack Upload Vision Image Version Build ""

  @SID_2
  Scenario: Create VM
    Given OpenStack Create VM
    When Wait for deployment completion till timeout of 20 minutes

  @SID_3
  Scenario: First time process & service validation
    When OpenStack Run First Time Wizard on VM
    And OpenStack Timeout 300
    Then OpenStack Validate Vision Server services on VM

  @SID4
  Scenario: Add Disk
    Given OpenStack create disk with size of 300
    Given OpenStack attach disk to VM
#    Given OpenStack detach disk from VM
#    Given OpenStack remove disk