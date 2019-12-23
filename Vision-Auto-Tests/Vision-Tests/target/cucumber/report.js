$(document).ready(function() {var formatter = new CucumberHTML.DOMFormatter($('.cucumber-report'));formatter.uri("GenericSteps.feature");
formatter.feature({
  "line": 2,
  "name": "Generic Steps",
  "description": "",
  "id": "generic-steps",
  "keyword": "Feature",
  "tags": [
    {
      "line": 1,
      "name": "@rest"
    }
  ]
});
formatter.scenario({
  "line": 4,
  "name": "Send Get Request",
  "description": "",
  "id": "generic-steps;send-get-request",
  "type": "scenario",
  "keyword": "Scenario"
});
formatter.step({
  "comments": [
    {
      "line": 5,
      "value": "#    Given Login to Vision With username \"radware\" and password \"radware\""
    },
    {
      "line": 6,
      "value": "#    Given New GET Request Specification with Base Path \"mgmt/device/byip/{deviceIp}/config/rsIDSNewRulesTable\""
    },
    {
      "line": 7,
      "value": "#    And Request Path Parameters"
    },
    {
      "line": 8,
      "value": "#      | deviceIp | 172.16.22.51 |"
    },
    {
      "line": 9,
      "value": "#    And Request Query Params"
    },
    {
      "line": 10,
      "value": "#      | count | 5                 |"
    },
    {
      "line": 11,
      "value": "#      | props | rsIDSNewRulesName |"
    },
    {
      "line": 12,
      "value": "#    And Request Accept JSON"
    },
    {
      "line": 13,
      "value": "#    And Request Content Type JSON"
    },
    {
      "line": 14,
      "value": "#    And Request Headers"
    },
    {
      "line": 15,
      "value": "#      | Connection | keep-alive |"
    },
    {
      "line": 16,
      "value": "#    And Request Cookies"
    },
    {
      "line": 17,
      "value": "#      | a | b |"
    },
    {
      "line": 18,
      "value": "#    When Send Request"
    },
    {
      "line": 19,
      "value": "#    Then Validate That Response Status Code Is OK"
    },
    {
      "line": 20,
      "value": "#    Then Validate That Response Status Line Is \"HTTP/1.1\""
    },
    {
      "line": 21,
      "value": "#    Then Validate That Response Headers Is"
    },
    {
      "line": 22,
      "value": "#      | Connection | keep-alive |"
    },
    {
      "line": 23,
      "value": "#    Then Validate That Response Cookies Is"
    },
    {
      "line": 24,
      "value": "#      | Connection | keep-alive |"
    },
    {
      "line": 25,
      "value": "#    Then Validate That Response Content Type Is JSON"
    },
    {
      "line": 26,
      "value": "#    Then Validate That Response Session Id Equals Client Session Id"
    }
  ],
  "line": 27,
  "name": "Validate That Response Body Contains",
  "rows": [
    {
      "cells": [
        "jsonPathString",
        "expectedValue"
      ],
      "line": 28
    },
    {
      "cells": [
        "$.name",
        "radware"
      ],
      "line": 29
    }
  ],
  "keyword": "Then "
});
formatter.match({
  "location": "GenericSteps.validateThatResponseBodyContains(JsonPathBodyValidator\u003e)"
});
formatter.result({
  "duration": 44827870100,
  "status": "passed"
});
});