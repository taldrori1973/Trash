@TC106715

Feature:Network Dashboard - Alteon Image Type

  @SID_1
  Scenario: make ADC unreachable by route
    Then CLI Clear vision logs
    Then CLI Run remote linux Command "service vision stop" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "net route set host 50.50.101.22 50.50.77.77" on "Radware_SERVER_CLI"

#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update hardware set platform_type='5208' where form_factor_type='Standalone';"" on "ROOT_SERVER_CLI"
    Then MYSQL UPDATE "hardware" Table in "VISION_NG" Schema SET "platform_type" Column Value as "5208" WHERE "form_factor_type='Standalone'"

    Then CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI"
#    Then CLI copy "/home/radware/adc-network-raw_update_time_to_now.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage/"
    Then Sleep "90"

  @SID_2
  Scenario: Login to VRM and enter ADC devices dashboard
    Then REST Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    When UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"

  @SID_3
 Scenario: validate Alteon image and ports status - 5208
  Then UI Validate Element Existence By Label "No Data Available" if Exists "false"
  Then UI validate port number "01" for alteon name "alteon image" with params "5208" with status "UP"
  Then UI validate port number "02" for alteon name "alteon image" with params "5208" with status "UP"
  Then UI validate port number "03" for alteon name "alteon image" with params "5208" with status "UP"
  Then UI validate port number "04" for alteon name "alteon image" with params "5208" with status "UP"
  Then UI validate port number "05" for alteon name "alteon image" with params "5208" with status "UP"
  Then UI validate port number "06" for alteon name "alteon image" with params "5208" with status "DOWN"
  Then UI validate port number "07" for alteon name "alteon image" with params "5208" with status "DOWN"
  Then UI validate port number "08" for alteon name "alteon image" with params "5208" with status "DOWN"
  Then UI validate port number "09" for alteon name "alteon image" with params "5208" with status "DOWN"
  Then UI validate port number "10" for alteon name "alteon image" with params "5208" with status "DOWN"

  @SID_4
  Scenario: delete ADC bad route
    Then CLI Run remote linux Command "net route delete 50.50.101.22 255.255.255.255 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "route del -host 50.50.101.22 gw 50.50.77.77" on "ROOT_SERVER_CLI"
    Then Sleep "45"

  @SID_5
   Scenario: Logout and exit browser
     Given UI logout and close browser

  @SID_6
  Scenario: Manipulate ADC platform in mysql and restart service
    Then CLI Run remote linux Command "service vision stop" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "net route set host 50.50.101.22 50.50.77.77" on "Radware_SERVER_CLI"

#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update hardware set platform_type='8820' where form_factor_type='Standalone';"" on "ROOT_SERVER_CLI"
    Then MYSQL UPDATE "hardware" Table in "VISION_NG" Schema SET "platform_type" Column Value as "8820" WHERE "form_factor_type='Standalone'"
    Then CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI"
    Then Sleep "90"

  @SID_7
  Scenario: Login to VRM and enter ADC devices dashboard
    When UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"

  @SID_8
  Scenario: validate Alteon image and ports status - 8820
    Then UI Validate Element Existence By Label "No Data Available" if Exists "false"
    Then UI validate port number "01" for alteon name "alteon image" with params "8820" with status "UP"
    Then UI validate port number "02" for alteon name "alteon image" with params "8820" with status "UP"
    Then UI validate port number "03" for alteon name "alteon image" with params "8820" with status "UP"
    Then UI validate port number "04" for alteon name "alteon image" with params "8820" with status "UP"
    Then UI validate port number "05" for alteon name "alteon image" with params "8820" with status "UP"
    Then UI validate port number "06" for alteon name "alteon image" with params "8820" with status "DOWN"
    Then UI validate port number "07" for alteon name "alteon image" with params "8820" with status "DOWN"
    Then UI validate port number "08" for alteon name "alteon image" with params "8820" with status "DOWN"
    Then UI validate port number "09" for alteon name "alteon image" with params "8820" with status "DOWN"
    Then UI validate port number "10" for alteon name "alteon image" with params "8820" with status "DOWN"
    Then UI validate port number "11" for alteon name "alteon image" with params "8820" with status "DISABLED"
    Then UI validate port number "12" for alteon name "alteon image" with params "8820" with status "DISABLED"
    Then UI validate port number "13" for alteon name "alteon image" with params "8820" with status "DISABLED"
    Then UI validate port number "14" for alteon name "alteon image" with params "8820" with status "DISABLED"
    Then UI validate port number "15" for alteon name "alteon image" with params "8820" with status "DISABLED"
    Then UI validate port number "16" for alteon name "alteon image" with params "8820" with status "UNPLUGGED"
    Then UI validate port number "17" for alteon name "alteon image" with params "8820" with status "UNPLUGGED"
    Then UI validate port number "18" for alteon name "alteon image" with params "8820" with status "UNPLUGGED"
    Then UI validate port number "19" for alteon name "alteon image" with params "8820" with status "UNPLUGGED"
    Then UI validate port number "20" for alteon name "alteon image" with params "8820" with status "UNPLUGGED"
    Then UI validate port number "21" for alteon name "alteon image" with params "8820" with status "UNDEFINED"
    Then UI validate port number "22" for alteon name "alteon image" with params "8820" with status "UNDEFINED"
    Then UI validate port number "23" for alteon name "alteon image" with params "8820" with status "UNDEFINED"
    Then UI validate port number "24" for alteon name "alteon image" with params "8820" with status "UNDEFINED"
    Then UI validate port number "25" for alteon name "alteon image" with params "8820" with status "UNDEFINED"
    Then UI validate port number "26" for alteon name "alteon image" with params "8820" with status "UNDEFINED"
    Then UI validate port number "27" for alteon name "alteon image" with params "8820" with status "UNDEFINED"
    Then UI validate port number "28" for alteon name "alteon image" with params "8820" with status "UNDEFINED"

  @SID_9
  Scenario: delete ADC bad route
    Then CLI Run remote linux Command "net route delete 50.50.101.22 255.255.255.255 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "route del -host 50.50.101.22 gw 50.50.77.77" on "ROOT_SERVER_CLI"
    Then Sleep "45"

  @SID_10
  Scenario: Logout and exit browser
    Given UI logout and close browser

  @SID_11
  Scenario: Manipulate ADC platform in mysql and restart service
    Then CLI Run remote linux Command "service vision stop" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "net route set host 50.50.101.22 50.50.77.77" on "Radware_SERVER_CLI"

