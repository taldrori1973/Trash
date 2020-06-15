Feature: VM Utils

  @RemoveVMs
  Scenario: Remove All VM that are OFF more than 24 hours
    When Remove old VMs
      | VmMachinePrefix    |
      | VisionAutoPositive |
      | VisionAutoAPM      |
      | VisionAutoNegative |
      | freshInstallTest   |

@Update_Snapshot
    Scenario: Update Snapshot
  Given UI Login with user "radware" and password "radware"
  Then UI logout and close browser
#      Given Upgrade Vision According To SUT Snapshot
