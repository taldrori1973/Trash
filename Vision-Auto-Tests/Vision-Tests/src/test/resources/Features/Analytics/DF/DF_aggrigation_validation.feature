@TC111080
Feature:  DF Statistics - Data Aggregation

  @SID_18
  Scenario: Change DF managment IP to IP of Generic Linux
    When CLI Operations - Run Radware Session command "system df management-ip set 172.17.164.10"
    When CLI Operations - Run Radware Session command "system df management-ip get"
    Then CLI Operations - Verify that output contains regex "DefenseFlow Management IP Address: 172.17.164.10"

  @SID_1
  Scenario: Copy retention verification script
    Then CLI copy "/home/radware/Scripts/get_ES_key_value_df.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"

    * REST Delete ES index "df-traffic-*"
    * Sleep "10"

    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER" and wait for prompt "False"
      | "nohup /home/radware/curl_DF_traffic_2_row_aggrigation.sh " |
      | #visionIP                                      |
      | " aggrigation_PO 20"                                   |
    * Sleep "90"



  @SID_2
  Scenario: Run DF aggregation
    Then CLI Run remote linux Command "curl -X POST --header 'Content-Type: application/json' --header 'Accept: */*' 'http://localhost:10080/reporter/mgmt/monitor/reporter/internal-dashboard/scheduledTasks?jobClassName=com.reporter.df.task.traffic.DFTrafficUtilizationAggregationTask'" on "ROOT_SERVER_CLI"
    * Sleep "120"

  #  tcp pps
  @SID_4
  Scenario: validate average values of fields in index df-traffic-agg units=pps monitoringProtocol=tcp
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps tcp inbound" on "ROOT_SERVER_CLI" and validate result EQUALS "1500.0" with timeOut 600
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps tcp dropped" on "ROOT_SERVER_CLI" and validate result EQUALS "75.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps tcp diverted" on "ROOT_SERVER_CLI" and validate result EQUALS "15.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps tcp discarded" on "ROOT_SERVER_CLI" and validate result EQUALS "7.5"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps tcp clean" on "ROOT_SERVER_CLI" and validate result EQUALS "1.5"

    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps tcp inboundAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "90000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps tcp droppedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "4500.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps tcp divertedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "900.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps tcp discardedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "450.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps tcp cleanAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "90.0"

  #  tcp bps
  @SID_5
  Scenario: validate average values of fields in index df-traffic-agg units=bps monitoringProtocol=tcp
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps tcp inbound" on "ROOT_SERVER_CLI" and validate result EQUALS "7.5"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps tcp dropped" on "ROOT_SERVER_CLI" and validate result EQUALS "6.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps tcp diverted" on "ROOT_SERVER_CLI" and validate result EQUALS "4.5"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps tcp discarded" on "ROOT_SERVER_CLI" and validate result EQUALS "3.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps tcp clean" on "ROOT_SERVER_CLI" and validate result EQUALS "1.5"

    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps tcp inboundAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "450.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps tcp droppedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "360.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps tcp divertedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "270.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps tcp discardedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "180.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps tcp cleanAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "90.0"




  #  udp pps
  @SID_6
  Scenario: validate average values of fields in index df-traffic-agg units=pps monitoringProtocol=udp
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps udp inbound" on "ROOT_SERVER_CLI" and validate result EQUALS "1.5E9"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps udp dropped" on "ROOT_SERVER_CLI" and validate result EQUALS "7.5E7"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps udp diverted" on "ROOT_SERVER_CLI" and validate result EQUALS "1.5E7"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps udp discarded" on "ROOT_SERVER_CLI" and validate result EQUALS "7500000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps udp clean" on "ROOT_SERVER_CLI" and validate result EQUALS "1500000.0"

    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps udp inboundAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "9.0E10"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps udp droppedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "4.5E9"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps udp divertedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "9.0E8"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps udp discardedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "4.5E8"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps udp cleanAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "9.0E7"

  #  udp bps
  @SID_7
  Scenario: validate average values of fields in index df-traffic-agg units=bps monitoringProtocol=udp
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps udp inbound" on "ROOT_SERVER_CLI" and validate result EQUALS "7500000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps udp dropped" on "ROOT_SERVER_CLI" and validate result EQUALS "6000000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps udp diverted" on "ROOT_SERVER_CLI" and validate result EQUALS "4500000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps udp discarded" on "ROOT_SERVER_CLI" and validate result EQUALS "3000000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps udp clean" on "ROOT_SERVER_CLI" and validate result EQUALS "1500000.0"

    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps udp inboundAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "4.5E8"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps udp droppedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "3.6E8"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps udp divertedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "2.7E8"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps udp discardedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "1.8E8"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps udp cleanAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "9.0E7"



  #  all pps
  @SID_8
  Scenario: validate average values of fields in index df-traffic-agg units=pps monitoringProtocol=all
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps all inbound" on "ROOT_SERVER_CLI" and validate result EQUALS "1.5166665E9"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps all dropped" on "ROOT_SERVER_CLI" and validate result EQUALS "7.5833325E7"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps all diverted" on "ROOT_SERVER_CLI" and validate result EQUALS "1.5166665E7"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps all discarded" on "ROOT_SERVER_CLI" and validate result EQUALS "7583332.5"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps all clean" on "ROOT_SERVER_CLI" and validate result EQUALS "1516666.5"

    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps all inboundAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "9.099999E10"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps all droppedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "4.5499995E9"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps all divertedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "9.099999E8"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps all discardedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "4.5499995E8"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps all cleanAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "9.099999E7"

  #  all bps
  @SID_9
  Scenario: validate average values of fields in index df-traffic-agg units=bps monitoringProtocol=all
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps all inbound" on "ROOT_SERVER_CLI" and validate result EQUALS "7583332.5"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps all dropped" on "ROOT_SERVER_CLI" and validate result EQUALS "6066666.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps all diverted" on "ROOT_SERVER_CLI" and validate result EQUALS "4549999.5"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps all discarded" on "ROOT_SERVER_CLI" and validate result EQUALS "3033333.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps all clean" on "ROOT_SERVER_CLI" and validate result EQUALS "1516666.5"

    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps all inboundAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "4.5499995E8"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps all droppedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "3.6399996E8"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps all divertedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "2.7299997E8"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps all discardedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "1.8199998E8"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps all cleanAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "9.099999E7"




      #  icmp pps
  @SID_10
  Scenario: validate average values of fields in index df-traffic-agg units=pps monitoringProtocol=icmp
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps icmp inbound" on "ROOT_SERVER_CLI" and validate result EQUALS "1500000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps icmp dropped" on "ROOT_SERVER_CLI" and validate result EQUALS "75000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps icmp diverted" on "ROOT_SERVER_CLI" and validate result EQUALS "15000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps icmp discarded" on "ROOT_SERVER_CLI" and validate result EQUALS "7500.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps icmp clean" on "ROOT_SERVER_CLI" and validate result EQUALS "1500.0"

    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps icmp inboundAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "9.0E7"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps icmp droppedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "4500000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps icmp divertedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "900000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps icmp discardedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "450000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps icmp cleanAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "90000.0"

  #  icmp bps
  @SID_11
  Scenario: validate average values of fields in index df-traffic-agg units=bps monitoringProtocol=icmp
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps icmp inbound" on "ROOT_SERVER_CLI" and validate result EQUALS "7500.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps icmp dropped" on "ROOT_SERVER_CLI" and validate result EQUALS "6000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps icmp diverted" on "ROOT_SERVER_CLI" and validate result EQUALS "4500.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps icmp discarded" on "ROOT_SERVER_CLI" and validate result EQUALS "3000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps icmp clean" on "ROOT_SERVER_CLI" and validate result EQUALS "1500.0"

    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps icmp inboundAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "450000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps icmp droppedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "360000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps icmp divertedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "270000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps icmp discardedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "180000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps icmp cleanAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "90000.0"




  #  igmp pps
  @SID_12
  Scenario: validate average values of fields in index df-traffic-agg units=pps monitoringProtocol=igmp
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps igmp inbound" on "ROOT_SERVER_CLI" and validate result EQUALS "150000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps igmp dropped" on "ROOT_SERVER_CLI" and validate result EQUALS "7500.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps igmp diverted" on "ROOT_SERVER_CLI" and validate result EQUALS "1500.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps igmp discarded" on "ROOT_SERVER_CLI" and validate result EQUALS "750.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps igmp clean" on "ROOT_SERVER_CLI" and validate result EQUALS "150.0"

    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps igmp inboundAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "9000000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps igmp droppedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "450000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps igmp divertedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "90000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps igmp discardedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "45000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps igmp cleanAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "9000.0"

  #  igmp bps
  @SID_13
  Scenario: validate average values of fields in index df-traffic-agg units=bps monitoringProtocol=igmp
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps igmp inbound" on "ROOT_SERVER_CLI" and validate result EQUALS "750.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps igmp dropped" on "ROOT_SERVER_CLI" and validate result EQUALS "600.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps igmp diverted" on "ROOT_SERVER_CLI" and validate result EQUALS "450.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps igmp discarded" on "ROOT_SERVER_CLI" and validate result EQUALS "300.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps igmp clean" on "ROOT_SERVER_CLI" and validate result EQUALS "150.0"

    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps igmp inboundAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "45000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps igmp droppedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "36000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps igmp divertedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "27000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps igmp discardedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "18000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps igmp cleanAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "9000.0"




  #  sctp pps
  @SID_14
  Scenario: validate average values of fields in index df-traffic-agg units=pps monitoringProtocol=sctp
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps sctp inbound" on "ROOT_SERVER_CLI" and validate result EQUALS "15000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps sctp dropped" on "ROOT_SERVER_CLI" and validate result EQUALS "750.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps sctp diverted" on "ROOT_SERVER_CLI" and validate result EQUALS "150.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps sctp discarded" on "ROOT_SERVER_CLI" and validate result EQUALS "75.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps sctp clean" on "ROOT_SERVER_CLI" and validate result EQUALS "15.0"

    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps sctp inboundAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "900000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps sctp droppedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "45000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps sctp divertedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "9000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps sctp discardedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "4500.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps sctp cleanAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "900.0"

  #  sctp bps
  @SID_15
  Scenario: validate average values of fields in index df-traffic-agg units=bps monitoringProtocol=sctp
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps sctp inbound" on "ROOT_SERVER_CLI" and validate result EQUALS "75.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps sctp dropped" on "ROOT_SERVER_CLI" and validate result EQUALS "60.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps sctp diverted" on "ROOT_SERVER_CLI" and validate result EQUALS "45.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps sctp discarded" on "ROOT_SERVER_CLI" and validate result EQUALS "30.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps sctp clean" on "ROOT_SERVER_CLI" and validate result EQUALS "15.0"

    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps sctp inboundAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "4500.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps sctp droppedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "3600.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps sctp divertedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "2700.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps sctp discardedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "1800.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps sctp cleanAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "900.0"




  #  other pps
  @SID_16
  Scenario: validate average values of fields in index df-traffic-agg units=pps monitoringProtocol=other
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps other inbound" on "ROOT_SERVER_CLI" and validate result EQUALS "1.5E7"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps other dropped" on "ROOT_SERVER_CLI" and validate result EQUALS "750000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps other diverted" on "ROOT_SERVER_CLI" and validate result EQUALS "150000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps other discarded" on "ROOT_SERVER_CLI" and validate result EQUALS "75000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps other clean" on "ROOT_SERVER_CLI" and validate result EQUALS "15000.0"

    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps other inboundAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "9.0E8"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps other droppedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "4.5E7"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps other divertedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "9000000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps other discardedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "4500000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg pps other cleanAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "900000.0"

  #  other bps
  @SID_17
  Scenario: validate average values of fields in index df-traffic-agg units=bps monitoringProtocol=other
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps other inbound" on "ROOT_SERVER_CLI" and validate result EQUALS "75000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps other dropped" on "ROOT_SERVER_CLI" and validate result EQUALS "60000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps other diverted" on "ROOT_SERVER_CLI" and validate result EQUALS "45000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps other discarded" on "ROOT_SERVER_CLI" and validate result EQUALS "30000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps other clean" on "ROOT_SERVER_CLI" and validate result EQUALS "15000.0"

    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps other inboundAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "4500000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps other droppedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "3600000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps other divertedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "2700000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps other discardedAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "1800000.0"
    Then CLI Run linux Command "/get_ES_key_value_df.sh df-traffic-agg bps other cleanAmount" on "ROOT_SERVER_CLI" and validate result EQUALS "900000.0"




