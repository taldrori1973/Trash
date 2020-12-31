@TC118901
Feature: ADC System and Network Generate CSV Report
  @SID_1
  Scenario: keep reports copy on file system
    Given CLI Reset radware password
    Then CLI Run remote linux Command "sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 720
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/collectors_service.sh status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Collectors Server is running." with timeOut 240

  @SID_2
  Scenario: Login and Navigate ADC Report
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "ADC Reports" page via homePage

  @SID_3
  Scenario: Create and validate ADC Report
    Then UI Click Button "New Report Tab"
    Given UI "Create" Report With Name "ADC System and Network Report"
      | Template-2            | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_50.50.101.21] |
      | Time Definitions.Date | Quick:1H                                                                                                 |
      | Format                | Select:  CSV                                                                                             |
    Then UI "Validate" Report With Name "ADC System and Network Report"
      | Template-2            | reportType:System and Network , Widgets:[Ports Traffic Information] , Applications:[Alteon_50.50.101.21] |
      | Time Definitions.Date | Quick:1H                                                                                                 |
      | Format                | Select: CSV                                                                                              |

  @SID_4
  Scenario: Validate delivery card and generate report
    Then UI Click Button "My Report" with value "ADC Applications Report"
    Then UI Click Button "Generate Report Manually" with value "ADC Applications Report"
    Then Sleep "35"

  @SID_5
  Scenario: VRM report unzip local CSV file
    Then CLI Run remote linux Command "unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip" on "ROOT_SERVER_CLI"

  @SID_6
  Scenario: ADC Applications report validate CSV file Ports Traffic Information widget header
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -1|tail -1|grep pps_receive,throughput_transmit,throughput_receive,id,pps_transmit,timestamp|wc -l " on "ROOT_SERVER_CLI" and validate result EQUALS "1"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -2|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "999999986991104"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -2|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "12"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -2|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "11"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -2|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_01"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -2|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "999996992"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -3|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "25"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -3|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "22"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -3|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "21"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -3|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_02"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -3|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "26"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -4|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "35"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -4|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "32"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -4|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "31"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -4|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_03"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -4|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "36"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -5|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "45"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -5|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "42"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -5|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "41"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -5|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_04"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -5|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "46"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -6|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "55"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -6|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "52"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -6|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "51"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -6|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_05"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -6|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "56"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -7|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "65"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -7|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "62"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -7|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "61"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -7|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_06"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -7|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "66"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -8|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "75"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -8|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "72"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -8|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "71"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -8|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_07"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -8|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "76"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -9|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "85"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -9|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "82"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -9|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "81"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -9|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_08"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -9|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "86"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -10|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "95"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -10|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "92"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -10|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "91"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -10|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_09"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -10|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "96"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -11|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "105"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -11|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "102"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -11|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "101"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -11|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_10"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -11|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "106"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -12|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "115"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -12|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "112"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -12|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "111"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -12|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_11"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -12|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "116"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -13|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "125"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -13|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "122"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -13|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "121"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -13|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_12"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -13|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "126"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -14|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "135"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -14|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "132"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -14|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "131"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -14|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_13"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -14|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "136"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -15|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "145"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -15|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "142"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -15|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "141"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -15|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_14"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -15|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "146"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -16|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "155"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -16|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "152"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -16|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "151"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -16|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_15"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -16|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "156"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -17|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "165"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -17|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "162"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -17|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "161"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -17|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_16"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -17|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "166"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -18|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "175"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -18|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "172"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -18|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "171"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -18|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_17"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -18|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "176"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -19|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "185"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -19|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "182"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -19|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "181"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -19|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_18"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -19|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "186"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -20|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "195"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -20|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "192"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -20|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "191"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -20|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_19"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -20|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "196"

    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -21|tail -1|awk -F "," '{printf $1}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "205"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -21|tail -1|awk -F "," '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "202"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -21|tail -1|awk -F "," '{printf $3}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "201"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -21|tail -1|awk -F "," '{printf $4}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "port_20"
    Then CLI Run linux Command "cat "/opt/radware/mgt-server/third-party/tomcat/bin/Ports Traffic Information-System and Network.csv"|head -21|tail -1|awk -F "," '{printf $5}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "206"

  @SID_7
  Scenario: Delete report
    Then UI Delete Report With Name "ADC System and Network Report"

  @SID_8
  Scenario: Logout
    Then UI logout and close browser


