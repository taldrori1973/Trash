package com.radware.vision.infra.testhandlers.rbac.configuration.applicationdelivery;

import com.radware.automation.webui.webpages.configuration.appDelivery.globalTrafficRedirection.remoteSites.RemoteSites;
import com.radware.automation.webui.webpages.configuration.appDelivery.globalTrafficRedirection.remoteSites.dnssec.DNSSEC;
import com.radware.automation.webui.webpages.configuration.appDelivery.globalTrafficRedirection.remoteSites.dnssec.keyRepository.KeyRepository;
import com.radware.automation.webui.webpages.configuration.appDelivery.globalTrafficRedirection.remoteSites.dnssec.zoneToKeyAssociation.ZoneToKeyAssociation;
import com.radware.automation.webui.webpages.configuration.appDelivery.globalTrafficRedirection.remoteSites.siteSelectionRules.SiteSelectionRules;
import com.radware.automation.webui.webpages.configuration.appDelivery.globalTrafficRedirection.remoteSites.siteSelectionRules.networks.Networks;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonGlobalTrafficRedirectionTableActionHandler extends RBACHandlerBase {

    public static boolean verifyRemoteSitesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        RemoteSites remoteSites = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mGlobalTrafficRedirection().mRemoteSites();
        remoteSites.openPage();

        WebUITable table = remoteSites.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("remoteSitesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifySiteSelectionRulesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        SiteSelectionRules siteSelectionRules = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mGlobalTrafficRedirection().mSiteSelectionRules();
        siteSelectionRules.openPage();

        WebUITable table = siteSelectionRules.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("siteSelectionRulesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyNetworksTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        Networks networks = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mGlobalTrafficRedirection().mSiteSelectionRules().mNetworks();
        networks.openPage();

        WebUITable table = networks.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("networksTableAction"), expectedResultRBAC);
        return result;
    }

    //===
    public static boolean verifyDNSSECTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        DNSSEC dnsSEC = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mGlobalTrafficRedirection().mDNSSEC();
        dnsSEC.openPage();

        WebUITable table = dnsSEC.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("dnsSECTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyKeyRepositoryTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        KeyRepository keyRepository = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mGlobalTrafficRedirection().mDNSSEC().mKeyRepository();
        keyRepository.openPage();

        WebUITable table = keyRepository.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("keyRepositoryTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyZoneToKeyAssociationTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        ZoneToKeyAssociation zoneToKeyAssociation = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mGlobalTrafficRedirection().mDNSSEC().mZoneToKeyAssociation();
        zoneToKeyAssociation.openPage();

        WebUITable table = zoneToKeyAssociation.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("zoneToKeyAssociationTableAction"), expectedResultRBAC);
        return result;
    }

}
