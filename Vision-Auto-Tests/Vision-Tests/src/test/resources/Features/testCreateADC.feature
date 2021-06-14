#@run
Feature: test

  Scenario: Login and Navigate to NEW REPORTS page
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.6.5.0-DD-1.00-10.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.6.5.0-DD-1.00-10.jar" on "ROOT_SERVER_CLI" with timeOut 240
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    Then UI Login with user "radware" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage


#  @SID_1
#  Scenario: Login and Navigate to NEW REPORTS page
#    Then UI Login with user "radware" and password "radware"
#    Then UI Navigate to "ADC REPORTS" page via homepage
#    Then UI Click Button "New Report Tab"
#
#  @SID_2
# Scenario: create new BDoS-TCP SYN1
#    Given UI "Create" Report With Name "Lp Report"
#      | Template | reportType:LinkProof ,Widgets:[CEC] , devices:[LinkProof 172.19.88.5] ,WANLinks:[w1,w2]|
