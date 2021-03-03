@TC119586
Feature:Create AppWall Part3

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    * REST Delete ES index "forensics-*"
    Then UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Vision Install License Request "vision-AVA-AppWall"
    * REST Vision Install License Request "vision-reporting-module-AMS"
    Then UI Navigate to "New Forensics" page via homePage

  @SID_2
  Scenario: create new Threat Category1 Equal
    Given UI "Create" Forensics With Name "Threat Category1 Equal"
      | Product               | AppWall                                                                                                                                              |
      | Output                | Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[HTTP RFC Violation]                                                                            |
      | devices               | All                                                                                                                                                  |
      | Time Definitions.Date | Quick:3M                                                                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                     |
      | Format                | Select: CSV With Attack Details                                                                                                                      |
    Then UI "Validate" Forensics With Name "Threat Category1 Equal"
      | Product               | AppWall                                                                                                                                              |
      | Output                | Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[HTTP RFC Violation]                                                                            |
      | devices               | All                                                                                                                                                  |
      | Time Definitions.Date | Quick:3M                                                                                                                                             |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                     |
      | Format                | Select: CSV With Attack Details                                                                                                                      |
    Then UI Delete Forensics With Name "Threat Category1 Equal"

  @SID_3
  Scenario: create new Threat Category2 Equal
    Given UI "Create" Forensics With Name "Threat Category2 Equal"
      | Product               | AppWall                                                                                                                       |
      | Output                | Action,Threat Category                                                                                                        |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Dos]                                                                    |
      | devices               | index:10                                                                                                                      |
      | Time Definitions.Date | Quick:This Month                                                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                |
      | Format                | Select: HTML                                                                                                                  |
    Then UI "Validate" Forensics With Name "Threat Category2 Equal"
      | Product               | AppWall                                                                                                                       |
      | Output                | Action,Threat Category                                                                                                        |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Dos]                                                                    |
      | devices               | index:10                                                                                                                      |
      | Time Definitions.Date | Quick:This Month                                                                                                              |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                |
      | Format                | Select: HTML                                                                                                                  |
    Then UI Delete Forensics With Name "Threat Category2 Equal"

  @SID_4
  Scenario: create new Threat Category3 Equal
    Given UI "Create" Forensics With Name "Threat Category3 Equal"
      | Product               | AppWall                                                                                                                       |
      | Output                | Web Application Name,Event Description,Attack Name,Device Host Name,Directory,Module,Severity,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Information Leakage]                                                    |
      | devices               | All                                                                                                                           |
      | Time Definitions.Date | Quick:3M                                                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                               |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware              |
      | Format                | Select: CSV With Attack Details                                                                                               |
    Then UI "Validate" Forensics With Name "Threat Category3 Equal"
      | Product               | AppWall                                                                                                                       |
      | Output                | Web Application Name,Event Description,Attack Name,Device Host Name,Directory,Module,Severity,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Information Leakage]                                                    |
      | devices               | All                                                                                                                           |
      | Time Definitions.Date | Quick:3M                                                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                               |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware              |
      | Format                | Select: CSV With Attack Details                                                                                               |
    Then UI Delete Forensics With Name "Threat Category3 Equal"

  @SID_5
  Scenario: create new Threat Category4 Equal
    Given UI "Create" Forensics With Name "Threat Category4 Equal"
      | Product               | AppWall                                                                         |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Action,Threat Category |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Automation]               |
      | devices               | index:10                                                                        |
      | Time Definitions.Date | Quick:This Month                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body  |
      | Format                | Select: HTML                                                                    |
    Then UI "Validate" Forensics With Name "Threat Category4 Equal"
      | Product               | AppWall                                                                         |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Action,Threat Category |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Automation]               |
      | devices               | index:10                                                                        |
      | Time Definitions.Date | Quick:This Month                                                                |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body  |
      | Format                | Select: HTML                                                                    |
    Then UI Delete Forensics With Name "Threat Category4 Equal"

  @SID_6
  Scenario: create new Threat Category5 Equal
    Given UI "Create" Forensics With Name "Threat Category5 Equal"
      | Product               | AppWall                                                                                                    |
      | Output                | Date and Time,Device IP,Source Port,Web Application Name,Action,Attack Name,Threat Category,Transaction ID |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Path Traversal]                                      |
      | devices               | index:10                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                             |
      | Format                | Select: HTML                                                                                               |
    Then UI "Validate" Forensics With Name "Threat Category5 Equal"
      | Product               | AppWall                                                                                                    |
      | Output                | Date and Time,Device IP,Source Port,Web Application Name,Action,Attack Name,Threat Category,Transaction ID |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Path Traversal]                                      |
      | devices               | index:10                                                                                                   |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                            |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                             |
      | Format                | Select: HTML                                                                                               |
    Then UI Delete Forensics With Name "Threat Category5 Equal"

  @SID_7
  Scenario: create new Threat Category6 Equal
    Given UI "Create" Forensics With Name "Threat Category6 Equal"
      | Product               | AppWall                                                                                                                           |
      | Output                | Source IP,Destination IP Address,Cluster Manager IP,Event Description,Device Host Name,Directory,Module,Severity,Tunnel,User Name |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Response Format Violation]                                                  |
      | devices               | All                                                                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                    |
      | Format                | Select: CSV                                                                                                                       |
    Then UI "Validate" Forensics With Name "Threat Category6 Equal"
      | Product               | AppWall                                                                                                                           |
      | Output                | Source IP,Destination IP Address,Cluster Manager IP,Event Description,Device Host Name,Directory,Module,Severity,Tunnel,User Name |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Response Format Violation]                                                  |
      | devices               | All                                                                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                    |
      | Format                | Select: CSV                                                                                                                       |
    Then UI Delete Forensics With Name "Threat Category6 Equal"

  @SID_8
  Scenario: create new Threat Category7 Equal
    Given UI "Create" Forensics With Name "Threat Category7 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Cluster Manager IP,Attack Name                                                                                   |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[XML & Web Services Violation]                              |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI "Validate" Forensics With Name "Threat Category7 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Cluster Manager IP,Attack Name                                                                                   |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[XML & Web Services Violation]                              |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Threat Category7 Equal"

  @SID_9
  Scenario: create new Threat Category8 Equal
    Given UI "Create" Forensics With Name "Threat Category8 Equal"
      | Product               | AppWall                                                                                  |
      | Output                | Source IP                                                                                |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Cross site Request Forgery (CSRF)] |
      | devices               | index:10                                                                                 |
      | Time Definitions.Date | Relative:[Days,2]                                                                        |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body           |
      | Format                | Select: HTML                                                                             |
    Then UI "Validate" Forensics With Name "Threat Category8 Equal"
      | Product               | AppWall                                                                                  |
      | Output                | Source IP                                                                                |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Cross site Request Forgery (CSRF)] |
      | devices               | index:10                                                                                 |
      | Time Definitions.Date | Relative:[Days,2]                                                                        |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                             |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body           |
      | Format                | Select: HTML                                                                             |
    Then UI Delete Forensics With Name "Threat Category8 Equal"

  @SID_10
  Scenario: create new Threat Category9 Equal
    Given UI "Create" Forensics With Name "Threat Category9 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Destination IP Address,Cluster Manager IP,Event Description,Device Host Name,Severity,User Name                  |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Remote File Inclusion]                                     |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI "Validate" Forensics With Name "Threat Category9 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Destination IP Address,Cluster Manager IP,Event Description,Device Host Name,Severity,User Name                  |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Remote File Inclusion]                                     |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Threat Category9 Equal"

  @SID_11
  Scenario: create new Threat Category10 Equal
    Given UI "Create" Forensics With Name "Threat Category10 Equal"
      | Product               | AppWall                                                                               |
      | Output                | Date and Time                                                                         |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Authentication & Authorization] |
      | devices               | All                                                                                   |
      | Time Definitions.Date | Quick:1D                                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body        |
      | Format                | Select: CSV                                                                           |
    Then UI "Validate" Forensics With Name "Threat Category10 Equal"
      | Product               | AppWall                                                                               |
      | Output                | Date and Time                                                                         |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Authentication & Authorization] |
      | devices               | All                                                                                   |
      | Time Definitions.Date | Quick:1D                                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                          |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body        |
      | Format                | Select: CSV                                                                           |
    Then UI Delete Forensics With Name "Threat Category10 Equal"

  @SID_12
  Scenario: create new Threat Category11 Equal
    Given UI "Create" Forensics With Name "Threat Category11 Equal"
      | Product               | AppWall                                                                                                                                                                    |
      | Output                | Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Hot Link]                                                                                                            |
      | devices               | All                                                                                                                                                                        |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                           |
      | Schedule              | Run Every:once, On Time:+6H                                                                                                                                                |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                           |
      | Format                | Select: CSV With Attack Details                                                                                                                                            |
    Then UI "Validate" Forensics With Name "Threat Category11 Equal"
      | Product               | AppWall                                                                                                                                                                    |
      | Output                | Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Hot Link]                                                                                                            |
      | devices               | All                                                                                                                                                                        |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                           |
      | Schedule              | Run Every:once, On Time:+6H                                                                                                                                                |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                           |
      | Format                | Select: CSV With Attack Details                                                                                                                                            |
    Then UI Delete Forensics With Name "Threat Category11 Equal"

  @SID_13
  Scenario: create new Threat Category12 Equal
    Given UI "Create" Forensics With Name "Threat Category12 Equal"
      | Product               | AppWall                                                                        |
      | Output                | Date and Time,Device IP,Source IP,Transaction ID,Tunnel                        |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Misconfiguration]        |
      | devices               | index:10                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI "Validate" Forensics With Name "Threat Category12 Equal"
      | Product               | AppWall                                                                        |
      | Output                | Date and Time,Device IP,Source IP,Transaction ID,Tunnel                        |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Misconfiguration]        |
      | devices               | index:10                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: HTML                                                                   |
    Then UI Delete Forensics With Name "Threat Category12 Equal"

  @SID_14
  Scenario: create new Threat Category13 Equal
    Given UI "Create" Forensics With Name "Threat Category13 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Event Description,Action,Attack Name,Device Host Name                                                            |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Insecure Communication]                                    |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI "Validate" Forensics With Name "Threat Category13 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Event Description,Action,Attack Name,Device Host Name                                                            |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Insecure Communication]                                    |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Threat Category13 Equal"

  @SID_15
  Scenario: create new Threat Category14 Equal
    Given UI "Create" Forensics With Name "Threat Category14 Equal"
      | Product               | AppWall                                                                        |
      | Output                | Device IP,Source IP,Destination IP Address,Cluster Manager IP                  |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Session Management]      |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI "Validate" Forensics With Name "Threat Category14 Equal"
      | Product               | AppWall                                                                        |
      | Output                | Device IP,Source IP,Destination IP Address,Cluster Manager IP                  |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Session Management]      |
      | devices               | All                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                    |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Threat Category14 Equal"

  @SID_16
  Scenario: create new Threat Category15 Equal
    Given UI "Create" Forensics With Name "Threat Category15 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Date and Time,Source Port                                                                                        |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[File Upload Violation]                                     |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI "Validate" Forensics With Name "Threat Category15 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Date and Time,Source Port                                                                                        |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[File Upload Violation]                                     |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                               |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                     |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Threat Category15 Equal"

  @SID_17
  Scenario: create new Threat Category16 Equal
    Given UI "Create" Forensics With Name "Threat Category16 Equal"
      | Product               | AppWall                                                                                                                                              |
      | Output                | Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Injection]                                                                                     |
      | devices               | index:10                                                                                                                                             |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                       |
      | Format                | Select: HTML                                                                                                                                         |
    Then UI "Validate" Forensics With Name "Threat Category16 Equal"
      | Product               | AppWall                                                                                                                                              |
      | Output                | Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Injection]                                                                                     |
      | devices               | index:10                                                                                                                                             |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                     |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAY]                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                       |
      | Format                | Select: HTML                                                                                                                                         |
    Then UI Delete Forensics With Name "Threat Category16 Equal"

  @SID_18
  Scenario: create new Threat Category17 Equal
    Given UI "Create" Forensics With Name "Threat Category17 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Action,Threat Category                                                                                           |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Evasion]                                                   |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI "Validate" Forensics With Name "Threat Category17 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Action,Threat Category                                                                                           |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Evasion]                                                   |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Relative:[Months,2]                                                                                              |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV                                                                                                      |
    Then UI Delete Forensics With Name "Threat Category17 Equal"

  @SID_19
  Scenario: create new Threat Category18 Equal
    Given UI "Create" Forensics With Name "Threat Category18 Equal"
      | Product               | AppWall                                                                                                                       |
      | Output                | Web Application Name,Event Description,Attack Name,Device Host Name,Directory,Module,Severity,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Input Validation]                                                       |
      | devices               | All                                                                                                                           |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                |
      | Format                | Select: CSV                                                                                                                   |
    Then UI "Validate" Forensics With Name "Threat Category18 Equal"
      | Product               | AppWall                                                                                                                       |
      | Output                | Web Application Name,Event Description,Attack Name,Device Host Name,Directory,Module,Severity,Transaction ID,Tunnel,User Name |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Input Validation]                                                       |
      | devices               | All                                                                                                                           |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                |
      | Format                | Select: CSV                                                                                                                   |
    Then UI Delete Forensics With Name "Threat Category18 Equal"

  @SID_20
  Scenario: create new Threat Category19 Equal
    Given UI "Create" Forensics With Name "Threat Category19 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Action,Threat Category                                  |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Logical Attacks]                                           |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI "Validate" Forensics With Name "Threat Category19 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Action,Threat Category                                  |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Logical Attacks]                                           |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                 |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[APR]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Threat Category19 Equal"

  @SID_21
  Scenario: create new Threat Category20 Equal
    Given UI "Create" Forensics With Name "Threat Category20 Equal"
      | Product               | AppWall                                                                                                    |
      | Output                | Date and Time,Device IP,Source Port,Web Application Name,Action,Attack Name,Threat Category,Transaction ID |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Brute Force]                                         |
      | devices               | index:10                                                                                                   |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                             |
      | Format                | Select: HTML                                                                                               |
    Then UI "Validate" Forensics With Name "Threat Category20 Equal"
      | Product               | AppWall                                                                                                    |
      | Output                | Date and Time,Device IP,Source Port,Web Application Name,Action,Attack Name,Threat Category,Transaction ID |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Brute Force]                                         |
      | devices               | index:10                                                                                                   |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                         |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                             |
      | Format                | Select: HTML                                                                                               |
    Then UI Delete Forensics With Name "Threat Category20 Equal"

  @SID_22
  Scenario: create new Threat Category21 Equal
    Given UI "Create" Forensics With Name "Threat Category21 Equal"
      | Product               | AppWall                                                                                                                           |
      | Output                | Source IP,Destination IP Address,Cluster Manager IP,Event Description,Device Host Name,Directory,Module,Severity,Tunnel,User Name |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Cross Site Scripting]                                                       |
      | devices               | All                                                                                                                               |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                       |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                  |
      | Format                | Select: CSV                                                                                                                       |
    Then UI "Validate" Forensics With Name "Threat Category21 Equal"
      | Product               | AppWall                                                                                                                           |
      | Output                | Source IP,Destination IP Address,Cluster Manager IP,Event Description,Device Host Name,Directory,Module,Severity,Tunnel,User Name |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Cross Site Scripting]                                                       |
      | devices               | All                                                                                                                               |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                                       |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                  |
      | Format                | Select: CSV                                                                                                                       |
    Then UI Delete Forensics With Name "Threat Category21 Equal"

  @SID_23
  Scenario: create new Threat Category22 Equal
    Given UI "Create" Forensics With Name "Threat Category22 Equal"
      | Product               | AppWall                                                                        |
      | Output                | Cluster Manager IP,Attack Name                                                 |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Access Control]          |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1Y                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI "Validate" Forensics With Name "Threat Category22 Equal"
      | Product               | AppWall                                                                        |
      | Output                | Cluster Manager IP,Attack Name                                                 |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Access Control]          |
      | devices               | All                                                                            |
      | Time Definitions.Date | Quick:1Y                                                                       |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format                | Select: CSV                                                                    |
    Then UI Delete Forensics With Name "Threat Category22 Equal"

  @SID_24
  Scenario: create new Threat Category23 Equal
    Given UI "Create" Forensics With Name "Threat Category23 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Source IP                                                                                                        |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Request Format Violation]                                  |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:This Month                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI "Validate" Forensics With Name "Threat Category23 Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Source IP                                                                                                        |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Request Format Violation]                                  |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:This Month                                                                                                 |
      | Schedule              | Run Every:Once, On Time:+6H                                                                                      |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Threat Category23 Equal"

  @SID_25
  Scenario: create new Threat Category24 Equal
    Given UI "Create" Forensics With Name "Threat Category24 Equal"
      | Product               | AppWall                                                                                         |
      | Output                | Destination IP Address,Cluster Manager IP,Event Description,Device Host Name,Severity,User Name |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Intrusion]                                |
      | devices               | index:10                                                                                        |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |
      | Format                | Select: HTML                                                                                    |
    Then UI "Validate" Forensics With Name "Threat Category24 Equal"
      | Product               | AppWall                                                                                         |
      | Output                | Destination IP Address,Cluster Manager IP,Event Description,Device Host Name,Severity,User Name |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Intrusion]                                |
      | devices               | index:10                                                                                        |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                  |
      | Format                | Select: HTML                                                                                    |
    Then UI Delete Forensics With Name "Threat Category24 Equal"

  @SID_26
  Scenario: create new Threat Category25 Equal
    Given UI "Create" Forensics With Name "Threat Category25 Equal"
      | Product               | AppWall                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
      | Output                | Date and Time                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Dos,Information Leakage,Automation,Path Traversal,Response Format Violation,XML & Web Services Violation,Cross site Request Forgery (CSRF),Remote File Inclusion,Authentication & Authorization,Hot Link,Misconfiguration,Insecure Communication,Session Management,File Upload Violation,Injection,Evasion,Input Validation,Logical Attacks,Brute Force,Cross Site Scripting,Access Control,Request Format Violation,Intrusion] |
      | devices               | All                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                                                                                                                                                                                                                                                                                                                                                                                           |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                                                                                                                                                                                                       |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
    Then UI "Validate" Forensics With Name "Threat Category25 Equal"
      | Product               | AppWall                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
      | Output                | Date and Time                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Dos,Information Leakage,Automation,Path Traversal,Response Format Violation,XML & Web Services Violation,Cross site Request Forgery (CSRF),Remote File Inclusion,Authentication & Authorization,Hot Link,Misconfiguration,Insecure Communication,Session Management,File Upload Violation,Injection,Evasion,Input Validation,Logical Attacks,Brute Force,Cross Site Scripting,Access Control,Request Format Violation,Intrusion] |
      | devices               | All                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | Time Definitions.Date | Relative:[Hours,2]                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[WED]                                                                                                                                                                                                                                                                                                                                                                                                                                           |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                                                                                                                                                                                                                                                                       |
      | Format                | Select: CSV                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
    Then UI Delete Forensics With Name "Threat Category25 Equal"

  @SID_27
  Scenario: create new Threat Category26 Not Equal
    Given UI "Create" Forensics With Name "Threat Category26 Not Equal"
      | Product               | AppWall                                                                                                                                                                    |
      | Output                | Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Dos,Information Leakage]                                                                                         |
      | devices               | All                                                                                                                                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                             |
      | Format                | Select: CSV                                                                                                                                                                |
    Then UI "Validate" Forensics With Name "Threat Category26 Not Equal"
      | Product               | AppWall                                                                                                                                                                    |
      | Output                | Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Dos,Information Leakage]                                                                                         |
      | devices               | All                                                                                                                                                                        |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                             |
      | Format                | Select: CSV                                                                                                                                                                |
    Then UI Delete Forensics With Name "Threat Category26 Not Equal"

  @SID_28
  Scenario: create new Threat Category27 Not Equal
    Given UI "Create" Forensics With Name "Threat Category27 Not Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Date and Time,Device IP,Source IP,Transaction ID,Tunnel                                                          |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Path Traversal,Response Format Violation]              |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI "Validate" Forensics With Name "Threat Category27 Not Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Date and Time,Device IP,Source IP,Transaction ID,Tunnel                                                          |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Path Traversal,Response Format Violation]              |
      | devices               | All                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[AUG]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Threat Category27 Not Equal"

  @SID_29
  Scenario: create new Threat Category28 Not Equal
    Given UI "Create" Forensics With Name "Threat Category28 Not Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Dos,Information Leakage,Automation,Path Traversal,Response Format Violation,XML & Web Services Violation,Cross site Request Forgery (CSRF)]                                         |
      | devices               | index:10                                                                                                                                                                                                                                      |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                |
      | Format                | Select: HTML                                                                                                                                                                                                                                  |
    Then UI "Validate" Forensics With Name "Threat Category28 Not Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Dos,Information Leakage,Automation,Path Traversal,Response Format Violation,XML & Web Services Violation,Cross site Request Forgery (CSRF)]                                         |
      | devices               | index:10                                                                                                                                                                                                                                      |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                |
      | Format                | Select: HTML                                                                                                                                                                                                                                  |
    Then UI Delete Forensics With Name "Threat Category28 Not Equal"

  @SID_30
  Scenario: create new Threat Category29 Not Equal
    Given UI "Create" Forensics With Name "Threat Category29 Not Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Remote File Inclusion]                                                                                                                                                              |
      | devices               | All                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                   |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                              |
      | Format                | Select: CSV                                                                                                                                                                                                                                   |
    Then UI "Validate" Forensics With Name "Threat Category29 Not Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Remote File Inclusion]                                                                                                                                                              |
      | devices               | All                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                            |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                   |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                              |
      | Format                | Select: CSV                                                                                                                                                                                                                                   |
    Then UI Delete Forensics With Name "Threat Category29 Not Equal"

  @SID_31
  Scenario: create new Threat Category30 Not Equal
    Given UI "Create" Forensics With Name "Threat Category30 Not Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Remote File Inclusion,Authentication & Authorization,Hot Link,Misconfiguration,Insecure Communication]                                                                              |
      | devices               | All                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                |
      | Format                | Select: CSV                                                                                                                                                                                                                                   |
    Then UI "Validate" Forensics With Name "Threat Category30 Not Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Remote File Inclusion,Authentication & Authorization,Hot Link,Misconfiguration,Insecure Communication]                                                                              |
      | devices               | All                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                              |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                |
      | Format                | Select: CSV                                                                                                                                                                                                                                   |
    Then UI Delete Forensics With Name "Threat Category30 Not Equal"

  @SID_32
  Scenario: create new Threat Category31 Not Equal
    Given UI "Create" Forensics With Name "Threat Category31 Not Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Session Management,File Upload Violation,Injection,Evasion,Input Validation,Logical Attacks,Brute Force,Cross Site Scripting,Access Control,Request Format Violation,Intrusion]     |
      | devices               | All                                                                                                                                                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                                                                                                                               |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                              |
      | Format                | Select: CSV With Attack Details                                                                                                                                                                                                               |
    Then UI "Validate" Forensics With Name "Threat Category31 Not Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Session Management,File Upload Violation,Injection,Evasion,Input Validation,Logical Attacks,Brute Force,Cross Site Scripting,Access Control,Request Format Violation,Intrusion]     |
      | devices               | All                                                                                                                                                                                                                                           |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                                                                                                                                               |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                              |
      | Format                | Select: CSV With Attack Details                                                                                                                                                                                                               |
    Then UI Delete Forensics With Name "Threat Category31 Not Equal"

  @SID_33
  Scenario: create new Threat Category32 Not Equal
    Given UI "Create" Forensics With Name "Threat Category32 Not Equal"
      | Product               | AppWall                                                                                                                                               |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Action,Threat Category                                                                       |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Hot Link,Misconfiguration,Insecure Communication,Session Management,File Upload Violation]  |
      | devices               | index:10                                                                                                                                              |
      | Time Definitions.Date | Quick:This Month                                                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                        |
      | Format                | Select: HTML                                                                                                                                          |
    Then UI "Validate" Forensics With Name "Threat Category32 Not Equal"
      | Product               | AppWall                                                                                                                                               |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Action,Threat Category                                                                       |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Hot Link,Misconfiguration,Insecure Communication,Session Management,File Upload Violation]  |
      | devices               | index:10                                                                                                                                              |
      | Time Definitions.Date | Quick:This Month                                                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                        |
      | Format                | Select: HTML                                                                                                                                          |
    Then UI Delete Forensics With Name "Threat Category32 Not Equal"

  @SID_34
  Scenario: create new Threat Category33 Not Equal
    Given UI "Create" Forensics With Name "Threat Category33 Not Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Date and Time,Device IP,Source Port,Web Application Name,Action,Attack Name,Threat Category,Transaction ID       |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Injection,Evasion,Input Validation]                    |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:3M                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI "Validate" Forensics With Name "Threat Category33 Not Equal"
      | Product               | AppWall                                                                                                          |
      | Output                | Date and Time,Device IP,Source Port,Web Application Name,Action,Attack Name,Threat Category,Transaction ID       |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Injection,Evasion,Input Validation]                    |
      | devices               | All                                                                                                              |
      | Time Definitions.Date | Quick:3M                                                                                                         |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[DEC]                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware |
      | Format                | Select: CSV With Attack Details                                                                                  |
    Then UI Delete Forensics With Name "Threat Category33 Not Equal"

  @SID_35
  Scenario: create new Threat Category34 Not Equal
    Given UI "Create" Forensics With Name "Threat Category34 Not Equal"
      | Product               | AppWall                                                                                                                           |
      | Output                | Source IP,Destination IP Address,Cluster Manager IP,Event Description,Device Host Name,Directory,Module,Severity,Tunnel,User Name |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Logical Attacks,Brute Force]                                            |
      | devices               | index:10                                                                                                                          |
      | Time Definitions.Date | Quick:This Month                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                    |
      | Format                | Select: HTML                                                                                                                      |
    Then UI "Validate" Forensics With Name "Threat Category34 Not Equal"
      | Product               | AppWall                                                                                                                           |
      | Output                | Source IP,Destination IP Address,Cluster Manager IP,Event Description,Device Host Name,Directory,Module,Severity,Tunnel,User Name |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Logical Attacks,Brute Force]                                            |
      | devices               | index:10                                                                                                                          |
      | Time Definitions.Date | Quick:This Month                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                    |
      | Format                | Select: HTML                                                                                                                      |
    Then UI Delete Forensics With Name "Threat Category34 Not Equal"

  @SID_36
  Scenario: create new Threat Category35 Not Equal
    Given UI "Create" Forensics With Name "Threat Category35 Not Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Cross Site Scripting,Access Control,Request Format Violation]                                                                                                                       |
      | devices               | index:10                                                                                                                                                                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                |
      | Format                | Select: HTML                                                                                                                                                                                                                                  |
    Then UI "Validate" Forensics With Name "Threat Category35 Not Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Threat Category,Operator:Not Equals,Value:[Cross Site Scripting,Access Control,Request Format Violation]                                                                                                                       |
      | devices               | index:10                                                                                                                                                                                                                                      |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[MAR]                                                                                                                                                                                               |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                |
      | Format                | Select: HTML                                                                                                                                                                                                                                  |
    Then UI Delete Forensics With Name "Threat Category35 Not Equal"

  @SID_37
  Scenario: create new Threat Category36 Equal
    Given UI "Create" Forensics With Name "Threat Category36t Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Cross Site Scripting,Access Control,Request Format Violation]                                                                                                                           |
      | devices               | All                                                                                                                                                                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                |
      | Format                | Select: CSV                                                                                                                                                                                                                                   |
    Then UI "Validate" Forensics With Name "Threat Category36t Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Cross Site Scripting,Access Control,Request Format Violation]                                                                                                                           |
      | devices               | All                                                                                                                                                                                                                                           |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                |
      | Format                | Select: CSV                                                                                                                                                                                                                                   |
    Then UI Delete Forensics With Name "Threat Category36t Equal"

  @SID_38
  Scenario: create new Tunnel Equal
    Given UI "Create" Forensics With Name "Tunnel Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Tunnel,Operator:Equals,Value:Name                                                                                                                                                                                            |
      | devices               | All                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                                                                                                                                               |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                              |
      | Format                | Select: CSV With Attack Details                                                                                                                                                                                                               |
    Then UI "Validate" Forensics With Name "Tunnel Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Tunnel,Operator:Equals,Value:Name                                                                                                                                                                                            |
      | devices               | All                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                              |
      | Schedule              | Run Every:Monthly, On Time:+6H, At Months:[OCT]                                                                                                                                                                                               |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                              |
      | Format                | Select: CSV With Attack Details                                                                                                                                                                                                               |
    Then UI Delete Forensics With Name "Tunnel Equal"

  @SID_39
  Scenario: create new Tunnel Not Equal
    Given UI "Create" Forensics With Name "Tunnel Not Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Tunnel,Operator:Not Equals,Value:Name                                                                                                                                                                                          |
      | devices               | index:10                                                                                                                                                                                                                                      |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                                                                                                                                             |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                |
      | Format                | Select: HTML                                                                                                                                                                                                                                  |
    Then UI "Validate" Forensics With Name "Tunnel Not Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Tunnel,Operator:Not Equals,Value:Name                                                                                                                                                                                          |
      | devices               | index:10                                                                                                                                                                                                                                      |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                                                                                                                                             |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[SUN]                                                                                                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                |
      | Format                | Select: HTML                                                                                                                                                                                                                                  |
    Then UI Delete Forensics With Name "Tunnel Not Equal"

  @SID_40
  Scenario: create new User Name Equal
    Given UI "Create" Forensics With Name "User Name Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:User Name,Operator:Equals,Value:Name                                                                                                                                                                                           |
      | devices               | All                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                                                                                                                                           |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                              |
      | Format                | Select: CSV                                                                                                                                                                                                                                   |
    Then UI "Validate" Forensics With Name "User Name Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:User Name,Operator:Equals,Value:Name                                                                                                                                                                                           |
      | devices               | All                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Relative:[Months,2]                                                                                                                                                                                                                           |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                              |
      | Format                | Select: CSV                                                                                                                                                                                                                                   |
    Then UI Delete Forensics With Name "User Name Equal"

  @SID_41
  Scenario: create new User Name Not Equal
    Given UI "Create" Forensics With Name "User Name Not Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:User Name,Operator:Not Equals,Value:Name                                                                                                                                                                                       |
      | devices               | All                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Quick:1D                                                                                                                                                                                                                                      |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                                                                                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                |
      | Format                | Select: CSV                                                                                                                                                                                                                                   |
    Then UI "Validate" Forensics With Name "User Name Not Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:User Name,Operator:Not Equals,Value:Name                                                                                                                                                                                       |
      | devices               | All                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Quick:1D                                                                                                                                                                                                                                      |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[FRI]                                                                                                                                                                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                |
      | Format                | Select: CSV                                                                                                                                                                                                                                   |
    Then UI Delete Forensics With Name "User Name Not Equal"

  @SID_42
  Scenario: create new Web Application Name Equal
    Given UI "Create" Forensics With Name "Web Application Name Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Web Application Name,Operator:Equals,Value:Name                                                                                                                                                                                |
      | devices               | All                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                              |
      | Schedule              | Run Every:once, On Time:+6H                                                                                                                                                                                                                   |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                              |
      | Format                | Select: CSV With Attack Details                                                                                                                                                                                                               |
    Then UI "Validate" Forensics With Name "Web Application Name Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Web Application Name,Operator:Equals,Value:Name                                                                                                                                                                                |
      | devices               | All                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00, +0d]                                                                                                                                                                                                              |
      | Schedule              | Run Every:once, On Time:+6H                                                                                                                                                                                                                   |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                              |
      | Format                | Select: CSV With Attack Details                                                                                                                                                                                                               |
    Then UI Delete Forensics With Name "Web Application Name Equal"

  @SID_43
  Scenario: create new Web Application Name Not Equal
    Given UI "Create" Forensics With Name "Web Application Name Not Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Web Application Name,Operator:Not Equals,Value:Name                                                                                                                                                                            |
      | devices               | index:10                                                                                                                                                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                |
      | Format                | Select: HTML                                                                                                                                                                                                                                  |
    Then UI "Validate" Forensics With Name "Web Application Name Not Equal"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Web Application Name,Operator:Not Equals,Value:Name                                                                                                                                                                            |
      | devices               | index:10                                                                                                                                                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                |
      | Format                | Select: HTML                                                                                                                                                                                                                                  |
    Then UI Delete Forensics With Name "Web Application Name Not Equal"

  @SID_44
  Scenario: create new Custom Conditions1
    Given UI "Create" Forensics With Name "Custom Conditions1"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Session Management];Event Criteria:Module,Operator:Equals,Value:Name,condition.Custom:1 AND 2                                                                                           |
      | devices               | All                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                                                                                                                                             |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                   |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                              |
      | Format                | Select: CSV                                                                                                                                                                                                                                   |
    Then UI "Validate" Forensics With Name "Custom Conditions1"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Threat Category,Operator:Equals,Value:[Session Management];Event Criteria:Module,Operator:Equals,Value:Name,condition.Custom:1 AND 2                                                                                           |
      | devices               | All                                                                                                                                                                                                                                           |
      | Time Definitions.Date | Relative:[Days,2]                                                                                                                                                                                                                             |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                   |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                              |
      | Format                | Select: CSV                                                                                                                                                                                                                                   |
    Then UI Delete Forensics With Name "Custom Conditions1"

  @SID_45
  Scenario: create new Custom Conditions2
    Given UI "Create" Forensics With Name "Custom Conditions2"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Severity,Operator:Equals,Value:[error];Event Criteria:Source Port,Operator:Equals,portType:Single,portValue:1024,condition.Custom:1 OR 2                                                                                       |
      | devices               | All                                                                                                                                                                                                                                           |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                |
      | Format                | Select: CSV                                                                                                                                                                                                                                   |
    Then UI "Validate" Forensics With Name "Custom Conditions2"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Severity,Operator:Equals,Value:[error];Event Criteria:Source Port,Operator:Equals,portType:Single,portValue:1024,condition.Custom:1 OR 2                                                                                       |
      | devices               | All                                                                                                                                                                                                                                           |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                                                                                                                   |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                                                                                                                |
      | Format                | Select: CSV                                                                                                                                                                                                                                   |
    Then UI Delete Forensics With Name "Custom Conditions2"

  @SID_46
  Scenario: create new Custom Conditions3
    Given UI "Create" Forensics With Name "Custom Conditions3"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:[Modified,Blocked,Reported];Event Criteria:Severity,Operator:Equals,Value:[alert];Event Criteria:User Name,Operator:Equals,Value:Name,condition.Custom:1 AND 2 OR 3                               |
      | devices               | index:10                                                                                                                                                                                                                                      |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                                                                                                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                              |
      | Format                | Select: CSV With Attack Details                                                                                                                                                                                                               |
    Then UI "Validate" Forensics With Name "Custom Conditions3"
      | Product               | AppWall                                                                                                                                                                                                                                       |
      | Output                | Date and Time,Device IP,Source IP,Destination IP Address,Source Port,Cluster Manager IP,Web Application Name,Event Description,Action,Attack Name,Device Host Name,Directory,Module,Severity,Threat Category,Transaction ID,Tunnel,User Name  |
      | Criteria              | Event Criteria:Action,Operator:Equals,Value:[Modified,Blocked,Reported];Event Criteria:Severity,Operator:Equals,Value:[alert];Event Criteria:User Name,Operator:Equals,Value:Name,condition.Custom:1 AND 2 OR 3                               |
      | devices               | index:10                                                                                                                                                                                                                                      |
      | Time Definitions.Date | Relative:[Weeks,2]                                                                                                                                                                                                                            |
      | Schedule              | Run Every:Weekly, On Time:+6H, At Days:[THU]                                                                                                                                                                                                  |
      | Share                 | FTP:checked, FTP.Location:172.17.164.10, FTP.Path:/home/radware/ftp/, FTP.Username:radware, FTP.Password:radware                                                                                                                              |
      | Format                | Select: CSV With Attack Details                                                                                                                                                                                                               |
    Then UI Delete Forensics With Name "Custom Conditions3"

  @SID_47
  Scenario: Logout
    Then UI logout and close browser




























































































































































































