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
      | Time Definitions.Date | Quick:15m                                                                          |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody               |
    Then UI "Validate" Report With Name "CEC1"
      | Template              | reportType:LinkProof ,Widgets:[CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                  |
      | Format                | Select: PDF                                                                        |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                    |
      | Time Definitions.Date | Quick:15m                                                                          |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody               |
    Then UI Delete Report With Name "CEC1"


  @SID_3
  Scenario: create new CEC2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC2"
      | Template              | reportType:LinkProof ,Widgets:[CEC] , devices:[LP_simulator_101] ,WANLinks:[w1] |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                    |
      | Time Definitions.Date | Quick:1M                                                                        |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody            |
      | Format                | Select: HTML                                                                    |
    Then UI "Validate" Report With Name "CEC2"
      | Template              | reportType:LinkProof ,Widgets:[CEC] , devices:[LP_simulator_101] ,WANLinks:[w1] |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                    |
      | Time Definitions.Date | Quick:1M                                                                        |
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
    Then UI Click Button "New Report Tab"
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
  Scenario: create new Download Throughput bps1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download Throughput bps1"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Quick:1D                                                                                                   |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                               |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: CSV                                                                                                |
    Then UI "Validate" Report With Name "Download Throughput bps1"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Quick:1D                                                                                                   |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                               |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: CSV                                                                                                |
    Then UI Delete Report With Name "Download Throughput bps1"

  @SID_9
  Scenario: create new Download Throughput bps2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download Throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                   |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                |
      | Format                | Select: PDF                                                                                                |
    Then UI "Validate" Report With Name "Download Throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                   |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                |
      | Format                | Select: PDF                                                                                                |
    Then UI Delete Report With Name "Download Throughput bps2"


  @SID_10
  Scenario: create new Download Throughput bps3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download Throughput bps3"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                            |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: HTML                                                                                               |
    Then UI "Validate" Report With Name "Download Throughput bps3"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                            |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: HTML                                                                                               |
    Then UI Delete Report With Name "Download Throughput bps3"

  @SID_11
  Scenario: create new Download Throughput bps4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download Throughput bps4"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                  |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                                                   |
      | Format                | Select: CSV                                                                                                                                        |
    Then UI "Validate" Report With Name "Download Throughput bps4"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                  |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                                                   |
      | Format                | Select: CSV                                                                                                                                        |
    Then UI Delete Report With Name "Download Throughput bps4"

  @SID_12
  Scenario: create new Download Throughput Usage1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download Throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                            |
      | Time Definitions.Date | Quick:1D                                                                                                     |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                 |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                         |
      | Format                | Select: CSV                                                                                                  |
    Then UI "Validate" Report With Name "Download Throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                            |
      | Time Definitions.Date | Quick:1D                                                                                                     |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                 |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                         |
      | Format                | Select: CSV                                                                                                  |
    Then UI Delete Report With Name "Download Throughput Usage1"

  @SID_13
  Scenario: create new Download Throughput Usage2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download Throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                     |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                  |
      | Format                | Select: PDF                                                                                                  |
    Then UI "Validate" Report With Name "Download Throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                     |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                  |
      | Format                | Select: PDF                                                                                                  |
    Then UI Delete Report With Name "Download Throughput Usage2"


  @SID_14
  Scenario: create new Download Throughput Usage3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download Throughput Usage3"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                            |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                         |
      | Format                | Select: HTML                                                                                                 |
    Then UI "Validate" Report With Name "Download Throughput Usage3"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                            |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                         |
      | Format                | Select: HTML                                                                                                 |
    Then UI Delete Report With Name "Download Throughput Usage3"

  @SID_15
  Scenario: create new Download Throughput Usage4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download Throughput Usage4"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                    |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                                                  |
      | Format                | Select: CSV                                                                                                                                          |
    Then UI "Validate" Report With Name "Download Throughput Usage4"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                    |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                                                  |
      | Format                | Select: CSV                                                                                                                                          |
    Then UI Delete Report With Name "Download Throughput Usage4"

  @SID_16
  Scenario: create new Upload Throughput bps1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Upload Throughput bps1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Time Definitions.Date | Quick:1D                                                                                                 |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                             |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                     |
      | Format                | Select: CSV                                                                                              |
    Then UI "Validate" Report With Name "Upload Throughput bps1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Time Definitions.Date | Quick:1D                                                                                                 |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                             |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                     |
      | Format                | Select: CSV                                                                                              |
    Then UI Delete Report With Name "Upload Throughput bps1"

  @SID_17
  Scenario: create new Upload Throughput bps2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Upload Throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                              |
      | Format                | Select: PDF                                                                                              |
    Then UI "Validate" Report With Name "Upload Throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                              |
      | Format                | Select: PDF                                                                                              |
    Then UI Delete Report With Name "Upload Throughput bps2"

  @SID_18
  Scenario: create new Upload Throughput bps3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Upload Throughput bps3"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                       |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                          |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                     |
      | Format                | Select: HTML                                                                                             |
    Then UI "Validate" Report With Name "Upload Throughput bps3"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                        |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                       |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                          |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                     |
      | Format                | Select: HTML                                                                                             |
    Then UI Delete Report With Name "Upload Throughput bps3"

  @SID_19
  Scenario: create new Upload Throughput bps4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Upload Throughput bps4"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                                                 |
      | Format                | Select: CSV                                                                                                                                      |
    Then UI "Validate" Report With Name "Upload Throughput bps4"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                                                 |
      | Format                | Select: CSV                                                                                                                                      |
    Then UI Delete Report With Name "Upload Throughput bps4"

  @SID_20
  Scenario: create new Upload Throughput Usage1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Upload Throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Quick:1D                                                                                                   |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                               |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: CSV                                                                                                |
    Then UI "Validate" Report With Name "Upload Throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Quick:1D                                                                                                   |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                               |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: CSV                                                                                                |
    Then UI Delete Report With Name "Upload Throughput Usage1"

  @SID_21
  Scenario: create new Upload Throughput Usage2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Upload Throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                   |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                |
      | Format                | Select: PDF                                                                                                |
    Then UI "Validate" Report With Name "Upload Throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                   |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                |
      | Format                | Select: PDF                                                                                                |
    Then UI Delete Report With Name "Upload Throughput Usage2"


  @SID_22
  Scenario: create new Upload Throughput Usage3
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Upload Throughput Usage3"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                            |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: HTML                                                                                               |
    Then UI "Validate" Report With Name "Upload Throughput Usage3"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                          |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                            |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                       |
      | Format                | Select: HTML                                                                                               |
    Then UI Delete Report With Name "Upload Throughput Usage3"

  @SID_23
  Scenario: create new Upload Throughput Usage4
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Upload Throughput Usage4"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                  |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                                                |
      | Format                | Select: CSV                                                                                                                                        |
    Then UI "Validate" Report With Name "Upload Throughput Usage4"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                  |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                                                |
      | Format                | Select: CSV                                                                                                                                        |
    Then UI Delete Report With Name "Upload Throughput Usage4"

  @SID_24
  Scenario: create new CEC Download Throughput bps
    Given UI "Create" Report With Name "CEC Download Throughput bps"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[bps]},CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                              |
      | Format                | Select: PDF                                                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                |
      | Time Definitions.Date | Quick:15m                                                                                                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                           |
    Then UI "Validate" Report With Name "CEC Download Throughput bps"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[bps]},CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                              |
      | Format                | Select: PDF                                                                                                    |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                |
      | Time Definitions.Date | Quick:15m                                                                                                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                           |
    Then UI Delete Report With Name "CEC Download Throughput bps"


  @SID_25
  Scenario: create new CEC Download Throughput Usage
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC Download Throughput Usage"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[Usage]},CEC] , devices:[LP_simulator_101] ,WANLinks:[w1] |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                  |
      | Time Definitions.Date | Quick:3M                                                                                                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                          |
      | Format                | Select: HTML                                                                                                  |
    Then UI "Validate" Report With Name "CEC Download Throughput Usage"
      | Template              | reportType:LinkProof ,Widgets:[{Download Throughput:[Usage]},CEC] , devices:[LP_simulator_101] ,WANLinks:[w1] |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                  |
      | Time Definitions.Date | Quick:3M                                                                                                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                          |
      | Format                | Select: HTML                                                                                                  |
    Then UI Delete Report With Name "CEC Download Throughput Usage"

  @SID_26
  Scenario: create new CEC Upload Throughput bps
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC Upload Throughput bps"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[bps]},CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,Ahlam_WAN] |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                    |
      | Format                | Select: CSV                                                                                                         |
    Then UI "Validate" Report With Name "CEC Upload Throughput bps"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[bps]},CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,Ahlam_WAN] |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                    |
      | Format                | Select: CSV                                                                                                         |
    Then UI Delete Report With Name "CEC Upload Throughput bpa"

  @SID_27
  Scenario: create new CEC Upload Throughput Usage
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC Upload Throughput Usage"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[Usage]},CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,Ahlam_WAN] |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                           |
      | Format                | Select: HTML                                                                                                          |
    Then UI "Validate" Report With Name "CEC Upload Throughput Usage"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[Usage]},CEC] , devices:[LP_simulator_101] ,WANLinks:[w1,Ahlam_WAN] |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                           |
      | Format                | Select: HTML                                                                                                          |
    Then UI Delete Report With Name "CEC Upload Throughput Usage"

  @SID_28
  Scenario: create new Download Throughput Usage Upload Throughput Usage1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download Throughput Usage Upload Throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[Usage]},{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Time Definitions.Date | Quick:1D                                                                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                                                                                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                                                             |
      | Format                | Select: HTML                                                                                                                                                                     |
    Then UI "Validate" Report With Name "Download Throughput Usage Upload Throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[Usage]},{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Time Definitions.Date | Quick:1D                                                                                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[FEB,MAR,JUL,AUG]                                                                                                                      |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                                                             |
      | Format                | Select: HTML                                                                                                                                                                     |
    Then UI Delete Report With Name "Download Throughput Usage Upload Throughput Usage1"


  @SID_29
  Scenario: create new Download Throughput Usage Upload Throughput Usage2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download Throughput Usage Upload Throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[Usage]},{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                                                     |
      | Format                | Select: CSV                                                                                                                                                                      |
    Then UI "Validate" Report With Name "Download Throughput Usage Upload Throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[Usage]},{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                                                     |
      | Format                | Select: CSV                                                                                                                                                                      |
    Then UI Delete Report With Name "Download Throughput Usage Upload Throughput Usage2"

  @SID_30
  Scenario: create new Download Throughput Usage Upload Throughput bps1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download Throughput bps Upload Throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[bps]},{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                      |
      | Time Definitions.Date | Quick:1D                                                                                                                               |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                                           |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                   |
      | Format                | Select: CSV                                                                                                                            |
    Then UI "Validate" Report With Name "Download Throughput bps Upload Throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[bps]},{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                      |
      | Time Definitions.Date | Quick:1D                                                                                                                               |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                                           |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                   |
      | Format                | Select: CSV                                                                                                                            |
    Then UI Delete Report With Name "Download Throughput Usage Upload Throughput bps1"

  @SID_31
  Scenario: create new Download Throughput Usage Upload Throughput bps2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download Throughput Usage Upload Throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[bps]},{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                                               |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                            |
      | Format                | Select: PDF                                                                                                                            |
    Then UI "Validate" Report With Name "Download Throughput Usage Upload Throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[bps]},{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                                               |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                            |
      | Format                | Select: PDF                                                                                                                            |
    Then UI Delete Report With Name "Download Throughput Usage Upload Throughput bps2"


  @SID_32
  Scenario: create new Download Throughput bps Upload Throughput Usage1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download Throughput bps Upload Throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[Usage]},{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                      |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                        |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                   |
      | Format                | Select: HTML                                                                                                                           |
    Then UI "Validate" Report With Name "Download Throughput bps Upload Throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[Usage]},{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                      |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                        |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                   |
      | Format                | Select: HTML                                                                                                                           |
    Then UI Delete Report With Name "Download Throughput bps Upload Throughput Usage1"

  @SID_33
  Scenario: create new Download Throughput bps Upload Throughput Usage2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download Throughput bps Upload Throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[Usage]},{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                                              |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                                                                               |
      | Format                | Select: CSV                                                                                                                                                                    |
    Then UI "Validate" Report With Name "Download Throughput bps Upload Throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[Usage]},{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                                              |
      | Time Definitions.Date | Absolute:[02.11.2020 13:47, +0d]                                                                                                                                               |
      | Format                | Select: CSV                                                                                                                                                                    |
    Then UI Delete Report With Name "Download Throughput bps Upload Throughput Usage2"

  @SID_34
  Scenario: create new Download Throughput bps Upload Throughput bps1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download Throughput bps Upload Throughput bps1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[bps]},{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                    |
      | Time Definitions.Date | Quick:1D                                                                                                                             |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                 |
      | Format                | Select: CSV                                                                                                                          |
    Then UI "Validate" Report With Name "Download Throughput bps Upload Throughput bps1"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[bps]},{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                    |
      | Time Definitions.Date | Quick:1D                                                                                                                             |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                                         |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                 |
      | Format                | Select: CSV                                                                                                                          |
    Then UI Delete Report With Name "Download Throughput bps Upload Throughput bps1"

  @SID_35
  Scenario: create new Download Throughput bps Upload Throughput bps2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "Download Throughput bps Upload Throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[bps]},{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                                             |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                          |
      | Format                | Select: PDF                                                                                                                          |
    Then UI "Validate" Report With Name "Download Throughput bps Upload Throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[{Upload Throughput:[bps]},{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                                             |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                          |
      | Format                | Select: PDF                                                                                                                          |
    Then UI Delete Report With Name "Download Throughput bps Upload Throughput bps2"


  @SID_36
  Scenario: create new CEC Download Throughput Usage Upload Throughput Usage1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC Download Throughput Usage Upload Throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[CEC,{Upload Throughput:[Usage]},{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                            |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                         |
      | Format                | Select: HTML                                                                                                                                 |
    Then UI "Validate" Report With Name "CEC Download Throughput Usage Upload Throughput Usage1"
      | Template              | reportType:LinkProof ,Widgets:[CEC,{Upload Throughput:[Usage]},{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                            |
      | Time Definitions.Date | Relative:[Hours,3]                                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                              |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                         |
      | Format                | Select: HTML                                                                                                                                 |
    Then UI Delete Report With Name "CEC Download Throughput Usage Upload Throughput Usage1"

  @SID_37
  Scenario: create new CEC Download Throughput Usage Upload Throughput Usage2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC Download Throughput Usage Upload Throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[CEC,{Upload Throughput:[Usage]},{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                    |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                                                                                  |
      | Format                | Select: CSV                                                                                                                                                                          |
    Then UI "Validate" Report With Name "CEC Download Throughput Usage Upload Throughput Usage2"
      | Template              | reportType:LinkProof ,Widgets:[CEC,{Upload Throughput:[Usage]},{Download Throughput:[Usage]}] , devices:[LP_simulator_101] ,WANLinks:[Giora123,mansour_1,w1,w2,Radware1,EdiWanLinks] |
      | Logo                  | reportLogoPNG.png                                                                                                                                                                    |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                                                                                  |
      | Format                | Select: CSV                                                                                                                                                                          |
    Then UI Delete Report With Name "CEC Download Throughput Usage Upload Throughput Usage2"

  @SID_38
  Scenario: create new CEC Download Throughput bps Upload Throughput bps1
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC Download Throughput bps Upload Throughput bps1"
      | Template              | reportType:LinkProof ,Widgets:[CEC,{Upload Throughput:[bps]},{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                        |
      | Time Definitions.Date | Quick:1D                                                                                                                                 |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                                             |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                     |
      | Format                | Select: CSV                                                                                                                              |
    Then UI "Validate" Report With Name "CEC Download Throughput bps Upload Throughput bps1"
      | Template              | reportType:LinkProof ,Widgets:[CEC,{Upload Throughput:[bps]},{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Logo                  | reportLogoPNG.png                                                                                                                        |
      | Time Definitions.Date | Quick:1D                                                                                                                                 |
      | Schedule              | Run Every:Daily ,On Time:+2m                                                                                                             |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody                                                                     |
      | Format                | Select: CSV                                                                                                                              |
    Then UI Delete Report With Name "CEC Download Throughput bps Upload Throughput bps1"

  @SID_39
  Scenario: create CEC Download Throughput bps Upload Throughput bps2
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "CEC Download Throughput bps Upload Throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[CEC,{Upload Throughput:[bps]},{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                              |
      | Format                | Select: PDF                                                                                                                              |
    Then UI "Validate" Report With Name "CEC Download Throughput bps Upload Throughput bps2"
      | Template              | reportType:LinkProof ,Widgets:[CEC,{Upload Throughput:[bps]},{Download Throughput:[bps]}] , devices:[LP_simulator_101] ,WANLinks:[w1,w2] |
      | Time Definitions.Date | Quick:1W                                                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                              |
      | Format                | Select: PDF                                                                                                                              |
    Then UI Delete Report With Name "CEC Download Throughput bps Upload Throughput bps2"


  @SID_40 @Sanity
  Scenario: Logout
    Then UI logout and close browser