@Analytics_ADC @TC106063

Feature: MSSP Login APIs

  @SID_1
  Scenario: kill all simulation on current vision and register as mssp
    * CLI kill all simulator attacks on current vision
    Then CLI Operations - Run Root Session command "echo -e "ip.address=172.17.164.10\nhttp.user.name=msspportal\nhttp.password=msspportal\nauth=basic" > /opt/radware/mgt-server/properties/mssp.properties"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 360

  @SID_2
  Scenario: /mgmt/monitor/security/devices/status/bulk
#    Then CLI Run linux Command "result=`curl -ks -X "POST" "https://172.17.164.104/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"msspportal\",\"password\": \"msspportal\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -X GET -s -o /dev/null --insecure -w 'RESP_CODE:%{response_code} \n' -d'{"devicesFilter": null}' -H "Content-Type: application/json" -H "cookie: JSESSIONID=$jsession" https://172.17.164.104:443/mgmt/monitor/security/devices/status/bulk" on "GENERIC_LINUX_SERVER" and validate result EQUALS "RESP_CODE:200"
    Then CLI Run remote linux Command "result=`curl -ks -X "POST" "https://172.17.164.104/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"msspportal\",\"password\": \"msspportal\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -X GET -s -o /dev/null --insecure -w 'RESP_CODE:%{response_code} \n' -d'{"devicesFilter": null}' -H "Content-Type: application/json" -H "cookie: JSESSIONID=$jsession" https://172.17.164.104:443/mgmt/monitor/security/devices/status/bulk" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"
  @SID_3
  Scenario: /mgmt/monitor/security/dp/attacks/bulk
#    Then CLI Run linux Command "result=`curl -ks -X "POST" "https://172.17.164.104/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"msspportal\",\"password\": \"msspportal\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -X POST -s -o /dev/null --insecure -w 'RESP_CODE:%{response_code} \n' -d'{"devicesFilter": null}' -H "Content-Type: application/json" -H "cookie: JSESSIONID=$jsession" https://172.17.164.104:443/mgmt/monitor/security/dp/attacks/bulk" on "GENERIC_LINUX_SERVER" and validate result EQUALS "RESP_CODE:200"
    Then CLI Run remote linux Command "result=`curl -ks -X "POST" "https://172.17.164.104/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"msspportal\",\"password\": \"msspportal\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -X POST -s -o /dev/null --insecure -w 'RESP_CODE:%{response_code} \n' -d'{"devicesFilter": null}' -H "Content-Type: application/json" -H "cookie: JSESSIONID=$jsession" https://172.17.164.104:443/mgmt/monitor/security/dp/attacks/bulk" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"
  @SID_4
  Scenario: /mgmt/monitor/security/df/traffic/utilization/last_sample/bulk
#    Then CLI Run linux Command "result=`curl -ks -X "POST" "https://172.17.164.104/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"msspportal\",\"password\": \"msspportal\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -X POST -s -o /dev/null --insecure -w 'RESP_CODE:%{response_code} \n' -d'{"devicesFilter": null}' -H "Content-Type: application/json" -H "cookie: JSESSIONID=$jsession" https://172.17.164.104:443/mgmt/monitor/security/df/traffic/utilization/last_sample/bulk" on "GENERIC_LINUX_SERVER" and validate result EQUALS "RESP_CODE:200"
    Then CLI Run remote linux Command "result=`curl -ks -X "POST" "https://172.17.164.104/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"msspportal\",\"password\": \"msspportal\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -X POST -s -o /dev/null --insecure -w 'RESP_CODE:%{response_code} \n' -d'{"devicesFilter": null}' -H "Content-Type: application/json" -H "cookie: JSESSIONID=$jsession" https://172.17.164.104:443/mgmt/monitor/security/df/traffic/utilization/last_sample/bulk" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"
  @SID_5
  Scenario: /mgmt/monitor/security/dp/traffic/utilization/last_sample/bulk
#    Then CLI Run linux Command "result=`curl -ks -X "POST" "https://172.17.164.104/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"msspportal\",\"password\": \"msspportal\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -X POST -s -o /dev/null --insecure -w 'RESP_CODE:%{response_code} \n' -d'{"devicesFilter": null}' -H "Content-Type: application/json" -H "cookie: JSESSIONID=$jsession" https://172.17.164.104:443/mgmt/monitor/security/dp/traffic/utilization/last_sample/bulk" on "GENERIC_LINUX_SERVER" and validate result EQUALS "RESP_CODE:200"
    Then CLI Run remote linux Command "result=`curl -ks -X "POST" "https://172.17.164.104/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"msspportal\",\"password\": \"msspportal\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -X POST -s -o /dev/null --insecure -w 'RESP_CODE:%{response_code} \n' -d'{"devicesFilter": null}' -H "Content-Type: application/json" -H "cookie: JSESSIONID=$jsession" https://172.17.164.104:443/mgmt/monitor/security/dp/traffic/utilization/last_sample/bulk" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"