#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update hardware set platform_type='9800' where form_factor_type='Standalone';"" on "ROOT_SERVER_CLI"
    Then MYSQL UPDATE "hardware" Table in "VISION_NG" Schema SET "platform_type" Column Value as "9800" WHERE "form_factor_type='Standalone'"

    Then CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI"
    Then Sleep "90"

  @SID_12
  Scenario: Login to VRM and enter ADC devices dashboard
    When UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"

  @SID_13
  Scenario: validate Alteon image and ports status - 9800
    Then UI Validate Element Existence By Label "No Data Available" if Exists "false"
    Then UI validate port number "01" for alteon name "alteon image" with params "9800" with status "UP"
    Then UI validate port number "02" for alteon name "alteon image" with params "9800" with status "UP"
    Then UI validate port number "03" for alteon name "alteon image" with params "9800" with status "UP"
    Then UI validate port number "04" for alteon name "alteon image" with params "9800" with status "UP"
    Then UI validate port number "05" for alteon name "alteon image" with params "9800" with status "UP"
    Then UI validate port number "06" for alteon name "alteon image" with params "9800" with status "DOWN"
    Then UI validate port number "07" for alteon name "alteon image" with params "9800" with status "DOWN"
    Then UI validate port number "08" for alteon name "alteon image" with params "9800" with status "DOWN"

  @SID_14
  Scenario: delete ADC bad route
    Then CLI Run remote linux Command "net route delete 50.50.101.22 255.255.255.255 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "route del -host 50.50.101.22 gw 50.50.77.77" on "ROOT_SERVER_CLI"
    Then Sleep "45"

  @SID_15
  Scenario: Logout and exit browser
    Given UI logout and close browser

  @SID_16
  Scenario: Manipulate ADC platform in mysql and restart service
    Then CLI Run remote linux Command "service vision stop" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "net route set host 50.50.101.22 50.50.77.77" on "Radware_SERVER_CLI"


#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update hardware set platform_type='4208' where form_factor_type='Standalone';"" on "ROOT_SERVER_CLI"
    Then MYSQL UPDATE "hardware" Table in "VISION_NG" Schema SET "platform_type" Column Value as "4208" WHERE "form_factor_type='Standalone'"

    Then CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI"
    Then Sleep "90"

  @SID_17
  Scenario: Login to VRM and enter ADC devices dashboard
    When UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"

  @SID_18
  Scenario: validate Alteon image and ports status - 4208
    Then UI Validate Element Existence By Label "No Data Available" if Exists "false"
    Then UI validate port number "01" for alteon name "alteon image" with params "4208" with status "UP"
    Then UI validate port number "02" for alteon name "alteon image" with params "4208" with status "UP"
    Then UI validate port number "03" for alteon name "alteon image" with params "4208" with status "UP"
    Then UI validate port number "04" for alteon name "alteon image" with params "4208" with status "UP"
    Then UI validate port number "05" for alteon name "alteon image" with params "4208" with status "UP"
    Then UI validate port number "06" for alteon name "alteon image" with params "4208" with status "DOWN"
    Then UI validate port number "07" for alteon name "alteon image" with params "4208" with status "DOWN"
    Then UI validate port number "08" for alteon name "alteon image" with params "4208" with status "DOWN"
    Then UI validate port number "09" for alteon name "alteon image" with params "4208" with status "DOWN"
    Then UI validate port number "10" for alteon name "alteon image" with params "4208" with status "DOWN"

  @SID_19
  Scenario: delete ADC bad route
    Then CLI Run remote linux Command "net route delete 50.50.101.22 255.255.255.255 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "route del -host 50.50.101.22 gw 50.50.77.77" on "ROOT_SERVER_CLI"
    Then Sleep "45"

  @SID_20
  Scenario: Logout and exit browser
    Given UI logout and close browser

  @SID_21
  Scenario: Manipulate ADC platform in mysql and restart service
    Then CLI Run remote linux Command "service vision stop" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "net route set host 50.50.101.22 50.50.77.77" on "Radware_SERVER_CLI"

