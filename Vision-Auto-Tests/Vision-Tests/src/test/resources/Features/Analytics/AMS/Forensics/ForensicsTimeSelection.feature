@TC106005

Feature: Forensic Time Selection

  
  @SID_1
  Scenario: Clean DB and generate attacks
    When CLI kill all simulator attacks on current vision
    Given REST Delete ES index "dp-attack*"
    Given REST Delete ES index "dp-sampl*"
    Given REST Delete ES index "dp-packet*"
    When CLI Clear vision logs
    And CLI simulate 1 attacks of type "rest_dos" on SetId "DefensePro_Set_1"
    And CLI simulate 1 attacks of type "rest_anomalies" on SetId "DefensePro_Set_1" and wait 22 seconds

  
  @SID_2
  Scenario: Login and go to forensics
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "AMS Forensics" page via homepage

   ######################   QUICK ONE DAY   #######################################################

  @SID_3
  Scenario: Forensic Time Quick Range One Day
   # move Anomalies start time 23.20 hrs backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-85800000'"}}'" on "ROOT_SERVER_CLI"
    Then UI "Create" Forensics With Name "Forensic Time"
      | Output                | Attack ID,Start Time |
      | Time Definitions.Date | Quick:1D             |
    Then UI Click Button "My Forensics" with value "Forensic Time"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensic Time"
    Then Sleep "35"
    Then UI Click Button "Views.Forensic" with value "Forensic Time,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "4-1402580209"
      | columnName | value        |
      | Attack ID  | 4-1402580209 |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "7706-1402580209"
      | columnName | value           |
      | Attack ID  | 7706-1402580209 |
       # move Anomalies start time back to original
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime+85800000'"}}'" on "ROOT_SERVER_CLI"


    Then UI Delete Forensics With Name "Forensic Time"
    Then UI Navigate to "AMS Reports" page via homePage
    Then UI Navigate to "AMS Forensics" page via homepage

   ######################   RELATIVE HOURS   #####################################################

  @SID_4
  Scenario: Forensic Time Relative Hours
   # move Anomalies start time 23.20 hrs backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-85800000'"}}'" on "ROOT_SERVER_CLI"
    Then UI "Create" Forensics With Name "Forensic Time"
      | Output                | Attack ID,Start Time |
      | Time Definitions.Date | Relative:[Hours,24]  |
    Then UI Click Button "My Forensics" with value "Forensic Time"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensic Time"
    Then Sleep "35"
    Then UI Click Button "Views.Forensic" with value "Forensic Time,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "4-1402580209"
      | columnName | value        |
      | Attack ID  | 4-1402580209 |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "7706-1402580209"
      | columnName | value           |
      | Attack ID  | 7706-1402580209 |
          # move Anomalies start time back to original
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime+85800000'"}}'" on "ROOT_SERVER_CLI"

    Then UI Delete Forensics With Name "Forensic Time"



   ######################   QUICK YESTERDAY   ####################################################

  @SID_5
  Scenario: Forensic Time Quick Range Yesterday
    # move the attack 25 hrs backwards
    When CLI Run remote linux Command "curl -XPOST "localhost:9200/dp-attack-raw-*/_update_by_query/?pretty&conflicts=proceed" -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-90000000'"}}'" on "ROOT_SERVER_CLI"
    Then UI "Create" Forensics With Name "Forensic Time"
      | Output                | Attack ID,Start Time |
      | Time Definitions.Date | Quick:Yesterday      |
    Then UI Click Button "My Forensics" with value "Forensic Time"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensic Time"
    Then Sleep "35"
    Then UI Click Button "Views.Forensic" with value "Forensic Time,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 1
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "4-1402580209"
      | columnName | value        |
      | Attack ID  | 4-1402580209 |
    Then CLI Run remote linux Command "curl -X POST localhost:9200/dp-attack-raw-*/_search -d '{"query":{"bool":{"must":[{"match_all":{}}]}},"from":0,"size":10}' > /opt/radware/storage/maintenance/yesterday.log" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "echo $(date) >> /opt/radware/storage/maintenance/yesterday.log" on "ROOT_SERVER_CLI"
     # move the attack 25 hrs fwd
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime+90000000'"}}'" on "ROOT_SERVER_CLI"
    Then UI Delete Forensics With Name "Forensic Time"


   ######################   QUICK ONE WEEK   ###################################################

  @SID_6
  Scenario: Forensic Time Quick Range One Week
   # move start time 6 days and 23.5 Hrs back
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-603000000'"}}'" on "ROOT_SERVER_CLI"
    Then UI "Create" Forensics With Name "Forensic Time"
      | Output                | Attack ID,Start Time |
      | Time Definitions.Date | Quick:1W             |
    Then UI Click Button "My Forensics" with value "Forensic Time"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensic Time"
    Then Sleep "35"
    Then UI Click Button "Views.Forensic" with value "Forensic Time,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "4-1402580209"
      | columnName | value        |
      | Attack ID  | 4-1402580209 |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "7706-1402580209"
      | columnName | value           |
      | Attack ID  | 7706-1402580209 |
      # move start time 6 days and 23.5 Hrs fwd
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime+603000000'"}}'" on "ROOT_SERVER_CLI"
    Then UI Delete Forensics With Name "Forensic Time"


   ######################   RELATIVE DAYS   ####################################################

  @SID_7
  Scenario: Forensic Time Relative Days
  # move start time 6 days and 23.5 Hrs back
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-603000000'"}}'" on "ROOT_SERVER_CLI"
    Then UI "Create" Forensics With Name "Forensic Time"
      | Output                | Attack ID,Start Time |
      | Time Definitions.Date | Relative:[Days,7]    |
    Then UI Click Button "My Forensics" with value "Forensic Time"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensic Time"
    Then Sleep "35"
    Then UI Click Button "Views.Forensic" with value "Forensic Time,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "4-1402580209"
      | columnName | value        |
      | Attack ID  | 4-1402580209 |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "7706-1402580209"
      | columnName | value           |
      | Attack ID  | 7706-1402580209 |
          # move start time 6 days and 23.5 Hrs fwd
    Then CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime+603000000'"}}'" on "ROOT_SERVER_CLI"
    Then UI Delete Forensics With Name "Forensic Time"


   ######################   QUICK ONE MONTH   #################################################
  
  @SID_8
  Scenario: Forensic Time Quick Range One Month
    # move start time 28 days and 23.5 hrs back
