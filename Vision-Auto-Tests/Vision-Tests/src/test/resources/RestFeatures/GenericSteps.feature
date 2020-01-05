@rest
Feature: Generic Steps

  Scenario: Send Get Request
#    Current Vision
    Given That Current Vision is Logged In With Username "radware" and Password "radware" With Activation
    Given That Current Vision is Logged In With Username "radware" and Password "radware"
    Given That Current Vision is Logged In With Activation

#    Current Vision HA
    Given That Current Vision HA is Logged In With Username "radware" and Password "radware"
    Given That Current Vision HA is Logged In

#    General Vision
    Given That Vision with IP "172.17.192.100" and Port 443 is Logged In With Username "radware" and Password "radware"

#    Alteon Or Appwall From SUT
    Given That Device Alteon With SUT Number 11 is Logged In
    Given That Device AppWall With SUT Number 11 is Logged In

#    On Vision VDirect
    Given That Current On Vision VDirect is Logged In With Username "radware" and Password "radware"
    Given That Current On Vision VDirect is Logged In



    Given New <string> Request Specification with Base Path "<string>"