@TC106042
Feature: Creates VM's

  @SID_1
  Scenario: firstTimeScenario Negative
    When Stop VM Machine
      | VmMachinePrefix            |
      | VisionAutoNegative-4.20.00 |

    Then first Time wizard
      | JenkinsJobName | FileNamePrefix | NewVmName                  |
      | Vision-4.40    | Vision-4.40.00 | VisionAutoNegative-4.40.00 |


  @REST @SID_2
  Scenario: firstTimeScenario REST
    When Stop VM Machine
      | VmMachinePrefix         |
      | VisionAuto-REST-4.20.00 |

    Then first Time wizard
      | JenkinsJobName | FileNamePrefix | NewVmName               |
      | Vision-4.20    | Vision-4.20.00 | VisionAuto-REST-4.20.00 |

  @REST_HA_per @SID_3
  Scenario: firstTimeScenario REST_HA
    When Stop VM Machine
      | VmMachinePrefix            |
      | HA_VisionAuto-REST-4.20.00 |

    Then first Time wizard
      | JenkinsJobName | FileNamePrefix | NewVmName                  |
      | Vision-4.20    | Vision-4.20.00 | HA_VisionAuto-REST-4.20.00 |

  @WebUI_HA @SID_4
  Scenario: firstTimeScenario WebUI_HA
    Then Stop VM Machine
      | VmMachinePrefix             |
      | HA_VisionAuto-WebUI-4.20.00 |

    Then first Time wizard
      | JenkinsJobName | FileNamePrefix | NewVmName                   |
      | Vision-4.20    | Vision-4.20.00 | HA_VisionAuto-WebUI-4.20.00 |

  @WebUI @SID_5
  Scenario: firstTimeScenario WebUI
    Then Stop VM Machine
      | VmMachinePrefix          |
      | VisionAuto-WebUI-4.20.00 |

    Then first Time wizard
      | JenkinsJobName | FileNamePrefix | NewVmName                |
      | Vision-4.20    | Vision-4.20.00 | VisionAuto-WebUI-4.20.00 |


  @WebUI_Sanity @SID_6
  Scenario: firstTimeScenario WebUI_Sanity
    When Stop VM Machine
      | VmMachinePrefix                 |
      | VisionAuto-WebUI-Sanity-4.20.00 |

    Then first Time wizard
      | JenkinsJobName | FileNamePrefix | NewVmName                       |
      | Vision-4.20    | Vision-4.20.00 | VisionAuto-WebUI-Sanity-4.20.00 |


  @firstTimeVisionAuto @SID_7
  Scenario: firstTimeScenario VisionAuto
    When Stop VM Machine
      | VmMachinePrefix    |
      | VisionAuto-4.20.00 |

    Then first Time wizard
      | JenkinsJobName | FileNamePrefix | NewVmName          |
      | Vision-4.20    | Vision-4.20.00 | VisionAuto-4.20.00 |
