@TC118901

Feature: ADC System and Network Generate CSV Report
  @SID_1
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/storage/dc_config/kvision-reporter/config/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Service "config_kvision-collector_1" do action RESTART
    Then CLI Validate service "CONFIG_KVISION_COLLECTOR" is up with timeout "45" minutes

  @SID_2
  Scenario: old reports on file-system
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv" on "ROOT_SERVER_CLI"

  @SID_3
  Scenario: Login and Navigate ADC Report
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "ADC Reports" page via homePage

  @SID_4
  Scenario: Create and validate ADC Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "ADC System and Network Report"
      | Template              | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.154.215] |
      | Time Definitions.Date | Quick:1H                                                                                                 |
      | Format                | Select:  CSV                                                                                             |
    Then UI "Validate" Report With Name "ADC System and Network Report"
      | Template              | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_172.17.154.215] |
      | Time Definitions.Date | Quick:1H                                                                                                 |
      | Format                | Select: CSV                                                                                              |

  @SID_5
  Scenario: Validate delivery card and generate report
    Then UI "Generate" Report With Name "ADC System and Network Report"
      | timeOut | 60 |

  @SID_6
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_7
  Scenario: ADC Applications report validate CSV file Ports Traffic Information widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -1|tail -1|grep name,status|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_01"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "UP"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -3|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_02"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "UP"

#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -1|tail -1|grep name,status|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_01"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "UP"

#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -3|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_02"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "UP"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -4|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_03"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -4|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "UP"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -5|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_04"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -5|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "UP"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -6|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_05"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -6|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "UP"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -7|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_06"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -7|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOWN"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -8|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_07"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -8|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOWN"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -9|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_08"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -9|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOWN"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -10|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_09"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -10|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOWN"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -11|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_10"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -11|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DOWN"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -12|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_11"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -12|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DISABLED"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -13|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_12"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -13|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DISABLED"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -14|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_13"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -14|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DISABLED"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -15|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_14"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -15|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DISABLED"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -16|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_15"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -16|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "DISABLED"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -17|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_16"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -17|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "UNPLUGGED"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -18|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_17"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -18|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "UNPLUGGED"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -19|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_18"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -19|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "UNPLUGGED"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -20|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_19"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -20|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "UNPLUGGED"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -21|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_20"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -21|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "UNPLUGGED"

  @SID_8
  Scenario: ADC Applications report validate CSV file Ports Traffic Information_1 widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -1|tail -1|grep pps_receive,throughput_transmit,throughput_receive,id,pps_transmit,timestamp|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_01"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -3|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_02"

#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -1|tail -1|grep pps_receive,throughput_transmit,throughput_receive,id,pps_transmit,timestamp|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "9.99999986991104E14"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "12.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "11.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_01"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "9.99996992E8"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -3|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "25.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "22.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -3|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "21.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -3|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_02"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -3|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "26.0"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -4|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "35.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -4|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "32.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -4|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "31.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -4|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_03"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -4|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "36.0"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -5|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "45.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -5|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "42.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -5|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "41.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -5|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_04"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -5|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "46.0"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -6|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "55.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -6|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "52.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -6|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "51.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -6|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_05"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -6|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "56.0"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -7|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "65.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -7|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "62.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -7|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "61.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -7|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_06"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -7|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "66.0"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -8|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "75.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -8|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "72.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -8|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "71.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -8|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_07"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -8|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "76.0"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -9|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "85.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -9|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "82.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -9|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "81.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -9|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_08"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -9|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "86.0"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -10|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "95.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -10|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "92.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -10|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "91.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -10|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_09"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -10|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "96.0"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -11|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "105.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -11|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "102.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -11|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "101.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -11|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_10"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -11|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "106.0"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -12|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "115.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -12|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "112.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -12|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "111.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -12|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_11"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -12|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "116.0"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -13|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "125.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -13|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "122.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -13|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "121.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -13|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_12"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -13|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "126.0"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -14|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "135.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -14|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "132.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -14|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "131.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -14|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_13"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -14|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "136.0"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -15|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "145.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -15|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "142.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -15|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "141.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -15|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_14"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -15|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "146.0"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -16|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "155.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -16|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "152.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -16|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "151.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -16|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_15"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -16|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "156.0"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -17|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "165.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -17|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "162.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -17|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "161.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -17|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_16"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -17|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "166.0"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -18|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "175.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -18|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -18|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "171.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -18|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_17"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -18|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "176.0"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -19|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "185.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -19|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "182.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -19|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "181.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -19|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_18"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -19|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "186.0"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -20|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "195.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -20|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "192.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -20|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "191.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -20|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_19"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -20|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "196.0"
#
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -21|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "205.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -21|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "202.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -21|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "201.0"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -21|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_20"
#    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network_1.csv"|head -21|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "206.0"
#

  @SID_9
  Scenario: Delete report
    Then UI Delete Report With Name "ADC System and Network Report"

  @SID_10
  Scenario: Logout
    Then UI logout and close browser


