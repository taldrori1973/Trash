@run
@Analytics_ADC @TC105978
@SSL_Charts
Feature: ADC dashboard Second Drill - SSL

  @SID_1
  Scenario: Import driver script and jar file
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.2.1.0-DD-1.00-110.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.4.0.0-DD-1.00-396.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"

  @SID_2
  Scenario: Upload Driver to vision
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.2.1.0-DD-1.00-110.jar" on "ROOT_SERVER_CLI" with timeOut 240
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.4.0.0-DD-1.00-396.jar" on "ROOT_SERVER_CLI" with timeOut 240
    Then Sleep "120"
  @SID_3
  Scenario: Validate server fetched all applications after upgrade
    Then CLI Run remote linux Command "result=`curl -ks -X "POST" "https://localhost/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"radware\",\"password\": \"radware\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -k -XPOST -H "Cookie: JSESSIONID=$jsession" -d '{}' https://localhost:443/mgmt/system/monitor/dpm/alteon/fetch" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario: Login
    Then REST Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    Then UI Login with user "radware" and password "radware"
    When UI Navigate to "Application Dashboard" page via homePage


  @SID_5
  Scenario: Navigate to Virtual Service
    Then Sleep "3"
    Then UI click Table row by keyValue or Index with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith_32326515:443"
    Then UI Validate Text field "Virtual Service.Name" with params "Rejith_32326515:443" EQUALS "Rejith_32326515:443"
    Then  UI Click Button "Virtual Service.Toolbar Tab" with value "ssl"

  @SID_6
  Scenario: Validate Diagrams Line Charts Titles
    Then UI Text of "Virtual Service.Widget Title" with extension "TLS Version" equal to "TLS Version"
    Then UI Text of "Virtual Service.Widget Title" with extension "Key Exchange Algorithms" equal to "Key Exchange Algorithms"
    Then UI Text of "Virtual Service.Widget Title" with extension "Top Used Ciphers" equal to "Top Used Ciphers"
    Then UI Text of "Virtual Service.Widget Title" with extension "Rejected SSL Handshakes (%)" equal to "Rejected SSL Handshakes (%)"
    Then UI Text of "Virtual Service.Widget Title" with extension "SSL Connections per Second" equal to "SSL Connections per Second"


  @SID_7
  Scenario: Validate TLS version widget
    Then UI Validate Line Chart data "TLS" with Label "TLS 1.3"
      | value | count | offset |
      | 41    | 30    | 2      |
    Then UI Validate Line Chart data "TLS" with Label "TLS 1.2"
      | value | count | offset |
      | 40    | 30    | 2      |
    Then UI Validate Line Chart data "TLS" with Label "TLS 1.1"
      | value | count | offset |
      | 39    | 30    | 2      |
    Then UI Validate Line Chart data "TLS" with Label "TLS 1.0"
      | value | count | offset |
      | 38    | 30    | 2      |
    Then UI Validate Line Chart data "TLS" with Label "SSLv3"
      | value | count | offset |
      | 37    | 30    | 2      |

  @SID_8
  Scenario: Validate TLS version widget Labels Attributes
    Then UI Validate Line Chart attributes "TLS" with Label "TLS 1.3"
      | attribute       | value              |
      | backgroundColor | rgba(92,182,174,1) |
    Then UI Validate Line Chart attributes "TLS" with Label "TLS 1.2"
      | attribute       | value              |
      | backgroundColor | rgba(78,109,141,1) |
    Then UI Validate Line Chart attributes "TLS" with Label "TLS 1.1"
      | attribute       | value               |
      | backgroundColor | rgba(169,203,226,1) |
    Then UI Validate Line Chart attributes "TLS" with Label "TLS 1.0"
      | attribute       | value              |
      | backgroundColor | rgba(77,131,187,1) |
    Then UI Validate Line Chart attributes "TLS" with Label "SSLv3"
      | attribute       | value                    |
      | backgroundColor | rgba(250, 132, 132, 0.8) |

  @SID_9
  Scenario: Validate Key Exchange Algorithms widget
    Then UI Validate Pie Chart data "Key Exchange Algorithms"
      | label | data | offset |
      | RSA   | 750  | 60     |
      | DHE   | 780  | 60     |
      | ECDHE | 810  | 60     |

  @SID_10
  Scenario: Validate Key Exchange Algorithms Widget attributes
    Then UI Validate Pie Chart attributes "Key Exchange Algorithms"
      | attribute       | value                                                                           |
      | backgroundColor | ["rgba(78, 109, 141, 1)","rgba( 165, 202, 227, 1 )","rgba( 250, 132, 132, 1 )"] |

  @SID_11
  Scenario: Validate SSL connection per second widget
    Then UI Validate Line Chart data "SSL CPS" with Label "New"
      | value | count | offset |
      | 31    | 30    | 2      |
    Then UI Validate Line Chart data "SSL CPS" with Label "Reused"
      | value | count | offset |
      | 32    | 30    | 2      |
    Then UI Validate Line Chart data "SSL CPS" with Label "Reused 0-RTT"
      | value | count | offset |
      | 0     | 30    | 2      |
    Then UI Validate Line Chart data "SSL CPS" with Label "Rejected"
      | value | count | offset |
      | 33    | 30    | 2      |

  @SID_12
  Scenario: Validate SSL connection per second widget Labels Attributes
    Then UI Validate Line Chart attributes "SSL CPS" with Label "New"
      | attribute       | value              |
      | backgroundColor | rgba(92,182,174,1) |
    Then UI Validate Line Chart attributes "SSL CPS" with Label "Reused"
      | attribute       | value               |
      | backgroundColor | rgba(169,203,226,1) |
    Then UI Validate Line Chart attributes "SSL CPS" with Label "Reused 0-RTT"
      | attribute       | value             |
      | backgroundColor | rgba(68,96,124,1) |
    Then UI Validate Line Chart attributes "SSL CPS" with Label "Rejected"
      | attribute       | value                    |
      | backgroundColor | rgba(250, 132, 132, 0.8) |


  @SID_13
  Scenario: SSL handshake failure widget
    Then UI Validate Line Chart data "SSL HANDSHAKE" with Label "Rejects (%)"
      | value | count | offset |
      | 34.38 | 30    | 2      |

  @SID_14
  Scenario: SSL handshake failure widget Labels Attributes
    Then UI Validate Line Chart attributes "SSL HANDSHAKE" with Label "Rejects (%)"
      | attribute       | value                    |
      | backgroundColor | rgba(250, 132, 132, 0.8) |

  @SID_15
  Scenario: Validate Top used Ciphers
    Then UI Text of "Virtual Service.SSL.TopUsedCiphers_cipherName" with extension "0" equal to "ECDHE-RSA-CHACHA20-POLY1305-OLD"
    Then UI Text of "Virtual Service.SSL.TopUsedCiphers_value" with extension "0" equal to "50%"
    Then UI Validate element "Virtual Service.SSL.TopUsedCiphers_progress" attribute with param "0"
      | name  | value      |
      | style | width: 50% |


    Then UI Text of "Virtual Service.SSL.TopUsedCiphers_cipherName" with extension "1" equal to "ECDHE_ECDSA_CHACHA20_POLY1305_SHA_256"
    Then UI Text of "Virtual Service.SSL.TopUsedCiphers_value" with extension "1" equal to "25%"
    Then UI Validate element "Virtual Service.SSL.TopUsedCiphers_progress" attribute with param "1"
      | name  | value      |
      | style | width: 25% |

    Then UI Text of "Virtual Service.SSL.TopUsedCiphers_cipherName" with extension "2" equal to "ECDHE-ECDSA-CHACHA20-POLY1305-OLD"
    Then UI Text of "Virtual Service.SSL.TopUsedCiphers_value" with extension "2" equal to "13%"
    Then UI Validate element "Virtual Service.SSL.TopUsedCiphers_progress" attribute with param "2"
      | name  | value      |
      | style | width: 13% |

    Then UI Text of "Virtual Service.SSL.TopUsedCiphers_cipherName" with extension "3" equal to "ECDHE_RSA_AES_128_CBC_SHA_256"
    Then UI Text of "Virtual Service.SSL.TopUsedCiphers_value" with extension "3" equal to "6%"
    Then UI Validate element "Virtual Service.SSL.TopUsedCiphers_progress" attribute with param "3"
      | name  | value     |
      | style | width: 6% |

    Then UI Text of "Virtual Service.SSL.TopUsedCiphers_cipherName" with extension "4" equal to "ECDHE_ECDSA_AES_128_GCM_SHA_256"
    Then UI Text of "Virtual Service.SSL.TopUsedCiphers_value" with extension "4" equal to "3%"
    Then UI Validate element "Virtual Service.SSL.TopUsedCiphers_progress" attribute with param "4"
      | name  | value     |
      | style | width: 3% |

  @SID_16
  Scenario: Cleanup
    Then UI logout and close browser
