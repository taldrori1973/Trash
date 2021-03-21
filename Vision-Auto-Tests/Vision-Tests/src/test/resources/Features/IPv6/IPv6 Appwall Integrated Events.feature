@TC111221
Feature: IPv6 Appwall Events

  @SID_1
  Scenario: Delete Alteon and site if exists
#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_file where fk_dev_site_tree_el=(select row_id from site_tree_elem_abs where name='Alteon_200a::172:17:164:19');"" on "ROOT_SERVER_CLI"
    Then MYSQL DELETE FROM "device_file" Table in "VISION_NG" Schema WHERE "fk_dev_site_tree_el=(select row_id from site_tree_elem_abs where name='Alteon_200a::172:17:164:19')"

#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from dpm_virtual_services where fk_device=(select row_id from site_tree_elem_abs where name='Alteon_200a::172:17:164:19');"" on "ROOT_SERVER_CLI"
    Then MYSQL DELETE FROM "dpm_virtual_services" Table in "VISION_NG" Schema WHERE "fk_device=(select row_id from site_tree_elem_abs where name='Alteon_200a::172:17:164:19')"

#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='Alteon_200a::172:17:164:19';"" on "ROOT_SERVER_CLI"
    Then MYSQL DELETE FROM "site_tree_elem_abs" Table in "VISION_NG" Schema WHERE "name='Alteon_200a::172:17:164:19'"

#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_setup where fk_dev_access_device_acces=(select row_id from device_access where mgt_ip="200a:0:0:0:172:17:164:19");"" on "ROOT_SERVER_CLI"
    Then MYSQL DELETE FROM "device_setup" Table in "VISION_NG" Schema WHERE "fk_dev_access_device_acces=(select row_id from device_access where mgt_ip='200a:0:0:0:172:17:164:19')"

#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_access where mgt_ip="200a:0:0:0:172:17:164:19";"" on "ROOT_SERVER_CLI"
    Then MYSQL DELETE FROM "device_access" Table in "VISION_NG" Schema WHERE "mgt_ip='200a:0:0:0:172:17:164:19'"

#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='Alteons-IPv6';"" on "ROOT_SERVER_CLI"
    Then MYSQL DELETE FROM "site_tree_elem_abs" Table in "VISION_NG" Schema WHERE "name='Alteons-IPv6'"

  @SID_2
  Scenario: Open the SitesAndClusters Containers
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
#    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI open Topology Tree view "SitesAndClusters" site

  @SID_3
  Scenario: Add new Site to tree
    Then UI Add new Site "Alteons-IPv6" under Parent "Default"

  @SID_4
  Scenario: Add new Alteon to site
#    Then UI Add "Alteon" with index 40 on "Alteons-IPv6" site
    Then UI Add "Alteon" Device To topology Tree with Name "Alteon_200a::172:17:164:19" and Management IP "200a::172:17:164:19" into site "Alteons-IPv6"
      | registerDeviceEvents | false |

  @SID_5
  Scenario: Lock and configure vision as syslog destination
    Given REST Lock Action on "Alteon" 40
    Then REST Request "PUT" for "Edit Alteon->Security->Vision Reporter"
      | type                 | value                                                    |
      | body                 | slbNewAppwallReporterOnOff=1                             |
      | body                 | slbNewAppwallReporterIpAddress=200a:0:0:0:172:17:164:111 |
      | body                 | slbNewAppwallReporterPort=2215                           |
      | Returned status code | 200                                                      |
    Then REST Unlock Action on "Alteon" 40

  @SID_6
  Scenario: Clear Appwall events from DB
    Then CLI Run remote linux Command "curl -XDELETE http://127.0.0.1:9200/appwall-v2-attack-raw-*" on "ROOT_SERVER_CLI"

  @SID_7
  Scenario: Generate request to the VIP
    Then CLI Run remote linux Command "curl --max-time 2 -XGET http://50.50.164.19/cmd.exe" on "GENERIC_LINUX_SERVER"
    Then Sleep "20"

  @SID_8
  Scenario: Verify IPv6 event received to DB
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"destinationPort":"80"}}]}},"from":0,"size":1}' localhost:9200/appwall-v2-attack-raw-*/_search |awk -F"," '{print$15}'" on "ROOT_SERVER_CLI" and validate result CONTAINS ""OriginatorIP":"200a:0:0:0:172:17:164:19"
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"destinationPort":"80"}}]}},"from":0,"size":1}' localhost:9200/appwall-v2-attack-raw-*/_search |awk -F"," '{print$19}'" on "ROOT_SERVER_CLI" and validate result EQUALS ""severity":"High""
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"destinationPort":"80"}}]}},"from":0,"size":1}' localhost:9200/appwall-v2-attack-raw-*/_search |awk -F"," '{print$21}'" on "ROOT_SERVER_CLI" and validate result EQUALS ""violationType":"URL Access Violation""
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"destinationPort":"80"}}]}},"from":0,"size":1}' localhost:9200/appwall-v2-attack-raw-*/_search |awk -F"," '{print$26}'" on "ROOT_SERVER_CLI" and validate result EQUALS ""appPath":"/cmd.exe""
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"destinationPort":"80"}}]}},"from":0,"size":1}' localhost:9200/appwall-v2-attack-raw-*/_search |awk -F"," '{print$35}'" on "ROOT_SERVER_CLI" and validate result EQUALS ""module":"Vulnerabilities""
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"term":{"destinationPort":"80"}}]}},"from":0,"size":1}' localhost:9200/appwall-v2-attack-raw-*/_search |awk -F"," '{print$41}'" on "ROOT_SERVER_CLI" and validate result EQUALS ""protocol":"HTTP""

  @SID_9
  Scenario: Go to AMS Appwall dashboard
    # Sleep in order to let server fetch the device application
    When Sleep "60"
    And UI Navigate to "AppWall Dashboard" page via homepage
    Then Sleep "5"

  @SID_10
  Scenario: validate Appwall widget SEVERITY OWASP
    Then UI Validate Pie Chart data "SEVERITY"
      | label | data |
      | High  | 1    |
    Then UI Validate Pie Chart data "OWASPCATEGORY"
      | label | data |
      | A5    | 1    |
#    Then UI Open "Configurations" Tab

  @SID_11
  Scenario: Change in DB the device IP to IPv6 to bypass Appwall bug
    When CLI Run remote linux Command "curl -XPOST localhost:9200/appwall-v2-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"uri": "/cmd.exe"}},"script": {"inline": "ctx._source.appwallIP = \"200a:0:0:0:172:17:164:19\""}}'" on "ROOT_SERVER_CLI"

  @SID_12
  Scenario: validate Appwall widget SEVERITY OWASP
    And UI Navigate to "AppWall Dashboard" page via homepage
    Then UI Validate Pie Chart data "SEVERITY"
      | label | data |
      | High  | 1    |
    Then UI Validate Pie Chart data "OWASPCATEGORY"
      | label | data |
      | A5    | 1    |
    Then UI Navigate to "VISION SETTINGS" page via homePage

  @SID_13
  Scenario: Delete Alteon devices from tree
    Then UI open Topology Tree view "SitesAndClusters" site
    Then UI Delete "Alteon" device with index 40 from topology tree

  @SID_14
  Scenario: Delete Alteon site and logout
    Then UI Delete TopologyTree Element "Alteons-IPv6" by topologyTree Tab "SitesAndClusters"
    Then UI logout and close browser