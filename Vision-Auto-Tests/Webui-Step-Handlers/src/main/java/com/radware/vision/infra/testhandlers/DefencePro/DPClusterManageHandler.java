package com.radware.vision.infra.testhandlers.DefencePro;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.restcommands.mgmtcommands.tree.DeviceCommands;
import com.radware.utils.device.DeviceScalarUtils;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.DeviceInfo;
import com.radware.vision.infra.base.pages.defensepro.DpClusterInformationPane;
import com.radware.vision.infra.base.pages.defensepro.HAStatus;
import com.radware.vision.infra.base.pages.topologytree.DPClusterProperties;
import com.radware.vision.infra.enums.ClusterAssociatedMgmtPorts;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.testhandlers.DefencePro.enums.DPHaDeviceStatus;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import org.openqa.selenium.support.How;

import java.util.ArrayList;
import java.util.List;

public class DPClusterManageHandler extends BaseHandler {

    public static void createDPCluster(List<DeviceInfo> containedDPDevices, String clusterName, String primaryDevice, ClusterAssociatedMgmtPorts mgmtPort) throws Exception {
        // Break OLD Cluster if exist
        List<String> deviceNames = new ArrayList<>();
        boolean needToWait = false;
        try {
            for (DeviceInfo deviceInfo : containedDPDevices) {
                DeviceCommands deviceCommands = new DeviceCommands(restTestBase.getVisionRestClient());
                deviceCommands.lockDeviceByManagementIp(deviceInfo.getDeviceIp());
                deviceNames.add(deviceInfo.getDeviceName());
                String scalar = DeviceScalarUtils.getScalarValueByKey(restTestBase.getVisionRestClient(), deviceInfo.getDeviceIp(), "rdwrDPHighAvailabilityStatus");
                if (scalar.equals("1")) {
                    needToWait = true;
                    DeviceScalarUtils.putScalar(restTestBase.getVisionRestClient(), deviceInfo.getDeviceIp(), "rdwrDPHighAvailabilityStatus=2");
                }
            }
        } catch (Exception e) {
            BaseTestUtils.report("Break OLD Cluster error: ", e);
        }
        if (needToWait) {
            BasicOperationsHandler.delay(120);
        }

        DPClusterProperties dpClusterProperties = new DPClusterProperties();
        TopologyTreeHandler.openSitesAndClusters();
        TopologyTreeHandler.multiSelection(deviceNames);
        dpClusterProperties.openPage();
        dpClusterProperties.setClusterName(clusterName);
        dpClusterProperties.setPrimaryDevice(primaryDevice);
        BasicOperationsHandler.delay(2);
        dpClusterProperties.submit("gwt-debug-device_properties_SubmitButton");
    }

    public static void breakDPCluster(String clusterName) {
        DPClusterProperties dpClusterProperties = new DPClusterProperties();
        TopologyTreeHandler.openSitesAndClusters();
        TopologyTreeHandler.expandAllSitesClusters();
        TopologyTreeHandler.clickTreeNode(clusterName);
        dpClusterProperties.openBreakClusterDialog();
    }

    public static void dpClusterSwitchover(String dpClusterName) throws Exception {
        innerOperation(dpClusterName);
        DpClusterInformationPane dpClusterInformationPane = new DpClusterInformationPane();
        dpClusterInformationPane.switchover();
    }

    public static void dpClusterUpdatePolicies(String dpClusterName) throws Exception {
        innerOperation(dpClusterName);
        DpClusterInformationPane dpClusterInformationPane = new DpClusterInformationPane();
        dpClusterInformationPane.updatePolicies();
    }

    public static void dpClusterSync(String dpClusterName) throws Exception {
        innerOperation(dpClusterName);
        DpClusterInformationPane dpClusterInformationPane = new DpClusterInformationPane();
        dpClusterInformationPane.sychronize();
    }

    private static void innerOperation(String dpClusterName) {
        TopologyTreeHandler.openSitesAndClusters();
        TopologyTreeHandler.clickTreeNode(dpClusterName);
    }

    public static boolean verifyDeviceHaStatus(String haEntity, DPHaDeviceStatus expectedDeviceStatus) {
        TopologyTreeHandler.openSitesAndClusters();
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getDeviceTreeNode(haEntity));
        WebUIComponent targetNode = new WebUIComponent(locator);
        String targetNodeAttribute = targetNode.getAttribute("class");
        if (targetNodeAttribute.contains(expectedDeviceStatus.getStatus())) {
            return true;
        } else {
            String errMsg = String.format("Cluster node: %s, Status: %s", haEntity, targetNodeAttribute);
            BaseTestUtils.report(errMsg, Reporter.FAIL);
            return false;
        }
    }

    public static boolean isDpDeviceMember(String dpClusterName, String clusterMember, HAStatus haStatus) {
        switch (haStatus){
            case Primary:
                return innerCheckStatus(dpClusterName, clusterMember, HAStatus.Primary);
            case Secondary:
                return innerCheckStatus(dpClusterName, clusterMember, HAStatus.Secondary);
        }
        return false;
    }

    public static boolean isPrimaryDpDeviceMember(String dpClusterName, String clusterMember) {
        return innerCheckStatus(dpClusterName, clusterMember, HAStatus.Primary);
    }

    public static boolean isSecondaryDpDeviceMember(String dpClusterName, String clusterMember) {
        return innerCheckStatus(dpClusterName, clusterMember, HAStatus.Secondary);
    }

    public static boolean waitForHASetupToUp(String dpClusterName, int timeout) throws Exception{

        long startTime = System.currentTimeMillis();

        while(!TopologyTreeHandler.isTreeNodeExist(dpClusterName)) {
            Thread.sleep(1000L);
            if (System.currentTimeMillis() - startTime >= timeout) {
                return false;
            }
        }

        return true;

    }

    private static boolean innerCheckStatus(String dpClusterName, String clusterMember, HAStatus requestedStatus) {
        TopologyTreeHandler.openSitesAndClusters();
        TopologyTreeHandler.clickTreeNode(dpClusterName);

        DpClusterInformationPane dpClusterInformationPane = new DpClusterInformationPane();
        return requestedStatus == HAStatus.Primary ? dpClusterInformationPane.isDpDevicePrimary(clusterMember) :
                dpClusterInformationPane.isDpDeviceSecondary(clusterMember);
    }
}