#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update hardware set platform_type='7220' where form_factor_type='Standalone';"" on "ROOT_SERVER_CLI"
    Then MYSQL UPDATE "hardware" Table in "VISION_NG" Schema SET "platform_type" Column Value as "7220" WHERE "form_factor_type='Standalone'"

    Then CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI"
    Then Sleep "90"

  @SID_22
  Scenario: Login to VRM and enter ADC devices dashboard
    When UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"

  @SID_23
  Scenario: validate Alteon image and ports status - 7220
    Then UI Validate Element Existence By Label "No Data Available" if Exists "false"
    Then UI validate port number "01" for alteon name "alteon image" with params "7220" with status "UP"
    Then UI validate port number "02" for alteon name "alteon image" with params "7220" with status "UP"
    Then UI validate port number "03" for alteon name "alteon image" with params "7220" with status "UP"
    Then UI validate port number "04" for alteon name "alteon image" with params "7220" with status "UP"
    Then UI validate port number "05" for alteon name "alteon image" with params "7220" with status "UP"
    Then UI validate port number "06" for alteon name "alteon image" with params "7220" with status "DOWN"
    Then UI validate port number "07" for alteon name "alteon image" with params "7220" with status "DOWN"
    Then UI validate port number "08" for alteon name "alteon image" with params "7220" with status "DOWN"
    Then UI validate port number "09" for alteon name "alteon image" with params "7220" with status "DOWN"
    Then UI validate port number "10" for alteon name "alteon image" with params "7220" with status "DOWN"
    Then UI validate port number "11" for alteon name "alteon image" with params "7220" with status "DISABLED"
    Then UI validate port number "12" for alteon name "alteon image" with params "7220" with status "DISABLED"
    Then UI validate port number "13" for alteon name "alteon image" with params "7220" with status "DISABLED"
    Then UI validate port number "14" for alteon name "alteon image" with params "7220" with status "DISABLED"
    Then UI validate port number "15" for alteon name "alteon image" with params "7220" with status "DISABLED"
    Then UI validate port number "16" for alteon name "alteon image" with params "7220" with status "UNPLUGGED"
    Then UI validate port number "17" for alteon name "alteon image" with params "7220" with status "UNPLUGGED"
    Then UI validate port number "18" for alteon name "alteon image" with params "7220" with status "UNPLUGGED"
    Then UI validate port number "19" for alteon name "alteon image" with params "7220" with status "UNPLUGGED"
    Then UI validate port number "20" for alteon name "alteon image" with params "7220" with status "UNPLUGGED"
    Then UI validate port number "21" for alteon name "alteon image" with params "7220" with status "UNDEFINED"
    Then UI validate port number "22" for alteon name "alteon image" with params "7220" with status "UNDEFINED"

  @SID_24
  Scenario: delete ADC bad route
    Then CLI Run remote linux Command "net route delete 50.50.101.22 255.255.255.255 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "route del -host 50.50.101.22 gw 50.50.77.77" on "ROOT_SERVER_CLI"
    Then Sleep "45"

  @SID_25
  Scenario: Logout and exit browser
    Given UI logout and close browser

  @SID_26
  Scenario: Manipulate ADC platform in mysql and restart service
    Then CLI Run remote linux Command "service vision stop" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "net route set host 50.50.101.22 50.50.77.77" on "Radware_SERVER_CLI"

#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update hardware set platform_type='6024' where form_factor_type='Standalone';"" on "ROOT_SERVER_CLI"
    Then MYSQL UPDATE "hardware" Table in "VISION_NG" Schema SET "platform_type" Column Value as "6024" WHERE "form_factor_type='Standalone'"

    Then CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI"
    Then Sleep "90"

  @SID_27
  Scenario: Login to VRM and enter ADC devices dashboard
    When UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"

  @SID_28
  Scenario: validate Alteon image and ports status - 6024
    Then UI Validate Element Existence By Label "No Data Available" if Exists "false"
    Then UI validate port number "01" for alteon name "alteon image" with params "6024" with status "UP"
    Then UI validate port number "02" for alteon name "alteon image" with params "6024" with status "UP"
    Then UI validate port number "03" for alteon name "alteon image" with params "6024" with status "UP"
    Then UI validate port number "04" for alteon name "alteon image" with params "6024" with status "UP"
    Then UI validate port number "05" for alteon name "alteon image" with params "6024" with status "UP"
    Then UI validate port number "06" for alteon name "alteon image" with params "6024" with status "DOWN"
    Then UI validate port number "07" for alteon name "alteon image" with params "6024" with status "DOWN"
    Then UI validate port number "08" for alteon name "alteon image" with params "6024" with status "DOWN"
    Then UI validate port number "09" for alteon name "alteon image" with params "6024" with status "DOWN"
    Then UI validate port number "10" for alteon name "alteon image" with params "6024" with status "DOWN"
    Then UI validate port number "11" for alteon name "alteon image" with params "6024" with status "DISABLED"
    Then UI validate port number "12" for alteon name "alteon image" with params "6024" with status "DISABLED"
    Then UI validate port number "13" for alteon name "alteon image" with params "6024" with status "DISABLED"
    Then UI validate port number "14" for alteon name "alteon image" with params "6024" with status "DISABLED"
    Then UI validate port number "15" for alteon name "alteon image" with params "6024" with status "DISABLED"
    Then UI validate port number "16" for alteon name "alteon image" with params "6024" with status "UNPLUGGED"
    Then UI validate port number "17" for alteon name "alteon image" with params "6024" with status "UNPLUGGED"
    Then UI validate port number "18" for alteon name "alteon image" with params "6024" with status "UNPLUGGED"
    Then UI validate port number "19" for alteon name "alteon image" with params "6024" with status "UNPLUGGED"
    Then UI validate port number "20" for alteon name "alteon image" with params "6024" with status "UNPLUGGED"
    Then UI validate port number "21" for alteon name "alteon image" with params "6024" with status "UNDEFINED"
    Then UI validate port number "22" for alteon name "alteon image" with params "6024" with status "UNDEFINED"
    Then UI validate port number "23" for alteon name "alteon image" with params "6024" with status "UNDEFINED"
    Then UI validate port number "24" for alteon name "alteon image" with params "6024" with status "UNDEFINED"

  @SID_29
  Scenario: delete ADC bad route
    Then CLI Run remote linux Command "net route delete 50.50.101.22 255.255.255.255 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "route del -host 50.50.101.22 gw 50.50.77.77" on "ROOT_SERVER_CLI"
    Then Sleep "45"

  @SID_30
  Scenario: Logout and exit browser
    Given UI logout and close browser

  @SID_31
  Scenario: Manipulate ADC platform in mysql and restart service
    Then CLI Run remote linux Command "service vision stop" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "net route set host 50.50.101.22 50.50.77.77" on "Radware_SERVER_CLI"


