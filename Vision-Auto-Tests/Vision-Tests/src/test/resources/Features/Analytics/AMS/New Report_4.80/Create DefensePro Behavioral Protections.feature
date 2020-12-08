Feature: DefensePro Behavioral Protections

 @SID_1
 Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

 @SID_2
 Scenario: create new BDoS-TCP SYN1
   Given UI "Create" Report With Name "BDoS-TCP SYN1"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:10}] |
     | Time Definitions.Date | Relative:[Months,3]                                                                                                    |
     | Schedule              | Run Every:Daily,On Time:+2m                                                                                            |
     | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                         |
     | Format                | Select: CSV                                                                                                            |
   Then UI "Validate" Report With Name "BDoS-TCP SYN1"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:10}] |
     | Time Definitions.Date | Relative:[Months,3]                                                                                                    |
     | Schedule              | Run Every:Daily,On Time:+2m                                                                                            |
     | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                         |
     | Format                | Select: CSV                                                                                                            |
   Then UI Delete Report With Name "BDoS-TCP SYN1"

 @SID_3
 Scenario: create new BDoS-TCP SYN2
   Then UI Click Button "New Report Tab"
   Given UI "Create" Report With Name "BDoS-TCP SYN2"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:10}] |
     | Logo                  | reportLogoPNG.png                                                                                                       |
     | Time Definitions.Date | Quick:1D                                                                                                                |
     | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                                                            |
     | Format                | Select: CSV                                                                                                             |
   Then UI "Validate" Report With Name "BDoS-TCP SYN2"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:10}] |
     | Logo                  | reportLogoPNG.png                                                                                                       |
     | Time Definitions.Date | Quick:1D                                                                                                                |
     | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                                                            |
     | Format                | Select: CSV                                                                                                             |
   Then UI Delete Report With Name "BDoS-TCP SYN2"

 @SID_4
 Scenario: create new BDoS-TCP SYN3
   Then UI Click Button "New Report Tab"
   Given UI "Create" Report With Name "BDoS-TCP SYN3"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,bps,Outbound]}] ,devices:[{deviceIndex:10}]  |
     | Logo                  | reportLogoPNG.png                                                                                                        |
     | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                         |
     | Schedule              | Run Every:Once, On Time:+6H                                                                                              |
     | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                           |
     | Format                | Select: PDF                                                                                                              |
   Then UI "Validate" Report With Name "BDoS-TCP SYN3"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:10}] |
     | Logo                  | reportLogoPNG.png                                                                                                       |
     | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                        |
     | Schedule              | Run Every:Once, On Time:+6H                                                                                             |
     | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                          |
     | Format                | Select: PDF                                                                                                             |
   Then UI Delete Report With Name "BDoS-TCP SYN3"

 @SID_5
 Scenario: create new BDoS-TCP SYN4
   Then UI Click Button "New Report Tab"
   Given UI "Create" Report With Name "BDoS-TCP SYN4"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:10}] |
     | Time Definitions.Date | Quick:This Week                                                                                                        |
     | Format                | Select: HTML                                                                                                           |
   Then UI "Validate" Report With Name "BDoS-TCP SYN4"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:10}] |
     | Time Definitions.Date | Quick:This Week                                                                                                        |
     | Format                | Select: HTML                                                                                                           |
   Then UI Delete Report With Name "BDoS-TCP SYN4"

 @SID_6
 Scenario: create new BDoS-Advanced-UDP Rate-Invariant1
   Then UI Click Button "New Report Tab"
   Given UI "Create" Report With Name "BDoS-Advanced-UDP Rate-Invariant1"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-Advanced-UDP Rate-Invariant:[IPv4,Inbound]}] ,devices:[{deviceIndex:10}] |
     | Time Definitions.Date | Relative:[Days,3]                                                                                                         |
     | Schedule              | Run Every:Daily,On Time:+2m                                                                                               |
     | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                            |
     | Format                | Select: CSV                                                                                                               |
   Then UI "Validate" Report With Name "BDoS-Advanced-UDP Rate-Invariant1"
     | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-Advanced-UDP Rate-Invariant:[IPv4,Inbound]}] ,devices:[{deviceIndex:10}] |
     | Time Definitions.Date | Relative:[Days,3]                                                                                                         |
     | Schedule              | Run Every:Daily,On Time:+2m                                                                                               |
     | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                            |
     | Format                | Select: CSV                                                                                                               |
   Then UI Delete Report With Name "BDoS-Advanced-UDP Rate-Invariant1"

  @SID_7
  Scenario: create new BDoS-Advanced-UDP Rate-Invariant2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS-Advanced-UDP Rate-Invariant2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-Advanced-UDP Rate-Invariant:[IPv4,Outbound]}] ,devices:[{deviceIndex:10}] |
      | Logo                  | reportLogoPNG.png                                                                                                          |
      | Time Definitions.Date | Quick:This Week                                                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                |
      | Format                | Select: CSV                                                                                                                |
    Then UI "Validate" Report With Name "BDoS-Advanced-UDP Rate-Invariant2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-Advanced-UDP Rate-Invariant:[IPv4,Outbound]}] ,devices:[{deviceIndex:10}] |
      | Logo                  | reportLogoPNG.png                                                                                                          |
      | Time Definitions.Date | Quick:This Week                                                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                |
      | Format                | Select: CSV                                                                                                                |
    Then UI Delete Report With Name "BDoS-Advanced-UDP Rate-Invariant2"

  @SID_8
  Scenario: create new BDoS-Advanced-UDP Rate-Invariant3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS-Advanced-UDP Rate-Invariant3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-Advanced-UDP Rate-Invariant:[IPv6,Inbound]}] ,devices:[{deviceIndex:10}] |
      | Logo                  | reportLogoPNG.png                                                                                                         |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                        |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                            |
      | Format                | Select: PDF                                                                                                               |
    Then UI "Validate" Report With Name "BDoS-Advanced-UDP Rate-Invariant3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-Advanced-UDP Rate-Invariant:[IPv6,Inbound]}] ,devices:[{deviceIndex:10}] |
      | Logo                  | reportLogoPNG.png                                                                                                         |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                        |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                            |
      | Format                | Select: PDF                                                                                                               |
    Then UI Delete Report With Name "BDoS-Advanced-UDP Rate-Invariant3"

  @SID_9
  Scenario: create new BDoS-Advanced-UDP Rate-Invariant4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS-Advanced-UDP Rate-Invariant4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-Advanced-UDP Rate-Invariant:[IPv6,Outbound]}] ,devices:[{deviceIndex:10}] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                                                         |
      | Format                | Select: HTML                                                                                                                            |
    Then UI "Validate" Report With Name "BDoS-Advanced-UDP Rate-Invariant4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-Advanced-UDP Rate-Invariant:[IPv6,Outbound]}] ,devices:[{deviceIndex:10}] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                                                         |
      | Format                | Select: HTML                                                                                                                            |
    Then UI Delete Report With Name "BDoS-Advanced-UDP Rate-Invariant4"

  @SID_10
  Scenario: create new BDoS-TCP FIN ACK1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS-TCP FIN ACK1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP FIN ACK:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:10}] |
      | Time Definitions.Date | Relative:[Months,3]                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                |
      | Format                | Select: CSV                                                                                                   |
    Then UI "Validate" Report With Name "BDoS-TCP FIN ACK1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP FIN ACK:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:10}] |
      | Time Definitions.Date | Relative:[Months,3]                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                |
      | Format                | Select: CSV                                                                                                   |
    Then UI Delete Report With Name "BDoS-TCP FIN ACK1"

  @SID_11
  Scenario: create new BDoS-TCP FIN ACK2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS-TCP FIN ACK2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP FIN ACK:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:10}] |
      | Logo                  | reportLogoPNG.png                                                                                              |
      | Time Definitions.Date | Quick:30m                                                                                                      |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[TUE]                                                                   |
      | Format                | Select: CSV                                                                                                    |
    Then UI "Validate" Report With Name "BDoS-TCP FIN ACK2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP FIN ACK:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:10}] |
      | Logo                  | reportLogoPNG.png                                                                                              |
      | Time Definitions.Date | Quick:30m                                                                                                      |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[TUE]                                                                   |
      | Format                | Select: CSV                                                                                                    |
    Then UI Delete Report With Name "BDoS-TCP FIN ACK2"

  @SID_12
  Scenario: create new BDoS-TCP FIN ACK3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS-TCP FIN ACK3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP FIN ACK:[IPv4,bps,Outbound]}] ,devices:[{deviceIndex:10}] |
      | Logo                  | reportLogoPNG.png                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                 |
      | Format                | Select: PDF                                                                                                    |
    Then UI "Validate" Report With Name "BDoS-TCP FIN ACK3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP FIN ACK:[IPv4,bps,Outbound]}] ,devices:[{deviceIndex:10}] |
      | Logo                  | reportLogoPNG.png                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                 |
      | Format                | Select: PDF                                                                                                    |
    Then UI Delete Report With Name "BDoS-TCP FIN ACK3"

  @SID_13
  Scenario: create new BDoS-TCP FIN ACK4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS-TCP FIN ACK4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP FIN ACK:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:10}] |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                         |
      | Format                | Select: HTML                                                                                                               |
    Then UI "Validate" Report With Name "BDoS-TCP FIN ACK4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP FIN ACK:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:10}] |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                         |
      | Format                | Select: HTML                                                                                                               |
    Then UI Delete Report With Name "BDoS-TCP FIN ACK4"

  @SID_14
  Scenario: create new BDoS-TCP Fragmented1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS-TCP Fragmented1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:10}] |
      | Time Definitions.Date | Quick:Quarter                                                                                                    |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                   |
      | Format                | Select: CSV                                                                                                      |
    Then UI "Validate" Report With Name "BDoS-TCP Fragmented1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:10}] |
      | Time Definitions.Date | Quick:Quarter                                                                                                    |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                   |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Report With Name "BDoS-TCP Fragmented1"

  @SID_15
  Scenario: create new BDoS-TCP Fragmented2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS-TCP Fragmented2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:10}] |
      | Logo                  | reportLogoPNG.png                                                                                                 |
      | Time Definitions.Date | Quick:Previous Month                                                                                              |
      | Format                | Select: CSV                                                                                                       |
    Then UI "Validate" Report With Name "BDoS-TCP Fragmented2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:10}] |
      | Logo                  | reportLogoPNG.png                                                                                                 |
      | Time Definitions.Date | Quick:Previous Month                                                                                              |
      | Format                | Select: CSV                                                                                                       |
    Then UI Delete Report With Name "BDoS-TCP Fragmented2"

  @SID_16
  Scenario: create new BDoS-TCP Fragmented3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS-TCP Fragmented3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,bps,Outbound]}] ,devices:[{deviceIndex:10}] |
      | Logo                  | reportLogoPNG.png                                                                                                 |
      | Time Definitions.Date | Quick:This Month                                                                                                  |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                    |
      | Format                | Select: PDF                                                                                                       |
    Then UI "Validate" Report With Name "BDoS-TCP Fragmented3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,bps,Outbound]}] ,devices:[{deviceIndex:10}] |
      | Logo                  | reportLogoPNG.png                                                                                                 |
      | Time Definitions.Date | Quick:This Month                                                                                                  |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                    |
      | Format                | Select: PDF                                                                                                       |
    Then UI Delete Report With Name "BDoS-TCP Fragmented3"

  @SID_17
  Scenario: create new BDoS-TCP Fragmented4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS-TCP Fragmented4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:10}] |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                               |
      | Format                | Select: HTML                                                                                                                  |
    Then UI "Validate" Report With Name "BDoS-TCP Fragmented4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,pps,Inbound]}] ,devices:[{deviceIndex:10}] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                               |
      | Format                | Select: HTML                                                                                                                  |
    Then UI Delete Report With Name "BDoS-TCP Fragmented4"

  @SID_18
  Scenario: create new BDoS-TCP RST1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS-TCP RST1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:10}] |
      | Time Definitions.Date | Quick:[Hours,3]                                                                                |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                   |
      | Format                | Select: CSV                                                                                                      |
    Then UI "Validate" Report With Name "BDoS-TCP RST1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,bps,Inbound]}] ,devices:[{deviceIndex:10}] |
      | Time Definitions.Date | Quick:[Hours,3]                                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                   |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Report With Name "BDoS-TCP RST1"

  @SID_19
  Scenario: create new BDoS-TCP RST2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS-TCP RST2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:10}] |
      | Logo                  | reportLogoPNG.png                                                                                                 |
      | Time Definitions.Date | Quick:15m                                                                                                         |
      | Format                | Select: CSV                                                                                                       |
    Then UI "Validate" Report With Name "BDoS-TCP RST2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,pps,Outbound]}] ,devices:[{deviceIndex:10}] |
      | Logo                  | reportLogoPNG.png                                                                                                 |
      | Time Definitions.Date | Quick:This Week                                                                                                         |
      | Format                | Select: CSV                                                                                                       |
    Then UI Delete Report With Name "BDoS-TCP RST2"

  @SID_20
  Scenario: create new BDoS-TCP RST3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "BDoS-TCP RST3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,bps,Outbound]}] ,devices:[{deviceIndex:10}] |
      | Logo                  | reportLogoPNG.png                                                                                                 |
      | Time Definitions.Date | Quick:15m                                                                                                  |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                    |
      | Format                | Select: PDF                                                                                                       |
    Then UI "Validate" Report With Name "BDoS-TCP RST3"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP Fragmented:[IPv4,bps,Outbound]}] ,devices:[{deviceIndex:10}] |
      | Logo                  | reportLogoPNG.png                                                                                                 |
      | Time Definitions.Date | Quick:This Week                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                    |
      | Format                | Select: PDF                                                                                                       |
    Then UI Delete Report With Name "BDoS-TCP RST3"
















































































































































































































