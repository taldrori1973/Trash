@TC110937
Feature: OTB Workflow - Instances

  @SID_1
  Scenario: Navigate to OTB WF page
    Given UI Login with user "radware" and password "radware"
    When UI Open Upper Bar Item "Toolbox"
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

  @SID_14
  Scenario: Logout
    Then UI Logout
