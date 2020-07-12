@Feature1
  Feature: CI feature 1

    @SID_1
    Scenario: Feature 1 test 1
      Given UI Login with user "radware" and password "radware"
      Then UI logout and close browser

    @SID_2
    Scenario: Feature 1 test 2
      Given UI Login with user "radware" and password "radware"
      Then UI logout and close browser