
Feature: navigation from homePage

  Scenario: Login
    Given UI Login with user "radware" and password "radware"

    Scenario: validate ADC navigation
      Then UI Navigate to "Analytics.ADC" page via homePage
      Then UI Validate Element Existence By Label "" if Exists "true" with value ""
      Then UI Click on upBar Button "homePageButton"

  Scenario: validate AMS navigation
    Then UI Navigate to "Analytics.AMS" page via homePage
    Then UI Validate Element Existence By Label "" if Exists "true" with value ""
    Then UI Click on upBar Button "homePageButton"

  Scenario: validate APM navigation
    Then UI Navigate to "Applications.APM" page via homePage
    Then UI Validate Element Existence By Label "" if Exists "true" with value ""
    Then UI Click on upBar Button "homePageButton"

  Scenario: validate ERT navigation
    Then UI Navigate to "Applications.ERT" page via homePage
    Then UI Validate Element Existence By Label "" if Exists "true" with value ""
    Then UI Click on upBar Button "homePageButton"

  Scenario: validate GEL navigation
    Then UI Navigate to "Applications.GEL" page via homePage
    Then UI Validate Element Existence By Label "" if Exists "true" with value ""
    Then UI Click on upBar Button "homePageButton"

  Scenario: validate vDirect navigation
    Then UI Navigate to "Applications.vDirect" page via homePage
    Then UI Validate Element Existence By Label "" if Exists "true" with value ""
    Then UI Click on upBar Button "homePageButton"

  Scenario: validate DefenseFlow_Configuration navigation
    Then UI Navigate to "DefenseFlow.DefenseFlow_Configuration" page via homePage
    Then UI Validate Element Existence By Label "" if Exists "true" with value ""
    Then UI Click on upBar Button "homePageButton"

  Scenario: validate DefenseFlow_Operation navigation
    Then UI Navigate to "DefenseFlow.DefenseFlow_Operation" page via homePage
    Then UI Validate Element Existence By Label "" if Exists "true" with value ""
    Then UI Click on upBar Button "homePageButton"

  Scenario: validate Toolbox navigation
    Then UI Navigate to "Automation.Toolbox" page via homePage
    Then UI Validate Element Existence By Label "" if Exists "true" with value ""
    Then UI Click on upBar Button "homePageButton"

  Scenario: validate WorkFlow navigation
    Then UI Navigate to "Automation.WorkFlow" page via homePage
    Then UI Validate Element Existence By Label "" if Exists "true" with value ""
    Then UI Click on upBar Button "homePageButton"

  Scenario: validate Settings navigation
    Then UI Navigate to "Configuration.Settings" page via homePage
    Then UI Validate Element Existence By Label "" if Exists "true" with value ""
    Then UI Click on upBar Button "homePageButton"