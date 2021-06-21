@TC121808
Feature: LinkProof_Reports

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    And UI Navigate to "ADC Reports" page via homePage
    Then UI Click Button "New Report Tab"


  @SID_2
  Scenario: create new CEC1
    Given UI "Create" Report With Name "CEC1"

      | Template              | reportType:LinkProof ,Widgets:[CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                  |
      | Format                | Select: PDF                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                    |
      | Time Definitions.Date | Quick:Today                                                                        |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody               |
    Then UI "Validate" Report With Name "CEC1"
      | Template              | reportType:LinkProof ,Widgets:[CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                  |
      | Format                | Select: PDF                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                    |
      | Time Definitions.Date | Quick:Today                                                                        |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody               |
    Then UI Delete Report With Name "CEC1"


  @SID_3
  Scenario: create new CEC2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC2"
      | Template              | reportType:LinkProof ,Widgets:[CEC] , devices:[LP_simulator_101] ,WANLinks:[w1] |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                    |
      | Time Definitions.Date | Quick:Yesterday                                                                 |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody            |
      | Format                | Select: HTML                                                                    |
    Then UI "Validate" Report With Name "CEC2"
      | Template              | reportType:LinkProof ,Widgets:[CEC] , devices:[LP_simulator_101] ,WANLinks:[w1] |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                    |
      | Time Definitions.Date | Quick:Yesterday                                                                 |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody            |
      | Format                | Select: HTML                                                                    |
    Then UI Delete Report With Name "CEC2"

  @SID_4
  Scenario: create new CEC3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC3"
      | Template              | reportType:LinkProof ,Widgets:[CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,Ahlam_WAN] |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                          |
      | Format                | Select: CSV                                                                               |
    Then UI "Validate" Report With Name "CEC3"
      | Template              | reportType:LinkProof ,Widgets:[CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,Ahlam_WAN] |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                          |
      | Format                | Select: CSV                                                                               |
    Then UI Delete Report With Name "CEC3"

  @SID_5
  Scenario: create new CEC4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC4"
      | Template              | reportType:LinkProof ,Widgets:[CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,Ahlam_WAN] |
      | Time Definitions.Date | Relative:[Days,3]                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                               |
      | Format                | Select: HTML                                                                              |
    Then UI "Validate" Report With Name "CEC4"
      | Template              | reportType:LinkProof ,Widgets:[CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,Ahlam_WAN] |
      | Time Definitions.Date | Relative:[Days,3]                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                               |
      | Format                | Select: HTML                                                                              |
    Then UI Delete Report With Name "CEC4"

  @SID_6
  Scenario: create new CEC5
    Then UI Click Button "CEC5"
    Given UI "Create" Report With Name "CEC5"
      | Template              | reportType:LinkProof ,Widgets:[CEC] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Time Definitions.Date | Quick:1D                                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                                |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                       |
      | Format                | Select: HTML                                                                                                               |
    Then UI "Validate" Report With Name "CEC5"
      | Template              | reportType:LinkProof ,Widgets:[CEC] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Time Definitions.Date | Quick:1D                                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                                |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                       |
      | Format                | Select: HTML                                                                                                               |
    Then UI Delete Report With Name "CEC5"


  @SID_7
  Scenario: create new CEC6
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC6"
      | Template              | reportType:LinkProof ,Widgets:[CEC] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                           |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                               |
      | Format                | Select: CSV                                                                                                                |
    Then UI "Validate" Report With Name "CEC6"
      | Template              | reportType:LinkProof ,Widgets:[CEC] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                           |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                               |
      | Format                | Select: CSV                                                                                                                |
    Then UI Delete Report With Name "CEC6"

  @SID_8
  Scenario: create new Download throughput bps1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download throughput bps1"
      | Template              | reportType:LinkProof ,Widgets:[{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Quick:1D                                                                                                   |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                               |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: CSV                                                                                                |
    Then UI "Validate" Report With Name "Download throughput bps1"
      | Template              | reportType:LinkProof ,Widgets:[{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Quick:1D                                                                                                   |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                               |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: CSV                                                                                                |
    Then UI Delete Report With Name "Download throughput bps1"

  @SID_9
  Scenario: create new Download throughput bps2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                   |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                |
      | Format                | Select: PDF                                                                                                |
    Then UI "Validate" Report With Name "Download throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                   |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                |
      | Format                | Select: PDF                                                                                                |
    Then UI Delete Report With Name "Download throughput bps2"


  @SID_10
  Scenario: create new Download throughput bps3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download throughput bps3"
      | Template              | reportType:LinkProof ,Widgets:[{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                            |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: HTML                                                                                               |
    Then UI "Validate" Report With Name "Download throughput bps3"
      | Template              | reportType:LinkProof ,Widgets:[{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                            |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: HTML                                                                                               |
    Then UI Delete Report With Name "Download throughput bps3"

  @SID_11
  Scenario: create new Download throughput bps4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download throughput bps4"
      | Template              | reportType:LinkProof ,Widgets:[{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                  |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                                                   |
      | Format                | Select: CSV                                                                                                                                        |
    Then UI "Validate" Report With Name "Download throughput bps4"
      | Template              | reportType:LinkProof ,Widgets:[{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                  |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                                                   |
      | Format                | Select: CSV                                                                                                                                        |
    Then UI Delete Report With Name "Download throughput bps4"

  @SID_12
  Scenario: create new Download throughput Usage1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                            |
      | Time Definitions.Date | Quick:1D                                                                                                     |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                 |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                         |
      | Format                | Select: CSV                                                                                                  |
    Then UI "Validate" Report With Name "Download throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                            |
      | Time Definitions.Date | Quick:1D                                                                                                     |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                 |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                         |
      | Format                | Select: CSV                                                                                                  |
    Then UI Delete Report With Name "Download throughput Usage1"

  @SID_13
  Scenario: create new Download throughput Usage2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                     |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                  |
      | Format                | Select: PDF                                                                                                  |
    Then UI "Validate" Report With Name "Download throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                     |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                  |
      | Format                | Select: PDF                                                                                                  |
    Then UI Delete Report With Name "Download throughput Usage2"


  @SID_14
  Scenario: create new Download throughput Usage3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download throughput Usage3"
      | Template              | reportType:LinkProof ,Widgets:[{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                            |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                         |
      | Format                | Select: HTML                                                                                                 |
    Then UI "Validate" Report With Name "Download throughput Usage3"
      | Template              | reportType:LinkProof ,Widgets:[{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                            |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                         |
      | Format                | Select: HTML                                                                                                 |
    Then UI Delete Report With Name "Download throughput Usage3"

  @SID_15
  Scenario: create new Download throughput Usage4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download throughput Usage4"
      | Template              | reportType:LinkProof ,Widgets:[{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                    |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                                                  |
      | Format                | Select: CSV                                                                                                                                          |
    Then UI "Validate" Report With Name "Download throughput Usage4"
      | Template              | reportType:LinkProof ,Widgets:[{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                    |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                                                  |
      | Format                | Select: CSV                                                                                                                                          |
    Then UI Delete Report With Name "Download throughput Usage4"

  @SID_16
  Scenario: create new Upload throughput bps1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Upload throughput bps1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Time Definitions.Date | Quick:1D                                                                                                 |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                             |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                     |
      | Format                | Select: CSV                                                                                              |
    Then UI "Validate" Report With Name "Upload throughput bps1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Time Definitions.Date | Quick:1D                                                                                                 |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                             |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                     |
      | Format                | Select: CSV                                                                                              |
    Then UI Delete Report With Name "Upload throughput bps1"

  @SID_17
  Scenario: create new Upload throughput bps2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Upload throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                              |
      | Format                | Select: PDF                                                                                              |
    Then UI "Validate" Report With Name "Upload throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                              |
      | Format                | Select: PDF                                                                                              |
    Then UI Delete Report With Name "Upload throughput bps2"


  @SID_18
  Scenario: create new Upload throughput bps3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Upload throughput bps3"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                       |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                          |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                     |
      | Format                | Select: HTML                                                                                             |
    Then UI "Validate" Report With Name "Upload throughput bps3"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                       |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                          |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                     |
      | Format                | Select: HTML                                                                                             |
    Then UI Delete Report With Name "Upload throughput bps3"

  @SID_19
  Scenario: create new Upload throughput bps4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Upload throughput bps4"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                                                 |
      | Format                | Select: CSV                                                                                                                                      |
    Then UI "Validate" Report With Name "Upload throughput bps4"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                                                 |
      | Format                | Select: CSV                                                                                                                                      |
    Then UI Delete Report With Name "Upload throughput bps3"

  @SID_20
  Scenario: create new Upload throughput Usage1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Upload throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Quick:1D                                                                                                   |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                               |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: CSV                                                                                                |
    Then UI "Validate" Report With Name "Upload throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Quick:1D                                                                                                   |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                               |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: CSV                                                                                                |
    Then UI Delete Report With Name "Upload throughput Usage1"

  @SID_21
  Scenario: create new Upload throughput Usage2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Upload throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                   |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                |
      | Format                | Select: PDF                                                                                                |
    Then UI "Validate" Report With Name "Upload throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                   |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                |
      | Format                | Select: PDF                                                                                                |
    Then UI Delete Report With Name "Upload throughput Usage2"


  @SID_22
  Scenario: create new Upload throughput Usage3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Upload throughput Usage3"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                            |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: HTML                                                                                               |
    Then UI "Validate" Report With Name "Upload throughput Usage3"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                            |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: HTML                                                                                               |
    Then UI Delete Report With Name "Upload throughput Usage3"

  @SID_23
  Scenario: create new Upload throughput Usage4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Upload throughput Usage4"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                  |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                                                |
      | Format                | Select: CSV                                                                                                                                        |
    Then UI "Validate" Report With Name "Upload throughput Usage4"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                  |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                                                |
      | Format                | Select: CSV                                                                                                                                        |
    Then UI Delete Report With Name "Upload throughput Usage4"

  @SID_24
  Scenario: create new CEC Download throughput bps
    Given UI "Create" Report With Name "CEC Download throughput bps"
      | Template              | reportType:LinkProof ,  Widgets:[{Download throughput:[bps]},CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                |
      | Format                | Select: PDF                                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                  |
      | Time Definitions.Date | Quick:Today                                                                                                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                             |
    Then UI "Validate" Report With Name "CEC Download throughput bps"
      | Template              | reportType:LinkProof ,Widgets:[CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                  |
      | Format                | Select: PDF                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                    |
      | Time Definitions.Date | Quick:Today                                                                        |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody               |
    Then UI Delete Report With Name "CEC Download throughput bps"


  @SID_25
  Scenario: create new CEC Download throughput Usage
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC Download throughput Usage"
      | Template              | reportType:LinkProof ,Widgets:[{Download throughput:[Usage]},CEC] , devices:[LP_simulator_101] ,WANLinks:[w1] |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                  |
      | Time Definitions.Date | Quick:Yesterday                                                                                               |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                          |
      | Format                | Select: HTML                                                                                                  |
    Then UI "Validate" Report With Name "CEC Download throughput Usage"
      | Template              | reportType:LinkProof ,Widgets:[{Download throughput:[Usage]},CEC] , devices:[LP_simulator_101] ,WANLinks:[w1] |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                  |
      | Time Definitions.Date | Quick:Yesterday                                                                                               |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                          |
      | Format                | Select: HTML                                                                                                  |
    Then UI Delete Report With Name "CEC Download throughput Usage"

  @SID_26
  Scenario: create new CEC Upload throughput bps
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC Upload throughput bps"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[bps]},CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,Ahlam_WAN] |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                    |
      | Format                | Select: CSV                                                                                                         |
    Then UI "Validate" Report With Name "CEC Upload throughput bpa"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[bps]},CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,Ahlam_WAN] |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                    |
      | Format                | Select: CSV                                                                                                         |
    Then UI Delete Report With Name "CEC Upload throughput bpa"

  @SID_27
  Scenario: create new CEC Upload throughput Usage
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC Upload throughput Usage"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[Usage]},CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,Ahlam_WAN] |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                           |
      | Format                | Select: HTML                                                                                                          |
    Then UI "Validate" Report With Name "CEC Upload throughput Usage"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[Usage]},CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,Ahlam_WAN] |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                           |
      | Format                | Select: HTML                                                                                                          |
    Then UI Delete Report With Name "CEC Upload throughput Usage"

  @SID_28
  Scenario: create new Download throughput Usage Upload throughput Usage1
    Then UI Click Button "CEC5"
    Given UI "Create" Report With Name "Download throughput Usage Upload throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[Usage]},{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Time Definitions.Date | Quick:1D                                                                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                                                                                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                                                             |
      | Format                | Select: HTML                                                                                                                                                                     |
    Then UI "Validate" Report With Name "Download throughput Usage Upload throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[Usage]},{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Time Definitions.Date | Quick:1D                                                                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                                                                                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                                                             |
      | Format                | Select: HTML                                                                                                                                                                     |
    Then UI Delete Report With Name "Download throughput Usage Upload throughput Usage1"


  @SID_29
  Scenario: create new Download throughput Usage Upload throughput Usage2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download throughput Usage Upload throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[Usage]},{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                                                     |
      | Format                | Select: CSV                                                                                                                                                                      |
    Then UI "Validate" Report With Name "Download throughput Usage Upload throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[Usage]},{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                                                     |
      | Format                | Select: CSV                                                                                                                                                                      |
    Then UI Delete Report With Name "Download throughput Usage Upload throughput Usage2"

  @SID_30
  Scenario: create new Download throughput Usage Upload throughput bps1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download throughput bps Upload throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[bps]},{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                      |
      | Time Definitions.Date | Quick:1D                                                                                                                               |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                                           |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                   |
      | Format                | Select: CSV                                                                                                                            |
    Then UI "Validate" Report With Name "Download throughput bps Upload throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[bps]},{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                      |
      | Time Definitions.Date | Quick:1D                                                                                                                               |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                                           |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                   |
      | Format                | Select: CSV                                                                                                                            |
    Then UI Delete Report With Name "Download throughput Usage Upload throughput bps1"

  @SID_31
  Scenario: create new Download throughput Usage Upload throughput bps2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download throughput Usage Upload throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[bps]},{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                                               |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                            |
      | Format                | Select: PDF                                                                                                                            |
    Then UI "Validate" Report With Name "Download throughput Usage Upload throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[bps]},{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                                               |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                            |
      | Format                | Select: PDF                                                                                                                            |
    Then UI Delete Report With Name "Download throughput Usage Upload throughput bps2"


  @SID_32
  Scenario: create new Download throughput bps Upload throughput Usage1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download throughput bps Upload throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[Usage]},{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                      |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                        |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                   |
      | Format                | Select: HTML                                                                                                                           |
    Then UI "Validate" Report With Name "Download throughput bps Upload throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[Usage]},{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                      |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                        |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                   |
      | Format                | Select: HTML                                                                                                                           |
    Then UI Delete Report With Name "Download throughput bps Upload throughput Usage1"

  @SID_33
  Scenario: create new Download throughput bps Upload throughput Usage2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download throughput bps Upload throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[Usage]},{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                                              |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                                                                               |
      | Format                | Select: CSV                                                                                                                                                                    |
    Then UI "Validate" Report With Name "Download throughput bps Upload throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[Usage]},{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                                              |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                                                                               |
      | Format                | Select: CSV                                                                                                                                                                    |
    Then UI Delete Report With Name "Download throughput bps Upload throughput Usage2"

  @SID_34
  Scenario: create new Download throughput bps Upload throughput bps1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download throughput bps Upload throughput bps1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[bps]},{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                    |
      | Time Definitions.Date | Quick:1D                                                                                                                             |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                 |
      | Format                | Select: CSV                                                                                                                          |
    Then UI "Validate" Report With Name "Download throughput bps Upload throughput bps1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[bps]},{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                    |
      | Time Definitions.Date | Quick:1D                                                                                                                             |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                 |
      | Format                | Select: CSV                                                                                                                          |
    Then UI Delete Report With Name "Download throughput bps Upload throughput bps1"

  @SID_35
  Scenario: create new Download throughput bps Upload throughput bps2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download throughput bps Upload throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[bps]},{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                                             |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                          |
      | Format                | Select: PDF                                                                                                                          |
    Then UI "Validate" Report With Name "Download throughput bps Upload throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload throughput:[bps]},{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                                             |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                          |
      | Format                | Select: PDF                                                                                                                          |
    Then UI Delete Report With Name "Download throughput bps Upload throughput bps2"


  @SID_36
  Scenario: create new CEC Download throughput Usage Upload throughput Usage1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC Download throughput Usage Upload throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[CEC,{Upload throughput:[Usage]},{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                            |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                         |
      | Format                | Select: HTML                                                                                                                                 |
    Then UI "Validate" Report With Name "CEC Download throughput Usage Upload throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[CEC,{Upload throughput:[Usage]},{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                            |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                         |
      | Format                | Select: HTML                                                                                                                                 |
    Then UI Delete Report With Name "CEC Download throughput Usage Upload throughput Usage1"

  @SID_37
  Scenario: create new CEC Download throughput Usage Upload throughput Usage2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC Download throughput Usage Upload throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[CEC,{Upload throughput:[Usage]},{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                    |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                                                                                  |
      | Format                | Select: CSV                                                                                                                                                                          |
    Then UI "Validate" Report With Name "CEC Download throughput Usage Upload throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[CEC,{Upload throughput:[Usage]},{Download throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                    |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                                                                                  |
      | Format                | Select: CSV                                                                                                                                                                          |
    Then UI Delete Report With Name "CEC Download throughput Usage Upload throughput Usage2"

  @SID_38
  Scenario: create new CEC Download throughput bps Upload throughput bps1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC Download throughput bps Upload throughput bps1"
      | Template              | reportType:LinkProof ,Widgets:[CEC,{Upload throughput:[bps]},{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                        |
      | Time Definitions.Date | Quick:1D                                                                                                                                 |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                                             |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                     |
      | Format                | Select: CSV                                                                                                                              |
    Then UI "Validate" Report With Name "CEC Download throughput bps Upload throughput bps1"
      | Template              | reportType:LinkProof ,Widgets:[CEC,{Upload throughput:[bps]},{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                        |
      | Time Definitions.Date | Quick:1D                                                                                                                                 |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                                             |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                     |
      | Format                | Select: CSV                                                                                                                              |
    Then UI Delete Report With Name "CEC Download throughput bps Upload throughput bps1"

  @SID_39
  Scenario: create CEC Download throughput bps Upload throughput bps2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC Download throughput bps Upload throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[CEC,{Upload throughput:[bps]},{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                              |
      | Format                | Select: PDF                                                                                                                              |
    Then UI "Validate" Report With Name "CEC Download throughput bps Upload throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[CEC,{Upload throughput:[bps]},{Download throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                              |
      | Format                | Select: PDF                                                                                                                              |
    Then UI Delete Report With Name "CEC Download throughput bps Upload throughput bps2"


  @SID_40 @Sanity
  Scenario: Logout
    Then UI logout and close browser