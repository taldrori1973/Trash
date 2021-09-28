@TC122727
Feature: Top Attack by GeoLocation


  @SID_1
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    Given CLI Reset radware password
    * REST Delete ES index "dp-*"

  @SID_2
  Scenario: Run DP simulator for ErtFeed_GeoFeed
    Given CLI simulate 1000 attacks of type "GEO" on "DefensePro" 11 with loopDelay 1500 and wait 60 seconds
    Given CLI simulate 1000 attacks of type "ErtFeed_GeoFeed" on "DefensePro" 11 with loopDelay 1500 and wait 60 seconds

    Then Sleep "15"


  @SID_3
  Scenario: Login and add widgets
    When UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    Then UI Click Button "Widget Selection"
    Then UI Click Button "Widget Selection.Clear Dashboard"
    Then UI Click Button "Widget Selection.Remove All Confirm"
   Then UI Click Button "Geolocation widget"
    Then UI Click Button "Widget Selection.Add Selected Widgets"
    Then UI Click Button "Widget Selection"
    Then Sleep "30"

  @SID_4
  Scenario: Validate Top Attacking by GeoLocations Widget, 15m
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "15m"
    Then Sleep "30"

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
    Then Sleep "30"


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
    Then Sleep "30"

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
    Then Sleep "30"

    # Validate Multiple country
    Then UI Validate Text field "Country Name" with params "Multiple" EQUALS "Multiple"
    Then UI Validate Text field "Country Value" with params "Multiple" EQUALS "50%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "Multiple" EQUALS "1"

    # Validate China country
    Then UI Validate Text field "Country Name" with params "China" EQUALS "China"
    Then UI Validate Text field "Country Value" with params "CN" EQUALS "50%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "CN" EQUALS "1"


  @SID_8
  Scenario: Clear data
    * CLI kill all simulator attacks on current vision
    Given CLI Reset radware password
    * REST Delete ES index "dp-*"

  @SID_9
  Scenario: Run DP simulator for ErtFeed_GeoFeed
    Given CLI simulate 1000 attacks of type "GeoPlus10" on "DefensePro" 11 with loopDelay 1500 and wait 60 seconds
    Then Sleep "15"

  @SID_10
  Scenario: Login and add widgets
    When UI Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    Then UI Click Button "Widget Selection"
    Then UI Click Button "Widget Selection.Clear Dashboard"
    Then UI Click Button "Widget Selection.Remove All Confirm"
    Then UI Click Button "Geolocation widget"
    Then UI Click Button "Widget Selection.Add Selected Widgets"
    Then UI Click Button "Widget Selection"
    Then Sleep "30"

  @SID_11
  Scenario: Validate Top Attacking by GeoLocations Widget with more than 10 countries
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "15m"
    Then Sleep "30"


    Then UI Validate Text field "Country Name" with params "Multiple" EQUALS "Multiple"
    Then UI Validate Text field "Country Value" with params "Multiple" EQUALS "10%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "Multiple" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "China" EQUALS "China"
    Then UI Validate Text field "Country Value" with params "CN" EQUALS "10%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "CN" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "France" EQUALS "France"
    Then UI Validate Text field "Country Value" with params "FR" EQUALS "10%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "FR" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "India" EQUALS "India"
    Then UI Validate Text field "Country Value" with params "IN" EQUALS "10%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "IN" EQUALS "1"
    Then Sleep "30"

    Then UI Validate Text field "Country Name" with params "Korea, Republic of" EQUALS "Korea, Republic of"
    Then UI Validate Text field "Country Value" with params "KR" EQUALS "10%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "KR" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "Lithuania" EQUALS "Lithuania"
    Then UI Validate Text field "Country Value" with params "LT" EQUALS "10%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "LT" EQUALS "1"
  Then Sleep "30"
    Then UI Validate Text field "Country Name" with params "Moldova, Republic of" EQUALS "Moldova, Republic of"
    Then UI Validate Text field "Country Value" with params "LD" EQUALS "10%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "LD" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "Mexico" EQUALS "Mexico"
    Then UI Validate Text field "Country Value" with params "MX" EQUALS "10%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "MX" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "Sweden" EQUALS "Sweden"
    Then UI Validate Text field "Country Value" with params "SE" EQUALS "10%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "SE" EQUALS "1"

    Then UI Validate Text field "Country Name" with params "Singapore" EQUALS "Singapore"
    Then UI Validate Text field "Country Value" with params "SG" EQUALS "10%" with offset 1
    Then UI Validate Text field "Total Events Value" with params "SG" EQUALS "1"



  @SID_9
  Scenario: Logout and close browser
    Given UI logout and close browser