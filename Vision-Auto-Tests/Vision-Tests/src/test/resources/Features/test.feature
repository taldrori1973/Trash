


Feature: ADC-


@SID_1
Scenario: Navigate to NEW REPORTS page
#    * REST Delete ES index "forensics-*"
Then UI Login with user "radware" and password "radware"
#    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
#    * REST Vision Install License Request "vision-AVA-AppWall"
#    * REST Vision Install License Request "vision-reporting-module-AMS"
Then UI Navigate to "AMS Forensics" page via homepage

@SID_40
Scenario: create new Output Attack ID Equals
Given UI "Create" Forensics With Name "Output Attack ID Equals"
| Product               | DefensePro                                                                     |
| Output                | Attack ID                                                                      |
| Criteria              | Event Criteria:Action,Operator:Equals,Value:Challenge                          |
| devices               | All                                                                            |
| Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
| Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
| Format                | Select: CSV                                                                    |

