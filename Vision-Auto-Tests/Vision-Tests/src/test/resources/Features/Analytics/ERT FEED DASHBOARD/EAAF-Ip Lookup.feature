@TC126291
Feature: EAAF-Ip Lookup

  @SID_1
  Scenario: login and navigate ERT dashboard
    Given UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "EAAF Dashboard" page via homePage

  @SID_2
  Scenario: click iplookup and write valide ip
    Given UI Click Button "IP Lookup button"
    Then UI Set Text Field "IPlookup search" To "103.28.52.93"
    Then Sleep "2"

    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "ID"
      | columnName     | value             |
      | Country Code   | ID                |
      | Device         | 50.50.100.1       |
      | Policy         | ERT               |
      | Volume (Kbits) | 854.1120405681431 |
      | Packets        | 861.0             |
    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "US"
      | columnName     | value             |
      | Country Code   | US                |
      | Device         | 50.50.100.1       |
      | Policy         | ERT               |
      | Volume (Kbits) | 854.1120405681431 |
      | Packets        | 861.0             |
    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "AT"
      | columnName     | value             |
      | Country Code   | AT                |
      | Device         | 50.50.100.1       |
      | Policy         | ERT               |
      | Volume (Kbits) | 854.1120405681431 |
      | Packets        | 861.0             |
    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "PT"
      | columnName     | value             |
      | Country Code   | PT                |
      | Device         | 50.50.100.1       |
      | Policy         | ERT               |
      | Volume (Kbits) | 854.1120405681431 |
      | Packets        | 861.0             |
    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "NL"
      | columnName     | value             |
      | Country Code   | NL                |
      | Device         | 50.50.100.1       |
      | Policy         | ERT               |
      | Volume (Kbits) | 851.1360404267907 |
      | Packets        | 858.0             |
    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "US"
      | columnName     | value             |
      | Country Code   | US                |
      | Device         | 50.50.100.1       |
      | Policy         | ERT               |
      | Volume (Kbits) | 851.1360404267907 |
      | Packets        | 858.0             |
    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "ID"
      | columnName     | value              |
      | Country Code   | ID                 |
      | Device         | 50.50.100.1        |
      | Policy         | ERT                |
      | Volume (Kbits) | 2847.0401352271438 |
      | Packets        | 2870.0             |
    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "US"
      | columnName     | value              |
      | Country Code   | US                 |
      | Device         | 50.50.100.1        |
      | Policy         | ERT                |
      | Volume (Kbits) | 2847.0401352271438 |
      | Packets        | 2870.0             |
    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "AT"
      | columnName     | value              |
      | Country Code   | AT                 |
      | Device         | 50.50.100.1        |
      | Policy         | ERT                |
      | Volume (Kbits) | 2847.0401352271438 |
      | Packets        | 2870.0             |

    Then UI Validate Table record tooltip values with elementLabel "IPLookupTable" findBy columnName "Country Code" findBy cellValue "PT"
      | columnName     | value              |
      | Country Code   | PT                 |
      | Device         | 50.50.100.1        |
      | Policy         | ERT                |
      | Volume (Kbits) | 2847.0401352271438 |
      | Packets        | 2870.0             |




    Then UI Validate Text field "count results" EQUALS "762 Results"

################################ CSV section to be edited ##################################
  @SID_3
  Scenario: Modify any dynamic values in DB
    #All units in mSec but in CSV/UI will be shown in seconds
    #Less than 1000 mSec are rounded to 0
    Then UI Click Button "Export To CSV"
    Then CLI Run remote linux Command "curl -XPOST -H "Content-Type: application/json" "localhost:9200/dp-attack-raw-*/_update_by_query/?size=1&conflicts=proceed&pretty" -d '{"query": {"bool": {"must": [{"term": {"attackIpsId": "7839-1402580209"}}]}},"script": {"source": "ctx._source.duration ='20000'"}}'" on "ROOT_SERVER_CLI"
    Then Sleep "5"
    Then CLI Run remote linux Command "curl -XPOST -H "Content-Type: application/json" "localhost:9200/dp-attack-raw-*/_update_by_query/?size=1&conflicts=proceed&pretty" -d '{"query": {"bool": {"must": [{"term": {"attackIpsId": "7840-1402580209"}}]}},"script": {"source": "ctx._source.duration ='1000'"}}'" on "ROOT_SERVER_CLI"
    Then Sleep "5"
    Then CLI Run remote linux Command "curl -XPOST -H "Content-Type: application/json" "localhost:9200/dp-attack-raw-*/_update_by_query/?size=1&conflicts=proceed&pretty" -d '{"query": {"bool": {"must": [{"term": {"attackIpsId": "33-19"}}]}},"script": {"source": "ctx._source.duration ='1'"}}'" on "ROOT_SERVER_CLI"
    Then Sleep "5"

  @SID_6
  Scenario: Clear FTP server logs and generate the modal ip lookup
    Then CLI Run remote linux Command "rm -f /home/radware/ftp/modal_ip_lookup*.zip /home/radware/ftp/modal_ip_lookup*.csv" on "GENERIC_LINUX_SERVER"


  @SID_8
  Scenario: Unzip CSV file
    Then CLI Run remote linux Command "unzip -o /home/radware/ftp/modal_ip_lookup*.zip -d /home/radware/ftp/" on "GENERIC_LINUX_SERVER"
    Then Sleep "3"

  @SID_9
  Scenario: Validate detailed csv iplookup
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "36"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ID"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "854.112040568143"

    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "US"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "854.112040568143"

    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "AT"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "854.112040568143"

    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "PT"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "854.112040568143"

    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "NL"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "851.13604042679"

    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "US"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "851.13604042679"

    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ID"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2847.04013522714"

    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "US"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2847.04013522714"

    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "AT"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2847.04013522714"

    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 5" on "GENERIC_LINUX_SERVER" and validate result EQUALS "50.50.100.1"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 7" on "GENERIC_LINUX_SERVER" and validate result EQUALS "861"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 9" on "GENERIC_LINUX_SERVER" and validate result EQUALS "ERT"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "PT"
    Then CLI Run linux Command "cat /home/radware/ftp/modal_ip_lookup_*.csv|head -$(echo $(grep -n "IPLookup" /home/radware/ftp/csv_without_details_*.csv |cut -f1 -d:)|bc)|tail -1|cut -d ',' -f 10" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2847.04013522714"

  @SID_10
  @SID_3
  Scenario: click iplookup and write unvalide ip

    Then UI Set Text Field "IPlookup search" To "344.344.344.344"
    Then UI Validate Text field "unvalid ip" EQUALS "IP address not found. Try a different one."