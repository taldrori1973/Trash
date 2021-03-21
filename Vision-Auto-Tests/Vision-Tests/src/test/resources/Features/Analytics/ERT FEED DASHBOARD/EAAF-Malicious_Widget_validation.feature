
Feature: EAAF Malicious Widget validation

  Scenario: Set system for test
    # copy configuration files of EAAF for further validation
    * CLI copy "/opt/radware/mgt-server/third-party/tomcat/conf/config_to_eaaf_tag_map.json" from "ROOT_SERVER_CLI" to "GENERIC_LINUX_SERVER" "/home/radware"
    * CLI copy "/opt/radware/mgt-server/third-party/tomcat/conf/collectors.properties" from "ROOT_SERVER_CLI" to "GENERIC_LINUX_SERVER" "/home/radware"