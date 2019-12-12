package com.radware.vision.infra.testhandlers.dptemplates;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.FileUtils;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.webdriver.WebUIDriver;
import com.radware.automation.webui.webpages.WebUIBasePage;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.networkprotectionrules.NetworkProtectionPolicies;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.networkprotectionrules.NetworkProtectionPolicyExport;
import com.radware.automation.webui.webpages.dp.configuration.serverprotection.serverprotectionpolicy.ServerProtectionPolicy;
import com.radware.automation.webui.webpages.dp.configuration.serverprotection.serverprotectionpolicy.ServerProtectionPolicyExport;
import com.radware.automation.webui.webpages.dp.enums.ProtectionPoliciesDeleteOptions;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.devicecontrolbar.ImportOperation;
import com.radware.vision.infra.base.pages.dptemplates.DpTemplates;
import com.radware.vision.infra.base.pages.dptemplates.DpUploadFileToServer;
import com.radware.vision.infra.base.pages.dptemplates.SelectDevicesToUpdate;
import com.radware.vision.infra.base.pages.navigation.WebUIUpperBar;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.*;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class TemplatesHandler extends BaseHandler {

    public static void createNetworkProtectionPolicy(HashMap<String, String> policyProperties) {
        NetworkProtectionPolicies networkProtectionPolicies = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mNetworkProtectionPolicies();
        initLockDevice(policyProperties);
        networkProtectionPolicies.openPage();
        networkProtectionPolicies.addNetworkProtectionPolicies();
        setNetworkProtectionPolicy(networkProtectionPolicies, policyProperties);

        WebUIVisionBasePage.submit(WebUIStringsVision.getSubmitAddNetworkPolicy());

    }

    public static void createServerProtectionPolicy(HashMap<String, String> policyProperties) {
        ServerProtectionPolicy serverProtectionPolicy = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mServerProtection().mServerProtectionPolicy();
        initLockDevice(policyProperties);
        serverProtectionPolicy.openPage();
        serverProtectionPolicy.addServerProtectionPolicy();
        setServerProtectionPolicy(serverProtectionPolicy, policyProperties);

        WebUIVisionBasePage.submit(WebUIStringsVision.getSubmitAddServerPolicy());

    }

    public static void setNetworkProtectionPolicy(NetworkProtectionPolicies networkProtectionPolicies, HashMap<String, String> policyProperties) {
        String status = "true";
        try {
            WebUIUtils.isTriggerPopupSearchEvent4FreeTest = false;
            if (policyProperties.get("enabledNetworkProtectionPolicy").equalsIgnoreCase(status)) {
                networkProtectionPolicies.enable();
            } else {
                networkProtectionPolicies.disable();
            }
            networkProtectionPolicies.setPolicyName(policyProperties.get("policyName"));
            if (policyProperties.get("srcNetworkInput") != null) {
                networkProtectionPolicies.selectSRCNetworkInput(policyProperties.get("srcNetworkInput"));
            }
            if (policyProperties.get("srcNetwork") != null) {
                networkProtectionPolicies.selectSRCNetwork(policyProperties.get("srcNetwork"));
            }
            if (policyProperties.get("dstNetworkInput") != null) {
                networkProtectionPolicies.selectDSTNetworkInput(policyProperties.get("dstNetworkInput"));
            }
            if (policyProperties.get("dstNetwork") != null) {
                networkProtectionPolicies.selectDSTNetwork(policyProperties.get("dstNetwork"));
            }
            if (policyProperties.get("portGroup") != null && !policyProperties.get("portGroup").equals("")) {
                networkProtectionPolicies.selectPortGroup(policyProperties.get("portGroup"));
            }
            if (policyProperties.get("direction") != null) {
                networkProtectionPolicies.selectDirection(policyProperties.get("direction"));
            }
            if (policyProperties.get("vlanTagGroup") != null) {
                networkProtectionPolicies.selectVLANTagGroup(policyProperties.get("vlanTagGroup"));
            }
            if (policyProperties.get("mplsRdGroup") != null) {
                networkProtectionPolicies.selectMPLSRDGroup(policyProperties.get("mplsRdGroup"));
            }
            if (policyProperties.get("bdosProfile") != null) {
                networkProtectionPolicies.selectBDoSProfile(policyProperties.get("bdosProfile"));
            }
            if (policyProperties.get("dnsProfile") != null) {
                networkProtectionPolicies.selectDNSProfile(policyProperties.get("dnsProfile"));
            }
            if (policyProperties.get("antiScanningProfile") != null) {
                networkProtectionPolicies.selectAntiScanningProfile(policyProperties.get("antiScanningProfile"));
            }
            if (policyProperties.get("signatureProtection") != null) {
                networkProtectionPolicies.selectSignatureProtectionProfile(policyProperties.get("signatureProtection"));
            }
            if (policyProperties.get("connectionLimitProfile") != null) {
                networkProtectionPolicies.selectConnectionLimitProfile(policyProperties.get("connectionLimitProfile"));
            }
            if (policyProperties.get("synFloodProfile") != null) {
                networkProtectionPolicies.selectSYNFloodProfile(policyProperties.get("synFloodProfile"));
            }
            if (policyProperties.get("connectionPpsLimitProfile") != null) {
                networkProtectionPolicies.selectConnectionPPSLimitProfile(policyProperties.get("connectionPpsLimitProfile"));
            }
            if (policyProperties.get("outOfStateProfile") != null) {
                networkProtectionPolicies.selectOutofStateProfile(policyProperties.get("outOfStateProfile"));
            }
            if (policyProperties.get("webQuarantine") != null) {
                networkProtectionPolicies.selectWebQuarantine(policyProperties.get("webQuarantine"));
            }
            if (policyProperties.get("action") != null) {
                networkProtectionPolicies.selectAction(policyProperties.get("action"));
            }

            if (policyProperties.get("packetReporting").equalsIgnoreCase(status)) {
                networkProtectionPolicies.enablePacketReporting();
            } else {
                networkProtectionPolicies.disablePacketReporting();
            }
            if (policyProperties.get("packetReportingConfigurationOnPolicyTakesPrecedence").equalsIgnoreCase(status)) {
                networkProtectionPolicies.enablePacketReportingConfigurationonPolicyTakesPrecedence();
            } else {
                networkProtectionPolicies.disablePacketReportingConfigurationonPolicyTakesPrecedence();
            }
            if (policyProperties.get("packetTrace").equalsIgnoreCase(status)) {
                networkProtectionPolicies.enablePacketTrace();
            } else {
                networkProtectionPolicies.disablePacketTrace();
            }
            if (policyProperties.get("packetTraceConfigurationOnPolicyTakesPrecedence").equalsIgnoreCase(status)) {
                networkProtectionPolicies.enablePacketTraceConfigurationonPolicyTakesPrecedence();
            } else {
                networkProtectionPolicies.disablePacketTraceConfigurationonPolicyTakesPrecedence();
            }
        } finally {
            WebUIUtils.isTriggerPopupSearchEvent4FreeTest = true;
        }

    }

    public static void setServerProtectionPolicy(ServerProtectionPolicy serverProtectionPolicies, HashMap<String, String> policyProperties) {
        String status = "true";
        try {
            WebUIUtils.isTriggerPopupSearchEvent4FreeTest = false;
            if (policyProperties.get("enabledServerProtectionPolicy").equalsIgnoreCase(status)) {
                serverProtectionPolicies.enable();
            } else {
                serverProtectionPolicies.disable();
            }
            serverProtectionPolicies.setServerName(policyProperties.get("policyName"));
            if (policyProperties.get("ipRangeInput") != null) {
                serverProtectionPolicies.selectIPRangeInput(policyProperties.get("ipRangeInput"));
            }
            if (policyProperties.get("ipRange") != null) {
                serverProtectionPolicies.selectIPRange(policyProperties.get("ipRange"));
            }
            if (policyProperties.get("httpFloodProfile") != null) {
                serverProtectionPolicies.selectHTTPFloodProfile(policyProperties.get("httpFloodProfile"));
            }
            if (policyProperties.get("serverCrackingProfile") != null) {
                serverProtectionPolicies.selectServerCrackingProfile(policyProperties.get("serverCrackingProfile"));
            }
            if (policyProperties.get("vlanTagGroup") != null) {
                serverProtectionPolicies.selectVLANTagGroup(policyProperties.get("vlanTagGroup"));
            }
            if (policyProperties.get("policy") != null) {
                serverProtectionPolicies.selectPolicy(policyProperties.get("policy"));
            }

            if (policyProperties.get("packetReporting").equalsIgnoreCase(status)) {
                serverProtectionPolicies.enablePacketReporting();
            } else {
                serverProtectionPolicies.disablePacketReporting();
            }
            if (policyProperties.get("packetReportingConfigurationOnPolicyTakesPrecedence").equalsIgnoreCase(status)) {
                serverProtectionPolicies.enablePacketReportingPrecedence();
            } else {
                serverProtectionPolicies.disablePacketReportingPrecedence();
            }
            if (policyProperties.get("packetTrace").equalsIgnoreCase(status)) {
                serverProtectionPolicies.enablePacketTrace();
            } else {
                serverProtectionPolicies.disablePacketTrace();
            }
            if (policyProperties.get("packetTraceConfigurationOnPolicyTakesPrecedence").equalsIgnoreCase(status)) {
                serverProtectionPolicies.enablePacketTracePrecedence();
            } else {
                serverProtectionPolicies.disablePacketTracePrecedence();
            }
        } finally {
            WebUIUtils.isTriggerPopupSearchEvent4FreeTest = true;
        }
    }

    public static void uploadFileToServer(String fileName, DpTemplateFileType fileType) {
        try {
            WebUIUpperBar.select(UpperBarItems.ToolBox);
            WebUIUpperBar.select(UpperBarItems.ToolBox_Advanced);
            DpTemplates.uploadFileToServerButtonClick();
            DpUploadFileToServer dpUploadFileToServer = new DpUploadFileToServer();
            dpUploadFileToServer.setFileType(fileType);
            ImportOperation browse = new ImportOperation();
            fileName = FileUtils.getAbsoluteClassesPath() + FileUtils.getFileSeparator() + "Templates" + FileUtils.getFileSeparator() + fileType.getResourceFolderName() + FileUtils.getFileSeparator() + fileName;
            browse.importFromClient(fileName, true);
            BasicOperationsHandler.delay(5);
            WebUIBasePage.closeYellowMessage();
            WebUIVisionBasePage.cancel(false);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            BasicOperationsHandler.toolbox(false);
        }
    }

    public static void deleteTemplate(String columnName, String columnValuesList) {
        try {
            WebUIUpperBar.select(UpperBarItems.ToolBox_Advanced);
            DpTemplates dpTemplates = new DpTemplates();
            dpTemplates.selectMultipleTemplate(columnName, columnValuesList);
            dpTemplates.clickDeleteButton();
            WebUIDriver.getListenerManager().getWebUIDriverEventListener().afterClickOn(null, WebUIUtils.getDriver());

            WebUIVisionBasePage.cancel(false);
        } finally {
            WebUIUpperBar.select(UpperBarItems.ToolBox_Advanced);
        }
    }

    public static void deleteAllTemplates() {
        try {
            BasicOperationsHandler.templates();
            DpTemplates dpTemplates = new DpTemplates();
            dpTemplates.deleteAllTemplates();
        } finally {
            BasicOperationsHandler.toolbox(false);
        }
    }

    public static void sendToDevices(HashMap<String, String> templateProperties) {
        try {
            BasicOperationsHandler.templates();
            DpTemplates dpTemplates = new DpTemplates();

            dpTemplates.selectMultipleTemplate(templateProperties.get("columnName"), templateProperties.get("fileNamesList"));

            DpTemplates.sendToDevicesButtonClick();
            setSelectDevicesToUpdateWindow(templateProperties);
            WebUIVisionBasePage.submit(WebUIStringsVision.getSubmitDpTemplatesSendToFile());
            WebUIUtils.fluentWaitJSExecutor("arguments[0].click();", WebUIUtils.SHORT_WAIT_TIME, false, new ComponentLocator(How.ID, "gwt-debug-ConfigTab_EDIT_DPConfigTemplates.SendFileToDevice_Close"));
            // timeout to let update policies get finished
            BasicOperationsHandler.delay(5);
        } finally {
            BasicOperationsHandler.toolbox(false);
        }
    }

    public static void downloadSelectedFile(String columnName, String columnValue) {
        try {
            BasicOperationsHandler.templates();
            DpTemplates dpTemplates = new DpTemplates();
            WebUITable table = dpTemplates.getTemplatesTable();
            table.clickRowByKeyValue(columnName, columnValue);
            DpTemplates.downloadSelectedFileButtonClick();
        } finally {
            BasicOperationsHandler.toolbox(false);
        }
    }

    public static boolean validateSearchTemplateModule(DpConfigurationTemplatesColumns columnName, String columnValuesList) {

        DpTemplates template = new DpTemplates();
        WebUITable table = template.getTemplatesTable();
        return validateSearchTemplate(columnName, columnValuesList, table);
    }

    public static boolean validateTemplateModule(String columnName, String columnValuesList) {
        try {
            BasicOperationsHandler.templates();
            DpTemplates template = new DpTemplates();
            WebUITable table = template.getTemplatesTable();
            return validateTemplate(columnName, columnValuesList, table);
        } finally {
            BasicOperationsHandler.toolbox(false);
        }
    }

    public static boolean searchConfigurationsTemplatesTable(String valueToSearch, DpConfigurationTemplatesColumns columnName) {
        WebUIUpperBar.select(UpperBarItems.ToolBox_Advanced);
        DpTemplates.setSearchDropdown(columnName, valueToSearch); //getDpConfigurationSearchByColumn
        return validateSearchTemplateModule(columnName, valueToSearch);
    }

    public static boolean validatePolicyDownload(String fileName, String downloadPath, boolean partial) {
        return FileUtils.validateFileDownload(fileName, downloadPath, partial);
    }

    public static boolean validateNetworkProtectionTemplate(HashMap<String, String> templateProperties) {
        TopologyTreeHandler.clickTreeNode(templateProperties.get("deviceName"));
        TopologyTreeHandler.openDeviceInfoPane();
        NetworkProtectionPolicies networkProtectionPolicies = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mNetworkProtectionPolicies();
        networkProtectionPolicies.openPage();
        WebUITable table = networkProtectionPolicies.getTable();
        return validateTemplate(templateProperties.get("columnName"), templateProperties.get("fileNamesList"), table);
    }

    public static boolean validateServerProtectionTemplate(HashMap<String, String> templateProperties) {
        TopologyTreeHandler.clickTreeNode(templateProperties.get("deviceName"));
        TopologyTreeHandler.openDeviceInfoPane();
        ServerProtectionPolicy serverProtectionPolicy = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mServerProtection().mServerProtectionPolicy();
        serverProtectionPolicy.openPage();
        WebUITable table = serverProtectionPolicy.getTable();
        return validateTemplate(templateProperties.get("columnName"), templateProperties.get("fileNamesList"), table);
    }

    public static boolean validateTemplate(String columnName, String columnValuesList, WebUITable table) {

        int found = 0;

        List<String> list = new ArrayList<String>();
        table.analyzeTable("div");
        table.setWaitForTableToLoad(true);
        if (columnValuesList != null) {
            list = Arrays.asList(columnValuesList.split(","));
        }
        for (int i = 0; i < list.size(); i++) {
            int rowIndex = table.getRowIndex(columnName, list.get(i));
            if (rowIndex != (-1)) {
                found++;
            }
        }
        WebUIVisionBasePage.cancel(false);
        if (found == list.size()) {
            return true;
        } else return false;
    }

    public static boolean validateSearchTemplate(DpConfigurationTemplatesColumns columnName, String columnValue, WebUITable table) {

        int columnIndex = columnName.ordinal();
//        if (columnName.equalsIgnoreCase(DpConfigurationTemplatesColumns.SOURCE_DEVICE_NAME.getColumnNameSearch())) {
//            columnIndex = 0;
//        } else if (columnName.equalsIgnoreCase(DpConfigurationTemplatesColumns.FILE_NAME.getColumnNameSearch())) {
//            columnIndex = 1;
//        } else if (columnName.equalsIgnoreCase(DpConfigurationTemplatesColumns.FILE_TYPE.getColumnNameSearch())) {
//            columnIndex = 2;
//        }

        List<String> list = new ArrayList<String>();
        table.analyzeTable("div");

        for (int i = 0; i < table.getRowCount(); i++) {
            if (columnIndex != 1 && table.getCellValue(i, columnIndex).equalsIgnoreCase(columnValue)) {//RowIndex(columnName, list.get(i));
                WebUIVisionBasePage.cancel(false);
                return true;
            } else if (columnIndex == 1 && table.getCellValue(i, columnIndex).contains(columnValue)) {
                WebUIVisionBasePage.cancel(false);
                return true;
            }
        }
        WebUIVisionBasePage.cancel(false);// test branch
        return false;
    }


    public static void setSelectDevicesToUpdateWindow(HashMap<String, String> templateProperties) {
        List<String> deviceDestinationsList = new ArrayList<String>();
        SelectDevicesToUpdate selectDevicesToUpdate = new SelectDevicesToUpdate();
        if ((templateProperties.get("deviceDestinations")) != null) {
            deviceDestinationsList = Arrays.asList(templateProperties.get("deviceDestinations").split(","));
            selectDevicesToUpdate.addSelectedDevices(DualListTypeEnum.TEMPLATE_DEVICES, deviceDestinationsList);
        }
        if ((templateProperties.get("groupDestinations")) != null) {
            deviceDestinationsList = Arrays.asList(templateProperties.get("groupDestinations").split(","));
            selectDevicesToUpdate.addSelectedDevices(DualListTypeEnum.TEMPLATE_GROUPS, deviceDestinationsList);
        }
        selectDevicesToUpdate.setUpdateMethod(UpdateMethod.valueOf(templateProperties.get("method")));
        selectDevicesToUpdate.setInstallOnInstance(Instance.valueOf(templateProperties.get("instance")));
        selectDevicesToUpdate.setUpdatePoliciesAfterSendingConfiguration(Boolean.valueOf(templateProperties.get("updatePolicies")));
    }

    public static void exportNetworkPolicies(HashMap<String, String> templateProperties) {
        ArrayList<String> exportPolicy = new ArrayList();
        NetworkProtectionPolicies networkProtectionPolicies = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mNetworkProtectionPolicies();
        initLockDevice(templateProperties);
        networkProtectionPolicies.openPage();
//        BasicOperationsHandler.delay(2);
        networkProtectionPolicies.exportPolicy(templateProperties.get("exportPolicyName"));
        NetworkProtectionPolicyExport networkProtectionPolicyExport = new NetworkProtectionPolicyExport();
        if (templateProperties.get("exportDownloadTo").equalsIgnoreCase("client"))
            networkProtectionPolicyExport.downloadToClient();
        else
            networkProtectionPolicyExport.downloadToServer();
        if (templateProperties.get("exportPolicyConfigurations") != null) {
            exportPolicy = new ArrayList(Arrays.asList(templateProperties.get("exportPolicyConfigurations").trim().split(",")));
            networkProtectionPolicyExport.setExportConfigurations(exportPolicy);
        }
        networkProtectionPolicyExport.saveAsFile(templateProperties.get("saveToFileName"));

        WebUIVisionBasePage.submit(WebUIStrings.getNetworkProtectionPolicyExportSubmit());
        BasicOperationsHandler.delay(10);
        // The browser's profile is setup
//        if (templateProperties.get("exportDownloadTo").equalsIgnoreCase("client")) {
//
//            BasicOperationsHandler.delay(7);
//            WebUIUtils.pressEnter();
//        }
    }

    public static void exportServerPolicies(HashMap<String, String> templateProperties) {
        ArrayList<String> exportPolicy = new ArrayList();
        ServerProtectionPolicy serverProtectionPolicy = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mServerProtection().mServerProtectionPolicy();
        initLockDevice(templateProperties);
        serverProtectionPolicy.openPage();
//        BasicOperationsHandler.delay(2);
        serverProtectionPolicy.exportPolicy(templateProperties.get("exportPolicyName"));
        ServerProtectionPolicyExport serverProtectionPolicyExport = new ServerProtectionPolicyExport();
        if (templateProperties.get("exportDownloadTo").equalsIgnoreCase("client"))
            serverProtectionPolicyExport.downloadToClient();
        else
            serverProtectionPolicyExport.downloadToServer();
        if (templateProperties.get("exportPolicyConfigurations") != null) {
            exportPolicy = new ArrayList(Arrays.asList(templateProperties.get("exportPolicyConfigurations").trim().split(",")));
            serverProtectionPolicyExport.setExportConfigurations(exportPolicy);
        }
        if (templateProperties.get("exportDownloadTo").equalsIgnoreCase(ExportPolicyDownloadTo.Server.getDownloadTo())) {
            serverProtectionPolicyExport.saveAsFile(templateProperties.get("saveToFileName"));
        }

        WebUIVisionBasePage.submit(WebUIStrings.getServerProtectionPolicyExportSubmit());
        BasicOperationsHandler.delay(10);

//        if (templateProperties.get("exportDownloadTo").equalsIgnoreCase("client")) {
//            BasicOperationsHandler.delay(7);
//            WebUIUtils.pressEnter();
//        }
    }

    public static void deleteAllNetworkProtectionPolicies(HashMap<String, String> templateProperties) {
        NetworkProtectionPolicies networkProtectionPolicies = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mNetworkProtectionPolicies();
        initLockDevice(templateProperties);
        networkProtectionPolicies.openPage();
        networkProtectionPolicies.deleteAllNetworkProtectionPolicies(ProtectionPoliciesDeleteOptions.POLICIES_ONLY);
    }

    public static void deleteNetworkProtectionPolicies(HashMap<String, String> templateProperties) {
        ArrayList<String> exportPolicy = new ArrayList();
        int policiesNum = 0;
        NetworkProtectionPolicies networkProtectionPolicies = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mNetworkProtectionPolicies();
        initLockDevice(templateProperties);
        networkProtectionPolicies.openPage();
        if (templateProperties.get("policiesList") != null) {
            exportPolicy = new ArrayList(Arrays.asList(templateProperties.get("policiesList").trim().split(",")));
            policiesNum = exportPolicy.size();

            for (int i = policiesNum - 1; i >= 0; i--) {
                try {
                    networkProtectionPolicies.deleteNetworkProtectionPoliciesByKeyValue(templateProperties.get("columnName"), exportPolicy.get(i));
                } catch (Exception e) {
                    continue;
                }
            }
        } else {
            for (int i = networkProtectionPolicies.getTable().getRowCount() - 1; i >= 0; i--) {
                try {
                    networkProtectionPolicies.deleteNetworkProtectionPoliciesByRowNumber(i);
                } catch (Exception e) {
                    continue;
                }
            }
        }
    }

    public static void deleteServerProtectionPolicies(HashMap<String, String> templateProperties) {
        ArrayList<String> exportPolicy = new ArrayList();
        int policiesNum = 0;
        ServerProtectionPolicy serverProtectionPolicies = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mServerProtection().mServerProtectionPolicy();
        initLockDevice(templateProperties);
        serverProtectionPolicies.openPage();

        if (templateProperties.get("policiesList") != null) {
            exportPolicy = new ArrayList(Arrays.asList(templateProperties.get("policiesList").trim().split(",")));
            policiesNum = exportPolicy.size();
            for (int i = policiesNum - 1; i >= 0; i--) {
                try {
                    serverProtectionPolicies.deleteServerProtectionPolicy(templateProperties.get("columnName"), exportPolicy.get(i));
                } catch (Exception e) {
                    continue;
                }
            }
        } else {
            for (int i = serverProtectionPolicies.getTable().getRowCount() - 1; i >= 0; i--) {
                try {
                    serverProtectionPolicies.deleteServerProtectionPolicy(i);
                } catch (Exception e) {
                    continue;
                }
            }
        }
    }

    public static void deleteAllServerProtectionPolicies(HashMap<String, String> templateProperties) {
        ServerProtectionPolicy serverProtectionPolicies = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mServerProtection().mServerProtectionPolicy();
        initLockDevice(templateProperties);
        serverProtectionPolicies.openPage();
        serverProtectionPolicies.deleteAllServerProtectionPolicy(ProtectionPoliciesDeleteOptions.POLICIES_ONLY);
    }
}