@CLI_Positive @TC106025

Feature: Net Route CLI Tests

#  @SID_1
#  Scenario: pre condition
#    Given REST Login with activation with user "radware" and password "radware"
#    Given REST Vision Install License Request "vision-security-reporter"
#    Given REST Vision Install License Request "vision-AVA-Max-attack-capacity"
#    Given REST Vision Install License Request "vision-perfreporter"
#    Given REST Vision Install License Request "vision-RTU96"

  @SID_1
  Scenario: Net Route Host tests
    When CLI Operations - Run Radware Session command "net route set host 192.11.0.1 172.17.0.5 G1"
    Then CLI Run linux Command "route|grep 192.11.0.1|awk '{print$1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "192.11.0.1"
    Then CLI Run linux Command "route|grep 192.11.0.1|awk '{print$2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "172.17.0.5"
    Then CLI Run linux Command "route|grep 192.11.0.1|awk '{print$3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "255.255.255.255"
    Then CLI Run linux Command "route|grep 192.11.0.1|awk '{print$8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "G1"

    When CLI Operations - Run Radware Session command "net route delete 192.11.0.1 255.255.255.255 172.17.0.5 G1"
    Then CLI Run linux Command "route|grep 192.11.0.1|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"

  @SID_2
  Scenario: Net Route Net tests
    When CLI Operations - Run Radware Session command "net route set net 192.12.0.0 255.255.0.0 172.17.0.5"
    Then CLI Run linux Command "route|grep 192.12.0.0|awk '{print$1}'" on "ROOT_SERVER_CLI" and validate result EQUALS "192.12.0.0"
    Then CLI Run linux Command "route|grep 192.12.0.0|awk '{print$2}'" on "ROOT_SERVER_CLI" and validate result EQUALS "172.17.0.5"
    Then CLI Run linux Command "route|grep 192.12.0.0|awk '{print$3}'" on "ROOT_SERVER_CLI" and validate result EQUALS "255.255.0.0"
    Then CLI Run linux Command "route|grep 192.12.0.0|awk '{print$8}'" on "ROOT_SERVER_CLI" and validate result EQUALS "G1"

    When CLI Operations - Run Radware Session command "net route delete 192.12.0.0 255.255.0.0 172.17.0.5"
    Then CLI Run linux Command "route|grep 192.12.0.1|wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"

