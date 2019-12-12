$(document).ready(function() {var formatter = new CucumberHTML.DOMFormatter($('.cucumber-report'));formatter.uri("Cloud_WAF_API/CWAF_API.feature");
formatter.feature({
  "line": 3,
  "name": "Cloud WAF API",
  "description": "",
  "id": "cloud-waf-api",
  "keyword": "Feature",
  "tags": [
    {
      "line": 1,
      "name": "@VRM"
    },
    {
      "line": 1,
      "name": "@TC106041"
    },
    {
      "line": 2,
      "name": "@run"
    }
  ]
});
formatter.before({
  "duration": 526623800,
  "status": "passed"
});
formatter.scenario({
  "line": 6,
  "name": "install VRM license in case it was removed",
  "description": "",
  "id": "cloud-waf-api;install-vrm-license-in-case-it-was-removed",
  "type": "scenario",
  "keyword": "Scenario",
  "tags": [
    {
      "line": 5,
      "name": "@SID_1"
    }
  ]
});
formatter.step({
  "line": 7,
  "name": "CLI Operations - Run Root Session command \"yes|restore_radware_user_password\" timeout 15",
  "keyword": "Then "
});
formatter.step({
  "line": 8,
  "name": "REST Login with user \"radware\" and password \"radware\"",
  "keyword": "Then "
});
formatter.step({
  "line": 9,
  "name": "REST Vision Install License Request \"vision-AVA-Max-attack-capacity\"",
  "keyword": "Then "
});
formatter.match({
  "arguments": [
    {
      "val": "yes|restore_radware_user_password",
      "offset": 43
    },
    {
      "val": "15",
      "offset": 86
    }
  ],
  "location": "ConsoleOperation.runRootCommand(String,int)"
});
formatter.write("15:42:04: Init VisionCli");
formatter.write("15:42:04: Init RadwareServerCli");
formatter.write("15:42:04: Init VisionServerHA");
formatter.write("15:42:04: Init RootServerCli");
formatter.write("15:42:06: Init MySqlSO");
formatter.write("15:42:06: Init MysqlClientCli");
formatter.write("15:42:13: ********************root radware");
formatter.write("15:42:15: Init VisionCli");
formatter.write("15:42:15: Init VisionLab");
formatter.write("15:42:15: Init Lab");
formatter.result({
  "duration": 12121488500,
  "status": "passed"
});
formatter.match({
  "arguments": [
    {
      "val": "radware",
      "offset": 22
    },
    {
      "val": "radware",
      "offset": 45
    }
  ],
  "location": "BasicRestOperationsSteps.restLoginWithUserAndPassword(String,String)"
});
formatter.result({
  "duration": 472641300,
  "status": "passed"
});
formatter.match({
  "arguments": [
    {
      "val": "vision-AVA-Max-attack-capacity",
      "offset": 37
    },
    {},
    {}
  ],
  "location": "LicenseSteps.installLicenses(String,String,String)"
});
formatter.result({
  "duration": 3700636599,
  "status": "passed"
});
formatter.after({
  "duration": 1526279600,
  "status": "passed"
});
formatter.before({
  "duration": 45369500,
  "status": "passed"
});
formatter.scenario({
  "comments": [
    {
      "line": 10,
      "value": "#    Then REST Vision Install License Request \"vision-reporting-module-ADC\""
    }
  ],
  "line": 13,
  "name": "/collector/device/config",
  "description": "",
  "id": "cloud-waf-api;/collector/device/config",
  "type": "scenario",
  "keyword": "Scenario",
  "tags": [
    {
      "line": 12,
      "name": "@SID_2"
    }
  ]
});
formatter.step({
  "line": 14,
  "name": "CLI Run remote linux Command \"echo \"Cleared\" \u003e \"/home/radware/config?noauth\"\" on \"GENERIC_LINUX_SERVER\"",
  "keyword": "When "
});
formatter.step({
  "line": 15,
  "name": "CLI Run remote linux Command \"cat /home/radware/config\\?noauth |grep \"Cleared\" |wc -l\" on \"GENERIC_LINUX_SERVER\"",
  "keyword": "When "
});
formatter.step({
  "line": 16,
  "name": "CLI Operations - Verify that output contains regex \"\\b1\\b\"",
  "keyword": "Then "
});
formatter.step({
  "line": 17,
  "name": "CLI Run remote linux Command \"curl -X GET -k -O https://172.17.164.101/mgmt/collector/device/config?noauth\" on \"GENERIC_LINUX_SERVER\"",
  "keyword": "When "
});
formatter.step({
  "line": 18,
  "name": "CLI Run remote linux Command \"cat /home/radware/config\\?noauth |grep \u0027\\\"deviceIp\\\":\\\"172.16.22.50\\\"\u0027 |wc -l\" on \"GENERIC_LINUX_SERVER\"",
  "keyword": "When "
});
formatter.step({
  "line": 19,
  "name": "CLI Operations - Verify that output contains regex \"[1]{1}\"",
  "keyword": "Then "
});
formatter.step({
  "line": 20,
  "name": "CLI Run remote linux Command \"cat /home/radware/config\\?noauth |grep \u0027\\\"monitored\\\":true\u0027 |wc -l\" on \"GENERIC_LINUX_SERVER\"",
  "keyword": "When "
});
formatter.step({
  "line": 21,
  "name": "CLI Operations - Verify that output contains regex \"\\b1\\b\"",
  "keyword": "Then "
});
formatter.match({
  "arguments": [
    {
      "val": "echo \"Cleared\" \u003e \"/home/radware/config?noauth\"",
      "offset": 30
    },
    {
      "val": "GENERIC_LINUX_SERVER",
      "offset": 82
    },
    {}
  ],
  "location": "RemoteSshCommandsTests.runCLICommand(String,SUTEntryType,Integer)"
});
formatter.result({
  "duration": 2115385601,
  "status": "passed"
});
formatter.match({
  "arguments": [
    {
      "val": "cat /home/radware/config\\?noauth |grep \"Cleared\" |wc -l",
      "offset": 30
    },
    {
      "val": "GENERIC_LINUX_SERVER",
      "offset": 91
    },
    {}
  ],
  "location": "RemoteSshCommandsTests.runCLICommand(String,SUTEntryType,Integer)"
});
formatter.result({
  "duration": 222604101,
  "status": "passed"
});
formatter.match({
  "arguments": [
    {
      "val": "\\b1\\b",
      "offset": 52
    },
    {}
  ],
  "location": "ConsoleOperation.verifyLastOutputByRegex(String,String)"
});
formatter.write("15:42:23: \\b1\\b is contained");
formatter.result({
  "duration": 2657499,
  "status": "passed"
});
formatter.match({
  "arguments": [
    {
      "val": "curl -X GET -k -O https://172.17.164.101/mgmt/collector/device/config?noauth",
      "offset": 30
    },
    {
      "val": "GENERIC_LINUX_SERVER",
      "offset": 112
    },
    {}
  ],
  "location": "RemoteSshCommandsTests.runCLICommand(String,SUTEntryType,Integer)"
});
formatter.result({
  "duration": 514286001,
  "status": "passed"
});
formatter.match({
  "arguments": [
    {
      "val": "cat /home/radware/config\\?noauth |grep \u0027\\\"deviceIp\\\":\\\"172.16.22.50\\\"\u0027 |wc -l",
      "offset": 30
    },
    {
      "val": "GENERIC_LINUX_SERVER",
      "offset": 113
    },
    {}
  ],
  "location": "RemoteSshCommandsTests.runCLICommand(String,SUTEntryType,Integer)"
});
formatter.result({
  "duration": 223281900,
  "status": "passed"
});
formatter.match({
  "arguments": [
    {
      "val": "[1]{1}",
      "offset": 52
    },
    {}
  ],
  "location": "ConsoleOperation.verifyLastOutputByRegex(String,String)"
});
formatter.write("15:42:24: [1]{1} is contained");
formatter.result({
  "duration": 840500,
  "status": "passed"
});
formatter.match({
  "arguments": [
    {
      "val": "cat /home/radware/config\\?noauth |grep \u0027\\\"monitored\\\":true\u0027 |wc -l",
      "offset": 30
    },
    {
      "val": "GENERIC_LINUX_SERVER",
      "offset": 102
    },
    {}
  ],
  "location": "RemoteSshCommandsTests.runCLICommand(String,SUTEntryType,Integer)"
});
formatter.result({
  "duration": 225952000,
  "status": "passed"
});
formatter.match({
  "arguments": [
    {
      "val": "\\b1\\b",
      "offset": 52
    },
    {}
  ],
  "location": "ConsoleOperation.verifyLastOutputByRegex(String,String)"
});
formatter.write("15:42:24: \\b1\\b is contained");
formatter.result({
  "duration": 397400,
  "status": "passed"
});
formatter.after({
  "duration": 1572679299,
  "status": "passed"
});
formatter.before({
  "duration": 17579100,
  "status": "passed"
});
formatter.scenario({
  "line": 24,
  "name": "/collector/device/devicesview",
  "description": "",
  "id": "cloud-waf-api;/collector/device/devicesview",
  "type": "scenario",
  "keyword": "Scenario",
  "tags": [
    {
      "line": 23,
      "name": "@SID_3"
    }
  ]
});
formatter.step({
  "line": 25,
  "name": "CLI Run remote linux Command \"echo \"Cleared\" \u003e \"/home/radware/devicesview?noauth\"\" on \"GENERIC_LINUX_SERVER\"",
  "keyword": "When "
});
formatter.step({
  "line": 26,
  "name": "CLI Run remote linux Command \"cat /home/radware/devicesview\\?noauth |grep \"Cleared\" |wc -l\" on \"GENERIC_LINUX_SERVER\"",
  "keyword": "When "
});
formatter.step({
  "line": 27,
  "name": "CLI Operations - Verify that output contains regex \"\\b1\\b\"",
  "keyword": "Then "
});
formatter.step({
  "line": 28,
  "name": "CLI Run remote linux Command \"curl -X GET -k -O https://172.17.164.101/mgmt/collector/device/devicesview?noauth\" on \"GENERIC_LINUX_SERVER\"",
  "keyword": "When "
});
formatter.step({
  "line": 29,
  "name": "CLI Run remote linux Command \"cat /home/radware/devicesview\\?noauth |grep \u0027\\\"deviceIp\\\":\\\"172.16.22.50\\\",\\\"portName\\\":\\\"5\\\",\\\"portDirection\\\":\\\"2\\\"\u0027 |wc -l\" on \"GENERIC_LINUX_SERVER\"",
  "keyword": "When "
});
formatter.step({
  "line": 30,
  "name": "CLI Operations - Verify that output contains regex \"\\b1\\b\"",
  "keyword": "Then "
});
formatter.match({
  "arguments": [
    {
      "val": "echo \"Cleared\" \u003e \"/home/radware/devicesview?noauth\"",
      "offset": 30
    },
    {
      "val": "GENERIC_LINUX_SERVER",
      "offset": 87
    },
    {}
  ],
  "location": "RemoteSshCommandsTests.runCLICommand(String,SUTEntryType,Integer)"
});
formatter.result({
  "duration": 223762201,
  "status": "passed"
});
formatter.match({
  "arguments": [
    {
      "val": "cat /home/radware/devicesview\\?noauth |grep \"Cleared\" |wc -l",
      "offset": 30
    },
    {
      "val": "GENERIC_LINUX_SERVER",
      "offset": 96
    },
    {}
  ],
  "location": "RemoteSshCommandsTests.runCLICommand(String,SUTEntryType,Integer)"
});
formatter.result({
  "duration": 223072100,
  "status": "passed"
});
formatter.match({
  "arguments": [
    {
      "val": "\\b1\\b",
      "offset": 52
    },
    {}
  ],
  "location": "ConsoleOperation.verifyLastOutputByRegex(String,String)"
});
formatter.write("15:42:26: \\b1\\b is contained");
formatter.result({
  "duration": 1069800,
  "status": "passed"
});
formatter.match({
  "arguments": [
    {
      "val": "curl -X GET -k -O https://172.17.164.101/mgmt/collector/device/devicesview?noauth",
      "offset": 30
    },
    {
      "val": "GENERIC_LINUX_SERVER",
      "offset": 117
    },
    {}
  ],
  "location": "RemoteSshCommandsTests.runCLICommand(String,SUTEntryType,Integer)"
});
formatter.result({
  "duration": 290756501,
  "status": "passed"
});
formatter.match({
  "arguments": [
    {
      "val": "cat /home/radware/devicesview\\?noauth |grep \u0027\\\"deviceIp\\\":\\\"172.16.22.50\\\",\\\"portName\\\":\\\"5\\\",\\\"portDirection\\\":\\\"2\\\"\u0027 |wc -l",
      "offset": 30
    },
    {
      "val": "GENERIC_LINUX_SERVER",
      "offset": 161
    },
    {}
  ],
  "location": "RemoteSshCommandsTests.runCLICommand(String,SUTEntryType,Integer)"
});
formatter.result({
  "duration": 222940100,
  "status": "passed"
});
formatter.match({
  "arguments": [
    {
      "val": "\\b1\\b",
      "offset": 52
    },
    {}
  ],
  "location": "ConsoleOperation.verifyLastOutputByRegex(String,String)"
});
formatter.write("15:42:27: \\b1\\b is contained");
formatter.result({
  "duration": 683401,
  "status": "passed"
});
formatter.after({
  "duration": 1527328300,
  "status": "passed"
});
});