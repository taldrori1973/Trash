package com.radware.vision.tests.dptemplates;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.enums.*;
import com.radware.vision.infra.testhandlers.dptemplates.TemplatesHandler;
import com.radware.vision.infra.testhandlers.dptemplates.enums.*;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;
import testhandlers.Device;

import java.awt.*;
import java.util.HashMap;

public class TemplatesTests extends RBACTestBase {
    String fileName;
    String fileNamesList;
    DpTemplateFileType fileType = DpTemplateFileType.SERVER_PROTECTION;
    String columnName;
    String deviceDestinations;
    String groupDestinations;
    UpdateMethod method = UpdateMethod.OverwriteExisistingConfiguration;
    Instance instance = Instance.ZERO;
    boolean updatePolicies = true;
    String exportPolicyName;
    ExportPolicyDownloadTo exportDownloadTo = ExportPolicyDownloadTo.Server;
    String exportPolicyConfigurations;
    String saveToFileName;
    TopologyTreeTabs parentTree = TopologyTreeTabs.SitesAndClusters;
    DeviceState deviceState = DeviceState.Lock;
    String valueToSearch;
    DpConfigurationTemplatesColumns searchColumnName = DpConfigurationTemplatesColumns.SOURCE_DEVICE_NAME;
    String deviceIp;
    String policyName;
    String policiesList;
    String policy;
    String policyDownloadDestinationPath;
    boolean partial = false;

    //========== network policy ==============
    boolean enabledNetworkProtectionPolicy = true;
    PolicyNetworkInput srcNetworkInput = PolicyNetworkInput.FROM_LIST;
    String srcNetwork;
    PolicyNetworkInput dstNetworkInput = PolicyNetworkInput.FROM_LIST;
    String dstNetwork;
    PolicyPortGroup portGroup = PolicyPortGroup.NO_SELECTION;
    PolicyDirection direction = PolicyDirection.ONE_WAY;
    String vlanTagGroup;
    String mplsRdGroup;

    String bdosProfile;
    String antiScanningProfile;
    String dnsProfile;
    String signatureProtection;
    String connectionLimitProfile;
    String synFloodProfile;
    String connectionPpsLimitProfile;
    String outOfStateProfile;
    PolicyWebQuarantine webQuarantine = PolicyWebQuarantine.DISABLE;
    PolicyAction action = PolicyAction.BLOCK_AND_REPORT;

    boolean packetReporting = false;
    boolean packetReportingConfigurationOnPolicyTakesPrecedence = false;
    boolean packetTrace = false;
    boolean packetTraceConfigurationOnPolicyTakesPrecedence = false;
    //========= Server policy ================
    PolicyNetworkInput ipRangeInput = PolicyNetworkInput.FROM_LIST;
    String ipRange;
    String httpFloodProfile;
    String serverCrackingProfile;
    boolean enabledServerProtectionPolicy = true;


    @Test
    @TestProperties(name = "Create NetworkProtection Policy", paramsInclude = {"qcTestId", "policyName", "deviceName", "parentTree", "deviceState",
            "enabledNetworkProtectionPolicy", "srcNetworkInput", "srcNetwork", "dstNetworkInput", "dstNetwork", "portGroup", "direction", "vlanTagGroup",
            "mplsRdGroup", "bdosProfile", "antiScanningProfile", "dnsProfile", "signatureProtection", "connectionLimitProfile", "synFloodProfile",
            "connectionPpsLimitProfile", "outOfStateProfile", "webQuarantine", "action", "packetReporting", "packetTrace",
            "packetReportingConfigurationOnPolicyTakesPrecedence", "packetTraceConfigurationOnPolicyTakesPrecedence"})

