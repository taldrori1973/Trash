Feature: test

  @SID_1
  Scenario: Login and Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "ADC REPORTS" page via homepage
    Then UI Click Button "New Report Tab"

  @SID_2
  Scenario: create new BDoS-TCP SYN1
    Given UI "Create" Report With Name "Lp Report"
      | Template | reportType:LinkProof ,Widgets:[CEC] , devices:[RnDLinkproof] ,WANLinks:[w1,w2] |

  @SID_3
  Scenario: create new BDoS-TCP SYN1
    Given UI "Validate" Report With Name "Lp Report"
      | Template | reportType:LinkProof,Widgets:[CEC],devices:[RnDLinkproof],WANLinks:[w1,w2] |
