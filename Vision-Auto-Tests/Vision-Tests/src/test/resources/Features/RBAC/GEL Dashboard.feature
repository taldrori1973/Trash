@TC108038
Feature: GEL Dashboard RBAC

  @SID_1
  Scenario: login as radware and configure TACACS server parameters
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Authentication Protocols->TACACS+ Settings"
    Then UI Set Text Field "IP Address" To "172.17.167.166" enter Key true
    Then UI Set Text Field "Shared Secret" To "radware" enter Key true
    Then UI Set Text field with id "gwt-debug-primarySharedSecret_DuplicatePasswordField" with "radware"
    # Then UI Set Text Field "Port" To "49" enter Key true
    When UI Do Operation "select" item "Shared Parameters"
    Then UI Set Text Field "Minimal Required Privilege Level" To "0" enter Key true
    Then UI Set Text Field "Service Name" To "connection" enter Key true
    Then UI Click Button "Submit"

  @SID_2
  Scenario: set Authentication Mode TACACS
    Then UI Navigate to page "System->User Management->User Management Settings"
    Then UI Select "TACACS+" from Vision dropdown "Authentication Mode"
    Then UI Click Button "Submit"
    Then UI Logout
    Then CLI Clear vision logs

  @SID_3
  Scenario Outline:GEL Dashboard RBAC
    When UI Login with user "<userName>" and password "radware"
    Then UI Validate user rbac
      | operations    | accesses |
      | GEL Dashboard | <Access> |
    Then UI Logout

    Examples:
      | userName                           | Access |
      | sys_admin                          | yes    |
      | ADC_Certificate_Administrator_user | yes    |
      | ADC_Administrator_user             | yes    |
      | ADC_Operator_user                  | yes    |
      | Device_Administrator_user          | yes    |
      | Device_Configurator_user           | yes    |
      | Device_Operator_user               | yes    |
      | Device_Viewer_user                 | yes    |
      | Vision_Administrator_user          | yes    |
      | Vision_Reporter_user               | yes    |
      | Certificate_Administrator_user     | no     |
      | Real_Server_Operator_user          | no     |
      | Security_Administrator_user        | no     |
      | Security_Monitor_user              | no     |
      | User_Administrator_user            | no     |

  @SID_4
  Scenario: Close Browser and validate logs
    Then UI close browser
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal        | NOT_EXPECTED |