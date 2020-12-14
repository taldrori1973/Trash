@TC118526
Feature: DefensePro Behavioral Protections Part 1

 @SID_1
 Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

 @SID_2
 Scenario: create new BDoS-TCP SYN1
   Given UI "Create" Report With Name "BDoS_TCP SYN1"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
     | Time Definitions.Date | Relative:[Months,3]                                                                                                    |
     | Schedule              | Run Every:Daily,On Time:+2m                                                                                            |
     | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                         |
     | Format                | Select: CSV                                                                                                            |
   Then UI "Validate" Report With Name "BDoS_TCP SYN1"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
     | Time Definitions.Date | Relative:[Months,3]                                                                                                    |
     | Schedule              | Run Every:Daily,On Time:+2m                                                                                            |
     | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                         |
     | Format                | Select: CSV                                                                                                            |
   Then UI Delete Report With Name "BDoS_TCP SYN1"

 @SID_3
 Scenario: create new BDoS-TCP SYN2
   Then UI Click Button "New Report Tab"
   Given UI "Create" Report With Name "BDoS_TCP SYN2"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
     | Logo                  | reportLogoPNG.png                                                                                                       |
     | Time Definitions.Date | Quick:1D                                                                                                                |
     | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                                                            |
     | Format                | Select: CSV                                                                                                             |
   Then UI "Validate" Report With Name "BDoS_TCP SYN2"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
     | Logo                  | reportLogoPNG.png                                                                                                       |
     | Time Definitions.Date | Quick:1D                                                                                                                |
     | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                                                            |
     | Format                | Select: CSV                                                                                                             |
   Then UI Delete Report With Name "BDoS_TCP SYN2"

 @SID_4
 Scenario: create new BDoS-TCP SYN3
   Then UI Click Button "New Report Tab"
   Given UI "Create" Report With Name "BDoS_TCP SYN3"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}]  |
     | Logo                  | reportLogoPNG.png                                                                                                        |
     | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                         |
     | Schedule              | Run Every:Once, On Time:+6H                                                                                              |
     | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                           |
     | Format                | Select: PDF                                                                                                              |
   Then UI "Validate" Report With Name "BDoS_TCP SYN3"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
     | Logo                  | reportLogoPNG.png                                                                                                       |
     | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                        |
     | Schedule              | Run Every:Once, On Time:+6H                                                                                             |
     | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                          |
     | Format                | Select: PDF                                                                                                             |
   Then UI Delete Report With Name "BDoS_TCP SYN3"

 @SID_5
 Scenario: create new BDoS-TCP SYN4
   Then UI Click Button "New Report Tab"
   Given UI "Create" Report With Name "BDoS_TCP SYN4"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
     | Time Definitions.Date | Quick:This Week                                                                                                        |
     | Format                | Select: HTML                                                                                                           |
   Then UI "Validate" Report With Name "BDoS_TCP SYN4"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
     | Time Definitions.Date | Quick:This Week                                                                                                        |
     | Format                | Select: HTML                                                                                                           |
   Then UI Delete Report With Name "BDoS_TCP SYN4"

 @SID_6
 Scenario: create new BDoS-Advanced-UDP Rate-Invariant1
   Then UI Click Button "New Report Tab"
   Given UI "Create" Report With Name "BDoS_Advanced_UDP Rate_Invariant1"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-Advanced-UDP Rate-Invariant:[IPv4,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
     | Time Definitions.Date | Relative:[Days,3]                                                                                                         |
     | Schedule              | Run Every:Daily,On Time:+2m                                                                                               |
     | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                            |
     | Format                | Select: CSV                                                                                                               |
   Then UI "Validate" Report With Name "BDoS_Advanced_UDP Rate_Invariant1"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-Advanced-UDP Rate-Invariant:[IPv4,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
     | Time Definitions.Date | Relative:[Days,3]                                                                                                         |
     | Schedule              | Run Every:Daily,On Time:+2m                                                                                               |
     | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                            |
     | Format                | Select: CSV                                                                                                               |
   Then UI Delete Report With Name "BDoS_Advanced_UDP Rate_Invariant1"

  @SID_7
  Scenario: create new BDoS-Advanced-UDP Rate-Invariant2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_Advanced_UDP Rate_Invariant2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-Advanced-UDP Rate-Invariant:[IPv4,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                          |
      | Time Definitions.Date | Quick:This Week                                                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                |
      | Format                | Select: CSV                                                                                                                |
    Then UI "Validate" Report With Name "BDoS_Advanced_UDP Rate_Invariant2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-Advanced-UDP Rate-Invariant:[IPv4,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                          |
      | Time Definitions.Date | Quick:This Week                                                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                |
      | Format                | Select: CSV                                                                                                                |
    Then UI Delete Report With Name "BDoS_Advanced_UDP Rate_Invariant2"

  @SID_8
  Scenario: create new BDoS-Advanced-UDP Rate-Invariant3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_Advanced_UDP Rate_Invariant3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-Advanced-UDP Rate-Invariant:[IPv6,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                         |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                        |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                            |
      | Format                | Select: PDF                                                                                                               |
    Then UI "Validate" Report With Name "BDoS_Advanced_UDP Rate_Invariant3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-Advanced-UDP Rate-Invariant:[IPv6,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                         |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                        |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                            |
      | Format                | Select: PDF                                                                                                               |
    Then UI Delete Report With Name "BDoS_Advanced_UDP Rate_Invariant3"

  @SID_9
  Scenario: create new BDoS-Advanced-UDP Rate-Invariant4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_Advanced_UDP Rate_Invariant4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-Advanced-UDP Rate-Invariant:[IPv6,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                                                         |
      | Format                | Select: HTML                                                                                                                            |
    Then UI "Validate" Report With Name "BDoS_Advanced_UDP Rate_Invariant4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-Advanced-UDP Rate-Invariant:[IPv6,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                                                         |
      | Format                | Select: HTML                                                                                                                            |
    Then UI Delete Report With Name "BDoS_Advanced_UDP Rate_Invariant4"

  @SID_10
  Scenario: create new BDoS-TCP FIN ACK1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_TCP FIN ACK1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP FIN ACK:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Months,3]                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                |
      | Format                | Select: CSV                                                                                                   |
    Then UI "Validate" Report With Name "BDoS_TCP FIN ACK1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP FIN ACK:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Months,3]                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                |
      | Format                | Select: CSV                                                                                                   |
    Then UI Delete Report With Name "BDoS_TCP FIN ACK1"

  @SID_11
  Scenario: create new BDoS-TCP FIN ACK2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_TCP FIN ACK2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP FIN ACK:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                              |
      | Time Definitions.Date | Quick:30m                                                                                                      |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[TUE]                                                                   |
      | Format                | Select: CSV                                                                                                    |
    Then UI "Validate" Report With Name "BDoS_TCP FIN ACK2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP FIN ACK:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                              |
      | Time Definitions.Date | Quick:30m                                                                                                      |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[TUE]                                                                   |
      | Format                | Select: CSV                                                                                                    |
    Then UI Delete Report With Name "BDoS_TCP FIN ACK2"

  @SID_12
  Scenario: create new BDoS-TCP FIN ACK3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_TCP FIN ACK3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP FIN ACK:[IPv4,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                 |
      | Format                | Select: PDF                                                                                                    |
    Then UI "Validate" Report With Name "BDoS_TCP FIN ACK3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP FIN ACK:[IPv4,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                 |
      | Format                | Select: PDF                                                                                                    |
    Then UI Delete Report With Name "BDoS_TCP FIN ACK3"

  @SID_13
  Scenario: create new BDoS-TCP FIN ACK4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_TCP FIN ACK4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP FIN ACK:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                         |
      | Format                | Select: HTML                                                                                                               |
    Then UI "Validate" Report With Name "BDoS_TCP FIN ACK4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP FIN ACK:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                         |
      | Format                | Select: HTML                                                                                                               |
    Then UI Delete Report With Name "BDoS_TCP FIN ACK4"

  @SID_14
  Scenario: create new BDoS-TCP Fragmented1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_TCP Fragmented1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:Quarter                                                                                                    |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                   |
      | Format                | Select: CSV                                                                                                      |
    Then UI "Validate" Report With Name "BDoS_TCP Fragmented1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:Quarter                                                                                                    |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                   |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Report With Name "BDoS_TCP Fragmented1"

  @SID_15
  Scenario: create new BDoS-TCP Fragmented2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_TCP Fragmented2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                 |
      | Time Definitions.Date | Quick:Previous Month                                                                                              |
      | Format                | Select: CSV                                                                                                       |
    Then UI "Validate" Report With Name "BDoS_TCP Fragmented2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                 |
      | Time Definitions.Date | Quick:Previous Month                                                                                              |
      | Format                | Select: CSV                                                                                                       |
    Then UI Delete Report With Name "BDoS_TCP Fragmented2"

  @SID_16
  Scenario: create new BDoS-TCP Fragmented3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_TCP Fragmented3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                 |
      | Time Definitions.Date | Quick:This Month                                                                                                  |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                    |
      | Format                | Select: PDF                                                                                                       |
    Then UI "Validate" Report With Name "BDoS_TCP Fragmented3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                 |
      | Time Definitions.Date | Quick:This Month                                                                                                  |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                    |
      | Format                | Select: PDF                                                                                                       |
    Then UI Delete Report With Name "BDoS_TCP Fragmented3"

  @SID_17
  Scenario: create new BDoS-TCP Fragmented4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_TCP Fragmented4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                               |
      | Format                | Select: HTML                                                                                                                  |
    Then UI "Validate" Report With Name "BDoS_TCP Fragmented4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                               |
      | Format                | Select: HTML                                                                                                                  |
    Then UI Delete Report With Name "BDoS_TCP Fragmented4"

  @SID_18
  Scenario: create new BDoS-TCP RST1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_TCP RST1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP RST:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:[Hours,3]                                                                                |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                   |
      | Format                | Select: CSV                                                                                                      |
    Then UI "Validate" Report With Name "BDoS_TCP RST1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP RST:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:[Hours,3]                                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                   |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Report With Name "BDoS_TCP RST1"

  @SID_19
  Scenario: create new BDoS-TCP RST2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_TCP RST2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP RST:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                 |
      | Time Definitions.Date | Quick:15m                                                                                                         |
      | Format                | Select: CSV                                                                                                       |
    Then UI "Validate" Report With Name "BDoS_TCP RST2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP RST:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                 |
      | Time Definitions.Date | Quick:15m                                                                                                      |
      | Format                | Select: CSV                                                                                                       |
    Then UI Delete Report With Name "BDoS_TCP RST2"

  @SID_20
  Scenario: create new BDoS-TCP RST3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_TCP RST3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP RST:[IPv4,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                 |
      | Time Definitions.Date | Quick:This Week                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                    |
      | Format                | Select: PDF                                                                                                       |
    Then UI "Validate" Report With Name "BDoS_TCP RST3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP RST:[IPv4,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                 |
      | Time Definitions.Date | Quick:This Week                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                    |
      | Format                | Select: PDF                                                                                                       |
    Then UI Delete Report With Name "BDoS_TCP RST3"

  @SID_21
  Scenario: create new BDoS-TCP RST4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_TCP RST4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP RST:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                               |
      | Format                | Select: HTML                                                                                                                  |
    Then UI "Validate" Report With Name "BDoS_TCP RST4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP RST:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                               |
      | Format                | Select: HTML                                                                                                                  |
    Then UI Delete Report With Name "BDoS_TCP RST4"

  @SID_22
  Scenario: create new BDoS-TCP SYN ACK1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_TCP SYN ACK1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN ACK:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                         |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                             |
      | Format                | Select: CSV                                                                                                                |
    Then UI "Validate" Report With Name "BDoS_TCP SYN ACK1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN ACK:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                         |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                             |
      | Format                | Select: CSV                                                                                                                |
    Then UI Delete Report With Name "BDoS_TCP SYN ACK1"

  @SID_23
  Scenario: create new BDoS-TCP SYN ACK2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_TCP SYN ACK2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN ACK:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                           |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                           |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                |
      | Format                | Select: PDF                                                                                                                 |
    Then UI "Validate" Report With Name "BDoS_TCP SYN ACK2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN ACK:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                           |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                                           |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                |
      | Format                | Select: PDF                                                                                                                 |
    Then UI Delete Report With Name "BDoS_TCP SYN ACK2"

  @SID_24
  Scenario: create new BDoS-TCP SYN ACK3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_TCP SYN ACK3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN ACK:[IPv4,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                           |
      | Time Definitions.Date | Quick:3M                                                                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                              |
      | Format                | Select: PDF                                                                                                                 |
    Then UI "Validate" Report With Name "BDoS_TCP SYN ACK3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN ACK:[IPv4,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                           |
      | Time Definitions.Date | Quick:3M                                                                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                              |
      | Format                | Select: PDF                                                                                                                 |
    Then UI Delete Report With Name "BDoS_TCP SYN ACK3"

  @SID_25
  Scenario: create new BDoS-TCP SYN ACK4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_TCP SYN ACK4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN ACK:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:This Month                                                                                                           |
      | Format                | Select: HTML                                                                                                               |
    Then UI "Validate" Report With Name "BDoS_TCP SYN ACK4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN ACK:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:This Month                                                                                                           |
      | Format                | Select: HTML                                                                                                               |
    Then UI Delete Report With Name "BDoS_TCP SYN ACK4"

  @SID_26
  Scenario: create new BDoS-UDP1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_UDP1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-UDP:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:1H                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                    |
      | Format                | Select: HTML                                                                                                       |
    Then UI "Validate" Report With Name "BDoS_UDP1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-UDP:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}]|
      | Time Definitions.Date | Quick:1H                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                    |
      | Format                | Select: HTML                                                                                                       |
    Then UI Delete Report With Name "BDoS_UDP1"

  @SID_27
  Scenario: create new BDoS-UDP2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_UDP2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-UDP:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}]|
      | Logo                  | reportLogoPNG.png                                                                                                   |
      | Time Definitions.Date | Quick:15m                                                                                                           |
      | Format                | Select: CSV                                                                                                         |
    Then UI "Validate" Report With Name "BDoS_UDP2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-UDP:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}]|
      | Logo                  | reportLogoPNG.png                                                                                                   |
      | Time Definitions.Date | Quick:15m                                                                                                           |
      | Format                | Select: CSV                                                                                                         |
    Then UI Delete Report With Name "BDoS_UDP2"

  @SID_28
  Scenario: create new BDoS-UDP3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_UDP3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-UDP:[IPv6,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                   |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                      |
      | Format                | Select: PDF                                                                                                         |
    Then UI "Validate" Report With Name "BDoS_UDP3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-UDP:[IPv6,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                   |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                      |
      | Format                | Select: PDF                                                                                                         |
    Then UI Delete Report With Name "BDoS_UDP3"

  @SID_29
  Scenario: create new BDoS-UDP4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_UDP4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-UDP:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                  |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                       |
      | Format                | Select: HTML                                                                                                       |
    Then UI "Validate" Report With Name "BDoS_UDP4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-UDP:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                  |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                       |
      | Format                | Select: HTML                                                                                                       |
    Then UI Delete Report With Name "BDoS_UDP4"

  @SID_30
  Scenario: create new BDoS-UDP Fragmented1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_UDP Fragmented1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-UDP Fragmented:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Months,3]                                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                |
      | Format                | Select: CSV                                                                                                                   |
    Then UI "Validate" Report With Name "BDoS_UDP Fragmented1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-UDP Fragmented:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Months,3]                                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                |
      | Format                | Select: CSV                                                                                                                   |
    Then UI Delete Report With Name "BDoS_UDP Fragmented1"

  @SID_31
  Scenario: create new BDoS-UDP Fragmented2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_UDP Fragmented2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-UDP Fragmented:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                              |
      | Time Definitions.Date | Quick:1D                                                                                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                                                                   |
      | Format                | Select: CSV                                                                                                                    |
    Then UI "Validate" Report With Name "BDoS_UDP Fragmented2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-UDP Fragmented:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                              |
      | Time Definitions.Date | Quick:1D                                                                                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                                                                   |
      | Format                | Select: CSV                                                                                                                    |
    Then UI Delete Report With Name "BDoS_UDP Fragmented2"

  @SID_32
  Scenario: create new BDoS-UDP Fragmented3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_UDP Fragmented3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-UDP Fragmented:[IPv6,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                              |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                                              |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                 |
      | Format                | Select: PDF                                                                                                                    |
    Then UI "Validate" Report With Name "BDoS_UDP Fragmented3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-UDP Fragmented:[IPv6,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                              |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                                              |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                 |
      | Format                | Select: PDF                                                                                                                    |
    Then UI Delete Report With Name "BDoS_UDP Fragmented3"

  @SID_33
  Scenario: create new BDoS-UDP Fragmented4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_UDP Fragmented4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-UDP Fragmented:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:This Week                                                                                                               |
      | Format                | Select: HTML                                                                                                                  |
    Then UI "Validate" Report With Name "BDoS_UDP Fragmented4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-UDP Fragmented:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:This Week                                                                                                               |
      | Format                | Select: HTML                                                                                                                  |
    Then UI Delete Report With Name "BDoS_UDP Fragmented4"

  @SID_34
  Scenario: create new BDoS-ICMP1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_ICMP1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-ICMP:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}]|
      | Time Definitions.Date | Relative:[Days,3]                                                                                                   |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                      |
      | Format                | Select: CSV                                                                                                         |
    Then UI "Validate" Report With Name "BDoS_ICMP1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-ICMP:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}]|
      | Time Definitions.Date | Relative:[Days,3]                                                                                                   |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                      |
      | Format                | Select: CSV                                                                                                         |
    Then UI Delete Report With Name "BDoS_ICMP1"

  @SID_35
  Scenario: create new BDoS-ICMP2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_ICMP2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-ICMP:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                    |
      | Time Definitions.Date | Quick:This Week                                                                                                      |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                          |
      | Format                | Select: CSV                                                                                                          |
    Then UI "Validate" Report With Name "BDoS_ICMP2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-ICMP:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}]|
      | Logo                  | reportLogoPNG.png                                                                                                    |
      | Time Definitions.Date | Quick:This Week                                                                                                      |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                          |
      | Format                | Select: CSV                                                                                                          |
    Then UI Delete Report With Name "BDoS_ICMP2"

  @SID_36
  Scenario: create new BDoS-ICMP3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_ICMP3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-ICMP:[IPv6,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                    |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                   |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                       |
      | Format                | Select: PDF                                                                                                          |
    Then UI "Validate" Report With Name "BDoS_ICMP3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-ICMP:[IPv6,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                    |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                   |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                       |
      | Format                | Select: PDF                                                                                                          |
    Then UI Delete Report With Name "BDoS_ICMP3"

  @SID_37
  Scenario: create new BDoS-ICMP4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_ICMP4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-ICMP:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                                     |
      | Format                | Select: HTML                                                                                                        |
    Then UI "Validate" Report With Name "BDoS_ICMP4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-ICMP:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                                     |
      | Format                | Select: HTML                                                                                                        |
    Then UI Delete Report With Name "BDoS_ICMP4"

  @SID_38
  Scenario: create new BDoS-IGMP1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_IGMP1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-IGMP:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Months,3]                                                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                      |
      | Format                | Select: CSV                                                                                                         |
    Then UI "Validate" Report With Name "BDoS_IGMP1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-IGMP:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Months,3]                                                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                      |
      | Format                | Select: CSV                                                                                                         |
    Then UI Delete Report With Name "BDoS_IGMP1"

  @SID_39
  Scenario: create new BDoS-IGMP2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_IGMP2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-IGMP:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                    |
      | Time Definitions.Date | Quick:30m                                                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[TUE]                                                                         |
      | Format                | Select: CSV                                                                                                          |
    Then UI "Validate" Report With Name "BDoS_IGMP2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-IGMP:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                    |
      | Time Definitions.Date | Quick:30m                                                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[TUE]                                                                         |
      | Format                | Select: CSV                                                                                                          |
    Then UI Delete Report With Name "BDoS_IGMP2"

  @SID_40
  Scenario: create new BDoS-IGMP3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_IGMP3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-IGMP:[IPv6,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                                    |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                       |
      | Format                | Select: PDF                                                                                                          |
    Then UI "Validate" Report With Name "BDoS_IGMP3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-IGMP:[IPv6,bps,Outbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}]|
      | Logo                  | reportLogoPNG.png                                                                                                    |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                       |
      | Format                | Select: PDF                                                                                                          |
    Then UI Delete Report With Name "BDoS_IGMP3"

  @SID_41
  Scenario: create new BDoS-IGMP4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS_IGMP4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-IGMP:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}]|
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                  |
      | Format                | Select: HTML                                                                                                        |
    Then UI "Validate" Report With Name "BDoS_IGMP4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-IGMP:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                  |
      | Format                | Select: HTML                                                                                                        |
    Then UI Delete Report With Name "BDoS_IGMP4"

  @SID_42
  Scenario: create new DNS-TXT1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_TXT1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-TXT:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:Quarter                                                                                         |
      | Schedule              | Run Every:Once, On Time:+6H                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
      | Format                | Select: CSV                                                                                           |
    Then UI "Validate" Report With Name "DNS_TXT1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-TXT:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}]|
      | Time Definitions.Date | Quick:Quarter                                                                                         |
      | Schedule              | Run Every:Once, On Time:+6H                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
      | Format                | Select: CSV                                                                                           |
    Then UI Delete Report With Name "DNS_TXT1"

  @SID_43
  Scenario: create new DNS-TXT2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_TXT2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-TXT:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:Previous Month                                                                                  |
      | Format                | Select: CSV                                                                                           |
    Then UI "Validate" Report With Name "DNS_TXT2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-TXT:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:Previous Month                                                                                  |
      | Format                | Select: CSV                                                                                           |
    Then UI Delete Report With Name "DNS_TXT2"

  @SID_44
  Scenario: create new DNS-TXT3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_TXT3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-TXT:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}]|
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:This Month                                                                                      |
      | Schedule              | Run Every:Once, On Time:+6H                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
      | Format                | Select: PDF                                                                                           |
    Then UI "Validate" Report With Name "DNS_TXT3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-TXT:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:This Month                                                                                      |
      | Schedule              | Run Every:Once, On Time:+6H                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
      | Format                | Select: PDF                                                                                           |
    Then UI Delete Report With Name "DNS_TXT3"

  @SID_45
  Scenario: create new DNS-TXT4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_TXT4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-TXT:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}]|
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                       |
      | Format                | Select: HTML                                                                                          |
    Then UI "Validate" Report With Name "DNS_TXT4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-TXT:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                       |
      | Format                | Select: HTML                                                                                          |
    Then UI Delete Report With Name "DNS_TXT4"

  @SID_46
  Scenario: create new DNS-A1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_A1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-A:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:[Hours,3]                                                                                     |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                      |
      | Format                | Select: CSV                                                                                         |
    Then UI "Validate" Report With Name "DNS_A1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-A:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:[Hours,3]                                                                                     |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                      |
      | Format                | Select: CSV                                                                                         |
    Then UI Delete Report With Name "DNS_A1"

  @SID_47
  Scenario: create new DNS-A2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_A2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-A:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Quick:15m                                                                                           |
      | Format                | Select: CSV                                                                                         |
    Then UI "Validate" Report With Name "DNS_A2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-A:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Quick:15m                                                                                           |
      | Format                | Select: CSV                                                                                         |
    Then UI Delete Report With Name "DNS_A2"

  @SID_48
  Scenario: create new DNS-A3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_A3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-A:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Quick:This Week                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                      |
      | Format                | Select: PDF                                                                                         |
    Then UI "Validate" Report With Name "DNS_A3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-A:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Quick:This Week                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                      |
      | Format                | Select: PDF                                                                                         |
    Then UI Delete Report With Name "DNS_A3"

  @SID_49
  Scenario: create new DNS-A4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_A4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-A:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                     |
      | Format                | Select: HTML                                                                                        |
    Then UI "Validate" Report With Name "DNS_A4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-A:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                     |
      | Format                | Select: HTML                                                                                        |
    Then UI Delete Report With Name "DNS_A4"

  @SID_50
  Scenario: create new DNS-AAAA1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_AAAA1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-AAAA:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:[Weeks,3]                                                                                        |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
      | Format                | Select: CSV                                                                                            |
    Then UI "Validate" Report With Name "DNS_AAAA1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-AAAA:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:[Weeks,3]                                                                                        |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
      | Format                | Select: CSV                                                                                            |
    Then UI Delete Report With Name "DNS_AAAA1"

  @SID_51
  Scenario: create new DNS-AAAA2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_AAAA2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-AAAA:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                   |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                        |
      | Format                | Select: CSV                                                                                         |
    Then UI "Validate" Report With Name "DNS_AAAA2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-AAAA:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                   |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                        |
      | Format                | Select: CSV                                                                                         |
    Then UI Delete Report With Name "DNS_AAAA2"

  @SID_52
  Scenario: create new DNS-AAAA3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_AAAA3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[DNS-AAAA:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                      |
      | Time Definitions.Date | Quick:3M                                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
      | Format                | Select: PDF                                                                                            |
    Then UI "Validate" Report With Name "DNS_AAAA3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[DNS-AAAA:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}]|
      | Logo                  | reportLogoPNG.png                                                                                      |
      | Time Definitions.Date | Quick:3M                                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
      | Format                | Select: PDF                                                                                            |
    Then UI Delete Report With Name "DNS_AAAA3"

  @SID_53
  Scenario: create new DNS-AAAA4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_AAAA4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-AAAA:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:This Month                                                                                        |
      | Format                | Select: HTML                                                                                            |
    Then UI "Validate" Report With Name "DNS_AAAA4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-AAAA:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:This Month                                                                                        |
      | Format                | Select: HTML                                                                                            |
    Then UI Delete Report With Name "DNS_AAAA4"

  @SID_54
  Scenario: create new DNS-MX1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_MX1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-MX:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:1H                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                       |
      | Format                | Select: HTML                                                                                          |
    Then UI "Validate" Report With Name "DNS_MX1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-MX:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:1H                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                       |
      | Format                | Select: HTML                                                                                          |
    Then UI Delete Report With Name "DNS_MX1"

  @SID_55
  Scenario: create new DNS-MX2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_MX2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-MX:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:15m                                                                                             |
      | Format                | Select: CSV                                                                                           |
    Then UI "Validate" Report With Name "DNS_MX2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-MX:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:15m                                                                                             |
      | Format                | Select: CSV                                                                                           |
    Then UI Delete Report With Name "DNS_MX2"

  @SID_56
  Scenario: create new DNS-MX3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_MX3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-MX:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:This Week                                                                                       |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
      | Format                | Select: PDF                                                                                           |
    Then UI "Validate" Report With Name "DNS_MX3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-MX:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:This Week                                                                                       |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
      | Format                | Select: PDF                                                                                           |
    Then UI Delete Report With Name "DNS_MX3"

  @SID_57
  Scenario: create new DNS-MX4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_MX4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-MX:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                       |
      | Format                | Select: HTML                                                                                          |
    Then UI "Validate" Report With Name "DNS_MX4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-MX:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                       |
      | Format                | Select: HTML                                                                                          |
    Then UI Delete Report With Name "DNS_MX4"

  @SID_58
  Scenario: create new DNS-NAPTR1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_NAPTR1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-NAPTR:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:[Weeks,3]                                                                                          |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                           |
      | Format                | Select: CSV                                                                                              |
    Then UI "Validate" Report With Name "DNS_NAPTR1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-NAPTR:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:[Weeks,3]                                                                                          |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                           |
      | Format                | Select: CSV                                                                                              |
    Then UI Delete Report With Name "DNS_NAPTR1"

  @SID_59
  Scenario: create new DNS-NAPTR2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_NAPTR2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-NAPTR:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Time Definitions.Date | Quick:15m                                                                                                |
      | Format                | Select: CSV                                                                                              |
    Then UI "Validate" Report With Name "DNS_NAPTR2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-NAPTR:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Time Definitions.Date | Quick:15m                                                                                                |
      | Format                | Select: CSV                                                                                              |
      | Format                | Select: CSV                                                                                              |
    Then UI Delete Report With Name "DNS_NAPTR2"

  @SID_60
  Scenario: create new DNS-NAPTR3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_NAPTR3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-NAPTR:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Time Definitions.Date | Quick:This Week                                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                           |
      | Format                | Select: PDF                                                                                              |
    Then UI "Validate" Report With Name "DNS_NAPTR3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-NAPTR:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Time Definitions.Date | Quick:This Week                                                                                          |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                           |
      | Format                | Select: PDF                                                                                              |
    Then UI Delete Report With Name "DNS_NAPTR3"

  @SID_61
  Scenario: create new DNS-NAPTR4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_NAPTR4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-NAPTR:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}]|
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                          |
      | Format                | Select: HTML                                                                                             |
    Then UI "Validate" Report With Name "DNS_NAPTR4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-NAPTR:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                          |
      | Format                | Select: HTML                                                                                             |
    Then UI Delete Report With Name "DNS_NAPTR4"

  @SID_62
  Scenario: create new DNS-PTR1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_PTR1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-PTR:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:[Weeks,3]                                                                                       |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
      | Format                | Select: CSV                                                                                           |
    Then UI "Validate" Report With Name "DNS_PTR1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-PTR:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:[Weeks,3]                                                                                       |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
      | Format                | Select: CSV                                                                                           |
    Then UI Delete Report With Name "DNS_PTR1"

  @SID_63
  Scenario: create new DNS-PTR2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_PTR2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-PTR:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:Previous Month                                                                                  |
      | Format                | Select: CSV                                                                                           |
    Then UI "Validate" Report With Name "DNS_PTR2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-PTR:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}]|
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:Previous Month                                                                                  |
      | Format                | Select: CSV                                                                                           |
    Then UI Delete Report With Name "DNS_PTR2"

  @SID_64
  Scenario: create new DNS-PTR3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_PTR3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-PTR:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:This Month                                                                                      |
      | Schedule              | Run Every:Once, On Time:+6H                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
      | Format                | Select: PDF                                                                                           |
    Then UI "Validate" Report With Name "DNS_PTR3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-PTR:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                     |
      | Time Definitions.Date | Quick:This Month                                                                                      |
      | Schedule              | Run Every:Once, On Time:+6H                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
      | Format                | Select: PDF                                                                                           |
    Then UI Delete Report With Name "DNS_PTR3"

  @SID_65
  Scenario: create new DNS-PTR4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_PTR4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-PTR:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                       |
      | Format                | Select: HTML                                                                                          |
    Then UI "Validate" Report With Name "DNS_PTR4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-PTR:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                       |
      | Format                | Select: HTML                                                                                          |
    Then UI Delete Report With Name "DNS_PTR4"

  @SID_66
  Scenario: Logout
    Then UI logout and close browser











































































































































































































