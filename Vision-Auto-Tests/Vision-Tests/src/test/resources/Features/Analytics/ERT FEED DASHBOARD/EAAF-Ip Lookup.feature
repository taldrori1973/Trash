@TC126291
Feature: EAAF-Ip Lookup
#  @SID_1
#    Scenario: delete data from elastic search
#    * CLI kill all simulator attacks on current vision
#    * REST Delete ES index "eaaf-attack-*"
#    Then Sleep "300"

@TEAA
  @SID_2
  Scenario: login and navigate ERT dashboard
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
  Then UI Navigate to "EAAF Dashboard" page via homePage

  @SID_3
  Scenario: click iplookup and write valide ip
    Given UI Click Button "IP Lookup"
    Then UI Set Text Field "IPlookup search" To "113.172.213.32"
    Then Sleep "2"

#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "ID"
#      | columnName     | value             |
#      | Country Code   | ID                |
#      | Device         | 50.50.100.1       |
#      | Policy         | ERT               |
#      | Volume (Kbits) | 854.1120405681431 |
#      | Packets        | 861.0             |
#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "US"
#      | columnName     | value             |
#      | Country Code   | US                |
#      | Device         | 50.50.100.1       |
#      | Policy         | ERT               |
#      | Volume (Kbits) | 854.1120405681431 |
#      | Packets        | 861.0             |
#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "AT"
#      | columnName     | value             |
#      | Country Code   | AT                |
#      | Device         | 50.50.100.1       |
#      | Policy         | ERT               |
#      | Volume (Kbits) | 854.1120405681431 |
#      | Packets        | 861.0             |
#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "PT"
#      | columnName     | value             |
#      | Country Code   | PT                |
#      | Device         | 50.50.100.1       |
#      | Policy         | ERT               |
#      | Volume (Kbits) | 854.1120405681431 |
#      | Packets        | 861.0             |
#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "NL"
#      | columnName     | value             |
#      | Country Code   | NL                |
#      | Device         | 50.50.100.1       |
#      | Policy         | ERT               |
#      | Volume (Kbits) | 851.1360404267907 |
#      | Packets        | 858.0             |
#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "US"
#      | columnName     | value             |
#      | Country Code   | US                |
#      | Device         | 50.50.100.1       |
#      | Policy         | ERT               |
#      | Volume (Kbits) | 851.1360404267907 |
#      | Packets        | 858.0             |
#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "ID"
#      | columnName     | value              |
#      | Country Code   | ID                 |
#      | Device         | 50.50.100.1        |
#      | Policy         | ERT                |
#      | Volume (Kbits) | 2847.0401352271438 |
#      | Packets        | 2870.0             |
#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "US"
#      | columnName     | value              |
#      | Country Code   | US                 |
#      | Device         | 50.50.100.1        |
#      | Policy         | ERT                |
#      | Volume (Kbits) | 2847.0401352271438 |
#      | Packets        | 2870.0             |
#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "AT"
#      | columnName     | value              |
#      | Country Code   | AT                 |
#      | Device         | 50.50.100.1        |
#      | Policy         | ERT                |
#      | Volume (Kbits) | 2847.0401352271438 |
#      | Packets        | 2870.0             |
#
#    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "PT"
#      | columnName     | value              |
#      | Country Code   | PT                 |
#      | Device         | 50.50.100.1        |
#      | Policy         | ERT                |
#      | Volume (Kbits) | 2847.0401352271438 |
#      | Packets        | 2870.0             |




    Then UI Validate Text field "count results" EQUALS "10 Results"

################################ CSV section to be edited ##################################
  @SID_4
  Scenario: Clear FTP server logs and generate the modal ip lookup
    Then CLI Run remote linux Command "rm -rf /home/radware/Downloads/*.csv" on "GENERIC_LINUX_SERVER"
  @SID_5
  Scenario: Modify any dynamic values in DB
    Then UI Click Button "Export To CSV"





  @SID_6
  Scenario: Validate detailed csv iplookup
    Then CLI Run linux Command "cat /home/radware/Downloads/file.csv |wc -l" on "SLAVE_SERVER_CLI" and validate result EQUALS "36"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ID"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "854.112040568143"
#
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "US"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "854.112040568143"
#
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "AT"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "854.112040568143"
#
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "PT"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "854.112040568143"
#
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "NL"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "851.13604042679"
#
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "US"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "851.13604042679"
#
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ID"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2847.04013522714"
#
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "US"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2847.04013522714"
#
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "AT"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2847.04013522714"
#
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "PT"
#    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2847.04013522714"
#
  @SID_7
  Scenario: click iplookup and write unvalide ip

    Then UI Set Text Field "IPlookup search" To "344.344.344.344"
    Then UI Validate Text field "unvalid ip" EQUALS "IP address not found. Try a different one."