#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update hardware set platform_type='4024' where form_factor_type='Standalone';"" on "ROOT_SERVER_CLI"
    Then MYSQL UPDATE "hardware" Table in "VISION_NG" Schema SET "platform_type" Column Value as "4024" WHERE "form_factor_type='Standalone'"

    Then CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI"
    Then Sleep "90"

  @SID_32
  Scenario: Login to VRM and enter ADC devices dashboard
    When UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"

  @SID_33
  Scenario: validate Alteon image and ports status - 4024
    Then UI Validate Element Existence By Label "No Data Available" if Exists "false"
    Then UI validate port number "01" for alteon name "alteon image" with params "4024" with status "UP"
    Then UI validate port number "02" for alteon name "alteon image" with params "4024" with status "UP"
    Then UI validate port number "03" for alteon name "alteon image" with params "4024" with status "UP"
    Then UI validate port number "04" for alteon name "alteon image" with params "4024" with status "UP"
    Then UI validate port number "05" for alteon name "alteon image" with params "4024" with status "UP"
    Then UI validate port number "06" for alteon name "alteon image" with params "4024" with status "DOWN"
    Then UI validate port number "07" for alteon name "alteon image" with params "4024" with status "DOWN"
    Then UI validate port number "08" for alteon name "alteon image" with params "4024" with status "DOWN"
    Then UI validate port number "09" for alteon name "alteon image" with params "4024" with status "DOWN"
    Then UI validate port number "10" for alteon name "alteon image" with params "4024" with status "DOWN"

  @SID_34
  Scenario: delete ADC bad route
    Then CLI Run remote linux Command "net route delete 50.50.101.22 255.255.255.255 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "route del -host 50.50.101.22 gw 50.50.77.77" on "ROOT_SERVER_CLI"
    Then Sleep "45"

  @SID_35
  Scenario: Logout and exit browser
    Given UI logout and close browser

  @SID_36
  Scenario: Manipulate ADC platform in mysql and restart service
    Then CLI Run remote linux Command "service vision stop" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "net route set host 50.50.101.22 50.50.77.77" on "Radware_SERVER_CLI"

#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update hardware set platform_type='7612' where form_factor_type='Standalone';"" on "ROOT_SERVER_CLI"
    Then MYSQL UPDATE "hardware" Table in "VISION_NG" Schema SET "platform_type" Column Value as "7612" WHERE "form_factor_type='Standalone'"

    Then CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI"
    Then Sleep "90"

  @SID_37
  Scenario: Login to VRM and enter ADC devices dashboard
    When UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"

  @SID_38
  Scenario: validate Alteon image and ports status - 7612
    Then UI Validate Element Existence By Label "No Data Available" if Exists "false"
    Then UI validate port number "01" for alteon name "alteon image" with params "7612" with status "UP"
    Then UI validate port number "02" for alteon name "alteon image" with params "7612" with status "UP"
    Then UI validate port number "03" for alteon name "alteon image" with params "7612" with status "UP"
    Then UI validate port number "04" for alteon name "alteon image" with params "7612" with status "UP"
    Then UI validate port number "05" for alteon name "alteon image" with params "7612" with status "UP"
    Then UI validate port number "06" for alteon name "alteon image" with params "7612" with status "DOWN"
    Then UI validate port number "07" for alteon name "alteon image" with params "7612" with status "DOWN"
    Then UI validate port number "08" for alteon name "alteon image" with params "7612" with status "DOWN"
    Then UI validate port number "09" for alteon name "alteon image" with params "7612" with status "DOWN"
    Then UI validate port number "10" for alteon name "alteon image" with params "7612" with status "DOWN"
    Then UI validate port number "11" for alteon name "alteon image" with params "7612" with status "DISABLED"
    Then UI validate port number "12" for alteon name "alteon image" with params "7612" with status "DISABLED"
    Then UI validate port number "13" for alteon name "alteon image" with params "7612" with status "DISABLED"
    Then UI validate port number "14" for alteon name "alteon image" with params "7612" with status "DISABLED"
    Then UI validate port number "15" for alteon name "alteon image" with params "7612" with status "DISABLED"
    Then UI validate port number "16" for alteon name "alteon image" with params "7612" with status "UNPLUGGED"
    Then UI validate port number "17" for alteon name "alteon image" with params "7612" with status "UNPLUGGED"
    Then UI validate port number "18" for alteon name "alteon image" with params "7612" with status "UNPLUGGED"

  @SID_39
  Scenario: delete ADC bad route
    Then CLI Run remote linux Command "net route delete 50.50.101.22 255.255.255.255 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "route del -host 50.50.101.22 gw 50.50.77.77" on "ROOT_SERVER_CLI"
    Then Sleep "45"

  @SID_40
  Scenario: Logout and exit browser
    Given UI logout and close browser

  @SID_41
  Scenario: Manipulate ADC platform in mysql and restart service
    Then CLI Run remote linux Command "service vision stop" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "net route set host 50.50.101.22 50.50.77.77" on "Radware_SERVER_CLI"

