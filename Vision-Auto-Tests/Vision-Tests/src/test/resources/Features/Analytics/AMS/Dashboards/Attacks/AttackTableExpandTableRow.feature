

Feature: Attack Table - Expand Table Row

  @SID_1
  Scenario: Add AVA License and Login
    * REST Login with user "radware" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given UI Login with user "radware" and password "radware"

