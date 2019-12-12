@TC106931

Feature: ADC Network Aggregation validation

  @SID_1
  Scenario: Copy ES manipulation and verification scripts
    Then CLI copy "/home/radware/Scripts/ADC_networkIndexManipulation.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then CLI copy "/home/radware/Scripts/ADC_networkIndexVerification.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"

  @SID_2
  Scenario: Verify ADC Network index aggregation task
    When Verify ADC Network index aggregation on device "50.50.101.21"

