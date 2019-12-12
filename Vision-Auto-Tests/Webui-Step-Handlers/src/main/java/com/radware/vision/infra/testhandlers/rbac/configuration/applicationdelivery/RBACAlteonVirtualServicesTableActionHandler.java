package com.radware.vision.infra.testhandlers.rbac.configuration.applicationdelivery;

import com.radware.automation.webui.webpages.configuration.appDelivery.virtualServices.appshape.AppShape;
import com.radware.automation.webui.webpages.configuration.appDelivery.virtualServices.contentSwitching.contentClasses.ContentClasses;
import com.radware.automation.webui.webpages.configuration.appDelivery.virtualServices.contentSwitching.l7Strings.httpMethods.HTTPMethods;
import com.radware.automation.webui.webpages.configuration.appDelivery.virtualServices.healthcheck.HealthCheck;
import com.radware.automation.webui.webpages.configuration.appDelivery.virtualServices.realServers.RealServers;
import com.radware.automation.webui.webpages.configuration.appDelivery.virtualServices.serverGroups.ServerGroups;
import com.radware.automation.webui.webpages.configuration.appDelivery.virtualServices.virtualServers.VirtualServers;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonVirtualServicesTableActionHandler extends RBACHandlerBase {

    public static boolean verifyRealServersTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        RealServers realServers = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mVirtualServices().mRealServers();
        realServers.openPage();

        WebUITable table = realServers.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("realServersTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyServerGroupsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        ServerGroups serverGroups = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mVirtualServices().mServerGroups();
        serverGroups.openPage();

        WebUITable table = serverGroups.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("serverGroupsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyVirtualServersTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        VirtualServers virtualServers = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mVirtualServices().mVirtualServers();
        virtualServers.openPage();

        WebUITable table = virtualServers.getVirtualServersTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("virtualServersTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyVirtualServicesOfSelectedVirtualServerTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        VirtualServers virtualServers = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mVirtualServices().mVirtualServers();
        virtualServers.openPage();

        WebUITable table = virtualServers.getVirtualServicesOfSelectedVirtualServerTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("virtualServicesOfSelectedVirtualServerTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyContentBasedRulesOfSelectedVirtualServiceTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        VirtualServers virtualServers = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mVirtualServices().mVirtualServers();
        virtualServers.openPage();

        WebUITable table = virtualServers.getContentBasedRulesOfSelectedVirtualServiceTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("contentBasedRulesOfSelectedVirtualServiceTableAction"), expectedResultRBAC);
        return result;
    }

    //======================
    public static boolean verifyContentClassesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        ContentClasses contentClasses = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mVirtualServices().mContentSwitching().mContentClasses();
        contentClasses.openPage();

        WebUITable table = contentClasses.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("contentClassesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyHTTPMethodsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        HTTPMethods httpMethods = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mVirtualServices().mContentSwitching().ml7Strings().mHTTPMethods();
        httpMethods.openPage();

        WebUITable table = httpMethods.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("httpMethodsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyHealthCheckTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        HealthCheck healthCheck = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mVirtualServices().mHealthCheck();
        healthCheck.openPage();

        WebUITable table = healthCheck.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("healthCheckTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyAppShapeTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        AppShape appShape = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mVirtualServices().mAppShape();
        appShape.openPage();

        WebUITable table = appShape.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("appShapeTableAction"), expectedResultRBAC);
        return result;
    }

}
