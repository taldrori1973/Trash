package com.radware.vision.system.snmp;

public class SnmpHelpTexts {

    public static final String helpSnmp = "community               SNMP community settings.\r\n" + "service                 Configures the SNMP service.\r\n" +
            "trap                    SNMP trap settings.\r\n";
    public static final String helpSnmpCommunity = "add                     Add an SNMP community.\r\n" + "delete                  Delete an SNMP community.\r\n" +
            "list                    Display the list of SNMP communities.\r\n";
    public static final String helpSnmpCommunityAdd = "Usage: system snmp community add <community>\r\n" + "\r\n" + "Add an SNMP community.\r\n";
    public static final String helpSnmpCommunityDelete = "Usage: system snmp community delete <community>\r\n" + "\r\n" + "Delete an SNMP community.\r\n";
    public static final String helpSnmpCommunityList = "Usage: system snmp community list \r\n" + "\r\n" + "Display the list of SNMP communities.\r\n";

    public static final String helpSnmpTrap = "target                  SNMP trap target settings.\r\n";
    public static final String helpSnmpTrapTarget = "add                     Add an SNMP trap target.\r\n" + "delete                  Delete an SNMP trap target.\r\n" +
            "list                    Display the list of SNMP trap target.\r\n";
    public static final String helpSnmpTrapTargetAdd = "Add an SNMP trap target.\r\n" + "Host: The destination host.\r\n" + "Community: The trap community.\r\n" +
            "Port (optional): The destination port.\r\n";
    public static final String helpSnmpTrapTargetDelete = "Usage: system snmp trap target delete <host> <community>\r\n" + "\r\n" +"Delete an SNMP trap target.\r\n";
    public static final String helpSnmpTrapTargetList = "Usage: system snmp trap target list \r\n" + "\r\n" + "Display the list of SNMP trap target.\r\n\r\n";
}