@Analytics_ADC @TC106064

Feature: MSSP No Login APIs

  @SID_1
  Scenario: edit mssp.properties and restart collector
    Then CLI Run remote linux Command "sed -i 's/ip.address=*.*.*.*/ip.address=172.17.0.0\/16/g' /opt/radware/mgt-server/properties/mssp.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "sed -i 's/http.user.name=.*$/http.user.name=sd_portal/g' /opt/radware/mgt-server/properties/mssp.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "sed -i 's/http.password=.*$/http.password=sd_portal123/g' /opt/radware/mgt-server/properties/mssp.properties" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "/opt/radware/mgt-server/bin/collectors_service.sh restart" on "ROOT_SERVER_CLI" with timeOut 360

  @SID_2
  Scenario: kill all simulation on current vision
    * CLI kill all simulator attacks on current vision

  @SID_3
  Scenario: /mgmt/monitor/security/devices/status/bulk
#    Then CLI Run linux Command "curl -X GET -s -o /dev/null --insecure -w 'RESP_CODE:%{response_code} \n' -H "Content-Type: application/json" -H "Authorization: Basic c2RfcG9ydGFsOnNkX3BvcnRhbDEyMw==" https://172.17.164.104:443/mgmt/monitor/security/devices/status/bulk" on "GENERIC_LINUX_SERVER" and validate result EQUALS "RESP_CODE:200"
    Then CLI Run remote linux Command "curl -X GET -s -o /dev/null --insecure -w 'RESP_CODE:%{response_code} \n' -H "Content-Type: application/json" -H "Authorization: Basic c2RfcG9ydGFsOnNkX3BvcnRhbDEyMw==" https://172.17.164.104:443/mgmt/monitor/security/devices/status/bulk" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"
    Then CLI Run remote linux Command "curl -X GET -O --insecure -H "Content-Type: application/json" -H "Authorization: Basic c2RfcG9ydGFsOnNkX3BvcnRhbDEyMw==" https://172.17.164.104:443/mgmt/monitor/security/devices/status/bulk" on "GENERIC_LINUX_SERVER"
    Then CLI Run linux Command "grep "{\"deviceIp\":\"172.16.22.50\",\"deviceStatus\":1}" /home/radware/bulk |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"


  @SID_4
  Scenario: /mgmt/monitor/security/dp/attacks/bulk
#    Then CLI Run linux Command "nowmili=`date +%s%3N`;let "newnow=$nowmili-300000"; curl -X POST -s -o /dev/null --insecure -w 'RESP_CODE:%{response_code} \n' -d$"{\"devicesFilter\": null, \"attackIdFilter\": null, \"startTimeFilter\": null, \"endTimeFilter\": {\"lowerBound\":\"$newnow\" , \"upperBound\": null}}" -H "Content-Type: application/json" -H "Authorization: Basic c2RfcG9ydGFsOnNkX3BvcnRhbDEyMw==" https://172.17.164.104:443/mgmt/monitor/security/dp/attacks/bulk" on "GENERIC_LINUX_SERVER" and validate result EQUALS "RESP_CODE:200"
    Then CLI Run remote linux Command "nowmili=`date +%s%3N`;let "newnow=$nowmili-300000"; curl -X POST -s -o /dev/null --insecure -w 'RESP_CODE:%{response_code} \n' -d$"{\"devicesFilter\": null, \"attackIdFilter\": null, \"startTimeFilter\": null, \"endTimeFilter\": {\"lowerBound\":\"$newnow\" , \"upperBound\": null}}" -H "Content-Type: application/json" -H "Authorization: Basic c2RfcG9ydGFsOnNkX3BvcnRhbDEyMw==" https://172.17.164.104:443/mgmt/monitor/security/dp/attacks/bulk" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"

  @SID_5
  Scenario: /mgmt/monitor/security/df/traffic/utilization/last_sample/bulk
#    Then CLI Run linux Command "curl -X POST -s -o /dev/null --insecure -w 'RESP_CODE:%{response_code} \n' -d'{"devicesFilter": null}' -H "Content-Type: application/json" -H "Authorization: Basic c2RfcG9ydGFsOnNkX3BvcnRhbDEyMw==" https://172.17.164.104:443/mgmt/monitor/security/df/traffic/utilization/last_sample/bulk" on "GENERIC_LINUX_SERVER" and validate result EQUALS "RESP_CODE:200"
    Then CLI Run remote linux Command "curl -X POST -s -o /dev/null --insecure -w 'RESP_CODE:%{response_code} \n' -d'{"devicesFilter": null}' -H "Content-Type: application/json" -H "Authorization: Basic c2RfcG9ydGFsOnNkX3BvcnRhbDEyMw==" https://172.17.164.104:443/mgmt/monitor/security/df/traffic/utilization/last_sample/bulk" on "GENERIC_LINUX_SERVER"
    Then CLI Operations - Verify that output contains regex "RESP_CODE:200"

  @SID_6
   Scenario: /mgmt/monitor/security/dp/traffic/utilization/last_sample/bulk
#    Then CLI Run linux Command "curl -X POST -s -o /dev/null --insecure -w 'RESP_CODE:%{response_code} \n' -d'{"devicesFilter": null}' -H "Content-Type: application/json" -H "Authorization: Basic c2RfcG9ydGFsOnNkX3BvcnRhbDEyMw==" https://172.17.164.104:443/mgmt/monitor/security/dp/traffic/utilization/last_sample/bulk" on "GENERIC_LINUX_SERVER" and validate result EQUALS "RESP_CODE:200"
     Then CLI Run remote linux Command "curl -X POST -s -o /dev/null --insecure -w 'RESP_CODE:%{response_code} \n' -d'{"devicesFilter": null}' -H "Content-Type: application/json" -H "Authorization: Basic c2RfcG9ydGFsOnNkX3BvcnRhbDEyMw==" https://172.17.164.104:443/mgmt/monitor/security/dp/traffic/utilization/last_sample/bulk" on "GENERIC_LINUX_SERVER"
     Then CLI Operations - Verify that output contains regex "RESP_CODE:200"
