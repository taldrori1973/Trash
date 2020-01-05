Feature: aa

  Scenario:
#  Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"

    Then REST Login with user "radware" and password "radware"
    Then REST Add "DefensePro" Device To topology Tree with Name "DefensePro_172.16.22.50" and Management IP "172.16.22.50" into site "Default"
      | attribute   | value |
      | cliUsername |       |
      | cliPassword |       |
      | httpUsername |       |
      | httpPassword |       |
      | httpsPassword |       |
      | httpsPassword |       |

    Given REST Login with activation with user "<any>" and password "<any>"
