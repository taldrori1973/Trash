
Feature: Alerts

  Scenario: Login to VRM "Alerts" tab
    Given UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS Alerts" page via homePage

    When UI "Create" Alerts With Name "Alert Alteon1"
      | Basic Info      | Description:Src Port,Impact:some impact,Remedy: who knows,Severity:Info  |
      | Product         | Appwall                                                                  |
      | reportType      | defenseflow analytics dashboard                                          |
      | webApplications | Vision,Vision1                                                           |
      | Criteria        | Event Criteria:Source Port,Operator:Equals,portType:Port,portValue:1024; |
      | Schedule        | triggerThisRule:2,Within:4,selectTimeUnit:days,alertsPerHour:60          |

    When UI "Create" Alerts With Name "Alert AlteonAll"
      | Basic Info      | Description:Src Port,Impact:some impact,Remedy: who knows,Severity:Info  |
      | Product         | Appwall                                                                  |
      | reportType      | defenseflow analytics dashboard                                          |
      | webApplications | All                                                                      |
      | Criteria        | Event Criteria:Source Port,Operator:Equals,portType:Port,portValue:1024; |
      | Schedule        | triggerThisRule:2,Within:4,selectTimeUnit:days,alertsPerHour:60          |

    When UI "Create" Alerts With Name "Alert DF1"
      | Basic Info     | Description:Src Port,Impact:some impact,Remedy: who knows,Severity:Info  |
      | Product        | DefenseFlow                                                              |
      | reportType     | defenseflow analytics dashboard                                          |
      | projectObjects | PO_1,PO_10                                                               |
      | Criteria       | Event Criteria:Source Port,Operator:Equals,portType:Port,portValue:1024; |
      | Schedule       | triggerThisRule:2,Within:4,selectTimeUnit:days,alertsPerHour:60          |

    When UI "Create" Alerts With Name "Alert DFAll"
      | Basic Info     | Description:Src Port,Impact:some impact,Remedy: who knows,Severity:Info  |
      | Product        | DefenseFlow                                                              |
      | reportType     | defenseflow analytics dashboard                                          |
      | projectObjects | All                                                                      |
      | Criteria       | Event Criteria:Source Port,Operator:Equals,portType:Port,portValue:1024; |
      | Schedule       | triggerThisRule:2,Within:4,selectTimeUnit:days,alertsPerHour:60          |

    When UI "Create" Alerts With Name "Alert Policy1"
      | Basic Info | Description:Src Port,Impact:some impact,Remedy: who knows,Severity:Info              |
      | devices    | [{setId:DefensePro_Set_1,policies:[pol_1]},{setId:DefensePro_Set_2,policies:[pol1]}] |
      | Criteria   | Event Criteria:Source Port,Operator:Equals,portType:Port,portValue:1024;             |
      | Schedule   | triggerThisRule:2,Within:4,selectTimeUnit:days,alertsPerHour:60                      |

    When UI "Create" Alerts With Name "Alert PolicyAll"
      | Basic Info | Description:Src Port,Impact:some impact,Remedy: who knows,Severity:Info  |
      | devices    | [{setId:DefensePro_Set_1,policies:[All]}]                                |
      | Criteria   | Event Criteria:Source Port,Operator:Equals,portType:Port,portValue:1024; |
      | Schedule   | triggerThisRule:2,Within:4,selectTimeUnit:days,alertsPerHour:60          |

    When UI "Create" Alerts With Name "Alert Port1"
      | Basic Info | Description:Src Port,Impact:some impact,Remedy: who knows,Severity:Info         |
      | devices    | [{setId:DefensePro_Set_1,ports:[1,2,3]},{setId:DefensePro_Set_2,ports:[1,2,3]}] |
      | Criteria   | Event Criteria:Source Port,Operator:Equals,portType:Port,portValue:1024;        |
      | Schedule   | triggerThisRule:2,Within:4,selectTimeUnit:days,alertsPerHour:60                 |

    When UI "Create" Alerts With Name "Alert PortAll"
      | Basic Info | Description:Src Port,Impact:some impact,Remedy: who knows,Severity:Info     |
      | devices    | [{setId:DefensePro_Set_1,ports:[All]},{setId:DefensePro_Set_2,ports:[All]}] |
      | Criteria   | Event Criteria:Source Port,Operator:Equals,portType:Port,portValue:1024;    |
      | Schedule   | triggerThisRule:2,Within:4,selectTimeUnit:days,alertsPerHour:60             |