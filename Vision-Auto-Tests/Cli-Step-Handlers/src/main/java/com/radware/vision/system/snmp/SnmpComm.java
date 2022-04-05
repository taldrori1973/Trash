package com.radware.vision.system.snmp;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import org.snmp4j.CommunityTarget;
import org.snmp4j.PDU;
import org.snmp4j.Snmp;
import org.snmp4j.event.ResponseEvent;
import org.snmp4j.mp.SnmpConstants;
import org.snmp4j.smi.*;
import org.snmp4j.transport.DefaultUdpTransportMapping;

import java.io.IOException;

public class SnmpComm {

    public static String getSnmpResponse(String community, String OID, RadwareServerCli radwareServerCli) throws IOException {
        Snmp snmp4j = new Snmp(new DefaultUdpTransportMapping());
        snmp4j.listen();
        Address add = new UdpAddress(radwareServerCli.getHost() + "/" + "161");
        CommunityTarget target = new CommunityTarget();

        target.setAddress(add);
        target.setTimeout(500);
        target.setRetries(3);
        target.setCommunity(new OctetString(community));
        target.setVersion(SnmpConstants.version2c);

        PDU request = new PDU();
        request.setType(PDU.GET);
        org.snmp4j.smi.OID oid= new OID(OID);
        request.add(new VariableBinding(oid));

        ResponseEvent responseEvent;
        responseEvent = snmp4j.send(request, target);
        if(responseEvent.getResponse() == null) {
            return null;
        }
        return responseEvent.getResponse().getVariableBindings().toString();
    }
}
