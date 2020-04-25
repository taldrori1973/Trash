package com.radware.vision.tests.topologytree;

import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;

import java.util.List;

public class TopologyTree {

    public String checkVadcDevices(List<String> devicesNames) {

        StringBuffer existingVadcs = new StringBuffer();
        TopologyTreeHandler.openSitesAndClusters();
        BasicOperationsHandler.refresh();
        for (String currentDeviceName : devicesNames) {
            try {
                BasicOperationsHandler.refresh();
                TopologyTreeHandler.clickTreeNode(currentDeviceName);
            } catch (Exception e) {
                existingVadcs.append("Failed to find vADC: " + currentDeviceName).append("\n");
            }
        }

        return existingVadcs.toString();
    }


}
