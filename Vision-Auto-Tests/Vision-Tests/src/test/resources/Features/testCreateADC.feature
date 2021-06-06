@run
Feature: test

  @SID_1
  Scenario: Login and Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
 Scenario: create new BDoS-TCP SYN1
    Given UI "Create" Report With Name "BDoS_TCP SYN1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,bps,Inbound,{Instances:[1,2,3]}]}] |
#    Then UI Delete Report With Name "System and Network Report"

    #,{BDoS-IGMP:[IPv4,pps,Inbound],Instances:[maha,amal]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}


    Given UI "Create" Report With Name "Application Report"
      | Template | reportType:Application ,Widgets:[Concurrent Connections] , Applications:[6:80] |
#    Then UI Delete Report With Name "Application Report"


#    Given UI "Create" Report With Name "System and Network Report"
#      | Template | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.164.17] |
#    Then UI Delete Report With Name "System and Network Report"


