@TC119587
Feature:Create DefenseFlow Part1

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    * REST Delete ES index "forensics-*"
    Then UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Vision Install License Request "vision-AVA-AppWall"
    * REST Vision Install License Request "vision-reporting-module-AMS"
    Then UI Navigate to "New Forensics" page via homePage

  @SID_2
  Scenario: create new Output Device IP Address
    Given UI "Create" Forensics With Name " Output Device IP Address"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Device IP Address                                                                                                |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:This Month                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI "Validate" Forensics With Name " Output Device IP Address"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Device IP Address                                                                                                |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:This Month                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name " Output Device IP Address"

  @SID_3
  Scenario: create new Output End Time
    Given UI "Create" Forensics With Name "Output End Time"
      | Product               | DefenseFlow                                                                    |
      | Output                | End Time                                                                       |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
      When UI "Validate" Forensics With Name "Output End Time"
      | Product               | DefenseFlow                                                                    |
      | Output                | End Time                                                                       |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name "Output End Time"

  @SID_4
  Scenario: create new Output Start Time
    Given UI "Create" Forensics With Name "Output Start Time"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Start Time                                                                                                       |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    When UI "Validate" Forensics With Name "Output Start Time"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Start Time                                                                                                       |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Start Time"

  @SID_5
  Scenario: create new Output Threat Category
    Given UI "Create" Forensics With Name "Output Threat Category"
      | Product               | DefenseFlow                                                                    |
      | Output                | Threat Category                                                                |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    When UI "Validate" Forensics With Name "Output Threat Category"
      | Product               | DefenseFlow                                                                    |
      | Output                | Threat Category                                                                |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Threat Category"

  @SID_6
  Scenario: create new Output Attack Name1
    Given UI "Create" Forensics With Name "Output Attack Name1"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Attack Name                                                                                                      |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    When UI "Validate" Forensics With Name "Output Attack Name1"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Attack Name                                                                                                      |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Attack Name1"

  @SID_7
  Scenario: create new Output Attack Name2
    Given UI "Create" Forensics With Name "Output Attack Name2"
      | Product               | DefenseFlow                                                                    |
      | Output                | Attack Name                                                                    |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    When UI "Validate" Forensics With Name "Output Attack Name2"
      | Product               | DefenseFlow                                                                    |
      | Output                | Attack Name                                                                    |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name "Output Attack Name2"

  @SID_8
  Scenario: create new Output Action
    Given UI "Create" Forensics With Name "Output Action"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Action                                                                                                           |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    When UI "Validate" Forensics With Name "Output Action"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Action                                                                                                           |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Action"

  @SID_9
  Scenario: create new Output Attack ID
    Given UI "Create" Forensics With Name "Output Attack ID"
      | Product               | DefenseFlow                                                                    |
      | Output                | Attack ID                                                                      |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    When UI "Validate" Forensics With Name "Output Attack ID"
      | Product               | DefenseFlow                                                                    |
      | Output                | Attack ID                                                                      |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Attack ID"

  @SID_10
  Scenario: create new Output Policy Name
    Given UI "Create" Forensics With Name "Output Policy Name"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Policy Name                                                                                                      |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    When UI "Validate" Forensics With Name "Output Policy Name"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Policy Name                                                                                                      |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Policy Name"

  @SID_11
  Scenario: create new Output Source IP Address
    Given UI "Create" Forensics With Name "Output Source IP Address"
      | Product               | DefenseFlow                                                                    |
      | Output                | Source IP Address                                                              |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    When UI "Validate" Forensics With Name "Output Source IP Address"
      | Product               | DefenseFlow                                                                    |
      | Output                | Source IP Address                                                              |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name "Output Source IP Address"

  @SID_12
  Scenario: create new Output Source Port
    Given UI "Create" Forensics With Name "Output Source Port"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Source Port                                                                                                      |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    When UI "Validate" Forensics With Name "Output Source Port"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Source Port                                                                                                      |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Source Port"

  @SID_13
  Scenario: create new Output Destination IP Address
    Given UI "Create" Forensics With Name "Output Destination IP Address"
      | Product               | DefenseFlow                                                                    |
      | Output                | Destination IP Address                                                         |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    When UI "Validate" Forensics With Name "Output Destination IP Address"
      | Product               | DefenseFlow                                                                    |
      | Output                | Destination IP Address                                                         |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Destination IP Address"

  @SID_14
  Scenario: create new Output Destination Port
    Given UI "Create" Forensics With Name "Output Destination Port"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Destination Port                                                                                                 |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    When UI "Validate" Forensics With Name "Output Destination Port"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Destination Port                                                                                                 |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Destination Port"

  @SID_15
  Scenario: create new Output Direction
    Given UI "Create" Forensics With Name "Output Direction"
      | Product               | DefenseFlow                                                                    |
      | Output                | Direction                                                                      |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    When UI "Validate" Forensics With Name "Output Direction"
      | Product               | DefenseFlow                                                                    |
      | Output                | Direction                                                                      |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name "Output Direction"

  @SID_16
  Scenario: create new Output Protocol
    Given UI "Create" Forensics With Name "Output Protocol"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Protocol                                                                                                         |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    When UI "Validate" Forensics With Name "Output Protocol"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Protocol                                                                                                         |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Protocol"

  @SID_17
  Scenario: create new Output Radware ID
    Given UI "Create" Forensics With Name "Output Radware ID"
      | Product               | DefenseFlow                                                                    |
      | Output                | Radware ID                                                                     |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1Y                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    When UI "Validate" Forensics With Name "Output Radware ID"
      | Product               | DefenseFlow                                                                    |
      | Output                | Radware ID                                                                     |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1Y                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Radware ID"

  @SID_18
  Scenario: create new Output Duration
    Given UI "Create" Forensics With Name "Output Duration"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Duration                                                                                                         |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:This Month                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    When UI "Validate" Forensics With Name "Output Duration"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Duration                                                                                                         |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:This Month                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Duration"

  @SID_19
  Scenario: create new Output Total Packets Dropped
    Given UI "Create" Forensics With Name "Output Total Packets Dropped"
      | Product               | DefenseFlow                                                                    |
      | Output                | Total Packets Dropped                                                          |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    When UI "Validate" Forensics With Name "Output Total Packets Dropped"
      | Product               | DefenseFlow                                                                    |
      | Output                | Total Packets Dropped                                                          |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name "Output Total Packets Dropped"

  @SID_20
  Scenario: create new Output Max pps
    Given UI "Create" Forensics With Name "Output Max pps"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Max pps                                                                                                          |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    When UI "Validate" Forensics With Name "Output Max pps"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Max pps                                                                                                          |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Max pps"

  @SID_21
  Scenario: create new Output Total Mbits Dropped
    Given UI "Create" Forensics With Name "Output Total Mbits Dropped"
      | Product               | DefenseFlow                                                                    |
      | Output                | Total Mbits Dropped                                                            |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    When UI "Validate" Forensics With Name "Output Total Mbits Dropped"
      | Product               | DefenseFlow                                                                    |
      | Output                | Total Mbits Dropped                                                            |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Total Mbits Dropped"

  @SID_22
  Scenario: create new Output Max bps
    Given UI "Create" Forensics With Name "Output Max bps"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Max bps                                                                                                          |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:3M                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    When UI "Validate" Forensics With Name "Output Max bps"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Max bps                                                                                                          |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:3M                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Max bps"

  @SID_23
  Scenario: create new Output Physical Port
    Given UI "Create" Forensics With Name "Output Physical Port"
      | Product               | DefenseFlow                                                                    |
      | Output                | Physical Port                                                                  |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Quick:This Month                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    When UI "Validate" Forensics With Name "Output Physical Port"
      | Product               | DefenseFlow                                                                    |
      | Output                | Physical Port                                                                  |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Quick:This Month                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name "Output Physical Port"

  @SID_24
  Scenario: create new Output Risk
    Given UI "Create" Forensics With Name "Output Risk"
      | Product               | DefenseFlow                                                                    |
      | Output                | Risk                                                                           |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    When UI "Validate" Forensics With Name "Output Risk"
      | Product               | DefenseFlow                                                                    |
      | Output                | Risk                                                                           |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name "Output Risk"

  @SID_25
  Scenario: create new Output VLAN Tag
    Given UI "Create" Forensics With Name "Output VLAN Tag"
      | Product               | DefenseFlow                                                                    |
      | Output                | VLAN Tag                                                                       |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    When UI "Validate" Forensics With Name "Output VLAN Tag"
      | Product               | DefenseFlow                                                                    |
      | Output                | VLAN Tag                                                                       |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output VLAN Tag"

  @SID_26
  Scenario: create new Output Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped
    Given UI "Create" Forensics With Name "Output Destination IP Address_Destination Port_Direction_Protocol_Radware ID_Duration_Total Packets Dropped"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped             |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    When UI "Validate" Forensics With Name "Output Destination IP Address_Destination Port_Direction_Protocol_Radware ID_Duration_Total Packets Dropped"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped             |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Destination IP Address_Destination Port_Direction_Protocol_Radware ID_Duration_Total Packets Dropped"

  @SID_27
  Scenario: create new Output Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag
    Given UI "Create" Forensics With Name "Output Action_Attack ID_Policy Name_Source IP Address_Destination IP Address_Destination Port_Total Mbits Dropped_Max bps_Physical Port_Risk_VLAN Tag"
      | Product               | DefenseFlow                                                                                                                                    |
      | Output                | Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag |
      | Criteria              | condition.All:true                                                                                                                             |
      | devices               | index:10                                                                                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                 |
      | Format                | Select: HTML                                                                                                                                   |
    When UI "Validate" Forensics With Name "Output Action_Attack ID_Policy Name_Source IP Address_Destination IP Address_Destination Port_Total Mbits Dropped_Max bps_Physical Port_Risk_VLAN Tag"
      | Product               | DefenseFlow                                                                                                                                    |
      | Output                | Action,Attack ID,Policy Name,Source IP Address,Destination IP Address,Destination Port,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag |
      | Criteria              | condition.All:true                                                                                                                             |
      | devices               | index:10                                                                                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                 |
      | Format                | Select: HTML                                                                                                                                   |
    Then UI Delete Forensics With Name "Output Action_Attack ID_Policy Name_Source IP Address_Destination IP Address_Destination Port_Total Mbits Dropped_Max bps_Physical Port_Risk_VLAN Tag"

  @SID_28
  Scenario: create new Output Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps
    Given UI "Create" Forensics With Name "Output Source IP Address_Source Port_Destination IP Address_Radware ID_Duration_Total Packets Dropped_Max pps"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps           |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    When UI "Validate" Forensics With Name "Output Source IP Address_Source Port_Destination IP Address_Radware ID_Duration_Total Packets Dropped_Max pps"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Source IP Address,Source Port,Destination IP Address,Radware ID,Duration,Total Packets Dropped,Max pps           |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Source IP Address_Source Port_Destination IP Address_Radware ID_Duration_Total Packets Dropped_Max pps"

  @SID_29
  Scenario: create new Output Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action
    Given UI "Create" Forensics With Name "Output Start Time_End Time_Device IP Address_Threat Category_Attack Name_Action"
      | Product               | DefenseFlow                                                                    |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action       |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    When UI "Validate" Forensics With Name "Output Start Time_End Time_Device IP Address_Threat Category_Attack Name_Action"
      | Product               | DefenseFlow                                                                    |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action       |
      | Criteria              | condition.All:true                                                             |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Start Time_End Time_Device IP Address_Threat Category_Attack Name_Action"

  @SID_30
  Scenario: create new Output Policy Name,Source IP Address
    Given UI "Create" Forensics With Name "Output Policy Name_Source IP Address"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Policy Name,Source IP Address                                                                                    |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    When UI "Validate" Forensics With Name "Output Policy Name_Source IP Address"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Policy Name,Source IP Address                                                                                    |
      | Criteria              | condition.All:true                                                                                               |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Policy Name_Source IP Address"

  @SID_31
  Scenario: create new Output Destination IP Address,Destination Port,Direction
    Given UI "Create" Forensics With Name "Output Destination IP Address_Destination Port_Direction"
      | Product               | DefenseFlow                                                                    |
      | Output                | Destination IP Address,Destination Port,Direction                              |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    When UI "Validate" Forensics With Name "Output Destination IP Address_Destination Port_Direction"
      | Product               | DefenseFlow                                                                    |
      | Output                | Destination IP Address,Destination Port,Direction                              |
      | Criteria              | condition.All:true                                                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name "Output Destination IP Address_Destination Port_Direction"

  @SID_32
  Scenario: create new Output All
    Given UI "Create" Forensics With Name "Output All"
      | Product               | DefenseFlow                                                                                                                                                                                                                                                                                       |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag |
      | Criteria              | condition.All:true                                                                                                                                                                                                                                                                                |
      | devices               | All                                                                                                                                                                                                                                                                                               |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                                                                                |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                                                       |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                  |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                       |
    When UI "Validate" Forensics With Name "Output All"
      | Product               | DefenseFlow                                                                                                                                                                                                                                                                                       |
      | Output                | Start Time,End Time,Device IP Address,Threat Category,Attack Name,Action,Attack ID,Policy Name,Source IP Address,Source Port,Destination IP Address,Destination Port,Direction,Protocol,Radware ID,Duration,Total Packets Dropped,Max pps,Total Mbits Dropped,Max bps,Physical Port,Risk,VLAN Tag |
      | Criteria              | condition.All:true                                                                                                                                                                                                                                                                                |
      | devices               | All                                                                                                                                                                                                                                                                                               |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                                                                                |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                                                                       |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                  |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                       |
    Then UI Delete Forensics With Name "Output All"

  @SID_33
  Scenario: create new Output Start Time Equals
    Given UI "Create" Forensics With Name "Output Start Time Equals"
      | Product               | DefenseFlow                                                                    |
      | Output                | Start Time                                                                     |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Modified                           |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1Y                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    When UI "Validate" Forensics With Name "Output Start Time Equals"
      | Product               | DefenseFlow                                                                    |
      | Output                | Start Time                                                                     |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Modified                           |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1Y                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Start Time Equals"

  @SID_34
  Scenario: create new Output End Time Equals
    Given UI "Create" Forensics With Name "Output End Time Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | End Time                                                                                                         |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Modified                                                              |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:This Month                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    When UI "Validate" Forensics With Name "Output End Time Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | End Time                                                                                                         |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Modified                                                             |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:This Month                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output End Time Equals"

  @SID_35
  Scenario: create new Output Device IP Address Equals
    Given UI "Create" Forensics With Name "Output Device IP Address Equals"
      | Product               | DefenseFlow                                                                    |
      | Output                | Device IP Address                                                              |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Drop                               |
      | devices               | indec:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    When UI "Validate" Forensics With Name "Output Device IP Address Equals"
      | Product               | DefenseFlow                                                                    |
      | Output                | Device IP Address                                                              |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Drop                               |
      | devices               | indec:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name ""Output Device IP Address Equals"

  @SID_36
  Scenario: create new Output Threat Category Equals
    Given UI "Create" Forensics With Name "Output Threat Category Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Threat Category                                                                                                  |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Source Reset                                                         |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    When UI "Validate" Forensics With Name "Output Threat Category Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Threat Category                                                                                                  |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Source Reset                                                         |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Threat Category Equals"

  @SID_37
  Scenario: create new Output Attack Name1 Equals
    Given UI "Create" Forensics With Name "Output Attack Name1 Equals"
      | Product               | DefenseFlow                                                                    |
      | Output                | Attack Name                                                                    |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Destination Reset                  |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    When UI "Validate" Forensics With Name "Output Attack Name1 Equals"
      | Product               | DefenseFlow                                                                    |
      | Output                | Attack Name                                                                    |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Destination Reset                  |
      | devices               | All                                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Attack Name1 Equals"

  @SID_38
  Scenario: create new Output Attack Name2 Equals
    Given UI "Create" Forensics With Name "Output Attack Name2 Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Attack Name                                                                                                      |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Source and Destination Reset                                         |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    When UI "Validate" Forensics With Name "Output Attack Name2 Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Attack Name                                                                                                      |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Source and Destination Reset                                         |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Attack Name2 Equals"

  @SID_39
  Scenario: create new Output Action Equals
    Given UI "Create" Forensics With Name "Output Action Equals"
      | Product               | DefenseFlow                                                                    |
      | Output                | Action                                                                         |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Bypass                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Days,2]                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    When UI "Validate" Forensics With Name "Output Action Equals"
      | Product               | DefenseFlow                                                                    |
      | Output                | Action                                                                         |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Bypass                             |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Days,2]                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name "Output Action Equals"

  @SID_40
  Scenario: create new Output Attack ID Equals
    Given UI "Create" Forensics With Name "Output Attack ID Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Attack ID                                                                                                        |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Challenge                                                            |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    When UI "Validate" Forensics With Name "Output Attack ID Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Attack ID                                                                                                        |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Challenge                                                            |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Attack ID Equals"

  @SID_41
  Scenario: create new Output Policy Name Equals
    Given UI "Create" Forensics With Name "Output Policy Name Equals"
      | Product               | DefenseFlow                                                                    |
      | Output                | Policy Name                                                                    |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Http 200 Ok                        |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1D                                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    When UI "Validate" Forensics With Name "Output Policy Name Equals"
      | Product               | DefenseFlow                                                                    |
      | Output                | Policy Name                                                                    |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Http 200 Ok                        |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1D                                                                       |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Policy Name Equals"

  @SID_42
  Scenario: create new Output Source IP Address Equals
    Given UI "Create" Forensics With Name "Output Source IP Address Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Source IP Address                                                                                                |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Http 200 Ok Reset Dest                                               |
      | devices               | index:10                                                                                                         |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    When UI "Validate" Forensics With Name "Output Source IP Address Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Source IP Address                                                                                                |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Http 200 Ok Reset Dest                                               |
      | devices               | index:10                                                                                                         |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Source IP Address Equals"

  @SID_43
  Scenario: create new Output Source Port Equals
    Given UI "Create" Forensics With Name "Output Source Port Equals"
      | Product               | DefenseFlow                                                                    |
      | Output                | Source Port                                                                    |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Http 403 Forbidden                 |
      | devices               | index:10                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    When UI "Validate" Forensics With Name "Output Source Port Equals"
      | Product               | DefenseFlow                                                                    |
      | Output                | Source Port                                                                    |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Http 403 Forbidden                 |
      | devices               | index:10                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name "Output Source Port Equals"

  @SID_44
  Scenario: create new Output Destination IP Address Equals
    Given UI "Create" Forensics With Name "Output Destination IP Address Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Destination IP Address                                                                                           |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Http 403 Forbidden Reset Dest                                        |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    When UI "Validate" Forensics With Name "Output Destination IP Address Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Destination IP Address                                                                                           |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:Http 403 Forbidden Reset Dest                                        |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Destination IP Address Equals"

  @SID_45
  Scenario: create new Output Destination Port Equals
    Given UI "Create" Forensics With Name "Output Destination Port Equals"
      | Product               | DefenseFlow                                                                                                                                |
      | Output                | Destination Port                                                                                                                           |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:[Modified,Source Reset,Source and Destination Reset,Http 200 Ok,Http 403 Forbidden Reset Dest] |
      | devices               | All                                                                                                                                        |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                             |
      | Format                | Select: CSV                                                                                                                                |
    When UI "Validate" Forensics With Name "Output Destination Port Equals"
      | Product               | DefenseFlow                                                                                                                                |
      | Output                | Destination Port                                                                                                                           |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:[Modified,Source Reset,Source and Destination Reset,Http 200 Ok,Http 403 Forbidden Reset Dest] |
      | devices               | All                                                                                                                                        |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                             |
      | Format                | Select: CSV                                                                                                                                |
    Then UI Delete Forensics With Name "Output Destination Port Equals"

  @SID_46
  Scenario: create new Output Direction Equals
    Given UI "Create" Forensics With Name "Output Direction Equals"
      | Product               | DefenseFlow                                                                                                                                                                                                                          |
      | Output                | Direction                                                                                                                                                                                                                            |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:[Modified,Forward,Drop,Source Reset,Destination Reset,Source and Destination Reset,Bypass,Challenge,Http 200 Ok,Http 200 Ok Reset Dest,Http 403 Forbidden,Http 403 Forbidden Reset Dest] |
      | devices               | All                                                                                                                                                                                                                                  |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                   |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                                                                                                                                         |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                     |
      | Format                | Select: CSV With Attack Details                                                                                                                                                                                                      |
    When UI "Validate" Forensics With Name "Output Direction Equals"
      | Product               | DefenseFlow                                                                                                                                                                                                                          |
      | Output                | Direction                                                                                                                                                                                                                            |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:[Modified,Forward,Drop,Source Reset,Destination Reset,Source and Destination Reset,Bypass,Challenge,Http 200 Ok,Http 200 Ok Reset Dest,Http 403 Forbidden,Http 403 Forbidden Reset Dest] |
      | devices               | All                                                                                                                                                                                                                                  |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                   |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                                                                                                                                         |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                     |
      | Format                | Select: CSV With Attack Details                                                                                                                                                                                                      |
    Then UI Delete Forensics With Name "Output Direction Equals"

  @SID_47
  Scenario: create new Output Protocol Not Equals
    Given UI "Create" Forensics With Name "Output Protocol Not Equals"
      | Product               | DefenseFlow                                                                    |
      | Output                | Protocol                                                                       |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Source and Destination Reset   |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    When UI "Validate" Forensics With Name "Output Protocol Not Equals"
      | Product               | DefenseFlow                                                                    |
      | Output                | Protocol                                                                       |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Source and Destination Reset   |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                               |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name "Output Protocol Not Equals"

  @SID_48
  Scenario: create new Output Radware ID Not Equals
    Given UI "Create" Forensics With Name "Output Radware ID Not Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Radware ID                                                                                                       |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Bypass                                                           |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    When UI "Validate" Forensics With Name "Output Radware ID Not Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Radware ID                                                                                                       |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Bypass                                                           |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Output Radware ID Not Equals"

  @SID_49
  Scenario: create new Output Duration Not Equals
    Given UI "Create" Forensics With Name "Output Duration Not Equals"
      | Product  | DefenseFlow                                                                    |
      | Output   | Duration                                                                       |
      | Criteria | Event Criteria:Action,Operator:Not Equals,Value:Challenge                      |
      | devices  | All                                                                            |
      | Schedule | Run Every:Weekly, On Time:+6H, At Days:[THU]                                   |
      | Share    | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format   | Select: CSV                                                                    |
    When UI "Validate" Forensics With Name "Output Duration Not Equals"
      | Product  | DefenseFlow                                                                    |
      | Output   | Duration                                                                       |
      | Criteria | Event Criteria:Action,Operator:Not Equals,Value:Challenge                      |
      | devices  | All                                                                            |
      | Schedule | Run Every:Weekly, On Time:+6H, At Days:[THU]                                   |
      | Share    | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format   | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Output Duration Not Equals"

  @SID_50
  Scenario: create new Output Total Packets Dropped Not Equals
    Given UI "Create" Forensics With Name "Output Total Packets Dropped Not Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Total Packets Dropped                                                                                            |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Http 200 Ok                                                      |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    When UI "Validate" Forensics With Name "Output Total Packets Dropped Not Equals"
      | Product               | DefenseFlow                                                                                                      |
      | Output                | Total Packets Dropped                                                                                            |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Http 200 Ok                                                      |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Output Total Packets Dropped Not Equals"

  @SID_51
  Scenario: create new Output Max pps Not Equals
    Given UI "Create" Forensics With Name "Output Max pps Not Equals"
      | Product               | DefenseFlow                                                                    |
      | Output                | Max pps                                                                        |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Http 200 Ok Reset Dest         |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Weeks,2]                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    When UI "Validate" Forensics With Name "Output Max pps Not Equals"
      | Product               | DefenseFlow                                                                    |
      | Output                | Max pps                                                                        |
      | Criteria              | Event Criteria:Action,Operator:Not Equals,Value:Http 200 Ok Reset Dest         |
      | devices               | index:10                                                                       |
      | Time Definitions.Date | Relative:[Weeks,2]                                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name "Output Max pps Not Equals"

  @SID_52
  Scenario: Logout
    Then UI logout and close browser
















































































