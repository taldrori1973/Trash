package com.radware.vision.bddtests.defensepro;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.signatureprotection.signatures.dosshield.DosShield;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIButton;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.DeviceInfo;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.DpTestBaseBDD;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.testhandlers.DefencePro.DPClusterManageHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import cucumber.api.java.en.Then;
import org.openqa.selenium.support.How;

public class DefensePro extends DpTestBaseBDD {

    public DefensePro() throws Exception {
    }

    @Then(("^UI Wait for \"(.*)\" cluster to be created (\\d+) seconds$"))
    public void verifyDPHaStatus(String dpClusterName, int timeout) {
        try {
            BasicOperationsHandler.delay(timeout);
            if(!DPClusterManageHandler.waitForHASetupToUp(dpClusterName, timeout * 1000)){
                BaseTestUtils.report("DP cluster not created", Reporter.FAIL);
            }
        }
        catch (Exception e) {
            BaseTestUtils.report("Waiting for HA setup failed: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then(("^UI Signature Find Usage with index (\\d+) by rowNum (\\d+) seconds$"))
    public void signatureFindUsage(int index, int rowNum) throws Exception {
        WebUITable signatureTable = new WebUITable();
        SUTDeviceType sutDeviceType = SUTDeviceType.valueOf("DefensePro");
        DeviceInfo deviceInfo = devicesManager.getDeviceInfo(sutDeviceType, index);
        setDpDD(deviceInfo.getDeviceName());
        TopologyTreeHandler.clickTreeNode(deviceInfo.getDeviceName());
        BaseHandler.initLockDevice(deviceInfo.getDeviceName(), TopologyTreeTabs.SitesAndClusters.getTopologyTreeTab(), DeviceState.Lock.getDeviceState());
        DosShield signatures = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mSignatureProtection().mSignatures().mDosShield();
        signatures.openPage();
        signatureTable = signatures.getTable();

        signatureTable.selectRow(rowNum);
        ComponentLocator findUsageLocator = new ComponentLocator(How.ID, "gwt-debug-rsIDSAsAttackTable_Find_Usages");
        WebUIButton findUsage = new WebUIButton(new WebUIComponent(findUsageLocator));
        findUsage.click();
    }

    public void setDpDD(String deviceName) throws Exception{
        setDeviceName(deviceName);
        uiInit();
    }
}