#    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-2503800000L'"}}'" on "ROOT_SERVER_CLI"
    Then UI "Create" Forensics With Name "Forensic Time"
      | Output                | Attack ID,Start Time |
      | Time Definitions.Date | Quick:1M             |
    Then UI Click Button "My Forensics" with value "Forensic Time"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensic Time"
    Then Sleep "35"
    Then UI Click Button "Views.Forensic" with value "Forensic Time,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "4-1402580209"
      | columnName | value        |
      | Attack ID  | 4-1402580209 |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "7706-1402580209"
      | columnName | value           |
      | Attack ID  | 7706-1402580209 |
       # move start time 28 days and 23.5 hrs fwd
    Then CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime+2503800000L'"}}'" on "ROOT_SERVER_CLI"
    Then UI Delete Forensics With Name "Forensic Time"


   ######################   RELATIVE WEEKS   #################################################


  @SID_9
  Scenario: Forensic Time Relative Weeks
        # move start time 28 days and 23.5 hrs back
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-2503800000L'"}}'" on "ROOT_SERVER_CLI"
    Then UI "Create" Forensics With Name "Forensic Time"
      | Output                | Attack ID,Start Time |
      | Time Definitions.Date | Relative:[Weeks,5]   |
    Then UI Click Button "My Forensics" with value "Forensic Time"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensic Time"
    Then Sleep "35"
    Then UI Click Button "Views.Forensic" with value "Forensic Time,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "4-1402580209"
      | columnName | value        |
      | Attack ID  | 4-1402580209 |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "7706-1402580209"
      | columnName | value           |
      | Attack ID  | 7706-1402580209 |
        # move start time 28 days and 23.5 hrs fwd
    Then CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime+2503800000L'"}}'" on "ROOT_SERVER_CLI"
    Then UI Delete Forensics With Name "Forensic Time"


   ######################   QUICK THREE MONTHS   ###########################################

  @SID_10
  Scenario: Forensic Time Quick Range Three Months
    # move start time 88 days and 23.5 hrs back
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-7687800000L'"}}'" on "ROOT_SERVER_CLI"
    Then UI "Create" Forensics With Name "Forensic Time"
      | Output                | Attack ID,Start Time |
      | Time Definitions.Date | Quick:3M             |
    Then UI Click Button "My Forensics" with value "Forensic Time"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensic Time"
    Then Sleep "35"
    Then UI Click Button "Views.Forensic" with value "Forensic Time,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "4-1402580209"
      | columnName | value        |
      | Attack ID  | 4-1402580209 |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "7706-1402580209"
      | columnName | value           |
      | Attack ID  | 7706-1402580209 |
       # move start time 88 days and 23.5 hrs fwd
    Then CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime+7687800000L'"}}'" on "ROOT_SERVER_CLI"
    Then UI Delete Forensics With Name "Forensic Time"


   ######################   QUICK ONE YEAR   #############################################

  @SID_11
  Scenario: Forensic Time Quick Range One Year
    # move start time 11.5 months backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-31015800000L'"}}'" on "ROOT_SERVER_CLI"
    Then UI "Create" Forensics With Name "Forensic Time"
      | Output                | Attack ID,Start Time |
      | Time Definitions.Date | Quick:1Y             |
    Then UI Click Button "My Forensics" with value "Forensic Time"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensic Time"
    Then Sleep "35"
    Then UI Click Button "Views.Forensic" with value "Forensic Time,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "4-1402580209"
      | columnName | value        |
      | Attack ID  | 4-1402580209 |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "7706-1402580209"
      | columnName | value           |
      | Attack ID  | 7706-1402580209 |
        # move start time 11.5 months fwd
    Then CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime+31015800000L'"}}'" on "ROOT_SERVER_CLI"
    Then UI Delete Forensics With Name "Forensic Time"


   ######################   RELATIVE MONTHS   ###########################################

  @SID_12
  Scenario: Forensic Time Relative Months
   # move start time 11.5 months backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-31015800000L'"}}'" on "ROOT_SERVER_CLI"
    Then UI "Create" Forensics With Name "Forensic Time"
      | Output                | Attack ID,Start Time |
      | Time Definitions.Date | Relative:[Months,12] |
    Then UI Click Button "My Forensics" with value "Forensic Time"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensic Time"
    Then Sleep "35"
    Then UI Click Button "Views.Forensic" with value "Forensic Time,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "4-1402580209"
      | columnName | value        |
      | Attack ID  | 4-1402580209 |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "7706-1402580209"
      | columnName | value           |
      | Attack ID  | 7706-1402580209 |
       # move start time 11.5 months fwd
    Then CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime+31015800000L'"}}'" on "ROOT_SERVER_CLI"
    Then UI Delete Forensics With Name "Forensic Time"


   ######################   ABSOLUTE   ###################################################


  @SID_13
  Scenario: Forensic Time Absolute
    # move start time to 27/02/1971
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = '36504000000L'"}}'" on "ROOT_SERVER_CLI"
    When UI "Create" Forensics With Name "Forensic Time"
      | Output                | Attack ID                           |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d] |
    Then UI Click Button "My Forensics" with value "Forensic Time"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensic Time"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Forensic Time,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "7706-1402580209"
      | columnName | value           |
      | Attack ID  | 7706-1402580209 |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "4-1402580209"
      | columnName | value        |
      | Attack ID  | 4-1402580209 |
    Then UI Delete Forensics With Name "Forensic Time"


   ######################   QUICK TODAY   ########################################################


  @SID_14
  Scenario: Forensic Quick Range Today
  # move attacks start time to beginning of today
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime ='$(date -d "$today 0" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "7706-1402580209"}},"script": {"source": "ctx._source.startTime ='$(date -d "$today 0" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"
    When UI "Create" Forensics With Name "Forensic Time"
      | Output                | Attack ID,Start Time |
      | Time Definitions.Date | Quick:Today          |
    Then UI Click Button "My Forensics" with value "Forensic Time"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensic Time"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Forensic Time,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "7706-1402580209"
      | columnName | value           |
      | Attack ID  | 7706-1402580209 |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "4-1402580209"
      | columnName | value        |
      | Attack ID  | 4-1402580209 |
    Then UI Delete Forensics With Name "Forensic Time"


   ######################   QUICK THIS MONTH   ##################################################


  @SID_15
  Scenario: Forensic Time Quick Range This month
  # move Anomalies start time to beginning of month
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime ='$(date -d "`date +%Y%m01`" +%s%3N)L'"}}'" on "ROOT_SERVER_CLI"
    When UI "Create" Forensics With Name "Forensic Time"
      | Output                | Attack ID,Protocol |
      | Time Definitions.Date | Quick:This Month   |
    Then UI Click Button "My Forensics" with value "Forensic Time"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "Forensic Time"
    Then Sleep "35"
    And UI Click Button "Views.Forensic" with value "Forensic Time,0"
    Then UI Validate "Forensics.Table" Table rows count EQUALS to 2
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "7706-1402580209"
      | columnName | value           |
      | Attack ID  | 7706-1402580209 |
    Then UI Validate Table record values by columns with elementLabel "Forensics.Table" findBy columnName "Attack ID" findBy cellValue "4-1402580209"
      | columnName | value        |
      | Attack ID  | 4-1402580209 |
    Then UI Delete Forensics With Name "Forensic Time"


  @SID_16
  Scenario: Forensics Time cleanup

    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal        | NOT_EXPECTED |
    * UI logout and close browser
    * CLI kill all simulator attacks on current vision