#    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update hardware set platform_type='8420' where form_factor_type='Standalone';"" on "ROOT_SERVER_CLI"
    Then MYSQL UPDATE "hardware" Table in "VISION_NG" Schema SET "platform_type" Column Value as "8420" WHERE "form_factor_type='Standalone'"

    Then CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI"
    Then Sleep "90"

  @SID_42
  Scenario: Login to VRM and enter ADC devices dashboard
    When UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"

  @SID_43
  Scenario: validate Alteon image and ports status - 8420
    Then UI Validate Element Existence By Label "No Data Available" if Exists "false"
    Then UI validate port number "01" for alteon name "alteon image" with params "8420" with status "UP"
    Then UI validate port number "02" for alteon name "alteon image" with params "8420" with status "UP"
    Then UI validate port number "03" for alteon name "alteon image" with params "8420" with status "UP"
    Then UI validate port number "04" for alteon name "alteon image" with params "8420" with status "UP"
    Then UI validate port number "05" for alteon name "alteon image" with params "8420" with status "UP"
    Then UI validate port number "06" for alteon name "alteon image" with params "8420" with status "DOWN"
    Then UI validate port number "07" for alteon name "alteon image" with params "8420" with status "DOWN"
    Then UI validate port number "08" for alteon name "alteon image" with params "8420" with status "DOWN"
    Then UI validate port number "09" for alteon name "alteon image" with params "8420" with status "DOWN"
    Then UI validate port number "10" for alteon name "alteon image" with params "8420" with status "DOWN"
    Then UI validate port number "11" for alteon name "alteon image" with params "8420" with status "DISABLED"
    Then UI validate port number "12" for alteon name "alteon image" with params "8420" with status "DISABLED"
    Then UI validate port number "13" for alteon name "alteon image" with params "8420" with status "DISABLED"
    Then UI validate port number "14" for alteon name "alteon image" with params "8420" with status "DISABLED"
    Then UI validate port number "15" for alteon name "alteon image" with params "8420" with status "DISABLED"
    Then UI validate port number "16" for alteon name "alteon image" with params "8420" with status "UNPLUGGED"
    Then UI validate port number "17" for alteon name "alteon image" with params "8420" with status "UNPLUGGED"
    Then UI validate port number "18" for alteon name "alteon image" with params "8420" with status "UNPLUGGED"
    Then UI validate port number "19" for alteon name "alteon image" with params "8420" with status "UNPLUGGED"
    Then UI validate port number "20" for alteon name "alteon image" with params "8420" with status "UNPLUGGED"
    Then UI validate port number "21" for alteon name "alteon image" with params "8420" with status "UNDEFINED"
    Then UI validate port number "22" for alteon name "alteon image" with params "8420" with status "UNDEFINED"
    Then UI validate port number "23" for alteon name "alteon image" with params "8420" with status "UNDEFINED"
    Then UI validate port number "24" for alteon name "alteon image" with params "8420" with status "UNDEFINED"

  @SID_44
  Scenario: delete ADC bad route
    Then CLI Run remote linux Command "net route delete 50.50.101.22 255.255.255.255 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "route del -host 50.50.101.22 gw 50.50.77.77" on "ROOT_SERVER_CLI"
    Then Sleep "45"

  @SID_45
  Scenario: Logout and exit browser
    Given UI logout and close browser

  @SID_46
  Scenario: Manipulate ADC platform in mysql and restart service
    Then CLI Run remote linux Command "service vision stop" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "net route set host 50.50.101.22 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update hardware set platform_type='6420' where form_factor_type='Standalone';"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI"
    Then Sleep "90"

  @SID_47
  Scenario: Login to VRM and enter ADC devices dashboard
    When UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"

  @SID_48
  Scenario: validate Alteon image and ports status - 6420
    Then UI Validate Element Existence By Label "No Data Available" if Exists "false"
    Then UI validate port number "01" for alteon name "alteon image" with params "6420" with status "UP"
    Then UI validate port number "02" for alteon name "alteon image" with params "6420" with status "UP"
    Then UI validate port number "03" for alteon name "alteon image" with params "6420" with status "UP"
    Then UI validate port number "04" for alteon name "alteon image" with params "6420" with status "UP"
    Then UI validate port number "05" for alteon name "alteon image" with params "6420" with status "UP"
    Then UI validate port number "06" for alteon name "alteon image" with params "6420" with status "DOWN"
    Then UI validate port number "07" for alteon name "alteon image" with params "6420" with status "DOWN"
    Then UI validate port number "08" for alteon name "alteon image" with params "6420" with status "DOWN"
    Then UI validate port number "09" for alteon name "alteon image" with params "6420" with status "DOWN"
    Then UI validate port number "10" for alteon name "alteon image" with params "6420" with status "DOWN"
    Then UI validate port number "11" for alteon name "alteon image" with params "6420" with status "DISABLED"
    Then UI validate port number "12" for alteon name "alteon image" with params "6420" with status "DISABLED"
    Then UI validate port number "13" for alteon name "alteon image" with params "6420" with status "DISABLED"
    Then UI validate port number "14" for alteon name "alteon image" with params "6420" with status "DISABLED"
    Then UI validate port number "15" for alteon name "alteon image" with params "6420" with status "DISABLED"
    Then UI validate port number "16" for alteon name "alteon image" with params "6420" with status "UNPLUGGED"
    Then UI validate port number "17" for alteon name "alteon image" with params "6420" with status "UNPLUGGED"
    Then UI validate port number "18" for alteon name "alteon image" with params "6420" with status "UNPLUGGED"
    Then UI validate port number "19" for alteon name "alteon image" with params "6420" with status "UNPLUGGED"
    Then UI validate port number "20" for alteon name "alteon image" with params "6420" with status "UNPLUGGED"
    Then UI validate port number "21" for alteon name "alteon image" with params "6420" with status "UNDEFINED"
    Then UI validate port number "22" for alteon name "alteon image" with params "6420" with status "UNDEFINED"
    Then UI validate port number "23" for alteon name "alteon image" with params "6420" with status "UNDEFINED"
    Then UI validate port number "24" for alteon name "alteon image" with params "6420" with status "UNDEFINED"

  @SID_49
  Scenario: delete ADC bad route
    Then CLI Run remote linux Command "net route delete 50.50.101.22 255.255.255.255 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "route del -host 50.50.101.22 gw 50.50.77.77" on "ROOT_SERVER_CLI"
    Then Sleep "45"

  @SID_50
  Scenario: Logout and exit browser
    Given UI logout and close browser

  @SID_51
  Scenario: Manipulate ADC platform in mysql and restart service
    Then CLI Run remote linux Command "service vision stop" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "net route set host 50.50.101.22 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update hardware set platform_type='5224' where form_factor_type='Standalone';"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI"
    Then Sleep "90"

  @SID_52
  Scenario: Login to VRM and enter ADC devices dashboard
    When UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"

  @SID_53
  Scenario: validate Alteon image and ports status - 5224
    Then UI Validate Element Existence By Label "No Data Available" if Exists "false"
    Then UI validate port number "01" for alteon name "alteon image" with params "5224" with status "UP"
    Then UI validate port number "02" for alteon name "alteon image" with params "5224" with status "UP"
    Then UI validate port number "03" for alteon name "alteon image" with params "5224" with status "UP"
    Then UI validate port number "04" for alteon name "alteon image" with params "5224" with status "UP"
    Then UI validate port number "05" for alteon name "alteon image" with params "5224" with status "UP"
    Then UI validate port number "06" for alteon name "alteon image" with params "5224" with status "DOWN"
    Then UI validate port number "07" for alteon name "alteon image" with params "5224" with status "DOWN"
    Then UI validate port number "08" for alteon name "alteon image" with params "5224" with status "DOWN"
    Then UI validate port number "09" for alteon name "alteon image" with params "5224" with status "DOWN"
    Then UI validate port number "10" for alteon name "alteon image" with params "5224" with status "DOWN"
    Then UI validate port number "11" for alteon name "alteon image" with params "5224" with status "DISABLED"
    Then UI validate port number "12" for alteon name "alteon image" with params "5224" with status "DISABLED"
    Then UI validate port number "13" for alteon name "alteon image" with params "5224" with status "DISABLED"
    Then UI validate port number "14" for alteon name "alteon image" with params "5224" with status "DISABLED"
    Then UI validate port number "15" for alteon name "alteon image" with params "5224" with status "DISABLED"
    Then UI validate port number "16" for alteon name "alteon image" with params "5224" with status "UNPLUGGED"
    Then UI validate port number "17" for alteon name "alteon image" with params "5224" with status "UNPLUGGED"
    Then UI validate port number "18" for alteon name "alteon image" with params "5224" with status "UNPLUGGED"
    Then UI validate port number "19" for alteon name "alteon image" with params "5224" with status "UNPLUGGED"
    Then UI validate port number "20" for alteon name "alteon image" with params "5224" with status "UNPLUGGED"
    Then UI validate port number "21" for alteon name "alteon image" with params "5224" with status "UNDEFINED"
    Then UI validate port number "22" for alteon name "alteon image" with params "5224" with status "UNDEFINED"
    Then UI validate port number "23" for alteon name "alteon image" with params "5224" with status "UNDEFINED"
    Then UI validate port number "24" for alteon name "alteon image" with params "5224" with status "UNDEFINED"
    Then UI validate port number "25" for alteon name "alteon image" with params "5224" with status "UNDEFINED"
    Then UI validate port number "26" for alteon name "alteon image" with params "5224" with status "UNDEFINED"

  @SID_54
  Scenario: delete ADC bad route
    Then CLI Run remote linux Command "net route delete 50.50.101.22 255.255.255.255 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "route del -host 50.50.101.22 gw 50.50.77.77" on "ROOT_SERVER_CLI"
    Then Sleep "45"

  @SID_55
  Scenario: Logout and exit browser
    Given UI logout and close browser

  @SID_56
  Scenario: Manipulate ADC platform in mysql and restart service
    Then CLI Run remote linux Command "service vision stop" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "net route set host 50.50.101.22 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update hardware set platform_type='VA' where form_factor_type='Standalone';"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI"
    Then Sleep "90"

  @SID_57
  Scenario: Login to VRM and enter ADC devices dashboard
    When UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"

  @SID_58
  Scenario: validate Alteon image and ports status - VA
    Then UI Validate Element Existence By Label "No Data Available" if Exists "false"
    Then UI validate port number "01" for alteon name "alteon image" with params "VA" with status "UP"
    Then UI validate port number "02" for alteon name "alteon image" with params "VA" with status "UP"
    Then UI validate port number "03" for alteon name "alteon image" with params "VA" with status "UP"
    Then UI validate port number "04" for alteon name "alteon image" with params "VA" with status "UP"
    Then UI validate port number "05" for alteon name "alteon image" with params "VA" with status "UP"
    Then UI validate port number "06" for alteon name "alteon image" with params "VA" with status "DOWN"
    Then UI validate port number "07" for alteon name "alteon image" with params "VA" with status "DOWN"
    Then UI validate port number "08" for alteon name "alteon image" with params "VA" with status "DOWN"
    Then UI validate port number "09" for alteon name "alteon image" with params "VA" with status "DOWN"
    Then UI validate port number "10" for alteon name "alteon image" with params "VA" with status "DOWN"
    Then UI validate port number "11" for alteon name "alteon image" with params "VA" with status "DISABLED"
    Then UI validate port number "12" for alteon name "alteon image" with params "VA" with status "DISABLED"
    Then UI validate port number "13" for alteon name "alteon image" with params "VA" with status "DISABLED"
    Then UI validate port number "14" for alteon name "alteon image" with params "VA" with status "DISABLED"
    Then UI validate port number "15" for alteon name "alteon image" with params "VA" with status "DISABLED"
    Then UI validate port number "16" for alteon name "alteon image" with params "VA" with status "UNPLUGGED"

  @SID_59
  Scenario: delete ADC bad route
    Then CLI Run remote linux Command "net route delete 50.50.101.22 255.255.255.255 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "route del -host 50.50.101.22 gw 50.50.77.77" on "ROOT_SERVER_CLI"
    Then Sleep "45"

  @SID_60
  Scenario: Logout and exit browser
    Given UI logout and close browser

  @SID_61
  Scenario: Manipulate ADC platform in mysql and restart service
    Then CLI Run remote linux Command "service vision stop" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "net route set host 50.50.101.22 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update hardware set platform_type='5424' where form_factor_type='Standalone';"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI"
    Then Sleep "90"

  @SID_62
  Scenario: Login to VRM and enter ADC devices dashboard
    When UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"

  @SID_63
  Scenario: validate Alteon image and ports status - 5424
    Then UI Validate Element Existence By Label "No Data Available" if Exists "false"
    Then UI validate port number "01" for alteon name "alteon image" with params "5424" with status "UP"
    Then UI validate port number "02" for alteon name "alteon image" with params "5424" with status "UP"
    Then UI validate port number "03" for alteon name "alteon image" with params "5424" with status "UP"
    Then UI validate port number "04" for alteon name "alteon image" with params "5424" with status "UP"
    Then UI validate port number "05" for alteon name "alteon image" with params "5424" with status "UP"
    Then UI validate port number "06" for alteon name "alteon image" with params "5424" with status "DOWN"
    Then UI validate port number "07" for alteon name "alteon image" with params "5424" with status "DOWN"
    Then UI validate port number "08" for alteon name "alteon image" with params "5424" with status "DOWN"
    Then UI validate port number "09" for alteon name "alteon image" with params "5424" with status "DOWN"
    Then UI validate port number "10" for alteon name "alteon image" with params "5424" with status "DOWN"
    Then UI validate port number "11" for alteon name "alteon image" with params "5424" with status "DISABLED"
    Then UI validate port number "12" for alteon name "alteon image" with params "5424" with status "DISABLED"
    Then UI validate port number "13" for alteon name "alteon image" with params "5424" with status "DISABLED"
    Then UI validate port number "14" for alteon name "alteon image" with params "5424" with status "DISABLED"
    Then UI validate port number "15" for alteon name "alteon image" with params "5424" with status "DISABLED"
    Then UI validate port number "16" for alteon name "alteon image" with params "5424" with status "UNPLUGGED"
    Then UI validate port number "17" for alteon name "alteon image" with params "5424" with status "UNPLUGGED"
    Then UI validate port number "18" for alteon name "alteon image" with params "5424" with status "UNPLUGGED"
    Then UI validate port number "19" for alteon name "alteon image" with params "5424" with status "UNPLUGGED"
    Then UI validate port number "20" for alteon name "alteon image" with params "5424" with status "UNPLUGGED"
    Then UI validate port number "21" for alteon name "alteon image" with params "5424" with status "UNDEFINED"
    Then UI validate port number "22" for alteon name "alteon image" with params "5424" with status "UNDEFINED"
    Then UI validate port number "23" for alteon name "alteon image" with params "5424" with status "UNDEFINED"
    Then UI validate port number "24" for alteon name "alteon image" with params "5424" with status "UNDEFINED"
    Then UI validate port number "25" for alteon name "alteon image" with params "5424" with status "UNDEFINED"
    Then UI validate port number "26" for alteon name "alteon image" with params "5424" with status "UNDEFINED"
    Then UI validate port number "27" for alteon name "alteon image" with params "5424" with status "UNDEFINED"
    Then UI validate port number "28" for alteon name "alteon image" with params "5424" with status "UNDEFINED"

  @SID_64
  Scenario: delete ADC bad route
    Then CLI Run remote linux Command "net route delete 50.50.101.22 255.255.255.255 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "route del -host 50.50.101.22 gw 50.50.77.77" on "ROOT_SERVER_CLI"
    Then Sleep "45"

  @SID_65
  Scenario: Logout and exit browser
    Given UI logout and close browser

  @SID_66
  Scenario: Manipulate ADC platform in mysql and restart service
    Then CLI Run remote linux Command "service vision stop" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "net route set host 50.50.101.22 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "update hardware set platform_type='5820' where form_factor_type='Standalone';"" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI"
    Then Sleep "90"

  @SID_67
  Scenario: Login to VRM and enter ADC devices dashboard
    When UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"

  @SID_68
  Scenario: validate Alteon image and ports status - 5820
    Then UI Validate Element Existence By Label "No Data Available" if Exists "false"
    Then UI validate port number "01" for alteon name "alteon image" with params "5820" with status "UP"
    Then UI validate port number "02" for alteon name "alteon image" with params "5820" with status "UP"
    Then UI validate port number "03" for alteon name "alteon image" with params "5820" with status "UP"
    Then UI validate port number "04" for alteon name "alteon image" with params "5820" with status "UP"
    Then UI validate port number "05" for alteon name "alteon image" with params "5820" with status "UP"
    Then UI validate port number "06" for alteon name "alteon image" with params "5820" with status "DOWN"
    Then UI validate port number "07" for alteon name "alteon image" with params "5820" with status "DOWN"
    Then UI validate port number "08" for alteon name "alteon image" with params "5820" with status "DOWN"
    Then UI validate port number "09" for alteon name "alteon image" with params "5820" with status "DOWN"
    Then UI validate port number "10" for alteon name "alteon image" with params "5820" with status "DOWN"
    Then UI validate port number "11" for alteon name "alteon image" with params "5820" with status "DISABLED"
    Then UI validate port number "12" for alteon name "alteon image" with params "5820" with status "DISABLED"
    Then UI validate port number "13" for alteon name "alteon image" with params "5820" with status "DISABLED"
    Then UI validate port number "14" for alteon name "alteon image" with params "5820" with status "DISABLED"
    Then UI validate port number "15" for alteon name "alteon image" with params "5820" with status "DISABLED"
    Then UI validate port number "16" for alteon name "alteon image" with params "5820" with status "UNPLUGGED"
    Then UI validate port number "17" for alteon name "alteon image" with params "5820" with status "UNPLUGGED"
    Then UI validate port number "18" for alteon name "alteon image" with params "5820" with status "UNPLUGGED"
    Then UI validate port number "19" for alteon name "alteon image" with params "5820" with status "UNPLUGGED"
    Then UI validate port number "20" for alteon name "alteon image" with params "5820" with status "UNPLUGGED"
    Then UI validate port number "21" for alteon name "alteon image" with params "5820" with status "UNDEFINED"
    Then UI validate port number "22" for alteon name "alteon image" with params "5820" with status "UNDEFINED"
    Then UI validate port number "23" for alteon name "alteon image" with params "5820" with status "UNDEFINED"
    Then UI validate port number "24" for alteon name "alteon image" with params "5820" with status "UNDEFINED"
    Then UI validate port number "25" for alteon name "alteon image" with params "5820" with status "UNDEFINED"
    Then UI validate port number "26" for alteon name "alteon image" with params "5820" with status "UNDEFINED"
    Then UI validate port number "27" for alteon name "alteon image" with params "5820" with status "UNDEFINED"
    Then UI validate port number "28" for alteon name "alteon image" with params "5820" with status "UNDEFINED"

  @SID_69
  Scenario: delete ADC bad route
    Then CLI Run remote linux Command "net route delete 50.50.101.22 255.255.255.255 50.50.77.77" on "Radware_SERVER_CLI"
    Then CLI Run remote linux Command "route del -host 50.50.101.22 gw 50.50.77.77" on "ROOT_SERVER_CLI"
    Then Sleep "45"

  @SID_70
  Scenario: Logout and exit browser
    Given UI logout and close browser

  @SID_71
  Scenario: ADC image type check logs
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal        | NOT_EXPECTED |
