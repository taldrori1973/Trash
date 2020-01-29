@TC110142
Feature: toolbox-workFlow

  @SID_1
  Scenario: Go To Workflows
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "TOOLBOX" page via homePage
    When set Tab "Automation.Toolbox"
#    When UI Click Button by id "gwt-debug-Global_ToolBox"
#    When UI Navigate to "Automation.Toolbox" page via homePage
    When UI Click Button by id "gwt-debug-WorkFlow_Tab"

  @SID_2
  Scenario: validate Oracle_SOA_Suite_11g
    When UI Click Button "Run" with value "Oracle_SOA_Suite_11g"
    When UI Set Text Field "Workflow name" To "Workflow" by sendkeys
    When UI Click Button "adc_dropdown"
    When UI Click Button "adc value" with value "Alteon_172.17.164.17"
    When UI Set Text Field "name" To "Oracle_SOA_Suite_11gName2" by sendkeys
    When UI Set Text Field "vipAddress_1" To "1.1.1.1" by sendkeys
    When UI Set Text Field "vipAddress_2" To "2.2.2.2" by sendkeys
    When UI Set Text Field "vipAddress_3" To "3.3.3.3" by sendkeys
    When UI Set Text Field "realServersGroup_address" To "4.4.4.4" by sendkeys
    When UI Set Text Field "certId" To "1" by sendkeys
    When UI Set Text Field "slbMetric" To "1" by sendkeys
    When UI Set Text Field "healthCheck" To "1" by sendkeys
    When Sleep "2"
    When UI Validate the attribute "class" Of Label "RunButton" with errorMessage "runButton is not enable" is "CONTAINS" to "FDFJZ"
    When UI Click Button "RunButton"
    Then UI Validate Text field "Task success message" CONTAINS "Task completed successfully."
    When UI Click Button "Dismiss"
    When UI Click Button by id "gwt-debug-ToolBox_ADVANCED"
    When UI Click Button by id "gwt-debug-Oracle SOA Suite 11g-content"
    Then UI validate Vision Table row by keyValue with elementLabel "AppShapes Table" findBy columnName "Name" findBy KeyValue "Oracle_SOA_Suite_11gName2"
      | columnName | value                    | isDate |
      | Name       | Oracle_SOA_Suite_11gName2 | false  |

  @SID_3
  Scenario: Go To WorkFlow
    When close popup if it exists by button "Cancel"
    When UI Click Button by id "gwt-debug-ToolBox_DASHBOARD"
#    When UI Click on upBar Button "homePageButton"
#    When UI Navigate to "Automation.Toolbox" page via homePage
    When UI Click Button by id "gwt-debug-WorkFlow_Tab"

  @SID_4
  Scenario: validate Microsoft_Exchange
    When UI Click Button "Run" with value "Microsoft_Exchange"
    When UI Set Text Field "Workflow name" To "Workflow_Microsoft_Exchange" by sendkeys
    When UI Click Button "adc_dropdown"
    When UI Click Button "adc value" with value "Alteon_172.17.164.17"
    When UI Set Text Field "name" To "Microsoft_Exchange" by sendkeys
    When UI Set Text Field "vipAddress" To "1.1.1.1" by sendkeys
    When UI Set Text Field "realServersCAS_address" To "2.2.2.2" by sendkeys
    When UI Set Text Field "realServersSMTP_address" To "3.3.3.3" by sendkeys
    When UI Set Text Field "certId" To "1" by sendkeys
    When UI Set Text Field "slbMetric_SMTP" To "1" by sendkeys
    When UI Set Text Field "healthCheck_SMTP" To "1" by sendkeys
    When UI Set Text Field "slbMetric_CAS" To "1" by sendkeys
    When UI Set Text Field "healthChecked_CAS" To "1" by sendkeys
    When UI Set Text Field "rpc" To "1" by sendkeys
    When UI Set Text Field "exchangeAddressBook" To "1" by sendkeys
    When UI Set Text Field "rpcEndpoint" To "1" by sendkeys
    When Sleep "2"
    When UI Validate the attribute "class" Of Label "RunButton" with errorMessage "runButton is not enable" is "CONTAINS" to "FDFJZ"
    When UI Click Button "RunButton"
    Then UI Validate Text field "Task success message" CONTAINS "Task completed successfully."
    When UI Click Button "Dismiss"
    When UI Click Button by id "gwt-debug-ToolBox_ADVANCED"
    When UI Click Button by id "gwt-debug-Microsoft Exchange 2010-content"
    Then UI validate Vision Table row by keyValue with elementLabel "AppShapes Table" findBy columnName "Name" findBy KeyValue "Workflow_Microsoft_Exchange"
      | columnName | value                    | isDate |
      | Name       | Workflow_Microsoft_Exchange | false  |


#  @SID_5
#  Scenario: Go To WorkFlow
#    When close popup if it exists by button "Cancel"
#    When UI Click on upBar Button "homePageButton"
#    When UI Navigate to "Automation.Toolbox" page via homePage
#    When UI Click Button by id "gwt-debug-WorkFlow_Tab"

#  @SID_5
#  Scenario: validate SharePoint
#    When UI Set Text Field "name" To "SharePoint" by sendkeys
#    When UI Set Text Field "vipAddress" To "1.1.1.1" by sendkeys
#    When UI Set Text Field "realServers_address" To "2.2.2.2" by sendkeys
#    When UI Set Text Field "certId" To "1" by sendkeys
#    When UI Set Text Field "slbMetric" To "1" by sendkeys
#    When UI Set Text Field "healthCheck" To "1" by sendkeys
#    When UI Set Text Field "http_Domain_Name" To "1" by sendkeys
#    When UI Click Button "Oracle SOA Suite 11g Side bar"


