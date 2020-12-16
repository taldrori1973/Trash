@TC118527
Feature: DefensePro Behavioral Protections Part 2


  @SID_1
    Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage
    Then UI Click Button "New Report Tab"


  @SID_2
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

  @SID_3
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

  @SID_4
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

  @SID_5
  Scenario: create new DNS-TXT4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_TXT4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-TXT:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}]|
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                       |
      | Format                | Select: HTML                                                                                          |
    Then UI "Validate" Report With Name "DNS_TXT4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-TXT:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                       |
      | Format                | Select: HTML                                                                                          |
    Then UI Delete Report With Name "DNS_TXT4"

  @SID_6
  Scenario: create new DNS-A1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_A1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-A:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:1D                                                                                    |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                      |
      | Format                | Select: CSV                                                                                         |
    Then UI "Validate" Report With Name "DNS_A1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-A:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Quick:1D                                                                                     |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                      |
      | Format                | Select: CSV                                                                                         |
    Then UI Delete Report With Name "DNS_A1"

  @SID_7
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

  @SID_8
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

  @SID_9
  Scenario: create new DNS-A4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_A4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-A:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                     |
      | Format                | Select: HTML                                                                                        |
    Then UI "Validate" Report With Name "DNS_A4"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-A:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                     |
      | Format                | Select: HTML                                                                                        |
    Then UI Delete Report With Name "DNS_A4"

  @SID_10
  Scenario: create new DNS-AAAA1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_AAAA1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-AAAA:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                        |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
      | Format                | Select: CSV                                                                                            |
    Then UI "Validate" Report With Name "DNS_AAAA1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-AAAA:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                        |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                         |
      | Format                | Select: CSV                                                                                            |
    Then UI Delete Report With Name "DNS_AAAA1"

  @SID_11
  Scenario: create new DNS-AAAA2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_AAAA2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-AAAA:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                    |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                        |
      | Format                | Select: CSV                                                                                         |
    Then UI "Validate" Report With Name "DNS_AAAA2"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-AAAA:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Logo                  | reportLogoPNG.png                                                                                   |
      | Time Definitions.Date |  Absolute:[27.02.1971 01:00, +0d]                                                                   |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                        |
      | Format                | Select: CSV                                                                                         |
    Then UI Delete Report With Name "DNS_AAAA2"

  @SID_12
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

  @SID_13
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

  @SID_14
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

  @SID_15
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

  @SID_16
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

  @SID_17
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

  @SID_18
  Scenario: create new DNS-NAPTR1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_NAPTR1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-NAPTR:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                          |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                           |
      | Format                | Select: CSV                                                                                              |
    Then UI "Validate" Report With Name "DNS_NAPTR1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-NAPTR:[IPv4]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                          |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                           |
      | Format                | Select: CSV                                                                                              |
    Then UI Delete Report With Name "DNS_NAPTR1"

  @SID_19
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
    Then UI Delete Report With Name "DNS_NAPTR2"

  @SID_20
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

  @SID_21
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

  @SID_22
  Scenario: create new DNS-PTR1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_PTR1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-PTR:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                       |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
      | Format                | Select: CSV                                                                                           |
    Then UI "Validate" Report With Name "DNS_PTR1"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{DNS-PTR:[IPv6]}] ,devices:[{deviceIndex:11, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                       |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                        |
      | Format                | Select: CSV                                                                                           |
    Then UI Delete Report With Name "DNS_PTR1"

  @SID_23
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

  @SID_24
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

  @SID_25
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

    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_26
  Scenario: DNS-SOA 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_SOA 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv4]}], devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Format                | Select: CSV                                                                                                                 |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                          |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                              |
    Then UI "Validate" Report With Name "DNS_SOA 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv4]}], devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Format                | Select: CSV                                                                                                                 |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                          |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                              |
    Then UI Delete Report With Name "DNS_SOA 1"

  @SID_27
  Scenario: DNS-SOA 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_SOA 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv4]}],devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Format                | Select: CSV                                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                           |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                               |
    Then UI "Validate" Report With Name "DNS_SOA 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv4]}],devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Format                | Select: CSV                                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                           |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                               |
    Then UI Delete Report With Name "DNS_SOA 2"

  @SID_28
  Scenario:  DNS-SOA 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_SOA 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv6]}],devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Format                | Select: PDF                                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                                          |
      | Time Definitions.Date | Quick:3M                                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                             |
    Then UI "Validate" Report With Name "DNS_SOA 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv6]}],devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Format                | Select: PDF                                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                                          |
      | Time Definitions.Date | Quick:3M                                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                             |
    Then UI Delete Report With Name "DNS_SOA 3"

  @SID_29
  Scenario:  DNS-SOA 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_SOA 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv6]}],devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Format                | Select: HTML                                                                                                               |
      | Time Definitions.Date | Quick:This Month                                                                                                           |
    Then UI "Validate" Report With Name "DNS_SOA 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SOA:[IPv6]}],devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Format                | Select: HTML                                                                                                               |
      | Time Definitions.Date | Quick:This Month                                                                                                           |
    Then UI Delete Report With Name "DNS_SOA 4"

    # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_30
  Scenario: DNS-SRV 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_SRV 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SRV:[IPv6]}], devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Format                | Select: CSV                                                                                                                 |
      | Time Definitions.Date | Quick: 1H                                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                              |
    Then UI "Validate" Report With Name "DNS_SRV 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SRV:[IPv6]}], devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Format                | Select: CSV                                                                                                                 |
      | Time Definitions.Date | Quick: 1H                                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                              |
    Then UI Delete Report With Name "DNS_SRV 1"

  @SID_31
  Scenario: DNS-SRV 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_SRV 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SRV:[IPv6]}],devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Format                | Select: CSV                                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                                          |
      | Time Definitions.Date | Quick: 15m                                                                                                                 |
    Then UI "Validate" Report With Name "DNS_SRV 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SRV:[IPv6]}],devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Format                | Select: CSV                                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                                          |
      | Time Definitions.Date | Quick: 15m                                                                                                                 |
    Then UI Delete Report With Name "DNS_SRV 2"

  @SID_32
  Scenario:  DNS-SRV 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_SRV 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SRV:[IPv4]}],devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Format                | Select: PDF                                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                                          |
      | Time Definitions.Date | Quick:This Week                                                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                             |
    Then UI "Validate" Report With Name "DNS_SRV 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SRV:[IPv4]}],devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Format                | Select: PDF                                                                                                                |
      | Logo                  | reportLogoPNG.png                                                                                                          |
      | Time Definitions.Date | Quick:This Week                                                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                             |
    Then UI Delete Report With Name "DNS_SRV 3"

  @SID_33
  Scenario:  DNS-SRV 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_SRV 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SRV:[IPv4]}],devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Format                | Select: HTML                                                                                                               |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                            |
    Then UI "Validate" Report With Name "DNS_SRV 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-SRV:[IPv4]}],devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Format                | Select: HTML                                                                                                               |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                            |
    Then UI Delete Report With Name "DNS_SRV 4"

        # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_34
  Scenario: DNS-SRV 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_Other 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-Other:[IPv4]}], devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Format                | Select: CSV                                                                                                                   |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                |
    Then UI "Validate" Report With Name "DNS_Other 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-Other:[IPv4]}], devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Format                | Select: CSV                                                                                                                   |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                |
    Then UI Delete Report With Name "DNS_Other 1"

  @SID_35
  Scenario: DNS-Other 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_Other 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-Other:[IPv4]}],devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Format                | Select: CSV                                                                                                                  |
      | Logo                  | reportLogoPNG.png                                                                                                            |
      | Time Definitions.Date | Quick: 15m                                                                                                                   |
    Then UI "Validate" Report With Name "DNS_Other 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-Other:[IPv4]}],devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Format                | Select: CSV                                                                                                                  |
      | Logo                  | reportLogoPNG.png                                                                                                            |
      | Time Definitions.Date | Quick: 15m                                                                                                                   |
    Then UI Delete Report With Name "DNS_Other 2"

  @SID_36
  Scenario:  DNS-Other 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_Other 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-Other:[IPv6]}],devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Format                | Select: PDF                                                                                                                  |
      | Logo                  | reportLogoPNG.png                                                                                                            |
      | Time Definitions.Date | Quick:This Week                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                               |
    Then UI "Validate" Report With Name "DNS_Other 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-Other:[IPv6]}],devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Format                | Select: PDF                                                                                                                  |
      | Logo                  | reportLogoPNG.png                                                                                                            |
      | Time Definitions.Date | Quick:This Week                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                               |
    Then UI Delete Report With Name "DNS_Other 3"

  @SID_37
  Scenario:  DNS-Other 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "DNS_Other 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-Other:[IPv6]}],devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Format                | Select: HTML                                                                                                                 |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                              |
    Then UI "Validate" Report With Name "DNS_Other 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{DNS-Other:[IPv6]}],devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Format                | Select: HTML                                                                                                                 |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                              |
    Then UI Delete Report With Name "DNS_Other 4"

        # ------------------------------------------------------------------------------------------------------------------------------------------------------------

  @SID_38
  Scenario: Excluded UDP Traffic 1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Excluded UDP Traffic 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv4, bps, inbound]}], devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Format                | Select: CSV                                                                                                                                            |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                                                     |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                         |
    Then UI "Validate" Report With Name "Excluded UDP Traffic 1"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv4, bps, inbound]}], devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Format                | Select: CSV                                                                                                                                            |
      | Time Definitions.Date | Relative:[Weeks,3]                                                                                                                                     |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                         |
    Then UI Delete Report With Name "Excluded UDP Traffic 1"

  @SID_39
  Scenario: Excluded UDP Traffic 2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Excluded UDP Traffic 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv4, pps, Outbound]}],devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Format                | Select: CSV                                                                                                                                            |
      | Logo                  | reportLogoPNG.png                                                                                                                                      |
      | Time Definitions.Date | Quick:Previous Month                                                                                                                                   |
    Then UI "Validate" Report With Name "Excluded UDP Traffic 2"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv4, pps, Outbound]}],devices:[{deviceIndex:11, devicePolicies:[BDOS]}] |
      | Format                | Select: CSV                                                                                                                                            |
      | Logo                  | reportLogoPNG.png                                                                                                                                      |
      | Time Definitions.Date | Quick:Previous Month                                                                                                                                   |
    Then UI Delete Report With Name "Excluded UDP Traffic 2"

  @SID_40
    Scenario:  Excluded UDP Traffic 3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Excluded UDP Traffic 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv6, bps, Outbound]}],devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Format                | Select: PDF                                                                                                                                            |
      | Logo                  | reportLogoPNG.png                                                                                                                                      |
      | Time Definitions.Date | Quick:This Month                                                                                                                                       |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                         |
    Then UI "Validate" Report With Name "Excluded UDP Traffic 3"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv6, bps, Outbound]}],devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Format                | Select: PDF                                                                                                                                            |
      | Logo                  | reportLogoPNG.png                                                                                                                                      |
      | Time Definitions.Date | Quick:This Month                                                                                                                                       |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                         |
    Then UI Delete Report With Name "Excluded UDP Traffic 3"

  @SID_41
  Scenario:  Excluded UDP Traffic 4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Excluded UDP Traffic 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv4, pps, inbound]}],devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Format                | Select: HTML                                                                                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                       |
    Then UI "Validate" Report With Name "Excluded UDP Traffic 4"
      | Template              | reportType:DefensePro Behavioral Protections, Widgets:[{Excluded UDP Traffic:[IPv4, pps, inbound]}],devices:[{deviceIndex:10, devicePolicies:[BDOS]}] |
      | Format                | Select: HTML                                                                                                                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                       |
    Then UI Delete Report With Name "Excluded UDP Traffic 4"



  @SID_42
    Scenario: Logout
    Then UI logout and close browser