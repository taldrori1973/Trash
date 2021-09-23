@VRM @TC106041 @Debug
Feature: Cloud WAF API

  @SID_1
  Scenario: install VRM license in case it was removed
    Given CLI Reset radware password
    Then REST Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
#    Then REST Vision Install License Request "vision-reporting-module-ADC"

  @SID_2
  Scenario: /collector/device/config
  When CLI Run remote linux Command "echo "Cleared" > "/home/radware/config?noauth"" on "GENERIC_LINUX_SERVER"
  When CLI Run remote linux Command "cat /home/radware/config\?noauth |grep "Cleared" |wc -l" on "GENERIC_LINUX_SERVER"
  Then CLI Operations - Verify that output contains regex "\b1\b"
  When CLI Run remote linux Command "result=`curl -ks -X "POST" "https://172.17.164.101/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"radware\",\"password\": \"radware\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -ks -XGET -H "Cookie: JSESSIONID=$jsession" https://172.17.164.101/mgmt/collector/device/config?noauth > /home/radware/config\?noauth" on "GENERIC_LINUX_SERVER"
  When CLI Run remote linux Command "cat /home/radware/config\?noauth |grep '\"deviceIp\":\"172.16.22.50\"' |wc -l" on "GENERIC_LINUX_SERVER"
  Then CLI Operations - Verify that output contains regex "\b1\b"
  When CLI Run remote linux Command "cat /home/radware/config\?noauth |grep '\"monitored\":true' |wc -l" on "GENERIC_LINUX_SERVER"
  Then CLI Operations - Verify that output contains regex "\b1\b"

  @SID_3
  Scenario: /collector/device/devicesview
    When CLI Run remote linux Command "echo "Cleared" > "/home/radware/devicesview?noauth"" on "GENERIC_LINUX_SERVER"
    When CLI Run remote linux Command "cat /home/radware/devicesview\?noauth |grep "Cleared" |wc -l" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "\b1\b"
    When CLI Run remote linux Command "result=`curl -ks -X "POST" "https://172.17.164.101/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"radware\",\"password\": \"radware\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -ks -XGET -H "Cookie: JSESSIONID=$jsession" https://172.17.164.101/mgmt/collector/device/devicesview?noauth > /home/radware/devicesview\?noauth" on "GENERIC_LINUX_SERVER"
    When CLI Run remote linux Command "cat /home/radware/devicesview\?noauth |grep '\"deviceIp\":\"172.16.22.50\",\"portName\":\"5\",\"portDirection\":\"2\"' |wc -l" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "\b1\b"
