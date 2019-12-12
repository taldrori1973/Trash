package com.radware.vision.tests.dp.networkprotection.signatureprotection;

import com.radware.automation.webui.webpages.dp.configuration.networkprotection.signatureprotection.signatures.Signatures;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIButton;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import com.radware.vision.tests.dp.DpTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;
import org.openqa.selenium.support.How;

/**
 * Created by ashrafa on 9/14/2017.
 */
public class SignaturesTests extends DpTestBase {
    int rowNum = 0;

    @Test
    @TestProperties(name = "Signature Find Usage", paramsInclude = {"deviceName","rowNum"})
    public void signatureFindUsage() throws Exception {
        TopologyTreeHandler.clickTreeNode(getDeviceName());
        BaseHandler.initLockDevice(getDeviceName(), TopologyTreeTabs.SitesAndClusters.getTopologyTreeTab(), DeviceState.Lock.getDeviceState());
        Signatures signatures = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mSignatureProtection().mSignatures();
        signatures.openPage();
        WebUITable signatureTable = signatures.getTable();
        signatureTable.selectRow(rowNum);
        ComponentLocator findUsageLocator = new ComponentLocator(How.ID,"gwt-debug-rsIDSAsAttackTable_Find_Usages");
        WebUIButton findUsage = new WebUIButton(new WebUIComponent(findUsageLocator));
        findUsage.click();
    }
    public int getRowNum(){return this.rowNum;}
    public void setRowNum(int rowNum){this.rowNum = rowNum;}
}
