@TC111097
Feature: Ipv6 OTB Workflow - Instances
  @SID_1
  Scenario: Navigate to OTB WF page
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "radware" and password "radware"
    Then UI Navigate to "AUTOMATION" page via homePage
    When set Tab "Automation.Toolbox"
    When UI Click Button by id "gwt-debug-WorkFlow_Tab"

  @SID_2
  Scenario: Upload new workflow
    Then UI Validate Element Existence By Label "New Workflow" if Exists "true"
    Then  Upload file "calculator.zip" to "New Workflow"
    Then UI Validate Text field with Class "ant-message-custom-content ant-message-success" "Equals" To "The workflow uploaded successfully"

  @SID_3
  Scenario: create instance to calcualtor
    Then UI Click Button "create instance" with value "calculator"
    Then UI Set Text Field "Workflow Name" To "calc10" enter Key false
    Then UI Click Button "Run Create"
    Then UI Click Button "Dismiss"

  @SID_4
  Scenario: validate number of insatnces to calculator is increased
    Then UI Validate Text field "instances" with params "calculator" EQUALS "Instances (1)"

  @SID_5
  Scenario: validate that instance added to list
    Then UI Click Button "instances" with value "calculator"
    Then UI Validate "instances table" Table rows count equal to 1
    Then UI validate Table row by keyValue with elementLabel "instances table" findBy columnName "Name" findBy cellValue "calc10"

  @SID_6
  Scenario: validate instance information
    Then UI Click Button "instances" with value "calculator"
    Then UI validate Table row by keyValue with elementLabel "instances table" findBy columnName "Name" findBy cellValue "calc10"
    Then UI Validate Table record values by columns with elementLabel "instances table" findBy columnName "Name" findBy cellValue "calc10"
      | columnName   | value                    |
      | Name         | calc10                   |
      | State        | ready                    |
      | Last Message | createWorkflow completed |

  @SID_7
  Scenario: call set action, and validate action
    Then UI Click Button "instances" with value "calculator"
    Then UI Click Button "Actions" with value "calc10"
    Then UI Click Button "set"
    Then UI Set Text Field "value" To "5"
    Then UI Click Button "RunButton"
    Then UI Click Button "Dismiss"
    Then UI Validate Table record values by columns with elementLabel "instances table" findBy columnName "Name" findBy cellValue "calc10"
      | columnName   | value         |
      | Name         | calc10        |
      | Last Message | set completed |

  @SID_8
  Scenario: call add action, and validate action
    Then UI Click Button "Actions" with value "calc10"
    Then UI Click Button "add"
    Then UI Set Text Field "Add value" To "5"
    Then UI Click Button "RunButton"
    Then UI Click Button "Dismiss"
    Then UI Validate Table record values by columns with elementLabel "instances table" findBy columnName "Name" findBy cellValue "calc10"
      | columnName   | value         |
      | Name         | calc10        |
      | Last Message | add completed |

  @SID_9
  Scenario: call sub action, and validate action
    Then UI Click Button "Actions" with value "calc10"
    Then UI Click Button "sub"
    Then UI Set Text Field "Sub value" To "5"
    Then UI Click Button "RunButton"
    Then UI Click Button "Dismiss"
    Then UI Validate Table record values by columns with elementLabel "instances table" findBy columnName "Name" findBy cellValue "calc10"
      | columnName   | value         |
      | Name         | calc10        |
      | Last Message | sub completed |

  @SID_10
  Scenario: call teardown action, and validate action
    Then UI Click Button "Actions" with value "calc10"
    Then UI Click Button "teardown"
    Then UI Click Button "RunButton"
    Then UI Click Button "Dismiss"
    Then UI Validate Table record values by columns with elementLabel "instances table" findBy columnName "Name" findBy cellValue "calc10"
      | columnName   | value              |
      | Name         | calc10             |
      | Last Message | teardown completed |
      | State        | removed            |

  @SID_11
  Scenario: delete instance
    Then UI Click Button "instances" with value "calculator"
    Then UI Click Button "delete instance" with value "calc10"
    Then UI Click Button "RunButton"
    Then UI Click Button "Dismiss"

  @SID_12
  Scenario: validate instance was removed from table, and instances count decreased
    Then UI validate Table row by keyValue with elementLabel "instances table" findBy columnName "Name" findBy cellValue "calc10" negative
    Then UI Click Button by Class "ant-modal-close-x"
    Then UI Validate Text field "instances" with params "calculator" EQUALS "Instances (0)"

  @SID_13
  Scenario: Delete WorkFlow
    Given UI Login with user "radware" and password "radware"
    When UI Open Upper Bar Item "Toolbox"
    When set Tab "Automation.Toolbox"
    When UI Click Button by id "gwt-debug-WorkFlow_Tab"
    When UI Click Button "card action" with value "calculator"
    When UI Click Button "delete Workflow" with value "calculator"
    Then UI Validate Element Existence By Label "Delete Submit" if Exists "true"
    Then UI Click Button "Delete Submit"

