@TC119591
Feature:Create DefensePro Part2

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    * REST Delete ES index "forensics-*"
    Then UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Vision Install License Request "vision-AVA-AppWall"
    * REST Vision Install License Request "vision-reporting-module-AMS"
    Then UI Navigate to "AMS Forensics" page via homepage

  @SID_2
  Scenario: create new Output Total Mbits Dropped Action Not Equals
    Given UI "Create" Forensics With Name "Output Total Mbits Dropped Action Not Equals"
      | Product               | DefensePro                                                                     |
      | Output                | Total Mbits Dropped                                                            |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:HTTP 403 Forbidden             |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI "Validate" Forensics With Name "Output Total Mbits Dropped Action Not Equals"
      | Product               | DefensePro                                                                     |
      | Output                | Total Mbits Dropped                                                            |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:HTTP 403 Forbidden             |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Total Mbits Dropped Action Not Equals"

  @SID_3
  Scenario: create new Output Max bps Action Not Equals
    Given UI "Create" Forensics With Name "Output Max bps Action Not Equals"
      | Product               | DefensePro                                                                                                       |
      | Output                | Max bps                                                                                                          |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:HTTP 403 Forbidden and Reset Destination                                    |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI "Validate" Forensics With Name "Output Max bps Action Not Equals"
      | Product               | DefensePro                                                                                                       |
      | Output                | Max bps                                                                                                          |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:HTTP 403 Forbidden and Reset Destination                         |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Max bps Action Not Equals"

  @SID_4
  Scenario: create new Output Physical Port Action Not Equals
    Given UI "Create" Forensics With Name "Output Physical Port Action Not Equals"
      | Product               | DefensePro                                                                                                                                       |
      | Output                | Physical Port                                                                                                                                    |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:[Modified,Source Reset,Source and Destination Reset,HTTP 200 OK,HTTP 403 Forbidden and Reset Destination]   |
      | devices               | index:10                                                                                                                                         |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                                               |
      | Schedule              | Run Every:once, On Time:+6H                                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                   |
      | Format                | Select: HTML                                                                                                                                     |
    Then UI "Validate" Forensics With Name "Output Physical Port Action Not Equals"
      | Product               | DefensePro                                                                                                                                       |
      | Output                | Physical Port                                                                                                                                    |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:[Modified,Source Reset,Source and Destination Reset,HTTP 200 OK,HTTP 403 Forbidden and Reset Destination]   |
      | devices               | index:10                                                                                                                                         |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                                               |
      | Schedule              | Run Every:once, On Time:+6H                                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                   |
      | Format                | Select: HTML                                                                                                                                     |
    Then UI Delete Forensics With Name "Output Physical Port Action Not Equals"

  @SID_5
  Scenario: create new Output Risk Action Not Equals
    Given UI "Create" Forensics With Name "Output Risk Action Not Equals"
      | Product               | DefensePro                                                                                                                                                                                                                               |
      | Output                | Risk                                                                                                                                                                                                                                     |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:[Modified,Forward,Drop,Source Reset,Destination Reset,Source and Destination Reset,Bypass,Challenge,HTTP 200 OK,HTTP 200 OK and Reset Destination,HTTP 403 Forbidden,HTTP 403 Forbidden and Reset Destination] |
      | devices               | All                                                                                                                                                                                                                                      |
      | Time Definitions.Date | Quick:1M                                                                                                                                                                                                                                 |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                         |
      | Format                | Select: CSV                                                                                                                                                                                                                              |
    Then UI "Validate" Forensics With Name "Output Risk Action Not Equals"
      | Product               | DefensePro                                                                                                                                                                                                                               |
      | Output                | Risk                                                                                                                                                                                                                                     |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:[Modified,Forward,Drop,Source Reset,Destination Reset,Source and Destination Reset,Bypass,Challenge,HTTP 200 OK,HTTP 200 OK and Reset Destination,HTTP 403 Forbidden,HTTP 403 Forbidden and Reset Destination] |
      | devices               | All                                                                                                                                                                                                                                      |
      | Time Definitions.Date | Quick:1M                                                                                                                                                                                                                                 |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                         |
      | Format                | Select: CSV                                                                                                                                                                                                                              |
    Then UI Delete Forensics With Name "Output Risk Action Not Equals"

  @SID_6
  Scenario: create new Output Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag Attack Name Equals
    Given UI "Create" Forensics With Name "Output Action_Attack ID_Policy Name_Source IP Address_Destination IP Address_Destination Port_Total Mbits Dropped_Max bps_Physical Port_Risk_VLAN Tag Attack Name Equals"
      | Product               | DefensePro                                                                                                                                      |
      | Output                | Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag  |
      | Criteria              | Event Criteria:Attack Name,Operator:Equals,Value:TCP Port Scan                                                                                  |
      | devices               | index:10                                                                                                                                        |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[SEP]                                                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                  |
      | Format                | Select: HTML                                                                                                                                    |
    Then UI "Validate" Forensics With Name "Output Action_Attack ID_Policy Name_Source IP Address_Destination IP Address_Destination Port_Total Mbits Dropped_Max bps_Physical Port_Risk_VLAN Tag Attack Name Equals"
      | Product               | DefensePro                                                                                                                                      |
      | Output                | Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag  |
      | Criteria              | Event Criteria:Attack Name,Operator:Equals,Value:TCP Port Scan                                                                                  |
      | devices               | index:10                                                                                                                                        |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[SEP]                                                                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                  |
      | Format                | Select: HTML                                                                                                                                    |
    Then UI Delete Forensics With Name "Output Action_Attack ID_Policy Name_Source IP Address_Destination IP Address_Destination Port_Total Mbits Dropped_Max bps_Physical Port_Risk_VLAN Tag Attack Name Equals"

  @SID_7
  Scenario: create new Output Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps Attack Name Not Equals
    Given UI "Create" Forensics With Name "Output Source IP Address_Source Port_Destination IP Address_Radware ID_Duration_Total Packets Dropped_Max pps Attack Name Not Equals"
      | Product               | DefensePro                                                                                                       |
      | Output                | Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps           |
      | Criteria              | Event Criteria:Attack Name,Operator:Not Equals,Value:Conn_Limit                                                |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI "Validate" Forensics With Name "Output Source IP Address_Source Port_Destination IP Address_Radware ID_Duration_Total Packets Dropped_Max pps Attack Name Not Equals"
      | Product               | DefensePro                                                                                                       |
      | Output                | Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps           |
      | Criteria              | Event Criteria:Attack Name,Operator:Not Equals,Value:Conn_Limit                                                |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Source IP Address_Source Port_Destination IP Address_Radware ID_Duration_Total Packets Dropped_Max pps Attack Name Not Equals"

  @SID_8
  Scenario: create new Output Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action Attack Rate in bps Greater than
    Given UI "Create" Forensics With Name "Output Start Time_End Time_Device IP Address_Threat Category_Attack Name_Action Attack Rate in bps Greater than"
      | Product               | DefensePro                                                                     |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action       |
      | Criteria              | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:500,Unit:M   |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI "Validate" Forensics With Name "Output Start Time_End Time_Device IP Address_Threat Category_Attack Name_Action Attack Rate in bps Greater than"
      | Product               | DefensePro                                                                     |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action       |
      | Criteria              | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:500,Unit:M   |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Start Time_End Time_Device IP Address_Threat Category_Attack Name_Action Attack Rate in bps Greater than"

  @SID_9
  Scenario: create new Output Policy Name,Source IP Address Attack Rate in bps Greater than
    Given UI "Create" Forensics With Name "Output Policy Name_Source IP Address Attack Rate in bps Greater than"
      | Product               | DefensePro                                                                                                       |
      | Output                | Policy Name,Source IP Address                                                                                    |
      | Criteria              | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:17778,Unit:K                                   |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI "Validate" Forensics With Name "Output Policy Name_Source IP Address Attack Rate in bps Greater than"
      | Product               | DefensePro                                                                                                       |
      | Output                | Policy Name,Source IP Address                                                                                    |
      | Criteria              | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:17778,Unit:K                                   |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Policy Name_Source IP Address Attack Rate in bps Greater than"

  @SID_10
  Scenario: create new Output Destination IP Address,Destination Port,Direction Attack Rate in bps Greater than
    Given UI "Create" Forensics With Name "Output Destination IP Address_Destination Port_Direction Attack Rate in bps Greater than"
      | Product               | DefensePro                                                                     |
      | Output                | Destination IP Address,Destination Port,Direction                              |
      | Criteria              | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:17,Unit:G    |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Weeks,2]                                                             |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI "Validate" Forensics With Name "Output Destination IP Address_Destination Port_Direction Attack Rate in bps Greater than"
      | Product               | DefensePro                                                                     |
      | Output                | Destination IP Address,Destination Port,Direction                              |
      | Criteria              | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:17,Unit:G    |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Weeks,2]                                                             |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name "Output Destination IP Address_Destination Port_Direction Attack Rate in bps Greater than"

  @SID_11
  Scenario: create new Output All Attack Rate in bps Greater than
    Given UI "Create" Forensics With Name "Output All Attack Rate in bps Greater than"
      | Product               | DefensePro                                                                                                                                                                                                                                                                                         |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag  |
      | Criteria              | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:1,Unit:T                                                                                                                                                                                                                         |
      | devices               | All                                                                                                                                                                                                                                                                                                |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                                                                                                                                                                                                 |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                                                        |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                   |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                        |
    Then UI "Validate" Forensics With Name "Output All Attack Rate in bps Greater than"
      | Product               | DefensePro                                                                                                                                                                                                                                                                                         |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag  |
      | Criteria              | Event Criteria:Attack Rate in bps,Operator:Greater than,RateValue:1,Unit:T                                                                                                                                                                                                                         |
      | devices               | All                                                                                                                                                                                                                                                                                                |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                                                                                                                                                                                                 |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                                                        |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                   |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                        |
    Then UI Delete Forensics With Name "Output All Attack Rate in bps Greater than"

  @SID_12
  Scenario: create new Output Device IP Address Attack Rate in pps Greater than
    Given UI "Create" Forensics With Name "Output Device IP Address Attack Rate in pps Greater than"
      | Product               | DefensePro                                                                     |
      | Output                | Device IP Address                                                              |
      | Criteria              | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:500,Unit:M   |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI "Validate" Forensics With Name "Output Device IP Address Attack Rate in pps Greater than"
      | Product               | DefensePro                                                                     |
      | Output                | Device IP Address                                                              |
      | Criteria              | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:500,Unit:M   |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Device IP Address Attack Rate in pps Greater than"

  @SID_13
  Scenario: create new Output End Time Attack Rate in pps Greater than
    Given UI "Create" Forensics With Name "Output End Time Attack Rate in pps Greater than"
      | Product               | DefensePro                                                                                                       |
      | Output                | End Time                                                                                                         |
      | Criteria              | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:17778,Unit:K                                   |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI "Validate" Forensics With Name "Output End Time Attack Rate in pps Greater than"
      | Product               | DefensePro                                                                                                       |
      | Output                | End Time                                                                                                         |
      | Criteria              | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:17778,Unit:K                                   |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output End Time Attack Rate in pps Greater than"

  @SID_14
  Scenario: create new Output Start Time Attack Rate in pps Greater than
    Given UI "Create" Forensics With Name "Output Start Time Attack Rate in pps Greater than"
      | Product               | DefensePro                                                                     |
      | Output                | Start Time                                                                     |
      | Criteria              | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:17,Unit:G    |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI "Validate" Forensics With Name "Output Start Time Attack Rate in pps Greater than"
      | Product               | DefensePro                                                                     |
      | Output                | Start Time                                                                     |
      | Criteria              | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:17,Unit:G    |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name "Output Start Time Attack Rate in pps Greater than"

  @SID_15
  Scenario: create new Output Threat Category Attack Rate in pps Greater than
    Given UI "Create" Forensics With Name "Output Threat Category Attack Rate in pps Greater than"
      | Product               | DefensePro                                                                                                       |
      | Output                | Threat Category                                                                                                  |
      | Criteria              | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:1,Unit:T                                       |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI "Validate" Forensics With Name "Output Threat Category Attack Rate in pps Greater than"
      | Product               | DefensePro                                                                                                       |
      | Output                | Threat Category                                                                                                  |
      | Criteria              | Event Criteria:Attack Rate in pps,Operator:Greater than,RateValue:1,Unit:T                                       |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Threat Category Attack Rate in pps Greater than"

  @SID_16
  Scenario: create new Output Attack Name1 Destination IP Equal
    Given UI "Create" Forensics With Name "Output Attack Name1 Destination IP Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Attack Name                                                                    |
      | Criteria              | Event Criteria:Destination IP,Operator:Equals,IPType:IPv4,IPValue:2.2.2.2      |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI "Validate" Forensics With Name "Output Attack Name1 Destination IP Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Attack Name                                                                    |
      | Criteria              | Event Criteria:Destination IP,Operator:Equals,IPType:IPv4,IPValue:2.2.2.2      |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Attack Name1 Destination IP Equal"

  @SID_17
  Scenario: create new Output Attack Name2 Destination IP Not Equal
    Given UI "Create" Forensics With Name "Output Attack Name2 Destination IP Not Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Attack Name                                                                                                      |
      | Criteria              | Event Criteria:Destination IP,Operator:Not Equals,IPType:IPv4,IPValue:4.4.4.1                                    |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:3M                                                                                                         |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI "Validate" Forensics With Name "Output Attack Name2 Destination IP Not Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Attack Name                                                                                                      |
      | Criteria              | Event Criteria:Destination IP,Operator:Not Equals,IPType:IPv4,IPValue:4.4.4.1                                    |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:3M                                                                                                         |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Attack Name2 Destination IP Not Equal"

  @SID_18
  Scenario: create new Output Action Destination IP Equal
    Given UI "Create" Forensics With Name "Output Action Destination IP Equal"
      | Product               | DefensePro                                                                                 |
      | Output                | Action                                                                                     |
      | Criteria              | Event Criteria:Destination IP,Operator:Equals,IPType:IPv6,IPValue:::ffff:0:255.255.255.255 |
      | devices               | index:10                                                                                   |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                           |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body             |
      | Format                | Select: HTML                                                                               |
    Then UI "Validate" Forensics With Name "Output Action Destination IP Equal"
      | Product               | DefensePro                                                                                 |
      | Output                | Action                                                                                     |
      | Criteria              | Event Criteria:Destination IP,Operator:Equals,IPType:IPv6,IPValue:::ffff:0:255.255.255.255 |
      | devices               | index:10                                                                                   |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                           |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[MON]                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body             |
      | Format                | Select: HTML                                                                               |
    Then UI Delete Forensics With Name "Output Action Destination IP Equal"

  @SID_19
  Scenario: create new Output Attack ID Destination IP Not Equal
    Given UI "Create" Forensics With Name "Output Attack ID Destination IP Not Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Attack ID                                                                                                        |
      | Criteria              | Event Criteria:Destination IP,Operator:Not Equals,IPType:IPv6,IPValue:64:ff9b::255.255.255.255                   |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI "Validate" Forensics With Name "Output Attack ID Destination IP Not Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Attack ID                                                                                                        |
      | Criteria              | Event Criteria:Destination IP,Operator:Not Equals,IPType:IPv6,IPValue:64:ff9b::255.255.255.255                   |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Attack ID Destination IP Not Equal"

  @SID_20
  Scenario: create new Output Policy Name Destination IP Equal
    Given UI "Create" Forensics With Name "Output Policy Name Destination IP Equal"
      | Product               | DefensePro                                                                                                |
      | Output                | Policy Name                                                                                               |
      | Criteria              | Event Criteria:Destination IP,Operator:Equals,IPType:IPv6,IPValue:2001:0db8:3c4d:0015:0000:0000:1a2f:1a2b |
      | devices               | All                                                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                            |
      | Format                | Select: CSV                                                                                               |
    Then UI "Validate" Forensics With Name "Output Policy Name Destination IP Equal"
      | Product               | DefensePro                                                                                                |
      | Output                | Policy Name                                                                                               |
      | Criteria              | Event Criteria:Destination IP,Operator:Equals,IPType:IPv6,IPValue:2001:0db8:3c4d:0015:0000:0000:1a2f:1a2b |
      | devices               | All                                                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                            |
      | Format                | Select: CSV                                                                                               |
    Then UI Delete Forensics With Name "Output Policy Name Destination IP Equal"

  @SID_21
  Scenario: create new Output Source IP Address Destination IP Equal
    Given UI "Create" Forensics With Name "Output Source IP Address Destination IP Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Source IP Address                                                                                                |
      | Criteria              | Event Criteria:Destination IP,Operator:Equals,IPType:IPv6,IPValue:2001:db8:3c4d:15::1a2f:1a2b                    |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI "Validate" Forensics With Name "Output Source IP Address Destination IP Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Source IP Address                                                                                                |
      | Criteria              | Event Criteria:Destination IP,Operator:Equals,IPType:IPv6,IPValue:2001:db8:3c4d:15::1a2f:1a2b                    |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Source IP Address Destination IP Equal"

  @SID_22
  Scenario: create new Output Source Port Destination Port Equal
    Given UI "Create" Forensics With Name "Output Source Port Destination Port Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Source Port                                                                    |
      | Criteria              | Event Criteria:Destination Port,Operator:Equals,portType:Single,portValue:80   |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Days,3]                                                              |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI "Validate" Forensics With Name "Output Source Port Destination Port Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Source Port                                                                    |
      | Criteria              | Event Criteria:Destination Port,Operator:Equals,portType:Single,portValue:80   |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Days,3]                                                              |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name "Output Source Port Destination Port Equal"

  @SID_23
  Scenario: create new Output Destination IP Address Destination Port Not Equal
    Given UI "Create" Forensics With Name "Output Destination IP Address Destination Port Not Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Destination IP Address                                                                                           |
      | Criteria              | Event Criteria:Destination Port,Operator:Not Equals,portType:Single,portValue:0                                  |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,4]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI "Validate" Forensics With Name "Output Destination IP Address Destination Port Not Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Destination IP Address                                                                                           |
      | Criteria              | Event Criteria:Destination Port,Operator:Not Equals,portType:Single,portValue:0                                  |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,4]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Destination IP Address Destination Port Not Equal"

  @SID_24
  Scenario: create new Output Destination Port Destination Port Equal
    Given UI "Create" Forensics With Name "Output Destination Port Destination Port Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Destination Port                                                               |
      | Criteria              | Event Criteria:Destination Port,Operator:Equals,portType:Single,portValue:53   |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI "Validate" Forensics With Name "Output Destination Port Destination Port Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Destination Port                                                               |
      | Criteria              | Event Criteria:Destination Port,Operator:Equals,portType:Single,portValue:53   |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Destination Port Destination Port Equal"

  @SID_25
  Scenario: create new Output Direction Destination Port Equal
    Given UI "Create" Forensics With Name "Output Direction Destination Port Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Direction                                                                                                        |
      | Criteria              | Event Criteria:Destination Port,Operator:Equals,portType:Range,portFrom:1,portTo:20                              |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI "Validate" Forensics With Name "Output Direction Destination Port Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Direction                                                                                                        |
      | Criteria              | Event Criteria:Destination Port,Operator:Equals,portType:Range,portFrom:1,portTo:20                              |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JAN]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Direction Destination Port Equal"

  @SID_26
  Scenario: create new Output Protocol Destination Port Not Equal
    Given UI "Create" Forensics With Name "Output Protocol Destination Port Not Equal"
      | Product               | DefensePro                                                                                |
      | Output                | Protocol                                                                                  |
      | Criteria              | Event Criteria:Destination Port,Operator:Not Equals,portType:Range,portFrom:90,portTo:100 |
      | devices               | index:10                                                                                  |
      | Time Definitions.Date | Relative:[Days,2]                                                                         |
      | Schedule              | Run Every:Daily,On Time:+2m                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body            |
      | Format                | Select: HTML                                                                              |
    Then UI "Validate" Forensics With Name "Output Protocol Destination Port Not Equal"
      | Product               | DefensePro                                                                                |
      | Output                | Protocol                                                                                  |
      | Criteria              | Event Criteria:Destination Port,Operator:Not Equals,portType:Range,portFrom:90,portTo:100 |
      | devices               | index:10                                                                                  |
      | Time Definitions.Date | Relative:[Days,2]                                                                         |
      | Schedule              | Run Every:Daily,On Time:+2m                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body            |
      | Format                | Select: HTML                                                                              |
    Then UI Delete Forensics With Name "Output Protocol Destination Port Not Equal"

  @SID_27
  Scenario: create new Output Radware ID Direction Equal
    Given UI "Create" Forensics With Name "Output Radware ID Direction Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Radware ID                                                                     |
      | Criteria              | Event Criteria:Direction,Operator:Equals,Value:[Inbound]                            |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Days,2]                                                              |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI "Validate" Forensics With Name "Output Radware ID Direction Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Radware ID                                                                     |
      | Criteria              | Event Criteria:Direction,Operator:Equals,Value:[Inbound]                            |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Days,2]                                                              |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name "Output Radware ID Direction Equal"

  @SID_28
  Scenario: create new Output Duration Direction Equal
    Given UI "Create" Forensics With Name "Output Duration Direction Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Duration                                                                                                         |
      | Criteria              | Event Criteria:Direction,Operator:Equals,Value:[Outbound]                                                             |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI "Validate" Forensics With Name "Output Duration Direction Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Duration                                                                                                         |
      | Criteria              | Event Criteria:Direction,Operator:Equals,Value:[Outbound]                                                             |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Duration Direction Equal"

  @SID_29
  Scenario: create new Output Total Packets Dropped Direction Equal
    Given UI "Create" Forensics With Name "Output Total Packets Dropped Direction Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Total Packets Dropped                                                                                            |
      | Criteria              | Event Criteria:Direction,Operator:Equals,Value:[Unknown]                                                         |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI "Validate" Forensics With Name "Output Total Packets Dropped Direction Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Total Packets Dropped                                                                                            |
      | Criteria              | Event Criteria:Direction,Operator:Equals,Value:[Unknown]                                                         |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Total Packets Dropped Direction Equal"

  @SID_30
  Scenario: create new Output Max pps Direction Equal
    Given UI "Create" Forensics With Name "Output Max pps Direction Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Max pps                                                                                                          |
      | Criteria              | Event Criteria:Direction,Operator:Equals,Value:[Both]                                                            |
      | devices               | index:10                                                                                                         |
      | Time Definitions.Date | Quick:Today                                                                                                      |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI "Validate" Forensics With Name "Output Max pps Direction Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Max pps                                                                                                          |
      | Criteria              | Event Criteria:Direction,Operator:Equals,Value:[Both]                                                            |
      | devices               | index:10                                                                                                         |
      | Time Definitions.Date | Quick:Today                                                                                                      |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Max pps Direction Equal"

  @SID_31
  Scenario: create new Output Total Mbits Dropped Direction Not Equal
    Given UI "Create" Forensics With Name "Output Total Mbits Dropped Direction Not Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Total Mbits Dropped                                                            |
      | Criteria              | Event Criteria:Direction,Operator:Not Equals,Value:[Outbound,Unknown]               |
      | devices               | index:10                                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI "Validate" Forensics With Name "Output Total Mbits Dropped Direction Not Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Total Mbits Dropped                                                            |
      | Criteria              | Event Criteria:Direction,Operator:Not Equals,Value:[Outbound,Unknown]               |
      | devices               | index:10                                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Total Mbits Dropped Direction Not Equal"

  @SID_32
  Scenario: create new Output Max bps Direction Equal
    Given UI "Create" Forensics With Name "Output Max bps Direction Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Max bps                                                                                                          |
      | Criteria              | Event Criteria:Direction,Operator:Equals,Value:[Inbound,Outbound,Unknown,Both]                                             |
      | devices               | index:10                                                                                                         |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI "Validate" Forensics With Name "Output Max bps Direction Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Max bps                                                                                                          |
      | Criteria              | Event Criteria:Direction,Operator:Equals,Value:[Inbound,Outbound,Unknown,Both]                                             |
      | devices               | index:10                                                                                                         |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[JUN]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Max bps Direction Equal"

  @SID_33
  Scenario: create new Output Physical Port Direction Not Equal
    Given UI "Create" Forensics With Name "Output Physical Port Direction Not Equal"
      | Product               | DefensePro                                                                         |
      | Output                | Physical Port                                                                      |
      | Criteria              | Event Criteria:Direction,Operator:Not Equals,Value:[Inbound,Outbound,Unknown,Both] |
      | devices               | index:10                                                                           |
      | Time Definitions.Date | Relative:[Months,4]                                                                |
      | Schedule              | Run Every:once, On Time:+6H                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body     |
      | Format                | Select: HTML                                                                       |
    Then UI "Validate" Forensics With Name "Output Physical Port Direction Not Equal"
      | Product               | DefensePro                                                                         |
      | Output                | Physical Port                                                                      |
      | Criteria              | Event Criteria:Direction,Operator:Not Equals,Value:[Inbound,Outbound,Unknown,Both] |
      | devices               | index:10                                                                           |
      | Time Definitions.Date | Relative:[Months,4]                                                                |
      | Schedule              | Run Every:once, On Time:+6H                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body     |
      | Format                | Select: HTML                                                                       |
    Then UI Delete Forensics With Name "Output Physical Port Direction Not Equal"

  @SID_34
  Scenario: create new Output Risk Duration Equal
    Given UI "Create" Forensics With Name "Output Risk Duration Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Risk                                                                                                             |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[Less than 1 min]                                                   |
      | devices               | index:10                                                                                                         |
      | Time Definitions.Date | Quick:1M                                                                                                         |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI "Validate" Forensics With Name "Output Risk Duration Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Risk                                                                                                             |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[Less than 1 min]                                                   |
      | devices               | index:10                                                                                                         |
      | Time Definitions.Date | Quick:1M                                                                                                         |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Risk Duration Equal"

  @SID_35
  Scenario: create new Output VLAN Tag Duration Equal
    Given UI "Create" Forensics With Name "Output VLAN Tag Duration Equal"
      | Product               | DefensePro                                                                     |
      | Output                | VLAN Tag                                                                       |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[1-5 min]                         |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI "Validate" Forensics With Name "Output VLAN Tag Duration Equal"
      | Product               | DefensePro                                                                     |
      | Output                | VLAN Tag                                                                       |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[1-5 min]                         |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output VLAN Tag Duration Equal"

  @SID_36
  Scenario: create new Output Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped Duration Equal
    Given UI "Create" Forensics With Name "Output Destination IP Address_Destination Port_Direction_Protocol_Radware ID_Duration_Total Packets Dropped Duration Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped             |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[5-10 min]                                                          |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI "Validate" Forensics With Name "Output Destination IP Address_Destination Port_Direction_Protocol_Radware ID_Duration_Total Packets Dropped Duration Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped             |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[5-10 min]                                                          |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Destination IP Address_Destination Port_Direction_Protocol_Radware ID_Duration_Total Packets Dropped Duration Equal"

  @SID_37
  Scenario: create new Output Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag Duration Equal
    Given UI "Create" Forensics With Name "Output Action_Attack ID_Policy Name_Source IP Address_Destination IP Address_Destination Port_Total Mbits Dropped_Max bps_Physical Port_Risk_VLAN Tag Duration Equal"
      | Product               | DefensePro                                                                                                                                     |
      | Output                | Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[10-30 min]                                                                                       |
      | devices               | index:10                                                                                                                                       |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                 |
      | Format                | Select: HTML                                                                                                                                   |
    Then UI "Validate" Forensics With Name "Output Action_Attack ID_Policy Name_Source IP Address_Destination IP Address_Destination Port_Total Mbits Dropped_Max bps_Physical Port_Risk_VLAN Tag Duration Equal"
      | Product               | DefensePro                                                                                                                                     |
      | Output                | Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[10-30 min]                                                                                       |
      | devices               | index:10                                                                                                                                       |
      | Time Definitions.Date | Relative:[Days,3]                                                                                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                 |
      | Format                | Select: HTML                                                                                                                                   |
    Then UI Delete Forensics With Name "Output Action_Attack ID_Policy Name_Source IP Address_Destination IP Address_Destination Port_Total Mbits Dropped_Max bps_Physical Port_Risk_VLAN Tag Duration Equal"

  @SID_38
  Scenario: create new Output Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps Duration Equal
    Given UI "Create" Forensics With Name "Output Source IP Address_Source Port_Destination IP Address_Radware ID_Duration_Total Packets Dropped_Max pps Duration Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps           |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[30-60 min]                                                         |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI "Validate" Forensics With Name "Output Source IP Address_Source Port_Destination IP Address_Radware ID_Duration_Total Packets Dropped_Max pps Duration Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps           |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[30-60 min]                                                         |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Source IP Address_Source Port_Destination IP Address_Radware ID_Duration_Total Packets Dropped_Max pps Duration Equal"

  @SID_39
  Scenario: create new Output Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action Duration Equal
    Given UI "Create" Forensics With Name "Output Start Time_End Time_Device IP Address_Threat Category_Attack Name_Action Duration Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action       |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[More than 1 hour]                |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1D                                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI "Validate" Forensics With Name "Output Start Time_End Time_Device IP Address_Threat Category_Attack Name_Action Duration Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action       |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[More than 1 hour]                |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1D                                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Start Time_End Time_Device IP Address_Threat Category_Attack Name_Action Duration Equal"

  @SID_40
  Scenario: create new Output Policy Name,Source IP Address Duration Not Equal
    Given UI "Create" Forensics With Name "Output Policy Name_Source IP Address Not Duration Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Policy Name,Source IP Address                                                                                    |
      | Criteria              | Event Criteria:Duration,Operator:Not Equals,Value:[5-10 min,10-30 min,30-60 min]                                    |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI "Validate" Forensics With Name "Output Policy Name_Source IP Address Not Duration Equal"
      | Product               | DefensePro                                                                                                       |
      | Output                | Policy Name,Source IP Address                                                                                    |
      | Criteria              | Event Criteria:Duration,Operator:Not Equals,Value:[5-10min,10-30min,30-60min]                                    |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Policy Name_Source IP Address Not Duration Equal"

  @SID_41
  Scenario: create new Output Destination IP Address,Destination Port,Direction Duration Equal
    Given UI "Create" Forensics With Name "Output Destination IP Address_Destination Port_Direction Duration Equal"
      | Product               | DefensePro                                                                       |
      | Output                | Destination IP Address,Destination Port,Direction                                |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[Less than 1 min,More than 1 hour]   |
      | devices               | index:10                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body   |
      | Format                | Select: HTML                                                                     |
    Then UI "Validate" Forensics With Name "Output Destination IP Address_Destination Port_Direction Duration Equal"
      | Product               | DefensePro                                                                       |
      | Output                | Destination IP Address,Destination Port,Direction                                |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[Less than 1 min,More than 1 hour]   |
      | devices               | index:10                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body   |
      | Format                | Select: HTML                                                                     |
    Then UI Delete Forensics With Name "Output Destination IP Address_Destination Port_Direction Duration Equal"

  @SID_42
  Scenario: create new Output All Duration Equal
    Given UI "Create" Forensics With Name "Output All Duration Equal"
      | Product               | DefensePro                                                                                                                                                                                                                                                                                         |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag  |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[Less than 1 min,1-5 min,5-10 min,10-30 min,30-60 min,More than 1 hour]                                                                                                                                                                                    |
      | devices               | All                                                                                                                                                                                                                                                                                                |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                                                                                                                                                                                                  |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                                                        |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                   |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                        |
    Then UI "Validate" Forensics With Name "Output All Duration Equal"
      | Product               | DefensePro                                                                                                                                                                                                                                                                                         |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag  |
      | Criteria              | Event Criteria:Duration,Operator:Equals,Value:[Less than 1 min,1-5 min,5-10 min,10-30 min,30-60 min,More than 1 hour]                                                                                                                                                                                    |
      | devices               | All                                                                                                                                                                                                                                                                                                |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                                                                                                                                                                                                  |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                                                        |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                   |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                        |
    Then UI Delete Forensics With Name "Output All Duration Equal"

  @SID_43
  Scenario: create new Output Start Time Duration Not Equal
    Given UI "Create" Forensics With Name "Output Start Time Duration Not Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Start Time                                                                     |
      | Criteria              | Event Criteria:Duration,Operator:Not Equals,Value:[1-5 min,5-10 min,10-30 min]    |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI "Validate" Forensics With Name "Output Start Time Duration Not Equal"
      | Product               | DefensePro                                                                     |
      | Output                | Start Time                                                                     |
      | Criteria              | Event Criteria:Duration,Operator:Not Equals,Value:[1-5 min,5-10 min,10-30 min]    |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Start Time Duration Not Equal"

  @SID_44
  Scenario: create new Output End Time Duration Not Equal
    Given UI "Create" Forensics With Name "Output End Time Duration Not Equal"
      | Product               | DefensePro                                                                                                          |
      | Output                | End Time                                                                                                            |
      | Criteria              | Event Criteria:Duration,Operator:Not Equals,Value:[Less than 1 min,1-5 min,5-10 min,10-30 min,30-60 min,More than 1 hour] |
      | devices               | All                                                                                                                 |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                  |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                        |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware    |
      | Format                | Select: CSV With Attack Details                                                                                     |
    Then UI "Validate" Forensics With Name "Output End Time Duration Not Equal"
      | Product               | DefensePro                                                                                                          |
      | Output                | End Time                                                                                                            |
      | Criteria              | Event Criteria:Duration,Operator:Not Equals,Value:[Less than 1 min,1-5 min,5-10 min,10-30 min,30-60 min,More than 1 hour] |
      | devices               | All                                                                                                                 |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                  |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                        |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware    |
      | Format                | Select: CSV With Attack Details                                                                                     |
    Then UI Delete Forensics With Name "Output End Time Duration Not Equal"

  @SID_45
  Scenario: create new Output Device IP Address Max bps Greater than
    Given UI "Create" Forensics With Name "Output Device IP Address Max bps Greater than"
      | Product               | DefensePro                                                                     |
      | Output                | Device IP Address                                                              |
      | Criteria              | Event Criteria:Max bps,Operator:Greater than,RateValue:500,Unit:M              |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI "Validate" Forensics With Name "Output Device IP Address Max bps Greater than"
      | Product               | DefensePro                                                                     |
      | Output                | Device IP Address                                                              |
      | Criteria              | Event Criteria:Max bps,Operator:Greater than,RateValue:500,Unit:M              |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name "Output Device IP Address Max bps Greater than"

  @SID_46
  Scenario: create new Output Threat Category Max bps Greater than
    Given UI "Create" Forensics With Name "Output Threat Category Max bps Greater than"
      | Product               | DefensePro                                                                                                       |
      | Output                | Threat Category                                                                                                  |
      | Criteria              | Event Criteria:Max bps,Operator:Greater than,RateValue:17778,Unit:K                                              |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI "Validate" Forensics With Name "Output Threat Category Max bps Greater than"
      | Product               | DefensePro                                                                                                       |
      | Output                | Threat Category                                                                                                  |
      | Criteria              | Event Criteria:Max bps,Operator:Greater than,RateValue:17778,Unit:K                                              |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Threat Category Max bps Greater than"

  @SID_47
  Scenario: create new Output Attack Name1 Max bps Greater than
    Given UI "Create" Forensics With Name "Output Attack Name1 Max bps Greater than"
      | Product               | DefensePro                                                                     |
      | Output                | Attack Name                                                                    |
      | Criteria              | Event Criteria:Max bps,Operator:Greater than,RateValue:17,Unit:G               |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI "Validate" Forensics With Name "Output Attack Name1 Max bps Greater than"
      | Product               | DefensePro                                                                     |
      | Output                | Attack Name                                                                    |
      | Criteria              | Event Criteria:Max bps,Operator:Greater than,RateValue:17,Unit:G               |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Attack Name1 Max bps Greater than"

  @SID_48
  Scenario: create new Output Attack Name2 Max bps Greater than
    Given UI "Create" Forensics With Name "Output Attack Name2 Max bps Greater than"
      | Product               | DefensePro                                                                                                       |
      | Output                | Attack Name                                                                                                      |
      | Criteria              | Event Criteria:Max bps,Operator:Greater than,RateValue:1,Unit:T                                                  |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI "Validate" Forensics With Name "Output Attack Name2 Max bps Greater than"
      | Product               | DefensePro                                                                                                       |
      | Output                | Attack Name                                                                                                      |
      | Criteria              | Event Criteria:Max bps,Operator:Greater than,RateValue:1,Unit:T                                                  |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Attack Name2 Max bps Greater than"

  @SID_49
  Scenario: Logout
    Then UI logout and close browser



















































































