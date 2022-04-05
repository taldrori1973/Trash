#@rest100
#@rest200
#@rest
Feature: Generic Steps

  Scenario: Send Get Request
#    Current Vision
    Given That Current Vision is Logged In
#    Given That Current Vision is Logged In With Activation
    Given That Current Vision is Logged In With Username "radware" and Password "radware"
    Given That Current Vision is Logged In With Username "sys_admin" and Password "radware"
    Given That Current Vision is Logged In
#    Given That Current Vision is Logged In With Username "sys_admin" and Password "radware" With Activation


#    Current Vision HA
#    Given That Current Vision HA is Logged In With Username "radware" and Password "radware" With Activation
#    Given That Current Vision HA is Logged In With Username "radware" and Password "radware"
#    Given That Current Vision HA is Logged In With Activation
#    Given That Current Vision HA is Logged In

#    General Vision
#    Given That Vision with IP "172.17.192.200" is Logged In With Username "radware" and Password "radware"
#    Given That Vision with IP "172.17.192.200" is Logged In With Username "radware" and Password "radware" With Activation
#    Given That Vision with IP "172.17.192.100" and Port 443 is Logged In With Username "radware" and Password "radware"
#    Given That Vision with IP "172.17.192.100" and Port 443 is Logged In With Username "radware" and Password "radware" With Activation
#    Given That Vision with IP "172.17.192.100" and Protocol "https" is Logged In With Username "<string>" and Password "<string>"
#    Given That Vision with IP "172.17.192.100" and Protocol "https" is Logged In With Username "<string>" and Password "<string>" With Activation
#    Given That Vision with IP "172.17.192.100" and Port 443 and Protocol "https" is Logged In With Username "<string>" and Password "<string>"
#    Given That Vision with IP "172.17.192.100" and Port 443 and Protocol "https" is Logged In With Username "<string>" and Password "<string>" With Activation

#    Alteon Or Appwall From SUT
    Given That Device Alteon With SUT Number 14 is Logged In
    Given That Current Vision is Logged In

#    Given That Device Alteon with IP "172.17.164.17" and Port 443 and Protocol "https" is Logged In With Username "admin" and Password "shimon1!$4"

#    Given That Device AppWall With SUT Number 11 is Logged In

#    On Vision VDirect
    Given That Current On-Vision VDirect is Logged In
    Given That Current Vision is Logged In

#    Given That Current On-Vision VDirect with Port 2189 and with protocol "https" is Logged In With Username "sys_admin" and Password "radware"


#    Given New <string> Request Specification with Base Path "<string>"

  #### ES rest example
  Scenario: ES rest example
    When REST Delete ES index "ramez"
    Then REST Delete ES document with data ""module": "DEVICE_GENERAL"" from index "alert"

    Then REST Search ES index "alert" with query "{"query":{"bool":{"must":[{"wildcard":{"message":"M_60096: Collector service went down, analytics data cannot be collected"}}]}},"from":0,"size":100}" and validate response contain ""took": 9"
    Then REST Update ES index "{"query":{"bool":{"must":{"term":{"tunnel":"tun_HTTP"}}}}"script":{"source":"ctx._source.receivedTimeStamp='$(echo $(date +%s%3N)-7200000|bc)L';"}}" with query "" body and validate response contains ""took": 9"
