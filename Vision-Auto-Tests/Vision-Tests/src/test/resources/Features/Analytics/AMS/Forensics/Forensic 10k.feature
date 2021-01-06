@TC108090
Feature: Forensics 10K

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"
#    * REST Delete ES index "forensics-*"
#    * REST Delete ES index "dpforensics-*"
    * CLI Clear vision logs
    Then CLI Run remote linux Command "rm -f /opt/radware/storage/forensics/*" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/storage/largecsv/*" on "ROOT_SERVER_CLI"

  @SID_2
  Scenario: unpack attacks import tool
    When CLI Run remote linux Command "tar -xzf /opt/radware/mgt-server/avrmigrate/avr_migration.tar.gz -C /opt/radware/storage/" on "ROOT_SERVER_CLI"

  @SID_3
  Scenario: edit import attack tool configuration and clean its history
    When CLI Run remote linux Command "sed -i 's/input_dir:.*$/input_dir: \"\/opt\/radware\/storage\/largecsv\/\"/g' /opt/radware/storage/dist/configuration.yaml" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "sed -i 's/bulk_indexing_chunk_size:.*$/bulk_indexing_chunk_size: 5000/g' /opt/radware/storage/dist/configuration.yaml" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "sed -i 's/doc_type:.*$/doc_type: \"Intrusions\"/g' /opt/radware/storage/dist/configuration.yaml" on "ROOT_SERVER_CLI"
#    Then CLI Run remote linux Command "sed -i 's/\"ormId\": {\"type\": \"keyword\"}/\"ormId\": {\"type\": \"long\"}/g' /opt/radware/storage/dist/configuration.yaml" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/storage/dist/history/*" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mkdir /opt/radware/storage/largecsv" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario: import csv file with 25000 records
    When CLI copy "/home/radware/Scripts/defensepro_attack_data_20180326.csv.gz" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage/largecsv/"

  @SID_5
  Scenario: run the attack import tool
    Then CLI Run remote linux Command "cd /opt/radware/storage/dist/; ./elastic_import" on "ROOT_SERVER_CLI" with timeOut 240

  @SID_6
  Scenario: Login and navigate to forensic page
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
#    And UI Open Upper Bar Item "AMS"
#    And UI Open "Forensics" Tab
    And UI Navigate to "AMS Forensics" page via homePage

  @SID_7
  Scenario: create forensic definition
    When UI "Create" Forensics With Name "Forensic_10K"
      | Time Definitions.Date | Absolute:[27.02.2017 01:00:00, +0d] |

  @SID_8
  Scenario: generate forensic report
    Then UI Generate and Validate Forensics With Name "Forensic_10K" with Timeout of 300 Seconds
    Then Sleep "30"

  @SID_9
  Scenario: validate number of records in forensic table
    And UI Click Button "Views.report" with value "Forensic_10K"
    Then Sleep "15"
    * UI Validate "Report.Table" Table rows count EQUALS to 10000

  @SID_10
  Scenario: validate existence of "export" button
    When UI Validate Element Existence By Label "Generate Full Snapshot" if Exists "true" with value "Generate Full Snapshot"

  @SID_11
  Scenario: Generate full Snapshot
    When UI Click Button "Generate Full Snapshot" with value "Generate Full Snapshot"
    Then Sleep "120"

  @SID_12
  Scenario: validate existence of "download" button
    When UI Validate Element Existence By Label "Download Snapshot" if Exists "true"
    
  @SID_13
  Scenario: unzip and validate number of lines in generated csv file
    Then CLI Run remote linux Command "unzip -d /opt/radware/storage/forensics/ /opt/radware/storage/forensics/Forensic_10K_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run linux Command "wc -l < /opt/radware/storage/forensics/Forensic_10K_*.csv" on "ROOT_SERVER_CLI" and validate result EQUALS "25001"