    public void CreateNetworkProtectionPolicy() throws AWTException {
        try {
            HashMap<String, String> policyProperties = new HashMap<String, String>();

            policyProperties.put("policyName", policyName);
            policyProperties.put("deviceName", getDeviceName());
            policyProperties.put("parentTree", parentTree.getTopologyTreeTab());
            policyProperties.put("deviceState", deviceState.getDeviceState());
            policyProperties.put("enabledNetworkProtectionPolicy", String.valueOf(enabledNetworkProtectionPolicy));
            policyProperties.put("srcNetworkInput", srcNetworkInput.getPolicyNetworkInput());
            policyProperties.put("srcNetwork", srcNetwork);
            policyProperties.put("dstNetworkInput", dstNetworkInput.getPolicyNetworkInput());
            policyProperties.put("dstNetwork", dstNetwork);
            policyProperties.put("portGroup", portGroup.getPolicyPortGroup());
            policyProperties.put("direction", direction.getPolicyDirection());
            policyProperties.put("vlanTagGroup", vlanTagGroup);
            policyProperties.put("mplsRdGroup", mplsRdGroup);
            policyProperties.put("bdosProfile", bdosProfile);
            policyProperties.put("antiScanningProfile", antiScanningProfile);
            policyProperties.put("dnsProfile", dnsProfile);
            policyProperties.put("signatureProtection", signatureProtection);
            policyProperties.put("connectionLimitProfile", connectionLimitProfile);
            policyProperties.put("synFloodProfile", synFloodProfile);
            policyProperties.put("connectionPpsLimitProfile", connectionPpsLimitProfile);
            policyProperties.put("outOfStateProfile", outOfStateProfile);
            policyProperties.put("webQuarantine", webQuarantine.getPolicyWebQuarantineState());
            policyProperties.put("action", action.getPolicyAction());
            policyProperties.put("packetReporting", String.valueOf(packetReporting));
            policyProperties.put("packetReportingConfigurationOnPolicyTakesPrecedence", String.valueOf(packetReportingConfigurationOnPolicyTakesPrecedence));
            policyProperties.put("packetTrace", String.valueOf(packetTrace));
            policyProperties.put("packetTraceConfigurationOnPolicyTakesPrecedence", String.valueOf(packetTraceConfigurationOnPolicyTakesPrecedence));


            TemplatesHandler.createNetworkProtectionPolicy(policyProperties);

        } catch (Exception e) {
            BaseTestUtils.report("Create NetworkProtection Policy may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Create ServerProtection Policy", paramsInclude = {"qcTestId", "policyName", "deviceName", "parentTree", "deviceState",
            "enabledServerProtectionPolicy", "ipRangeInput", "ipRange", "httpFloodProfile", "serverCrackingProfile", "vlanTagGroup",
            "packetReporting", "packetTrace",
            "packetReportingConfigurationOnPolicyTakesPrecedence", "packetTraceConfigurationOnPolicyTakesPrecedence", "policy"})

    public void CreateServerProtectionPolicy() throws AWTException {
        try {
            HashMap<String, String> policyProperties = new HashMap<String, String>();

            policyProperties.put("policyName", policyName);
            policyProperties.put("deviceName", getDeviceName());
            policyProperties.put("parentTree", parentTree.getTopologyTreeTab());
            policyProperties.put("deviceState", deviceState.getDeviceState());
            policyProperties.put("enabledServerProtectionPolicy", String.valueOf(enabledServerProtectionPolicy));
            policyProperties.put("ipRangeInput", ipRangeInput.getPolicyNetworkInput());
            policyProperties.put("ipRange", ipRange);
            policyProperties.put("httpFloodProfile", httpFloodProfile);
            policyProperties.put("serverCrackingProfile", serverCrackingProfile);
            policyProperties.put("vlanTagGroup", vlanTagGroup);
            policyProperties.put("packetReporting", String.valueOf(packetReporting));
            policyProperties.put("packetReportingConfigurationOnPolicyTakesPrecedence", String.valueOf(packetReportingConfigurationOnPolicyTakesPrecedence));
            policyProperties.put("packetTrace", String.valueOf(packetTrace));
            policyProperties.put("packetTraceConfigurationOnPolicyTakesPrecedence", String.valueOf(packetTraceConfigurationOnPolicyTakesPrecedence));
            policyProperties.put("policy", policy);


            TemplatesHandler.createServerProtectionPolicy(policyProperties);

        } catch (Exception e) {
            BaseTestUtils.report("Create ServerProtection Policy may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    @Test
    @TestProperties(name = "uploadFileToServer", paramsInclude = {"qcTestId", "fileName", "fileType"})
    public void UploadFileToServer() throws AWTException {
        try {
            TemplatesHandler.uploadFileToServer(fileName, fileType);
        } catch (Exception e) {
            BaseTestUtils.report("Templates related operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "delete File", paramsInclude = {"qcTestId", "fileNamesList"})
    public void deleteFile() throws AWTException {
        try {
            columnName = "File Name";
            TemplatesHandler.deleteTemplate(columnName, fileNamesList);
        } catch (Exception e) {
            BaseTestUtils.report("Templates related operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "delete all Policy Template Files", paramsInclude = {"qcTestId"})
    public void deleteAllFiles() throws AWTException {
        try {
            TemplatesHandler.deleteAllTemplates();
        } catch (Exception e) {
            BaseTestUtils.report("Templates related operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "delete NetworkProtectionPolicy", paramsInclude = {"qcTestId", "policiesList", "deviceName", "deviceState", "parentTree"})
    public void deleteNetworkProtectionPolicy() throws AWTException {
        try {
            columnName = "Policy Name";
            HashMap<String, String> templateProperties = new HashMap<String, String>();
            templateProperties.put("policiesList", policiesList);
            templateProperties.put("columnName", columnName);
            templateProperties.put("parentTree", parentTree.getTopologyTreeTab());
            templateProperties.put("deviceName", getDeviceName());
            templateProperties.put("deviceState", deviceState.getDeviceState());
            TemplatesHandler.deleteNetworkProtectionPolicies(templateProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Delete NetworkProtectionPolicy operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "delete ServerProtectionPolicy", paramsInclude = {"qcTestId", "policiesList", "deviceName", "deviceState", "parentTree"})
    public void deleteServerProtectionPolicy() throws AWTException {
        try {
            columnName = "Server Name";
            HashMap<String, String> templateProperties = new HashMap<String, String>();
            templateProperties.put("policiesList", policiesList);
            templateProperties.put("columnName", columnName);
            templateProperties.put("deviceName", getDeviceName());
            templateProperties.put("parentTree", parentTree.getTopologyTreeTab());
            templateProperties.put("deviceState", deviceState.getDeviceState());
            TemplatesHandler.deleteServerProtectionPolicies(templateProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Delete ServerProtectionPolicy operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "validate Template Existence", paramsInclude = {"qcTestId", "fileNamesList", "expectedResult"})
    public void validateTemplateExistence() throws AWTException {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            columnName = "File Name";
            if (!TemplatesHandler.validateTemplateModule(columnName, fileNamesList)) {
                BaseTestUtils.report("The result was NOT as expected: ", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("The validate Template Existence has failed :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "validate NetworkProtection Template Existence", paramsInclude = {"qcTestId", "fileNamesList", "expectedResult", "deviceName", "deviceState", "parentTree"})
    public void validateNetworkProtectionTemplateExistence() throws AWTException {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            columnName = "Policy Name";
            HashMap<String, String> templateProperties = new HashMap<String, String>();
            templateProperties.put("fileNamesList", fileNamesList);
            templateProperties.put("columnName", columnName);
            templateProperties.put("deviceName", getDeviceName());
            templateProperties.put("deviceState", deviceState.getDeviceState());
            templateProperties.put("deviceName", getDeviceName());
            templateProperties.put("parentTree", parentTree.getTopologyTreeTab());
            if (!TemplatesHandler.validateNetworkProtectionTemplate(templateProperties)) {
                BaseTestUtils.report("The result was NOT as expected: ", Reporter.FAIL);

            }
        } catch (Exception e) {
            BaseTestUtils.report("The validateNetwork  Template Existence has failed :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "validate ServerProtection Template Existence", paramsInclude = {"qcTestId", "fileNamesList", "expectedResult", "deviceName", "deviceState", "parentTree"})
    public void validateServerProtectionTemplateExistence() throws AWTException {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            columnName = "Server Name";
            HashMap<String, String> templateProperties = new HashMap<String, String>();
            templateProperties.put("fileNamesList", fileNamesList);
            templateProperties.put("columnName", columnName);
            templateProperties.put("deviceName", getDeviceName());
            templateProperties.put("deviceState", deviceState.getDeviceState());
            templateProperties.put("parentTree", parentTree.getTopologyTreeTab());
            if (!TemplatesHandler.validateServerProtectionTemplate(templateProperties)) {
                BaseTestUtils.report("The result was NOT as expected: ", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("The validate Server Template Existence has failed :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "sendToDevices", paramsInclude = {"qcTestId", "fileNamesList", "deviceDestinations", "groupDestinations", "method", "instance",
            "updatePolicies"})
    public void sendToDevices() throws AWTException {
        try {
            columnName = "File Name";
            HashMap<String, String> templateProperties = new HashMap<String, String>();
            templateProperties.put("columnName", columnName);
            templateProperties.put("fileNamesList", fileNamesList);
            templateProperties.put("deviceDestinations", deviceDestinations);
            templateProperties.put("groupDestinations", groupDestinations);
            templateProperties.put("method", String.valueOf(method));
            templateProperties.put("instance", String.valueOf(instance));
            templateProperties.put("updatePolicies", String.valueOf(updatePolicies));

            TemplatesHandler.sendToDevices(templateProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Templates related operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "download Selected File", paramsInclude = {"qcTestId", "fileName"})
    public void downloadSelectedFile() throws AWTException {
        try {
            columnName = "File Name";
            TemplatesHandler.downloadSelectedFile(columnName, fileName);
        } catch (Exception e) {
            BaseTestUtils.report("Templates related operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Export NetworkPolicy Template", paramsInclude = {"qcTestId", "deviceName", "parentTree", "deviceState", "exportPolicyName", "exportDownloadTo", "exportPolicyConfigurations", "saveToFileName"})
    public void exportNetworkPolicyTemplate() {
        try {
            HashMap<String, String> templateProperties = new HashMap<String, String>();
            templateProperties.put("deviceName", getDeviceName());
            templateProperties.put("parentTree", parentTree.getTopologyTreeTab());
            templateProperties.put("deviceState", deviceState.getDeviceState());
            templateProperties.put("exportPolicyName", exportPolicyName);
            templateProperties.put("exportDownloadTo", exportDownloadTo.getDownloadTo());
            templateProperties.put("exportPolicyConfigurations", exportPolicyConfigurations);
            templateProperties.put("saveToFileName", saveToFileName);

            TemplatesHandler.exportNetworkPolicies(templateProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Export NetworkPolicy have failed: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Export ServerPolicy Template", paramsInclude = {"qcTestId", "deviceName", "parentTree", "deviceState", "exportPolicyName", "exportDownloadTo", "exportPolicyConfigurations", "saveToFileName"})
    public void exportServerPolicyTemplate() {
        try {
            HashMap<String, String> templateProperties = new HashMap<String, String>();
            templateProperties.put("deviceName", getDeviceName());
            templateProperties.put("parentTree", parentTree.getTopologyTreeTab());
            templateProperties.put("deviceState", deviceState.getDeviceState());
            templateProperties.put("exportPolicyName", exportPolicyName);
            templateProperties.put("exportDownloadTo", exportDownloadTo.getDownloadTo());
            templateProperties.put("exportPolicyConfigurations", exportPolicyConfigurations);
            templateProperties.put("saveToFileName", saveToFileName);

            TemplatesHandler.exportServerPolicies(templateProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Export ServerPolicy have failed: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "search policy By", paramsInclude = {"qcTestId", "searchColumnName", "valueToSearch"})
    public void searchPolicyBy() throws AWTException {
        try {
            RBACHandlerBase.expectedResultRBAC = true;
            if (!TemplatesHandler.searchConfigurationsTemplatesTable(valueToSearch, searchColumnName)) {
                BaseTestUtils.report("the search operation: " + " was NOT successful", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Templates related operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "validate PolicyFile Download", paramsInclude = {"qcTestId", "fileName", "policyDownloadDestinationPath", "partial", "expectedResult"})
    public void validatePolicyFileDownload() throws AWTException {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if (!TemplatesHandler.validatePolicyDownload(fileName, policyDownloadDestinationPath, partial)) {
                BaseTestUtils.report("the specified file : " + fileName + " was NOT found", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Templates related operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Before
    public void setupDPDevice() throws Exception {
        if (getDeviceName() != null) {
            updateNavigationParser(Device.getDeviceIp(getVisionRestClient(), getDeviceName()));
        }
    }

    //============


    public boolean getPacketReporting() {
        return packetReporting;
    }

    public void setPacketReporting(boolean packetReporting) {
        this.packetReporting = packetReporting;
    }

    public boolean getPacketReportingConfigurationOnPolicyTakesPrecedence() {
        return packetReportingConfigurationOnPolicyTakesPrecedence;
    }

    public void setPacketReportingConfigurationOnPolicyTakesPrecedence(boolean packetReportingConfigurationOnPolicyTakesPrecedence) {
        this.packetReportingConfigurationOnPolicyTakesPrecedence = packetReportingConfigurationOnPolicyTakesPrecedence;
    }

    public boolean getPacketTrace() {
        return packetTrace;
    }

    public void setPacketTrace(boolean packetTrace) {
        packetTrace = packetTrace;
    }

    public boolean getPacketTraceConfigurationOnPolicyTakesPrecedence() {
        return packetTraceConfigurationOnPolicyTakesPrecedence;
    }

    public void setPacketTraceConfigurationOnPolicyTakesPrecedence(boolean packetTraceConfigurationOnPolicyTakesPrecedence) {
        this.packetTraceConfigurationOnPolicyTakesPrecedence = packetTraceConfigurationOnPolicyTakesPrecedence;
    }

    public boolean getEnabledNetworkProtectionPolicy() {
        return enabledNetworkProtectionPolicy;
    }

    public void setEnabledNetworkProtectionPolicy(boolean enabledNetworkProtectionPolicy) {
        this.enabledNetworkProtectionPolicy = enabledNetworkProtectionPolicy;
    }

    public PolicyNetworkInput getSrcNetworkInput() {
        return srcNetworkInput;
    }

    public void setSrcNetworkInput(PolicyNetworkInput srcNetworkInput) {
        this.srcNetworkInput = srcNetworkInput;
    }

    public String getSrcNetwork() {
        return srcNetwork;
    }

    public void setSrcNetwork(String srcNetwork) {
        this.srcNetwork = srcNetwork;
    }

    public PolicyNetworkInput getDstNetworkInput() {
        return dstNetworkInput;
    }

    public void setDstNetworkInput(PolicyNetworkInput dstNetworkInput) {
        this.dstNetworkInput = dstNetworkInput;
    }

    public String getDstNetwork() {
        return dstNetwork;
    }

    public void setDstNetwork(String dstNetwork) {
        this.dstNetwork = dstNetwork;
    }

    public PolicyPortGroup getPortGroup() {
        return portGroup;
    }

    public void setPortGroup(PolicyPortGroup portGroup) {
        this.portGroup = portGroup;
    }

    public PolicyDirection getDirection() {
        return direction;
    }

    public void setDirection(PolicyDirection direction) {
        this.direction = direction;
    }

    public String getVlanTagGroup() {
        return vlanTagGroup;
    }

    public void setVlanTagGroup(String vlanTagGroup) {
        this.vlanTagGroup = vlanTagGroup;
    }

    public String getMplsRdGroup() {
        return mplsRdGroup;
    }

    public void setMplsRdGroup(String mplsRdGroup) {
        this.mplsRdGroup = mplsRdGroup;
    }

    public String getBdosProfile() {
        return bdosProfile;
    }

    public void setBdosProfile(String bdosProfile) {
        this.bdosProfile = bdosProfile;
    }

    public String getAntiScanningProfile() {
        return antiScanningProfile;
    }

    public void setAntiScanningProfile(String antiScanningProfile) {
        this.antiScanningProfile = antiScanningProfile;
    }

    public String getDnsProfile() {
        return dnsProfile;
    }

    public void setDnsProfile(String dnsProfile) {
        this.dnsProfile = dnsProfile;
    }

    public String getSignatureProtection() {
        return signatureProtection;
    }

    public void setSignatureProtection(String signatureProtection) {
        this.signatureProtection = signatureProtection;
    }

    public String getSynFloodProfile() {
        return synFloodProfile;
    }

    public void setSynFloodProfile(String synFloodProfile) {
        this.synFloodProfile = synFloodProfile;
    }

    public String getConnectionPpsLimitProfile() {
        return connectionPpsLimitProfile;
    }

    public void setConnectionPpsLimitProfile(String connectionPpsLimitProfile) {
        this.connectionPpsLimitProfile = connectionPpsLimitProfile;
    }

    public String getOutOfStateProfile() {
        return outOfStateProfile;
    }

    public void setOutOfStateProfile(String outOfStateProfile) {
        this.outOfStateProfile = outOfStateProfile;
    }

    public PolicyWebQuarantine getWebQuarantine() {
        return webQuarantine;
    }

    public void setWebQuarantine(PolicyWebQuarantine webQuarantine) {
        this.webQuarantine = webQuarantine;
    }

    public PolicyAction getAction() {
        return action;
    }

    public void setAction(PolicyAction action) {
        this.action = action;
    }

    public String getConnectionLimitProfile() {
        return connectionLimitProfile;
    }

    public void setConnectionLimitProfile(String connectionLimitProfile) {
        this.connectionLimitProfile = connectionLimitProfile;
    }

    public String getDeviceIp() {
        return deviceIp;
    }

    public void setDeviceIp(String deviceIp) {
        this.deviceIp = deviceIp;
    }

    public String getPolicyName() {
        return policyName;
    }

    public void setPolicyName(String policyName) {
        this.policyName = policyName;
    }

    public String getPoliciesList() {
        return policiesList;
    }

    @ParameterProperties(description = "Please provide Policy names to delete, separated by <,>. Leave Empty to delete ALL")
    public void setPoliciesList(String policiesList) {
        this.policiesList = policiesList;
    }

    public String getPolicyDownloadDestinationPath() {
        return policyDownloadDestinationPath;
    }

    @ParameterProperties(description = "Leave Empty in case headless mode is used!")
    public void setPolicyDownloadDestinationPath(String policyDownloadDestinationPath) {
        this.policyDownloadDestinationPath = policyDownloadDestinationPath;
    }

    public DpConfigurationTemplatesColumns getSearchColumnName() {
        return searchColumnName;
    }

    public void setSearchColumnName(DpConfigurationTemplatesColumns searchColumnName) {
        this.searchColumnName = searchColumnName;
    }

    public String getValueToSearch() {
        return valueToSearch;
    }

    public void setValueToSearch(String valueToSearch) {
        this.valueToSearch = valueToSearch;
    }

    public String getFileNamesList() {
        return fileNamesList;
    }

    @ParameterProperties(description = "Please provide file names to delete, separated by <,>.")
    public void setFileNamesList(String fileNamesList) {
        this.fileNamesList = fileNamesList;
    }

    public DeviceState getDeviceState() {
        return deviceState;
    }

    public void setDeviceState(DeviceState deviceState) {
        this.deviceState = deviceState;
    }

    public TopologyTreeTabs getParentTree() {
        return parentTree;
    }

    public void setParentTree(TopologyTreeTabs parentTree) {
        this.parentTree = parentTree;
    }

    public String getSaveToFileName() {
        return saveToFileName;
    }

    public void setSaveToFileName(String saveToFileName) {
        this.saveToFileName = saveToFileName;
    }

    public ExportPolicyDownloadTo getExportDownloadTo() {
        return exportDownloadTo;
    }

    public void setExportDownloadTo(ExportPolicyDownloadTo exportDownloadTo) {
        this.exportDownloadTo = exportDownloadTo;
    }

    public String getExportPolicyConfigurations() {
        return exportPolicyConfigurations;
    }

    public void setExportPolicyConfigurations(String exportPolicyConfigurations) {
        this.exportPolicyConfigurations = exportPolicyConfigurations;
    }

    public String getFileName() {
        return fileName;
    }

    @ParameterProperties(description = "Please provide the <fileName> (including its full path)")
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }


    public DpTemplateFileType getFileType() {
        return fileType;
    }
    public void setFileType(DpTemplateFileType fileType) {
        this.fileType = fileType;
    }

    public String getDeviceDestinations() {
        return deviceDestinations;
    }
    public void setDeviceDestinations(String deviceDestinations) {
        this.deviceDestinations = deviceDestinations;
    }

    public String getGroupDestinations() {
        return groupDestinations;
    }
    public void setGroupDestinations(String groupDestinations) {
        this.groupDestinations = groupDestinations;
    }

    public String getColumnName() {
        return columnName;
    }
    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public boolean isUpdatePolicies() {
        return updatePolicies;
    }
    public void setUpdatePolicies(boolean updatePolicies) {
        this.updatePolicies = updatePolicies;
    }

    public UpdateMethod getMethod() {
        return method;
    }
    public void setMethod(UpdateMethod method) {
        this.method = method;
    }

    public Instance getInstance() {
        return instance;
    }
    public void setInstance(Instance instance) {
        this.instance = instance;
    }

    public String getExportPolicyName() {
        return exportPolicyName;
    }
    public void setExportPolicyName(String exportPolicyName) {
        this.exportPolicyName = exportPolicyName;
    }

    public String getHttpFloodProfile() {
        return httpFloodProfile;
    }
    public void setHttpFloodProfile(String httpFloodProfile) {
        this.httpFloodProfile = httpFloodProfile;
    }

    public String getServerCrackingProfile() {
        return serverCrackingProfile;
    }
    public void setServerCrackingProfile(String serverCrackingProfile) {
        this.serverCrackingProfile = serverCrackingProfile;
    }

    public String getIpRange() {
        return ipRange;
    }
    @ParameterProperties(description = "ipRange must be provided to create the ServerPolicy")
    public void setIpRange(String ipRange) {
        this.ipRange = ipRange;
    }

    public PolicyNetworkInput getIpRangeInput() {
        return ipRangeInput;
    }
    public void setIpRangeInput(PolicyNetworkInput ipRangeInput) {
        this.ipRangeInput = ipRangeInput;
    }

    public boolean isEnabledServerProtectionPolicy() {
        return enabledServerProtectionPolicy;
    }
    public void setEnabledServerProtectionPolicy(boolean enabledServerProtectionPolicy) {
        this.enabledServerProtectionPolicy = enabledServerProtectionPolicy;
    }

    public String getPolicy() {
        return policy;
    }
    public void setPolicy(String policy) {
        this.policy = policy;
    }

    public boolean isPartial() { return partial; }
    public void setPartial(boolean partial) { this.partial = partial; }
}
