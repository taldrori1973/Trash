@TC127093
Feature: Top Source IPs Chart
  @SID_1
  Scenario: Clean system data before Top Source IPs Chart Test
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "df-*"
    * REST Delete ES index "traffic-*"
    * REST Delete ES index "attack-*"