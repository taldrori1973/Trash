@Feature3
  Feature: CI feature 3

    @SID_1
    Scenario: Feature 3 test 1
      Given UI Login with user "radware" and password "radware"
      Then UI logout and close browser

    @SID_2
    Scenario: Feature 3 test 2
      Given UI Login with user "radware" and password "radware"
      Then UI logout and close browser