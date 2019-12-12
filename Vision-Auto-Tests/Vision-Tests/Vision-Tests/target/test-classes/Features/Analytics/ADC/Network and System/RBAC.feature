@TC106807
@Functional @Analytics_ADC
Feature: RBAC - ADC System and Network Dashboard

  @SID_2
  Scenario: Set cli authentication TACACS
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"

  @SID_3
  Scenario Outline: Validate ADC RBAC
    When UI Login with user "<User Name>" and password "<Password>"
    Then UI Validate user rbac with "<Operation>" and "<Access>"
    Then UI Logout
    Examples:
      | User Name                          | Password | Operation | Access |
      | ADC_Certificate_Administrator_user | radware  | ADC       | yes    |
      | ADC_Administrator_user             | radware  | ADC       | yes    |
      | ADC_Operator_user                  | radware  | ADC       | yes    |
      | Certificate_Administrator_user     | radware  | ADC       | no     |
      | Device_Administrator_user          | radware  | ADC       | yes    |
      | Device_Configurator_user           | radware  | ADC       | yes    |
      | Device_Operator_user               | radware  | ADC       | yes    |
      | Device_Viewer_user                 | radware  | ADC       | yes    |
      | Real_Server_Operator_user          | radware  | ADC       | no     |
      | Security_Administrator_user        | radware  | ADC       | no     |
      | Security_Monitor_user              | radware  | ADC       | no     |
      | User_Administrator_user            | radware  | ADC       | no     |
      | Vision_Administrator_user          | radware  | ADC       | yes    |
      | Vision_Reporter_user               | radware  | ADC       | yes    |
      | sys_admin                          | radware  | ADC       | yes    |


  @SID_4
  Scenario: Logout
    Then UI close browser
