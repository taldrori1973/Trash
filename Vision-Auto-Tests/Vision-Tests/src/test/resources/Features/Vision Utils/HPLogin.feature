@TC113285
Feature: HPLogin

  @SID_1
  Scenario: arrive to login page
    When UI Login with user "sys_admin" and password "radware"
    When UI Logout

  @SID_2
  Scenario: Sanity
    Then UI Text of "cardHeader" with extension "" equal to "APSolute Vision Login"
    Then UI Validate Element Existence By Label "contactSupportLink" if Exists "true"
    Then UI Text of "contactSupportLink" with extension "" equal to "support@radware.com."
    Then UI Validate the attribute "href" Of Label "contactSupportLink" is "CONTAINS" to "support@radware.com"
    Then UI Text of "greetingParagraph" with extension "" equal to "Welcome to Radware APSolute Vision!APSolute Vision is the most comprehensive and effective solution for configuration, automation, monitoring, and reporting of Radware devices."
    Then UI Validate the attribute "type" Of Label "passwordInput" is "CONTAINS" to "password"

  @SID_3
  Scenario: empty username
    When UI clear 10 characters in "usernameInput"
    Then UI Text of "cardContent" with extension "" contains "Invalid Username or invalid Password. Re-enter."

  @SID_4
  Scenario: Wrong password
    When UI Set Text Field "usernameInput" To "sys_admin" enter Key false
    When UI Set Text Field "passwordInput" To "wrongPassword" enter Key false
    When UI Click Button "loginButton"
    Then UI Text of "cardHeader" with extension "" contains "M_00257: Invalid username or password. Re-enter them."

  @SID_5
  Scenario: Legal username and password with Enter
    When UI Set Text Field "usernameInput" To "sys_admin" enter Key false
    When UI Set Text Field "passwordInput" To "radware" enter Key true
    Then UI Validate Text field "logedInUsername" EQUALS "sys_admin"
    When UI Logout

  @SID_6
  Scenario: Wrong username
    When UI Set Text Field "usernameInput" To "????" enter Key false
    When UI Set Text Field "passwordInput" To "radware" enter Key false
    When UI Click Button "loginButton"
    Then UI Text of "cardHeader" with extension "" contains "M_00257: Invalid username or password. Re-enter them."

  @SID_7
  Scenario: expired password

  @SID_8
  Scenario: specific characters

  Scenario: login without activate license
    * REST Vision DELETE License Request "vision-activation"
    When UI Logout
    When UI Set Text Field "usernameInput" To "sys_admin" enter Key false
    When UI Set Text Field "passwordInput" To "radware" enter Key false
    Then UI Text of "cardHeader" with extension "" contains "The installation does not have an activation license. Please provide it."
    * REST Vision Install License Request "vision-activation"
    When UI Click Button "loginButton"
    Then UI Validate Text field "logedInUsername" EQUALS "sys_admin"

  Scenario: logout
    * REST Vision Install License Request "vision-activation"
    When UI logout and close browser

