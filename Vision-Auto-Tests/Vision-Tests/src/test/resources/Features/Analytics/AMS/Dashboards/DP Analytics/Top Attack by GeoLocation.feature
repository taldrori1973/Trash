@TC122727
Feature: Top Attack by GeoLocation


  @SID_1
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    Given CLI Reset radware password
    * REST Delete ES index "dp-*"

  @SID_2
  Scenario: Run DP simulator for ErtFeed_GeoFeed
    Given CLI simulate 1000 attacks of type "ErtFeed_GeoFeed" on "DefensePro" 11 with loopDelay 15000 and wait 60 seconds
    Given CLI simulate 1000 attacks of type "GEO" on "DefensePro" 11 with loopDelay 15000 and wait 60 seconds
    Then Sleep "15"


  @SID_3
  Scenario: Login and add widgets
    When UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage

  @SID_4
  Scenario: Validate Top Attacking by GeoLocations Widget, 15m
    # Validate Header chart
    Then UI Validate Text field "Chart" with params "Top Attacking by GeoLocation" EQUALS "Top Attacking by GeoLocation"

     # Validate Multiple country
    Then UI Validate Text field "Country Name" with params "Multiple" EQUALS "Multiple"
    Then UI Validate Text field "Country Value" with params "Multiple" EQUALS "67%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "Multiple" EQUALS "2"



    # Validate China country
    Then UI Validate Text field "Country Name" with params "China" EQUALS "China"
    Then UI Validate Text field "Country Value" with params "CN" EQUALS "33%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "CN" EQUALS "1"


  @SID_5
  Scenario: Validate Top Attacking by GeoLocations Widget, 30m
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "30m"
    # Validate Header chart
    Then UI Validate Text field "Chart" with params "Top Attacking by GeoLocation" EQUALS "Top Attacking by GeoLocation"

     # Validate Multiple country
    Then UI Validate Text field "Country Name" with params "Multiple" EQUALS "Multiple"
    Then UI Validate Text field "Country Value" with params "Multiple" EQUALS "67%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "Multiple" EQUALS "2"

    # Validate China country

    Then UI Validate Text field "Country Name" with params "China" EQUALS "China"
    Then UI Validate Text field "Country Value" with params "CN" EQUALS "33%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "CN" EQUALS "1"

  @SID_6
  Scenario: Validate Top Attacking by GeoLocations Widget, 1H
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1H"
    # Validate Header chart
    Then UI Validate Text field "Chart" with params "Top Attacking by GeoLocation" EQUALS "Top Attacking by GeoLocation"

     # Validate Multiple country
    Then UI Validate Text field "Country Name" with params "Multiple" EQUALS "Multiple"
    Then UI Validate Text field "Country Value" with params "Multiple" EQUALS "67%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "Multiple" EQUALS "2"

    # Validate China country
    Then UI Validate Text field "Country Name" with params "China" EQUALS "China"
    Then UI Validate Text field "Country Value" with params "CN" EQUALS "33%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "CN" EQUALS "1"


  @SID_7
  Scenario:  Click on  Exclude Malicious IP Addresses
    Then UI Click Button "Exclude Malicious IP Addresses Checkbox"
    Then UI Validate the attribute "data-debug-checked" Of Label "Exclude Malicious IP Addresses Checkbox" is "EQUALS" to "true"
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "30m"

    # Validate Multiple country
    Then UI Validate Text field "Country Name" with params "Multiple" EQUALS "Multiple"
    Then UI Validate Text field "Country Value" with params "Multiple" EQUALS "50%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "Multiple" EQUALS "1"

    # Validate China country
    Then UI Validate Text field "Country Name" with params "China" EQUALS "China"
    Then UI Validate Text field "Country Value" with params "CN" EQUALS "50%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "CN" EQUALS "1"

  @SID_9
  Scenario: Logout and close browser
    Given UI logout and close browser