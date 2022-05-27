@TC126775

Feature: BulkAPI


  Scenario: Login And Go to Vision
    Given UI Login with user "radware" and password "radware"
    Given UI Go To Vision


  Scenario Outline: Create system_user and verify
    Given UI Navigate to page "System->User Management->Local Users"
    When UI Create New User With User Name "<User Name>", Role "<Role>", Scope "<Scope>", Password "radware"
    Then  UI User With User Name "<User Name>" ,Role "<Role>" ,Scope "<Scope>" Exists
    Examples:
      | User Name             | Role                             | Scope |
      | adc_admin_certificate | ADC+Certificate Administrator    | [ALL] |
      | adc_admin             | ADC Administrator                | [ALL] |
      | adc_operator          | ADC Operator                     | [ALL] |
      | radware               | Administrator                    | [ALL] |
      | ams_analytic_user     | AMS Analytics User               | [ALL] |
      | appwall_analytic_user | AppWall Analytics User           | [ALL] |
      | adc_analytic_user     | ADC Analytics User               | [ALL] |
      | appwall_admin         | Integrated AppWall Administrator | [ALL] |
      | appwall_viewer        | Integrated AppWall Viewer        | [ALL] |
      | certificate_admin     | Certificate Administrator        | [ALL] |
      | device_admin          | Device Administrator             | [ALL] |
      | device_configurator   | Device Configurator              | [ALL] |
      | device_operator       | Device Operator                  | [ALL] |
      | device_viewer         | Device Viewer                    | [ALL] |
      | real_server_operator  | Real Server Operator             | [ALL] |
      | security_admin        | Security Administrator           | [ALL] |
      | security_monitor      | Security Monitor                 | [ALL] |
      | user_admin            | User Administrator               | [ALL] |
      | vision_admin          | Vision Administrator             | [ALL] |
      | vision_reporter       | Vision Reporter                  | [ALL] |
      | system_user           | System User                      | [ALL] |


  Scenario: Close browser
    Then UI logout and close browser

  Scenario: Clean system data before test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    Given CLI simulate 1 attacks of type "many_attacks" on SetId "DefensePro_Set_1" and wait 120 seconds

  @SID_1
  Scenario: ADC+Certificate Administrator
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value                   |
      | $.username | "adc_admin_certificate" |
      | $.password | "radware"               |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK

    Then New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

  @SID_2
  Scenario: ADC Administrator
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value       |
      | $.username | "adc_admin" |
      | $.password | "radware"   |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

  @SID_3
  Scenario: ADC Operator
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value          |
      | $.username | "adc_operator" |
      | $.password | "radware"      |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

  @SID_4
  Scenario: Administrator
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value          |
      | $.username | "radware" |
      | $.password | "radware"      |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

   @SID_5
  Scenario: AMS Analytics User
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value          |
      | $.username | "ams_analytic_user" |
      | $.password | "radware"      |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

  @SID_5
  Scenario: AppWall Analytics User
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value          |
      | $.username | "appwall_analytic_user" |
      | $.password | "radware"      |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

  @SID_5
  Scenario: Integrated AppWall Administrator
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value          |
      | $.username | "appwall_admin" |
      | $.password | "radware"      |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

  @SID_5
  Scenario: Integrated AppWall Viewer
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value          |
      | $.username | "appwall_viewer" |
      | $.password | "radware"      |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

  @SID_6
  Scenario: Certificate Administrator
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value               |
      | $.username | "certificate_admin" |
      | $.password | "radware"           |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Then New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

  @SID_7
  Scenario: Device Administrator
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value          |
      | $.username | "device_admin" |
      | $.password | "radware"      |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

  @SID_8
  Scenario: Device Configurator
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value                 |
      | $.username | "device_configurator" |
      | $.password | "radware"             |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

  @SID_9
  Scenario: Device Operator
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value             |
      | $.username | "device_operator" |
      | $.password | "radware"         |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

  @SID_10
  Scenario: Device Viewer
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value           |
      | $.username | "device_viewer" |
      | $.password | "radware"       |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

  @SID_11
  Scenario: Real Server Operator
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value                  |
      | $.username | "real_server_operator" |
      | $.password | "radware"              |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

  @SID_12
  Scenario: Security Administrator
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value            |
      | $.username | "security_admin" |
      | $.password | "radware"        |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

  @SID_13
  Scenario: Security Monitor
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value              |
      | $.username | "security_monitor" |
      | $.password | "radware"          |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

  @SID_14
  Scenario: User Administrator
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value        |
      | $.username | "user_admin" |
      | $.password | "radware"    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

  @SID_15
  Scenario: Device Operator
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value          |
      | $.username | "vision_admin" |
      | $.password | "radware"      |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

  @SID_16
  Scenario: Vision Reporter
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value             |
      | $.username | "vision_reporter" |
      | $.password | "radware"         |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is FORBIDDEN

  @SID_17

  Scenario: Getting visionsessionID with system user
    Given That Current Vision is Logged In
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "visionsessionID"
    Given The Request Body is the following Object
      | jsonPath   | value         |
      | $.username | "system_user" |
      | $.password | "radware"     |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK


  Scenario: BulkAPI request and response validation
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get bulk API"

    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    And Validate That Response Body Contains
      | jsonPath                    | value                                                              |
      | $.transaction.request_url   | "/mssp/dp/samples"                                                 |
      | $.samples[0].id             | 0                                                                  |
      | $.samples[0].attack-id      | "221-1531216812"                                                   |
      | $.samples[0].vlan-tag       | "N/A"                                                              |
      | $.samples[0].src-port       | "0"                                                                |
      | $.samples[0].dst-address    | "2.2.2.1"                                                          |
      | $.samples[0].src-port       | "0"                                                                |
      | $.samples[0].dst-port       | "0"                                                                |
      | $.samples[0].mpls-rd        | "N/A"                                                              |
      | $.samples[0].physical-port  | 101                                                                |
      | $.samples[0].protocol       | "IP"                                                               |
      | $.samples[0].src-msisdn     | "N/A"                                                              |
      | $.samples[0].dst-msisdn     | "N/A"                                                              |
      | $.samples[0].po-id          | "N_A"                                                              |
      | $.samples[0].activation-id  | "N_A"                                                              |
      | $.samples[0].tier-id        | "N_A"                                                              |
      | $.samples[0].policy-name    | "P_11111111111111111111111111111111111111111111111111111111111111" |
      | $.samples[0].src-country    | "US"                                                               |
      | $.samples[0].dst-country    | "FR"                                                               |
      | $.samples[0].source-address | "149.85.1.2"                                                       |


