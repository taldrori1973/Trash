@TC111221
Feature: IPv6 Appwall Events

  @SID_1
  Scenario: Delete Alteon and site if exists
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_file where fk_dev_site_tree_el=(select row_id from site_tree_elem_abs where name='Alteon_200a::172:17:164:19');"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from dpm_virtual_services where fk_device=(select row_id from site_tree_elem_abs where name='Alteon_200a::172:17:164:19');"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='Alteon_200a::172:17:164:19';"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_setup where fk_dev_access_device_acces=(select row_id from device_access where mgt_ip="200a:0:0:0:172:17:164:19");"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from device_access where mgt_ip="200a:0:0:0:172:17:164:19";"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "delete from site_tree_elem_abs where name='Alteons-IPv6';"" on "ROOT_SERVER_CLI"

  @SID_2
  Scenario: Open the SitesAndClusters Containers
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
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
      |User Name             |admin  |
      |Password              |admin  |

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
    And UI Open Upper Bar Item "AMS"
    When UI Open "Dashboards" Tab
    Then UI Open "AppWall Dashboard" Sub Tab
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
    When UI Open "Reports" Tab
    When UI Open "Dashboards" Tab
    Then UI Open "AppWall Dashboard" Sub Tab
    Then UI Validate Pie Chart data "SEVERITY"
      | label | data |
      | High  | 1    |
    Then UI Validate Pie Chart data "OWASPCATEGORY"
      | label | data |
      | A5    | 1    |
    Then UI Open "Configurations" Tab

################################ #IPV6 Tests  #####################################
  @SID_15
  Scenario: Clear Appwall events from DB
    Then CLI Run remote linux Command "curl -XDELETE http://127.0.0.1:9200/appwall-v2-attack-raw-*" on "ROOT_SERVER_CLI"

  @SID_16
  Scenario:run AW attacks
#    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
#      | "/home/radware/AW_Attacks/sendAW_Attacks_IPV6.sh "                     |
#      | #visionIP                                                         |
#      | " 200a:0:0:0:172:17:164:19 5 "/home/radware/AW_Attacks/IPv6/"" |

    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "cat /home/radware/AW_Attacks/IPv6/Injection \| netcat " |
      | #visionIP                                                |
      | " 2215"                                                  |

    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "cat /home/radware/AW_Attacks/IPv6/crossSiteRequest8 \| netcat " |
      | #visionIP                                                        |
      | " 2215"                                                          |

    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "cat /home/radware/AW_Attacks/IPv6/crossSiteScripting6 \| netcat " |
      | #visionIP                                                          |
      | " 2215"                                                            |

    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "cat /home/radware/AW_Attacks/IPv6/Injection9 \| netcat " |
      | #visionIP                                                 |
      | " 2215"                                                   |


    Then Sleep "40"


