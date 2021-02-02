Feature: VM Utils

  @RemoveVMs
  Scenario: Remove All VM that are OFF more than 24 hours
    When Remove old VMs
      | VmMachinePrefix     |
      | VisionAutoPositive  |
      | VisionAutoAPM       |
      | VisionAutoNegative  |
      | freshInstallTest    |
      | VisionAutoHiScale   |

  @Update_Snapshot
  Scenario: Update Snapshot
    Given Upgrade Vision According To SUT Snapshot
