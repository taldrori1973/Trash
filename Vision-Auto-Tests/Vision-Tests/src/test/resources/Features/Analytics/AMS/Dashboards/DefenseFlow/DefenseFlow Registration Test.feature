#@TC106932
#Feature: DefenseFlow Registration Test
#
#  @SID_1
#  Scenario: clean logs and unregister DF
#    * CLI kill all simulator attacks on current vision
#    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
#    * REST Delete ES index "df-attack*"
#    * CLI Clear vision logs
#
#    # Set non exist df ip
#    When CLI Operations - Run Radware Session command "system df management-ip set 1.2.3.4"
#    When CLI Operations - Run Radware Session command "system df management-ip get"
#    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 1.2.3.4"
#
#    # delete df ip
#    When CLI Operations - Run Radware Session command "system df management-ip delete 1.2.3.4"
#    #Todo ask diana if this is properties or DB test ->
#    #verify no ip is define in the properties and database (back to default 100.64.0.3) file from vision point of view
#    When CLI Operations - Run Radware Session command "system df management-ip get"
#    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 100.64.0.3"
#
#
#  @SID_2
#  Scenario: Set DFs snapshot to fresh No vision register
#    # Todo implement the following snapshot setting
#    # Revert DefenseFlow to snapshot 3.4.0.0 172.16.160.170 -> fresh No register + TACACS+ SHARED PARAMETERS
#  When  Revert DefenseFlow to snapshot
#    # Revert DefenseFlow to snapshot 3.5.0.0 172.16.160.171 -> fresh No register + TACACS+ SHARED PARAMETERS
#    # Revert DefenseFlow to snapshot 3.6.0.0 172.16.160.172 -> fresh No register + TACACS+ SHARED PARAMETERS
#
#    # TBD 3.7.0.0
#    # Revert DefenseFlow to snapshot 3.6.0.0 172.16.160.173 -> fresh No register + TACACS+ SHARED PARAMETERS
#
#
#
#  # check that unregister DF is succeeding to register to clean vision (without DF device driver)
#
#
#  @SID_3
#  Scenario: cleaning vision device drivers (include DF)
#    # Delete all device divers from the CLI "system database maintenance driver_table delete"
#    # time consuming - stop and start all services
#    #Todo need approve "y" to the command
#    When CLI Operations - Run Radware Session command "system database maintenance driver_table delete"
#
#    # verify all services are up and running
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "APSolute Vision Reporter is running" in any line with timeOut 15
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "AMQP service is running" in any line with timeOut 15
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Configuration server is running" in any line with timeOut 15
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Collector service is running" in any line with timeOut 15
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "New Reporter service is running" in any line with timeOut 15
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Alerts service is running" in any line with timeOut 15
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Scheduler service is running" in any line with timeOut 15
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Configuration Synchronization service is running" in any line with timeOut 15
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Tor feed service is running" in any line with timeOut 15
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "Radware vDirect is running" in any line with timeOut 15
#    Then CLI Run linux Command "service mgtsrv status" on "ROOT_SERVER_CLI" and validate result CONTAINS "VRM reporting engine is running" in any line with timeOut 15
#    Then CLI Run linux Command "service vz status" on "ROOT_SERVER_CLI" and validate result EQUALS "OpenVZ is running..."
#
#  @SID_4
#  Scenario: register fresh DFs 3.4.0.0 to vision
#    # register DF 3.4.0.0 with DF rest command
#    Given That Defense Flow Device with IP "172.16.160.170" is Logged In
#    Given New Request Specification from File "DefenseFlow/DefenseFlowAPI" with label "Register to vision"
#    Given The Request Body is the following Object
#      | jsonPath   | value            |
#      | $.ip       | "172.16.160.157" |
#      | $.password | "defenseflow"    |
#      | $.user     | "defenseflow"    |
#
#
#
#
#
#    # verify DF 3.4.0.0 is register via TACACS+ "https://172.16.160.170:9101/rest/v2/configure/tacacs" contains "172.16.160.170_3.4.0.0"
#  https://172.17.160.157/mgmt/device/df/config?prop=tacacsFeatureEnabled,tacacsPrimaryServerIp,tacacsPrimaryServerPort,tacacsPrimaryServerSecretKey,tacacsSecondaryServerIp,tacacsSecondaryServerPort,tacacsSecondaryServerSecretKey,serviceName
#
#    # verify resitration exist in properties file and database
#
#  @SID_5
#  Scenario: register fresh DFs 3.5.0.0 to vision
#    # register DF 3.4.0.0 with DF rest command
#    # verify DF 3.5.0.0 is register via TACACS+ "https://172.16.160.171:9101/rest/v2/configure/tacacs" contains "172.16.160.171_3.5.0.0"
#    # verify resitration exist in properties file and database
#
#  @SID_6
#  Scenario: register fresh DFs 3.6.0.0 to vision
#    # register DF 3.4.0.0 with DF rest command
#    # verify DF 3.6.0.0 is register via TACACS+ "https://172.16.160.172:9101/rest/v2/configure/tacacs" contains "172.16.160.172_3.6.0.0"
#    ## this is the reast request - "https://172.17.160.157/mgmt/device/df/config?prop=tacacsFeatureEnabled,tacacsPrimaryServerIp,tacacsPrimaryServerPort,tacacsPrimaryServerSecretKey,tacacsSecondaryServerIp,tacacsSecondaryServerPort,tacacsSecondaryServerSecretKey,serviceName"
#    # verify resitration exist in properties file and database
#
#    # TBD 3.7.0.0
#  @SID_7
#  Scenario: register fresh DFs 3.7.0.0 to vision
#    # register DF 3.4.0.0 with DF rest command
#    # verify DF 3.6.0.0 is register via TACACS+ "https://172.16.160.173:9101/rest/v2/configure/tacacs" contains "172.16.160.173_3.6.0.0"
#    # verify resitration exist in properties file and database
#
#
#
#  @SID_8
#  Scenario: Set DFs snapshot to working DF with configured attacks and traffic
#    # delete df ip
#    When CLI Operations - Run Radware Session command "system df management-ip delete 172.16.160.173"
#    #Todo ask diana if this is properties or DB test ->
#    #verify no ip is define in the properties and database (back to default 100.64.0.3) file from vision point of view
#    When CLI Operations - Run Radware Session command "system df management-ip get"
#    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 100.64.0.3"
#
#    # Todo implement the following snapshot setting
#    # Revert DefenseFlow to snapshot 3.4.0.0 172.16.160.170 -> DF_With_attacks_and_traffic
#    # Revert DefenseFlow to snapshot 3.5.0.0 172.16.160.171 -> DF_With_attacks_and_traffic
#    # Revert DefenseFlow to snapshot 3.6.0.0 172.16.160.172 -> DF_With_attacks_and_traffic
#
#    # TBD 3.7.0.0
#    # Revert DefenseFlow to snapshot 3.6.0.0 172.16.160.173 -> DF_With_attacks_and_traffic
#
#      # Virify vision is blocking DF 3.4.0.0 and 3.5.0.0 and 3.6.0.0 and 3.7.0.0 traffic and attacks
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.170" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.171" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.172" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.173" contains "Unauthorized"
#
#  @SID_9
#  Scenario: register DF 3.4.0.0 with attacs and traffic to vision
#    # register DF 3.4.0.0 with CLI registraion command "system df management-ip set 172.17.160.170"
#    When CLI Operations - Run Radware Session command "system df management-ip set 172.17.160.170"
#    When CLI Operations - Run Radware Session command "system df management-ip get"
#    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 172.17.160.170"
#
#    # verify DF 3.4.0.0 is register via TACACS+ "https://172.16.160.170:9101/rest/v2/configure/tacacs" contains "172.16.160.170_3.4.0.0"
#    # Verify vision reciving traffic from DF 3.4.0.0 and stop blocking
#    When CLI Operations - Run Radware Session command "rm -rf /opt/radware/mgt-server/third-party/tomcat/logs/collector.log"
#    When Sleep "30"
#    Then CLI Run linux Command "cat /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.170" on "ROOT_SERVER_CLI" and validate result CONTAINS "Unauthorized" in any line with timeOut 15
#
#  "" NOT contains "Unauthorized"
#    # verify resitration exist in properties file and database
#      # Virify vision is blocking DF 3.5.0.0 and 3.6.0.0 and 3.7.0.0 traffic and attacks
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.171" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.172" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.173" contains "Unauthorized"
#
#
#  @SID_10
#  Scenario: register DF 3.5.0.0 with attacs and traffic to vision
#    # register DF 3.5.0.0 with CLI registraion command "system df management-ip set 172.16.160.171"
#    When CLI Operations - Run Radware Session command "system df management-ip set 172.16.160.171"
#    When CLI Operations - Run Radware Session command "system df management-ip get"
#    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 172.16.160.171"
#
#    # verify DF 3.5.0.0 is register via TACACS+ "https://172.16.160.170:9101/rest/v2/configure/tacacs" contains "172.16.160.170_3.5.0.0"
#    # Verify vision reciving traffic from DF 3.5.0.0 and stop blocking
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.171" NOT contains "Unauthorized"
#    # verify resitration exist in properties file and database
#      # Virify vision is blocking DF 3.4.0.0 and 3.6.0.0 and 3.7.0.0 traffic and attacks
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.170" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.172" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.173" contains "Unauthorized"
#
#
#  @SID_11
#  Scenario: register not exist DF 1.2.3.4
#    # register not existing IP "system df management-ip set 1.2.3.4"
#    When CLI Operations - Run Radware Session command "system df management-ip set 1.2.3.4"
#    When CLI Operations - Run Radware Session command "system df management-ip get"
#    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 1.2.3.4"
#
#    # verify resitration 1.2.3.4 exist in properties file and database
#      # Virify vision is blocking DF 3.4.0.0 and 3.5.0.0 and 3.6.0.0 and 3.7.0.0 traffic and attacks
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.170" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.171" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.172" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.173" contains "Unauthorized"
#
#  @SID_12
#  Scenario: register DF 3.6.0.0 with attacs and traffic to vision
#    # register DF 3.6.0.0 with CLI registraion command "system df management-ip set 172.16.160.172"
#    When CLI Operations - Run Radware Session command "system df management-ip set 172.16.160.172"
#    When CLI Operations - Run Radware Session command "system df management-ip get"
#    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 172.16.160.172"
#
#    # verify DF 3.6.0.0 is register via TACACS+ "https://172.16.160.170:9101/rest/v2/configure/tacacs" contains "172.16.160.170_3.5.0.0"
#    # Verify vision reciving traffic from DF 3.6.0.0 and stop blocking
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.172" NOT contains "Unauthorized"
#    # verify resitration exist in properties file and database
#      # Virify vision is blocking DF 3.4.0.0 and 3.5.0.0 and 3.6.0.0 and 3.7.0.0 traffic and attacks
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.170" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.171" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.173" contains "Unauthorized"
#
#
#  #Todo TBD 3.7.0.0
#  @SID_13
#  Scenario: register DF 3.7.0.0 with attacs and traffic to vision
#    # register DF 3.7.0.0 with CLI registraion command "system df management-ip set 172.16.160.173"
#    When CLI Operations - Run Radware Session command "system df management-ip set 172.16.160.173"
#    When CLI Operations - Run Radware Session command "system df management-ip get"
#    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 172.16.160.173"
#
#    # verify DF 3.7.0.0 is register via TACACS+ "https://172.16.160.170:9101/rest/v2/configure/tacacs" contains "172.16.160.170_3.5.0.0"
#    # Verify vision reciving traffic from DF 3.7.0.0 and stop blocking
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.173" NOT contains "Unauthorized"
#    # verify resitration exist in properties file and database
#    # Virify vision is blocking DF 3.4.0.0 and 3.5.0.0 and 3.6.0.0 traffic and attacks
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.170" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.171" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.172" contains "Unauthorized"
#
#  @SID_14
#  Scenario: register incorrect DF IP
#    # register DF with incorrect IP "system df management-ip set 172.16.160.256"
#    When CLI Operations - Run Radware Session command "system df management-ip set 172.16.160.256"
#    When CLI Operations - Run Radware Session command "system df management-ip get"
#    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 172.16.160.173"
#
#    # verify DF 3.7.0.0 is register via TACACS+ "https://172.16.160.170:9101/rest/v2/configure/tacacs" contains "172.16.160.170_3.5.0.0"
#    # Verify vision reciving traffic from DF 3.7.0.0 and stop blocking
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.173" NOT contains "Unauthorized"
#    # verify resitration exist in properties file and database
#    # Virify vision is blocking DF 3.4.0.0 and 3.5.0.0 and 3.6.0.0 traffic and attacks
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.170" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.171" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.172" contains "Unauthorized"
#
#  @SID_15
#  Scenario: delete register DF 3.7.0.0
#    # delete DF 3.7.0.0 with CLI registraion command "system df management-ip set 172.16.160.173"
#    When CLI Operations - Run Radware Session command "system df management-ip delete 172.16.160.172"
#    When CLI Operations - Run Radware Session command "system df management-ip get"
#    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 100.64.0.3"
#
#    # verify resitration empty (ip return to 100.64.0.3) in properties file and database
#    # Virify vision is blocking DF 3.4.0.0 and 3.5.0.0 and 3.6.0.0 and 3.7.0.0 traffic and attacks
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.170" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.171" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.172" contains "Unauthorized"
#  "tail -f /opt/radware/mgt-server/third-party/tomcat/logs/collector.log | grep 172.16.160.173" contains "Unauthorized"
