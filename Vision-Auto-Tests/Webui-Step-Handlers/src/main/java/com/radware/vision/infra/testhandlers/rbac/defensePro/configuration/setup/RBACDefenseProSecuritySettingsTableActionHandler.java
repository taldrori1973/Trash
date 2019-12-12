package com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.setup;

import com.radware.automation.webui.webpages.dp.configuration.setup.scuritysettings.bdosprotection.bdosEarlyBlocking.BDoSEarlyBlocking;
import com.radware.automation.webui.webpages.dp.configuration.setup.scuritysettings.bdosprotection.bdosFootprintBypass.BDoSFootprintBypass;
import com.radware.automation.webui.webpages.dp.configuration.setup.scuritysettings.bdosprotection.bdosPacketHeaderSelection.BDoSPacketHeaderSelection;
import com.radware.automation.webui.webpages.dp.configuration.setup.scuritysettings.dnsfloodprotection.dnsEarlyBlocking.DNSEarlyBlocking;
import com.radware.automation.webui.webpages.dp.configuration.setup.scuritysettings.dnsfloodprotection.dnsFootprintBypass.DNSFootprintBypass;
import com.radware.automation.webui.webpages.dp.configuration.setup.scuritysettings.dnsfloodprotection.dnsPacketHeaderSelection.DNSPacketHeaderSelection;
import com.radware.automation.webui.webpages.dp.configuration.setup.scuritysettings.packetanomaly.PacketAnomaly;
import com.radware.automation.webui.webpages.dp.configuration.setup.scuritysettings.synfloodprotection.SYNFloodProtection;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 10/1/2014.
 */
public class RBACDefenseProSecuritySettingsTableActionHandler extends RBACHandlerBase {

    public static boolean verifyBDoSFootprintBypassTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        BDoSFootprintBypass bdosFootprintBypass = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mBDoSProtection().mBDoSFootprintBypass();
        bdosFootprintBypass.openPage();

        WebUITable table = bdosFootprintBypass.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("bdosFootprintBypassTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyBDoSEarlyBlockingTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        BDoSEarlyBlocking bdosEarlyBlocking = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mBDoSProtection().mBDoSEarlyBlocking();
        bdosEarlyBlocking.openPage();

        WebUITable table = bdosEarlyBlocking.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("bdosEarlyBlockingTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyBDoSPacketHeaderSelectionTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        BDoSPacketHeaderSelection bdosPacketHeaderSelection = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mBDoSProtection().mBDoSPacketHeaderSelection();
        bdosPacketHeaderSelection.openPage();

        WebUITable table = bdosPacketHeaderSelection.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("bdosPacketHeaderSelectionTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifySSLParametersTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        SYNFloodProtection synFloodProtection = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mSYNFloodProtection();
        synFloodProtection.openPage();

        synFloodProtection.mSSLParameters().openTab();

        WebUITable table = synFloodProtection.mSSLParameters().getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("sslParametersTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyPacketAnomalyTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        PacketAnomaly packetAnomaly = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mPacketAnomaly();
        packetAnomaly.openPage();

        WebUITable table = packetAnomaly.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("packetAnomalyTableAction"), expectedResultRBAC);
        return result;
    }

    //=============
    public static boolean verifyDNSFootprintBypassTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        DNSFootprintBypass dnsFootprintBypass = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mDNSFloodProtection().mDNSFootprintBypass();
        dnsFootprintBypass.openPage();

        WebUITable table = dnsFootprintBypass.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("dnsFootprintBypassTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyDNSEarlyBlockingTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        DNSEarlyBlocking dnsEarlyBlocking = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mDNSFloodProtection().mDNSEarlyBlocking();
        dnsEarlyBlocking.openPage();

        WebUITable table = dnsEarlyBlocking.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("dnsEarlyBlockingTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyDNSPacketHeaderSelectionTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        DNSPacketHeaderSelection dnsPacketHeaderSelection = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mDNSFloodProtection().mDNSPacketHeaderSelection();
        dnsPacketHeaderSelection.openPage();

        WebUITable table = dnsPacketHeaderSelection.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("dnsPacketHeaderSelectionTableAction"), expectedResultRBAC);
        return result;
    }

}