#  @SID_15
#  Scenario: validate Microsoft_Exchange (workflow with Alteon)
#    When UI Click Button by id "gwt-debug-WorkFlow_Tab"
#    Then UI Click Button "create instance" with value "Microsoft_Exchange"
#    When UI Set Text Field "Workflow name" To "Workflow_Microsoft_Exchange" by sendkeys
#    When UI Click Button "adc_dropdown"
#    When UI Click Button "adc value" with value "Alteon_200a::172:17:164:19"
#    When UI Set Text Field "name" To "Microsoft_Exchange" by sendkeys
#    When UI Set Text Field "vipAddress" To "1.1.1.1" by sendkeys
#    When UI Set Text Field "realServersCAS_address" To "2.2.2.2" by sendkeys
#    When UI Set Text Field "realServersSMTP_address" To "3.3.3.3" by sendkeys
#    When UI Set Text Field "certId" To "1" by sendkeys
#    When UI Set Text Field "slbMetric_SMTP" To "1" by sendkeys
#    When UI Set Text Field "healthCheck_SMTP" To "1" by sendkeys
#    When UI Set Text Field "slbMetric_CAS" To "1" by sendkeys
#    When UI Set Text Field "healthChecked_CAS" To "1" by sendkeys
#    When UI Set Text Field "rpc" To "1" by sendkeys
#    When UI Set Text Field "exchangeAddressBook" To "1" by sendkeys
#    When UI Set Text Field "rpcEndpoint" To "1" by sendkeys
#    When Sleep "2"
#    When UI Validate the attribute "class" Of Label "RunButton" with errorMessage "runButton is not enable" is "CONTAINS" to "FDFJZ"
#    When UI Click Button "RunButton"
#    Then UI Validate Text field "Task success message" EQUALS "Task completed successfully."
#    When UI Click Button "Dismiss"
#    When UI Click Button by id "gwt-debug-ToolBox_ADVANCED"
#    When UI Click Button by id "gwt-debug-Microsoft Exchange 2010-content"
#    Then UI validate Vision Table row by keyValue with elementLabel "AppShapes Table" findBy columnName "Name" findBy KeyValue "Workflow_Microsoft_Exchange"
#      | columnName | value                       | isDate |
#      | Name       | Workflow_Microsoft_Exchange | false  |
#
#  @SID_16
#  Scenario: Go To WorkFlow
#    When close popup if it exists by button "Cancel"
#    When UI Click Button by id "gwt-debug-ToolBox_DASHBOARD"
#    When UI Click Button by id "gwt-debug-WorkFlow_Tab"
#
#  @SID_17
#  Scenario: Delete Microsoft_Exchange instance
#    Then UI Click Button "instances" with value "Microsoft_Exchange"
#    Then UI Click Button "delete instance" with value "Workflow_Microsoft_Exchange"
#    Then UI Click Button "RunButton"
#    Then UI Click Button "Dismiss"


  @SID_14
  Scenario: Logout
    Then UI logout and close browser