#    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
#      | "/home/radware/AW_Attacks/sendAW_Attacks_IPV6.sh "                     |
#      | #visionIP                                                         |
#      | " 200a:0:0:0:172:17:164:19 5 "/home/radware/AW_Attacks/IPv6/"" |
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "cat /home/radware/AW_Attacks/IPv6/Injection \| netcat " |
      | #visionIP                                                |
      | " 2215"                                                  |

    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "cat /home/radware/AW_Attacks/IPv6/crossSiteRequest8 \| netcat " |
      | #visionIP                                                        |
      | " 2215"                                                          |

    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "cat /home/radware/AW_Attacks/IPv6/crossSiteScripting6 \| netcat " |
      | #visionIP                                                          |
      | " 2215"                                                            |

    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "cat /home/radware/AW_Attacks/IPv6/Injection9 \| netcat " |
      | #visionIP                                                 |
      | " 2215"                                                   |


    Then Sleep "40"

  @SID_17
  Scenario: Go TO AW dashboard
    And UI Open Upper Bar Item "AMS"
    When UI Open "Dashboards" Tab
    Then UI Open "AppWall Dashboard" Sub Tab
    Then Sleep "5"
    Then UI Validate Element Existence By Label "Top Sources Widget" if Exists "true"


  @SID_18
  Scenario: validate 3 upper widgets
    Then UI Text of "blocked Events value" equal to "6"
    Then UI Text of "reported Events value" equal to "2"


  @SID_19
  Scenario: validate OWASP Top 10
    Then UI Validate Pie Chart data "OWASPCATEGORY"
      | label | data |
      | A1    | 4    |
      | A5    | 2    |
      | A7    | 2    |

  @SID_20
  Scenario: validate Top Attack Category
    Then UI Validate Text field "TopAttackCategory_value" with params "Injections" EQUALS "4"
    Then UI Validate Text field "TopAttackCategory_value" with params "Access Control" EQUALS "2"
    Then UI Validate Text field "TopAttackCategory_value" with params "Cross Site Scripting" EQUALS "2"


  @SID_21
  Scenario: validate Top Sources
    Then UI Validate Text field "TopSources_value" with params "500B:1001:1001:1001:1001:100A:233C:1111" EQUALS "6"
    Then UI Validate Text field "TopSources_value" with params "500B:1001:1001:1001:1001:100A:233C:2222" EQUALS "2"


  @SID_22
  Scenario: validate Attack by Action
    Then UI Validate Pie Chart data "ACTION"
      | label    | data |
      | Blocked  | 6    |
      | Reported | 2    |

  @SID_23
  Scenario: validate Attack Severity
    Then UI Validate Pie Chart data "SEVERITY"
      | label | data |
      | High  | 8    |


  @SID_24
  Scenario: validate Top Attack Hosts
    Then UI Validate Text field "AttackHosts_value" with params "200b:1001:1001:1001:1001:100a:233c:1111" EQUALS "6"
    Then UI Validate Text field "AttackHosts_value" with params "211b:1003:1003:abcd:2202:4444:4444:2003" EQUALS "2"

  @SID_25
  Scenario: logout
    Then UI logout and close browser

  @SID_26
  Scenario: validate IPv6 A.W RBAC
    Given UI Login with user "Device_Admin_50.50.101.21" and password "radware"
    And UI Open Upper Bar Item "AMS"
    When UI Open "Dashboards" Tab
    Then UI Open "AppWall Dashboard" Sub Tab
    Then Sleep "5"
    Then UI Text of "blocked Events value" equal to "0"
    Then UI Text of "reported Events value" equal to "0"
    Then UI logout and close browser

  @SID_27
  Scenario:run AW attacks for different IPv6 formats
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "cat /home/radware/AW_Attacks/IPv6/InjectionIPv6Format \| netcat " |
      | #visionIP                                                |
      | " 2215"                                                  |
    Then Sleep "40"

  @SID_28
  Scenario: Go TO AW dashboard
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "radware" and password "radware"
    When UI Open Upper Bar Item "AMS"
    And UI Open "Dashboards" Tab
    Then UI Open "AppWall Dashboard" Sub Tab
    Then Sleep "5"
    Then UI Validate Element Existence By Label "Top Sources Widget" if Exists "true"


  @SID_29
  Scenario: validate Top Attack widgets for different IPv6 formats
    Then UI Text of "blocked Events value" equal to "6"

  @SID_30
  Scenario: validate OWASP Top 10 for different IPv6 formats
    Then UI Validate Pie Chart data "OWASPCATEGORY"
      | label | data |
      | A1    | 6    |

  @SID_31
  Scenario: validate Top Attack Category for different IPv6 formats
    Then UI Validate Text field "TopAttackCategory_value" with params "Injections" EQUALS "6"



  @SID_32
  Scenario: validate Top Sources for different IPv6 formats
    Then UI Validate Text field "TopSources_value" with params "500B:1001:1001:1001:1001:100A:233C:1111" EQUALS "6"


  @SID_33
  Scenario: validate Attack by Action for different IPv6 formats
    Then UI Validate Pie Chart data "ACTION"
      | label    | data |
      | Blocked  | 6    |

  @SID_34
  Scenario: validate Attack Severity for different IPv6 formats
    Then UI Validate Pie Chart data "SEVERITY"
      | label | data |
      | High  | 6    |


  @SID_35
  Scenario: validate Top Attack Hosts for different IPv6 formats
    Then UI Validate Text field "AttackHosts_value" with params "200b:1001:1001:1001:1001:100a:233c:1111" EQUALS "6"

  @SID_36
  Scenario: logout
    Then UI logout and close browser

####################################################################################

  @SID_13
  Scenario: Delete Alteon devices from tree
    Given UI Login with user "radware" and password "radware"
    Then UI Open "Configurations" Tab
    Then UI open Topology Tree view "SitesAndClusters" site
    Then UI Delete "Alteon" device with index 40 from topology tree

  @SID_14
  Scenario: Delete Alteon site and logout
    Then UI Delete TopologyTree Element "Alteons-IPv6" by topologyTree Tab "SitesAndClusters"
    Then UI logout and close browser