@TC110731
Feature: OTB Workflow - Add, Update and Delete

  @SID_1
  Scenario: Navigate to OTB WF page
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "AUTOMATION" page via homePage
    When set Tab "Automation.Toolbox"
    When UI Click Button by id "gwt-debug-WorkFlow_Tab"

#  @SID_2
#  Scenario: Upload new workflow
#    Then UI Validate Element Existence By Label "New Workflow" if Exists "true"
#    Then  Upload file "notZip.txt" to "New Workflow"
#    Then UI Validate Text field with Class "ant-message-custom-content ant-message-error" "Equals" To "Error reading file. Invalid file type. Upload only valid ZIP files"

  @SID_2
  Scenario: Upload new workflow
    Then UI Validate Element Existence By Label "New Workflow" if Exists "true"
    Then  Upload file "calculator.zip" to "New Workflow"
    Then Sleep "2"
    Then UI Validate Text field with Class "ant-message-custom-content ant-message-success" "Equals" To "The workflow uploaded successfully"

  @SID_3
  Scenario: validate workflow added to the page
    Then UI Validate Element Existence By Label "card action" if Exists "true" with value "calculator"

  @SID_4
  Scenario: Upload file with wrong format (not zip file)
    When UI Click Button by id "gwt-debug-WorkFlow_Tab"
    Then  Upload file "notZip.txt" to "New Workflow"
    Then UI Validate Text field with Class "ant-message-custom-content ant-message-error" "Equals" To "Error reading file. Invalid file type. Upload only valid ZIP files"

  @SID_5
  Scenario: Update WF with wrong format (not zip file)
    When UI Click Button by id "gwt-debug-WorkFlow_Tab"
    When UI Click Button "card action" with value "calculator"
    Then  Upload file "notZip.txt" to "Update" for element "calculator"
    Then UI Validate Text field with Class "ant-message-custom-content ant-message-error" "Equals" To "Error reading file. Invalid file type. Upload only valid ZIP files"


  @SID_6
  Scenario: Upload existing workflow
    When Sleep "10"
    When UI Click Button by id "gwt-debug-WorkFlow_Tab"
    Then  Upload file "calculator.zip" to "New Workflow"
    Then UI Validate Text field with Class "ant-message-custom-content ant-message-error" "Equals" To "A workflow named calculator already exists"


  @SID_7
  Scenario: Update WF with same format
    When UI Click Button by id "gwt-debug-WorkFlow_Tab"
    When UI Click Button "card action" with value "calculator"
    Then  Upload file "calculator.zip" to "Update" for element "calculator"
    Then UI Validate Text field with Class "ant-message-custom-content ant-message-success" "Equals" To "Workflow calculator was updated successfully"

  @SID_8
  Scenario: Update WF with file include another workflow
    When UI Click Button by id "gwt-debug-WorkFlow_Tab"
    When UI Click Button "card action" with value "calculator"
    Then  Upload file "CitrixXenDesktop.zip" to "Update" for element "calculator"
    Then UI Validate Text field with Class "ant-message-custom-content ant-message-error" "Equals" To "Error. Could not update the workflow calculator"

  @SID_9
  Scenario: Logout
    Then UI Logout

  @SID_10
  Scenario Outline: RBAC - add,delete,update Workflow Templates Available for Administrator Roles
    Given UI Login with user "<userName>" and password "radware"
    Given UI Go To Vision
    When UI Open Upper Bar Item "Toolbox"
    When set Tab "Automation.Toolbox"
    When UI Click Button by id "gwt-debug-WorkFlow_Tab"
    Then UI Validate Element Existence By Label "New Workflow" if Exists "true"
    Then UI Validate Element Existence By Label "card action" if Exists "true" with value "calculator"
    When UI Click Button "card action" with value "calculator"
    Then UI Validate Element Existence By Label "delete Workflow" if Exists "true" with value "calculator"
    Then UI Validate Element Existence By Label "Update" if Exists "true" with value "calculator"
    When UI Click Button by id "gwt-debug-WorkFlow_Tab"
    Then UI Logout
    Examples:
      | userName                    |
      | sys_admin                   |
      | radware                     |
      | Device_Administrator_user   |
      | Security_Administrator_user |
      | Vision_Administrator_user   |

  @SID_11
  Scenario Outline: RBAC - validate that NOT Adminstrator Roles can't Add,upload,delete WF
    Given UI Login with user "<userName>" and password "radware"
    When UI Open Upper Bar Item "Toolbox"
    When set Tab "Automation.Toolbox"
    When UI Click Button by id "gwt-debug-WorkFlow_Tab"
    Then UI Validate Element Existence By Label "New Workflow" if Exists "false"
    Then UI Validate Element Existence By Label "card action" if Exists "false" with value "calculator"
    Then UI Logout

    Examples:
      | userName           |
      | Device_Viewer_user |

  @SID_12
  Scenario: Delete WorkFlow
    Given UI Login with user "radware" and password "radware"
    When UI Open Upper Bar Item "Toolbox"
    When set Tab "Automation.Toolbox"
    When UI Click Button by id "gwt-debug-WorkFlow_Tab"
    When UI Click Button "card action" with value "calculator"
    When UI Click Button "delete Workflow" with value "calculator"
    Then UI Validate Element Existence By Label "Delete Submit" if Exists "true"
    Then UI Click Button "Delete Submit"

  @SID_13
  Scenario: Validate success message appear after delete
    Then UI Validate Text field with Class "ant-message-custom-content ant-message-success" "Equals" To "Workflow calculator was deleted successfully"

  @SID_14
  Scenario: Logout
    Then UI Logout


  


    